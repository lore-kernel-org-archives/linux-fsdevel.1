Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4410303A0D
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Apr 2026 18:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775153121; cv=none; b=VDyLhlaMpnkDaS0nOMgRrzQ83HKd9NIk5OQMjaCURLZKfc3fCzF28h31HZ1Lj4su5fCmxeAg20QAh8DXjI7H/kFPaTtXxhPc46wp2uq4UrhtX+gzJd+007epR03lHNrHOfJi0CAfNpk9ij6O4AwljDrTsHzuPvH67v7F8Sgksa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775153121; c=relaxed/simple;
	bh=QPL0uuvEDXRVeKv3f8n2wNsi0QJczdCAn5Z2EQT25zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q5Og5zV1oNLprQrBrqJojj/NDAJpOwZZ10ZzWbw33uUtvSZI8OzlVcJAL4xTTVWt833IY6dFjwRrn+uGwRTG5iak2X3w+9F23nK6px0J49BWesDRX+N8icr+wGSsFXP9j1YPz5H++e7xqqtaz++/5k71MiIrsF2bCi42HPA00BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=KBub56nZ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="KBub56nZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=k53IEzv+vCFVycx9KgnnDNo4ujZWxFP4AWZOpjvK0Vg=; b=KBub56nZG8mfOHq7qpsoBY4UXl
	6kOvH/ztyLpt0ePmMbWJHV1tx/KJDtB5/I4W8+0VQ6cncxT9cKG536F849gNf8Vfi7bAuVfaLCFwI
	1iIA2e8pB4OL436jkO2TdxRC/iRC4sofKkmMmuHVktW7BCtn2k3SMPQc/mNnb3xWOmXG5z94PVbC3
	RKZXMqJqk9adJXP4szAQgWCqfxc9LUUaRU15pk8xP67ot52opFj9++AVyYM4b7xCHpBW3/KtRcdNm
	4NOj//jLNLSpHSVMqTOAU37XsJUTAQbMq3Wyf8xXeVndTo33isfm1fjS4n+ZCt48SSm69zPwrJZjY
	C4ubbWig==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w8MTK-0000000FeB5-0So1;
	Thu, 02 Apr 2026 18:08:51 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Eric Sandeen <sandeen@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>
Subject: [RFC PATCH v2 0/4] getting rid of busy-wait in shrink_dcache_parent()
Date: Thu,  2 Apr 2026 19:08:45 +0100
Message-ID: <20260402180850.3729310-1-viro@zeniv.linux.org.uk>
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

[This got stalled last cycle; back then it had been a single patch, now it's
carved up, and hopefully more readable for that.  I think Linus' objections
should be addressed by that variant - no casts, no void * conversions, etc.
As the matter of fact, no type-punning and no reliance upon the layouts of
overlapping members of struct dentry either]

There's a case in which shrink_dcache_tree() ends up busy-waiting: if some
dentry in the subtree in question is found to be in process of being evicted
by another thread.  We need to wait for that to finish so that parent would
no longer be pinned, to avoid the situations when nothing in the tree is
busy, but shrink_dcache_tree() fails to evict some directory only because
memory pressure initiated eviction of some of its children before we got to
evicting those ourselves.  That would be bogus both for shrink_dcache_parent()
and for shrink_dcache_for_umount().

Unfortunately, we have nothing to wait on.  That had led to the possibility
of busy-waiting - getting through the iteration of shrink_dcache_tree() main
loop without having made any progress.  That's Not Nice(tm) and that had been
discussed quite a few times since at least 2018.  Recently it became obvious
that this goes beyond "not nice" - on sufficiently contrieved setup it's
possible to get a livelock there, with both threads involved tied to the same
CPU, shrink_dcache_tree() one with higher priority than the thread that has
given CPU up on may_sleep() in the very beginning of iput() during eviction
of the dentry in the tree shrink_dcache_tree() is busy-waiting for.

Let's get rid of that busy-waiting.  Constraints are
        * don't grow struct dentry
        * don't slow the normal case of __dentry_kill() down
Satisfying those turns out to be possible.

Dentries in question are
        * already marked dying (negative ->d_count)
        * already negative
        * already unhashed
        * already not in in-lookup hash
	* still visible in the dentry tree (reachable via ->d_sib)
        * yet to get DCACHE_DENTRY_KILLED in flags.

Neither ->d_alias (aside of several pathological places, dealt with in
#3/4) nor the members overlapping it (->d_rcu and ->d_in_lookup_hash)
are going to be accessed for these dentries until after dentry_unlist().
So we can embed struct completion into struct select_data and store
a reference to linked list of select_data instances in a new member
(->waiters) colocated with ->d_alias.  That allows to have
shrink_dcache_parent() insert its select_data to ->waiters of dying
dentry it needs to wait for and use wait_for_complete(), with complete()
coming from dentry_unlist() in case it sees non-NULL ->waiters.

No more busy-waiting there...

Branch (currently -rc6-based) lives in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.dcache-busy-wait
individual patches in followups.

Please, review.  It does survive local testing, but extra eyes would be very welcome.

Note: in -next CIFS has grown a local copy of d_mark_tmpfile(), which would need
 the same modification of sanity checks the original gets in #3/4 here.  I wonder
if that cifs_d_mark_tmpfile() should be turned into to d_mark_tmpfile_name() and
lifted into fs/dcache.c...  Anyway, that's a separate story...

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
 fs/dcache.c                           | 138 ++++++++++++++++++--------
 fs/exportfs/expfs.c                   |   2 +-
 fs/inode.c                            |   2 +-
 fs/nfs/dir.c                          |   4 +-
 fs/nfs/getroot.c                      |   2 +-
 fs/notify/fsnotify.c                  |   2 +-
 fs/ocfs2/dcache.c                     |   2 +-
 fs/overlayfs/dir.c                    |   2 +-
 fs/smb/client/inode.c                 |   2 +-
 include/linux/dcache.h                |  24 ++++-
 13 files changed, 140 insertions(+), 56 deletions(-)

Series overview:

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

Now everything is ready for adding a new member and killing busy-wait:

4) get rid of busy-waiting in shrink_dcache_tree()

If shrink_dcache_parent() runs into a potential victim that is already
dying, it must wait for that dentry to go away.  To avoid busy-waiting
we need some object to wait on and a way for dentry_unlist() to see that
we need to be notified.

The obvious place for the object to wait on would be inside struct
select_data we have on our stack frame.  We will store a pointer to
select_data in victim dentry; if there's more than one thread wanting to
wait for the same dentry to finish dying, we'll have their select_data
linked into a list, with reference in dentry pointing to the head of
that list.

* add struct completion and a pointer to the next select_data into
struct select_data; that will be what we wait on and the list linkage.

* add a new member (->waiters, opaque pointer to struct select_data)
to struct dentry.  It is defined for negative live dentries that are
not in-lookup ones and it will remain NULL for almost all of them.

It does not conflict with ->d_rcu (defined for killed dentries), ->d_alias
(defined for positive dentries, all live) or ->d_in_lookup_hash (defined
for in-lookup dentries, all live negative).  That allows to colocate
all four members.

* make sure that all places where dentry enters the state where ->waiters
is defined (live, negative, not-in-lookup) initialize ->waiters to NULL.

* if select_collect2() runs into a dentry that is already dying, have
its caller insert its select_data into the head of list that hangs off
dentry->waiters and wait for completion.

* if dentry_unlist() sees non-NULL ->waiters, have it carefully walk
through the select_data on that list, calling complete() for each.
