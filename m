Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792748551;
	b=xlZQZiVg1T61VqviCDY4SLCeqgh69+y+tlEQKOwPExpj5jLwsbLkY2OxSk2+DOFxOo9/
	 98/CYrkX9wpSRj7rmbXtpi3zXIbyIIjPw6NDXn/sp0tM5NOzaeBKBMOcV2gft2s4Hk2o4
	 o6dc/iF40M4iur6k+QPCGMNtig9Zj8nnoT6By4W+5FDtZbQ9SlxfVoYsfxRCG2LLvmAdV
	 btuoyb6z0eX12X8WCCqRfaouLcDOE5WuF4EeySbTqHDsvHwlKJ0f2kfH6RTFAfEuNJyEp
	 Jsk1c0ecFM7qX+dL6FsICdb4iksz58UxaKB83Evp0UYEBXAPy+7UdnPdhhCxnf5rUKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792748551;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=bAly4EONl+K8wONrV4FVF/MxFNRQ6940rjQwxfQwRzM=;
	b=Z3XmcRnbdKfc+5oa08sk6bh3bDzOoC0dU0dsaDeAzKJLk8tfrpb7HyqNx1urmgJktK0+
	 XeVDydjtKl8kw1h+pqI6agqZaMTM2Ly/oI7X/bWo8lX57a/Q3hrvnrIm+92wtq+kI30tS
	 2PEw4dNlbKjRc14S2mGd9JzgkWgd12HcVr7ZgZwu/jsIw0uoiX1WHLESEJnoMzqHJFSf8
	 t4gu9k3syaXAisIpFBGm2C7Q15WN5pY23dxT3HOULIu9+jcYQXvA+Bs9aWYF/JzZ69R4i
	 s68QV8Fgm2sx/LsNfgtlcPDRXA18U7/Nd1s87CSMKmTCLfv6mfLygMnkvdbwPMzax+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oAdDrUom;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B157B606A329;
	Fri, 23 Oct 2026 09:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oAdDrUom
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A18C1F01828;
	Fri, 23 Oct 2026 09:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792748550;
	bh=bAly4EONl+K8wONrV4FVF/MxFNRQ6940rjQwxfQwRzM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oAdDrUomGiuPJwjA1YaQEyZH0b9xHZldb9YRwempGQe1vO6hWIjbU5a1AHwyJnIBP
	 pqHlUCPqGE2CWR02PWJAd0tZcmMo8ueca6SojUbv9SaKDmfunrMFoWMSrbnyW8vmj8
	 GgRR1IExLAURCy68nw7BCBwwxNrJTSh0nVoG64nIPXUN6kE2nbuPi0BOhif4wrF35s
	 eR/nnEMKYFSGN5Fb5NSgy4PSlqQlkeZVQ5YmX4xDW7RytrxcVS3oE5AoWjFqJy6My0
	 j57HCMjdX74AOiKp54nENUWGwtjkIT6uoKrsMEYcMmSaLrZaI0rx4UW3k+2rf+hJI/
	 AqV25qUufMQTg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 23 Oct 2026 11:41:03 +0200
Subject: [PATCH 3/5] super: let super_lock() wait for a superblock being
 shut down
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
Message-Id: <20261023-work-super-lock_helpers-v1-3-d0fcb3f2f275@kernel.org>
References: <20261023-work-super-lock_helpers-v1-0-d0fcb3f2f275@kernel.org>
In-Reply-To: <20261023-work-super-lock_helpers-v1-0-d0fcb3f2f275@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=10151; i=brauner@kernel.org;
 h=from:subject:message-id; bh=5rDZhLkecJDgv4/8yOEq2hSSkuaxdUpamEIzEuzSbdg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTd1v6bUDKv7Oaqr/qWbsnXF3lY3ivocdpfZ31tcZzKB
 LvUOb/LO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZiycXIsPdF6YTuHvNEHrvF
 9k9aXofc//fansVcbe/MJfvdGL63v2H4X5pw6H5rWaLxldePFl7f1iZ2Z/aCqsP1EbJn9P8tOqP
 +mhcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Everyone who needs an unmount to be over before they can carry on
currently calls super_lock() and, if that fails, calls
super_wait_shutdown() or super_wait_shutdown_killable() after it. That's
six callers open-coding the same two step dance, and they have to make
sure to pick the shutdown wait that matches the lock they took.

Add SUPER_LOCK_WAIT_SHUTDOWN which makes super_lock() wait for SB_DYING
when it finds the superblock going away. It still returns -ENOENT after
the wait. It sleeps in the same state as the rest of super_lock(), so
SUPER_LOCK_KILLABLE now covers all of the waiting. get_active_super()
passes the flags through for the freezing callers. Then remove
super_wait_shutdown() and super_wait_shutdown_killable().

__iterate_supers() is the odd one out. It takes s_umount uninterruptibly
but waits for the shutdown killably. Keep it that way for now and let it
call super_wait() directly.

Note that the freezing callers used to wait for the shutdown even if
super_lock() succeeded and atomic_inc_not_zero() in get_active_super()
failed. That can't happen. The last active reference is dropped with
s_umount held and s_umount stays held until SB_DYING is set. So once
super_lock() succeeded there's always an active reference to take.

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/super.c | 118 +++++++++++++++++++++++--------------------------------------
 1 file changed, 45 insertions(+), 73 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 0185c1f16ba3..0f3308fb99aa 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -58,6 +58,7 @@ static char *sb_writers_name[SB_FREEZE_LEVELS] = {
 enum super_lock_flags_t {
 	SUPER_LOCK_EXCL		= (1U << 0),
 	SUPER_LOCK_KILLABLE	= (1U << 1),
+	SUPER_LOCK_WAIT_SHUTDOWN = (1U << 2),
 };
 
 static inline int __super_lock(struct super_block *sb,
@@ -130,13 +131,19 @@ static int super_wait(struct super_block *sb, unsigned int sb_flags,
  * creation will succeed and SB_BORN is set by vfs_get_tree() or we're
  * woken and we'll see SB_DYING.
  *
- * A superblock which is being shut down is not waited for, see
- * super_wait_shutdown() and super_wait_shutdown_killable() for that.
- *
  * With SUPER_LOCK_EXCL s_umount is taken for writing, otherwise for reading.
- * With SUPER_LOCK_KILLABLE both the wait and taking s_umount can be cut short
- * by a fatal signal.  That is only for callers which give up altogether when
- * they are killed.
+ *
+ * A superblock which is being shut down is not waited for unless
+ * SUPER_LOCK_WAIT_SHUTDOWN is passed.  That is for those who have nothing to
+ * do on a superblock which is going away, but who promise their caller that
+ * what it had to write has been written, or who must not carry on while the
+ * filesystem is still being written out.  The wait is over once
+ * generic_shutdown_super() is done with @sb, and -ENOENT is still returned.
+ *
+ * With SUPER_LOCK_KILLABLE all the waiting can be cut short by a fatal
+ * signal.  That is only for callers which give up altogether when they are
+ * killed.  If what comes after the wait happens either way, the wait must
+ * not be cut short.
  *
  * The caller must have acquired a temporary reference on @sb->s_passive.
  *
@@ -162,7 +169,7 @@ static __must_check int super_lock(struct super_block *sb,
 	 * and it can be a long one: the filesystem is written out first.
 	 */
 	if (!atomic_read(&sb->s_active))
-		return -ENOENT;
+		goto dying;
 
 	/* wait until the superblock is ready or dying */
 	ret = super_wait(sb, SB_BORN | SB_DYING, state);
@@ -171,7 +178,7 @@ static __must_check int super_lock(struct super_block *sb,
 
 	/* Don't pointlessly acquire s_umount. */
 	if (super_flags(sb, SB_DYING))
-		return -ENOENT;
+		goto dying;
 
 	ret = __super_lock(sb, flags);
 	if (ret)
@@ -184,45 +191,19 @@ static __must_check int super_lock(struct super_block *sb,
 	 */
 	if (sb->s_flags & SB_DYING) {
 		super_unlock(sb, flags);
-		return -ENOENT;
+		goto dying;
 	}
 
 	WARN_ON_ONCE(!(sb->s_flags & SB_BORN));
 	return 0;
-}
 
-/**
- * super_wait_shutdown_killable - wait for a superblock being shut down
- * @sb: superblock super_lock() failed on
- *
- * For those who have nothing to do on a superblock which is going away, but
- * who promise their caller that what it had to write has been written.
- *
- * Only for callers which give up altogether when they are killed.  If what
- * comes after the wait happens either way, the wait must not be cut short.
- *
- * The caller must have acquired a temporary reference on @sb->s_passive.
- *
- * Return: 0 once generic_shutdown_super() is done with @sb, -ERESTARTSYS if
- *         the task was killed first.
- */
-static int super_wait_shutdown_killable(struct super_block *sb)
-{
-	return super_wait(sb, SB_DYING, TASK_KILLABLE);
-}
-
-/**
- * super_wait_shutdown - wait for a superblock being shut down
- * @sb: superblock super_lock() failed on
- *
- * For callers of which the rest happens whether they are killed or not, and
- * must not happen while the filesystem is still being written out.
- *
- * The caller must have acquired a temporary reference on @sb->s_passive.
- */
-static void super_wait_shutdown(struct super_block *sb)
-{
-	super_wait(sb, SB_DYING, TASK_UNINTERRUPTIBLE);
+dying:
+	if (flags & SUPER_LOCK_WAIT_SHUTDOWN) {
+		ret = super_wait(sb, SB_DYING, state);
+		if (ret)
+			return ret;
+	}
+	return -ENOENT;
 }
 
 /* wake waiters */
@@ -1055,7 +1036,8 @@ static int __iterate_supers(void (*f)(struct super_block *, void *), void *arg,
 			f(sb, arg);
 			super_unlock_shared(sb);
 		} else if (flags & SUPER_ITER_WAIT_SHUTDOWN) {
-			ret = super_wait_shutdown_killable(sb);
+			/* whoever shuts it down writes it out, wait for that */
+			ret = super_wait(sb, SB_DYING, TASK_KILLABLE);
 		}
 
 		if (p)
@@ -1285,11 +1267,9 @@ static void do_emergency_remount_callback(struct super_block *sb, void *unused)
 {
 	struct fs_context *fc = NULL;
 
-	if (super_lock(sb, SUPER_LOCK_EXCL)) {
-		/* the unmount writes the filesystem out, wait for that */
-		super_wait_shutdown(sb);
+	/* the unmount writes the filesystem out, wait for that */
+	if (super_lock(sb, SUPER_LOCK_EXCL | SUPER_LOCK_WAIT_SHUTDOWN))
 		return;
-	}
 
 	/* Make sure no reference put under s_umount is the last one. */
 	atomic_inc(&sb->s_active);
@@ -1329,11 +1309,12 @@ void emergency_remount(void)
 	}
 }
 
-static inline bool get_active_super(struct super_block *sb)
+static inline bool get_active_super(struct super_block *sb,
+				    enum super_lock_flags_t flags)
 {
 	bool active = false;
 
-	if (!super_lock(sb, SUPER_LOCK_EXCL)) {
+	if (!super_lock(sb, SUPER_LOCK_EXCL | flags)) {
 		active = atomic_inc_not_zero(&sb->s_active);
 		super_unlock_excl(sb);
 	}
@@ -1342,7 +1323,7 @@ static inline bool get_active_super(struct super_block *sb)
 
 static void do_thaw_all_callback(struct super_block *sb, void *unused)
 {
-	if (!get_active_super(sb))
+	if (!get_active_super(sb, 0))
 		return;
 
 	/* fs_bdev_thaw() acquires s_umount so it must not be held here */
@@ -1388,11 +1369,9 @@ static void filesystems_freeze_callback(struct super_block *sb, void *freeze_all
 	if (!freeze_all_ptr && !(sb->s_type->fs_flags & FS_POWER_FREEZE))
 		return;
 
-	if (!get_active_super(sb)) {
-		/* an unmount from a workqueue isn't stopped by the freezer */
-		super_wait_shutdown(sb);
+	/* an unmount from a workqueue isn't stopped by the freezer */
+	if (!get_active_super(sb, SUPER_LOCK_WAIT_SHUTDOWN))
 		return;
-	}
 
 	if (sb->s_op->freeze_super)
 		sb->s_op->freeze_super(sb, FREEZE_EXCL | FREEZE_HOLDER_KERNEL,
@@ -1419,7 +1398,7 @@ static void filesystems_thaw_callback(struct super_block *sb, void *unused)
 	if (!sb->s_op->freeze_fs && !sb->s_op->freeze_super)
 		return;
 
-	if (!get_active_super(sb))
+	if (!get_active_super(sb, 0))
 		return;
 
 	if (sb->s_op->thaw_super)
@@ -1660,12 +1639,9 @@ static void fs_bdev_mark_dead(struct block_device *bdev, bool surprise)
 	mutex_unlock(&bdev->bd_holder_lock);
 
 	for_each_dev_super(sb, &cursor) {
-		if (super_lock(sb, 0)) {
-			/* don't take the device away from under an unmount */
-			if (!surprise)
-				super_wait_shutdown(sb);
+		/* don't take the device away from under an unmount */
+		if (super_lock(sb, surprise ? 0 : SUPER_LOCK_WAIT_SHUTDOWN))
 			continue;
-		}
 		if (sb->s_root && (sb->s_flags & SB_ACTIVE)) {
 			if (!sb->s_op->remove_bdev ||
 			    sb->s_op->remove_bdev(sb, bdev)) {
@@ -1691,20 +1667,18 @@ static void fs_bdev_sync(struct block_device *bdev)
 	for_each_dev_super_killable(sb, &cursor) {
 		int ret;
 
-		ret = super_lock(sb, SUPER_LOCK_KILLABLE);
-		if (!ret) {
-			if (sb->s_root && (sb->s_flags & SB_ACTIVE))
-				sync_filesystem(sb);
-			super_unlock_shared(sb);
-			continue;
-		}
+		ret = super_lock(sb, SUPER_LOCK_KILLABLE |
+				     SUPER_LOCK_WAIT_SHUTDOWN);
 		if (ret == -ENOENT)
-			ret = super_wait_shutdown_killable(sb);
+			continue;
 		if (ret) {
 			super_dev_walk_end(&cursor);
 			put_super(sb);
 			return;
 		}
+		if (sb->s_root && (sb->s_flags & SB_ACTIVE))
+			sync_filesystem(sb);
+		super_unlock_shared(sb);
 	}
 }
 
@@ -1733,11 +1707,9 @@ static int fs_bdev_freeze(struct block_device *bdev)
 	mutex_unlock(&bdev->bd_holder_lock);
 
 	for_each_dev_super(sb, &cursor) {
-		if (!get_active_super(sb)) {
-			/* an unmount writes to the device until it is done */
-			super_wait_shutdown(sb);
+		/* an unmount writes to the device until it is done */
+		if (!get_active_super(sb, SUPER_LOCK_WAIT_SHUTDOWN))
 			continue;
-		}
 		err = fs_super_freeze(sb);
 		if (err && !error)
 			error = err;
@@ -1791,7 +1763,7 @@ static int fs_bdev_thaw(struct block_device *bdev)
 	mutex_unlock(&bdev->bd_holder_lock);
 
 	for_each_dev_super(sb, &cursor) {
-		if (!get_active_super(sb))
+		if (!get_active_super(sb, 0))
 			continue;
 		err = fs_super_thaw(sb);
 		if (err && !error)

-- 
2.53.0

