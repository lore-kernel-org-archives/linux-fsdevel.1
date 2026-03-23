Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505E11B4223;
	Mon, 23 Mar 2026 13:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774270947; cv=none; b=IA8HuMoaM7I8bVuSEb7/Idq69LZfdLXiBpYmAPUVyRFVhLjau9d8NT2KhDc3EyT0WlgyDsNFoP6my4UaPuNfAesJ+MVIS8WnzAyep+9tFxmRSZKJ/vh0rzneL+zR2yu/9JQ7Q2R5Rp/XN0llPiild5kDDz12/xX67swnq89fqug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774270947; c=relaxed/simple;
	bh=f9IlyphnTvQp0WGpAFG7P5T9ZXzLK+T9w4wh4Sy/Ukg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PKbNqtO6JA28+WaKHWGDg/6/1oFDfwt3vecZRd6373W/eAF7jV8fUL6V+aYojSAIPFUr69gNK8VAbS/2Chdmt+qiXieG1nwGzKVfHs6+CLR51qPlz+i6Ubtx6SuXQvJY8Hgqzukv+qymtm5CM6+G5BNLFhU/ZMVTbqG49ehf65U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89DA11516;
	Mon, 23 Mar 2026 06:02:18 -0700 (PDT)
Received: from NH27D9T0LF (unknown [10.57.13.32])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C9A83F73B;
	Mon, 23 Mar 2026 06:02:23 -0700 (PDT)
Date: Mon, 23 Mar 2026 14:02:16 +0100
From: Emanuele Rocca <emanuele.rocca@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH v5 1/2] pidfds: add coredump_code field to pidfd_info
Message-ID: <acE52HIFivNZN3nE@NH27D9T0LF>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acE5fYOgyVUYahIn@NH27D9T0LF>

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
Acked-by: Oleg Nesterov <oleg@redhat.com>
---
 fs/pidfs.c                 | 12 ++++++++----
 include/uapi/linux/pidfd.h |  4 ++++
 2 files changed, 12 insertions(+), 4 deletions(-)

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
-- 
2.47.3

