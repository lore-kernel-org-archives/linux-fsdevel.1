Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCD43F86FB
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 14:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371697; cv=none; b=hC1qADI7u2D6QAVCPeMc7ebeSwWhZlVdingX3URuxYrvd47KOYVK6OQgynZHGMwsB0aU1W7w3jB8/NkdmOGBkel0i+bZyhdQXO6GcH2IMyeaZ8Pj6p++OyT4QhGKYTKuKzr9StAanLmD8yEbVR7gdR/feOl01mrfRYppOu7c0RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371697; c=relaxed/simple;
	bh=kLEOqEnFcXW+rNVmQEljA3h0yllVd5ca9DQ3khlYlWQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AsS4lTY2B1hsY1iMb6u/4lXtyByVpgzUdtWxtBR5AZmCxdqYXUdhlPCmelXHuMbghs/5R0VWcTMpJa2lQsRE04a9NP3TLPYnloy9f/OMWipmnJey7HJ6H7T4dj5/jIYYOpSwWCSJjAsXpMy9+W6+CdqJAAnZNduHZAJQvEn+/F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=QE29lpQB; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="QE29lpQB"
Received: from pps.filterd (m0167069.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67ACbMTR3845073
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 10:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=9wYX
	/ZIYKVfQPG27uMx8tOqEdGsdSAkMZMuyFrH1L8I=; b=QE29lpQB/ULYlNngi21a
	/hTWjHq6AZmD1jtPW4qIsTEUVkjzLRzyD2DepfK0JzhyI7UnmEptrsJ2EM1Jiatp
	930l2Adj9Cl8YlIXCq8v70vsP4kPoYlVYrCjZhD7o9N/Hg5Hawttp8xS1pxz5yyA
	tU0Hfq5fWnNyb2QXDXQW//vSN9M515bDPdIKyXQ67MfGCz63VTGRJlhEumOFuhXq
	mveUu3P3jcaaBXDl9JZensPr9NK+G+tKVBC8MLzutth5TpqpZLVlicpuw35fn2Ww
	fdUiRmfKanF+tCI1U1Da8edHrJKxx4LyRA4ArOgQi3zLi1t5TGtiFFWlnjHOlt9B
	Gw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4fxyb9bku6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 10:21:23 -0400 (EDT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5174a23afcbso23008011cf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 07:21:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786371682; x=1786976482;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9wYX/ZIYKVfQPG27uMx8tOqEdGsdSAkMZMuyFrH1L8I=;
        b=emgB+z+k+x3sS8mhbOCfinqskPciGRxnriQoPZJpuTlHMs4rXeBHJ5aQhTntyxnHXM
         UqrkZl131V1DxBiqxFJSbm1ciw78gNspIAu8N155hKVbd1bSws3HKQEba61sJwNsBnO5
         qaI7C3O5MJiVyrut9r1OVhBu02p9RksH962f8e21t5zn1P3YsXtWFuXLXVnsi1soOvwl
         hrn9ZGh4EBeJO6dMcwZHI9djYPzfgBzz/o2YVNH44fLBhN8DOWB/kjZax3/bZPaEwBBl
         0UFrU5LjD6K3c5F2SlIS/FI4gcM87QW6Own9PToFSZq1/GJn49qjOOlBPnLLHiTFppdS
         9Liw==
X-Forwarded-Encrypted: i=1; AHgh+RqPOkycGpfKHqcgFYBD/49OGxkhd62XC7wQjfADAjzDCOUKNa+oAarmHENxKpveODLbI4Grou98cBGG4cpQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzthvLCqb6cGJXyf8T4+6X41Xpy92TBY4rKQr8c+CjcWcZQehR3
	RGuYEnwYlYLVVl8yw6G7Nzs7kjtLYVkU6Go7Q3D2AQpsDc4XhZTdDeDqCOMaxUi0SH7u3o0dJNo
	uqI/96Icz+rEiAYd9cyR2MBiym6YJV1uZXvjJn18BYSogrsCAYgX+8Y1N6jlKfgQ=
X-Gm-Gg: AR+sD13I2wG6LBME9As4uXkD35IYh3mf4ZGAwIZthRPMukjTED9b812xw9T23TxH91V
	vECdbxIRO4e5gRX/JIv9s+kG+3ah4XteBI8Kr6/k+9cMwAuPaYvhEv2DmakkTLTEuBLmTMbkNfH
	2Yr3Etkzz0AtDlA2QZE1Vhftepymsfx0FH8zHgISP/Y0ynPFfNagm76zt5WLwCPK+NZK2Jh3pNO
	cGb+NDgElggAFtxlaCWruGl7evAagqoC8i2gO39mInYjyaKEvKv8tgn0xmd3HZ+wXFA+A863/BM
	sAooQhWALfRmG11I4osnM5MROkR1Ldgc2/IlQ1C8SbROh09s+xPeuS75cLmmyxQmnsNyROJU+ra
	EiX6D/Rdu
X-Received: by 2002:a05:622a:58c8:b0:52c:dffc:4645 with SMTP id d75a77b69052e-52d18e1a66amr253262311cf.7.1786371681875;
        Mon, 10 Aug 2026 07:21:21 -0700 (PDT)
X-Received: by 2002:a05:622a:58c8:b0:52c:dffc:4645 with SMTP id d75a77b69052e-52d18e1a66amr253261341cf.7.1786371681258;
        Mon, 10 Aug 2026 07:21:21 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.77.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002145589sm37383983f8f.1.2026.08.10.07.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 07:21:20 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 10 Aug 2026 10:20:18 -0400
Subject: [PATCH v3 07/12] ceph: convert ceph_submit_write() to folios
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-remove-wait-on-page-writeback-v3-7-dd7531704f26@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786371655; l=4661;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=kLEOqEnFcXW+rNVmQEljA3h0yllVd5ca9DQ3khlYlWQ=;
 b=joNh9X5mUvffrlxkKTmBkr0iWmzW7a5lLjSbuFRThbu6aArrCyt6TGzZNH/GWLmWekE58e/D9
 Y/+qkhPxIWUAoYE6Mj5KUz7ZnB0M9pwSraQitcVWKcL1lN5xiSjMjtw
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=QKxYgALL c=1 sm=1 tr=0 ts=6a79de63 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=zHmcO6jMd5r4EZ4U0P0LQg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=JR4YdQiviy7OQf72WyZ1:22
 a=RfODlEta0-z8xtihUo8A:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: IiSL1bTXQIYATly5JTe-4yxeeGb1hb4M
X-Proofpoint-ORIG-GUID: IiSL1bTXQIYATly5JTe-4yxeeGb1hb4M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfX3s6Jl12iOf4q
 ib3AsbtUNat1ETBz00fyJpum8Is1V/L/xO1mTdbAIoU0pUt54vXwVUo8qjLfyNE+moOJUMbVNNp
 2BxMgIImz1qgmZoFJDpsFwoQL+sU1ztOsigv5Zl3OOKGC9qZNgpF+9KyO7SOLHD2YPtpxBS1iyT
 NXRG1tLCgbhGgZeu/zdXFSqNxn8IR42IEe5HrxgCOULS0nJD81vK0stzA39R+00mapY/5eBjbzl
 MRjjPSjZ3RqfDyUX9mV83vRHTiQXqVfCGphNisEzV3S7uMoYe3l6AvVM0nXWjU+5AL89uJaM36n
 AngJQqq0PVZIMVlKHSWP0zXxqIv8E1RfpO3+e9sqjlhyBKYbdeSMgHBZ7YCejZ9+dSfFgIy5z3o
 QD9c4xdtr0oWXQiY+e3Rvi2XBvyb7Zi/1nbp6hiwHleLraO4N2Y9lU+3Yl9NhQD9mCeL0oA272G
 +GGozskUxpSm8Fm5reA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfXzdhkwQUHOg5T
 5djSa1OBjz7xXZigePdOKWm6xQiWu7SvbAvrYUQye6c9TGGis+rzGPGJiRlRP1KE7e4FM0xW8jG
 0ck3troiOQcqc5cWWO3oW9EzqgtlHMosqYpFcHPvzJc1uliHRvQH
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11870
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=10
 clxscore=1015 impostorscore=10 adultscore=0 suspectscore=0 phishscore=0
 bulkscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100123

Convert the request assembly loop and error path in ceph_submit_write()
to folios. This drops ceph's uses of the set_page_writeback(),
redirty_page_for_writepage(), and unlock_page() compatibility wrappers
in the writeback submission path.

Add ceph_folio_start_fscache(), a folio counterpart of
ceph_set_page_fscache(). The remaining caller of the latter in
write_folio_nounlock() will be converted separately.

In total, this removes eight calls to compound_head() hidden in the
page-based APIs, while adding four explicit ones via page_folio().

Note that get_writepages_data_length() must still be passed the
possibly-bounce folio, not the unwrapped pagecache folio, as it checks
fscrypt_is_bounce_folio() to round encrypted lengths up to the fscrypt
block size.

No functional change.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/addr.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 28f0b16da2b0..a3324da08123 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -553,6 +553,11 @@ const struct netfs_request_ops ceph_netfs_ops = {
 };
 
 #ifdef CONFIG_CEPH_FSCACHE
+static void ceph_folio_start_fscache(struct folio *folio)
+{
+	folio_start_private_2(folio); /* [DEPRECATED] */
+}
+
 static void ceph_set_page_fscache(struct page *page)
 {
 	folio_start_private_2(page_folio(page)); /* [DEPRECATED] */
@@ -580,6 +585,10 @@ static void ceph_fscache_write_to_cache(struct inode *inode, u64 off, u64 len, b
 			       ceph_fscache_write_terminated, inode, true, caching);
 }
 #else
+static inline void ceph_folio_start_fscache(struct folio *folio)
+{
+}
+
 static inline void ceph_set_page_fscache(struct page *page)
 {
 }
@@ -1448,14 +1457,14 @@ int ceph_submit_write(struct address_space *mapping,
 	struct ceph_client *cl = fsc->client;
 	struct ceph_vino vino = ceph_vino(inode);
 	struct ceph_osd_request *req = NULL;
-	struct page *page = NULL;
+	struct folio *folio = NULL;
 	bool caching = ceph_is_cache_enabled(inode);
 	u64 offset;
 	u64 len;
 	unsigned i;
 
 new_request:
-	offset = ceph_fscrypt_page_offset(ceph_wbc->pages[0]);
+	offset = ceph_fscrypt_folio_offset(page_folio(ceph_wbc->pages[0]));
 	len = ceph_wbc->wsize;
 
 	req = ceph_osdc_new_request(&fsc->client->osdc,
@@ -1479,21 +1488,21 @@ int ceph_submit_write(struct address_space *mapping,
 		BUG_ON(IS_ERR(req));
 	}
 
-	page = ceph_wbc->pages[ceph_wbc->locked_pages - 1];
-	BUG_ON(len < ceph_fscrypt_page_offset(page) + thp_size(page) - offset);
+	folio = page_folio(ceph_wbc->pages[ceph_wbc->locked_pages - 1]);
+	BUG_ON(len < ceph_fscrypt_folio_offset(folio) + folio_size(folio) - offset);
 
 	if (!ceph_inc_osd_stopping_blocker(fsc->mdsc)) {
 		for (i = 0; i < ceph_wbc->locked_pages; i++) {
 			fscrypt_finalize_bounce_page(&ceph_wbc->pages[i]);
-			page = ceph_wbc->pages[i];
+			folio = page_folio(ceph_wbc->pages[i]);
 
 			if (atomic_long_dec_return(&fsc->writeback_count) <
 			    CONGESTION_OFF_THRESH(fsc->mount_options->congestion_kb))
 				fsc->write_congested = false;
 
-			redirty_page_for_writepage(wbc, page);
-			unlock_page(page);
-			put_page(page);
+			folio_redirty_for_writepage(wbc, folio);
+			folio_unlock(folio);
+			folio_put(folio);
 		}
 
 		if (ceph_wbc->from_pool) {
@@ -1519,8 +1528,8 @@ int ceph_submit_write(struct address_space *mapping,
 	for (i = 0; i < ceph_wbc->locked_pages; i++) {
 		u64 cur_offset;
 
-		page = ceph_fscrypt_pagecache_page(ceph_wbc->pages[i]);
-		cur_offset = page_offset(page);
+		folio = ceph_fscrypt_pagecache_folio(page_folio(ceph_wbc->pages[i]));
+		cur_offset = folio_pos(folio);
 
 		/*
 		 * Discontinuity in page range? Ceph can handle that by just passing
@@ -1553,12 +1562,12 @@ int ceph_submit_write(struct address_space *mapping,
 			ceph_wbc->op_idx++;
 		}
 
-		set_page_writeback(page);
+		folio_start_writeback(folio);
 
 		if (caching)
-			ceph_set_page_fscache(page);
+			ceph_folio_start_fscache(folio);
 
-		len += thp_size(page);
+		len += folio_size(folio);
 	}
 
 	ceph_fscache_write_to_cache(inode, offset, len, caching);
@@ -1569,7 +1578,7 @@ int ceph_submit_write(struct address_space *mapping,
 		/* writepages_finish() clears writeback pages
 		 * according to the data length, so make sure
 		 * data length covers all locked pages */
-		u64 min_len = len + 1 - thp_size(page);
+		u64 min_len = len + 1 - folio_size(folio);
 		len = get_writepages_data_length(inode,
 						 page_folio(ceph_wbc->pages[i - 1]),
 						 offset);

-- 
2.39.5

