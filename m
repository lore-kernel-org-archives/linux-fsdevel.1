Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793660090;
	b=uA4bq7lP4Pfsa+Jf8mkTaRlYSzVE4fMTiXHoKX99TMh3NQ1hGoWth+BYJgFupFQ7inzP
	 oc5+ym+Lva3ksq4ZRpW63uZD+5yUGaF9FGlQJWsxjJFdFkwUQHNKqBitrkCrjBU01riW4
	 voQdP7xg1DrlL0+855vItCAogfFf/OVaKk/ibzsR1jmagSixQxjZeqtXzcqe9L5ul93/O
	 KO8iTcCM5ncfQSs3e0KEWF+8oDSJeeHAgKca5Cm6hXtQGZN6e1PvLNd08KRjyXKXLI+W9
	 EGipEhdaSoBVdCT7KvTkvQg9NPhwPKHVtqafCKCmEMiBB8yN4HseXaTFkWGNdmFP2Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793660090;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=+n+C22ug44tZi/zSDo7h3XNZ0RC6s+0z26GFL25p54M=;
	b=GgCs+QGm3BnEF9p7wmWE8cgabOlya55akcv5p4aTGc0KPSkTylkS9CKU30amwWEZ0dje
	 HzyJj1pw6UAx9u9E/8FU/dsxInnqyL/DPputWhCt38w+6fBmvUQRDw4kUAJo0Qko+u46n
	 A/40igJQJudtV2gzvMvyC11+8U9oPzl3W/KygfhZch2sBiXMP4HaFCooSQ2UNBqJZ0NWt
	 vVouPysZflxFQoxvKfBRYX4Ln7ucWdocyaZUQTl59Eocoe2EQLQxf+c01qAhjNlolhiVi
	 zWnlldjamYEyP3RdELYHPnkqRKETKODxkuIXMjMATD1jj74yZYvnG19RF266Ldt2L+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=f794UEnE;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=oBHPXs0D;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31468606A334
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2026 22:54:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31468606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=f794UEnE;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=oBHPXs0D
Received: from pps.filterd (m0499199.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2MDTtv2287595
	for <linux-fsdevel@vger.kernel.org>; Mon, 2 Nov 2026 17:54:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=+n+C
	22ug44tZi/zSDo7h3XNZ0RC6s+0z26GFL25p54M=; b=f794UEnE20qN0MjZa2Lf
	8yLMS6g4sqhWKbjKw0V/PgJVyJKk8CgRzJp9sXwvI2mu8gFdkx/F+mItbkOF/I5N
	DcjVNqBeAsWdHLb91ZbL+i/rDDbWOY8EYclHvOl5xhp3b+knIHTsq1F7cXrfMguK
	0HkwMAGOdlvN/Slp44+ZjjJMr51FEFsRzoxitSx6A6p9CqRvDr/6FxCHcoGf+0K1
	T0tgkJdtOXz2A3a4HFkha3mzJswtDa9Eq3AIBLKhLXqp5rWuwaqhd98yJxUPvm3w
	r2nyCdGsPickemPnQOU6uH/S/dws/Y/qvsaVaZqxZlOiX8GYuOjGpRrha9Wmtkzl
	Ug==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4hq34br9p7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 17:54:49 -0500 (EST)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f37c94ceeso24214485a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 14:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793660088; x=1794264888; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+n+C22ug44tZi/zSDo7h3XNZ0RC6s+0z26GFL25p54M=;
        b=oBHPXs0DaZ8I+W1oWDQM8qk4RD2XgGjPGTg7RNY3SVL8cHSWrqUT3OO8sF3D9VRpcI
         ku/CvCrUPFoX/Xlpwqd++TmpKSEIsb3/Scddh8GiZjV4TwQXmZ/mraKTCKakOgBmJevx
         Dm+Ixx5TClZU8CSpZNwuKHAM4ICAg+7i3zDipArTNbUPwxnH2VeTOBCRasYrq/YNWYuk
         Kr6NbKF2aGz8qyuLegu4Q+uQj3zPgrDtrYQCyqwfar5Tnbt7HRLrZA+6QfyyeaohJ/pL
         +8GgjjmKo+EWyv6m2Wo2jM+9+RGeM3mk8am6p1jHiGgcUL/1V1Yi9Ioww8PqM+Q7fUP7
         +BIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793660088; x=1794264888;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+n+C22ug44tZi/zSDo7h3XNZ0RC6s+0z26GFL25p54M=;
        b=ZqBn0taQbSXiZ/0dHodoJLex1AZ9/xvNEC1p+fPn809NUgBft/yFv+6Id2XrZEP3Jj
         EwAS5+qEt88MNnDqIAbRCB0UHzhwWIG0jC0qEVAglh7i4iCkT0VvoN2eaZqMaPOVPXeA
         VbxeGzm8hFsf8JLGsE4wW2DnLZBWkrPPTx2ldXVto+yo4PTWNyjlcRFBehnx0trJ6XAM
         8JpxqlSNTnTafnuGOjtfpV1Fvj1qCeZWNn3ob9YC4QLiTIZncaSy8YhfpoJt/WxBVn5H
         SWM46aHVpaFSzTgFJ+W1ty//QnoZAxqQBzQfpzCddscTQFqCVwoBP7rwKZeGqZjNGQk5
         AK5Q==
X-Gm-Message-State: AFq9FYL8sGm/1tw4ePedfQV6A+zSw4hrDlLoF7dyAuLys6tpPCWgZqJn
	AvMEc7BuZpAuy1hacdQG2JrL0UyhiqxpV7LdGNCgbV3QPFGPDoCyHgC7NL61p+SKasCG/Kxqjs0
	ftMN4jBKS35CueoLu8zAJR1HYtqFVS6M/towdfthvNJL+RwzsU5C/f1FjJtdNK3Q=
X-Gm-Gg: AYBFou3EOWkkTf7Vl8KEep6TF4c2mqoP3fDaKN3D3uCoLhRmqVnvq/jmesZhSIgkwb9
	N2EDjAP5EypimAv/6+Hxq53Jx9mKPxHiY7+dbHe19xRU8UBA/EebE+jXuCZ/pFosA3Us1Glnd9h
	QyFUZvPXBc9E/3V/6XU1GNzbqKM0/lCd1/zcwwA8uGXh3D/jqzedSCp4XUfNGMVXtFe7U9I24Ji
	ssm7pMxCh9lzWYmikJgA4RjbJ5LG6yqMI3wcRya6dy4tUHrMUidSTtoRHH978tneNwFFnBswjXc
	bHAudygkgpGJtjwaURcHmqOTlGrDGu7enlNEO+1LQz7eIGlySniNcjNJb5L/rF4ISn9lZK8VdBL
	m8/1PXDAYXGkt43XxQ3dosSD9xvPSNRpDj0Fcbjo5FgfqVYIrgTW2JCOMdQY=
X-Received: by 2002:a05:620a:711b:b0:93f:2e81:2217 with SMTP id af79cd13be357-944133d6c9bmr2247288785a.36.1793660088368;
        Mon, 02 Nov 2026 14:54:48 -0800 (PST)
X-Received: by 2002:a05:620a:711b:b0:93f:2e81:2217 with SMTP id af79cd13be357-944133d6c9bmr2247286085a.36.1793660087877;
        Mon, 02 Nov 2026 14:54:47 -0800 (PST)
Received: from [127.0.1.1] ([37.142.157.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8011csm24710529f8f.31.2026.11.02.14.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 14:54:46 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 02 Nov 2026 17:54:12 -0500
Subject: [PATCH 7/8] mm: remove read_cache_page_gfp()
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-page-wrappers-v1-7-e7280bdb31f6@columbia.edu>
References: <20261102-page-wrappers-v1-0-e7280bdb31f6@columbia.edu>
In-Reply-To: <20261102-page-wrappers-v1-0-e7280bdb31f6@columbia.edu>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793660051; l=2961;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=iXAYsdJV62i38j1emwbwdbC78bf2OkaieSqqfLylJrA=;
 b=aqMzWy5ivbfIJq4ptqsBqYqbQ9FaALulqGhIwOJg0pfOaZx8bycf0yHvDarD2bQnGKi6NfBo/
 XuHlZoR6BZNBqRi3CZOGQTS0xEDszTh9YrJyBvZyxG5CK1s/55Hp4pg
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: uk8X4Hny6iB8O-Qg8b5ivXOo2XQ3tM62
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA5MCBTYWx0ZWRfX1XqLFU8ZiAqe
 4iKH/+BPYIkd5hz/mRelT5bguQ+v4NSMI9s9AL07bkz+Xr69ZFHKOV98ZtBDiFTfvLWBrovixg5
 dIafiYr9IPCRCBXbz0YkHL8Vitt3PTqC77CDtqu1Ibmg68PTtxuM06mWs3jacyK1QJaFXCelV2k
 DHqtcKwXbNIWxhBMBZrMTkRDUbsk33+da7gl/UpUZUWD39eWCfnQdjbPVyyzr/IVozB39B9qYUa
 8Ji628Zpr/ZBMQetHN2nlltT00UN1up0wEj652PLTvYUR9WQrm7ZQ5Mm9A0A9w/r0GbU5tmJWy9
 02QdWbTFyomLBLEdTwkvoUgeXuPuY8VcOPQaElEQru20AoQe/Fn/Li5OYiDApFQCXXyjYKa+Rzf
 HCvtU1qIRkmFpRRZxmV9R8FDVyZ7dMYY2n96LduF1qa24vSX7qWR7tnl1yRIlzy0NyAzpyvecdI
 FmMaVTiKoSDUccnUA8g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA5MCBTYWx0ZWRfX98koS6K3R5tq
 cbULJ5fA1BXs6m5S1dpGV5qo2S2KS0BmfMl5gAlPNfZpAVTMeOJdwqGHIaCvGLS3rsKv+RxzMmb
 j/1TVRtSA/lesFoufHgHa/kOjLHqWFGG3yCSc8zB9g3IZO5xIKZA
X-Proofpoint-GUID: uk8X4Hny6iB8O-Qg8b5ivXOo2XQ3tM62
X-Authority-Analysis: v=2.4 cv=Sadi5fRu c=1 sm=1 tr=0 ts=6ae914b9 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=Qz3frfIdACK70Hl/8c7MJg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=G--0XuH5328wxK7v7Suf:22
 a=NLUVrwrjVKh-CqleozEA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11954
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 suspectscore=0 adultscore=0 lowpriorityscore=10 bulkscore=10
 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020090

There are no callers left. Point the comment on shmem_read_folio_gfp()
at mapping_read_folio_gfp() instead.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 include/linux/pagemap.h |  2 --
 mm/filemap.c            | 23 -----------------------
 mm/shmem.c              |  4 ++--
 3 files changed, 2 insertions(+), 27 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index a92329805acd..305c99bad689 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -962,8 +962,6 @@ struct folio *mapping_read_folio_gfp(struct address_space *, pgoff_t index,
 		gfp_t flags);
 struct page *read_cache_page(struct address_space *, pgoff_t index,
 		filler_t *filler, struct file *file);
-extern struct page * read_cache_page_gfp(struct address_space *mapping,
-				pgoff_t index, gfp_t gfp_mask);
 
 static inline struct page *read_mapping_page(struct address_space *mapping,
 				pgoff_t index, struct file *file)
diff --git a/mm/filemap.c b/mm/filemap.c
index 1df776907140..2b724d9be94b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4258,29 +4258,6 @@ struct page *read_cache_page(struct address_space *mapping,
 }
 EXPORT_SYMBOL(read_cache_page);
 
-/**
- * read_cache_page_gfp - read into page cache, using specified page allocation flags.
- * @mapping:	the page's address_space
- * @index:	the page index
- * @gfp:	the page allocator flags to use if allocating
- *
- * This is the same as "read_mapping_page(mapping, index, NULL)", but with
- * any new page allocations done using the specified allocation flags.
- *
- * If the page does not get brought uptodate, return -EIO.
- *
- * The function expects mapping->invalidate_lock to be already held.
- *
- * Return: up to date page on success, ERR_PTR() on failure.
- */
-struct page *read_cache_page_gfp(struct address_space *mapping,
-				pgoff_t index,
-				gfp_t gfp)
-{
-	return do_read_cache_page(mapping, index, NULL, NULL, gfp);
-}
-EXPORT_SYMBOL(read_cache_page_gfp);
-
 /*
  * Warn about a page cache invalidation failure during a direct I/O write.
  */
diff --git a/mm/shmem.c b/mm/shmem.c
index de838dbb4df8..16b1cc3d8ac5 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -6190,9 +6190,9 @@ int shmem_zero_setup_desc(struct vm_area_desc *desc)
  * @index:	the folio index
  * @gfp:	the page allocator flags to use if allocating
  *
- * This behaves as a tmpfs "read_cache_page_gfp(mapping, index, gfp)",
+ * This behaves as a tmpfs "mapping_read_folio_gfp(mapping, index, gfp)",
  * with any new page allocations done using the specified allocation flags.
- * But read_cache_page_gfp() uses the ->read_folio() method: which does not
+ * But mapping_read_folio_gfp() uses the ->read_folio() method: which does not
  * suit tmpfs, since it may have pages in swapcache, and needs to find those
  * for itself; although drivers/gpu/drm i915 and ttm rely upon this support.
  *

-- 
2.39.5

