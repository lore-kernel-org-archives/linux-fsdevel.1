Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A440B42983C;
	Thu, 11 Jun 2026 17:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198073; cv=none; b=HTGZclO2sOzW/uAErregcch2JLf5cS8jCw+iaID7EtsQoHhr1q82tVhGIhqbX0k7xTU2RyHLx8XpTf2xhgJBtPRkAPwS+e6ryaFIT2EQJyDyZypNJW0kRpQOmzRwAyyb0tL9Fx53EO2a+Z8yHQ8YgqKaxrDH/rT2bhvGorz/wJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198073; c=relaxed/simple;
	bh=rQq6kElaR00sQlN0H5+3k0LCzLLxSJiBnA+f0/BSdmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eezaE4G8DbFXq4sNt7Q0EHKrRBRxnUJiNnW7hMFdBxaLRHbfMe8NrpDxWOziqOHg82zSSAT5hT1S2md799REOxbqZWau99SdlDIIS+CHN25JxS8im+x05IjznpNygcu3vOlSWENibHUPozfbBz1iVB+p/QrYTP4/X60nvf7Xy18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=RAp/YriU; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="RAp/YriU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=cXwsc3pUPuy9tdbeh5fqPCJ0B/8K72avIUsW4AewIh8=; b=RAp/YriUSB1I3QFnHLYDDA+fPg
	6Jc7Q0OsVpBqgY/CXrTkXpYIicVA7A4Eaz7L6luYvaHeVG1wtoqXswISFNfhnYi4sUXVOZCiJVhAK
	8iuUiLjQuLlEUVStDep2rDsKZq2f6hwgjyK70tB1LcmXOIWe0Y+/Qw1yxj1Hzkb8G3FCEDrKwLGrD
	HWsBtzB83VrqSxfWxfvwgzwe1D0UPqY1AqLpRCfMHVcHBkBrvX4GPYSuyUTh1zj3k7/9JbFRMUhhR
	kK6lPT7WQcYMtu95kbcwXFVUE5I5ySwjOJ9YJQdxvNcvsHNCQpXQaIYsmc8J1n91SBx98sWQMLlfF
	VApM+pfA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wXiz3-000000070lt-0M82;
	Thu, 11 Jun 2026 17:14:25 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-mm@kvack.org
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Harry Yoo <harry.yoo@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Mateusz Guzik <mjguzik@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/9] kmem_cache instances with static storage duration
Date: Thu, 11 Jun 2026 18:14:15 +0100
Message-ID: <20260611171425.1671254-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611171309.GN2636677@ZenIV>
References: <20260611171309.GN2636677@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Changes since v1:
	* milder restrictions on mergability (non-modular static cache
can be used as alias for later dynamic ones)
	* consolidated conversions into fewer commits
	* rebased to 7.1-rc6.
Branch lives in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.kmem_cache_static
individual patches in followups.

Please, review.

        kmem_cache_create() and friends create new instances of
struct kmem_cache and return pointers to those.  Quite a few things in
core kernel are allocated from such caches; each allocation involves
dereferencing an assign-once pointer and for sufficiently hot ones that
dereferencing does show in profiles.

        There had been patches floating around switching some of those
to runtime_const infrastructure.  Unfortunately, it's arch-specific
and most of the architectures lack it.

        There's an alternative approach applicable at least to the caches
that are never destroyed, which covers a lot of them.  No matter what,
runtime_const for pointers is not going to be faster than plain &,
so if we had struct kmem_cache instances with static storage duration, we
would be at least no worse off than we are with runtime_const variants.

        There are obstacles to doing that, but they turn out to be easy
to deal with.

1) as it is, struct kmem_cache is opaque for anything outside of a few
files in mm/*; that avoids serious headache with header dependencies,
etc., and it's not something we want to lose.  Solution: struct
kmem_cache_opaque, with the size and alignment identical to struct
kmem_cache.  Calculation of size and alignment can be done via the same
mechanism we use for asm-offsets.h and rq-offsets.h, with build-time
check for mismatches.  With that done, we get an opaque type defined in
linux/slab-static.h that can be used for declaring those caches.
In linux/slab.h we add a forward declaration of kmem_cache_opaque +
helper (to_kmem_cache()) converting a pointer to kmem_cache_opaque
into pointer to kmem_cache.

2) real constructor of kmem_cache needs to be taught to deal with
preallocated instances.  That turns out to be easy - we already pass an
obscene amount of optional arguments via struct kmem_cache_args, so we
can stash the pointer to preallocated instance in there.  Changes in
mm/slab_common.c are very minor - we should not merge preallocated caches
with anything already created, use the instance passed to us instead of
allocating a new one and we should not free them.  That's it.

	A set of helpers parallel to kmem_cache_create() and friends
(kmem_cache_setup(), etc.) is provided in the same linux/slab-static.h;
generally, conversion affects only a few lines.

	Note that slab-static.h is needed only in places that create
such instances; all users need only slab.h (and they can be modular,
unlike runtime_const-based approach).


	That covers the instances that never get destroyed.  Quite a few
fall into that category, but there's a major exception - anything in
modules must be destroyed before the module gets removed.  Note that
unlike runtime_constant-based approach, cache _uses_ in a module are
fine - if kmem_cache_opaque instance is exported, its address is available
to modules without any problems.  It's caches _created_ in a module
that offer an extra twist.

	Teaching kmem_cache_destroy() to skip actual freeing of given
kmem_cache instance is trivial; the problem is that kmem_cache_destroy()
may overlap with sysfs access to attributes of that cache.  In that
case kmem_cache_destroy() may return before the instance gets freed -
freeing (from slab_kmem_cache_release()) happens when the refcount of
embedded kobject drops to zero.  That's fine, since all references
to data structures in module's memory are already gone by the time
kmem_cache_destroy() returns.  That, however, relies upon the struct
kmem_cache itself not being in module's memory; getting it unmapped
before slab_kmem_cache_release() has run needs to be avoided.

	It's not hard to deal with, though.  We need to make sure that
instance in a module will get to slab_kmem_cache_release() before the
module data gets freed.  That's only a problem on sysfs setups -
otherwise it'll definitely be finished before kmem_cache_destroy()
returns.

	Note that modules themselves have sysfs-exposed attributes,
so a similar problem already exists there.  That's dealt with by
having mod_sysfs_teardown() wait for refcount of module->mkobj.kobj
reaching zero.  Let's make use of that - have static-duration-in-module
kmem_cache instances grab a reference to that kobject upon setup and
drop it in the end of slab_kmem_cache_release().

	Let setup helpers store the kobject to be pinned in
kmem_cache_args->owner (for preallocated; if somebody manually sets it
for non-preallocated case, it'll be ignored).  That would be
&THIS_MODULE->mkobj.kobj for a module and NULL in built-in.

	If sysfs is enabled and we are dealing with preallocated instance,
let create_cache() grab and stash that reference in kmem_cache->owner
and let slab_kmem_cache_release() drop it instead of freeing kmem_cache
instance.


	Costs:
* a bit (SLAB_PREALLOCATED) is stolen from slab_flags_t
* such caches can't be merged with anything preexisting (obviously)
and subsequent cache creations can't merge with static-in-module
ones.  If you want them more mergable, don't use that technics.
* you can't do kmem_cache_setup()/kmem_cache_destroy()/kmem_cache_setup()
on the same instance.  Just don't do that.

Al Viro (9):
  static kmem_cache instances for core caches
  allow static-duration kmem_cache in modules
  VFS caches: switch from runtime_const() machinery to slab-static.h
  make inode_cache statically allocated
  make mnt_cache statically allocated
  make bh_cachep statically allocated
  make seq_file_cache statically allocated
  make thread component caches (fs_cachep, files_cachep, etc.)
    statically allocated
  make ufs_inode_cache statically allocated

 Kbuild                            | 14 ++++++-
 fs/buffer.c                       |  6 ++-
 fs/dcache.c                       |  8 ++--
 fs/file_table.c                   | 40 ++++++++----------
 fs/inode.c                        |  6 ++-
 fs/namei.c                        | 16 +++----
 fs/namespace.c                    |  6 ++-
 fs/seq_file.c                     |  6 ++-
 fs/ufs/super.c                    |  9 ++--
 include/asm-generic/vmlinux.lds.h |  6 +--
 include/linux/fdtable.h           |  3 +-
 include/linux/fs_struct.h         |  3 +-
 include/linux/signal.h            |  3 +-
 include/linux/slab-static.h       | 69 +++++++++++++++++++++++++++++++
 include/linux/slab.h              | 11 +++++
 kernel/fork.c                     | 37 ++++++++++-------
 mm/kmem_cache_size.c              | 20 +++++++++
 mm/slab.h                         |  1 +
 mm/slab_common.c                  | 49 ++++++++++++++--------
 mm/slub.c                         |  7 ++++
 20 files changed, 231 insertions(+), 89 deletions(-)
 create mode 100644 include/linux/slab-static.h
 create mode 100644 mm/kmem_cache_size.c

-- 
2.47.3

