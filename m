Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817774A2A55;
	Mon, 12 Oct 2026 15:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819587; cv=none; b=ey4SOQ6rcUU5myMjJqIsm3KRJPOXW4hGLfxednbonYQZ4MhcRnnoyz/2+sdt8BSTI9KLoI4j4H4heO/R826ZRrRihprP9+nWGwOxlKYas74Qro1ywGWpvtEslojsRbMhkTezfX8fFTU+Y6nnShN/+B9wBkn9xCbOigyndJemC4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819587; c=relaxed/simple;
	bh=ZfOqJlHcXNBpaql0mublJU8ONdMBeo5ozHw6oN+xBgY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CZwd+UB1HpdjA8RX6hRv+0dp8/2tZjxkheefWEICMLolf4V1sWqOE6KXRS6dopZT/kyQ9ivuhskE2pQ4Lp7NMReSxylVKXVFYbOF9s0nCk+n5jKSTa2JEocPuaWuJaxbyz9jdwgYf917n496QY8ik8IAQaYxtGDDKrvAZmhK7ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAXGoiqy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAXGoiqy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AAC91F0089F;
	Mon, 12 Oct 2026 15:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791819584;
	bh=2y+Sag+WMgniwY0J1ScJuyQynFS/WMItUNBAY/b0l9o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fAXGoiqyYHoffOM716LUDgBMikuZT57GM3PMp1KuqRL5loV7HX9ExPd5Tu7WrdVLy
	 UPO6ycOIw9sEZB3D4pusEIaadzV+UROlaA+7RjdidnEWu058N5CT39xrApimQITsi9
	 gRFLVUrjhrnLSjw/48EmvFz4ywxDhxOGczdVaHrAMZQiN1dN3RO6tcDTFwL4AqSn59
	 iFaIcptkS3Ncv5Kez+IYLVVfxvZEgQSD+FAqiM8SneBia5E7IiYyqnpQcR50WFagi5
	 UYHRRgHvStFcG9vZNPnU6GryMhKy24I8eQ1LmMjcjdemf/UKNqpjvuPvIrzsbW2oGt
	 P7RR338ylaWgg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 12 Oct 2026 17:39:20 +0200
Subject: [PATCH 7/9] Documentation/litmus-tests: add the mount reference
 count tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-work-mount-gp_on_demand-proposal-v1-7-43f60221a7d0@kernel.org>
References: <20261012-work-mount-gp_on_demand-proposal-v1-0-43f60221a7d0@kernel.org>
In-Reply-To: <20261012-work-mount-gp_on_demand-proposal-v1-0-43f60221a7d0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 "Paul E. McKenney" <paulmck@kernel.org>, NeilBrown <neil@brown.name>, 
 Alexander Larsson <alexl@redhat.com>, Jan Kara <jack@suse.cz>, 
 Jeff Layton <jlayton@kernel.org>, lkmm@lists.linux.dev, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=46511; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ZfOqJlHcXNBpaql0mublJU8ONdMBeo5ozHw6oN+xBgY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSd+a/Nt2temsjSbwfWfhc2sUutl9nr+kL1R0palGdKb
 hXb54KZHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABO5ysjIcOMiO0+IZc1Pv5VW
 izdl/HzyP1XmwkHW7CDewBcLNN06chn+yv0P4WH3sMw9qS0aJc7Hs+X6rx8nTTu400PNb56IquT
 lBAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The reference count of a mount is split into per-cpu gets and puts and
not everyone who touches it takes mount_lock:

(1) A holder drops a reference on the fast path of mntput_no_expire()
    under rcu_read_lock() as long as it sees a non-NULL ->mnt_ns.

(2) A walker in __legitimize_mnt() speculatively takes a reference
    during rcu path walk and drops it again under mount_lock if the
    seqcount has changed.

(3) The unmounter sums up the counters under mount_lock with
    mnt_get_count() and finishes the mount off without a grace period
    if the sum says that nothing else holds it.

That relies on three barriers and one grace period:

- the smp_wmb() before the fast-path put in mntput_no_expire()
- the smp_mb() between the increment and the re-read of the seqcount
  in __legitimize_mnt()
- the smp_mb() between the puts pass and the gets pass in
  mnt_get_count()
- the synchronize_rcu_expedited() that mntput_unmounted() waits for if
  the sum came out higher than one

Finishing an unmounted mount off without a grace period when the count
under mount_lock is one relies on all of this. A holder's get is
counted whenever its put is. A walker's increment is either counted or
the walker sees the seqcount change and drops its reference under
mount_lock. So the one reference the sum found is the mount's own.

That's not enough on its own though. A walker that only starts after
the sum must not be able to find the mount at all. Its seqcount sample
would already be current and __legitimize_mnt() would hand it a
reference to a mount we're tearing down. The mount isn't in the mount
tree anymore and every other way to get at it goes through a reference
the sum would have counted. The tricky case is a holder that had its
cwd on the mount and called chdir() right before the sum. set_fs_pwd()
stores the new fs->pwd before it puts the old one and both the smp_wmb()
in write_sequnlock() and the one on the fast path of mntput_no_expire()
order that. The smp_mb() in mnt_get_count() then orders the load of the
put before the seqcount store of the unlock. So a walker that sees that
seqcount also sees the new fs->pwd.

Add litmus tests so we can check that argument against the kernel
memory model. Each test is a two-process cut of fs/namespace.c except
for the mnt-walker-late-sees-new-pwd tests which need a third process
for the late walker. The per-cpu counters are one variable per cpu,
write_seqlock() is spelled out as a spinlock, a seqcount store and an
smp_wmb(), and read_seqretry() is an smp_rmb() and a READ_ONCE().

The tests of the code as it is are "Never". The exception is
mnt-sum-misses-fastpath-put which shows that the sum can miss a put on
the fast path. That's why mntput_unmounted() still waits for a grace
period when the count isn't one. Next to them are mutations with one
ingredient removed and those are "Sometimes": the holder's smp_wmb(),
the smp_mb() in mnt_get_count() or the order of its two passes, the
walker's smp_mb(), the lock around the walker's look at ->mnt_flags,
and the grace period. So we know which barrier carries which pairing.

Run them with herd7 against tools/memory-model:

    cd tools/memory-model
    scripts/checklitmus.sh ../../Documentation/litmus-tests/fs/<test>

Note that every architecture's smp_mb(), smp_wmb(), READ_ONCE(),
WRITE_ONCE(), spinlock and RCU implementation has to follow the memory
model. So a "Never" there holds on all architectures.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 Documentation/litmus-tests/README                  |  95 +++++++++++++++++++
 .../fs/mnt-gp-sees-fastpath-put-nogp.litmus        |  75 +++++++++++++++
 .../fs/mnt-gp-sees-fastpath-put-sync-rcu.litmus    |  73 +++++++++++++++
 .../fs/mnt-gp-sees-fastpath-put.litmus             |  79 ++++++++++++++++
 .../fs/mnt-holder-get-before-put-getsfirst.litmus  |  63 +++++++++++++
 .../fs/mnt-holder-get-before-put-nomb.litmus       |  62 +++++++++++++
 .../fs/mnt-holder-get-before-put-nowmb.litmus      |  62 +++++++++++++
 .../fs/mnt-holder-get-before-put.litmus            |  73 +++++++++++++++
 .../mnt-kern-unmount-gp-sees-fastpath-put.litmus   |  70 ++++++++++++++
 .../mnt-kern-unmount-holder-get-before-put.litmus  |  60 ++++++++++++
 .../fs/mnt-sum-misses-fastpath-put.litmus          |  69 ++++++++++++++
 .../fs/mnt-walker-bail-sees-doomed-nolock.litmus   |  89 ++++++++++++++++++
 .../fs/mnt-walker-bail-sees-doomed.litmus          |  95 +++++++++++++++++++
 .../mnt-walker-get-vs-seqcount-no-outer-mb.litmus  |  92 ++++++++++++++++++
 .../fs/mnt-walker-get-vs-seqcount-nomb.litmus      |  92 ++++++++++++++++++
 .../fs/mnt-walker-get-vs-seqcount.litmus           | 102 ++++++++++++++++++++
 .../fs/mnt-walker-late-sees-new-pwd-nomb.litmus    |  89 ++++++++++++++++++
 .../fs/mnt-walker-late-sees-new-pwd-nowmb.litmus   |  88 ++++++++++++++++++
 .../fs/mnt-walker-late-sees-new-pwd.litmus         | 103 +++++++++++++++++++++
 19 files changed, 1531 insertions(+)

diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
index 6c666f3422ea..47fca037c6e1 100644
--- a/Documentation/litmus-tests/README
+++ b/Documentation/litmus-tests/README
@@ -38,6 +38,101 @@ cmpxchg-fail-unordered-2.litmus
     acquire operation.
 
 
+fs (/fs directory)
+------------------
+
+The reference count of a mount is split into per-CPU gets and puts.  A
+holder drops a reference on the fast path of mntput_no_expire() without
+mount_lock, a walker in __legitimize_mnt() takes one during an RCU path
+walk, and the unmounter sums the counters under mount_lock with
+mnt_get_count() to decide whether it can finish the mount off without
+waiting for a grace period.  The tests spell write_seqlock() out as a
+spinlock, a seqcount store and smp_wmb(), read_seqbegin() and
+read_seqretry() as READ_ONCE() and smp_rmb(), and the per-CPU counters
+as one variable per CPU.
+
+mnt-sum-misses-fastpath-put.litmus
+    Demonstrates that the sum under mount_lock can miss a put on the
+    fast path of mntput_no_expire(), which is why mntput_unmounted()
+    falls back to a grace period when the count is not one.
+
+mnt-holder-get-before-put.litmus
+    Demonstrates that a fast-path put the sum counts has its get counted
+    too: the smp_wmb() in mntput_no_expire() pairs with the smp_mb()
+    between the puts pass and the gets pass of mnt_get_count().
+
+mnt-holder-get-before-put-nowmb.litmus
+    The same without the holder's smp_wmb(); the sum can count the put
+    but not the get.
+
+mnt-holder-get-before-put-nomb.litmus
+    The same without the smp_mb() inside mnt_get_count(); an smp_mb()
+    ahead of the puts pass does not stand in for it.
+
+mnt-holder-get-before-put-getsfirst.litmus
+    The same with the gets summed before the puts; the order of the two
+    passes is part of the pairing.
+
+mnt-gp-sees-fastpath-put.litmus
+    Demonstrates that after the grace period of mntput_unmounted() the
+    plain mntput() sees the fast-path put the sum missed, because the
+    holder's read-side critical section ended before the grace period.
+
+mnt-gp-sees-fastpath-put-sync-rcu.litmus
+    The same with synchronize_rcu() in place of
+    synchronize_rcu_expedited().
+
+mnt-gp-sees-fastpath-put-nogp.litmus
+    The same with an smp_mb() in place of the grace period; the put can
+    still be missed.
+
+mnt-walker-get-vs-seqcount.litmus
+    Demonstrates the store buffering pairing between the increment and
+    smp_mb() of __legitimize_mnt() and the seqcount store and the
+    smp_mb() of mnt_get_count() under mount_lock: the walker cannot
+    keep a reference to a mount the sum finishes off.
+
+mnt-walker-get-vs-seqcount-no-outer-mb.litmus
+    The same with the sum as the tree has it, without an smp_mb()
+    between taking mount_lock and the sum; the smp_mb() inside
+    mnt_get_count() is the one that pairs.
+
+mnt-walker-get-vs-seqcount-nomb.litmus
+    The same without the walker's smp_mb(); the walker can keep a
+    reference to a freed mount.
+
+mnt-walker-bail-sees-doomed.litmus
+    Demonstrates that a walker which sees the seqcount change and reads
+    ->mnt_flags under mount_lock finds MNT_DOOMED on a mount the sum
+    finished off; mount_lock orders the two critical sections.
+
+mnt-walker-bail-sees-doomed-nolock.litmus
+    The same with ->mnt_flags read outside mount_lock; the walker can
+    miss MNT_DOOMED.
+
+mnt-walker-late-sees-new-pwd.litmus
+    Demonstrates that a walker which starts after the sum finished a
+    mount off cannot reach it through the old cwd of a holder whose put
+    the sum counted: the holder orders the new fs->pwd before the put
+    and the smp_mb() of mnt_get_count() orders the load of the put
+    before the seqcount store the walker samples.
+
+mnt-walker-late-sees-new-pwd-nowmb.litmus
+    The same without the smp_wmb()s that order the new fs->pwd before
+    the put; the walker can read the old cwd.
+
+mnt-walker-late-sees-new-pwd-nomb.litmus
+    The same without the smp_mb() inside mnt_get_count(); the walker can
+    read the old cwd.
+
+mnt-kern-unmount-holder-get-before-put.litmus
+    The holder test for kern_unmount_array(), where mnt_make_shortterm()
+    clears ->mnt_ns with a plain WRITE_ONCE() outside mount_lock.
+
+mnt-kern-unmount-gp-sees-fastpath-put.litmus
+    The grace period test for kern_unmount_array().
+
+
 locking (/locking directory)
 ----------------------------
 
diff --git a/Documentation/litmus-tests/fs/mnt-gp-sees-fastpath-put-nogp.litmus b/Documentation/litmus-tests/fs/mnt-gp-sees-fastpath-put-nogp.litmus
new file mode 100644
index 000000000000..b0b4037217a4
--- /dev/null
+++ b/Documentation/litmus-tests/fs/mnt-gp-sees-fastpath-put-nogp.litmus
@@ -0,0 +1,75 @@
+C mnt-gp-sees-fastpath-put-nogp
+
+(*
+ * Result: Sometimes
+ *
+ * mnt-gp-sees-fastpath-put.litmus with an smp_mb() in place of the
+ * grace period.  A barrier orders the unmounter's own accesses and
+ * waits for nothing: the holder's read-side critical section may still
+ * be running and the second sum misses the put like the first one.
+ * Only a grace period covers a fast-path put the sum missed.
+ *)
+
+{
+	mnt_ns=1;
+	gets_h=1;
+	puts_h=0;
+	gets_u=1;
+	puts_u=0;
+}
+
+P0(int *mnt_ns, int *gets_h, int *puts_h)
+{
+	int r0;
+
+	rcu_read_lock();
+	r0 = READ_ONCE(*mnt_ns);
+	if (r0) {
+		smp_wmb();
+		WRITE_ONCE(*puts_h, 1);
+	}
+	rcu_read_unlock();
+}
+
+P1(spinlock_t *mlock, int *seq, int *mnt_ns, int *gets_h, int *puts_h, int *gets_u, int *puts_u)
+{
+	int r1;
+	int r3;
+	int r5;
+	int r6;
+
+	spin_lock(mlock);
+	WRITE_ONCE(*seq, 1);
+	smp_wmb();
+	WRITE_ONCE(*mnt_ns, 0);
+	smp_wmb();
+	WRITE_ONCE(*seq, 2);
+	spin_unlock(mlock);
+
+	spin_lock(mlock);
+	WRITE_ONCE(*seq, 3);
+	smp_wmb();
+	smp_mb();
+	r1 = READ_ONCE(*puts_h);
+	smp_mb();
+	r3 = READ_ONCE(*gets_h);
+	smp_wmb();
+	WRITE_ONCE(*seq, 4);
+	spin_unlock(mlock);
+
+	smp_mb();
+
+	spin_lock(mlock);
+	WRITE_ONCE(*seq, 5);
+	smp_wmb();
+	smp_mb();
+	WRITE_ONCE(*puts_u, 1);
+	r5 = READ_ONCE(*puts_h);
+	smp_mb();
+	r6 = READ_ONCE(*gets_h);
+	smp_wmb();
+	WRITE_ONCE(*seq, 6);
+	spin_unlock(mlock);
+}
+
+exists (0:r0=1 /\ 1:r5=0)
diff --git a/Documentation/litmus-tests/fs/mnt-gp-sees-fastpath-put-sync-rcu.litmus b/Documentation/litmus-tests/fs/mnt-gp-sees-fastpath-put-sync-rcu.litmus
new file mode 100644
index 000000000000..e8d4b17f1426
--- /dev/null
+++ b/Documentation/litmus-tests/fs/mnt-gp-sees-fastpath-put-sync-rcu.litmus
@@ -0,0 +1,73 @@
+C mnt-gp-sees-fastpath-put-sync-rcu
+
+(*
+ * Result: Never
+ *
+ * mnt-gp-sees-fastpath-put.litmus with synchronize_rcu() in place of
+ * synchronize_rcu_expedited().  To the memory model the two are the
+ * same fence.
+ *)
+
+{
+	mnt_ns=1;
+	gets_h=1;
+	puts_h=0;
+	gets_u=1;
+	puts_u=0;
+}
+
+P0(int *mnt_ns, int *gets_h, int *puts_h)
+{
+	int r0;
+
+	rcu_read_lock();
+	r0 = READ_ONCE(*mnt_ns);
+	if (r0) {
+		smp_wmb();
+		WRITE_ONCE(*puts_h, 1);
+	}
+	rcu_read_unlock();
+}
+
+P1(spinlock_t *mlock, int *seq, int *mnt_ns, int *gets_h, int *puts_h, int *gets_u, int *puts_u)
+{
+	int r1;
+	int r3;
+	int r5;
+	int r6;
+
+	spin_lock(mlock);
+	WRITE_ONCE(*seq, 1);
+	smp_wmb();
+	WRITE_ONCE(*mnt_ns, 0);
+	smp_wmb();
+	WRITE_ONCE(*seq, 2);
+	spin_unlock(mlock);
+
+	spin_lock(mlock);
+	WRITE_ONCE(*seq, 3);
+	smp_wmb();
+	smp_mb();
+	r1 = READ_ONCE(*puts_h);
+	smp_mb();
+	r3 = READ_ONCE(*gets_h);
+	smp_wmb();
+	WRITE_ONCE(*seq, 4);
+	spin_unlock(mlock);
+
+	synchronize_rcu();
+
+	spin_lock(mlock);
+	WRITE_ONCE(*seq, 5);
+	smp_wmb();
+	smp_mb();
+	WRITE_ONCE(*puts_u, 1);
+	r5 = READ_ONCE(*puts_h);
+	smp_mb();
+	r6 = READ_ONCE(*gets_h);
+	smp_wmb();
+	WRITE_ONCE(*seq, 6);
+	spin_unlock(mlock);
+}
+
+exists (0:r0=1 /\ 1:r5=0)
diff --git a/Documentation/litmus-tests/fs/mnt-gp-sees-fastpath-put.litmus b/Documentation/litmus-tests/fs/mnt-gp-sees-fastpath-put.litmus
new file mode 100644
index 000000000000..b60100fdab5e
--- /dev/null
+++ b/Documentation/litmus-tests/fs/mnt-gp-sees-fastpath-put.litmus
@@ -0,0 +1,79 @@
+C mnt-gp-sees-fastpath-put
+
+(*
+ * Result: Never
+ *
+ * The sum of mntput_unheld() can miss the put of a holder on the fast
+ * path of mntput_no_expire(), see mnt-sum-misses-fastpath-put.litmus.
+ * mntput_unmounted() then waits in synchronize_rcu_expedited() and
+ * drops the own reference with a plain mntput(), which sums again in
+ * mntput_no_expire_slowpath() under mount_lock.  The holder read
+ * ->mnt_ns non-NULL inside rcu_read_lock() before umount_tree() stored
+ * NULL, so its read-side critical section, and the put inside it, ends
+ * before the grace period does.  The first sum may miss the put
+ * (1:r1), the second one never does (1:r5=1).
+ *)
+
+{
+	mnt_ns=1;
+	gets_h=1;
+	puts_h=0;
+	gets_u=1;
+	puts_u=0;
+}
+
+P0(int *mnt_ns, int *gets_h, int *puts_h)
+{
+	int r0;
+
+	rcu_read_lock();
+	r0 = READ_ONCE(*mnt_ns);
+	if (r0) {
+		smp_wmb();
+		WRITE_ONCE(*puts_h, 1);
+	}
+	rcu_read_unlock();
+}
+
+P1(spinlock_t *mlock, int *seq, int *mnt_ns, int *gets_h, int *puts_h, int *gets_u, int *puts_u)
+{
+	int r1;
+	int r3;
+	int r5;
+	int r6;
+
+	spin_lock(mlock);
+	WRITE_ONCE(*seq, 1);
+	smp_wmb();
+	WRITE_ONCE(*mnt_ns, 0);
+	smp_wmb();
+	WRITE_ONCE(*seq, 2);
+	spin_unlock(mlock);
+
+	spin_lock(mlock);
+	WRITE_ONCE(*seq, 3);
+	smp_wmb();
+	smp_mb();
+	r1 = READ_ONCE(*puts_h);
+	smp_mb();
+	r3 = READ_ONCE(*gets_h);
+	smp_wmb();
+	WRITE_ONCE(*seq, 4);
+	spin_unlock(mlock);
+
+	synchronize_rcu_expedited();
+
+	spin_lock(mlock);
+	WRITE_ONCE(*seq, 5);
+	smp_wmb();
+	smp_mb();
+	WRITE_ONCE(*puts_u, 1);
+	r5 = READ_ONCE(*puts_h);
+	smp_mb();
+	r6 = READ_ONCE(*gets_h);
+	smp_wmb();
+	WRITE_ONCE(*seq, 6);
+	spin_unlock(mlock);
+}
+
+exists (0:r0=1 /\ 1:r5=0)
diff --git a/Documentation/litmus-tests/fs/mnt-holder-get-before-put-getsfirst.litmus b/Documentation/litmus-tests/fs/mnt-holder-get-before-put-getsfirst.litmus
new file mode 100644
index 000000000000..d20470a276fe
--- /dev/null
+++ b/Documentation/litmus-tests/fs/mnt-holder-get-before-put-getsfirst.litmus
@@ -0,0 +1,63 @@
+C mnt-holder-get-before-put-getsfirst
+
+(*
+ * Result: Sometimes
+ *
+ * mnt-holder-get-before-put.litmus with mnt_get_count() summing the
+ * gets before the puts, the smp_mb() still between the two passes.
+ * The order of the passes is part of the pairing: read first, the
+ * gets pass can predate a get whose put is then counted.
+ *)
+
+{
+	mnt_ns=1;
+	gets_h=1;
+	puts_h=0;
+	gets_u=1;
+	puts_u=0;
+}
+
+P0(int *mnt_ns, int *gets_h, int *puts_h)
+{
+	int r0;
+
+	WRITE_ONCE(*gets_h, 2);
+	rcu_read_lock();
+	r0 = READ_ONCE(*mnt_ns);
+	if (r0) {
+		smp_wmb();
+		WRITE_ONCE(*puts_h, 1);
+	}
+	rcu_read_unlock();
+}
+
+P1(spinlock_t *mlock, int *seq, int *mnt_ns, int *gets_h, int *puts_h, int *gets_u, int *puts_u)
+{
+	int r1;
+	int r2;
+	int r3;
+	int r4;
+
+	spin_lock(mlock);
+	WRITE_ONCE(*seq, 1);
+	smp_wmb();
+	WRITE_ONCE(*mnt_ns, 0);
+	smp_wmb();
+	WRITE_ONCE(*seq, 2);
+	spin_unlock(mlock);
+
+	spin_lock(mlock);
+	WRITE_ONCE(*seq, 3);
+	smp_wmb();
+	smp_mb();
+	r3 = READ_ONCE(*gets_h);
+	r4 = READ_ONCE(*gets_u);
+	smp_mb();
+	r1 = READ_ONCE(*puts_h);
+	r2 = READ_ONCE(*puts_u);
+	smp_wmb();
+	WRITE_ONCE(*seq, 4);
+	spin_unlock(mlock);
+}
+
+exists (0:r0=1 /\ 1:r1=1 /\ 1:r3=1)
diff --git a/Documentation/litmus-tests/fs/mnt-holder-get-before-put-nomb.litmus b/Documentation/litmus-tests/fs/mnt-holder-get-before-put-nomb.litmus
new file mode 100644
index 000000000000..2da4353bc087
--- /dev/null
+++ b/Documentation/litmus-tests/fs/mnt-holder-get-before-put-nomb.litmus
@@ -0,0 +1,62 @@
+C mnt-holder-get-before-put-nomb
+
+(*
+ * Result: Sometimes
+ *
+ * mnt-holder-get-before-put.litmus without the smp_mb() between the
+ * puts pass and the gets pass of mnt_get_count().  The smp_mb() ahead
+ * of the puts pass is still there and does not help: the barrier that
+ * pairs with the holder's smp_wmb() has to sit between the two loads.
+ *)
+
+{
+	mnt_ns=1;
+	gets_h=1;
+	puts_h=0;
+	gets_u=1;
+	puts_u=0;
+}
+
+P0(int *mnt_ns, int *gets_h, int *puts_h)
+{
+	int r0;
+
+	WRITE_ONCE(*gets_h, 2);
+	rcu_read_lock();
+	r0 = READ_ONCE(*mnt_ns);
+	if (r0) {
+		smp_wmb();
+		WRITE_ONCE(*puts_h, 1);
+	}
+	rcu_read_unlock();
+}
+
+P1(spinlock_t *mlock, int *seq, int *mnt_ns, int *gets_h, int *puts_h, int *gets_u, int *puts_u)
+{
+	int r1;
+	int r2;
+	int r3;
+	int r4;
+
+	spin_lock(mlock);
+	WRITE_ONCE(*seq, 1);
+	smp_wmb();
+	WRITE_ONCE(*mnt_ns, 0);
+	smp_wmb();
+	WRITE_ONCE(*seq, 2);
+	spin_unlock(mlock);
+
+	spin_lock(mlock);
+	WRITE_ONCE(*seq, 3);
+	smp_wmb();
+	smp_mb();
+	r1 = READ_ONCE(*puts_h);
+	r2 = READ_ONCE(*puts_u);
+	r3 = READ_ONCE(*gets_h);
+	r4 = READ_ONCE(*gets_u);
+	smp_wmb();
+	WRITE_ONCE(*seq, 4);
+	spin_unlock(mlock);
+}
+
+exists (0:r0=1 /\ 1:r1=1 /\ 1:r3=1)
diff --git a/Documentation/litmus-tests/fs/mnt-holder-get-before-put-nowmb.litmus b/Documentation/litmus-tests/fs/mnt-holder-get-before-put-nowmb.litmus
new file mode 100644
index 000000000000..d9070e813e47
--- /dev/null
+++ b/Documentation/litmus-tests/fs/mnt-holder-get-before-put-nowmb.litmus
@@ -0,0 +1,62 @@
+C mnt-holder-get-before-put-nowmb
+
+(*
+ * Result: Sometimes
+ *
+ * mnt-holder-get-before-put.litmus without the smp_wmb() between the
+ * get and the fast-path put in mntput_no_expire().  Nothing orders the
+ * two stores: the sum counts the put but not the get and finishes the
+ * mount off under the holder.
+ *)
+
+{
+	mnt_ns=1;
+	gets_h=1;
+	puts_h=0;
+	gets_u=1;
+	puts_u=0;
+}
+
+P0(int *mnt_ns, int *gets_h, int *puts_h)
+{
+	int r0;
+
+	WRITE_ONCE(*gets_h, 2);
+	rcu_read_lock();
+	r0 = READ_ONCE(*mnt_ns);
+	if (r0) {
+		WRITE_ONCE(*puts_h, 1);
+	}
+	rcu_read_unlock();
+}
+
+P1(spinlock_t *mlock, int *seq, int *mnt_ns, int *gets_h, int *puts_h, int *gets_u, int *puts_u)
+{
+	int r1;
+	int r2;
+	int r3;
+	int r4;
+
+	spin_lock(mlock);
+	WRITE_ONCE(*seq, 1);
+	smp_wmb();
+	WRITE_ONCE(*mnt_ns, 0);
+	smp_wmb();
+	WRITE_ONCE(*seq, 2);
+	spin_unlock(mlock);
+
+	spin_lock(mlock);
+	WRITE_ONCE(*seq, 3);
+	smp_wmb();
+	smp_mb();
+	r1 = READ_ONCE(*puts_h);
+	r2 = READ_ONCE(*puts_u);
+	smp_mb();
+	r3 = READ_ONCE(*gets_h);
+	r4 = READ_ONCE(*gets_u);
+	smp_wmb();
+	WRITE_ONCE(*seq, 4);
+	spin_unlock(mlock);
+}
+
+exists (0:r0=1 /\ 1:r1=1 /\ 1:r3=1)
diff --git a/Documentation/litmus-tests/fs/mnt-holder-get-before-put.litmus b/Documentation/litmus-tests/fs/mnt-holder-get-before-put.litmus
new file mode 100644
index 000000000000..414c303dcbb6
--- /dev/null
+++ b/Documentation/litmus-tests/fs/mnt-holder-get-before-put.litmus
@@ -0,0 +1,73 @@
+C mnt-holder-get-before-put
+
+(*
+ * Result: Never
+ *
+ * A holder with a reference of its own (gets_h=1) does a transient
+ * mntget() and drops it on the fast path of mntput_no_expire(): the
+ * store to its gets counter, READ_ONCE(->mnt_ns) non-NULL, smp_wmb(),
+ * the store to its puts counter.  umount_tree() clears ->mnt_ns under
+ * write_seqlock() and mntput_unheld() sums with mnt_get_count(): the
+ * puts pass, smp_mb(), the gets pass.  The smp_wmb() pairs with that
+ * smp_mb(), so a put the sum counts has its get counted too.  The bad
+ * outcome is the sum counting the put (1:r1=1) but not the get
+ * (1:r3=1): a count of one, and the mount finished off under the
+ * reference the holder still has.  Message passing, smp_wmb() on the
+ * holder's side and smp_mb() on the sum's.  The sum is modelled with
+ * an smp_mb() ahead of the puts pass as well; it takes no part in
+ * this, see the -nomb variant.  A put that lands on another CPU's
+ * counter after a migration is the same test, the model has no CPUs.
+ *)
+
+{
+	mnt_ns=1;
+	gets_h=1;
+	puts_h=0;
+	gets_u=1;
+	puts_u=0;
+}
+
+P0(int *mnt_ns, int *gets_h, int *puts_h)
+{
+	int r0;
+
+	WRITE_ONCE(*gets_h, 2);
+	rcu_read_lock();
+	r0 = READ_ONCE(*mnt_ns);
+	if (r0) {
+		smp_wmb();
+		WRITE_ONCE(*puts_h, 1);
+	}
+	rcu_read_unlock();
+}
+
+P1(spinlock_t *mlock, int *seq, int *mnt_ns, int *gets_h, int *puts_h, int *gets_u, int *puts_u)
+{
+	int r1;
+	int r2;
+	int r3;
+	int r4;
+
+	spin_lock(mlock);
+	WRITE_ONCE(*seq, 1);
+	smp_wmb();
+	WRITE_ONCE(*mnt_ns, 0);
+	smp_wmb();
+	WRITE_ONCE(*seq, 2);
+	spin_unlock(mlock);
+
+	spin_lock(mlock);
+	WRITE_ONCE(*seq, 3);
+	smp_wmb();
+	smp_mb();
+	r1 = READ_ONCE(*puts_h);
+	r2 = READ_ONCE(*puts_u);
+	smp_mb();
+	r3 = READ_ONCE(*gets_h);
+	r4 = READ_ONCE(*gets_u);
+	smp_wmb();
+	WRITE_ONCE(*seq, 4);
+	spin_unlock(mlock);
+}
+
+exists (0:r0=1 /\ 1:r1=1 /\ 1:r3=1)
diff --git a/Documentation/litmus-tests/fs/mnt-kern-unmount-gp-sees-fastpath-put.litmus b/Documentation/litmus-tests/fs/mnt-kern-unmount-gp-sees-fastpath-put.litmus
new file mode 100644
index 000000000000..59dd434e6a76
--- /dev/null
+++ b/Documentation/litmus-tests/fs/mnt-kern-unmount-gp-sees-fastpath-put.litmus
@@ -0,0 +1,70 @@
+C mnt-kern-unmount-gp-sees-fastpath-put
+
+(*
+ * Result: Never
+ *
+ * mnt-gp-sees-fastpath-put.litmus for kern_unmount_array(), where
+ * mnt_make_shortterm() clears ->mnt_ns with a plain WRITE_ONCE()
+ * outside mount_lock.  The holder still read it non-NULL inside
+ * rcu_read_lock() before the store, so its read-side critical section
+ * ends before the grace period of mntput_unmounted() does and the
+ * plain mntput() that follows sees its put.
+ *)
+
+{
+	mnt_ns=1;
+	gets_h=1;
+	puts_h=0;
+	gets_u=1;
+	puts_u=0;
+}
+
+P0(int *mnt_ns, int *gets_h, int *puts_h)
+{
+	int r0;
+
+	rcu_read_lock();
+	r0 = READ_ONCE(*mnt_ns);
+	if (r0) {
+		smp_wmb();
+		WRITE_ONCE(*puts_h, 1);
+	}
+	rcu_read_unlock();
+}
+
+P1(spinlock_t *mlock, int *seq, int *mnt_ns, int *gets_h, int *puts_h, int *gets_u, int *puts_u)
+{
+	int r1;
+	int r3;
+	int r5;
+	int r6;
+
+	WRITE_ONCE(*mnt_ns, 0);
+
+	spin_lock(mlock);
+	WRITE_ONCE(*seq, 3);
+	smp_wmb();
+	smp_mb();
+	r1 = READ_ONCE(*puts_h);
+	smp_mb();
+	r3 = READ_ONCE(*gets_h);
+	smp_wmb();
+	WRITE_ONCE(*seq, 4);
+	spin_unlock(mlock);
+
+	synchronize_rcu_expedited();
+
+	spin_lock(mlock);
+	WRITE_ONCE(*seq, 5);
+	smp_wmb();
+	smp_mb();
+	WRITE_ONCE(*puts_u, 1);
+	r5 = READ_ONCE(*puts_h);
+	smp_mb();
+	r6 = READ_ONCE(*gets_h);
+	smp_wmb();
+	WRITE_ONCE(*seq, 6);
+	spin_unlock(mlock);
+}
+
+exists (0:r0=1 /\ 1:r5=0)
diff --git a/Documentation/litmus-tests/fs/mnt-kern-unmount-holder-get-before-put.litmus b/Documentation/litmus-tests/fs/mnt-kern-unmount-holder-get-before-put.litmus
new file mode 100644
index 000000000000..dd7976f06b93
--- /dev/null
+++ b/Documentation/litmus-tests/fs/mnt-kern-unmount-holder-get-before-put.litmus
@@ -0,0 +1,60 @@
+C mnt-kern-unmount-holder-get-before-put
+
+(*
+ * Result: Never
+ *
+ * mnt-holder-get-before-put.litmus for kern_unmount_array(), where
+ * mnt_make_shortterm() clears ->mnt_ns with a plain WRITE_ONCE(),
+ * outside mount_lock and without a seqcount write, before
+ * mntput_unmounted() sums under the lock.  The pairing is unchanged:
+ * the holder's smp_wmb() against the smp_mb() of mnt_get_count(),
+ * neither of which needs the lock or the seqcount.  Only holders are
+ * modelled.
+ *)
+
+{
+	mnt_ns=1;
+	gets_h=1;
+	puts_h=0;
+	gets_u=1;
+	puts_u=0;
+}
+
+P0(int *mnt_ns, int *gets_h, int *puts_h)
+{
+	int r0;
+
+	WRITE_ONCE(*gets_h, 2);
+	rcu_read_lock();
+	r0 = READ_ONCE(*mnt_ns);
+	if (r0) {
+		smp_wmb();
+		WRITE_ONCE(*puts_h, 1);
+	}
+	rcu_read_unlock();
+}
+
+P1(spinlock_t *mlock, int *seq, int *mnt_ns, int *gets_h, int *puts_h, int *gets_u, int *puts_u)
+{
+	int r1;
+	int r2;
+	int r3;
+	int r4;
+
+	WRITE_ONCE(*mnt_ns, 0);
+
+	spin_lock(mlock);
+	WRITE_ONCE(*seq, 3);
+	smp_wmb();
+	smp_mb();
+	r1 = READ_ONCE(*puts_h);
+	r2 = READ_ONCE(*puts_u);
+	smp_mb();
+	r3 = READ_ONCE(*gets_h);
+	r4 = READ_ONCE(*gets_u);
+	smp_wmb();
+	WRITE_ONCE(*seq, 4);
+	spin_unlock(mlock);
+}
+
+exists (0:r0=1 /\ 1:r1=1 /\ 1:r3=1)
diff --git a/Documentation/litmus-tests/fs/mnt-sum-misses-fastpath-put.litmus b/Documentation/litmus-tests/fs/mnt-sum-misses-fastpath-put.litmus
new file mode 100644
index 000000000000..34347c6a2b25
--- /dev/null
+++ b/Documentation/litmus-tests/fs/mnt-sum-misses-fastpath-put.litmus
@@ -0,0 +1,69 @@
+C mnt-sum-misses-fastpath-put
+
+(*
+ * Result: Sometimes
+ *
+ * A holder drops its reference on the fast path of mntput_no_expire():
+ * READ_ONCE(->mnt_ns) non-NULL under rcu_read_lock(), smp_wmb(), the
+ * put.  umount_tree() clears ->mnt_ns under write_seqlock() and
+ * mntput_unheld() sums the counters with mnt_get_count() under the
+ * lock.  The holder read ->mnt_ns before it was cleared (0:r0=1) and
+ * the sum still does not count its put (1:r1=0): the put is simply
+ * later.  The sum comes out at two, so mntput_unmounted() has to wait
+ * for the holder's read-side critical section before the plain
+ * mntput() that drops the own reference, see
+ * mnt-gp-sees-fastpath-put.litmus.  This is why the grace period
+ * branch exists, not a bug.
+ *)
+
+{
+	mnt_ns=1;
+	gets_h=1;
+	puts_h=0;
+	gets_u=1;
+	puts_u=0;
+}
+
+P0(int *mnt_ns, int *gets_h, int *puts_h)
+{
+	int r0;
+
+	rcu_read_lock();
+	r0 = READ_ONCE(*mnt_ns);
+	if (r0) {
+		smp_wmb();
+		WRITE_ONCE(*puts_h, 1);
+	}
+	rcu_read_unlock();
+}
+
+P1(spinlock_t *mlock, int *seq, int *mnt_ns, int *gets_h, int *puts_h, int *gets_u, int *puts_u)
+{
+	int r1;
+	int r2;
+	int r3;
+	int r4;
+
+	spin_lock(mlock);
+	WRITE_ONCE(*seq, 1);
+	smp_wmb();
+	WRITE_ONCE(*mnt_ns, 0);
+	smp_wmb();
+	WRITE_ONCE(*seq, 2);
+	spin_unlock(mlock);
+
+	spin_lock(mlock);
+	WRITE_ONCE(*seq, 3);
+	smp_wmb();
+	smp_mb();
+	r1 = READ_ONCE(*puts_h);
+	r2 = READ_ONCE(*puts_u);
+	smp_mb();
+	r3 = READ_ONCE(*gets_h);
+	r4 = READ_ONCE(*gets_u);
+	smp_wmb();
+	WRITE_ONCE(*seq, 4);
+	spin_unlock(mlock);
+}
+
+exists (0:r0=1 /\ 1:r1=0)
diff --git a/Documentation/litmus-tests/fs/mnt-walker-bail-sees-doomed-nolock.litmus b/Documentation/litmus-tests/fs/mnt-walker-bail-sees-doomed-nolock.litmus
new file mode 100644
index 000000000000..233f2e65d25d
--- /dev/null
+++ b/Documentation/litmus-tests/fs/mnt-walker-bail-sees-doomed-nolock.litmus
@@ -0,0 +1,89 @@
+C mnt-walker-bail-sees-doomed-nolock
+
+(*
+ * Result: Sometimes
+ *
+ * mnt-walker-bail-sees-doomed.litmus with the walker reading
+ * ->mnt_flags outside mount_lock.  Nothing orders that read against
+ * the sum's critical section: the walker can read the flags before
+ * MNT_DOOMED is set and keep a reference to a mount the sum has
+ * finished off.  This is why __legitimize_mnt() looks under the lock.
+ *)
+
+{
+	mnt_ns=1;
+	gets_w=0;
+	puts_w=0;
+	gets_u=1;
+	puts_u=0;
+	flags=0;
+	seq=0;
+	freed=0;
+}
+
+P0(spinlock_t *mlock, int *seq, int *gets_w, int *puts_w, int *flags)
+{
+	int r0;
+	int r1;
+	int r2;
+	int r3;
+
+	r0 = READ_ONCE(*seq);
+	smp_rmb();
+	smp_rmb();
+	r1 = READ_ONCE(*seq);
+	if (r1 == 0) {
+		WRITE_ONCE(*gets_w, 1);
+		smp_mb();
+		smp_rmb();
+		r2 = READ_ONCE(*seq);
+		if (r2 != 0) {
+			r3 = READ_ONCE(*flags);
+			if (r3 != 0) {
+				WRITE_ONCE(*puts_w, 1);
+			}
+		}
+	}
+}
+
+P1(spinlock_t *mlock, int *seq, int *mnt_ns, int *flags, int *gets_w, int *puts_w, int *gets_u, int *puts_u, int *freed)
+{
+	int r1;
+	int r2;
+	int r3;
+	int r4;
+
+	spin_lock(mlock);
+	WRITE_ONCE(*seq, 1);
+	smp_wmb();
+	WRITE_ONCE(*mnt_ns, 0);
+	smp_wmb();
+	WRITE_ONCE(*seq, 2);
+	spin_unlock(mlock);
+
+	spin_lock(mlock);
+	WRITE_ONCE(*seq, 3);
+	smp_wmb();
+	smp_mb();
+	r1 = READ_ONCE(*puts_w);
+	r2 = READ_ONCE(*puts_u);
+	smp_mb();
+	r3 = READ_ONCE(*gets_w);
+	r4 = READ_ONCE(*gets_u);
+	if (r3 == 0) {
+		WRITE_ONCE(*flags, 3);
+		WRITE_ONCE(*freed, 1);
+	}
+	if (r3 == 1) {
+		if (r1 == 1) {
+			WRITE_ONCE(*flags, 3);
+			WRITE_ONCE(*freed, 1);
+		}
+	}
+	smp_wmb();
+	WRITE_ONCE(*seq, 4);
+	spin_unlock(mlock);
+}
+
+filter (0:r0=0)
+exists (0:r1=0 /\ ~(0:r2=0) /\ 0:r3=0 /\ freed=1)
diff --git a/Documentation/litmus-tests/fs/mnt-walker-bail-sees-doomed.litmus b/Documentation/litmus-tests/fs/mnt-walker-bail-sees-doomed.litmus
new file mode 100644
index 000000000000..187619db7fb6
--- /dev/null
+++ b/Documentation/litmus-tests/fs/mnt-walker-bail-sees-doomed.litmus
@@ -0,0 +1,95 @@
+C mnt-walker-bail-sees-doomed
+
+(*
+ * Result: Never
+ *
+ * A lazy unmount: umount_tree() clears ->mnt_ns under write_seqlock()
+ * without setting MNT_SYNC_UMOUNT, and mntput_unheld() sets MNT_DOOMED
+ * (flags=3) when the sum says nothing else holds the mount.  A walker
+ * in __legitimize_mnt() that sees the seqcount change takes mount_lock
+ * and reads ->mnt_flags there.  Not both the walker finding no flag
+ * set (0:r3=0, it keeps the reference) and the mount being finished
+ * off (freed=1).  mount_lock orders the two critical sections: either
+ * the walker's comes first and the sum counts its increment, or the
+ * sum's does and the walker finds MNT_DOOMED.
+ *)
+
+{
+	mnt_ns=1;
+	gets_w=0;
+	puts_w=0;
+	gets_u=1;
+	puts_u=0;
+	flags=0;
+	seq=0;
+	freed=0;
+}
+
+P0(spinlock_t *mlock, int *seq, int *gets_w, int *puts_w, int *flags)
+{
+	int r0;
+	int r1;
+	int r2;
+	int r3;
+
+	r0 = READ_ONCE(*seq);
+	smp_rmb();
+	smp_rmb();
+	r1 = READ_ONCE(*seq);
+	if (r1 == 0) {
+		WRITE_ONCE(*gets_w, 1);
+		smp_mb();
+		smp_rmb();
+		r2 = READ_ONCE(*seq);
+		if (r2 != 0) {
+			spin_lock(mlock);
+			r3 = READ_ONCE(*flags);
+			if (r3 != 0) {
+				WRITE_ONCE(*puts_w, 1);
+			}
+			spin_unlock(mlock);
+		}
+	}
+}
+
+P1(spinlock_t *mlock, int *seq, int *mnt_ns, int *flags, int *gets_w, int *puts_w, int *gets_u, int *puts_u, int *freed)
+{
+	int r1;
+	int r2;
+	int r3;
+	int r4;
+
+	spin_lock(mlock);
+	WRITE_ONCE(*seq, 1);
+	smp_wmb();
+	WRITE_ONCE(*mnt_ns, 0);
+	smp_wmb();
+	WRITE_ONCE(*seq, 2);
+	spin_unlock(mlock);
+
+	spin_lock(mlock);
+	WRITE_ONCE(*seq, 3);
+	smp_wmb();
+	smp_mb();
+	r1 = READ_ONCE(*puts_w);
+	r2 = READ_ONCE(*puts_u);
+	smp_mb();
+	r3 = READ_ONCE(*gets_w);
+	r4 = READ_ONCE(*gets_u);
+	if (r3 == 0) {
+		WRITE_ONCE(*flags, 3);
+		WRITE_ONCE(*freed, 1);
+	}
+	if (r3 == 1) {
+		if (r1 == 1) {
+			WRITE_ONCE(*flags, 3);
+			WRITE_ONCE(*freed, 1);
+		}
+	}
+	smp_wmb();
+	WRITE_ONCE(*seq, 4);
+	spin_unlock(mlock);
+}
+
+filter (0:r0=0)
+exists (0:r1=0 /\ ~(0:r2=0) /\ 0:r3=0 /\ freed=1)
diff --git a/Documentation/litmus-tests/fs/mnt-walker-get-vs-seqcount-no-outer-mb.litmus b/Documentation/litmus-tests/fs/mnt-walker-get-vs-seqcount-no-outer-mb.litmus
new file mode 100644
index 000000000000..66e65920e491
--- /dev/null
+++ b/Documentation/litmus-tests/fs/mnt-walker-get-vs-seqcount-no-outer-mb.litmus
@@ -0,0 +1,92 @@
+C mnt-walker-get-vs-seqcount-no-outer-mb
+
+(*
+ * Result: Never
+ *
+ * mnt-walker-get-vs-seqcount.litmus with the sum as mntput_unheld()
+ * has it: write_seqlock(), the puts pass, the smp_mb() of
+ * mnt_get_count(), the gets pass, and no smp_mb() between taking the
+ * lock and the sum.  The inner smp_mb() comes after the seqcount store
+ * and before the gets loads in program order, which is all store
+ * buffering asks of the unmounter's side.
+ *)
+
+{
+	mnt_ns=1;
+	gets_w=0;
+	puts_w=0;
+	gets_u=1;
+	puts_u=0;
+	flags=0;
+	seq=0;
+	freed=0;
+}
+
+P0(spinlock_t *mlock, int *seq, int *gets_w, int *puts_w, int *flags)
+{
+	int r0;
+	int r1;
+	int r2;
+	int r3;
+
+	r0 = READ_ONCE(*seq);
+	smp_rmb();
+	smp_rmb();
+	r1 = READ_ONCE(*seq);
+	if (r1 == 0) {
+		WRITE_ONCE(*gets_w, 1);
+		smp_mb();
+		smp_rmb();
+		r2 = READ_ONCE(*seq);
+		if (r2 != 0) {
+			spin_lock(mlock);
+			r3 = READ_ONCE(*flags);
+			if (r3 != 0) {
+				WRITE_ONCE(*puts_w, 1);
+			}
+			spin_unlock(mlock);
+		}
+	}
+}
+
+P1(spinlock_t *mlock, int *seq, int *mnt_ns, int *flags, int *gets_w, int *puts_w, int *gets_u, int *puts_u, int *freed)
+{
+	int r1;
+	int r2;
+	int r3;
+	int r4;
+
+	spin_lock(mlock);
+	WRITE_ONCE(*seq, 1);
+	smp_wmb();
+	WRITE_ONCE(*mnt_ns, 0);
+	WRITE_ONCE(*flags, 1);
+	smp_wmb();
+	WRITE_ONCE(*seq, 2);
+	spin_unlock(mlock);
+
+	spin_lock(mlock);
+	WRITE_ONCE(*seq, 3);
+	smp_wmb();
+	r1 = READ_ONCE(*puts_w);
+	r2 = READ_ONCE(*puts_u);
+	smp_mb();
+	r3 = READ_ONCE(*gets_w);
+	r4 = READ_ONCE(*gets_u);
+	if (r3 == 0) {
+		WRITE_ONCE(*flags, 3);
+		WRITE_ONCE(*freed, 1);
+	}
+	if (r3 == 1) {
+		if (r1 == 1) {
+			WRITE_ONCE(*flags, 3);
+			WRITE_ONCE(*freed, 1);
+		}
+	}
+	smp_wmb();
+	WRITE_ONCE(*seq, 4);
+	spin_unlock(mlock);
+}
+
+filter (0:r0=0)
+exists (0:r1=0 /\ 0:r2=0 /\ freed=1)
diff --git a/Documentation/litmus-tests/fs/mnt-walker-get-vs-seqcount-nomb.litmus b/Documentation/litmus-tests/fs/mnt-walker-get-vs-seqcount-nomb.litmus
new file mode 100644
index 000000000000..e3297207e760
--- /dev/null
+++ b/Documentation/litmus-tests/fs/mnt-walker-get-vs-seqcount-nomb.litmus
@@ -0,0 +1,92 @@
+C mnt-walker-get-vs-seqcount-nomb
+
+(*
+ * Result: Sometimes
+ *
+ * mnt-walker-get-vs-seqcount.litmus without the smp_mb() between the
+ * increment and the re-read of the seqcount in __legitimize_mnt().
+ * The smp_rmb() of read_seqretry() does not order a store against a
+ * later load: the walker sees the seqcount unchanged and keeps its
+ * reference while the sum misses the increment and finishes the mount
+ * off.
+ *)
+
+{
+	mnt_ns=1;
+	gets_w=0;
+	puts_w=0;
+	gets_u=1;
+	puts_u=0;
+	flags=0;
+	seq=0;
+	freed=0;
+}
+
+P0(spinlock_t *mlock, int *seq, int *gets_w, int *puts_w, int *flags)
+{
+	int r0;
+	int r1;
+	int r2;
+	int r3;
+
+	r0 = READ_ONCE(*seq);
+	smp_rmb();
+	smp_rmb();
+	r1 = READ_ONCE(*seq);
+	if (r1 == 0) {
+		WRITE_ONCE(*gets_w, 1);
+		smp_rmb();
+		r2 = READ_ONCE(*seq);
+		if (r2 != 0) {
+			spin_lock(mlock);
+			r3 = READ_ONCE(*flags);
+			if (r3 != 0) {
+				WRITE_ONCE(*puts_w, 1);
+			}
+			spin_unlock(mlock);
+		}
+	}
+}
+
+P1(spinlock_t *mlock, int *seq, int *mnt_ns, int *flags, int *gets_w, int *puts_w, int *gets_u, int *puts_u, int *freed)
+{
+	int r1;
+	int r2;
+	int r3;
+	int r4;
+
+	spin_lock(mlock);
+	WRITE_ONCE(*seq, 1);
+	smp_wmb();
+	WRITE_ONCE(*mnt_ns, 0);
+	WRITE_ONCE(*flags, 1);
+	smp_wmb();
+	WRITE_ONCE(*seq, 2);
+	spin_unlock(mlock);
+
+	spin_lock(mlock);
+	WRITE_ONCE(*seq, 3);
+	smp_wmb();
+	smp_mb();
+	r1 = READ_ONCE(*puts_w);
+	r2 = READ_ONCE(*puts_u);
+	smp_mb();
+	r3 = READ_ONCE(*gets_w);
+	r4 = READ_ONCE(*gets_u);
+	if (r3 == 0) {
+		WRITE_ONCE(*flags, 3);
+		WRITE_ONCE(*freed, 1);
+	}
+	if (r3 == 1) {
+		if (r1 == 1) {
+			WRITE_ONCE(*flags, 3);
+			WRITE_ONCE(*freed, 1);
+		}
+	}
+	smp_wmb();
+	WRITE_ONCE(*seq, 4);
+	spin_unlock(mlock);
+}
+
+filter (0:r0=0)
+exists (0:r1=0 /\ 0:r2=0 /\ freed=1)
diff --git a/Documentation/litmus-tests/fs/mnt-walker-get-vs-seqcount.litmus b/Documentation/litmus-tests/fs/mnt-walker-get-vs-seqcount.litmus
new file mode 100644
index 000000000000..46ca500f8d50
--- /dev/null
+++ b/Documentation/litmus-tests/fs/mnt-walker-get-vs-seqcount.litmus
@@ -0,0 +1,102 @@
+C mnt-walker-get-vs-seqcount
+
+(*
+ * Result: Never
+ *
+ * A walker in __legitimize_mnt() increments its gets counter, does
+ * smp_mb() and re-reads the seqcount of mount_lock with
+ * read_seqretry(); if it changed, the walker takes mount_lock and
+ * drops the reference again when it finds MNT_SYNC_UMOUNT or
+ * MNT_DOOMED.  umount_tree() stores the seqcount when it takes
+ * write_seqlock(), clears ->mnt_ns and sets MNT_SYNC_UMOUNT;
+ * mntput_unheld() takes the lock again and sums with mnt_get_count():
+ * the puts pass, smp_mb(), the gets pass.  Store buffering between the
+ * walker's increment and the unmounter's seqcount store: not both the
+ * walker seeing the seqcount unchanged (0:r1=0, 0:r2=0, it keeps the
+ * reference) and the sum missing the increment (freed=1, the mount is
+ * finished off).  The walker's smp_mb() and the smp_mb() of
+ * mnt_get_count() are the two full barriers that takes.  The sum is
+ * modelled with a further smp_mb() ahead of the puts pass, which the
+ * -no-outer-mb variant drops.
+ *)
+
+{
+	mnt_ns=1;
+	gets_w=0;
+	puts_w=0;
+	gets_u=1;
+	puts_u=0;
+	flags=0;
+	seq=0;
+	freed=0;
+}
+
+P0(spinlock_t *mlock, int *seq, int *gets_w, int *puts_w, int *flags)
+{
+	int r0;
+	int r1;
+	int r2;
+	int r3;
+
+	r0 = READ_ONCE(*seq);
+	smp_rmb();
+	smp_rmb();
+	r1 = READ_ONCE(*seq);
+	if (r1 == 0) {
+		WRITE_ONCE(*gets_w, 1);
+		smp_mb();
+		smp_rmb();
+		r2 = READ_ONCE(*seq);
+		if (r2 != 0) {
+			spin_lock(mlock);
+			r3 = READ_ONCE(*flags);
+			if (r3 != 0) {
+				WRITE_ONCE(*puts_w, 1);
+			}
+			spin_unlock(mlock);
+		}
+	}
+}
+
+P1(spinlock_t *mlock, int *seq, int *mnt_ns, int *flags, int *gets_w, int *puts_w, int *gets_u, int *puts_u, int *freed)
+{
+	int r1;
+	int r2;
+	int r3;
+	int r4;
+
+	spin_lock(mlock);
+	WRITE_ONCE(*seq, 1);
+	smp_wmb();
+	WRITE_ONCE(*mnt_ns, 0);
+	WRITE_ONCE(*flags, 1);
+	smp_wmb();
+	WRITE_ONCE(*seq, 2);
+	spin_unlock(mlock);
+
+	spin_lock(mlock);
+	WRITE_ONCE(*seq, 3);
+	smp_wmb();
+	smp_mb();
+	r1 = READ_ONCE(*puts_w);
+	r2 = READ_ONCE(*puts_u);
+	smp_mb();
+	r3 = READ_ONCE(*gets_w);
+	r4 = READ_ONCE(*gets_u);
+	if (r3 == 0) {
+		WRITE_ONCE(*flags, 3);
+		WRITE_ONCE(*freed, 1);
+	}
+	if (r3 == 1) {
+		if (r1 == 1) {
+			WRITE_ONCE(*flags, 3);
+			WRITE_ONCE(*freed, 1);
+		}
+	}
+	smp_wmb();
+	WRITE_ONCE(*seq, 4);
+	spin_unlock(mlock);
+}
+
+filter (0:r0=0)
+exists (0:r1=0 /\ 0:r2=0 /\ freed=1)
diff --git a/Documentation/litmus-tests/fs/mnt-walker-late-sees-new-pwd-nomb.litmus b/Documentation/litmus-tests/fs/mnt-walker-late-sees-new-pwd-nomb.litmus
new file mode 100644
index 000000000000..38d52c31f0b8
--- /dev/null
+++ b/Documentation/litmus-tests/fs/mnt-walker-late-sees-new-pwd-nomb.litmus
@@ -0,0 +1,89 @@
+C mnt-walker-late-sees-new-pwd-nomb
+
+(*
+ * Result: Sometimes
+ *
+ * mnt-walker-late-sees-new-pwd.litmus without the smp_mb() between the
+ * puts pass and the gets pass of mnt_get_count().  The smp_wmb() of
+ * write_sequnlock() orders stores only: the load of the put can be
+ * satisfied after the seqcount store of the unlock and a walker that
+ * samples the seqcount after the sum still reads the old cwd.
+ *)
+
+{
+	mnt_ns=1;
+	pwd=0;
+	fseq=0;
+	gets_h=1;
+	puts_h=0;
+	gets_u=1;
+	puts_u=0;
+	seq=0;
+}
+
+P0(spinlock_t *fslock, int *fseq, int *pwd, int *mnt_ns, int *puts_h)
+{
+	int r0;
+
+	spin_lock(fslock);
+	WRITE_ONCE(*fseq, 1);
+	smp_wmb();
+	WRITE_ONCE(*pwd, 1);
+	smp_wmb();
+	WRITE_ONCE(*fseq, 2);
+	spin_unlock(fslock);
+
+	rcu_read_lock();
+	r0 = READ_ONCE(*mnt_ns);
+	if (r0) {
+		smp_wmb();
+		WRITE_ONCE(*puts_h, 1);
+	}
+	rcu_read_unlock();
+}
+
+P1(spinlock_t *mlock, int *seq, int *mnt_ns, int *gets_h, int *puts_h, int *gets_u, int *puts_u)
+{
+	int r1;
+	int r2;
+	int r3;
+	int r4;
+
+	spin_lock(mlock);
+	WRITE_ONCE(*seq, 1);
+	smp_wmb();
+	WRITE_ONCE(*mnt_ns, 0);
+	smp_wmb();
+	WRITE_ONCE(*seq, 2);
+	spin_unlock(mlock);
+
+	spin_lock(mlock);
+	WRITE_ONCE(*seq, 3);
+	smp_wmb();
+	r1 = READ_ONCE(*puts_h);
+	r2 = READ_ONCE(*puts_u);
+	r3 = READ_ONCE(*gets_h);
+	r4 = READ_ONCE(*gets_u);
+	smp_wmb();
+	WRITE_ONCE(*seq, 4);
+	spin_unlock(mlock);
+}
+
+P2(int *seq, int *fseq, int *pwd)
+{
+	int r5;
+	int r6;
+	int r7;
+	int r8;
+
+	r5 = READ_ONCE(*seq);
+	smp_rmb();
+	r7 = READ_ONCE(*fseq);
+	smp_rmb();
+	r6 = READ_ONCE(*pwd);
+	smp_rmb();
+	r8 = READ_ONCE(*fseq);
+}
+
+filter (2:r7=0 /\ 2:r8=0 \/ 2:r7=2 /\ 2:r8=2)
+exists (1:r1=1 /\ 2:r5=4 /\ 2:r6=0)
diff --git a/Documentation/litmus-tests/fs/mnt-walker-late-sees-new-pwd-nowmb.litmus b/Documentation/litmus-tests/fs/mnt-walker-late-sees-new-pwd-nowmb.litmus
new file mode 100644
index 000000000000..d3d68619311e
--- /dev/null
+++ b/Documentation/litmus-tests/fs/mnt-walker-late-sees-new-pwd-nowmb.litmus
@@ -0,0 +1,88 @@
+C mnt-walker-late-sees-new-pwd-nowmb
+
+(*
+ * Result: Sometimes
+ *
+ * mnt-walker-late-sees-new-pwd.litmus without the smp_wmb() of
+ * write_sequnlock() after the store of the new fs->pwd and without the
+ * smp_wmb() on the fast path of mntput_no_expire().  Nothing orders the
+ * new fs->pwd before the put: the sum can count the put while a walker
+ * that samples the seqcount after the sum still reads the old cwd.
+ *)
+
+{
+	mnt_ns=1;
+	pwd=0;
+	fseq=0;
+	gets_h=1;
+	puts_h=0;
+	gets_u=1;
+	puts_u=0;
+	seq=0;
+}
+
+P0(spinlock_t *fslock, int *fseq, int *pwd, int *mnt_ns, int *puts_h)
+{
+	int r0;
+
+	spin_lock(fslock);
+	WRITE_ONCE(*fseq, 1);
+	smp_wmb();
+	WRITE_ONCE(*pwd, 1);
+	WRITE_ONCE(*fseq, 2);
+	spin_unlock(fslock);
+
+	rcu_read_lock();
+	r0 = READ_ONCE(*mnt_ns);
+	if (r0) {
+		WRITE_ONCE(*puts_h, 1);
+	}
+	rcu_read_unlock();
+}
+
+P1(spinlock_t *mlock, int *seq, int *mnt_ns, int *gets_h, int *puts_h, int *gets_u, int *puts_u)
+{
+	int r1;
+	int r2;
+	int r3;
+	int r4;
+
+	spin_lock(mlock);
+	WRITE_ONCE(*seq, 1);
+	smp_wmb();
+	WRITE_ONCE(*mnt_ns, 0);
+	smp_wmb();
+	WRITE_ONCE(*seq, 2);
+	spin_unlock(mlock);
+
+	spin_lock(mlock);
+	WRITE_ONCE(*seq, 3);
+	smp_wmb();
+	r1 = READ_ONCE(*puts_h);
+	r2 = READ_ONCE(*puts_u);
+	smp_mb();
+	r3 = READ_ONCE(*gets_h);
+	r4 = READ_ONCE(*gets_u);
+	smp_wmb();
+	WRITE_ONCE(*seq, 4);
+	spin_unlock(mlock);
+}
+
+P2(int *seq, int *fseq, int *pwd)
+{
+	int r5;
+	int r6;
+	int r7;
+	int r8;
+
+	r5 = READ_ONCE(*seq);
+	smp_rmb();
+	r7 = READ_ONCE(*fseq);
+	smp_rmb();
+	r6 = READ_ONCE(*pwd);
+	smp_rmb();
+	r8 = READ_ONCE(*fseq);
+}
+
+filter (2:r7=0 /\ 2:r8=0 \/ 2:r7=2 /\ 2:r8=2)
+exists (1:r1=1 /\ 2:r5=4 /\ 2:r6=0)
diff --git a/Documentation/litmus-tests/fs/mnt-walker-late-sees-new-pwd.litmus b/Documentation/litmus-tests/fs/mnt-walker-late-sees-new-pwd.litmus
new file mode 100644
index 000000000000..3e195dd4317a
--- /dev/null
+++ b/Documentation/litmus-tests/fs/mnt-walker-late-sees-new-pwd.litmus
@@ -0,0 +1,103 @@
+C mnt-walker-late-sees-new-pwd
+
+(*
+ * Result: Never
+ *
+ * A holder has its cwd on the mount and chdir()s away right before
+ * mntput_unheld() sums.  set_fs_pwd() stores the new fs->pwd under
+ * write_seqlock() of fs->seq and then drops the reference to the old cwd
+ * on the fast path of mntput_no_expire(): smp_wmb(), the put.
+ * umount_tree() clears ->mnt_ns under write_seqlock() of mount_lock and
+ * mntput_unheld() sums with mnt_get_count() under the lock: the puts
+ * pass, smp_mb(), the gets pass.  The sum counts the put (1:r1=1), comes
+ * out at one and finishes the mount off.  A walker whose path_init()
+ * samples the seqcount of mount_lock after that critical section
+ * (2:r5=4) and then reads fs->pwd must not read the old cwd (2:r6=0).
+ * Its seqcount sample would never change again and __legitimize_mnt()
+ * would hand it a reference to the finished mount.  The smp_wmb() of
+ * write_sequnlock() orders the new fs->pwd before the put and so does
+ * the smp_wmb() of the fast path, either one is enough.  The smp_mb() of
+ * mnt_get_count() orders the load of the put before the seqcount store
+ * of the unlock, and the walker orders its loads with smp_rmb().  A
+ * holder that already sees ->mnt_ns NULL puts under mount_lock, which
+ * orders the put anyway.
+ *)
+
+{
+	mnt_ns=1;
+	pwd=0;
+	fseq=0;
+	gets_h=1;
+	puts_h=0;
+	gets_u=1;
+	puts_u=0;
+	seq=0;
+}
+
+P0(spinlock_t *fslock, int *fseq, int *pwd, int *mnt_ns, int *puts_h)
+{
+	int r0;
+
+	spin_lock(fslock);
+	WRITE_ONCE(*fseq, 1);
+	smp_wmb();
+	WRITE_ONCE(*pwd, 1);
+	smp_wmb();
+	WRITE_ONCE(*fseq, 2);
+	spin_unlock(fslock);
+
+	rcu_read_lock();
+	r0 = READ_ONCE(*mnt_ns);
+	if (r0) {
+		smp_wmb();
+		WRITE_ONCE(*puts_h, 1);
+	}
+	rcu_read_unlock();
+}
+
+P1(spinlock_t *mlock, int *seq, int *mnt_ns, int *gets_h, int *puts_h, int *gets_u, int *puts_u)
+{
+	int r1;
+	int r2;
+	int r3;
+	int r4;
+
+	spin_lock(mlock);
+	WRITE_ONCE(*seq, 1);
+	smp_wmb();
+	WRITE_ONCE(*mnt_ns, 0);
+	smp_wmb();
+	WRITE_ONCE(*seq, 2);
+	spin_unlock(mlock);
+
+	spin_lock(mlock);
+	WRITE_ONCE(*seq, 3);
+	smp_wmb();
+	r1 = READ_ONCE(*puts_h);
+	r2 = READ_ONCE(*puts_u);
+	smp_mb();
+	r3 = READ_ONCE(*gets_h);
+	r4 = READ_ONCE(*gets_u);
+	smp_wmb();
+	WRITE_ONCE(*seq, 4);
+	spin_unlock(mlock);
+}
+
+P2(int *seq, int *fseq, int *pwd)
+{
+	int r5;
+	int r6;
+	int r7;
+	int r8;
+
+	r5 = READ_ONCE(*seq);
+	smp_rmb();
+	r7 = READ_ONCE(*fseq);
+	smp_rmb();
+	r6 = READ_ONCE(*pwd);
+	smp_rmb();
+	r8 = READ_ONCE(*fseq);
+}
+
+filter (2:r7=0 /\ 2:r8=0 \/ 2:r7=2 /\ 2:r8=2)
+exists (1:r1=1 /\ 2:r5=4 /\ 2:r6=0)

-- 
2.53.0

