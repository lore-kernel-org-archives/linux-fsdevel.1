Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=128.30.2.78
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792815225;
	b=hwXu/5KmA0cp1PqLU41rdszW7bPZiR6C/mKf6k+27uNb1Vt11mej67jlICsZIYy7VQSH
	 oLHiVVGfCEZ5OTiWVWWHaTFHtz3uCjEpQHBKvMKTMUPi4Ft/ktBcS28l4b8Tgo7LcObpC
	 FLghqxh1eI7/XPtAhCIEKemlIKhYYU1I+CPgQZ2bisNFBAMPqUZIgYRgOYe2iXTqo21gY
	 b5eXCG0GBIVmUOXTYhRY1IsDYYaXCym8Op1XmhBX6OPd5hzeFvZOCJpAES870I7NPxF1V
	 Q7XdjG9hiL/RicMGCeEtHTFZD457N/i4M3viMegCjHfi6ZY797wQDZvPqcO496/kzNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792815225;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=VTbLNMP+UpXniIrujxXe7sYDHvjBTEb8cMy7ABMULcc=;
	b=mRPOG9ZLzWypheFaSZDAaxC+G9ICu1ZXbWrcSrzTuq24t2hdaxkcMT/k+hMi/24deHo5
	 bAkrcv4SmLf3ygeBQYHLPd8jmVH+BdaIhVgqLNHv/+HKTfnHrxMKTKszWVGIOPArhrzS3
	 eX0KgID3c2EKfiQYGQDpZoxvtybcWVCFHkFZts0irwi6TBXuEg5acWhJ/S635Drk5r+rJ
	 kKz7nmWuNeIK/1ijCTf/nItpUmCucpdNGXaM/bUuIrUkzZcJzq9L8f7Ldx8IxpR3lmqam
	 CtAVj2EXWyDIAzSJOg0giZxK5563paxLlQmwTl71HsiQqP/6Jyj3Icv/f9u2O1fERaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=csail.mit.edu;
	spf=pass smtp.mailfrom=csail.mit.edu;
	arc=none smtp.remote-ip=128.30.2.78
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BE2606A31A;
	Sat, 24 Oct 2026 04:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38BE2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
Received: from escalante.csail.mit.edu ([128.52.128.198])
	by outgoing2021.csail.mit.edu with esmtp (Exim 4.95)
	(envelope-from <nickolai@csail.mit.edu>)
	id 1xKT8Q-00EPeW-TB;
	Sat, 24 Oct 2026 00:13:34 -0400
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
Subject: [PATCH v2 2/2] selftests/pidfd: test that fields beyond the struct size are not reported
Date: Sat, 24 Oct 2026 00:13:34 -0400
Message-ID: <20261024041334.831273-3-nickolai@csail.mit.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261024041334.831273-1-nickolai@csail.mit.edu>
References: <20261017020634.792390-1-nickolai@csail.mit.edu>
 <20261024041334.831273-1-nickolai@csail.mit.edu>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PIDFD_GET_INFO must not set the mask bit of a field that lies beyond
the struct size encoded in the ioctl command. Add a test that requests
the coredump fields and the supported mask with PIDFD_INFO_SIZE_VER0
over a full-size, poisoned struct, and checks that the mask names none
of those fields and that the poison behind the first 64 bytes is
intact.

Add fallback definitions of PIDFD_INFO_SIZE_VER0 to VER3 to pidfd.h,
like the other uapi constants there.

Signed-off-by: Nickolai Zeldovich <nickolai@csail.mit.edu>
---

Notes:
    Result in a QEMU x86_64 guest on mainline 17bb0e2f6c80, without
    patch 1:
    
      # pidfd_info_test.c:801:info_size_ver0_mask:Expected 0 (0) == !!(info.mask & (PIDFD_INFO_COREDUMP | ...)) (1)
      not ok 3 global.info_size_ver0_mask
    
    With patch 1:
    
      ok 3 global.info_size_ver0_mask

 tools/testing/selftests/pidfd/pidfd.h         | 16 +++++++
 .../testing/selftests/pidfd/pidfd_info_test.c | 48 +++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index 5a4e78c10f434..cf146d3273348 100644
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
index 597012ed195f0..ee08df3dc3d2b 100644
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
-- 
2.53.0

