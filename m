Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F8B349CCD
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 23:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784070357; cv=none; b=Lmi5pQudpEPuRYLgpGWrQ2+cKpABKKXFZ7veUDzsaRtxAsK33AANS/O1iPmGOEOW4otkYZd2g4bADvGoRt8SF+4+0wVcAyvZUnYb0IuVF3HYOm4V9riUmGeOgv42aL7uqKdnMnVYcQ/wIPkykfxQRLl17PDmR0gqJqyZ+AMbBMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784070357; c=relaxed/simple;
	bh=bI7Fu7+m4Y4paeZeRm+9DvalA4qZf1f/fYVH/Aaw6n8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mkHQL/piI+o9TK81LmBRHtybIwmcDOGWJ27iQrGpKleytOR2XSfEu/ozZwh8BUsuSubduP4zC/hlwm7mvp9hj5TwQ/tF+TEmqFRPc0S39pJiNZRcpfU2Hbp3JtETCDbrCgOy/7EdO4nRfz0udAW21NcltpxuV6bSeiRmtLEqPSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=D6gH1bgB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iacm9jgi; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="D6gH1bgB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iacm9jgi"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D92027A0157;
	Tue, 14 Jul 2026 19:05:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 14 Jul 2026 19:05:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1784070350;
	 x=1784156750; bh=40XiNEdAzh1eFu4Ly1xdPF5oTxAkThXBFBTECpiedog=; b=
	D6gH1bgBfCYXkhdBWfTZ1LaxMi9ia0CNOhBk3WlSWXjwb5rxxg/+FZJpvp3/8/ZO
	J+yeJLV54A7mB2Tl2j5cZwo2WufGVkmYkVJ88nDmtmrMfZdzKy1dO6wNi93OEUY1
	I1FausSoygk9YL9HHzu3VGU9oasnqRDKeJKomLc6w2iRQUBOO3essuz/3r89/JLf
	4mfPutC567NmdVNHy1EkJt/gkBbPBa0eh9izLTjoJZAk5CwG5Hl5vVEbDKC5bfFf
	xHkpV+qB4w0rHrdO5vlH8xjMhRuFseJ7FdyZza/bmOOnEa7BpluQeaIb9tkF5BPk
	TwI8N+deNQKCVj47yVrIBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1784070350; x=1784156750; bh=4
	0XiNEdAzh1eFu4Ly1xdPF5oTxAkThXBFBTECpiedog=; b=iacm9jgiOqEFjxs1j
	+vmrMxOiJFBxFuGkOD2EdDLrPcmfTg+Qmuq5/whmC5WhsnuFVMHUX1sdYDX8EJbv
	xEQ6mnDwc8IdjgxzCgpszPwgM7nOlAyHrJ1TJfIaM5sVtfeLjh0barBKWIa1nWhq
	UpFOgEoP8KJXkCb9zxhDH5AFvxgFrAKJ+LhcqTFNimS6LQPbzyrvwxmWy+qlim2s
	tpQHlO35zLO0yKLKekvAirftwMzi5FZ5acUzirS3/AQpXFKyCr6LK1OlCZpOLOn0
	3E1kXAiFicG5PuZm0Y8n18PiAFeQq/+7T3pWEPS9wcmn3F/Fj8Hx5D/6izLo5Lcy
	oc5Qg==
X-ME-Sender: <xms:zsBWapj9waJglPEMdW5qFQNoVtZijFPnup7KBY-NTm-2WzzUOSAIgQ>
    <xme:zsBWam_jizKXTN_VNPcDtUaIJZjceAi2SybwES0AUe2Hgu6b0Ajr_ThujBPpYR_CT
    GgSBwjBd7WfP4Ukmv3Kt4pzQaRAejcJOI7z6NVGyy_vexaFKg>
X-ME-Received: <xmr:zsBWakrYcnazmDMnymxmxPGe82hAd1KVPgDA72I1Dp8NJ7NLjIRGKp4Q9FIIzYqLJ_aYOjSHky-L-YgS8PWlkwCMs0bbZrk>
X-ME-Proxy-Cause: dmFkZTFqP8WqiBJdtOa2hcfBQxjE9popyOicxtbV07MXFh/bu9T+iEb2GHQ65Mn/QQr6QH
    VQSYmX1hcI4+EPJF+4tELj1f8pNYv0yrtyuRNWSAxG6472jQ9vH1SIFCLLeHuKq84JDVso
    5gFlonpuTM9JPncfNbTnC0dZn7dRXqYWsCF/yjOenBrnyElgDGgIg9iMtAJBKckf9J54rP
    kYnLPoo6axfaUIlHHQTbAeqL4tm6cS5eJADIZJBMqpcFqOg+CkTfEBm6Dsdkxm+mtA8YJX
    RK0EBEXfyh75YXIksEDCCbePN3vRU0gGblpCiV2Js8UQlHNDX8+d6yP6Stqa1cFQM56vot
    /BM32xKYXvh1/zU0YnEkpXjKUW3UueAuFDSofgP+ASHTgunaRr5ymZqqL5VBfUnCfiPGAh
    grYEZqpcwGijrgcDai06gONPfSwSmreIHeiHFhS3NKfcEZeWHVQkjSejM7tYXiylkakiAQ
    7LTP6FeTNR7alETS9YtN+nyiN2ENgylFaseXWAzQMdk4Y3SyDsZ+1wGaLcrx407iGyFk2b
    G/Y2vvpYdf8V3bxi1+Uag/sDCNvb3l0k9wmx0QW1g84OAIYOcx1ayUE04VNgLheSc0BYi+
    TwS853hFd0KQ/xV2VaQs8RCSoBlZn1KE2TKbTp4yKfRvW1bk2N0TcxT1YwwA
X-ME-Proxy: <xmx:zsBWauXU4SRQFuLInr5lmqZ82aPp1OiPfGnoCTBwCk5Zm6aA8I4Aaw>
    <xmx:zsBWajC-TLslssuCiuyr-m1w26htD_Dhqh42MPLAq3odsRCkdxj-Hg>
    <xmx:zsBWai2KuYo3FnYs4JQ5sfQkHR16WIvUxcTsyGMgqGBbYKknOpNelg>
    <xmx:zsBWal0SFpH0Vb3Zo4CZrWkN7OpUOZ4HaupkTjhxL3d0ve8Cq4yFAw>
    <xmx:zsBWajeZ4STd5TKJpUGb8CNmRkXqCrXBvCZrS5oCYBgy202NcRZhdZwt>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jul 2026 19:05:48 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v4 1/3] VFS: move mnt_want_write() and locking into lookup_open()
Date: Wed, 15 Jul 2026 09:04:12 +1000
Message-ID: <20260714230534.776886-2-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260714230534.776886-1-neilb@ownmail.net>
References: <20260714230534.776886-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

The mnt_want_write() call and the parent inode locking in
open_last_lookups() are only needed for lookup_open().  So we can move
them and all the got_write handling into lookup_open().

Note that we need to also check create_error when determining whether to
unlock shared or not, as O_CREAT can be cleared, but create_error is
only set of O_CREAT was set.

The fsnotify calls come too as they must be in the locked region.

Also use the existing dir_inode uniformly for dir->d_inode.

This is a step towards exporting an better "open/create" interface to nfsd.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c | 77 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 41 insertions(+), 36 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 7ead3db55be2..55404fe0e269 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4398,7 +4398,7 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
  */
 static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 				  const struct open_flags *op,
-				  bool got_write, struct delegated_inode *delegated_inode)
+				  struct delegated_inode *delegated_inode)
 {
 	struct mnt_idmap *idmap;
 	struct dentry *dir = nd->path.dentry;
@@ -4407,9 +4407,25 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	struct dentry *dentry;
 	int error, create_error = 0;
 	umode_t mode = op->mode;
+	bool got_write = false;
 
-	if (unlikely(IS_DEADDIR(dir_inode)))
-		return ERR_PTR(-ENOENT);
+	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
+		got_write = !mnt_want_write(nd->path.mnt);
+		/*
+		 * do _not_ fail yet - we might not need that or fail with
+		 * a different error; let lookup_open() decide; we'll be
+		 * dropping this one anyway.
+		 */
+	}
+	if (open_flag & O_CREAT)
+		inode_lock(dir_inode);
+	else
+		inode_lock_shared(dir_inode);
+
+	if (unlikely(IS_DEADDIR(dir_inode))) {
+		dentry = ERR_PTR(-ENOENT);
+		goto out;
+	}
 
 	file->f_mode &= ~FMODE_CREATED;
 	dentry = d_lookup(dir, &nd->last);
@@ -4417,7 +4433,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		if (!dentry) {
 			dentry = d_alloc_parallel(dir, &nd->last);
 			if (IS_ERR(dentry))
-				return dentry;
+				goto out;
 		}
 		if (d_in_lookup(dentry))
 			break;
@@ -4433,7 +4449,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	}
 	if (dentry->d_inode) {
 		/* Cached positive dentry: will open in f_op->open */
-		return dentry;
+		goto out;
 	}
 
 	if (open_flag & O_CREAT)
@@ -4454,7 +4470,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	if (open_flag & O_CREAT) {
 		if (open_flag & O_EXCL)
 			open_flag &= ~O_TRUNC;
-		mode = vfs_prepare_mode(idmap, dir->d_inode, mode, mode, mode);
+		mode = vfs_prepare_mode(idmap, dir_inode, mode, mode, mode);
 		if (likely(got_write))
 			create_error = may_o_create(idmap, &nd->path,
 						    dentry, mode);
@@ -4469,7 +4485,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		dentry = atomic_open(&nd->path, dentry, file, open_flag, mode);
 		if (unlikely(create_error) && dentry == ERR_PTR(-ENOENT))
 			dentry = ERR_PTR(create_error);
-		return dentry;
+		goto out;
 	}
 
 	if (d_in_lookup(dentry)) {
@@ -4508,11 +4524,27 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		error = create_error;
 		goto out_dput;
 	}
+out:
+	if (!IS_ERR(dentry)) {
+		if (file->f_mode & FMODE_CREATED)
+			fsnotify_create(dir_inode, dentry);
+		if (file->f_mode & FMODE_OPENED)
+			fsnotify_open(file);
+	}
+	if ((open_flag & O_CREAT) || create_error)
+		inode_unlock(dir_inode);
+	else
+		inode_unlock_shared(dir_inode);
+
+	if (got_write)
+		mnt_drop_write(nd->path.mnt);
+
 	return dentry;
 
 out_dput:
 	dput(dentry);
-	return ERR_PTR(error);
+	dentry = ERR_PTR(error);
+	goto out;
 }
 
 static inline bool trailing_slashes(struct nameidata *nd)
@@ -4555,9 +4587,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 		   struct file *file, const struct open_flags *op)
 {
 	struct delegated_inode delegated_inode = { };
-	struct dentry *dir = nd->path.dentry;
 	int open_flag = op->open_flag;
-	bool got_write = false;
 	struct dentry *dentry;
 	const char *res;
 
@@ -4587,32 +4617,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 		}
 	}
 retry:
-	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
-		got_write = !mnt_want_write(nd->path.mnt);
-		/*
-		 * do _not_ fail yet - we might not need that or fail with
-		 * a different error; let lookup_open() decide; we'll be
-		 * dropping this one anyway.
-		 */
-	}
-	if (open_flag & O_CREAT)
-		inode_lock(dir->d_inode);
-	else
-		inode_lock_shared(dir->d_inode);
-	dentry = lookup_open(nd, file, op, got_write, &delegated_inode);
-	if (!IS_ERR(dentry)) {
-		if (file->f_mode & FMODE_CREATED)
-			fsnotify_create(dir->d_inode, dentry);
-		if (file->f_mode & FMODE_OPENED)
-			fsnotify_open(file);
-	}
-	if (open_flag & O_CREAT)
-		inode_unlock(dir->d_inode);
-	else
-		inode_unlock_shared(dir->d_inode);
-
-	if (got_write)
-		mnt_drop_write(nd->path.mnt);
+	dentry = lookup_open(nd, file, op, &delegated_inode);
 
 	if (IS_ERR(dentry)) {
 		if (is_delegated(&delegated_inode)) {
-- 
2.50.0.107.gf914562f5916.dirty

