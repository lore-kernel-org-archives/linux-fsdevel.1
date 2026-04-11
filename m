Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFA333438F
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Apr 2026 21:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775943067; cv=none; b=V4KNal6gcjiqhDHnQoN1fGzgPiL3JvpBBuI6zWOEVYOINlO5zom5XYhKm3Q7E84UDkxsjXWyDKCDFlmmpjdUeIXoXXjasEDWe6qok00GbUwdDuMZnFufWMCGzpFamDtsnxls5MoXr4q4LXE+z6XInTVN5EfQw3O+AwJ4dsO6yzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775943067; c=relaxed/simple;
	bh=egDQ3vRox+4DY4zTVgOl2B2FVv1cbf0jL3Iu8RyPTWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=juU/d4xHyMDtw1kfLD48IPnKkEmhSTHNgsfedSRB99yndoZ35Q9Cjv0idFRQheNh6W542GcNbhyEfkKR3hexKdf04+YAsMhB04wFJkZiVLsI+l2MFCy1h51WuJV+dYUP+2EmcCSe0Ed0ndN0frW1Whbtaam1PsQLziMN9kPC+jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=MkgLl9no; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="MkgLl9no"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=qibsbPWILgAaIQU0OFNZYsP7YRt7FZxbyDAhSZycauQ=; b=MkgLl9noHYO0Z7Pjw+WTx7Kn2n
	B5MPfldNf258HubyIn6N4dQF720P2XIpa6+qJHeghS7shASUnF1I0l9vGtQZ9kSiPFqojr3tNr358
	8GcV+MrsVjgysziCSsn7Colpdn4AlQ+TyA75tz9CEX8Xh5Ue6DYMhDxgLUsLMkCKd47jmH4sj7hVy
	hFePgzv2dqw/RvG6sZaS2NVDfQqCEL7MiOwYqo/X3zZi1GRIiYCGteInROXg7r52uS4vfuLhV9xoa
	hWxGhD4CYVOdl1x+7UTKlGxH+AdxQof5XD+8rErFGRzXnNV6KwYwMuLcJm6By/oSUARQJuVMGOA5S
	T3ZA8Sgw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wBfyi-0000000A99O-0jrZ;
	Sat, 11 Apr 2026 21:34:56 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Eric Sandeen <sandeen@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>
Subject: [RFC PATCH 10/11] adjust calling conventions of lock_for_kill(), fold __dentry_kill() into dentry_kill()
Date: Sat, 11 Apr 2026 22:34:53 +0100
Message-ID: <20260411213454.2418381-10-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411213454.2418381-1-viro@zeniv.linux.org.uk>
References: <20260411213348.GB3836593@ZenIV>
 <20260411213454.2418381-1-viro@zeniv.linux.org.uk>
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
 fs/dcache.c | 99 +++++++++++++++++++++++++++--------------------------
 1 file changed, 50 insertions(+), 49 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 12786b54fd78..a848a082d056 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -691,11 +691,60 @@ static inline void dentry_unlist(struct dentry *dentry)
 	}
 }
 
-static struct dentry *__dentry_kill(struct dentry *dentry)
+/*
+ * Prepare locking environment for killing a dentry.
+ * Called under dentry->d_lock.  To proceed with eviction of a positive
+ * dentry we need to get ->i_lock of dentry inode as well and that
+ * needs to be done carefully - ->i_lock nests outside of ->d_lock,
+ * so we might need to drop and regain the latter.  We use rcu_read_lock()
+ * to keep the RCU read-side critical area contiguous, so dentry and
+ * inode won't get freed under us, but dentry state might've changed
+ * while its ->d_lock had not been held - it might end up getting
+ * killed, becoming busy, negative, etc.
+ *
+ * If dentry is busy (or busy dying, or already dead), unlock dentry
+ * and return false.  Otherwise, return true and have that dentry's
+ * inode (if any) locked in addition to dentry itself.
+ */
+static bool lock_for_kill(struct dentry *dentry)
+{
+	struct inode *inode = dentry->d_inode;
+
+	if (unlikely(dentry->d_lockref.count)) {
+		spin_unlock(&dentry->d_lock);
+		return false;
+	}
+
+	if (!inode || likely(spin_trylock(&inode->i_lock)))
+		return true;
+
+	rcu_read_lock();
+	do {
+		spin_unlock(&dentry->d_lock);
+		spin_lock(&inode->i_lock);
+		spin_lock(&dentry->d_lock);
+		if (likely(inode == dentry->d_inode))
+			break;
+		spin_unlock(&inode->i_lock);
+		inode = dentry->d_inode;
+	} while (inode);
+	rcu_read_unlock();
+	if (likely(!dentry->d_lockref.count))
+		return true;
+	if (inode)
+		spin_unlock(&inode->i_lock);
+	spin_unlock(&dentry->d_lock);
+	return false;
+}
+
+static struct dentry *dentry_kill(struct dentry *dentry)
 {
 	struct dentry *parent = NULL;
 	bool can_free = true;
 
+	if (unlikely(!lock_for_kill(dentry)))
+		return NULL;
+
 	/*
 	 * The dentry is now unrecoverably dead to the world.
 	 */
@@ -742,54 +791,6 @@ static struct dentry *__dentry_kill(struct dentry *dentry)
 	return parent;
 }
 
-/*
- * Lock a dentry for feeding it to __dentry_kill().
- * Called under rcu_read_lock() and dentry->d_lock; the former
- * guarantees that nothing we access will be freed under us.
- * Note that dentry is *not* protected from concurrent dentry_kill(),
- * d_delete(), etc.
- *
- * Return false if dentry is busy.  Otherwise, return true and have
- * that dentry's inode locked.
- */
-
-static bool lock_for_kill(struct dentry *dentry)
-{
-	struct inode *inode = dentry->d_inode;
-
-	if (unlikely(dentry->d_lockref.count))
-		return false;
-
-	if (!inode || likely(spin_trylock(&inode->i_lock)))
-		return true;
-
-	rcu_read_lock();
-	do {
-		spin_unlock(&dentry->d_lock);
-		spin_lock(&inode->i_lock);
-		spin_lock(&dentry->d_lock);
-		if (likely(inode == dentry->d_inode))
-			break;
-		spin_unlock(&inode->i_lock);
-		inode = dentry->d_inode;
-	} while (inode);
-	rcu_read_unlock();
-	if (likely(!dentry->d_lockref.count))
-		return true;
-	if (inode)
-		spin_unlock(&inode->i_lock);
-	return false;
-}
-
-static struct dentry *dentry_kill(struct dentry *dentry)
-{
-	if (unlikely(!lock_for_kill(dentry))) {
-		spin_unlock(&dentry->d_lock);
-		return NULL;
-	}
-	return __dentry_kill(dentry);
-}
-
 /*
  * Decide if dentry is worth retaining.  Usually this is called with dentry
  * locked; if not locked, we are more limited and might not be able to tell
-- 
2.47.3

