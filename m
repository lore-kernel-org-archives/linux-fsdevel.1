Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C54A364059
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 11:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781262334; cv=none; b=gO3/og9ZrAM2HENlerzB6d/12UpffmlXk97+0nCTRfYfjlXYPaliHs80m8VBd2CED9lsws+OVNUgrHHp953mMXsKCgE95V67eOX5iDU9/Ke0LvMtROWd2oXp2RPAS2PlgLugivKBWmag60pbrrJisu/L3y9v1BTs7W3ao2kH80c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781262334; c=relaxed/simple;
	bh=uU9a06kRFzy5mC6sEUVoOzRb6H6V9i+eUd+scBX9FG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jHjTLJ3vNMqguSHfJpflfCudF9yStW78YjmFWyrRsjmlq//p4wD20PY4Q7SHw6hBf4sXQmx8J2//1aThIZL1g88e1iN/EUQD3F3sBdkckdMF2BJidFzVIQv0jxj0rKpurMNaj9U2nWfboD7EPuh8C7bIsEAaGurSpg7a/X11WrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6SjLP/U; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6SjLP/U"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5176ca6bab1so9890601cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 04:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781262331; x=1781867131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W7i05/LWULjDnDL3RKpZcgMyqERkM7NgwwG7FLfJ3o0=;
        b=T6SjLP/UFvHdWYZ+jly6rnvBv7eldKZ5wTnyPBEcVrfMyOl179fVW2NFG1W1mH0SSv
         WKPwudSPLQmMz4N5tdhX3/h7gL/7hXoqFV9067aInZZoNEmuu2T2AupLC2j+w1FBmXJb
         sxiqeAoFdNB1s8YDLgER02Vk0oOxgMk7z8t+TqeFk9ZBur1sNkwYsL4H7sIUA5sm+fg+
         uDzsUklOyfkNt634ZEfX1YOy5NT2VCNRU6DrL0c+5F+y7xB5LWbC95LFJoShuY2jBKoh
         GxhB4xGyswO/BYoAkhL2PdOxi+qhjJ4yqLDGvHp+wvlrsy1r+mPKevTaBIlzH3tzL/2X
         gAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781262331; x=1781867131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7i05/LWULjDnDL3RKpZcgMyqERkM7NgwwG7FLfJ3o0=;
        b=q4cKLztLR7/Z2DVH2Mx4nQ9dB8+tbL6Kz9cTFWdwqu7bjNdzMsea3TTytPLxOJ/h8l
         VPaj+UN3HDOkQVUGOcXKi7fWu9oiQ3ne2ragtJtlfUXKtePW8n25AIET9k955bWsE7RA
         0JXfazpB+I5aDq6FOvO9oVhwUVt8Vxr3Jy1PsEPQDxLl8bHsbfV5+itFyqGKolRoeLly
         AI0eP7gXgWlxD7xD2fOOyBni7WRqsJYMAXVIbeSgSEb5Vhu82Qxb0sgeAXrqXxdXVPqA
         Kjp6Ex/1XGUn1LQj6bIPzJ5cI8LTUH6WgfC/DIbM+FA31NZWxHshcI/syDr4z6A10FdP
         kjnQ==
X-Forwarded-Encrypted: i=1; AFNElJ/pBXV2StgAoQL7McNyaBvbeIKUIEGquVG8nYnFY1BRkqKXOgnpjcslVLuUtkW/eOFISe9JfS1GUq4USZGe@vger.kernel.org
X-Gm-Message-State: AOJu0YxfLLiYknSB8dmSodEmfHB5I48ZZL9bk6wpg9+uqMuQMosFJM9T
	Ebnn2qUSq30mvuX4/y9TvnjUejdCFydahl3ZJGNtqjjRl/Rnljq/O5hk
X-Gm-Gg: Acq92OHzf8OMfKsxxZmzE48K/yQijqw8TVgI9EowjImsyZJZyZZPSqmXCrYPh5SrdR8
	u7euBDCF/tl5C2mXShwNTEN04N+R+lA5lTkgeM6Cp5YjYsu0Ws/XqZ+cLvdqoLihWFjQ51jpkP+
	j2yuR+/5NT1w8B+LzW6sdmigdigKQt0hDlU6bWDjIPJ/29U+1JURETYvkHi+HgfGrwYMdJeLV+e
	v6MbfM8oZmHQkytuy+r85vrAhUdz5yGtMk9/DeIJ0MDy6UeJyyIUqMQF0r8CuT/4ZyTxTLkxagz
	lFD+NY3sdFDFJhRuc+gOi7puPfq6Nv+509twpWjUq+65qwCVcRplw78OqpFvGCRSlob5p0B8yRQ
	9E9LjY8IP4Q+fwjC1gwqUEzTL3A3iv+jtf72HB7uqR+THUuBUSf75un6fdLCPp0SknM2RgqB2Fx
	d3fjcHcLaY5jc4Hh8cDdrOwRmnn7GKMeLtszJqW0Mfm7A=
X-Received: by 2002:a05:622a:14c8:b0:516:ddfa:b6b9 with SMTP id d75a77b69052e-517fbe619e8mr32473931cf.23.1781262331088;
        Fri, 12 Jun 2026 04:05:31 -0700 (PDT)
Received: from Adams-MBP-8.home ([142.188.47.64])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb61fb15sm18424721cf.5.2026.06.12.04.05.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 12 Jun 2026 04:05:30 -0700 (PDT)
From: "A. Sterling" <adam.sterling@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pidfs: pin stashed dentry for pid lifetime to fix repeat-open regression
Date: Fri, 12 Jun 2026 07:05:29 -0400
Message-ID: <20260612110529.80055-1-adam.sterling@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit cb12fd8e0dab ("pidfd: add pidfs") moved pidfds from anonymous
inodes to a pseudo filesystem, with the intent that pid->stashed would
cache the dentry+inode across multiple pidfd_open() calls for the same
struct pid.  Commit b28ddcc32d8f ("pidfs: convert to path_from_stashed()
helper") realized that intent via the stashed_dentry_get() fast-path.

In practice the stash cache never hits for serial open/close patterns.
pidfs dentries are anonymous (d_alloc_anon) and the superblock raises
DCACHE_DONTCACHE, so dput() at close() drops the refcount to zero and
immediately destroys the dentry.  __dentry_kill -> d_prune ->
stashed_dentry_prune cmpxchg()es pid->stashed back to NULL, and the
last iput() runs pidfs_evict_inode().  The next pidfd_open() finds an
empty stash slot and reallocates both the inode (new_inode_pseudo +
simple_inode_init_ts + sops->init_inode) and the dentry (d_alloc_anon
+ d_instantiate + cmpxchg into the stash slot).

Measured with a small benchmark that times a single pidfd_open()
syscall on a live process, best-of-k per run (written for this
investigation as part of an extended fork of the LEBench suite,
Ren et al. SOSP'19; the test is not part of upstream LEBench).
QEMU/KVM x86_64 guest, 5 runs per kernel, RSD <1%, kernels v5.19
to v7.1-rc2:

                            v5.19   v6.0    v6.9 (pidfs)   v7.1-rc2
  pidfd_open kbest (us)      0.40   0.39          [step]       0.50

i.e. ~25% slower than the pre-pidfs anon_inode baseline, persistent
through current.  The cost is a kmem_cache_alloc on inode_cachep + a
clock read (simple_inode_init_ts) + a kmem_cache_alloc on dentry_cache
per call, all of which can be elided when the stash cache hits.

With this patch applied to v7.1-rc4 (same guest, median kbest
across 5 boots, kernels built with the pidfd selftest config
requirements enabled):

                            v7.1-rc4 stock   v7.1-rc4 + patch
  pidfd_open kbest (us)          0.489           0.349  (-28.6%)

All eight buildable pidfd kselftest suites (41 tests, including the
file_handle suite that exercises the stashed-dentry path with
CLONE_NEWUSER children) pass identically on the stock and patched
kernels.

The patched kernel is faster than the pre-pidfs anon_inode baseline
(0.40 us at v5.19/v6.0): a stash hit reuses the cached dentry and
inode outright, where the anon_inode path still performed per-call
file setup against the shared inode.

Fix by holding an extra reference to the stashed dentry for as long as
the task is alive.  pidfs_alloc_file() takes a dget() on the first
successful path_from_stashed() per pid, recorded by a new
PIDFS_ATTR_BIT_STASH_PINNED bit in pid->attr->attr_mask.  pidfs_exit()
-- which already runs in sleepable context from release_task() --
drops the reference.

pidfs_alloc_file() is reachable after pidfs_exit() has already run:
SO_PEERPIDFD and SCM_PIDFD hold struct pid references on sockets and
can allocate pidfds for already-reaped peers (the PIDFD_STALE path).
A pin taken on that path could never be dropped, since pidfs_exit()
will not run again.  Both the pin and the unpin therefore take
pid->wait_pidfd.lock -- the lock pidfs_exit() already uses to
synchronize with pidfs_register_pid() -- and the pin is skipped once
PIDFS_ATTR_BIT_EXIT is set:

  - pin before exit's unpin section: the unpin sees the bit, drops
    the reference.  Balanced.
  - exit's unpin section before the pin attempt: PIDFS_ATTR_BIT_EXIT
    is set before the unpin section, so the later allocation observes
    it under the lock and does not pin.  Stale allocations behave as
    they do today (per-call inode+dentry), which is acceptable: the
    cache targets live processes.

The unpin's dput() runs outside the lock (pidfs_exit() is sleepable;
dput must not run under a spinlock).  While pinned, the reference
keeps the dentry alive, so stashed_dentry_prune() cannot run and
pid->stashed still points at the pinned dentry when pidfs_exit()
reads it.

Unpinning at pidfs_free_pid() instead is not possible: the pinned
dentry holds the inode, the inode holds a pid reference
(pidfs_evict_inode() does put_pid()), so the pid refcount cannot
reach zero while the pin is held and pidfs_free_pid() would never
run.

Memory cost is one inode (~800 B) + one dentry (~200 B) per pid that
has ever had a pidfd allocated, held until release_task() instead of
until the last fd close.  Bounded by pid_max.  Tasks that never have
a pidfd allocated are unaffected.

The existing VFS_WARN_ON_ONCE(pid->stashed) assertion in
pidfs_free_pid() is preserved: the exit-time dput triggers the
existing teardown chain (__dentry_kill -> stashed_dentry_prune ->
pidfs_evict_inode) before pidfs_free_pid runs.

Fixes: cb12fd8e0dab ("pidfd: add pidfs")
Assisted-by: Claude:claude-fable-5
Signed-off-by: A. Sterling <adam.sterling@gmail.com>
---
 fs/pidfs.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -44,8 +44,9 @@
 }
 
 enum pidfs_attr_mask_bits {
-	PIDFS_ATTR_BIT_EXIT	= 0,
-	PIDFS_ATTR_BIT_COREDUMP	= 1,
+	PIDFS_ATTR_BIT_EXIT		= 0,
+	PIDFS_ATTR_BIT_COREDUMP		= 1,
+	PIDFS_ATTR_BIT_STASH_PINNED	= 2,
 };
 
 struct pidfs_anon_attr {
@@ -725,6 +726,7 @@
 {
 	struct pid *pid = task_pid(tsk);
 	struct pidfs_attr *attr;
+	struct dentry *unpin = NULL;
 #ifdef CONFIG_CGROUPS
 	struct cgroup *cgrp;
 #endif
@@ -765,6 +767,23 @@
 	/* Ensure that PIDFD_GET_INFO sees either all or nothing. */
 	smp_wmb();
 	set_bit(PIDFS_ATTR_BIT_EXIT, &attr->attr_mask);
+
+	/*
+	 * Drop the per-pid stash reference taken by pidfs_alloc_file()
+	 * (see PIDFS_ATTR_BIT_STASH_PINNED).  The wait_pidfd.lock guard
+	 * orders this against the pin in pidfs_alloc_file(): once
+	 * PIDFS_ATTR_BIT_EXIT is visible under the lock, no new pin can
+	 * be taken.  dput() runs outside the lock; on the final
+	 * reference it triggers __dentry_kill -> stashed_dentry_prune
+	 * -> pidfs_evict_inode, the existing teardown path.
+	 */
+	scoped_guard(spinlock_irq, &pid->wait_pidfd.lock) {
+		if (test_and_clear_bit(PIDFS_ATTR_BIT_STASH_PINNED,
+				       &attr->attr_mask))
+			unpin = READ_ONCE(pid->stashed);
+	}
+	if (unpin)
+		dput(unpin);
 }
 
 #ifdef CONFIG_COREDUMP
@@ -1151,6 +1170,32 @@
 
 	VFS_WARN_ON_ONCE(!pid->attr);
 
+	/*
+	 * Pin the stashed dentry for the lifetime of the task so that
+	 * repeat pidfd_open() on the same pid reuses the cached dentry
+	 * + inode instead of reallocating both each time.  Anonymous
+	 * pidfs dentries don't enter the dcache LRU (DCACHE_DONTCACHE),
+	 * so without an explicit reference the dput() at close()
+	 * immediately destroys the dentry and, via
+	 * stashed_dentry_prune, the inode.
+	 *
+	 * Skip the pin once PIDFS_ATTR_BIT_EXIT is set: pidfs_exit()
+	 * has run (or is running) and will not run again, so a
+	 * reference taken now could never be dropped (stale
+	 * allocations via SO_PEERPIDFD reach here after
+	 * release_task()).  The wait_pidfd.lock guard makes the EXIT
+	 * check and the pin atomic against the unpin in pidfs_exit().
+	 */
+	scoped_guard(spinlock_irq, &pid->wait_pidfd.lock) {
+		struct pidfs_attr *attr = pid->attr;
+
+		if (!IS_ERR_OR_NULL(attr) &&
+		    !test_bit(PIDFS_ATTR_BIT_EXIT, &attr->attr_mask) &&
+		    !test_and_set_bit(PIDFS_ATTR_BIT_STASH_PINNED,
+				      &attr->attr_mask))
+			dget(path.dentry);
+	}
+
 	flags &= ~PIDFD_STALE;
 	flags |= O_RDWR;
 	pidfd_file = dentry_open(&path, flags, current_cred());
-- 
2.45.1
