Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793660094;
	b=iefFO2tPQq7SiboXLd++MjLHp1Nvph5aTCThiLOiYE+24igbbKL2jd3/RGtnS2OZEs8x
	 9aBPTOkHzYMdPQ/aCfewKQLAXTTyAwnt0nJu9MC8K7IBwVyoM5dXZpzo/SALECXoyjYeT
	 GuY1LBZoMMgHdMyRvh5K9gdYC2EWyrRuL3m9xf22OFd+KnunnRpoaQDICxxu+rGnALQR0
	 nHIZDXVbz0pMB2gu0Fp2BWQUOSFJr/vZ9sXEytfUthLgN0OWkOOIyBk/KDKtgXEJ88erk
	 Xlz0f0nVUIMaGLWLXhUuBW0n6xlQP8FK1WieOVpcS79ODWoaVWh37ddRCaxOvQYOhJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793660094;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=CLnMk/B1cFQ3z0k0LPzM7qddECf0IZkSoR3rfDNv3Qo=;
	b=5NEn4omfRchmkje5QLqKhooowpoyXcS1ieD+GAYnZtHlEYjJFRJZAHiBuC7mhn3vJf/E
	 l24IYgdmikQ6HdHynr/OeEdJnXmr3RW/WJqtpvW/vnvgpYNAxghrNZ85SbnETqY/1FwUB
	 uh1QpY3SnZLuyIPrXNRTQJ1gc5QzUNShpJGvHqav7qAF/+vw1hZbtwO77T/IhdVgSFapo
	 gop6p8DhKrhi/oLGZrLw1WTd2sdZHn+12EI+y0gDxRW7PwvrQOvA5GKyr96oyoYYu74po
	 rjyQoNemhKrPFYXtPZkrddysIbARmueI+asjy9ZrWKm++Ij/bV+lwyPFsJDJNGp7TuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=KcIyYlhH;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=r4C8V8xN;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F03606A33D
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2026 22:54:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75F03606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=KcIyYlhH;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=r4C8V8xN
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2LY8lE3358517
	for <linux-fsdevel@vger.kernel.org>; Mon, 2 Nov 2026 17:54:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=CLnM
	k/B1cFQ3z0k0LPzM7qddECf0IZkSoR3rfDNv3Qo=; b=KcIyYlhHka/aLzj1YcU/
	Ujww+HQttnvrap2DyOvBYAhHdsOau+joQmC06nexMZwElJ2nJfggfL4Btqp1z0re
	hW/kZlCLIlr4CR3v5D1GLztV3KjCKmynVi03ZsvBec1pDGh92gK0yR6LWJm4iuDM
	RsG7CezQlBr6yQx+eZHRoFxWsSybUVQNQmi/XqTghSFF75MD489mSTYsskDg5aYS
	R+NC+jkKACRpJmCzZ20AgHVkjsp0e8U7D55YSnuc8HfpwegKiwlhLLIsy+HDa6j8
	6U5TxIgd73F4SF8F0TpNi5AQoPRNGI1CuHxeluSm1+U21kfaNihiBYQJNUNE2Wcl
	Ow==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hpwfcv63m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 17:54:53 -0500 (EST)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91c0f73807eso47480426d6.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 14:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793660093; x=1794264893; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CLnMk/B1cFQ3z0k0LPzM7qddECf0IZkSoR3rfDNv3Qo=;
        b=r4C8V8xNTFoiWgKpySHXztyV0WNfSdRM/AO0ttaul06EmElTHq2SqRxqg1DDVPkA4q
         c7TDE9Ywel54hC4Mj1KwjAK/G106UkPSZUo/X0P/ovDkOtnF/I5D5/HhdzjvIzHqK/0I
         qqPTECI7/IxEMQGfC0ziu1iYWQi38eBoVdF6yYuN/geKFZvy58LnisebbNCO6J8c6q1t
         tLD39JBKSj/sXocq0ZJFBcbqeFXACdfa1K/zg4CgMhZp3R/+8AfDZDipsWO9d1yr7r26
         Br52mvyLUG2KzlcP3MLcFhd+oe3yEFPSxmlPU+isHiynes2DFp1CzqfU6X2SXwjn6qy7
         wp/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793660093; x=1794264893;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CLnMk/B1cFQ3z0k0LPzM7qddECf0IZkSoR3rfDNv3Qo=;
        b=n/u8mpKtN1NmtAEyDG0/9tZyGZijfy0KoGn4o7IkdCNkTAkK5tWAdjP7W6vBkCEhRY
         WWpcc/ygNF1u1RdGO8hjOnLrEjzk9j/rWuEXKzivuNrieFHqpvPHzlznJa5+p13GcavL
         aum50kt6PKPoapxuVWVqfdSPSb/qds0e/OemIGSmZADwGMFxz/Ttad1dWAhOtaRvtd5y
         3G4BJTABJtRFsiIERo38NdTF7NS/6Dj8sHap0WPdoSHuDZqRCXZ4e0rSTLMr0m5Akb8Q
         XFh1/U5tjHUlBkCqSOKQdMV3L1W143qMFbevlmHG7diloij1xMtTsA/wGao99k5r5bkj
         WO/w==
X-Gm-Message-State: AFq9FYJuN4MmNgZm/1VTSlRJAP86HvNDCwmdGDjyjc4VgLCHlJx97iqo
	T8OoXkJnAmpSbbCou9dO+1cD21porDwt02arhED57LNOIPZvlEn2jenXCEAeJNsAA+vmLHxdf2q
	8GpxJbXCOR27qevbduw5frjcLbQV2j8YBIjSk+t2WXxKyv2ZZph67z4X8x5NA1J0=
X-Gm-Gg: AYBFou0QMg4rll3EFyF0vtjFWyFtb0cwd3JwrVSsBB4aGJTqCGAFCrHYCpcbygw9/7v
	O5Ax8Zw/95g+c2pbtazO8buN1XG0DrzTCD26KVoSdPbz+3OqqHZCuCkHc+QqRxZuJ6J6L7YfCax
	oL7NN81mFx0xGo2jPfQrqw1hKuDIh4/gRJAYzazZCfqw60vdfV/x9voIV0dkDzwJ3edZJX9JchP
	YLvOsUIT6e3ZmH7NWGRXeK5IwvMYLgYnZYZsuuFc7736mvBc14/CKuGuqMEWG0DXrArXxV+lNRz
	YkjoFd+o+wmhOD+45z8EWEwIWBeDZ0bYDk7HRnv9mWok3nZmr9+0PHbTYfF34rhU/aFjRE1IIVr
	NwVnMl07RhT5AY2rL2J6LM9Hg/MJo1i+IzpQ6/0scA0O99e21k0o09hBUVRQ=
X-Received: by 2002:a05:620a:4402:b0:93f:34c9:9252 with SMTP id af79cd13be357-9442174e1femr1926259385a.55.1793660092564;
        Mon, 02 Nov 2026 14:54:52 -0800 (PST)
X-Received: by 2002:a05:620a:4402:b0:93f:34c9:9252 with SMTP id af79cd13be357-9442174e1femr1926257385a.55.1793660091921;
        Mon, 02 Nov 2026 14:54:51 -0800 (PST)
Received: from [127.0.1.1] ([37.142.157.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8011csm24710529f8f.31.2026.11.02.14.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 14:54:51 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 02 Nov 2026 17:54:13 -0500
Subject: [PATCH 8/8] mm: remove thp_size() and thp_order()
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
Message-Id: <20261102-page-wrappers-v1-8-e7280bdb31f6@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793660051; l=1262;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=6t8b0yasyYH7uaOC/pe0116nR8/5Kr1ZC3jHg5DjY98=;
 b=hJRS3l3lsCEY2qgn9hYW0rOfYfRH53Y+MmXfkNNwQXYDnRHQLgVIFrENlde5pR/kqnnVhHGZw
 aqdn0TcBaRyCRMSDUYUqRTd1SjdjkQj3EkIbJxIwZJVaFBlnU0eMKkb
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA5MCBTYWx0ZWRfX+c69ePwFvvM9
 YLCeejMqQSO0l9SEHXwVK2XHmbHQPpg+4vF6yyi4VGxkqGsMpiO/cvz21rUHjRDsC4W9B3hUEBm
 Lut1Z07O68Cr1WyYWW0/o0hClH7fjp96NvgF9F6tqcZiF6YX3h0+
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA5MCBTYWx0ZWRfX5wOiD1+7swon
 4paMmKbPY7+URRFfs54BndC2rntThzEJOWmV4roet4FtuMnGk+DhvWj1+myQdPXHJuXMMjzTohO
 OKbbhb1yYXukM/kLobbigqibxrYeraSgJ4gqPV93sgABevpfVwcWOGcA5zwpqDrdyWeGiR0xBvX
 i5U4jmmYOb94uhsnoxB954/WNfDhbg+6Lb9XZTb042QUIcmhlpG5dLDufYKXTygVpz90BMAkepR
 n7d0Dq7NeSEZkrVGVOGKNssBRoznQJmDUbnEP864qt+hwGCNqQeFIQ2PC697poOJVkt77lEfjnS
 TrHRahFKkqoaUA77mttsf/naP2sgNeSCEXfQqjYE0f0kT8J44v09RNEDfLvGSMm7i662JTjhdJM
 kScahBiDr/RTNF+wx2Bw83My4WRLqMUJGZifdbNu9LUG/bDcp/xYIRdEamT2V8yJatY/FXSrdhV
 P6Yh0OonJ6A+qkxjPrA==
X-Authority-Analysis: v=2.4 cv=dNszC+Zb c=1 sm=1 tr=0 ts=6ae914bd cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=Qz3frfIdACK70Hl/8c7MJg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=jHxIr1HyPKZ_Q5_91PL3:22
 a=VwQbUJbxAAAA:8 a=5wpFShScvf9Uq2YMFBAA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: McDCN3DDUJrrmhA6FyxKi2Vs35iNWDkU
X-Proofpoint-ORIG-GUID: McDCN3DDUJrrmhA6FyxKi2Vs35iNWDkU
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11954
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 phishscore=0 spamscore=0 bulkscore=10 lowpriorityscore=10
 malwarescore=0 clxscore=1015 adultscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020090

The last callers of thp_size() have been converted to folio_size(), and
thp_order()'s only remaining user was thp_size() itself, so remove
both.

Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 include/linux/mm.h | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8b5883878538..143865580169 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2146,27 +2146,6 @@ static inline unsigned int page_shift(struct page *page)
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

