Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEBD4399E2
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 18:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869574; cv=none; b=k0TJ49CYzBQa2ORSqZZqAUpAGZCG7SIZsmG0AMZFLUtuB7LDpgvTGN/fp+hWWVmkEhbm1iYjdIs3L0HDBDdxRsR/KcGrwEldNcN3v4GVoSvTGtO99U/q4G6gg5Q+LGoWInLW6fgkfGiH63fb40TaZKbO+gxCSyR21czh/YG0D0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869574; c=relaxed/simple;
	bh=500EpqFLV6KTsCK9vzHr1t9+N59E2kCrXGhqPKPlKoc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TAFnfVWqWYnPpOZEbTZJhienvAfTjkb1H4w63PFLp4scybDEW4baFQxbRVPUV7ghqu5M+tBoYLEyti6/LNnZnvKQntXE+eGjqhcIylhtKWMsDjWUQAnJFI24GW828wFdgojVmzY3YOmU8PtTsJgPKposLNh2wDLJ0gjnsk2/ee8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=TPTrIWS8; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="TPTrIWS8"
Received: from pps.filterd (m0167068.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674IY75P2404212
	for <linux-fsdevel@vger.kernel.org>; Tue, 4 Aug 2026 14:52:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=CnNA
	DUinRNwat8S2OMUK6WgEOXqYRvhZzhuvbRl7oDQ=; b=TPTrIWS81PZQemSMf5t5
	USmw4FdbDjyN23RSCrdvIHFD3UxdDzJM2cuFbsGXRn2yYlsFMmIjuAEPYcHTLZo8
	r+NXhE6fYTMMXA59qf892/pQaTWOjgo1ucaACTygfBYnLdmAfcDyiCHIIzbHul1L
	Tpj6OzRAv+sHcT+Zm7L1xgKT31VyonHxG9et1b+U/3e4SpnP0HtQrZIWySFMSKRd
	cP+LRLaENEs4VsHRQ7ggn5EGtWpcx91FFZAKvwna3vKScKHLt9QGl+3KSo3C1Vhu
	pgYiG/Uft7bzf2wKit7jqnk0vGinskVKijo4mmbWqRonm9FrG0Ajl6MXVEygOOly
	4Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4fue1x3nfv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2026 14:52:45 -0400 (EDT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c20762d21so1323441cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2026 11:52:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785869565; x=1786474365;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CnNADUinRNwat8S2OMUK6WgEOXqYRvhZzhuvbRl7oDQ=;
        b=qHzgYleyPWZ1BdOSQfqyzypZ45o0mbA3IJQBaUjN9inpZOW9nc3q8efBagYp4Xco+n
         +GtB5iQZbueS+wyUeRacyHdfogXzdfPL0NSFDX6NmSCgWoeeWctRBQnvorXSgwvMcByX
         mni79B3A6KSxfcuZM8HPnuMQz/h/Az1dyorCfGLP7uU3eNvfMmLIkgrzq6/TjRPiNYX3
         ETSeC3zDv3aCV8KD3nOAj5aax3as4stXyTSbywuxyQt0MS9F9AvvKq2Vy9WWmkD1P/L/
         oHfaJN4wIwShTbgo4XZEt6bShcq+mnc1mJ4IjND6I8z5VPcsMJ9ef5sfYgCNF9gQ37s3
         EMTg==
X-Forwarded-Encrypted: i=1; AHgh+RqVvTo4FxJfYR1arv1ug77mEA30NdzT2rTdUGv94D4eba5Dw5dSnJUz8VJ0wzr4V3Uek2Wwa8mNDFw9SQTR@vger.kernel.org
X-Gm-Message-State: AOJu0YwcMmmAGYZ41n8XF7uEZ1H6ajvk4qw3opa7XLuZ4bshhewwVGRo
	xoDMuaqBoOvNn027CHzr51LJ3/SjRXUgnLV11YnWa0QAyvsVleze+k8fJ/Zojmu5NO4j/05o9Jg
	eYz6CJ81vrfrQTvHRTYFl1ytC2WjZDKlzZVWUPyVNCVpU+Yqh5uB29BJGfJycUTY=
X-Gm-Gg: AR+sD11RTajOBhhum07URhIAfrNTh/s11eiuSvixRCTYwy9ZgL/Ildg7KnyiZ5rMwfp
	0SPmSjVNOC1FmN/BT+V/qaVAQaFocAuubvp/TqHstRXhUHNmBtb4XNBRwZbxRsi7RVaDjHCpyfc
	6+492xoReSQ8ugOS4oPuQSh9fEcwU0ALPvX6TTL5eWLSGYfKXgspCQF2zlNoU2JBWXiIbvvvrp7
	IEn8HEahgW0pM1EAfVQQPmWqOSr+Tpauoh+8FeWTi4DJT8q5C9TVVw6yoUJ4r+AGNUisoZq44UR
	RFZD1hMFHXoAxuZIu4Vryvzf8x0gV/2dPSaPTJjc6Kdq7wfFBzBwRJOhH04sp/OuyZe1IdVIeiD
	EcOBGnSYZ
X-Received: by 2002:ac8:5e08:0:b0:527:f0a:ccbc with SMTP id d75a77b69052e-52ce5fa28acmr15090551cf.18.1785869564653;
        Tue, 04 Aug 2026 11:52:44 -0700 (PDT)
X-Received: by 2002:ac8:5e08:0:b0:527:f0a:ccbc with SMTP id d75a77b69052e-52ce5fa28acmr15090071cf.18.1785869564163;
        Tue, 04 Aug 2026 11:52:44 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.77.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec232d7fsm2313275f8f.20.2026.08.04.11.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 11:52:43 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 04 Aug 2026 14:52:15 -0400
Subject: [PATCH v2 07/10] ceph: remove page remnants from
 write_folio_nounlock()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-remove-wait-on-page-writeback-v2-7-81f0ab065284@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785869541; l=2510;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=500EpqFLV6KTsCK9vzHr1t9+N59E2kCrXGhqPKPlKoc=;
 b=UBXFoH6y7LgXHIhuQeQIAJrJ0u0TLtb+QPEwzLT3I8tdP4d68PDNx+HUqFw0HznkZYJXgc93m
 lkPyciv2BfKAqFjgWwF7vCQck65jvJA4ziPdSBfbfyDO+n229Fd4GIj
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=C+7ZDwP+ c=1 sm=1 tr=0 ts=6a7234fd cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=j1J1DEHOHTVaJYOjuVnKiw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=usPcmh10W0ubT8QP8_c3:22
 a=xhPbJxARXHWvbxRXPbEA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: 6vii1_s5vxoepGpPUeg0a3-5XMrUprRF
X-Proofpoint-ORIG-GUID: 6vii1_s5vxoepGpPUeg0a3-5XMrUprRF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE1MiBTYWx0ZWRfX4CM8qw/RwmBm
 86FIlvrwLJ98imVD6MnqRfg5RysVStKAKksqUmY989CDvsJj/hQ4Y+GMPH0QoZHvfDytHB8rVKI
 /OhzaVXHBd7wFCvWhTdOub7GAAkYpRz/538xV47U+GX4NpddwlUMkIBakF8PQ3jzXlOD+ai4L/8
 XzX1kSmP4IM2D/7AjqS8wrOP4MNR3eVnEgCoLuYcjJUXqIViFgsWYp55b/FjIS7KMP43dCQg8zw
 Yue2ym0JuivPInthtIoYApm/rIglLFi1M8djPATEGuK2MAlzp109kAiOaMLMS3wAJxoeubQRkMb
 M+bNR3eNuNrOFeIvpBXXaObt/5hx1LgW7wDJMNE2jBawXfHW46XlGFZLvbnVBhwf0Q0YzRqP/vq
 j8Dfpjy88z9djNx4YUhegbtb3C9K7VAYxmUI80GK8nWm7HrrKx5/RXoWY3y3iVmHASYklzeKU3C
 Pus6u2YttcG34RW/MOA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE1MiBTYWx0ZWRfX7+uJ+H395RDm
 tS+uAMweOEQmQmJhOiXJVveWwN9OdAP/C0gsbSrG7U9Da2/IzDVgcIJTHcohFuwRutoHtM9JpEh
 bzy3xIJOj3cjF35hbmPdDRyN7roWscOfHo5/14v/KHepyjAMOeZ4
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11865
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 spamscore=0 lowpriorityscore=10 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040152

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
index a96986c503bf..59e559bdfdff 100644
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
 static void ceph_fscache_write_terminated(void *priv, ssize_t error)
 {
 	struct inode *inode = priv;
@@ -584,10 +579,6 @@ static inline void ceph_folio_start_fscache(struct folio *folio)
 {
 }
 
-static inline void ceph_set_page_fscache(struct page *page)
-{
-}
-
 static inline void ceph_fscache_write_to_cache(struct inode *inode, u64 off, u64 len, bool caching)
 {
 }
@@ -734,7 +725,7 @@ static u64 get_writepages_data_length(struct inode *inode,
 static int write_folio_nounlock(struct folio *folio,
 		struct writeback_control *wbc)
 {
-	struct page *page = &folio->page;
+	struct page *page;
 	struct inode *inode = folio->mapping->host;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
@@ -813,7 +804,7 @@ static int write_folio_nounlock(struct folio *folio,
 
 	folio_start_writeback(folio);
 	if (caching)
-		ceph_set_page_fscache(&folio->page);
+		ceph_folio_start_fscache(folio);
 	ceph_fscache_write_to_cache(inode, page_off, len, caching);
 
 	if (IS_ENCRYPTED(inode)) {
@@ -833,9 +824,8 @@ static int write_folio_nounlock(struct folio *folio,
 
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

