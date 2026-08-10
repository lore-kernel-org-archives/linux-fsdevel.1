Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEEE403AFF
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 14:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371708; cv=none; b=K8JBZIfBu6YzmxPvDBnqBcsInrQbWR7U1TguwtE3VqpPYVjFEYcTBijdKDfNYp36VwxIaXBxTJffNfgHP2oyZq0IvEF+LNl1PIq8gHZ0w4T/HZJpV6KLJ6NZdz7pi/0iZ7u904holthB3Ferej4u8KHHMydbDtNo2mmbowkr2ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371708; c=relaxed/simple;
	bh=eEBEQRS44uRWq+68HnHuSJkJWcepL1mJ0SSpfrhNU80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q0YWFZos1m3TnxIGg98cM/Yb8KwPFO7q1uJknthy4YMaLkiRfpIzwn03LuiIKgfQRM9Mm9BqY0+1IjWc6o91LxFxT8TdRFkDlZPMVYxxTKntShk2IrOD+uR4MWlyBlmrT3ypS4+9gBrAMEkyM74oRJo9CkiJoLFsdltq3sE2WHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=qjq+35LT; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="qjq+35LT"
Received: from pps.filterd (m0499199.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AEKH0U3092943
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 10:21:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=aLyb
	lFTyCRkRNvHlbjBlieXQYnfG93Mvps8LThXIpPg=; b=qjq+35LTpjf9J2w6F2hB
	vecXljYKiBnAzD5aenYJHzWhsNXgP9xHEliMM9O37gGKVD1vf/Se7su7wn2XbkLZ
	rD2Jym0BqslG5QgoaHVZ61V0B0C8zhmW1wU+QrjXQYIDVxiVIqKgSDWpi/1WUXHy
	ywTqc3FxNJY4ahiAjXPHYZJOy9kupo/J0IxL1BEaXBInVqdm6ONnvUYHFuTpUBSM
	bfA8k5gOrjl2wE7RFonKnU2MENdTTsZEevpboN2Rq7OQug4eKv7jl7Smq6U+kCzG
	b8RYvB92ovczaQwSBwLkIJDnlZxH21dFvqcBi4PRdU3TYYLfd7kGAt4/+bWKd9of
	HQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4fygar00dv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 10:21:35 -0400 (EDT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-52d28f8737eso37895331cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 07:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786371694; x=1786976494;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aLyblFTyCRkRNvHlbjBlieXQYnfG93Mvps8LThXIpPg=;
        b=spmFHbbuBAyyaihy86kiHRHcTkn4kuKhbBsM9sjsNZoJoR0NPia3Ll2VeAYRwGRUO1
         ibIQ9aQeetGgPmc2vQpORtdjFf9NanSk3kzoNW/KI3w0r8uV8Ku0IMdpBc54G+ZUOuuR
         jx3HwuTI7ByWjHbbrKFNxPr18gKqZ5SpfQEYv0BlgNzksqPZZba7buW1fCIgXbvcA73s
         RCNHdlyDWhH3C5YOxuaMxal2K55o8kXBtIYMXlzZcCpjLvf9zhw0/OekMfOrbVk7n1M9
         3k9EXkSDXwbLqmhUkOJeA5TfmM3PDovk+OeyROs2GqCENnIa5i5crVMUvTCp7Iqf8OYh
         OfWQ==
X-Forwarded-Encrypted: i=1; AHgh+RptJaWdAZmR8bbdU+VxWOjqbatndI2L6boxjsde10CvGMGCUfKJnYluNZmtFq0QAyjbu2lPIGL7GnYNz6Yy@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8MGLE9Jbony2CMvE403wC1G3xvZMUzewp8UzKelRTbqkSy4yt
	CM07U6fp4fSpsCWtrL6pYH+7MIHRMmULw4U3GkM9me3EFyNs8H89J99XnQVsP9wZWteWmRgNJKo
	PBmU5Fg2tulFOsV34psjsUVIh9UASrn6Qo7XiAJGwxAcLLNcQs4jEzm/dOjyqdIY=
X-Gm-Gg: AR+sD134saDdomAhG/x511iAQi/0vfhCa2BzvwNGp8Xo/awkCI21y3+guaOpRKI/KCs
	epvItxBKNUAAcLfeJVbrBtmUxdmUzHppzlOmOECUw3MzE5B9/EzPXZhVm0e8+QBZSe04oH0Gu7r
	9Vrfp5mwgpWEwEPqptMhFCkilemleiLKD0HGWhHZhHqiEnQg8JPJn0pGGUOAmqCYVyDgZ80adOU
	kXqKBqqzda/pXAXGxPY6m5W4QSGxEMitX+g1qQpOcFH1eM46kuqbiBiIG4aiqvMB3ZTu6fKxa/V
	sbsRnvDasMLtCe1Ki78e72gAgVbgubpkZmQ9wel3ntPUu0J3mgRnf8avPkB2iRxjdg6BGGRWCzE
	K9vTZKqY6
X-Received: by 2002:ac8:6f0f:0:b0:528:3ae6:14d6 with SMTP id d75a77b69052e-52d20a50232mr221693471cf.36.1786371694414;
        Mon, 10 Aug 2026 07:21:34 -0700 (PDT)
X-Received: by 2002:ac8:6f0f:0:b0:528:3ae6:14d6 with SMTP id d75a77b69052e-52d20a50232mr221692471cf.36.1786371693979;
        Mon, 10 Aug 2026 07:21:33 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.77.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002145589sm37383983f8f.1.2026.08.10.07.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 07:21:33 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 10 Aug 2026 10:20:22 -0400
Subject: [PATCH v3 11/12] ceph: remove ceph_fscrypt_pagecache_page() and
 ceph_fscrypt_page_offset()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-remove-wait-on-page-writeback-v3-11-dd7531704f26@columbia.edu>
References: <20260810-remove-wait-on-page-writeback-v3-0-dd7531704f26@columbia.edu>
In-Reply-To: <20260810-remove-wait-on-page-writeback-v3-0-dd7531704f26@columbia.edu>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Zi Yan <ziy@nvidia.com>, Christian Brauner <brauner@kernel.org>,
        David Howells <dhowells@redhat.com>, Jeff Layton <jlayton@kernel.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786371655; l=1581;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=eEBEQRS44uRWq+68HnHuSJkJWcepL1mJ0SSpfrhNU80=;
 b=igitKHwKICJe64WLGnQtJ7juQTX89Q1kNusDsmkgFURVamzkBrRPYcM6WFXlcOnjVGCWu9jAc
 HjyznGVPVaGAnp/iTFafK7Se035x+xGTYGst6RxsqK2bKINK75nE3GU
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfXy2ykH/Y+YYde
 ReLQjqls8gd0wMByi+981m9ems9QGSWI2AKfFIyI/tiP6yNohmmjYUXO3uDrCE/8qUdwDzkOinm
 2EyqOXOKB/nhaqL24RE1SZ+iVX7zMgeXawJMU0STrsZuK/0AOBVH
X-Proofpoint-ORIG-GUID: gqPNX-50-w6KsFayfopBR5Ic2kYDHGCs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfXwlmls264iEDm
 pDSwbYn4KHXbHvaG+BD3+Z2jooE6hdpZ8A6BM1hJgp5qYwA0R9Xe2bedF8p5i6SDB305F2afTx7
 txw5Fgcesqx+oxFK9q3+g4F2flnh5Zz30U6uVJFN2QtWQtprfF+Y9pTMPa+V5ZkmNFZm0YU6N6z
 HuDc7Rb61/EFy8akqQamdc1khSi+JeO4KSCIdtBENGcFCL61pH6KemcZrAotdPR45EebJ3blC93
 U0KScqiLyyIu9KIaWUdooen08DxSkHSLJ37wVM6UgogGqitZv5RQ0rO/rMY8QT9DI6uAtvyRKwS
 XJnppfoLbPOHpnKb6xnli6Sxir2Fre9EHoU2jUr8ompphk6XPNbt4eKOuP05uu5x9gBCUE8c+FD
 m7as/Rr5ua6A9KHx4JNw5y+zCxxMPwduk50jCaNzAv5PjAUeHU6Tr1oMV4uBIluibn0RofnCEPL
 cN1JEtby4u10Zd0jRWg==
X-Proofpoint-GUID: gqPNX-50-w6KsFayfopBR5Ic2kYDHGCs
X-Authority-Analysis: v=2.4 cv=c7Cbhx9l c=1 sm=1 tr=0 ts=6a79de6f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=zHmcO6jMd5r4EZ4U0P0LQg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=G--0XuH5328wxK7v7Suf:22
 a=jfg2DRd2ap2c96lsYj8A:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11870
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=10 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=10 suspectscore=0 phishscore=0 priorityscore=1501
 bulkscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100123

All callers have been converted to the folio equivalents, so remove
these unused helpers. This also removes a use of page_offset().

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/crypto.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
index 948c8b5dca06..d199dc8410fe 100644
--- a/fs/ceph/crypto.h
+++ b/fs/ceph/crypto.h
@@ -157,11 +157,6 @@ int ceph_fscrypt_decrypt_extents(struct inode *inode, struct page **page,
 int ceph_fscrypt_encrypt_pages(struct inode *inode, struct page **page, u64 off,
 			       int len);
 
-static inline struct page *ceph_fscrypt_pagecache_page(struct page *page)
-{
-	return fscrypt_is_bounce_page(page) ? fscrypt_pagecache_page(page) : page;
-}
-
 static inline struct folio *ceph_fscrypt_pagecache_folio(struct folio *folio)
 {
 	return fscrypt_is_bounce_folio(folio) ? fscrypt_pagecache_folio(folio) : folio;
@@ -263,22 +258,12 @@ static inline int ceph_fscrypt_encrypt_pages(struct inode *inode,
 	return 0;
 }
 
-static inline struct page *ceph_fscrypt_pagecache_page(struct page *page)
-{
-	return page;
-}
-
 static inline struct folio *ceph_fscrypt_pagecache_folio(struct folio *folio)
 {
 	return folio;
 }
 #endif /* CONFIG_FS_ENCRYPTION */
 
-static inline loff_t ceph_fscrypt_page_offset(struct page *page)
-{
-	return page_offset(ceph_fscrypt_pagecache_page(page));
-}
-
 static inline loff_t ceph_fscrypt_folio_offset(struct folio *folio)
 {
 	return folio_pos(ceph_fscrypt_pagecache_folio(folio));

-- 
2.39.5

