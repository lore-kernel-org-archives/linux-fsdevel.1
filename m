Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B94C423A7E
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 16:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774973351; cv=none; b=iyD6BTAyxXAfeJzGL0zfdSGAtSgKfZvEBrAr7GBKG2XAvO3jGbxA35xcEiKDfKaZh56mXgwsI+v8tDePyB9aFpiKVVSnXICiKE3jRZic3nQlUFy793UExf/OHu5PNVByUgRX/sx4yqb50rX6RbaZBxEG9ONjpoUMjn5ql5gj4n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774973351; c=relaxed/simple;
	bh=xLe7Xr4y/3FYwrBKdU9rBcEBhztw5Png+eE/YUQOL1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L34nEcbqTi0CeFjiNZU5spH1XNRsxEe8IQBChZZvlOy99KjxsdUmaBetkw6IZO2UYTRxlMM2ro8KAb+mS5a8QNOjUe+Ky3xt6t+FcFvYX3ImSCtz2juatAvbmunKHPDSBlhZcckQAL9O2rhso1sjvQFdEhUqkprfe6VwyglR6cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOMpYfCE; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOMpYfCE"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43d04fc3bf2so1205401f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 09:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774973349; x=1775578149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HSqZSq7PMnW1S3SVm/ldyegcUrreaAeM2ZHCXOJzrgI=;
        b=DOMpYfCEdP5j1HAU70ogTBiVPDb/mXo4GS157dHxTg1DjrQ5pHd45zJPp29U1rUbIt
         CiJznxTqGpsuraP6zBoYhvZqZSb1eeHiKgNLYC20Q3B1UPdrw0ITsgTiGxKzYsDDx9NA
         4VbfaWDKId15DIRYRFcS+H/WcaQOvhJD1Nk7vkq/gef+23Wa2DwigK1VMlzvP5szhCAZ
         GI/QEkRYMPB8lxw+dzHZbobJ3RG66fRWRKtIA/N/FHF4gbQm/kRwvC52f8pw++yd3JOk
         S91Py92EiR22nHciMKDwzde3QKt8k+wDGPpKGurowFb/TkjIJEYGhfhJfEQsJ5UL49/H
         1HRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774973349; x=1775578149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HSqZSq7PMnW1S3SVm/ldyegcUrreaAeM2ZHCXOJzrgI=;
        b=OXqL1cUZ4QBHmGo7DNnNpJ5EKZ53PrkGP0BRuLRpR6hki2vo6OP5ww4O2wEZKbnPfR
         /w2gphuscOxtSyM6HbZrccv9zjb+F139jCo59OvoJa+DyGQHAlyvNcRiV4erkEykidiO
         MB/8JWpYVba917JTkTCOa0btvsfRmfdBhXDdYH907NRUZfsX4aG6C8ENV21v4+daWONR
         WtBhplLJSwDMW5vzXszpviRMOV8klYenxvMRTDSiPYGLekvccgDpsfMFBEvDOt71MZbf
         jobY1YVXBS++bUI06PyXEuF5s0zPxL0wCSM+P4UUGBv1DVbqVLl0LSOmKEn/+lJPubXU
         Cg0A==
X-Forwarded-Encrypted: i=1; AJvYcCWaAqoJT4MERe8gQdqj3vFcH1DnGmqO90q34Z/T2XjovPOVaWfqZuavAd4bVdoViatAHOf0LnxHMNC0F9aq@vger.kernel.org
X-Gm-Message-State: AOJu0Ywocn+cbaR4ZgFtrsGbL2eWzlHjGlnVLWI0haLDTOwMeC1kvGE9
	RjIU2/m7yMK8KIHppEqHbghsG4ALggElFaXv+62aWcEh2yq9HfkIitLs
X-Gm-Gg: ATEYQzwGv62tufjITvY9R9Uz4oc4UdTWZQsF3em7+Kt/sTm1/tAOuYhNE/UEIDBz4km
	NGrRKBw1TCmhrX/0PFdYhimCjEkaipXVFrFDws1/KFCpS2B/Ey+jVshyWqKX9ZQEQ3aHltVSVVP
	/E2t6AH+lLYWZ9kun6mWqbq74jwlpPHXT6emlPHK7xBAiH92yOA157LJ0O0OaSut0ob+32pHYhv
	gpRhmS6E7x18qIVx1t9jnYWyFEyBf0yWSpbMHShNeHAwDYO9Ikyz5c0rjPIDb+y6GwkkRaDniVf
	OJelx7pPgf/7ElSYVEEfu7pYz8EBCa/f3hXRuf4FbFOMPL52GpywLLtGbNy4Q4dYW5BZ85poacE
	PyqFqFdxYm7nRmGnGNo7doV4/BIKREKxKh60zYNUrk0DVvhCDw9dEKSOUAC4zjAoHPEtEBK28tI
	sqmKqaCnvuLtRLLu2AE9L4OzwE2btMXQsn8qVzOyceGEyC8h6YRs1ThscFu6/uu6ROKUh+lMYHt
	A==
X-Received: by 2002:a05:6000:220f:b0:43c:f8b4:e58 with SMTP id ffacd0b85a97d-43d151107bdmr389813f8f.41.1774973348468;
        Tue, 31 Mar 2026 09:09:08 -0700 (PDT)
Received: from f.. (cst-prg-89-171.cust.vodafone.cz. [46.135.89.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21e3602sm28792632f8f.4.2026.03.31.09.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 09:09:07 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v5 4/4] fs: allow lockless ->i_count bumps as long as it does not transition 0->1
Date: Tue, 31 Mar 2026 18:08:51 +0200
Message-ID: <20260331160851.3854954-5-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331160851.3854954-1-mjguzik@gmail.com>
References: <20260331160851.3854954-1-mjguzik@gmail.com>
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
index 013470e6d144..03472be4e1a9 100644
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
+ * managed to replace a non-0 value with a bigger one, we have a guarantee neither
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

