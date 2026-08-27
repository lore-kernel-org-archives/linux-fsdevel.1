Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACCA3FBB4D
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2026 08:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787820574; cv=none; b=lvKopYBoBbH24eMTDwPgiMiUXki05cZzyxWIVUeVOTsDS/VMIh0hQMsbm6VAzYsha2fkGk20XvEq/NeeURBEU6dfAWX1I19nLrHhs0YqOgSqj3qmdnrECjB0qFG1CuDclgZhA4G7/t2zTI9FsvoeA6OUeK2b9GwyppQaOJupcpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787820574; c=relaxed/simple;
	bh=xOo52WEwM9OcvK3XM7gppK9P45+gQdtp6SHuVaRQ8xQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uJ/LpAXBYR6M8dusEDVax9uv5j6e6RuVxGhRF8uw7HcjNbmc281auoEs858cK6wptqXIbxRIuLFadI1AN28tOG4JnwvH89hURUTs6CR3NVmpT/LGOoUWhDJ/EVX9mpOsPDG+3KzEuqnIQbFt6BhIUqvw0imYJNCxOaoWCM7G7Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TLK/unnv; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TLK/unnv"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-85845398586so23701427b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2026 01:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787820572; x=1788425372; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r1qjuH7DPdLHxaMJrgal+nSqcPVjkvrEhw9rBC64WAk=;
        b=TLK/unnvDueiRDw0p19YY9LJInr+bAz6RJn/uhc2MjNoONapzkLRyqgMoEOEX68sKj
         V1wShyCVWvpQl1vJWbA69ZAa8rzZEeFoR/GamjLhCEsDw4Wrez1Zr/vDfLZp5OUp6wnN
         oWgtEMEV9sBRzENHNAHW/VWom9M/MVqnQ2C6Ypo3HdgRfpGZBKbZSeO2a/fKMV9XykYk
         xggeaYbtnJos9DzAWoe1zE9UTwd6F+xm5xF63NFUnoxdXsPqL5RQqAyc3ewIxhZhiBh9
         UeZ/Tbl/Xr+XjEZCIY3HVRm+kVkkVGaI09NU3p4tK6MT/dJOy4ja997IpVrtw4aERwRO
         UWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787820572; x=1788425372;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r1qjuH7DPdLHxaMJrgal+nSqcPVjkvrEhw9rBC64WAk=;
        b=Mx0gLo4dzgkO9Fontji0/QcB6076lHbBvmpmROOl9PnkPDjum3mp2b7wi02tINGPCP
         a5w62j0gXu8rV3aM2W3lMtPHOz7Th4IJ+KfNxi8l8goJ2hON/M3w+x8k1B/WoTXrGxu6
         UiygbJXwn4zpYQoIzOHW8jJ8ndIrzKUjMHlA0QYILM31H10InK1J4hgv70RKsTpxH7uX
         eFn7/JuwOmPkkMpWmnlRye+tFyoZY3KsCQYQqApa0e1f/jMWWjEuAReMSNOXqNQckgjq
         AEJ4OAABB6Fq91FTRqkHeZ0GScIK7aMtRxdFDC14IDqlvLPs620hSLZA6GoJ9LglvXNq
         QuNw==
X-Forwarded-Encrypted: i=1; AHgh+RoPng/ucwx713ITJNJ8QLUkg0FAG3rCAfS0a1D7l9QjCZpTk2waSqYZn7atvc93ipyAHBCiWp8V7BSoBObW@vger.kernel.org
X-Gm-Message-State: AFuF++kjk2FSDLdm2gkIQsflAfhJ4zQ5DULzCQrzp3pdiMZDUYaVszJV
	QSzLfZJVfuvuRkOsY6vZAq87lpzyi8kVZQ6PWZ7iPnxuhwBGtRbG1PhRCgzfJDFnuA==
X-Gm-Gg: AR+sD12SsndDx9WXL8CH/8MhLlD59LUxhdhyr/GjAg/0F1qEC7iwPaZsR5ODmR2pQq6
	aL2WgGvZG/5ngcequuXTAB501WC95Xg36h2C1B3WJqbsJqsm/PHQqhK2NjNcsaJRbuPvisJEJQt
	7pXnuns5u+LQRRBi+5cxOnqXAe5dS+kCdbLzi7O5Uo4AgqMUH2hVUWkt6vgpE9SMujdeWcX7qgL
	V92qIRwIRw6Yx1d+dPgw/DXTL755qpaKwyhB9gTAhFrWhwU93rab50QBUNyrsGVDLNzoRtFx+4H
	WADR5IYyVeDiX+dNK2e03dez7LWvj8YvXgD1yIIwmrKoIGQ4HB1TWCUtyj4Er9g0S2jZn7g0iJh
	k2qWnWwjwEL3XsG+jIWrL+D3Ihuf3Isu+vWC3ZRtE7qFn2c+FVClsrOaLvtx/g7vI3sqDTKI5kT
	tWP6o3dLC1aNPmbnR6U/jhOqELX9XA1WU/p6BaDhrIePhKcJzfOfFu6EFSxJu2uMwGKRdmlXQTe
	T4TJ/sm2XywuPvUUBiKuduxBP8I0m7Tbdygpgg4WGqn1gY0
X-Received: by 2002:a05:690c:ec9:b0:85b:35f6:bc5d with SMTP id 00721157ae682-85b35f6bdb2mr18592327b3.13.1787820571154;
        Thu, 27 Aug 2026 01:49:31 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85b5cccdd31sm6315477b3.18.2026.08.27.01.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 01:49:29 -0700 (PDT)
Date: Thu, 27 Aug 2026 01:49:12 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    Ackerley Tng <ackerleytng@google.com>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Barry Song <baohua@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
    Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>, 
    Christoph Lameter <cl@gentwo.org>, David Hildenbrand <david@kernel.org>, 
    JP Kobryn <jp.kobryn@linux.dev>, Jan Kara <jack@suse.cz>, 
    Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>, 
    Kairui Song <ryncsn@gmail.com>, Kiryl Shutsemau <kas@kernel.org>, 
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
Subject: Re: [PATCH 20/25] s390/fbatch: no lru_add_drain_all() in
 s390_wiggle_split_folio()
In-Reply-To: <20260826155722.0198d3ce@p-imbrenda>
Message-ID: <2319f670-fe0b-f032-c0dc-486cbec0f3e1@google.com>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com> <7bf68e7b-f88c-6ca9-39ab-e9fedab0c8be@google.com> <20260826155722.0198d3ce@p-imbrenda>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 26 Aug 2026, Claudio Imbrenda wrote:
> On Mon, 24 Aug 2026 07:39:12 -0700 (PDT)
> Hugh Dickins <hughd@google.com> wrote:
> 
> > s390_wiggle_split_folio() has no good reason to lru_add_drain_all(),
> > now that the per-cpu fbatch references are gone.
> > 
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > ---
> >  arch/s390/kernel/uv.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
> > index dc14ebc0105b..120a467026a5 100644
> > --- a/arch/s390/kernel/uv.c
> > +++ b/arch/s390/kernel/uv.c
> > @@ -364,7 +364,6 @@ int s390_wiggle_split_folio(struct mm_struct *mm, struct folio *folio)
> >  
> >  	lockdep_assert_not_held(&mm->mmap_lock);
> >  	folio_wait_writeback(folio);
> > -	lru_add_drain_all();
> >  
> >  	if (!folio_test_large(folio))
> >  		return 0;
> 
> This is black magic for me, I am not sure I fully understand all the
> details, but what's the new purpose of lru_add_drain_all() ?
> 
> will we have a guarantee that no stray references to mapped folios will
> ever remain?
> 
> Any unexpected reference (i.e. not due to mappings, see
> expected_folio_refs()) will cause a protected guest to hang.

I most certanly don't know s390 or that code well enough to guarantee
you that no stray references to mapped folios can remain there. What I
can guarantee is that no references, of the kind which lru_add_drain_all()
used to be needed to remove, can exist there: so there will no longer
be any point in s390 (or others) calling it for that reason, to help
split_folio() to succeed.

You wonder then, what lru_add_drain_all()'s new purpose is, why it
still exists at all? I did hope to remove it completely, but found
two usages that I could not argue against: one is in user-forced page
reclaim (two memcg interfaces and a sysfs interface), where it's
still desirable to push folios on to the immediately reclaimable LRUs,
rather than leave any on the per-cpu fbatches preceding those LRUs;
the other is in memory hotremove, where it will be necessary to erase
stray addresses, through which a subsequent folio_try_get() might have
accessed a struct folio which (I imagine) might have been freed.

Yes, your split_folio() may still occasionally fail, because of
transient references and folio_try_get()s on that folio; but that's
so before and after the changes. And there is (in my mind anyway) an
open question of whether "folio_try_get() blips" will be visible a
little more than before.

Hmm, looking again at s390_wiggle_split_folio(), it seems rather
odd that it was doing an lru_add_drain_all() at all: because any
large (hence splittable) folios have themselves been immediately
flushed from the per-cpu fbatches, not left queued up there. Maybe
there was an earlier time when mm did not enforce that; and Barry
is currently looking to relax that, so the limitation intended for
pmd-sized folios is no longer forced on the smallest large folios.

If Barry's relaxation goes in before my drainage changes, then
there is value in that s390 lru_add_drain_all() in the interim.

Hugh
