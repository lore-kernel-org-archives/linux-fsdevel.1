Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792748554;
	b=hH0bvpzkx+zm+NyTHHhU36tC7MirMt5zD00vx1gedCcNC8x2U6VCxX2ElpMiVAxdh9Nq
	 PRPt58YiSE7CgXDpYqEGczsnxGoBvcfeeT3khl1vZoWF8KNJUHYFs5VjPHh9u4nYE236R
	 HNdW/GAb7a+hUgK4WYMxub7UwVGuLH/JFactUh9h9OenKXQ9rMXdsMuLb5FW5D33eYVTq
	 ZcHIlf8AXO5F8YYWftB5ELpSWpL9BMjTlTQBvrZd2EE1KLkfjo7S58oGNNe0YXXJwvThq
	 kNJsTdL/7hu8V3gTBA87VnBmcAzoYNp7cItEoxBR9QRyxkyqb8WLJSsqYnb2zfFJz8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792748554;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=YL7WBpazbRLf00nGBYbE+lsiwRbcvbYmywK+/jMsRiQ=;
	b=OUglEqwBSboRGfIkuAO31iBUuqXnseC2v1qx18et4ytvHFeuQhsUoyIVjlNd68op81S9
	 GowygI/NHH7PWmFlkDtJgfOCLr1uRUS1IE+lUIoHUOwd2zqcMNmXbZZAxCx/MCy0/DMrq
	 bFm9gZW63FFCRTwFZm+qFYIWCuqAvnJIPH27pEE57s/zd+jIkeGZKQRBzUW9iyL3isbrL
	 IdB3Da5MyCWTeiAQTwp33dUSnIuLKaeqo2lXNqqKgcBtYXiV/ubskxNE1Fs+fIxmureLt
	 knx3szhCSVFeAc1G8P8eedf0DPMRKP9xq55OiAnuC745GRi4ugDi5D1fenlPn3XyQMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gT7bCWS/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF5C606A334;
	Fri, 23 Oct 2026 09:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gT7bCWS/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C53161F01825;
	Fri, 23 Oct 2026 09:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792748554;
	bh=YL7WBpazbRLf00nGBYbE+lsiwRbcvbYmywK+/jMsRiQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gT7bCWS/A27P491zsDx3naIVVdlBsq5YGKWG9VQklpTtVtAE0Vd9RniFSG+JsIrzg
	 WMtNohQnP1J9g2p287VUEcFELPrWulR4KnBBV8SYC1aq4BKITOvpdDrVEY+uWA2fGE
	 kWFJdXbH2NOuzjqbWVJinW9CdpQWiKxf9gjg3wv9irx05gcaGzsGgkQ1bxFFPyY8Sg
	 g6SMUs0lNaBfMQm6y56ukbgNQQ47RWEfyI4l8GBXPWttpCV251FjdQ2nlyQP6IbHq5
	 DTRousCRwhfzEQigmgoF59mxbtSaEJxtYBAr7D94V88tSM/PYvfA+VnZLAbqD8WlWj
	 bf7oXpUYgtkQA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 23 Oct 2026 11:41:05 +0200
Subject: [PATCH 5/5] super: add a guard for super_lock()
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-work-super-lock_helpers-v1-5-d0fcb3f2f275@kernel.org>
References: <20261023-work-super-lock_helpers-v1-0-d0fcb3f2f275@kernel.org>
In-Reply-To: <20261023-work-super-lock_helpers-v1-0-d0fcb3f2f275@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5763; i=brauner@kernel.org;
 h=from:subject:message-id; bh=H/yHfcoSTHp4xNgjjwU9MRaZwR55NiTll80tOhydvaI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTd1v77KWm13qfZPuZcU8/MveTXtWf22d+XArVyJ6xcU
 qGmZ5ZX01HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRehNGhr3WYllL950/lvXl
 TIDMqfgv1iKiHifUhVc49c1/WLdl9V2G/4k3DwcZe1v8N5Kfxbt7h+ez+qeTcjOyD2k0xi0wuJU
 YyAgA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Six callers take s_umount and drop it again in the same scope and have
to pick the unlock that matches the lock they took. Add a guard for
super_lock() that unlocks with the flags it locked with and convert
them. Similar to irqdesc_lock let's build it from
__DEFINE_UNLOCK_GUARD() as super_lock() takes its flags at runtime.

The device walks use ACQUIRE() instead of scoped_guard() so a continue
still moves on to the next superblock. __iterate_supers() uses ACQUIRE()
as well because, like fs_bdev_sync(), it needs ACQUIRE_ERR() to tell
-ENOENT from a fatal signal. The callers that hand the lock off stay as
they are.

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/super.c | 83 ++++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 51 insertions(+), 32 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index a0f9eadf0da7..aff2169ca94d 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -206,6 +206,31 @@ static __must_check int super_lock(struct super_block *sb,
 	return -ENOENT;
 }
 
+static inline void super_unlock_guard(struct super_block *sb,
+				      enum super_lock_flags_t flags)
+{
+	if (!IS_ERR_OR_NULL(sb))
+		super_unlock(sb, flags);
+}
+
+/* Unlocks with the flags it locked with. */
+__DEFINE_CLASS_IS_CONDITIONAL(super_lock, true);
+__DEFINE_UNLOCK_GUARD(super_lock, struct super_block,
+		      super_unlock_guard(_T->lock, _T->flags),
+		      enum super_lock_flags_t flags);
+
+static inline class_super_lock_t
+class_super_lock_constructor(struct super_block *sb, enum super_lock_flags_t flags)
+{
+	class_super_lock_t _t = { .lock = sb, .flags = flags };
+	int ret;
+
+	ret = super_lock(sb, flags);
+	if (ret)
+		_t.lock = ERR_PTR(ret);
+	return _t;
+}
+
 /* wake waiters */
 #define SUPER_WAKE_FLAGS (SB_BORN | SB_DYING | SB_DEAD)
 static void super_wake(struct super_block *sb, unsigned int flag)
@@ -1037,13 +1062,13 @@ static int __iterate_supers(void (*f)(struct super_block *, void *), void *arg,
 		if (flags & SUPER_ITER_UNLOCKED) {
 			f(sb, arg);
 		} else {
-			ret = super_lock(sb, lock_flags);
-			if (!ret) {
+			ACQUIRE(super_lock, lock)(sb, lock_flags);
+
+			ret = ACQUIRE_ERR(super_lock, &lock);
+			if (!ret)
 				f(sb, arg);
-				super_unlock_shared(sb);
-			} else if (ret == -ENOENT) {
+			else if (ret == -ENOENT)
 				ret = 0;
-			}
 		}
 
 		if (p)
@@ -1124,10 +1149,8 @@ void iterate_supers_type(struct file_system_type *type,
 
 		spin_unlock(&sb_lock);
 
-		if (!super_lock(sb, 0)) {
+		scoped_guard(super_lock, sb, 0)
 			f(sb, arg);
-			super_unlock_shared(sb);
-		}
 
 		if (p)
 			put_super(p);
@@ -1274,18 +1297,18 @@ static void do_emergency_remount_callback(struct super_block *sb, void *unused)
 	struct fs_context *fc = NULL;
 
 	/* the unmount writes the filesystem out, wait for that */
-	if (super_lock(sb, SUPER_LOCK_EXCL | SUPER_LOCK_WAIT_SHUTDOWN))
-		return;
-
-	/* Make sure no reference put under s_umount is the last one. */
-	atomic_inc(&sb->s_active);
-	if (sb->s_bdev && !sb_rdonly(sb)) {
-		fc = fs_context_for_reconfigure(sb->s_root,
-					SB_RDONLY | SB_FORCE, SB_RDONLY);
-		if (!IS_ERR(fc) && parse_monolithic_mount_data(fc, NULL) == 0)
-			(void)reconfigure_super(fc);
+	scoped_cond_guard(super_lock, return, sb,
+			  SUPER_LOCK_EXCL | SUPER_LOCK_WAIT_SHUTDOWN) {
+		/* Make sure no reference put under s_umount is the last one. */
+		atomic_inc(&sb->s_active);
+		if (sb->s_bdev && !sb_rdonly(sb)) {
+			fc = fs_context_for_reconfigure(sb->s_root,
+						SB_RDONLY | SB_FORCE, SB_RDONLY);
+			if (!IS_ERR(fc) &&
+			    parse_monolithic_mount_data(fc, NULL) == 0)
+				(void)reconfigure_super(fc);
+		}
 	}
-	super_unlock_excl(sb);
 
 	/*
 	 * Our active reference may be the last one by now, so only drop it
@@ -1318,13 +1341,9 @@ void emergency_remount(void)
 static inline bool get_active_super(struct super_block *sb,
 				    enum super_lock_flags_t flags)
 {
-	bool active = false;
-
-	if (!super_lock(sb, SUPER_LOCK_EXCL | flags)) {
-		active = atomic_inc_not_zero(&sb->s_active);
-		super_unlock_excl(sb);
-	}
-	return active;
+	scoped_guard(super_lock, sb, SUPER_LOCK_EXCL | flags)
+		return atomic_inc_not_zero(&sb->s_active);
+	return false;
 }
 
 static void do_thaw_all_callback(struct super_block *sb, void *unused)
@@ -1646,7 +1665,9 @@ static void fs_bdev_mark_dead(struct block_device *bdev, bool surprise)
 
 	for_each_dev_super(sb, &cursor) {
 		/* don't take the device away from under an unmount */
-		if (super_lock(sb, surprise ? 0 : SUPER_LOCK_WAIT_SHUTDOWN))
+		ACQUIRE(super_lock, lock)(sb, surprise ? 0 :
+					      SUPER_LOCK_WAIT_SHUTDOWN);
+		if (ACQUIRE_ERR(super_lock, &lock))
 			continue;
 		if (sb->s_root && (sb->s_flags & SB_ACTIVE)) {
 			if (!sb->s_op->remove_bdev ||
@@ -1659,7 +1680,6 @@ static void fs_bdev_mark_dead(struct block_device *bdev, bool surprise)
 					sb->s_op->shutdown(sb);
 			}
 		}
-		super_unlock_shared(sb);
 	}
 }
 
@@ -1671,10 +1691,10 @@ static void fs_bdev_sync(struct block_device *bdev)
 	mutex_unlock(&bdev->bd_holder_lock);
 
 	for_each_dev_super_killable(sb, &cursor) {
-		int ret;
+		ACQUIRE(super_lock, lock)(sb, SUPER_LOCK_KILLABLE |
+					      SUPER_LOCK_WAIT_SHUTDOWN);
+		int ret = ACQUIRE_ERR(super_lock, &lock);
 
-		ret = super_lock(sb, SUPER_LOCK_KILLABLE |
-				     SUPER_LOCK_WAIT_SHUTDOWN);
 		if (ret == -ENOENT)
 			continue;
 		if (ret) {
@@ -1684,7 +1704,6 @@ static void fs_bdev_sync(struct block_device *bdev)
 		}
 		if (sb->s_root && (sb->s_flags & SB_ACTIVE))
 			sync_filesystem(sb);
-		super_unlock_shared(sb);
 	}
 }
 

-- 
2.53.0

