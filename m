Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6F5495534
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 18:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869560; cv=none; b=Lb3lYa+lJtCgDLKOdJWdSqEVVNkaFgIorsuXg4xbnVhqPiDVKZn5z/OKaGKP6UAgrvkYRql2OJzD4/v8aiF7Q/si/k8PsLfknnE8/mrKgM3Wa9zjgyxsnkwdNBr1upMHze7QP9azqfjypdpKhCP0GNzaQ7w55t2eLPxz0J7tomI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869560; c=relaxed/simple;
	bh=ZLn4GmbBBs4DJzpxg5iY9HTTJ6Xur2Gxm1ww+3ec0uo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UmlrI+tx5w5tlueLEZ7ve3vxa08jMthm1UVLp8zvJeb5SReWz38NQxnIey0m1TN0zRjy+n1I6ER6OkwmNYcCd8FrYirjawFPcBkUj2ZGICriKzdSxNJkBd2MCH82kgB3S4X8dHX9INLUt//GuGinHZU2yJvyJdP5Azwjf3mdeeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=orP4G7rp; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="orP4G7rp"
Received: from pps.filterd (m0167075.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674IYGVH2119295
	for <linux-fsdevel@vger.kernel.org>; Tue, 4 Aug 2026 14:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=Hrfn
	ottRt8RY51efcxtpgPFZmS0xvtqTx86D5p3Srj4=; b=orP4G7rpYSxdzMQRVI2s
	CNyB6CtqRdTN4aTJuVK04d5E17G1o69HkG4AzD6u25O7ICHVAZE1GAnPopsdyqlz
	iyEgK1W+d4mQrqW6wQPKmYyhwsDq8xaQ0BCY9MVXLQ7qP1kit5mu1YDzDB/zTZ55
	l4UTwwBxgv4xVduEYwJjWpcOTKOYEuVX8njCXBYWgkdbMzosk2SooZRuZ4Aui8Ff
	rRtRKXDjvsU3TSD/ENPpuNcIuTp/ZRmDHxxos47Q6wzAPrNS5PyC3txKJlhy/i9W
	HBzh8TqfoOMSESAk7aRsw4AZ5ZFn+Hw7ybz19RafXxccwpo4KILa6kXk3ys1Q2wT
	gQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4fugvdjp88-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2026 14:52:36 -0400 (EDT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c1c7f135bso1950591cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2026 11:52:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785869556; x=1786474356;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HrfnottRt8RY51efcxtpgPFZmS0xvtqTx86D5p3Srj4=;
        b=TJzcHZrb92UZn07TblC5luiBgEFKLE9W3TmEI/mFXKOg/IErDzFjpg5xsjG/4XP27F
         ijqa76I+t1oT06XyOKabzhmLeQ5gKg/fQ5tqIHkns/X1Uno+is3n9zeqcUWPj8EJ3yjp
         NfRL/ODKgM9N8pe6okGBLTm+kUhOPidtvGIKytK2UdzCE5jnJip4XbcsNPqWT49Uv+Ch
         KJjcNf0JFpMwC9zgIk5VSjLhVrBfgO2ywaqV0f3rfE1N39waT856tI0NgqHTtG1KGGyy
         wRw/BErWvbjQPgF28iFi8Lrq0WLqRTIrgZH5OBJnjpL6b02dDmucol29fVyDXsx6PtZH
         ydtg==
X-Forwarded-Encrypted: i=1; AHgh+RqfqEoGpaioHUy3d5JHxZahia0pq97QM0AUthISlxClBL9uHCjXmyZiaB8qj0ULMbjtBFp41BJf7w+rspzU@vger.kernel.org
X-Gm-Message-State: AOJu0YxqtOFLAsprg8BfB1UgfGT6TRTRur4JZBiJadCjJChZUtpR5Hra
	r2x6e2zurLYZLX3vNjNRC75ICHrbKBf1Yfhz6FRsFCDjUGab70HRwKXok1pzE8igvlViT853516
	1WkxfX0hbY245/GYMc+D7ApCH6vgVLoSsAFLU3l0nl48gRlEs3XWIcZnR+5/AY4A=
X-Gm-Gg: AR+sD119zgnNJbIZ8pSk9DvOvCnYyUC9nWL4ZVPGm6c6IrivAg1yV2IB8mnGiV8H6H+
	flWfFuXdtakSCuMt3K1BCagW0ORS/5dx3hQ1eZVTGfxgAYiVqVXO+62ds95k3aH1OtjZRkO00Ew
	37XXlWyNjiVlBMjjegw0FNZ5RGgMz9uDF16IQMOfAqt8OyAz71SOEJFpzHFDdjOYscwxmk1qkUf
	bw4bXBO7z7FZXLbdSrgbw59VwveaWDEVTKsu79MriB/gC/sXFK18ZHOaffa+OYUhCka5TMGMMyt
	7XMtF+Mu7669ZRaGn1BLz6iQfnicqFHPrm7oFUbvD9g+TOMWGvGO8YY92t6H0If6Ek4drLAWUAe
	Ehun3RSct
X-Received: by 2002:a05:622a:4d89:b0:51c:22c5:daf5 with SMTP id d75a77b69052e-52ce62c6cf6mr12809171cf.38.1785869556090;
        Tue, 04 Aug 2026 11:52:36 -0700 (PDT)
X-Received: by 2002:a05:622a:4d89:b0:51c:22c5:daf5 with SMTP id d75a77b69052e-52ce62c6cf6mr12808671cf.38.1785869555591;
        Tue, 04 Aug 2026 11:52:35 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.77.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec232d7fsm2313275f8f.20.2026.08.04.11.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 11:52:34 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 04 Aug 2026 14:52:12 -0400
Subject: [PATCH v2 04/10] ceph: convert get_writepages_data_length() to
 folios
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-remove-wait-on-page-writeback-v2-4-81f0ab065284@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785869541; l=4666;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=ZLn4GmbBBs4DJzpxg5iY9HTTJ6Xur2Gxm1ww+3ec0uo=;
 b=oth0Nf14fRObazwrdx6pe7EJlKObc8Y5tWmZKRvFAWjLufDheiwH1ZkewJyJhwIs0DUt/Y4AV
 KJKOHQot2zAAS1u1iOv6yf/vIMfhsOm9h8XHLJdtoZigFowDlJQvo/J
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE1MiBTYWx0ZWRfX1ibfBMlUOx9e
 4P+5xK0TH69wlbinvoQmIUa76cptDZzD4JZI3/OvqeypQnOD3q8EkiVdv4MdwXhQ48y6oRDZVgz
 xM+8uBK+B3VUoCbqaXiqA22VccAD460ZozgJkrWGnNW4VXa+75FV
X-Authority-Analysis: v=2.4 cv=G5Ys1dk5 c=1 sm=1 tr=0 ts=6a7234f4 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=j1J1DEHOHTVaJYOjuVnKiw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=HpS3TJQ9O3Ob1ozEcmik:22
 a=4S3DF5rXG3rfafK4-1MA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: 1RUdndO8A18UCy_qWmWCM3LE45teq9WV
X-Proofpoint-GUID: 1RUdndO8A18UCy_qWmWCM3LE45teq9WV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE1MiBTYWx0ZWRfXyhxMEb/xhdkt
 jLR6n0Oa78ooXYf2j1itS/Zi0ja3wRNjm6ZUrDhuW8pYdaSMIodP9krlyjQlCfsI1x3s2MkyubV
 IUtphd1pe4QGQArNXreB74Df/Oh1XiSYCFfXGhnyTs3MIAv1ThdvGRHQxBLr8jVRFe3oCFlbjH6
 WeCEuMt2vClcAeN5X66MvlFjOmSjqHt0s0LO1/VwVRE7avy2oHaW1r3lYtEinU+ctRz4Q9V60RI
 oPc3NI838WgtH3VCgGLtUi/rAM4yILwY2AHegBPmpqoPwUITmJZRbznw1QTnVOT1Nee/z0ApD9b
 k6/Uko/bwA+LfLV0EmeXBJ4btDyoGq7kkFu7J8LAn5e7zkIFfHeRsKvcGNh+7hkM+mzZmHr7C9v
 X2vUojMnnrM1oOCfkKl8Pv0vqIrwoQa2IZgrrkmszxjoQAk1zc9bi5ltyQkqEXlbCCI/crX1r0m
 ikFHAe7DeHmxkm13msA==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11865
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0
 spamscore=0 lowpriorityscore=10 bulkscore=10 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040152

Introduce ceph_fscrypt_pagecache_folio() and ceph_fscrypt_folio_offset(),
folio equivalents of ceph_fscrypt_pagecache_page() and
ceph_fscrypt_page_offset(), and use them to convert
get_writepages_data_length() to folios.

This removes the last caller of page_snap_context(), so remove it as
well. This also removes a use of page->private and a call to
fscrypt_is_bounce_page().

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/addr.c   | 25 +++++++++----------------
 fs/ceph/crypto.h | 15 +++++++++++++++
 2 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 967243f425f2..c81e9da42df9 100644
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
 static inline
 struct ceph_snap_context *ceph_folio_snap_context(const struct folio *folio)
 {
@@ -692,7 +685,7 @@ get_oldest_context(struct inode *inode, struct ceph_writeback_ctl *ctl,
 }
 
 static u64 get_writepages_data_length(struct inode *inode,
-				      struct page *page, u64 start)
+				      struct folio *folio, u64 start)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_snap_context *snapc;
@@ -700,7 +693,7 @@ static u64 get_writepages_data_length(struct inode *inode,
 	u64 end = i_size_read(inode);
 	u64 ret;
 
-	snapc = page_snap_context(ceph_fscrypt_pagecache_page(page));
+	snapc = ceph_folio_snap_context(ceph_fscrypt_pagecache_folio(folio));
 	if (snapc != ci->i_head_snapc) {
 		bool found = false;
 		spin_lock(&ci->i_ceph_lock);
@@ -715,10 +708,10 @@ static u64 get_writepages_data_length(struct inode *inode,
 		spin_unlock(&ci->i_ceph_lock);
 		WARN_ON(!found);
 	}
-	if (end > ceph_fscrypt_page_offset(page) + thp_size(page))
-		end = ceph_fscrypt_page_offset(page) + thp_size(page);
+	if (end > ceph_fscrypt_folio_offset(folio) + folio_size(folio))
+		end = ceph_fscrypt_folio_offset(folio) + folio_size(folio);
 	ret = end > start ? end - start : 0;
-	if (ret && fscrypt_is_bounce_page(page))
+	if (ret && fscrypt_is_bounce_folio(folio))
 		ret = round_up(ret, CEPH_FSCRYPT_BLOCK_SIZE);
 	return ret;
 }
@@ -1565,7 +1558,7 @@ int ceph_submit_write(struct address_space *mapping,
 		 * data length covers all locked pages */
 		u64 min_len = len + 1 - thp_size(page);
 		len = get_writepages_data_length(inode,
-						 ceph_wbc->pages[i - 1],
+						 page_folio(ceph_wbc->pages[i - 1]),
 						 offset);
 		len = max(len, min_len);
 	}
diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
index 79cb563fd887..948c8b5dca06 100644
--- a/fs/ceph/crypto.h
+++ b/fs/ceph/crypto.h
@@ -162,6 +162,11 @@ static inline struct page *ceph_fscrypt_pagecache_page(struct page *page)
 	return fscrypt_is_bounce_page(page) ? fscrypt_pagecache_page(page) : page;
 }
 
+static inline struct folio *ceph_fscrypt_pagecache_folio(struct folio *folio)
+{
+	return fscrypt_is_bounce_folio(folio) ? fscrypt_pagecache_folio(folio) : folio;
+}
+
 #else /* CONFIG_FS_ENCRYPTION */
 
 static inline void ceph_fscrypt_set_ops(struct super_block *sb)
@@ -262,6 +267,11 @@ static inline struct page *ceph_fscrypt_pagecache_page(struct page *page)
 {
 	return page;
 }
+
+static inline struct folio *ceph_fscrypt_pagecache_folio(struct folio *folio)
+{
+	return folio;
+}
 #endif /* CONFIG_FS_ENCRYPTION */
 
 static inline loff_t ceph_fscrypt_page_offset(struct page *page)
@@ -269,4 +279,9 @@ static inline loff_t ceph_fscrypt_page_offset(struct page *page)
 	return page_offset(ceph_fscrypt_pagecache_page(page));
 }
 
+static inline loff_t ceph_fscrypt_folio_offset(struct folio *folio)
+{
+	return folio_pos(ceph_fscrypt_pagecache_folio(folio));
+}
+
 #endif /* _CEPH_CRYPTO_H */

-- 
2.39.5

