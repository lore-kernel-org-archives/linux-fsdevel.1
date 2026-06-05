Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2FE35A39D
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 05:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780636157; cv=none; b=NXE0lEeYhwkc2oKc/Ar8awByWDXL6hJ1DT14uLc/Ozt1MkobyADp07LBSnkWldwDaNSglMCq/HES9bbHD/58wtoH16zNkViDPdOi678wRVwz0McETumE5nOUm9fHTgr2pEoibXWr/zTx8X8gJP861ds8asczFzJ0a80LcIoMLmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780636157; c=relaxed/simple;
	bh=XEisnoDXPBt+DTOidILzXJjsE4/2C0NR56/0os3gbNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NCn6TuoGYYNwxZST4glFaQTg2rUCP+V5lD0SsaEIzxvr2C7k43XkYMM5t2ngzM99Cdr6OsoCj6npDYuNv9BJNwow64F2LVgPaJqfvYCPtKaYji4y7zdySCRrbml49AKbM3R2gMgosFhBlcXCS16OTODtcKSWbrl3a0X2PX1dsSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=woWfsHgA; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="woWfsHgA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=klARvwFdZGMhjAOswkUbzAwHFqyNBa1v4F5+NUSIdJI=; b=woWfsHgAMsiDnRqXEwmjbyXgnP
	FzDZrKgdbc7orHueuYgd86KPIhuswHMUW0zFSQBBw0aYijVJbWDeQMI3LNDbYj+1fBqgNB80YN8yI
	6yWC6cQsQL2IvRCpctrrc7J8yxOPHgTyXvt1vtIBhIVe9MFyGjbxoJtwqXfo7fyS9/85ZVaQ/yb8/
	0RE7KsZ+MK0MQ78CHzJSlugoClAPudBCd3aBUX4nY9y6bHMkeUUjyrCu7V4IlxMlTwQoPF8KHdDYx
	BJmQsLWD1qh16yKT2E1FUVKAM4bwWgYjQoBGWTQmK+SaSkLrbEdPbUS83fmFqC/YcNxWtANtOMlE6
	JM/bKoKQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wVMnv-00000005Ts1-3DuT;
	Fri, 05 Jun 2026 05:09:11 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Subject: [PATCH v2 03/22] fix a race between d_find_any_alias() and final dput() of NORCU dentries
Date: Fri,  5 Jun 2026 06:08:51 +0100
Message-ID: <20260605050910.1306432-4-viro@zeniv.linux.org.uk>
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
	* provide dget_alias_ilocked() that would return false for NORCU
dentries with zero refcount and return true incrementing refcount otherwise
	* make __d_find_any_alias() go over the list of aliases, using
dget_alias_ilocked() and returning the alias it succeeds on (normally the
first one).  Any NORCU alias with zero refcount is going to be evicted by
the thread that had dropped the final reference; this makes __d_find_any_alias()
pretend it had lost the race with eviction.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c            | 21 ++++++++++++++++++---
 include/linux/dcache.h | 18 ++++++++++++++++++
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 0aff2c510beb..fa12e18906b9 100644
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
+		if (dget_alias_ilocked(alias))
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
index 97a887be150a..a3409de3f490 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -365,6 +365,24 @@ static inline struct dentry *dget(struct dentry *dentry)
 	return dentry;
 }
 
+/* dentry->d_inode->i_lock must be held by caller */
+static inline bool dget_alias_ilocked(struct dentry *dentry)
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

