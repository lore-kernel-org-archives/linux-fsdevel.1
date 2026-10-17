Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEE92EA15C;
	Sat, 17 Oct 2026 02:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.30.2.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792202805; cv=none; b=vDM4LxJagY3ckzFnB9SaMR7bRbeby5zH8BC8OASdudPnA3XeWG6f66QBTKbkiyRiMR4KUzxXKpLbDWJJuD36BX4MjjWzdaQPADTcRMk4KfL+mR2bkDO58OxQU67RGEfzR6Ak4thlzjjS/vp55u6+8zl1kloPqxh0mpA6onLaJJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792202805; c=relaxed/simple;
	bh=Cu+OSIQH8dP/eLmsqcJbGmKyOWUvKeB7xnH9dIGk8Og=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CEyLpt3+pBHcT0ah5cpEiqUyVsl9SgExh9Oveh4VJCSeEDyzgeow1qqj98xIk8wGKeAH6VhM3/erhPXm8sKfktoMnIfZ5tXV+9ikVAJh5gfU+txN7u1lefQI5ZR+JWZNoFHEt3URfb6/xehz8NCvOfx3X92JBysDKMVz1UHwi5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu; spf=pass smtp.mailfrom=csail.mit.edu; arc=none smtp.client-ip=128.30.2.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
Received: from escalante.csail.mit.edu ([128.52.128.198])
	by outgoing2021.csail.mit.edu with esmtp (Exim 4.95)
	(envelope-from <nickolai@csail.mit.edu>)
	id 1xHtog-00HOWO-Ar;
	Fri, 16 Oct 2026 22:06:34 -0400
From: Nickolai Zeldovich <nickolai@csail.mit.edu>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Shuah Khan <shuah@kernel.org>,
	Jann Horn <jannh@google.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Luca Boccassi <luca.boccassi@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nickolai Zeldovich <nickolai@csail.mit.edu>
Subject: [PATCH v1] pidfs: do not report fields that do not fit into the caller's struct
Date: Fri, 16 Oct 2026 22:06:33 -0400
Message-ID: <20261017020634.792390-1-nickolai@csail.mit.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation of struct pidfd_info promises that "If the structure
size is too small to contain a field (requested or not), to avoid
confusion the mask will not contain a bit for that field", and asks
userspace to trust the returned mask when deciding which fields hold
valid data.

pidfd_info() does not keep that promise. It builds kinfo.mask without
looking at the size encoded in the ioctl command, and
copy_struct_to_user() then truncates the copy to that size. A caller
that passes a 64-byte struct (PIDFD_INFO_SIZE_VER0) and requests
PIDFD_INFO_COREDUMP or PIDFD_INFO_SUPPORTED_MASK gets a mask with
PIDFD_INFO_COREDUMP, PIDFD_INFO_COREDUMP_SIGNAL, PIDFD_INFO_COREDUMP_CODE
and PIDFD_INFO_SUPPORTED_MASK set, while the coredump_* and
supported_mask fields behind the 64 bytes were never written. Trusting
the mask as documented, userspace then reads whatever its own buffer
held at those offsets. The same happens for a 72- or 80-byte struct
and the fields added after it.

Clear the bits of the fields that lie beyond the caller's size before
the copy, in the one place that knows both the final mask and the size.
A request for a field that cannot be returned is thereby answered the
way the header describes: the field is simply absent from the mask.

The added selftest issues PIDFD_GET_INFO with the first published size
over a full-size, poisoned struct and checks that the mask names none
of the fields beyond that size and that the poison is intact. It fails
on an unpatched kernel and passes with this change.

Found by formal verification of fs/pidfs.c against the kernel binary.

Fixes: 1d8db6fd698d ("pidfs, coredump: add PIDFD_INFO_COREDUMP")
Assisted-by: LLM
Signed-off-by: Nickolai Zeldovich <nickolai@csail.mit.edu>
---

Notes:
    The three size thresholds follow the field layout: coredump_mask and
    coredump_signal end at PIDFD_INFO_SIZE_VER1 (72), coredump_code at
    PIDFD_INFO_SIZE_VER2 (80), supported_mask at PIDFD_INFO_SIZE_VER3 (88).
    Masking the request bits early instead (before the coredump and
    supported_mask blocks run) would save a little work for such callers
    but leaves the bits set in the task->mm fallback path; clearing the
    result once before copy_struct_to_user() covers every way a bit can be
    set. No stable tag: the only callers affected pass a struct size
    smaller than the fields they request, and the consequence is a wrong
    mask bit, not a crash or corruption.

 fs/pidfs.c                                    |  8 ++++
 tools/testing/selftests/pidfd/pidfd.h         | 16 +++++++
 .../testing/selftests/pidfd/pidfd_info_test.c | 48 +++++++++++++++++++
 3 files changed, 72 insertions(+)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index a6a643f15d08..b20f507c6bdf 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -485,6 +485,14 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 		kinfo.supported_mask = PIDFD_INFO_SUPPORTED;
 	}
 
+	/* Only report fields that fit into the caller's struct. */
+	if (usize < PIDFD_INFO_SIZE_VER1)
+		kinfo.mask &= ~(PIDFD_INFO_COREDUMP | PIDFD_INFO_COREDUMP_SIGNAL);
+	if (usize < PIDFD_INFO_SIZE_VER2)
+		kinfo.mask &= ~PIDFD_INFO_COREDUMP_CODE;
+	if (usize < PIDFD_INFO_SIZE_VER3)
+		kinfo.mask &= ~PIDFD_INFO_SUPPORTED_MASK;
+
 	/* Are there bits in the return mask not present in PIDFD_INFO_SUPPORTED? */
 	WARN_ON_ONCE(~PIDFD_INFO_SUPPORTED & kinfo.mask);
 	/*
diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index 5a4e78c10f43..cf146d327334 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -160,6 +160,22 @@
 #define PIDFD_INFO_COREDUMP_CODE	(1UL << 7)
 #endif
 
+#ifndef PIDFD_INFO_SIZE_VER0
+#define PIDFD_INFO_SIZE_VER0		64 /* sizeof first published struct */
+#endif
+
+#ifndef PIDFD_INFO_SIZE_VER1
+#define PIDFD_INFO_SIZE_VER1		72 /* sizeof second published struct */
+#endif
+
+#ifndef PIDFD_INFO_SIZE_VER2
+#define PIDFD_INFO_SIZE_VER2		80 /* sizeof third published struct */
+#endif
+
+#ifndef PIDFD_INFO_SIZE_VER3
+#define PIDFD_INFO_SIZE_VER3		88 /* sizeof fourth published struct */
+#endif
+
 #ifndef PIDFD_COREDUMPED
 #define PIDFD_COREDUMPED	(1U << 0) /* Did crash and... */
 #endif
diff --git a/tools/testing/selftests/pidfd/pidfd_info_test.c b/tools/testing/selftests/pidfd/pidfd_info_test.c
index 597012ed195f..ee08df3dc3d2 100644
--- a/tools/testing/selftests/pidfd/pidfd_info_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_info_test.c
@@ -764,4 +764,52 @@ TEST(supported_mask_with_other_fields)
 	close(pidfd);
 }
 
+/*
+ * Test: fields beyond the caller's struct size are not reported
+ *
+ * Request the coredump and supported_mask fields with a struct of the
+ * first published size. None of those fields fit, so the returned mask
+ * must not name them and the memory behind the struct must be untouched.
+ */
+TEST(info_size_ver0_mask)
+{
+	struct pidfd_info info = {
+		.mask = PIDFD_INFO_COREDUMP | PIDFD_INFO_SUPPORTED_MASK,
+		.coredump_mask = 0xdeadbeef,
+		.coredump_signal = 0xdeadbeef,
+		.coredump_code = 0xdeadbeef,
+		.supported_mask = 0xdeadbeefdeadbeefULL,
+	};
+	unsigned int cmd = _IOC(_IOC_READ | _IOC_WRITE, PIDFS_IOCTL_MAGIC, 11,
+				PIDFD_INFO_SIZE_VER0);
+	int pidfd;
+	pid_t pid;
+
+	pid = create_child(&pidfd, 0);
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0)
+		pause();
+
+	ASSERT_EQ(ioctl(pidfd, cmd, &info), 0);
+
+	/* The fields that fit are reported as usual. */
+	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_PID));
+	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_CREDS));
+
+	/* The fields that do not fit are neither reported nor written. */
+	ASSERT_FALSE(!!(info.mask & (PIDFD_INFO_COREDUMP |
+				     PIDFD_INFO_COREDUMP_SIGNAL |
+				     PIDFD_INFO_COREDUMP_CODE |
+				     PIDFD_INFO_SUPPORTED_MASK)));
+	ASSERT_EQ(info.coredump_mask, 0xdeadbeef);
+	ASSERT_EQ(info.coredump_signal, 0xdeadbeef);
+	ASSERT_EQ(info.coredump_code, 0xdeadbeef);
+	ASSERT_EQ(info.supported_mask, 0xdeadbeefdeadbeefULL);
+
+	sys_pidfd_send_signal(pidfd, SIGKILL, NULL, 0);
+	sys_waitid(P_PIDFD, pidfd, NULL, WEXITED);
+	close(pidfd);
+}
+
 TEST_HARNESS_MAIN

base-commit: 70dd4ee72eb2d5793c62e71c14e3aba78e5a4e56
-- 
2.53.0

