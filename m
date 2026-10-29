Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793236184;
	b=XM8pUzbooSK4cRApAAYeDamg5toOlD0yq9x0nS0ANnHjfKerkhzvY3Smp7Y3+FRWZsm7
	 lYlwojgohD9qbqS//+DQue+dpb1t4dHRMNW0qHUmElRFCyRJsS/NnVaxlaQmnqYCFtjmj
	 x4CL9p5XVL6WLIYaoSvkK36j4tD4l/q6L9GEHfhQBdU1ez8rhAsDG0rO5WTIARgH+lksy
	 cE1OzfoWT9YQkfAK1sf5XugANNN3/hEC8FaBNPqFmWSa9W/0O4oeO0BizNMHzZV0/Cb8c
	 bWahcqTG54N2H+bBRH91sAi8G9F4yvphdWY3yGAbGavSKXZPP7W0OQo66ADOEwGTjug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793236184;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=tpLGrLGauDgDl9yW0M4lNB40Ai17F4E6qRNBG6GWEPM=;
	b=yvmBQGVD0cqu1yqxDD6KA4z/W6jN48Kniq87GujDbEW2WJqNLnlJvVULa1ZLonZpQMj7
	 cCfyPP5PS1SInOJtmUlHt6LvnrUAl9J+gB034gfe6gkiViduNHERJRcAuu3ysbALfnUpi
	 5DMZ9AUCO9Tqkmdo9FobPnf3zzNRPFYlrg7oYCNTIojVNuEeangKgx8NOby8i4lPv0cqc
	 DGf0PJaTgGlA/TxOCbECUnUNrbO0Q7BwmWftwgovoMvNdGr5+LF29TcvSYzFKjA7qalmS
	 WVBFYX8xShvpJ8o99qUY2M8QRUq85Z5Up6lQ69kqjz02RLwoCzoSHVmBbMw1JSycROQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=snBeTqYB;
	arc=none smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F2660A261C
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 01:09:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54F2660A261C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=snBeTqYB
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-91c75267b0fso19025896d6.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 18:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793236183; x=1793840983; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tpLGrLGauDgDl9yW0M4lNB40Ai17F4E6qRNBG6GWEPM=;
        b=snBeTqYBJH41K4SmZEQXMR4sJriIuR6UHXzT/pzqBt0DTgo4l0yd9IycrSoO1Z77b0
         sVCLInl6O7ZcZRgJ3GFe24hILU8nZmMXD2zHZ2hKojGchvX1/gs2zIHP0V9F/UBSwFzJ
         +PNqZTTmgqWM/KQ0Om4XUn5nB2jYgTbJar9PUtwU43e572P9u/9zOAmO5URFTGaoCJge
         oTAMBTKHymdFtuuwFAcSdOsgjNo4bieZ3Wt70dGJRXLxzhpwB4Y+AgicL1s/11G+pue1
         MuKtI52AwNBOt7ScuyCfftS0gxwrthI+Vfye1WomYbSNd+OoEovfw8LCujIikN5twJ2J
         qjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793236183; x=1793840983;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tpLGrLGauDgDl9yW0M4lNB40Ai17F4E6qRNBG6GWEPM=;
        b=177VfhSBLb5AMsTrKGHng1Y/jR+kP5U4qxNCKmXMZrkJKtsGbNI1KIRHDqxgLNP/Y5
         cG3Q3WaGS8pp34sAMI7IDoVDsAom+D3IFM5qCA15TiCO8OAUMdObAXWAHqYAUCTKj6ZP
         SDg+fmjokg9qKPQg2aBMFARm+XYcbTGK/oVr4SPT/W892RWotzcbPdm9eDBp2PeliUjn
         nCtmIgDIs9BBY/PoGcNsn40oS4ir0nUekYyqmM9exbB+fRtPf5iebQWc0u3FW01djitD
         doj5Z83wdWx4zQEvXlcuCVmkcTX3Dw86nRMqebbSuQiOxiA3nMSwnWNxcL6FRr99ysj3
         lE6Q==
X-Forwarded-Encrypted: i=1; AKwUvBxVKvfOI4AXAGJy9mDyMxWc3o5pPsk4WIXIqXHcsQVIAPfboTsD5BuRJsPHP80JP+EESJDePztX82cYMoE5@vger.kernel.org
X-Gm-Message-State: AFq9FYKr0yUqSgm8Vz6Cm3u7FHhJvymEMHMoWgIoFizS73mACYMUDxal
	chkoJfj9pjysT1/UCohrq3rjuEg+2mjVVTlsa3zd9wRNBJDRc7nmui4BGx6KemHsctU=
X-Gm-Gg: AYBFou2mEHfo1edyOYIngCSSIVQUhBfZKKYGz0cvRTxg41iAo3UcBj19YlvMzYVS1jO
	dh+a1TdueMzfrVqI4owrQWLM7et7j04UvBvPWupmNKkl9nxtvdUv+CtlTaDGsyEUjlKXP8CPP5/
	Fg7lxnmCUSDj0Z+6GNk9exhFiFguIny0QTGhDFm2qUVFT1Zpr0iPsZIyvX5A1e1n3M+rtkCIXTw
	ta2MQ9sYhbNnMjGoIMI/nOeKYimb3g8b85Tx+Kk0m4kCmTpjJYIrd3siGBMCWIvWnyjWttd+cLU
	CNg9oHqqxV8OtgK8xjSsT6TfpKlKMMt43c4q4MgYI9ijgSzuq5GfNM77qrOj70NcsISooWOL3gA
	d5e341ZKzmyYXFdApCDDHSXs03Wg63ArzhymM/gKg5jP4oQLCx+R+GxjT6XeQAWAL9RdcnBHmJT
	wO8WWwKQdNsiWzz2khLjSKZfHtEp2fyLVowhFhS/tlgqIdMzUMBLv4vOkjs5QRR3L0Wg/Fp8CbT
	nm6RpxUANrzc8xGOQWHmyDXIMtkR0QXbfvQAKKAPkTgwbkRKrGlz76ztr0Ky6mMRJ+B/lXzBVBL
	YwPRd8kH0zZDSXYj1XiqYDquqWQNuTGGtX/x+n8MxspmwQ8=
X-Received: by 2002:a05:620a:2849:b0:93e:5821:2c5c with SMTP id af79cd13be357-94408cf1bf6mr614312185a.60.1793236183125;
        Wed, 28 Oct 2026 18:09:43 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.253])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f0a78c06sm1393247685a.35.2026.10.28.18.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 18:09:42 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 29 Oct 2026 01:09:20 +0000
Subject: [PATCH v2 06/10] ovl: handle lazytime on the upper filesystem
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-b4-ovl-containerized-sync-v2-6-4e9f08e4a052@toxicpanda.com>
References: <20261029-b4-ovl-containerized-sync-v2-0-4e9f08e4a052@toxicpanda.com>
In-Reply-To: <20261029-b4-ovl-containerized-sync-v2-0-4e9f08e4a052@toxicpanda.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@infradead.org>, Chris Mason <mason@kernel.org>, 
 Chengguang Xu <cgxu519@mykernel.net>, linux-unionfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793236166; l=5683;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=eSliQDWathldjP0ntiY67Ro+PGXXgDddabaaxFAzW2I=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJ8x16Vjf8JcNJXDO4uG8vDEJU3JRltGOVRdMbyzc29w6t/9VmkmtO1mzIZyUyluu4UFqRn+3a6
 34qDNoy7FgA0=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

With lazytime on the upper filesystem the flusher leaves timestamps in
memory for up to 12 hours.  The overlay inode must not be clean during that
time, or syncfs() would miss them.  It cannot stay dirty either, because
the flusher would visit it on every pass and it could not be reclaimed.

When deferred timestamps are all that is left to write, set I_DIRTY_TIME on
the overlay inode, like the VFS does on the upper inode.  Implement
->sync_lazytime() to pass the request on to the upper inode.

The VFS writes deferred timestamps on the last iput().  The upper inode
does not see that while the overlay inode holds it, so the last iput() of
the overlay inode stands in for it.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/overlayfs/dir.c       |  1 +
 fs/overlayfs/inode.c     | 19 +++++++++++++++++++
 fs/overlayfs/overlayfs.h |  1 +
 fs/overlayfs/super.c     | 27 +++++++++++++++++++++++++++
 4 files changed, 48 insertions(+)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 1194ccf981c3..fc47beffa67e 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -1489,6 +1489,7 @@ const struct inode_operations ovl_dir_inode_operations = {
 	.get_acl	= ovl_get_acl,
 	.set_acl	= ovl_set_acl,
 	.update_time	= ovl_update_time,
+	.sync_lazytime	= ovl_sync_lazytime,
 	.fileattr_get	= ovl_fileattr_get,
 	.fileattr_set	= ovl_fileattr_set,
 	.tmpfile	= ovl_tmpfile,
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 9a4bf7c2502b..5895ee5aa771 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -743,6 +743,22 @@ int ovl_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 	return err;
 }
 
+/*
+ * The overlay inode has I_DIRTY_TIME set because the upper inode has deferred
+ * timestamps, see ovl_park_inode().  The VFS calls this when the timestamps
+ * have to be written.  Mark the upper inode dirty, which hands the timestamps
+ * to the upper filesystem, and mark the overlay inode dirty, so that
+ * ovl_write_inode() writes the upper inode.
+ */
+void ovl_sync_lazytime(struct inode *inode)
+{
+	struct inode *upper = ovl_inode_upper(inode);
+
+	if (upper && (inode_state_read_once(upper) & I_DIRTY_TIME))
+		mark_inode_dirty_sync(upper);
+	ovl_mark_inode_dirty(inode);
+}
+
 static const struct inode_operations ovl_file_inode_operations = {
 	.setattr	= ovl_setattr,
 	.permission	= ovl_permission,
@@ -752,6 +768,7 @@ static const struct inode_operations ovl_file_inode_operations = {
 	.get_acl	= ovl_get_acl,
 	.set_acl	= ovl_set_acl,
 	.update_time	= ovl_update_time,
+	.sync_lazytime	= ovl_sync_lazytime,
 	.fiemap		= ovl_fiemap,
 	.fileattr_get	= ovl_fileattr_get,
 	.fileattr_set	= ovl_fileattr_set,
@@ -763,6 +780,7 @@ static const struct inode_operations ovl_symlink_inode_operations = {
 	.getattr	= ovl_getattr,
 	.listxattr	= ovl_listxattr,
 	.update_time	= ovl_update_time,
+	.sync_lazytime	= ovl_sync_lazytime,
 };
 
 static const struct inode_operations ovl_special_inode_operations = {
@@ -774,6 +792,7 @@ static const struct inode_operations ovl_special_inode_operations = {
 	.get_acl	= ovl_get_acl,
 	.set_acl	= ovl_set_acl,
 	.update_time	= ovl_update_time,
+	.sync_lazytime	= ovl_sync_lazytime,
 };
 
 static const struct address_space_operations ovl_aops = {
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 8f83325ec359..d3a897e46ccb 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -890,6 +890,7 @@ static inline struct posix_acl *ovl_get_acl_path(const struct path *path,
 
 int ovl_update_time(struct inode *inode, enum fs_update_time type,
 		unsigned int flags);
+void ovl_sync_lazytime(struct inode *inode);
 bool ovl_is_private_xattr(struct super_block *sb, const char *name);
 
 struct ovl_inode_params {
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index a68eb78a9061..de3e2d0b29ee 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -368,6 +368,31 @@ static enum ovl_write_mode ovl_write_mode(struct inode *inode,
 	return OVL_WRITE_COMMIT;
 }
 
+/*
+ * All that is left to write for @inode are timestamps that lazytime has
+ * deferred on the upper inode.  The flusher leaves those alone for up to 12
+ * hours.  Set I_DIRTY_TIME on the overlay inode, like the VFS did on the upper
+ * inode.  This takes the overlay inode off the list that the flusher walks,
+ * syncfs() still finds it, and the VFS calls ovl_sync_lazytime() when the
+ * timestamps have to be written.
+ *
+ * One of those occasions is when the last reference to an inode goes away.  The
+ * upper inode never loses its last reference while the overlay inode exists, so
+ * the overlay inode has to stand in for it.  The last reference to the overlay
+ * inode may already be gone at this point.  iput() checks for I_DIRTY_TIME
+ * under i_lock before it drops the last reference, so either iput() sees the
+ * flag, or the reference count is zero here.
+ */
+static void ovl_park_inode(struct inode *inode)
+{
+	if (!ovl_tracks_dirty(OVL_FS(inode->i_sb)))
+		return;
+
+	__mark_inode_dirty(inode, I_DIRTY_TIME);
+	if (!icount_read_once(inode))
+		mark_inode_dirty_sync(inode);
+}
+
 static int ovl_write_inode(struct inode *inode, struct writeback_control *wbc)
 {
 	struct inode *upper = ovl_inode_upper(inode);
@@ -388,6 +413,8 @@ static int ovl_write_inode(struct inode *inode, struct writeback_control *wbc)
 
 	if (ovl_upper_unfinished(upper))
 		ovl_mark_inode_dirty(inode);
+	else if (inode_state_read_once(upper) & I_DIRTY_TIME)
+		ovl_park_inode(inode);
 
 	return ret;
 }

-- 
2.55.0

