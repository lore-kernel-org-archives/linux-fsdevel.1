Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C10376A1D
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 20:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779310245; cv=none; b=kuGlpEKWL2L/+nJvbtcnYrb6t2bbeXe3mlar1IY8naK4VmbVQMox/tr9yrGGnYxWeTolZT13jnEJYCRB4rwKYBxOzL3UqdmiBaJJdCqTm2EuRJ0IOuKiZrb5MVUS4XlkVaBwThkgsgnHadLsx0W2tktLNBR8mmJlBMfSjjW70HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779310245; c=relaxed/simple;
	bh=dFyWvW6idGsgNVV3N8U6/Sf1EZqh/O1Nww0zGEVwRg8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HoanVsa4Z6f689z3EvCE2CsOyP6RDWruoyIZdPVhzrcto28NyaE/m1Lc7jCEy0F4Gvr8Nbf4+4lIxGGPlLzXNgbz5YYeW3knhgQxSMTJ3v770ete3pOyFXIkg1jfCqn3Zi2T8KCCgZTRCcL8OjFpnBWboTPV/FHFH99KUg4+aYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=R6qzpP2I; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="R6qzpP2I"
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KKO1gN2354695
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 16:50:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=avRQ
	NH2N900diQes/ogN4qxa19bmdOzpQ8cdXUSTkOY=; b=R6qzpP2I6TzJ9toROuZ4
	25CAzSV0QypPvPhnHnRyFZnZ7ztKEuyAJKs24zra5vCMLYILNukkb/Tcsd217DS4
	fggTihPdbZMn+yqz2B2JBLKJEc+41PZdlH++fP5e0SMaxYoHk97ZEfIr41vmfVO5
	XXjqsssgJOCszcemHbfkWa25njREhNk0idIx4DAK/7F/BjCp3GKntlko+aGADs6u
	d6DefmlE/cw97ki7b5pBMrodg54Pz/HR+n/BZYql+ihGX5222U2LgO/KLY7N8m6F
	Up9pgnDgHsAJ2UD7LhXHFKJfSdOfrcpQEVqb5tVXZVQD1a5fjEHWUxupV7ijBmBb
	lA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4e958qwyyg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 16:50:41 -0400 (EDT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8baa173eacbso81861696d6.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 13:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779310240; x=1779915040;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=avRQNH2N900diQes/ogN4qxa19bmdOzpQ8cdXUSTkOY=;
        b=AjCUi/hCwbAdJBm+Mpo/am+i8wZw/niuzVFXIWrEv4NOa4vZe9C1Sogsxpj05nwow6
         1dw+l3WhGEm/Bh6cZ7vB45nXsgNQfeIhR8LZpPsQUnWbAzCsKSBOIWBl4pzIilA07Svb
         bVuxBlc9vpvy+cfb6gmf1hWQBNH/gTz+Amtjbo27HX3AvxepgUs93oag472SCY/WtZ4X
         AzZ5Z0ChWdqq8iAnvd8SLRviQ9C7mI+vn0gyGqRLQJ6Gp1Sbe390YKBg1gocMnjvn/iW
         ngNeHnnVxtyQV2SpsAg3gq5a5bEiIbCBwYseyhhuuUm/cs9J042KBnUZkHjEt5ISiAq4
         dL8A==
X-Gm-Message-State: AOJu0Yyz+7D1dkLjevRn33b66dcGH8mjtyO7Fs5FdULDYdrqyyT2PQW5
	YyDuc6POgrwKcPlUz2hJCgMtl8LgUBmvKpSrQnMUMoP1vTym80c6ZjvDCpeJ+jEO7TZw8BDUpEh
	5ysKX0aspP+9BRaS+bwRAou5pCJsfw2kxke1UwjJ46nBFaBmwAHBcTkEqWOblit0=
X-Gm-Gg: Acq92OGLFMAx/3gxl5sddk83x02ZAZB32h+cIeIVTBI314IWgv8V1JxkUhMEVadbp9D
	Iu/7TX2eN8csxy0cxHF/ynY5sw3jD0ioIho74goQEiRwpiIjLJQDD+gzDRGfV2UrD7/84FZq0JW
	pLd1Hlyl6+WmNlwCoLTqrN1R2FnARjg7P9mhcPTtDO3EVLsCYrJKlLgmmck5S08aRigeOJDpNMd
	Dkc4dOXou2KgPMqr4awzDhgdUHEuEh+Z8/VIAVRz3c8dCzd+ugCDCU4aEjl1y4AdfQUC5lINWyc
	aF0RAGnWqQAkT34OJqs9ITo/4156tr3XAA/fcUqHB1dhQ5WrMB8D9bLpJNZonnVQ5gP8n6I57Y4
	V4pCG+lZRFpUO7yCYWmGQajxq02Q/EePDcJq2tq3ZwvnBRvTkNPVy6rgdHw/ToCsoBaw=
X-Received: by 2002:a05:620a:28c2:b0:909:e4dc:fb32 with SMTP id af79cd13be357-911cdc429b7mr3837076885a.33.1779310240585;
        Wed, 20 May 2026 13:50:40 -0700 (PDT)
X-Received: by 2002:a05:620a:28c2:b0:909:e4dc:fb32 with SMTP id af79cd13be357-911cdc429b7mr3837072885a.33.1779310240054;
        Wed, 20 May 2026 13:50:40 -0700 (PDT)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bcf37274sm2232692085a.37.2026.05.20.13.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 13:50:39 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 20 May 2026 16:48:59 -0400
Subject: [PATCH RFC 08/11] MAINTAINERS: add folio_wait files to MEMORY
 MANAGEMENT - CORE
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-filemap-split-v1-8-c36ddc2b6cf2@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779310229; l=850;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=dFyWvW6idGsgNVV3N8U6/Sf1EZqh/O1Nww0zGEVwRg8=;
 b=HPyU6CJCZ8kqU8alpJJp2HCe9isKSiBdanKUUwMFGvy0Q00sMV+3afcEBole6GJFz/iDcpiMr
 llz2jdaNdK3DhYhQLMgNYC2AXXFscR5FYH0b1/6uHxLX4UxQ5UB3BTb
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: dlnXAoWF9Jd-6PHjnqHRLPFgVk-rfZvC
X-Proofpoint-ORIG-GUID: dlnXAoWF9Jd-6PHjnqHRLPFgVk-rfZvC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDIwMyBTYWx0ZWRfX0fo13WBwbuXD
 HpqYuDRqo1BdHcWlPIrwUpXXn81M+CygIvXL3b8+abeeL7VWfUdljbrtNsqJpMyoYovp8EwTZwP
 OK2y/jjXmgj0N6nsD+vpBzGc1TKuTGFyLNkzpp9jN3ziKE0R03Mjua4xOEMdHR6dDqjxeaiUPtF
 xXdW49SivtuIAV0TeUy2FRAP2Vclh8au54LIdpZWxy0FmmwJW/gcZlsOIl06PGMYU/5CXDwPwUG
 JkmjJTP1Ej/BMzwJhri4BtPnHci/jOByxcrcUVcUNk5lmg0rNKEg+Z5nQLZ+fg4EA/Ha358KGqK
 H2N5PRqWshrlJT54x3hVrTvdIbfN5QVQQgZY4gyQeu/54fevRWlgdtkke2QjzJzB+fcCno2YGs9
 kkibtcPZkK1gaoWeZwwLBmFJYpasgxBhOnzhJ6+QsINsLQWQfSAZzxYBWgoQ83qAYdSB1JEec3O
 OGCGPqVlSzyg8rps6UQ==
X-Authority-Analysis: v=2.4 cv=W6sIkxWk c=1 sm=1 tr=0 ts=6a0e1ea1 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=jHxIr1HyPKZ_Q5_91PL3:22
 a=1-S1nHsFAAAA:8 a=VwQbUJbxAAAA:8 a=hdCJvu6vi-O6ykQZt0QA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=gK44uIRsrOYWoX5St5dO:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11792
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=10 priorityscore=1501 lowpriorityscore=10
 adultscore=0 bulkscore=10 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200203

Add mm/folio_wait.c and include/linux/folio_wait.h after they were split
out from mm/filemap.c, mm/page-writeback.c, and include/linux/pagemap.h.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8cf9ba51d981..bfe1488d9030 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16781,6 +16781,7 @@ S:	Maintained
 W:	http://www.linux-mm.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
 F:	include/linux/folio_batch.h
+F:	include/linux/folio_wait.h
 F:	include/linux/gfp.h
 F:	include/linux/gfp_types.h
 F:	include/linux/highmem.h
@@ -16802,6 +16803,7 @@ F:	kernel/fork.c
 F:	mm/Kconfig
 F:	mm/debug.c
 F:	mm/folio-compat.c
+F:	mm/folio_wait.c
 F:	mm/highmem.c
 F:	mm/init-mm.c
 F:	mm/internal.h

-- 
2.39.5

