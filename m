Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D79342DA4D
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 14:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787581112; cv=none; b=W4fb/5yjdqO5KGP0joDon1o9K5ZFTZUl1QFGTs7atswC64IsLWAKmDJPLe9DuBiU1vBxQPTW3e5mYQgLWBS+EXup1faxt4M0Wq++gJmn3/8HoTGeE39otqCvRfARbvy/N4V8iFuU8SH0ftnZqc4oPk4XqpXP5xR+BeUfgdWsfhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787581112; c=relaxed/simple;
	bh=NXqB4cq2up2lZFmd8LXQWlaLoQrbIuSlvHGTMlBcpMo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=r6Eb8dsjdL9hnfdFZjpglPmThwf73/I6Np58BZSKh+doWAM79cyr8nZihAHpGJ39ZtwERmy3RUCUlCleJekf+Y7t2G71nfsZXlj3clTWtQH4nNOWIRP5+Smx8FqoCoMX1+n+LbuTT1d64MAP4KFDvnWpNJzouh3zVgp/r1alALA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iEWFyp2f; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iEWFyp2f"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8111c0c7561so52248637b3.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 07:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787581109; x=1788185909; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p1RKlgv7gfcdgd0R95YOF5t38k1glOotR90LR4kTqgc=;
        b=iEWFyp2fObpGuMxuC3AxmU+tN6T5R0BSy85FKMQOYOj0zD6eb+5TZ4Gy9kkRrUDX7l
         sBfXgKGoB5BlSlq9Vy+xXpe8N12y8g65QcgEfOhdRO+FxdanYmLBwx4XdJJmTcPmDS/Q
         k8oHz8e4apoTLoFfrpoYRsKudobrDwWUEBbYKJW2o2P4WxYhb0UE1yWHQnxb4DbdB4Z1
         MQf0SEv65ZzjkonEMzDdolDCxFGDabCQZg1WG6z5hXp5qimSXeSTii8THmYsmArGmCxI
         oqSgx3CpTY7Ls0wUnBdq1CQ9s8ZZbJlvOZ9KQbaQJDUQmshkCWvEPZoNw8thg2V5cBJg
         /TVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787581109; x=1788185909;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p1RKlgv7gfcdgd0R95YOF5t38k1glOotR90LR4kTqgc=;
        b=gyliwhVBg3pQJ1tVZk1UZfGZgi/HbcqMD4e9WJ2pny5v/B6a6CPYDQg/TAop1m6xDD
         lQRaKPGRrIhAomuJfI/AMOzMilWphT/eQ70UnsFzM+IraejjqnWwo6rISr8tev1QKIBJ
         qtwAYtE0DgmYycPHaWSBi1cqc1CeuZQ2WofFHK2/LAmgvwIpdmzipe3MuN2EIyS/i6a8
         5KWy6orb8AulGMB05XbWNnr+W5eqNNFu45D8YXuD/MhCtej2tnYxsmSGn6Fn7fsN8AnE
         Xj2UBBs2uT6AZ8F9qEc51RwNcP+6VOOS2HULhlajk8N+HTWehYwzAi18UmWPzffcmsij
         Sqsg==
X-Forwarded-Encrypted: i=1; AHgh+RrEqzi+w2gMHXkOxE/S73OYLTDHMPvUnsmnomT/6PUwNP7Eq3Jac+CT72LTwBy5965LRYOyKjjBuyPNm8/I@vger.kernel.org
X-Gm-Message-State: AFuF++ngsrLYs//j8E5JCKEGdX6svsDBU35iHyMSPsvAxsRCoX3zL1FW
	Ur5cVRvdcmPaC2XnELrz8PCmQwCYu+83F3Snb1DSIECPdbUuq8aMHwbf8MEN6gb8Kg==
X-Gm-Gg: AR+sD11MPYYScFX45fdqc9N36j6Q8yq5Tilf8wIyMNMpoPL2AOXZjF0WlZZZJvm0o/y
	uvW/+epkIn8fM3Y8FY2hnzR+QjGEeiIqTOwSCKAlUimXJxZXfw68aadxHw1IGSmhH8rqnb1HyUH
	SzYOty935VmOVv/8yVLPW1iXVsMPF+fZdL9wJTD/RajyQ4QOiQYr7ohDN8HIIxoFubTuLyfeY3U
	SgOTLTM9s7dduJwGhgyJI7ObkTTMzKxQHm5K54wrSO3M3qb1GUWXwvVmeqdXUHaCwi9i8nebL09
	tBsA1khyyxTYPRYyJpVwMiaT4ZAVWNvC8Xt+3OZcBjn6Ee57s345f4gt3v2oEF+BwawFheiIfOc
	yTTQGHFFBS/UdpA5KuPpNg+Bu6M9/dIHbyQuHAqMypYwq/iMB9elx1HAl1l+pqNuQ96XA0Vy+Px
	F/+ww5tBG3XgTvXCqbCrtzUoi36xGreuKKNQ1mE2w+GKHs87bxJ4ZKbuHdVwTuTHiQeD1AlFSWP
	/hYLKm1bASUBPmCRI2zj9CGWuBPO8BolmtHm2F5R2YesSuA
X-Received: by 2002:a05:690c:e0d5:10b0:821:1013:b420 with SMTP id 00721157ae682-849f090e309mr91327927b3.2.1787581108999;
        Mon, 24 Aug 2026 07:18:28 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8542a633964sm1660667b3.37.2026.08.24.07.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 07:18:28 -0700 (PDT)
Date: Mon, 24 Aug 2026 07:18:24 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Ackerley Tng <ackerleytng@google.com>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Barry Song <baohua@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
    Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>, 
    Christoph Lameter <cl@gentwo.org>, 
    Claudio Imbrenda <imbrenda@linux.ibm.com>, 
    David Hildenbrand <david@kernel.org>, JP Kobryn <jp.kobryn@linux.dev>, 
    Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
    Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <ryncsn@gmail.com>, 
    Kiryl Shutsemau <kas@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
    Leonardo Bras <leobras.c@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>, 
    Marcelo Tosatti <mtosatti@redhat.com>, 
    Matthew Wilcox <willy@infradead.org>, 
    Mel Gorman <mgorman@techsingularity.net>, 
    Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@suse.com>, 
    Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
    Oscar Salvador <osalvador@suse.de>, Peter Zijlstra <peterz@infradead.org>, 
    Qi Zheng <qi.zheng@linux.dev>, Rik van Riel <riel@surriel.com>, 
    Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
    Shakeel Butt <shakeel.butt@linux.dev>, 
    Suren Baghdasaryan <surenb@google.com>, 
    Vlastimil Babka <vbabka@kernel.org>, 
    Yang Shi <yang@os.amperecomputing.com>, Yu Zhao <yuzhao@google.com>, 
    Zach O'Keefe <zokeefe@google.com>, Zi Yan <ziy@nvidia.com>, 
    linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 11/25] mm/fbatch: remove migration's PAGE_WAS_MLOCKED
 lru_add_drain()
In-Reply-To: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Message-ID: <6b1ccb51-be6d-5f1b-147c-771e6adaf55c@google.com>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

A welcome side-effect of mm/mlock.c's mod_mlock_count() succeeding on
folios on the per-cpu lru_add fbatch, is that migrate_folio_move() no
longer has to lru_add_drain() before remove_migration_ptes() restores
a PAGE_WAS_MLOCKED mlock_count: so remove PAGE_WAS_MLOCKED altogether.

Re the "We would like to do something similar for the old page, when
unsuccessful" comment above it: that may be easier now, but involve
some rearrangement: not researched, so just leave the comment as is.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/migrate.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 6b71b2415d00..534908a0839a 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1148,8 +1148,7 @@ static int move_to_new_folio(struct folio *dst, struct folio *src,
  */
 enum {
 	FOLIO_WAS_MAPPED = BIT(0),
-	FOLIO_WAS_MLOCKED = BIT(1),
-	FOLIO_OLD_STATES = FOLIO_WAS_MAPPED | FOLIO_WAS_MLOCKED,
+	FOLIO_OLD_STATES = FOLIO_WAS_MAPPED,
 };
 
 static void __migrate_folio_record(struct folio *dst,
@@ -1259,8 +1258,6 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 		folio_lock(src);
 	}
 	locked = true;
-	if (folio_test_mlocked(src))
-		old_folio_state |= FOLIO_WAS_MLOCKED;
 
 	if (folio_test_writeback(src)) {
 		/*
@@ -1411,9 +1408,6 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
 	 * isolated from the unevictable LRU: but this case is the easiest.
 	 */
 	folio_add_lru(dst);
-	if (old_folio_state & FOLIO_WAS_MLOCKED)
-		lru_add_drain();
-
 	if (old_folio_state & FOLIO_WAS_MAPPED)
 		remove_migration_ptes(src, dst, 0);
 
-- 
2.51.0

