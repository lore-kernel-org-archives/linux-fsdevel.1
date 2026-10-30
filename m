Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793363999;
	b=PNq4jb4vIT0PDIK/6zW0qC5dHzuExlmlHWzILeTzjOkABIs9K2g/tabTuLEWs9pGv1Zz
	 raVwOP7bijg9FCHShaP+9JFjFwMD/p9ZCF27fyXVeJKq1ShOYqPcYew4/sIS3tpt2CKNZ
	 sSq3qe06yPAq6NnSir3fVyrfIovrTewKCVZijKAHAFa6nSucnbQ7UNuGc9jPB72BRIDQr
	 HqkNz7E27bghY6pDO1GpAVT4gFFgpEzB+nRU0KYOZO8WqVCATfVySMUx9Hb+I1qNkw1Kb
	 b/aDNzHJugyQFagcCIB3PsLR1Ez8QrCpPeZe3D1U4RQqNxTyALyt7KkQpPOo53CEWww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793363999;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Ed13n90ye5Czp3pxuz2kTfn9JK5IM878W6MtBdLVE2U=;
	b=jPP5Gy6nG1Nfty8vbQJq7VgsKjwdALiLGMt8ve5Nvv3aDNjmfzcYB578dk4fIbS9e4tx
	 RV9zMpQ1BDOILdhl4Q9w2knkl/btqLs/AcVb7omCtILt9GKq5DPzsEXht3oC0XjyKZrW7
	 eK4wSXVLHJkd300qfLTsKGfpPRTsjgRG1v4mHZMc8VCLvTf9h2i2hggAVzWoj0fcZ4hLM
	 woC0stNrxtV+sxz1n8QR/JdHIyTd/u3TXBSJ7Ch4y4E2X9tzc4G43/UvJHsRSKyf//knl
	 Qb+K07HNQQlcDZnbLu9bWV3aB1oLQM98UZ9g6TsHjyn4yS2I0vXHRqWnsYTyuSx05IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JTfFdqh8;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC82606A33B
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 12:39:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CC82606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JTfFdqh8
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48e0d1c095dso363360f8f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 05:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793363997; x=1793968797; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ed13n90ye5Czp3pxuz2kTfn9JK5IM878W6MtBdLVE2U=;
        b=JTfFdqh8j9+fKMxKHItTl2oqC4vxgdOAEHzXs0OazO/r1yFB59l7h0fLFfPqMPAanA
         jYDmylhiHlXm9FkDQWRtFAB3CSRFuq5Vx6Xh0oCEge/Rc6bUI1C5gHSBBfuVScKblTLE
         EKyntDiNuuzrmioqTrutj84ytMNpJXEN4Wk19CTY73fEf2I9LWyeLywIK9d/h0jpnHgm
         0u7/c8S4qbdaXryeJqacM7aeXz6rGs2ZZff1PFUrbY/ZcVp8cRDL/1yxcyNjwUgeBQto
         73dofAhf/FIabkPaZwOyFeupMJ22iROyZ5CVAhvjAHXTd0L6BWTO6j8Iy3Zz9s39lMWf
         SvHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793363997; x=1793968797;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ed13n90ye5Czp3pxuz2kTfn9JK5IM878W6MtBdLVE2U=;
        b=Tx6HdAcHLiTUUssrd1aS5ZXvX9fTgMT+7XSZZGUHkjgtZ1StgayNtl62EmlI8uFdss
         8ZKasB3LpnXbaNlHnW3SQHHYpjL5h6ULKpM7UdVVowTpuDVbV9q0pj1PO9cZ/H3kodKD
         LMrjmC3TYiHv6PRMFYMygElfGNJpJWFZW5/6u970gPeC95ReORdwbt7tCSGX8F4C/80y
         OY6RQmsiJFNT9sHqnoLTLQCOk8Ie82nkEvjGyf85/PDtnlUyRLhUnH5D17QRbCUx/zP9
         ju0+r5jDu4ptKuGPvXWIpMBbnLOFx4OweE71/L5YgvM5+pEr80b0LQm9tcx0nhLkD7xI
         GDvQ==
X-Forwarded-Encrypted: i=1; AKwUvBz+Wu7+RrC8OWWMTjRtj2byUyPY4xYsHO8fBVFxE/3Vh0VXYm5ZrCyoXBCq4AzhMpY12riZKmi5k7UzuYUv@vger.kernel.org
X-Gm-Message-State: AFq9FYISjlXrcKgQ0uOfeudHJagdcIs8zMDkUh2lmSzmWyQx3jJUyguG
	wByPbqP80g9qGmkJOa3e/jEhuA0CJGVZvmh8vgO+EWlMtE+GenMXtVF9
X-Gm-Gg: AYBFou3Idu1O8/SXVszeESUvgnYosY3SrLE3m1Dgkz0VgHxGjhKRRo71qgBDO2RfGUb
	JB8RLuVU1nzQCigN7er/pHTwXn3DnmYnnHdfMIeCCcqc47RAcVjHQpnoWwJzUYCc2rRbwEE/Egf
	FH9/CBKVD/wRUD+3ZheWVoPkZrlC3DivFDaOlSEYCmjwJ+KdvLrLQqdHt7zam82lkwrdwkXt/lk
	gMLQVyFg3ZQ2GXOGmlPqSnH1dLNLW9gogVP4VofjRZyw01OmL9y8jkoO83mg7fnJ6zP57vhqlnf
	YWssA3B/d0RGyHgpdkkghsMJqg0B+27jJc1m2dyCuLTwU0WS3SGvEFhmZLJwy4ODizOKcfLA+aB
	WX3wnHgc0+gCIZSEJS/QJUr2y7kS0IsvmXy5AZD/dlUW3l+/i+pLFgy3yYDASFV1TBxwMhFMI0H
	zGGOCElGtz2N2OyHke0B3DhK79ZX6JbQ3kLptS6AK/s1crvROqi+lm+wCHElLgxNiDuMBXF8MzG
	XCbCiQXxVL/UmqkEe35koZPZ/Y7Y16tP1LPSoOV7Oz+WjtetQwyfhv86fJGTq8S+SJsyo8BDsvR
	+5xs8NkGZqOE+gluPGY3iC1AtiGXrmFlkdMopaL5oha5LS10BcyHKKE7WFVoNil+Pfpctbw5uyN
	CZmHbGcFVY2xGPEshj9k=
X-Received: by 2002:adf:e307:0:b0:48d:bafc:a409 with SMTP id ffacd0b85a97d-48e6e4fde69mr4213621f8f.26.1793363996784;
        Fri, 30 Oct 2026 05:39:56 -0700 (PDT)
Received: from meven-thinkpad.home (2a01cb088745e00090de407b41070a01.ipv6.abo.wanadoo.fr. [2a01:cb08:8745:e000:90de:407b:4107:a01])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b78a4csm3088971f8f.23.2026.10.30.05.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 05:39:56 -0700 (PDT)
From: "=?UTF-8?q?M=C3=A9ven=20Car?=" <meven29@gmail.com>
X-Google-Original-From: =?UTF-8?q?M=C3=A9ven=20Car?= <meven@kde.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/3] io_uring: set times inline when the filesystem cannot sleep
Date: Fri, 30 Oct 2026 13:39:45 +0100
Message-ID: <20261030123945.1704118-4-meven@kde.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030123945.1704118-1-meven@kde.org>
References: <20261030123945.1704118-1-meven@kde.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

IORING_OP_UTIMENSAT always went to io-wq. On tmpfs the setattr only
changes the inode in memory, so the handoff to a worker cost more than
the work: 2000 files took 7 ms with utimensat(2) and 20 ms through the
ring.

Try the request inline first. The lookup uses LOOKUP_CACHED, and the
freeze protection and the inode lock are only tried, the former with
the new mnt_want_write_trylock(). A filesystem whose ->setattr() never
sleeps for a change of times alone says so with
FS_SETATTR_TIMES_NOWAIT, which tmpfs sets. Any other filesystem, an
uncached path, a contended lock or a delegation returns -EAGAIN, and
io_uring sends the request to io-wq as before.

Signed-off-by: Méven Car <meven@kde.org>
---
 fs/internal.h      |  3 ++-
 fs/namespace.c     | 20 +++++++++++++++++++
 fs/utimes.c        | 48 +++++++++++++++++++++++++++++++++++++---------
 include/linux/fs.h |  1 +
 io_uring/fs.c      | 26 +++++++++++++++----------
 mm/shmem.c         |  3 ++-
 6 files changed, 80 insertions(+), 21 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 985b2bc5895e..e991b63bb714 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -64,7 +64,7 @@ int filename_symlinkat(struct filename *from, int newdfd, struct filename *to);
 int filename_linkat(int olddfd, struct filename *old, int newdfd,
 			struct filename *new, int flags);
 int filename_utimensat(int dfd, struct filename *name,
-		       struct timespec64 *times, int flags);
+		       struct timespec64 *times, int flags, bool nowait);
 int vfs_tmpfile(struct mnt_idmap *idmap,
 		const struct path *parentpath,
 		struct file *file, umode_t mode);
@@ -86,6 +86,7 @@ extern int sb_prepare_remount_readonly(struct super_block *);
 extern void __init mnt_init(void);
 
 int mnt_get_write_access_file(struct file *file);
+int mnt_want_write_trylock(struct vfsmount *m);
 void mnt_put_write_access_file(struct file *file);
 
 extern void dissolve_on_fput(struct vfsmount *);
diff --git a/fs/namespace.c b/fs/namespace.c
index ae5dc64f8b45..f4aadd4e1958 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -499,6 +499,26 @@ int mnt_want_write(struct vfsmount *m)
 }
 EXPORT_SYMBOL_GPL(mnt_want_write);
 
+/**
+ * mnt_want_write_trylock - get write access to a mount without waiting
+ * @m: the mount on which to take a write
+ *
+ * Like mnt_want_write(), but returns -EAGAIN instead of waiting when the
+ * filesystem is frozen.  When the write operation is finished,
+ * mnt_drop_write() must be called.
+ */
+int mnt_want_write_trylock(struct vfsmount *m)
+{
+	int ret;
+
+	if (!sb_start_write_trylock(m->mnt_sb))
+		return -EAGAIN;
+	ret = mnt_get_write_access(m);
+	if (ret)
+		sb_end_write(m->mnt_sb);
+	return ret;
+}
+
 /**
  * mnt_get_write_access_file - get write access to a file's mount
  * @file: the file who's mount on which to take a write
diff --git a/fs/utimes.c b/fs/utimes.c
index 8072f05ac8dc..f70ad9003fa9 100644
--- a/fs/utimes.c
+++ b/fs/utimes.c
@@ -18,7 +18,9 @@ static bool nsec_valid(long nsec)
 	return nsec >= 0 && nsec <= 999999999;
 }
 
-int vfs_utimes(const struct path *path, struct timespec64 *times)
+/* With @nowait, returns -EAGAIN instead of sleeping */
+static int __vfs_utimes(const struct path *path, struct timespec64 *times,
+			bool nowait)
 {
 	int error;
 	struct iattr newattrs;
@@ -34,9 +36,17 @@ int vfs_utimes(const struct path *path, struct timespec64 *times)
 			times = NULL;
 	}
 
-	error = mnt_want_write(path->mnt);
-	if (error)
-		goto out;
+	if (nowait) {
+		if (!(inode->i_sb->s_type->fs_flags & FS_SETATTR_TIMES_NOWAIT))
+			return -EAGAIN;
+		error = mnt_want_write_trylock(path->mnt);
+		if (error)
+			goto out;
+	} else {
+		error = mnt_want_write(path->mnt);
+		if (error)
+			goto out;
+	}
 
 	newattrs.ia_valid = ATTR_CTIME | ATTR_MTIME | ATTR_ATIME;
 	if (times) {
@@ -63,24 +73,40 @@ int vfs_utimes(const struct path *path, struct timespec64 *times)
 		newattrs.ia_valid |= ATTR_TOUCH;
 	}
 retry_deleg:
-	inode_lock(inode);
+	if (!nowait) {
+		inode_lock(inode);
+	} else if (!inode_trylock(inode)) {
+		error = -EAGAIN;
+		goto drop;
+	}
 	error = notify_change(mnt_idmap(path->mnt), path->dentry, &newattrs,
 			      &delegated_inode);
 	inode_unlock(inode);
 	if (is_delegated(&delegated_inode)) {
+		if (nowait) {
+			iput(delegated_inode.di_inode);
+			delegated_inode.di_inode = NULL;
+			error = -EAGAIN;
+			goto drop;
+		}
 		error = break_deleg_wait(&delegated_inode);
 		if (!error)
 			goto retry_deleg;
 	}
-
+drop:
 	mnt_drop_write(path->mnt);
 out:
 	return error;
 }
+
+int vfs_utimes(const struct path *path, struct timespec64 *times)
+{
+	return __vfs_utimes(path, times, false);
+}
 EXPORT_SYMBOL_GPL(vfs_utimes);
 
 int filename_utimensat(int dfd, struct filename *name,
-		       struct timespec64 *times, int flags)
+		       struct timespec64 *times, int flags, bool nowait)
 {
 	struct path path;
 	int lookup_flags = 0, error;
@@ -90,13 +116,17 @@ int filename_utimensat(int dfd, struct filename *name,
 
 	if (!(flags & AT_SYMLINK_NOFOLLOW))
 		lookup_flags |= LOOKUP_FOLLOW;
+	if (nowait)
+		lookup_flags |= LOOKUP_CACHED;
 
 retry:
 	error = filename_lookup(dfd, name, lookup_flags, &path, NULL);
 	if (error)
 		return error;
-	error = vfs_utimes(&path, times);
+	error = __vfs_utimes(&path, times, nowait);
 	path_put(&path);
+	if (nowait && error == -ESTALE)
+		return -EAGAIN;
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
 		goto retry;
@@ -108,7 +138,7 @@ static int do_utimes_path(int dfd, const char __user *filename,
 		struct timespec64 *times, int flags)
 {
 	CLASS(filename_uflags, name)(filename, flags);
-	return filename_utimensat(dfd, name, times, flags);
+	return filename_utimensat(dfd, name, times, flags, false);
 }
 
 static int do_utimes_fd(int fd, struct timespec64 *times, int flags)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f9d1e05e8ae6..d1800fba15d8 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2296,6 +2296,7 @@ struct file_system_type {
 #define FS_POWER_FREEZE		256	/* Always freeze on suspend/hibernate */
 #define FS_USERNS_MOUNT_RESTRICTED 512	/* Restrict mount in userns if not already visible */
 #define FS_USERNS_DELEGATABLE	1024	/* Can be mounted inside userns from outside */
+#define FS_SETATTR_TIMES_NOWAIT	2048	/* ->setattr() of times alone never sleeps */
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
 	int (*init_fs_context)(struct fs_context *);
 	const struct fs_parameter_spec *parameters;
diff --git a/io_uring/fs.c b/io_uring/fs.c
index 85e0a1cb6b47..79f6f39ce267 100644
--- a/io_uring/fs.c
+++ b/io_uring/fs.c
@@ -356,38 +356,44 @@ int io_utimensat_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 		if (ut->dfd == AT_FDCWD)
 			return -EFAULT;
 		ut->flags |= IO_UTIMENSAT_NO_PATH;
-		goto out;
+		return 0;
 	}
 	err = delayed_getname_uflags(&ut->filename, fname, ut->flags);
 	if (unlikely(err))
 		return err;
 	req->flags |= REQ_F_NEED_CLEANUP;
-out:
-	req->flags |= REQ_F_FORCE_ASYNC;
 	return 0;
 }
 
-static int __io_utimensat(struct io_utimensat *ut, struct filename *name)
+static int __io_utimensat(struct io_utimensat *ut, struct filename *name,
+			  bool force_nonblock)
 {
 	int flags = ut->flags & (AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH);
 
-	return filename_utimensat(ut->dfd, name, ut->times, flags);
+	return filename_utimensat(ut->dfd, name, ut->times, flags,
+				  force_nonblock);
 }
 
 int io_utimensat(struct io_kiocb *req, unsigned int issue_flags)
 {
 	struct io_utimensat *ut = io_kiocb_to_cmd(req, struct io_utimensat);
+	bool force_nonblock = issue_flags & IO_URING_F_NONBLOCK;
 	int ret = 0;
 
-	WARN_ON_ONCE((issue_flags & IO_URING_F_NONBLOCK) &&
-		     !(ut->flags & IO_UTIMENSAT_NOOP));
-
 	if (ut->flags & IO_UTIMENSAT_NO_PATH) {
 		CLASS(filename_kernel, name)("");
-		ret = __io_utimensat(ut, name);
+		ret = __io_utimensat(ut, name, force_nonblock);
+		if (ret == -EAGAIN && force_nonblock)
+			return -EAGAIN;
 	} else if (!(ut->flags & IO_UTIMENSAT_NOOP)) {
 		CLASS(filename_complete_delayed, name)(&ut->filename);
-		ret = __io_utimensat(ut, name);
+		ret = __io_utimensat(ut, name, force_nonblock);
+		if (ret == -EAGAIN && force_nonblock) {
+			ret = putname_to_delayed(&ut->filename,
+						 no_free_ptr(name));
+			if (likely(!ret))
+				return -EAGAIN;
+		}
 	}
 
 	req->flags &= ~REQ_F_NEED_CLEANUP;
diff --git a/mm/shmem.c b/mm/shmem.c
index 897fa2b61346..405b39fc5d0e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -5310,7 +5310,8 @@ static struct file_system_type shmem_fs_type = {
 	.parameters	= shmem_fs_parameters,
 #endif
 	.kill_sb	= kill_anon_super,
-	.fs_flags	= FS_USERNS_MOUNT | FS_ALLOW_IDMAP | FS_MGTIME,
+	.fs_flags	= FS_USERNS_MOUNT | FS_ALLOW_IDMAP | FS_MGTIME |
+			  FS_SETATTR_TIMES_NOWAIT,
 };
 
 #if defined(CONFIG_SYSFS) && defined(CONFIG_TMPFS)
-- 
2.56.0

