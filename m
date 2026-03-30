Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC4B3CCFD8
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 12:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774873578; cv=none; b=DO5G55L/9HNJtHoSoWSeGsEY4Vy0ZOFuZAoWfZijn+sCl4wMtDMzBm6z0K4zqOTF6O8LkO7wmUsML5oq9wj7DyH3ZodZgycio6NanEMBVUJWIfMXjwoPK5WQKZqSpE+YqR3O5JqdZEbsWLgRzlPd5eg1Fw7r6+qI89SELOGWFSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774873578; c=relaxed/simple;
	bh=2CjUp93JkPBxpWSqmVHo2It4km/TFL7MtJebAJ8A1RQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UEinHnJJU6RTQwzzuasrNori86yg3e8js+I0yiFoE5N+pKPrIwi1SY1hCWNap6LcRxyKF+/qcj7f9B4yy9j2cunaui6TDT1YYbqj1DukQHUtvjG0eHp1ff8cH6f/gZOglpTo1H6pCkjwEcXGAWayEEt/9koPuGOFxoVCqLO0n9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oxOME1yu; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oxOME1yu"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48540d21f7dso53011475e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 05:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774873575; x=1775478375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXuXEDvrDtfw8BayhkvLcB6SfckV4kYiA2bRPrVX/L0=;
        b=oxOME1yuaZ2WdHB7/YU7Gr6HkfYWNrmPPsvnyWosU55KJmzqGUQNuVMJptzToMTzMp
         eTpK6KxR/SEQpUocntarl64cmCnW7C0NpRPuf6amr5SC7vbC2Tbp5voONjGArGKMe+TI
         SqqxWIsRhmUpfh7KSpavuARSaIx6TawRHbgvj8efgwHDH05qNboOSO+awNlgqO0FvCEk
         ee2sCdTFiB1AbeifV5L02pEqn7PNrz3jNBSVMLsSHOtheWL/y+uZyuXVAHJ1oDDbNEMX
         wy+znJek35ueQ0ecjIWezz1lxbEWs/4CGps7wXq9KV5hJqsNXwf9ehzLTvBA4RlCxnhf
         zw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774873575; x=1775478375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QXuXEDvrDtfw8BayhkvLcB6SfckV4kYiA2bRPrVX/L0=;
        b=Pp9+znk4labHjRTPWdPRyz43JZKocYayyT9AALpGaSUhKTCWfXBu/5yrjsPV83zjZ9
         6tN/wwnycl0YY37yMmTS3htQtetUxyrwPlkMvi0tLcI5JtCY9/gqqWSUgnv89AK1V0ku
         kork1C/XioOY2DrHU3q4Neuqf3DOLIhrqU2AQZd57mxpPZZrFlYPUmdAgXACVQYU+n58
         Hzs2nMg/iemBtCr+cLqVnfOKkzh4bwJiBy9jHEKDoY5sMu1I3JcUJE4PgzCn+XGkuFjn
         rvtd5CZeu+g5RGWlA4RwgrcvDmj58yzas2hgIfQkH7wxv+MDQaML2KwUEf1KkI5bcuS7
         ZVQA==
X-Forwarded-Encrypted: i=1; AJvYcCX/NdGIOPe6bNOshSQ9eHPzlXbiNCWw9+TrHaZ6b9KHI2b1VwVcf5PTDxlKwdtMq5dNN0+PNCw313n4BLn6@vger.kernel.org
X-Gm-Message-State: AOJu0YwlzqkmUlYP5+kUU1pdLqct/BOcJGo0edRzB3S1MOl0rDQV61DM
	ZvDG3f+1yzj80eWtI8XCD9KNtArdh8RdWfkCJboyH5rQrbIRCxxMeyTB
X-Gm-Gg: ATEYQzwgcQE4RezA+Ed9BhiaIEA9hOyVau2OQcS3f3l14cPCxJtDe9OrjZFU0MXg1bQ
	B5nmiJCHuA450ot+QBlzsR99EWA+OaX6DDO/9KLPgrCsFUwJceZR4jyjKkvMYn8Jwt+GgdZeqbW
	Bq/VENJAwhaTULo35WZOdCuT3axDN2QFnsDw+wSUITMWFfzndjRyJApnd7T6itiZlhmy7HVwr6w
	3PNYB3unYc0ARcndO70M1XBMSUkB9r4zULSLWCEzqVZfX+twnEj2PnLyGc6WbIc1RsErZxy4ths
	oA2x9aZZPpHCoT6/T34Hr3JlI3gQB3bIR4J//awVV4zWXqEB8u4MPFIh1It0gKcLsCp6OcOIrGQ
	UAW2bOxyuPuMA7RQEfjZ+cBe7bX5J1ECnRaN3gyor/6bXRNADokmS7TjnT+CjnMoWKpyxaEx2tw
	9U00K+GiIhrHD00Ob59zgBBqf656OVVT/RhPvbeR1dyet9SLSs047vUJD1KqP3a1EcgYj+JcDzI
	w==
X-Received: by 2002:a05:600c:1e2a:b0:485:1878:7b8c with SMTP id 5b1f17b1804b1-48727ee9f5bmr233570175e9.18.1774873575199;
        Mon, 30 Mar 2026 05:26:15 -0700 (PDT)
Received: from f.. (cst-prg-89-171.cust.vodafone.cz. [46.135.89.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48725da0333sm113541525e9.2.2026.03.30.05.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 05:26:14 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v4 4/4] fs: allow lockless ->i_count bumps as long as it does not transition 0->1
Date: Mon, 30 Mar 2026 14:26:02 +0200
Message-ID: <20260330122602.3659417-5-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330122602.3659417-1-mjguzik@gmail.com>
References: <20260330122602.3659417-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With this change only 0->1 and 1->0 transitions need the lock.

I verified all places which look at the refcount either only care about
it staying 0 (and have the lock enforce it) or don't hold the inode lock
to begin with (making the above change irrelevant to their correcness or
lack thereof).

I also confirmed nfs and btrfs like to call into these a lot and now
avoid the lock in the common case, shaving off some atomics.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/dcache.c        |  4 +++
 fs/inode.c         | 65 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |  4 +--
 3 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 9ceab142896f..b63450ebb85c 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2033,6 +2033,10 @@ void d_instantiate_new(struct dentry *entry, struct inode *inode)
 	__d_instantiate(entry, inode);
 	spin_unlock(&entry->d_lock);
 	WARN_ON(!(inode_state_read(inode) & I_NEW));
+	/*
+	 * Paired with igrab_try_lockless()
+	 */
+	smp_wmb();
 	inode_state_clear(inode, I_NEW | I_CREATING);
 	inode_wake_up_bit(inode, __I_NEW);
 	spin_unlock(&inode->i_lock);
diff --git a/fs/inode.c b/fs/inode.c
index a06edd557e84..5e5cddd76a9d 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1029,6 +1029,7 @@ long prune_icache_sb(struct super_block *sb, struct shrink_control *sc)
 }
 
 static void __wait_on_freeing_inode(struct inode *inode, bool hash_locked, bool rcu_locked);
+static bool igrab_try_lockless(struct inode *inode);
 
 /*
  * Called with the inode lock held.
@@ -1053,6 +1054,11 @@ static struct inode *find_inode(struct super_block *sb,
 			continue;
 		if (!test(inode, data))
 			continue;
+		if (igrab_try_lockless(inode)) {
+			rcu_read_unlock();
+			*isnew = false;
+			return inode;
+		}
 		spin_lock(&inode->i_lock);
 		if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE)) {
 			__wait_on_freeing_inode(inode, hash_locked, true);
@@ -1095,6 +1101,11 @@ static struct inode *find_inode_fast(struct super_block *sb,
 			continue;
 		if (inode->i_sb != sb)
 			continue;
+		if (igrab_try_lockless(inode)) {
+			rcu_read_unlock();
+			*isnew = false;
+			return inode;
+		}
 		spin_lock(&inode->i_lock);
 		if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE)) {
 			__wait_on_freeing_inode(inode, hash_locked, true);
@@ -1212,6 +1223,10 @@ void unlock_new_inode(struct inode *inode)
 	lockdep_annotate_inode_mutex_key(inode);
 	spin_lock(&inode->i_lock);
 	WARN_ON(!(inode_state_read(inode) & I_NEW));
+	/*
+	 * Paired with igrab_try_lockless()
+	 */
+	smp_wmb();
 	inode_state_clear(inode, I_NEW | I_CREATING);
 	inode_wake_up_bit(inode, __I_NEW);
 	spin_unlock(&inode->i_lock);
@@ -1223,6 +1238,10 @@ void discard_new_inode(struct inode *inode)
 	lockdep_annotate_inode_mutex_key(inode);
 	spin_lock(&inode->i_lock);
 	WARN_ON(!(inode_state_read(inode) & I_NEW));
+	/*
+	 * Paired with igrab_try_lockless()
+	 */
+	smp_wmb();
 	inode_state_clear(inode, I_NEW);
 	inode_wake_up_bit(inode, __I_NEW);
 	spin_unlock(&inode->i_lock);
@@ -1582,6 +1601,14 @@ EXPORT_SYMBOL(ihold);
 
 struct inode *igrab(struct inode *inode)
 {
+	/*
+	 * Read commentary above igrab_try_lockless() for an explanation why this works.
+	 */
+	if (atomic_add_unless(&inode->i_count, 1, 0)) {
+		VFS_BUG_ON_INODE(inode_state_read_once(inode) & (I_FREEING | I_WILL_FREE), inode);
+		return inode;
+	}
+
 	spin_lock(&inode->i_lock);
 	if (!(inode_state_read(inode) & (I_FREEING | I_WILL_FREE))) {
 		__iget(inode);
@@ -1599,6 +1626,44 @@ struct inode *igrab(struct inode *inode)
 }
 EXPORT_SYMBOL(igrab);
 
+/*
+ * igrab_try_lockless - special inode refcount acquire primitive for the inode hash
+ * (don't use elsewhere!)
+ *
+ * It provides lockless refcount acquire in the common case of no problematic
+ * flags being set and the count being > 0.
+ *
+ * There are 4 state flags to worry about and the routine makes sure to not bump the
+ * ref if any of them is present.
+ *
+ * I_NEW and I_CREATING can only legally get set *before* the inode becomes visible
+ * during lookup. Thus if the flags are not spotted, they are guaranteed to not be
+ * a factor. However, we need an acquire fence before returning the inode just
+ * in case we raced against clearing the state to make sure our consumer picks up
+ * any other changes made prior. atomic_add_unless provides a full fence, which
+ * takes care of it.
+ *
+ * I_FREEING and I_WILL_FREE can only legally get set if ->i_count == 0 and it is
+ * illegal to bump the ref if either is present. Consequently if atomic_add_unless
+ * managed to replaced a non-0 value with a bigger one, we have a guarantee neither
+ * of these flags is set. Note this means explicitly checking of these flags below
+ * is not necessary, it is only done because it does not cost anything on top of the
+ * load which already needs to be done to handle the other flags.
+ */
+static bool igrab_try_lockless(struct inode *inode)
+{
+	if (inode_state_read_once(inode) & (I_NEW | I_CREATING | I_FREEING | I_WILL_FREE))
+		return false;
+	/*
+	 * Paired with routines clearing I_NEW
+	 */
+	if (atomic_add_unless(&inode->i_count, 1, 0)) {
+		VFS_BUG_ON_INODE(inode_state_read_once(inode) & (I_FREEING | I_WILL_FREE), inode);
+		return true;
+	}
+	return false;
+}
+
 /**
  * ilookup5_nowait - search for an inode in the inode cache
  * @sb:		super block of file system to search
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 07363fce4406..119e0a3d2f42 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2234,8 +2234,8 @@ static inline int icount_read_once(const struct inode *inode)
 }
 
 /*
- * returns the refcount on the inode. The lock guarantees no new references
- * are added, but references can be dropped as long as the result is > 0.
+ * returns the refcount on the inode. The lock guarantees no 0->1 or 1->0 transitions
+ * of the count are going to take place, otherwise it changes arbitrarily.
  */
 static inline int icount_read(const struct inode *inode)
 {
-- 
2.48.1

