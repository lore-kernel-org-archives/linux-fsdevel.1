Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF26C44C51C
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 17:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784913280; cv=none; b=SjMaLE6l1/3gDB6eWJE9dNWhkdbAArhLOxTYeQ5ftZc9VG3vJCx5t+mDN+OB2crcyOP19PSvp3pu+3qJGmK+0wlcnIgoFllHJcl5QQ7jawF7wNC5XFnRxjuQiZr2DfRDar20bn+vZSJ5jGYYLpjUsE3MYLJaUhXFlqn+G72E7eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784913280; c=relaxed/simple;
	bh=5mx/01neYXBTDDS+aRelvHZ9v+7teX4gKivVdoDzzGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O3+sORxsl23nPVJsEyRmgzam1e5KFCqZeXymZM+bV7o6/R8LNAeC5GOKkvpZ2y0Q0/VfLyZPJQynnr2Jnxwf0YZIdSRHlVN2OcOVCven5Vrik5k1Jt/labvixVodlzzQNyKC8eX9eMsm1F1SsqZkyxy5T62Q77flXogTShqJ9mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exFNef4f; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exFNef4f"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493f75f7172so6152915e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 10:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784913274; x=1785518074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PYL/Z6JmdCpxR8zGHw2pPpkq0PjReJC2CXcOqJWl4I4=;
        b=exFNef4f+GuEAjka1t8B0gBwJR0enx4Eeyc/iF0yTZ/Sye3VJbpZFU9+/OT4upbY/C
         ysgb+172fnhgFb83ekYQFn+SXW8aWNkeM6tr6KRLbmQaW2lNa1EWaz4wJKoSajmauiL3
         +q4tyVU+ahMUpcSsBCIQV/LunzqL0rYpo6EiaslLVr+6/uvzaB/B+jnm4iX9DOGAbuRR
         yPOy8/nd9Y1FU727sUeSi1MLrITNl5C6xGc2iDGafmFcy+HkmxIsAFX8ZOI5e1IT0Fg5
         M5YNcH8y3paAbNHI8XRViasssOZdwplVIqhCTHQ+udQ0wrVQc/wDg+sro9WuR+NGLTbo
         VJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784913274; x=1785518074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PYL/Z6JmdCpxR8zGHw2pPpkq0PjReJC2CXcOqJWl4I4=;
        b=drFfBI144P6eBV9Xdh6ic5iMxVWHGL0DNGGiGp+1CAFohjH3JstSAV2q2bcQhZjRbM
         JKm4fQpSKYPpWe8h2pIk+g2+PC6JoUjA/Jp7YhpGRuLcoKXzXI6IkYXnEJxQm//ZSiu6
         3mRMSUQXUt+BaOvmglWhWcoERLo+L1TQn1zORTBqxEvKnSh/v9JwQqiyHT3oZd1rENQ7
         2FOkU4v1eMyIDsUX3dNZOYqVcCC5FPSWugDKY1d/ovR3PWup21xzA3L+X2/SxF2x7/MP
         lVl2LjELnZwuAo5llnyPJLcbkMRb2SJ1l62TeADmn/ad2VXvLgznFFwfCjWEfDpAWgMp
         AsBA==
X-Forwarded-Encrypted: i=1; AHgh+Rr1JaICfutC689YCL9kbSARQy3EF2xarXoaxehnnXQAGUe75bV/d66DtVqDF16wRLjpL3Mcgi8MQluhCC5o@vger.kernel.org
X-Gm-Message-State: AOJu0YwKRu6CN51YuzIcbnAmnSr5HU58M8mrcF3Om/2iOyiYdT+WCgH/
	0w3VUYJd/0pbT4piVnyv854+KLBya7YMXnIq1BRa1AZHc5mOm+mgMeSa
X-Gm-Gg: AR+sD13E/95dwEad+3CDwPvQnuZGBmyVzufcU8SG+skTDp7Nz2+QSiBpdIOuatcVLaN
	CFBKTY8J9mWOADys4mHNmcSF+/7bH3glYy3CeTKTQGbxCdKILQfQmsQ1FW9psv3Va+jKN+XqwOI
	Jcv95Cuy+AHn6AMDDbyBrsjvM6O2y3Xu3hszvHFX1VFe6WChaaSlJWPre1dLlkxbBtaocMLyXtY
	Zq33JNo6nWxqQ67TQKeH4toiSm3ByrE61kLLT9f8Ke5y6RSssEiE4VrxYGDAig35o219bUKYZ97
	bf/uAEGPkZkG0AlhNCk1nNv8hv8qbM+MTeaJxbzhtKzZu79YMX+sWhl89Ixo8IckUpc54f9Rd2N
	LjzZEO97dOuy2DuE/n1kO9++p52HG8MGvjLH4qs/34uf/i9NsswivO2y6GoYx/YC654wRQTsmNF
	bfxU2vXg3yWZ7958NvuK/ZPmtypCZqQBR4te9B8Z0ffdh0ZlnUPRwu
X-Received: by 2002:a7b:c40f:0:b0:495:7303:e38c with SMTP id 5b1f17b1804b1-49573cffa73mr63119865e9.28.1784913274327;
        Fri, 24 Jul 2026 10:14:34 -0700 (PDT)
Received: from f.. (cst-prg-85-255.cust.vodafone.cz. [46.135.85.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b499c473sm4175225e9.11.2026.07.24.10.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 10:14:33 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 1/2] lockref: tidy up dead count handling
Date: Fri, 24 Jul 2026 19:14:21 +0200
Message-ID: <20260724171422.429284-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724171422.429284-1-mjguzik@gmail.com>
References: <20260724171422.429284-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1. put the dead val into a macro so that it can be used in other places
2. __lockref_is_dead():
- drop the __ suffix, this is not an internal routine
- drop the spurious cast, the value is already a signed int
- use READ_ONCE to prevent any compile shenanigans
3. provide lockref_is_dead_or_zero()

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/ceph/dir.c           |  2 +-
 fs/erofs/zdata.c        |  4 ++--
 fs/gfs2/glock.c         |  6 +++---
 fs/gfs2/lock_dlm.c      |  6 +++---
 fs/gfs2/quota.c         |  4 ++--
 fs/xfs/xfs_buf.c        |  4 ++--
 fs/xfs/xfs_qm.c         |  4 ++--
 include/linux/lockref.h | 12 ++++++++++--
 lib/lockref.c           |  2 +-
 9 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index b957149abe5a..f39856ff3ea1 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1667,7 +1667,7 @@ __dentry_leases_walk(struct ceph_mds_client *mdsc,
 		if (!spin_trylock(&dentry->d_lock))
 			continue;
 
-		if (__lockref_is_dead(&dentry->d_lockref)) {
+		if (lockref_is_dead(&dentry->d_lockref)) {
 			list_del_init(&di->lease_list);
 			goto next;
 		}
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 74520e910259..d022d1dff5a1 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -725,7 +725,7 @@ static bool z_erofs_get_pcluster(struct z_erofs_pcluster *pcl)
 		return true;
 
 	spin_lock(&pcl->lockref.lock);
-	if (__lockref_is_dead(&pcl->lockref)) {
+	if (lockref_is_dead(&pcl->lockref)) {
 		spin_unlock(&pcl->lockref.lock);
 		return false;
 	}
@@ -945,7 +945,7 @@ static void z_erofs_put_pcluster(struct erofs_sb_info *sbi,
 	if (lockref_put_or_lock(&pcl->lockref))
 		return;
 
-	DBG_BUGON(__lockref_is_dead(&pcl->lockref));
+	DBG_BUGON(lockref_is_dead(&pcl->lockref));
 	if (!--pcl->lockref.count) {
 		if (try_free && xa_trylock(&sbi->managed_pslots)) {
 			free = __erofs_try_to_release_pcluster(sbi, pcl);
diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index b8a144d3a73b..eaa2980051ed 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -2080,7 +2080,7 @@ static void clear_glock(struct gfs2_glock *gl)
 	gfs2_glock_remove_from_lru(gl);
 
 	spin_lock(&gl->gl_lockref.lock);
-	if (!__lockref_is_dead(&gl->gl_lockref)) {
+	if (!lockref_is_dead(&gl->gl_lockref)) {
 		gl->gl_lockref.count++;
 		if (gl->gl_state != LM_ST_UNLOCKED)
 			request_demote(gl, LM_ST_UNLOCKED, 0, false);
@@ -2115,7 +2115,7 @@ static void dump_glock_func(struct gfs2_glock *gl)
 static void withdraw_glock(struct gfs2_glock *gl)
 {
 	spin_lock(&gl->gl_lockref.lock);
-	if (!__lockref_is_dead(&gl->gl_lockref)) {
+	if (!lockref_is_dead(&gl->gl_lockref)) {
 		/*
 		 * We don't want to write back any more dirty data.  Unlock the
 		 * remaining inode and resource group glocks; this will cause
@@ -2483,7 +2483,7 @@ static void gfs2_glock_iter_next(struct gfs2_glock_iter *gi, loff_t n)
 				continue;
 			break;
 		} else {
-			if (__lockref_is_dead(&gl->gl_lockref))
+			if (lockref_is_dead(&gl->gl_lockref))
 				continue;
 			n--;
 		}
diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
index 7828ad0b6f5a..cc901fb97da0 100644
--- a/fs/gfs2/lock_dlm.c
+++ b/fs/gfs2/lock_dlm.c
@@ -126,7 +126,7 @@ static void gdlm_ast(void *arg)
 	clear_bit(GLF_BLOCKING, &gl->gl_flags);
 
 	/* If the glock is dead, we only react to a dlm_unlock() reply. */
-	if (__lockref_is_dead(&gl->gl_lockref) &&
+	if (lockref_is_dead(&gl->gl_lockref) &&
 	    gl->gl_lksb.sb_status != -DLM_EUNLOCK)
 		return;
 
@@ -182,7 +182,7 @@ static void gdlm_bast(void *arg, int mode)
 {
 	struct gfs2_glock *gl = arg;
 
-	if (__lockref_is_dead(&gl->gl_lockref))
+	if (lockref_is_dead(&gl->gl_lockref))
 		return;
 
 	switch (mode) {
@@ -329,7 +329,7 @@ static void gdlm_put_lock(struct gfs2_glock *gl)
 	uint32_t flags = 0;
 	int error;
 
-	BUG_ON(!__lockref_is_dead(&gl->gl_lockref));
+	BUG_ON(!lockref_is_dead(&gl->gl_lockref));
 
 	if (test_bit(GLF_INITIAL, &gl->gl_flags)) {
 		gfs2_glock_free(gl);
diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 91e9975d25e8..001c8b39ca55 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -342,7 +342,7 @@ static void qd_put(struct gfs2_quota_data *qd)
 	if (lockref_put_or_lock(&qd->qd_lockref))
 		return;
 
-	BUG_ON(__lockref_is_dead(&qd->qd_lockref));
+	BUG_ON(lockref_is_dead(&qd->qd_lockref));
 	sdp = qd->qd_sbd;
 	if (unlikely(!test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags))) {
 		lockref_mark_dead(&qd->qd_lockref);
@@ -486,7 +486,7 @@ static bool qd_grab_sync(struct gfs2_sbd *sdp, struct gfs2_quota_data *qd,
 	    qd->qd_sync_gen >= sync_gen)
 		goto out;
 
-	if (__lockref_is_dead(&qd->qd_lockref))
+	if (lockref_is_dead(&qd->qd_lockref))
 		goto out;
 	qd->qd_lockref.count++;
 
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 21d67af781da..17b9d643e1a8 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -80,7 +80,7 @@ xfs_buf_stale(
 
 	spin_lock(&bp->b_lockref.lock);
 	atomic_set(&bp->b_lru_ref, 0);
-	if (!__lockref_is_dead(&bp->b_lockref))
+	if (!lockref_is_dead(&bp->b_lockref))
 		list_lru_del_obj(&bp->b_target->bt_lru, &bp->b_lru);
 	spin_unlock(&bp->b_lockref.lock);
 }
@@ -841,7 +841,7 @@ static void
 xfs_buf_destroy(
 	struct xfs_buf		*bp)
 {
-	ASSERT(__lockref_is_dead(&bp->b_lockref));
+	ASSERT(lockref_is_dead(&bp->b_lockref));
 	ASSERT(!(bp->b_flags & _XBF_DELWRI_Q));
 
 	if (bp->b_pag)
diff --git a/fs/xfs/xfs_qm.c b/fs/xfs/xfs_qm.c
index 896b24f87ac9..99a82107b8e6 100644
--- a/fs/xfs/xfs_qm.c
+++ b/fs/xfs/xfs_qm.c
@@ -128,7 +128,7 @@ xfs_qm_dqpurge(
 	struct xfs_quotainfo	*qi = dqp->q_mount->m_quotainfo;
 
 	spin_lock(&dqp->q_lockref.lock);
-	if (dqp->q_lockref.count > 0 || __lockref_is_dead(&dqp->q_lockref)) {
+	if (dqp->q_lockref.count > 0 || lockref_is_dead(&dqp->q_lockref)) {
 		spin_unlock(&dqp->q_lockref.lock);
 		return -EAGAIN;
 	}
@@ -429,7 +429,7 @@ xfs_qm_dquot_isolate(
 	 * from the LRU, leave it for the freeing task to complete the freeing
 	 * process rather than risk it being free from under us here.
 	 */
-	if (__lockref_is_dead(&dqp->q_lockref))
+	if (lockref_is_dead(&dqp->q_lockref))
 		goto out_miss_unlock;
 
 	/*
diff --git a/include/linux/lockref.h b/include/linux/lockref.h
index 6ded24cdb4a8..ddfb7d3b8cec 100644
--- a/include/linux/lockref.h
+++ b/include/linux/lockref.h
@@ -34,6 +34,8 @@ struct lockref {
 	};
 };
 
+#define __LOCKREF_DEAD_VAL	-128
+
 /**
  * lockref_init - Initialize a lockref
  * @lockref: pointer to lockref structure
@@ -55,9 +57,15 @@ void lockref_mark_dead(struct lockref *lockref);
 bool lockref_get_not_dead(struct lockref *lockref);
 
 /* Must be called under spinlock for reliable results */
-static inline bool __lockref_is_dead(const struct lockref *l)
+static inline bool lockref_is_dead(const struct lockref *l)
+{
+	return (READ_ONCE(l->count) == __LOCKREF_DEAD_VAL);
+}
+
+static inline bool lockref_is_dead_or_zero(const struct lockref *l)
 {
-	return ((int)l->count < 0);
+	int count = READ_ONCE(l->count);
+	return (count == __LOCKREF_DEAD_VAL || count == 0);
 }
 
 #endif /* __LINUX_LOCKREF_H */
diff --git a/lib/lockref.c b/lib/lockref.c
index 5d8e3ef3860e..9b3dd688d8cd 100644
--- a/lib/lockref.c
+++ b/lib/lockref.c
@@ -131,7 +131,7 @@ EXPORT_SYMBOL(lockref_put_or_lock);
 void lockref_mark_dead(struct lockref *lockref)
 {
 	assert_spin_locked(&lockref->lock);
-	lockref->count = -128;
+	lockref->count = __LOCKREF_DEAD_VAL;
 }
 EXPORT_SYMBOL(lockref_mark_dead);
 
-- 
2.48.1

