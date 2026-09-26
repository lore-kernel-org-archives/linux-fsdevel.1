Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650CA54706B
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2026 03:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790391674; cv=none; b=pBLpjl0Xhr5ViSMXPTckFuyncRa0sCIiKBzbFIVH1wIC/NTw9cpvMMBDe5fLsymK9iibX112N/H4HIACR7Gbu/B+3OpFphMW3Gtz9FVHChVIhsyQpbUZ4ZWQDvCI/RoUeVErho4kJ7aCoggejfFp3gXbEyeU0zNeMB+BE8PdVyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790391674; c=relaxed/simple;
	bh=3WvX8auO+vPTxuhxrUMeUtPNsWMfO7P5fBUdwNuci20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mTkXkJLjHHIWDe+yghb/4gmjnQkXrvMsZRgqWPc9s8vnmIhD+03faWhBb1nfEcriUkZJYh8GXKrLG1qO7E61y963I3Vqzbw9mnApLbP+0/1IihDKkFxSznn3Tw2Earp85b4Vg0YJdNx3udYGfiNHBTVx9OyQ7fm3rtgOtpvAIb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=H+ORYJ9l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i4m2/21U; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="H+ORYJ9l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i4m2/21U"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id B7F241D000E0;
	Fri, 25 Sep 2026 23:01:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 25 Sep 2026 23:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1790391671;
	 x=1790478071; bh=KFQ8SOVgK/GCz1zi1dP3pEpXYGsBD/dTHbuQx3+/6fE=; b=
	H+ORYJ9lCSHP8wa+nyYmFhe5fTmMlmiOr45vFg1xY4cOHaZ12Hgt1fMAujSezP9S
	Eerx4yK9UQ7yoPwNt9Z5erOC2ajsqRA6Bbzysnd1hJvfOPKPTROOF/F3jmXbC5Uz
	hHiFllyjDnyuHvuJFKg3VWs9iUQkXYo0pOxe1n+5eLU0zmVRac+Pq0n/U97VaK76
	51HYjfWKDoo9VNzpnct2kmExssmQE/FmO3gmNseN0kqZ8ecG/s6LPboLMUbSGpJu
	KYwWzjGGtkfHqwII1I2DTU8ac5ioCBpVAX3rO/IXD0+QNKMNcDJrrq/eTHwo0qjZ
	7pCxg1robovR7qAiONA2jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790391671; x=1790478071; bh=K
	FQ8SOVgK/GCz1zi1dP3pEpXYGsBD/dTHbuQx3+/6fE=; b=i4m2/21UNcKMLoP72
	Nr26NwybC98whh6OhvC+n3G0NUMw6+GbsrnY+uhXMUSEQ7/RbkEHSZaVnx5bOyII
	SEFA2no1C82LkJUs1iZ57f7rySif8hKp44R1XD9KayyAFRQLsIJFrCxAsInu6foq
	5ZA2gr3DjbKX4fmc3L+8eH6H4dbuObewGAjkDPXwKcYRiMGN7mUs86vrYtt/mZXX
	kLLP7e28lKJ39azwuP78W+BkKRMgLkiTbKm6SgC6C+L/GdnThthE3Lg4mXE5/rdt
	fR2kGzBPnE7SDSIUxm1QYa58h7qy3U2U71WSgInzKvRndQd7Re8C4G9OmLnNSVfv
	6zQCA==
X-ME-Sender: <xms:dzW3aqV-1mB-VN1-TYe-JT2P0e9REIxarIIFp_QxT7fd6DUKP9JVhw>
    <xme:dzW3apIK7Pm2aWHdDc-shKLwiCjA_UgsmvuvwPQWP8pmK1Y3T0N22lAzwWe9CwxL3
    NMM_IUEp2w2NAvVYLqdfeM3VFi70cg0i4sPdRn0ih4FnNy0UQ>
X-ME-Received: <xmr:dzW3aiCBtVxy498XeVU6qjO6zdWYZA4F59ERA29NduEKBcuSMfjFkQcN5j-h1OLZb0jhSXJpUBvfd4M_uxsWNdt4iNj6dg8>
X-ME-Proxy-Cause: dmFkZTGF7YpWubyzu579fb3slujvEFieLqPzpCtc5hxEQ6L4lVNSnbIULlGqjts7qW58y+
    fiT0LsxSLxPrEUq2phpCF3WfxXmMcNSrlRUtslDj9DY6InNnwyG5ElgIv0P1ksEjQOdF4f
    dY7iP287oVHqnyKstxicoV/3t1bbil4uJDXOkyrpw/L3I98BXHu3TNEDIOa5p4FE0sizkq
    a6AG2exOvowDXytBfSSY7xF/1KMITKSh3ACkC3VrNC1i2/q8qpt8TonMIY4NtHxPlpqVK6
    U2Aym4WtB79iItXHKNcF2C4TdawhSdOFqwrf15bpfAvErmeqoRRzZIEbgC0Miv6VTckMFr
    CyHHDWkd04oCV2430jKdmE3sd3P68bZE1M3UkXGuyEp4Hn/xj5F9VlxKsoY3PjQ7lvDUtU
    F8x0hVPnE3bvSiB4c6HDxy//0DOCHa0GWXn/IJavnJfhx2UVfW4juGYy0ca0Go99uE8N5c
    aJRY0kEHSGFcoLtfsXe87Vq7KHYsXx6mWCTCZjMyb5eEIY7zhmSbpdHbeep9GAKRbqAKKq
    xW97gEm2xyPp+ZEcUcO9LK+pa+cfLPkA9e/t897oOUXyhWrE+KHchC8LCxS415dIjHZFXo
    Ov7vVJBOYwqdWS1OgKIxWDxLPa8qWgHI/h98+9mJB6BJMNXCjFQZEPzwoByQ
X-ME-Proxy: <xmx:dzW3ahdwV2JeuFHcvm6e01Kxsx-qcxA2r3M5pWxrTdzVrvd2UjO7_g>
    <xmx:dzW3ap2TozZ1l6kfEf5olaP0WpPIgWoZmZ41jOWXqdanrnOSXn6xDQ>
    <xmx:dzW3agieooZedz_9flMbXIqAfj132KafT9GllMYEzz-xmv-cpH6OPQ>
    <xmx:dzW3aql1n9Xwi_VP3PiXK1MgbcGqHVZtVvVB5gk7zbZjNoLaw_4Imw>
    <xmx:dzW3aj3qjKoirZN6c6w9rpyftHyvg7Q2RlQ85kDRF21Dvuy9Ylh31aws>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 23:01:08 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-afs@lists.infradead.org
Subject: [PATCH 1/5] afs: don't unhash/rehash dentries during unlink/rename
Date: Sat, 26 Sep 2026 12:57:20 +1000
Message-ID: <20260926030052.467448-2-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260926030052.467448-1-neilb@ownmail.net>
References: <20260926030052.467448-1-neilb@ownmail.net>
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

