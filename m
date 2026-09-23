Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926B2420477
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 12:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790166510; cv=none; b=lvPfh1izbRywtsznfpTxJW1t2vtMKG7csGMyF8C1jeolGT/jEaj5+ECgUoD8PlfIQ06lphBrpn1NnzQkQxOU4M4q07FwstfAYHei61MdkRG7r/TthCXJMuzD9PXMniBETddhg/sInXiZSo9ABrNJJz5aEA5PSbZJrlwaM+j9QbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790166510; c=relaxed/simple;
	bh=tjHES0RP0LA0JoM6nEUktlzGFgU38dyC6Yu/slZEAEI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uLSvT3PBBHCAfBAJu+BBNnUjq6LbrGPjQdLOeadl7QgK5a+BBNddM99/hQlqSpMNdOImX51oxsm2pWY1NN5Iczj66rVkotx/G8cEj/1zTEMFLk8OWZNi7opBbziifNWP4J4OtkPiHSNTonPOkLBpKUOR3UTJ/BiEyNbV0sdaImQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZ5Tpgle; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZ5Tpgle"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27241F00893;
	Wed, 23 Sep 2026 12:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790166508;
	bh=8j/g6oHCRroMG7sfpHVXaS5G47HlSL8AJbpryJIYzAU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oZ5Tpgle4UJ/11esN9CWwuJPR2g1PuhcU7jPk/GPJTy3DUxBcDDWoGAUJZwbPPl5U
	 9Y6zTRQZ6iPfXtDp1hz6sJTRj90InwpOntmKQN2q7Wz/sPlF9NiuEZGMQBB4pIh760
	 yT7R+zh0MmmFY6PV84Q9YaAmNfK6+c/9QpP5j0drnan0xXKxy5Y2ts2E/QXkVmoI+o
	 jxusC26Xvyp18FIFKQN/2Cf4dhi4WjkadRmmP1iaADiyLPREajBgCVYYF+aWXyIno+
	 0x4D5hU8+u2rGtfrP7mEu+9Kc2/0FzcUCAdsnVL2JRb2BtCTXMw3GQi59Za3xzM8mZ
	 GvgOMz9p4OaYg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 23 Sep 2026 14:27:59 +0200
Subject: [PATCH 7/8] fs: don't let a migrating task hide its reference from
 do_umount()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-work-mount-fixes-v1-7-f424cf8d3242@kernel.org>
References: <20260923-work-mount-fixes-v1-0-f424cf8d3242@kernel.org>
In-Reply-To: <20260923-work-mount-fixes-v1-0-f424cf8d3242@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=14001; i=brauner@kernel.org;
 h=from:subject:message-id; bh=tjHES0RP0LA0JoM6nEUktlzGFgU38dyC6Yu/slZEAEI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtPnqHeY/1w3OuR2e2aMrNKf6qH7iQJ0/13U6VTZGxx
 WxXrtyz7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI9kMM/6Pnx+fObPpr872P
 x9u8V+Xr7FfXNmS/3TCZcemMiOe/PnUx/M9ny9k8q1Kq6tiX7qvtgi6RGyt5a2+ud9E/trTjzOX
 1cbwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

propagate_mount_busy() uses mnt_get_count() via do_refcount_check() to
figure out whether a synchronous umount may proceed or not by summing
the per-CPU mnt_count counter under mount_lock.

The fastpath for mntget() and mntput() doesn't require that lock. A task
that already holds a reference and takes another one on a cpu the loop
has summed can get migrated and drops that reference again on another
cpu. The loop might not have reached that cpu yet. That ends up
undercounting. The original reference of the task is missed and umount()
ends up succeeding with the file still open. The mount is destroyed
later when the task mntput()s so it degrades to a lazy umount.

That's basically the umount(2) variant of commit 9ea0a46ca2c3 ("fix
mntput/mntput race") closed for the final mntput(). The same
cpu-migration caused a UAF.

Luckily this isn't a UAF. It's just a hidden reference pinning the
mount but it's wrong nonetheless.

Like the other race it's a narrow window but I can reproduce it reliably
with some patching. The debug patch below prints the sum the loop
computed next to an immediate re-sum of the same counters. It reports
who drops the last reference to that mount later:

  --- a/fs/namespace.c
  +++ b/fs/namespace.c
  @@ -34,6 +34,8 @@
   #include <linux/mnt_idmapping.h>
   #include <linux/pidfs.h>
   #include <linux/nstree.h>
  +#include <linux/debugfs.h>
  +#include <linux/delay.h>

   #include "pnode.h"
   #include "internal.h"
  @@ -263,17 +265,48 @@
   #endif
   }

  +static u32 mnt_get_count_delay_ms;
  +static int mnt_get_count_debug_id;
  +
  +static int __init mnt_get_count_debug_init(void)
  +{
  +	debugfs_create_u32("mnt_get_count_delay_ms", 0600, NULL,
  +			   &mnt_get_count_delay_ms);
  +	return 0;
  +}
  +late_initcall(mnt_get_count_debug_init);
  +
   /*
    * vfsmount lock must be held for write
    */
   int mnt_get_count(struct mount *mnt)
   {
   #ifdef CONFIG_SMP
  -	int count = 0;
  +	static int seen[NR_CPUS];
  +	bool slow = mnt_get_count_delay_ms &&
  +		    !(mnt->mnt.mnt_flags & MNT_UMOUNT);
  +	int count = 0, again = 0;
   	int cpu;

   	for_each_possible_cpu(cpu) {
  -		count += per_cpu_ptr(mnt->mnt_pcp, cpu)->mnt_count;
  +		seen[cpu] = per_cpu_ptr(mnt->mnt_pcp, cpu)->mnt_count;
  +		count += seen[cpu];
  +		if (slow)
  +			mdelay(mnt_get_count_delay_ms);
  +	}
  +	if (slow) {
  +		for_each_possible_cpu(cpu) {
  +			int now;
  +
  +			now = per_cpu_ptr(mnt->mnt_pcp, cpu)->mnt_count;
  +			again += now;
  +			pr_err("mount %d: cpu%d read %d, now %d\n",
  +			       mnt->mnt_id, cpu, seen[cpu], now);
  +		}
  +		mnt_get_count_debug_id = mnt->mnt_id;
  +		pr_err("mount %d: sum %d, re-sum %d, %ps\n",
  +		       mnt->mnt_id, count, again,
  +		       __builtin_return_address(0));
   	}

   	return count;
  @@ -1350,6 +1383,9 @@
   	smp_mb();
   	mnt_add_count(mnt, -1);
   	count = mnt_get_count(mnt);
  +	if (count == 0 && mnt->mnt_id == mnt_get_count_debug_id)
  +		pr_err("mount %d: last put by %s (%d)\n", mnt->mnt_id,
  +		       current->comm, task_pid_nr(current));
   	if (count != 0) {
   		WARN_ON(count < 0);
   		rcu_read_unlock();

A task holds open a directory fd on a tmpfs. A synchronous rumount() of
the tmpfs sums up. Concurrently a task calls fchdir() on that fd on
CPU 0 and fchdir()s back to / on CPU 3. This will cause a path_get() and
a path_put() with a migration in between without mount_lock held.

Adding a delay per CPU makes the count loop miss the get in a cpu it
already visited but count the put in one it hasn't.

The reproducer, run as root with debugfs mounted:

  /*
   * gcc -static -o umount-torn umount-torn.c
   */
  #define _GNU_SOURCE
  #include <errno.h>
  #include <fcntl.h>
  #include <sched.h>
  #include <stdio.h>
  #include <string.h>
  #include <unistd.h>
  #include <sys/mount.h>
  #include <sys/stat.h>
  #include <sys/wait.h>

  #define KNOB "/sys/kernel/debug/mnt_get_count_delay_ms"
  #define MNT "/mnt/x"

  static int kmsg;

  static void pin(int cpu)
  {
  	cpu_set_t s;

  	CPU_ZERO(&s);
  	CPU_SET(cpu, &s);
  	sched_setaffinity(0, sizeof(s), &s);
  }

  static void knob(const char *v)
  {
  	int fd = open(KNOB, O_WRONLY);

  	write(fd, v, strlen(v));
  	close(fd);
  }

  int main(void)
  {
  	int last = sysconf(_SC_NPROCESSORS_ONLN) - 1;
  	int p[2], fd, ret;
  	pid_t pid;
  	char c;

  	kmsg = open("/dev/kmsg", O_WRONLY);
  	mkdir(MNT, 0755);
  	mount("none", MNT, "tmpfs", 0, NULL);
  	fd = open(MNT "/f", O_WRONLY | O_CREAT, 0644);
  	write(fd, "still here\n", 11);
  	close(fd);

  	pipe(p);
  	pid = fork();
  	if (pid == 0) {
  		int dirfd = open(MNT, O_RDONLY | O_DIRECTORY);
  		int rootfd = open("/", O_RDONLY | O_DIRECTORY);
  		struct stat st;
  		char buf[16];

  		/* one get/put pair while the umount is summing */
  		usleep(150000);
  		pin(0);
  		fchdir(dirfd);		/* mntget() */
  		dprintf(kmsg, "holder %d: get on cpu %d\n", getpid(),
  			sched_getcpu());
  		pin(last);
  		fchdir(rootfd);		/* mntput() */
  		dprintf(kmsg, "holder %d: put on cpu %d\n", getpid(),
  			sched_getcpu());

  		/* the umount has returned, is the fd still good? */
  		read(p[0], &c, 1);
  		fd = openat(dirfd, "f", O_RDONLY);
  		ret = read(fd, buf, sizeof(buf));
  		dprintf(kmsg, "holder %d: fstat %d openat %d read %d\n",
  			getpid(), fstat(dirfd, &st), fd, ret);
  		_exit(0);
  	}

  	pin(1);
  	knob("100");
  	ret = umount2(MNT, 0);
  	knob("0");
  	if (ret)
  		dprintf(kmsg, "umount: %s\n", strerror(errno));
  	else
  		dprintf(kmsg, "umount: 0\n");
  	write(p[1], "x", 1);
  	waitpid(pid, NULL, 0);
  	return 0;
  }

The log shows the busy check summing 2 and when read right after it
reads 3. The loop read CPU 0 before the get landed there and CPU 3
after the put did. The umount succeeds while there's still someone
with an fd. The mount is then dropped when the fd goes:

  [    2.511944] holder 90: get on cpu 0
  [    2.512023] holder 90: put on cpu 3
  [    2.671388] mount 28: cpu0 read 1, now 2
  [    2.671398] mount 28: cpu1 read 2, now 2
  [    2.671401] mount 28: cpu2 read 0, now 0
  [    2.671404] mount 28: cpu3 read -1, now -1
  [    2.671407] mount 28: sum 2, re-sum 3, propagate_mount_busy
  [    2.671773] umount: 0
  [    2.672963] holder 90: fstat 0 openat 8 read 11
  [    2.673663] mount 28: last put by umount-torn (90)

Easy fix would be to order mntget() against the loop that sums up. But
that's a full barrier and a flag test in mntget() afaict. No bueno...
That would cost every path_get().

So learn from SRCU. Keep gets and puts in separate per-cpu counters and
make mnt_get_count() sum all puts first and all gets second with a full
barrier in between.

A put is always after its own get (hopefully...) independent of the cpu
the task is on. So a put the first pass counted must have its get
visible to the second pass. Ergo, we can't undercount.

This is the two pass sum srcu_readers_active_idx_check() does for
srcu_locks and srcu_unlocks. mntget() keeps a single
this_cpu_inc(). mntput() gains an smp_wmb() before its increment, a
compiler barrier on x86 and a store fence on the weakly ordered
architectures, since the two counters are two words and a put stored
after a get could otherwise become visible before it. The counters
are unsigned so the difference stays right after they wrap.

The count can still come out high when a get is counted whose put
the first pass did not see. We don't care. A task can only take a new
reference if:

(1) it holds one already
(2) through __legitimize_mnt() which the seqcount orders
    against the write side

So a get in this window means someone has a reference and -EBUSY is
correct. The final mntput() is unchanged. Once ->mnt_ns is NULL every
put takes the slow path under mount_lock and so no put is in flight
while it counts. Here's an attempted proof for that crap:

(i) A put never becomes visible before its get. Within one task the
    smp_wmb() in mntput_no_expire() orders every earlier store before the
    increment of the puts.

    Any task that migrated in between had its stores flushed by the
    scheduler. When that reference is handed to another task that's
    trivially true.

(ii) The double count in mnt_get_count() is ordered via smp_mb(). That
     keeps every read of the puts counter before every read of the gets
     counter.

(iii) We never undercount by (ii).

(iv) There are no spurious counts/differences. A get is counted only if
     it happened and a put is left out only if it hasn't happened when
     the counter was read. With (iii) this means it's equivalent to the
     old count whenever nothing is taken or dropped during the loop.

(v) do_umount() holds a reference and mount_lock hence. New references
    come from: (v.a) __legitimize_mnt() managed by the seqcount. Either
    it's smp_mb() made the get visible to the loop or it takes the lock
    and waits for the loop. By (iii) a mount with a additional
    references is refused. By (iv) refusing the umount just means that
    any additional reference existed, same as the old counter.

(vi) mntput_no_expire_slowpath() runs with ->mnt_ns already NULL. Hence,
     every other put must take the slowpath as well and hangs on mount_lock.

    The grace period in namespace_unlock() will make every fast path do
    a put that still saw ->mnt_ns.

    No put is in flight during the loop.

    A get that is in flight comes from a task holding another reference.
    That must be included by the count or from __legitimize_mnt() as in
    (v).

    Ergo, zero means the last reference and non-zero means a reference
    is live.

(vii) may_umount() uses propagate_mount_busy() as well and
      may_umount_tree() sums mnt_get_count() itself.

With this patch the race is dead:

  [    3.066786] mount 28: sum 3, re-sum 3, propagate_mount_busy
  [    3.105867] umount: Device or resource busy
  [    3.106047] holder 90: fstat 0 openat 8 read 11

Fixes: b3e19d924b6e ("fs: scale mntget/mntput")
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/mount.h     |  3 ++-
 fs/namespace.c | 48 ++++++++++++++++++++++++++++++------------------
 2 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index 94fcc306d21e..85f136786bbc 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -33,7 +33,8 @@ struct mnt_namespace {
 } __randomize_layout;
 
 struct mnt_pcp {
-	int mnt_count;
+	unsigned int mnt_gets;
+	unsigned int mnt_puts;
 	int mnt_writers;
 };
 
diff --git a/fs/namespace.c b/fs/namespace.c
index d842fc1f1f1a..73215f84e04d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -249,16 +249,24 @@ void mnt_release_group_id(struct mount *mnt)
 	mnt->mnt_group_id = 0;
 }
 
-/*
- * vfsmount lock must be held for read
- */
-static inline void mnt_add_count(struct mount *mnt, int n)
+static inline void mnt_inc_count(struct mount *mnt)
+{
+#ifdef CONFIG_SMP
+	this_cpu_inc(mnt->mnt_pcp->mnt_gets);
+#else
+	preempt_disable();
+	mnt->mnt_count++;
+	preempt_enable();
+#endif
+}
+
+static inline void mnt_dec_count(struct mount *mnt)
 {
 #ifdef CONFIG_SMP
-	this_cpu_add(mnt->mnt_pcp->mnt_count, n);
+	this_cpu_inc(mnt->mnt_pcp->mnt_puts);
 #else
 	preempt_disable();
-	mnt->mnt_count += n;
+	mnt->mnt_count--;
 	preempt_enable();
 #endif
 }
@@ -269,14 +277,17 @@ static inline void mnt_add_count(struct mount *mnt, int n)
 int mnt_get_count(struct mount *mnt)
 {
 #ifdef CONFIG_SMP
-	int count = 0;
+	unsigned int gets = 0, puts = 0;
 	int cpu;
 
-	for_each_possible_cpu(cpu) {
-		count += per_cpu_ptr(mnt->mnt_pcp, cpu)->mnt_count;
-	}
+	/* puts first, so a put counted here has its get counted below */
+	for_each_possible_cpu(cpu)
+		puts += per_cpu_ptr(mnt->mnt_pcp, cpu)->mnt_puts;
+	smp_mb();	/* pairs with the smp_wmb() in mntput_no_expire() */
+	for_each_possible_cpu(cpu)
+		gets += per_cpu_ptr(mnt->mnt_pcp, cpu)->mnt_gets;
 
-	return count;
+	return gets - puts;
 #else
 	return mnt->mnt_count;
 #endif
@@ -305,7 +316,7 @@ static struct mount *alloc_vfsmnt(const char *name)
 		if (!mnt->mnt_pcp)
 			goto out_free_devname;
 
-		this_cpu_add(mnt->mnt_pcp->mnt_count, 1);
+		this_cpu_inc(mnt->mnt_pcp->mnt_gets);
 #else
 		mnt->mnt_count = 1;
 		mnt->mnt_writers = 0;
@@ -746,13 +757,13 @@ int __legitimize_mnt(struct vfsmount *bastard, unsigned seq)
 	if (bastard == NULL)
 		return 0;
 	mnt = real_mount(bastard);
-	mnt_add_count(mnt, 1);
-	smp_mb();		// see mntput_no_expire() and do_umount()
+	mnt_inc_count(mnt);
+	smp_mb();	/* see mntput_no_expire_slowpath() and do_umount() */
 	if (likely(!read_seqretry(&mount_lock, seq)))
 		return 0;
 	lock_mount_hash();
 	if (unlikely(bastard->mnt_flags & (MNT_SYNC_UMOUNT | MNT_DOOMED))) {
-		mnt_add_count(mnt, -1);
+		mnt_dec_count(mnt);
 		unlock_mount_hash();
 		return 1;
 	}
@@ -1348,7 +1359,7 @@ static void noinline mntput_no_expire_slowpath(struct mount *mnt)
 	 * mount_lock, we'll see their refcount increment here.
 	 */
 	smp_mb();
-	mnt_add_count(mnt, -1);
+	mnt_dec_count(mnt);
 	count = mnt_get_count(mnt);
 	if (count != 0) {
 		WARN_ON(count < 0);
@@ -1405,7 +1416,8 @@ static void mntput_no_expire(struct mount *mnt)
 		 * non-NULL under rcu_read_lock(), the reference
 		 * we are dropping is not the final one.
 		 */
-		mnt_add_count(mnt, -1);
+		smp_wmb();	/* pairs with the smp_mb() in mnt_get_count() */
+		mnt_dec_count(mnt);
 		rcu_read_unlock();
 		return;
 	}
@@ -1427,7 +1439,7 @@ EXPORT_SYMBOL(mntput);
 struct vfsmount *mntget(struct vfsmount *mnt)
 {
 	if (mnt)
-		mnt_add_count(real_mount(mnt), 1);
+		mnt_inc_count(real_mount(mnt));
 	return mnt;
 }
 EXPORT_SYMBOL(mntget);

-- 
2.53.0

