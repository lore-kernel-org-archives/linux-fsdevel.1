Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121954854EE
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 09:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944494; cv=none; b=ddhjAE2dUsBiCsgN84/enhifStDRwEcsq9NfwW7UEkxV9TTLc8SEy0pAdcB+yUiIoso6sLfTKCRpXYTcIZNORtmK3oiuvaXMAOHdDEi+rum7LyGGMDDyWN/QlHelZTi4OdqeAH5n5o2YVcG8s9jjKZPOXrwWNWzTN5Ritks/nmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944494; c=relaxed/simple;
	bh=+N65DOQCnJgQqGpfVkRNDf8fPq5SSO1tZXUIQK8AhmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N4tlgk0mYdRHz6bkCGlSN3/KDWm8GFNIiP+hPOL+eaabg+B+jwmooH8dQvpXD0LacqJRXhXY4U5eM09r+eoI/4N0diwgqP+kVje1xHzrcrRD57A18E1/UGypZGdE1eCSji59QO13ceRmeuUf8JB2liuSCBaG8eHB+mOiXcLd28A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LAncElzF; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LAncElzF"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb751so777643a91.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2026 02:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788944488; x=1789549288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uD00HHK4q2p2m+RWf7dPjIKnA4HG/zGsgecKKk0GRwI=;
        b=LAncElzFkbL/948YP8dKg5Trota1ZKYEnHtZpurVn4hbxJyoXnIrxGASvzfCu9VRSr
         AJVaCjIy3HeD9HUkke+RVjqWGJK70cbJJU6nn2Ks4EP/LrWumYx9elx/dBHvGnjcqj67
         OppYi/ZUtqy6WdmPg1+2oMJQ5cKw/pyOl2Cj3fF9Tbc4QKPAwPJ6JrqpLgZTNnMg4Hay
         JJD2NAgZtciZDvBpf8pDrZqjcoco5KLPycpXNv/IATE+gKL4MkUO/kmECm6mVlAQDycw
         WgPiNE6xdIFZ0r5oCh5QuISvr20DrPw2DCVUxFQSFaULul1DuTvkAubTCvW5pdOiGy5X
         NALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788944488; x=1789549288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uD00HHK4q2p2m+RWf7dPjIKnA4HG/zGsgecKKk0GRwI=;
        b=auK6dmvGlU+2CSMlLa3SUzdIPtmjb6720HSIJb9OwL8UVws62H1ftSMaZTymSV4EN3
         E+yJwotk8ZANjZ31AAUl0kMjmZHMuw60X7qwY8EfUS1InWKzIZ9tAajNBil9h158lIaE
         7KndsfAP+qOs9PkGSyaqH8kXIpgsnbIygm8mb7qWQxO81kp83mAT2hspU3SucZndHQuc
         dzXN8+AsEgrWh5NF0Z8Lq13/5CLj0JRwTB7MZ4Gt4q00crvkjcJzdas4ErFwhBxqPwEy
         iqAWHzXZtYMnMcEi/lc70LNqdSWB4XnlxELa8P3pgQ1E6syU5ePNc8Ldr2v65Mv5RTf8
         ivbg==
X-Forwarded-Encrypted: i=1; AKwUvBye8y35MUH69UCmaBXQQVGl4o39Hrn/nEq4vGsuBc93K8EkAYad0AUS6RZqwlpfa5SDTduO1Ry3Xd8PQg5Y@vger.kernel.org
X-Gm-Message-State: AFuF++n35xr+2+jBTtJjbfIAQNdTqq51UoAdMCGE8j7syor4LA8gkfPa
	HayWWKSKA8XvtaT2HZeuNa52At9qhO2SY3xxh3DT3gcTIOcf1mj/Z9elxEPqPZdc3cQ=
X-Gm-Gg: AYBFou3vrPRqWqD02grODcgVYmUFw+fkMjyexhBTf5DmnnZjcsIHKXAdD/oB6gUvT/D
	ugKl3fTLRbDLcnWu2wuAWYYfyLHok1rhd4QMwfCezB6AmEQ4PbBwp6oRW14Da6CpWsMy294tdxP
	swaNhI2GDSOyJ8088prbTESNlZUACHwwQBIguhCnWvqR593F586o8y0ma3l1SHH3U2qLo/czSMs
	KoFEzsHuRTAtucuEPnwGpbrnMxUt6Z5V/aHh7lOzf0pAPM/8Og7rC5iZaoAbUkW2+2WrGfEeWre
	ADbG2JpJ6ARwhNzUh22CEW4+inDuLU4EDXAVKkpIpMU4a/pS7/uG8MQkZoGFeEATIBSOiL78HaL
	nLyw3BugtWyZe8lxEa8mADGjm+jXKnAS07Lvn04Xl1WZAEcdbaRjt2Dbsnanjic+zBUfoUxn2sr
	KUkaX83OGa04F96KMAUL1U+Fz5iOoNPai7IVsKqPT5blKGVVLoz1EGF61NZpbUzSPwyfu4Pue5G
	w==
X-Received: by 2002:a17:90b:4986:b0:395:4de4:92be with SMTP id 98e67ed59e1d1-39bac34a641mr7338347a91.13.1788944487761;
        Wed, 09 Sep 2026 02:01:27 -0700 (PDT)
Received: from localhost ([106.38.226.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39cd20641e2sm951155a91.3.2026.09.09.02.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 02:01:27 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-security-module@vger.kernel.org
Cc: jack@suse.cz,
	agruenba@redhat.com,
	mic@digikod.net,
	gnoack@google.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	aleksa@amutable.com,
	legion@kernel.org,
	djwong@kernel.org,
	ebiggers@kernel.org,
	sandeen@redhat.com
Subject: [PATCH 3/7] block: use sb_for_each_inodes() in sync_bdevs()
Date: Wed,  9 Sep 2026 17:01:08 +0800
Message-Id: <20260909090112.790006-4-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260909090112.790006-1-sunjunchao@bytedance.com>
References: <20260909090112.790006-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert sync_bdevs() to sb_for_each_inodes() and move device writeback
into a callback. The iterator preserves the walk position, allowing the
callback to iput() its inode before reacquiring the list lock and removing
the old_inode reference carried across iterations.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 block/bdev.c | 85 +++++++++++++++++++++++++---------------------------
 1 file changed, 41 insertions(+), 44 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index cd8323083740..ae472a062e51 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1336,56 +1336,53 @@ void bdev_mark_dead(struct block_device *bdev, bool surprise)
  */
 EXPORT_SYMBOL_GPL(bdev_mark_dead);
 
-void sync_bdevs(bool wait)
+static int sync_bdevs_inode_iter_cb(struct inode *inode, void *data)
 {
-	struct inode *inode, *old_inode = NULL;
-
-	spin_lock(&blockdev_superblock->s_inode_list_lock);
-	list_for_each_entry(inode, &blockdev_superblock->s_inodes, i_sb_list) {
-		struct address_space *mapping = inode->i_mapping;
-		struct block_device *bdev;
+	bool wait = (bool)data;
+	struct block_device *bdev;
+	struct address_space *mapping = inode->i_mapping;
 
-		spin_lock(&inode->i_lock);
-		if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE | I_NEW) ||
-		    mapping->nrpages == 0) {
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
-		__iget(inode);
+	if (mapping->nrpages == 0) {
 		spin_unlock(&inode->i_lock);
-		spin_unlock(&blockdev_superblock->s_inode_list_lock);
+		return 0;
+	}
+
+	/*
+	 * We hold a reference to 'inode' so it couldn't have been
+	 * removed from s_inodes list while we dropped the
+	 * s_inode_list_lock.
+	 */
+	__iget(inode);
+	spin_unlock(&inode->i_lock);
+	spin_unlock(&blockdev_superblock->s_inode_list_lock);
+	bdev = I_BDEV(inode);
+
+	mutex_lock(&bdev->bd_disk->open_mutex);
+	if (!atomic_read(&bdev->bd_openers)) {
+		; /* skip */
+	} else if (wait) {
 		/*
-		 * We hold a reference to 'inode' so it couldn't have been
-		 * removed from s_inodes list while we dropped the
-		 * s_inode_list_lock  We cannot iput the inode now as we can
-		 * be holding the last reference and we cannot iput it under
-		 * s_inode_list_lock. So we keep the reference and iput it
-		 * later.
+		 * We keep the error status of individual mapping so
+		 * that applications can catch the writeback error using
+		 * fsync(2). See filemap_fdatawait_keep_errors() for
+		 * details.
 		 */
-		iput(old_inode);
-		old_inode = inode;
-		bdev = I_BDEV(inode);
-
-		mutex_lock(&bdev->bd_disk->open_mutex);
-		if (!atomic_read(&bdev->bd_openers)) {
-			; /* skip */
-		} else if (wait) {
-			/*
-			 * We keep the error status of individual mapping so
-			 * that applications can catch the writeback error using
-			 * fsync(2). See filemap_fdatawait_keep_errors() for
-			 * details.
-			 */
-			filemap_fdatawait_keep_errors(inode->i_mapping);
-		} else {
-			filemap_fdatawrite(inode->i_mapping);
-		}
-		mutex_unlock(&bdev->bd_disk->open_mutex);
-
-		spin_lock(&blockdev_superblock->s_inode_list_lock);
+		filemap_fdatawait_keep_errors(inode->i_mapping);
+	} else {
+		filemap_fdatawrite(inode->i_mapping);
 	}
-	spin_unlock(&blockdev_superblock->s_inode_list_lock);
-	iput(old_inode);
+	mutex_unlock(&bdev->bd_disk->open_mutex);
+	iput(inode);
+
+	spin_lock(&blockdev_superblock->s_inode_list_lock);
+
+	return 0;
+}
+
+void sync_bdevs(bool wait)
+{
+	sb_for_each_inodes(blockdev_superblock, INODE_ITER_NORMAL,
+			   sync_bdevs_inode_iter_cb, (void *)wait);
 }
 
 /*
-- 
2.39.5

