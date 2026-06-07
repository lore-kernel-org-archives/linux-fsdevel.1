Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309C51DF254
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Jun 2026 16:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780850515; cv=none; b=gMgTFPcTDA5dgQggLND5tjpbGcFSFfZpuZ4mhtTBcmK2gZFaMp3A48e8/AxgjvNytT/9mJrSL+G5ieKP5DcA116faqgidHcnyGL8rGHzPBCtmPTSWT4MtMXp619uQqMDYB0ZYamvKiKZXZaNYZu1snuRi8ettb1812Oo5hUIgTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780850515; c=relaxed/simple;
	bh=sTSMTmNJtgmlU6oB9O1nMhv5Zevt8NFSi65AEFLZUBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JoiORNiK6P+M+s1BGqtj1NootHVcz1tNRpf1MYpCbBLukznreOysZVafpLGzXJfc7cUWfM/T2wkevh/X5munPhGiwxG+6Mv6moXdOW86eaIpKbOq33XWv+77uq/GOw38vc8Bmfc+6oHZGAl15EL3hIIJOJh2FAiG5fpzxVmufWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KTxpuMZX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KTxpuMZX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780850513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oEaXL7l7SsdVCnSQu53UeFbSpzncVM6juNiLZ7gijMs=;
	b=KTxpuMZXetBueJTkJlmMbhZMgqLEMK/KLwaAnlcB3XLsHJ6G1yJADmmDyBoMRCMD0SR7qb
	KxdnlWmyYhzABhAyPrS6eAseyxhjR3bQ8hhoyQecrf1/Nhfv9owvcyl0t13iMtItmvlU72
	tesF2Kbsxu5dGdEXIC7wp6XV7l3SkAk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-IRx1tkUmPEG3DVJuz86CHQ-1; Sun,
 07 Jun 2026 12:41:48 -0400
X-MC-Unique: IRx1tkUmPEG3DVJuz86CHQ-1
X-Mimecast-MFC-AGG-ID: IRx1tkUmPEG3DVJuz86CHQ_1780850506
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5B087180047F;
	Sun,  7 Jun 2026 16:41:46 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.30])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2243230001BE;
	Sun,  7 Jun 2026 16:41:43 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 3/3] file: consolidate fd cleanup classes using fdget_except
Date: Sun,  7 Jun 2026 18:41:36 +0200
Message-ID: <20260607164136.2948550-3-agruenba@redhat.com>
In-Reply-To: <20260607164136.2948550-1-agruenba@redhat.com>
References: <20260607164136.2948550-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Currently, the fd, fd_except, and fd_raw cleanup classes all use separate init
functions, but fdget() and fdget_raw() can be replaced with fdget_except() with
negligible overhead.

The only complication is that we now need access to the definition of
FMODE_PATH in <linux/file.h>.  To make that definition available without
including <linux/fs.h>, split the fmode definitions off into a separate
<linux/fmode.h> header and include that in both places.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 drivers/android/binder.c |   2 +-
 fs/file.c                |  18 +-----
 include/linux/file.h     |  11 ++--
 include/linux/fmode.h    | 120 +++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h       | 116 +------------------------------------
 5 files changed, 131 insertions(+), 136 deletions(-)
 create mode 100644 include/linux/fmode.h

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 9e6194224593..0a4e2e37fbef 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -1983,7 +1983,7 @@ struct binder_task_work_cb {
  * It is not safe to call ksys_close() during the binder_ioctl()
  * function if there is a chance that binder's own file descriptor
  * might be closed. This is to meet the requirements for using
- * fdget() (see comments for __fget_light()). Therefore use
+ * fdget_except() (see the comments there). Therefore use
  * task_work_add() to schedule the close operation once we have
  * returned from binder_ioctl(). This function is a callback
  * for that mechanism and does the actual ksys_close() on the
diff --git a/fs/file.c b/fs/file.c
index c34049b36e6f..c686c1313b2e 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1179,7 +1179,7 @@ EXPORT_SYMBOL(fget_task_next);
  *
  * See also the documentation in rust/kernel/file.rs.
  */
-static inline struct fd __fget_light(unsigned int fd, fmode_t mask)
+struct fd fdget_except(unsigned int fd, fmode_t mask)
 {
 	struct files_struct *files = current->files;
 	struct file *file;
@@ -1205,21 +1205,7 @@ static inline struct fd __fget_light(unsigned int fd, fmode_t mask)
 		return CLONED_FD(file);
 	}
 }
-struct fd fdget(unsigned int fd)
-{
-	return __fget_light(fd, FMODE_PATH);
-}
-EXPORT_SYMBOL(fdget);
-
-struct fd fdget_except(unsigned int fd, fmode_t mask)
-{
-	return __fget_light(fd, mask);
-}
-
-struct fd fdget_raw(unsigned int fd)
-{
-	return __fget_light(fd, 0);
-}
+EXPORT_SYMBOL(fdget_except);
 
 /*
  * Try to avoid f_pos locking. We only need it if the
diff --git a/include/linux/file.h b/include/linux/file.h
index 947765f064fe..c2b73a95c508 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -11,6 +11,7 @@
 #include <linux/posix_types.h>
 #include <linux/errno.h>
 #include <linux/cleanup.h>
+#include <linux/fmode.h>
 #include <linux/err.h>
 
 struct file;
@@ -69,9 +70,11 @@ extern struct file *fget_task(struct task_struct *task, unsigned int fd);
 extern struct file *fget_task_next(struct task_struct *task, unsigned int *fd);
 extern void __f_unlock_pos(struct file *);
 
-struct fd fdget(unsigned int fd);
-struct fd fdget_except(unsigned int fd, fmode_t mask);
-struct fd fdget_raw(unsigned int fd);
+struct fd fdget_except(unsigned int fd, fmode_t mode);
+static inline struct fd fdget(unsigned int fd)
+{
+	return fdget_except(fd, FMODE_PATH);
+}
 struct fd fdget_pos(unsigned int fd);
 
 static inline void fdput_pos(struct fd f)
@@ -83,7 +86,7 @@ static inline void fdput_pos(struct fd f)
 
 DEFINE_CLASS(fd, struct fd, fdput(_T), fdget(fd), int fd)
 DEFINE_CLASS(fd_except, struct fd, fdput(_T), fdget_except(fd, mask), int fd, fmode_t mask)
-DEFINE_CLASS(fd_raw, struct fd, fdput(_T), fdget_raw(fd), int fd)
+DEFINE_CLASS(fd_raw, struct fd, fdput(_T), fdget_except(fd, 0), int fd)
 DEFINE_CLASS(fd_pos, struct fd, fdput_pos(_T), fdget_pos(fd), int fd)
 
 extern int f_dupfd(unsigned int from, struct file *file, unsigned flags);
diff --git a/include/linux/fmode.h b/include/linux/fmode.h
new file mode 100644
index 000000000000..7c4758f3b693
--- /dev/null
+++ b/include/linux/fmode.h
@@ -0,0 +1,120 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_FMODE_H
+#define _LINUX_FMODE_H
+
+/*
+ * flags in file.f_mode.  Note that FMODE_READ and FMODE_WRITE must correspond
+ * to O_WRONLY and O_RDWR via the strange trick in do_dentry_open()
+ */
+
+/* file is open for reading */
+#define FMODE_READ		((__force fmode_t)(1 << 0))
+/* file is open for writing */
+#define FMODE_WRITE		((__force fmode_t)(1 << 1))
+/* file is seekable */
+#define FMODE_LSEEK		((__force fmode_t)(1 << 2))
+/* file can be accessed using pread */
+#define FMODE_PREAD		((__force fmode_t)(1 << 3))
+/* file can be accessed using pwrite */
+#define FMODE_PWRITE		((__force fmode_t)(1 << 4))
+/* File is opened for execution with sys_execve / sys_uselib */
+#define FMODE_EXEC		((__force fmode_t)(1 << 5))
+/* File writes are restricted (block device specific) */
+#define FMODE_WRITE_RESTRICTED	((__force fmode_t)(1 << 6))
+/* File supports atomic writes */
+#define FMODE_CAN_ATOMIC_WRITE	((__force fmode_t)(1 << 7))
+
+/* FMODE_* bit 8 */
+
+/* 32bit hashes as llseek() offset (for directories) */
+#define FMODE_32BITHASH         ((__force fmode_t)(1 << 9))
+/* 64bit hashes as llseek() offset (for directories) */
+#define FMODE_64BITHASH         ((__force fmode_t)(1 << 10))
+
+/*
+ * Don't update ctime and mtime.
+ *
+ * Currently a special hack for the XFS open_by_handle ioctl, but we'll
+ * hopefully graduate it to a proper O_CMTIME flag supported by open(2) soon.
+ */
+#define FMODE_NOCMTIME		((__force fmode_t)(1 << 11))
+
+/* Expect random access pattern */
+#define FMODE_RANDOM		((__force fmode_t)(1 << 12))
+
+/* Supports IOCB_HAS_METADATA */
+#define FMODE_HAS_METADATA	((__force fmode_t)(1 << 13))
+
+/* File is opened with O_PATH; almost nothing can be done with it */
+#define FMODE_PATH		((__force fmode_t)(1 << 14))
+
+/* File needs atomic accesses to f_pos */
+#define FMODE_ATOMIC_POS	((__force fmode_t)(1 << 15))
+/* Write access to underlying fs */
+#define FMODE_WRITER		((__force fmode_t)(1 << 16))
+/* Has read method(s) */
+#define FMODE_CAN_READ          ((__force fmode_t)(1 << 17))
+/* Has write method(s) */
+#define FMODE_CAN_WRITE         ((__force fmode_t)(1 << 18))
+
+#define FMODE_OPENED		((__force fmode_t)(1 << 19))
+#define FMODE_CREATED		((__force fmode_t)(1 << 20))
+
+/* File is stream-like */
+#define FMODE_STREAM		((__force fmode_t)(1 << 21))
+
+/* File supports DIRECT IO */
+#define	FMODE_CAN_ODIRECT	((__force fmode_t)(1 << 22))
+
+#define	FMODE_NOREUSE		((__force fmode_t)(1 << 23))
+
+/* File is embedded in backing_file object */
+#define FMODE_BACKING		((__force fmode_t)(1 << 24))
+
+/*
+ * Together with FMODE_NONOTIFY_PERM defines which fsnotify events shouldn't be
+ * generated (see below)
+ */
+#define FMODE_NONOTIFY		((__force fmode_t)(1 << 25))
+
+/*
+ * Together with FMODE_NONOTIFY defines which fsnotify events shouldn't be
+ * generated (see below)
+ */
+#define FMODE_NONOTIFY_PERM	((__force fmode_t)(1 << 26))
+
+/* File is capable of returning -EAGAIN if I/O will block */
+#define FMODE_NOWAIT		((__force fmode_t)(1 << 27))
+
+/* File represents mount that needs unmounting */
+#define FMODE_NEED_UNMOUNT	((__force fmode_t)(1 << 28))
+
+/* File does not contribute to nr_files count */
+#define FMODE_NOACCOUNT		((__force fmode_t)(1 << 29))
+
+/*
+ * The two FMODE_NONOTIFY* define which fsnotify events should not be generated
+ * for an open file. These are the possible values of
+ * (f->f_mode & FMODE_FSNOTIFY_MASK) and their meaning:
+ *
+ * FMODE_NONOTIFY - suppress all (incl. non-permission) events.
+ * FMODE_NONOTIFY_PERM - suppress permission (incl. pre-content) events.
+ * FMODE_NONOTIFY | FMODE_NONOTIFY_PERM - suppress only FAN_ACCESS_PERM.
+ */
+#define FMODE_FSNOTIFY_MASK \
+	(FMODE_NONOTIFY | FMODE_NONOTIFY_PERM)
+
+#define FMODE_FSNOTIFY_NONE(mode) \
+	((mode & FMODE_FSNOTIFY_MASK) == FMODE_NONOTIFY)
+#ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
+#define FMODE_FSNOTIFY_HSM(mode) \
+	((mode & FMODE_FSNOTIFY_MASK) == 0 || \
+	 (mode & FMODE_FSNOTIFY_MASK) == (FMODE_NONOTIFY | FMODE_NONOTIFY_PERM))
+#define FMODE_FSNOTIFY_ACCESS_PERM(mode) \
+	((mode & FMODE_FSNOTIFY_MASK) == 0)
+#else
+#define FMODE_FSNOTIFY_ACCESS_PERM(mode) 0
+#define FMODE_FSNOTIFY_HSM(mode)	0
+#endif
+
+#endif /* _LINUX_FMODE_H */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 11559c513dfb..d8c3a5919aa9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -47,6 +47,7 @@
 #include <linux/rw_hint.h>
 #include <linux/file_ref.h>
 #include <linux/unicode.h>
+#include <linux/fmode.h>
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
@@ -99,121 +100,6 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 /* called from RCU mode, don't block */
 #define MAY_NOT_BLOCK		0x00000080
 
-/*
- * flags in file.f_mode.  Note that FMODE_READ and FMODE_WRITE must correspond
- * to O_WRONLY and O_RDWR via the strange trick in do_dentry_open()
- */
-
-/* file is open for reading */
-#define FMODE_READ		((__force fmode_t)(1 << 0))
-/* file is open for writing */
-#define FMODE_WRITE		((__force fmode_t)(1 << 1))
-/* file is seekable */
-#define FMODE_LSEEK		((__force fmode_t)(1 << 2))
-/* file can be accessed using pread */
-#define FMODE_PREAD		((__force fmode_t)(1 << 3))
-/* file can be accessed using pwrite */
-#define FMODE_PWRITE		((__force fmode_t)(1 << 4))
-/* File is opened for execution with sys_execve / sys_uselib */
-#define FMODE_EXEC		((__force fmode_t)(1 << 5))
-/* File writes are restricted (block device specific) */
-#define FMODE_WRITE_RESTRICTED	((__force fmode_t)(1 << 6))
-/* File supports atomic writes */
-#define FMODE_CAN_ATOMIC_WRITE	((__force fmode_t)(1 << 7))
-
-/* FMODE_* bit 8 */
-
-/* 32bit hashes as llseek() offset (for directories) */
-#define FMODE_32BITHASH         ((__force fmode_t)(1 << 9))
-/* 64bit hashes as llseek() offset (for directories) */
-#define FMODE_64BITHASH         ((__force fmode_t)(1 << 10))
-
-/*
- * Don't update ctime and mtime.
- *
- * Currently a special hack for the XFS open_by_handle ioctl, but we'll
- * hopefully graduate it to a proper O_CMTIME flag supported by open(2) soon.
- */
-#define FMODE_NOCMTIME		((__force fmode_t)(1 << 11))
-
-/* Expect random access pattern */
-#define FMODE_RANDOM		((__force fmode_t)(1 << 12))
-
-/* Supports IOCB_HAS_METADATA */
-#define FMODE_HAS_METADATA	((__force fmode_t)(1 << 13))
-
-/* File is opened with O_PATH; almost nothing can be done with it */
-#define FMODE_PATH		((__force fmode_t)(1 << 14))
-
-/* File needs atomic accesses to f_pos */
-#define FMODE_ATOMIC_POS	((__force fmode_t)(1 << 15))
-/* Write access to underlying fs */
-#define FMODE_WRITER		((__force fmode_t)(1 << 16))
-/* Has read method(s) */
-#define FMODE_CAN_READ          ((__force fmode_t)(1 << 17))
-/* Has write method(s) */
-#define FMODE_CAN_WRITE         ((__force fmode_t)(1 << 18))
-
-#define FMODE_OPENED		((__force fmode_t)(1 << 19))
-#define FMODE_CREATED		((__force fmode_t)(1 << 20))
-
-/* File is stream-like */
-#define FMODE_STREAM		((__force fmode_t)(1 << 21))
-
-/* File supports DIRECT IO */
-#define	FMODE_CAN_ODIRECT	((__force fmode_t)(1 << 22))
-
-#define	FMODE_NOREUSE		((__force fmode_t)(1 << 23))
-
-/* File is embedded in backing_file object */
-#define FMODE_BACKING		((__force fmode_t)(1 << 24))
-
-/*
- * Together with FMODE_NONOTIFY_PERM defines which fsnotify events shouldn't be
- * generated (see below)
- */
-#define FMODE_NONOTIFY		((__force fmode_t)(1 << 25))
-
-/*
- * Together with FMODE_NONOTIFY defines which fsnotify events shouldn't be
- * generated (see below)
- */
-#define FMODE_NONOTIFY_PERM	((__force fmode_t)(1 << 26))
-
-/* File is capable of returning -EAGAIN if I/O will block */
-#define FMODE_NOWAIT		((__force fmode_t)(1 << 27))
-
-/* File represents mount that needs unmounting */
-#define FMODE_NEED_UNMOUNT	((__force fmode_t)(1 << 28))
-
-/* File does not contribute to nr_files count */
-#define FMODE_NOACCOUNT		((__force fmode_t)(1 << 29))
-
-/*
- * The two FMODE_NONOTIFY* define which fsnotify events should not be generated
- * for an open file. These are the possible values of
- * (f->f_mode & FMODE_FSNOTIFY_MASK) and their meaning:
- *
- * FMODE_NONOTIFY - suppress all (incl. non-permission) events.
- * FMODE_NONOTIFY_PERM - suppress permission (incl. pre-content) events.
- * FMODE_NONOTIFY | FMODE_NONOTIFY_PERM - suppress only FAN_ACCESS_PERM.
- */
-#define FMODE_FSNOTIFY_MASK \
-	(FMODE_NONOTIFY | FMODE_NONOTIFY_PERM)
-
-#define FMODE_FSNOTIFY_NONE(mode) \
-	((mode & FMODE_FSNOTIFY_MASK) == FMODE_NONOTIFY)
-#ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
-#define FMODE_FSNOTIFY_HSM(mode) \
-	((mode & FMODE_FSNOTIFY_MASK) == 0 || \
-	 (mode & FMODE_FSNOTIFY_MASK) == (FMODE_NONOTIFY | FMODE_NONOTIFY_PERM))
-#define FMODE_FSNOTIFY_ACCESS_PERM(mode) \
-	((mode & FMODE_FSNOTIFY_MASK) == 0)
-#else
-#define FMODE_FSNOTIFY_ACCESS_PERM(mode) 0
-#define FMODE_FSNOTIFY_HSM(mode)	0
-#endif
-
 /*
  * Attribute flags.  These should be or-ed together to figure out what
  * has been changed!
-- 
2.54.0

