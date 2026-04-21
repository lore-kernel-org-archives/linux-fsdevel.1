Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A868B37419D
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 18:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776795971; cv=none; b=B6uf136gv9K4CWzLI2eKbB69WD6HN2URp3GxXLYTLuXN7Vhjo1RKxcDEFaTBOPmXVHbrrlDMErK2iYZZDFcL6oRXDGYP+MiEVlIclD5deZATn6Ecll4iJf34qTh7r+XjoiMFw1yk1iIwJtGnH1RSKPQ24lXtOpI4o1n4yWKZYcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776795971; c=relaxed/simple;
	bh=um8mWqo+ysNTDuv/IAnEQP3YwsMRzVln2eIJwdryl48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZhIvJ4AHfzxezY1DTFJrPjIp+O0snAFTynl6YMhS5pH9UX+MpDT21AvjK3Ja6Mxwf9nM4SNi0fdzpPw+DQkEtxzaFcac0LCS6vKPGsN4rUTAcucImeyXEb+xw+UpgtfxPDAAvby6hK5NGkpStMvd+697ar0JcjrMxSri/Rnia2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnUg66xV; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnUg66xV"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso52401705e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 11:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776795959; x=1777400759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+IKYoxJ9Wc1k2pNKDIE5E+KfU0dVLGiKfgsx7sEWKQ=;
        b=HnUg66xV4caG7iMHOpspaua4N4dM135L1sxtdyLQFQNgDNcPPcc+DLe2A9mUbXK4tj
         WKP0keuRydmDSwIjhX9ahCXjieQi0dNSjzmBa+8qVDX7iPjbM/87MWC7HxDcVMvWZesS
         L1AXksXsoQt1o17UAUDyO2rtWuRjz0J9LGggCY+sKUYOMyIt2Ri/DMuOzJVDaTfPjTuB
         84bX60uuNS+6DwPyEe2fuawYMb7yLqIcpnxW0vDgMzEEcju1HlJiQRiksE0FtjTumwae
         LaIfWScoYo/mvpJ0E65wc39hdUJ7HG21uHzq4qM5j9ZYHK4G0egfUwfCWvJPp3Q04ILq
         ne+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776795959; x=1777400759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y+IKYoxJ9Wc1k2pNKDIE5E+KfU0dVLGiKfgsx7sEWKQ=;
        b=oWa10T5zjEOyyjJkXAGaNOfsUibzPvFmLU0yU0/3DQO6A8s/w2JUP785FjaHpCWY7u
         9lJrZblv2V9ufo1YZyCm++K2X3H3+c/oNa01iNg1Nk4PDqUTb+CGnNBaDoyQyQ8HWGiC
         glekr8o+tN1/P0P7OlWBC7NCGSyojGrQIguyJ459FF22P3HXF7yqYZGYAxwwCgI4pBIL
         4Y0yv7YTijJSpB4Z6eSMyJSuSM42xi6E4uboNrywzHM+Df+mVoHfc8jADQDIkvOLhm0G
         onvVFT29Wc/LMzRaDraWTDFlcky9xic8UPbQW6mwOg1qVsktE17CnC1ASnRt51u3joY4
         0V7g==
X-Forwarded-Encrypted: i=1; AFNElJ/vFdU2ePmmJ6cvyF0lRcEyApuYo61jZwF0fyjG1xWPylYjd18avZAi8DtV8zvO7Qe7nWZF6zs/gnxVVMw/@vger.kernel.org
X-Gm-Message-State: AOJu0YygmIMP04ANz7NHwxEpISKyT32fZNX5bMWqcuvqUe5IRnSTnVdS
	+EYxKsui2u2i+r8XqbGEkuXmw40QZ5EfSUJoU+Ax0CbPQjQleG6qOaJF
X-Gm-Gg: AeBDiettXb5zDtGlN/+iITQr0+4T+oyeRYdkQVvqoxgQs8r2uTa9guY5TuakFnFCfuJ
	lhkGEE8LULnrN6x1H+lnkZnYcRc1EKpzZX52dQEvVcWs9XW4hKRCeAqHsbci0DKcnkREyepfb9i
	vgKO9Y52y4ZnmttGlECGamgAuv17yjI6UcTRZtRZs+xn71tv+kYlJnOynbRHs2turGOJOeJU9RY
	/cBakAJ//TnTpO71+ou48nqL4Bs5ydLosk1Y39fKDl+8sLfaZa1/9segPTrWjj5wrdG6xMvKoDh
	fb9+ydXQDMAQxslZyX1hr8pMeUV433wUS4eWg3GuOFE1jTjtnUl+SM7zSJ2KgfLIEhuBEt1D43S
	0qUx42cctNoct36M97pcBOYyWMBZMVIN7fdnyXkaAVFSzQGpBL5dGhoEghj6EbULKSnCcXCh9nT
	ahibg1EgzCCMwaz5ludYbrKa+hFTsTU3lMXlNPJHItQd87cCVlnT3s3dxsiESa5eC9pmuOehuG0
	Pu6ya1iDtQxkyb8bsWb
X-Received: by 2002:a05:600c:a106:b0:48a:58ae:9933 with SMTP id 5b1f17b1804b1-48a58ae9fbdmr19378515e9.18.1776795958687;
        Tue, 21 Apr 2026 11:25:58 -0700 (PDT)
Received: from f.. (cst-prg-4-152.cust.vodafone.cz. [46.135.4.152])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1405sm38694053f8f.4.2026.04.21.11.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 11:25:58 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v6 3/3] fs: allow lockless ->i_count bumps as long as it does not transition 0->1
Date: Tue, 21 Apr 2026 20:25:38 +0200
Message-ID: <20260421182538.1215894-4-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421182538.1215894-1-mjguzik@gmail.com>
References: <20260421182538.1215894-1-mjguzik@gmail.com>
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
 fs/inode.c         | 64 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |  4 +--
 3 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index df11bbba0342..13c81a6bb5e1 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2033,6 +2033,10 @@ void d_instantiate_new(struct dentry *entry, struct inode *inode)
 	__d_instantiate(entry, inode);
 	spin_unlock(&entry->d_lock);
 	WARN_ON(!(inode_state_read(inode) & I_NEW));
+	/*
+	 * Paired with igrab_from_hash()
+	 */
+	smp_wmb();
 	inode_state_clear(inode, I_NEW | I_CREATING);
 	inode_wake_up_bit(inode, __I_NEW);
 	spin_unlock(&inode->i_lock);
diff --git a/fs/inode.c b/fs/inode.c
index 17f0804b429c..39cb22e63d5b 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1023,6 +1023,7 @@ long prune_icache_sb(struct super_block *sb, struct shrink_control *sc)
 }
 
 static void __wait_on_freeing_inode(struct inode *inode, bool hash_locked, bool rcu_locked);
+static bool igrab_from_hash(struct inode *inode);
 
 /*
  * Called with the inode lock held.
@@ -1047,6 +1048,11 @@ static struct inode *find_inode(struct super_block *sb,
 			continue;
 		if (!test(inode, data))
 			continue;
+		if (igrab_from_hash(inode)) {
+			rcu_read_unlock();
+			*isnew = false;
+			return inode;
+		}
 		spin_lock(&inode->i_lock);
 		if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE)) {
 			__wait_on_freeing_inode(inode, hash_locked, true);
@@ -1089,6 +1095,11 @@ static struct inode *find_inode_fast(struct super_block *sb,
 			continue;
 		if (inode->i_sb != sb)
 			continue;
+		if (igrab_from_hash(inode)) {
+			rcu_read_unlock();
+			*isnew = false;
+			return inode;
+		}
 		spin_lock(&inode->i_lock);
 		if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE)) {
 			__wait_on_freeing_inode(inode, hash_locked, true);
@@ -1206,6 +1217,10 @@ void unlock_new_inode(struct inode *inode)
 	lockdep_annotate_inode_mutex_key(inode);
 	spin_lock(&inode->i_lock);
 	WARN_ON(!(inode_state_read(inode) & I_NEW));
+	/*
+	 * Paired with igrab_from_hash()
+	 */
+	smp_wmb();
 	inode_state_clear(inode, I_NEW | I_CREATING);
 	inode_wake_up_bit(inode, __I_NEW);
 	spin_unlock(&inode->i_lock);
@@ -1217,6 +1232,10 @@ void discard_new_inode(struct inode *inode)
 	lockdep_annotate_inode_mutex_key(inode);
 	spin_lock(&inode->i_lock);
 	WARN_ON(!(inode_state_read(inode) & I_NEW));
+	/*
+	 * Paired with igrab_from_hash()
+	 */
+	smp_wmb();
 	inode_state_clear(inode, I_NEW);
 	inode_wake_up_bit(inode, __I_NEW);
 	spin_unlock(&inode->i_lock);
@@ -1576,6 +1595,14 @@ EXPORT_SYMBOL(ihold);
 
 struct inode *igrab(struct inode *inode)
 {
+	/*
+	 * Read commentary above igrab_from_hash() for an explanation why this works.
+	 */
+	if (atomic_add_unless(&inode->i_count, 1, 0)) {
+		VFS_BUG_ON_INODE(inode_state_read_once(inode) & (I_FREEING | I_WILL_FREE), inode);
+		return inode;
+	}
+
 	spin_lock(&inode->i_lock);
 	if (!(inode_state_read(inode) & (I_FREEING | I_WILL_FREE))) {
 		__iget(inode);
@@ -1593,6 +1620,43 @@ struct inode *igrab(struct inode *inode)
 }
 EXPORT_SYMBOL(igrab);
 
+/*
+ * igrab_from_hash - special inode refcount acquire primitive for the inode hash
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
+ * managed to replace a non-0 value with a bigger one, we have a guarantee neither
+ * of these flags is set. Note this means explicitly checking of these flags below
+ * is not necessary, it is only done because it does not cost anything on top of the
+ * load which already needs to be done to handle the other flags.
+ */
+static bool igrab_from_hash(struct inode *inode)
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
index a046ae84a227..bbe179b02234 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2226,8 +2226,8 @@ static inline int icount_read_once(const struct inode *inode)
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

