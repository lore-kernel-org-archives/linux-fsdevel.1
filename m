Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0835F3BD643
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 05:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777960444; cv=none; b=lPd3DlQXhljQ413XyE3UrBsFTB3LMnUzlLvJCL3VbFOdEFVQ5hh/tQQ02aZHKoe7wWaJEIsD8ZuYQun5CYqELn3CyAUhdzxTU/GciH1c8eft8fHJ5V1ed4DiBT1XdeNTbPqDFBoxk0vHLjCdLLARWkWTyNNP3DT7KZkSA2YIg04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777960444; c=relaxed/simple;
	bh=jziuh2FymogpZOeZrdGNJ4LCSB3FmICnOy6ZoVG4b1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uo9PLIxANOZbDrTbJdB2ZgoSIehalxA9VP7sDAW8J7H0r7q0+C3BiM1eFRQIdaVkdzAhi44YUi/f6rFQXVj25ii10fb46Q0pIfznEp+FBl/ocl/6HbkfIiTPIdcIFVelnUWEwB7+F7H+Xm8A0onS8UTeam/D5rbYEyJ3K7SleSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=wsfOM8LB; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="wsfOM8LB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=yJq6czuxoXP2Gkb/nMmDCWpdOlfpvmenHEoTkjmfYRk=; b=wsfOM8LBPljdhMGRPIpuDZnA2E
	LPJxnOAY7laEGLTFKJDzyT/7+hqXuHrSnwb0iBWS1zletrtK8xLnOdpkVD3+X+SKGpe9vKvogFzT9
	B7ncT+OIWuLNxUcDtd2yHpleLvWWKk/zX97THQih1QISugD2UHRQdeIHgJnFOyuAuxboDTZM7IjNj
	sh5idxRMnfFMF2ayADVWbmg7yeckTOZ0LI+f63M1sdwPGohLvW7SZG2g1UW7mQS5+DXPbVxlcEZ/O
	4mKQ9oSyQgpIxJDROAH5ERL45RDiJsk3m7lauOyxSQ8aBh680YWo1u1wIBjppOBl+ZKqOLXKYujkz
	+e11cJWA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wK8jV-00000005I5P-14Nc;
	Tue, 05 May 2026 05:54:13 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Subject: [RFC PATCH 00/25] assorted dcache cleanups and fixes
Date: Tue,  5 May 2026 06:53:47 +0100
Message-ID: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

This series has grown out of trying to prove memory safety
of dentry handling; there are followups sitting in the local
tree, but those are getting reshuffled.

* d_alloc_parallel() API change (Neil's with my changes).
* NORCU fixes.
* Reorganization and simplification of dentry eviction logics.
* Reducing and documenting rcu_read_lock() scopes in fs/dcache.c
* Secondary roots work - getting rid of NFS fake root dentries and
dealing with remaining shrink_dcache_for_umount()/shrink_dentry_list()
races.
* making cursors NORCU (surprisingly easy)

Currently that stuff lives in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.dcache
individual patches in followups.

Please, review.  It survives the local beating so far, but more testing
is obviously needed.

Al Viro (24):
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
  reducing rcu_read_lock() scopes in dput and friends, step 1
  reducing rcu_read_lock() scopes in dput and friends, step 2
  reducing rcu_read_lock() scopes in dput and friends, step 3
  reducing rcu_read_lock() scopes in dput and friends, step 4
  reducing rcu_read_lock() scopes in dput and friends, step 5
  reducing rcu_read_lock() scopes in dput and friends, step 6
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
 fs/dcache.c                           | 527 +++++++++++++++-----------
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
 18 files changed, 369 insertions(+), 290 deletions(-)

-- 
2.47.3

