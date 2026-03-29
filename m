Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFB0386C39
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Mar 2026 17:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774804825; cv=none; b=FZk7Ll86BiFwqcVMewuz2w1cWRQ2DtHJBCQO1wx7YOHCyn1Pfa0V4TWOV7Nco3UoNPZSf91SsxnWzjgjVuQi9qoD3Jc9UPib25i1TuAnIqPFiPCuHmbTwGezLNK8DP07PR7D749HZ8Oco8zcgshOMCKfg46kM5/nuDxLtpWDyI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774804825; c=relaxed/simple;
	bh=pSGIt1gpj97rMHRo/uSF1TFQzt+/bTerdPhiTqudf/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iVIzYNWz/11fAu0RXU8MVr17Ix05bdIzm8mySQJ8t16Q9bj5o4MU9Cnf0pKvB+iutzCrm5czDh2SLBaTMvY7Q309NYnPSdm5uT5o82f2BDSPDyQNEUOMDNQ3RXUu6zmy3oJeNWeCQLINdDumfwOrNOlmnRWv9n5amlOc8xd6Ai4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tEPc1U26; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tEPc1U26"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4853e1ce427so45534455e9.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 29 Mar 2026 10:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774804822; x=1775409622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/g2CowQdixIfq8ensM5Khpl9kYXMah3qefhvCGYiZ7M=;
        b=tEPc1U26Zm3mAiPYX7qSNo05GlyVeepw1Sqg8+lR9bKGa+kfP7AQ5zYWapk+J1E3eJ
         j5RFsQ5tc0WGWIG9wB7+qN3gUccHuHkTmb9cC15EFSB5nQtS/kfEHPE8tzzPnCa6oMlK
         zZ9TAAhEnIUdCo/zNfEidVivMjB3Lt+KjYNuKaFLcCuA0teRnPWAXDOtVWybbDYX6Csb
         XdLBEo7eONpYbHxk+qIrFlRnghdPmug5s6/YMPiKuMRHMAPqf4D1CYcdXDxDOx2gwtH7
         /lPofDF81Cw9/SIfYcvunOXj8rX3izhQUDWCultOETDRafVje7x7gFTTJRXH4vlyHoIH
         HYFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774804822; x=1775409622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/g2CowQdixIfq8ensM5Khpl9kYXMah3qefhvCGYiZ7M=;
        b=H4dCcnNG+BYAwZc2mbQ4ycxpnUqYQcb88jRXOeUzqVvuNvWc2Lj2YhiOoW6TFcR33r
         lwHSGcvdEU2ddV4+kni5bVosDqJ+UwrDtLhzvWL2dqXT1DxoCSPl/qpxtId6KLxMYaLA
         vw5RgjtrVqlahuTJo4bUombFTm6k01Oixe+Ppmk2A92iLHAHojZEr9yrJ2OL2vzWt6Fp
         02iAT+CBm0AaVSwqT8FuaCm0PgYK7dh3Z3xrbXElPZHDDXF9kxGLwLlzA8W5nVVzO+74
         QzKn8tIlmjPSssL3x39UmN8032xNi0YEIo/ploAiTxLdAT4rSWrEkIUhdtDu4PRZhsj3
         w23Q==
X-Forwarded-Encrypted: i=1; AJvYcCW71tZcrt79IHeCtQPj/R570w2JbpF3UTq7epf5ntsOsq+zPINzmd1F07RxAJ5e9x+AN0y0ESh9Mob+W97V@vger.kernel.org
X-Gm-Message-State: AOJu0YxzoUfm/7Y3qkVlCJ+M4saY/+PzAXImmLWvrNtUVmKCnX+vbpuP
	nSVrHbyUqeAJULsgw/iCGShXoLQ4cJdqhBBZO3lsZlCjVOhmsqObjP4X
X-Gm-Gg: ATEYQzygXIx+FpWCupTqyOiq/FU33Xptan8IK6bJ9UwrLiuBqEYn2pbAOLdHW78snAE
	8NWQQaiHRbPZTUPSPqy3Q2Mwyqa5GuBNfaVQEq6JFBD1SgcuO4OfcLA5p52V3o2hEwuE8tqsRt9
	ubQaC7OlNcHocQ0J7QO6R28FbtDJ38FN7aRRQMidHQR6ySTVqZb04LwX8wzXT/vXD4vwzWtRn2c
	osjcaGSfKBhntc146zw4M5pKUGjYME9qI0GOfN8HD2xanr6f198sqSX827wSLFWJ2UFj1joNmHR
	ie3Ii+sIuiLwVuW2yAAy5MxUiN1uG8NB3Cg0MH4OeMSgB8hX9FF171k9edMzV6VBaN3glJDzUaF
	flvlF4EAdKKcwM8jSMcKXpoRnQJ+nQDWpotA/faTAxCKOTCv9a3pD4HqfNHLHyfWuIxtiSfyW21
	nR2R+JLqsWt5g0YfwM1U8BASeN201jWKCDnpzi5XoKe1pHpXi8+IF6S28fG6bnL+OfccqK+gPJt
	A==
X-Received: by 2002:a05:600c:5304:b0:485:f1d1:8f3d with SMTP id 5b1f17b1804b1-48727d67a43mr164826365e9.6.1774804821809;
        Sun, 29 Mar 2026 10:20:21 -0700 (PDT)
Received: from f.. (cst-prg-89-171.cust.vodafone.cz. [46.135.89.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4873cd7d039sm9776805e9.15.2026.03.29.10.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 10:20:21 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3 7/7] fs: locklessly bump refs in the inode hash when possible
Date: Sun, 29 Mar 2026 19:20:02 +0200
Message-ID: <20260329172002.3557801-8-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260329172002.3557801-1-mjguzik@gmail.com>
References: <20260329172002.3557801-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/dcache.c |  4 ++++
 fs/inode.c  | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

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
index c7585924d5c8..c6e53ec90057 100644
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
@@ -1604,6 +1623,39 @@ struct inode *igrab(struct inode *inode)
 }
 EXPORT_SYMBOL(igrab);
 
+/*
+ * Special routine for the inode hash. Don't use elsewhere.
+ *
+ * It provides lockless refcount acquire in the common case of no problematic
+ * flags being set.
+ *
+ * Any of I_NEW, I_CREATING, I_FREEING and I_WILL_FREE require dedicated treatment
+ * during lookup and bumping inodes with these is intentionally avoided. Additionally
+ * it is illegal to add refs if eiter I_FREEING or I_WILL_FREE is set in the first place.
+ *
+ * Correctness is achieved as follows:
+ * 1. both I_NEW and I_CREATING can only legally get set *before* the inode is visible
+ *    in the hash, meaning the upfront read takes care of them.
+ * 2. unsetting of I_NEW is preceded with a store fence, paired with full fence in
+ *    atomic_add_unless
+ * 3. both I_FREEING and I_WILL_FREE can only legally get set if ->i_count == 0, thus if
+ *    cmpxchg managed to replace any non-0 value, we have an invariant these flags are
+ *    not present
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
-- 
2.48.1

