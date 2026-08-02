Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380DC3CB565
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Aug 2026 16:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785689624; cv=none; b=j+83c2HCkq1jaf6Srkub6d90bKrwSgqWpPF99uB2oO7Ae1OsRoDNvjyvMVmJ1uO3fWMoiitNqMhqsNBOkcY0XNu0F6iXZSeCRlxiuoKFZq7LeJfHwldEaYs+3y0ntY98tXyGvS7A0niFVxbvgF2SCAHm5Oy9pTFj+v8rgul2/nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785689624; c=relaxed/simple;
	bh=E+7MzW7ymcOmm2fAOpewcVRXAlWP28GQ8bwE/xkarAE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TBqFQlFd8b+NTdjZquB9A/7cv7tzmio4Lft8utz1UCBNQhO1ly98eYCRMva/D1L89QdmehyM2UD9YaVJiuJxuR/IDlekQ4pkPs0kSrE27O4ktMWuAuVVrHrPVXXdZcHTLlWKfFr2HVLHGiWp3DnRAr2IXtHN5QBSAtCmZjE8ccI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=lsnrTEqo; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="lsnrTEqo"
Received: from pps.filterd (m0167071.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672GfWpK3923228
	for <linux-fsdevel@vger.kernel.org>; Sun, 2 Aug 2026 12:53:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=YgZD
	12vF5o4SjGPupBE5NOIO7mg5JBXcQDcfIckANSI=; b=lsnrTEqo2LT6TEG7vP9k
	kxCnydT7i+KLPh3FM6khNDUcEeh7r3bpmjw4ho9//jQfGfwp6l4lpPAGmI2+/TLG
	gmpB6U/NZJNclhxo/IUGUl+WvenUkYtiYHIuBHI0Hp+E1lyqCa2V4n/S83pOczq4
	sjDiT4+xNLyn231+Gw3p+g2UC21cwg/k+RqhZEIY9L2NP99I4P6rfUH2rbwtjDR3
	wMeYR6qiBnRcnBRpPdBRGimZHPeEZLHfOL7V0ZhfqV3ggSNQiXi9Bynso4c8VuhW
	v7lwlMkbpF0w4g7sxcbaukGlhvOHCbKXU6wbun8NU3jkGMd6KZN6oYWqP6Nv8/K9
	yQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4fsdrgneqk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Sun, 02 Aug 2026 12:53:42 -0400 (EDT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5276aa86d00so27074931cf.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Aug 2026 09:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785689621; x=1786294421;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YgZD12vF5o4SjGPupBE5NOIO7mg5JBXcQDcfIckANSI=;
        b=B6E9qemD+VCeaVhy/HXJ0A3W8WBN4/J0Y3j0CbPSDqPH2sG9X6R/KZPreTM32V1y9Y
         jBY2Ewq2d8VmbbIyfbII8uX99bmQ1YXJIvIP6q0398zeiYXG3pEfllD1xbEk/Z4sVbk4
         jlS/agHRDk7SM4BIy1Pe13vbXou45QAFvcsBkqP7EXtGbWiJcO/zVBInurzwqQ6gfHBR
         9uie1Fl1BBRENaY4l7Wa8y4euSbmluLtq1vvXBXKFKGVvUp1hchgfrBg0o16OpO9V+P2
         TzehQs6y/DOEhf2cga2x8dt+W8NnxNmdHy2wtD4qHetNNs+nALuGSwMfVhdxhnAAJb5k
         4v2w==
X-Forwarded-Encrypted: i=1; AHgh+Ro+cd4o/rX1Fe8t8gRCz1RckxnRRNSXJot8c8NzKsE+IpgxJdbB+YS2+DsJigD1L3/VVWj2lztDRvNFSHNn@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4NDCAXDOQBOoE3Y3od5w7wHi+hiXQQb7VVBcvL9KpBF40I0s5
	vanlldfMGZDKbfTCGej6d8Dag7KPfNhRqibTKgJwkD16K8ikrEo3ajzsJCHUSDTczmK4tUj4KAv
	S/GMbONYvE55IQT6D7v+4CihViB2aTuNE9VEEu+IisCZTDktLzScTgeh501QbW/8=
X-Gm-Gg: AR+sD12upTzf2yZ/1rK2JtkgIeYKuOjcM3IP9qBcRvctbceGtadGo9mElNWkra3aexv
	tMCKZXGezUzwwM6K9cZoqI9hA9vkmaCuxDUceAnYs1WpeulYjt5nKWRgtdOTSxnLB8e12ZeauTY
	t/YZMCJnOVAQ29pSsSKbjXywh2Inx3pTuJyRPvoJHiY9yi08vTU8/c5ef43qDTf4/FGZqOEtqm7
	t5TREwaUMDFAzBtEf2Y60Vus/m8VClCAGAQvfN4c1IjPQFf38S6kyt/PloTEr5ncNhmvaj3jqX/
	7vbxQyLBbaPP+JFycFjYLlgGDs5UTpiiErDmh3HksgBrenoYPGYGhK0ycSlcPKig/SOf6fL1SpT
	cRMB7VXbMd6bFEU+Ep7Gruv6udRIxqSf8L3YydJcAY0aiLBia2Yo=
X-Received: by 2002:a05:622a:1247:b0:51c:844f:28da with SMTP id d75a77b69052e-52b56673bf2mr163448531cf.5.1785689621472;
        Sun, 02 Aug 2026 09:53:41 -0700 (PDT)
X-Received: by 2002:a05:622a:1247:b0:51c:844f:28da with SMTP id d75a77b69052e-52b56673bf2mr163448101cf.5.1785689620984;
        Sun, 02 Aug 2026 09:53:40 -0700 (PDT)
Received: from [127.0.1.1] (CBL217-132-158-98.bb.netvision.net.il. [217.132.158.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a0c8bsm24064574f8f.34.2026.08.02.09.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 09:53:40 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Sun, 02 Aug 2026 12:50:05 -0400
Subject: [PATCH 4/4] ceph: remove page_snap_context()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-remove-wait-on-page-writeback-v1-4-6c35d6b3ad36@columbia.edu>
References: <20260802-remove-wait-on-page-writeback-v1-0-6c35d6b3ad36@columbia.edu>
In-Reply-To: <20260802-remove-wait-on-page-writeback-v1-0-6c35d6b3ad36@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785689606; l=1958;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=E+7MzW7ymcOmm2fAOpewcVRXAlWP28GQ8bwE/xkarAE=;
 b=CGrtCZzmymnOg0P1AnYYYJJhAxmkHbTbgJSoW9X6pUAWQ24AQTP1LclOZq1dzmzHdLFh9Byxb
 fftOg/3aKaoDeb0vSDcCi66HsuVSw4joSRlXCjwpzGhun32idb8IvRp
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: 636dcWImB6azRuNF3g9raItVs3AuxpQa
X-Authority-Analysis: v=2.4 cv=WMxPmHsR c=1 sm=1 tr=0 ts=6a6f7616 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=C4zMR0+CEq2lM/mtmjScOA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=79PYxaXUQd1wl-QFWJnA:22
 a=7ovMhKOaTh8UDYQOW-cA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDE1MyBTYWx0ZWRfX+e2FmpIkwMBk
 nbuo8VxKrYS08GpTKVCtRt+HQfBI6vFEzNvFGG+3ZVezEKa/Wlw+g48KNpUD/iS8bm34aML5Gs4
 eM1myiKIdoliNOXJ/MCtUFd93tKNGw91xxigcaR1x5Y6COX+dH48UTfIkt7aqluRA3TDoxzp4vI
 dhEjCl8NMFKfhhOQ75PUilDJz7ZCkwlIFWJ2Dj7ZooxTvGYDCbq9VBCmrOv1zfwKBlW7GMSfMiw
 ZPORkV89TVsimK/CkWIfcBM0efbMSCgj6CMXy6ep6BcKMVCRcbEZVb6ErHaq0V9BD5uyZTcw6qV
 OJVbGDpbu2M+WpTXW2wSN6OiK6cZILWgjmUWRrqXYAXlFHNpDH1Qnkb363AEFWyqljUkd9PWud3
 hb+e+tE7p25YgIOkhjNFpNV/rcCxWE3gBNEuowZbezMS0EkdinXKNaCineOMD4nH9cfohvMgP1Y
 W31ClYIdi57xHxjGeLQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDE1MyBTYWx0ZWRfX+k/egMb3TBJa
 6jtzMyHVw9n4xI/3v9exwXL1RGRMsXTYWOjPmKwc4P6HM9qA9ykKQFQ7YRYBjPskc1lrQdp/qOC
 1VAV1qWWS4ntQo3eVJoJMUZrdcddLMIoB0/C3nV2DEsbte4Zkcj/
X-Proofpoint-ORIG-GUID: 636dcWImB6azRuNF3g9raItVs3AuxpQa
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11863
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=10 malwarescore=0 adultscore=0
 lowpriorityscore=10 clxscore=1015 bulkscore=10 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608020153

Convert the final caller in get_writepages_data_length() to use a folio
and ceph_folio_snap_context(), then remove page_snap_context().

This drops the last open-coded use of page->private in ceph's writeback
path.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/addr.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index f4aaf9a5f196..702cf5fc1eab 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -29,9 +29,9 @@
  *
  * There are a few funny things going on here.
  *
- * The page->private field is used to reference a struct
- * ceph_snap_context for _every_ dirty page.  This indicates which
- * snapshot the page was logically dirtied in, and thus which snap
+ * The folio->private field is used to reference a struct
+ * ceph_snap_context for _every_ dirty folio.  This indicates which
+ * snapshot the folio was logically dirtied in, and thus which snap
  * context needs to be associated with the osd write during writeback.
  *
  * Similarly, struct ceph_inode_info maintains a set of counters to
@@ -68,13 +68,6 @@
 static int ceph_netfs_check_write_begin(struct file *file, loff_t pos, unsigned int len,
 					struct folio **foliop, void **_fsdata);
 
-static inline struct ceph_snap_context *page_snap_context(struct page *page)
-{
-	if (PagePrivate(page))
-		return (void *)page->private;
-	return NULL;
-}
-
 static inline struct ceph_snap_context *ceph_folio_snap_context(struct folio *folio)
 {
 	if (folio_test_private(folio))
@@ -697,7 +690,7 @@ static u64 get_writepages_data_length(struct inode *inode,
 	u64 end = i_size_read(inode);
 	u64 ret;
 
-	snapc = page_snap_context(ceph_fscrypt_pagecache_page(page));
+	snapc = ceph_folio_snap_context(page_folio(ceph_fscrypt_pagecache_page(page)));
 	if (snapc != ci->i_head_snapc) {
 		bool found = false;
 		spin_lock(&ci->i_ceph_lock);

-- 
2.39.5

