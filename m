Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E3836AB57
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 18:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776968963; cv=none; b=jYUK/VLYrjSL6zy2wOa2Ph8ZcchoxJx/5SOBBHJRrPu8J+vhhwrZyJLueoG/39icBqYIk92KAw3k3X5Hk/AcPmt4PkxJ4wqLWxpLSI01KvTYTnQdtXrK0dI1W0PcTAcWE5xrbPgR00tVOeJ3c8Ptet2ecMqv/WExP0dMzpTWjTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776968963; c=relaxed/simple;
	bh=OAvPtoS1eowlkgyDo4i33Me/hxVu7CqQI6TYuq7SmAk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RnNtAoxOH/tCRMpxoGcukEeAUROuk2WX4WrLjzc8d+OwY5nVJE3eUuZ+cBKUDZ+Yxg6G7RlB3k3zYnFt2YKeY7KHpHAWXym/M9gyOWDeHRPZnoEvUhynP/8buIqnNpJcTLm78DH+d86GmIr/w0vhBJQARv3CtHnFW10GTYzdWeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=pcMfj3xW; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pcMfj3xW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=8QLCPAF9QNVP08upvA4ErC/9+SCJAm0czC2DHidzyzc=; b=pcMfj3xWB0DMQPknd2XIWauBAb
	5e8L6RbwLOGGZJraOIuXZl7URJnVj4n0d9nLbGMUDDKtrCZglXbn8ljAdYZGjWkN1pih6swxPLwP9
	ZNSumsQ4zjcNTx1KsTy85tNyq1333GhXbXK6JkRTikKCoLdNcBHgh/q8vRMDN4MnmfVssNBm+tySm
	mL/ioAxPQtznWu2fh6GwdY14MngIX4uvGy+VdlwSyJTbSMAR680FVm+NB6iQrE8NFKFISnDqM0KeC
	KNm8S4Ldfqdy+0kFHYOe6ZsHyfnxLG0QYW2J8CLUDtgjIJjRspHHIxwHvGT9FLqvKgPSG771xHV7w
	wrJQpEsg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wFynd-0000000AakZ-3eOL;
	Thu, 23 Apr 2026 18:29:18 +0000
Date: Thu, 23 Apr 2026 19:29:17 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: [RFC] shrinking rcu_read_lock() scope in d_alloc_parallel()
Message-ID: <20260423182917.GP3518998@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	While documening rcu_read_lock() uses in fs/dcache.c, I've run
into a fairly opaque one in d_alloc_parallel() and I wonder if we would
be better off reducing that one.

	The current variant serves two purposes.  We start with lookup
in normal hash, and there it puts __d_lookup_rcu() and subsequent
lockref_get_not_dead() into the same RCU read-side critical area.
If no match is found, we proceed to lock the hash chain of in-lookup
hash and scan that for a match.  If we find a match, we want to grab
it and wait for lookup in progress to finish.  Since the bitlock we use
for these hash chains has to nest inside ->d_lock, we need to unlock
the chain first and use lockref_get_not_dead() on the match.  That
has to be done without breaking the RCU read-side critical area, and
we use the same rcu_read_lock() scope to bridge over.

	The thing is, after having grabbed the reference (and it
is very unlikely to fail) we proceed to grab ->d_lock, which makes
lockref_get_not_dead() somewhat pointless.  If we grab ->d_lock first
and replace lockref_get_not_dead() with direct check for negative
->d_lockref.count + increment if it's non-negative we can move
rcu_read_unlock() immediately after grabbing ->d_lock.  Moreover,
we don't need the RCU read-side critical area to be contiguous since
before earlier __d_lookup_rcu() - we can just as well terminate the
earlier one ASAP and call rcu_read_lock() again only after having
found a match (if any) in the in-lookup hash chain.

	That makes the entire thing easier to follow and the purpose
of those rcu_read_lock() calls easier to describe - the first scope is
for __d_lookup_rcu() + lockref_get_not_dead(), the second one bridges
over from the bitlock scope to the ->d_lock scope on the match found in
in-lookup hash.

	Does anybody see any problems with something like the delta below
(on top of current mainline)?  It seems to survive the local beating, but
then I hadn't tried it with RT configs, etc.


diff --git a/fs/dcache.c b/fs/dcache.c
index 2c61aeea41f4..08aca152fccf 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2684,38 +2684,33 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
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
@@ -2732,19 +2727,20 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
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
@@ -2765,7 +2761,6 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 		dput(new);
 		return dentry;
 	}
-	rcu_read_unlock();
 	new->d_wait = wq;
 	hlist_bl_add_head(&new->d_in_lookup_hash, b);
 	hlist_bl_unlock(b);
