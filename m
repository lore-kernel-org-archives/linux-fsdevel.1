Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7248533C198
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 13:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780062190; cv=none; b=ADp53W+4L18l/ODdRZax41Eh+jd/n5CiffzncuEglvEpnO/KpjVUMcysGJE6h6kkO401BFJaKI7NHSHICIylOTsGZM3DyP0bO7CNLoXN1fNkqkIxa1gEYJuhbtc+8Jp1p1VGpEYdIdkIvGCyp4u1hVGW89Ar68iYRoNrQOBTm6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780062190; c=relaxed/simple;
	bh=ue9ZThP3t/sKd+RjXyGJ45YGMm61kEycggHL/Y49230=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VopS6tbcig5p7IBloiZ55TlDPleHd+WZ3f7Bh7iSPB4TdUjBIhKlMiWA4C/CkFrcOHvLTutdHxIRJ1In3Mi/dhMzcVrxhzorLBsa//iApcHdayZ2vwCexFVmq8ARuUOXxakETjKozDDn2hxlZsaS8kngZ55PVIN8FcE4BcvOqc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GLkzkrYB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=i9kIIf16; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GLkzkrYB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="i9kIIf16"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780062187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FKTA4RCHKCz2KKA9wXNpc4hYUgAoPfVgN618I6qkEvY=;
	b=GLkzkrYBe+wsAtr+fyCDslgKM8Zrj/KIa2g8Qe17ndimqHt3Sven20xvQQoQaA1+N9EVpB
	ZJuPdpTPVeuqrRB1OqHxhi6HcxiMSa2sc289LQE+2QeNxRqVnZu2oR7iabhI2V2pSZR2Xh
	af2Hxkz+3AEjXrPaF+l9lnjLM+dOBlw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-ogH4OSopPja_ZP4rApamNw-1; Fri, 29 May 2026 09:43:05 -0400
X-MC-Unique: ogH4OSopPja_ZP4rApamNw-1
X-Mimecast-MFC-AGG-ID: ogH4OSopPja_ZP4rApamNw_1780062185
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45ef5ba50aeso190495f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 06:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780062185; x=1780666985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FKTA4RCHKCz2KKA9wXNpc4hYUgAoPfVgN618I6qkEvY=;
        b=i9kIIf16MtXWB505icW4COBHaYz5oSwgafhpMPJYYhFop+qY8tF1yZH9enoovrEXwT
         2SuFC6XqpWOZtomnmOHWE9dasaWrM+SKuiqVB+2+NXTsYjSLEGpmWJGkEQdot4wJQK4Z
         AK8Yd6BcgKQlYXfc5LUhtHNmizdD/bwTdgTJloVqfZDa6Ke0h4GXjGQ2mgRAc3WwX2C6
         xVqMyAIEJKzn44ABJMa2AvW22AGqpGuRXlIU2TtKkIvINK0AA5D9JlYKpGouvZj1eOfC
         fhsb6iVqwNrosDSGlmaMeLhE0H/lApCU850J8qx5WjEVHPEo5d45SY0Sh0qJEQA5d6oZ
         qamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780062185; x=1780666985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKTA4RCHKCz2KKA9wXNpc4hYUgAoPfVgN618I6qkEvY=;
        b=NanAuYqGijZvHK9GFnZ6uV2mELfXYmMHj4ivouIF9qUVf/r/dviFmJZzo8CG6H3IKE
         R2AD7A0jDjPP2V784iC1pYydyexSwhnlR2MOid9NW/jsTzMMXy9AU3SubfgaHaMXMVYp
         onL6pvDAv06UBdbqghRpwJP7gKK1u9/4XYZsIbms2Mrspoabz7glszWD85qV8+I1nnLF
         nEbB2v5uzqqPCAcCdyaUCOngBWgDzSCp9orCYCJMnUYm1fJMBxS4fjj4wiU/B0dDifhw
         x8yeKvDLh5/lytz7Np0Nm+I9YHmLJR29AjpFRqyUi9Jw0QhAqeBrgp+jfWlbRuf30nEM
         NgDw==
X-Forwarded-Encrypted: i=1; AFNElJ8T+8NPg5B4SvUffZjm/3YEld3n63QNM2OWGRKguNirscTaxRCDlztWcHgbPJfFKMHEP98zqB/75zogB76v@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+dYNjRPg/yGQKoV6ZAl/A7GCfcsJbS2exkKSQTi6hRXODrKrd
	inc+pWHjlHS3eAXMRizNDWoUQd+Q1XLJZylw/uUVp35EnmBnlHctBEKMeUBobbh+tLQF5tZNxm2
	6VvnSh+FvQx4s1ZEMgOQdyybsbZSEDosMdZ2Ic9mca2/UcNu5rHpsMhBVo4OqtzqZGtPMCMN43C
	k=
X-Gm-Gg: Acq92OHzMRJ+PUePRbDXxV4BwtU4rG5/0hdHdBclL9WcmYoi4SzRn6JETt4ZgglDU3L
	r5DTxZM0+ED8nOkJfm/6igZXOKxRFPVpO2J9eXlU1SKiNoHbTV6K95seAaWFILe2ptC38vyogK9
	Z1tb6MSLj9jo1rhEn6mgYNF6sNRFoi2CyxpOlVtkvEnLtWhVe3oAddtVMJVdxDDtBUDRuHApj+o
	FQqeZr5EuPnY4kuMos8NjsQdTCgQB2WCZEbkS7erFCVn4WzSoz2P/U5JXaGyBuZaKGVthbUvgmO
	jSv4fOGpzW8CzOyI7roc5HrOwdFUzjyHfLU76BH5HZv16BalZzF2+MhWKZLzTYqzhqY5Rdo/7pB
	PdW2qLuefwxtVnq3B2cJ8Z588ekSa7IyPVgCO60iE1NvXpWU3KVqyRU1/uAj1vNlKp7e3mc/hMr
	2QHTTmP1S1L4s=
X-Received: by 2002:a5d:5f54:0:b0:45e:ce49:43e7 with SMTP id ffacd0b85a97d-45ef1412e75mr5881557f8f.15.1780062184362;
        Fri, 29 May 2026 06:43:04 -0700 (PDT)
X-Received: by 2002:a5d:5f54:0:b0:45e:ce49:43e7 with SMTP id ffacd0b85a97d-45ef1412e75mr5881488f8f.15.1780062183814;
        Fri, 29 May 2026 06:43:03 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (78-131-46-194.pool.digikabel.hu. [78.131.46.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef357635fsm3587276f8f.33.2026.05.29.06.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 06:43:03 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: John Groves <john@groves.net>
Cc: fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] famfs: FUSE_GET_DAXDEV -> FUSE_DEV_IOC_BACKING_OPEN
Date: Fri, 29 May 2026 15:43:01 +0200
Message-ID: <20260529134302.1989958-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The difference is that now the server needs to look at the fmap and check
if any new device needs registering, the device index is now allocated by
the kernel and returned by the ioctl().

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
This is the first part of what we were talking about: using the backing
file API for dax devices.

It's on top of the famfs-v10 patchset.

Totally untested, haven't even tried booting it.  Obviously needs
nontrivial conversion in the server code as well.

Thanks,
Miklos

fs/fuse/Kconfig           |   1 +
 fs/fuse/backing.c         |  28 ++-
 fs/fuse/famfs.c           | 346 ++++++++++----------------------------
 fs/fuse/famfs_kfmap.h     |   2 -
 fs/fuse/fuse_i.h          |  25 +--
 fs/fuse/inode.c           |   7 +-
 include/uapi/linux/fuse.h |   8 +-
 7 files changed, 123 insertions(+), 294 deletions(-)

diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
index 17fe1f490cbd..8dbd6663808e 100644
--- a/fs/fuse/Kconfig
+++ b/fs/fuse/Kconfig
@@ -79,6 +79,7 @@ config FUSE_IO_URING
 
 config FUSE_FAMFS_DAX
 	bool "FUSE support for fs-dax filesystems backed by devdax"
+	select FUSE_PASSTHROUGH
 	depends on FUSE_FS
 	depends on DEV_DAX_FSDEV
 	default FUSE_FS
diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index d95dfa48483f..e56b7f8d5d2b 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -37,14 +37,14 @@ void fuse_backing_files_init(struct fuse_conn *fc)
 	idr_init(&fc->backing_files_map);
 }
 
-static int fuse_backing_id_alloc(struct fuse_conn *fc, struct fuse_backing *fb)
+int fuse_backing_id_alloc(struct fuse_conn *fc, void *obj)
 {
 	int id;
 
 	idr_preload(GFP_KERNEL);
 	spin_lock(&fc->lock);
 	/* FIXME: xarray might be space inefficient */
-	id = idr_alloc_cyclic(&fc->backing_files_map, fb, 1, 0, GFP_ATOMIC);
+	id = idr_alloc_cyclic(&fc->backing_files_map, obj, 1, 0, GFP_ATOMIC);
 	spin_unlock(&fc->lock);
 	idr_preload_end();
 
@@ -75,7 +75,10 @@ static int fuse_backing_id_free(int id, void *p, void *data)
 
 void fuse_backing_files_free(struct fuse_conn *fc)
 {
-	idr_for_each(&fc->backing_files_map, fuse_backing_id_free, NULL);
+	if (fc->famfs_iomap)
+		famfs_teardown(fc);
+	else
+		idr_for_each(&fc->backing_files_map, fuse_backing_id_free, NULL);
 	idr_destroy(&fc->backing_files_map);
 }
 
@@ -88,13 +91,23 @@ int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
 
 	pr_debug("%s: fd=%d flags=0x%x\n", __func__, map->fd, map->flags);
 
+	if (map->padding)
+		return -EINVAL;
+
+	if (fc->famfs_iomap) {
+		if (map->flags != FUSE_BACKING_DAXDEV)
+			return -EINVAL;
+
+		return famfs_daxdev_open(fc, map);
+	}
+
 	/* TODO: relax CAP_SYS_ADMIN once backing files are visible to lsof */
 	res = -EPERM;
 	if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
 		goto out;
 
 	res = -EINVAL;
-	if (map->flags || map->padding)
+	if (map->flags)
 		goto out;
 
 	file = fget_raw(map->fd);
@@ -144,6 +157,10 @@ int fuse_backing_close(struct fuse_conn *fc, int backing_id)
 
 	pr_debug("%s: backing_id=%d\n", __func__, backing_id);
 
+	/* No close for dax device (yet) */
+	if (fc->famfs_iomap)
+		return -EINVAL;
+
 	/* TODO: relax CAP_SYS_ADMIN once backing files are visible to lsof */
 	err = -EPERM;
 	if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
@@ -170,6 +187,9 @@ struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc, int backing_id)
 {
 	struct fuse_backing *fb;
 
+	if (fc->famfs_iomap)
+		return NULL;
+
 	rcu_read_lock();
 	fb = idr_find(&fc->backing_files_map, backing_id);
 	fb = fuse_backing_get(fb);
diff --git a/fs/fuse/famfs.c b/fs/fuse/famfs.c
index 121ed74e9727..c49362d19b36 100644
--- a/fs/fuse/famfs.c
+++ b/fs/fuse/famfs.c
@@ -23,15 +23,15 @@
 #include "fuse_i.h"
 
 static void famfs_set_daxdev_err(
-	struct fuse_conn *fc, struct dax_device *dax_devp);
+	struct famfs_daxdev *dd, struct dax_device *dax_devp);
 
 static int
 famfs_dax_notify_failure(struct dax_device *dax_devp, u64 offset,
 			u64 len, int mf_flags)
 {
-	struct fuse_conn *fc = dax_holder(dax_devp);
+	struct famfs_daxdev *dd = dax_holder(dax_devp);
 
-	famfs_set_daxdev_err(fc, dax_devp);
+	famfs_set_daxdev_err(dd, dax_devp);
 
 	return 0;
 }
@@ -51,6 +51,26 @@ static const struct address_space_operations famfs_dax_aops = {
 
 /*****************************************************************************/
 
+static void famfs_daxdev_free(struct famfs_daxdev *dd)
+{
+	/* Only call fs_put_dax if fs_dax_get succeeded */
+	if (dd->devp) {
+		if (!dd->dax_err)
+			fs_put_dax(dd->devp, dd);
+		put_dax(dd->devp);
+	}
+	kfree(dd->name);
+	kfree(dd);
+}
+
+DEFINE_FREE(famfs_daxdev_free, struct famfs_daxdev *, if (_T) famfs_daxdev_free(_T));
+
+static int famfs_devidx_free(int id, void *p, void *data)
+{
+	famfs_daxdev_free(p);
+	return 0;
+}
+
 /*
  * famfs_teardown()
  *
@@ -59,263 +79,90 @@ static const struct address_space_operations famfs_dax_aops = {
 void
 famfs_teardown(struct fuse_conn *fc)
 {
-	struct famfs_dax_devlist *devlist __free(kfree) = fc->dax_devlist;
-	int i;
-
-	fc->dax_devlist = NULL;
-
-	if (!devlist)
-		return;
-
-	if (!devlist->devlist)
-		return;
-
-	/* Close & release all the daxdevs in our table */
-	for (i = 0; i < devlist->nslots; i++) {
-		struct famfs_daxdev *dd = &devlist->devlist[i];
-
-		if (!dd->valid)
-			continue;
-
-		/* Only call fs_put_dax if fs_dax_get succeeded */
-		if (dd->devp) {
-			if (!dd->dax_err)
-				fs_put_dax(dd->devp, fc);
-			put_dax(dd->devp);
-		}
-
-		kfree(dd->name);
-	}
-	kfree(devlist->devlist);
+	idr_for_each(&fc->backing_files_map, famfs_devidx_free,  NULL);
 }
 
 static int
-famfs_verify_daxdev(const char *pathname, dev_t *devno)
+famfs_verify_daxdev(const struct path *path, dev_t *devno)
 {
-	struct inode *inode;
-	struct path path;
-	int err;
+	struct inode *inode = d_inode(path->dentry);
 
-	if (!pathname || !*pathname)
+	if (!S_ISCHR(inode->i_mode))
 		return -EINVAL;
 
-	err = kern_path(pathname, LOOKUP_FOLLOW, &path);
-	if (err)
-		return err;
-
-	inode = d_backing_inode(path.dentry);
-	if (!S_ISCHR(inode->i_mode)) {
-		err = -EINVAL;
-		goto out_path_put;
-	}
-
-	if (!may_open_dev(&path)) { /* had to export this */
-		err = -EACCES;
-		goto out_path_put;
-	}
+	if (!may_open_dev(path)) /* had to export this */
+		return -EACCES;
 
 	*devno = inode->i_rdev;
 
-out_path_put:
-	path_put(&path);
-	return err;
+	return 0;
 }
 
-/**
- * famfs_fuse_get_daxdev() - Retrieve info for a DAX device from fuse server
- *
- * Send a GET_DAXDEV message to the fuse server to retrieve info on a
- * dax device.
- *
- * @fm:     fuse_mount
- * @index:  the index of the dax device; daxdevs are referred to by index
- *          in fmaps, and the server resolves the index to a particular daxdev
- *
- * Returns: 0=success
- *          -errno=failure
- */
-static int
-famfs_fuse_get_daxdev(struct fuse_mount *fm, const u64 index)
+static int famfs_fuse_get_daxdev(const struct path *path, struct famfs_daxdev *dd)
 {
-	struct fuse_daxdev_out daxdev_out = { 0 };
-	struct fuse_conn *fc = fm->fc;
-	struct famfs_daxdev *daxdev;
 	int rc;
 
-	FUSE_ARGS(args);
-
-	/* Store the daxdev in our table */
-	if (index >= fc->dax_devlist->nslots) {
-		pr_err("%s: index(%lld) > nslots(%d)\n",
-		       __func__, index, fc->dax_devlist->nslots);
-		return -EINVAL;
-	}
-
-	args.opcode = FUSE_GET_DAXDEV;
-	args.nodeid = index;
-
-	args.in_numargs = 0;
-
-	args.out_numargs = 1;
-	args.out_args[0].size = sizeof(daxdev_out);
-	args.out_args[0].value = &daxdev_out;
-
-	/* Send GET_DAXDEV command */
-	rc = fuse_simple_request(fm, &args);
+	/* Verify dev is valid and can be opened and gets the devno */
+	rc = famfs_verify_daxdev(path, &dd->devno);
 	if (rc) {
-		pr_err("%s: rc=%d from fuse_simple_request()\n",
-		       __func__, rc);
-		/* Error will be that the payload is smaller than FMAP_BUFSIZE,
-		 * which is the max we can handle. Empty payload handled below.
-		 */
+		pr_err("%s: rc=%d from famfs_verify_daxdev()\n", __func__, rc);
 		return rc;
 	}
 
-	scoped_guard(rwsem_write, &fc->famfs_devlist_sem) {
-		daxdev = &fc->dax_devlist->devlist[index];
-
-		/* Abort if daxdev is now valid (races are possible here) */
-		if (daxdev->valid) {
-			pr_debug("%s: daxdev already known\n", __func__);
-			return 0;
-		}
-
-		/* Verify dev is valid and can be opened and gets the devno */
-		rc = famfs_verify_daxdev(daxdev_out.name, &daxdev->devno);
-		if (rc) {
-			pr_err("%s: rc=%d from famfs_verify_daxdev()\n",
-			       __func__, rc);
-			return rc;
-		}
-
-		daxdev->name = kstrdup(daxdev_out.name, GFP_KERNEL);
-		if (!daxdev->name)
-			return -ENOMEM;
+	dd->name = kasprintf(GFP_KERNEL, "%pd4", path->dentry);
+	if (!dd->name)
+		return -ENOMEM;
 
-		/* This will fail if it's not a dax device */
-		daxdev->devp = dax_dev_get(daxdev->devno);
-		if (!daxdev->devp) {
-			pr_warn("%s: device %s not found or not dax\n",
-				__func__, daxdev_out.name);
-			kfree(daxdev->name);
-			daxdev->name = NULL;
+	/* This will fail if it's not a dax device */
+	dd->devp = dax_dev_get(dd->devno);
+	if (!dd->devp) {
+		pr_warn("%s: device %s not found or not dax\n",__func__, dd->name);
+			kfree(dd->name);
+			dd->name = NULL;
 			return -ENODEV;
 		}
 
-		rc = fs_dax_get(daxdev->devp, fc, &famfs_fuse_dax_holder_ops);
-		if (rc) {
-			/* Mark as valid with dax_err to prevent retry loop.
-			 * famfs_dax_err() will return -EIO on access attempts.
-			 * Teardown handles this case: skips fs_put_dax, calls put_dax.
-			 */
-			daxdev->dax_err = 1;
-			pr_err("%s: fs_dax_get(%lld) failed\n",
-			       __func__, (u64)daxdev->devno);
-		}
-
-		wmb(); /* All other fields must be visible before valid */
-		daxdev->valid = 1;
+	rc = fs_dax_get(dd->devp, dd, &famfs_fuse_dax_holder_ops);
+	if (rc) {
+		/* Mark as valid with dax_err to prevent retry loop.
+		 * famfs_dax_err() will return -EIO on access attempts.
+		 * Teardown handles this case: skips fs_put_dax, calls put_dax.
+		 */
+		dd->dax_err = 1;
+		pr_err("%s: fs_dax_get(%lld) failed\n", __func__, (u64)dd->devno);
 	}
 
 	return 0;
 }
 
-/**
- * famfs_update_daxdev_table() - Update the daxdev table
- * @fm:   fuse_mount
- * @meta: famfs_file_meta, in-memory format, built from a GET_FMAP response
- *
- * This function is called for each new file fmap, to verify whether all
- * referenced daxdevs are already known (i.e. in the table). Any daxdev
- * indices referenced in @meta but not in the table will be retrieved via
- * famfs_fuse_get_daxdev() and added to the table
- *
- * Return: 0=success
- *         -errno=failure
- */
-static int
-famfs_update_daxdev_table(
-	struct fuse_mount *fm,
-	const struct famfs_file_meta *meta)
+int famfs_daxdev_open(struct fuse_conn *fc, struct fuse_backing_map *map)
 {
-	struct famfs_dax_devlist *local_devlist;
-	struct fuse_conn *fc = fm->fc;
-	int indices_to_fetch[MAX_DAXDEVS];
-	int n_to_fetch = 0;
-	int err;
-
-	/* First time through we will need to allocate the dax_devlist */
-	if (!fc->dax_devlist) {
-		local_devlist = kcalloc(1, sizeof(*fc->dax_devlist), GFP_KERNEL);
-		if (!local_devlist)
-			return -ENOMEM;
-
-		local_devlist->nslots = MAX_DAXDEVS;
-
-		local_devlist->devlist = kcalloc(MAX_DAXDEVS,
-						 sizeof(struct famfs_daxdev),
-						 GFP_KERNEL);
-		if (!local_devlist->devlist) {
-			kfree(local_devlist);
-			return -ENOMEM;
-		}
-
-		/* We don't need famfs_devlist_sem here because we use cmpxchg */
-		if (cmpxchg(&fc->dax_devlist, NULL, local_devlist) != NULL) {
-			kfree(local_devlist->devlist);
-			kfree(local_devlist); /* another thread beat us to it */
-		}
-	}
+	struct famfs_daxdev *dd __free(famfs_daxdev_free) = kzalloc_obj(*dd);
+	int rc;
 
-	/* Collect indices that need fetching while holding read lock */
-	scoped_guard(rwsem_read, &fc->famfs_devlist_sem) {
-		unsigned long i;
+	CLASS(fd_raw, f)(map->fd);
+	if (fd_empty(f))
+		return -EBADF;
 
-		for_each_set_bit(i, (unsigned long *)&meta->dev_bitmap, MAX_DAXDEVS) {
-			if (!(fc->dax_devlist->devlist[i].valid))
-				indices_to_fetch[n_to_fetch++] = i;
-		}
-	}
+	rc = famfs_fuse_get_daxdev(&fd_file(f)->f_path, dd);
+	if (rc)
+		return rc;
 
-	/* Fetch needed daxdevs outside the read lock */
-	for (int j = 0; j < n_to_fetch; j++) {
-		err = famfs_fuse_get_daxdev(fm, indices_to_fetch[j]);
-		if (err)
-			pr_err("%s: failed to get daxdev=%d\n",
-			       __func__, indices_to_fetch[j]);
-	}
+	rc = fuse_backing_id_alloc(fc, dd);
+	if (rc >= 0)
+		retain_and_null_ptr(dd);
 
-	return 0;
+	return rc;
 }
 
 static void
 famfs_set_daxdev_err(
-	struct fuse_conn *fc,
-	struct dax_device *dax_devp)
+	struct famfs_daxdev *dd, struct dax_device *dax_devp)
 {
-	int i;
-
-	/* Gotta search the list by dax_devp;
-	 * read lock because we're not adding or removing daxdev entries
-	 */
-	scoped_guard(rwsem_write, &fc->famfs_devlist_sem) {
-		for (i = 0; i < fc->dax_devlist->nslots; i++) {
-			if (fc->dax_devlist->devlist[i].valid) {
-				struct famfs_daxdev *dd;
-
-				dd = &fc->dax_devlist->devlist[i];
-				if (dd->devp != dax_devp)
-					continue;
 
-				dd->error = true;
+	dd->error = true;
 
-				pr_err("%s: memory error on daxdev %s (%d)\n",
-				       __func__, dd->name, i);
-				return;
-			}
-		}
-	}
-	pr_err("%s: memory err on unrecognized daxdev\n", __func__);
+	pr_err("%s: memory error on daxdev %s\n", __func__, dd->name);
 }
 
 /***************************************************************************/
@@ -447,9 +294,6 @@ famfs_fuse_meta_alloc(
 			meta->se[i].ext_offset = se_in[i].se_offset;
 			meta->se[i].ext_len    = se_in[i].se_len;
 
-			/* Record bitmap of referenced daxdev indices */
-			meta->dev_bitmap |= (1 << meta->se[i].dev_index);
-
 			errs += famfs_check_ext_alignment(&meta->se[i]);
 
 			extent_total += meta->se[i].ext_len;
@@ -545,9 +389,6 @@ famfs_fuse_meta_alloc(
 				strips_out[j].ext_offset = offset;
 				strips_out[j].ext_len    = len;
 
-				/* Record bitmap of referenced daxdev indices */
-				meta->dev_bitmap |= (1 << devindex);
-
 				extent_total += len;
 				errs += famfs_check_ext_alignment(&strips_out[j]);
 				size_remainder -= len;
@@ -603,7 +444,7 @@ famfs_fuse_meta_alloc(
  * Return: 0=success
  *          -errno=failure
  */
-int
+static int
 famfs_file_init_dax(
 	struct fuse_mount *fm,
 	struct inode *inode,
@@ -625,9 +466,6 @@ famfs_file_init_dax(
 	if (rc)
 		goto errout;
 
-	/* Make sure this fmap doesn't reference any unknown daxdevs */
-	famfs_update_daxdev_table(fm, meta);
-
 	/* Publish the famfs metadata on fi->famfs_meta */
 	inode_lock(inode);
 
@@ -662,11 +500,6 @@ static int famfs_file_bad(struct inode *inode);
 
 static int famfs_dax_err(struct famfs_daxdev *dd)
 {
-	if (!dd->valid) {
-		pr_err("%s: daxdev=%s invalid\n",
-		       __func__, dd->name);
-		return -EIO;
-	}
 	if (dd->dax_err) {
 		pr_err("%s: daxdev=%s dax_err\n",
 		       __func__, dd->name);
@@ -680,6 +513,18 @@ static int famfs_dax_err(struct famfs_daxdev *dd)
 	return 0;
 }
 
+static struct famfs_daxdev *
+famfs_daxdev_lookup(struct fuse_conn *fc, int devidx)
+{
+	struct famfs_daxdev *dd;
+
+	rcu_read_lock();
+	dd = idr_find(&fc->backing_files_map, devidx);
+	rcu_read_unlock();
+
+	return dd;
+}
+
 static int
 famfs_interleave_fileofs_to_daxofs(struct inode *inode, struct iomap *iomap,
 			 loff_t file_offset, off_t len, unsigned int flags)
@@ -730,21 +575,13 @@ famfs_interleave_fileofs_to_daxofs(struct inode *inode, struct iomap *iomap,
 			u64 strip_devidx = fei->ie_strips[strip_num].dev_index;
 			int rc;
 
-			if (strip_devidx >= fc->dax_devlist->nslots) {
-				pr_err("%s: strip_devidx %llu >= nslots %d\n",
-				       __func__, strip_devidx,
-				       fc->dax_devlist->nslots);
-				goto err_out;
-			}
-
-			if (!fc->dax_devlist->devlist[strip_devidx].valid) {
+			dd = famfs_daxdev_lookup(fc, strip_devidx);
+			if (!dd) {
 				pr_err("%s: daxdev=%lld invalid\n", __func__,
 					strip_devidx);
 				goto err_out;
 			}
 
-			dd = &fc->dax_devlist->devlist[strip_devidx];
-
 			rc = famfs_dax_err(dd);
 			if (rc) {
 				/* Shut down access to this file */
@@ -756,7 +593,7 @@ famfs_interleave_fileofs_to_daxofs(struct inode *inode, struct iomap *iomap,
 			iomap->offset  = file_offset;
 			iomap->length  = min_t(loff_t, len, chunk_remainder);
 
-			iomap->dax_dev = fc->dax_devlist->devlist[strip_devidx].devp;
+			iomap->dax_dev = dd->devp;
 
 			iomap->type    = IOMAP_MAPPED;
 			iomap->flags   = flags;
@@ -815,11 +652,6 @@ famfs_fileofs_to_daxofs(struct inode *inode, struct iomap *iomap,
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	loff_t local_offset = file_offset;
 
-	if (!fc->dax_devlist) {
-		pr_err("%s: null dax_devlist\n", __func__);
-		goto err_out;
-	}
-
 	if (famfs_file_bad(inode))
 		goto err_out;
 
@@ -851,15 +683,13 @@ famfs_fileofs_to_daxofs(struct inode *inode, struct iomap *iomap,
 			struct famfs_daxdev *dd;
 			int rc;
 
-			if (daxdev_idx >= fc->dax_devlist->nslots) {
-				pr_err("%s: daxdev_idx %llu >= nslots %d\n",
-				       __func__, daxdev_idx,
-				       fc->dax_devlist->nslots);
+			dd = famfs_daxdev_lookup(fc, daxdev_idx);
+			if (!dd) {
+				pr_err("%s: daxdev=%lld invalid\n", __func__,
+					daxdev_idx);
 				goto err_out;
 			}
 
-			dd = &fc->dax_devlist->devlist[daxdev_idx];
-
 			rc = famfs_dax_err(dd);
 			if (rc) {
 				/* Shut down access to this file */
@@ -884,7 +714,7 @@ famfs_fileofs_to_daxofs(struct inode *inode, struct iomap *iomap,
 			iomap->offset  = file_offset;
 			iomap->length  = min_t(loff_t, len, ext_len_remainder);
 
-			iomap->dax_dev = fc->dax_devlist->devlist[daxdev_idx].devp;
+			iomap->dax_dev = dd->devp;
 
 			iomap->type    = IOMAP_MAPPED;
 			iomap->flags   = flags;
diff --git a/fs/fuse/famfs_kfmap.h b/fs/fuse/famfs_kfmap.h
index 970ad802b492..3f72ae8e4696 100644
--- a/fs/fuse/famfs_kfmap.h
+++ b/fs/fuse/famfs_kfmap.h
@@ -124,7 +124,6 @@ struct famfs_file_meta {
 	enum famfs_file_type   file_type;
 	size_t                 file_size;
 	enum famfs_extent_type fm_extent_type;
-	u64 dev_bitmap; /* bitmap of referenced daxdevs by index */
 	union {
 		struct {
 			size_t         fm_nextents;
@@ -145,7 +144,6 @@ struct famfs_file_meta {
  */
 struct famfs_daxdev {
 	/* Include dev uuid? */
-	bool valid;
 	bool error; /* Dax has reported a memory error (probably poison) */
 	bool dax_err; /* fs_dax_get() failed */
 	dev_t devno;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index dcbeaceda918..adc88a8681e2 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1006,11 +1006,6 @@ struct fuse_conn {
 		/* Request timeout (in jiffies). 0 = no timeout */
 		unsigned int req_timeout;
 	} timeout;
-
-#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
-	struct rw_semaphore famfs_devlist_sem;
-	struct famfs_dax_devlist *dax_devlist;
-#endif
 };
 
 /*
@@ -1572,6 +1567,7 @@ void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 struct fuse_backing *fuse_backing_get(struct fuse_backing *fb);
 void fuse_backing_put(struct fuse_backing *fb);
 struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc, int backing_id);
+int fuse_backing_id_alloc(struct fuse_conn *fc, void *obj);
 #else
 
 static inline struct fuse_backing *fuse_backing_get(struct fuse_backing *fb)
@@ -1647,22 +1643,14 @@ extern void fuse_sysctl_unregister(void);
 /* famfs.c */
 
 #if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
-int famfs_file_init_dax(struct fuse_mount *fm,
-			struct inode *inode, void *fmap_buf,
-			size_t fmap_size);
 ssize_t famfs_fuse_write_iter(struct kiocb *iocb, struct iov_iter *from);
 ssize_t famfs_fuse_read_iter(struct kiocb *iocb, struct iov_iter	*to);
 int famfs_fuse_mmap(struct file *file, struct vm_area_struct *vma);
 void __famfs_meta_free(void *map);
 
+int famfs_daxdev_open(struct fuse_conn *fc, struct fuse_backing_map *map);
 void famfs_teardown(struct fuse_conn *fc);
 
-/* Set fi->famfs_meta = NULL regardless of prior value */
-static inline void famfs_meta_init(struct fuse_inode *fi)
-{
-	fi->famfs_meta = NULL;
-}
-
 /* Set fi->famfs_meta iff the current value is NULL */
 static inline struct fuse_backing *famfs_meta_set(struct fuse_inode *fi,
 						  void *meta)
@@ -1678,11 +1666,6 @@ static inline void famfs_meta_free(struct fuse_inode *fi)
 	}
 }
 
-static inline void famfs_init_devlist_sem(struct fuse_conn *fc)
-{
-	init_rwsem(&fc->famfs_devlist_sem);
-}
-
 static inline int fuse_file_famfs(struct fuse_inode *fi)
 {
 	return (READ_ONCE(fi->famfs_meta) != NULL);
@@ -1736,6 +1719,10 @@ fuse_get_fmap(struct fuse_mount *fm, struct inode *inode)
 	return 0;
 }
 
+static inline int famfs_daxdev_open(struct fuse_conn *fc, struct fuse_backing_map *map)
+{
+	return -EINVAL;
+}
 #endif /* CONFIG_FUSE_FAMFS_DAX */
 
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 40e7ea5b6437..5e692fc84297 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1048,9 +1048,6 @@ void fuse_conn_put(struct fuse_conn *fc)
 		WARN_ON(atomic_read(&bucket->count) != 1);
 		kfree(bucket);
 	}
-	if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX))
-		famfs_teardown(fc);
-
 	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
 		fuse_backing_files_free(fc);
 	call_rcu(&fc->rcu, delayed_release);
@@ -1480,10 +1477,8 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 				u64 in_flags = FIELD_PREP(GENMASK_ULL(63, 32), ia->in.flags2)
 						| ia->in.flags;
 
-				if (in_flags & FUSE_DAX_FMAP) {
-					famfs_init_devlist_sem(fc);
+				if (in_flags & FUSE_DAX_FMAP)
 					fc->famfs_iomap = 1;
-				}
 			}
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 1b82895108be..d6e8dc75c8a1 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -248,7 +248,6 @@
  *    - struct fuse_famfs_iext
  *    - struct fuse_famfs_fmap_header
  *  - Add the following structs for the GET_DAXDEV message and reply
- *    - struct fuse_get_daxdev_in
  *    - struct fuse_get_daxdev_out
  *  - Add the following enumerated types
  *    - enum fuse_famfs_file_type
@@ -1145,6 +1144,9 @@ struct fuse_notify_prune_out {
 	uint64_t	spare;
 };
 
+/* Backing is a dax device */
+#define FUSE_BACKING_DAXDEV	(1 << 0)
+
 struct fuse_backing_map {
 	int32_t		fd;
 	uint32_t	flags;
@@ -1373,10 +1375,6 @@ struct fuse_famfs_fmap_header {
 	uint64_t reserved1;
 };
 
-struct fuse_get_daxdev_in {
-	uint32_t        daxdev_num;
-};
-
 #define DAXDEV_NAME_MAX 256
 
 /* fuse_daxdev_out has enough space for a uuid if we need it */
-- 
2.54.0

