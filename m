Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2DA310651;
	Sun, 11 Oct 2026 15:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791732658; cv=none; b=U2SOMoDa3uNb0y+dQeEZi3y29OgkU39H6SAuRJgp1jgT9yl102x+q/+VIOX08XTvICR9UVzb8GRZ/9JpHiq3cC2gLsMFbYzKS4ueXT7l5VK1ADD5eDzw60U02xODu8psWGHBLC+vDfn4JuA/UvPHiQvWe5u5NbcJLcXJCnOWYi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791732658; c=relaxed/simple;
	bh=0Dy8TUETU55BdH47GrswJDSfNTsX7NhFNHdgtZAPtic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pVAjL4jxLqH7Aeo0vQBGULYzUl9DbYsGXHRpO7Rt9tPBb6JeMLMpkLdtksDhpzpnSmEaJePNHwxbeJm4Gxjd2fhhb28c4IJBInhO3D2ZRc7GhMc0vT4O3SutR/L47ulRo/WlVDXRsLeybbWmwCTlrImhXrlkUoKX7UgKFAglzSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kP2IkOm7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kP2IkOm7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC891F0089C;
	Sun, 11 Oct 2026 15:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791732657;
	bh=lUwdIZb3RKar98XZiYO4UY5CyJPxCYuUAljFO4pqQvQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kP2IkOm7d1ue68pjqWBq6czGNiQAms3XfgoXZQLFa7gbxbL653bsy0ae2CSiLu981
	 tkA62fzHBsIRZ2zVd5YitPD4PTpqtJBtu+Y1OIOfVWDwnEX9/mIoD/o9RxdfksuED2
	 HblX30/q/CGJeIO1HItdoVcrLihspfeMokRPxJmrkyeMF3gAdO39sCdvi1bp5hOaxt
	 wrhXjfpZEW8eNbiOSZ9MXztf5Q0gD0JQE3Vjw3waUU42wMIVssoFmbXMmeT69othVk
	 DsMtiBdyxhbnMpIxx9Alwp/oeUlrJqD2KAI8V0SlL7oLyjNdPtMmvunqiIl+c8YEo2
	 U+3wusKPi3RdA==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 11 Oct 2026 17:30:44 +0200
Subject: [PATCH 1/2] fs: drop the smp_mb()s that mnt_get_count() made
 redundant
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-work-mount-fixes-5-v1-1-a9b9a8ecf565@kernel.org>
References: <20261011-work-mount-fixes-5-v1-0-a9b9a8ecf565@kernel.org>
In-Reply-To: <20261011-work-mount-fixes-5-v1-0-a9b9a8ecf565@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 lkmm@lists.linux.dev, "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4257; i=brauner@kernel.org;
 h=from:subject:message-id; bh=0Dy8TUETU55BdH47GrswJDSfNTsX7NhFNHdgtZAPtic=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSdXr1mt7KT0Lo61gDZ///XT+/ZHZihpCEdtmO9skmm2
 4cvQBUdpSwMYlwMsmKKLA7tJuFyy3kqNhtlasDMYWUCGcLAxSkAE7nmwvDfZ+8Cvf6v2w9/O1Lh
 lmLmZrL0UPZ6Hcs/u3o7r/id7vAKY2ToKm37XSryUvVc8Wm/65Mfl3C8/+r4kSvh6+m+mFUyZ/N
 4AQ==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Both mntput_no_expire_slowpath() and do_umount() have an smp_mb()
between taking mount_lock and summing up the reference count. They pair
with the smp_mb() in __legitimize_mnt().

A walker in __legitimize_mnt() increments the count and then re-reads
the seqcount of mount_lock. The unmounter writes the seqcount when it
takes mount_lock and then sums up the count. They must not both miss
each other's store. Otherwise the walker keeps a reference to a mount
that the unmounter finishes off. That's the store buffering pattern and
it needs a full barrier between the store and the load on both sides.

In commit 119e1ef80ecf ("fix __legitimize_mnt()/mntput() race") the
barrier in the slow path of mntput_no_expire() as added and the one in
do_umount() in commit 65781e19dcfc ("do_umount(): add missing barrier
before refcount checks in sync case"). Back then mnt_get_count() didn't
have a barrier of its own.

Since commit 7eb84d54fac5 ("fs: don't let a migrating task hide its
reference from do_umount()") it does. It sums up the puts, does an
smp_mb() and then sums up the gets. In program order that barrier sits
after the seqcount write in lock_mount_hash() and before the loads of
the gets. That's all the walker needs. If the sum misses the walker's
increment the walker sees the seqcount change and drops its reference
under mount_lock where it finds MNT_DOOMED or MNT_SYNC_UMOUNT.

The only thing the outer barrier orders on top of that is the seqcount
write against the loads of the puts and nothing relies on it:

(1) A put from the fast path of mntput_no_expire() never looks at the
    seqcount. If the sum misses such a put that's what the grace period
    is for.

(2) All other puts happen under mount_lock and are ordered by it.

(3) The slow path's own decrement right before the sum is a store on the
    same cpu and is read back in program order.

So the outer barriers don't order anything that the inner one doesn't.
That argument is made in the kernel memory model and every architecture
has to implement its barriers according to it. herd7 against
tools/memory-model agrees. Without the outer smp_mb() the walker against
the slow path and against the busy check in do_umount() is "Never". If
the inner smp_mb() goes as well it's "Sometimes". The litmus tests for
this are in the next patch.

Make the comments in __legitimize_mnt() and mnt_get_count() point at
each other.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/namespace.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 3ed3766f3a18..b55cd0e8c865 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -297,7 +297,11 @@ int mnt_get_count(struct mount *mnt)
 	/* puts first, so a put counted here has its get counted below */
 	for_each_possible_cpu(cpu)
 		puts += per_cpu_ptr(mnt->mnt_pcp, cpu)->mnt_puts;
-	smp_mb();	/* pairs with the smp_wmb() in mntput_no_expire() */
+	/*
+	 * Pairs with the smp_wmb() in mntput_no_expire() and with the
+	 * smp_mb() in __legitimize_mnt().
+	 */
+	smp_mb();
 	for_each_possible_cpu(cpu)
 		gets += per_cpu_ptr(mnt->mnt_pcp, cpu)->mnt_gets;
 
@@ -782,7 +786,7 @@ int __legitimize_mnt(struct vfsmount *bastard, unsigned seq)
 		return 0;
 	mnt = real_mount(bastard);
 	mnt_inc_count(mnt);
-	smp_mb();	/* see mntput_no_expire_slowpath() and do_umount() */
+	smp_mb();	/* pairs with the smp_mb() in mnt_get_count() */
 	if (likely(!read_seqretry(&mount_lock, seq)))
 		return 0;
 	lock_mount_hash();
@@ -1419,11 +1423,6 @@ static void noinline mntput_no_expire_slowpath(struct mount *mnt)
 
 	VFS_BUG_ON(mnt->mnt_ns);
 	lock_mount_hash();
-	/*
-	 * make sure that if __legitimize_mnt() has not seen us grab
-	 * mount_lock, we'll see their refcount increment here.
-	 */
-	smp_mb();
 	mnt_dec_count(mnt);
 	count = mnt_get_count(mnt);
 	if (count != 0) {
@@ -2006,7 +2005,6 @@ static int do_umount(struct mount *mnt, int flags)
 		umount_tree(mnt, UMOUNT_PROPAGATE);
 		retval = 0;
 	} else {
-		smp_mb(); // paired with __legitimize_mnt()
 		shrink_submounts(mnt);
 		retval = -EBUSY;
 		if (!propagate_mount_busy(mnt, 2)) {

-- 
2.53.0

