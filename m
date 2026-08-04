Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEF64C0416
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 18:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869581; cv=none; b=kFNfsopbNaqEMPfaAvps7W6yEZhBcGlrkbHc3YiyEFEGM/QSg9DlwBKdU9AKQpWdMVbiwL+RWnnMX8acAQY9yEueGXfQGnzgNvA8MOmqrCgREe2AMiWot+nEjs9ywN1EnsybStQy2L7/EosXJuF4hz7D5ZJRZAfKBZZHtk0iNmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869581; c=relaxed/simple;
	bh=eEBEQRS44uRWq+68HnHuSJkJWcepL1mJ0SSpfrhNU80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JVGbodWhIhNCgNgp0ZdeVI7x7ileEnIw8WyBwO57eBWdA/ftvR8oRtB2zmaU+AVeErVY0EQ75zle0YFrKAwBuK++1ajqPGOse19SS47TImGtoW09P9qlXzSuvLEHQlEzTl4b4f4g9kHxbVLxfqhkTuxabLd7EcyxwhxHkDRZSZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=FZQOfS2m; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="FZQOfS2m"
Received: from pps.filterd (m0167072.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674IY9QR2050076
	for <linux-fsdevel@vger.kernel.org>; Tue, 4 Aug 2026 14:52:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=aLyb
	lFTyCRkRNvHlbjBlieXQYnfG93Mvps8LThXIpPg=; b=FZQOfS2mrfDQVv1eTgY+
	KoHIWPv7re0oYNY5Ak+9Hk5q72AtkKqpgtlokthMwfu7jmQ+xhBqpqTKIepB9xhZ
	yneWNpbAd3zsItw3SHaMvretXA8+qaOYKNdIy2mbHY6etbfVU/MT7PT4rI2duJf2
	SObadpunqBBBfBBH0bcskN2hDOlTjn+dmhWIx0Z9FnqRYEARekOL413g9Prd2gAf
	kws3L6gGJE9ofKW/2qGu3L8D/L9n+jOo/8oGUM1LSbYoUhcQxOEfeMqBDH300VMU
	kNoC4WkxuLNNlJj5+5KRd8r6O+yNS22qEK9drDas3n7Wtji4lmrhWGPQq3CnQ6rS
	wA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4fuhpht7d7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2026 14:52:51 -0400 (EDT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c0199faafso1070781cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2026 11:52:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785869570; x=1786474370;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aLyblFTyCRkRNvHlbjBlieXQYnfG93Mvps8LThXIpPg=;
        b=tWtXGJeMyJHdriGL3PQKV8rs/8vV6OcA4G8XiRfYj3KbFV4lyeCYeFJjMRD9cuXdb5
         d9OaP4Yhw25F5rclHuPg/APATH5W16ebIqvbtPCQbyA+Ws6zaS+aqj+EzKie0btRuiJY
         wjBrHUp2ao7JyelXcGV0wZ//xreT8q7aZl6IKOvY7EGFZ7TmruKdCtmB90aif951plQk
         cPmM+nS8Kq8liAhjIdjBAk7RdvQsEMfKhwxAttsX6Ho3sQV4fOCePM1HO9+0irfCE3r1
         dJWbx4zvis6lOkh9+1GWYruS8yXEbXYq5A3iFdct7c7Wleja6sP6bHQF/yH6VDVmZ+I9
         h0Tg==
X-Forwarded-Encrypted: i=1; AHgh+RqwIHzo4Ddrhe5IrHO61YrGirq0975CJflfYF3H+xyAX7ouWCFFHWKhLhjZBb7W4jWK3nHnbcu0MIPb/92K@vger.kernel.org
X-Gm-Message-State: AOJu0YyKvWvX9aVdA0GN1cw5yOW1TFzwVwDqJgLUrucj0Rd2mHo+PAfp
	+Tct5siqUg0oAH7izUVOJQtxzTZW1/zQal+JsDzLJZmWHnYRFtZyjigxOb/sJb24290XZ1PT9wX
	0vRZFsESwIaRy2eH5gH1iG9pykAc2pPWyD7QcBGBWqiHo0ytxszntf0fNAd2mCDc=
X-Gm-Gg: AR+sD12p3sjuBU817LmokRt43z6s1TOckLZWYkbGSuyNydokGIX2uJ5p11A02GAe1su
	X/66woBNWCLHXjmTNDCPSyHgY6R7umFarqjZZEZ6/P1ddilO+2yvIC8YILx+p12k07E7v0arfbT
	qf5+pXafra0ZezQumP5Gut7gLbuVo/RScDT8PtYa0TfwPbiD5xzxyFgkYOd4lua8N66svXp5TXa
	aVm4GJiIDkt2TS3W3y6aNjkt142EltHdgpt3zmiuYMHhyAqMlKzivC9G9qvq5bjawVuVSEg4CQV
	CaSC3okuxHzzBJSdXcwu9fvAVK0B3YnbPs51vNOEol29hp6Ooxq6ANs9uqTP9tsOHT5d2StsplY
	bDieYozTS
X-Received: by 2002:a05:622a:345:b0:527:6dc7:5c5b with SMTP id d75a77b69052e-52ce61009cfmr11185411cf.21.1785869570494;
        Tue, 04 Aug 2026 11:52:50 -0700 (PDT)
X-Received: by 2002:a05:622a:345:b0:527:6dc7:5c5b with SMTP id d75a77b69052e-52ce61009cfmr11184811cf.21.1785869570010;
        Tue, 04 Aug 2026 11:52:50 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.77.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec232d7fsm2313275f8f.20.2026.08.04.11.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 11:52:49 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 04 Aug 2026 14:52:17 -0400
Subject: [PATCH v2 09/10] ceph: remove ceph_fscrypt_pagecache_page() and
 ceph_fscrypt_page_offset()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-remove-wait-on-page-writeback-v2-9-81f0ab065284@columbia.edu>
References: <20260804-remove-wait-on-page-writeback-v2-0-81f0ab065284@columbia.edu>
In-Reply-To: <20260804-remove-wait-on-page-writeback-v2-0-81f0ab065284@columbia.edu>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Zi Yan <ziy@nvidia.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785869541; l=1581;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=eEBEQRS44uRWq+68HnHuSJkJWcepL1mJ0SSpfrhNU80=;
 b=ymFYHbrvN5rEjeaHcX4tJ/TZFBIdDlWxKA60/JN0KDJrq2/K4VZWWR2AOJJsHb/WIAfLsRBdE
 dVh0f4m20VEA7/0gLk/zQLeySGdoHYncfupyZbHlWLadTzarlMg/B7k
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE1MiBTYWx0ZWRfXy8QVL5huGlz9
 z0zwrteo6I9RGpSvWpx3B+LW/sgTUyWncwqPJ+BvkGZDyU71mBpjJKYxvtkoLg+RTzdztEjxi31
 GcioRlTbfigGt6BX2LpN6sO0d35Jtu7rmawtm6sciAwHFFbvh4vToOkkOuiIGY1vCaSMemM0hv+
 SXmJzm3VbZy52vNC0FOug6WXhIET9PL0is2UaXjD3k88ey6ATo/I8lNP/aPbGWFxcmA5KXsY30O
 hxlTBRGm4AS++BzPcuI3spBnBt2v6eYQR+6ZlRdDz7XOEwUtb85gjXENrUmAb1ic5blRiuqIVDw
 4VepbhbqIECVCP5XaY6RHiSh5A2nx6kAuLmfz7dK/+0Q1zxT9Fte9/ECqonC/C5epIskQkeL5p6
 +nbKBjp5ZzzR5sicMgq674GBp0c/BehQASzN5QKlv+c4rqv6aPtk9QPHgSWTK38/goEsCyVjmlV
 1OfMBtUsj+/POWTbbKg==
X-Authority-Analysis: v=2.4 cv=O+EJeh9W c=1 sm=1 tr=0 ts=6a723503 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=j1J1DEHOHTVaJYOjuVnKiw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=SsB-OO3BMngHh3ZO9fOt:22
 a=jfg2DRd2ap2c96lsYj8A:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: u9SzAaIzxAFxfvvCfbggLXIRTuZyHClR
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE1MiBTYWx0ZWRfX5SUcxAi8Cton
 2+JPeF1UrNiMCcblZhoF/OFn1sXnIiqqn1KxZ36h0uZZJzLGdQJGMPfTl6vnzB2nrsDzDU98zzt
 yLfViZ1R16GulRaFofd2hsajpjijnKm7cUYuvPsgmdgFR903sCXQ
X-Proofpoint-ORIG-GUID: u9SzAaIzxAFxfvvCfbggLXIRTuZyHClR
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11865
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=10 phishscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=10 impostorscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040152

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

