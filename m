Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793790384;
	b=dSfjQ802OodPBdfjzSjGA3WVfHCE5s9a3vFPfZ+2ScW+z3J9nkOsNYX6pox9BmKBZPuU
	 +b+DD4v69QjMjN/KzBlQUTPMT5XMsdOdteSg3AjfMPBdHmBDu3UnyfEZgrivtmyfoadlK
	 eppovNzMpQgRvT+UO8Z75mEZniIpb22NOH1FIBgbMPIg23kVafPcBiRFG9eTUIiQqFNjD
	 kqM1O59txG0N3zCje9ec7rfhokPfiDryiFZ9LS3xprTNmljAskynnmVjElq4uS7LbwAvu
	 gTod52UsmlDNO3/6uB6FT5uc5WJ3O8Ixxa0t6Yg/uaA6hdDQBkhsxh7ED1GmaJCvnag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793790384;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=bX+HuofyV7edkMCVGlmcJHHKOGvBqTskGwpRW1QG8GA=;
	b=5gVqabq4o/skoQKMKEDSZKuPkt5D6/avuddJt/6OkJw0LUef3fageLw03uNnr9TIT8YE
	 1s2BoU57wnmjxhOBZmwW9Rjfb600WRYiZHd1yfd6UHwL0TU5cZKwuCkdkkkEedEgJUcrZ
	 u793DYWCN6AMgo1LOFP0FqFuKS3EtaWOHgPlCkQPI1/gyNW6qduLqak9/hUJ3UCAbNkD2
	 ANtPQH9tcVcX7IyBraaje7V2VogAOL49xJwZQvNLGmOCf/wyJ1DSUc5Uq0oJvupydIxMi
	 xf7JWC1BAE6kF68kc7VTw8PY9KAaT/H70u+5L9SulecYmXwKDHYyByMgIAvXdRS0Yew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Ecb/miJs";
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCB6606D805
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 11:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FCB6606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ecb/miJs
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a215e64962so5360295e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 03:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793790382; x=1794395182; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bX+HuofyV7edkMCVGlmcJHHKOGvBqTskGwpRW1QG8GA=;
        b=Ecb/miJsFXXmuMiEFqc42iRJ0dwErK+FnLefGFdbuoASBHpOMFqrqW6ca6nL7ixA3H
         BtKapMSUiiJNqIjvHDXRrXTQCwuJ8jpRSj/06/42QnoBH6gVaqh6mxGMvFRcZ6unuoQh
         inO+O1wM0mQFdxEv54kEoxum9gQBsSpPIpOJAsApydjuqifkMSJiAc+VHiJMDHWsYb5E
         wPrUB+ScfgfsXWwhi5DQr4CXeNjp2R2MLIkrHEM0hi5cmlAoFOunZ/RFufe0TjV+ptAg
         C4I4+CKB44cMIlYEa1znNcE2qUvrjHt+eM/AGfsxMzLedHjoHmK3osFy/w6QkuJaA25Q
         T1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793790382; x=1794395182;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bX+HuofyV7edkMCVGlmcJHHKOGvBqTskGwpRW1QG8GA=;
        b=djsvKYCDcdX/7f3NDoSRyDsmu0qAHVB1GigVJnqh7La/+EVA1tDTLxhKun7ZzyrnOm
         6l/fqMXmbLIElhHKv197MQrjFddBY2rHbEq/z/8cFsYIaV+5LL7Ovve1pIIbA0tx8R7g
         nvoej5g5KPeO1sv/JGOEN/qeB0CPcK55QzN85AHdZVyUy0VKdiy+BwNbhMWe5sejgqIJ
         miyMRpwfQXNIj/Rv90hHgdRT7Z/kl2dt2J2sjsDmBfBsYb08akFdSixKJDAQ88nrUzid
         v0AuV8l+Mx40PrvSBqivPg1FdPtc+lVrCMQ0SDSEOplFzRB0BjhJi3bkwIUCqa8hyt+6
         hAAQ==
X-Forwarded-Encrypted: i=1; AKwUvBx6APT8llUXBbHbPbRZeDGMFwXQCT2TzpO5iIwFUbXbuXV2IitOkKCsuCq44c2qczeOU4k9g7IWtjI5nkEo@vger.kernel.org
X-Gm-Message-State: APuU4Z/eTTEPVLnOan70pTC65ZCaSlXxaqTW+ora2p9HEpUty1TId3FE
	O6bwKVUQvj2aOvuBB5zde8XuOSfT7rt70vNvj6AUrZWIraD8ofM57gC8
X-Gm-Gg: AYBFou2i+perTXtQJAm3Awu84uFm//bv4ChwcUTnh6H85PcQi89UlKgDGV+rA8Xber9
	XueK6tG+6MFHRJTpQw4KATBCEQ6dxtIa/jHSmFzLvizig3QwOGQN8KdYEb2+o0IyNIOm4YU1d4t
	W0zFfs8Q2C5zTAwfRKfWq5c9IVvUNBHrMqtPBosD1W6iCoLQBRV/sEpyHYQjN70u/f9N+IAWWXJ
	jj8fb7028pQr5FuYgJVOBhs/9ELCFRY/gKEaZSDICtYbaoM2NPsxXa69Vh1FVELswSklHN2+SdN
	VWoZM1xFlWxPc+UDO5yCR0qlLCp2+6CxoYgP8CX2Z3fCTLu1ARI2TLDdVTl5ytpgNiS3fUXgs8I
	JDtPyRy6guuuBzfAaTM4nxw+ppfHnitY3Es4K+S17bWKGchjWJwTO29Qtza9gZQ+CdGnT7Y/FHY
	5dzdhKF3E1woC5NKFQ2XO3yBc1L8xReauQW6iHyA/T9a2Jmd6gC4iI+TkM1EpCmz9IHB8jcNyh3
	KQ/sV/O64UmPwhckmW9AjvdQby1y5B3vzAZReH14jh9sh1ruNTyyEk2eHvBWbi5sgL5DJbvEGq7
	jPmzw4CVjhpEljIx1qRm32nzaDo2/NFXtmApXWvldjzJ7txD7SLaYEHjE4jze2lnVCCRLv63lVj
	XY8chI4g+yF/4VaX4HkVJMGlM
X-Received: by 2002:a05:600c:1385:b0:4a3:5991:718 with SMTP id 5b1f17b1804b1-4ac182dc0a1mr386721525e9.16.1793790382506;
        Wed, 04 Nov 2026 03:06:22 -0800 (PST)
Received: from meven-thinkpad.home (2a01cb088745e00090de407b41070a01.ipv6.abo.wanadoo.fr. [2a01:cb08:8745:e000:90de:407b:4107:a01])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed92a753sm3704835f8f.45.2026.11.04.03.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 03:06:22 -0800 (PST)
From: =?UTF-8?q?M=C3=A9ven=20Car?= <meven29@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?M=C3=A9ven=20Car?= <meven@kde.org>
Subject: [RFC PATCH v2 3/3] io_uring: set times inline when the filesystem cannot sleep
Date: Wed,  4 Nov 2026 12:06:04 +0100
Message-ID: <20261104110604.126717-4-meven29@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104110604.126717-1-meven29@gmail.com>
References: <20261104110604.126717-1-meven29@gmail.com>
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

From: Méven Car <meven@kde.org>

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
 fs/internal.h      |  5 ++++-
 fs/namespace.c     | 20 ++++++++++++++++++++
 fs/utimes.c        | 45 +++++++++++++++++++++++++++++++++++----------
 include/linux/fs.h |  1 +
 io_uring/fs.c      | 22 ++++++++++++++--------
 mm/shmem.c         |  3 ++-
 6 files changed, 76 insertions(+), 20 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 985b2bc5895e..2370faec54f5 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -64,7 +64,9 @@ int filename_symlinkat(struct filename *from, int newdfd, struct filename *to);
 int filename_linkat(int olddfd, struct filename *old, int newdfd,
 			struct filename *new, int flags);
 int filename_utimensat(int dfd, struct filename *name,
-		       struct timespec64 *times, int flags);
+		       struct timespec64 *times, int flags, bool nowait);
+int __vfs_utimes(const struct path *path, struct timespec64 *times,
+		 bool nowait);
 int vfs_tmpfile(struct mnt_idmap *idmap,
 		const struct path *parentpath,
 		struct file *file, umode_t mode);
@@ -86,6 +88,7 @@ extern int sb_prepare_remount_readonly(struct super_block *);
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
index 8072f05ac8dc..a0d67b8e96a1 100644
--- a/fs/utimes.c
+++ b/fs/utimes.c
@@ -18,7 +18,9 @@ static bool nsec_valid(long nsec)
 	return nsec >= 0 && nsec <= 999999999;
 }
 
-int vfs_utimes(const struct path *path, struct timespec64 *times)
+/* With @nowait, returns -EAGAIN instead of sleeping */
+int __vfs_utimes(const struct path *path, struct timespec64 *times,
+		 bool nowait)
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
@@ -63,24 +73,35 @@ int vfs_utimes(const struct path *path, struct timespec64 *times)
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
+	/* Without a delegated_inode, a delegation gives -EWOULDBLOCK */
 	error = notify_change(mnt_idmap(path->mnt), path->dentry, &newattrs,
-			      &delegated_inode);
+			      nowait ? NULL : &delegated_inode);
 	inode_unlock(inode);
 	if (is_delegated(&delegated_inode)) {
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
@@ -90,13 +111,17 @@ int filename_utimensat(int dfd, struct filename *name,
 
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
@@ -108,7 +133,7 @@ static int do_utimes_path(int dfd, const char __user *filename,
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
index 71164bddd958..664ea918ae3b 100644
--- a/io_uring/fs.c
+++ b/io_uring/fs.c
@@ -358,34 +358,40 @@ int io_utimensat_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 		if (ut->flags)
 			return -EINVAL;
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
 
 int io_utimensat(struct io_kiocb *req, unsigned int issue_flags)
 {
 	struct io_utimensat *ut = io_kiocb_to_cmd(req, struct io_utimensat);
+	bool force_nonblock = issue_flags & IO_URING_F_NONBLOCK;
 	int ret = 0;
 
-	WARN_ON_ONCE((issue_flags & IO_URING_F_NONBLOCK) &&
-		     !(ut->flags & IO_UTIMENSAT_NOOP));
-
 	if (ut->flags & IO_UTIMENSAT_NO_PATH) {
 		CLASS(fd, f)(ut->dfd);
 
 		ret = -EBADF;
 		if (!fd_empty(f))
-			ret = vfs_utimes(&fd_file(f)->f_path, ut->times);
+			ret = __vfs_utimes(&fd_file(f)->f_path, ut->times,
+					   force_nonblock);
+		if (ret == -EAGAIN && force_nonblock)
+			return -EAGAIN;
 	} else if (!(ut->flags & IO_UTIMENSAT_NOOP)) {
 		CLASS(filename_complete_delayed, name)(&ut->filename);
-		ret = filename_utimensat(ut->dfd, name, ut->times, ut->flags);
+		ret = filename_utimensat(ut->dfd, name, ut->times, ut->flags,
+					 force_nonblock);
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

