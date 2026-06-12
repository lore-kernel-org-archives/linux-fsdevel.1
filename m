Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09996234964;
	Fri, 12 Jun 2026 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781277351; cv=none; b=NK6AAqx13JKcs/kOyuwPaS7O+foUa2eqfNkXVCjfskCOalx7G1SJ4ZXxypA7Wpdj6EGT/T6x0t4UICCQfSK0v3v2U2qB6UsNnnEPYDggvy6rif34g43aH7gJtV06Lzu+E5sCvwz4uUziRYDjCUCKbhrJvoHQU8N8ngDqF8HrPjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781277351; c=relaxed/simple;
	bh=wzWXOkFSR2t9T1O4eg3Ux6g0kfK3w7UGpvQsKMXHW9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mL2lY2/s13tFGdzQCqCmHhR4pkKKJogrBhMsKtcYNmINVF3+kxaDpM1anGDnbMkWkBRJ4Gf6r1zVjXMKDXWWFLkbeHk0A8sQRhxsENDhAVTbdt0WZAibHpUEdgewUflPLBrkOINnYiqj6iFSH8yrZ/aKlfz5VQnSkm21HNXtOC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEFUEDzU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEFUEDzU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770991F000E9;
	Fri, 12 Jun 2026 15:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781277349;
	bh=5PW5vawg5xpswVnbiOyTSU4giBBasMb+anWjy4krkSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fEFUEDzUmfKT8xH/wu3X3yPmaAXijph7jISES9oSXx8wmqelyTfN/2KY/qBNElY4t
	 rMauK5h7bFK/7u6WjXZoaMOs/XRNoiF6kyXmTBnp6cmNqY7T5K/vXHXU5NmSTuBSkT
	 W+H706uulpOfiD3VjcEkGFse7GGyYuG2n/cCDkzF8SFc5eSqB6HN/tPD+vcYGOP7HY
	 pSyMrCCs4F80xl4saPKQhgGYptNcpLgy0gCp0MdaQmD6vZycVREE1ZHiHjrc3bMp45
	 J1wDuvSxA3Uv5lc1eX9U2fN3lc9NFi2TM/9Tv9Ew3EER02lqJPnBmvkW4qEFa1kha2
	 Ac5hsyVFg9GWg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 14/16 for v7.2] vfs xattr
Date: Fri, 12 Jun 2026 17:15:43 +0200
Message-ID: <20260612-vfs-xattr-v72-765acd2e67cc@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260612-vfs-v72-20facee87e19@brauner>
References: <20260612-vfs-v72-20facee87e19@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5156; i=brauner@kernel.org; h=from:subject:message-id; bh=wzWXOkFSR2t9T1O4eg3Ux6g0kfK3w7UGpvQsKMXHW9w=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTpKC2wnHHO7NLNbVc4ejQ2rXNkubjreN/MY6wxrH8eC c1f9srfsKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiGyMZ/mf0rHuWzmqx3mPz 7s4pJxl6V5puvT9dbeYM44wChk3LS5oY/ineKmS+uu+x+Yo/H4QfBHxN2D35iqz6zb9Le2XXBF1 sLeADAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This reworks the simple xattr api to make it more efficient and easier
to use for all consumers.

The simple_xattr hash table moves from the inode into a per-superblock
cache, removing the per-inode overhead for the common case of few or
no xattrs. The interface now passes struct simple_xattrs ** so lazy
allocation is handled internally instead of by every caller, kernfs
xattr operations on kernfs nodes shared between multiple superblocks
are properly serialized, and tmpfs constructs "security.foo" xattr
names with kasprintf() instead of kmalloc() plus two memcpy()s.

A follow-up fix links kernfs nodes to their parent before the LSM init
hook runs: with the per-sb cache kernfs_xattr_set() computes the cache
via kernfs_root(kn), which faulted on a freshly allocated node when
selinux_kernfs_init_security() called into it - reproducible as a NULL
pointer dereference on the first cgroup mkdir on SELinux-enabled
systems.

On top of this bpffs gains support for trusted.* and security.* xattrs
so that user space and BPF LSM programs can attach metadata - for
example a content hash or a security label - to pinned objects and
directories and inspect it uniformly like on other filesystems. The
store is in-memory and non-persistent, living only for the lifetime of
the mount like everything else in bpffs.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

This has merge conflicts with the bpf-next tree in kernel/bpf/inode.c
between commit 9722955b54307 ("bpf: Add simple xattr support to
bpffs") from this tree and commit b93c55b4932dd ("bpf: fix UAF by
restoring RCU-delayed inode freeing in bpffs") from the bpf-next tree,
and in include/linux/bpf.h. Reported in [1] and [2]; Daniel confirmed
the resolution in [3]. They can be resolved as follows:

[1]: https://lore.kernel.org/linux-next/aiF2rsdpUb5LuhmZ@sirena.org.uk
[2]: https://lore.kernel.org/linux-next/aiamrLm8DnCP6dbw@sirena.org.uk
[3]: https://lore.kernel.org/linux-next/8906796e-0542-46d2-bb92-9e49642d86dc@iogearbox.net

diff --cc kernel/bpf/inode.c
index c3f79b5a2f8c0,188c774a469ca..0000000000000
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@@ -842,9 -768,12 +842,13 @@@ static void bpf_destroy_inode(struct in

  	if (!bpf_inode_type(inode, &type))
  		bpf_any_put(inode->i_private, type);
 +	simple_xattrs_free(&opts->xa_cache, &bi->xattrs, NULL);
  }

+ /*
+  * Called after RCU grace period - safe to free inode and anything
+  *  that might be accessed by RCU pathwalk (inode fields, i_link).
+  */
  static void bpf_free_inode(struct inode *inode)
  {
  	if (S_ISLNK(inode->i_mode))

diff --cc include/linux/bpf.h
index 64efc3fdb7163,62bba7a4876f5..0000000000000
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@@ -31,7 -32,8 +32,9 @@@
  #include <linux/static_call.h>
  #include <linux/memcontrol.h>
  #include <linux/cfi.h>
+ #include <linux/key.h>
+ #include <linux/ftrace.h>
 +#include <linux/xattr.h>
  #include <asm/rqspinlock.h>

  struct bpf_verifier_env;

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc1.xattr

for you to fetch changes up to 9722955b54307e9070994f2382ec06af3d7405e0:

  bpf: Add simple xattr support to bpffs (2026-06-06 15:22:44 +0200)

----------------------------------------------------------------
vfs-7.2-rc1.xattr

Please consider pulling these changes from the signed vfs-7.2-rc1.xattr tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (2):
      Merge patch series "Rework simple xattrs"
      kernfs: link kn to its parent before the LSM init hook

Daniel Borkmann (1):
      bpf: Add simple xattr support to bpffs

Miklos Szeredi (4):
      kernfs: fix xattr race condition with multiple superblocks
      tmpfs: simplify constructing "security.foo" xattr names
      simple_xattr: change interface to pass struct simple_xattrs **
      simpe_xattr: use per-sb cache

 fs/kernfs/dir.c             |  22 ++--
 fs/kernfs/file.c            |  13 +--
 fs/kernfs/inode.c           |  36 +++---
 fs/kernfs/kernfs-internal.h |  24 +++-
 fs/kernfs/mount.c           |   2 +-
 fs/pidfs.c                  |  45 ++-----
 fs/xattr.c                  | 278 ++++++++++++++++++++++++++------------------
 include/linux/bpf.h         |   3 +
 include/linux/kernfs.h      |  11 +-
 include/linux/shmem_fs.h    |   3 +-
 include/linux/xattr.h       |  39 ++++---
 kernel/bpf/inode.c          | 256 +++++++++++++++++++++++++++++++++++++---
 mm/shmem.c                  |  50 +++-----
 net/socket.c                |  30 ++---
 14 files changed, 526 insertions(+), 286 deletions(-)
