Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A8628030E
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 02:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782957853; cv=none; b=BDUBw8FqT50Thrxl39bhnXQNWhb83cTsffMXT1MYT+rc+znSbuVNoWmvz4gQ6hbIUL7Jpu1jwKcC5yrOGXqk658YGwfmSN/mKUbXm0gbUZpZEu1aySLpX3Lirzifm2DozJ0o2rGkUpkgCwgAJ8O/NpmdMF4xQ+fhz8y/2c1xLiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782957853; c=relaxed/simple;
	bh=TTLVwpFnjw/vdSw1Ye+Z8QP2VnkOut9vgYNXPiylSVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SFAO9xwczwmYiSC6WnEOd3N4bcD3c8zg0IrKrTk/GV6HaLniVAHcdIXgao1LRI3sXrW2X+TEg0Pzwq2mxtGCZ+ZtWVEXKtJ/uqId5hpDIeFJ/8YYaSdoX3d0aMgfDqsYn8t/r6RcWaupN3zKpYWxrsPkj3a+LyFvjlzxYWwPUxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=BAou5NaO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DjKGPOJB; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="BAou5NaO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DjKGPOJB"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EDCB51400143;
	Wed,  1 Jul 2026 22:04:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 01 Jul 2026 22:04:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1782957850;
	 x=1783044250; bh=5lSGYiUVovvCZlqK7Higlps49OWTiKRhCsZotTeHk0I=; b=
	BAou5NaO10O47TSQMmR5TM7v9DhFI6A4RO+cZYCB+lbyyyN4sEdSyVRx5tvqqLvG
	FUbPAe6XzsEspJKL4V/aZAZjIwckURp185cuTV4dHngcaKQk+wA1G0OBVhm251oM
	s1moj2za6f7LEZ8B5FX/LY8JmDQsP4vboM4abMlDVeEI6doKAWzjRH0bNhdb9z9Y
	k0LhH+rSVzhhkkcp3jstnwa7v7HyEWIHao270BE+lu7A+vTB8LNocAScNVecb3QZ
	6ovKcE4wYWR5zQbiFmPfX3yujXGvAU3diwSlwoOd0s6q8s5jSFHl7NM2ZhP5rNDb
	QVFCQ+7oyq4WyL1/AAdzEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1782957850; x=1783044250; bh=5
	lSGYiUVovvCZlqK7Higlps49OWTiKRhCsZotTeHk0I=; b=DjKGPOJBrtkshQh51
	glwSMcyNn8K4NIM4hAgKx4QOHpIs2I6yysw/DMyYREwVnQdF+JOO6Hkj5wDbO5iR
	HKfWfjYa2JawUREMzuBvFxIEFb7Wzu6xE/V5sNfmw4b893GvxbUvvUbo7ymQoc3T
	47KGXy56dQQeCfyNAv2FtTIHBsr9d7EANlGYLfQYP9Xucm59VQn5oeyTo4//ygk+
	Q2cDkig7qg5Jzl8AOdIktVTcW1qq5ddFHxcX2X5GIRLwe663ZEWiVJ7yokGP/y37
	/iOox4LwQdeZ4e410K+cCOfbn/X+gVjQLXKfJK8L7Jyvz1NDWXqMSlOzvRQ6baC7
	5RGsA==
X-ME-Sender: <xms:GsdFakbL5HwlxiPkbUJ8aN6-KPWRMKULnKhQ65ZZ5zMqMd8Ob0AwXw>
    <xme:GsdFatN-s62V47_6-WGfMWY3dbScIwHBHnvtR2WjBJmuKzm_q5arl1Sjm9eNbNi2K
    pXAbHBcB_oV3s_RlgBcj8RVea62HEjCVr81xcrET3HQp_mt7g>
X-ME-Received: <xmr:GsdFapbHI8tfm6kSkawAhCiJ2mLqs-zfgyeJuEuk_CvAA-MAUqji4ceIL9mVzKDSwasc0FGyIXBQ6LyMOWXEIKq5hWDsZnU>
X-ME-Proxy-Cause: dmFkZTFBM60NYNvBYVyZBJE7BtjskAnRB5cF+Y5CxG3dl8xBiQ1DVZb41zrTInBF3jaFxm
    8+pPgR3R2Hfs3MGbv9VeKwHM9g6bR4S8J9RYmIMfjSsamA40CBcf6BittuEXs10PMgrBl4
    5Fk2UwQsXXBr66XU1RXhOjZA4QKgC/Pany22UKsouDAb3b0oU3RdJL8TvIW0PF3Qko6oB1
    1B+CuhKSqihZYX4BnH5PD4WuPf/MvTKb3I8QFENVwoGJWFzI9/VXlZvH40Ips6pT1dbbMr
    AdmQyItGacXgN4qLa13lvxsNwQdSnvAgFn7BN72ReAo4Xg001h8PE2+wAtfvzyrjptUTXA
    QQJUzGlF1K41HWELIBGSfN9597s7z39i46HvDfR9FzauYhpFlx5WTTl8XtNgTl9jnG/Gjn
    xIKTiXdjf/8I+8mHKXOHS9KuBMxPjAOu/iM5LwLrUcFWziZ4t3+V6zCJXKtD8f/gGmAhi/
    BddqMaFA0yf6cH/m+CIJ28CI7W7jhSLrTcEeSzqgixzqvPpI6Oa/bELgWPtFUNYANCWlwt
    ntfO4SV2kzhzg+rqAYfEcv+FpWFD4hC66qSlTjA7t3wnAazdwPUHimqIKLK85rH6wgrm+K
    pgVIoiOtCmkrkJwZnoSsgud0dedbXHi9eOQOrz+H4AK520ha2emqqenhLlRQ
X-ME-Proxy: <xmx:GsdFar0MawSld0s5jnGuVZhuIuZ2qrIlvRgjKzdP9y_jTO9m67UdfQ>
    <xmx:GsdFavdNLTsN94M379GQU9DycCJH2JlhBXHBaTFfEHsv3IlbwYcIUQ>
    <xmx:GsdFasECNxO2o55rGl-lPBP4idyxwc-u4K2Mhn9Bngr7LUgB5UeM2w>
    <xmx:GsdFag0l5CX0WCQGGA55y24ZdBz61eyjVfZ8yN6tWZePeZCDV3rlXQ>
    <xmx:GsdFagARyUMESPfyMIVWS6r8Km1y6NDyX6jxyve-fjBpeMfo0MglzoJ4>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 22:04:09 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>
Cc: linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] afs: don't unhash/rehash dentries during unlink/rename
Date: Thu,  2 Jul 2026 11:58:30 +1000
Message-ID: <20260702020350.3403907-3-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260702020350.3403907-1-neilb@ownmail.net>
References: <20260702020350.3403907-1-neilb@ownmail.net>
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

This patch copies a mechanism developed for NFS.  ->d_fsdata which is
currently unused is now set to a non-NULL value when lookups must be
blocked.  d_revalidate checks for this value, and waits for it to become
NULL.

->d_lock is used to ensure d_revalidate never updates ->d_time while
->d_fsdata is set.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/afs/afs.h      |  7 ++++++
 fs/afs/dir.c      | 64 +++++++++++++++++++++++++++++------------------
 fs/afs/internal.h |  5 +---
 3 files changed, 47 insertions(+), 29 deletions(-)

diff --git a/fs/afs/afs.h b/fs/afs/afs.h
index ec3db00bd081..019e77b08458 100644
--- a/fs/afs/afs.h
+++ b/fs/afs/afs.h
@@ -26,6 +26,13 @@ typedef u64			afs_volid_t;
 typedef u64			afs_vnodeid_t;
 typedef u64			afs_dataversion_t;
 
+/* This is stored in ->d_fsdata to stop d_revalidate looking at,
+ * and possibly changing, ->d_time on a dentry which is being moved
+ * between directories, and to block lookup for dentry that is
+ * being removed without silly-rename.
+ */
+#define AFS_FSDATA_BLOCKED ((void*)1)
+
 typedef enum {
 	AFSVL_RWVOL,			/* read/write volume */
 	AFSVL_ROVOL,			/* read-only volume */
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 7ff84b410097..e9aaf66218ea 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -1021,6 +1021,10 @@ static int afs_d_revalidate_rcu(struct afs_vnode *dvnode, struct dentry *dentry)
 	if (!afs_check_validity(dvnode))
 		return -ECHILD;
 
+	/* A rename/unlink is pending */
+	if (dentry->d_fsdata)
+		return -ECHILD;
+
 	/* We only need to invalidate a dentry if the server's copy changed
 	 * behind our back.  If we made the change, it's no problem.  Note that
 	 * on a 32-bit system, we only have 32 bits in the dentry to store the
@@ -1056,6 +1060,10 @@ static int afs_d_revalidate(struct inode *parent_dir, const struct qstr *name,
 	if (flags & LOOKUP_RCU)
 		return afs_d_revalidate_rcu(dir, dentry);
 
+	/* Wait for rename/unlink to complete */
+wait_for_rename:
+	wait_var_event(&dentry->d_fsdata, dentry->d_fsdata == NULL);
+
 	if (d_really_is_positive(dentry)) {
 		vnode = AFS_FS_I(d_inode(dentry));
 		_enter("{v={%llx:%llu} n=%pd fl=%lx},",
@@ -1148,7 +1156,13 @@ static int afs_d_revalidate(struct inode *parent_dir, const struct qstr *name,
 	}
 
 out_valid:
+	spin_lock(&dentry->d_lock);
+	if (dentry->d_fsdata) {
+		spin_unlock(&dentry->d_lock);
+		goto wait_for_rename;
+	}
 	dentry->d_time = (unsigned long)dir_version;
+	spin_unlock(&dentry->d_lock);
 out_valid_noupdate:
 	key_put(key);
 	_leave(" = 1 [valid]");
@@ -1523,8 +1537,7 @@ static void afs_unlink_edit_dir(struct afs_operation *op)
 static void afs_unlink_put(struct afs_operation *op)
 {
 	_enter("op=%08x", op->debug_id);
-	if (op->unlink.need_rehash && afs_op_error(op) < 0 && afs_op_error(op) != -ENOENT)
-		d_rehash(op->dentry);
+	store_release_wake_up(&op->dentry->d_fsdata, NULL);
 }
 
 static const struct afs_operation_ops afs_unlink_operation = {
@@ -1578,11 +1591,7 @@ static int afs_unlink(struct inode *dir, struct dentry *dentry)
 		afs_op_set_error(op, afs_sillyrename(dvnode, vnode, dentry, op->key));
 		goto error;
 	}
-	if (!d_unhashed(dentry)) {
-		/* Prevent a race with RCU lookup. */
-		__d_drop(dentry);
-		op->unlink.need_rehash = true;
-	}
+	dentry->d_fsdata = AFS_FSDATA_BLOCKED;
 	spin_unlock(&dentry->d_lock);
 
 	op->file[1].vnode = vnode;
@@ -1889,9 +1898,10 @@ static void afs_rename_edit_dir(struct afs_operation *op)
 
 	_enter("op=%08x", op->debug_id);
 
-	if (op->rename.rehash) {
-		d_rehash(op->rename.rehash);
-		op->rename.rehash = NULL;
+	if (op->rename.unblock) {
+		/* Rename has finished, so unlocks lookups to target */
+		store_release_wake_up(&op->rename.unblock->d_fsdata, NULL);
+		op->rename.unblock = NULL;
 	}
 
 	fscache_begin_write_operation(&orig_cres, afs_vnode_cache(orig_dvnode));
@@ -1974,6 +1984,9 @@ static void afs_rename_exchange_edit_dir(struct afs_operation *op)
 
 		d_exchange(old_dentry, new_dentry);
 		up_write(&orig_dvnode->validate_lock);
+	/* dentry has been moved, so d_validate can safely proceed */
+	store_release_wake_up(&old_dentry->d_fsdata, NULL);
+
 	} else {
 		down_write(&orig_dvnode->validate_lock);
 		if (test_bit(AFS_VNODE_DIR_VALID, &orig_dvnode->flags) &&
@@ -2013,11 +2026,10 @@ static void afs_rename_exchange_edit_dir(struct afs_operation *op)
 static void afs_rename_put(struct afs_operation *op)
 {
 	_enter("op=%08x", op->debug_id);
-	if (op->rename.rehash)
-		d_rehash(op->rename.rehash);
+	if (op->rename.unblock)
+		store_release_wake_up(&op->rename.unblock->d_fsdata, NULL);
+	store_release_wake_up(&op->dentry->d_fsdata, NULL);
 	dput(op->rename.tmp);
-	if (afs_op_error(op))
-		d_rehash(op->dentry);
 }
 
 static const struct afs_operation_ops afs_rename_operation = {
@@ -2125,7 +2137,6 @@ static int afs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		op->ops		= &afs_rename_noreplace_operation;
 	} else if (flags & RENAME_EXCHANGE) {
 		op->ops		= &afs_rename_exchange_operation;
-		d_drop(new_dentry);
 	} else {
 		/* If we might displace the target, we might need to do silly
 		 * rename.
@@ -2139,14 +2150,12 @@ static int afs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		 */
 		if (d_is_positive(new_dentry) && !d_is_dir(new_dentry)) {
 			/* To prevent any new references to the target during
-			 * the rename, we unhash the dentry in advance.
+			 * the rename, we set d_fsdata which afs_d_revalidate will wait for.
+			 * d_lock ensures d_count() and ->d_fsdata are consistent.
 			 */
-			if (!d_unhashed(new_dentry)) {
-				d_drop(new_dentry);
-				op->rename.rehash = new_dentry;
-			}
-
+			spin_lock(&new_dentry->d_lock);
 			if (d_count(new_dentry) > 2) {
+				spin_unlock(&new_dentry->d_lock);
 				/* copy the target dentry's name */
 				op->rename.tmp = d_alloc(new_dentry->d_parent,
 							 &new_dentry->d_name);
@@ -2164,8 +2173,12 @@ static int afs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 				}
 
 				op->dentry_2 = op->rename.tmp;
-				op->rename.rehash = NULL;
 				op->rename.new_negative = true;
+			} else {
+				/* Block any lookups to target until the rename completes */
+				new_dentry->d_fsdata = AFS_FSDATA_BLOCKED;
+				op->rename.unblock = new_dentry;
+				spin_unlock(&new_dentry->d_lock);
 			}
 		}
 	}
@@ -2176,10 +2189,11 @@ static int afs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	 * d_revalidate may see old_dentry between the op having taken place
 	 * and the version being updated.
 	 *
-	 * So drop the old_dentry for now to make other threads go through
-	 * lookup instead - which we hold a lock against.
+	 * So block revalidate on the old_dentry until the rename completes.
 	 */
-	d_drop(old_dentry);
+	spin_lock(&old_dentry->d_lock);
+	old_dentry->d_fsdata = AFS_FSDATA_BLOCKED;
+	spin_unlock(&old_dentry->d_lock);
 
 	ret = afs_do_sync_operation(op);
 	if (ret == -ENOTSUPP)
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index a22027935482..a0afe552ae64 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -900,10 +900,7 @@ struct afs_operation {
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
-- 
2.50.0.107.gf914562f5916.dirty

