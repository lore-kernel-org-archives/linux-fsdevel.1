Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937073932D0
	for <linux-fsdevel@vger.kernel.org>; Sat, 12 Sep 2026 22:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789250846; cv=none; b=j0B6lXlGSHxggAGDb+BCvqb3lcmpnWzeNWAfYH9C9yWAn6dz75anDmT2X6+PrM1TI10zzNsjR8E1sbI9lhErkFs7hUMu0a1ZOEzLuu5CrdYGg9En+lkCWkT8vfoasRAC+BvJSgdbmZ+UQtHwQbMANasjexHMHw0kKbBGfoeQHy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789250846; c=relaxed/simple;
	bh=aO0EnKRtbp4eQRdiajrWBnJhUoH5QBxQwM0G7h6ERwI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jzIAvmZRHGCUhxDdGpU7d3UonI50z21ztqCxIqbygogspUyl21X4aEL4taOOKOecIuST4lMaAtuNEglD2CeBzfabz6MVTvv6ZiZ0/EfvRyijATM1APlwN8XGIaYNrpr58mu9JP1fN4YHEn54Kk5U7lKzanEQRcnHTxVAcSGIrzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BRtj19Jm; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BRtj19Jm"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f633cd80so292062f8f.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Sep 2026 15:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789250843; x=1789855643; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rv9y+bdGfrIVxvXFR+/Wb3gMq5lM5A+QpTE+pSCVxcc=;
        b=BRtj19Jm3XCuIKfHnRQELeUcgfjAhTyscn/BtZ8qnMuQa6d+j51+unk7VwNUWZf+W+
         z98zEU9F7KpbgDTYRN9CQG76ae8O5OaHYSxjk2fyPnfLbVVCgQe1GpnB+3BUoQbksT8T
         Ct0IURHezJufjPd0Q95+dOpvacKfd4kHwQjz7dq9GAhQ0uBfy2adJ9KDnoGBzzNfdyrj
         jq0Zjy/dG+dlM+L+FKdSBRrDRzQDL8Phc/G6LYFhl2VreS/DYy8FSgxe9JYYpLf1r0iY
         XAmnSKFNOgWspEwTi5Ob8sPA6HyrYtkrnbUnuucJCLBcHh1ayw8MPm3n1jVkCDl7WW+y
         rHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789250843; x=1789855643;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rv9y+bdGfrIVxvXFR+/Wb3gMq5lM5A+QpTE+pSCVxcc=;
        b=pssj7gg+AYcD30UsOL7pglh8FQUu0wP9gnCBWbWXhQO7k2DC+OZxL5MRTXh0AAAkM4
         lTVfuBYvWoplyymgYYme/xm8LCe5FvYiOGi3GFWN3k2INY2rB2rDamc5HvBBsN9zWvxs
         1FvJgsSuQT/lc1Yb2bdZsKI8zHSEyRMfx9lGrficQ8xXvEEmeBTDALISrYzUmMWzUJqh
         8IFKT+pWJMgnuY0DZI2FRk8zgJ3vdMQXCvxB4K3483UQLq5px0nfPZTWpORr7uS/tOZ9
         wCqTEQXcn/PAtkZwmhQdymYJq0oauQF7fAGEBVJHgJ1VfO5Tz8Q+eFglq0q9YMaYJ5Jq
         H2WQ==
X-Forwarded-Encrypted: i=1; AKwUvBx/p8HwKN9B/EOS10lTgCyeqwGyLQVD8tXKQ9faIqNkCx6u5fun8jQa8tnR3ZnmWjXFGa2z1pZPDbW4fSM2@vger.kernel.org
X-Gm-Message-State: AFuF++lBHT6cb4oCfm0PqMiXrgeGo6RcgHRfAf2Q0Labcp3gNHp+7dHq
	WCuK91/6LqdQUVKmez08o/l8xtNDpLDvGgHPcltuCwFG3qHDjkm00EkAs9B0np/O1g==
X-Gm-Gg: AYBFou1CUc9+xCEum9nvJV0rMP/DrESv7fL1v3Qbq+IrcuLmFcXYz4WDbBfPX/IQqlb
	4pAhYNCdFO+mFgGMIjCUWXvgbpeB/c6yLEhAOGdEZXD+Y+rAssSwwuN5cLpKe42fQVLEdjNvmga
	tJ720ZQKgwyeQG5gJPctK482hG/B3CRJJkT+mUiV0st+RgC69FIp7JpFBpmqt5Y5i8xYgizMZnn
	WhWkzUabxgjN9j0lLVcOA1EWBVIxzXhoslQALE//p33wOiAHv/5rOycfMT4WNa84BTTXhlbgxZ6
	h1/w06j3gWXBfvkf217VJt9Yo2ErME5SkKKryucNSOGxLAwRUrZtJSBRdUXs2y64+tJ4OXyAbP0
	/iSIvqZpkRnZOFa9bnC4ELnVl6T8/LB6folTaZag4vyRIW9P0dE14fSo7EAZOj30tCT8wmrrv/v
	g0twddeXTNWc2N8DokJhAuU/hqYUnmn9n5Iudpq2iPgnfxW+bIEtROBb/HaiexwGijeeHk4vq2s
	Vz4e6AGSygBU7jfKFBK
X-Received: by 2002:a05:6000:2f8a:b0:486:e920:6726 with SMTP id ffacd0b85a97d-486f6d5956dmr4081301f8f.51.1789250842159;
        Sat, 12 Sep 2026 15:07:22 -0700 (PDT)
Received: from darker.lan (104.157.125.91.dyn.plus.net. [91.125.157.104])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb33ee5csm15513089f8f.20.2026.09.12.15.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 15:07:20 -0700 (PDT)
Date: Sat, 12 Sep 2026 15:07:18 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    Ackerley Tng <ackerleytng@google.com>, 
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
    Yang Shi <yang@os.amperecomputing.com>, Yu Zhao <yuzhao@google.com>, 
    Zach O'Keefe <zokeefe@google.com>, Zi Yan <ziy@nvidia.com>, 
    linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 06/26] mm/fbatch: fbatch_drain_lazyfree(onstack fbatch)
 before ptl unlock
In-Reply-To: <ac4fedf1-168f-4166-8059-353f2cbf04ae@kernel.org>
Message-ID: <9ca87753-6851-7b54-4305-75d5319b069d@google.com>
References: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com> <17e1a6c3-525b-1cc3-0731-349f0850e3ea@google.com> <ac4fedf1-168f-4166-8059-353f2cbf04ae@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 9 Sep 2026, Vlastimil Babka (SUSE) wrote:
> On 9/9/26 11:53, Hugh Dickins wrote:
> > Re-enable lazyfree batching for MADV_FREE. But it's not safe now to leave
> > potentially stale (then reused) folios in a per-cpu fbatch for lazyfree.
> > Instead, madvise_free_pte_range() keep an fbatch on its stack, and drain
> > it each time before dropping pagetable lock, while the folios are secure.
> > 
> > Ignore folio_may_be_lru_cached() and lru_cache_disabled(): limitations
> > irrelevant to this fbatch drained under spinlock (even if RT); though
> > in practice madvise_free_huge_pmd() does have to drain every time.
> > 
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> 
> It seems correct to me, so:
> 
> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

Thanks.

> 
> Might be that something regresses performance though. Guess we'll see.
> 
> Also seems to me that if this patch was preparatory, the batching wouldn't
> have to be temporarily disabled. Doesn't matter ultimately though.

That's true, the order of patches does rather reflect the order in
which I got to think about things - but I thought it might be easiest
to review in this way too. I was anxious to get to the core patch (04/26)
as quickly as possible, to find out whether the idea would fly at all;
I could see lazyfree was a problem, but wanted to put off its solution.

Hugh
