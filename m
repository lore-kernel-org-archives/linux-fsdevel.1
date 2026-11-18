Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794976160;
	b=i+EssZJPJ0ziRSDxLOIOu/3uOPT8IT+4sNM2Zai5MAjco5+Lt2tmm86AmXE1QqZOo/kd
	 9fqbabXEPDPGK5C+F7/2SFOYuydGgx236iqO5XJzAk0Ff0NT265Ja3Io05lhOaoWBexLC
	 p2JXTb2AQvYFfctRNzO5kKdQvohoXNJKu/YFmemmCMuLcmDyPKjHIgB5we604OX9p3gkI
	 ieujnRZc/xwlRsFYxMtTqjup0h9AwXQRpqYUaBHKj1gE9VtIBrXUXfmT5ztBfakjz5Dqk
	 C0lydEvwq2Ox5aH49SvBGiAtf8JHuWrSG3itOJa+RekUaxfZGnUehWxt8exte9rJyjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794976160;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=rc5CZiGD7tyh48F4lxL78ysIlC6P7Il9CJaGLWhqpm8=;
	b=ySNAyHEMIsuLhyDn4y6NGfwqOnB+6Noh5fZP1TGb41XLFuAXm7fhl7OsIt7TimoK8c7I
	 320e7qhPXHyh99gT9VHoFiTQq1L3NiH0UZtNe+JPNMC7fiuYKrUfjHlyM6goE3LcqGEs8
	 Ba+PjW7h3A1uOsPWj5rDjPRfFAZNsLClxzqfLe/TYykQLi3OnfrYkrozwj75xxu75jz44
	 fyU4yqIamp73yzZWJL0L1hOpqcYL+QIq/31vkYfGlXp91zvPI6t0p+P5S2kOn8IgVYTtq
	 +hkZogDPkS5k5gJgMkxxumUIVH4JeQWiHnnaLtxz0f0h5/gRZMc478kMJU8BSMSur9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=Z2b5fLvD;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=zm+v2xP8;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50A8606A8AD
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 04:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A50A8606A8AD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=Z2b5fLvD;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=zm+v2xP8
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI1XPTf3394956
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 23:29:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=rc5C
	ZiGD7tyh48F4lxL78ysIlC6P7Il9CJaGLWhqpm8=; b=Z2b5fLvDdtaRtLT5sxpo
	rB8Si0+hsuAxEnDqVRyAuE5KIbZhsldSqcxjM7VWUSDeVwwKZQUQwbxkS1zecQlu
	7oD7jcKcr3LqzTwFIXBIbSRPoxdXu9BXM4DjQ+uK1YVz+x/QOWe3Mr3sbpavw4A9
	uL9HQZzybTXLdYLC6BabHENLdt0O/t+tpsZxoHGIlTIK5xtqLe/2v6mz25D099Pw
	RjuBPlqQOjMLaiesL9biJ/pz+UscxZHNvJZLLgn5nJcPoPd9Z4Ba7pqzMKeflg//
	yJplaT2/E7DUKCyOkHJUtc1iIme3CggFz+sq7it6xunXRDF8wxjAfceYqn473RxW
	pg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j0yu5sf36-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 23:29:18 -0500 (EST)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-94967c6d4f4so75243585a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 20:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794976158; x=1795580958; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rc5CZiGD7tyh48F4lxL78ysIlC6P7Il9CJaGLWhqpm8=;
        b=zm+v2xP8vtK/ZqHV0EwRGP5f+/mHNfqgiau4vaQJQtb3JXFnbcaHV9QB4AQA+/Xnxp
         LQUbashXFZzJlU3Wbuj3uD2dhWPV3soZGbfwWuJOF9bAyXs23woyWCg4ihf+d+g6VUU9
         ctlJgzcq9Jh/fG6Z+pszL7+hlZlUIYFL4l0r4rOYoq/+6ixO+AvulFq1FnPbKOTcPLVn
         vJtbt2p9h783iLweKiq6FBEi1GvggAds8QkGRIZMcHCRa3PVD1iGl6Q6WFFQDiUymbWp
         yalkYsoj4Becjse4+krnu/iTzBaocm76tw0+3HZn/7O4JNzNuO65ol7bzGBr37qEBNpJ
         6ekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794976158; x=1795580958;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rc5CZiGD7tyh48F4lxL78ysIlC6P7Il9CJaGLWhqpm8=;
        b=GtysUr+urDnfOKtDUBAGq91wt8wk4hJtFRh+WXqEQ3szosaUebG+reM3+S3jseT7jw
         fT+R9T3LUwvPQMjtc9fzZJqEuBcNUuWpbp3DRPZX9xPtl3oZkMgHFhi6YFm+pJYS0fRY
         BGTzQHzrYjoaMoOq8LOxO8n40TY/mI1S30XDSOC7ts3kjG18xnNKYIKQEBmaPp3QhVRU
         plqyJXNKSf5y1b6PnXC302SUMtuvOPrnBXhYXIvO7BG51x4arnsHf/3iOENIyY5V/s8u
         BtBXLvomr4nEvu2rpej0okugWl2hiLySRBWM9sxMkzeBEZiP9TT3ovUBFdFk27erIG+H
         jwmQ==
X-Forwarded-Encrypted: i=1; AL+hErE8sYjkSyR70BZcTk/GfLv26UAZ+EoUZydNjTCb2IM/rdtCNlhZh1aXlrB6TlWnxicw4X2Xw5aQkUuOQuvA@vger.kernel.org
X-Gm-Message-State: APuU4Z8OL28wGV8b+YBcuOHUFFl4AreJj7pURoN1XkK33fdX0uzwsrRI
	OLbxT4A+XUVTnHj/i+0Cg+u9b/Jibua/H1UwhdH0Fb3nACFjXFUvwMOvNiVJzEyBSKeXqaxl26i
	xW38xKUFBiqv3+yg9bgcRs5f2iyClBDdR9RFIAbxUXRbY4/b379JiazKXVrxPZqc=
X-Gm-Gg: AYBFou0SiIRiUBDvxOOhB16f0U9i14++NrgEOkOsAbWtFN4kOIM3ye6aWDdDFCkL4D/
	5zE8886xRnR7SrvNZcD+KoEmQmsBT5TFFbjRDBdio0zIdbwNKDg1MWAaSTVR2USXbU3cOf+acJI
	9xqhF/GST56mHlxYs2TWs5wagmVvVnCki5qteswaPskgUqgxi3tFJ8XUOXOT6CN7KwPCLK1DR0e
	O6hrBbjRy41vyHxppQfNJ0snFn8YLGHTcbOnKd6JTxpUQLTfrRN1kdJcC0CYxGC2EfiCKHp0ZZ0
	cRL2oS0Al98YVqJT0fMyXnXTv6xaRIbPeLiDuJCNDwhX5s364Ikln/LYRbwcbtuu1Pb5MzetOr2
	yc8BQk4bnn/y+t1SjokfpkAyn/cui3mZecgOli6dz9Sms1YRSse94R0zHLTErKQXdtctnJtwZQQ
	Xp/JDTeM4zAeSlvceMzw==
X-Received: by 2002:a05:620a:710b:b0:93e:c12c:fbcd with SMTP id af79cd13be357-949996676d3mr314677685a.73.1794976157574;
        Tue, 17 Nov 2026 20:29:17 -0800 (PST)
X-Received: by 2002:a05:620a:710b:b0:93e:c12c:fbcd with SMTP id af79cd13be357-949996676d3mr314671185a.73.1794976156873;
        Tue, 17 Nov 2026 20:29:16 -0800 (PST)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9499b743a8bsm89678085a.17.2026.11.17.20.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 20:29:16 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 17 Nov 2026 23:28:46 -0500
Subject: [PATCH v3 6/9] mm/huge_memory: build the moved huge zero PMD from
 the destination VMA
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
Message-Id: <20261117-uffd-state-fixes-v3-6-b617009d1a4a@columbia.edu>
References: <20261117-uffd-state-fixes-v3-0-b617009d1a4a@columbia.edu>
In-Reply-To: <20261117-uffd-state-fixes-v3-0-b617009d1a4a@columbia.edu>
To: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>,
        Peter Xu <peterx@redhat.com>, James Houghton <jthoughton@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Balbir Singh <balbirs@nvidia.com>,
        "Liam R. Howlett" <liam@infradead.org>,
        Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        David Hildenbrand <david@kernel.org>, Michal Hocko <mhocko@suse.com>,
        =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Andrei Vagin <avagin@gmail.com>,
        Muhammad Usama Anjum <usama.anjum@arm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>,
        Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
        Kiryl Shutsemau <kas@kernel.org>, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        =?utf-8?q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794976146; l=2219;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=QxwfrdfeAZDvxUgLWWnt4K6ra8Mm3m9n0/IIOemncrc=;
 b=Yg+dHnTso+62HA6AwoBYf3rsd8BxbMnxwO9j1plFZMR96k4L5mkWJL/htZVANnb7stvo5K34B
 Y10CwAlkHPqAoHI2SbhOwt/MyAT3gFejZ1/OcrHBeXzZFS7jBY7ybYA
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: 0L-qu0BxoXb7h4OblqNSjn_06KP4Cmp2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAxNyBTYWx0ZWRfX84m14L//z8Bo
 PIptriRCfh5KAHd+pL9oWeHG9FXqrH5pLyOtDn/lTCVF7VfDiwtiqBps2emkoSHISQmINrLBmqv
 Ym3+MgOyOC231aBwgsf0Sz5JdIuEH1QP7k10bQX7r7E5EiJumCLO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAxNyBTYWx0ZWRfX0jOGfFyWlnq0
 BZCCuHdCNlsv5CvjYvFTRytaSnJNuA+P7us065es88ugQ27uTfYN5xvHdaQtZJO02+nthuXErAW
 C1R608lEeE4lmn2bp72iZAbwBGF9DshNkF7dLndIa2H8Re0atiRvb79tIyenzDvp8eEISbAmSAO
 zcUDnn7Du9Pu9YVDH476aTWxdumVnoE+bwR8MFdEIux7jC7AGU/fnOk569Fb7XSMkiZXBNIiSeE
 NjxtV6zs3gex4fukxJe146KU4aA3tBAWxj6y5sOQGhlEgWoj1CJoo00LXxhTskF47JGtdYK8yCe
 FiVEMFwM+hFJB2y1eFxeFDXO7mAcY4oZaWuez+Kw92ZeB2rafcRHYow+euJVEBuGzrl2OOe0Dbl
 jAZQq6IFoDO12tHOeiQ+u6hYc87Axi0TL3NQ3utWjxBZPHssk2B6cQyrGerHah3ieoo8PCYQVlH
 K3ICi8VYiNfACDagW2A==
X-Proofpoint-GUID: 0L-qu0BxoXb7h4OblqNSjn_06KP4Cmp2
X-Authority-Analysis: v=2.4 cv=e7ST2qp/ c=1 sm=1 tr=0 ts=6afd299e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=jHxIr1HyPKZ_Q5_91PL3:22
 a=VwQbUJbxAAAA:8 a=tHa68p0SAAAA:8 a=t9wnRcJLD9wLKarOqGUA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=ufIsyHvWW7FwcMbVRpPq:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11969
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=10 bulkscore=10 clxscore=1015 priorityscore=1501
 impostorscore=10 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180017

move_pages_huge_pmd() builds the destination PMD for the huge zero page
by copying the source PMD and clearing its uffd bit, so the destination
keeps the protection of the source.

A source VMA registered for RWP can map the huge zero page with a
PAGE_NONE PMD, and UFFDIO_MOVE does not check how the source is
registered. The destination then gets a PAGE_NONE PMD without the uffd
bit, although nothing asked for that in the destination VMA.

The next access fixes it up through the NUMA hinting fault path. Until
then, the first access to the destination takes a spurious fault and GUP
has to take the fault path. The impact on userspace is small.

The moved entry must have the protection of the destination VMA. To fix
it, build the entry from the vm_page_prot of the destination VMA, as
move_zeropage_pte() does for the small zero page, and keep marking it
soft-dirty. A destination VMA registered for RWP still gets its PMD
re-armed afterwards.

Fixes: 763f43865fc4 ("mm: preserve RWP marker across PTE rewrites")
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 mm/huge_memory.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 4a4e187ae3b1..bb7fe695a615 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2981,9 +2981,9 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pm
 		/* Follow mremap() behavior and treat the entry dirty after the move */
 		_dst_pmd = pmd_mkwrite(pmd_mkdirty(_dst_pmd), dst_vma);
 	} else {
-		src_pmdval = pmdp_huge_clear_flush(src_vma, src_addr, src_pmd);
-		_dst_pmd = move_soft_dirty_pmd(src_pmdval);
-		_dst_pmd = clear_uffd_wp_pmd(_dst_pmd);
+		pmdp_huge_clear_flush(src_vma, src_addr, src_pmd);
+		_dst_pmd = folio_mk_pmd(huge_zero_folio, dst_vma->vm_page_prot);
+		_dst_pmd = move_soft_dirty_pmd(pmd_mkspecial(_dst_pmd));
 	}
 
 	/* Re-arm RWP on the moved PMD if dst_vma is RWP-registered. */

-- 
2.39.5

