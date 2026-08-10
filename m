Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499AC3F6C3E
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 14:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371696; cv=none; b=iVzF4nXEdPyCzxeo1JSCeFgqZY77dsEYqk8o8H7b+yjRZlK+4SRx02eVsbpV9X3yjxTjUsTq2vQ763+6CcuU2uSSUSGShF5yzEfugJbO+Eez+pGduu1s/gt2uvkMFwbc9VDyA3yH2sE86n2uEAzuvo558jVMl088OvWfyieu+EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371696; c=relaxed/simple;
	bh=RB6EAm4khz80XnHvU3JzY5JD7tO097AT2T3aOYQsk5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rbslm+4dxudcWxCbg1cB+KMmK2++JuZA2g59yI3drdBLNISqdBN2xLxgvViEt8V9MrERyQ/46MNS+g8MsYp81aRPZe9ItsXFkC8Cj8Gyywe7eCXjJp63WzhGGqnfaqk57cCKlnQG2FQkF2a3DXoW1Pe50uOhf8m4fpgzpbNaD5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=V7msvAJD; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="V7msvAJD"
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67ACaRZE3011165
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 10:21:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=IjHt
	At6xPrS0rFFojV7YCtn1FnT734JGQcpGFzyUn3s=; b=V7msvAJDQO6Cp0c3wmcU
	OsBbKNzMS8p4Jxu8pTCQLs8bvpvt54iQ/MKjfLvFb3+Hia7gYfRahFqsF7i9LqTy
	uaddPdJTZfQZe16KitfFHl3vdC7QN3+WXSuoCYd0Ot3lHNw/b44jSYDKTmKeVGzy
	6ogFrjvZFadVt2A/WLbYx3Xjipg2BQPOTgI/b/dQhUaPy7XjFG521zhpHHd88XNv
	xkV8RvV7liSGrNkJeCC3qM57WUq6DeNKhA/z3tlA5zYcn2za1oDF61c/MvzLHJPg
	I2L6sfzQo2n7M2ms+DxO1sw2KZfCyurkO2Rm5l+viziasFL20v/cTBUi7V+nwgvD
	EA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4fy0rkuddt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 10:21:19 -0400 (EDT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-529ae8e96e8so17536581cf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 07:21:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786371679; x=1786976479;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IjHtAt6xPrS0rFFojV7YCtn1FnT734JGQcpGFzyUn3s=;
        b=VOmFYoP+rHZs+SllKGVNf5d/RXGv8bStEkaNGxeNDfiRiQw/pkUfMmaubqCT/SbdhO
         lt5uHdZzqJLz+u3//NizZQkk3CU2Azu23368kppAHnwvos3k1NjqcLVbJGoF3Yygi9lh
         7O4qg9y89kNqj7DgnOpVtlczj5qecKNqFtj4tIDlgzJ/Y7HHexXpJGUTLnJdKD8SrOeB
         VS7vw/jPcYlRgXbkSiaAlm2+9vXob54ewWBXqZDFFjYOO/T5jNn7sanYbOxm3tzwBnxS
         drLp0KUgbh6lQxCYjE8JdqiL/eYtztKvb9Rt4d03UiJ28FT8uEVialYENnk2fGRGEqRz
         vh+A==
X-Forwarded-Encrypted: i=1; AHgh+Ro9Yj+5bE2a+wMg4my67PPnkwrpTO2grkczihgds8F2YUom3j+sI3QrdMNwjiPdwQEytHoW5k7NxNOQHros@vger.kernel.org
X-Gm-Message-State: AOJu0YzIdfIzRBtDE8Tl3aQWyMd1HvhdyohIggZXaE/kHeOw7XP1x14z
	IjQUV+9xqnWOmax6e2HNOTGGZLtjASnu1DR3tvSpveGMHe+l12LlyBcHkG57W1hzaBtgKrssPJt
	AzfhDjPZdLcLyXWsFBPJhYBniT3ahzJb4PQU1IF3YithTXt/ZZAI0ehkVpIUrkD8=
X-Gm-Gg: AR+sD1055uhhCA80iNJOhFw4tcsYIXc/slfZkpmjLzxc++VSYSAg8KXsYFaEC+wauN7
	3ix3qbGSL6M/dsyq6bdcad2DebacSVMZznnuMoEgbmqjBxaFmakdYMqy5OZV+7DRZy3lfziEdFi
	SZ6S5WGEySsyWFTqAkiICeW5hjVZd/DR00C21tnWrb8pXycJ8ujU0TfnMV2TGM5EptaPWtUWJwR
	vTduDXXKSYQGdeFgcDqnVO86TcbRXf3eCNUpgCBw1NPNmWmVzxahkY4B8JdDlrhzdvQEEivNyd+
	9q8m+yrmPLIYTCmz5TO44CdLCeG6osMrVfnpUXpXDmnV8KXYrkQsr59aYFe4qStWkll/iuRsojB
	m6UJCnmoJ
X-Received: by 2002:ac8:6f0a:0:b0:528:320b:305e with SMTP id d75a77b69052e-52d4bc980b2mr25355051cf.35.1786371678758;
        Mon, 10 Aug 2026 07:21:18 -0700 (PDT)
X-Received: by 2002:ac8:6f0a:0:b0:528:320b:305e with SMTP id d75a77b69052e-52d4bc980b2mr25353871cf.35.1786371678214;
        Mon, 10 Aug 2026 07:21:18 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.77.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002145589sm37383983f8f.1.2026.08.10.07.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 07:21:17 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 10 Aug 2026 10:20:17 -0400
Subject: [PATCH v3 06/12] ceph: convert get_writepages_data_length() to
 folios
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-remove-wait-on-page-writeback-v3-6-dd7531704f26@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786371655; l=4666;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=RB6EAm4khz80XnHvU3JzY5JD7tO097AT2T3aOYQsk5Q=;
 b=2BYn9jC9xqnkpmGWEmWnzu3nuFMYF00OiM6zRyuG/a7lH6IXJCYQWgiT7LYjcZIK1HYQnpMw0
 TnXJAaYK7n5BTN+QpVQmimzFaXlk3oIPuNmUL7EPbH/Mzj24wYByM5G
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfX5sq/gijE2jPy
 NA/PtFcoLFuGFHZ+4y8YMX4Sa8+TzyXGzVs5ge2SALCM796xIh3i3KdKIXyF3u/3mvZjpRUKEhy
 3SoQVCyl8sgtS9ky/6YAuUN6lrNOxMVnDzQuBhPXwjrvO5gmU9yvNRpn7RMOg2Cucmw3/V2rbSs
 euzlIhegkgb3fUhHd+K0fSpJG2o2CaOVuCwp2YGZ00myYGM3tjqTsizMnaXMeJSJMextuyIHRcr
 cJfVmG34gxAhrz/hbPDPpX+DpRCXV0EpaEtzYUz9l92X9W3zD7vobr3i9P9ECSeGaQ8hjtw37bE
 vhYYO3D3BnkXQhQA96sMRguAp+OwzZPGIEbjzqpo+6Jpc3g8v3WgCVh/25/1FyQysGYvp2Ocqem
 KHBt1Ds5QF77ZmE+Ddq9KNoUrjUozocOT4h0ZvuL92rwRbtbjF2hS6+SVOQpT7C+l7kEVxf/nOg
 GigTda+HskhQFPnz0Pw==
X-Proofpoint-GUID: kszLJibCfjIUr1GYipg8UVpo1ZCAl7Tg
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfX21A4Ll/PL58s
 d00tRGFKcoYK0Igy5K7am8Q/a672i8wt4rszG7UYLElgNqen/tDnFOm7hrT807ZvvRTKqRK2suQ
 ZqjjjchxKayLe5ywQGQ5zf366Bts72ZMkP15WByVnMfg70fYgfSr
X-Proofpoint-ORIG-GUID: kszLJibCfjIUr1GYipg8UVpo1ZCAl7Tg
X-Authority-Analysis: v=2.4 cv=WPlPmHsR c=1 sm=1 tr=0 ts=6a79de5f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=zHmcO6jMd5r4EZ4U0P0LQg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=jHxIr1HyPKZ_Q5_91PL3:22
 a=4S3DF5rXG3rfafK4-1MA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11870
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0
 bulkscore=10 impostorscore=10 malwarescore=0 phishscore=0 lowpriorityscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100123

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
index c08fc70321e6..28f0b16da2b0 100644
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
@@ -701,7 +694,7 @@ get_oldest_context(struct inode *inode, struct ceph_writeback_ctl *ctl,
 }
 
 static u64 get_writepages_data_length(struct inode *inode,
-				      struct page *page, u64 start)
+				      struct folio *folio, u64 start)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_snap_context *snapc;
@@ -709,7 +702,7 @@ static u64 get_writepages_data_length(struct inode *inode,
 	u64 end = i_size_read(inode);
 	u64 ret;
 
-	snapc = page_snap_context(ceph_fscrypt_pagecache_page(page));
+	snapc = ceph_folio_snap_context(ceph_fscrypt_pagecache_folio(folio));
 	if (snapc != ci->i_head_snapc) {
 		bool found = false;
 		spin_lock(&ci->i_ceph_lock);
@@ -724,10 +717,10 @@ static u64 get_writepages_data_length(struct inode *inode,
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
@@ -1578,7 +1571,7 @@ int ceph_submit_write(struct address_space *mapping,
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

