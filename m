Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B813B3C1A
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 07:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779174398; cv=none; b=sjr6r43va41H7pYs/sD/hxFHjdkYupgP6w2rFqgOZeL09pa+sE7WeW96Zd2uQww1CKaEzav9qoFBU7FDPW1AHl1NX9wCmEBz0uepR7kASYnzvxHAv5OXEqLOEgihBDTsrY07+y8/bbP9JOXwB8peFbFSfrPiLHx+MfPMM+TXp6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779174398; c=relaxed/simple;
	bh=HW5J+PK3f3BS3A1CXdyNmg8aj210XJ8htALWkNXefjE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hrWz/OsYqt7R1dHGZZP1hubh0aa0C2BRlgOKxvOBs93l32A9KNGc5qHS0IzkpVVmu9yowJKO//dFXQzf1t8H/ZAPmquOiyDCXa5CTL+CPPaLT+IgJZPu4zZoqbw2AX8hwtkhc4q9cefTRylclKsHEPRPqvv70b7QcZ8vAYxDVeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=UUCaenWf; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="UUCaenWf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=KUtTioFW5HjK++B4UakO/lkKz92hN4MFXLgj7i6a3tk=; b=UUCaenWf499mKEBGjJJctG8W06
	yLXJdw7RCt+fTi/ycx31/SfVnhOubhNIBeMrV+1W9qH4tPs8WJvVXug/smb33ZjEzsgceVoyKoPzd
	TVPlBjtHy+sE4yGOMbrPwvMMiUAptrOU+jwVseeLwbF9UnYjtyOqShLWV7e066kV/qS7HmWhFfWU7
	Cw5qrfx/2FmcwuWSkuyTYcjYGvvEJZybcVWLAhRqMZiW2KW4RS29KqTJtvGGyNH5FLcmbGdXPAZXd
	/s0RAZtkaWvxcfwKABtSPjxqNdCdfuGvDtimwzddp5Ws5suR82EbcBdqoISvZoJmMUV8e/meafT/K
	qYkAFVWw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wPEXB-00000008UvK-14Kr;
	Tue, 19 May 2026 07:06:33 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [RFC PATCH 00/14] configfs cleanups and fixes
Date: Tue, 19 May 2026 08:06:19 +0100
Message-ID: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

A bunch of configfs patches; fix for UAF caught while doing dentry memory
safety audit + stuff cherry-picked from old branches, up to the minimal
switch to d_make_persistent().

There's a *lot* more still rotting in the old configfs branches (the
earliest stuff there is from back in 2018), but I would prefer to deal
with that gradually - the last thing I want is yet another variant of
the same pile sitting around to be sorted out someday ;-/

The stuff in this pile:
	* minimal UAF fix for configfs_lookup() (ancient, but you'd
need the allocation of in-core inode to fail at the right time, and if
the things are controllable for attacker to that degree, the system is
already FUBAR)
	* obvious cleanup in configfs_mkdir() - no need to do a manual
analogue of take_dentry_name_snapshot() when we are not going to modify
the copy we make.
	* sorting out the argument types for a bunch of "iterate over
configfs_dirent subtree" functions; being able to switch back and forth
between dentry and configfs_dirent (via ->d_fsdata and ->s_dentry resp.)
doesn't mean we need to without a good reason.	Passing dentry only to
use it for ->d_fsdata isn't one, especially when some callers get it as
some_configfs_dirent->s_dentry in the first place.
	* partially untangle creation and removal of directory trees;
ideally I'd like to use simple_recursive_removal() for the latter
and create-then-move-in-place for the former, but that takes a _lot_
of preliminary massage.  For now just get it to the point where we can
regularize the refcount mess - some objects are pinned once, some twice,
for no good reason.
	* switch to d_make_persistent() on creation side with
simple_rmdir() and simple_unlink() on removals.
	* sanitize attribute removal - we don't want full
__simple_unlink() there *and* we ought to lock the inode for i_nlink
updates.
	* do *not* update the timestamps of directory when looking an
attribute up; stat foo/bar shouldn't update the modification time of foo.


	Fixes aside, the main result is that configfs is finally switched
to tree-in-dcache machinery.  It's *not* making use of recursive removal
helpers yet, and it still does the bloody awful "build subtree in full
sight of userland, with possibility of failure halfway through and need
to unroll" that forces the locking model from hell; dealing with that
is a separate patch series, once this one is out of the way.  However,
it is using DCACHE_PERSISTENT properly now.  And apparmorfs is the sole
remaining user of __simple_{unlink,rmdir}() at that point.

	This branch (7.1-rc4-based) lives in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.configfs
Individual patches in followups.  It has been lightly tested, but it
obviously needs more beating.

	Review and testing would be very welcome.

Al Viro (14):
  configfs_lookup(): don't leave ->s_dentry dangling on failure
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

 fs/configfs/configfs_internal.h |   1 -
 fs/configfs/dir.c               | 225 ++++++++++++++------------------
 fs/configfs/inode.c             |  25 ----
 fs/configfs/symlink.c           |   3 +-
 4 files changed, 97 insertions(+), 157 deletions(-)

-- 
2.47.3

