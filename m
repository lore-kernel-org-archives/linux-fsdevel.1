Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792748549;
	b=XfaRtHmM/Rg+9myB3IgJFmucrNuxvu/aUwPSR/tzZwSougltUYYRt0nAqZ46VgOj6Yx3
	 0mwo6v2qXCKsu43lfkNf/bPAdwlWfxvm6OTpIPYHM0BDAItM0m5Wm/lzzmjJ2nToBYFQG
	 ot9wTJD3wT4VqelBLxx1+9Vmi80/NC34gQaAsKTIZMMD3pjGptdBTYiyjYN/Nio4pRYf1
	 xD17aSIYRuupAdSqDHauzJ7otLkit8aPF08ntVKmBp6CCAfGEGfciMfah/ZW3FAAPHt2U
	 /MM59XG8aFBBlndSRIr1p9wg6ZhBInlAvy7Haqckd5st+wUvqnaVXjAXtXyk8N8Te4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792748549;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=sB+IzVEWZ4g2nqsVLTSInbJCekYJdmjwhHN4vYjq2Xg=;
	b=b6aixSZgesbV5GDWSHR8WOVef51HNeDSIRvzVeJKXV7O787RiK19erFhaJKcmmIrBbki
	 fpYG4nQIl9AR2NldmafS8beVBEmxXqSGp2oQBY7WUQ1kAoZEP8NqrxW48HgK8zqgHphCp
	 GR5rYsBY+43XR3/5Ws460YzBRdLesCfFHTeVeGsyAYh9sb5scjtYBBWxgNmwRWApp3R9s
	 24Bab30BMs5gRUKq3Y/Pi3DArqUP6qiqxQEskXjht2uF1Kw9yqQc2FqhOP4eKMSd6r4sq
	 pZF2ABzUg320XeixFWYv84hxKApuPpDrqzjR3B0T5VchBFrcwxsCAcH18oxwwta89rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mBaPwwvy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37541606A31E;
	Fri, 23 Oct 2026 09:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mBaPwwvy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852401F01829;
	Fri, 23 Oct 2026 09:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792748548;
	bh=sB+IzVEWZ4g2nqsVLTSInbJCekYJdmjwhHN4vYjq2Xg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mBaPwwvynem0+mLmjlciTQ21skk9lz4lP2Hktrr8O2Z/LIXb7lZbnLpenmVO8u7bW
	 YpiOcjpEAKPMrLtetlQL/wDR8heXokG+6LIvghlpLvlZ9Rm/uxr6QM7Ik4Gm0VVQcL
	 6LAVEj6D7fsa+dwEw4ymzx5MQ/2Q329jl+aj59S564fzvVssc6w19SKGltlWnQm3/T
	 bDVBkjemJ6Nm0g2gLU+IDPoWBedNiVgF/WcO/l9kYIHiei2WcZ5ZrITkqGaIZg9UCP
	 v/llIuJR2g4WUbUhXJfCsm65GeeVNAeHeahjElxKTGTnVm1PHtXTzTkQ7VdVoFdNWg
	 BVWv2KZ/jA+4A==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 23 Oct 2026 11:41:02 +0200
Subject: [PATCH 2/5] super: let super_lock() take flags
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
Message-Id: <20261023-work-super-lock_helpers-v1-2-d0fcb3f2f275@kernel.org>
References: <20261023-work-super-lock_helpers-v1-0-d0fcb3f2f275@kernel.org>
In-Reply-To: <20261023-work-super-lock_helpers-v1-0-d0fcb3f2f275@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=12328; i=brauner@kernel.org;
 h=from:subject:message-id; bh=igg5UYchgCLhYG1GvlROM7wzFVaBvrbs3Ns9C2KvkRg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTd1v5rb3NC75Qiy02Tx+K2Nwt9EsUnv34t52dVnDzx0
 jdXicnSHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNZIs7IsOPvT+tw3qov/pp5
 6Uy1Wy8v3H/RQuxGy5w7ZVl3Tu9rZWJkOPI29fmaaz3/Dv6p068svpJktlY7VfvwnJI5yhO/31l
 0hwMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

We have super_lock() returning a bool, super_lock_killable() returning
an int and both forwarding to super_lock_common() which takes two bools.
On top of that super_lock_shared() and super_lock_excl() return true on
success while super_lock_killable() returns 0 on success. So whether
"if (super_lock*(sb))" means we got the lock depends on which one is
called. And the next patch wants super_lock() to optionally wait for a
superblock that's being shut down.

So instead of growing yet another variant, add SUPER_LOCK_EXCL and
SUPER_LOCK_KILLABLE and pass them all the way down. __super_lock() and
super_unlock() take the flags instead of a bool, which also gets rid of
__super_lock_killable(). super_lock() takes the flags and returns 0,
-ENOENT or the error from the wait. Then remove super_lock_killable(),
super_lock_common(), super_lock_shared() and super_lock_excl() and
convert everyone to super_lock().

No functional changes.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/super.c | 163 +++++++++++++++++++++++++------------------------------------
 1 file changed, 67 insertions(+), 96 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 16b9d7ac381c..0185c1f16ba3 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -55,24 +55,31 @@ static char *sb_writers_name[SB_FREEZE_LEVELS] = {
 	"sb_internal",
 };
 
-static inline void __super_lock(struct super_block *sb, bool excl)
+enum super_lock_flags_t {
+	SUPER_LOCK_EXCL		= (1U << 0),
+	SUPER_LOCK_KILLABLE	= (1U << 1),
+};
+
+static inline int __super_lock(struct super_block *sb,
+			       enum super_lock_flags_t flags)
 {
-	if (excl)
+	if (flags & SUPER_LOCK_KILLABLE) {
+		if (flags & SUPER_LOCK_EXCL)
+			return down_write_killable(&sb->s_umount);
+		return down_read_killable(&sb->s_umount);
+	}
+
+	if (flags & SUPER_LOCK_EXCL)
 		down_write(&sb->s_umount);
 	else
 		down_read(&sb->s_umount);
+	return 0;
 }
 
-static inline int __super_lock_killable(struct super_block *sb, bool excl)
-{
-	if (excl)
-		return down_write_killable(&sb->s_umount);
-	return down_read_killable(&sb->s_umount);
-}
-
-static inline void super_unlock(struct super_block *sb, bool excl)
+static inline void super_unlock(struct super_block *sb,
+				enum super_lock_flags_t flags)
 {
-	if (excl)
+	if (flags & SUPER_LOCK_EXCL)
 		up_write(&sb->s_umount);
 	else
 		up_read(&sb->s_umount);
@@ -80,17 +87,17 @@ static inline void super_unlock(struct super_block *sb, bool excl)
 
 static inline void __super_lock_excl(struct super_block *sb)
 {
-	__super_lock(sb, true);
+	__super_lock(sb, SUPER_LOCK_EXCL);
 }
 
 static inline void super_unlock_excl(struct super_block *sb)
 {
-	super_unlock(sb, true);
+	super_unlock(sb, SUPER_LOCK_EXCL);
 }
 
 static inline void super_unlock_shared(struct super_block *sb)
 {
-	super_unlock(sb, false);
+	super_unlock(sb, 0);
 }
 
 static bool super_flags(const struct super_block *sb, unsigned int flags)
@@ -113,13 +120,38 @@ static int super_wait(struct super_block *sb, unsigned int sb_flags,
 				    state);
 }
 
-/*
- * Returns 0 with s_umount held, -ENOENT if the superblock is going away, or,
- * if @killable, the error from a wait which was cut short.
+/**
+ * super_lock - wait for superblock to become ready and lock it
+ * @sb: superblock to wait for
+ * @flags: SUPER_LOCK_* flags
+ *
+ * If the superblock has neither passed through vfs_get_tree() or
+ * generic_shutdown_super() yet wait for it to happen. Either superblock
+ * creation will succeed and SB_BORN is set by vfs_get_tree() or we're
+ * woken and we'll see SB_DYING.
+ *
+ * A superblock which is being shut down is not waited for, see
+ * super_wait_shutdown() and super_wait_shutdown_killable() for that.
+ *
+ * With SUPER_LOCK_EXCL s_umount is taken for writing, otherwise for reading.
+ * With SUPER_LOCK_KILLABLE both the wait and taking s_umount can be cut short
+ * by a fatal signal.  That is only for callers which give up altogether when
+ * they are killed.
+ *
+ * The caller must have acquired a temporary reference on @sb->s_passive.
+ *
+ * Return: 0 if SB_BORN was set and with s_umount held. Without s_umount held,
+ *         -ENOENT if the superblock is being shut down or SB_DYING was set,
+ *         -EINTR or -ERESTARTSYS if the task was killed.
  */
-static int super_lock_common(struct super_block *sb, bool excl, bool killable)
+static __must_check int super_lock(struct super_block *sb,
+				   enum super_lock_flags_t flags)
 {
-	int ret = 0;
+	unsigned int state = TASK_UNINTERRUPTIBLE;
+	int ret;
+
+	if (flags & SUPER_LOCK_KILLABLE)
+		state = TASK_KILLABLE;
 
 	lockdep_assert_not_held(&sb->s_umount);
 
@@ -133,8 +165,7 @@ static int super_lock_common(struct super_block *sb, bool excl, bool killable)
 		return -ENOENT;
 
 	/* wait until the superblock is ready or dying */
-	ret = super_wait(sb, SB_BORN | SB_DYING,
-			 killable ? TASK_KILLABLE : TASK_UNINTERRUPTIBLE);
+	ret = super_wait(sb, SB_BORN | SB_DYING, state);
 	if (ret)
 		return ret;
 
@@ -142,10 +173,7 @@ static int super_lock_common(struct super_block *sb, bool excl, bool killable)
 	if (super_flags(sb, SB_DYING))
 		return -ENOENT;
 
-	if (killable)
-		ret = __super_lock_killable(sb, excl);
-	else
-		__super_lock(sb, excl);
+	ret = __super_lock(sb, flags);
 	if (ret)
 		return ret;
 
@@ -155,7 +183,7 @@ static int super_lock_common(struct super_block *sb, bool excl, bool killable)
 	 * grab a reference to this. Tell them so.
 	 */
 	if (sb->s_flags & SB_DYING) {
-		super_unlock(sb, excl);
+		super_unlock(sb, flags);
 		return -ENOENT;
 	}
 
@@ -163,49 +191,6 @@ static int super_lock_common(struct super_block *sb, bool excl, bool killable)
 	return 0;
 }
 
-/**
- * super_lock - wait for superblock to become ready and lock it
- * @sb: superblock to wait for
- * @excl: whether exclusive access is required
- *
- * If the superblock has neither passed through vfs_get_tree() or
- * generic_shutdown_super() yet wait for it to happen. Either superblock
- * creation will succeed and SB_BORN is set by vfs_get_tree() or we're
- * woken and we'll see SB_DYING.
- *
- * A superblock which is being shut down is not waited for, see
- * super_wait_shutdown() and super_wait_shutdown_killable() for that.
- *
- * The caller must have acquired a temporary reference on @sb->s_passive.
- *
- * Return: The function returns true if SB_BORN was set and with
- *         s_umount held. The function returns false if the superblock
- *         is being shut down or SB_DYING was set and without s_umount
- *         held.
- */
-static __must_check bool super_lock(struct super_block *sb, bool excl)
-{
-	return !super_lock_common(sb, excl, false);
-}
-
-/**
- * super_lock_killable - killable super_lock()
- * @sb: superblock to wait for
- * @excl: whether exclusive access is required
- *
- * Only for callers which give up altogether when they are killed.
- *
- * The caller must have acquired a temporary reference on @sb->s_passive.
- *
- * Return: 0 if SB_BORN was set and with s_umount held. Without s_umount held,
- *         -ENOENT if the superblock is being shut down or SB_DYING was set,
- *         -EINTR or -ERESTARTSYS if the task was killed.
- */
-static __must_check int super_lock_killable(struct super_block *sb, bool excl)
-{
-	return super_lock_common(sb, excl, true);
-}
-
 /**
  * super_wait_shutdown_killable - wait for a superblock being shut down
  * @sb: superblock super_lock() failed on
@@ -240,18 +225,6 @@ static void super_wait_shutdown(struct super_block *sb)
 	super_wait(sb, SB_DYING, TASK_UNINTERRUPTIBLE);
 }
 
-/* wait and try to acquire read-side of @sb->s_umount */
-static inline bool super_lock_shared(struct super_block *sb)
-{
-	return super_lock(sb, false);
-}
-
-/* wait and try to acquire write-side of @sb->s_umount */
-static inline bool super_lock_excl(struct super_block *sb)
-{
-	return super_lock(sb, true);
-}
-
 /* wake waiters */
 #define SUPER_WAKE_FLAGS (SB_BORN | SB_DYING | SB_DEAD)
 static void super_wake(struct super_block *sb, unsigned int flag)
@@ -726,7 +699,7 @@ static int grab_super(struct super_block *sb)
 
 	refcount_inc(&sb->s_passive);
 	spin_unlock(&sb_lock);
-	ret = super_lock_killable(sb, true);
+	ret = super_lock(sb, SUPER_LOCK_EXCL | SUPER_LOCK_KILLABLE);
 	if (!ret) {
 		if (atomic_inc_not_zero(&sb->s_active)) {
 			put_super(sb);
@@ -1078,7 +1051,7 @@ static int __iterate_supers(void (*f)(struct super_block *, void *), void *arg,
 
 		if (flags & SUPER_ITER_UNLOCKED) {
 			f(sb, arg);
-		} else if (super_lock_shared(sb)) {
+		} else if (!super_lock(sb, 0)) {
 			f(sb, arg);
 			super_unlock_shared(sb);
 		} else if (flags & SUPER_ITER_WAIT_SHUTDOWN) {
@@ -1155,8 +1128,6 @@ void iterate_supers_type(struct file_system_type *type,
 
 	spin_lock(&sb_lock);
 	hlist_for_each_entry(sb, &type->fs_supers, s_instances) {
-		bool locked;
-
 		if (super_flags(sb, SB_DYING))
 			continue;
 
@@ -1165,8 +1136,7 @@ void iterate_supers_type(struct file_system_type *type,
 
 		spin_unlock(&sb_lock);
 
-		locked = super_lock_shared(sb);
-		if (locked) {
+		if (!super_lock(sb, 0)) {
 			f(sb, arg);
 			super_unlock_shared(sb);
 		}
@@ -1191,7 +1161,8 @@ struct super_block *user_get_super(dev_t dev, bool excl)
 	for_each_dev_super_killable(sb, &cursor) {
 		int ret;
 
-		ret = super_lock_killable(sb, excl);
+		ret = super_lock(sb, (excl ? SUPER_LOCK_EXCL : 0) |
+				     SUPER_LOCK_KILLABLE);
 		if (ret == -ENOENT)
 			continue;
 		super_dev_walk_end(&cursor);
@@ -1314,7 +1285,7 @@ static void do_emergency_remount_callback(struct super_block *sb, void *unused)
 {
 	struct fs_context *fc = NULL;
 
-	if (!super_lock_excl(sb)) {
+	if (super_lock(sb, SUPER_LOCK_EXCL)) {
 		/* the unmount writes the filesystem out, wait for that */
 		super_wait_shutdown(sb);
 		return;
@@ -1362,7 +1333,7 @@ static inline bool get_active_super(struct super_block *sb)
 {
 	bool active = false;
 
-	if (super_lock_excl(sb)) {
+	if (!super_lock(sb, SUPER_LOCK_EXCL)) {
 		active = atomic_inc_not_zero(&sb->s_active);
 		super_unlock_excl(sb);
 	}
@@ -1379,7 +1350,7 @@ static void do_thaw_all_callback(struct super_block *sb, void *unused)
 		while (sb->s_bdev && !bdev_thaw(sb->s_bdev))
 			pr_warn("Emergency Thaw on %pg\n", sb->s_bdev);
 
-	if (super_lock_excl(sb))
+	if (!super_lock(sb, SUPER_LOCK_EXCL))
 		thaw_super_locked(sb, FREEZE_HOLDER_USERSPACE, NULL);
 	deactivate_super(sb);
 }
@@ -1668,7 +1639,7 @@ static int fs_super_thaw(struct super_block *sb)
 	}
 
 	/* The caller holds an active reference. */
-	if (WARN_ON_ONCE(!super_lock_excl(sb)))
+	if (WARN_ON_ONCE(super_lock(sb, SUPER_LOCK_EXCL)))
 		return 0;
 
 	/* FITHAW or an emergency thaw may have dropped the freeze already. */
@@ -1689,7 +1660,7 @@ static void fs_bdev_mark_dead(struct block_device *bdev, bool surprise)
 	mutex_unlock(&bdev->bd_holder_lock);
 
 	for_each_dev_super(sb, &cursor) {
-		if (!super_lock_shared(sb)) {
+		if (super_lock(sb, 0)) {
 			/* don't take the device away from under an unmount */
 			if (!surprise)
 				super_wait_shutdown(sb);
@@ -1720,7 +1691,7 @@ static void fs_bdev_sync(struct block_device *bdev)
 	for_each_dev_super_killable(sb, &cursor) {
 		int ret;
 
-		ret = super_lock_killable(sb, false);
+		ret = super_lock(sb, SUPER_LOCK_KILLABLE);
 		if (!ret) {
 			if (sb->s_root && (sb->s_flags & SB_ACTIVE))
 				sync_filesystem(sb);
@@ -2517,7 +2488,7 @@ int freeze_super(struct super_block *sb, enum freeze_holder who, const void *fre
 {
 	int ret;
 
-	if (!super_lock_excl(sb)) {
+	if (super_lock(sb, SUPER_LOCK_EXCL)) {
 		WARN_ONCE(1, "Dying superblock while freezing!");
 		return -EINVAL;
 	}
@@ -2684,7 +2655,7 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who,
 int thaw_super(struct super_block *sb, enum freeze_holder who,
 	       const void *freeze_owner)
 {
-	if (!super_lock_excl(sb)) {
+	if (super_lock(sb, SUPER_LOCK_EXCL)) {
 		WARN_ONCE(1, "Dying superblock while thawing!");
 		return -EINVAL;
 	}

-- 
2.53.0

