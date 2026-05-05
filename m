Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C0F3CF049
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 05:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777960449; cv=none; b=t09gAmU3hFgl3Zfm3KfMZ8VborrZq/BC2jTLA6kpZYB54ksIIIIgKgsHN6BxIeJgCwJJNZCXi0zAPhrEjzIGeKSVwvoYsawMeMoZOVFzjNixijW3wXPjrh49Vj1v4mw/KAezOVcpkiG6zeP4FsIjgusL022z4pKGJCamlvU8LPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777960449; c=relaxed/simple;
	bh=E5Mq6YXgqGVc3yDMZeMllQ2k4zo3rRu6FMdx7xEzpXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9EztcYHiAhhRzsGYutBDatfU75z3CU2IeKQ2JnOIvwFy5U5B78U8oxKhuWD1AYPtbCWXTy6cMraL0ORFAsHhN37sL2piRH42U+ae1+TWaymHph55qe+E0/78rfIEqw8p7PSpG2/1Klgv2doGM4n+wKoMVKh5ahXO78HOvxN4EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=OrCtGq5H; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="OrCtGq5H"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=7iMs4vXA3y4WXkuG9TkyC1F9BvTvPtLk0860iqwR3Nw=; b=OrCtGq5HL8J0QhXb/g2niO/sMy
	oZnwRrovjFp+jUhuwjdLpuQCOrU8MlYjn0aBX8nirRJSgjUzYgvRRIJIbtFcDeUJcy8TBmMqNYqCg
	lQXY7clR/r7+eRXhMwBVCMofP6tVjC8YID0/n0jaybAqejDvSUzp+l1On6ZnqDV1pBzpGRBMN8A7A
	lLtKMYqjKISJx5MRlGI7um1rG9TQxJdvLmCluskfyXCT8tOM23KzrQ+vFo1ka8t8SuEqbPvql1sx4
	FxNZajYgGEoJfQt355EU9RCRsPO2S6Dt/YFUe1MN4B64Cq94iCLlycpwHnlPrkP/d1uT9KoSsoBhi
	pHU5Ncjw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wK8jg-00000005I9l-3Um7;
	Tue, 05 May 2026 05:54:25 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Subject: [RFC PATCH 21/25] shrinking rcu_read_lock() scope in d_alloc_parallel()
Date: Tue,  5 May 2026 06:54:08 +0100
Message-ID: <20260505055412.1261144-22-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
References: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

	The current use of rcu_read_lock() uses in d_alloc_parallel()
is fairly opaque - the single large scope serves two purposes.

	We start with lookup in normal hash, and there rcu_read_lock()
scope puts __d_lookup_rcu() and subsequent lockref_get_not_dead() into
the same RCU read-side critical area.

	If no match is found, we proceed to lock the hash chain of
in-lookup hash and scan that for a match.  If we find a match, we want
to grab it and wait for lookup in progress to finish.  Since the bitlock
we use for these hash chains has to nest inside ->d_lock, we need to
unlock the chain first and use lockref_get_not_dead() on the match.
That has to be done without breaking the RCU read-side critical area,
and we use the same rcu_read_lock() scope to bridge over.

	The thing is, after having grabbed the reference (and it is
very unlikely to fail) we proceed to grab ->d_lock - d_wait_lookup()
and __d_lookup_unhash()/__d_wake_in_lookup_waiters() are using that for
serialization.	That makes lockref_get_not_dead() pointless - trying
to avoid grabbing ->d_lock for refcount increment, only to grab it
anyway immediately after that.	If we grab ->d_lock first and replace
lockref_get_not_dead() with direct check for sign and increment if
non-negative we can move rcu_read_unlock() to immediately after grabbing
->d_lock.  Moreover, we don't need the RCU read-side critical area to
be contiguous since before earlier __d_lookup_rcu() - we can just as
well terminate the earlier one ASAP and call rcu_read_lock() again only
after having found a match (if any) in the in-lookup hash chain.

	That makes the entire thing easier to follow and the purpose
of those rcu_read_lock() calls easier to describe - the first scope is
for __d_lookup_rcu() + lockref_get_not_dead(), the second one bridges
over from the bitlock scope to the ->d_lock scope on the match found in
in-lookup hash.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 2a342d618303..f3c8d46867a9 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2729,38 +2729,33 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 	spin_unlock(&parent->d_lock);
 
 retry:
-	rcu_read_lock();
 	seq = smp_load_acquire(&parent->d_inode->i_dir_seq);
 	r_seq = read_seqbegin(&rename_lock);
+	rcu_read_lock();
 	dentry = __d_lookup_rcu(parent, name, &d_seq);
 	if (unlikely(dentry)) {
 		if (!lockref_get_not_dead(&dentry->d_lockref)) {
 			rcu_read_unlock();
 			goto retry;
 		}
+		rcu_read_unlock();
 		if (read_seqcount_retry(&dentry->d_seq, d_seq)) {
-			rcu_read_unlock();
 			dput(dentry);
 			goto retry;
 		}
-		rcu_read_unlock();
 		dput(new);
 		return dentry;
 	}
-	if (unlikely(read_seqretry(&rename_lock, r_seq))) {
-		rcu_read_unlock();
+	rcu_read_unlock();
+	if (unlikely(read_seqretry(&rename_lock, r_seq)))
 		goto retry;
-	}
 
-	if (unlikely(seq & 1)) {
-		rcu_read_unlock();
+	if (unlikely(seq & 1))
 		goto retry;
-	}
 
 	hlist_bl_lock(b);
 	if (unlikely(READ_ONCE(parent->d_inode->i_dir_seq) != seq)) {
 		hlist_bl_unlock(b);
-		rcu_read_unlock();
 		goto retry;
 	}
 	/*
@@ -2777,19 +2772,20 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 			continue;
 		if (!d_same_name(dentry, parent, name))
 			continue;
+		rcu_read_lock();
 		hlist_bl_unlock(b);
+		spin_lock(&dentry->d_lock);
+		rcu_read_unlock();
 		/* now we can try to grab a reference */
-		if (!lockref_get_not_dead(&dentry->d_lockref)) {
-			rcu_read_unlock();
+		if (unlikely(dentry->d_lockref.count < 0)) {
+			spin_unlock(&dentry->d_lock);
 			goto retry;
 		}
-
-		rcu_read_unlock();
 		/*
 		 * somebody is likely to be still doing lookup for it;
-		 * wait for them to finish
+		 * pin it and wait for them to finish
 		 */
-		spin_lock(&dentry->d_lock);
+		dget_dlock(dentry);
 		d_wait_lookup(dentry);
 		/*
 		 * it's not in-lookup anymore; in principle we should repeat
@@ -2810,7 +2806,6 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 		dput(new);
 		return dentry;
 	}
-	rcu_read_unlock();
 	hlist_bl_add_head(&new->d_in_lookup_hash, b);
 	hlist_bl_unlock(b);
 	return new;
-- 
2.47.3

