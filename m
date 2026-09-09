Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA1935FF6C
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 19:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788982249; cv=none; b=QlP+jggspBYBzzxEnb+94P+57dAllbMyBoBOoDnNw4F5vud2S17NYMjrEVyOnrEIYlmZDITNI17KDd1aE1W/JVUld15/3D7eI30TRyQNUMzhLMTzxVHcrviWvnRKBzO9e2hSQSF2/uQc2fZ0qVt/qY3oIhCCvXf3jYclEZbVLG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788982249; c=relaxed/simple;
	bh=OjwTS77Of0cEI60dHR7L7jYTCrdKX4ImjgWXDc6oBCA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aiZ2T+YcNMH2F0XEpRPY16Akr2K1bl12R1KNQdAZK2FghgtWOULoVSmHhq4UtO8lCJ+t7R1Xw+s5Zd9mN8juuSOfVn4Vdkgeub+XOMK7W/0I8YqmktzZZjDnOyX+gtS9GGKSzImGmObf7AgsRA44mI8+W65spcUl5G1UHIbLvUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjQVMRUI; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjQVMRUI"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49cca4ffdcfso51396085e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2026 12:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788982244; x=1789587044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LWEuh4czJmGzJknfeo9JvN82m4WXeS0H/uuWqVtl4ks=;
        b=PjQVMRUIXeePD7wCZdk0hktW3427lXGGE1twL6OQiKs4P0lcVEt5rHhrYaQU00zTLT
         S9Nuqmgk+hXNU8IfYHKYdE6Mf9w6YE9HEVmK9A2E0wQ0GOaMyaXGU0HreEJ5gMayE0CG
         S0mHPDms1q+H+tiOX2ocgC0O5OoIbHG/cQnRgLeHP0dfDVHCxf40kaijhrGxtYBcAfxB
         07AvdkttK7iYhv/paPG6kXVi+WZ8lrFxZ9A5dGlxnDlPP0t1qrsDNHGd+SB6XRycfdeF
         8Do2HZjbNiluiuQOT6dKQdX98yQ4EEPw80xUKg1dmgWFa5za0zvOc9JR28n+tAyrv04D
         ircA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788982244; x=1789587044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LWEuh4czJmGzJknfeo9JvN82m4WXeS0H/uuWqVtl4ks=;
        b=eSBAC/DXI4ZEdUcigDgK4qWEusEOwIbzVir2oSQ+68uNcMxCuguGSpLVQbju2l2GMt
         olnimEWO7MTPeyYms/9MKy/5MtnLuoiCHKUlxe4Pha/1UNmw4TTvvNf17r1Yox0u1lp2
         xfXf64xOFV90Pcv51zhQderpf+uIolD7bCWIT2/hJrEDPZa3sf21wD9Xh97b9Gdf1PtG
         sy1Q8W2LM4UdLZ1nFtj5ysE2k+PjWDKq2cJN25I1aUW2nb15UUKxfNHA/IlSrqcfSehQ
         nK8hIcYWRoxe9CjX+1V3ZSQtF9hR+LV0+TpjxoWysVNXAUFtPUPasl7TijuzFb3XbNxJ
         O2Bw==
X-Forwarded-Encrypted: i=1; AKwUvBzZlHoyX7VqGZ6os8epDbjG0XBXGs9I4ErkLcPcEHJNWOlveQrPXoGcaNWQoaR0eJS1OHPmQ5FzLnhxZgJV@vger.kernel.org
X-Gm-Message-State: AFuF++kNBtQocvX5DJCp17RNAEAmuS0aC9EPn4Z8PFkaLq7rheLt+HOP
	MXv+Z1d2pYUZdieK4jviGIIM1IQOtoYJmpzljKNmBNG7VfhEVsCBI3NJ
X-Gm-Gg: AYBFou2JebL83v+qJvEzGwDq48J+w/9E3bk0M08ooD4to3ThthZRNwokNnEYO1dsjpO
	Ro7v/GfKV+ebs79vTs3+YzhIVn+A9zL1n3TCCUrBB7Pyljr/H89tE3Y9ocmEUlRccjQvZti5V8U
	+AIDzFLQm0VZsbbwWqSp7xXrcn/iv0oSaiYIweGE3h5Kb9vz6TR6BL4T9Fq+FE66PSzGYTVtBUp
	5VwGfMc0Xh9N9Jcu5FssM59TMyK5f4+knXBrw2cHQRRZxZ6tf9WogEdl41JYUZuaXmQ1ERrbtla
	XCqwkNotw+ie9p1PyxvL+nNwKGbDKc38X55Mn7OMFZuH48Pcima6lkRzGjIg8u9Dam4+s/Eg33I
	ThUlC//ubT5nfsj3nj7EieZCkRXBc1GDiBtaTz0LK+JIXORd2VUzK/QNjnD7d9ffQ2E0J1pHQE6
	k2MMjJZ1oSFWrXZ6epdrhalpRpbjriiK8yk+UNhzjYNQZPlGBJGIQNKgS6PGCPi+QopPDT1oF3m
	sJxZy0xp0kMwORX0ZTnb8l0LHv8JlSsWYoOhZvfOLV8ttsxv7oyMVeuY8cTAXN/2O/HEtO5NMqf
	ZZg7ecbnvXsBfx85h+SI/yTQ5YIiOZEnvalFkSBJqTE0kNp4Xt/+121pUoRUOr9oK4QiBpUG4Zl
	bGIo6uDs=
X-Received: by 2002:a05:600c:3588:b0:49c:fc6e:a3d7 with SMTP id 5b1f17b1804b1-49cfc6ea7d5mr355877335e9.22.1788982243784;
        Wed, 09 Sep 2026 12:30:43 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b090-6201-5565-e933-e630-1831.310.pool.telefonica.de. [2a02:3100:b090:6201:5565:e933:e630:1831])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26b7332asm13318195e9.0.2026.09.09.12.30.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Sep 2026 12:30:43 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Paulo Alcantara <pc@manguebit.org>,
	linux-fsdevel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] super: make iterate_supers_type() deletion-safe
Date: Wed,  9 Sep 2026 21:30:34 +0200
Message-Id: <20260909193034.7467-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

iterate_supers_type() drops sb_lock while invoking the callback and keeps
only a passive reference to the current superblock. That reference keeps
the object allocated, but does not keep its s_instances node linked.

After the iterator releases s_umount, final teardown can unlink the current
s_instances node. The iterator then advances through a reinitialized node.
With the current hlist it stops without visiting the remaining superblocks.
The unlink moved from generic_shutdown_super() to kill_super_notify(), but
the cursor lifetime has been unsafe since the helper was introduced.

The CIFS DFS lookup can consequently miss a matching superblock and return
-EINVAL.

Move removal from fs_supers to put_super(), alongside removal from
super_blocks, so a passive reference keeps both list nodes linked. Keep
the filesystem module reference until then, since unlinking s_instances
may touch type->fs_supers.

Make sget_fc() skip SB_DEAD superblocks before invoking test(), and set
SB_DEAD under sb_lock to serialize with those callbacks. This allows
kernfs to free its private information after kill_anon_super() returns.
Keep matching SB_DYING superblocks until SB_DEAD is set so concurrent
mounts still wait for teardown before retrying.

Fixes: 43e15cdbefea ("new helper: iterate_supers_type()")
Reported-by: Karl Mehltretter <kmehltretter@gmail.com>
Closes: https://lore.kernel.org/r/20260903013336.92081-1-kmehltretter@gmail.com
Suggested-by: Jan Kara <jack@suse.cz>
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Tested-by: Karl Mehltretter <kmehltretter@gmail.com>
Assisted-by: LLM
[kmehltretter: supplied the commit message]
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Changes in v2:
- Use Christian's implementation of Jan's suggestion: keep s_instances
  linked until the last passive reference is dropped and make sget_fc()
  skip SB_DEAD superblocks under sb_lock.
- Retain the filesystem module reference until put_super().
- Attribute authorship to Christian; retain my commit message.

Testing: All tests run on v1 also passed with Christian's draft. These
included an x86_64 QEMU deterministic KUnit test using the actual CIFS
lookup callback and a Samba DFS reconnect test with concurrent CIFS
mounts and unmounts in the same guest. The deterministic test exercised
the missed-match case; the network stress did not reproduce the narrow
race on baseline.

Link to v1: https://lore.kernel.org/r/20260903013336.92081-1-kmehltretter@gmail.com

Christian's draft:
https://lore.kernel.org/r/20260904-rockkonzert-bergtour-dahin-23c9c5c87d0f@brauner

 fs/kernfs/mount.c |  4 ++--
 fs/super.c        | 39 +++++++++++++++++++--------------------
 2 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index f183a96778b9..a57399021c8b 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -434,8 +434,8 @@ void kernfs_kill_sb(struct super_block *sb)
 	up_write(&root->kernfs_supers_rwsem);
 
 	/*
-	 * Remove the superblock from fs_supers/s_instances
-	 * so we can't find it, before freeing kernfs_super_info.
+	 * Mark the superblock dead so sget_fc() can't find it,
+	 * before freeing kernfs_super_info.
 	 */
 	kill_anon_super(sb);
 	kfree(info);
diff --git a/fs/super.c b/fs/super.c
index 05e443173038..0f9e13eedb4f 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -433,15 +433,19 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 void put_super(struct super_block *s)
 {
 	if (refcount_dec_and_test(&s->s_passive)) {
+		struct file_system_type *type = s->s_type;
 
 		spin_lock(&sb_lock);
 		list_del_init(&s->s_list);
+		hlist_del_init(&s->s_instances);
 		spin_unlock(&sb_lock);
 
 		WARN_ON(s->s_dentry_lru.node);
 		WARN_ON(s->s_inode_lru.node);
 		WARN_ON(s->s_mounts);
 		call_rcu(&s->rcu, destroy_super_rcu);
+		/* The unlink above may touch type->fs_supers, so drop it last. */
+		put_filesystem(type);
 	}
 }
 
@@ -558,17 +562,6 @@ static void kill_super_notify(struct super_block *sb)
 	if (sb->s_flags & SB_DEAD)
 		return;
 
-	/*
-	 * Remove it from @fs_supers so it isn't found by new
-	 * sget_fc() walkers anymore. Any concurrent mounter still
-	 * managing to grab a temporary reference is guaranteed to
-	 * already see SB_DYING and will wait until we notify them about
-	 * SB_DEAD.
-	 */
-	spin_lock(&sb_lock);
-	hlist_del_init(&sb->s_instances);
-	spin_unlock(&sb_lock);
-
 	/* Drop sget_fc()'s claim; a never-registered entry stays with the sb. */
 	if (sb->s_super_dev->sd_dev) {
 		super_dev_put(sb->s_super_dev);
@@ -577,11 +570,15 @@ static void kill_super_notify(struct super_block *sb)
 
 	/*
 	 * Let concurrent mounts know that this thing is really dead.
-	 * We don't need @sb->s_umount here as every concurrent caller
-	 * will see SB_DYING and either discard the superblock or wait
-	 * for SB_DEAD.
+	 * sget_fc() skips SB_DEAD superblocks and calls test() under
+	 * sb_lock, so set it under sb_lock: once we return no test()
+	 * runs on this superblock anymore and none will start. Everyone
+	 * else already saw SB_DYING and either discarded the superblock
+	 * or waits for SB_DEAD.
 	 */
+	spin_lock(&sb_lock);
 	super_wake(sb, SB_DEAD);
+	spin_unlock(&sb_lock);
 }
 
 /**
@@ -608,7 +605,6 @@ void deactivate_locked_super(struct super_block *s)
 		list_lru_destroy(&s->s_dentry_lru);
 		list_lru_destroy(&s->s_inode_lru);
 
-		put_filesystem(fs);
 		put_super(s);
 	} else {
 		super_unlock_excl(s);
@@ -795,12 +791,12 @@ void generic_shutdown_super(struct super_block *sb)
 	}
 	/*
 	 * Broadcast to everyone that grabbed a temporary reference to this
-	 * superblock before we removed it from @fs_supers that the superblock
-	 * is dying. Every walker of @fs_supers outside of sget_fc() will now
-	 * discard this superblock and treat it as dead.
+	 * superblock that it is dying. Every walker of @fs_supers outside
+	 * of sget_fc() will now discard this superblock and treat it as
+	 * dead.
 	 *
-	 * We leave the superblock on @fs_supers so it can be found by
-	 * sget_fc() until we passed sb->kill_sb().
+	 * sget_fc() keeps finding the superblock until SB_DEAD is set, so
+	 * a concurrent mounter waits until we passed sb->kill_sb().
 	 */
 	super_wake(sb, SB_DYING);
 	super_unlock_excl(sb);
@@ -879,6 +875,9 @@ struct super_block *sget_fc(struct fs_context *fc,
 	spin_lock(&sb_lock);
 	if (test) {
 		hlist_for_each_entry(old, &fc->fs_type->fs_supers, s_instances) {
+			/* Only unlinked at the last passive reference. */
+			if (super_flags(old, SB_DEAD))
+				continue;
 			if (test(old, fc))
 				goto share_extant_sb;
 		}
-- 
2.53.0
