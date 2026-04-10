Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2826138BF76
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 08:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775810696; cv=none; b=NP3V84eapu1BhSO74U2JVgga2iXR9xDYXoho3cWKxjXHyiUHhrTj2wHf/t5l3ZGpxyWERYaPlMAiVduzuKuVsbmhbI1v+fUq5fYrQtOtc/dnf8dWCXSdLvgmIaXir8oj1CnNHFHuvG2dF64QoQxXDRGpqBEMWg9KC4mGSpjnLrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775810696; c=relaxed/simple;
	bh=MXDO6aA8bwO/EbjFuIkhb+T7V5lBSgLyk6Wmx09N0m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G6h3w8cZPQUXxz9wLQhL7dcAZD4T4ynq4RfOKztEeCQBEVv04s4rp96bfFcvryQaFtqEwl+JFxYi80Au0DXlZrVLsdad6EUfs9wa3M2sCSgLaHn/WQ2DOqA2o4UpqmIZUJjXiNs3WMkNuGGkq3aFBxXZgjPat3GWrAmSKa9fCvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=J37B/5BT; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="J37B/5BT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gR/0YTka3JzSnDdYhZqLg1QUuEyVZg1NaJI6eR7hfS4=; b=J37B/5BTUUc2GjIdnZ2FlOMdWm
	MxwocmQYlXXcfgQEq0kMFMo/JEcn3aJnaq5Ii9MK/3j8Mbbu/Rz9fLJ8eguoKl7C/HiH27l+iiPt+
	2thXBtrK80qpkvGDTM3dflj3HkSbUrVkX4VXnH6acy2J4ih2Qh4JT+RYkYGfQCBaUUE1T8Ek+uFG7
	ix7jJfHWOhRlKCPFOFDD/n/+L1T1WXkB0SpRRtsEtLJVi5B9aUtQvXyXsAzpgJbADYKzVqNBwgYaD
	AEuFx7n4NfsnAlnOstbK2D7L53b6XtJ0M/AGs1wy+RHNCe9wxaRsAm00i+OvzH8kXAeOUaZoBC1Od
	nj3NViQg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wB7Xb-00000005dP3-0VrO;
	Fri, 10 Apr 2026 08:48:39 +0000
Date: Fri, 10 Apr 2026 09:48:39 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jeff Layton <jlayton@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Eric Sandeen <sandeen@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>
Subject: [RFC][PATCH] make sure that lock_for_kill() callers drop the locks
 in safe order
Message-ID: <20260410084839.GA1310153@ZenIV>
References: <20260122202025.GG3183987@ZenIV>
 <20260404080751.2526990-1-viro@zeniv.linux.org.uk>
 <53b4795292d1df2fe1569fc724325ab52fcab322.camel@kernel.org>
 <20260409190213.GQ3836593@ZenIV>
 <41cfd0f95b7fde411c0d59463dce979be89cb8ef.camel@kernel.org>
 <20260409215733.GS3836593@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409215733.GS3836593@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

[this may or may not be the source of UAFs caught by Jeff and by Helge]

lock_for_kill() losing a race to eviction by another thread will end up
returning false (correctly - the caller should *not* evict dentry in
that case), with ->d_lock held and rcu read-critical area still unbroken,
so the caller can safely drop the locks, provided that it's done in the
right order - ->d_lock should be dropped before rcu_read_unlock().

Unfortunately, 3 of 4 callers did it the other way round and for two of them
(finish_dput() and shrink_kill()) that ended up with a possibility of UAF.
The third (shrink_dentry_list()) had been safe for other reasons (dentry being
on the shrink list => the other thread wouldn't even schedule its freeing
until observing dentry off the shrink list while holding ->d_lock), but it's
simpler to make it a general rule - in case of lock_for_kill() failure
->d_lock must be dropped before rcu_read_unlock().

UAF scenario was basically this:
	dput() drops the last reference to foo/bar and evicts it.
	The reference it held to foo happens to be the last one.
	When trylock on ->i_lock of parent's inode fails, we
	(under rcu_read_lock()) drop ->d_lock and take the locks in
	the right order; while we'd been spinning on ->i_lock somebody
	else comes and evicts the parent.
	Noticing non-zero (negative) refcount we decide there's nothing
	left to do.  And had we only dropped parent's ->d_lock before
	rcu_read_unlock(), everything would be fine.  Unfortunately,
	doing that the other way round allows rcu-scheduled freeing of
	parent to proceed before we drop its ->d_lock.
The same applies if instead of final dput() of foo/bar it gets evicted
by shrink_dcache_parent() or memory pressure, again taking out the last
reference to that used to pin its parent.

Fixes: 339e9e13530b ("don't try to cut corners in shrink_lock_dentry()")
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/dcache.c b/fs/dcache.c
index 0c8faeee02e2..b1c163f20db6 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -751,6 +751,8 @@ static struct dentry *__dentry_kill(struct dentry *dentry)
  *
  * Return false if dentry is busy.  Otherwise, return true and have
  * that dentry's inode locked.
+ *
+ * On failure the caller must drop ->d_lock *before* rcu_read_unlock()
  */
 
 static bool lock_for_kill(struct dentry *dentry)
@@ -933,8 +935,8 @@ static void finish_dput(struct dentry *dentry)
 		}
 		rcu_read_lock();
 	}
-	rcu_read_unlock();
 	spin_unlock(&dentry->d_lock);
+	rcu_read_unlock();
 }
 
 /* 
@@ -1193,11 +1195,12 @@ static inline void shrink_kill(struct dentry *victim)
 	do {
 		rcu_read_unlock();
 		victim = __dentry_kill(victim);
+		if (!victim)
+			return;
 		rcu_read_lock();
-	} while (victim && lock_for_kill(victim));
+	} while (lock_for_kill(victim));
+	spin_unlock(&victim->d_lock);
 	rcu_read_unlock();
-	if (victim)
-		spin_unlock(&victim->d_lock);
 }
 
 void shrink_dentry_list(struct list_head *list)
@@ -1210,10 +1213,10 @@ void shrink_dentry_list(struct list_head *list)
 		rcu_read_lock();
 		if (!lock_for_kill(dentry)) {
 			bool can_free;
-			rcu_read_unlock();
 			d_shrink_del(dentry);
 			can_free = dentry->d_flags & DCACHE_DENTRY_KILLED;
 			spin_unlock(&dentry->d_lock);
+			rcu_read_unlock();
 			if (can_free)
 				dentry_free(dentry);
 			continue;
