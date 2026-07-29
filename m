Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ACA3B059D
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 16:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785343541; cv=none; b=G34tF4Q8qJtr8uTJXsDqKcRyxmJq6cGX0F1dkc7cr+3/2iRk/Pe9wXfT0mFdSNBpYlIEaugO6hi6dKqWAYCNEQN33KLVmn80r41iqvxsBMJaTa8HkWRXc9AAWUI7gEodMbmWDTRchPYr9nEDzC1gCkdWBXbP8XTKFlIEnryafms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785343541; c=relaxed/simple;
	bh=BUcy0OJ1HeFUh7S94vbth1x9g1Pl3UxFo1yLAOOzYPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HmdBo3NxNlHTwp0ZF3mcy6py6pob4G9NNZYD6aocKGWAWe4MXniGJEAU8xJVPSYQE4CbMoF5P2nHvvdR+QQ1Yu0UNJjEvjnBTG8EoCkCt/+7d/Ygu3X4slNZD7Fa+1nUV1Hf3++3W7TC+ccSXbIVkiisZPd+tSB/7mHfJQJcK68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=erzJtMUJ; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="erzJtMUJ"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8ee6912d86dso7962326d6.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 09:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1785343534; x=1785948334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3ZiDYlOZHMR29bIdu7HPNBG+9FYDGI/12tsRJlqZmQI=;
        b=erzJtMUJPIGwEHyz0VWzKsR5OUndK9FECwJBIG33mZ5m5u3TekFESB7cnrKFPSk/Q3
         LV2Yifg9fgu1jaqM4RBw6iEq/D4e/uiKKi247oQa5M2orhUVbx96+zx5je21UfZIGxZL
         itQulkVdoNH1RsEPzbc3fhomRQSoNTE4MQY8Cr03Sv9q6GTPNJZhgZ1NOqLX4XgXRp0A
         jim80J6PtLp7JlMveznVMoEQe4MUfDpW7Siw7U6GyAV0McA4xx5ICsmReoyhGi+ap/8K
         xgwVJ/ucbV11x9sh8+enIvEip+CQqeWQu3lp8hQorlCcW9j5TxrhTZEOL2UxcxOJsfRB
         2zAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785343534; x=1785948334;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3ZiDYlOZHMR29bIdu7HPNBG+9FYDGI/12tsRJlqZmQI=;
        b=RivEV1sOPQEou9KbKeB9O1k//KtHWrbjjF66Ob4vNuKsvFmWC4KEtjjY8eEdge23Rh
         BSiizMRGwq0plIXihSekJ0d5tBZeSvyYPSyqKgrQjiTH+HNf8tK7Xt7WcxKl+n3k+Njz
         DzlEoePD3JVYs0DBtLfyPMJRj32sCbBX8H/AfV8ZSanwsOblzKGwPGFbyl/x92Q7SJ4F
         JWf47Qbapx81BX/hm0EUCp+Ew29Oas/owG8nOF/kwH5cnbzlxgmffxYDfXowFK48Nhfd
         2FECmIuF6VYH7hKGTlS+VgjqnMZmw9tU7dlqpDlrvmfJS1YoqMNPO7EhsCuYUmdVZCm1
         Xxeg==
X-Forwarded-Encrypted: i=1; AHgh+RrhkQucIV8OQBZ4n8yGXBEeSgROQIODJSlS/JgIa5qFobOWmBa3naM4FPZtr6P7y7nIsfemFPFhomrjexV7@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj4Q6ZGw0hbFFCG87l4GxlIhU6k9XMYDEnxYZcejVnQmvfAuHB
	iTUi/zz/jUkUhzJU8GxrtP4EiMDFNz1bCxq0CbuG3GqZEt3vJnMEHVktM1h2VekmIIo=
X-Gm-Gg: AR+sD10uQ72xcKn2KieRBWCNn3rQhgWx1FkO5nExhmKTlxjIUe2/ueafdL2mvbL6BKT
	By002tI0C92hFCcTP1mnZvDQib6Cad3N9OhCjDaRhi6nYf3Bv1cR/BntU5J3om6/i3lSRgPRIYu
	zxlwtSbOJlcBhHuG5d9xqAR0Jwq2mgr++Xg3wpBpc1TmBxjZ0HJNQzODWjZjmEKaUL875qSm+LW
	HnZpDUDgI8de36R8WVWlpYHAriZCpHti6Go6xgfzMPU8DLRbZJLpQUZT+j2iS37NcCfr+07c1vj
	aC4WYGiU5A77RjrOD4Hwwxyj/w5QbtpZX9/gdnpK79gpnPUXMoHdnO8o8OdsZdFIPgbLdy4h+FP
	ucby97jP6lqOI6dcPj3uqeZPWpzo9rJnFKZwtq6nNaUOvw77fdBeCH5PR4StUWLI2NPtVia0Z/6
	EEUF6xxwVyOtfF4i5xdzUVC2PNJ2qCYEM5Og/qwuwmIUvaYVnT5VjT6erl+HL89Xiprr8o+aDL8
	IcqkPkEbvm+NnBPXmYrJ7lu74P83W0NKeK5ySNxm68N
X-Received: by 2002:a05:6214:3213:b0:904:4275:e165 with SMTP id 6a1803df08f44-90816f81939mr87398986d6.19.1785343534135;
        Wed, 29 Jul 2026 09:45:34 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9081f77f713sm24503226d6.17.2026.07.29.09.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 09:45:32 -0700 (PDT)
Date: Wed, 29 Jul 2026 12:45:30 -0400
From: Gregory Price <gourry@gourry.net>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <christian@brauner.io>, Jiaqi Yan <jiaqiyan@google.com>
Subject: Re: [PATCH v7 06/13] hugetlb: Use the has_hwpoisoned flag
Message-ID: <amot-Zo0qsspKvKK@gourry-fedora-PF4VCD3F>
References: <20260728204409.3396238-1-willy@infradead.org>
 <20260728204409.3396238-7-willy@infradead.org>
 <amlQYkGgLmxmwX9_@gourry-fedora-PF4VCD3F>
 <amlrjtaFSEQLYbEO@casper.infradead.org>
 <amoWqtYhXm9_Bxhf@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amoWqtYhXm9_Bxhf@casper.infradead.org>

On Wed, Jul 29, 2026 at 04:05:14PM +0100, Matthew Wilcox wrote:
> On Wed, Jul 29, 2026 at 03:55:10AM +0100, Matthew Wilcox wrote:
> > > > @@ -2725,13 +2748,19 @@ int unpoison_memory(unsigned long pfn)
> > > >  
> > > Adding new synchronization here without noting why - it's not
> > > immediately clear what this synchronizes.
> > > 
> > > Is this just fixing an unrelated bug / should it be a separate patch?
> > 
> > This prevents a hugetlb folio (which in this arm we don't have a
> > reference on) from being freed.  I think it ended up in this patch
> > because Sashiko pointed out the race during review of this patch.
> > It could probably go in its own patch 
> 
> OK, split out into its own patch.  The 0day bot chewed on it a bit and
> came up with a config that enabled MEMORY_FAILURE and disabled HUGETLB
> which showed a missing hugetlb_lock symbol.  Here's the new patch:
> 
> commit 9df49152f5de
> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> Date:   Wed Jul 29 08:41:50 2026 -0400
> 
>     memory-failure: Prevent hugetlb freeing during unpoisoning
>     
>     If we fail to get a reference on the hugetlb folio, then it might be
>     freed as we operate on it.  Prevent the freeing and the attendant races
>     around manipulation of the raw_hwp list by holding the hugetlb_lock,
>     which is also held by the hugetlb code when freeing hugetlb folios.
>     
>     Fixes: ac5fcde0a96a ("mm, hwpoison: make unpoison aware of raw error info in hwpoisoned hugepage")
>     Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 

nice - if/when you respin or submit this separately:

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

