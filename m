Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net [178.154.239.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A44C3F86EA;
	Thu, 13 Aug 2026 09:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786614333; cv=none; b=unyTCbVjPm9ARSMkgI+/52pIs1YTf3osreX7n36OqXKaAgfEGZgsK9arD8ouVHM615FQsfAvEqAWb6h/IXbGJ4matsyTZl9huiZc4WXV0/VmIKWuPz0VsEtmWbjj3aCZohRiZVIHCewimc9L5bP6ArNH/xPC0l9MW06GucESTNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786614333; c=relaxed/simple;
	bh=m4w1XwuFK3X5lApld8D17ehvlNho8fiKoAI5WihrXY0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZnLxaPRC2P4YVyewdTxR/ZfbTNN1n/dIpyUwTjuTSVJV/Y4UH9EupziS9lQzUwahZztk9FNqhrEUplrTP1pNBH/6HTV0/7l5h0p37ZQkQvgJEWZ4nzSxItNabtxzSIYK4yb/TRORNzYD1/SeP9SXVm8TI7TxVj4POqxaUiUF5PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=nYS0h0FQ; arc=none smtp.client-ip=178.154.239.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="nYS0h0FQ"
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net [IPv6:2a02:6b8:c11:43a8:0:640:574d:0])
	by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 83308808E6;
	Thu, 13 Aug 2026 12:43:37 +0300 (MSK)
Received: from [127.0.1.1] (unknown [2a02:6bf:8009:1403:13e2:aa39:7988:f1b2])
	by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA id YhMvcMH3p0U0-xIhwMUQR;
	Thu, 13 Aug 2026 12:43:36 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1786614217;
	bh=YAwfVd7GutEdwn+cskftuCKF+M/AxPGC2e/iuoUawf8=;
	h=Cc:In-Reply-To:Message-Id:To:Date:References:From:Subject;
	b=nYS0h0FQOVMSGIKcUZeE+eOcVQFm64dWFEx9fwuK8b4yqxHOQ3S7SAVYLf8TuPXmN
	 HQRJU9c7sBW5e68Wm0AktjUbHUYEbRl3txwfQiAqw+Hx00fKHGT5to50PWeaQGSTdl
	 2T2fzIX+RPpaJQZTa5q8qVH58mTvdRvRyOBr0z2U=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Mikhail Rudenko <xyzzy@yandex-team.ru>
Date: Thu, 13 Aug 2026 12:43:29 +0300
Subject: [PATCH RFC 1/2] fs: add superblock deferred iput infrastructure
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-deferred-dirtytime-iput-v1-1-ad2fb3ad6bdb@yandex-team.ru>
References: <20260813-deferred-dirtytime-iput-v1-0-ad2fb3ad6bdb@yandex-team.ru>
In-Reply-To: <20260813-deferred-dirtytime-iput-v1-0-ad2fb3ad6bdb@yandex-team.ru>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mikhail Rudenko <xyzzy@yandex-team.ru>
X-Mailer: b4 0.15.2

Add the superblock side of deferred final iput processing. The new
helper queues an inode on a per-superblock list and schedules an
unbound WQ_MEM_RECLAIM worker to retry iput() outside the caller's
context.

Superblock teardown shuts the queue down and flushes pending work after
the shrinker is unregistered and before ->kill_sb(). This processes
queued inodes while the superblock and filesystem are still alive.

This is preparation for deferring dirtytime final iput from PF_MEMALLOC
context.

Signed-off-by: Mikhail Rudenko <xyzzy@yandex-team.ru>
---
 fs/dcache.c                    |  1 +
 fs/internal.h                  |  3 ++
 fs/super.c                     | 92 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs/super_types.h |  6 +++
 4 files changed, 102 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index 3e9af9de7074..5465d8dbfdd2 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -3511,6 +3511,7 @@ void __init vfs_caches_init(void)
 {
 	filename_init();
 	dcache_init();
+	super_init();
 	inode_init();
 	files_init();
 	files_maxfiles_init();
diff --git a/fs/internal.h b/fs/internal.h
index 355d93f92208..641b9a0c612d 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -9,6 +9,7 @@ struct super_block;
 struct file_system_type;
 struct iomap;
 struct iomap_ops;
+struct inode;
 struct linux_binprm;
 struct path;
 struct mount;
@@ -138,6 +139,8 @@ extern bool super_trylock_shared(struct super_block *sb);
 struct super_block *user_get_super(dev_t, bool excl);
 void put_super(struct super_block *sb);
 extern bool mount_capable(struct fs_context *);
+void __init super_init(void);
+int super_defer_iput(struct inode *inode);
 
 /*
  * Prepare superblock for changing its read-only state (i.e., either remount
diff --git a/fs/super.c b/fs/super.c
index a8fd61136aaf..2f318694c98b 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -37,6 +37,7 @@
 #include <linux/user_namespace.h>
 #include <linux/fs_context.h>
 #include <linux/fserror.h>
+#include <linux/workqueue.h>
 #include <uapi/linux/mount.h>
 #include "internal.h"
 
@@ -45,6 +46,7 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who,
 
 static LIST_HEAD(super_blocks);
 static DEFINE_SPINLOCK(sb_lock);
+static struct workqueue_struct *super_deferred_iput_wq __ro_after_init;
 
 static char *sb_writers_name[SB_FREEZE_LEVELS] = {
 	"sb_writers",
@@ -52,6 +54,89 @@ static char *sb_writers_name[SB_FREEZE_LEVELS] = {
 	"sb_internal",
 };
 
+/*
+ * sb->s_deferred_iput_lock protects sb->s_deferred_iputs and inode->i_lru
+ * while the inode is queued there.
+ */
+static void super_deferred_iput_work(struct work_struct *work)
+{
+	struct super_block *sb = container_of(work, struct super_block,
+					      s_deferred_iput_work);
+	LIST_HEAD(pending);
+
+	for (;;) {
+		spin_lock(&sb->s_deferred_iput_lock);
+		list_splice_init(&sb->s_deferred_iputs, &pending);
+		spin_unlock(&sb->s_deferred_iput_lock);
+
+		if (list_empty(&pending))
+			break;
+
+		while (!list_empty(&pending)) {
+			struct inode *inode;
+
+			inode = list_first_entry(&pending, struct inode, i_lru);
+			list_del_init(&inode->i_lru);
+			iput(inode);
+			cond_resched();
+		}
+	}
+}
+
+static void __init super_deferred_iput_wq_init(void)
+{
+	super_deferred_iput_wq = alloc_workqueue("super_deferred_iput",
+						 WQ_UNBOUND | WQ_MEM_RECLAIM, 0);
+	if (!super_deferred_iput_wq)
+		panic("Failed to allocate super deferred iput workqueue\n");
+}
+
+void __init super_init(void)
+{
+	super_deferred_iput_wq_init();
+}
+
+static void super_deferred_iput_init(struct super_block *sb)
+{
+	spin_lock_init(&sb->s_deferred_iput_lock);
+	INIT_LIST_HEAD(&sb->s_deferred_iputs);
+	INIT_WORK(&sb->s_deferred_iput_work, super_deferred_iput_work);
+	sb->s_deferred_iput_shutdown = false;
+}
+
+static void super_deferred_iput_shutdown(struct super_block *sb)
+{
+	bool empty;
+
+	spin_lock(&sb->s_deferred_iput_lock);
+	sb->s_deferred_iput_shutdown = true;
+	spin_unlock(&sb->s_deferred_iput_lock);
+
+	flush_work(&sb->s_deferred_iput_work);
+
+	spin_lock(&sb->s_deferred_iput_lock);
+	empty = list_empty(&sb->s_deferred_iputs);
+	spin_unlock(&sb->s_deferred_iput_lock);
+	WARN_ON_ONCE(!empty);
+}
+
+int super_defer_iput(struct inode *inode)
+{
+	struct super_block *sb = inode->i_sb;
+	int ret = -ESHUTDOWN;
+
+	spin_lock(&sb->s_deferred_iput_lock);
+	if (!sb->s_deferred_iput_shutdown) {
+		list_add_tail(&inode->i_lru, &sb->s_deferred_iputs);
+		/* Queue under the lock so shutdown cannot miss this work. */
+		queue_work(super_deferred_iput_wq, &sb->s_deferred_iput_work);
+		ret = 0;
+	}
+	spin_unlock(&sb->s_deferred_iput_lock);
+
+	return ret;
+}
+
 static inline void __super_lock(struct super_block *sb, bool excl)
 {
 	if (excl)
@@ -363,6 +448,7 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	mutex_init(&s->s_sync_lock);
 	INIT_LIST_HEAD(&s->s_inodes);
 	spin_lock_init(&s->s_inode_list_lock);
+	super_deferred_iput_init(s);
 	INIT_LIST_HEAD(&s->s_inodes_wb);
 	spin_lock_init(&s->s_inode_wblist_lock);
 	fserror_mount(s);
@@ -474,6 +560,12 @@ void deactivate_locked_super(struct super_block *s)
 	struct file_system_type *fs = s->s_type;
 	if (atomic_dec_and_test(&s->s_active)) {
 		shrinker_free(s->s_shrink);
+		/*
+		 * The shrinker can leave final inode references queued for
+		 * processing outside reclaim. Drain them before
+		 * filesystem-specific shutdown starts.
+		 */
+		super_deferred_iput_shutdown(s);
 		fs->kill_sb(s);
 
 		kill_super_notify(s);
diff --git a/include/linux/fs/super_types.h b/include/linux/fs/super_types.h
index ef7941e9dc79..9bd4abbdbd51 100644
--- a/include/linux/fs/super_types.h
+++ b/include/linux/fs/super_types.h
@@ -255,6 +255,12 @@ struct super_block {
 	 */
 	struct list_lru				s_dentry_lru;
 	struct list_lru				s_inode_lru;
+	/* Protects s_deferred_iputs and s_deferred_iput_shutdown. */
+	spinlock_t				s_deferred_iput_lock;
+	/* Inodes whose final iput was deferred from PF_MEMALLOC context. */
+	struct list_head			s_deferred_iputs;
+	struct work_struct			s_deferred_iput_work;
+	bool					s_deferred_iput_shutdown;
 	struct rcu_head				rcu;
 	struct work_struct			destroy_work;
 

-- 
2.55.0

