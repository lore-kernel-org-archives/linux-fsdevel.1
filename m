Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5742037DAD5
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 19:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786994142; cv=none; b=EZIiDHLI5IHKFWneB6wms/Jovyna+57aAznWWEZcAjISIjg3Lwkd8PSV5EeTTwoUAy3DKVQiUGcVObh4Q1eDft3dzihIWX42QjPNnS1n5nJucnuK0iRCA5VNVicocOEOjl/r6/udw9racSN1NReKVXXXRk0K9T8LnX3/TMRoHvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786994142; c=relaxed/simple;
	bh=Py9gUMYDLXU7l1TUEJ0L6HzvJXCNw6ptCakw/+crsQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SrzsrB6q6c/4Wkr8HoigpfaPIbzaSSb0s5WzYT+OFOI9t0Y1DhyS7jwCAGxSn8zYQtzJNMF90KhArBMktLUBpU/ALmOFoYtinkhfiN/on8wepe/4+yVehgXc6nGj9hJn2bW0xo+4HEU3LolowdvQQTsO1hJ7x2UnYOlhYj+bPEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=aQ2iaOWu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=ynDiZXs9; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="aQ2iaOWu";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="ynDiZXs9"
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HIvhk03766651
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 15:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=GWf7
	W7btzDJ2DedURkbQJEOrdsj9qNB2OmbEzhz1xwo=; b=aQ2iaOWu/u9y5uDpTyJk
	mg63Q43oqYRBLEtM3bWQdOMGQBnMy/ewC6GuzPhp4gssH294S97auQcmFiFDjGWv
	I6MHFNLOkvfeRi8xBXTzbgU+S34m96INXoYVTJtqIKpvMFbqELHEM04yUPhHn1Q8
	A/R4xZyBdvl6tzrqDd89Hj83LJSAckC08fdZ5KW6RxoY9mzgRGhGQwLbdKqmyJY+
	kOvaQsdXalqU5ECHyfxCLy45SrMcZe7hLbtkcYQhaKSUcMWsaH/u09BAgjlxxAi0
	0GJxkbF08m7yAvyuL0AA7bPuGZW8+sL5md58v10GAM/+CcXWDe/BZAmvvr/kehSY
	pA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4g481r85fy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 15:15:40 -0400 (EDT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-936a796a23aso325974885a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 12:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1786994140; x=1787598940; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GWf7W7btzDJ2DedURkbQJEOrdsj9qNB2OmbEzhz1xwo=;
        b=ynDiZXs972LvKE6nqzE7OiKqVBlW0lVBqAkoh2mSb4sid5NYGWFuSWPuYRBP8UjuXi
         ZNpz761tCLDWdV5DkRuDhpCIE+IjPFytcx7FrTOPovmxn1NpBrKF0OUPJ3g3rqnlRSNd
         MOQZyrPgi0FhevX6AraZuWQKxZuBFJWmmdfLrdpOQvYOgQMGj1pCy/ObKUg52RrV0uxC
         lc0zVsCTIu2W1ni2SK59O912Ptg52JjY2hkJZ1mULmjxBXWOt6pnRs2s3EwFEcCpvxv4
         2tinIuj9tGmXRkudmfzzihYX46RRxJhvdDUxhNf/TLaBVgD63iaECYq1GDvJifmbfvva
         Dgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786994140; x=1787598940;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GWf7W7btzDJ2DedURkbQJEOrdsj9qNB2OmbEzhz1xwo=;
        b=cqe/Wp3F47zeKrwl/DpK4VGTxyRDwnU+EPXr0O4f0qHa2r5pf5nu4MmOHThrlMBVfR
         jBmr65293IZjPYADAohVw4gwzbrt5SG1upn+fCBGfBDjeYXqO1dqXmR1WC87ag8fHqHN
         aF7stKrG/dooudNg2rMRS5jXY35Zm9QgXJacKaRZ5be5q0PBdxlQzAvaKHKgd/uMp0qV
         7sfclUwmX0IO6wxCGBCkwxmXM3QJJh15UgBaIkuA6G5jT9mf0qfIAkqjPj7aUqpd/FTa
         jaV/yYEhdHDldsA8JVSfIbJVg5pixiXA4ZPS7eI/3rl1pguo7sI9rVmdlg8W1RGagSbj
         PMQg==
X-Forwarded-Encrypted: i=1; AHgh+Ro7tg2gxX3soTaHCgst+DOYEHoG734QdcDEfhmYn2tA8Wb0Usyf+zNj5KpkMqHBFELAChJ0QMq2hWiqA+lB@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9XVafzShCq9Yy7RXH18u91X8Pxvnv4uVC/szVmnoj6X9ZVtNY
	72+AX3ZSXCSX176zOsXBxI0jfNjDkZw5K1BivMTIQ4rcBWAlvqyy9ICkBHiFn/fg0suiWqRF2ZJ
	fl5CiY8SUeVyuCrUEfH9Qa5sPwLV8jDcgzoyU5E9tBvOt+4rCmavEXuPq7lmI3XQ=
X-Gm-Gg: AR+sD10BqLHXRyF5S0xBSCEJIieE7+mYDUK5fHqUOOHcwRiIuRT8HwclTjsyfymU6tr
	CRZuQ87tRWBDQeG/slCkaR7dPZWE030fTZrFunoICMognZeoGCpUjei439/irg1ghlXY1WNF0EC
	VAzp3iDwBYGNSt2WLrtC8Y2Zf/RXeDThVI8Q/mddlI2Wpuyr1D7ewM8I92Yov5zZprfmRATl5Dw
	Jrar1oxCWb+NakxZ1ir4jI92V2mRXSdXZyxMk2N84JV9K8O57sn9gV/6AOivEuUEoKBzHwOVdAU
	5f4xWW0UVfIv9UKwCGncm1trSm7MVosFkAc4dym8IizJXNzPq8nDezcYgrYDPXjDQX+nsJEiM6/
	XxpRYRQva
X-Received: by 2002:a05:620a:a18a:20b0:936:31c9:6c57 with SMTP id af79cd13be357-936d2145af8mr2163067585a.7.1786994139712;
        Mon, 17 Aug 2026 12:15:39 -0700 (PDT)
X-Received: by 2002:a05:620a:a18a:20b0:936:31c9:6c57 with SMTP id af79cd13be357-936d2145af8mr2163060885a.7.1786994139218;
        Mon, 17 Aug 2026 12:15:39 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.67.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499961098cdsm194692085e9.6.2026.08.17.12.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 12:15:38 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 17 Aug 2026 14:55:23 -0400
Subject: [PATCH v4 07/10] ceph: remove page remnants from
 write_folio_nounlock()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-remove-wait-on-page-writeback-v4-7-0e5e53d47eb0@columbia.edu>
References: <20260817-remove-wait-on-page-writeback-v4-0-0e5e53d47eb0@columbia.edu>
In-Reply-To: <20260817-remove-wait-on-page-writeback-v4-0-0e5e53d47eb0@columbia.edu>
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
        Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786992937; l=2482;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=Py9gUMYDLXU7l1TUEJ0L6HzvJXCNw6ptCakw/+crsQc=;
 b=KnKavewnMLt7GfgB/b9gNamxCvAKCVliqz/Nl42GLPbGPgNz4HqeqCOPrXbTI4+qdxkMA50j4
 O4CmW/Hz5AbBwj/z9IrdWPBS9SXjRb5arFT/T2ZJwzAs+6gmLmK7RuD
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE0NyBTYWx0ZWRfXwq9ImUB9GjNw
 CDEiOj0N+1DI02fW7deeXEWZcVT/KNbTSyKTiokUA00sXmZWBLw66Dw/89Ww4VN7zvzpCl6/ABy
 q6l8UGMV19G1XCj8Y3Jqz3sHIfZCixpxMbJCsnfO8prHc9q9pOYtgY4vTNWQ6/HnQ97i+Cp0UuI
 U4YX9yZdsCRHPv1f09RKUT+Hrv3yqgxjacMBGDW7lyuBuAXsdMpocIHxwk3buHUOxN+ODiHZ27u
 CrB6uCEu2ZJGsWcOZOypDBLJUbEoe/hmDHp6kF8kN5T2Qevor0jPjTgVj/a3wsnIL9JBuIJflJ0
 vsPGeWG561IHwkWyp1M5o0ZOQhMctmC1/UCTylFQ+jkZhYSUm+TwxulO+bfRqp/RKc/lTKEwKmT
 d8m2Chspc5DgdsQuZXQWRpdLXuJ/gFuNlA8XdftfyTi46Avjjels55acHBeu7d3uzI+k2S1wEzT
 2SPd+dRDBw444Hb0GBg==
X-Authority-Analysis: v=2.4 cv=PKw/P/qC c=1 sm=1 tr=0 ts=6a835ddc cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=+gpNN1aRt999K7yrv1sWlQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=jHxIr1HyPKZ_Q5_91PL3:22
 a=vHg950cVU3XL5QtsloQA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: OBHGyTGmefJeHYWLprgpEw8ZHzoHoLZE
X-Proofpoint-GUID: OBHGyTGmefJeHYWLprgpEw8ZHzoHoLZE
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE0NyBTYWx0ZWRfX33i7eIpVzJ8d
 6dj99goiQeK7pMUn1kLxwGKfB9zO1GplvbI2lv7pmM7cauU+Kc9h+lV+QtrzEH5Ggy4DBZhERQa
 UYls0TJ9Pi2+piozQtmk1KirYkpeRMMgh2kpahhvgxim8u6L70EK
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11878
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=10 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=10 lowpriorityscore=10 suspectscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170147

Use ceph_folio_start_fscache() and only use a struct page pointer at the
osd_req_op_extent_osd_data_pages() boundary, which requires a page
array. This removes a call to compound_head() in
ceph_set_page_fscache().

This was the last user of ceph_set_page_fscache(), so remove it.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/addr.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 2d89d3d51bf1..756d44eae838 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -558,11 +558,6 @@ static void ceph_folio_start_fscache(struct folio *folio)
 	folio_start_private_2(folio); /* [DEPRECATED] */
 }
 
-static void ceph_set_page_fscache(struct page *page)
-{
-	folio_start_private_2(page_folio(page)); /* [DEPRECATED] */
-}
-
 static void ceph_folio_wait_fscache(struct folio *folio)
 {
 	folio_wait_private_2(folio); /* [DEPRECATED] */
@@ -589,10 +584,6 @@ static inline void ceph_folio_start_fscache(struct folio *folio)
 {
 }
 
-static inline void ceph_set_page_fscache(struct page *page)
-{
-}
-
 static inline void ceph_folio_wait_fscache(struct folio *folio)
 {
 }
@@ -743,7 +734,7 @@ static u64 get_writepages_data_length(struct inode *inode,
 static int write_folio_nounlock(struct folio *folio,
 		struct writeback_control *wbc)
 {
-	struct page *page = &folio->page;
+	struct page *page;
 	struct inode *inode = folio->mapping->host;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
@@ -825,7 +816,7 @@ static int write_folio_nounlock(struct folio *folio,
 
 	folio_start_writeback(folio);
 	if (caching)
-		ceph_set_page_fscache(&folio->page);
+		ceph_folio_start_fscache(folio);
 	ceph_fscache_write_to_cache(inode, page_off, len, caching);
 
 	if (IS_ENCRYPTED(inode)) {
@@ -845,9 +836,8 @@ static int write_folio_nounlock(struct folio *folio,
 
 	/* it may be a short write due to an object boundary */
 	WARN_ON_ONCE(len > folio_size(folio));
-	osd_req_op_extent_osd_data_pages(req, 0,
-			bounce_page ? &bounce_page : &page, wlen, 0,
-			false, false);
+	page = bounce_page ? bounce_page : &folio->page;
+	osd_req_op_extent_osd_data_pages(req, 0, &page, wlen, 0, false, false);
 	doutc(cl, "%llx.%llx %llu~%llu (%llu bytes, %sencrypted)\n",
 	      ceph_vinop(inode), page_off, len, wlen,
 	      IS_ENCRYPTED(inode) ? "" : "not ");

-- 
2.39.5

