Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB4B3FD941
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 14:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371689; cv=none; b=Kpv6yxkc3IvpfLpXLZ64XyDOsdnfnoMgkb7O8hfKe5Dsh+ffS7jAs1I9mlLdWpDY/ioUW0deg1At2v+NwNuxAs9ffFTAtQRMOTgRmhAVe1G7mlnDUo0Af+egbY3hJpCijE75o3t6HIjUKQaPg0KCitJkbnWVCZmr8N06jusfjN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371689; c=relaxed/simple;
	bh=7O7yrVN4O0oLp3x/dLZGdiLj0pIUK9KzDcYDRFGgB18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UYnvqfFdOgXtxV85GPiJ1ga93gKak4zic1v7u5aMsZ2iTc7dcgx0KHULbq+OiEANQwH0oci7+jz9OIh6k9rB3/2sYH2DCtRmvJXN15WS32XUn1w5EPlmEMJjehn+6aorSxKeez9LjLlxwZJMXJu0d69tWMO18nWy67m3XBp4qik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=p7UYcBOs; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="p7UYcBOs"
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67ACaGPZ2721642
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 10:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=lZAV
	MDkDi9w8ZU6GK98RKcAV+HW3xUm2lluu/vojFZM=; b=p7UYcBOsaLr+pPgsuvLr
	R/MPvSANKRo7h+FTvLCjUg1W9gLw/P+sbm/usRn/2eddqqPspDB0T/nNH5kDnGWx
	WUhUaUmn2aQFPpG7arLYdteqS4NTxG8HBirKP976dPJY16902eRjwjbBIKybL1x4
	oz19MiM7Eaa37ABKsOoxc6eKS50e1dzLtzq6Ik00JFAI8wyJh1IEj3Lmy8vSG5xu
	+yRZ+mykZkceaNeTd5w4Kn3cb4zVT5SMe0CDw5x56ZVuMZ6SytgY0rho0+ZaDkpB
	QzErQ54R0Ev1ZPJMs1/Qf4lm8vz4Zih5lVgjEQIpHA8IERJjMSuuLVB9bOSwkMO1
	Vg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4fxyvd3gv7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 10:21:10 -0400 (EDT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e8004d60eso321952685a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 07:21:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786371669; x=1786976469;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lZAVMDkDi9w8ZU6GK98RKcAV+HW3xUm2lluu/vojFZM=;
        b=JbzfFMaB/piBPZaOTYG8X/uZpoSr6ofepZWfWlAWKpOtYf+Fcf9v2lMde9Ygxqhyvi
         6VZilWkImwAi9TyWepzbjaHpvhJB2MK8VSnhhPVp28K1heCu0kqhgfDnH9d0LC5GIbFe
         D2dEyPCh/IdSI+iEognNF3diELeyazSjuETi7Mxekz51OyMu6qc6ClprAtE4votn/WLc
         at17VB9tDwKCVK6Tb50eVi3Znen1U9o3k8OLL4DX31nnSmadiOngV94BrsQ4gpc2JLb5
         +KrRefgnd9mYnIBr8LsDBlGaFw8jAsusVDbvxAtg2eog9iMB9ELFEYZYisYkSTLnw46I
         4Owg==
X-Forwarded-Encrypted: i=1; AHgh+Ro2MjfA3KEMRM2lOBwBJmCs1QA2KSpB0gO/5dcZmjcuRroGf3Kc4mTm94Xotg82dDL2uugKQlO0BO81BRZ2@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Y/AVfp41CdhFyf3kF2Kkx4mX2hxqOMutysaRHHnm2XSbPprk
	RYduje3JBYVIFU3uknkFpYwjDOf4HqJJhj8P7DZBqQzW7Xtg3po+S5ii+ZgRGJOK6v8yfevmJ4T
	wSQRoHO2t9Frx2sc8kIn/13S/wfIiOWVtAmch/nV0HXNrvGTZzhedrKZxObnUFKQ=
X-Gm-Gg: AR+sD128mpSG/8DCuxggoJgSfU2N7S5MFEu8KrccEo5pk5/LbKStDdTasfI1faRWCe+
	hcGJNXljX61oL90HFxu7iB7vJMxRgaEMl7qtmjh+d35ef+I6Va9yl1YyGGUXP6PWjOHCJe5aCoz
	sfs7DshwcTqw0FvLcQYsaF5PjmUDKDoZnBDdyJ6gver8JAaSesfI0FUc6MRsfzIbvlVIx4ebxZp
	VQYeDuRfY+5gpOnZHUoqxOT8mzEhr4WG55OZj9OhFyd2KnjhYTzq2hRXMblbOKTHsRy46hLiSW1
	Rxva/cwLC2PPGONTLdVuSd7JcpaPB5sqrIE3/VHm2FHgpiJ+ssuvNXYC6G3Ixk8O8xA+89pg3eY
	YdwB183ue
X-Received: by 2002:ac8:7d0f:0:b0:51e:47a4:4851 with SMTP id d75a77b69052e-52d0b003eafmr297600251cf.8.1786371669558;
        Mon, 10 Aug 2026 07:21:09 -0700 (PDT)
X-Received: by 2002:ac8:7d0f:0:b0:51e:47a4:4851 with SMTP id d75a77b69052e-52d0b003eafmr297598971cf.8.1786371668881;
        Mon, 10 Aug 2026 07:21:08 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.77.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002145589sm37383983f8f.1.2026.08.10.07.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 07:21:07 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 10 Aug 2026 10:20:14 -0400
Subject: [PATCH v3 03/12] ceph: add ceph_folio_snap_context()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-remove-wait-on-page-writeback-v3-3-dd7531704f26@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786371655; l=2021;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=7O7yrVN4O0oLp3x/dLZGdiLj0pIUK9KzDcYDRFGgB18=;
 b=3gSQg6M47bO2pgURxJWAmFQ4PnvlGi8AWeaabt5bNBcjpfLt1y0znTJf5ZvHSRcsXLgqlAj71
 VOCHDcekvzuBKKOjVXYC/adYE5gwRzuUdjjSiA2b/54HZ5bpM8mfi62
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfX6icQnJxvhabU
 ypAt5Rh3VU0LPKOyuK6PUknucH4VnrFxwqHSaDzFGXT61vBqJZ67kxJBiOkIJ0te9UWuzKpWT8g
 HoNMcpFsIyrjMoCux1fK4T69OkArJFP0QPvJ5ho61k97mDg84YbA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfX7dNnMkDkHD/K
 /5uIAo9AD58L7FzBfBztHZdJVXOQlSSfUMGqIT1sI4VO92ZPzToDbIFXCm04v+UIDctYKWqQqTD
 IhisbmopnSjH3g903t0V+N9JOy6JdwTS3i+dZ/SoiqSnArKcHTaKfpUPDSkDYFFQOboHpzb2bPN
 HuJzI/K5Tdg5EtBUWrtjR0YuEwDI5LHv4TT4tMOxOp8vlA3wOf/SMJ0ZDX/fUIzrlqdpgLwgY/n
 iYXwgpWzdoQ9gi4i+jaKml+kaHqJTx4lDe3Ao+t2JJqKSOT38AVU1Vu49PXWH2AluM4Ior3eCpz
 FkcfO5OaFgBUetXBPGSTC8RczMkRr5XTwsxYpLIatulaIh0MbsPENQDpBgXoDQ0yRg3266243Bz
 Al/t+euJVyR8lZUYR+3z4L2gNPrE/RvE2RsrWSb41NU0qKdorupop8qdZ1s1+Qf1gfhxG8Qiw4j
 jI0Q1VauAyOUAlKnT7g==
X-Proofpoint-ORIG-GUID: sT8fx0EZhZSTPdqnU0uMM3wXd_BGKVUz
X-Authority-Analysis: v=2.4 cv=Gb0nWwXL c=1 sm=1 tr=0 ts=6a79de56 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=zHmcO6jMd5r4EZ4U0P0LQg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=svvvyxlR1OQQkelhaPoB:22
 a=JfrnYn6hAAAA:8 a=Ikd4Dj_1AAAA:8 a=bg0B0yAPDd754FioS-UA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: sT8fx0EZhZSTPdqnU0uMM3wXd_BGKVUz
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11870
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=10 impostorscore=10 suspectscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=10 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100123

Add a folio-based counterpart to page_snap_context() that reads the
snap context from folio->private directly.

Convert the three writeback paths that passed &folio->page to
page_snap_context() to ceph_folio_snap_context(), removing three
open-coded folio-to-page conversions. No functional change.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/addr.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index de0113b23940..3d86e4c85b06 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -75,6 +75,12 @@ static inline struct ceph_snap_context *page_snap_context(struct page *page)
 	return NULL;
 }
 
+static inline
+struct ceph_snap_context *ceph_folio_snap_context(const struct folio *folio)
+{
+	return folio->private;
+}
+
 /*
  * Dirty a page.  Optimistically adjust accounting, on the assumption
  * that we won't race with invalidate.  If we do, readjust.
@@ -758,7 +764,7 @@ static int write_folio_nounlock(struct folio *folio,
 		return -EIO;
 
 	/* verify this is a writeable snap context */
-	snapc = page_snap_context(&folio->page);
+	snapc = ceph_folio_snap_context(folio);
 	if (!snapc) {
 		doutc(cl, "%llx.%llx folio %p not dirty?\n", ceph_vinop(inode),
 		      folio);
@@ -1183,7 +1189,7 @@ int ceph_check_page_before_write(struct address_space *mapping,
 	}
 
 	/* only if matching snap context */
-	pgsnapc = page_snap_context(&folio->page);
+	pgsnapc = ceph_folio_snap_context(folio);
 	if (pgsnapc != ceph_wbc->snapc) {
 		doutc(cl, "folio snapc %p %lld != oldest %p %lld\n",
 		      pgsnapc, pgsnapc->seq,
@@ -1840,7 +1846,7 @@ ceph_find_incompatible(struct folio *folio)
 
 		folio_wait_writeback(folio);
 
-		snapc = page_snap_context(&folio->page);
+		snapc = ceph_folio_snap_context(folio);
 		if (!snapc || snapc == ci->i_head_snapc)
 			break;
 

-- 
2.39.5

