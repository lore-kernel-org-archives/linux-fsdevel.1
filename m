Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EEB351C17
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 02:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790649476; cv=none; b=FLqcfoyXQfbBOOQu4qAOq4h/eDmx3Lb2aBsxcQs7bsuacfD19/bUkaJ8kkH1viBoH0+q0rRPkMsAprFgtk3/GCAGrDyRki5QmJM5Z94a76MLxk7NsyRA71MxTJWFxBHD0DJ59Vf77f/bGdl8blxv1vp4jVapM+6PZTuTKtQWiUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790649476; c=relaxed/simple;
	bh=3WvX8auO+vPTxuhxrUMeUtPNsWMfO7P5fBUdwNuci20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qT74cw2X4YckKDWBDb5PNrwRtztF0EOdfK50zJFDxQYupVH9i8BoMagO0MCK30M/K2OO7e/oeoCyIrIkvqvFfqCkdAuR+abGbMOm7MyPHmUfxcDGRFT+b2pyvPdDuCMbV1X2YKEshhPiAuYcf5zb3IjeARmuzzwGvNFxHDuNqtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=hx8deatW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QO2WpYao; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="hx8deatW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QO2WpYao"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 960FA1D000DE;
	Mon, 28 Sep 2026 22:37:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 28 Sep 2026 22:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1790649473;
	 x=1790735873; bh=KFQ8SOVgK/GCz1zi1dP3pEpXYGsBD/dTHbuQx3+/6fE=; b=
	hx8deatWTfApTqkDfJI+6f9mqbUDXRr6/CTkZegrgWe91u21ksNIjYYchUmCLP8D
	op9JsPXBJrdcASwHDdG/hN79W3inwtUyjDnaqWmnKgJwT64UWLV06nYeo4HF/SHI
	2oVgJcnBubAKUeX1GJbSE1By4ig7eZVP4TGY7hNJIyGgZ78f7bZVrM19R/Yvlw3g
	ElJgCUX8VxghkXTkX7y1BpZOTCaXsYJBnQs2BLwjGRcqxq8hSKefxJppe9SQBn02
	Zt90UOU67TaxNCtQfiY4UyAYYW2fM/yJ3m0Yetlrqwlj7XlYxdYM7MV5j8ARkUA+
	DZCqayQHoOXYWla0f+N6cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790649473; x=1790735873; bh=K
	FQ8SOVgK/GCz1zi1dP3pEpXYGsBD/dTHbuQx3+/6fE=; b=QO2WpYao6XNNA8ec/
	3CD49JTO9zoa8cZaB5MItfSIsg9yuNVtjfw/cYNmj8B0huTksiOqezJ3vlmTBSbS
	kZF4FoPQTmfA9HnEyw7O7A0MxaBw5IzCfTDmWmCSNFFvcfaSsK1dzYfbZakTv0NH
	+hfAwEA/vxut/udBhRmjlgtvPze0bf9OcjzFmo7qC1JEGbgiJUSsXI2lKG2Ohgfs
	uqOU05CPB7NNJThw39XByfVc4DNB1Sacb+A6dmUp4Quz6Iyu/nZ3UAqSr2BXmJLi
	dukI+HlVfqO3uAp9yveO3QFFzqqt6Ga6QRGbWEl0YhZ74Q1ljoSdZ9zsbTMPDJow
	8W6OA==
X-ME-Sender: <xms:gSS7ahNyTJwQrD9qRCl0tgJfpiVGtc3ZH72yn5ve08UgpHQfXLwzIA>
    <xme:gSS7anClAg95wN5qK60GeYEvD0pZrq9YjgbuJgFPvRx_JKikqjQKvUffFKgRfusV0
    lrItNLLpabZMR8tF3BoLYoeWD56IiK_SREZIzioobUDZ3GZzQ>
X-ME-Received: <xmr:gSS7aq7oIMR3qwOJTQhFcLIm7Z5xcQuXedU8sLfO37gDomeKI4MQmeBosvkVPkPGDklUrFBU6V_2bZN8DIHVJcWyVCZDYXE>
X-ME-Proxy-Cause: dmFkZTGWqbnmI8/n4qvCotPb7BBmoUH0aBQ5WcJI9+Mnj2pcS7qFuOb/LM6GkieOZda24Y
    vYFOBr5Ca4t3MzL+KOro5zy+3wBaOzkHacz0D7wxco336zEnEW4q7tqPFa1DAGKCtqeMa5
    3qffhkHCJ8FV4BlRY+/5S3TZV4anDcVMOsMbl3gL0Rs27sChroA1dk2PqpvBV6dlXkqtCe
    Q6BIPhoaYRm9hbeQ3xRqL27M9QWbzPH9djD5YfEn3qH3/46727VCx2pLcRBE7QooVwJ/76
    s/Rk7bxUUf/2ST2Plv7aX/x89o82U1CxpELwOnOufR+Yk0vVYzzZ7JEimKbJaGYrQqYQhh
    j05O3EET2gbTQzd/tSDFvFVg2+TBsI0EzYVw+yoRVkP1+hVmrlxw/HxZO/xtzDcJmN3v1u
    h9z9MquZAIPlYG65Jh19C3hF3swMEXVBGmjbg+XmfVp+Jh5OIQ61ESNTNc00tRqejMJcMw
    9Y2Su4ilrUr8NLvzpFKuTStUZFW+PjAjfkwXrvZKVErFw1STw3VSZqiAltS/3v/Yd2Txpn
    HFgn93XMvWzBZnsdaFpuyv7ezTDCf9K0EbiIUQmaZ0C/cD/7oLDZOyGTve1E64J4+Pq2Yf
    vUR96VGlzQ7E3vlXLNBKGe4znP5YPJx0iavxHk1mRwuvtdzgo97QN2oNMMXg
X-ME-Proxy: <xmx:gSS7ap7deVAzQm3NUkvwWHYGR2yC2W2iQ-ibPqV9orwnS_DDY3n7eQ>
    <xmx:gSS7akS5Z6Y-4xXRXRwa2JbaOTnIUruOGMomfBAzpudnYeFjKEEaHg>
    <xmx:gSS7ap8Kv4-0s3lUC9d4sJd_WQw2PxKuKCQy7DzNO0SAd9F-1I6UjQ>
    <xmx:gSS7atYh8Q1bF8myBNt7o-PF5ys06l20XhsEEJxzXpC5g8YAESsoUQ>
    <xmx:gSS7alnPjHApdCBhSqNRIxerinH39QK0oeIq7vOb3MADXiAEGAASwaUY>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 22:37:50 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernl.org
Subject: [PATCH v2 1/5] afs: don't unhash/rehash dentries during unlink/rename
Date: Tue, 29 Sep 2026 12:29:27 +1000
Message-ID: <20260929023223.1429201-2-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260929023223.1429201-1-neilb@ownmail.net>
References: <20260929023223.1429201-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

afs needs to block lookup of dentries during unlink and rename.
There are two reasons:
1/ If the target is to be removed, not silly-renamed, the subsequent
   opens cannot be allowed as the file won't exist on the server.
2/ If the rename source is being moved between directories a lookup,
   particularly d_revalidate, might change ->d_time asynchronously
   with rename changing ->d_time with possible incorrect results.

afs current unhashes the dentry to force a lookup which will wait on the
directory lock, and rehashes afterwards.  This is incompatible with
proposed changed to directory locking which will require a dentry to
remain hashed throughout rename/unlink/etc operations.

This patch copies a mechanism developed for NFS but uses the new
DCACHE_PRIVATE flag rather then ->d_fsdata.  DCACHE_PRIVATE is given
the private name DCACHE_BLOCKED within afs.

The flag is set when lookups and revalidates must be blocked.
d_revalidate checks for this flag and waits for it to become be cleared.

->d_lock is used to ensure d_revalidate never updates the time stamp in
->d_fsdata while DCACHE_PRIVATE is set.

When setting DCACHE_BLOCKED is used to prevent lookups we need
write_seqcount_invalidate(&dentry->d_seq) as well to ensure
RCU-walk don't proceed to an open until DCACHE_BLOCKED is cleared.
When being used to avoid revalidating the timestamp in d_fsdata,
that invalidation isn't needed.

The unlocking in afs_rename_edit_dir() is not needed.  It was previously
needed because it would not be safe to d_rehash() after calling
d_move().  But now that we don't use d_rehash() that is not a concern.
afs_rename_put() is always called and is sufficient for all rename
unlocking.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/afs/dir.c      | 95 +++++++++++++++++++++++++++++++++--------------
 fs/afs/internal.h |  5 +--
 2 files changed, 69 insertions(+), 31 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 81565366d937..8955ddb054fb 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -49,6 +49,14 @@ static int afs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 static int afs_dir_writepages(struct address_space *mapping,
 			      struct writeback_control *wbc);
 
+/*
+ * This is set to stop d_revalidate looking at, and possibly changing,
+ * ->d_fsdata (a timestamp) on a dentry which is being moved between
+ * directories, and to block lookup and possible open() for a dentry
+ * that is being removed without silly-rename.
+ */
+#define DCACHE_BLOCKED DCACHE_PRIVATE
+
 const struct file_operations afs_dir_file_operations = {
 	.open		= afs_dir_open,
 	.release	= afs_release,
@@ -1031,6 +1039,10 @@ static int afs_d_revalidate_rcu(struct afs_vnode *dvnode, struct dentry *dentry)
 	if (!afs_check_validity(dvnode))
 		return -ECHILD;
 
+	/* A rename/unlink is pending */
+	if (dentry->d_flags & DCACHE_BLOCKED)
+		return -ECHILD;
+
 	/* We only need to invalidate a dentry if the server's copy changed
 	 * behind our back.  If we made the change, it's no problem.  Note that
 	 * on a 32-bit system, we only have 32 bits in the dentry to store the
@@ -1066,6 +1078,10 @@ static int afs_d_revalidate(struct inode *parent_dir, const struct qstr *name,
 	if (flags & LOOKUP_RCU)
 		return afs_d_revalidate_rcu(dir, dentry);
 
+	/* Wait for rename/unlink to complete */
+wait_for_rename:
+	wait_var_event(&dentry->d_flags, !(dentry->d_flags & DCACHE_BLOCKED));
+
 	if (d_really_is_positive(dentry)) {
 		vnode = AFS_FS_I(d_inode(dentry));
 		_enter("{v={%llx:%llu} n=%pd fl=%lx},",
@@ -1158,7 +1174,13 @@ static int afs_d_revalidate(struct inode *parent_dir, const struct qstr *name,
 	}
 
 out_valid:
+	spin_lock(&dentry->d_lock);
+	if (dentry->d_flags & DCACHE_BLOCKED) {
+		spin_unlock(&dentry->d_lock);
+		goto wait_for_rename;
+	}
 	dentry->d_fsdata = (void *)(unsigned long)dir_version;
+	spin_unlock(&dentry->d_lock);
 out_valid_noupdate:
 	key_put(key);
 	_leave(" = 1 [valid]");
@@ -1533,8 +1555,10 @@ static void afs_unlink_edit_dir(struct afs_operation *op)
 static void afs_unlink_put(struct afs_operation *op)
 {
 	_enter("op=%08x", op->debug_id);
-	if (op->unlink.need_rehash && afs_op_error(op) < 0 && afs_op_error(op) != -ENOENT)
-		d_rehash(op->dentry);
+	spin_lock(&op->dentry->d_lock);
+	store_release_wake_up(&op->dentry->d_flags,
+			      op->dentry->d_flags &~ DCACHE_BLOCKED);
+	spin_unlock(&op->dentry->d_lock);
 }
 
 static const struct afs_operation_ops afs_unlink_operation = {
@@ -1588,11 +1612,13 @@ static int afs_unlink(struct inode *dir, struct dentry *dentry)
 		afs_op_set_error(op, afs_sillyrename(dvnode, vnode, dentry, op->key));
 		goto error;
 	}
-	if (!d_unhashed(dentry)) {
-		/* Prevent a race with RCU lookup. */
-		__d_drop(dentry);
-		op->unlink.need_rehash = true;
-	}
+	/*
+	 * As RCU-walk calls d_revalidate() before incrementing d_count
+	 * it may have already run.  We need to invalidate d_seq so
+	 * legitimize_path() will trigger a retry.
+	 */
+	write_seqcount_invalidate(&dentry->d_seq);
+	dentry->d_flags |= DCACHE_BLOCKED;
 	spin_unlock(&dentry->d_lock);
 
 	op->file[1].vnode = vnode;
@@ -1899,11 +1925,6 @@ static void afs_rename_edit_dir(struct afs_operation *op)
 
 	_enter("op=%08x", op->debug_id);
 
-	if (op->rename.rehash) {
-		d_rehash(op->rename.rehash);
-		op->rename.rehash = NULL;
-	}
-
 	fscache_begin_write_operation(&orig_cres, afs_vnode_cache(orig_dvnode));
 	if (new_dvnode != orig_dvnode)
 		fscache_begin_write_operation(&new_cres, afs_vnode_cache(new_dvnode));
@@ -2023,11 +2044,18 @@ static void afs_rename_exchange_edit_dir(struct afs_operation *op)
 static void afs_rename_put(struct afs_operation *op)
 {
 	_enter("op=%08x", op->debug_id);
-	if (op->rename.rehash)
-		d_rehash(op->rename.rehash);
+	if (op->rename.unblock) {
+		spin_lock(&op->rename.unblock->d_lock);
+		store_release_wake_up(&op->rename.unblock->d_flags,
+				      op->rename.unblock->d_flags &~ DCACHE_BLOCKED);
+		spin_unlock(&op->rename.unblock->d_lock);
+		op->rename.unblock = NULL;
+	}
+	spin_lock(&op->dentry->d_lock);
+	store_release_wake_up(&op->dentry->d_flags,
+			      op->dentry->d_flags &~ DCACHE_BLOCKED);
+	spin_unlock(&op->dentry->d_lock);
 	dput(op->rename.tmp);
-	if (afs_op_error(op))
-		d_rehash(op->dentry);
 }
 
 static const struct afs_operation_ops afs_rename_operation = {
@@ -2135,7 +2163,11 @@ static int afs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		op->ops		= &afs_rename_noreplace_operation;
 	} else if (flags & RENAME_EXCHANGE) {
 		op->ops		= &afs_rename_exchange_operation;
-		d_drop(new_dentry);
+		/* Block revalidate on new_dentry until rename completes */
+		spin_lock(&new_dentry->d_lock);
+		new_dentry->d_flags |= DCACHE_BLOCKED;
+		op->rename.unblock = new_dentry;
+		spin_unlock(&new_dentry->d_lock);
 	} else {
 		/* If we might displace the target, we might need to do silly
 		 * rename.
@@ -2148,15 +2180,18 @@ static int afs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		 * and becomes the new target.
 		 */
 		if (d_is_positive(new_dentry) && !d_is_dir(new_dentry)) {
-			/* To prevent any new references to the target during
-			 * the rename, we unhash the dentry in advance.
+
+			/*
+			 * To prevent any new references to the target
+			 * during the rename, we set DCACHE_BLOCKED
+			 * which afs_d_revalidate will wait for.  d_lock
+			 * ensures d_count() and DCACHE_BLOCKED are
+			 * consistent.
 			 */
-			if (!d_unhashed(new_dentry)) {
-				d_drop(new_dentry);
-				op->rename.rehash = new_dentry;
-			}
 
+			spin_lock(&new_dentry->d_lock);
 			if (d_count(new_dentry) > 2) {
+				spin_unlock(&new_dentry->d_lock);
 				/* copy the target dentry's name */
 				op->rename.tmp = d_alloc(new_dentry->d_parent,
 							 &new_dentry->d_name);
@@ -2174,8 +2209,13 @@ static int afs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 				}
 
 				op->dentry_2 = op->rename.tmp;
-				op->rename.rehash = NULL;
 				op->rename.new_negative = true;
+			} else {
+				/* Block any lookups to target until the rename completes */
+				write_seqcount_invalidate(&new_dentry->d_seq);
+				new_dentry->d_flags |= DCACHE_BLOCKED;
+				op->rename.unblock = new_dentry;
+				spin_unlock(&new_dentry->d_lock);
 			}
 		}
 	}
@@ -2186,10 +2226,11 @@ static int afs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	 * d_revalidate may see old_dentry between the op having taken place
 	 * and the version being updated.
 	 *
-	 * So drop the old_dentry for now to make other threads go through
-	 * lookup instead - which we hold a lock against.
+	 * So block revalidate on the old_dentry until the rename completes.
 	 */
-	d_drop(old_dentry);
+	spin_lock(&old_dentry->d_lock);
+	old_dentry->d_flags |= DCACHE_BLOCKED;
+	spin_unlock(&old_dentry->d_lock);
 
 	ret = afs_do_sync_operation(op);
 	if (ret == -ENOTSUPP)
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 290873bac89b..2026bf434c3e 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -899,10 +899,7 @@ struct afs_operation {
 			struct afs_symlink *symlink;
 		} create;
 		struct {
-			bool	need_rehash;
-		} unlink;
-		struct {
-			struct dentry	*rehash;
+			struct dentry	*unblock;
 			struct dentry	*tmp;
 			unsigned int	rename_flags;
 			bool		new_negative;

base-commit: 3879f51857325da9bf3cfb073280257cd16ae067
-- 
2.50.0.107.gf914562f5916.dirty

