Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA404399D5
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 14:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787581412; cv=none; b=ah9A62unQLYRLbwx/iCtp5iGyHrfL0gMubcXqDhJBwyNHiaO7zCcLhJX2Z3lI9q1a2CxhPCfuB4hB7H5vIr02uEPT7jwvsulrn+n2Ud3aJ59qj7s3nxqYF3NOvkAe14fGMTLAwYd2luypXdkzFYNBnsyjGmJettmSisVZK+KITw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787581412; c=relaxed/simple;
	bh=6kB5h1HEECPTicOG3LYyogzNQExsOtWLu7kTMzR5cg0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JoKT1PdiQ7FRO0z90jCXgGrsLGfTXwXbw3KzthwaV+ce/UEBxVsUpBe7+lAWwpkmJ7AqLn85K+KC1J+CqwbNglOESGvS336P44d0xlLgTuc0FihTMiIy4AgYzQk/Dp4IFsl9CEA1rKiz0OSUH3aa4v93fN1r8/NNFBi1l8QW8T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qTL5iIIU; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qTL5iIIU"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-836cb2fa1bcso53083657b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 07:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787581409; x=1788186209; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DAA3AJBckMfL7iDkU5H4UAChzqupIeoXexgfVyLiXUk=;
        b=qTL5iIIUHVBB9JoHNIpqnDPZ8Tgfan4sEu+QR0jdnehPcdRuSmmSwrTk5iczR8q5DD
         600sh1DTir0FNM08emH2W9KFR+c5JnQvIJhyb3T26Cw4B38BIWghn22vvykMM45M388U
         bJnjrkF6MAh4c/yHo3+o/t/uMp88ct+95h8a6fHmgzcnDUYnTD7ZsU5oDvccIbAxwtl2
         WXjIvy7nmjcYv7IeJhvfOCQdnexTlqMx+eN9GT5NvTXc1Pu3tbLAzS6FYPxnkxx6+ZSN
         Op/Oam74dLn3ZBLZnFPzkvHBG35ayFwnOvUGHFjjlvN6wqCLJ/YOlwnFTazDqJ9O/4LZ
         BUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787581409; x=1788186209;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DAA3AJBckMfL7iDkU5H4UAChzqupIeoXexgfVyLiXUk=;
        b=pN4wqMNZJVVFuSbu0hCjmgmakO6Qdhd3/RwzwVBWvMXbwPW8p2cPgnD0dYpIo4RgXw
         EY3pyv2q9MbSkVZ1FHd7YlstXdP653079diPLnF9g4FbHZT6rsFklymKIW1LrRpXzYJa
         1A2snGFiaq4g8r60fYEQLlo1CFeusiIquaB6r5TkUIPb5vHUxDYnBB6Yrcm7U1NRyov8
         wlike56oKI1jdBocVeAIUK1oIUORdJSzUzB2eYkdn/6TV7Dom3y1y4mQIpubW16rHRsq
         2xb/pDiP1Fr7MFHFSgBQ5rJZLUiVWf/Co60mMxXyTU08aUudzr6ZmQx7O75jGRKA77Ch
         MaYg==
X-Forwarded-Encrypted: i=1; AHgh+Rp4Yr0zMv8lHmgdOhV84Ae2zhbwKp7Kw1xpFJgrje4t7t/6Qlcd4e3L5rmVzXl6298B1gR+XaPO0fzHt26M@vger.kernel.org
X-Gm-Message-State: AFuF++mXN8mpVDDPXVx1lVugl6JAo449Z11b/2Qa1yq+y9tx+EYduL0q
	NRmnVH6jB9XYAYqFH+9JaQAZB0NhVU5LfDQJQAcToZJHkv8PaQyZ42C79TsCvdhqvw==
X-Gm-Gg: AR+sD11715uZrsWbWeiW0ypwpggMFsa0NY17lYeCdTDOO1uCltoZoQGVS6HDeR6bJI+
	8pL/NvytnNEpD3tGWTGRW/2q5NssDjug8HLyQreu/ljFYS9s1Fn8RcxN/htqlFHSPcIbeXkC6cY
	XWsPuam7x8OiVGvKpI4ZDTA5oP6tq1TS8phLbCt1CT5rjLczjuxwrtvelb4GiDEbDIs0scz0zzM
	vYt1quF8tLvmUzcXfivycDVuyaHUkaXad5ZdAvac+PtYrwgTbpdbgY7NUlpvVHv6Ahmc/bcHXxW
	mEj7xXPcTPWzPkZS65rkJMfh3swcf9zFY1j6+n//2qXSZqu/K57aNnt1Azb13JwvdBiC/CL8f26
	T7L9/zFc2lChOsg8Sgv0lJGae1lrMWU9hJKSRWJPCPPnOGVrY7lGB1qnonPzKReS3SG8XLQ66f/
	nWaW3vqifzNhdbeKw4CM2KpKg5bimMROPHiXXOYrjN9HS5KvBughtFcWWp4h/iWSgBMP0cpXSpO
	A6cPTZeP5G8rwL0EdfHoH4Ps9lPqfy8C0xABYY3I7fYe5XD
X-Received: by 2002:a05:690c:a4db:b0:80d:a249:4854 with SMTP id 00721157ae682-84c99f902c3mr43542587b3.17.1787581408945;
        Mon, 24 Aug 2026 07:23:28 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84cab854483sm33838647b3.33.2026.08.24.07.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 07:23:27 -0700 (PDT)
Date: Mon, 24 Aug 2026 07:23:23 -0700 (PDT)
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
Subject: [PATCH 13/25] mm/fbatch: no lru_add_drain() to
 collect_longterm_unpinnable_folios()
In-Reply-To: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Message-ID: <fbf3fa74-c646-8855-17e4-e8b35dfd9c14@google.com>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

collect_longterm_unpinnable_folios() has no use for lru_add_drain() nor
lru_add_drain_all(), now that the per-cpu fbatch references are gone.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/gup.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 99902c15703b..9616379ab069 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2268,7 +2268,6 @@ static unsigned long collect_longterm_unpinnable_folios(
 {
 	unsigned long collected = 0;
 	struct folio *folio;
-	int drained = 0;
 	long i = 0;
 
 	for (folio = pofs_get_folio(pofs, i); folio;
@@ -2287,19 +2286,6 @@ static unsigned long collect_longterm_unpinnable_folios(
 			continue;
 		}
 
-		if (drained == 0 && folio_may_be_lru_cached(folio) &&
-				folio_ref_count(folio) !=
-				folio_expected_ref_count(folio) + 1) {
-			lru_add_drain();
-			drained = 1;
-		}
-		if (drained == 1 && folio_may_be_lru_cached(folio) &&
-				folio_ref_count(folio) !=
-				folio_expected_ref_count(folio) + 1) {
-			lru_add_drain_all();
-			drained = 2;
-		}
-
 		if (!folio_isolate_lru(folio))
 			continue;
 
-- 
2.51.0

