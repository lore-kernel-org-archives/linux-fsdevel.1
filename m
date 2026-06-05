Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E826C3BAD99
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 05:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780636157; cv=none; b=G/k5JMx5ohUV7JI4Fl/yuOYqJTYVMdLUGQ3/5Td+DSHejShfmpzDghJjq5CnLfQkhjy2OKMRGcLOdhBt1LfRi59l5JfLcAImqp0WUTHVVcgi8tk/06AcTtNXr2+JOBDl6FHYL3YBDDqwK6MvNHvBFGtrXLl1vo1p/hj4gkgJlOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780636157; c=relaxed/simple;
	bh=BYvEcoh1mE1JcR37DPFCQml4vZggZQMkM2hufc3lojg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HIA9u4V6b+dEu9lFBC9WWdyWXuREOKGnzSWYfqEh+uRu3wvLdKYhUP47XyCdN+w7r3fj09M93Jxehlhk1GV5DEIGUmpcQRCBk5yR4sr+K/QL4xJHBgple/y3+tveStf9VPDX5QQ/HplIY/lzKmTqjuirwRjlE41pc8T8jLnCDzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=h1WI8wE1; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="h1WI8wE1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=4yjgZ/n1Gr4gcqtLMmC4xG+uzbA7cDkNsM33V6lrF3c=; b=h1WI8wE17RmGJlQVT18QyAMR/R
	r1JI3EHesFaeMuZmj309UwClgEN82FVTHSjCAtFSoTLCxrElvzjcYjwtlW0RxcNaEhoO1sjlTHfcK
	mF+pnxqQFPoVnKynMOhmUMg5ntOjmSnqWv/5aAv5BnZJiVFG/di8jJr0hKABsJXN/xe3jB+uNdxSr
	9ntbcamB3hpBaJUX4QMOmmKYpI3kLMc5792O9McIO67MVlvMx7vDRJJ6EgA+lqF7SpvwjiI/eWsDS
	u0bSyoQ2XbXfQQ9jK+RjrmO2n9QbNWTLzVvCLPne8itXNdYNaEywDA9o2tngNyGQo/LWtnx3Lh2mM
	LiSA0t/Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wVMny-00000005TuS-2j46;
	Fri, 05 Jun 2026 05:09:14 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Subject: [PATCH v2 14/22] Document rcu_read_lock() use in select_collect2()
Date: Fri,  5 Jun 2026 06:09:02 +0100
Message-ID: <20260605050910.1306432-15-viro@zeniv.linux.org.uk>
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

If select_collect2() finds something that is neither busy nor can
be moved to shrink list, it needs to return that to caller's caller
(shrink_dcache_tree()) ASAP and do so without grabbing references (among
other things, it might be already dying, in which case refcount can't be
incremented).  We are called inside a ->d_lock scope, but that scope is
going to be terminated as soon as we return to caller (d_walk()); ->d_lock
will be retaken by shrink_dcache_tree(), but we need to bridge between
these scopes, turning them into contiguous RCU read-side critical area.

We do that with rcu_read_lock() scope - it spans from unbalanced
rcu_read_lock() in select_collect2() to unbalanced rcu_read_unlock()
in shrink_dcache_tree().  That works, but it really needs to be documented;
it's rather unidiomatic and it had caused quite a bit of confusion - some
of it in form of patches "fixing" the damn thing.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index ae9b7151e6a4..a65cb6451e63 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1638,6 +1638,15 @@ static enum d_walk_ret select_collect2(void *_data, struct dentry *dentry)
 
 	if (dentry->d_lockref.count <= 0) {
 		if (!__move_to_shrink_list(dentry, &data->dispose)) {
+			/*
+			 * We need an enter RCU read-side critical area that
+			 * would extend past the return from d_walk() and
+			 * we are in the scope of ->d_lock that will terminate
+			 * before that, so we use rcu_read_lock() to bridge
+			 * over to the scope of ->d_lock in d_walk() caller.
+			 * The scope of rcu_read_lock() spans from here to
+			 * paired rcu_read_unlock() in shrink_dcache_tree().
+			 */
 			rcu_read_lock();
 			data->victim = dentry;
 			return D_WALK_QUIT;
@@ -1682,9 +1691,20 @@ static void shrink_dcache_tree(struct dentry *parent, bool for_umount)
 		d_walk(parent, &data, select_collect2);
 		if (data.victim) {
 			struct dentry *v = data.victim;
-
+			/*
+			 * select_collect2() has picked a dentry that was
+			 * either dying or on a shrink list and arranged
+			 * for it to be returned to us.  We are still in
+			 * the RCU read-side critical area started there
+			 * (rcu_read_lock() scope opened in select_collect2()),
+			 * so dentry couldn't have been freed yet, but its
+			 * state might've changed since we dropped ->d_lock
+			 * on the way out.  Switch over to ->d_lock scope
+			 * and recheck the dentry state.
+			 */
 			spin_lock(&v->d_lock);
 			rcu_read_unlock();
+
 			if (v->d_lockref.count < 0 &&
 			    !(v->d_flags & DCACHE_DENTRY_KILLED)) {
 				struct completion_list wait;
-- 
2.47.3

