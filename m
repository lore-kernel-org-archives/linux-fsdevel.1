Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851CD34A79D
	for <linux-fsdevel@vger.kernel.org>; Sat, 12 Sep 2026 22:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789250421; cv=none; b=gSPWfx4WQ4vd/e5VqeKB3blIojAW9OHG6H/LthYmuO77xYHcIra28TtfJoK5ZMKae/CPWihFX3ukMtrcoCwSn0FIdgE6MH8+kMub0SLRtWeIGORflDR3UuR1ZUh0Mm8+ZnSWP71zSVAy8sgn4i5SOy6tbY8jYIKZ1i1UULWEdYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789250421; c=relaxed/simple;
	bh=VSjoq7DHQbKtAdXTo08YR1Ci+Z/OuPpj5YnrQdVytbE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IG2mFzq59OUqvBHxm0eF5Ok+cUXEdqcO0qThD3lvm3GmNVVFg1i8p6KQmTDJZJQa7pPcB8PahAX3900F+fp4qvh0JLWgZ4ZBPLPBfGpw4G05kCRsIPEapyKcBE16I6N+lK9O1Wsh+V56WzN+r8Hr5MQjPKxSP1mVq3DhXXzE+fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tvpxxhm9; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tvpxxhm9"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cc9f581c4so2884745e9.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Sep 2026 15:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789250418; x=1789855218; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ShFFlTNrkhtcTY1WEEF9s6hCAewZPx0n3fIe5hLvRZo=;
        b=Tvpxxhm9rJ8WYRsBiT/xjrzlhS8DbT5GvMsIGw4HPVU5QKIJmMRgcsppKv9nv2phYu
         Smm/6rEmmKyBtuARBmoOEVXmW5ZriVYBlP7EEQ5PKrRkG742u4jbetZ/Dfqp9yyn60+3
         SKhPb2LbNnF9MLFn2nUFE29SIgp+5w/pG9aboVgbVSmhCsSjzx3/3b9Q+/C5gM3QGpnc
         CIdR2WGwKyN/4T2f6Ds7cHMU4y8vdDgqRtdmwmapMz3PA5SIOaMtgB+8hAkpwk/+HNEF
         gYeASik22FtEXcjOZFnKZEEZ0z2+femILPQUMSHbk2C14J9qhK4aKSwtCDujKL42xvcG
         e1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789250418; x=1789855218;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ShFFlTNrkhtcTY1WEEF9s6hCAewZPx0n3fIe5hLvRZo=;
        b=BArr98hMxBTXakTVB9aR6NndKyfl3xmR54yJkmCTR1+WLWQugxvOKaRY1AJP0RwqN/
         a+S+6sbujwAgEciuVuTr3t0S/gMh/k8A9JVQ2yxAzJV0ix6ni2xS/JLA/xtoFVK/Wz3K
         zQ6KpMGJZ7LGjLZ06R7jlvJpMdc+tplE6mLreUrD275G1JEaQhaxi5Ib/mXrWu7AKp0E
         gYKnhd4pBgajM5i0qqzgHODP7ihee3PhUYHUFzCucx1FY2NwSMkL4NatySe6gzu5UsS+
         i3gz4J05ZmjEk6z/eYLDStKhu2WQCLmmX9g32FHBWSCgK2n01mH4FA1YkSyrhAhn3PFs
         dy9g==
X-Forwarded-Encrypted: i=1; AKwUvBx7R6qn0i9CZwizDGm0zCYat38SIiMJjpix2FJ4nfnnFRYl7PtMM1SomOhEb8Zb+xgUi1sladp3wscqFA+i@vger.kernel.org
X-Gm-Message-State: AFuF++ngGKVVABwj6znh895WHm0FCo7WKjI5DoRHnYaZiycBGA6VSIMZ
	ccq9VIDm9eO2AdomvHRDPr+IHGkDoLDEhcoXIbIpZWZevIieMKXQjWQMoyweMUWBHg==
X-Gm-Gg: AYBFou28J3Ux8GrMbmtIhTlgHVR/ClC3w/WoH8/ztGHuOYlhRMPjydHtQkGqekxt3gI
	8FPRtcziJwKObZ2zLHpxhjD+pQVcKySVOIQWyGGkDlB0PoKOdInYZw2wfas04ljw/JoTrc1dBZ/
	B2GRS7H5CiUUVM5XOWUaw/i5EsCYwR2qvm3T1X06QPvyQ76OktAtZWm0ldyfsxwzNFAKcp0+bcH
	t6qd8MceVPI0hL5Fac2afvqmoj5VjxWwk0yc3FxP9KIRCpEA2L4WFh2AjbSym3Xm03tfFFAfJwJ
	iI5j8tlc4f+wJwbhq20YGYxXS8De6UX97nJu11v0na+GJbRU5nx9qN0goAETJr+SdUQXjC0ZHpm
	3JSEuSaj04s/hZ9NvdpONOjgbENGd9m942Q4vRo0Uy5dfUKZIP2BBI9nZ9LQaPBBmc9JXCiB76V
	1ErRl3GdVN8E8F+rTXe4LiZYzp8pjBnl1OMAuyqQnI9yRCI5BYDWObrPv1Zbb7zUzLfxxcgxKVe
	V1iELr5b/PTgbs7zhpe
X-Received: by 2002:a05:600c:3115:b0:49d:1e79:35d6 with SMTP id 5b1f17b1804b1-49e61094b9bmr117724205e9.14.1789250416975;
        Sat, 12 Sep 2026 15:00:16 -0700 (PDT)
Received: from darker.lan (104.157.125.91.dyn.plus.net. [91.125.157.104])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e64221639sm67265195e9.4.2026.09.12.15.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 15:00:16 -0700 (PDT)
Date: Sat, 12 Sep 2026 14:59:23 -0700 (PDT)
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
Subject: Re: [PATCH v2 05/26] mm/fbatch: lru_add_del_folio()+folio_add_lru()
 after clear_lru()
In-Reply-To: <af864862-90f9-4b16-a06e-1c189c4c4d6b@kernel.org>
Message-ID: <5c943056-cf6b-788f-aa45-b7c0da28ecf2@google.com>
References: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com> <b2e312f3-6909-5496-195f-ab71b45970ac@google.com> <af864862-90f9-4b16-a06e-1c189c4c4d6b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 9 Sep 2026, Vlastimil Babka (SUSE) wrote:
> On 9/9/26 11:51, Hugh Dickins wrote:
> > Most callers of folio_test_clear_lru() then proceed to remove the folio
> > from its lru, and add it back at the end when they're done (if still in
> > use). But isolate_migratepages_block() and check_move_unevictable_pages()
> > sometimes decide against, and release immediately with a folio_set_lru().
> > 
> > Which usually works fine: but there's now a small chance that while they
> > held the folio with lru bit cleared, an lru_add fbatch drain came along,
> > and had to skip that folio because its lru bit was transiently cleared
> > (previously, the lru_add fbatch drain relied on finding lru bit never yet
> > set). This risks leaving that folio off lru, unreclaimable until freed.
> 
> So this makes the previous patch a somewhat bisection hazard? I guess it's
> acceptable given it's not fatal.

Not what I would call a bisection hazard. Yes, the preceding patch
is not perfect, but more reviewable that way, and then come corrections
to edge cases best considered by themselves. Nobody bisecting unrelated
issues would get held up by this gap, and it won't crash any bisections.

> 
> > Fix such cases by trying lru_add_del_folio() (which only takes action and
> > returns true if the folio was on an lru_add fbatch), then folio_add_lru()
> 
> Oh ok, that's one detail I didn't realize on the previous patch, and
> explains the name of the function. But it's still IMHO confusing.
> 
> > if it succeeded: invalidating the old fbatch slot, appending in a new one.
> > 
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> 
> In general, LGTM.
> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

Thanks.

> 
> Nit below:

> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index f11491ee9ed5..4e8d5cc34f07 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -8093,17 +8093,19 @@ void check_move_unevictable_folios(struct folio_batch *fbatch)
> >  			folio_clear_unevictable(folio);
> >  			lruvec_add_folio(lruvec, folio);
> >  			pgrescued += nr_pages;
> > +		} else if (lru_add_del_folio(folio)) {
> > +			lruvec_unlock_irq(lruvec);
> > +			folio_add_lru(folio);
> > +			lruvec = NULL;
> >  		}
> > -		folio_set_lru(folio);
> > +		if (lruvec)
> > +			folio_set_lru(folio);
> >  	}
> >  
> > -	if (lruvec) {
> > -		__count_vm_events(UNEVICTABLE_PGRESCUED, pgrescued);
> > -		__count_vm_events(UNEVICTABLE_PGSCANNED, pgscanned);
> > +	if (lruvec)
> >  		lruvec_unlock_irq(lruvec);
> > -	} else if (pgscanned) {
> > -		count_vm_events(UNEVICTABLE_PGSCANNED, pgscanned);
> > -	}
> > +	count_vm_events(UNEVICTABLE_PGRESCUED, pgrescued);
> > +	count_vm_events(UNEVICTABLE_PGSCANNED, pgscanned);
> 
> AFAIU this is done because we can no longer rule out that !lruvec means
> pgrescued is 0.
> But we can still distinguish the cheaper __count_vm_events vs
> count_vm_events? Probably all the same on x86, but I hear on arm64 this_cpu*
> ops have a cost worth proposing rather elaborate schemes to deal with...

Yes, it was just looking a bit baroque to still be deciding whether to
use the __count or the count there. Could be done of course, and with
"if (pgrescued)" and "if (pgscanned)"; but I haven't noticed anywhere
else in the source where we go to such lengths to use __count versus
count, and I don't think this is on anyone's hotpath (IIRC this is
just SHM_UNLOCK).

Now you've got me worried, no, fractionally worried, about Shakeel's
recent __count to count fix to NR_MLOCK.

I am much more familiar with x86, and have noticed the recent tussles
over improving arm64 this_cpus, so that confirms you're right; but I'd
look for juicier low-hanging fruit than this, if we're going to
embark on an "if (x) __count() else count()" spree.

Hugh
