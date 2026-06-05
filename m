Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D275356765
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 05:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780636157; cv=none; b=F3ay0jHI+v/lvA0BE9eIKU5d6wgBrefsAY5lToTUELdnx/sVLTkv/INeB2acAVujm7BCaCIHpWzCAeToJwDCI/APdxjl7s85YnrklcF6GmbZCXNUB7tdg38q30V+r+sxJ8vKHzKHdUMVSROndOq+K9+S+PthD/ujAruY63gyv0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780636157; c=relaxed/simple;
	bh=Y74VKCOZ0ntslaWSPoV7bkt3jDrolu7g4niyQcqBsYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KrvRIfO2hXujh/VFrcjeKZkYeyLGOuHfVTGUpo0GsKoVnZhhETLxcw0eVelwXg7UnARJLvOk8Ta0KlMQ6ZkoWR6xe2zgqL/yeqJl4+uUSi6DtELav4IdliwCCDJvRTIWscLg1NJHQgoPr8fInUK6u3LKiM4vsOOnHuEDHxfeI8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=JZfrVlGs; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="JZfrVlGs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Ew9Z98bwraRrqN7eMNTTaNj4xI1T8ZevANEy93X64c0=; b=JZfrVlGsh72iUKxzATKHHNcv2n
	uEpiOMbm0qEVmCDwcJCiFIAM0UrgjoSUUfk7icapD5lPAwzquAMyfTudfDZr8yDgjvF0xtyLvAJLV
	n9wO47pPhMcFcTryg9MwafV7wNpcOQC0+MMOESrQhF0IvaRWoqPDB4NtT/uR0WbK0ppcebUPKEHyS
	OxZ2tWC72NnIY2WAfPbArDLCOE1ymvinBbZhaI3+RNN1AY+RsrVNI1peLSggthppqGSqTtnOd6gOY
	w92150GcR2ubnYZqKvCsT1oF6LweCF+gf6cWja/ER0Tm+ew74H3dAV6F5cgBdJpZV83wC6zWPUck0
	jNBqRliA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wVMnu-00000005Trf-2OV8;
	Fri, 05 Jun 2026 05:09:11 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Subject: [PATCH v2 00/22] assorted dcache cleanups and fixes
Date: Fri,  5 Jun 2026 06:08:48 +0100
Message-ID: <20260605050910.1306432-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.54.0
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

Changes since v1:
	* rebased to -rc6
	* s/__dget_alias_careful/dget_alias_locked/, as suggested by Linus
	* fixed a braino in 9/22 (dentry_free() belongs after dropping ->d_lock)
	* first 4 "reducing rcu_read_lock() scopes..." commits consolidated into
a single step; replacement patch as posted back on May 7, with some comments added.

Currently that stuff lives in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.dcache
individual patches in followups.

Please, review.  It survives the local beating; more testing would be welcome.
If nobody has problems with it, I'm going to put it into #for-next in a few days.

Al Viro (21):
  alloc_path_pseudo(): make sure we don't end up with NORCU dentries for
    directories
  fix a race between d_find_any_alias() and final dput() of NORCU
    dentries
  find_acceptable_alias(): skip NORCU aliases with zero refcount
  select_collect(): ignore dentries on shrink lists if they have
    positive refcounts
  make to_shrink_list() return whether it has moved dentry to list
  kill d_dispose_if_unused()
  d_prune_aliases(): make sure to skip NORCU aliases
  shrink_dentry_list(): start with removing from shrink list
  fold lock_for_kill() into shrink_kill()
  fold lock_for_kill() and __dentry_kill() into common helper
  simplify safety for lock_for_kill() slowpath
  Shift rcu_read_{,un}lock() inside fast_dput()
  Document rcu_read_lock() use in select_collect2()
  adjust calling conventions of lock_for_kill(), fold __dentry_kill()
    into dentry_kill()
  document dentry_kill()
  d_walk(): shrink rcu_read_lock() scope
  shrinking rcu_read_lock() scope in d_alloc_parallel()
  shrink_dentry_tree(): unify the calls of shrink_dentry_list()
  wind ->s_roots via ->d_sib instead of ->d_hash
  nfs: get rid of fake root dentries
  make cursors NORCU

NeilBrown (1):
  VFS: use wait_var_event for waiting in d_alloc_parallel()

 Documentation/filesystems/porting.rst |  17 +
 fs/afs/dir_silly.c                    |   4 +-
 fs/dcache.c                           | 549 +++++++++++++++-----------
 fs/exportfs/expfs.c                   |   9 +-
 fs/file_table.c                       |   2 +
 fs/fuse/dir.c                         |   2 +-
 fs/fuse/readdir.c                     |   3 +-
 fs/namei.c                            |   6 +-
 fs/nfs/dir.c                          |   6 +-
 fs/nfs/getroot.c                      |  35 +-
 fs/nfs/unlink.c                       |   3 +-
 fs/proc/base.c                        |   3 +-
 fs/proc/proc_sysctl.c                 |   3 +-
 fs/smb/client/readdir.c               |   3 +-
 fs/super.c                            |   1 +
 include/linux/dcache.h                |  31 +-
 include/linux/fs/super_types.h        |   3 +-
 include/linux/nfs_xdr.h               |   1 -
 18 files changed, 387 insertions(+), 294 deletions(-)

-- 
2.47.3

