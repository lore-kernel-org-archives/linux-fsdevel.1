Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE5B3FE37A
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371693; cv=none; b=XU0w9sDCrYFyZi+p7aJF2Gq/LozFJU6OsKYgiBcLGQiWAYfHqoU4pOkogrAV/7eGZek5Xn+zVkH6jCrB1Fqk12CCbF1+/UQug3kYmbIPduZDm1rclGnJ4TM+S0TJ2jggiHzjGY0bwaYKxd98j50ACerbwuUiamE6K3cGOMFpeEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371693; c=relaxed/simple;
	bh=l3uEHuwNVk6EU1qiSYF/Q0V/FDAY448POx4+1dXVCT4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NBnBiKq2oCXqGRnC7mbIRlPEVqwM5oaGIvsL5TOS28pRWD9/5vrUyv/SPCMVH58hNFcfwcbD5YBKZyivGLuJik/Tp68WXY2tCrZD+dLkmkn9jfR2jffdFhb3XYDLzBK69nMV8m0mMG2svxjCn/5E8fdv1YiKIXzZTr2kQyKOsuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=seVJQEGw; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="seVJQEGw"
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67ACaHX93029446
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 10:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=jW8u
	Io9mq1l2z2LJqV2kSeHNoorVMZ6STN4QBox7XYc=; b=seVJQEGw48BgY3Nu9Psy
	tQQuCjl+9yc5O8F27BW5VVwDRtmwyNqign08Gujtt587mOgRMxa+TxRCOuvFzAnX
	fACFqvlqUg77CEbTfrcUVjEnc8Y6hvJN7VIXP8gLteGpb9S/s/KI6CFbScKO5rjC
	G/x5IJZj9UQ5RaWoqT5+Lj4qgWKKgWh7//KaugA9v8ccpAW0gYdtFe43jwh35TJE
	jALRLyOj+M3yxht9j6PmS2DQzBA+7MAFLMhpgJ3ygC+kWWkUbT1UQsbLUfrnXY41
	7rvVKVvDB2euC0f1HgOUVS4OClT7f7vdAbYXTfWHd2TpVuOZokMPmw9pNqHblRnh
	1g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4fxv0pvdb2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 10:21:13 -0400 (EDT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5174a23afcbso23003001cf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 07:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786371673; x=1786976473;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jW8uIo9mq1l2z2LJqV2kSeHNoorVMZ6STN4QBox7XYc=;
        b=lVcmqI/n4JJ87RWooe9QuLfzHjtjHbETaPDLkhOsmJzrGAxUvjog5t3A5axxGwEitt
         nZAl69urad1S5GPOc2EQvKTyWxtshC90e4RGVsiyEtMfjOexX9VTsZaHM6HmJR4DPOz0
         USz9aNqDsN4oRdkie6KI/LPUKuOIYA5c+IGcVf3wchqIw9UNvBn3goDQ/DC6y/ME6fB+
         CVknbObevhasVEnnu3QTHUufZq28NJD99hXJgtESgUW/r57OeM+sLtrpOIVDt6giSexu
         PUfuvHJvptBcKKdXKRt1ZRF0nYAKTpeT9KgjOV/O21hEr9INudsCMpt1sRnrnzPyTp7v
         fTwA==
X-Forwarded-Encrypted: i=1; AHgh+Rqu/wjCPBCDfXQesQ6XPQRdZRe0dgBIqWmOYTTMBFLqOpHZk6+p5Ppj5g7y1mYXcIJUvemZ3ik6g9VroBbi@vger.kernel.org
X-Gm-Message-State: AOJu0YykOiDwDdNsGDOCmGagNIihx76o9OdsGypf5H8hA+Uj20ArLbit
	0UU/HiEWXz5d609/5ZgS4oMFwPwso0Ner71U/9zD20zawWIRDgEGUjdGJ+Z8HozL/O6948FNZ/q
	7+kL4F/oVXPtHUT5CLv8RS9Q41YgvJfNt2/1ycUCIl3hHVRfXZfgsBQgSsMez644=
X-Gm-Gg: AR+sD11vSZmdqaEh2YB5jxkBmAc5OgkQN12olN/WjspPMKBowJHQvexRzX+cB/Pd6w8
	O2NzH16NVvv9iIn1OKu3akOs0os289ZOQAidn2lHUV2eCIwsx7K56vdBe68JSVhiPmSqEKoyRE4
	pR0wM0vBPrBEkD4p6hTVI4TM70G33bsBpFT2OQ5WarnfRB03M3rR5OsFx08HDXhFEpt0Wv+0Vod
	SlVo0Li7RPSIZksvhOdtbZ52/YdsuiuLk2VhyJI2PVCpMBBrW8X9VQBfylJ86qG95QOt8banAWo
	F7D/rgi+yp9ZwIuMf65sb+uP93Tp9NDAiECXof+wT+fZ9BIBlsX20kuFtmAAXLP04uRtZAWDP4K
	BgfcYzMkk
X-Received: by 2002:a05:622a:581a:b0:51b:fe7a:4eb8 with SMTP id d75a77b69052e-52d1918e143mr244244961cf.35.1786371672722;
        Mon, 10 Aug 2026 07:21:12 -0700 (PDT)
X-Received: by 2002:a05:622a:581a:b0:51b:fe7a:4eb8 with SMTP id d75a77b69052e-52d1918e143mr244243051cf.35.1786371672052;
        Mon, 10 Aug 2026 07:21:12 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.77.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002145589sm37383983f8f.1.2026.08.10.07.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 07:21:11 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 10 Aug 2026 10:20:15 -0400
Subject: [PATCH v3 04/12] ceph: convert
 ceph_wait_until_current_writes_complete() to folios
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-remove-wait-on-page-writeback-v3-4-dd7531704f26@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786371655; l=1518;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=l3uEHuwNVk6EU1qiSYF/Q0V/FDAY448POx4+1dXVCT4=;
 b=MN0UzA0s4wH6d3PLNpiFNlpzeBQU1Ayj1yl+dxXmrHHGmwf6FOlt2/PLR9CC+k7hpkkVwBz/A
 zWPq6NK5C5PDacjs4Oon93gHT3vjCh1ok9uHfjQLVsS+prVu7VChuak
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfX7Naw+memctWH
 8LRDqCGSj/q4I0Rdz4EYKCaiKoOB47zSbpF7COycDVIfnhVSi6dsBg1hf04lnuV7YojcR8a5Upd
 R6FqgSONPNFgsJBk2u8jbfufDpguuw8T2aRFILPK7Gk/x170UrH1
X-Proofpoint-GUID: _Fbx1TPyLsO3FRlQhHPec6NEvMFogKz_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfX2+3i42ztgySF
 w6Qx7dn2EekjeKffLisnTq8YSiqwXsqEHhhYFunXkHcumg838uvGfvujN3i3VUTOfJtkAqFg35T
 w7oVYq6e/hbuU1BEGQF1iMrqRDxCZaYdZt19pCja9BanYbXhCeo83G8NKt2pg1LNftEJNqyBDid
 ENgfvjo9vrITa/+Do7UPY42zm4iX+DiWIJ0F3dv7XOnzleT33/W8jiqhm1l7AzkdyRkl9c92rw6
 p63+Ergajl7eQXdNpWgvqidOR/e4KhZBE+50OSXgtAFTMEIT4wWGuNKiVm6UHpuAuEON0Ge1DKb
 gYBSVmJnHc2zlsAbcPmOVanRLuPGDQni5/97HOENXJvqLy3cGiPBAmLtSGq5LEXC0xw7SinvadE
 x3j8D+crPwfVeDVo1sgxCtzjZdz7YG64Qq3QprIPAUSMgy7GOnyTl38mPi31gLkacH27/k+h4YP
 Dk8CvSpDGTzkXbu7vZQ==
X-Proofpoint-ORIG-GUID: _Fbx1TPyLsO3FRlQhHPec6NEvMFogKz_
X-Authority-Analysis: v=2.4 cv=dcuwG3Xe c=1 sm=1 tr=0 ts=6a79de59 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=zHmcO6jMd5r4EZ4U0P0LQg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=JfrnYn6hAAAA:8 a=oBeIbaJldBQvbLH65vwA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11870
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=10 adultscore=0 priorityscore=1501 phishscore=0
 impostorscore=10 spamscore=0 bulkscore=10 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100123

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
index 3d86e4c85b06..c08fc70321e6 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1637,7 +1637,7 @@ void ceph_wait_until_current_writes_complete(struct address_space *mapping,
 					     struct writeback_control *wbc,
 					     struct ceph_writeback_ctl *ceph_wbc)
 {
-	struct page *page;
+	struct folio *folio;
 	unsigned i, nr;
 
 	if (wbc->sync_mode != WB_SYNC_NONE &&
@@ -1652,10 +1652,10 @@ void ceph_wait_until_current_writes_complete(struct address_space *mapping,
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

