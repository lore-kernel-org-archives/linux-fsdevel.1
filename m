Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C7647A0D4
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 19:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576112; cv=none; b=ENkOnV6Kr2nG7VYxI9hyuhEA3NpRQbmfzWzK/+1jWDNd0fzImRO8/LoOhN4x1F+fiZChG3ZrU19LSpriA6grGmpLx/iK0Jir+DoaYb5PWZstEId5YS8L66UO9OJCkXe1e+rZmdvxEUrvwgZB6h+/6czlDOUBo2cHpWZXPoDz/qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576112; c=relaxed/simple;
	bh=w0eKiY4I5uQufyW64Owv7K7jj+Cw2kBSZ0H/fUn8aTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JSZleRY5hscmOfXU+4czDjuzHho+hEMS67Yfhy35lHMhtcIydwl5IcaN+IRsS4C7gtH4dER1IdfVSB4095OHsEvVfID9rtdpsA21i1xI7ilHk7uWYwZm+ZmQmMDRNNcregC9aTHv9phkNjxEopGGfILsgVRhQsD9gPO4Ye7RWX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=cweaukzy; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="cweaukzy"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-9305a2121a1so722930185a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 12:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784576107; x=1785180907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AbvY/gXh+2/u61eyWpGKI13cVvWaG4WQkB8wV0sMVYg=;
        b=cweaukzy0xSkEdWhxhls4M00xcE3RdBAkeV+RCtuuVZxeneDh3Lj5w8ubJO/Zrwmrl
         Nln1/CsNKB3whOnU0gxZ+UN+TowVz1+VyoBzRmPx71CReyduVjO8hRWd+ix+3AG25bCd
         Jo4l2RfJyskjI16bDjfDvujp/h3XGJmZwJUCOc4ssvpFAg6+yqWRNpIz54cZxcAEk1Ss
         tqiTLiQttYsOCn1T6APRUcDBYv8WeBG8oj+dTrbYpE4Hcqo98s9Wx0IRMYUFPfOVfa4X
         +r58eMj9l4k5hmuOCFsUm+kzKS2qaNwm/AGbvQC/IXrDAJlkiVxlWATNJk7i9QyP3kDL
         x6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784576107; x=1785180907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AbvY/gXh+2/u61eyWpGKI13cVvWaG4WQkB8wV0sMVYg=;
        b=DD3QsOYgeNYATxdxhvNItTDosPmDteBCLdxTe0uDrZDuZSLN3IcniJa9IyJINf8zln
         F/xEAC9q2El6tlEuzDnDDj5Izh/6k9Tu4qWPD9bJbbBw6f7/fpkcO2pPvtq/RftZFODI
         r36Xy2LTTYf53M3kCM5a8gO4s+Aaf2rJbX4mGmE2M8hdONEk6lLIChQnNX6Yw6fbGswG
         mzMN2j0ymWeRIyg+gMVMAEAT6ZqNpjXbpREf6oKHjrHisGq2In96EIXsRSiluJDiyz9E
         GwDvC+SwNPTB4oP0LRStgYmVd2CG1uCvW5NQp+hBQPbo6plIbXuiBC6GOkDLEPQdX75x
         XF/Q==
X-Forwarded-Encrypted: i=1; AHgh+Rrw9LSD6OjHAs9UPWoxkKXgNzmqmFgxPiBsZbV4EW2Z3p5r5tHDEEGaxd3tBQezLaZHcrr8Q4gjCjWMZ2U8@vger.kernel.org
X-Gm-Message-State: AOJu0YzzZfV2lLHnLydd1IDJMSRzGCTBt+OFfgvBgoLA9QavWcDXo8Yg
	kaANESPecscVkrjQ2mbuIGd0u++C5gU8640/wAzw4Cmmol3xiGczxoR/nXPM65Tedtk=
X-Gm-Gg: AfdE7cn3ufgyPPZN2rznqXhXJmhBaWHuMrO4gpbshfptFq1qCYZTTStvWF1HEUADqhp
	2UdEpTAFL7IkO5a1CSILCXIMOVTJaV7xM82niBnWlEg0qpLQZQviYnEN5jgS9ND36UwksRalLLM
	lNo8wIWQTEmFmYF64s84Gh6V5gczbQiWG8X2pxjkhCnMksuhAd66JqHqmyvpAy2ksZVgUnV1Hlv
	DCeltbGaj+DU93ZJVBzjkwQBNfy3wmOjEcTHdurXXl5DDv8vvcF4cFgdWbxbp4gypbJpU8BYABm
	NbKZfsOdqs6exjLCvB9kFsenkqgpYHWMnI3Rk5MuaTCF10NTfv52y2lfw95P+Tz/FCc8I99UYPl
	WL5z6ZaBoIOQFizqt2Zn7SjfHs4NDdMf8yQC33HW3fFQklTmzaTiQQe74dxli2q6OmLiQsI7Ptd
	7xwHO3LF6USfWB4oeq4om8dPlpGqki6Z9x+Q625+bNLudzh+zj88Ql8Si3G8v5bGs=
X-Received: by 2002:a05:620a:44c2:b0:92e:6b95:237a with SMTP id af79cd13be357-930b3f45487mr1592960485a.32.1784576106925;
        Mon, 20 Jul 2026 12:35:06 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b545e47bsm957792285a.35.2026.07.20.12.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:35:06 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: Zhigang.Luo@amd.com,
	arun.george@samsung.com,
	balbirs@nvidia.com,
	brendan.jackman@linux.dev,
	yuzenghui@huawei.com,
	apopple@nvidia.com,
	alucerop@amd.com,
	matthew.brost@intel.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	djbw@kernel.org,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	osandov@osandov.com,
	jannh@google.com,
	pfalcato@suse.de,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	pbonzini@redhat.com,
	osalvador@suse.de,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	longman@redhat.com,
	ridong.chen@linux.dev,
	tj@kernel.org,
	mkoutny@suse.com,
	sj@kernel.org,
	jgg@ziepe.ca,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-debuggers@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kvm@vger.kernel.org,
	cgroups@vger.kernel.org,
	damon@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v5 11/36] mm/compaction: disallow compaction on private nodes
Date: Mon, 20 Jul 2026 15:34:05 -0400
Message-ID: <20260720193431.3841992-12-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720193431.3841992-1-gourry@gourry.net>
References: <20260720193431.3841992-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Skip compaction on private nodes. Compaction requires the ability to
migrate pages, which is not yet supported on private nodes.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/compaction.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/compaction.c b/mm/compaction.c
index 9f81055a358ed..8c1351cce7bcc 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2462,6 +2462,9 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 		    !__cpuset_zone_allowed(zone, gfp_mask))
 			continue;
 
+		if (node_is_private(zone_to_nid(zone)))
+			continue;
+
 		/*
 		 * Do not consider all the reclaimable memory because we do not
 		 * want to trash just for a single high order allocation which
@@ -2853,6 +2856,9 @@ enum compact_result try_to_compact_pages(gfp_t gfp_mask, unsigned int order,
 			!__cpuset_zone_allowed(zone, gfp_mask))
 				continue;
 
+		if (node_is_private(zone_to_nid(zone)))
+			continue;
+
 		if (prio > MIN_COMPACT_PRIORITY
 					&& compaction_deferred(zone, order)) {
 			rc = max_t(enum compact_result, COMPACT_DEFERRED, rc);
@@ -2922,6 +2928,9 @@ static int compact_node(pg_data_t *pgdat, bool proactive)
 		.proactive_compaction = proactive,
 	};
 
+	if (node_is_private(pgdat->node_id))
+		return 0;
+
 	for (zoneid = 0; zoneid < MAX_NR_ZONES; zoneid++) {
 		zone = &pgdat->node_zones[zoneid];
 		if (!populated_zone(zone))
@@ -3017,6 +3026,9 @@ static ssize_t compact_store(struct device *dev,
 {
 	int nid = dev->id;
 
+	if (node_is_private(nid))
+		return -EINVAL;
+
 	if (nid >= 0 && nid < nr_node_ids && node_online(nid)) {
 		/* Flush pending updates to the LRU lists */
 		lru_add_drain_all();
-- 
2.53.0-Meta

