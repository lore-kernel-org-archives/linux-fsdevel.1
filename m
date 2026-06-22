Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9201370D52
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 09:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782119394; cv=none; b=tyhvDGtS1of530yemDHaLCauI1RV4f3IOYwS+gLs/JAGzYIZ9D34aBNG9rtrhrWvHV7Zxobn/xJ9SyM8I8kfICjHVz/iy978f23ozuwsTUDg3TPAsJuLkbzmFHyNuWnlVMu3v4mDep/xYt5R9j3KKnbjby0AlSbP7aFtVnEdjlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782119394; c=relaxed/simple;
	bh=eeLCwMM/on2XWB2MsCivkQkkL7LpErxuT6jfJeZc4l0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jxnJc48mY9JD6qRnCCe+jp44V3JeJHVJnjYiVIYhDw3ctuxIdZAt8ldxUmGEr04zxA/j9FlqVJh+Moz24ABe6XZgRe6hCrTVEQTfGR4y+MdEeEhRCX5CAu+Nwv3e/1t2i73x5ziIDNVZjmlOmRhqk0VHOa2fCEC1C1AJsbZh/g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=blV+rSzi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="blV+rSzi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782119392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hh/qa1hXxOSb0BuMIMtmXpp20WZ4x3jnxiyageTsNFQ=;
	b=blV+rSzi9X+jvoMzjGwjWeyGD/GIwAGaQGdP5QGmr270AD4uhxxq7ZgHPrAG9OdCkfVr9G
	1HyH3O9Cgx8a0IReM4mD9Cy130ei5ifF1x6Fcau3C2CpnkHdS7D93SrjfSGeAcW4GV57GW
	csLjEgECw4PiuvthsYRVzShGrJp6XKQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-Y3ugc210NwmwNPvDIsYhzA-1; Mon,
 22 Jun 2026 05:09:49 -0400
X-MC-Unique: Y3ugc210NwmwNPvDIsYhzA-1
X-Mimecast-MFC-AGG-ID: Y3ugc210NwmwNPvDIsYhzA_1782119387
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C170C1954B2B;
	Mon, 22 Jun 2026 09:09:47 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.242])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A3E8C3001D84;
	Mon, 22 Jun 2026 09:09:45 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v4 10/21] afs: Fix bulk lookup malfunction due to change in dir_emit() API
Date: Mon, 22 Jun 2026 10:08:44 +0100
Message-ID: <20260622090856.2746629-11-dhowells@redhat.com>
In-Reply-To: <20260622090856.2746629-1-dhowells@redhat.com>
References: <20260622090856.2746629-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

afs_do_lookup() and afs_do_lookup_one() use the same directory parsing code
as afs_readdir() and were supplying alternative dir_context actors to
retrieve dirents, but because lookup needs the vnode's uniquifier as part
of the reference, but not the DT flags, the uniquifier was being passed in
the dt flags argument to the lookup actors.

Unfortunately, commit c644bce62b9c, added to fix overlayfs with fuse, broke
this by masking off part of the uniquifier.  This doesn't matter enough to
be directly noticeable, instead causing bulk advance inode lookups to fail
(which are retried later) and may cause dir revalidation to malfunction if
the uniquifier is changed by masking.

Fix this by making the afs directory parsing code take special ->actor
values of AFS_LOOKUP or AFS_LOOKUP_ONE instead that tell it to call
afs_lookup_filldir() or afs_lookup_one_filldir() directly rather than going
through dir_emit().  dir_emit() is still used for readdir.

Fixes: c644bce62b9c ("readdir: require opt-in for d_type flags")
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Amir Goldstein <amir73il@gmail.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/dir.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 498b99ccdf0e..6df56fe9163f 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -28,9 +28,11 @@ static int afs_d_revalidate(struct inode *dir, const struct qstr *name,
 static int afs_d_delete(const struct dentry *dentry);
 static void afs_d_iput(struct dentry *dentry, struct inode *inode);
 static bool afs_lookup_one_filldir(struct dir_context *ctx, const char *name, int nlen,
-				  loff_t fpos, u64 ino, unsigned dtype);
+				   u64 ino, u32 uniquifier);
+#define AFS_LOOKUP_ONE ((filldir_t)0x123UL)
 static bool afs_lookup_filldir(struct dir_context *ctx, const char *name, int nlen,
-			      loff_t fpos, u64 ino, unsigned dtype);
+			       u64 ino, u32 uniquifier);
+#define AFS_LOOKUP ((filldir_t)0x137UL)
 static int afs_create(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *dentry, umode_t mode, bool excl);
 static struct dentry *afs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
@@ -421,11 +423,18 @@ static int afs_dir_iterate_block(struct afs_vnode *dvnode,
 		}
 
 		/* found the next entry */
-		if (!dir_emit(ctx, dire->u.name, nlen,
-			      ntohl(dire->u.vnode),
-			      (ctx->actor == afs_lookup_filldir ||
-			       ctx->actor == afs_lookup_one_filldir)?
-			      ntohl(dire->u.unique) : DT_UNKNOWN)) {
+		if (ctx->actor == AFS_LOOKUP) {
+			if (!afs_lookup_filldir(ctx, dire->u.name, nlen,
+						ntohl(dire->u.vnode),
+						ntohl(dire->u.unique)))
+				return 0;
+		} else if (ctx->actor == AFS_LOOKUP_ONE) {
+			if (!afs_lookup_one_filldir(ctx, dire->u.name, nlen,
+						    ntohl(dire->u.vnode),
+						    ntohl(dire->u.unique)))
+				return 0;
+		} else if (!dir_emit(ctx, dire->u.name, nlen,
+				     ntohl(dire->u.vnode), DT_UNKNOWN)) {
 			_leave(" = 0 [full]");
 			return 0;
 		}
@@ -545,6 +554,7 @@ static int afs_readdir(struct file *file, struct dir_context *ctx)
 {
 	afs_dataversion_t dir_version;
 
+	ctx->dt_flags_mask = UINT_MAX;
 	return afs_dir_iterate(file_inode(file), ctx, file, &dir_version);
 }
 
@@ -554,14 +564,14 @@ static int afs_readdir(struct file *file, struct dir_context *ctx)
  *   uniquifier through dtype
  */
 static bool afs_lookup_one_filldir(struct dir_context *ctx, const char *name,
-				  int nlen, loff_t fpos, u64 ino, unsigned dtype)
+				  int nlen, u64 ino, u32 uniquifier)
 {
 	struct afs_lookup_one_cookie *cookie =
 		container_of(ctx, struct afs_lookup_one_cookie, ctx);
 
 	_enter("{%s,%u},%s,%u,,%llu,%u",
 	       cookie->name.name, cookie->name.len, name, nlen,
-	       (unsigned long long) ino, dtype);
+	       (unsigned long long) ino, uniquifier);
 
 	/* insanity checks first */
 	BUILD_BUG_ON(sizeof(union afs_xdr_dir_block) != 2048);
@@ -574,7 +584,7 @@ static bool afs_lookup_one_filldir(struct dir_context *ctx, const char *name,
 	}
 
 	cookie->fid.vnode = ino;
-	cookie->fid.unique = dtype;
+	cookie->fid.unique = uniquifier;
 	cookie->found = 1;
 
 	_leave(" = false [found]");
@@ -591,7 +601,7 @@ static int afs_do_lookup_one(struct inode *dir, const struct qstr *name,
 {
 	struct afs_super_info *as = dir->i_sb->s_fs_info;
 	struct afs_lookup_one_cookie cookie = {
-		.ctx.actor = afs_lookup_one_filldir,
+		.ctx.actor = AFS_LOOKUP_ONE,
 		.name = *name,
 		.fid.vid = as->volume->vid
 	};
@@ -622,14 +632,14 @@ static int afs_do_lookup_one(struct inode *dir, const struct qstr *name,
  *   uniquifier through dtype
  */
 static bool afs_lookup_filldir(struct dir_context *ctx, const char *name,
-			      int nlen, loff_t fpos, u64 ino, unsigned dtype)
+			      int nlen, u64 ino, u32 uniquifier)
 {
 	struct afs_lookup_cookie *cookie =
 		container_of(ctx, struct afs_lookup_cookie, ctx);
 
 	_enter("{%s,%u},%s,%u,,%llu,%u",
 	       cookie->name.name, cookie->name.len, name, nlen,
-	       (unsigned long long) ino, dtype);
+	       (unsigned long long) ino, uniquifier);
 
 	/* insanity checks first */
 	BUILD_BUG_ON(sizeof(union afs_xdr_dir_block) != 2048);
@@ -637,7 +647,7 @@ static bool afs_lookup_filldir(struct dir_context *ctx, const char *name,
 
 	if (cookie->nr_fids < 50) {
 		cookie->fids[cookie->nr_fids].vnode	= ino;
-		cookie->fids[cookie->nr_fids].unique	= dtype;
+		cookie->fids[cookie->nr_fids].unique	= uniquifier;
 		cookie->nr_fids++;
 	}
 
@@ -778,7 +788,7 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry)
 
 	for (i = 0; i < ARRAY_SIZE(cookie->fids); i++)
 		cookie->fids[i].vid = dvnode->fid.vid;
-	cookie->ctx.actor = afs_lookup_filldir;
+	cookie->ctx.actor = AFS_LOOKUP;
 	cookie->name = dentry->d_name;
 	cookie->nr_fids = 2; /* slot 1 is saved for the fid we actually want
 			      * and slot 0 for the directory */

