Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49C93769FB;
	Mon, 21 Sep 2026 19:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790019939; cv=none; b=mpnWffzi9+jc9RnoXDeJrng04syLoQF70cMZQ1SYysEYCNKY7DtFLKtQaKqtbquca5tAZ0WkSCd1Hy7HHyupbTXb6apLysfSVlF+Ar6SpVN9bXWqwYPar2/nkcZoCY7JjNNViaMQ4Ksu1DBjioEyuGegwhhQQCaWv/g/Yv7yH50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790019939; c=relaxed/simple;
	bh=Pu7f8dHTmAVbcbO5Am1juduR/q4XXo7nAJWewjSIgI8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JVAq95q3jiRdCeDjtVqdrXFxFEoR3g0f06lQgiveaDfucK1eX67hbw9g7pJN/5Uw7UFTSpmRp8VclPZQFQ5oj26rDyq0ckWufNcFfs6cCmSqKjHpDdcwA437/hKcH32kHWh175NLCLbNgjIWJigxSvDV7TxtC/FolyWhN6RyD7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=vGeqROWP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="vGeqROWP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450941F000FF;
	Mon, 21 Sep 2026 19:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1790019938;
	bh=VmdfqmBH4jrhaxwTCYSeFkpBAeDxBk63Act7QDZ3RcA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=vGeqROWPC+MoRonoRVJLURAv4yAo8Fhxj7II7mEW8uh5O2dmMGBK1DkNsf3qD1iYP
	 F0t2Nh9vLrlUE39++lWcI0DY/IMFfOT8G7kyPI3ZjX5X0FyMvGJa95n08kCprxcZof
	 Vkoi1X4y8Q2RfEB2jsGN29k+a9T5AOyE4L5tr7Rc=
Date: Mon, 21 Sep 2026 12:45:36 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry@kernel.org>,
 Nhat Pham <nphamcs@gmail.com>, Chris Li <chrisl@kernel.org>, Kairui Song
 <kasong@tencent.com>, Kairui Song <ryncsn@gmail.com>, Chengming Zhou
 <chengming.zhou@linux.dev>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Jan Kara <jack@suse.cz>, Kemeng Shi
 <shikemeng@huaweicloud.com>, Baoquan He <baoquan.he@linux.dev>, Barry Song
 <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, David
 Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Michal
 Hocko <mhocko@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, Qi
 Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Wei Xu
 <weixugc@google.com>, Yuanchu Xie <yuanchu@google.com>, Kunwu Chan
 <kunwu.chan@gmail.com>, Tal Zussman <tz2294@columbia.edu>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 0/3] mm: zswap: free cold writeback folios promptly
Message-Id: <20260921124536.7a1857853ad7629f061a106b@linux-foundation.org>
In-Reply-To: <20260921151306.625134-1-alex@ghiti.fr>
References: <20260921151306.625134-1-alex@ghiti.fr>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Sep 2026 17:13:01 +0200 Alexandre Ghiti <alex@ghiti.fr> wrote:

> When zswap writes an entry back, it allocates an order-0 swap cache folio,
> decompresses into it, and issues the write. The folio is cold by
> construction, yet today it is left on the LRU for page reclaim to find and
> free later. That wastes a reclaim scan and keeps cold memory resident
> longer than necessary.
> 
> Rather than implement this in zswap, extend the existing dropbehind
> mechanism to swap cache folios and have zswap opt into it (Yosry). A
> PG_dropbehind folio is already dropped from its cache once writeback
> completes instead of being left for reclaim; for a swap cache folio that
> "drop" is removing it from the swap cache.

Thanks, I updated mm.git's mm-unstable branch to this version.

> Changes in v6:
> - No functional change: this version only updates changelogs and collects
>   tags.

Confirmed.

> - Patch 1: fix the changelog. The first paragraph describes the behaviour
>   before the patch, so it must name swap_cache_alloc_folio(), not the
>   __swap_cache_alloc_folio() this patch introduces, and the last paragraph
>   now says the helper is renamed as well as that the LRU insertion is
>   deferred (Kairui).
> - Patch 2: fix the changelog. The swap cluster lock is a spinlock taken
>   with interrupts disabled and does not sleep; the folio lock is what the
>   drop blocks on, and that is why the completion needs task context. Also
>   spell out why it blocks instead of using folio_trylock() (Barry).
> - Collect Reviewed-by tags. Thanks to Kairui, Barry and Nhat for the
>   reviews! Kairui's tag on patch 1 was given on the posting of the zswap
>   writeback refault series [1], which carries the same patch.

