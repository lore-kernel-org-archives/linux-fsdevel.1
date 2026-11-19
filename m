Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795122947;
	b=WWKTg7fwG6PAKDljKYkIzYJssFQHJHUdHGRoVDjJDiUFwOzCMXkUhbUgrn6lwFbd09z8
	 P+FusYYcqx8SZaMuZfN1BJ2PFrnPDZWSvSSD61SOP6k3ma2BiXj/Utw3B5EvJuDmV251J
	 Md48tUfhiIIO1QZfn4UoTNauygFQTbb+p7DaKytTgBIc+F2M5/UCtTiIBTTH5ycNs/Bp6
	 8ulfTUA6m2qz/z4cCyjWnSBJtwaLjLVSxczuI8VnxAX0qddTsiA2qUXojCIznybbqGwE5
	 ZxRCrVG9PxCJWQjrz2DGeD5SCKtMZ1Hn02D4Pa86dT7NZZt7FfdMGNspowFhh9QDAqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795122947;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Tc5opscNT+ATkDzpq4f6to21+ehrx5595qg6c8eJNt8=;
	b=Lpc3/fG/DxIo5wI964nznjtPh9ADsyIToJmtlshPCZT/Dv9+OzBbEoK4M697TlM6Bemw
	 zHhT3wGo88P0lvN7GC81jDiBQtRg2TsGekTbLk3ho/Nzm1EfRjq6Di/k6VktDodJtnZIr
	 bLufF9vkA7BzAfwzqZFUnASHqLTe3/ykJfJP6SZ9pNy2DI4UlQIGcU3tQMldN6DWrDsHg
	 qvJB0ODu1tsQAo3NDH/Spql2xTtlmij2QkX25CXePIDshRqeZJHGiueKegvILEy5YDlA1
	 HSfvH1RKXlxft9ORS3JZ8cv/Vp1eqMQdqLD3ZkpBjYvroDpMQyDwoteEI3rzAnzOG7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AvBZTtar;
	arc=none smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790DB60A2616
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 21:15:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 790DB60A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AvBZTtar
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c4d2b741ed9so40719566b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 13:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795122944; x=1795727744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tc5opscNT+ATkDzpq4f6to21+ehrx5595qg6c8eJNt8=;
        b=AvBZTtar3duU3OcP4+5m3vPo0o9icOddU+EaXcbAL+k/CuiMkEnoO0sihLK0MMiQ0i
         unBToyJ+0veUgd055dw4WTvh8KYhyArR67NiLO8UzLbaU1TTHBA9zq6fuzDikWYICCSR
         h8X5+DUWyUL8tC/1K0L4l0t4LEPQWxrtvCsAHvTSjgzIWykwQBTmEYp4qM5K6ruvq/zc
         Mf/nLihZ1HMgzU1gCg8BM75hPo9D1tnz64cQkXc74Cq6nevwPq13rb15zQCUstOxtBE/
         6F8pWe47E1dplE7JzRIqCidEHy4SDsOm4xsmHNgNFg41/FHlNNawMww8WrMlKlT4Xv5T
         xdsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795122944; x=1795727744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tc5opscNT+ATkDzpq4f6to21+ehrx5595qg6c8eJNt8=;
        b=Hl7K9w5X2ZuFCaU4FpW5f3U88SkJQjM8PQCZxKtaPJHFwTTbAWgMn4Jz1jTWbP35pM
         vBNgjC/fJKH7zOydBjP09JY5Ood7foMye3Cz5cWEGUUUkH5SymSMtMMUuUGdL+/XKKMt
         4O23XFUT5zivvnCeum+WZt4w7jsozpZC+ydcSVIbp/nsxClpvtSnba4bSkxTIsNBPiSz
         kHSZn6OMaTCnx8rdOUvQTkMEnkUxXymjY19h2yqFVOvflLrrN2ctsH4CQlkv6Y4ar5Ya
         3IN9rIYjRvMQve45qNLr1yvgI9rKt1j/T6KzwlYeOLQtTI1vvW/LSCP14mX8056XfWiO
         TYLg==
X-Gm-Message-State: APuU4Z9NpoZftWoViAnW6Vl6N5N//0vpxP16iA/3p/y+sHagSapbon+m
	Ombaa4zXausIM1cZMBn/jO3jhxidfNIQEJEa7UJJ8gKhYPRPYacDPVkGTMYKg1xC
X-Gm-Gg: AYBFou0sg07t5QI2vtsoiwY8oM71LgCsvIx1aU1fJag6Wo+1U41cvtxgTSrAXk2qA8L
	CT5JJJNC8Dz79VkOxFPt5KPiQ8HlZ3h/qeLldrWk5SWlbzJA/vxX1iJTd2NmcKMNgL+DNCLJFdv
	CsMSwfFEgpAHrG/51Dm8ImnaugGA3zaexUK/ASPMUq44b9eTf0EqPcZ12yTebZvmc/XxuGrdcFQ
	5EphAXbvp0hNie37JEpM6w015XmFVW7qDeixJHQVh8etuu7DPNu6hP0zFOlC5YcATTi2rk7ECjp
	e0DdyL/aTXospUms2fpzGGmwqxQvQCzQV3VgCqazQrEchjjy0/OEMQdv6kGIO97trqtXdIx6cJy
	ejAUZAS9Ua4pxhqVuERQg+v7F6NM0XWMZfmZ9jrUpvMfxIOJzmnUeifNusP74CN33zJqYNca9k5
	VHuFLnyzf0g0L7EtEdyG+a1c00vgI4wJg3Bpy0dRyOP6S3W9nCSEGxAJYbSSHr895g058UMt8NG
	u/J9FOf2ahvYGKOD0gAihWUj1y8KKwKTGcL9Ae2UhCHg66ycCVLc7eUN5X9JbVTa7Zeo0L0Nu4x
	sSSAQbwjqVYN87WO3R2EYJffu03n3HsfEzmt8d0sVQRDGsNrfjM0xjVaDQHNCFZzS4MKnC2MVvA
	lS3qFPP4aZmMQ
X-Received: by 2002:a17:906:d10c:b0:c2e:2252:6ddb with SMTP id a640c23a62f3a-c513a5ea8a7mr100171166b.10.1795122943485;
        Thu, 19 Nov 2026 13:15:43 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ae67bd3sm33246666b.27.2026.11.19.13.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 13:15:42 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Ding Feng <dingf3ng@gmail.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Subject: [PATCH v2] fs: add ->f_real() file operation
Date: Thu, 19 Nov 2026 22:15:42 +0100
Message-ID: <20261119211542.1509119-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.56.1
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

sync_file_range(2) and cachestat(2) operate on file->f_mapping.  For a
file on a stacking filesystem, such as overlayfs, the data and its page
cache are in the real (backing) file, so on a stacked file
sync_file_range() writes back nothing and cachestat() reports nothing.

Add a ->f_real() file operation, modelled after ->d_real(), and a
file_real() helper in backing-file.h that returns the backing file
holding the data of a stacked file, or the file itself.  file_real() is
a no-op without CONFIG_FS_STACK; otherwise it calls backing_file_real()
in fs/backing-file.c, which calls ->f_real() and verifies that it
returned a backing file.  The real file is owned by the stacked file, so
it is valid for as long as the caller holds the stacked file.

file_real() is only meant for inspecting and writing back the page cache
of the data.  Operations that need the credentials or permission checks
of the stacking filesystem need a dedicated file operation, like
->fadvise().

Use file_real() in sync_file_range() (also used by io_uring) and in
cachestat(), and implement ->f_real() for overlayfs.

Tested-by: Ding Feng <dingf3ng@gmail.com>
Link: https://lore.kernel.org/r/20261118040056.6543-1-dingf3ng@gmail.com/
Tested-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Link: https://lore.kernel.org/r/20261119183039.1505892-2-ptikhomirov@virtuozzo.com/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Christian,

v2 fixes the nested overlayfs case that Pavel pointed out.

Thanks,
Amir.

Changes since v1:
- ovl_f_real() recurses into a stacked lower fs (Pavel)
- Rename __file_real() to backing_file_real() and export it for ovl
- Added Pavel's tested-by and link to his new test

v1: https://lore.kernel.org/r/20261118123105.1247627-1-amir73il@gmail.com/

 Documentation/filesystems/locking.rst |  1 +
 Documentation/filesystems/vfs.rst     | 17 +++++++++++++++++
 fs/backing-file.c                     | 13 +++++++++++++
 fs/overlayfs/file.c                   | 17 +++++++++++++++++
 fs/sync.c                             |  8 ++++++++
 include/linux/backing-file.h          | 26 ++++++++++++++++++++++++++
 include/linux/fs.h                    |  1 +
 mm/filemap.c                          |  9 ++++++++-
 8 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index f7363ad770c76..db9ba2a8c13e7 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -485,6 +485,7 @@ prototypes::
 			struct file *file_out, loff_t pos_out,
 			loff_t len, unsigned int remap_flags);
 	int (*fadvise)(struct file *, loff_t, loff_t, int);
+	struct file *(*f_real)(const struct file *);
 
 locking rules:
 	All may block.
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 1824462a43711..e4ce15545244b 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -1038,6 +1038,7 @@ This describes how the VFS can manipulate an open file.  As of kernel
 					   struct file *file_out, loff_t pos_out,
 					   loff_t len, unsigned int remap_flags);
 		int (*fadvise)(struct file *, loff_t, loff_t, int);
+		struct file *(*f_real)(const struct file *);
 		int (*uring_cmd)(struct io_uring_cmd *ioucmd, unsigned int issue_flags);
 		int (*uring_cmd_iopoll)(struct io_uring_cmd *, struct io_comp_batch *,
 					unsigned int poll_flags);
@@ -1162,6 +1163,22 @@ otherwise noted.
 ``fadvise``
 	possibly called by the fadvise64() system call.
 
+``f_real``
+	stacking filesystems (e.g. overlayfs) whose file data is accessed
+	through a backing file implement this method to return that backing
+	file.  It is called through file_real() by system calls that operate
+	on the page cache of the data, such as sync_file_range(2) and
+	cachestat(2).
+
+	The returned file must be a backing file (FMODE_BACKING) or the file
+	itself.  It is owned by the file and must remain valid for as long
+	as the caller holds a reference to the file.
+
+	The returned file is only used to inspect and write back the page
+	cache of the data.  Operations that need the credentials or the
+	permission checks of the stacking filesystem need a dedicated file
+	operation (e.g. ``fadvise``).
+
 ``mmap_prepare``
 	Called by the mmap(2) system call. Allows a VFS to set up a
 	file-backed memory mapping, most notably establishing relevant
diff --git a/fs/backing-file.c b/fs/backing-file.c
index c601b27f0fd35..c63acb636ad0e 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -102,6 +102,19 @@ struct file *backing_tmpfile_open(const struct file *user_file, int flags,
 }
 EXPORT_SYMBOL(backing_tmpfile_open);
 
+/* Get the innermost backing file of @user_file */
+struct file *backing_file_real(struct file *user_file)
+{
+	struct file *real_file = user_file->f_op->f_real(user_file);
+
+	if (!IS_ERR(real_file) && real_file != user_file &&
+	    WARN_ON_ONCE(!(real_file->f_mode & FMODE_BACKING)))
+		return ERR_PTR(-EIO);
+
+	return real_file;
+}
+EXPORT_SYMBOL_GPL(backing_file_real);
+
 struct backing_aio {
 	struct kiocb iocb;
 	refcount_t ref;
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 7433220d4ad6c..41a3daf3e0663 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -195,6 +195,22 @@ static struct file *ovl_real_file(const struct file *file)
 	return ovl_real_file_path(file, &realpath);
 }
 
+/*
+ * The real file that holds the page cache of the data: the upper file after
+ * copy up, otherwise the lower data file.  After copy up of a file that was
+ * opened from lower, this opens the upper file, just like a write would.
+ */
+static struct file *ovl_f_real(const struct file *file)
+{
+	struct file *real_file = ovl_real_file(file);
+
+	if (IS_ERR(real_file))
+		return real_file;
+
+	/* Handle recursion into stacked lower fs */
+	return file_real(real_file);
+}
+
 static int ovl_open(struct inode *inode, struct file *file)
 {
 	struct dentry *dentry = file_dentry(file);
@@ -656,6 +672,7 @@ const struct file_operations ovl_file_operations = {
 	.mmap		= ovl_mmap,
 	.fallocate	= ovl_fallocate,
 	.fadvise	= ovl_fadvise,
+	.f_real		= ovl_f_real,
 	.flush		= ovl_flush,
 	.splice_read    = ovl_splice_read,
 	.splice_write   = ovl_splice_write,
diff --git a/fs/sync.c b/fs/sync.c
index 4a84dd837b863..e8f5ddf14cbe4 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -7,6 +7,7 @@
 #include <linux/kernel.h>
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/backing-file.h>
 #include <linux/slab.h>
 #include <linux/export.h>
 #include <linux/namei.h>
@@ -269,6 +270,13 @@ int sync_file_range(struct file *file, loff_t offset, loff_t nbytes,
 	if (!S_ISREG(i_mode) && !S_ISBLK(i_mode) && !S_ISDIR(i_mode))
 		goto out;
 
+	/* The page cache of a stacked file is in its real file */
+	file = file_real(file);
+	if (IS_ERR(file)) {
+		ret = PTR_ERR(file);
+		goto out;
+	}
+
 	mapping = file->f_mapping;
 	ret = 0;
 	if (flags & SYNC_FILE_RANGE_WAIT_BEFORE) {
diff --git a/include/linux/backing-file.h b/include/linux/backing-file.h
index c939cd222730c..dec7f8f017418 100644
--- a/include/linux/backing-file.h
+++ b/include/linux/backing-file.h
@@ -40,5 +40,31 @@ ssize_t backing_file_splice_write(struct pipe_inode_info *pipe,
 				  struct backing_file_ctx *ctx);
 int backing_file_mmap(struct file *file, struct vm_area_struct *vma,
 		      struct backing_file_ctx *ctx);
+struct file *backing_file_real(struct file *user_file);
+
+/**
+ * file_real - Return the real file hosting the data
+ * @file: the file to query
+ *
+ * If @file is on a stacking filesystem (e.g. overlayfs) whose data is
+ * accessed through a backing file, return that backing file.
+ * Otherwise return @file itself.
+ *
+ * The returned file is owned by @file and is valid for as long as the
+ * caller holds a reference to @file.
+ *
+ * The real file is only meant to be used for inspecting and writing
+ * back the page cache of the data (e.g. sync_file_range(2), cachestat(2)).
+ * It must not be used for operations that require the credentials or the
+ * permission checks of the stacking filesystem; those need a dedicated
+ * file operation (e.g. ->fadvise()).
+ */
+static inline struct file *file_real(struct file *file)
+{
+	if (!IS_ENABLED(CONFIG_FS_STACK) || likely(!file->f_op->f_real))
+		return file;
+
+	return backing_file_real(file);
+}
 
 #endif /* _LINUX_BACKING_FILE_H */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 5b3a100aba77b..613f7c692a420 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1960,6 +1960,7 @@ struct file_operations {
 				   struct file *file_out, loff_t pos_out,
 				   loff_t len, unsigned int remap_flags);
 	int (*fadvise)(struct file *, loff_t, loff_t, int);
+	struct file *(*f_real)(const struct file *);
 	int (*uring_cmd)(struct io_uring_cmd *ioucmd, unsigned int issue_flags);
 	int (*uring_cmd_iopoll)(struct io_uring_cmd *, struct io_comp_batch *,
 				unsigned int poll_flags);
diff --git a/mm/filemap.c b/mm/filemap.c
index b04be64a5069f..bead492070ed6 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -31,6 +31,7 @@
 #include <linux/hash.h>
 #include <linux/writeback.h>
 #include <linux/backing-dev.h>
+#include <linux/backing-file.h>
 #include <linux/folio_batch.h>
 #include <linux/security.h>
 #include <linux/cpuset.h>
@@ -4782,6 +4783,7 @@ SYSCALL_DEFINE4(cachestat, unsigned int, fd,
 		struct cachestat __user *, cstat, unsigned int, flags)
 {
 	CLASS(fd, f)(fd);
+	struct file *real_file;
 	struct address_space *mapping;
 	struct cachestat_range csr;
 	struct cachestat cs;
@@ -4804,11 +4806,16 @@ SYSCALL_DEFINE4(cachestat, unsigned int, fd,
 	if (flags != 0)
 		return -EINVAL;
 
+	/* The page cache of a stacked file is in its real file */
+	real_file = file_real(fd_file(f));
+	if (IS_ERR(real_file))
+		return PTR_ERR(real_file);
+
 	first_index = csr.off >> PAGE_SHIFT;
 	last_index =
 		csr.len == 0 ? ULONG_MAX : (csr.off + csr.len - 1) >> PAGE_SHIFT;
 	memset(&cs, 0, sizeof(struct cachestat));
-	mapping = fd_file(f)->f_mapping;
+	mapping = real_file->f_mapping;
 	filemap_cachestat(mapping, first_index, last_index, &cs);
 
 	if (copy_to_user(cstat, &cs, sizeof(struct cachestat)))
-- 
2.56.1

