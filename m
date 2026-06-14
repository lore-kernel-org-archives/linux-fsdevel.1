Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432A32475CB
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jun 2026 22:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781477045; cv=none; b=NmHCek+mzEdcqFq5YTauR3Uctgl1isx97HXT7RawQCFtC6tsVeI3wLESzZb0+QWxTSqGwG028uCA3//xMcEw7oODhgL6cA+qyI6o9UZhVXtMCnwg8/dt9wR9DyYB06YTmp1dxDqq7/LeRRDZxa8xE4ZNaV5Icd0OeShtBBgw6AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781477045; c=relaxed/simple;
	bh=l9iJ83eVop7YUrMVJAjpM7QeUfqDs73d3moTmbgYsS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Erfai2IRaAazRu4shD9Bzqnms7opMhN+jlv1Wi1dvUqpR5HyEZSNuz1BnvWaN61+kahRh5w/xoRxyPdqZ9H7zm99dTEcTIfwgEOnYuF80Xl/QFwShMVMNBfZLiKgvIDFMOYuszpvoCX88DiR1DXtx6Cp26pQCxe/YmPFCbZVd1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=XWpBBrxj; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="XWpBBrxj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5rc5O4y8i4qX0w3qWuHwatNb7jeGUMhSoGQxnrdSmR8=; b=XWpBBrxjR1yIDXZCcavJflwdf3
	S5glqZ4kxrhX1ijHUrfG/y0ePGTGaRIrOWa1GOygiONlQwRevvPPPxjcGm9zcuut+S+GzfDMHzdjI
	Tsoua16S3YJ6ocg87wHGtANv50d8U1UB3CX5TazG0cLOgWiaEfcQhpzpzxm8erE1Z6bSDn/EcOReh
	qkNPNK0KJOGwa38G8jP+A0roiM4NM2uCnVksox2wYReO5GX03824qTtmne2VNBwfLfXsVCAtgO90T
	2f1KX5QzxxyCk7PIT5iKEWarZGe+0uocJzLdl4QmBYfSA8wNhZBUUnZx+5+GL6QLCTL5I7yCLPell
	LFvbvy1A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wYtYe-00000006i1d-3fQT;
	Sun, 14 Jun 2026 22:44:01 +0000
Date: Sun, 14 Jun 2026 23:44:00 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [git pull] configfs cleanups and fixes (with tag on correct branch
 now)
Message-ID: <20260614224400.GT2636677@ZenIV>
References: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
 <20260603074815.3033766-1-viro@zeniv.linux.org.uk>
 <20260614223625.GR2636677@ZenIV>
 <20260614223951.GS2636677@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260614223951.GS2636677@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

The following changes since commit e43ffb69e0438cddd72aaa30898b4dc446f664f8:

  Linux 7.1-rc6 (2026-05-31 15:14:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-configfs-fixed

for you to fetch changes up to d53ac61b6120fa596d758ff6e22b5dcb6db21ce8:

  create_default_group(): pass parent's dentry instead of config_group (2026-06-08 14:55:02 -0400)

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
Al Viro (18):
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

 fs/configfs/configfs_internal.h |   1 -
 fs/configfs/dir.c               | 315 ++++++++++++++++++++--------------------
 fs/configfs/inode.c             |  25 ----
 fs/configfs/symlink.c           |   3 +-
 4 files changed, 157 insertions(+), 187 deletions(-)
