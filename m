Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B2637E5F2
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 19:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786994136; cv=none; b=ADPbfLOq64PP+wRMvMA8qoGlDE5fk+P14jBaEetbbtcALPpo4ZJ8QoMRSiIDeOthPd+Iv3jY0biCnS7a3SqZlxz65niCJmRWIvpaUctdVUIPXIqMMGibe1qopSm6Dc0CLyHob/JrTGLI3GcXBFETNLp8qZ13d91Mw3aroiHTlLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786994136; c=relaxed/simple;
	bh=CjGUfQGtk1hGuYgE8mlbsK87Dxg0IBB0DZ7ppRlE9ac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BitFrVeoBzWzCzs0NApCzPSPwX6ZRg7z/w3v5itD2xkThFahUPqYqEAuX0qZRKbrJrlaGDV6KvhjsODcvT6fAFMcKfTeL/NEHsVoX7y2qDhaCuHUmc9esE7OpWScSje1IRS5A1ptD0kS1bc9wHWwua8JqdYEcPrieU3oXKFby+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=jULaqmw1; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=IksjeHHW; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="jULaqmw1";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="IksjeHHW"
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HIvhjw3766651
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 15:15:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=eDdl
	k+dJjpkXdKVusIRsLy1rhBsPVt11GNFJest4++I=; b=jULaqmw1ftBKn5QXmpnj
	YiVfI/c2EPl8LF/ilqtT5U4ebUDZoyQ9m/x6rkF0FswWW9VcKD0TJXKC9nYwbWe2
	w0YMjjCWXDzWrXdnVthu5P0/gFRsYGlJRw3tju0fhP1O5glAky/2XBdauZD+HjwJ
	ZEMH/ITPKocDa2EdtJMZM1x8mJCOTexiUP85TrpEBqPA8eeXhaiCMM61MovySs6n
	SUip99AOgKo+k0/joqaEqvSjDL4mFrjt6yFDQrjYVL8iCkqGQ97YxK3dg51fiNGZ
	rxe7mKbjlo1FbFkhEqFm7FGituAitLn05MAM7veQUmqwVk/8j9xHgCc6QXmpHa6p
	Qg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4g481r85ew-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 15:15:34 -0400 (EDT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9309af14fd7so314240685a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 12:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1786994133; x=1787598933; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eDdlk+dJjpkXdKVusIRsLy1rhBsPVt11GNFJest4++I=;
        b=IksjeHHWFTZognWBZ99N4o09DYArPXhCN+E8Ks0UotIsmhgilHg4qpIml4YFIwZ4a7
         /zW3xyhfecFeRr5Amu9vd9KsPhDbHWAdT0wa2wWAA4ZaCsQM+3kzZl/9ojk1Lj+hKao+
         TfcRZ9c4v646Dh4HNl6e23UuTFtnXjFEQ0ok1FBp6AUK/Y814EpolGYG5J+4Ko+47Ou5
         uwHFLS6sOkJyO5Wm5je9DaS3pSzM70ChXHZWQLiazqoL2+1QmdB9lkqMMYLbLyy4ELv+
         xpWRvpdCVbSIuV8FIdWbNNi1ohk8kCfmqeLcfBFw/P7+UxSegVSGalyPUYvuZZtFcy3w
         NtVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786994133; x=1787598933;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eDdlk+dJjpkXdKVusIRsLy1rhBsPVt11GNFJest4++I=;
        b=aRbjYSBDRTzESF8ZnUDmtdobEb/rmkqZVh+cmxhTRkuVBRcGI4N8CjWFW237nbHo1y
         uoO8LiFUSDYJzvWYhHdDxze4kws5jut/aXeQPppv63fnyFZfYH5oE05ZCYEU5Kk7KEQ4
         f9dERg0b9zhb0r9bDLwe7G8wIJYRlDapi8cP/chK7MQva8XuvOrTXOQShU0M9bk0jegN
         J4Em3CbolW66b/MQQISVHs4Du2aaR0CGo/hnMWxrTdsQPROwge1Xlih0MjlMyYWHwzGG
         NiiQEPkcc3oujbEpTO4AdR8k62FS/JHs8hKP0XcXw87INsDx0chn957pEbYsfQxrVT7F
         YNlg==
X-Forwarded-Encrypted: i=1; AHgh+RoMWo9qgDA3Bcm21DF4Ptxe+fRjh5xE7kQR3LbF8EAiz+UoYgwFWgpBG0HkX0HqORS/gi8yJyqAvIdLTwVM@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkx1nc2aQO72SngycX3d6Bs24xyq9iYNRUZCAiL90ZewbEDEWc
	Cl+1HUWN6YvCVa/bTd1byhWI9RkMy2++LDHpdvZw1FpJqCbB6Oapz/oCw2nu+kTtr+ZMW4hZIU1
	e7RJmv5yC+krRo1wo43Ni1Epiilbq/YszhE9B7GBJbiOwfZyD0AoSWGEnoSPeaNU=
X-Gm-Gg: AR+sD12kK2o3B5+zlTX1+AAlE8SvZtidN4ZrGIyULVp0RdJ/Y3MROCY2ZVhw98xGtLM
	jLA7rZk5efWoiMmpsucA8FKGZ5p/pmKZL8b5sVkbCjJ5ndIyQuOHj0kBabdKD1AhmYrnNVB5Gci
	ITZq9cCZB+9cNJTT4PmYu1OEdixi6pj9TGxy+eCsOR/u1ab0D9JUTqrYR1HfSxuzORF/bsizesD
	smk0u38zbvvLlVEdy2Imawj61sDlRi40ZWkuVZX8NJ+MXIudLMxSul45CLBc6I7GgYCNU/ObUXv
	N8XNHbXAN/bV1lsiIJ6YmUjOyFe5/hHcb49H2lnuqFlZMTngp02RykVqnrJY5VDIDPHTKgtwyWr
	CQikkDX+a
X-Received: by 2002:a05:620a:5be8:b0:930:cb79:ee65 with SMTP id af79cd13be357-936d234d4f7mr2386077885a.30.1786994133414;
        Mon, 17 Aug 2026 12:15:33 -0700 (PDT)
X-Received: by 2002:a05:620a:5be8:b0:930:cb79:ee65 with SMTP id af79cd13be357-936d234d4f7mr2386069385a.30.1786994132905;
        Mon, 17 Aug 2026 12:15:32 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.67.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499961098cdsm194692085e9.6.2026.08.17.12.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 12:15:31 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 17 Aug 2026 14:55:21 -0400
Subject: [PATCH v4 05/10] ceph: convert get_writepages_data_length() to
 folios
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-remove-wait-on-page-writeback-v4-5-0e5e53d47eb0@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786992937; l=4666;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=CjGUfQGtk1hGuYgE8mlbsK87Dxg0IBB0DZ7ppRlE9ac=;
 b=KhVLTaoUXjCbc7TXQHxw+1ii0RoWMiuDhToT3bEe8ZCyATqgjx9FKeOWObd6DwkbPk0W2Em74
 xPeOjr5sfrPDCr4NF4569Y0rF3FJkVx0J1j1f5Nmpgg1Ql8RB3Ffztx
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE0NyBTYWx0ZWRfX+h9CwWWUlh9V
 4vQumFYRQC5jZWLnBFBUjZrTz/FyU9dMK/h6PytNMHBGQFIuofM996U0Mn0vzvMt41imDlgDnT0
 hYtTeJJJRij/OseYeD7lCz95Bef5/YtHAj7sbptoNGNqY3Y+T5rZpa6dmQMTyVRWXd/H4h/y8+r
 OTuz5udLAQ+EAyJFdB8LYPNVgKrnRtpwZVcZJaTcIbPykG4in8k/pr1iRfz9oJdfi0KaDnYSgVP
 Ce6h3bSqObiB1vXmAewJ1IqjaN+9Nx8tzPln5+CkZeGsvFHt1dTmAu3QtKrauQwdNA9ZaOmZkUl
 WnuPayTwCKbOuu7uNYSSxLm4lI05PnPG80R360VgLFun7fBlPiPfCTO4x9B5lwqHW42AkirQmxn
 dV78s6WMJAN/bprUMoRv43MN+PFzMPmB0B3ktXiD6wIGrseT5Ca6f6thAcnr6m30bC/xXIBx+CD
 utVwcPLMYXRPp9spHpA==
X-Authority-Analysis: v=2.4 cv=PKw/P/qC c=1 sm=1 tr=0 ts=6a835dd6 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=+gpNN1aRt999K7yrv1sWlQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=jHxIr1HyPKZ_Q5_91PL3:22
 a=4S3DF5rXG3rfafK4-1MA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: ZT-vuMWEyvlGkDHNq7n9OBzNtyruS9vX
X-Proofpoint-GUID: ZT-vuMWEyvlGkDHNq7n9OBzNtyruS9vX
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE0NyBTYWx0ZWRfX7zrLFNLFYfWy
 Hpw1i8FTz3JWusOB9DtVyqtcpQnldbMniwrLHE5jKuqWpdqkGLmlAiaULNAa/fVrDXTXWnI/Phi
 10GFmema/YMWE/bXfuOA9rqPqvxNtZmya7ek68GS9ZuxGp2uBfbM
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11878
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=10 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=10 lowpriorityscore=10 suspectscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170147

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
index 5efc8c7c91df..a34849374f65 100644
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
@@ -1589,7 +1582,7 @@ int ceph_submit_write(struct address_space *mapping,
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

