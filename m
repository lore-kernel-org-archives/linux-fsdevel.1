Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB143C5525
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2026 10:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773226152; cv=none; b=dwmHuVw9fdTXWl+DkBzvEBKBAOwETNV8bjYXEddu/Kd8XwZTSYExpPhQUBdTIdPVHfEzBQIA6KigIxojB2Dmwbxxqisz8P4h0D2+4ybEbypQdobHbdGrF0UQNxtISiPP5G7IsvMRnbXmEqjHHPrMP6JjZBp+UW6NBbeWaGREXHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773226152; c=relaxed/simple;
	bh=jZdFA3yg5PbUHE1uS38WJ+U0pqEQzT8xijb+oURvXss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h+StRwtThVCEMkH9Z/okmU+ZkMIwCoVK8CoG6vxfUHpuJNsczz18AjiX9K0zoB+VCEoWseQCoN7Bnd+qkpCPdId665IX0X+bH21XizUYOKcZGoR45nNB+lc433WP1ArLCWCb3iDI4aRYq7OMe7SNALwHwJYSBuuwuS1O+rkMy/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7q1MOZ+; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7q1MOZ+"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so44570395e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2026 03:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773226149; x=1773830949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icJ5IiXPMSMLmdnRhvkeTHga2mUYWqcZGNxqizcbQDw=;
        b=Y7q1MOZ+Zb594ZNQhKBA/ZGiZpUGQXHCeoYTIEKjHaFkuGPTC20PKPwL1NVAlV35jg
         tTyxXmXiwnmf1PCYU4gaErktv0pFICi0GA+UYwetkRuYVTbq/o28BMr//7Ldlv+O8vBE
         BXkKn7ev1iSTQ9rZI9BGMny3xq8gmP3NaWnFYFtf+Ra2jML4TCpiMEqXspcoQl0EKEJS
         xKmNuizqEnSVcYihwiAWPlTeOefmbQxqSL0TdH8I47mDK+c9v4u7Memfosut/P+AIQ42
         x81OGDBgWbnqy/nUma3rVD908QT4d5Vb5ymEwcdkuL5CX3WvreUX1xYpGkJ7ZZHQ6zzP
         ciPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773226149; x=1773830949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=icJ5IiXPMSMLmdnRhvkeTHga2mUYWqcZGNxqizcbQDw=;
        b=XHU+3QdMSMFnvR0KNGquzCabrkI1hj5Uwd6p8WgJ5MwWctm0NlOH1U707j8fAJGZzq
         9LTOqqSdgSN5G2QrWeOWUb8eltOQ6IOu7qT0jHdPbwuNfXWjg1bEAgQ00RMcUT19pt7j
         Khjkb1UciDpGDWgeK/xKo8h6kBYWuPqNwBy172aMb8opb6FnRjP3bn/8vl89f94NSGDq
         NDxjoyx/D4OJjWV1Kk7N3GhYx347vQ8FUMreK6VJr0yaBG3n2aJt5bPAlfZs+KoFM3iI
         yoT1H2ASIhMZ39gNnlxgZSmfXGhc5HNpKnONbb/uSvzKFIGjk3Cj3guvXKmN1hWgA11a
         8PAA==
X-Forwarded-Encrypted: i=1; AJvYcCUQEFq4/fGUiQIz+Apjej2b1qNZwtMRIrDi9DX3TfRPMNqY+iemr4BMiTudmbU39yDHV8tV9Tbq3T4PAF4v@vger.kernel.org
X-Gm-Message-State: AOJu0YyJXBgkj5VsVN0lzF5J3Db5CFONkqpqPej1odN7aewT+WCtAUVF
	aXEp13woF7optOsHn87XoJ6P7S6HQf3/qzYeGDDYB2h1RT7LF10FW20w
X-Gm-Gg: ATEYQzy4VkX+SjeV7YRT+qhXbQ4RIZnkbmMxxtOfFRX5EsYEmhap0T6SoS0D0aRFwcP
	BpcHE52WBkS1eDYbo7TXiy5oOoyux8ih2ZVO/dYRFNvDueTSMhmhJrO5wrpfwXUTorMlaVSQvnC
	p8zSCml02M7ZiGFyedQ0ZS+0QkzheewCQxzHLzVyUYojRKmAjxnSCVt07eYmu5YSMfyhfiyiuAs
	GKDiMueH8v5Vttn0OGm0WP79yoptlQ/lNicIAU+oYClPaDSpYLnLlPj6zizZQLlez99sS1LpGYr
	11A5z9S9Fg9PVoNdkgX8GMOT3cKUcLuQMTMG38Xx3hMYJClOqBzq09QY0V1mjpwvOkdCB3qnn+Y
	9xDR0YSFvUI5Ps37MACsGTGh7J6EfqKU+Pcuvd67HqRntk3apWcabl30p4h++2sis7ISaLTjhAE
	7cWu9p/rDKM+RN3Gveq9exs24srln9wJw8FtPfQXS0sk7JF7sQlg==
X-Received: by 2002:a05:600c:a4b:b0:477:9b35:3e49 with SMTP id 5b1f17b1804b1-4854b0a71f3mr37638525e9.3.1773226148617;
        Wed, 11 Mar 2026 03:49:08 -0700 (PDT)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b0febd2sm15459265e9.32.2026.03.11.03.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:49:07 -0700 (PDT)
From: Qing Wang <wangqing7171@gmail.com>
To: syzbot+cae7809e9dc1459e4e63@syzkaller.appspotmail.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	chao@kernel.org,
	jaegeuk@kernel.org,
	jannh@google.com,
	linkinjeon@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	pfalcato@suse.de,
	sj1557.seo@samsung.com,
	syzkaller-bugs@googlegroups.com,
	vbabka@suse.cz
Subject: Re: [syzbot] [mm?] [f2fs?] [exfat?] memory leak in __kfree_rcu_sheaf
Date: Wed, 11 Mar 2026 18:48:55 +0800
Message-Id: <20260311104855.102050-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <698a26d3.050a0220.3b3015.007e.GAE@google.com>
References: <698a26d3.050a0220.3b3015.007e.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/mm/slub.c b/mm/slub.c
index 20cb4f3b636d..73b2cfd0e123 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2797,6 +2797,7 @@ static void free_empty_sheaf(struct kmem_cache *s, struct slab_sheaf *sheaf)
 	if (s->flags & SLAB_KMALLOC)
 		mark_obj_codetag_empty(sheaf);
 
+	WARN_ON(sheaf->size > 0);
 	kfree(sheaf);
 
 	stat(s, SHEAF_FREE);
@@ -2828,6 +2829,7 @@ static int refill_sheaf(struct kmem_cache *s, struct slab_sheaf *sheaf,
 	return 0;
 }
 
+static void sheaf_flush_unused(struct kmem_cache *s, struct slab_sheaf *sheaf);
 
 static struct slab_sheaf *alloc_full_sheaf(struct kmem_cache *s, gfp_t gfp)
 {
@@ -2837,6 +2839,7 @@ static struct slab_sheaf *alloc_full_sheaf(struct kmem_cache *s, gfp_t gfp)
 		return NULL;
 
 	if (refill_sheaf(s, sheaf, gfp | __GFP_NOMEMALLOC | __GFP_NOWARN)) {
+		sheaf_flush_unused(s, sheaf);
 		free_empty_sheaf(s, sheaf);
 		return NULL;
 	}
@@ -4623,6 +4626,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 			 * we must be very low on memory so don't bother
 			 * with the barn
 			 */
+			sheaf_flush_unused(s, empty);
 			free_empty_sheaf(s, empty);
 		}
 	} else {
