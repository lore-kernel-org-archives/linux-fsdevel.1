Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351B63845B4
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 09:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776763481; cv=none; b=k2XHo5i5g1Br9HQ+hERSnXsLjpcWarYJXIpl7MrGlmAGCOnImSXeIl1rNza29skdlWo3YscoBEX5xDBUKVqCJMIXDr1tlzgbc5yO4UMH30BzMF/8GVbDNvkV4fPBTxP10fjh7faPERJhe5xBwo3BQYa9any1lAgycP9rb9ZtODg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776763481; c=relaxed/simple;
	bh=FVEtXTsOkLRcOxuOX/jo+1GFqignjV+azVbV3/v2VJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZnm4Eb/eatu2NXQkcWxWAn1UW9gvn1wPDMpyNmDMTJEm8kUcMMm7cXYKp6ja2SyAMBXyC41h4mTj4jxw6/lN7dNAuSBZWKJ1B4wIDN+qIx5j0wuu717AXvBEd85D/7D4CPLny9gxtYvt3AF2JAacGYOo9ZQKHaWY5miWoL8Yew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Td7QkI5o; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Td7QkI5o"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=d3hUISur3kszyAibTVNCgyCXCZ5lpQV5p5TQtLa8dvU=; b=Td7QkI5o4gBatyI2u/eOU4bELc
	Ik7H6M3orUwAZEFYzxkSKb7niB/VytmPBTZILrDY06+KcqZ8zaJHoWldjA1BzqJ0zfZZDobUHbr+F
	E7Hv233fwtlZGBhG7lVcrI6J0lvBbEcSSoBADDZ3H1fgmHRFrQTgT4AgEKRz3+81ICSrVU2qjVvZr
	hpuEWnQlARCofjfKEuOKdqM2Vq18/nfAcOvLymTJ5cYPSe6kNcmtzI64WrshSUieJmDdyASFV0wqb
	BRGIVqXmNbEHWfhRaz/RcEI3uso/kMS37hcHTeEPas/01P/jktP9g78xdJ87CQ0ZaY8XlfWiu2FQ9
	Qf0jc2Mg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wF7PO-00000003mzk-1LKV;
	Tue, 21 Apr 2026 09:28:42 +0000
Date: Tue, 21 Apr 2026 10:28:42 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, Nikolay Borisov <nik.borisov@suse.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Eric Sandeen <sandeen@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>
Subject: [git pull] dcache busy-wait fixes
Message-ID: <20260421092842.GD3518998@ZenIV>
References: <20260411213348.GB3836593@ZenIV>
 <20260411213454.2418381-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260411213454.2418381-1-viro@zeniv.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>

The following changes since commit 7aaa8047eafd0bd628065b15757d9b48c5f9c07d:

  Linux 7.0-rc6 (2026-03-29 15:40:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-dcache-busy-wait

for you to fetch changes up to 14a51045e10d3087b8374deef02a9d3a694132d6:

  get rid of busy-waiting in shrink_dcache_tree() (2026-04-04 04:03:56 -0400)


[one trivial conflict in Documentation/filesystems/porting.rst - appends both in
mainline and in this branch]

----------------------------------------------------------------
Fixing livelocks in shrink_dcache_tree()

If shrink_dcache_tree() finds a dentry in the middle of being killed
by another thread, it has to wait until the victim finishes dying,
gets detached from the tree and ceases to pin its parent.

The way we used to deal with that amounted to busy-wait; unfortunately,
it's not just inefficient but can lead to reliably reproducible hard
livelocks.

Solved by having shrink_dentry_tree() attach a completion to such dentry,
with dentry_unlist() calling complete() on all objects attached to it.
With a bit of care it can be done without growing struct dentry or adding
overhead in normal case.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (4):
      for_each_alias(): helper macro for iterating through dentries of given inode
      struct dentry: make ->d_u anonymous
      dcache.c: more idiomatic "positives are not allowed" sanity checks
      get rid of busy-waiting in shrink_dcache_tree()

 Documentation/filesystems/porting.rst |  10 +++
 fs/affs/amigaffs.c                    |   2 +-
 fs/ceph/mds_client.c                  |   4 +-
 fs/dcache.c                           | 129 ++++++++++++++++++++++++++--------
 fs/exportfs/expfs.c                   |   2 +-
 fs/inode.c                            |   2 +-
 fs/nfs/dir.c                          |   4 +-
 fs/nfs/getroot.c                      |   2 +-
 fs/notify/fsnotify.c                  |   2 +-
 fs/ocfs2/dcache.c                     |   2 +-
 fs/overlayfs/dir.c                    |   2 +-
 fs/smb/client/inode.c                 |   2 +-
 include/linux/dcache.h                |  24 +++++--
 13 files changed, 140 insertions(+), 47 deletions(-)
