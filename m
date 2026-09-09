Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461E9498929
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 10:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788949391; cv=none; b=sLTM7vGK8wd9zfxhOsdssfeJB9L8S1FbKMAgb1pzp95H63og/Ac5/y4x8aHIVRt+vFPurruo+5PoFkjC57qTOA+Nx7TCW4odmzdoUxzGQxycd6RrIeU1ltMgo+cTFz+FB5vmv3rPUQZJ+BUja+9EYMcdX+00vtIubExLyHh/D3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788949391; c=relaxed/simple;
	bh=RrFIEm8SrJEjhBjzApoefNfd8aQaR4Oxfr/yDuZhFPU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rFOqDRTJN7jQHReUGFwhGAFqdxbFLR4GXWkOcm9mP5ftOfS9WWJGp8L8siao5d+1CNEXY5lEdQO1rscyO+eDgbRp3Zv7sqRPgdcZYIOLpXfx2iB5csaixCj5d4Y2XPMhuCqDZYapmsvLcuLGmSZZZ8bYkWudd3XU5MPgAUyCUio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZoRzlaCR; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZoRzlaCR"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-836c4474028so53553967b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2026 03:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788949388; x=1789554188; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2UY30k1UeQzYu1OvDSaJuzIQ8I7z52NjmS+xQ0qJeoY=;
        b=ZoRzlaCRFXhH6gCaS3eEcmQTSTKHzTmJKAFmIlJChPlLxnQWPDvmcYyCo34ZtQ4JwK
         9liXSr9XQyn6eDXCJA0PhPpYangmdjaKltp8Z2mbwnKEma2qNUWjNKz+LESYTRm312fu
         Sc2okpFRLO+NTb1xQex6y7ciauOwGUOmKDcTtFcBSI2lASywJ8vrz8UZEMl0loeyEdqa
         akAq9L9rAqzMHpqT0nf3pI09liWo+VnpxJ6a6l3ebqBnbZE3pYUqEUc1ioBb925HCRSY
         dTbxog+PSoprsbaLQk5FE6QVEYobawHzFMMEdh36UGK8SY6HxDgd20i6s3LNBr9kC9E1
         5F1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788949388; x=1789554188;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2UY30k1UeQzYu1OvDSaJuzIQ8I7z52NjmS+xQ0qJeoY=;
        b=mrqfjNfEL8/6IabeItZ+H/XJPYsgjSqZSe+Gt6HmsgNgehikoRWYJsedjczQSB920q
         C2FHRUvCQD/T1UsErnCXo7txomHUvquHdYiCOXs6CZisHvDtemC/x/hwMfw7HOXlbeXv
         S5bjc+qWAshOAEZt5QgIAU7yj5wAa9O/yoeYH2rFztFQFATwkhNSRO0zOAla+SQOE+4z
         eGS4um5UhBjebHy42BqH133Yk2tmPDma1p9xj1WueJLIiUxio8ab40miolYZhaZ6xW9v
         aSUZgrGeWodJx1uDCXMxF1ngaGNZ4Gc3ggXaa520O+L81e/lo6RaDDJ7d7UT8nm8TZxn
         kIPQ==
X-Forwarded-Encrypted: i=1; AKwUvBxETFEDvqxciZ0SbCDwppEoP5Ze2OXiDa/e1Y/ppGhQJkkSEuhNJHTq2t3wK6cDJtp0YsKScWpu+OWdL77R@vger.kernel.org
X-Gm-Message-State: AFuF++kgSDTfbfnghfdwcmu/nuSEpNNGdGQ/Tlq7KxwUFDp8akhQgZ+q
	fFuey8YmaXalaRNGjO+JDr5GipE4jBor/fIxoSAXub9b5XKgJ8Ojr0OgXUu/jbmpvA==
X-Gm-Gg: AYBFou1aGTgPUwWLJcUr+wB2ObeKs5bg5e2pKdrQvbcdFIel3AnZztOXQpeb4bFkbMe
	qE/pBRwfBGDD0E6dwghFlcEf+HFNmsZri00aNsoyWQUxgz5m+6q70nuKu7D0Z7ylIxdgqjRgxeN
	zKAY7Udg9F0u57TQNP70t2LW4CHwMec7lzYKjwCM/oQLLFIuBHtTyLR1uMi5tSLhMdPq+5ANbbB
	x9LOAFW+pem37Uo41s/anJrejIoGCek/iHg/MOzTy+ruu1wh0Jwl/XYev8cGu6823FL8ARnYNML
	ORKDy853Kzoh62TOsmM3VjwjgqjsDlfTVw20L2zNESyKnKClbBXHify7SFGbnav2gJo29xO7i4b
	OJ/BI/U4loygFMH0+OQXgbgQ6cHJ1X78EM+FQU5HQRGecn5Fiind203hZmZ/7rjZ5sFFbZ5emj+
	DgKdv6jCqu6GN0bRtmW9A6FYm4cSV6AVcAyVr5BnEXuimL0G/VthdMnnCc3uG0u7NXrC836dz9B
	8Oi13lnJO+7UTWA/nCdzDxiR8DnOqHMVO40d+eRNKYbuT0vTtyXflOUqoM=
X-Received: by 2002:a05:690c:4b85:b0:870:c600:686c with SMTP id 00721157ae682-87126aa77d1mr116385687b3.18.1788949387337;
        Wed, 09 Sep 2026 03:23:07 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714b62503dsm108473437b3.38.2026.09.09.03.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 03:23:05 -0700 (PDT)
Date: Wed, 9 Sep 2026 03:23:00 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Ackerley Tng <ackerleytng@google.com>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, Alexandre Ghiti <alex@ghiti.fr>, 
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
Subject: [PATCH v2 20/26] s390/fbatch: no lru_add_drain_all() in
 s390_wiggle_split_folio()
In-Reply-To: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Message-ID: <d8a9dcab-4fc6-1f28-d6b2-e9231f3ba150@google.com>
References: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

s390_wiggle_split_folio() has no good reason to lru_add_drain_all(),
now that the per-cpu fbatch references are gone.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 arch/s390/kernel/uv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index dc14ebc0105b..120a467026a5 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -364,7 +364,6 @@ int s390_wiggle_split_folio(struct mm_struct *mm, struct folio *folio)
 
 	lockdep_assert_not_held(&mm->mmap_lock);
 	folio_wait_writeback(folio);
-	lru_add_drain_all();
 
 	if (!folio_test_large(folio))
 		return 0;
-- 
2.51.0

