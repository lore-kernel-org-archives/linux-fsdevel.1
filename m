Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FDB2475CB
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jun 2026 22:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781476590; cv=none; b=ct9cWZEjbWp6he/aIsxekWJ5VlfPYv25kAmKF0mPe+UsALOmaRig195ie0HjoMknhtizB3v6RL/8kGwpm0gYE6Qbw37kmve1Un8btGcbsdKKV6LV1yM7PddJOHliUJJzuuHu1fMQOEH50nDHLbLySBzuWNauCwIIX3X7yOVTKKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781476590; c=relaxed/simple;
	bh=+6wFfJl47YaBkZvggSh+zU/ZfW4HnoLRi2cOblMXifA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTRdeyCQawY5tmstluDSGMFd1FtVD6ZdfdEr3pPfkXdQrR7DLSqHMWi8F0mFei5e0h4wdD19S5pu++sEgxIX/9/3GsLpG8GSj1Aqlg93tJVApZL0Vc8xfIWSiDW7A0Tts+mn5n+nb1jN5qJ2e3G6bPExmtt+whVSBPGJlUut+18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=JUCyVwo+; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="JUCyVwo+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qMuo9cFk+8tvvjn/xBC5E4H66nzQdaWhHWcqfnj7qXU=; b=JUCyVwo+SmQaqWhHNuwNnYWqrI
	Sscz0tau6KjQbwGzDujElJF03Lseg3ZbN4L4MatKtjbScKcikWOjXDgcqLdP6kQK2cZhmooOYk/BW
	fbn7kD0bpau7R5p1Hc+jpv99/0jXrjy4D+XJqBaT81MF8IiyEnBkkgM4NbAEXExYhQ3hymHvsBzX9
	3YtEDBoRIUXShuyagLHwf1KLNQLdLnNu7PziTBHJUh0pz9oMC61VLJRwImQSk779b1flM1Mp2/Dty
	UODFEuSwVSUIGLlMPVUc9Genq+m/DxRvU1Yu7/g69wyXyWmsEZpHNpi5nXi5CGwzPQGMnDJiIyaJ2
	crz7LKaQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wYtRJ-00000006d8y-1ffa;
	Sun, 14 Jun 2026 22:36:26 +0000
Date: Sun, 14 Jun 2026 23:36:25 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [git pull] configfs cleanups and fixes
Message-ID: <20260614223625.GR2636677@ZenIV>
References: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
 <20260603074815.3033766-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603074815.3033766-1-viro@zeniv.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>

The following changes since commit e43ffb69e0438cddd72aaa30898b4dc446f664f8:

  Linux 7.1-rc6 (2026-05-31 15:14:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-configfs

for you to fetch changes up to 45a62661733904e09b55afd078c815aed6f159a6:

  configfs_make_dirent(): remove redundant 'frag' argument (2026-06-08 14:55:43 -0400)

----------------------------------------------------------------
configfs work

A couple of fixes (UAF in configfs_lookup() and really old races
introduced when lseek() on configfs directories stopped locking those
directories; impact up to and including UAF).

Fixes aside, the main result is that configfs is finally switched
to tree-in-dcache machinery.  It's *not* making use of recursive removal
helpers yet, and it still does the bloody awful "build subtree in full
sight of userland, with possibility of failure halfway through and need
to unroll" that forces the locking model from hell; dealing with that
is a separate patch series, once this one is out of the way.  However,
it is using DCACHE_PERSISTENT properly now.  And apparmorfs is the sole
remaining user of __simple_{unlink,rmdir}() at that point.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (37):
      configfs_lookup(): don't leave ->s_dentry dangling on failure
      configfs: fix lockless traversals of ->s_children
      configfs_mkdir(): use take_dentry_name_snapshot()
      configfs_detach_prep(): pass configfs_dirent instead of dentry
      configfs_depend_prep(): pass configfs_dirent instead of dentry
      configfs_do_depend_item(): pass configfs_dirent instead of dentry
      configfs_detach_rollback(): pass configfs_dirent instead of dentry
      populate_group(): move cleanup on failure to the sole caller
      populate_attrs(): move cleanup to the sole caller
      configfs_remove_dir(), detach_attrs(): switch to passing dentry
      switch configfs_detach_{group,item}() to passing dentry
      configfs: dentry refcount needs to be pinned only once
      configfs: mark pinned dentries persistent
      kill configfs_drop_dentry()
      configfs_create(): lift parent timestamp updates into callers
      configs_attach_item(): drop unused parent_item argument
      configfs_attach_group(): drop the unused parent_item argument
      create_default_group(): pass parent's dentry instead of config_group
      configfs_remove_dirent(): switch to passing configfs_dirent
      configfs: don't leave dangling ->d_fsdata if creation fails
      new primitive: both_locked_recursive_removal()
      configfs_register_group(): expand the call of create_default_group()
      configfs: switch to locked_recursive_removal()
      kill fsnotify_rmdir()
      configfs_attach_group(): shrink the recursion loop
      unify configfs_attach_{item,group}()
      config_add_subtree(): new helper
      configfs_register_...(): switch to simple_{start,done}_creating()
      teach d_make_persistent(), ..._recursive_removal() to deal with detached trees
      configfs: attach the subtree only when it's completely built
      configfs: don't mess with locking inodes in configfs_attach()
      configfs: get rid of locking inodes when creating regular files
      kill configfs_dirent_is_ready()
      configfs: don't attach cursors until they are moved
      configfs: delay attaching the new configfs_dirent subtree
      now we no longer need to pass parent_sd when creating directories
      configfs_make_dirent(): remove redundant 'frag' argument

 Documentation/filesystems/porting.rst |   8 +
 fs/configfs/configfs_internal.h       |  14 +-
 fs/configfs/dir.c                     | 940 +++++++++++-----------------------
 fs/configfs/file.c                    |  43 --
 fs/configfs/inode.c                   |  66 +--
 fs/configfs/symlink.c                 |  15 +-
 fs/dcache.c                           |   2 +-
 fs/libfs.c                            |  61 ++-
 include/linux/fs.h                    |   2 +
 include/linux/fsnotify.h              |  13 -
 net/sunrpc/rpc_pipe.c                 |   2 +-
 11 files changed, 354 insertions(+), 812 deletions(-)
