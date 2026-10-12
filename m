Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7113437B3FE;
	Mon, 12 Oct 2026 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819578; cv=none; b=cbEgNW5lNp5u9yFXc3Nyey2a4V7CSmyU7/DO8d+LXsM75PznfXKkRCPnECg7p0S9ZhGXx3HsVwjwqe1u/zrT8PHHypKurq5hOuCKFtPdjKDe2DAIHMZdrFtY9uhvVmwuo+XY7QrHFSC6sgsb/xjhwNO7ugALVNIoOpX4dC7kTKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819578; c=relaxed/simple;
	bh=EqayXH/IN+DPPcvD9poAMXPFMEeN3FWBnVFZ998zzWg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XLWagzEC+NDYElNUF2O9q8r1xD4KIHAZJq3/Wv8aXo8HXjDLxA8EHwjorOHMqdULUl6Jb+1g4mWx2ESULK+8Q5fMlU7gbhrtKNucF5+xPmOg+A3oOa5Qcl46ZK+Q+hBJp4BLjiyOVr/0j85gmYJGuoO9uTNKMDaICa7b+Q9N3l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SpsTxnIL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SpsTxnIL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606011F0089C;
	Mon, 12 Oct 2026 15:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791819577;
	bh=4EnG/S50zp7ap1/Q5g0SkOH91soOFlQKBc9Hhwbnufc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SpsTxnILRtVraubU1tG51PuQwFPWKWUl7QauezrlIaX0GaMP4f/XJOczBk+x6qodZ
	 vkCOzJwiKaLcRHlKSXgBM23Fm9JJ3dbEUfVYMKlGh6VEDxQNtYKwWx4776vCc8K/eT
	 BPYnaPxlf2x4f9M7s8rAFmhipNXDz4NUmefzyH42KZXdz9QUtqWlIgY9IRp+Lsiqno
	 ACn+sP7BFoeNFy2ZKwOS8eVzRZq0DpzFDXKehPLITXewNwv7rirp6isykjDxyjeEnR
	 9/amsVeLjav0WYgTVdX53dOqMJrStPIwaRCZTnV1QP7vFWlMlyyOnbxPM0zHoKDv9T
	 pp/3yPlbhufGw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 12 Oct 2026 17:39:17 +0200
Subject: [PATCH 4/9] fs: unmount without a grace period when nothing else
 holds the mounts
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-work-mount-gp_on_demand-proposal-v1-4-43f60221a7d0@kernel.org>
References: <20261012-work-mount-gp_on_demand-proposal-v1-0-43f60221a7d0@kernel.org>
In-Reply-To: <20261012-work-mount-gp_on_demand-proposal-v1-0-43f60221a7d0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 "Paul E. McKenney" <paulmck@kernel.org>, NeilBrown <neil@brown.name>, 
 Alexander Larsson <alexl@redhat.com>, Jan Kara <jack@suse.cz>, 
 Jeff Layton <jlayton@kernel.org>, lkmm@lists.linux.dev, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=10181; i=brauner@kernel.org;
 h=from:subject:message-id; bh=EqayXH/IN+DPPcvD9poAMXPFMEeN3FWBnVFZ998zzWg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSd+a9deL+3UXPqc72+HxOcQxluVk9O73N8w6imf8h53
 0N9qy0zO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZyLpmRoXGbv1hde8qGNxPY
 s7ZcYVt7LjHqd+z16WrGm+8eSjQq12X4K+B2TOqdy/w3/SJrVy/l5TxyQvlE8BdXrl32Z6RmKC8
 L4wYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Currently namespace_unlock() always waits for an RCU grace period
before it drops the references of the mounts that umount_tree()
unmounted. The grace period is needed for two reasons:

(1) mntput_no_expire() decrements the count without mount_lock as long
    as it sees a non-NULL ->mnt_ns under rcu_read_lock(). That only
    works because the mount's own reference isn't dropped until an RCU
    delay after ->mnt_ns has been cleared.

(2) __legitimize_mnt() speculatively bumps the count of a mount during
    rcu lookup and drops it again under mount_lock when it realizes the
    seqcount has changed or the mount is doomed.

Without the grace period a decrement or an increment of an rcu lookup
could land after the final mount put has summed up the counters and end
up leaking the mount. Or the task in rcu lookup would end up shutting
the filesystem down instead of task which called umount(2) causing
spurious EBUSY errors.

The grace period is rather expensive though. Neil switched it to
synchronize_rcu_expedited() in commit 22cb7405fada ("VFS: use
synchronize_rcu_expedited() in namespace_unlock()") because 5000
unmounts took 100 seconds with normal grace periods. But an expedited
grace period still IPIs every CPU. On a reasonably beefy 64 vcpu VM
that's 20 to 31 microseconds for every namespace_unlock(). That's two
thirds of the teardown of a detached single mount and half of a mount
and unmount pair.

We've tried a few things to get rid of it. For example, handing a lazy
unmount to a workqueue after the grace period (cf. [1]). But that
changes uapi. Today every mount that nobody else references is torn
down before umount(2) returns, lazy or not, because the puts are done
from the calling task. The deferred variant broke LTP which reuses its
loop devices right after a lazy unmount, and mkfs corrupted an ext4
image while the filesystem was still being torn down from the
workqueue. I also tried sampling the grace period state in
umount_tree() and polling it in namespace_unlock() but that didn't help
as the two are only microseconds apart.

But we can elide the grace period in a lot of cases. In commit
7eb84d54fac5 ("fs: don't let a migrating task hide its reference from
do_umount()") I split the per-cpu reference count into gets and puts
and the puts are summed before the gets. So the increment from rcu
lookup in __legitimize_mnt() is either visible to the sum or rcu lookup
sees the seqcount bump of the unmount and drops its reference under
mount_lock.

IOW, if the sum under mount_lock comes out as one after the mount has
left its namespace then it's the mount's own reference. No holder can
be on the fast path of mntput_no_expire() with a reference to it, no
rcu lookup holds a reference to it, and nobody can find it anymore. So
it is safe to drop that reference and put the mount without waiting for
a grace period. Mounts that are still held wait for the grace period as
before.

The fast paths of mntput_no_expire() and __legitimize_mnt() don't need
to be changed and nothing changes for path lookup. Nothing changes for
userspace either.

The unheld mounts of a batch are finished under mount_lock and the held
ones share a single grace period. Finishing all of them under one
mount_lock hold took a namespace death from 62.9 to 49.9 us in
namespace_unlock() and gave the 8 worker variants of the dissolve modes
another 4 to 7%. But every peek sums up the counters of all possible
cpus and path walks spin on mount_lock while it's held. So we finish at
most 16 mounts per hold.

umount-bench, kops/s, median of 15 runs on a 64 vcpu VM, base against
the full series, 1 and 8 workers:

    mode                  base            full            delta
    mountumount 1w / 8w   26.1 / 75.4     57.1 / 125.5    +118% / +66%
    dissolveone 1w / 8w   38.2 / 108.5    170.6 / 173.4   +347% / +60%
    dissolveflat 1w       15.5            22.4            +45%
    dissolvechain 1w      15.7            22.4            +43%
    nsdeath 1w            6.15            7.10            +15%
    detachlocked 1w       2.72            3.22            +18%
    lazytree 1w           2.93            3.11            +6%
    held modes            14.8-17.4       +1 to +4%       level

For a namespace death the synchronize_rcu_expedited() (30.9 us) is gone:

- namespace_unlock() goes from 93 to 61 us
- the slow path's 54 us are replaced by mntput_final_locked() at 5.8 us

Propagating a tree of 128 mounts into 1000 mount namespaces, median of
14 runs:

- mount and umount propagation stay level within 1%
- releasing the namespaces is 5-10% faster

Mounting, statting and unmounting in a loop with 8 threads for 20s:

- overlay is 82-87% faster (292k -> 528-544k ops)
- casefolded tmpfs is 24-26% faster (433k -> 539-545k ops)

The gain grows with the number of cpus the expedited grace period has to
IPI. Single worker, base against this series, median of 9:

  vcpus            1     8    16    32    64   128   256   512
  mountumount    +30%  +44%  +63%  +92%  +83%  +93%  +71%  +75%
  dissolveone    +86% +130% +183% +293% +224% +242% +155% +149%

Above 64 vcpus the per-cpu sums start to dominate a namespace death. At
512 vcpus 521 of the 676 us it spends in namespace_unlock() are the
sixty mnt_get_count() sums and 118 us are the grace period. So the
multi-mount modes only gain 10 to 27% there. Held mounts stay within a
few percent everywhere because they still wait for their grace period.

[1]: https://lore.kernel.org/all/20250408210350.749901-12-echanude@redhat.com

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/namespace.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 79 insertions(+), 13 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 8c6673bd8c03..435e5f6db880 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1489,10 +1489,12 @@ static void mntput_no_expire(struct mount *mnt)
 		 * Since we don't do lock_mount_hash() here,
 		 * ->mnt_ns can change under us.  However, if it's
 		 * non-NULL, then there's a reference that won't
-		 * be dropped until after an RCU delay done after
-		 * turning ->mnt_ns NULL.  So if we observe it
-		 * non-NULL under rcu_read_lock(), the reference
-		 * we are dropping is not the final one.
+		 * be dropped until after turning ->mnt_ns NULL and
+		 * either an RCU delay or a look under mount_lock
+		 * that found it to be the only one left, which it
+		 * isn't while ours is counted (mntput_unheld()).
+		 * So if we observe it non-NULL under rcu_read_lock(),
+		 * the reference we are dropping is not the final one.
 		 */
 		smp_wmb();	/* pairs with the smp_mb() in mnt_get_count() */
 		mnt_dec_count(mnt);
@@ -1504,6 +1506,75 @@ static void mntput_no_expire(struct mount *mnt)
 
 DEFINE_FREE(mntput_no_expire, struct mount *, if (_T) mntput_no_expire(_T))
 
+/*
+ * Drop the own reference of a mount that has left its namespace without
+ * waiting for a grace period. mnt_get_count() is biased towards gets,
+ * i.e., it overcounts rather than undercounts. So if the count under
+ * mount_lock is one we know its ours and we're going to drop it.
+ *
+ * Called under mount_lock, the cleanup of the mount is left to the caller.
+ * Returns false if somebody else still references the mount.
+ */
+static bool mntput_unheld(struct mount *mnt, struct list_head *shrink)
+{
+	VFS_BUG_ON(mnt->mnt_ns);
+	if (mnt_get_count(mnt) != 1)
+		return false;
+	mnt_dec_count(mnt);
+	mntput_final_locked(mnt, shrink);
+	return true;
+}
+
+/* peeks per mount_lock hold, pathwalks spin while it is held */
+#define MNTPUT_UNMOUNTED_BATCH 16
+
+/*
+ * Put the mounts umount_tree() collected. Ideally, every mount just has a
+ * single reference count which means that we can elide the grace period.
+ * We batch mntput_unheld() as mnt_get_count() needs to sum over every cpu.
+ * On big machines it's not that fast. If there are mounts with held references
+ * we need the grace period.
+ */
+static void mntput_unmounted(struct hlist_head *head)
+{
+	struct hlist_node *p;
+	struct mount *m;
+	HLIST_HEAD(held);
+
+	while (!hlist_empty(head)) {
+		unsigned int n = 0;
+		HLIST_HEAD(unheld);
+		LIST_HEAD(shrink);
+
+		lock_mount_hash();
+		hlist_for_each_entry_safe(m, p, head, mnt_umount) {
+			hlist_del(&m->mnt_umount);
+			if (mntput_unheld(m, &shrink))
+				hlist_add_head(&m->mnt_umount, &unheld);
+			else
+				hlist_add_head(&m->mnt_umount, &held);
+			if (++n == MNTPUT_UNMOUNTED_BATCH)
+				break;
+		}
+		unlock_mount_hash();
+		shrink_dentry_list(&shrink);
+
+		hlist_for_each_entry_safe(m, p, &unheld, mnt_umount) {
+			hlist_del(&m->mnt_umount);
+			mntput_queue_cleanup(m);
+		}
+	}
+
+	if (hlist_empty(&held))
+		return;
+
+	synchronize_rcu_expedited();
+	hlist_for_each_entry_safe(m, p, &held, mnt_umount) {
+		hlist_del(&m->mnt_umount);
+		mntput(&m->mnt);
+	}
+}
+
 void mntput(struct vfsmount *mnt)
 {
 	if (mnt) {
@@ -1527,7 +1598,9 @@ EXPORT_SYMBOL(mntget);
 /*
  * Make a mount point inaccessible to new lookups.
  * Because there may still be current users, the caller MUST WAIT
- * for an RCU grace period before destroying the mount point.
+ * for an RCU grace period before destroying the mount point, unless
+ * it finds under mount_lock that it holds the only reference left,
+ * see mntput_unheld().
  */
 void mnt_make_shortterm(struct vfsmount *mnt)
 {
@@ -1782,8 +1855,6 @@ static void free_mnt_ns(struct mnt_namespace *);
 static void namespace_unlock(void)
 {
 	struct hlist_head head;
-	struct hlist_node *p;
-	struct mount *m;
 	struct mnt_namespace *ns = emptied_ns;
 	LIST_HEAD(list);
 
@@ -1814,12 +1885,7 @@ static void namespace_unlock(void)
 	if (likely(hlist_empty(&head)))
 		return;
 
-	synchronize_rcu_expedited();
-
-	hlist_for_each_entry_safe(m, p, &head, mnt_umount) {
-		hlist_del(&m->mnt_umount);
-		mntput(&m->mnt);
-	}
+	mntput_unmounted(&head);
 }
 
 static inline void namespace_lock(void)

-- 
2.53.0

