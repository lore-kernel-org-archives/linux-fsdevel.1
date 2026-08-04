Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE4F47604C
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 18:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869555; cv=none; b=M0P70SQ1padztbgDFkhUP9aSxGwxSG4bjZbprOQjk0eA39qj9ulG+rqJ49SrZZx02qbOVePIjsx+7zxybwdu0M41S+8NKBJrILfqUxexk2pl2Iru4aQayq34/xD0+j8v1qNIVv36fja1BCjSc2WZUhMv214+CBXFO4T9E4buaEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869555; c=relaxed/simple;
	bh=9zGm2Ur3Nw8t1fGAniDrK4O8Ro9h7p/uEv8uJfX+ZUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dfU2iwanXI1oB6qtpscxvI8XBtkWlX3fCgVT5GYiRdkqOIHVe3eI7QpbCs492j00SgJq8Wpjqdtes0kkDudG7Coibg4vHk9Rk0DIQTqMQqZu6Q9w8yFLeRz1tU4cd9RuSlNYD8vN0BGhnEVf4yTYWRg15TmRq9bDpD1XnBSYilk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=HY0pFEmU; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="HY0pFEmU"
Received: from pps.filterd (m0167075.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674IY90s2119104
	for <linux-fsdevel@vger.kernel.org>; Tue, 4 Aug 2026 14:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=yedV
	j+u8P0Tmm47FPkrJoqBk2IvRgeJQ6pNoT7nNxrg=; b=HY0pFEmU2udRqNNtUDxJ
	9RSw/lY1Vy7TzmvBYQFFbm40N4EWHwXjduXKD6rPYdsd71ltw1pMGfLRlKg+A+Tm
	EeksvS+7yGHcIeZbpz3F5DcsvH4dB6uY9vtQfupd+eVglKx19C9VuMyTDCGkvwLB
	gniMiWuNavsOszMidxOzzU/aeuza09cTtZR7VTESvwda2biUIollaTjfdJiZ3dPE
	L5PMfaZONppi5iegiAmsn14rGXFS5Ij1b+24q9tudfiyTDVE7d6zTN/lW2/GFaT1
	Pl6n3xbk8eztta/yTTrL0tVMLE+xrrmnzNP2S7pbmok6hsdSwINqqHG6Ys2BASdw
	mQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4fugvdjp7g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2026 14:52:30 -0400 (EDT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c20762d21so1320441cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2026 11:52:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785869550; x=1786474350;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yedVj+u8P0Tmm47FPkrJoqBk2IvRgeJQ6pNoT7nNxrg=;
        b=ivrj9wlH/+Wb/fsTzZiLk6Jwurs0c+zzOD4IyClk6ObyNmf1AcmcWcsRF7190d0k8G
         YVtzVte9jDC5ZfAnCQMsXZEOvt4rXL6NmHl+zSGYZpTfg3PMpXOP8jyDgh7pNEq6n4En
         RO9xw5TBaRbfgsoX2O41bXoNnZIAXNCKj4Rz7znhrxvw2FAxz5W9VJYr3qJQSQJ0e59F
         OcmQop6yx7y2IPEta5MjsE/wSMrb0gBEjzEDxni8lYQjB1n6RT53OocvROzLmpJVbUHY
         x7A5DCyGVz0CTJIJkFbWUAvfCq2uSgc4yuQoeME1UxBGbkSyPVL9bheMvdwWMbrbn9XA
         FUcw==
X-Forwarded-Encrypted: i=1; AHgh+RrIF04E1LjGr0gOby4vVKPhgLvga2bSg28hCJqfdT44/l3GJnY7TQjBUAgxRKUlR+SGiupPfTT7kzK2hyGz@vger.kernel.org
X-Gm-Message-State: AOJu0Yx05lDyKhhmcWI+GFSEww+t/M3KQEQz4wuT6LHiPXV+Aihnf7fR
	pTnqm3d5qNX8mMjV9xzKJplxcHC+oI/gHzXqaj5cZNVKzkO1pVdXfcLmdTHxkfGQjg8VI0G9QZQ
	t1DtPCod5wFxLfg9rM6RRT+vlVebBbeBoeTb26MunDh3nMBvB/gSfy+L3eUHLSN0=
X-Gm-Gg: AR+sD12WGc0foHcD5JFqhRfkaqiHUCYrMg+RnMfb4K+yxqEz7NAMZlZoAsx28rBLsp2
	H0rWNzn5L6dhvrbDBDI5shkm8Q62UIfTc3f80QlRoUiYclRUPzqKjvhO2ez+rR4lcou5ZhLGZvv
	/P3TE1GKoZbGl+kf1fNTj547bS4ce9Lg1qErG1wdXXL4ojNL+bz+Um4oevJhZZ+edteD5cazdTd
	LiZm8ZN2HwJY9nH925/E05ZWB3/Tz8QA8/HYn0XDqMKFVzxC8GGGPJP0xQpigiiBIzcejxcUHxL
	Hz8Fpj7+hMC4hF2P7xl6po7PLVt7SAdbohxrDefraLrqQmST39aucJ7Wy3zKjU9e3hP0sTNZ6ut
	jrDrmPu2k
X-Received: by 2002:a05:622a:355:b0:519:8998:661b with SMTP id d75a77b69052e-52ce60c07c6mr12782951cf.20.1785869550469;
        Tue, 04 Aug 2026 11:52:30 -0700 (PDT)
X-Received: by 2002:a05:622a:355:b0:519:8998:661b with SMTP id d75a77b69052e-52ce60c07c6mr12782271cf.20.1785869549978;
        Tue, 04 Aug 2026 11:52:29 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.77.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec232d7fsm2313275f8f.20.2026.08.04.11.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 11:52:28 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 04 Aug 2026 14:52:10 -0400
Subject: [PATCH v2 02/10] ceph: convert
 ceph_wait_until_current_writes_complete() to folios
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-remove-wait-on-page-writeback-v2-2-81f0ab065284@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785869541; l=1518;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=9zGm2Ur3Nw8t1fGAniDrK4O8Ro9h7p/uEv8uJfX+ZUc=;
 b=YhHy2DJ2mcWRFMayaQHzRWVDDTYASGlGUJSMGAN80QdBcHSVdXLZ5tByq7B/kPH+1jdGwugfR
 syQDU3doLFhB5JzGHt5ToPbjDwQSP/Ct8ZorKaIRSv2e2Bwqyj1AwU+
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE1MiBTYWx0ZWRfX8nHYH4S6Xwjo
 RbNMHhxjjeYAepUHntuXuuNhmNHK8M6mperj0JhIEVeGfLggpCR97wD91LJv4N+FYwjA5XGWhuY
 OmpsKv2LMIthRu/BPSs6V40zRZH3MYthdktAGVFMlyjRuCwujhLn
X-Authority-Analysis: v=2.4 cv=G5Ys1dk5 c=1 sm=1 tr=0 ts=6a7234ef cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=j1J1DEHOHTVaJYOjuVnKiw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=HpS3TJQ9O3Ob1ozEcmik:22
 a=JfrnYn6hAAAA:8 a=oBeIbaJldBQvbLH65vwA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: YbVj1zjPSZQQKX0n8tYviWxk42H9QqnE
X-Proofpoint-GUID: YbVj1zjPSZQQKX0n8tYviWxk42H9QqnE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE1MiBTYWx0ZWRfXw1K34G/L3fXu
 RxhoJkb4SMhjXlFhaaNVLPkbUzOxw01Gv/uNzFyWUA/RNYcNWC0vIi9GHJ6aK8zQ8wcGuvKudia
 jeoE/5KV7sTddm/0fT+sWwy2ihlDNfg4QNH74MH9FgQqim+hCqMjqj6NeWuG9f2ta/FseaIy+cK
 J7Uf4VpiCqKl+ADEA0gjNDZhyzJAreeOIpVEH6z+noVCPENXripU2U1Yn0dUUTUccq4GHopdaE6
 pinz1V2L7hx4+XKNkfRSGpuPH25G5v8JV6X6A1wRpCnPBvNrv1CpUahgL7PvnrBdWuaDE/QUvBe
 RPiEdCeriM8hJoCx7ETA10TyKGgwYWtB2r4/sn6kh3edN29Zx/qHdvsC9pVZYTItunIKtcc/fAP
 LXV19uUObOtuBZti5eWOWVBInBN4w13nkZ4W514mu3KqXo9zjgftJIJgw4R8w7MAWD3AAgJdgFZ
 EUBp72BzhkDrW6xFV6A==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11865
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0
 spamscore=0 lowpriorityscore=10 bulkscore=10 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040152

Iterate the writeback batch as folios rather than using
&folios[i]->page. Use ceph_folio_snap_context() for the snap context
check and folio_wait_writeback() instead of wait_on_page_writeback().

This removes one call to compound_head() and the last caller of
wait_on_page_writeback(). No functional change.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/addr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 8347366ce5d9..967243f425f2 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1624,7 +1624,7 @@ void ceph_wait_until_current_writes_complete(struct address_space *mapping,
 					     struct writeback_control *wbc,
 					     struct ceph_writeback_ctl *ceph_wbc)
 {
-	struct page *page;
+	struct folio *folio;
 	unsigned i, nr;
 
 	if (wbc->sync_mode != WB_SYNC_NONE &&
@@ -1639,10 +1639,10 @@ void ceph_wait_until_current_writes_complete(struct address_space *mapping,
 						     PAGECACHE_TAG_WRITEBACK,
 						     &ceph_wbc->fbatch))) {
 			for (i = 0; i < nr; i++) {
-				page = &ceph_wbc->fbatch.folios[i]->page;
-				if (page_snap_context(page) != ceph_wbc->snapc)
+				folio = ceph_wbc->fbatch.folios[i];
+				if (ceph_folio_snap_context(folio) != ceph_wbc->snapc)
 					continue;
-				wait_on_page_writeback(page);
+				folio_wait_writeback(folio);
 			}
 
 			folio_batch_release(&ceph_wbc->fbatch);

-- 
2.39.5

