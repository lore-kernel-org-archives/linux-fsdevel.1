Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC34B3537EF;
	Wed,  8 Apr 2026 18:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672903; cv=none; b=fYNLhHeofhdBBfFKbyC5G9zkgpXoI3f5rXOeXWr9fGk0+3nNHblHVnACjdzQQGrNLocTVkOpwpTVSesO4O7v506VF4Nm6su7mUqmj6ft4Jubzq+3i3FxBFDkNiQkoyOC1JLwwPf0Y/NZSccjOBhpFogFzFX05FPrK/OF9cNl9oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672903; c=relaxed/simple;
	bh=CL0FXxVPzsCOjfk/Q8/ufWpILq4QDS39p3t7y0XPEBU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a7dnnZ/WkgtTpf8PgUtdkcsVN32TInriRJuDymsUBy8xiDkRYnZQmgeC+we8i9S7Rn5JOIFyIczkkY7p7D+HpFW069x0/ZiDOxx+Q615tE27wg3+5N0nql94CpbXEufNgquM1pV7OeRhpaBsbZerq/HT9J7WY6ZQYQxPI67gfkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/ozZPU5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/ozZPU5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE596C19425;
	Wed,  8 Apr 2026 18:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775672903;
	bh=CL0FXxVPzsCOjfk/Q8/ufWpILq4QDS39p3t7y0XPEBU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Y/ozZPU5Hcpqslp1lyzE8AWvm534QM39SJuMnHK6MyCvZKzA0pfB+7kFn5V+qeoxZ
	 OG3FEN76Ir1XTtW+Yh2/8zv4YzkqV7C/Sz8/iGQa7TpRiGlxV55A/T3S+0hc8Ee6PT
	 qV12F4y6rGQPd92mIJNZDuub0i0ShZo2MLsR8g2FUCaujfPyxG5r9983R0nSz/w8oT
	 vBy6IOkobtXB4uxu/ah3H27S1dlhRPbNj3J77/8l3WL/8oIdrK7OAoM6iWhylmb5wP
	 5rqwasCXCk2ShHQzgag25JUadbwKZAEUIonEmE71+BEVodXoZMVg7NA60DYWbLQ3T3
	 a5SdTUYY/duRg==
Message-ID: <f44d1047296ede580c69bdad8e527ac8294746ec.camel@kernel.org>
Subject: Re: [PATCH] dcache: warn when a dentry is freed with a non-empty
 ->d_lru
From: Jeff Layton <jlayton@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, clm@meta.com, 
	gustavold@meta.com
Date: Wed, 08 Apr 2026 14:28:20 -0400
In-Reply-To: <20260408064251.GE3836593@ZenIV>
References: <20260406-dcache-warn-v1-1-c665efbc005f@kernel.org>
	 <20260408064251.GE3836593@ZenIV>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-04-08 at 07:42 +0100, Al Viro wrote:
> On Mon, Apr 06, 2026 at 12:44:13PM -0400, Jeff Layton wrote:
> > We've had a number of panics that seem to occur on hosts with heavy
> > process churn. The symptoms are a panic when invalidating /proc entries
> > as a task is exiting:
> >=20
> > queued_spin_lock_slowpath+0x153/0x270
> > shrink_dentry_list+0x11d/0x220
> > shrink_dcache_parent+0x68/0x110
> > d_invalidate+0x90/0x170
> > proc_invalidate_siblings_dcache+0xc8/0x140
> > release_task+0x41b/0x510
> > do_exit+0x3d8/0x9d0
> > do_group_exit+0x7d/0xa0
> > get_signal+0x2a9/0x6a0
> > arch_do_signal_or_restart+0x1a/0x1c0
> > syscall_exit_to_user_mode+0xe6/0x1c0
> > do_syscall_64+0x74/0x130
> > entry_SYSCALL_64_after_hwframe+0x4b/0x53
> >=20
> > The problem appears to be a UAF. It's freeing a shrink list of
> > dentries, but one of the dentries on it has already been freed.
>=20
> That, or dentry pointer passed to shrink_dcache_parent() is a
> complete garbage - e.g. due to struct pid having already been
> freed.  Might make sense to try and get a crash dump and poke
> around...
>=20

Chris was able to track me down a vmcore.

No, it actually does seem to be what we thought originally. The parent
is fine, but one of the dentries under it has been freed and
reallocated:

>>> stack
#0  queued_spin_lock_slowpath (kernel/locking/qspinlock.c:471:3)
#1  spin_lock (./include/linux/spinlock.h:351:2)
#2  lock_for_kill (fs/dcache.c:675:3)
#3  shrink_dentry_list (fs/dcache.c:1086:8)
#4  shrink_dcache_parent (fs/dcache.c:0)
#5  d_invalidate (fs/dcache.c:1614:2)
#6  proc_invalidate_siblings_dcache (fs/proc/inode.c:142:5)
#7  proc_flush_pid (fs/proc/base.c:3478:2)
#8  release_task (kernel/exit.c:279:2)
#9  exit_notify (kernel/exit.c:775:3)
#10 do_exit (kernel/exit.c:958:2)
#11 do_group_exit (kernel/exit.c:1087:2)
#12 get_signal (kernel/signal.c:3036:3)
#13 arch_do_signal_or_restart (arch/x86/kernel/signal.c:337:6)
#14 exit_to_user_mode_loop (kernel/entry/common.c:111:4)
#15 exit_to_user_mode_prepare (./include/linux/entry-common.h:329:13)
#16 __syscall_exit_to_user_mode_work (kernel/entry/common.c:207:2)
#17 syscall_exit_to_user_mode (kernel/entry/common.c:218:2)
#18 do_syscall_64 (arch/x86/entry/common.c:89:2)
#19 entry_SYSCALL_64+0x6c/0xaa (arch/x86/entry/entry_64.S:121)
#20 0x7f49ead2c482
>>> identify_address(stack[3]["dentry"])
'slab object: kmalloc-96+0x48'
>>> identify_address(stack[4]["parent"])
'slab object: dentry+0x0'

...it turns out that Gustavo had been chasing this independently to me,
and had Claude do a bit more analysis. I included it below, but here's
a link that may be more readable. Any thoughts?

https://markdownpastebin.com/?id=3D7c258413493b4144ab27d5cdcb8ae5b4

-------------8<----------------------

## dcache: `shrink_dcache_parent()` livelock leading to use-after-free

### Summary

A race between concurrent proc dentry invalidation (`proc_flush_pid` =E2=86=
=92
`d_invalidate` =E2=86=92 `shrink_dcache_parent`) and the global dentry shri=
nker
(`drop_caches` / memory pressure =E2=86=92 `prune_dcache_sb`) causes
`shrink_dcache_parent()` to loop indefinitely. This livelock is the
root cause of the use-after-free crash observed in production (see
P2260313060 for the original crash analysis).

### How the bug manifests

**In production** (narrow race window): The livelock occasionally
resolves through specific timing that allows a parent dentry to be
freed and its slab page reused. When a sibling's `__dentry_kill` then
tries `spin_lock(&parent->d_lock)` on the reused memory =E2=86=92 page faul=
t in
`queued_spin_lock_slowpath` (Oops).

**With `CONFIG_DCACHE_SHRINK_RACE_DEBUG`** (5ms delay in
`__dentry_kill`): The race is deterministic. `shrink_dcache_parent()`
livelocks on the first iteration and never completes.

### Root cause

In `select_collect()` (the `d_walk` callback used by
`shrink_dcache_parent`), two types of dentries are incorrectly counted
as "found":

1. **Dead dentries** (`d_lockref.count < 0`): Another CPU called
`lockref_mark_dead()` in `__dentry_kill()` but hasn't yet called
`dentry_unlist()` to remove the dentry from the parent's children list.
With the debug delay, the dentry stays dead-but-visible for 5ms.

2. **`DCACHE_SHRINK_LIST` dentries**: Already isolated by another
shrinker path (e.g., the global LRU shrinker from `drop_caches`) to its
own dispose list. These are being processed by that other path but
slowly (5ms per proc dentry with the debug delay).

When `select_collect` counts these as `found++`,
`shrink_dcache_parent()` sees `data.found > 0` and loops again. But
these dentries can never be collected onto `data.dispose` (dead ones
have count < 0, shrink-list ones already have `DCACHE_SHRINK_LIST`
set), so the loop never makes progress =E2=86=92 **infinite loop**.

```
shrink_dcache_parent() loop:
  for (;;) {
      d_walk(parent, &data, select_collect);
      if (!list_empty(&data.dispose)) {
          shrink_dentry_list(&data.dispose);  // never reached
          continue;
      }
      if (!data.found)
          break;            // never reached because found > 0
      // ... loops forever
  }
```

### Reproducer

**Requirements:**
- `CONFIG_DCACHE_SHRINK_RACE_DEBUG=3Dy` (injects 5ms `mdelay()` in
`__dentry_kill` for proc dentries)
- `CONFIG_KASAN=3Dy` (optional, for UAF detection)
- `CONFIG_DEBUG_KERNEL=3Dy`

**Debug patch** (apply to `fs/Kconfig` and `fs/dcache.c`):

```diff
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -9,6 +9,15 @@ menu "File systems"
 config DCACHE_WORD_ACCESS
        bool
=20
+config DCACHE_SHRINK_RACE_DEBUG
+	bool "Debug: inject delay in __dentry_kill to widen race
window"
+	depends on DEBUG_KERNEL
+	default n
+	help
+	  Inject a delay in __dentry_kill() between releasing d_lock
and
+	  re-acquiring it, to make the shrink_dentry_list race
reproducible
+	  in test environments. Only enable for testing.
+
 config VALIDATE_FS_PARSER

--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -32,6 +32,7 @@
 #include <linux/list_lru.h>
+#include <linux/delay.h>
 #include "internal.h"
=20
@@ -630,6 +631,16 @@ static struct dentry *__dentry_kill(...)
 	cond_resched();
+#ifdef CONFIG_DCACHE_SHRINK_RACE_DEBUG
+	/*
+	 * Delay proc dentry kills to keep dead dentries in the tree
+	 * longer. With the bug (count < 0 counted as "found" in
+	 * select_collect), d_walk keeps re-finding dead dentries and
+	 * shrink_dcache_parent() loops forever.
+	 */
+	if (dentry->d_sb->s_magic =3D=3D 0x9fa0 /* PROC_SUPER_MAGIC */)
+		mdelay(5);
+#endif
 	/* now that it's negative, ->d_parent is stable */
```

**Test program** (`test_dcache_race.sh`):

The reproducer creates multi-threaded processes, populates their
`/proc/<pid>/task/<tid>/...` dcache entries, then SIGKILLs them while
simultaneously running `drop_caches` in tight loops. This creates
concurrent `proc_flush_pid` (from dying threads) and `prune_dcache_sb`
(from `drop_caches`) paths competing on the same proc dentries.

```c
/* Key structure:
 * - Fork child with N threads (creates /proc/<pid>/task/<tid>/...
entries)
 * - Parent reads all /proc entries to populate dcache
 * - Background threads continuously do: echo 2 >
/proc/sys/vm/drop_caches
 * - SIGKILL child -> all threads exit -> concurrent proc_flush_pid
 * - drop_caches shrinker races with proc_flush_pid on same dentries
 */
```

Parameters used: 50 threads/process, 200 iterations, 4 shrinker
threads, 4 reader threads.

**vmtest.toml:**
```toml
[[target]]
name =3D "dcache-shrink-race"
kernel =3D "arch/x86/boot/bzImage"
kernel_args =3D "hung_task_panic=3D0 softlockup_panic=3D0
rcupdate.rcu_cpu_stall_suppress=3D1"
command =3D "/mnt/vmtest/test_dcache_race.sh"

  [target.vm]
  memory =3D "16G"   # KASAN needs extra memory
  num_cpus =3D 8
  timeout =3D 1200
```

### Reproduction results

| Kernel | Result |
|---|---|
| Unfixed + debug delay + KASAN | **FAIL**: livelock on iteration 1,
test timed out at 750s |
| Fixed + debug delay + KASAN | **PASS**: all 200 iterations completed,
no KASAN/warnings |

### Fix

The fix is in `select_collect()` =E2=80=94 stop counting dead dentries and
`DCACHE_SHRINK_LIST` dentries as "found":

```diff
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1448,13 +1459,27 @@ static enum d_walk_ret select_collect(void
*_data, struct dentry *dentry)
 	if (data->start =3D=3D dentry)
 		goto out;
=20
-	if (dentry->d_flags & DCACHE_SHRINK_LIST) {
-		data->found++;
+	if (dentry->d_lockref.count < 0) {
+		/*
+		 * Dead dentry (lockref_mark_dead sets count
negative).
+		 * Another CPU is in the middle of __dentry_kill() and
+		 * will shortly unlink it from the tree.  Do not count
+		 * it as "found" --- that causes
shrink_dcache_parent()
+		 * to loop indefinitely.
+		 */
+	} else if (dentry->d_flags & DCACHE_SHRINK_LIST) {
+		/*
+		 * Already on a shrink list, being processed by
another
+		 * path (e.g., the global LRU shrinker).  Do not count
+		 * it as "found" --- if the other path is slow (e.g.,
+		 * contention on d_lock or filesystem callbacks),
+		 * shrink_dcache_parent() would spin forever waiting
for
+		 * them to finish.  The other shrinker will handle
these
+		 * dentries.
+		 */
 	} else if (!dentry->d_lockref.count) {
 		to_shrink_list(dentry, &data->dispose);
 		data->found++;
-	} else if (dentry->d_lockref.count < 0) {
-		data->found++;
 	}
```

**Why this is correct:**

- **Dead dentries (`count < 0`)**: These are being killed by another
CPU's `__dentry_kill()`. That CPU will call `dentry_unlist()` to remove
them from the parent's children list. `shrink_dcache_parent()` doesn't
need to wait for them =E2=80=94 they'll disappear from the tree on their ow=
n.

- **`DCACHE_SHRINK_LIST` dentries**: These are already on another
shrinker's dispose list and will be processed by that path. Counting
them as "found" forces `shrink_dcache_parent()` to wait for the other
shrinker to finish, which can take arbitrarily long (especially with
filesystem callbacks or the debug delay).

- **The `select_collect2` path** (used when `data.found > 0` but
`data.dispose` is empty) handles `DCACHE_SHRINK_LIST` dentries
separately by setting `data->victim` and processing them directly. With
this fix, `select_collect2` is only reached when there are genuinely
unprocessable dentries (count > 0, not dead, not on shrink list), not
when there are merely in-flight kills or concurrent shrinkers.

### Relationship to the production UAF crash

The livelock is the **precursor** to the use-after-free crash seen in
production (P2260313060):

1. Without the debug delay, the `__dentry_kill` race window is
nanoseconds (just `cond_resched()`).
2. Most of the time, the dead dentry is unlinked before
`select_collect` finds it =E2=86=92 no issue.
3. Occasionally, `select_collect` finds dead dentries and spins
briefly. During this spinning, the specific timing allows a parent
dentry to be fully freed (via `dentry_free` =E2=86=92 `call_rcu` =E2=86=92 =
slab
reclaim) and its slab page reused for `kmalloc-96`.
4. When the spinning `shrink_dcache_parent` or a concurrent
`__dentry_kill` then accesses the freed parent =E2=86=92 UAF crash.

The fix prevents the spinning entirely, eliminating both the livelock
and the UAF.
