Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4E93B52E1
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 19:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786994150; cv=none; b=cEhp8enwb3JeDuB+VVCyguvsQ/FmfQwCciftwnhOxXK2HHLBkgKU161DIbPFkioxWllvOSYsFYCTv3bLFKazapczs0PdrkrGBR8D6jVKjvb6M7pSg9X2BiuowuC5Edi3UInwb1eEHWzkKyCOCZvHJH1gn/gBRa6jAVc+RsCqP+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786994150; c=relaxed/simple;
	bh=T5FG3fhAKz0kMpG0eGKGX/d3+iEP0nP9oBKuJs6wttk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e3mB2BWvQugp0Qu5fV1AWfJHRUP8T/3kl87gDw0LI4BnZd9lpb8J7nAwUimLQhki7JmyIdvsAkPG45X3Y1D9mGePizYJby+22Z5ZLklqGa5WI4grqzBz69sP+N60GB4ZU/hyFbAtDJ9C5aKQZs3wHx/O07fcrUEMWwyyHQohQgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=mReR1FnQ; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=ZoPClzu8; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="mReR1FnQ";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="ZoPClzu8"
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HJ9B6K3773013
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 15:15:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=m7Us
	8fWg5hhgUppSV1QIr9mJ0JyWe8U/fZpzI/jv608=; b=mReR1FnQTlF6SCUrq+I+
	w9Dr5AfsKfP537a6YnpqVF3IM5BdSZxosqPmm1LPD4RDlo1F0vhiznlaSuseTS6V
	8C6IaY7irEu6js9XAEepKTfr1/XhgYJ82F/SSDc3gWHQoiv15C/ba8yJg3e0o1/E
	OWhSiOShuavAEq1LkP5dYyjm+SRkWUWMgtqfWXASa5hE1+erxZNjjzAnNfuZyJ50
	5SWoOPLflO+ly4COXffaAjIDUQ+WKoTsSr3rxGB3CWiXqEdbG5F7PAzVBf3E60R1
	yMSCKyHHNQCEUJez17zlmFtK+N8ROHAT0BErtwz9Y3VkdRZyDDCpKIrqVAxG1vbK
	tw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4g486y01qw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 15:15:43 -0400 (EDT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-934956beec8so642765885a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 12:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1786994143; x=1787598943; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m7Us8fWg5hhgUppSV1QIr9mJ0JyWe8U/fZpzI/jv608=;
        b=ZoPClzu8K62G0Ste8u5nUu7PzGvjlt9T41lYeX/C8jd+UwbJE80+w+wnb043L0OWlw
         2vB5YpwcXIqwd6WfowU9VgOoaGjwsCIwYWf6m9UkioSSBRnEYn+6d4DpITWFU7u+p2lA
         40HvvAYnr346hNc2HTf5Qgy68cP/66Aig7XCnXxjijOrBK8NplssA+USFpe0jOoHG2k+
         cKAkxZpMZ0iWRvxK4D9l30mSNGgr/QROjPiVv/z8LSJFgQWTbGvR+gyR1B3gTJJZ3Jg8
         +7cyN5WcPsqOel1r2Mo4+qUza1Rdh/VKkBqVNhp5KUV0wzwtJOyySLSGJzox3ajRGSjQ
         FX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786994143; x=1787598943;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m7Us8fWg5hhgUppSV1QIr9mJ0JyWe8U/fZpzI/jv608=;
        b=SMiDUR3HDXOxnF5SpAuxDt2dLbC+7gMzExWOFp23eKrjdLUN84AnXkLIj1sBFI0dua
         nAd4KgQlstAAgQ5YjvTkbxRxKh1Z7eo487bokOHBbh2Yh0dZx8oiPHCRf2qq4CjroPgw
         XWay1ew4i5+rYv7XSBDJnw5XRyKCPQgDlZEOsAGRlnO6jVTu2GdzvatWUGXJMXi20elj
         9GqaAEx1FJ0mbSNkcObXGJ3lScPKWh4M7df8ZN+bkOpggeke5jz97G9tUal1KH90vH1i
         Yz4wehdAJnDIxPF0nnX9BKHLX9qYzRXZ7qdLStIg94j0pkxonAQuedvsZQonFXuCM0mV
         8LcA==
X-Forwarded-Encrypted: i=1; AHgh+Rrxb8i+Ir29M63VMp/+35f3G+Wa2hMzOkUqzZefrYG9W2BZyKP/JIpBEW160gA3j094UIxKyc6zIagjk9ti@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn1o1Hxlb/qQwA4JubzBN19QIkPq4T1u+7XnMNo50u/2LgGHYj
	4S+2V7Db9EBOPZTai1YcOgu8/37C524GWuDTvns1+OpdmayDRUfYHNFmNj4KmFMAeJgES1+tU2w
	GLjMZcz2gY3AllPbrt8rHoibAI2XKmcgVa714ruzYvoaTjvvhxRuQBsYvzKFLFrI=
X-Gm-Gg: AR+sD12P8HUDVdyBrnW9HJ3dYEhBZnznAoPJSqBVeta/EBYzIN02Ugejwv7WIq0FIFq
	NAI2NdqbmqCw6/Mg+/JwaOhwpF1WB0h0zLh2VrrImqPnDWduF5qZlreu/ml7P8ZP+/AZbIdVCVZ
	7+EmZznPSjQW5Lb7Vre1Sk7o41C5wxMno+/LlXtMIu0rrkNOznbhrFfliyJWC/3EDIyIcvZQP71
	V11lmJzYTyAMQiZQ6/+DXNnisJhb7TYJiyiUQgenX/Zg0G+1oX1OtstjlWvd/hMLXuBII8ZnGOR
	hqGrUjGYxqNKUyBMgt8pmQsajFw0AraUlvTfqiN0NrzB9g8BYK8zbaeNGY8JWpLluT1fZXTo+dd
	bkajPQkm0
X-Received: by 2002:a05:620a:2814:b0:934:a12b:1d41 with SMTP id af79cd13be357-936d22ff13dmr2810092885a.33.1786994142842;
        Mon, 17 Aug 2026 12:15:42 -0700 (PDT)
X-Received: by 2002:a05:620a:2814:b0:934:a12b:1d41 with SMTP id af79cd13be357-936d22ff13dmr2810085685a.33.1786994142313;
        Mon, 17 Aug 2026 12:15:42 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.67.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499961098cdsm194692085e9.6.2026.08.17.12.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 12:15:41 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 17 Aug 2026 14:55:24 -0400
Subject: [PATCH v4 08/10] ceph: convert page cleanup loop in
 writepages_finish() to folios
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-remove-wait-on-page-writeback-v4-8-0e5e53d47eb0@columbia.edu>
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
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786992937; l=2393;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=T5FG3fhAKz0kMpG0eGKGX/d3+iEP0nP9oBKuJs6wttk=;
 b=zjQ8ZG3NiJuKlvbWeB6va+eBvsFwnY5+DnPdg2m7mJ2GbnShZ7+f51yH0VqcAoCHzAULhHKt/
 rYqDp3ZLwv0AtKip2NM+8iOyszkU3i2/9/PfK5kFRTkM205RbtNKtbx
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE0NiBTYWx0ZWRfXxhth6oRihqFX
 dJr/83rp1y4NeDyi0f2mZb/m4r4VvDyZH8s1wIMV0gMSa5hVvykTAR4izLtN4w8O3SPzlmueYgY
 lyEsyawd8ZEwN60nUC3AQOVc7QSFCE3hUK2xh4TB1P5FgnRkU8wvT4kjlfWo1WLexBITBdjpYrR
 t8ygWhe1fr5k7BmYhgBSFvQ6jZMJwS1aBLd7qnU+Qrcwra6MonRUYm9324sqh0V/gSAHZPEoBrr
 n4e87BQWWYa82Hcom3XXNQD7cNzKxiJGpGtrikQoNiJqfAVF4d2aih4euvhcueuUiC1nNtrJQZ0
 wIURAeb+lU2v3WHf9zTURhE12dC/D+KzweUZLg01FO60oJvc/hFiRiAOLYskhBpelkd3Kct8KeI
 jsoN11JRehh4yD/lNf3hoaKhJvEKBWh54CRQ7U639Y3QHxHDz7ZX3PoEwqUNG0Yxd2WAMSB4aK7
 M3p5Bhrophs4YlE6OvQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE0NiBTYWx0ZWRfX0v3AWRWb7IRG
 ER31kQim4k/T8mzQZ83oPpz8Xb7mMNW1+ALMT4cnV6sFKzesDjKx4ckmLvReDKq+e/CDW+4NhgJ
 wQGQ/7qKr1fcAH2m0aXNsuf6GWe/EFqxsMbydjLxkcSQWkJQhxdk
X-Proofpoint-ORIG-GUID: d7SGDYZgXJHEOQBDFB5akopqWq5aehZj
X-Proofpoint-GUID: d7SGDYZgXJHEOQBDFB5akopqWq5aehZj
X-Authority-Analysis: v=2.4 cv=AI0CnPLt c=1 sm=1 tr=0 ts=6a835ddf cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=+gpNN1aRt999K7yrv1sWlQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=PHYVD-oPFUEr7kX-Mb8A:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11878
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 spamscore=0 impostorscore=10 bulkscore=10 phishscore=0 lowpriorityscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170146

Convert the page cleanup loop in writepages_finish() to work on folios,
resolving the folio directly after fscrypt_finalize_bounce_page() has
replaced any bounce page with its pagecache page.

This removes a use of detach_page_private() and five calls to
compound_head() per page, while adding one back via page_folio().

While at it, remove the BUG_ON() in the num_pages loop, as it cannot be
triggered.

No functional change.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/addr.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 756d44eae838..e1ff5d9fd121 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -908,7 +908,6 @@ static void writepages_finish(struct ceph_osd_request *req)
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_osd_data *osd_data;
-	struct page *page;
 	int num_pages, total_pages = 0;
 	int i, j;
 	int rc = req->r_result;
@@ -955,31 +954,32 @@ static void writepages_finish(struct ceph_osd_request *req)
 					   (u64)osd_data->length);
 		total_pages += num_pages;
 		for (j = 0; j < num_pages; j++) {
+			struct folio *folio;
+
 			fscrypt_finalize_bounce_page(&osd_data->pages[j]);
-			page = osd_data->pages[j];
-			BUG_ON(!page);
-			WARN_ON(!PageUptodate(page));
+			folio = page_folio(osd_data->pages[j]);
+			WARN_ON(!folio_test_uptodate(folio));
 
 			if (atomic_long_dec_return(&fsc->writeback_count) <
 			     CONGESTION_OFF_THRESH(
 					fsc->mount_options->congestion_kb))
 				fsc->write_congested = false;
 
-			ceph_put_snap_context(detach_page_private(page));
-			end_page_writeback(page);
+			ceph_put_snap_context(folio_detach_private(folio));
+			folio_end_writeback(folio);
 
 			if (atomic64_dec_return(&mdsc->dirty_folios) <= 0) {
 				wake_up_all(&mdsc->flush_end_wq);
 				WARN_ON(atomic64_read(&mdsc->dirty_folios) < 0);
 			}
 
-			doutc(cl, "unlocking %p\n", page);
+			doutc(cl, "unlocking %p\n", folio);
 
 			if (remove_page)
 				generic_error_remove_folio(inode->i_mapping,
-							  page_folio(page));
+							  folio);
 
-			unlock_page(page);
+			folio_unlock(folio);
 		}
 		doutc(cl, "%llx.%llx wrote %llu bytes cleaned %d pages\n",
 		      ceph_vinop(inode), osd_data->length,

-- 
2.39.5

