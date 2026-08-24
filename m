Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A1343E9C3
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 14:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582360; cv=none; b=H8LUs5txA0OeGaM5W/Y+sHnl/Mbp4voQwN/sqSXcqsssK8eE1/wt7eGdClLTwU6yePjvbxuAHSgL4HDsVkuhcuC+73Che7p6fNMBXsZeuMtrVze5PGJKUybregbYtO9Dew5CxbflbXJGbxS3x16vSDCqPq+LNliGGH9yQG8QD/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582360; c=relaxed/simple;
	bh=RrFIEm8SrJEjhBjzApoefNfd8aQaR4Oxfr/yDuZhFPU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=r1wPV3AaoPizBQxN9i7HrTnQw2RwKVSrprmM+CVhvmt0IujjPM4W5Ovu+WvYZVFSHerywr3k2GWc6s7s/1sfwDCykNDvdN9nVjBPz+HvtlLD76ZKKqVSzBCj4NeMoMhlYoOrbcyUm2D1D449zbCkUrHlgxPtFafDi9/oY6gjwLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vHmlLxfi; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vHmlLxfi"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-81ff017d420so62202407b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 07:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787582358; x=1788187158; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2UY30k1UeQzYu1OvDSaJuzIQ8I7z52NjmS+xQ0qJeoY=;
        b=vHmlLxfitfZqNVju4Fys+i9kMW93CHbXhaQ4TweDYrYsnvNOrqfA4WWNkrT0GV/92H
         PYd56DwBcbzMkwVcAQkmr6KBnZVJJFOZsXEUcuPVnKXZwJKmJbGLyjkZerz1wOXyeEbD
         an7AWJQPNPrc/LaH7IVqH7T9ScABFmmDf224G9ZCReXmuCjOBYVw5TBayV+7kijVrrhf
         Jf2qsaDgt8SLMxtG6ZtvLErEWIVT61s7PJbodg/Md5vdN5JMfweDOaTuOU82gVunF2Ff
         9tMKMIW/oJYKvQXAbp7KTKpCVjXuhACi7jzA9Ay0MgByz8RsaI30eSuu6zLynm4l1OHD
         tZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787582358; x=1788187158;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2UY30k1UeQzYu1OvDSaJuzIQ8I7z52NjmS+xQ0qJeoY=;
        b=VZ4qKsIxN1OV3rodWk5NbybL7H747wM/7TwwJMcf861GyETBQ0R6OJNCe1BFDxNegR
         8/Zwb/VqGh9X2e2Aq5TmuH1LlTj/PhyigSaRucAFGQcky1H3YdHki00kGjYrhvSo/MZT
         YKV/8UoM+wKpdoXJ788bN6Bruan9z/ZXzvaJey7nJ27E2Fj6+m+iJvyi7a/Rb3x3pSJX
         eVHGP/QvsK1pmeQEZZIsuEPopL+nDJscNegYIALkYlKfaNJibbpZ/tLEgmAVbaBIcvVv
         dnfJkDUUKiZstRnNpQx3vR8AmxLGID2+UPZCC8X4rHZpP48bUam7KqgEGOS34bK/4ZdP
         LT3Q==
X-Forwarded-Encrypted: i=1; AHgh+RoGXJhD//+IvJJYcj+SySdmcSvYA8CTYNbCGBdwEm4MIHMIIzVYHI8asiwRpb9kw7pXvREaK8CNkRWV6g/x@vger.kernel.org
X-Gm-Message-State: AFuF++mrLsv/gRwkujHbg6Ny8I/gKvPUY5MrhfQJ+EVJUGIkegbfU6FK
	eTbBVcFX8WTD/CePHapfcd9p8mTpO6RwKD25PixueXyiIjOg2Kdv2F8x7nL3ef/HZQ==
X-Gm-Gg: AR+sD13evdqc9TPRXf6Mu7OU6WAP4meCVso0PDSynbE6Wz3DYv0P9cBYFFLS5KLRzem
	nJEu8AO0dbYA5PWXvW9yoh8+2c/5Anxm7gajQNOpcdiESVzDPI8xfRXy1AYg2y2SmuBJXugHIq6
	vWaXzfvcOLt6hWv59X6Olz5Q9yTEV+AEHXaR98c7oUejOgeiXUQ7DGjC2RrFyZUVdTJGZ1nbM1j
	xzMs/dj1CCEMDbS2dWk5pkgVLwb/eRzwWThKfVs7rHREkb63ykl8+GxNJ/UTm3vujmBRTkBwCYy
	HAi1OLWFRkv/dFvg71nJEeRVIG+fq2UUy8/GZ2vUWMdmvD7XYGx31EF7sPb4BAd/IktvwqzTYBa
	g3E7SEyaE4Qy4IDKfbTb4S9mRynfh85EIxAjjEdXd0QiSljjqpeV4ffiRhk2uAVxYdef3C2pp7V
	ZUBXJegJINFPB4GQb9AdJYPp8U8/3Vk6AnvIEn4oX350C3PyJeeEoC/+p3kIM2KfnFROih/WDFh
	zU6Gy5wtlpEZ9aFIMizLTkU+J8l6gLBCUrY1FuhdPQ2nMn2
X-Received: by 2002:a05:690c:c221:b0:81e:a373:47ad with SMTP id 00721157ae682-847073b93fbmr133529677b3.2.1787582357182;
        Mon, 24 Aug 2026 07:39:17 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84ca5188982sm35471097b3.10.2026.08.24.07.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 07:39:16 -0700 (PDT)
Date: Mon, 24 Aug 2026 07:39:12 -0700 (PDT)
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
Subject: [PATCH 20/25] s390/fbatch: no lru_add_drain_all() in
 s390_wiggle_split_folio()
In-Reply-To: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Message-ID: <7bf68e7b-f88c-6ca9-39ab-e9fedab0c8be@google.com>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
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

