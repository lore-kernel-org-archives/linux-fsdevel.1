Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793660074;
	b=Rn0lmGfXgMZYR9zAGwfk0bDckLbXuyQwZPDGRsQZekrpw43sRTEfD5wFHny21QB9Gj4H
	 obxKaQYu0O6m/yTWdSnWrHB1r/rS577TMEprbxFvFHyXmmPJtfPdGaHpuQkod5bJipuWZ
	 Nx8E4owLGDKL90tJm051vwWCPO4VioFOQ3RL0df/edtPUEKyYFfYaFvUWblK7X8/vjyKq
	 PsxnqXMaLsA6jxtY3p8hzvtQpWNqfQbZrZn0buQ0Y4QZi6D1Z/ONIWUZMCeI2tatCYDpj
	 eIKoTHcStJC0feQDL2/U98WsxwIY3sAJSVMGDxrlek/W2+qWkhjSJd9s+dX8gmeyCFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793660074;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=+yGLnfP8ZKDdE9WWfyrLXQUXzQI6BTmOLGN0Hnn6wDw=;
	b=g4wXAR/YcXRQeYJXIqLWJW3JtTqxfOvBr6PPrLFi0YdK9b55MhCWluHrtAKMsAOt6qSz
	 YMGFG+uWDMfbAChO0mZPkWpWXDQeJBL2ZLSnhlCAjkFHRxjcEb/NQUe+M/Z/XG5xzzezY
	 z0BRbH5g87ExVjFt26mGRBu7hIBvw8XsXxwfPFl914fpJ5QOdgSSlXfprflnl7WCF+jWw
	 0omF0JSGf05sGw//oZ/5Jmzr7VlJiSvR1Ex2COWOubl6uMzY5MmLY7zfmB0GhKZmSAPa4
	 6ghcXbd7FVKnHRjChLamTYu40C1v9EBN01r/MMfDZM576KQYvzj3XvhzsoFWBNrUNGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=dkn7kv9i;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=ZOr33Br1;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AA9606D80C
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2026 22:54:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7AA9606D80C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=dkn7kv9i;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=ZOr33Br1
Received: from pps.filterd (m0167068.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2LYHnX3351610
	for <linux-fsdevel@vger.kernel.org>; Mon, 2 Nov 2026 17:54:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=+yGL
	nfP8ZKDdE9WWfyrLXQUXzQI6BTmOLGN0Hnn6wDw=; b=dkn7kv9ifrFDyQg7gzi0
	9n825IO8HEtxOakVAmA4Y3ft4TQZt9UwpNzOl20VePZcy1dTDxcOKVwnIe0BUAno
	XW2e5yDLVpUqfw9m6yFh/GKJUy6JfD4+zzjkV3zOv/BsKR3HAE0GM8XCtvU+3TFf
	1utmVN+swcQQkREYm4Eg0AeXx7/XMw0HAudCJokrUdbmOOhbOF4MLNqLV3q5aPc4
	AoUWaO9h1NKKz5uGuhOmmVD+TUFkjB1yZH1lpg7mK778W6kiFnGxoYK8353X8aNR
	Vl3R2Ra4y4pBAoJnFLc/VwmuXkk/2OhHdwECKL6X/ZJqYuHrSSZuke7rEfhIb1rJ
	jQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4hpvuvmgdj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 17:54:32 -0500 (EST)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93cb71b1443so734672885a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 14:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793660072; x=1794264872; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+yGLnfP8ZKDdE9WWfyrLXQUXzQI6BTmOLGN0Hnn6wDw=;
        b=ZOr33Br1ohHrFgEntEFLEIme8YxquiY1MW8Q6r04E/JseGPyNzkAAf7QvG6SddPi9Y
         rvwCfMskmzPotaPAwTH85c8nDXa+I4+4tjNZlXZYXmIvodfAswOksNtyciCNb7jHE97P
         KGUTazkyTGf4B3mxfoS/J+W7sCscA4E0W+7XpiKEZbWbTdvA3j35Z9a6lB1lMzEOvVcn
         3/A4yd3utY75N+cw2ygwIUpwxZBIl7vWUSoO5ViuetbLUursvX+BksRd2BHy6ZUtNSHp
         06oXZxRUWnlXFolfyNZgxz8pgURclfM7vtgrVKsYkple1ju+RiIvwm/ih7fmob3l0/4l
         u48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793660072; x=1794264872;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+yGLnfP8ZKDdE9WWfyrLXQUXzQI6BTmOLGN0Hnn6wDw=;
        b=dAoEifeCOSSCjh6qymXLkYLvhgCWklApH3F9w0+hR2s4/HpRa7XYhER3IjMuLNXE9n
         OWGohxoVVrOVum/iFI6xJdZHOHMAD6E5QSUfEEnw3ffGKxLBpKPAnF6/ceVvlICdXffv
         Gieq5e8tyKFg5r/CUnLofO8D+JJ7ZvRsdiDWlYIIaSex8a+7Hddy8dBE73QrmCFjn7q2
         NOztAEGsRxnRGlqgAmuypFipxCro5A+AAWGcn6bSVdeJlZD6m7RKaYpAB7reHizabviP
         s+piZWxNwR67CiXhv9MytNOVcKTYMbqZs1ZalepYAobFlDodOf1GcEKGDZz31rKkX8ou
         xbDg==
X-Gm-Message-State: AFq9FYLhgi4AVlW7pgTtsmpH0FiGd/7azPfwEESPqDPYsYJx50b1CGcC
	XlH/UWZxWlcmikXKnxNQnjOArpeg7ixehU+bl/N/Apk6/G9FMv3j194/uD5+J4z6jQpYYLGmfuB
	E9iMAyW/22EnJrnRPsoVYACBH1evg+1YEf4uV5pytCOhHjgm5TCqzgIbPcwmQ2Kg=
X-Gm-Gg: AYBFou0W2g6KzrIKcMgpT3dwyG4/+TmcPPrRZ9L50y8H51EnlvfrFvKSWWPZGly1Zxz
	KDducWqw/hZGDSaRZ0woYyEK9V+rutaj89DLCkkJoN29BYLkBSrO2XNdCHP07EHlCYCxg9ft4Cr
	mtd53yN3lT1sPTFBr9luRCdf/L8blQG0ay6pTl+XniQRN3cUKbH6rPqRnxqDr1WurCES5QJQszY
	qWftypFc9MJCleqLQyI92bB9h1iieV6VputZ86dBApUTtMgoN6PjT/7gBvD1m/ZH/jAHS9kkBQe
	5NKTroW6lus5WAI4Lgv63KNFjQzlkd9ox9QCQRb3Kxv6IiHxqjaYQUFcXT5o/kmupj48XOMqM4J
	cUsGqiDmS26Bz3zgjx9wne7ML4KbnSj4yY1GMwOQKCAeO2qBu9FqHUMf1p3A=
X-Received: by 2002:a05:620a:2987:b0:93e:623d:99ec with SMTP id af79cd13be357-94421744cc9mr1890408685a.13.1793660071853;
        Mon, 02 Nov 2026 14:54:31 -0800 (PST)
X-Received: by 2002:a05:620a:2987:b0:93e:623d:99ec with SMTP id af79cd13be357-94421744cc9mr1890405585a.13.1793660071252;
        Mon, 02 Nov 2026 14:54:31 -0800 (PST)
Received: from [127.0.1.1] ([37.142.157.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8011csm24710529f8f.31.2026.11.02.14.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 14:54:29 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 02 Nov 2026 17:54:08 -0500
Subject: [PATCH 3/8] mm: remove clear_page_dirty_for_io()
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-page-wrappers-v1-3-e7280bdb31f6@columbia.edu>
References: <20261102-page-wrappers-v1-0-e7280bdb31f6@columbia.edu>
In-Reply-To: <20261102-page-wrappers-v1-0-e7280bdb31f6@columbia.edu>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793660051; l=3173;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=7BGChjOxIQhOtitHhW0SVkXy4VnfQVCDC4XS3O7FajE=;
 b=/NiIZEdK4/vHMgmcvSib7+5sqV1U6WoM4/lSQ6/4yiaD9YZKgG+9hO/ypL1c7u1BU+O3PANod
 aXNNjbTDdmlA8KC3CrSFBF/POjFrulEuLLnMes3oZpw5/0KLTpm8dSw
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA5MCBTYWx0ZWRfX9SbkxNOzcph/
 WSmJVWknEFZaJkQAuJ4HMk/PTABSCQyIK9mUVC1LwppTdwJupVcXzTIWG8C4679dR8nUvveQm8U
 Q6ojaTeT17z7YcoRex+GPkJyNEuHD0WxwAjQynqP0MoozTVJkkmnT9747Q0oU24oaQ7IJDTH0Gr
 uMUsFOCH4b/2PeA2miyzRATZ6PjvdFkE/tLttIKHAVb1hpPZqign2WPJDjJocXi3yOkzR55KaSC
 g4U9afZwTUoK5qdXLSuO6kzsx56JDIrISJLIncFyRJ/La7FJoE1r75yhYRMy/XWS78YpiNmFyW9
 wU0VMQ4Z29wAkXs/fJjOjOdBYK3KTB4iut2fimlfjbF/0sPZPode0HWWxgoLN5lyT7E5mA05gY1
 V6I4Gi+9NgU44d6nb9J22WvqrfrbTEX6PdtAaaKBNTSQ90Bgmek7XLtZKO83Ovlf5x9voTuTIeX
 6hPjDWRO215PMLLiOJw==
X-Proofpoint-ORIG-GUID: D0K4BeRbyIrlGrPLkFPvwFPlOrNdRkbE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA5MCBTYWx0ZWRfX5PMa4Z8+QRdz
 I6X7A52cyJxwxFjlEzUDLP+LdFh6LSKZgVj/xHUUSh/ff1U8aEkNzHtTE2Vg+PRS0QQKUYUTC4Y
 Tyjatp7Z/v7aOmQBaFLO7yBn4anTs2iIIOPjqil4dJLTCRRb53pR
X-Authority-Analysis: v=2.4 cv=R7eWitRX c=1 sm=1 tr=0 ts=6ae914a8 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=Qz3frfIdACK70Hl/8c7MJg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=usPcmh10W0ubT8QP8_c3:22
 a=Ut7rPBlKFqStPCCC4O8A:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: D0K4BeRbyIrlGrPLkFPvwFPlOrNdRkbE
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11954
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=10 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 impostorscore=10 adultscore=0 malwarescore=0 lowpriorityscore=10
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020090

There are no callers left. Point the comments that named it at
folio_clear_dirty_for_io() instead.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 include/linux/pagemap.h | 1 -
 mm/folio-compat.c       | 6 ------
 mm/gup.c                | 6 +++---
 mm/page-writeback.c     | 2 +-
 4 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 692ce3867a1d..9adfeae2153c 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1315,7 +1315,6 @@ static inline void folio_cancel_dirty(struct folio *folio)
 		__folio_cancel_dirty(folio);
 }
 bool folio_clear_dirty_for_io(struct folio *folio);
-bool clear_page_dirty_for_io(struct page *page);
 void folio_invalidate(struct folio *folio, size_t offset, size_t length);
 bool noop_dirty_folio(struct address_space *mapping, struct folio *folio);
 
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 9f2cd0ebfbbd..13d4d39e1896 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -42,12 +42,6 @@ int set_page_dirty_lock(struct page *page)
 }
 EXPORT_SYMBOL(set_page_dirty_lock);
 
-bool clear_page_dirty_for_io(struct page *page)
-{
-	return folio_clear_dirty_for_io(page_folio(page));
-}
-EXPORT_SYMBOL(clear_page_dirty_for_io);
-
 bool redirty_page_for_writepage(struct writeback_control *wbc,
 		struct page *page)
 {
diff --git a/mm/gup.c b/mm/gup.c
index 7d43ce717b24..335dcb3a5c17 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -298,16 +298,16 @@ void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
 		folio = gup_folio_next(pages, npages, i, &nr);
 		/*
 		 * Checking PageDirty at this point may race with
-		 * clear_page_dirty_for_io(), but that's OK. Two key
+		 * folio_clear_dirty_for_io(), but that's OK. Two key
 		 * cases:
 		 *
 		 * 1) This code sees the page as already dirty, so it
 		 * skips the call to set_page_dirty(). That could happen
-		 * because clear_page_dirty_for_io() called
+		 * because folio_clear_dirty_for_io() called
 		 * folio_mkclean(), followed by set_page_dirty().
 		 * However, now the page is going to get written back,
 		 * which meets the original intention of setting it
-		 * dirty, so all is well: clear_page_dirty_for_io() goes
+		 * dirty, so all is well: folio_clear_dirty_for_io() goes
 		 * on to call TestClearPageDirty(), and write the page
 		 * back.
 		 *
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 0694ec4098f6..b56f2c91b0f2 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2821,7 +2821,7 @@ EXPORT_SYMBOL(folio_mark_dirty_lock);
  * This cancels just the dirty bit on the kernel page itself, it does NOT
  * actually remove dirty bits on any mmap's that may be around. It also
  * leaves the page tagged dirty, so any sync activity will still find it on
- * the dirty lists, and in particular, clear_page_dirty_for_io() will still
+ * the dirty lists, and in particular, folio_clear_dirty_for_io() will still
  * look at the dirty bits in the VM.
  *
  * Doing this should *normally* only ever be done when a page is truncated,

-- 
2.39.5

