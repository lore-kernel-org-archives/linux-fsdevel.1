Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA2C4963AC
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 18:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869577; cv=none; b=euiI+Xl9FTXkvLURU2t/BYiwBAFDZw3A7/qDgfhz1x54EjFhgB7j7p8m6Y3B+ODTKVHtWJYDP+T345C/60B4MmywWvZUjCJFBuXjBucCTE7dCVxKQ6fwgeoERADGmxE4l3+hKbZoPmfF4Xf5YvYxg/SQHtFGodP4/J69/Eg44WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869577; c=relaxed/simple;
	bh=VtzqiAKIaGHunrdK+84+1QbqamvLCcoJ2tsGqghPxR0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MnGn9Gi+Fb94QmTCOXr828pP7B1yeUJLagQsyqMMKlNw7Fc+ktKIiJubXgNy8CS2gO3CMLcMOvccunYDOg5FKs43THNFuUCX2Vy1Ec+fJNDQBbl+6izLdGe+zcpOwBnUGFVxsQYQHnFgv7nUXJm3pGM0LF+yqGLjGYtH1d4/Wm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=pIZFL8g3; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="pIZFL8g3"
Received: from pps.filterd (m0499199.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674IYJ362113403
	for <linux-fsdevel@vger.kernel.org>; Tue, 4 Aug 2026 14:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=5Z1d
	1TlXkyKgDoQf2U27ofqIWC2kaIkUryg1X3S+EV8=; b=pIZFL8g3JUUeHvOt2OuV
	Wu71CXApi+WoFTVDKHD1/CThuPssXvgEf8afTE4woSfTDzDNlkbR7bk4I/MCT5yv
	v9kWn3cFllgIgzjvUCyZAozYejIzx79Na2hpfKysxhU6pXFutU9fZVq9NU119ojp
	QfitVEAY13o0BBon33Upj1u+6tGk5seoagnigVWhuX/VSZDbq7xi0cDKcJkhISh8
	XSdacnrucuLydFB0ybrv73TudiDvxphvALvNgkRHZbYd3o7VtCmzMGOqxbJwQzt4
	cz974U1Kl7j5Amd+MWNKejjew4aWTjtQtU0d9XOkhdaQ5yGSVOx++XuCVNNlGUjy
	WA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4fumy9gc77-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2026 14:52:48 -0400 (EDT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c0199faafso1070131cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2026 11:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785869567; x=1786474367;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Z1d1TlXkyKgDoQf2U27ofqIWC2kaIkUryg1X3S+EV8=;
        b=h3JKC7hdJ+fChj48TfTLD24AKEgCmxBnoQi6f4EnM25RfEnlNyaDNy5WQecT/uiU0Q
         80hxLwey3LjbHsCvmvYh97BO+I758BX7LkWjM9KiTxA9uFHbIoNoMzXp6K5VSz8poedI
         JaUksG19P76ymfbLrgju1Cyxtymy0uL6fEsLD42ARg3z5Roql/jm4OKvAmmtyAGlin6A
         g3+g+QZP9AvIJrPfe9+iQCCuYmES2mh814E4cY4wWnd4xiRzyHt8oejX7xtlrCWW3vCL
         HydgdLU4EcoXtW/9ja+XD3V5USpeqjqnxnQXQWHCDs2SW8/ukQ3voQ8GR0fkgifoheU1
         F/uA==
X-Forwarded-Encrypted: i=1; AHgh+RqRNT/dx6n5neEWqWJvfkx7g6Kbo4vNhSElSvFsGMcdtiin42sNmsLy7cNYiODxMwBoROhkRLg1qAppvQDl@vger.kernel.org
X-Gm-Message-State: AOJu0YykJjMw0QLjjC6XYHBzCg0Eqh/Zz1jKLBarXaw+auUTn6FoY+nn
	HR8jdAjrzOU/pQ9rSbL7YkRQpIYlSEz1nD8yHgFl6B02F2qXkgVItI1GS/vZ052TRSz22DNrFHq
	UEETjhCzLhhNLIhxOYB59HhjTop8ygD/QZvg/qVMTsGRKuoTUVhcU/Q7OM3eHWlg=
X-Gm-Gg: AR+sD11WMQsMLsN1Hf0c6etLcCTwUoQa9mhfEDsYKkrauyCOveckf5MvMV6tYJ6moIx
	+MqPITpS6vhpXJGgqTqrdmOn36Zluxj1+HB5e45cfbM0o4Okdn9OlwduBC522fLJqflPMt8g+S8
	fRlPUxk94+v3+Eny8O8Er0VdnbMa2wSXJOQS6wb/NXJkemE8RwIGS+APPwS6fkMWvP4ONU68dy8
	mhG80XyUhbvsDSK1P24VBMUEYUiouxt0bC/r8Bv+JzCodqeco6jzivDEVBbICL3ITIiwq5xG9Os
	+Szc16c2ZflpYnfg/tPwBAk8P2PFNf07dXR3akEcG/Rxk7P0GqgF2nlAIpTV2NTzK2dRHu5cICl
	yrnyGP9dH
X-Received: by 2002:a05:622a:4811:b0:516:d60f:6438 with SMTP id d75a77b69052e-52ce5e01448mr16271551cf.0.1785869567607;
        Tue, 04 Aug 2026 11:52:47 -0700 (PDT)
X-Received: by 2002:a05:622a:4811:b0:516:d60f:6438 with SMTP id d75a77b69052e-52ce5e01448mr16270781cf.0.1785869567080;
        Tue, 04 Aug 2026 11:52:47 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.77.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec232d7fsm2313275f8f.20.2026.08.04.11.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 11:52:46 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 04 Aug 2026 14:52:16 -0400
Subject: [PATCH v2 08/10] ceph: convert page cleanup loop in
 writepages_finish() to folios
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-remove-wait-on-page-writeback-v2-8-81f0ab065284@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785869541; l=2329;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=VtzqiAKIaGHunrdK+84+1QbqamvLCcoJ2tsGqghPxR0=;
 b=RyGOUa5eKloJbpygdzbwT4OucEq/qVhavJ6tD6H5WtS+DuBoeRpiGXKJb0kfgATrw5uo/X1hn
 fWUMpT5dvtsBAAGgVN8auf5poVNA6xzYJwPO6B0z3lte5+1ZD1v8SZ0
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE1MiBTYWx0ZWRfX0LeE+7vuaJXL
 O+0uY4I3nJSQu2UX47PJrhbYTvMVkG4gJtZr/poEgpqUADKjEihWR7RvDdCOh8XUSUyiYHrtgFD
 IfERo4BhJ7qcP9NY1l7Wug/wWGVuldmE/6rA0CbDNi5YYtz0qUgljP60fKIcZTjeN/Ox3BZDSO8
 ShOnrPm5ErA0KDWYcO1NDEJwiGDUKiLV3FmUEE5BFLeraFeHw7f+pi7TzPi8h74hhKsxGuER/ol
 U8WoTyTMQUEKU94uGCcBxt6oX/6wV2zSsFeh30KoSCkO1heKMO7nvEBVe1qXkt9dhsGVnQD9HO+
 wF7l0qSpTRNwnzocKziN0gfStryg0NSdt66pimLknWIPQ6osJH2nPSaTGTkzL10b30iYzEWFPRS
 M9TXrpOoIQdsCz9OCMvm7p6SDdWXjP1+BHiF3grkdYyVNxJb4B+WdJKwElM1KhVzdwq3sRXcxlv
 KFP1zFDN7E2mF9hzqsw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE1MiBTYWx0ZWRfX35kd8sLIqQex
 ZEjHX6wMrwuKRhvmz4qLj0/RdFHgogCPnZddozSxSN34E01v7HT074NODDV3ZwzzSyUHrKVZFv4
 mdNvUl1Xo9tWmg/uBeGAyooU5kZYm9KxCaLq62qGBm3cPw2cpbVi
X-Proofpoint-GUID: uWrUkfl2uhy-LMb9pWLma04XXWRMMf8V
X-Proofpoint-ORIG-GUID: uWrUkfl2uhy-LMb9pWLma04XXWRMMf8V
X-Authority-Analysis: v=2.4 cv=KLZqylFo c=1 sm=1 tr=0 ts=6a723500 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=j1J1DEHOHTVaJYOjuVnKiw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=G--0XuH5328wxK7v7Suf:22
 a=PHYVD-oPFUEr7kX-Mb8A:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11865
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=10 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=10
 impostorscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040152

Convert the page cleanup loop in writepages_finish() to work on folios,
resolving the folio directly after fscrypt_finalize_bounce_page() has
replaced any bounce page with its pagecache page.

This removes a use of detach_page_private() and five calls to
compound_head() per page, while adding one back via page_folio().

No functional change.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/addr.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 59e559bdfdff..eaf5b3f6d13f 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -896,7 +896,6 @@ static void writepages_finish(struct ceph_osd_request *req)
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_osd_data *osd_data;
-	struct page *page;
 	int num_pages, total_pages = 0;
 	int i, j;
 	int rc = req->r_result;
@@ -943,31 +942,33 @@ static void writepages_finish(struct ceph_osd_request *req)
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
+			BUG_ON(!folio);
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

