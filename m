Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EB43B6C12
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 05:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780636157; cv=none; b=ME8gEnf3DI3ACfCL2vw2A/22+kuMVpuS4oMi7j0YrCROQimzAQKdEHHeNvs5AZ2PqEbea+rrqmeNr9sAWdH2xMu4HISic888WIKK9LqBkkPwOZkJW5RCK4cN1lOX/V9miffPNsPRPz7g2H985uIRblx/9Ed8O7Wb8uWohLpbBOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780636157; c=relaxed/simple;
	bh=Y8GsYoOZ1a+98z81kTz/8L1qLeSLVDrIoCB5GZxNwAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bGqKGqrJ8k5Vrmn1l2o4G4yklutYl5x11jgIs0YNeqHfKY9YIe+VYnz6nYjF+oY9PkxP/KVfWxvCY1uN7+Gb3akhNG06qSkA183jtF167CEdhKp1oNvalFR2rGrqFV88og9EtR2l+1/MImf5BOx61MDzGGclnJbQUpDdywdHeUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=QrFpYpsz; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="QrFpYpsz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=9n0KrFKLd6/4A/aNaxDjJtcg6LxbDFikD493kL21Hgs=; b=QrFpYpszzixcHFfuLQnl4YwYXR
	AgAMlkqqpa2h2Eu3RKd1K0Au5lv4HGA3svdg8QRQPhellgCR7YpV/Yi0qFtFHI+Fjd6VKePeY38cI
	SRAsnL5lDaWDKjopKiYoKyui4pZSWiCQeFW1X9uIykEgEhfnPdPIB3tqdvmQGYMpDYVvwuOe6jrmX
	e3VjFKvJX5elADEM9P7H1cll14uhvrjC96YsW7Z21qWbe1bMIxSxQOtifHvDuA67/+avRJpixKa1I
	/Iyx9LuenPIU6xzbYW49J4uZkZaG8OH9Zbd5Rsec7lAVgBbL7ijaWb0uMZ5V4vlS+Zg3IDgvROp9q
	hPw4N2mA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wVMny-00000005TuF-1jRy;
	Fri, 05 Jun 2026 05:09:14 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Subject: [PATCH v2 13/22] Shift rcu_read_{,un}lock() inside fast_dput()
Date: Fri,  5 Jun 2026 06:09:01 +0100
Message-ID: <20260605050910.1306432-14-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605050910.1306432-1-viro@zeniv.linux.org.uk>
References: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
 <20260605050910.1306432-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Shrink rcu_read_lock() scopes surrounding fast_dput() calls.
Both callers are immediately preceded and followed by
rcu_read_lock()/rcu_read_unlock() resp.  Shrink that down
into fast_dput() itself; in case when fast_dput() ends up
grabbing ->d_lock, we can pull rcu_read_unlock() up to
right after spin_lock().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 9851d387349d..ae9b7151e6a4 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -885,17 +885,17 @@ EXPORT_SYMBOL(d_mark_dontcache);
  * If unsuccessful, we return false, having already taken the dentry lock.
  * In that case refcount is guaranteed to be zero and we have already
  * decided that it's not worth keeping around.
- *
- * The caller needs to hold the RCU read lock, so that the dentry is
- * guaranteed to stay around even if the refcount goes down to zero!
  */
 static inline bool fast_dput(struct dentry *dentry)
 {
 	int ret;
 
 	/*
-	 * try to decrement the lockref optimistically.
+	 * Try to decrement the lockref optimistically.
+	 * RCU read lock held so that dentry is guaranteed to stay around
+	 * even if the refcount goes down to zero.
 	 */
+	rcu_read_lock();
 	ret = lockref_put_return(&dentry->d_lockref);
 
 	/*
@@ -905,6 +905,7 @@ static inline bool fast_dput(struct dentry *dentry)
 	 */
 	if (unlikely(ret < 0)) {
 		spin_lock(&dentry->d_lock);
+		rcu_read_unlock();
 		if (WARN_ON_ONCE(dentry->d_lockref.count <= 0)) {
 			spin_unlock(&dentry->d_lock);
 			return true;
@@ -916,8 +917,10 @@ static inline bool fast_dput(struct dentry *dentry)
 	/*
 	 * If we weren't the last ref, we're done.
 	 */
-	if (ret)
+	if (ret) {
+		rcu_read_unlock();
 		return true;
+	}
 
 	/*
 	 * Can we decide that decrement of refcount is all we needed without
@@ -925,8 +928,10 @@ static inline bool fast_dput(struct dentry *dentry)
 	 * dentry looks like it ought to be retained and there's nothing else
 	 * to do.
 	 */
-	if (retain_dentry(dentry, false))
+	if (retain_dentry(dentry, false)) {
+		rcu_read_unlock();
 		return true;
+	}
 
 	/*
 	 * Either not worth retaining or we can't tell without the lock.
@@ -934,6 +939,7 @@ static inline bool fast_dput(struct dentry *dentry)
 	 * but we'll need to re-check the situation after getting the lock.
 	 */
 	spin_lock(&dentry->d_lock);
+	rcu_read_unlock();
 
 	/*
 	 * Did somebody else grab a reference to it in the meantime, and
@@ -991,12 +997,8 @@ void dput(struct dentry *dentry)
 	if (!dentry)
 		return;
 	might_sleep();
-	rcu_read_lock();
-	if (likely(fast_dput(dentry))) {
-		rcu_read_unlock();
+	if (likely(fast_dput(dentry)))
 		return;
-	}
-	rcu_read_unlock();
 	finish_dput(dentry);
 }
 EXPORT_SYMBOL(dput);
@@ -1044,12 +1046,8 @@ EXPORT_SYMBOL(__move_to_shrink_list);
 
 void dput_to_list(struct dentry *dentry, struct list_head *list)
 {
-	rcu_read_lock();
-	if (likely(fast_dput(dentry))) {
-		rcu_read_unlock();
+	if (likely(fast_dput(dentry)))
 		return;
-	}
-	rcu_read_unlock();
 	__move_to_shrink_list(dentry, list);
 	spin_unlock(&dentry->d_lock);
 }
-- 
2.47.3

