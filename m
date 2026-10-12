Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3A54A384D;
	Mon, 12 Oct 2026 15:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819590; cv=none; b=jrK7rAa5+XGII5Q/ONGQfilfoUYJe8oO2/vNhgB1YX/6Juq6A82MFQ79txAQGrR6YGbnOMWYl7mK28mhXU0VoCZ0WF+JwX+A4XH6k6kQS93VHeqSVmujQ7jNdFofl5zBzbvqtoLwO8/e7u9IftpeoPwHBQVxVwgFZpcMifzs1WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819590; c=relaxed/simple;
	bh=2DI4zoaixiVFE4YtZLzssE6VYUn+4bxxHAOutiJxAfo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ACUAVgy87S6jBH98vsFWZK7lEjwMY8n4OFNxbKMgdlHY57nKBxZZp7qtING2gGjjepMVbEbpzF/AcGdDq/dD4axzG+nmRRTLbWCGVzEfFLCQDwIoB1sX5icSxUNhfF+cih6DIwzQHD7izD4VbbDm8S84UL8twqXW/hTIr6wqIUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGnkPtAa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGnkPtAa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350731F0089C;
	Mon, 12 Oct 2026 15:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791819589;
	bh=FMEh0qb/Q0ZT4mEuQnrBmkcWJql3nuGRBlO/MXAiooo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZGnkPtAangb03QNBzBX9P8OiKrazUFg/XQTpKUqRdGwI0pCqcDP4PVCt9n3pSoYs5
	 qucJ7yIvJ5Cugvb6xP/BbX9Fi5ELDF45dMe0foZGhEBGgTAtSdFKn4xbQPtI0VjiWn
	 dA4ZN1ZYj+x+mXuD4RUQaofm0cT2OZewSWbVRZkfx1UaWhIU/bJBoUjBGKPNvzoF/i
	 Za9KFnD1kuCSFqsq3QqqEh8gRvtKBLIMdhKkUpMRySmMVrW1y19YwuAZT9xVOjd/JO
	 FLUbCkhmluD283mmNG8DIljlgBSwgVtG0QeQt8rAfvtadFIvtJpzbHHL7JhtQ0FXJ0
	 UN/m2NWwrwmCg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 12 Oct 2026 17:39:22 +0200
Subject: [PATCH 9/9] ipc: unmount the mqueue mount with kern_unmount()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-work-mount-gp_on_demand-proposal-v1-9-43f60221a7d0@kernel.org>
References: <20261012-work-mount-gp_on_demand-proposal-v1-0-43f60221a7d0@kernel.org>
In-Reply-To: <20261012-work-mount-gp_on_demand-proposal-v1-0-43f60221a7d0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 "Paul E. McKenney" <paulmck@kernel.org>, NeilBrown <neil@brown.name>, 
 Alexander Larsson <alexl@redhat.com>, Jan Kara <jack@suse.cz>, 
 Jeff Layton <jlayton@kernel.org>, lkmm@lists.linux.dev, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3339; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2DI4zoaixiVFE4YtZLzssE6VYUn+4bxxHAOutiJxAfo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSd+a9dtTGgzjgwnt9359cz2r58vRJ6iibLGLaFPphop
 ztn+pegjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInMucHwv9LGbLlnldSL/jL/
 uN/qk//qX5DfudLwILeioJzX/C+yBxn+R8slFPAc9g4K23tD5ZZP9po13nu/aAo/rgoTefdVd1k
 ZJwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

free_ipc() open-codes kern_unmount() for the whole batch of dying
namespaces. Just let free_ipc_ns() call kern_unmount() instead. A
namespace whose queues are still open elsewhere now waits for an
expedited grace period of its own instead of the normal one for the
whole batch.

Currently free_ipc() pays a normal grace period for every batch of
dying ipc namespaces. That's one of the two normal grace periods a
podman run --rm costs per container. The other one is for the network
namespace.

That leaves kern_unmount_array() as the only user of
mnt_make_shortterm() so make it static. While at it, update the comment
above the work queue. It isn't there to avoid synchronize_rcu() anymore.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/namespace.c        |  2 +-
 include/linux/mount.h |  1 -
 ipc/namespace.c       | 15 +++------------
 3 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index af36cce922a2..e6b3a3206f3a 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1602,7 +1602,7 @@ EXPORT_SYMBOL(mntget);
  * it finds under mount_lock that it holds the only reference left,
  * see mntput_unheld().
  */
-void mnt_make_shortterm(struct vfsmount *mnt)
+static void mnt_make_shortterm(struct vfsmount *mnt)
 {
 	if (mnt)
 		WRITE_ONCE(real_mount(mnt)->mnt_ns, NULL);
diff --git a/include/linux/mount.h b/include/linux/mount.h
index b16ba5d45605..2342929e2fff 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -74,7 +74,6 @@ extern void mnt_drop_write(struct vfsmount *mnt);
 extern void mnt_drop_write_file(struct file *file);
 extern void mntput(struct vfsmount *mnt);
 extern struct vfsmount *mntget(struct vfsmount *mnt);
-extern void mnt_make_shortterm(struct vfsmount *mnt);
 extern struct vfsmount *mnt_clone_internal(const struct path *path);
 extern bool __mnt_is_readonly(const struct vfsmount *mnt);
 extern bool mnt_may_suid(struct vfsmount *mnt);
diff --git a/ipc/namespace.c b/ipc/namespace.c
index 76df11e0b134..24706b910654 100644
--- a/ipc/namespace.c
+++ b/ipc/namespace.c
@@ -21,7 +21,8 @@
 #include "util.h"
 
 /*
- * The work queue is used to avoid the cost of synchronize_rcu in kern_unmount.
+ * The work queue keeps the teardown of a namespace out of the callers of
+ * put_ipc_ns(), the eviction of an mqueue inode among them.
  */
 static void free_ipc(struct work_struct *unused);
 static DECLARE_WORK(free_ipc_work, free_ipc);
@@ -149,11 +150,7 @@ void free_ipcs(struct ipc_namespace *ns, struct ipc_ids *ids,
 
 static void free_ipc_ns(struct ipc_namespace *ns)
 {
-	/*
-	 * Caller needs to wait for an RCU grace period to have passed
-	 * after making the mount point inaccessible to new accesses.
-	 */
-	mntput(ns->mq_mnt);
+	kern_unmount(ns->mq_mnt);
 	sem_exit_ns(ns);
 	msg_exit_ns(ns);
 	shm_exit_ns(ns);
@@ -173,12 +170,6 @@ static void free_ipc(struct work_struct *unused)
 	struct llist_node *node = llist_del_all(&free_ipc_list);
 	struct ipc_namespace *n, *t;
 
-	llist_for_each_entry_safe(n, t, node, mnt_llist)
-		mnt_make_shortterm(n->mq_mnt);
-
-	/* Wait for any last users to have gone away. */
-	synchronize_rcu();
-
 	llist_for_each_entry_safe(n, t, node, mnt_llist)
 		free_ipc_ns(n);
 }

-- 
2.53.0

