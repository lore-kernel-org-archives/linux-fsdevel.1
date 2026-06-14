Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FED2475CB
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jun 2026 22:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781476269; cv=none; b=aymDt1+ZyTddQ1+U28EeoDZjwXORilHQGjdBBp5mwydI5m2cCDCaj48pNrvKwPSYI3PlCdtMtkj1eghj7HzsOZcigbRk1aN4Kp3QndtBsYx9AuxGh9uiwKzAbo74VPlIznFluDBILcw4d1KeRCoM9NuXYGjFPEooO9brysr8V2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781476269; c=relaxed/simple;
	bh=HIBsoJnJVvKX884jU7aDnhwCWRzV40lbcHYUwBq1K9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unln+5BgNVwXjNimIQJOzENAe3lPq7RCXVkgm8LSIS7LsRcYOCh1AfyV9u/6OCA0KFnLdIONj8mIFNNnKImXJfaHpGY5U7lz9qhlxM72kmgsmm5fsVt7GKWRTpIp7nuLxE2EOHEei3Vb9MAn5Y/FBoeJ+GSTxu8bNJ1V8o9qOZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=IVQBS4dM; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="IVQBS4dM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fGG4sLrz1f59A82p5RtM+NHXxDhslJv8y1MRDA/1NWQ=; b=IVQBS4dM2qZC5pr9wbybXL+2ZC
	VlkdYIpDKJ37t8DYjjpolrb6Ze2dbnxB7GbA9CBinDNKMyYT0ISwrHc7wffVwWxYDKYMfTFWzjgUI
	jcuLmZo/vRMUSURUNLWVe3X728ujOl9vzyA/ibJGN8ER2uVNv4fi/1Y4mrdwTdyOOhcJJvqwDSdiS
	+iSRq7RCAULeiftTHZqN9y6yuwanve/hMroYru8+vtq2Y73wV7mn30FcatzJOH8lH5TGb4Mz+IQWd
	wtEtuPLgnKTFrnrmJ87qhtgQVrsRrK4OkSUA87uaw09gUU5P/iHsQXBh0zVAUAC3dBMeT9PiVznHn
	kwdNaIlA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wYtM8-00000006Zj8-08FC;
	Sun, 14 Jun 2026 22:31:04 +0000
Date: Sun, 14 Jun 2026 23:31:03 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>
Subject: [git pull] vfs: dcache work
Message-ID: <20260614223103.GP2636677@ZenIV>
References: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
 <20260605050910.1306432-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605050910.1306432-1-viro@zeniv.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>

The following changes since commit e43ffb69e0438cddd72aaa30898b4dc446f664f8:

  Linux 7.1-rc6 (2026-05-31 15:14:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-dcache

for you to fetch changes up to 3df5153c5f123d6018c82a24341ccd99c79d64a0:

  make cursors NORCU (2026-06-05 00:34:56 -0400)

----------------------------------------------------------------
dentry memory safety stuff

 * d_alloc_parallel() API change (Neil's with my changes).
 * NORCU fixes.
 * Reorganization and simplification of dentry eviction logics.
 * Simplifying rcu_read_lock() scopes in fs/dcache.c.
 * Secondary roots work - getting rid of NFS fake root dentries and
 dealing with remaining shrink_dcache_for_umount()/shrink_dentry_list()
 races.
 * making cursors NORCU (surprisingly easy)

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (21):
      alloc_path_pseudo(): make sure we don't end up with NORCU dentries for directories
      fix a race between d_find_any_alias() and final dput() of NORCU dentries
      find_acceptable_alias(): skip NORCU aliases with zero refcount
      select_collect(): ignore dentries on shrink lists if they have positive refcounts
      make to_shrink_list() return whether it has moved dentry to list
      kill d_dispose_if_unused()
      d_prune_aliases(): make sure to skip NORCU aliases
      shrink_dentry_list(): start with removing from shrink list
      fold lock_for_kill() into shrink_kill()
      fold lock_for_kill() and __dentry_kill() into common helper
      simplify safety for lock_for_kill() slowpath
      Shift rcu_read_{,un}lock() inside fast_dput()
      Document rcu_read_lock() use in select_collect2()
      adjust calling conventions of lock_for_kill(), fold __dentry_kill() into dentry_kill()
      document dentry_kill()
      d_walk(): shrink rcu_read_lock() scope
      shrinking rcu_read_lock() scope in d_alloc_parallel()
      shrink_dentry_tree(): unify the calls of shrink_dentry_list()
      wind ->s_roots via ->d_sib instead of ->d_hash
      nfs: get rid of fake root dentries
      make cursors NORCU

NeilBrown (1):
      VFS: use wait_var_event for waiting in d_alloc_parallel()

 Documentation/filesystems/porting.rst |  17 ++
 fs/afs/dir_silly.c                    |   4 +-
 fs/dcache.c                           | 549 ++++++++++++++++++++--------------
 fs/exportfs/expfs.c                   |   9 +-
 fs/file_table.c                       |   2 +
 fs/fuse/dir.c                         |   2 +-
 fs/fuse/readdir.c                     |   3 +-
 fs/namei.c                            |   6 +-
 fs/nfs/dir.c                          |   6 +-
 fs/nfs/getroot.c                      |  35 +--
 fs/nfs/unlink.c                       |   3 +-
 fs/proc/base.c                        |   3 +-
 fs/proc/proc_sysctl.c                 |   3 +-
 fs/smb/client/readdir.c               |   3 +-
 fs/super.c                            |   1 +
 include/linux/dcache.h                |  31 +-
 include/linux/fs/super_types.h        |   3 +-
 include/linux/nfs_xdr.h               |   1 -
 18 files changed, 387 insertions(+), 294 deletions(-)
