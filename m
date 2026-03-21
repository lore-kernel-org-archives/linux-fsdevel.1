Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E458D36EA99;
	Sat, 21 Mar 2026 15:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774107785; cv=none; b=SPSPN4KNqQFhF/Wy3RAAC5G3shu2awhC8B7qiIcs2Bo1RAx+aaDeAHVqTA7AjruB3C1s2fXXQ2TzHLk5HbT4ptbwR/Wp0UAHZv0dO66UrKTTqb4805wrN5fchFxI3vqJZDwqHj+XcXmchvYcjFoWS428JMoiHsb2lDIoocyL30s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774107785; c=relaxed/simple;
	bh=sRFNVSRQuNPL8WqeUMdmR58THrYUs4vrRZsU5nOvxwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=astq8Ps8Vvc8QfqzqDNT7wzkBzZXtMFv0t92sz8L1sUHFxVKP+z1s3NFdQIpRYVv53gHfHRjSFXEP8r6nUXMXKi8cStEwiR6i4pb5maS+2BG/pf2fRdL06HyIOTfeVp79zGGZK8ubk/H+WWejQijghkhNgigtglzEcj/8/SoYcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC6AF1596;
	Sat, 21 Mar 2026 08:42:55 -0700 (PDT)
Received: from NH27D9T0LF (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21E3A3F763;
	Sat, 21 Mar 2026 08:42:59 -0700 (PDT)
Date: Sat, 21 Mar 2026 16:42:53 +0100
From: Emanuele Rocca <emanuele.rocca@arm.com>
To: kernel test robot <lkp@intel.com>
Cc: linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v2] pidfds: add coredump_code field to pidfd_info
Message-ID: <ab68fUmCK4An1UH-@NH27D9T0LF>
References: <ab29J6KsQm8Xg3LR@NH27D9T0LF>
 <202603211842.JCwUVYTI-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202603211842.JCwUVYTI-lkp@intel.com>

The struct pidfd_info currently exposes in a field called coredump_signal the
signal number (si_signo) that triggered the dump (for example, 11 for SIGSEGV).
However, it is also valuable to understand the reason why that signal was sent.
This additional context is provided by the signal code (si_code), such as 2 for
SEGV_ACCERR.

Add a new field to struct pidfd_info called coredump_code with the value of
si_code for the benefit of sysadmins who pipe core dumps to user-space programs
for later analysis. The following snippet illustrates a simplified C program
that consumes coredump_signal and coredump_code, and then logs core dump
signals and codes to a file:

    int pidfd = (int)atoi(argv[1]);

    struct pidfd_info info = {
        .mask = PIDFD_INFO_EXIT | PIDFD_INFO_COREDUMP,
    };

    if (ioctl(pidfd, PIDFD_GET_INFO, &info) == 0)
        if (info.mask & PIDFD_INFO_COREDUMP)
            fprintf(f, "PID=%d, si_signo: %d si_code: %d\n",
                info.pid, info.coredump_signal, info.coredump_code);

Assuming the program is installed under /usr/local/bin/core-logger, core dump
processing can be enabled by setting /proc/sys/kernel/core_pattern to
'|/usr/local/bin/dumpstuff %F'.

systemd-coredump(8) already uses pidfds to process core dumps, and it could be
extended to include the values of coredump_code too.

Signed-off-by: Emanuele Rocca <emanuele.rocca@arm.com>
Link: https://lore.kernel.org/lkml/ablsdmLsMKm0z5wt@NH27D9T0LF
---

V1 -> V2: Add coredump_pad to struct pidfd_info to ensure the struct has the
same size on both 64 bit and 32 bit systems.
Link: https://lore.kernel.org/lkml/202603211842.JCwUVYTI-lkp@intel.com/

 fs/pidfs.c                                    | 12 ++++---
 include/uapi/linux/pidfd.h                    |  4 +++
 .../coredump/coredump_socket_protocol_test.c  | 26 +++++++++++++++
 .../selftests/coredump/coredump_socket_test.c | 32 +++++++++++++++++++
 .../coredump/coredump_test_helpers.c          |  4 +--
 tools/testing/selftests/pidfd/pidfd.h         |  5 +++
 .../testing/selftests/pidfd/pidfd_info_test.c |  1 +
 7 files changed, 78 insertions(+), 6 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index e3825ee246be..49b46be6c413 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -55,6 +55,7 @@ struct pidfs_attr {
 	};
 	__u32 coredump_mask;
 	__u32 coredump_signal;
+	__u32 coredump_code;
 };
 
 static struct rhashtable pidfs_ino_ht;
@@ -331,7 +332,8 @@ static __u32 pidfs_coredump_mask(unsigned long mm_flags)
 			      PIDFD_INFO_EXIT | \
 			      PIDFD_INFO_COREDUMP | \
 			      PIDFD_INFO_SUPPORTED_MASK | \
-			      PIDFD_INFO_COREDUMP_SIGNAL)
+			      PIDFD_INFO_COREDUMP_SIGNAL | \
+			      PIDFD_INFO_COREDUMP_CODE)
 
 static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 {
@@ -345,7 +347,7 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 	const struct cred *c;
 	__u64 mask;
 
-	BUILD_BUG_ON(sizeof(struct pidfd_info) != PIDFD_INFO_SIZE_VER2);
+	BUILD_BUG_ON(sizeof(struct pidfd_info) != PIDFD_INFO_SIZE_VER3);
 
 	if (!uinfo)
 		return -EINVAL;
@@ -378,9 +380,10 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 	if (mask & PIDFD_INFO_COREDUMP) {
 		if (test_bit(PIDFS_ATTR_BIT_COREDUMP, &attr->attr_mask)) {
 			smp_rmb();
-			kinfo.mask |= PIDFD_INFO_COREDUMP | PIDFD_INFO_COREDUMP_SIGNAL;
+			kinfo.mask |= PIDFD_INFO_COREDUMP | PIDFD_INFO_COREDUMP_SIGNAL | PIDFD_INFO_COREDUMP_CODE;
 			kinfo.coredump_mask = attr->coredump_mask;
 			kinfo.coredump_signal = attr->coredump_signal;
+			kinfo.coredump_code = attr->coredump_code;
 		}
 	}
 
@@ -730,8 +733,9 @@ void pidfs_coredump(const struct coredump_params *cprm)
 			      PIDFD_COREDUMPED;
 	/* If coredumping is set to skip we should never end up here. */
 	VFS_WARN_ON_ONCE(attr->coredump_mask & PIDFD_COREDUMP_SKIP);
-	/* Expose the signal number that caused the coredump. */
+	/* Expose the signal number and code that caused the coredump. */
 	attr->coredump_signal = cprm->siginfo->si_signo;
+	attr->coredump_code = cprm->siginfo->si_code;
 	smp_wmb();
 	set_bit(PIDFS_ATTR_BIT_COREDUMP, &attr->attr_mask);
 }
diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
index ea9a6811fc76..db3e95635c4d 100644
--- a/include/uapi/linux/pidfd.h
+++ b/include/uapi/linux/pidfd.h
@@ -28,10 +28,12 @@
 #define PIDFD_INFO_COREDUMP		(1UL << 4) /* Only returned if requested. */
 #define PIDFD_INFO_SUPPORTED_MASK	(1UL << 5) /* Want/got supported mask flags */
 #define PIDFD_INFO_COREDUMP_SIGNAL	(1UL << 6) /* Always returned if PIDFD_INFO_COREDUMP is requested. */
+#define PIDFD_INFO_COREDUMP_CODE	(1UL << 7) /* Always returned if PIDFD_INFO_COREDUMP is requested. */
 
 #define PIDFD_INFO_SIZE_VER0		64 /* sizeof first published struct */
 #define PIDFD_INFO_SIZE_VER1		72 /* sizeof second published struct */
 #define PIDFD_INFO_SIZE_VER2		80 /* sizeof third published struct */
+#define PIDFD_INFO_SIZE_VER3		88 /* sizeof fourth published struct */
 
 /*
  * Values for @coredump_mask in pidfd_info.
@@ -98,6 +100,8 @@ struct pidfd_info {
 	struct /* coredump info */ {
 		__u32 coredump_mask;
 		__u32 coredump_signal;
+		__u32 coredump_code;
+		__u32 coredump_pad; /* align supported_mask to 8 bytes */
 	};
 	__u64 supported_mask;	/* Mask flags that this kernel supports */
 };
diff --git a/tools/testing/selftests/coredump/coredump_socket_protocol_test.c b/tools/testing/selftests/coredump/coredump_socket_protocol_test.c
index d19b6717c53e..d9fa6239b5a9 100644
--- a/tools/testing/selftests/coredump/coredump_socket_protocol_test.c
+++ b/tools/testing/selftests/coredump/coredump_socket_protocol_test.c
@@ -1004,6 +1004,8 @@ TEST_F(coredump, socket_request_invalid_size_large)
  *
  * Verify that when using socket-based coredump protocol,
  * the coredump_signal field is correctly exposed as SIGSEGV.
+ * Also check that the coredump_code field is correctly exposed
+ * as SEGV_MAPERR.
  */
 TEST_F(coredump, socket_coredump_signal_sigsegv)
 {
@@ -1079,6 +1081,18 @@ TEST_F(coredump, socket_coredump_signal_sigsegv)
 			goto out;
 		}
 
+		/* Verify coredump_code is available and correct */
+		if (!(info.mask & PIDFD_INFO_COREDUMP_CODE)) {
+			fprintf(stderr, "socket_coredump_signal_sigsegv: PIDFD_INFO_COREDUMP_CODE not set in mask\n");
+			goto out;
+		}
+
+		if (info.coredump_code != SEGV_MAPERR) {
+			fprintf(stderr, "socket_coredump_signal_sigsegv: coredump_code=%d, expected SEGV_MAPERR=%d\n",
+				info.coredump_code, SEGV_MAPERR);
+			goto out;
+		}
+
 		if (!read_coredump_req(fd_coredump, &req)) {
 			fprintf(stderr, "socket_coredump_signal_sigsegv: read_coredump_req failed\n");
 			goto out;
@@ -1128,6 +1142,8 @@ TEST_F(coredump, socket_coredump_signal_sigsegv)
 	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_COREDUMP));
 	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_COREDUMP_SIGNAL));
 	ASSERT_EQ(info.coredump_signal, SIGSEGV);
+	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_COREDUMP_CODE));
+	ASSERT_EQ(info.coredump_code, SEGV_MAPERR);
 
 	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
 }
@@ -1137,6 +1153,8 @@ TEST_F(coredump, socket_coredump_signal_sigsegv)
  *
  * Verify that when using socket-based coredump protocol,
  * the coredump_signal field is correctly exposed as SIGABRT.
+ * Also check that the coredump_code field is correctly exposed
+ * as SI_TKILL.
  */
 TEST_F(coredump, socket_coredump_signal_sigabrt)
 {
@@ -1212,6 +1230,12 @@ TEST_F(coredump, socket_coredump_signal_sigabrt)
 			goto out;
 		}
 
+		if (info.coredump_code != SI_TKILL) {
+			fprintf(stderr, "socket_coredump_signal_sigabrt: coredump_code=%d, expected SI_TKILL=%d\n",
+				info.coredump_code, SI_TKILL);
+			goto out;
+		}
+
 		if (!read_coredump_req(fd_coredump, &req)) {
 			fprintf(stderr, "socket_coredump_signal_sigabrt: read_coredump_req failed\n");
 			goto out;
@@ -1261,6 +1285,8 @@ TEST_F(coredump, socket_coredump_signal_sigabrt)
 	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_COREDUMP));
 	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_COREDUMP_SIGNAL));
 	ASSERT_EQ(info.coredump_signal, SIGABRT);
+	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_COREDUMP_CODE));
+	ASSERT_EQ(info.coredump_code, SI_TKILL);
 
 	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
 }
diff --git a/tools/testing/selftests/coredump/coredump_socket_test.c b/tools/testing/selftests/coredump/coredump_socket_test.c
index 7e26d4a6a15d..422728f632ca 100644
--- a/tools/testing/selftests/coredump/coredump_socket_test.c
+++ b/tools/testing/selftests/coredump/coredump_socket_test.c
@@ -435,6 +435,8 @@ TEST_F(coredump, socket_no_listener)
  *
  * Verify that when using simple socket-based coredump (@ pattern),
  * the coredump_signal field is correctly exposed as SIGSEGV.
+ * Also check that the coredump_code field is correctly exposed
+ * as SEGV_MAPERR.
  */
 TEST_F(coredump, socket_coredump_signal_sigsegv)
 {
@@ -509,6 +511,18 @@ TEST_F(coredump, socket_coredump_signal_sigsegv)
 			goto out;
 		}
 
+		/* Verify coredump_code is available and correct */
+		if (!(info.mask & PIDFD_INFO_COREDUMP_CODE)) {
+			fprintf(stderr, "socket_coredump_signal_sigsegv: PIDFD_INFO_COREDUMP_CODE not set in mask\n");
+			goto out;
+		}
+
+		if (info.coredump_code != SEGV_MAPERR) {
+			fprintf(stderr, "socket_coredump_signal_sigsegv: coredump_code=%d, expected SEGV_MAPERR=%d\n",
+				info.coredump_code, SEGV_MAPERR);
+			goto out;
+		}
+
 		fd_core_file = open_coredump_tmpfile(self->fd_tmpfs_detached);
 		if (fd_core_file < 0) {
 			fprintf(stderr, "socket_coredump_signal_sigsegv: open_coredump_tmpfile failed: %m\n");
@@ -572,6 +586,8 @@ TEST_F(coredump, socket_coredump_signal_sigsegv)
 	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_COREDUMP));
 	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_COREDUMP_SIGNAL));
 	ASSERT_EQ(info.coredump_signal, SIGSEGV);
+	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_COREDUMP_CODE));
+	ASSERT_EQ(info.coredump_code, SEGV_MAPERR);
 
 	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
 }
@@ -581,6 +597,8 @@ TEST_F(coredump, socket_coredump_signal_sigsegv)
  *
  * Verify that when using simple socket-based coredump (@ pattern),
  * the coredump_signal field is correctly exposed as SIGABRT.
+ * Also check that the coredump_code field is correctly exposed
+ * as SI_TKILL.
  */
 TEST_F(coredump, socket_coredump_signal_sigabrt)
 {
@@ -655,6 +673,18 @@ TEST_F(coredump, socket_coredump_signal_sigabrt)
 			goto out;
 		}
 
+		/* Verify coredump_code is available and correct */
+		if (!(info.mask & PIDFD_INFO_COREDUMP_CODE)) {
+			fprintf(stderr, "socket_coredump_signal_sigabrt: PIDFD_INFO_COREDUMP_CODE not set in mask\n");
+			goto out;
+		}
+
+		if (info.coredump_code != SI_TKILL) {
+			fprintf(stderr, "socket_coredump_signal_sigabrt: coredump_code=%d, expected SI_TKILL=%d\n",
+				info.coredump_code, SI_TKILL);
+			goto out;
+		}
+
 		fd_core_file = open_coredump_tmpfile(self->fd_tmpfs_detached);
 		if (fd_core_file < 0) {
 			fprintf(stderr, "socket_coredump_signal_sigabrt: open_coredump_tmpfile failed: %m\n");
@@ -718,6 +748,8 @@ TEST_F(coredump, socket_coredump_signal_sigabrt)
 	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_COREDUMP));
 	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_COREDUMP_SIGNAL));
 	ASSERT_EQ(info.coredump_signal, SIGABRT);
+	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_COREDUMP_CODE));
+	ASSERT_EQ(info.coredump_code, SI_TKILL);
 
 	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
 }
diff --git a/tools/testing/selftests/coredump/coredump_test_helpers.c b/tools/testing/selftests/coredump/coredump_test_helpers.c
index 2c850e0b1b57..2a20faf9cb0a 100644
--- a/tools/testing/selftests/coredump/coredump_test_helpers.c
+++ b/tools/testing/selftests/coredump/coredump_test_helpers.c
@@ -148,8 +148,8 @@ bool get_pidfd_info(int fd_peer_pidfd, struct pidfd_info *info)
 		fprintf(stderr, "get_pidfd_info: ioctl(PIDFD_GET_INFO) failed: %m\n");
 		return false;
 	}
-	fprintf(stderr, "get_pidfd_info: mask=0x%llx, coredump_mask=0x%x, coredump_signal=%d\n",
-		(unsigned long long)info->mask, info->coredump_mask, info->coredump_signal);
+	fprintf(stderr, "get_pidfd_info: mask=0x%llx, coredump_mask=0x%x, coredump_signal=%d, coredump_code=%d\n",
+		(unsigned long long)info->mask, info->coredump_mask, info->coredump_signal, info->coredump_code);
 	return true;
 }
 
diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index 9085c1a3c005..5a4e78c10f43 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -156,6 +156,10 @@
 #define PIDFD_INFO_COREDUMP_SIGNAL	(1UL << 6)
 #endif
 
+#ifndef PIDFD_INFO_COREDUMP_CODE
+#define PIDFD_INFO_COREDUMP_CODE	(1UL << 7)
+#endif
+
 #ifndef PIDFD_COREDUMPED
 #define PIDFD_COREDUMPED	(1U << 0) /* Did crash and... */
 #endif
@@ -194,6 +198,7 @@ struct pidfd_info {
 	struct {
 		__u32 coredump_mask;
 		__u32 coredump_signal;
+		__u32 coredump_code;
 	};
 	__u64 supported_mask;
 };
diff --git a/tools/testing/selftests/pidfd/pidfd_info_test.c b/tools/testing/selftests/pidfd/pidfd_info_test.c
index 8bed951e06a0..597012ed195f 100644
--- a/tools/testing/selftests/pidfd/pidfd_info_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_info_test.c
@@ -724,6 +724,7 @@ TEST(supported_mask_field)
 	ASSERT_TRUE(!!(info.supported_mask & PIDFD_INFO_COREDUMP));
 	ASSERT_TRUE(!!(info.supported_mask & PIDFD_INFO_SUPPORTED_MASK));
 	ASSERT_TRUE(!!(info.supported_mask & PIDFD_INFO_COREDUMP_SIGNAL));
+	ASSERT_TRUE(!!(info.supported_mask & PIDFD_INFO_COREDUMP_CODE));
 
 	/* Clean up */
 	sys_pidfd_send_signal(pidfd, SIGKILL, NULL, 0);
-- 
2.47.3

