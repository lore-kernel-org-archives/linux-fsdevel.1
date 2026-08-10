Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8A73FE344
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 14:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371704; cv=none; b=sgqsRfucBEezNln2O2gCMiUtmFD0rggjXrrfBE8lbAOYTuBq/WXvbG+eFeyVirG9Zid2xQF1VBtGeia6RhRXUK89dDxzGOTU8YIcI/9+SleLI52IESgwD1Lpu3vJTIruGsLFND9ncTq49JepmRc1E2s1Yciq6IS7qksV8ioZYVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371704; c=relaxed/simple;
	bh=nPmPX7TOd6iviTDoGDogGRf3WQ6WG/tn7FBA7wKc8Cg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kK9XZYZalSrfepL1XpnSsLveNH6uH+BU5Z2WTb3T57VUk44W8s7WjgXcrPrU5WAiUfMb2sWzlURBpnU8rqoHlP2TtRpOY2AX73/48mob7Y+qut4b873gjG4kv5l2rvivhLS3VqlBoX5h34tm8b/80l3yPLhMZzzwWwBDkAgq7iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=JRWSYZBC; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="JRWSYZBC"
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67ACa9qT2990311
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 10:21:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=S3D6
	qH/ZmLhiW03zXnR3WbvGewlE3ORw28iMnvFcpFU=; b=JRWSYZBCu8mCmTGWvbvU
	vcg0D3UlltsT26b7Dm8dsoBNf7JUve2Rf3wjD1IGOE5C9j16pqyNDU0ezcYckvwc
	D3Waz/SlkjxnyGgW33tX+qEMIzPzxINHd5uVbzU+cUrZAbcWnmSr3EnYBtYJI0o3
	ERZ5M42fdtlYu6dz7fRDYPZioR89JsquAnO5/OtDICrbd9VXEXfH5Xnk2KEV2SsW
	CLLp/Hje3WnV1q8CXfs4PsWzBTDli793kkT5BR43TwtTuTHTFNEvkFGzJuA3Uq1J
	swB9IoY0ic6g55WRvljs2HHbAugTMQ3MF97vNlXzv0SK8utjBw+zMceq+dy3G4vc
	JA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4fxykwujh3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 10:21:28 -0400 (EDT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c1d30035dso13825781cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 07:21:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786371688; x=1786976488;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S3D6qH/ZmLhiW03zXnR3WbvGewlE3ORw28iMnvFcpFU=;
        b=snbztJaAN2/FL6CVZ3ZDVci2CoaoKrcQp1Tq22DSVhfGPcay+QfR627tn1iMA2hrMK
         K0rZj83GESvWjLerAZCpFH2e0i4tSi82s9mXgdonw0AmCLizifdaZlrk61uwUidS9jTa
         d3qAWrv/bRx7bJnz9QnIzP06VjmaQIJQJjWc3Yp2Q42Ln9sy4DQDeqK2J6E3neL3bw0E
         m4RTH5oMUQ1xCqbz5zFQDNhLkSfoFR6iKT+Sy2DwoFxMqCknh7UR7xZ9IX5QXPGvoqFZ
         8Cdcytbm6zHSrAIl4a5D4xnTHYkiFB4mUopW2oEO5cTB3UCUVgSNhpWJh25g4qj4ON65
         XU6Q==
X-Forwarded-Encrypted: i=1; AHgh+RrLu3vFeFT0uKhWjpjSQjZnc5TrhuoWPMdlVfsm/aaSdqHOb11ebC4Fl+sroKuAKjU+Kroz1qBOMA9cHF/v@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi+VUX6mL9zxhY9kqAOn0URZ+/GL1OtVTwHyuAvHwduqDuc2dc
	hcr2UY2gn8l2Wg4Xdq9AdToDfMdvwpEfwYbZVSS1CivmupPhNi3mY6NB/IH/R0w0ztC9HkSX/nv
	cx0VcrTFFsCDp2e6awiD2Z/7EcGWgtfW6FKorm/orViNu41bZrIBo1fXTzK9+2lE=
X-Gm-Gg: AR+sD11fp5r4Vb7G+7Ouh4LF8SB1zPNnfPLVvfNsrlSyA1V6MCOGWXeZpx7zj6okTnQ
	T7q2e4oR+xdVYwcVMb3gdOyV6FqH7FZHQVjBl/JZgT1s8Lx1vKPtJSFgQX+XJ5HNxuuXgqqgNlS
	Cc6yYvEJm3Vt5bKvupT8pBBAg6utUvdN0d+frwb2VZCC2qykyUyxLrTr/k6CfUNQXyAIlz4pTO/
	NsIUxO7PphO7EMz0fLMwGCnrAsfuen+62RwA9uspeMYO/7Q3xCKZlUVcDLSQe3G0bnBqVFS6mid
	pleiLQAE2rww5F4t2f8+MkMZ1yUz8Gpf2XgB+D585WFEVG+PdDpPhHd+GOP5D4KV3cxKuFScQlG
	v06KgLalq
X-Received: by 2002:a05:622a:144b:b0:51b:ecbb:206f with SMTP id d75a77b69052e-52d4c10b153mr22589611cf.32.1786371688054;
        Mon, 10 Aug 2026 07:21:28 -0700 (PDT)
X-Received: by 2002:a05:622a:144b:b0:51b:ecbb:206f with SMTP id d75a77b69052e-52d4c10b153mr22588901cf.32.1786371687575;
        Mon, 10 Aug 2026 07:21:27 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.77.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002145589sm37383983f8f.1.2026.08.10.07.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 07:21:26 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 10 Aug 2026 10:20:20 -0400
Subject: [PATCH v3 09/12] ceph: remove page remnants from
 write_folio_nounlock()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-remove-wait-on-page-writeback-v3-9-dd7531704f26@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786371655; l=2482;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=nPmPX7TOd6iviTDoGDogGRf3WQ6WG/tn7FBA7wKc8Cg=;
 b=khqDuSvEeY3iayitcAW/vunwtinABTC4Duk+Il2kJMRDY3Nq/xhyvNiLwOwy1X/owlcNbZVu9
 Ak1lnHZ3pf+AG3RpWIeXjwYuSfobiQr4Gh3ucmIBMR06VcopR7ZiCb8
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: _1OCagWH6Tl59RjkM_6NSEBrugjcUD66
X-Authority-Analysis: v=2.4 cv=S43pBosP c=1 sm=1 tr=0 ts=6a79de68 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=zHmcO6jMd5r4EZ4U0P0LQg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=vHg950cVU3XL5QtsloQA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfXzQp9piCo3duG
 MF/w5/8PsexfI/2njQQkxLiY+/X3OBiIalslJVV8SwFUdq1x6+cxee8YkugguWwdpou9UdTbIwL
 JfmXng09aQmVvHPVl/WslFHeZ6bY/pHlGzfPds1+gJM9CprAFLlsoFhhhBFvgXaLv71CaUCf9u/
 TSGsfL8qBRpzcol/8IQCuCRFwi8EgnkJTBBRGbil2mvCrUG89PC8T6tr2HgjYU8i5dY6CRVJeky
 CxcjKWPASjiG4spwJrb5L7VMAe7p5zCn4dXJGv72vpJFyH11xEsbNV5mFef2+iQFV2IAw+EwiBr
 3/eRFokRUJqNXAya0PbAG6XN/PF3wU6TueinUQUhqsppR5fh9sF0fsY5Hi8knPUPnWkWmPW0H+e
 tKOXPYMtiKqITNGnp6tMm8mvR8bINZuMbTv5ib5r9rAdklnK/Oy3SH+nJz1eG3DeRNshPqcCWMn
 n+ugd9tV1UG8KQ+nJ8Q==
X-Proofpoint-GUID: _1OCagWH6Tl59RjkM_6NSEBrugjcUD66
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfXxJLPmkwypB45
 QkD8rd5DC6hY+SBMhmj8BbqL2QOV5tMNKUAaO7dfDEHKYrrsPCMKjnfyOVllrDJwFPTQNRSHYU8
 dmRbbp59gtu6ASZOLzfbMnN7a/2pZe6zvTj2W3IJpe6LCxHQY0Ll
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11870
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=10 spamscore=0
 malwarescore=0 suspectscore=0 phishscore=0 lowpriorityscore=10
 impostorscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100123

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
index a3324da08123..ddb12fccdcff 100644
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

