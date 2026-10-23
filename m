Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792763852;
	b=n2s14mP8wg5d/gTc80VD9C1TjJPUAdy2pzwqEhvGLIeMcAKN+/wCdfj1ejGPWwShTIe4
	 vA90Gg2B+bEP3M5R3CFKYeWI6RyFnGOt89ILL210n81F3seBHQhOgat3c3SkfrMUdk+iC
	 g4fYwpo7q5G3Y1E9tuU1NBnCB8wqpLMJklMeWcC1nrOQO0ER3N81SXdmL5EyTecpPm7QE
	 +k0CfMJyEqaDU202rd7kcirL1mwEGZzhwf6dgWJAiuM+dsjLpqo7ueMGedk3zjge5sXZi
	 3MQ3ylKc0KxYowNBZeq3ISsHMimyQUJLLGDDkbcD6p7SJcpOE7Fodoxr7DMJyE+9E3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792763852;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UnzrsY8G/SWjwoHnSGm3SIOWLUzW8i2qmZeZsBb1utE=;
	b=z1boPcsRqKWig5+e7BZfsBr302Hf9R2Cs2YP6JFub4bcikjz2RenkFiyosJzmoBtGdWg
	 rnwYjq2A5r69TRcGFj7BIRGcT7+01TzAsqBKoXAsoLnc8uu4gRR10jPFk6n83O8cRwxD+
	 Fz8ZJliHgPJmnBbLfThjPgaC53W4OxSMT/QuqB+goFhfP58X8cdh5G7SuOQ72V61s6tjZ
	 uygEJQ5VfSABX8fJspqpSavOipZDaaDVGcZuv33CCqHTc8YGbZXaYPjyzE5GixFlAyhLl
	 QvzYFvvt8vrdkkqUNHGtZylE20K15nx8Gk2s2bjSF2xQqIS8cj3K0w4p2yGEs4BmDhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="aU/o+LQJ";
	arc=none smtp.remote-ip=209.85.221.173
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2099D606A32E
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 13:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2099D606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aU/o+LQJ
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5eaf34452a9so738352e0c.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 06:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792763851; x=1793368651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UnzrsY8G/SWjwoHnSGm3SIOWLUzW8i2qmZeZsBb1utE=;
        b=aU/o+LQJtik59Zp1xO1fBC3w0QQvJJw7j8sOXoWMy3T7Wg4GNBFcgE92bgA9TkzLgF
         tOmnlrU8fpUya2eIsYzcXXNnqCKKOJG9qrZDFDGWHTRg/a944vgqJ4UaBPiJn4qwIuh3
         681UyAM5Jj8V2lpy+Rpt5xfudXkUG0O04uMkRk7rsxE5AoQL+9VM3P8/+8NBVvD+N6d7
         CocAvSW2yeAqv2vd38ePiQN/h62r2Z0h/1DOlbRGhBrkqjoHiAjy8XPJgt5EQDKsRkyB
         xfeIj2ss+Lp3QCVhNpcandfFwB0H/yIq73O4KbYGdtbIRbwwCQ4pQC5hgW1c5J5YA4iz
         8y1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792763851; x=1793368651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UnzrsY8G/SWjwoHnSGm3SIOWLUzW8i2qmZeZsBb1utE=;
        b=J6KbWmeORBHHpZFbEXUyHwwrvmzEWEqUqLppukFxoVmLqE9VNYm/ZvlzMsvmlmmhID
         OkxmSsEm48pd7DvroLnSt00SDpsmGoWQvpWBkbc6mteVy/rZi+jbDW70692GZ4JI3fM5
         mP5B0XqOHQJ82JrDdeuQlMmPXVRh/kOb9CrHZZ+5D69Rg9XUm5I4PX9WHKX/9ST3jJHJ
         oJEr+DEL0VZiawUIwQMBmlRvyMoBGxA7FsK9QAEQU72WarsFSlVzBlnXMj4V1FRD0JEg
         WzbxXc8pHgREGHoqi9d6w6QSxjqtDRIgTcgKFL5ho1d3CvhCGsahZxiQZ0rc65PuaCHo
         l65w==
X-Gm-Message-State: AFq9FYJhzhLd4WLTu6NnO/gjTKdox80SqA8KF2ZDIxKXvR5oI6G1qpNi
	b9rdCU1Ti1J9K8tDZYFVJAmjqlKykeGVjpn9+DGpWYbYrOHTIM3H4THGPUEGAoDt
X-Gm-Gg: AYBFou33ym248k+RdJgiCDOgljXxxOge3ZXXvCTiOud8iYD2g8QI/xfh0hErxIxiY2w
	VGz8an6VlecYNzCSMus7B1GqFl9DHLuvrLDxoBx6qKySEck9CTHbiObEQHvL1Ogo72R5l1nfOT/
	u/bgJq7V3nZc9pC2yDlPMX6yByeMyjNX54gWcqxBbl/Pj+VO3+i5FQrGWRgWfbAyXCduqDFOSOx
	EPfsTR8KmEKIvPGoPL/BBVUH19MfXevGsVwLok+amu7IegouREPEBAjwNtfMysBQHNCTVLUm+2J
	KVImuQlh1gk+xbOp4wD/bx9fGBc4f9pF2HGgz4UBa4YYcnzO5q3msSRF6SMVOXk3scxsoGD0rZY
	oRf+WZrJW+xBpVYK5MZSwXuGTog2yZ9xhEYcgA/y1/2rXXRdKM999IDZa0JsyW+H4GZ9VR4zbeN
	MS3imP4DVTsrlGRzIWU48HAJ36zaKGNm5rVJ4Qegf3YAzUdEhdm/toVvEwJjszvF5WCTWiONZcU
	q7IBATZwloC0oRcCap0UgycWrfrVb7z3s0sJAFHBJc2NlbXHU8K0VQZmkTqgv23VQme0PzELdIj
	xVQ4Kkdi19SMWa+e7kE5Buc=
X-Received: by 2002:a05:6123:4009:b0:5ea:d2d7:37e4 with SMTP id 71dfb90a1353d-5eafa439734mr1174546e0c.5.1792763851035;
        Fri, 23 Oct 2026 06:57:31 -0700 (PDT)
Received: from Biostar-A520MT ([187.94.15.233])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec1feb44desm161827e0c.5.2026.10.23.06.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 06:57:30 -0700 (PDT)
From: Breno Rodrigues Alves <breno3011alves@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: Breno Rodrigues Alves <breno3011alves@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] exfat: fix bitmap lock ordering and inode cache reinitialization
Date: Fri, 23 Oct 2026 10:57:13 -0300
Message-ID: <20261023135714.49481-2-breno3011alves@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023135714.49481-1-breno3011alves@gmail.com>
References: <20261023135714.49481-1-breno3011alves@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two correctness fixes for the exFAT allocator and inode cache.

1) exfat_alloc_cluster() checks sbi->used_clusters and updates
   sbi->clu_srch_ptr before acquiring sbi->bitmap_lock.  Concurrent
   allocations can therefore observe an inconsistent bitmap state
   and double-allocate clusters.  Take the lock before the checks
   and route the early error paths through the existing 'unlock'
   label.

2) exfat_alloc_inode() relies on exfat_inode_init_once() to seed
   the cache_lru fields, but slab objects are reused without
   re-running the constructor.  A stale cache_valid_id or a
   non-empty cache_lru list can crash __exfat_cache_inval_inode()
   when an inode is recycled.  Reinitialize the fields on every
   allocation.

Tested with 5000 create/delete cycles on a loop-mounted 100M
exFAT image; fsck.exfat reports clean afterwards and dmesg
shows no exFAT-related warnings.

Fixes: 31023864e67a ("exfat: add fat entry operations")
Fixes: 719c1e182916 ("exfat: add super block operations")
Cc: stable@vger.kernel.org
Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>
---
 fs/exfat/fatent.c | 13 ++++++++-----
 fs/exfat/super.c  |  5 +++++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index a8b11e2ce43f..7dcb2819849d 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -427,19 +427,22 @@ int exfat_alloc_cluster(struct inode *inode, unsigned int num_alloc,
 	struct super_block *sb = inode->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 
+	mutex_lock(&sbi->bitmap_lock);
+
 	total_cnt = EXFAT_DATA_CLUSTER_COUNT(sbi);
 
 	if (unlikely(total_cnt < sbi->used_clusters)) {
 		exfat_fs_error_ratelimit(sb,
 			"%s: invalid used clusters(t:%u,u:%u)\n",
 			__func__, total_cnt, sbi->used_clusters);
-		return -EIO;
+		ret = -EIO;
+		goto unlock;
 	}
 
-	if (num_alloc > total_cnt - sbi->used_clusters)
-		return -ENOSPC;
-
-	mutex_lock(&sbi->bitmap_lock);
+	if (num_alloc > total_cnt - sbi->used_clusters) {
+		ret = -ENOSPC;
+		goto unlock;
+	}
 
 	hint_clu = p_chain->dir;
 	/* find new cluster */
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index a9ea36ba2693..2d142bf68b63 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -195,6 +195,11 @@ static struct inode *exfat_alloc_inode(struct super_block *sb)
 	if (!ei)
 		return NULL;
 
+	spin_lock_init(&ei->cache_lru_lock);
+	ei->nr_caches = 0;
+	ei->cache_valid_id = EXFAT_CACHE_VALID + 1;
+	INIT_LIST_HEAD(&ei->cache_lru);
+
 	return &ei->vfs_inode;
 }
 
-- 
2.56.0

