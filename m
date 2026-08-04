Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E07F48424E
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 18:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869565; cv=none; b=FzvEfbYCIscrxwy0rvL+CdNYStUkovqmoibVqqBxIkWjc6514889KnvZIoyjxHN8oMZCT53g+ASrz68ea+4SVE62v2ZfXBuP3zxuc46MB3VQKC8o0Eh/lpHOULSNXDZJ+X215YF2ROrPVOTb8VA6nnBPGzl/HQ9I1N9WcKOVdxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869565; c=relaxed/simple;
	bh=e5RnTghCgGxRcPefvNu8eHDy7gFWlXJacvM2LVI5FtM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YgAD6sHGv5tqtAnTcOgpISlYidmxi+5glmwx2LxeP0y68btOPUiqqvXXdhHePNKaAVg72m5xB30CRenYK3oZfeuWjBXsv/lgdLEq4TVgESTBp1leZ77xoLFKeL6ysK5pi85ZdxHdDK3lziM0BuU2EgvlYd/5hN2lheTGWJzcAUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=XZpc3OUE; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="XZpc3OUE"
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674IY5c42226810
	for <linux-fsdevel@vger.kernel.org>; Tue, 4 Aug 2026 14:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=Hfui
	Aq9fRwaotC1CJREPqRYjNBrhvyD6iaPba22WJLg=; b=XZpc3OUErFhDuYUKKUqZ
	NgyX4ZEu4US2rdX/qTNvhwRViyaUx1n5QBVsAxLukRBmCfbhPulRIl7pI8ZDFjaF
	K+vabneR/odcpWaGUDF6t8CFft8WaFIHJCl6b6Hb9O/LgrsKt2lD7RQqD0CrJLqi
	29pYTxRZqvs0ZZJu4YByWOtr9BqMmo3FjbIL/7WTQIXBcHz9ZixlSTyfn+p+tY5u
	672KBL7qpWA54lXDvJWLL13s2HDgKLWmET9XFH5k3zkCZTcEsd+FHAzNAAAjAdeR
	gPLlUl4louazwblLm7hX411RaqSamXuZedV75DfhQXmISFnjR8MZBWTXH3xweNSD
	JQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4fuhh7abqs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2026 14:52:42 -0400 (EDT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5276aa86d00so1013231cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2026 11:52:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785869562; x=1786474362;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HfuiAq9fRwaotC1CJREPqRYjNBrhvyD6iaPba22WJLg=;
        b=C26hV7MXLVSRj0XustPIkcqfSZpAWSf8BC9t5PXAM/vBNEsNVNDzQKT0r9st4GUtmU
         BOWDNk/pR79s4mm30dfLCjtG/rvrPGTt4Hboo0kwtXeefiCSQhJ0nVwcxZkW05w7Tiw4
         Aum3JsylVUGgmbkqISyS6MZGA2UWF4Vae7wmjzdQ1VJ+48/dqqsXWuKARf9h2iCvuFKV
         21yAWK0XLpLZhDr7s3dY4sUbTSXdxqstatH+05TBl4/76eurHeSgUAnR7z5vdE3iJ+VY
         ravzvvmIUTvQFd9IC21lU/Vz+DoMhR+bz+K38e8naSCwyTRmf80dCXvj71cu4q4XS18l
         v6Sw==
X-Forwarded-Encrypted: i=1; AHgh+RqGnHqN0GhW96/f0jX9MHeaEr2gOwdY2AmYNqn31wt6Mvj1tGVW6PnLb3IhlMltS8hOFTCMLvQgsQIVMoxL@vger.kernel.org
X-Gm-Message-State: AOJu0YyA1nAU/+GFObu6hagetZHcdqXBTqCMLX3LWM1L4RPdVFxhAOv+
	Gyc1CUQ8i8VfEclDGaG232LbcP+APWlPEpWii9SwdutFKOLwnbrr1v6+zS+Mt+r1BpxuEtZkIm2
	4D9N2dy7tV9tyyPRCxK81NW3jJxEu/MtkKT3W/NkWbuOczullihPWxHhGIWxF4TY=
X-Gm-Gg: AR+sD12gPT6Lyi2ZqB8pA3QJtbVdcCu6OxioxNX/7IFGJkbBGI8K8LKZPc3e01tXcP8
	jlcZfLTKYis5P5jvTaGJervuMmDVmdf6HR1+bvn2DOu0p4sL4uqlN4NAHj53/XZQLzU26BhX/TP
	YS3wSvoLSwcXh9/zxQ4Y9urnsHQN7fxS+s5usBSj9roKX7aR1W4E0m8fJIiW1urH6uyZn8eqRM8
	3KbBqz5giwhMaWhxcrxhn73I4yIqk/5Gh0R+Wf1xx6RnXS9Zkl1bo99H8xxUouaLA/bS4K7oiFA
	fX4gA3JEDVEfoYAmsesDQJ1gxwDOJueqyBGZjluT+i3QCRy9++SBd4PkE2FTXNoGluQ3ooJqT0i
	xE7GXmDnb
X-Received: by 2002:a05:622a:2615:b0:51c:2022:cef5 with SMTP id d75a77b69052e-52ce61009f2mr13701621cf.26.1785869561760;
        Tue, 04 Aug 2026 11:52:41 -0700 (PDT)
X-Received: by 2002:a05:622a:2615:b0:51c:2022:cef5 with SMTP id d75a77b69052e-52ce61009f2mr13701091cf.26.1785869561259;
        Tue, 04 Aug 2026 11:52:41 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.77.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec232d7fsm2313275f8f.20.2026.08.04.11.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 11:52:40 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 04 Aug 2026 14:52:14 -0400
Subject: [PATCH v2 06/10] mm: remove thp_size() and thp_order()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-remove-wait-on-page-writeback-v2-6-81f0ab065284@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785869541; l=1208;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=e5RnTghCgGxRcPefvNu8eHDy7gFWlXJacvM2LVI5FtM=;
 b=352CGDr9OG3l8KsRpsq9VMlqpPZh/MfaEoDT8M8ftVE1jeGcs1HXBprsWM41xxX90zxLaaPU/
 J3mqutft1KOBPqpbEFXWNVkoXdMQb6b5ZCY8fxhWijzmLWTs7ZOOQ/3
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE1MiBTYWx0ZWRfXy3wZKGAJSglj
 OS6/bhp/Vox9EmPH8+olYcJDE+YoXfi+4OFX6IBDcD81ax98ucpBZ56bwx4/HRCPmqhOQ/HK+eF
 RbBABJ8D+N5cDuHUgKWajySgCMoTLtCRiQ1Cj2gRKvao0cNLwRXpH2CXsNKE/44EAXObOpCr8Hl
 XzbDp64c0eshq8CH/RpwaJwdJNS85HIluOS63P0IX8//BB7MRYA0JSwdFdL/PDyzVSzKJgZo6KB
 qeOezXkIk7aTFZWZITahZyBYHgI8YBdsy730NcyBobTsOvGM40DonLV6Zq+fvOs4eM2CD+UL3ZL
 BoS51Qs4NzDjfrV8q9Eq9s3NV4ex8pWZfwLCxYKarhLSLb2+dCDIgL046xAi7o4+6hmx9galXJf
 G9OlOSTDGCDumFxn0FtV5k5MVQbc+Mg3ROd0EJlvpaXc0Sqgwc7BXPH0oXJM56T/n4s55hGN0Rj
 ad4D8jusx6QO7oRZmFg==
X-Proofpoint-ORIG-GUID: lq4BpPVi9G1GIetiLHxx6U2EoLRlTqQE
X-Proofpoint-GUID: lq4BpPVi9G1GIetiLHxx6U2EoLRlTqQE
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE1MiBTYWx0ZWRfX2Jq2meyqZx6+
 dmEu8T/FKtMFHvdzaAdg1LhEGyi3ok+c8A5bM/HayJyGRKdy+IZHPNQ/0x58WBcx57LPkYmLBhl
 1HpEE72jEBumHD9K+yh44xTXsgEsjOx6R0QYVbVKVrY8JDdWPqd5
X-Authority-Analysis: v=2.4 cv=PYzPQChd c=1 sm=1 tr=0 ts=6a7234fa cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=j1J1DEHOHTVaJYOjuVnKiw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=jHxIr1HyPKZ_Q5_91PL3:22
 a=5wpFShScvf9Uq2YMFBAA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11865
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=10 bulkscore=10 priorityscore=1501 spamscore=0
 impostorscore=10 adultscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040152

The last callers of thp_size() have been converted to folio_size(), and
thp_order()'s only remaining user was thp_size() itself, so remove
both.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 include/linux/mm.h | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 485df9c2dbdd..48e821454ca0 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1966,27 +1966,6 @@ static inline unsigned int page_shift(struct page *page)
 	return PAGE_SHIFT + compound_order(page);
 }
 
-/**
- * thp_order - Order of a transparent huge page.
- * @page: Head page of a transparent huge page.
- */
-static inline unsigned int thp_order(struct page *page)
-{
-	VM_BUG_ON_PGFLAGS(PageTail(page), page);
-	return compound_order(page);
-}
-
-/**
- * thp_size - Size of a transparent huge page.
- * @page: Head page of a transparent huge page.
- *
- * Return: Number of bytes in this page.
- */
-static inline unsigned long thp_size(struct page *page)
-{
-	return PAGE_SIZE << thp_order(page);
-}
-
 #ifdef CONFIG_MMU
 /*
  * Do pte_mkwrite, but only if the vma says VM_WRITE.  We do this when

-- 
2.39.5

