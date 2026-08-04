Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25D547CA7C
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 18:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869557; cv=none; b=kOptxT+aspPXpsWLaHwVp+T4PPQ+7rbyQ+6m5afBTZIOGwXOurhCL6JcqaZrionbqH35ZwGsFPVxqDcrJRrwHdm2zjjE6+bkiV5obynWokqJlZ/f+JL1wAphHETOGORe4bqfz7pmMGKrkHDYwnGokdfKvVyF66Tly1K94rw/Ank=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869557; c=relaxed/simple;
	bh=6dxbAtDCmrnDYkfOuWrS6UKuWVd+lmgUjReNrbBmSH4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZarnTlwd60U1Dn0WHUR8A19GKeIjvQHl/QqdZoX2Sp2pQ+WwGVvMM+La0twGDMScg/bdPiPGwuMZG5aLxuO80FRhgZhtNo0rVZCfhcZphtOTfg6yCO/cuViTmDu3p89FVa5ZMitXRyRm+OlmbARrGY0KUQGmCBRi19qFS7XtB3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=Ltf+xSeG; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="Ltf+xSeG"
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674IYA5r2126294
	for <linux-fsdevel@vger.kernel.org>; Tue, 4 Aug 2026 14:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=0np+
	Mh4g6FbtGTotF1tdHYY92zqeAhsY3aQwW/2FAQ4=; b=Ltf+xSeGzv0AQkYnla7e
	HMlda09qU+ceQAezbuwSwfpQ+s98hfRrxCrojTw200tDHO0KPJWtipa+mOndoYa2
	0faFNVbhALn0z4heQK6KRc5vqT+Zw91vYGijd+tQ/ZVzSziPHadAUv6hDXtU/i/L
	ynUN9BIQu2IK1g6uWXu4Mw7IZZ8V+TVEcfQWsxChodpUetUwIq3LZnyfE3QsqIFG
	vJgQe4bLMhOxd1rU5LOMm87Bc4ADLQATL+mW4RUie+BXWiilIjbe7wLzh9I5LX83
	evGCAdsnquSjRtxOwQG8Sj711pJ9EjNLgEJAZm/YC6jjB5BEeffKc1Rd2FDNTbTN
	ZA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4fuj0et14u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2026 14:52:33 -0400 (EDT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c1d7886cdso1675191cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2026 11:52:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785869553; x=1786474353;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0np+Mh4g6FbtGTotF1tdHYY92zqeAhsY3aQwW/2FAQ4=;
        b=M5gegTjf/F5G9RpBdc5gAIdx7RsTpZ4orJ7VyLuu4zgsQt76evaKVjLl4colU29Oa/
         +GIlzsb/3Okuv1JjX7T8eEy92ziOp/BBeRL7r5sJpLbAG7sEsW1LisEsRidGB3OTsrZi
         2qSC856SUXJ+LQ7aMk50UTZQX3ZRUPm15vBSaRR20EL89qTURHcP8HI/GpZh71BApuzC
         /PRvGliTxEqqJjjHYQvaoFvmOEWkk4AxWfVVkKOi1aDhViNRfOywBN+x6lxOLxP7OIND
         Ydv2Ug2pP4aB0ka2xTrjjavzhKtQ0fnR4Dc0YOxmcmDFVkBviwDmih0BJqbz/dRAhnGJ
         xkVg==
X-Forwarded-Encrypted: i=1; AHgh+RpuvEzCY4X6wPd8O4Tirmr2nebBmQNNuyEMuQ3cOU7QhAsSRSMvXwGGTMnpoPBalDiPzwroerChHfurlbpH@vger.kernel.org
X-Gm-Message-State: AOJu0YyFi723nJA6mJjCC/EBkpSzuegOJ5zgo1m4RK+F/UkJnksozg0G
	1kHkVlaEY8bEnMwo3DzJGLtr79yB//BUj/YgL0TOsN0Z+HRNzKv6BP9WBPQ8KmjvTwI8zyxd0sT
	Y/ItYpY9ldnNLi0GpztyB6dmNVLalkhmAKAWd0OsOoLsOFW8VczXU5rtvnKNNGjw=
X-Gm-Gg: AR+sD11OH4bNPM7ySBHCem58+BJ9qykSl+2t3l/RPSuR9nO/B5oITthqga1n8CcGkb3
	tfqdMjwJve9KtqorwbXTw2xHVUEXFqcKcnnDMLIebbJDF3Qyp+jl/35MAWFjl+crNgOgIuSnjBw
	qY7j0sBUYd7bM/rKifAeQS/dL+JOj8FvtJ2Y7RNIKYor1DhaDz/rKBG/lrpksredhhm8bEMj5cB
	XZ+W8svHdR+11byVRqBOxgPJaoVriKN2yhf+WOS6V9boZpx2XYRPwe1moNrcQfrP/dOKdOTe8pP
	89I+tWM42uIqPuaa8AT1vmnMjM9gfCC2CY2iI7uNHGwqzDEN5Amm1975P2TKwaP45Grloxy1l8o
	YNtiTboRV
X-Received: by 2002:a05:622a:2615:b0:51b:fb82:67d1 with SMTP id d75a77b69052e-52ce6112cd9mr13729501cf.20.1785869553259;
        Tue, 04 Aug 2026 11:52:33 -0700 (PDT)
X-Received: by 2002:a05:622a:2615:b0:51b:fb82:67d1 with SMTP id d75a77b69052e-52ce6112cd9mr13728971cf.20.1785869552803;
        Tue, 04 Aug 2026 11:52:32 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.77.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec232d7fsm2313275f8f.20.2026.08.04.11.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 11:52:32 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 04 Aug 2026 14:52:11 -0400
Subject: [PATCH v2 03/10] mm: remove wait_on_page_writeback()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-remove-wait-on-page-writeback-v2-3-81f0ab065284@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785869541; l=1451;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=6dxbAtDCmrnDYkfOuWrS6UKuWVd+lmgUjReNrbBmSH4=;
 b=ZZvU1M4pLXeTAriOtmeOSI0mHfXaaquENtCXvCsHWefyUHy7xTa8qlvMhdOavhouCXtH/NY/9
 QkGdKcRbTsJBwgWtf4Ig/DUGBu4bGeMxHWQm7D+6O8sOhgz7BM0DOKW
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=ePIjSnp1 c=1 sm=1 tr=0 ts=6a7234f1 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=j1J1DEHOHTVaJYOjuVnKiw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=qBqFc3eaEPVjc8k8qNUA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE1MiBTYWx0ZWRfXyqqGEGVePapn
 GfT2a1aAcPmbEyPODLQCMzf/YrzifxITgqUYCTtm7GzOjbH9rnIN+lPifeoM5LlUxumKLeQyWE0
 42iUkybmKumhlceCYkryxkpFFbKqCSF/g+Fi9m4CmZ/d41Nq1mnV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE1MiBTYWx0ZWRfX4HtmACv3zgxb
 LPKWk8IqyMN5H/8YVVTkjzUpQRE4dYWdeZn3VCkv0WgmyH8qPJdjSA8+VPgiaxMGejBP+3t7KAD
 ym5m2razAL6K9hChDvzocQbej2Ajn3IisPJbDFEjkDTSy+FbSbuf61st0vc8fHdPAPAD+Y5RS1L
 jx2F/txq6iJ1bC93YV8Ndny4wz/EjS31RT+E1A5bhq9QEIg4g3hc73N+p5yHTxayJSCCgfh3PPg
 zPhDx+L7dVLBUvGkPhlO5Nub9iusCVRWBQevEneiTd/JulnCL5CCZns+3h90fkwPcKRUbHcWRIS
 8WtKhxvUSyS5pt1bhtk/hskgfr1HlYrMSBY0QgERS1s7eLQquxK5M0+ePy9ol0Bf1dMIp3yop24
 QK8nd6AzIJWuJUcQz++dWZcwRTbtgCaEUMokctsZfYH13O2K0WD9fjqoOkFPinL9B6s89WR+ZwT
 4kPo649CE9tnCvon+5A==
X-Proofpoint-GUID: MiGU0t1tJj1KyGsn3fwZAylblTDpfRXj
X-Proofpoint-ORIG-GUID: MiGU0t1tJj1KyGsn3fwZAylblTDpfRXj
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11865
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501
 impostorscore=10 lowpriorityscore=10 bulkscore=10 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040152

The last caller was converted to folio_wait_writeback(), so drop the
wait_on_page_writeback() compatibility wrapper and its declaration.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 include/linux/pagemap.h | 1 -
 mm/folio-compat.c       | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 2c3718d592d6..3748dde2b97e 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1240,7 +1240,6 @@ static inline int folio_wait_locked_killable(struct folio *folio)
 }
 
 void folio_end_read(struct folio *folio, bool success);
-void wait_on_page_writeback(struct page *page);
 void folio_wait_writeback(struct folio *folio);
 int folio_wait_writeback_killable(struct folio *folio);
 void end_page_writeback(struct page *page);
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index a02179a0bded..ae0271591d37 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -23,12 +23,6 @@ void end_page_writeback(struct page *page)
 }
 EXPORT_SYMBOL(end_page_writeback);
 
-void wait_on_page_writeback(struct page *page)
-{
-	return folio_wait_writeback(page_folio(page));
-}
-EXPORT_SYMBOL_GPL(wait_on_page_writeback);
-
 void mark_page_accessed(struct page *page)
 {
 	folio_mark_accessed(page_folio(page));

-- 
2.39.5

