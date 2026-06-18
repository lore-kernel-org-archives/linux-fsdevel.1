Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D552E5B1B
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 15:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781797956; cv=none; b=nBV2gcrl5tuygl03t1bDemAIOUYMtBGZib0BTEB7mm5WKcvoU7Cj30g0uAVGnytBoXY/oOe/mruEPlJSXetG7IFQpUylk1oWzdhtmD7QS1oyKO20fmsVJKvI+/UWByM7pjgndJKCb/RlsEp2oMDyvJpd+jIOhG5+p3AYDyvkvVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781797956; c=relaxed/simple;
	bh=q5GsnSfg57d+z1/pL8uHAlK3Ewmwpsn7DLoFDJkjhp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aR21WsJbxB7/8++1XsDgrxgj3lm5gg4uqhX2j70i+0ejeBoKD7CK8Ux5IYUhWsA77K5Ynm099dFtFW9hJuRfr3Gyplzqpsf2XqPJ9RCc1WqB7iYjwTb1XE8R+4S1WVRkRCArtNlhh6MbGVrHcCrxiqgoBNUGQnrBnViT8G00Rd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CIvuMEcJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CIvuMEcJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781797954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Is8gZeDxmJ/yOHhdFapMgcLnvId/PtrFwq0tQaR3lE0=;
	b=CIvuMEcJYRK3O1pHLXINjGnn7dLU60zMCCawzyM6nGD7CRR8kLzW2AJeUdZk1Eqg8O4P49
	Uom0wKlfbpZ3d7F2IDsNhZpKdYmyGpp1GNTukR0a7YFDy29Lq5hgmSX5bMY+76MjLDz9VJ
	I1H4X6YN8P3hxqEkF346CEHlPEwccso=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-htYu51B2PL617jfJKvXH4w-1; Thu,
 18 Jun 2026 11:52:30 -0400
X-MC-Unique: htYu51B2PL617jfJKvXH4w-1
X-Mimecast-MFC-AGG-ID: htYu51B2PL617jfJKvXH4w_1781797949
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 93D101955F7A;
	Thu, 18 Jun 2026 15:52:29 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 741611800667;
	Thu, 18 Jun 2026 15:52:27 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v3 10/20] afs: Fix bulk lookup malfunction due to change in dir_emit() API
Date: Thu, 18 Jun 2026 16:51:29 +0100
Message-ID: <20260618155141.2513212-11-dhowells@redhat.com>
In-Reply-To: <20260618155141.2513212-1-dhowells@redhat.com>
References: <20260618155141.2513212-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
 fs/afs/dir.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 498b99ccdf0e..7af36370ccb4 100644
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
 
@@ -554,7 +564,7 @@ static int afs_readdir(struct file *file, struct dir_context *ctx)
  *   uniquifier through dtype
  */
 static bool afs_lookup_one_filldir(struct dir_context *ctx, const char *name,
-				  int nlen, loff_t fpos, u64 ino, unsigned dtype)
+				  int nlen, u64 ino, unsigned dtype)
 {
 	struct afs_lookup_one_cookie *cookie =
 		container_of(ctx, struct afs_lookup_one_cookie, ctx);
@@ -591,7 +601,7 @@ static int afs_do_lookup_one(struct inode *dir, const struct qstr *name,
 {
 	struct afs_super_info *as = dir->i_sb->s_fs_info;
 	struct afs_lookup_one_cookie cookie = {
-		.ctx.actor = afs_lookup_one_filldir,
+		.ctx.actor = AFS_LOOKUP_ONE,
 		.name = *name,
 		.fid.vid = as->volume->vid
 	};
@@ -622,7 +632,7 @@ static int afs_do_lookup_one(struct inode *dir, const struct qstr *name,
  *   uniquifier through dtype
  */
 static bool afs_lookup_filldir(struct dir_context *ctx, const char *name,
-			      int nlen, loff_t fpos, u64 ino, unsigned dtype)
+			      int nlen, u64 ino, unsigned dtype)
 {
 	struct afs_lookup_cookie *cookie =
 		container_of(ctx, struct afs_lookup_cookie, ctx);
@@ -778,7 +788,7 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry)
 
 	for (i = 0; i < ARRAY_SIZE(cookie->fids); i++)
 		cookie->fids[i].vid = dvnode->fid.vid;
-	cookie->ctx.actor = afs_lookup_filldir;
+	cookie->ctx.actor = AFS_LOOKUP;
 	cookie->name = dentry->d_name;
 	cookie->nr_fids = 2; /* slot 1 is saved for the fid we actually want
 			      * and slot 0 for the directory */

