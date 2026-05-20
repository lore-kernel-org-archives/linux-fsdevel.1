Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7BA3750D7
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 20:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779310241; cv=none; b=sJxJd0bzFPt7wWBANCRu0wLo1Z8OOmTJ6A49tXnE3siOCnXfxyvmL0i7eTBjVpDFNZJS9qirN45XejePebZ8HDTm6SbhT/b27O4e5sFD5JHD8Xgqc+KwIF3U585xlB+6t5j95/C80X1qIEJQr3FoXIC8plcWf5s7j44fL6n7+bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779310241; c=relaxed/simple;
	bh=VtCji9Vx3n0Qm0HWIP6UWTPSjZWdzR1UjYoNBHm1Y+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O7kerQb9XxesfZNNMuRezHU0TBgAn0ueZgNm0piZugmyZUEBP2ECGwrDhB2eRqrzBqySOuh32vaSTggYzWBgmzc6zmfWrFEO2uZZvlwghPKVI80Z/yYJZoR2hYNCjVNVFznMsqS5wGbqi0d03K+9VnDGx8AP0aBenbuHsdZoQ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=e3ggfQ5i; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="e3ggfQ5i"
Received: from pps.filterd (m0167075.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KKNx3K3138369
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 16:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=Vd43
	LnA947EFq0/DCZQf4Ap5tt7EnbD+Y9KrusTIT/M=; b=e3ggfQ5iJZvEHRmVWX+j
	LpFK6H+LsUTgm8fyI6wL9f0vMt7W2oIbT9qn60r4FWKZqhpLkP3JPi064tiKO5DZ
	fkdq8VvYDIilfbURYABMrhkiDk6vnaAbF4FQsQ5CbvQQ693ktoG3RgD1IfVwDM02
	GtQWDjriMuc858rYZhQ8SwA8zKivQg4b1oB+Qr69f6/kyIX0+1MuF1XwUUTlZGbR
	oBKUlf2O2jQAMQgaGGwYC/2k2+I1UR2RtYy86RcLqQb0I0x0/HoYiUO8PCbpOwzd
	LlLoeCgkDOCpeW+7VspTHmsDFE7B4hWWUbpO2aYngH6S4S0QVjQu8/n3rWcHI4dr
	9g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4e9d3hv04r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 16:50:32 -0400 (EDT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-90f436952f4so1191089285a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 13:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779310232; x=1779915032;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vd43LnA947EFq0/DCZQf4Ap5tt7EnbD+Y9KrusTIT/M=;
        b=W43NELpo9BYkjLKYTxCDXx+SQL9pOLXb6oj/Hrjy4+ZzhvwCUcRb7hiL9448MEZ9S6
         DQ2BHgPWo8snrRZkUq1q9DmgJFmmlLpdxtB0l0jp4f9rOClwf7NXnZ7bmBJ3kBaySWuu
         ZzEtXI3yHJxYCTktJOF9kRor1MTAZ381B+hmB0Yl6IzEJUy9inLGW2RIno3/otaPDfRb
         G5HcF1uy9FGLW9bOUez+C0YgxM2ClIgxRLm8slW0znc0xq3GT+jn0n0uwRzBNp+4OuC6
         bbN3Fj4OPaadOZ/z1KjEsshVjI6KCTipiRvAylRz+KHgo364+vgf4mo3EdAV9zbXH6ZK
         SL9g==
X-Gm-Message-State: AOJu0YxqGBCeje8J1DXiLs5yjbTdGrJ/zLavovO54Zi5xmhAdsFZ5KIr
	5/1/IOH5U27fGbMyzro07RjZ4ERkj6WReUB1p3nzalY0teM3/1oT7ggbIbrXMMfUYeCikESPS3h
	bWVYuUE7x75OMnY9Qaci6REAr3pr+aLmRLhp7Ia2JfDVEDcF7Zy4XaSlKDtBcNjw=
X-Gm-Gg: Acq92OHQ+UULT7D1TFA3yEwlKEOTMXaz3HXBkVWr2gfyPpGJ/FWW87DcgUZIbm7fZiC
	F4RQq4XtqEBKnTcKuPvzDR/ucJx9VECt47SnjQ2GTMIePpcWxt0icz5Fxau4A6PtHSBX0usW3aU
	OM6OZuud0ahoT1Z2+J6/A08ojElgVZ1WG/vNhB6L4FZsMiuGo71Wc0fPU2CQcAHbGlgRxvo/l3p
	HWIdvxXjSAK4kYcKXq0kTG7PB4yDKMKk6Vz0Hx61CEjnqu2yihwpAKNIki6z3Tgf3a71pPAATWY
	kz4aa7IpUnHuQ/pJv236ExeXBKmZGKU0kajPgh5s5QkZ2AMjc8nGSAnU1x3pvq9+67PFxe0g+9r
	JJ271BW2yEMcHbVTbszJkxTOaaj8TRkTwcJN9cLNpes6LUUpzUniwjpE6a4f7/Ul+UzQ=
X-Received: by 2002:a05:620a:45a1:b0:90d:3af3:2a62 with SMTP id af79cd13be357-911d01b8480mr3765384285a.46.1779310231916;
        Wed, 20 May 2026 13:50:31 -0700 (PDT)
X-Received: by 2002:a05:620a:45a1:b0:90d:3af3:2a62 with SMTP id af79cd13be357-911d01b8480mr3765379085a.46.1779310231448;
        Wed, 20 May 2026 13:50:31 -0700 (PDT)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bcf37274sm2232692085a.37.2026.05.20.13.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 13:50:30 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 20 May 2026 16:48:52 -0400
Subject: [PATCH RFC 01/11] mm: add folio_wake_writeback() helper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-filemap-split-v1-1-c36ddc2b6cf2@columbia.edu>
References: <20260520-filemap-split-v1-0-c36ddc2b6cf2@columbia.edu>
In-Reply-To: <20260520-filemap-split-v1-0-c36ddc2b6cf2@columbia.edu>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779310229; l=1111;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=VtCji9Vx3n0Qm0HWIP6UWTPSjZWdzR1UjYoNBHm1Y+c=;
 b=azfgHe+wJUmJYcnwmRy9nfEahOjxOjPQSFoLVtJuTFiY0m9rg0Q8a5Ipg+OYQuIMW9Uilws3E
 gf20tFxHI6SAIQaIiaLwaqYFsnM1ib8jXHnImDriiGvJgm0NNJdZl85
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=fsvsol4f c=1 sm=1 tr=0 ts=6a0e1e98 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=HpS3TJQ9O3Ob1ozEcmik:22
 a=s_jWojCdVP8jdXr2cG4A:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: 7_wWU2ofpficMLYGKh9H1mNuDNm1hOe-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDIwMyBTYWx0ZWRfX015y5OvToE79
 HFpIy40XcNWjzuSLvwGAeWNnCPLXFBynpK5MxaOg2TpBT+5iLinJKfJT0Ng+Bi3gyLue4rvgKYQ
 CNTr9hNVsx9dqc8sLUCCWnuMqjHQ/TB93avulNH12fgwkhVwnDgiOsfY+x0tgI16K36/TLDLl7Q
 rmZWCnI9P45ihcjuW56qsBM44RXtE90Vp6R2HW8cbaSrJsRBWE87PFQmYAwC3NY0YxW2o+3r5/G
 6cYESdqmeliBqRdZJP6vnxrWM8mYAqF8xhmDauy+pl/+kGjCbGijfZxCmCPcGnX3Va1u8W9L5S4
 u+aTO8ZCm4hvEvMdZXRPS76zPw0qRTldNUVrx1y4n5a/dqbA5uh1HIKaF4b3VSKeedvtF6gT5dn
 bBliyLljC8DAX2RCSp7tf8ZfUYfms1/qZ40rThnJAyND5LXxTW9tKmgiprg30JEM9iNGe7uEN2K
 SgavDpfg7f1PPgiOsOw==
X-Proofpoint-ORIG-GUID: 7_wWU2ofpficMLYGKh9H1mNuDNm1hOe-
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11792
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=10 suspectscore=0 spamscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 impostorscore=10 bulkscore=10
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200203

Add a folio_wake_writeback() wrapper for folio_wake_bit() for use in
folio_end_writeback_no_dropbehind(), in preparation for moving the folio
bit lock and wait queue code to a separate file.

No functional change.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 mm/filemap.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 5aaba0d3e81d..567742fbaff0 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1209,6 +1209,14 @@ static void folio_wake_bit(struct folio *folio, int bit_nr)
 	spin_unlock_irqrestore(&q->lock, flags);
 }
 
+/*
+ * Wake waiters on PG_writeback for @folio.
+ */
+static void folio_wake_writeback(struct folio *folio)
+{
+	folio_wake_bit(folio, PG_writeback);
+}
+
 /*
  * A choice of three behaviors for folio_wait_bit_common():
  */
@@ -1664,7 +1672,7 @@ void folio_end_writeback_no_dropbehind(struct folio *folio)
 	}
 
 	if (__folio_end_writeback(folio))
-		folio_wake_bit(folio, PG_writeback);
+		folio_wake_writeback(folio);
 
 	acct_reclaim_writeback(folio);
 }

-- 
2.39.5

