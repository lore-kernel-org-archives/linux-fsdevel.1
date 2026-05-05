Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431B03BE172
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 05:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777960442; cv=none; b=Yzj2Y7I8knM8BbTtVqF6A3x1P3t9o/h+iAc00Wk6DCDVN/0yyEVl8CdxybE/OMOy6dDkR7ZtIAmLR/XEfrsqHsc/1dneR4MA1f/JHN2toNLABZnESoKoPzH2H7LaWGBRMkYlNAT1we3zye9w77GVmoy9ZL0ye/nQtg7UdTTcypE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777960442; c=relaxed/simple;
	bh=U/1o6UPcYJOy5V59UTGnaHvEXH6qZZdGyyH0JImJbZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IPpQuf3Pwq3s8vH6x2ln/jkj/1Ce2qF9H8rzw2mlJZaCrx50nMmYvYpIs8Vfh3ukMsVPbK7Ig0P3kgz1XmKGMMgBWX6HTLynzZSqHg2cN01bOoM9CsUNQEvo9MWtjEKoxx0ACaQ0/fG7thBMM1hAkIG7//7swJZSY1zrQ6ROf5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ggfCbGg7; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ggfCbGg7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=hOYe2i0qZTSKLrGqu4pJrMnwnii1mmo5Wewj5CNCXvQ=; b=ggfCbGg766r3Umrsw2xq0APbBn
	Jv8dbRqWlBHr6i/G6nyWZB8bokU4x5bTFFQT9KXlBqnveZdgb1d84u/1GeixnwfKBgUSW0EYOdL68
	m1e2jzYE7hfi8adZczN9x3KCFIxg3gFfSyVxE4M/1i/269xV12aGAfTMslPiaIEHbW4aLSGiXgYUJ
	K36B6FWbPTdsoBiobWk3GHAV4ycLLjWFU10yZJBwnD9OS8qm0FEZSFLphmNWG3gTXc2wjBvCxTql8
	FwUxd5UBbIxfqyhIaB6PyLaJ+xJzroCEbF5yDb3Cl5t4VxmnLjiLFYouKQ8wv5TmsjVpcMaMNFcBX
	DDnPoMBw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wK8jW-00000005I5Z-13mr;
	Tue, 05 May 2026 05:54:14 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Subject: [RFC PATCH 03/25] fix a race between d_find_any_alias() and final dput() of NORCU dentries
Date: Tue,  5 May 2026 06:53:50 +0100
Message-ID: <20260505055412.1261144-4-viro@zeniv.linux.org.uk>
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

Refcount of a NORCU dentry must not be incremented after having dropped
to zero.  Otherwise we might end up with the following race:
	CPU1: in fast_dput(d), rcu_read_lock();
	CPU1: decrements refcount of d to 0
	CPU1: notice that it's unhashed
	CPU2: grab a reference to d
	CPU2: dput(d), freeing d
	CPU1: ... looks like we need to evict d, let's grab ->d_lock, recheck
	      the refcount, etc.
and that spin_lock(&d->d_lock) ends up a UAF, despite still being in
an RCU read-side critical area started back when the refcount had been
positive.  If not for DCACHE_NORCU in d->d_flags freeing would've been
RCU-delayed, so we'd have grabbed ->d_lock, noticed the negative value
stored into refcount by __dentry_kill(), dropped the locks and that would
be it.  For NORCU dentries freeing is _not_ delayed, though.

Most of the non-counting references are excluded for NORCU dentries -
they are not allowed to be hashed, they never get placed on LRU, they
never get placed into anyone's list of children and while dput_to_list()
might put them into a shrink list, nobody bumps refcount of something
that had been reached that way.

However, inode's list of aliases can be a problem - it does not contribute
to dentry refcount (for obvious reasons) and we *do* have places that
grab references to something found on that list - that's precisely what
d_find_alias() is.  In case of d_find_alias() we are safe - it skips
unhashed aliases, so all NORCU ones are ignored there.  d_find_any_alias()
is *not* limited to hashed ones, though, and while it's usually called
for directories (which never get NORCU dentries), there are callers that
use it to get something for non-directories with no hashed aliases.

Having d_find_any_alias() hit a NORCU dentry is not impossible - it can
be easily arranged if you have CAP_DAC_READ_SEARCH (memfd_create() + mmap()
+ name_to_handle_at() for /proc/self/map_files/<...> + munmap() +
open_by_handle_at() will do that, and adding a second memfd_create() for
mount_fd makes it possible to do that without having memfd pinned).
The race window is narrow, and it's probably not feasible on bare hardware,
but...

It's not hard to fix, fortunately:
	* separate __d_find_dir_alias() (== current __d_find_any_alias()) to
be used for directory inodes.
	* provide __dget_alias_careful() that would return false for NORCU
dentries with zero refcount and return true incrementing refcount otherwise
	* make __d_find_any_alias() go over the list of aliases, using
__dget_alias_careful() and returning the alias it succeeds on (normally the
first one).  Any NORCU alias with zero refcount is going to be evicted by
the thread that had dropped the final reference; this makes __d_find_any_alias()
pretend it had lost the race with eviction.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c            | 21 ++++++++++++++++++---
 include/linux/dcache.h | 18 ++++++++++++++++++
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 0aff2c510beb..923e499ffe7e 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1052,7 +1052,10 @@ struct dentry *dget_parent(struct dentry *dentry)
 }
 EXPORT_SYMBOL(dget_parent);
 
-static struct dentry * __d_find_any_alias(struct inode *inode)
+/*
+ * inode is a directory, inode->i_lock is held by the caller
+ */
+static struct dentry * __d_find_dir_alias(struct inode *inode)
 {
 	struct dentry *alias;
 
@@ -1063,6 +1066,18 @@ static struct dentry * __d_find_any_alias(struct inode *inode)
 	return alias;
 }
 
+static struct dentry * __d_find_any_alias(struct inode *inode)
+{
+	struct dentry *alias;
+
+	if (hlist_empty(&inode->i_dentry))
+		return NULL;
+	for_each_alias(alias, inode)
+		if (__dget_alias_careful(alias))
+			return alias;
+	return NULL;
+}
+
 /**
  * d_find_any_alias - find any alias for a given inode
  * @inode: inode to find an alias for
@@ -1086,7 +1101,7 @@ static struct dentry *__d_find_alias(struct inode *inode)
 	struct dentry *alias;
 
 	if (S_ISDIR(inode->i_mode))
-		return __d_find_any_alias(inode);
+		return __d_find_dir_alias(inode);
 
 	for_each_alias(alias, inode) {
 		spin_lock(&alias->d_lock);
@@ -3150,7 +3165,7 @@ struct dentry *d_splice_alias_ops(struct inode *inode, struct dentry *dentry,
 	security_d_instantiate(dentry, inode);
 	spin_lock(&inode->i_lock);
 	if (S_ISDIR(inode->i_mode)) {
-		struct dentry *new = __d_find_any_alias(inode);
+		struct dentry *new = __d_find_dir_alias(inode);
 		if (unlikely(new)) {
 			/* The reference to new ensures it remains an alias */
 			spin_unlock(&inode->i_lock);
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 97a887be150a..684aeb9e9cbe 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -365,6 +365,24 @@ static inline struct dentry *dget(struct dentry *dentry)
 	return dentry;
 }
 
+/* dentry->d_inode->i_lock must be held by caller */
+static inline bool __dget_alias_careful(struct dentry *dentry)
+{
+	if (likely(!(READ_ONCE(dentry->d_flags) & DCACHE_NORCU))) {
+		lockref_get(&dentry->d_lockref);
+		return true;
+	}
+	// NORCU dentries with zero refcount MUST NOT be grabbed
+	spin_lock(&dentry->d_lock);
+	if (dentry->d_lockref.count > 0) {
+		dget_dlock(dentry);
+		spin_unlock(&dentry->d_lock);
+		return true;
+	}
+	spin_unlock(&dentry->d_lock);
+	return false;
+}
+
 extern struct dentry *dget_parent(struct dentry *dentry);
 
 /**
-- 
2.47.3

