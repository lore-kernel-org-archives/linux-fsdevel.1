Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068A23A451D
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Apr 2026 08:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775289858; cv=none; b=hvzkfUHN3AK2cqK6rYgCOeHZkblttgIwrErPCddA4gvLJQGqlagdJ7umJ5pxxACWpi1ukbER4aXl0szjSi9VZdSF+wXGJ2wennVx8tNFzqfZ+ybvvCKz66339v62dKRXxDFyVeIEHFaHIiUudXt+GTVq7LbkrUEKrw8nn4GXy4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775289858; c=relaxed/simple;
	bh=OCVaEMVAFpi1Ie6BdFkttp468KxX8IGtv5PKrpW2hSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XiOVd9fDWUa1KNnWjwHqvLGy9+N12vtfyyP/CCHKrYLGgkqNVbp39lGJeeV6+uaU6VcpEz6ktIo7R/Cgig00tbV1ArrtXociGUKxt6h538dj5XZ2GaZOejY99mB+xYXQ8BENl3vYAMcaerDiSc8Z/9G18nzJa/cIONzHiSR8XH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=e4JLLk4D; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="e4JLLk4D"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Kq8Z9X364aQZP1ci/KpQeDHr/f6GnnOW0D3llR4V0jk=; b=e4JLLk4DxdSDn8/OCpRfN5rda4
	cj5LiWWdOXoq51+CfX4ncPtw+U6CIEzWaS3T2WFcpEbGI2mX2I62aDbPvppPUoCGEGCaRl2LxVt3/
	jiXjUGMZbiK/fhkIoSNw8RZTorHP/DHWP9+1DTNE1aKseKD6ZiOXj9LQlCPV4g+31rbzV6f4SAJXf
	22JQMc8hggjCm5sae5+syIiptC5eEnkvPoyw3hvOsC2++Y0iDqlr6tA8x+A45PKPag2Q/2JvHcXA6
	tElcmhgtke5Eb6FxecbUnM7PT3jCdPa6KXz0MCWF6nLzxQccgoaEmxTYar/URjuZkrsbyFoaHybDc
	K6sUSVTA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w8w2p-0000000AbO3-2Ojo;
	Sat, 04 Apr 2026 08:07:51 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Eric Sandeen <sandeen@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>
Subject: [RFC PATCH v3 0/4] getting rid of busy-wait in shrink_dcache_parent()
Date: Sat,  4 Apr 2026 09:07:47 +0100
Message-ID: <20260404080751.2526990-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260122202025.GG3183987@ZenIV>
References: <20260122202025.GG3183987@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Changes since v2:
	* separate select_data from the completion list elements - add a separate
struct completion_list (private to fs/dcache.c at the moment, but it's completely
independent from struct dentry and can be lifted e.g. into linux/completion.h
if there are other potential users).

Branch (currently -rc6-based) lives in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.dcache-busy-wait
individual patches in followups.  Please, review.

Shortlog:
Al Viro (4):
  for_each_alias(): helper macro for iterating through dentries of given inode
  struct dentry: make ->d_u anonymous
  dcache.c: more idiomatic "positives are not allowed" sanity checks
  get rid of busy-waiting in shrink_dcache_tree()

Diffstat:
 Documentation/filesystems/porting.rst |  10 ++
 fs/affs/amigaffs.c                    |   2 +-
 fs/ceph/mds_client.c                  |   4 +-
 fs/dcache.c                           | 129 +++++++++++++++++++-------
 fs/exportfs/expfs.c                   |   2 +-
 fs/inode.c                            |   2 +-
 fs/nfs/dir.c                          |   4 +-
 fs/nfs/getroot.c                      |   2 +-
 fs/notify/fsnotify.c                  |   2 +-
 fs/ocfs2/dcache.c                     |   2 +-
 fs/overlayfs/dir.c                    |   2 +-
 fs/smb/client/inode.c                 |   2 +-
 include/linux/dcache.h                |  24 ++++-
 13 files changed, 140 insertions(+), 47 deletions(-)

Series overview

First a couple of cleanups to reduce the amount of noise:

1) for_each_alias(): helper macro for iterating through dentries of given inode

Most of the places using d_alias are loops iterating through all aliases for
given inode; introduce a helper macro (for_each_alias(dentry, inode))
and convert open-coded instances of such loop to it.

They are easier to read that way and it reduces the noise on the next steps.

2) struct dentry: make ->d_u anonymous

Making ->d_rcu and (then) ->d_child overlapping dates back to 2006; anon unions
support had been added to gcc only in 4.6 (2011) and the minimal gcc version hadn't
been bumped to that until 4.19 (2018).
These days there's no reason not to keep that union named.

Next we get rid of the aforementioned pathologies:

3) dcache.c: more idiomatic "positives are not allowed" sanity checks

Several functions have BUG_ON/WARN_ON sanity checks that want to verify
that dentry is not positive and instead of looking at ->d_inode (as we
do in all other places that check that) they look at ->d_alias.
Just use the normal helpers instead - that way we no longer even look
at ->d_alias for negative dentries

Now that everything is ready for adding a new member and killing busy-wait:

4) get rid of busy-waiting in shrink_dcache_tree()

If shrink_dcache_tree() runs into a potential victim that is already
dying, it must wait for that dentry to go away.  To avoid busy-waiting
we need some object to wait on and a way for dentry_unlist() to see that
we need to be notified.

The obvious place for the object to wait on would be on our stack frame.
We will store a pointer to that object (struct completion_list) in victim
dentry; if there's more than one thread wanting to wait for the same
dentry to finish dying, we'll have their instances linked into a list,
with reference in dentry pointing to the head of that list.

* new object - struct completion_list.  A pair of struct completion and
pointer to the next instance.  That's what shrink_dcache_tree() will wait
on if needed.

* add a new member (->waiters, opaque pointer to struct completion_list)
to struct dentry.  It is defined for negative live dentries that are
not in-lookup ones and it will remain NULL for almost all of them.

It does not conflict with ->d_rcu (defined for killed dentries), ->d_alias
(defined for positive dentries, all live) or ->d_in_lookup_hash (defined
for in-lookup dentries, all live negative).  That allows to colocate
all four members.

* make sure that all places where dentry enters the state where ->waiters
is defined (live, negative, not-in-lookup) initialize ->waiters to NULL.

* if select_collect2() runs into a dentry that is already dying, have
its caller insert a local instance of struct completion_list into the
head of the list hanging off dentry->waiters and wait for completion.

* if dentry_unlist() sees non-NULL ->waiters, have it carefully walk
through the completion_list instances in that list, calling complete()
for each.

For now struct completion_list is local to fs/dcache.c; it's obviously
dentry-agnostic, and it can be trivially lifted into linux/completion.h
if somebody finds a reason to do so...

--
2.47.3
