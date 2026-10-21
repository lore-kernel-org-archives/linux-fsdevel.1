Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792544218;
	b=rtOROBzsQ5sh6m8f+BQnEdGWYwE29eSMyDeaGlTnJPtZHorArzJt2gA7FKCZ1OnJaE9B
	 9rLdXa8LT3eNt7ofm0+uTfUxqcdIOa5b0KkaM30rYe1aZN+Bbg0wmIcLRf+TZIT41EhGD
	 QKcynpA5WKXa5PXQIcNXlgDEq3ZKJAdDSANYJaMEOi2Ac/0xLOYUQP59szXhcwXtXuXZS
	 rtRiTXTHsDbZfX4FR02lL2irUlbnQ/RQS6V1Y7b/8zg7dUEuasvCj8sXhLxAP3OmOK1HJ
	 ylp3kQ3UCDSrgCH278DCHQlRduKvCKduQOqEDjnU2ZibkCGIkcOIdKR0W4mDD1KekBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792544218;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=ZUaeSXUjB2dqBXCXVxQNt4OEJ8Egv9vojQ/GwusE1iQ=;
	b=Xz7pl0D9oQUFUCfHxjEXUZvf5kOnqhIIo+GQI0nPSrGo3+b2evl5bfR2upF3lxo05EeQ
	 BgVowMQw4q0BGVMGqX9RqA/CUS7sfXgGNAMPlDEMdnDzJRfOv8LrSpbeGfs+u9ery2soX
	 +QIdFQ3Cc97vONn20tHbwjWfNlDYrCzItp3y038kAWByNCUsBTgq81YTb9KjzrBU8M99U
	 o98SyLIhoV3fRzIJnR40ZgqJ6oQ7RJvsBtF0KEApkHNawFd0VhWBBqo9GBtqtGbdN4NJw
	 sydqIaSd1tEc7J5T3Bwp7RGNYwdU5FoF+9L3lNGjpJ6N7oJxH7VR7aXRVXHMLhOR5mQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=ZYOOwagB;
	arc=none smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F259606A32A
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 00:56:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F259606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=ZYOOwagB
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-930c0f9c1b1so19937385a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 17:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792544217; x=1793149017; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZUaeSXUjB2dqBXCXVxQNt4OEJ8Egv9vojQ/GwusE1iQ=;
        b=ZYOOwagByMH9i3fywQkpXK1FHPLR8dRRIf84xIn2mM6457d2XXT7JkPKGsRNdjUdG/
         MrI43hXq3StX/MND1woyXp3pWc0hMrrsbKnpyBzh1GhbMEjRM/4AC5PmvWrN5zOnilgN
         ZY3oQPo0ybuGnYm9x30WWaUdVIm9LH2BOJhqFOgoPf6ZAnYinlLorgOy1pABk3Vx3dCl
         hkMWqoeunsqFwIzSnnj3i36DwAau2GGjwziLxrq4v7ziWBL3P/H+cd5oIlJZeEPjUQhp
         YnvAmoBQXCvMbMetMvRD3WZrednvzgcAVXk1qoGAky+R7GyUI8+Ii+kta1/tPWsHn5OY
         +IIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792544217; x=1793149017;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZUaeSXUjB2dqBXCXVxQNt4OEJ8Egv9vojQ/GwusE1iQ=;
        b=v8bNV3Xl9O5F4G4vKmUyoVbluy1SZ3PMBbJXfln4gVRCXDcorrfc8K0qm5h574hB7v
         Rqv8T8Q9HQFtwJbLY3AkG69936GJQ9BSxoTsVvj0MwKtITa0IsS4TUdQTid/74gca1jI
         mNDlhM1NvfV64lckX+c1W8MgyQQhlZQkVmssuWBCGSM0sXLl4Vynk9OuyFEJphXFCh6m
         4IuuJAblHTOFjUm+WQjOg0z9oufyfh8gJ7xCd5dDx8WF2wKRWrfT0O1FH57fkqs+nGmr
         UxCDIOX7uwKtj/w6wU/UK9+nILCUav5JArMcMrRC56BeEZHm5VIVKDaCwk8oNWWGbqCe
         3stA==
X-Gm-Message-State: AFq9FYKsGKaElkqwJFtH7DfrXXhr5uB4/L8W7nvBANCMC34fwT8xH84Q
	cQXK7yGLsY7x5W7Ke3fR9SmaHRIg8kOW5NVqvqq6HpS6eqW/E4gwuaFvGp5muY955tg=
X-Gm-Gg: AYBFou04O92U5v5CiiNbT13U1CkxSjG4l2GMPZY7dsev05I2vmezp2OLe38yQtLFfir
	1d9MxYZUswXYfDuXFsjidxTSo/ITOdBLVgs+9v0vEUWl+HSQh/GJfZtFOyLKjOShdKDlrreWU+f
	dWNvcO1GAsLV25M2FXrnWmkZ5KNGicYBlYzZ1HCM0oZvoSv496pgAHFVSevDV4g0mg2cDYSPRgK
	7z9kU+8s3/QqCQ34TFLQzrn9Dxm6p5bZ6fPxeBaeMg0DXU8s2Xs+9BJzppOdmmxtrrHBx8a5Q/5
	6qF3L0BSSruaMXs+V3fSEBFK2DQKhw0tqGVhER8a8kGa4cKT9qTHrRNBY7F9UtqVX1LRjN4VL5t
	itUR10TPrjyneQB9ZM8aEa0nRtC1uTiIlt6jtHp5pqMmV/scd9u249/YlOy9tede4scUiUnkwKN
	Pdhubcal2azKuKRdoCKubZjucTgrHxBSxs+edRkymHBN7xhU9/48ZLjilZ/tRzm51yPjNC4OYiA
	PH9NwJsHVWwd7U=
X-Received: by 2002:a05:620a:2788:b0:93c:70da:e45e with SMTP id af79cd13be357-93f57f1d866mr152906685a.36.1792544216960;
        Tue, 20 Oct 2026 17:56:56 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.253])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56d98e5asm118308985a.7.2026.10.20.17.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 17:56:56 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 21 Oct 2026 00:56:35 +0000
Subject: [PATCH 1/5] fs: make sync(2) wait for superblocks being shut down
 explicitly
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
Message-Id: <20261021-b4-super-lock-dying-v1-1-2b35e86706ff@toxicpanda.com>
References: <20261021-b4-super-lock-dying-v1-0-2b35e86706ff@toxicpanda.com>
In-Reply-To: <20261021-b4-super-lock-dying-v1-0-2b35e86706ff@toxicpanda.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792544204; l=7060;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=Fsef/7q8+tlZpUDImxaQXUI27Mg/M9pC0vW9FedtQ6I=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QH2bdNbWlyq7us0XGwYXIkZy5PA6J71+js2sp3MyoUkHnsnr5YrdlPc63RuE/GrDo+kkWQCfJsb
 mwb0L1IVvvAg=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

sync(2) walks the superblocks with iterate_supers().  For one which is
being unmounted, super_lock() sleeps on s_umount until
generic_shutdown_super() is done with it, finds SB_DYING set and fails, so
the superblock isn't passed to the callback.

sync(2) does get something out of that sleep.  The unmount has written the
filesystem out by the time s_umount is dropped, so that filesystem is on
disk like all the others when sync(2) returns.  The same goes for the
emergency sync and the emergency remount, after which one is supposed to
be able to reset the machine.

Nothing says so in the code, and super_lock() is about to stop sleeping on
a superblock which is being shut down.  Add
super_wait_shutdown_killable(), which waits for SB_DYING, and
a flag for __iterate_supers() to call it for each superblock super_lock()
fails on.  iterate_supers_sync() passes that flag, for the two syncs, and
so does the emergency remount.

If the task is killed the walk stops and ksys_sync() returns.  There is
nobody left to make a promise to.  The emergency sync and remount and the
sync before suspend and hibernation run from a workqueue, where that can't
happen.

For now SB_DYING is always set by the time super_lock() fails, so nothing
changes yet.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/internal.h |  1 +
 fs/super.c    | 51 ++++++++++++++++++++++++++++++++++++++++++++++++---
 fs/sync.c     | 15 ++++++++-------
 3 files changed, 57 insertions(+), 10 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index e833c7e6e14f..71ab0ae11941 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -137,6 +137,7 @@ extern int reconfigure_super(struct fs_context *);
 extern bool super_trylock_shared(struct super_block *sb);
 struct super_block *user_get_super(dev_t, bool excl);
 void put_super(struct super_block *sb);
+int iterate_supers_sync(void (*f)(struct super_block *, void *), void *arg);
 void __init super_dev_init(void);
 extern bool mount_capable(struct fs_context *);
 
diff --git a/fs/super.c b/fs/super.c
index a1dc4de1b657..c33981d3f7c0 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -137,6 +137,26 @@ static __must_check bool super_lock(struct super_block *sb, bool excl)
 	return true;
 }
 
+/**
+ * super_wait_shutdown_killable - wait for a superblock being shut down
+ * @sb: superblock super_lock() failed on
+ *
+ * For those who have nothing to do on a superblock which is going away, but
+ * who promise their caller that what it had to write has been written.
+ *
+ * Only for callers which give up altogether when they are killed.  If what
+ * comes after the wait happens either way, the wait must not be cut short.
+ *
+ * The caller must have acquired a temporary reference on @sb->s_passive.
+ *
+ * Return: 0 once generic_shutdown_super() is done with @sb, -ERESTARTSYS if
+ *         the task was killed first.
+ */
+static int super_wait_shutdown_killable(struct super_block *sb)
+{
+	return wait_var_event_killable(&sb->s_flags, super_flags(sb, SB_DYING));
+}
+
 /* wait and try to acquire read-side of @sb->s_umount */
 static inline bool super_lock_shared(struct super_block *sb)
 {
@@ -938,6 +958,7 @@ enum super_iter_flags_t {
 	SUPER_ITER_EXCL		= (1U << 0),
 	SUPER_ITER_UNLOCKED	= (1U << 1),
 	SUPER_ITER_REVERSE	= (1U << 2),
+	SUPER_ITER_WAIT_SHUTDOWN = (1U << 3),
 };
 
 static inline struct super_block *first_super(enum super_iter_flags_t flags)
@@ -955,11 +976,12 @@ static inline struct super_block *next_super(struct super_block *sb,
 	return list_next_entry(sb, s_list);
 }
 
-static void __iterate_supers(void (*f)(struct super_block *, void *), void *arg,
-			     enum super_iter_flags_t flags)
+static int __iterate_supers(void (*f)(struct super_block *, void *), void *arg,
+			    enum super_iter_flags_t flags)
 {
 	struct super_block *sb, *p = NULL;
 	bool excl = flags & SUPER_ITER_EXCL;
+	int ret = 0;
 
 	spin_lock(&sb_lock);
 
@@ -979,16 +1001,21 @@ static void __iterate_supers(void (*f)(struct super_block *, void *), void *arg,
 		} else if (super_lock(sb, excl)) {
 			f(sb, arg);
 			super_unlock(sb, excl);
+		} else if (flags & SUPER_ITER_WAIT_SHUTDOWN) {
+			ret = super_wait_shutdown_killable(sb);
 		}
 
 		if (p)
 			put_super(p);
 		p = sb;
 		spin_lock(&sb_lock);
+		if (ret)
+			break;
 	}
 	spin_unlock(&sb_lock);
 	if (p)
 		put_super(p);
+	return ret;
 }
 
 void iterate_supers(void (*f)(struct super_block *, void *), void *arg)
@@ -996,6 +1023,23 @@ void iterate_supers(void (*f)(struct super_block *, void *), void *arg)
 	__iterate_supers(f, arg, 0);
 }
 
+/**
+ * iterate_supers_sync - iterate_supers() for syncing all filesystems
+ * @f: function to call
+ * @arg: argument to pass to it
+ *
+ * A superblock which is being shut down isn't passed to @f, whoever shuts it
+ * down writes it out.  Wait for that, so that it is on disk as well by the time
+ * the walk is over.
+ *
+ * Return: 0 if all the superblocks were seen, -ERESTARTSYS if the task was
+ *         killed while it waited for one.
+ */
+int iterate_supers_sync(void (*f)(struct super_block *, void *), void *arg)
+{
+	return __iterate_supers(f, arg, SUPER_ITER_WAIT_SHUTDOWN);
+}
+
 /**
  *	iterate_supers_type - call function for superblocks of given type
  *	@type: fs type
@@ -1174,7 +1218,8 @@ static void do_emergency_remount_callback(struct super_block *sb, void *unused)
 static void do_emergency_remount(struct work_struct *work)
 {
 	__iterate_supers(do_emergency_remount_callback, NULL,
-			 SUPER_ITER_EXCL | SUPER_ITER_REVERSE);
+			 SUPER_ITER_EXCL | SUPER_ITER_REVERSE |
+			 SUPER_ITER_WAIT_SHUTDOWN);
 	kfree(work);
 	printk("Emergency Remount complete\n");
 }
diff --git a/fs/sync.c b/fs/sync.c
index 4a84dd837b86..0681bfcb2da6 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -99,9 +99,10 @@ void ksys_sync(void)
 	int nowait = 0, wait = 1;
 
 	wakeup_flusher_threads(WB_REASON_SYNC);
-	iterate_supers(sync_inodes_one_sb, NULL);
-	iterate_supers(sync_fs_one_sb, &nowait);
-	iterate_supers(sync_fs_one_sb, &wait);
+	if (iterate_supers_sync(sync_inodes_one_sb, NULL) ||
+	    iterate_supers_sync(sync_fs_one_sb, &nowait) ||
+	    iterate_supers_sync(sync_fs_one_sb, &wait))
+		return;
 	sync_bdevs(false);
 	sync_bdevs(true);
 }
@@ -121,11 +122,11 @@ static void do_sync_work(struct work_struct *work)
 	 * Sync twice to reduce the possibility we skipped some inodes / pages
 	 * because they were temporarily locked
 	 */
-	iterate_supers(sync_inodes_one_sb, NULL);
-	iterate_supers(sync_fs_one_sb, &nowait);
+	iterate_supers_sync(sync_inodes_one_sb, NULL);
+	iterate_supers_sync(sync_fs_one_sb, &nowait);
 	sync_bdevs(false);
-	iterate_supers(sync_inodes_one_sb, NULL);
-	iterate_supers(sync_fs_one_sb, &wait);
+	iterate_supers_sync(sync_inodes_one_sb, NULL);
+	iterate_supers_sync(sync_fs_one_sb, &wait);
 	sync_bdevs(false);
 	printk("Emergency Sync complete\n");
 	kfree(work);

-- 
2.55.0

