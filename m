Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D46E4A0EF3;
	Mon, 12 Oct 2026 15:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819574; cv=none; b=JDkJsR4/cOEKAquENluXKCWzp74Zfntk8H444JcUApx2cmfnAtlnp9t0Lbcuz0YZs9EDHVISEH1xTLExrzpjg3+iHUTKKh9w69TCsyK46irRP/C9UDW3IUT2u9H4f4kdpWlWB38DWCQvGOpy2jWiV9UeeBAg4fxVGQdjRxV9ENI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819574; c=relaxed/simple;
	bh=t0Rzv4A/YaqzcFX0MP84LWevaHwvF3X1c6tqBhoOwvo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=As5/On4nbqW6x47kcVvlGhN7u3C4IsZgc8acGEeOzOW1Dj5I7S/NRSLV/+CFa/AlFeyNtm2EEDa2l1H8uK0zip/NqaRqXAndKZuW+s9sD+3lAvNsT2UtDEM9d2YcaELnRuSNNiMpTIFDJIQMElsAJN2eKceLk89Cf1ZY81d8f+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntavJQQT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntavJQQT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10381F0089B;
	Mon, 12 Oct 2026 15:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791819572;
	bh=nY2vLLEGVsbzSGLjXWVmi2z0MSZasspbMS3bCRBq7Y4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ntavJQQT5lJIDhLZhKu8iDsczr9epxIjrG/8K2zu6cyF23c/LPKaUWjppnnR7QMtl
	 z/6oi7ELj/ziqz3p9l2l0gUFzgleh/Su+ZmpHHgEiyIrZ5RCOsQEjsB9iRkGvHNhE7
	 MWJnkPWUw59Cxr5ptIXFmEK7VfYf5o/mBdz11XJImKAginNOJ2qtIKNfZyKk/sXlqu
	 k8V4FHgWe2Gl88L+6O5Y9rLMAjl7I/o/QC35AZd7KCPOpgRiSb/vCo8AkEqudByUl7
	 D32Y5szUtmF/b6pO2PglzxBJ4kTTDZCshZhvSJWHmRDj+3i1vYjNQC6PgmQ+0oNGTV
	 CV2Ee5W41jPlg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 12 Oct 2026 17:39:15 +0200
Subject: [PATCH 2/9] fs: split the final put out of
 mntput_no_expire_slowpath()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-work-mount-gp_on_demand-proposal-v1-2-43f60221a7d0@kernel.org>
References: <20261012-work-mount-gp_on_demand-proposal-v1-0-43f60221a7d0@kernel.org>
In-Reply-To: <20261012-work-mount-gp_on_demand-proposal-v1-0-43f60221a7d0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 "Paul E. McKenney" <paulmck@kernel.org>, NeilBrown <neil@brown.name>, 
 Alexander Larsson <alexl@redhat.com>, Jan Kara <jack@suse.cz>, 
 Jeff Layton <jlayton@kernel.org>, lkmm@lists.linux.dev, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3149; i=brauner@kernel.org;
 h=from:subject:message-id; bh=t0Rzv4A/YaqzcFX0MP84LWevaHwvF3X1c6tqBhoOwvo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSd+a8996a8v/PBSEX1sNtGG2fEpD3lvnFyl//aOY/Ub
 NdW9Yakd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkgRojw3IJzQuerTpTpnVO
 uGB3OuiAd3zwri/is1e9UxaZJ9DRbMzwV6xD3fKaE8NWv4bm66FHrCZdDdznop17Ielf+4lu966
 ZHAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Split mntput_no_expire_slowpath() into mntput_final_locked() and
mntput_queue_cleanup() so we can reuse them.

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/namespace.c | 64 ++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 24 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 3ed3766f3a18..eacf181298d9 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1410,10 +1410,47 @@ static void delayed_mntput(struct work_struct *unused)
 }
 static DECLARE_DELAYED_WORK(delayed_mntput_work, delayed_mntput);
 
-static void noinline mntput_no_expire_slowpath(struct mount *mnt)
+/*
+ * The count reached zero under mount_lock so we doom the mount and
+ * cleanup everything.
+ */
+static void mntput_final_locked(struct mount *mnt, struct list_head *shrink)
 {
 	struct mnt_cover *cover;
 	struct hlist_node *n;
+
+	VFS_WARN_ON_ONCE(mnt->mnt.mnt_flags & MNT_DOOMED);
+	mnt->mnt.mnt_flags |= MNT_DOOMED;
+
+	mnt_del_instance(mnt);
+	if (unlikely(!list_empty(&mnt->mnt_expire)))
+		list_del(&mnt->mnt_expire);
+
+	/* nothing stays attached to an unmounted mount */
+	VFS_WARN_ON_ONCE(!list_empty(&mnt->mnt_mounts));
+	hlist_for_each_entry_safe(cover, n, &mnt->mnt_covers, node)
+		drop_cover(cover, shrink);
+}
+
+/* cleanup_mnt() sleeps: from task work, or the workqueue for kernel threads */
+static void mntput_queue_cleanup(struct mount *mnt)
+{
+	if (likely(!(mnt->mnt.mnt_flags & MNT_INTERNAL))) {
+		struct task_struct *task = current;
+		if (likely(!(task->flags & PF_KTHREAD))) {
+			init_task_work(&mnt->mnt_rcu, __cleanup_mnt);
+			if (!task_work_add(task, &mnt->mnt_rcu, TWA_RESUME))
+				return;
+		}
+		if (llist_add(&mnt->mnt_llist, &delayed_mntput_list))
+			schedule_delayed_work(&delayed_mntput_work, 1);
+		return;
+	}
+	cleanup_mnt(mnt);
+}
+
+static void noinline mntput_no_expire_slowpath(struct mount *mnt)
+{
 	LIST_HEAD(list);
 	int count;
 
@@ -1437,32 +1474,11 @@ static void noinline mntput_no_expire_slowpath(struct mount *mnt)
 		unlock_mount_hash();
 		return;
 	}
-	mnt->mnt.mnt_flags |= MNT_DOOMED;
+	mntput_final_locked(mnt, &list);
 	rcu_read_unlock();
-
-	mnt_del_instance(mnt);
-	if (unlikely(!list_empty(&mnt->mnt_expire)))
-		list_del(&mnt->mnt_expire);
-
-	/* nothing stays attached to an unmounted mount */
-	VFS_WARN_ON_ONCE(!list_empty(&mnt->mnt_mounts));
-	hlist_for_each_entry_safe(cover, n, &mnt->mnt_covers, node)
-		drop_cover(cover, &list);
 	unlock_mount_hash();
 	shrink_dentry_list(&list);
-
-	if (likely(!(mnt->mnt.mnt_flags & MNT_INTERNAL))) {
-		struct task_struct *task = current;
-		if (likely(!(task->flags & PF_KTHREAD))) {
-			init_task_work(&mnt->mnt_rcu, __cleanup_mnt);
-			if (!task_work_add(task, &mnt->mnt_rcu, TWA_RESUME))
-				return;
-		}
-		if (llist_add(&mnt->mnt_llist, &delayed_mntput_list))
-			schedule_delayed_work(&delayed_mntput_work, 1);
-		return;
-	}
-	cleanup_mnt(mnt);
+	mntput_queue_cleanup(mnt);
 }
 
 static void mntput_no_expire(struct mount *mnt)

-- 
2.53.0

