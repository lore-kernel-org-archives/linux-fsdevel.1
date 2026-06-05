Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4F23FD978
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 05:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780636158; cv=none; b=Xq0A4gbV0IIWYrs76c2RdABn/1DWuLGneBO1GmOsv2vQStQekgoWlHJCmc4QoHfkiF+7qrTen1487tX4RhbqPomJTg4naXvU0a4Sv3pgTzBmNyitbLwyBZvJ9NfbItMNvTJHQFASYtnFh+tyUXQsB0MqrscjvaW1b3zZUBLY2Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780636158; c=relaxed/simple;
	bh=OjB0deSBhcww48BzBM4i6pJmQ0Ju+YNqHTlR050Y9I0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GmqidY4JXq70AqUTQk528mSp6PTrDwU0zU3Rz3QFFLnuKloeiav3H2aLvewQsLohFr2ok+KZfB0Lyrv4HNRz3BC/9dZDa94+wHouF7eeG7uF2PddchrwXQKQTUgZyov04uBjTe4upMssaEXsX8vdagh9tgChZEyV4ws9xO2FSQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=LOT7zr91; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="LOT7zr91"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=qNX8AWaW1Kad0dVTD9jKkZWQMZROKgaQ1taV+RVv1xo=; b=LOT7zr918aMfx1Z++HxPz29Loe
	1tHqmZGc4AzdWth5S+8ADTXLJc5sLQGahg57DB0Gx4LN63syp22s9BOUKLyHWzquSav13OYhH6FzO
	fFeDDU8gNCLLyctvHI2xAvQg0fpV1oDjLEOlSj9vcEzZjot+H7/WTffU9BsOUNHm7tMwK6I9ngohU
	xW9aErWWwhzvfjeG2om5WSElvuZb/SEddct928StJMlpqd3T6n/DYToatPQ46N3hUL2p1YriO3EmD
	PW/N7CiAkqsmPDAOpxOO7WqHaqxOEpH+XeeYbR5xctwFZCIy6FjqJK2Y0GWyoaatoQ4Eiw1Dh9yPg
	/aTmuPXA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wVMny-00000005TuZ-3K77;
	Fri, 05 Jun 2026 05:09:14 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Subject: [PATCH v2 15/22] adjust calling conventions of lock_for_kill(), fold __dentry_kill() into dentry_kill()
Date: Fri,  5 Jun 2026 06:09:03 +0100
Message-ID: <20260605050910.1306432-16-viro@zeniv.linux.org.uk>
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

Pull dropping ->d_lock on lock_for_kill() failure into lock_for_kill() itself.
That reduces dentry_kill() to
	if (!lock_for_kill(dentry))
		return NULL;
	return __dentry_kill(dentry);
at which point it's easier to move that if (...) into the beginning of __dentry_kill()
itself and rename it into dentry_kill().

Document the new calling conventions of lock_for_kill().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 112 +++++++++++++++++++++++++---------------------------
 1 file changed, 54 insertions(+), 58 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index a65cb6451e63..3887d8b5f81a 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -691,57 +691,6 @@ static inline void dentry_unlist(struct dentry *dentry)
 	}
 }
 
-static struct dentry *__dentry_kill(struct dentry *dentry)
-{
-	struct dentry *parent = NULL;
-	bool can_free = true;
-
-	/*
-	 * The dentry is now unrecoverably dead to the world.
-	 */
-	lockref_mark_dead(&dentry->d_lockref);
-
-	/*
-	 * inform the fs via d_prune that this dentry is about to be
-	 * unhashed and destroyed.
-	 */
-	if (dentry->d_flags & DCACHE_OP_PRUNE)
-		dentry->d_op->d_prune(dentry);
-
-	if (dentry->d_flags & DCACHE_LRU_LIST) {
-		if (!(dentry->d_flags & DCACHE_SHRINK_LIST))
-			d_lru_del(dentry);
-	}
-	/* if it was on the hash then remove it */
-	__d_drop(dentry);
-	if (dentry->d_inode)
-		dentry_unlink_inode(dentry);
-	else
-		spin_unlock(&dentry->d_lock);
-	this_cpu_dec(nr_dentry);
-	if (dentry->d_op && dentry->d_op->d_release)
-		dentry->d_op->d_release(dentry);
-
-	cond_resched();
-	/* now that it's negative, ->d_parent is stable */
-	if (!IS_ROOT(dentry)) {
-		parent = dentry->d_parent;
-		spin_lock(&parent->d_lock);
-	}
-	spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
-	dentry_unlist(dentry);
-	if (dentry->d_flags & DCACHE_SHRINK_LIST)
-		can_free = false;
-	spin_unlock(&dentry->d_lock);
-	if (likely(can_free))
-		dentry_free(dentry);
-	if (parent && --parent->d_lockref.count) {
-		spin_unlock(&parent->d_lock);
-		return NULL;
-	}
-	return parent;
-}
-
 /*
  * Prepare locking environment for killing a dentry.
  * Called under dentry->d_lock.  To proceed with eviction of a positive dentry
@@ -763,17 +712,18 @@ static struct dentry *__dentry_kill(struct dentry *dentry)
  * provided by keeping the RCU read-side critical area contiguous with
  * an explicit rcu_read_lock() scope bridging over the break in spinlock scopes.
  *
- * Return false if dentry is busy (or busy dying, or already dead).  Otherwise,
- * return true and have that dentry's inode (if any) locked in addition to
- * dentry itself.
+ * If dentry is busy (or busy dying, or already dead), unlock dentry
+ * and return false.  Otherwise, return true and have that dentry's
+ * inode (if any) locked in addition to dentry itself.
  */
-
 static bool lock_for_kill(struct dentry *dentry)
 {
 	struct inode *inode = dentry->d_inode;
 
-	if (unlikely(dentry->d_lockref.count))
+	if (unlikely(dentry->d_lockref.count)) {
+		spin_unlock(&dentry->d_lock);
 		return false;
+	}
 
 	if (!inode || likely(spin_trylock(&inode->i_lock)))
 		return true;
@@ -798,16 +748,62 @@ static bool lock_for_kill(struct dentry *dentry)
 		return true;
 	if (inode)
 		spin_unlock(&inode->i_lock);
+	spin_unlock(&dentry->d_lock);
 	return false;
 }
 
 static struct dentry *dentry_kill(struct dentry *dentry)
 {
-	if (unlikely(!lock_for_kill(dentry))) {
+	struct dentry *parent = NULL;
+	bool can_free = true;
+
+	if (unlikely(!lock_for_kill(dentry)))
+		return NULL;
+
+	/*
+	 * The dentry is now unrecoverably dead to the world.
+	 */
+	lockref_mark_dead(&dentry->d_lockref);
+
+	/*
+	 * inform the fs via d_prune that this dentry is about to be
+	 * unhashed and destroyed.
+	 */
+	if (dentry->d_flags & DCACHE_OP_PRUNE)
+		dentry->d_op->d_prune(dentry);
+
+	if (dentry->d_flags & DCACHE_LRU_LIST) {
+		if (!(dentry->d_flags & DCACHE_SHRINK_LIST))
+			d_lru_del(dentry);
+	}
+	/* if it was on the hash then remove it */
+	__d_drop(dentry);
+	if (dentry->d_inode)
+		dentry_unlink_inode(dentry);
+	else
 		spin_unlock(&dentry->d_lock);
+	this_cpu_dec(nr_dentry);
+	if (dentry->d_op && dentry->d_op->d_release)
+		dentry->d_op->d_release(dentry);
+
+	cond_resched();
+	/* now that it's negative, ->d_parent is stable */
+	if (!IS_ROOT(dentry)) {
+		parent = dentry->d_parent;
+		spin_lock(&parent->d_lock);
+	}
+	spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
+	dentry_unlist(dentry);
+	if (dentry->d_flags & DCACHE_SHRINK_LIST)
+		can_free = false;
+	spin_unlock(&dentry->d_lock);
+	if (likely(can_free))
+		dentry_free(dentry);
+	if (parent && --parent->d_lockref.count) {
+		spin_unlock(&parent->d_lock);
 		return NULL;
 	}
-	return __dentry_kill(dentry);
+	return parent;
 }
 
 /*
-- 
2.47.3

