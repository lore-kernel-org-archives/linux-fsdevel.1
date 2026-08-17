Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39AF43CE46
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 19:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786994128; cv=none; b=rSZBBBz+FqgmlKQvF0SHc+PMxKijTSnksV5+IOVRKUmlXgEaeJck46/F9KcBs21DFVKHN4LnDk1zz7M4wdy0Qn0CMoyDvt3FgjY34yXnqBMq+SBWhoFSWN0fKni7vzyqemF7fA2oekADWiGdi6QtIuRukqFuY4CUs5RKTG8yCsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786994128; c=relaxed/simple;
	bh=PR2WJRorXsFJP25q+ha589sxpEGLHSUrsTYvs7exL2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kYzaTNvIbsUQbao7S+WsExgHF21ZNgELtv5Q3UzHHHXXGQdqC1hbrVTrDRMtVZDarTmWX4+1/rgO4FTXEA2Gdwk1IwDpcpEqfs6aMevAGzcw3Omm3gQd/T792Y950d196Cs9TW6FerkMlY/VpzOFeOg8WNCs99UNkdS682nYdPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=LCWw5JIV; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=B/uDaFPP; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="LCWw5JIV";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="B/uDaFPP"
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HIZDZ33665032
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 15:15:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=Dggv
	ESa2CSpFGON8I8M+asVXtRP298nD3FGbSrEXKPU=; b=LCWw5JIVGwNwlQ264hw/
	16CXJ97dztxkuxphSfp+yufad1UQKR+KFb1x586lzjDl/e+ek5Kl1iQptAt1xg4M
	cqHM/YeA+9lFNfY/a1WJZT7yrwIb/1DpDAW2mSiv8jYy67FcjGnAK2v2ZVSOJEAC
	kZPxB7w9HhiSM8Q/HIFgS2tgl59CjWuVy2/4tRqJhWpU1hmDGXZHE/xAWo02IRs2
	FOuJ5JwmYvwtw3wvHDY1guySZR6t4z84TpTV9IqvwyoTBCXGY/mOv0aysZXDcF+F
	zewbiYLDc6ifqu4QB+knUGJlLDrDe1C6moCgZLImDhe+OeIYJaScAO07TwSANqkk
	sQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4g3mkfnqf6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 15:15:20 -0400 (EDT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-52d8243f1bcso2399691cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 12:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1786994120; x=1787598920; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DggvESa2CSpFGON8I8M+asVXtRP298nD3FGbSrEXKPU=;
        b=B/uDaFPPBjtgueEDNFZupmJrLS6haHXyr3+sc5cS6DSlnhSYfQF5v5TQcuL+sO9UCt
         hD0Huz3Y0azs2OtVSr5RnrNK1PV0P0s+ouueqyMwk53dZSNApTZjYr/J7nOUzcNzjG1v
         9wdvMFV4huTBHaRsnYVYgfF2/ITuYdDWuw15nokjM98QlvO/VgxkHfEfmqUl8LVJUT+h
         kWtGUdOffhiol+oqchMIM46FmO6QdrWIBXutfpKdspMwQaCyTeAQ4ROYV3X7rtgdSQ5f
         ZIvidLMfinx9hqJ6VY4jyGLkz20wwrvQ+PVvH1N5WjWvPq5NNy8LIasQxblffAXCtD0C
         iDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786994120; x=1787598920;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DggvESa2CSpFGON8I8M+asVXtRP298nD3FGbSrEXKPU=;
        b=kl6R+EMSh2+dgA/AdmXKl3qDS2V2nVfvdlzux26ipeFkE89xk3t980y+NP5Dw9zdZE
         eo2pBa9e0TBR9SaAGpdfSNy+ihTtvkJ/5TsBKGAXnDWi/0nMDGOiMEjkSy8gt8vLsUfP
         CF60UPTeCiGLRuFNMlttGMsQRDf4J/2ynExRRrvyKJ3btzw1bT+YfAZULz74op+pSt+a
         wIvuuVrhgZ+CZzUiP2bsmzKsNkmLNqBZXtwAbPuGlrX45FfAoMxInCNshNyvks466Drf
         vzZqo4BKLGEatf0d+iGJRpUWM111ccVVDZmiadDf8g0s5rnwTxEQ+0OgA7duveZZxn8A
         9GRQ==
X-Forwarded-Encrypted: i=1; AHgh+RpaiUDiy/h/1uofqHiUzaY+NsmOYQxAErt7BRyS8n/XeZlXloAX/io4vOoN7l+Jspy5aYMXPC1wc/5guAHk@vger.kernel.org
X-Gm-Message-State: AOJu0YyfyOIfTTdA6PhqzpL/pZsqKp8CKpGO/FA2o6tFRzzqt34bp8A0
	z98eVZRvsJ7o0phO9/j0HZ5HYfcjMj6wHhoFGMmYDYbeSIkpFu9jJvzMbXBWwvJrZIAZ3iyRkrl
	ca6B+ZlJp5yCQAdJmh9jQVgfw16oC2uTK+kn3e6OnDO2Ud9QxQDfz9+jcQ89GKf8=
X-Gm-Gg: AR+sD11lSAo+m7yAZ6e81OP90XY1KKjQ6R/GUJwzOFGJCBczNq+RjAToN8pu8qQpDeN
	/N7vppGixFLmZ+4B0Etxqb9PTAekhCJKCOEz1CCEz5D18t6yxrUMQdhvjQPj8aPHe9Z6qKsXgH2
	+qSWH69gh5ZH+xuhobQOvfYWIv7nIUWBiNPGYle2Vf/sPBX9yUdvoFai6t1oGI+0KHOqzsRfqWR
	kEjLg6rnAC5RG8m44opaLRkyUTeu7eaNptBIrBTsuWsee8D4LJxU349Sm7sTVlttsn7oFq9HyN8
	2Ugv8YGoqQbujabVM8UplmFDIJfhMEZeJD0ZdU7cM/VicPQAG3jGX8LR+PY4z/ObaqGHPTK4nvL
	JFf9/1woT
X-Received: by 2002:a05:620a:a2cc:20b0:934:b798:c245 with SMTP id af79cd13be357-9370667ddaamr124716185a.16.1786994118875;
        Mon, 17 Aug 2026 12:15:18 -0700 (PDT)
X-Received: by 2002:a05:620a:a2cc:20b0:934:b798:c245 with SMTP id af79cd13be357-9370667ddaamr124708885a.16.1786994118444;
        Mon, 17 Aug 2026 12:15:18 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.67.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499961098cdsm194692085e9.6.2026.08.17.12.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 12:15:17 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 17 Aug 2026 14:55:17 -0400
Subject: [PATCH v4 01/10] ceph: fix error handling when the OSD client is
 stopping in ceph_submit_write()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-remove-wait-on-page-writeback-v4-1-0e5e53d47eb0@columbia.edu>
References: <20260817-remove-wait-on-page-writeback-v4-0-0e5e53d47eb0@columbia.edu>
In-Reply-To: <20260817-remove-wait-on-page-writeback-v4-0-0e5e53d47eb0@columbia.edu>
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
        Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        Tal Zussman <tz2294@columbia.edu>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786992937; l=3647;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=PR2WJRorXsFJP25q+ha589sxpEGLHSUrsTYvs7exL2Q=;
 b=MiiNBNV2/TEXmunVAfFweNzSbK1tOrILyKq6hig9fRhHD4mptc9CP13bSnvq9tUhn4BJarq8m
 zyRitg3Xmy9CS5XcwYpEcwgBOKrL2PtxpNzgf7r1WjjZkGT+5QUzJJL
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE0NyBTYWx0ZWRfX4JRYKTs0jnWC
 dAmO0WwLI2VLA98O5zQYp/zVpnzgh9YdGXYEpAY13qLeY8zsl2iaSrjWvt9j6KiTYPvUks4w73O
 t1RFQuzPlg2RyaG6xbkyKsjQQzpI404WGu/euTxGlFui6c77JQ8n
X-Proofpoint-ORIG-GUID: E0b-AwamH6Cvo8AO3ooxoc4w9FDw50Vk
X-Proofpoint-GUID: E0b-AwamH6Cvo8AO3ooxoc4w9FDw50Vk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE0NyBTYWx0ZWRfX2q7Du5wtpsZi
 SqmRWipP9fxapoCJHDGgf0UfcaQWtAxSad5DTFcz245AfPOe8Gm+D3n5VJNOqTFb4tBJLhQUvbN
 kCxg4ZAaoHXmhWSWSS3LlWcjSHpfLD+sTZWfDbFxxsYn8C9+5kjNg98WGRB0syMLQI/EsMhgn4S
 C6G1JSU2XfRsafuKKN+6rZtqNcG/JrhnosZOIvDxDYXIA7kVqc140GFKbfGi/L22W0Q0PnwVXMU
 HwpdCBBJgBrmXXzbl1eC1BhN6cXctxA/MieeVQXdVDpqhx2vQy3NPuDk6pL2YAfhMXR2wOHRAbl
 eDXv/fRNE8nsJFoKZ4l+0l6f9sz8zzLmfLUlqg51wnBL+aAAJg5N4fiIQwaQtjFhYLj9kPhGfVS
 5dszu8FSzMJfrrjfLvrswkwcpusE7SP+QPZpDyHAj/pFGEcWcBHnpbF12OZ+YFyoyGOwIqt8sH1
 VyyOr7hCwzGUglEo1Gg==
X-Authority-Analysis: v=2.4 cv=C+vZDwP+ c=1 sm=1 tr=0 ts=6a835dc8 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=+gpNN1aRt999K7yrv1sWlQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=W980AcPXFMIW1GselFUA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11878
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=10 impostorscore=10
 priorityscore=1501 phishscore=0 bulkscore=10 clxscore=1015 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170147

When ceph_inc_osd_stopping_blocker() fails, ceph_submit_write()
redirties and unlocks the folios remaining in ceph_wbc->fbatch.
However, none of those folios are locked at this point: locked folios
were moved to ceph_wbc->pages[] and removed from the fbatch by
ceph_process_folio_batch(). Unlocking them triggers
VM_BUG_ON_FOLIO(!folio_test_locked(folio)) in folio_unlock(), or
unlocks a folio locked by another task.

This error path also returns -EIO without fully cleaning up the folios in
ceph_wbc->pages[]: their references are never dropped, fscrypt bounce
pages are never freed, the writeback congestion count is never
decremented, and the pages array is leaked. ceph_wbc->locked_pages is
also left non-zero, so ceph_writepages_start() loops back around and
hits BUG_ON(ceph_wbc.locked_pages).

Leave the fbatch folios alone, as ceph_writepages_start() drops their
references when releasing the batch, and unwind ceph_wbc->pages[] the
same way writepages_finish() would have. Abort writeback in
ceph_writepages_start() instead of continuing, matching the handling
of ceph_inc_osd_stopping_blocker() failure on entry, as the OSD
client is being torn down and further writeback cannot make progress.

An LLM was used to verify that the cleanup was comprehensive, and
suggested aborting the writeback instead of continuing.

Fixes: 1551ec61dc55 ("ceph: introduce ceph_submit_write() method")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260804-remove-wait-on-page-writeback-v2-0-81f0ab065284%40columbia.edu?part=5
Assisted-by: Claude:fable-5
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/addr.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 1f77aec8e960..d5a349daf4d0 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1482,27 +1482,28 @@ int ceph_submit_write(struct address_space *mapping,
 	BUG_ON(len < ceph_fscrypt_page_offset(page) + thp_size(page) - offset);
 
 	if (!ceph_inc_osd_stopping_blocker(fsc->mdsc)) {
-		for (i = 0; i < folio_batch_count(&ceph_wbc->fbatch); i++) {
-			struct folio *folio = ceph_wbc->fbatch.folios[i];
-
-			if (!folio)
-				continue;
-
-			page = &folio->page;
-			redirty_page_for_writepage(wbc, page);
-			unlock_page(page);
-		}
-
 		for (i = 0; i < ceph_wbc->locked_pages; i++) {
-			page = ceph_fscrypt_pagecache_page(ceph_wbc->pages[i]);
+			fscrypt_finalize_bounce_page(&ceph_wbc->pages[i]);
+			page = ceph_wbc->pages[i];
 
-			if (!page)
-				continue;
+			if (atomic_long_dec_return(&fsc->writeback_count) <
+			    CONGESTION_OFF_THRESH(fsc->mount_options->congestion_kb))
+				fsc->write_congested = false;
 
 			ceph_undo_wrbuffer_claim(inode, page_folio(page));
 			redirty_page_for_writepage(wbc, page);
 			unlock_page(page);
+			put_page(page);
+		}
+
+		if (ceph_wbc->from_pool) {
+			mempool_free(ceph_wbc->pages, ceph_wb_pagevec_pool);
+			ceph_wbc->from_pool = false;
+		} else {
+			kfree(ceph_wbc->pages);
 		}
+		ceph_wbc->pages = NULL;
+		ceph_wbc->locked_pages = 0;
 
 		ceph_osdc_put_request(req);
 		return -EIO;
@@ -1736,8 +1737,11 @@ static int ceph_writepages_start(struct address_space *mapping,
 		}
 
 		rc = ceph_submit_write(mapping, wbc, &ceph_wbc);
-		if (rc)
-			goto release_folios;
+		if (rc) {
+			/* the OSD client is being torn down, don't retry */
+			folio_batch_release(&ceph_wbc.fbatch);
+			goto dec_osd_stopping_blocker;
+		}
 
 		ceph_wbc.locked_pages = 0;
 		ceph_wbc.strip_unit_end = 0;

-- 
2.39.5

