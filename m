Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCD73C3F48
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Aug 2026 16:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785689616; cv=none; b=DDK13fFy4ttGxagzeVAKfWU2zMawAOy/FDWnpZxzY/BsjT/7F0g5tEDNHAQSEKrA7+br7p3a0ItFeEMKqfSAgbk0fwpEQsgl//GA1qRjNU7XfNOHDI/+Fz4BEPGxTK+/HkQpueSs4ap+rM5J9YFOGWDNAZAHnIsJm+yfHBdva8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785689616; c=relaxed/simple;
	bh=QqylW3bsSIhF05NLxH45ljAlwMTCLlW2b0M3h7Ydtyk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Suve9ZpZRTkc9z1EqT/uFzOVYsvjUZK00PEjOuz0koWrBiRaMV0ABojE1Yzfq+r+NWnOzKgJ4INv/PaCTV2McOy5dQSf9xzkKqwTrty5E8a0A/JAldQNQSgC35onVgl8HGiljzsRb3mYhil+P87UKGQYJduCUSQ17MKt12GtXos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=GCggjXSk; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="GCggjXSk"
Received: from pps.filterd (m0167072.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672CZ6DS3463105
	for <linux-fsdevel@vger.kernel.org>; Sun, 2 Aug 2026 12:53:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=gxVd
	pvxkC5zPJOy2sGwkp20ewyXEsgwMMwkoFsHT1cE=; b=GCggjXSkylmK9j0b1Jp8
	oP3vczyvYz5vManXcGOZUGpnAR3eQwyYlptq2RtkgZamFQKTR6CERuIQwtPdg/lJ
	YU3rEa2IxVA2JcK3L11HOSw6DrcgmmFBe/itIo5NvHQLi4e82RkV3Fz8/Ek/ZfPJ
	qK5nBCYxhMOFwQXtbCO1RzQVAzlv9TXeIvtqngpMG8hjyG5/mgNBFtYehPoDBaAu
	LHIQG5RNx5PAMEh+jJHUdIhgmJX1OeTKP9SGo2A1c9srlSeGdVfDdPtjWGn8xlkX
	4AdkHPOgB/s+3gheu+wBxieB6FXuhILGq2RdNbBfYj9Ajd9/HuEJJl4QgoJmX87F
	Ug==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4fscyp5hrd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Sun, 02 Aug 2026 12:53:33 -0400 (EDT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c1d137a68so48953201cf.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Aug 2026 09:53:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785689613; x=1786294413;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gxVdpvxkC5zPJOy2sGwkp20ewyXEsgwMMwkoFsHT1cE=;
        b=oLtkBEtlbCbTnXyW89lP/qmh6Ro/EGeFlMFXZAeAyJYi7JgVswBJBs+tZ7pAavXx/e
         CdqUm4k7R8OztUM7A8c+1bcF0fkw4HSuoojbS4XTNVoPjeHBNlA69SW7B8I1z9WH1+GS
         RmesyFjRJ8BjKqN5q2LFAyp4FfRDLHBcB1CaBI5RwUDryqYQrI1Cc17BVBuSKuxTOalt
         Xnkacw3DKgP1AZHaxBMjran4D6RoEt5XKGklpjiN9m+TV9txOs3hg2PtG1PHqBh+bnvQ
         fbEIJL+t0DmE0lday8yCxvQv2VB8+xkr67jY3LbEUrblcKXBzoD5Et6IOZoJ4Ig211Bc
         fFkQ==
X-Forwarded-Encrypted: i=1; AHgh+RoI7Y8NvtlWQbRwPkj6X00gvGCYNY71OhHoVv4f3FuU9uc6SQxMNbqkAVttrPmrKVGrLqZG2XbDhncOXNZe@vger.kernel.org
X-Gm-Message-State: AOJu0YwLmG/QZQMdYJarzhYx25dQ9tie273FTnaj/5IFyGRFPCX8bDha
	kZeTgb4Z6lLQmfiIwnLxb4bDgYSGZNQcEhDI/W/JiYgDdq6gPkSqTe8dnS+CoN0xQ4E/yaaJspR
	Z1N4BnjqI5LqiCLoKF6uyX0AJGqcCkSGQd9xG9u0P9RJAefYJI4TKg1/KjIcowkg=
X-Gm-Gg: AR+sD11VVDZ+Ajvr33YsWwSaPpwZyTdWWXtBWZrY4mgNWXZuJAvSBUwxrxDompBrKFZ
	0gFYtakciF9ferFx3l5rWkp/mDglxQohvViAJbTUO7f/6cE/mPfCIpTW73vQZz2u2iBV/LE/VSj
	5mqrpZOANjLBHJGfybhgwxr5qajC9zLjEYWIKp0tJpQuMGJrmgsH/MqtDcUcKE1mAjrAsVeAHVW
	aBk4/LshoX6Lbe7Wy3SgMNatvqvclSveW0jDstKNSEu2QaRPYynENtREao/sh2m9OBafPf9oRJq
	h5cbpwABXZrp2m8hYi7yy8I7t84URwjphQyDx23ZB41KwJLPYcU6xVODddiRaJ1ULP8dWd0kywZ
	3+2UuTmkldph4giO3I0gM3BkM1NGiavKDNNbMLGKGyy1RA8evH4o=
X-Received: by 2002:a05:622a:2486:b0:517:736b:e0c2 with SMTP id d75a77b69052e-52b5673f0b6mr159137701cf.27.1785689612919;
        Sun, 02 Aug 2026 09:53:32 -0700 (PDT)
X-Received: by 2002:a05:622a:2486:b0:517:736b:e0c2 with SMTP id d75a77b69052e-52b5673f0b6mr159137361cf.27.1785689612478;
        Sun, 02 Aug 2026 09:53:32 -0700 (PDT)
Received: from [127.0.1.1] (CBL217-132-158-98.bb.netvision.net.il. [217.132.158.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a0c8bsm24064574f8f.34.2026.08.02.09.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 09:53:31 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Sun, 02 Aug 2026 12:50:02 -0400
Subject: [PATCH 1/4] ceph: add ceph_folio_snap_context()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-remove-wait-on-page-writeback-v1-1-6c35d6b3ad36@columbia.edu>
References: <20260802-remove-wait-on-page-writeback-v1-0-6c35d6b3ad36@columbia.edu>
In-Reply-To: <20260802-remove-wait-on-page-writeback-v1-0-6c35d6b3ad36@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785689606; l=1979;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=QqylW3bsSIhF05NLxH45ljAlwMTCLlW2b0M3h7Ydtyk=;
 b=dxZbHRsFgGPdfbaM7ZuaRZB4wbT0T9ysMyProgY4c8BR9d6NCgfGc+G/TZXj0NJTYAzcPrmn9
 AlW+bBeNVYvBE31GxwJr7e7QgAOWIYuQLUSYFlUILQVrkd9oIz1kjwh
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: EP8KOYNsRECVVYMviO-V_dWCKAw5Piej
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDE1MyBTYWx0ZWRfXxjOBwwbqUQE7
 gdXHdAN+qv+Xvqoy3UF8QZhvNwawlxHCqUoi1ZWds4a+qtjkhX8wIR/8ijehZTquyfZqFipw2Jv
 uM6e5OWLk5ulpqcrS9im8bL+yADujlKXI/3+cW3jbbF2VyhKMRzZ
X-Proofpoint-ORIG-GUID: EP8KOYNsRECVVYMviO-V_dWCKAw5Piej
X-Authority-Analysis: v=2.4 cv=LJ9WhpW9 c=1 sm=1 tr=0 ts=6a6f760d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=C4zMR0+CEq2lM/mtmjScOA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=SsB-OO3BMngHh3ZO9fOt:22
 a=ALYDsW89DncSylXEcn0A:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDE1MyBTYWx0ZWRfX+j309ee/INNn
 MgInzsP/ul9kn2NNLWHJUiHHRInvwMIZ8V+NYqgGkX/Nkro+5u//WZEvg+DTF2aS4ogMsjNjEzo
 YDW7nZ3ra3q5cSKpottSI2bCJHnnrCnmaZ5vvia2tUgW2d6GPIYqsEAJXx06X+NGc9P1j/7jZtE
 Uzv7D+B8zeaL2unxh6ZRdwuXC1LWYOuS1OSUqu5Du9lqQ5MivU4gfwCAYgPQxFpM/Vtn+Zc/R9N
 0a/Qym0RpfHR/ZKhnSmc5LnyPYRF/BW2Pe3qP/zFbmTypRvNiF4q1eTqMxgtXpBeNR5BpHc9Y9Z
 RTgr2nuSZE6ZMhTkQ077Ecv+b69UjM/8ENrlBHqFGHZu3J5g33MPCqm5jUsKCi6+30OdRtsZNEx
 CyVri5ZgI1konnBCgmV8iFqlNzr44oO3A9Zm+/btz8qxD/m5OqA6WOAG5Ut0D8t8PGZ3Z1y0rZo
 CAAowcHl+9dIIuIo0KA==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11863
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=10 phishscore=0 bulkscore=10 impostorscore=10 spamscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608020153

Add a folio-based counterpart to page_snap_context() that reads the
snap context from folio->private directly.

Convert the three writeback paths that passed &folio->page to
page_snap_context() to ceph_folio_snap_context(), removing three
open-coded folio-to-page conversions. No functional change.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/addr.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index ecf33b66610c..a8ed2a14da44 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -75,6 +75,13 @@ static inline struct ceph_snap_context *page_snap_context(struct page *page)
 	return NULL;
 }
 
+static inline struct ceph_snap_context *ceph_folio_snap_context(struct folio *folio)
+{
+	if (folio_test_private(folio))
+		return (void *)folio->private;
+	return NULL;
+}
+
 /*
  * Dirty a page.  Optimistically adjust accounting, on the assumption
  * that we won't race with invalidate.  If we do, readjust.
@@ -745,7 +752,7 @@ static int write_folio_nounlock(struct folio *folio,
 		return -EIO;
 
 	/* verify this is a writeable snap context */
-	snapc = page_snap_context(&folio->page);
+	snapc = ceph_folio_snap_context(folio);
 	if (!snapc) {
 		doutc(cl, "%llx.%llx folio %p not dirty?\n", ceph_vinop(inode),
 		      folio);
@@ -1171,7 +1178,7 @@ int ceph_check_page_before_write(struct address_space *mapping,
 	}
 
 	/* only if matching snap context */
-	pgsnapc = page_snap_context(&folio->page);
+	pgsnapc = ceph_folio_snap_context(folio);
 	if (pgsnapc != ceph_wbc->snapc) {
 		doutc(cl, "folio snapc %p %lld != oldest %p %lld\n",
 		      pgsnapc, pgsnapc->seq,
@@ -1824,7 +1831,7 @@ ceph_find_incompatible(struct folio *folio)
 
 		folio_wait_writeback(folio);
 
-		snapc = page_snap_context(&folio->page);
+		snapc = ceph_folio_snap_context(folio);
 		if (!snapc || snapc == ci->i_head_snapc)
 			break;
 

-- 
2.39.5

