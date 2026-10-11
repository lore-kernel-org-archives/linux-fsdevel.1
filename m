Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF3B2D1F40;
	Sun, 11 Oct 2026 15:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791732660; cv=none; b=pcDou3zl2wF7p5hhtOjzpqdEmv8KTuUUECEtHD78ALqlN3+VCey3kvxtXQt0oIffaVWfCoAsFiz2NTO0gvgNkA/LisLwfuEaRHISYd71Uix0M47Sevd7P2K9xooLoAnOba/1w7ZlWJPAeYBxSSlmrExii6qo3QvFOavMRs6+GSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791732660; c=relaxed/simple;
	bh=sdEgDj1YoYpKUdiKXsso6GU4dymC2s92kKQMCkZNegg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MhyfkVipJyUiIf1bHtdMEJ4hx5HNrrA4WazeWxd1LH8fXLl9s8WNU5nDtSehmUhBYH1x4B3NIfMrgmrEJj/uL/rVn47STTWkfeos4GQQoiqcnG1rsPUcLXmHg8BdaS3jQwLTJJbDEui7deUfUjEaeNqXmJqtF3tpQKKQ4ztqjwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=giAo6bah; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="giAo6bah"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 895521F0089B;
	Sun, 11 Oct 2026 15:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791732658;
	bh=UVy1zPoPklJNnLTUG5sLfKRnr6warRvu5Qgik26PCFg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=giAo6bah9APVGPfAbCqJdMoiy1JOu5aP1dnXXHm7VvPPsU6Pydck92cr1HDRmLxDC
	 tHgDUb9zH1UnVTrw2GsL0aMEKRI8upU4OcseVSuieh24aTnrZTUZwuIXcCuq775yLq
	 GXAoKeyr1EvOvzY4spwarlzhwxbe7yESWSmcgtMu2jchUXlBsSLTzqDoWcYc/mpNxA
	 ru1M1wx4/+Y3tWOJ0r9l+Jz2t/0g1cloYv938ZN7JkSllJVtib/E3S0yCg8FAzCWJf
	 v2e5LrK08Tect76H3D+Hp6K5Xp1T8x69WhJmScVpOgAC73p3xbFBBfx8LJ5EIPcwUF
	 pEW74XX4fWPLA==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 11 Oct 2026 17:30:45 +0200
Subject: [PATCH 2/2] Documentation/litmus-tests: add the mnt_get_count()
 barrier tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-work-mount-fixes-5-v1-2-a9b9a8ecf565@kernel.org>
References: <20261011-work-mount-fixes-5-v1-0-a9b9a8ecf565@kernel.org>
In-Reply-To: <20261011-work-mount-fixes-5-v1-0-a9b9a8ecf565@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 lkmm@lists.linux.dev, "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=7483; i=brauner@kernel.org;
 h=from:subject:message-id; bh=sdEgDj1YoYpKUdiKXsso6GU4dymC2s92kKQMCkZNegg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSdXr2mkyV/Swfnr+QNBp/YWXeZmN2bP//1xsNpd1TUV
 ft27BP41lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRLCNGhulnIm23nPV6GWuZ
 dzeWK2fVp103/unqPmXa/kbT+ky2QyTDP+OetPN6wjlvs7j+B/rydW08co4v827RaqsTnrey5b9
 qMQEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add litmus tests for the two places that sum up the reference count of a
mount under mount_lock while a walker in __legitimize_mnt() takes a
reference without it:

- the final put in mntput_no_expire_slowpath()
- the busy check in do_umount()

Neither has an smp_mb() between taking mount_lock and mnt_get_count()
anymore. The smp_mb() in mnt_get_count() sits after the seqcount store
in lock_mount_hash() and before the loads of the gets. So it's the full
barrier that the walker's smp_mb() needs on the other side. Both tests
are "Never". If the smp_mb() in mnt_get_count() or the walker's smp_mb()
is removed they become "Sometimes".

Each test is a two-process cut of fs/namespace.c. The per-cpu counters
are one variable per cpu, write_seqlock() is spelled out as a spinlock,
a seqcount store and an smp_wmb(), and read_seqretry() is an smp_rmb()
and a READ_ONCE().

Run them with herd7 against tools/memory-model:

    cd tools/memory-model
    herd7 -conf linux-kernel.cfg ../../Documentation/litmus-tests/fs/<test>

The memory model is the contract that every architecture's smp_mb(),
smp_wmb(), READ_ONCE(), WRITE_ONCE() and spinlock implementation has to
follow. So a "Never" there holds on all architectures.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 Documentation/litmus-tests/README                  | 20 +++++
 .../fs/mnt-slowpath-sum-no-outer-mb.litmus         | 85 ++++++++++++++++++++++
 .../fs/mnt-umount-busy-sum-no-outer-mb.litmus      | 83 +++++++++++++++++++++
 3 files changed, 188 insertions(+)

diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
index 6c666f3422ea..655aeda42fe1 100644
--- a/Documentation/litmus-tests/README
+++ b/Documentation/litmus-tests/README
@@ -38,6 +38,26 @@ cmpxchg-fail-unordered-2.litmus
     acquire operation.
 
 
+fs (/fs directory)
+------------------
+
+The reference count of a mount is split into per-CPU gets and puts.  A
+walker in __legitimize_mnt() takes a reference during an RCU path walk
+without mount_lock, and mntput_no_expire_slowpath() and do_umount() sum
+the counters under mount_lock with mnt_get_count().  The tests spell
+write_seqlock() out as a spinlock, a seqcount store and smp_wmb(),
+read_seqbegin() and read_seqretry() as READ_ONCE() and smp_rmb(), and
+the per-CPU counters as one variable per CPU.
+
+mnt-slowpath-sum-no-outer-mb.litmus
+    Demonstrates that mntput_no_expire_slowpath() needs no smp_mb()
+    between taking mount_lock and mnt_get_count() to pair with the
+    walker's smp_mb().
+
+mnt-umount-busy-sum-no-outer-mb.litmus
+    The same for the busy check of do_umount().
+
+
 locking (/locking directory)
 ----------------------------
 
diff --git a/Documentation/litmus-tests/fs/mnt-slowpath-sum-no-outer-mb.litmus b/Documentation/litmus-tests/fs/mnt-slowpath-sum-no-outer-mb.litmus
new file mode 100644
index 000000000000..d844f4ce65e0
--- /dev/null
+++ b/Documentation/litmus-tests/fs/mnt-slowpath-sum-no-outer-mb.litmus
@@ -0,0 +1,85 @@
+C mnt-slowpath-sum-no-outer-mb
+
+(*
+ * Result: Never
+ *
+ * mntput_no_expire_slowpath() against a walker in __legitimize_mnt():
+ * lock_mount_hash() stores the seqcount, mnt_dec_count() drops the own
+ * reference, mnt_get_count() sums the puts, does smp_mb() and sums the
+ * gets, and a count of zero finishes the mount off.  There is no
+ * smp_mb() between taking the lock and the sum.  The smp_mb() of
+ * mnt_get_count() sits after the seqcount store and before the gets
+ * loads in program order, which is what store buffering against the
+ * walker's smp_mb() needs.  Not both the walker keeping its reference
+ * (0:r1=0, 0:r2=0) and the slow path freeing the mount (freed=1).  The
+ * own decrement ahead of the sum is a store of the running CPU, read
+ * back in program order.  The initial state is the mount after
+ * umount_tree().  A walker that started before that never meets the
+ * final put, the grace period in namespace_unlock() sees to it.
+ *)
+
+{
+	gets_w=0;
+	puts_w=0;
+	gets_u=1;
+	puts_u=0;
+	flags=1;
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
+P1(spinlock_t *mlock, int *seq, int *flags, int *gets_w, int *puts_w,
+   int *gets_u, int *puts_u, int *freed)
+{
+	int r1;
+	int r2;
+	int r3;
+	int r4;
+
+	spin_lock(mlock);
+	WRITE_ONCE(*seq, 1);
+	smp_wmb();
+	WRITE_ONCE(*puts_u, 1);
+	r1 = READ_ONCE(*puts_w);
+	r2 = READ_ONCE(*puts_u);
+	smp_mb();
+	r3 = READ_ONCE(*gets_w);
+	r4 = READ_ONCE(*gets_u);
+	if (r3 == r1) {
+		WRITE_ONCE(*flags, 3);
+		WRITE_ONCE(*freed, 1);
+	}
+	smp_wmb();
+	WRITE_ONCE(*seq, 2);
+	spin_unlock(mlock);
+}
+
+filter (0:r0=0)
+exists (0:r1=0 /\ 0:r2=0 /\ freed=1)
diff --git a/Documentation/litmus-tests/fs/mnt-umount-busy-sum-no-outer-mb.litmus b/Documentation/litmus-tests/fs/mnt-umount-busy-sum-no-outer-mb.litmus
new file mode 100644
index 000000000000..ef6ec9381777
--- /dev/null
+++ b/Documentation/litmus-tests/fs/mnt-umount-busy-sum-no-outer-mb.litmus
@@ -0,0 +1,83 @@
+C mnt-umount-busy-sum-no-outer-mb
+
+(*
+ * Result: Never
+ *
+ * The busy check of do_umount() against a walker in __legitimize_mnt():
+ * lock_mount_hash() stores the seqcount and propagate_mount_busy() sums
+ * with mnt_get_count(), the puts pass, smp_mb(), the gets pass.  When
+ * the sum finds no reference the caller does not account for,
+ * umount_tree() clears ->mnt_ns and sets MNT_SYNC_UMOUNT under the
+ * same lock (freed=1 marks the unmount going ahead).  There is no
+ * smp_mb() between taking the lock and the sum; the smp_mb() of
+ * mnt_get_count() is the full barrier store buffering needs on this
+ * side.  Not both the walker keeping its reference (0:r1=0, 0:r2=0)
+ * and the unmount going ahead.
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
+P1(spinlock_t *mlock, int *seq, int *mnt_ns, int *flags, int *gets_w,
+   int *puts_w, int *gets_u, int *puts_u, int *freed)
+{
+	int r1;
+	int r2;
+	int r3;
+	int r4;
+
+	spin_lock(mlock);
+	WRITE_ONCE(*seq, 1);
+	smp_wmb();
+	r1 = READ_ONCE(*puts_w);
+	r2 = READ_ONCE(*puts_u);
+	smp_mb();
+	r3 = READ_ONCE(*gets_w);
+	r4 = READ_ONCE(*gets_u);
+	if (r3 == r1) {
+		WRITE_ONCE(*mnt_ns, 0);
+		WRITE_ONCE(*flags, 1);
+		WRITE_ONCE(*freed, 1);
+	}
+	smp_wmb();
+	WRITE_ONCE(*seq, 2);
+	spin_unlock(mlock);
+}
+
+filter (0:r0=0)
+exists (0:r1=0 /\ 0:r2=0 /\ freed=1)

-- 
2.53.0

