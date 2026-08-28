Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321323CB552
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 08:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787904295; cv=none; b=lQxbdk+yYc5FHAHCUHwy6tEgo+lUCUgsY1YuJIWDRak+RC93IuwFJHG3kWKao0gOCiTvjTWVk9DucapbTBEh3Bjaq9p8DSRSCZr5MZrHg/O6BMDqRGZ1j2k+tVFE6hE44KdQKtmjkLHjnv/gIF6H3f0m76AtkHVnX20bk0Fce2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787904295; c=relaxed/simple;
	bh=+Z1sz08sC1OLnnsRQrZbBoZJEG+XRT6Xi6xh/5v8fzU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=vFnPRuS/1vtkg/tW6zUe39bXXF+17uS2CbX7wukqBkQJwOn/Urp0UBd18be3DXbPCuK9uEOgkJVp0s30v8lPPgum4yTLDxi88pn51lGuAboKw6+bRO5Yj4A1bn/rZWdyai8d9EZ5qjfU2de7ZLSjJCHS4FZTsLDM2EEX20noFl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BWSwcvhS; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BWSwcvhS"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-836c4474028so9445887b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 01:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787904293; x=1788509093; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cziOTKmVhxUE52ibRD2kF7eNQJ4Wv/wGrdlgF7Hd+bw=;
        b=BWSwcvhSk/PxXFlZEaeHj6C0tD7bH6ccPc/I3cx/on9JjEUwBsE9kvDMXOdeOLoIqg
         ZBwDUMKwS9rZ9tc5Xgk0FOje0LaDrcwinuggTdfXian9r980LEE/rXiTg9N5h0819ck0
         cKqkxB9d/qlxDAdlE5Y+EPARRkTaiemPgVM9YBJORyyPuQRFDDdTd9PjCTMpzIjaUyvE
         D6wFpghurIa1+DP++x61d7O3UWvCaHiEQE3F2sMA7Yjc4FUlyJkOXl69UFUvFyErX2GA
         9Kw+AoSUdn1OozsV/68wU7BmkqljlvKq2uKWblED7BaMingK+gCa+tnzKmm9JQRTs/kI
         d27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787904293; x=1788509093;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cziOTKmVhxUE52ibRD2kF7eNQJ4Wv/wGrdlgF7Hd+bw=;
        b=h5pZUJ7U2nbI3C0nFXrNRPHArV/oOJbgfizvGyjKi4r5Z5jZUJ3ddtWayGDpuRmQiv
         Box6b17kFpfNdDcWDOMejfMjZl99Yy/gC/HpgfJMa370nIWFtq22qDdVX7sWFhPLQ0ms
         dUye3niXFCrIcn3v6OjSngKMY0L+0R+QXzl+7z+xLLElkLAf6+yJcVMmV4bSiOWV4mj1
         U0dg9zXhWIHpy/N8qnwa5au3L6ZbxOVmi9IvnW0HUQ2EdrsKEMhp9xuInuG76Du/4QB7
         4fNb4zJxESqiT6qztCIhohwxGW9iFeSCXKlwzHWZUewUmZfIR+viIR6Nyyi3q/RLfKvr
         hvGQ==
X-Forwarded-Encrypted: i=1; AHgh+RqZYAS8UNqIrBPyq9MZI5MeZ0SbBbkAh0BIHTcK66L25aUAMLPqjKsn7f+j3Xv+KJ3eU84u3Qeok6IATPvS@vger.kernel.org
X-Gm-Message-State: AFuF++l95NubO2gDWYS79grdqAnTLNjP9w1UmKAGQM2QIhZDZkwLA4wx
	3cHKTM7m6/BxY2wYGUYFxWnKvW3X8uvhO1dFVlniQLr9dcrb6SL8wHhTG5pE3eW1kw==
X-Gm-Gg: AR+sD13ewlIhXQFm/KgsGtdpceS31QrUZ127Pi0OO8d+bk1KMor0caKTxV7Zt/+5+CE
	dIStrIynuJv+mRD82eAV9KpClt+NKECQ7lMQi4omUbm/kvurccRHnESyh3evhuzqknOpyBKOme1
	988ebtK/BGl72mFiHr9NxHrz+mrPbuDKBMkXJwnRvt5C8B0I/nJGBb9QMpdtn9rh9BMMhIpGUo3
	So+7VUiu99mYFzJ99eYTJwp3dwUch0p9GlocJ48YpBnchALzS5tAnHygQ3bcpJ1+SozEDlhXwZb
	6yuBJyoDGQTLtIfl1WkI4lYX/alLAzkanWO4osWN5UKJDcf4y0YTInogOYY4OTo4uypdPhr64ZT
	u+mtNNBiT770x1HNJghIoI1BYCeF3tvC4Enz+Zu5fc0ITOntvmrSvJ2fx1jjXgzQ6gvsMdqlGCP
	7HX+kUH/qv9xJ0FSkHfAReLkq2j8TkBZbA6piDBhMbBAqNbH/Ikbr0pXsDodKPLV7YDXF1Dad1+
	SuU35725XoZcanXbanBtItha2AXTFL/jypq2eq/DGj66xXe
X-Received: by 2002:a05:690c:4f89:b0:80d:15a3:7b1c with SMTP id 00721157ae682-85d68a8ebdamr19896027b3.4.1787904292453;
        Fri, 28 Aug 2026 01:04:52 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e5e181d7asm3395277b3.4.2026.08.28.01.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 01:04:51 -0700 (PDT)
Date: Fri, 28 Aug 2026 01:04:34 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Kiryl Shutsemau <kas@kernel.org>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    Ackerley Tng <ackerleytng@google.com>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Barry Song <baohua@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
    Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>, 
    Christoph Lameter <cl@gentwo.org>, 
    Claudio Imbrenda <imbrenda@linux.ibm.com>, 
    David Hildenbrand <david@kernel.org>, JP Kobryn <jp.kobryn@linux.dev>, 
    Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
    Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <ryncsn@gmail.com>, 
    Lance Yang <lance.yang@linux.dev>, Leonardo Bras <leobras.c@gmail.com>, 
    Lorenzo Stoakes <ljs@kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>, 
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
Subject: Re: [PATCH 04/25] mm/fbatch: lru bit set, no extra ref, while folio
 on per-cpu fbatch
In-Reply-To: <apAaWsWPV9QEeVwn@thinkstation>
Message-ID: <3b8d9cc4-d6f9-6bd6-f774-34cfca9c48c9@google.com>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com> <e0887417-85a7-453e-e733-561dc11db08f@google.com> <apAaWsWPV9QEeVwn@thinkstation>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 27 Aug 2026, Kiryl Shutsemau wrote:
> On Mon, Aug 24, 2026 at 07:01:20AM -0700, Hugh Dickins wrote:
> > Treat folios on a per-cpu fbatch as if they were already on the lruvec:
> > with PG_lru set, without holding an extra reference. This will enable
> > the removal of most lru_add_drain() and lru_add_drain_all() calls soon.
> > 
> > Recognize such a folio by 0x02 set in the folio->lru.next pointer by
> > folio_add_lru().
> 
> Hm. pfmemalloc (__GFP_MEMALLOC) thingy already claims the bit. Is it
> safe because such memory is never on LRU?
> 
> Are pfmemalloc and PG_lru mutually exclusive?
> 
> Do we want to be explicit about this? Like, folio/page_is_pfmemalloc()
> shouldn't return true for PG_lru folios/pages or something.

Gosh, thanks so much for pointing that out: I was completely ignorant
of the the pfmemalloc use, and a bit (bit 1!) shocked to learn of it
(why wouldn't they just reuse a pageflag, I wonder? but doesn't matter).

Anyway, as you've rightly guessed, it's not a problem at all: these
mm/folio.c and mm/mlock.c per-cpu fbatches are entirely for folios;
and if any pfmemalloced page ever get used for a folio (dunno) and
put on an fbatch for LRU, then of course its use of lru.next is
immediately overwritten (first by what this patch writes in lru_next,
then later by the lru.next pointer for whatever LRU it goes on to -
just as before this patch).

If you were to tell me that some subsystem uses PG_lru for some
other purpose, then I would have to get more worried; but we can
be fairly sure that's not so, since mm/compaction.c for one relies
on konwing it's free to  play with PG_lru folios.

Whether a folio is ever allocated with __GFP_MEMALLOC, I'm not
certain (haven't looked), but there is no need to exclude that:
it simply would not retain that page_is_pfmemalloc() info across
folio_add_lru().

Does stable_page_flags() present page_is_pfmemalloc() as a KPF
flag?  No, it does not, so no problem there either.

This certainly deserves a comment somewhere, but not a problem.

Thanks!
Hugh

p.s. Only in replying do I come to realize that I don't actually
need that bit myself now (we could just put one magic value there).
It comes from all along when I believed it important to be able to
distinguish expected from unexpected entries, then suddenly realized
that actually they want identical treatment, so no need to distinguish.
The lru_add entry pointer is still kept in lru_next, but only to help
in debug. But I would like to go on this way, using the bit, for now:
partly because I'm wary of well-intentioned last-minute changes,
partly because I'm not certain a reason to distinguish won't emerge.
