Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCF043CE73
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 09:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790156163; cv=pass; b=GHwG+0xlpyVjY7ldO2q6XoAEqReVMwXSOufuwqwk8MZP0+NoQ2htLXBFU+IUspBITuF+VwXW8IlT5Q+gN88v42qcB5/td+vHZ4eRHaH3iA64RW8vxnq0ZG2+90Q+ONZjYw6BmScXFu6XpNkRZhqoHyDa3xbXfJZ4bo77y7u1Cd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790156163; c=relaxed/simple;
	bh=Cs8T5ZcWIq5U6G9Vf1GtZypFn9LtOBQKVlGIKm7mFCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ouK+3P68DNEUUIV/vH65lMDU1Uf86JRu+0CvZx5tV0vXaMxIxPbJc3AHOT1UGZvEm28NTd/C4ugNPeEf6/i5YJ1DdqHBWKxEcwp/7CSSCO1W9ZsFKytjoQD7WbSptl4XGwA2oitU51kjzjQ0QP1kwH6m71u5KoPDQ1Ql0SvxhsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYyZp+z4; arc=pass smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYyZp+z4"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c254f56039dso97759166b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 02:36:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790156159; cv=none;
        d=google.com; s=arc-20260327;
        b=mU9fyt6mP8CiaaJFzcPAWE0TFm2KjNC8SxNpRKyKIBOEp7SdGFjKn6VvpMCtbc1vZF
         Iq6s/S7swSntsel2uBqW5zR4gc3M3YeOCxkglFLcvr4iQctTYrvjC+pAH/fcp9rDF25N
         gXd/mig0TdAydep7TTjizLhiZO6qWORfzXcSfce+iuQY69ws37MjxIcPIUe4cIoGxUKd
         P1Pv4N7s6bcxNNc/xZfUStCuMZUuggut3PkWZf/sD4f2Zs/lnNtQlRzD8GQuKzr3r+UO
         zybr6xnjgTOs3Pl++K2x1LJ6SF+n852UFY4RbgrLUK7AtcgmLYI79FLyM63orndxKoqE
         qRfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cs8T5ZcWIq5U6G9Vf1GtZypFn9LtOBQKVlGIKm7mFCo=;
        fh=N/BEPc3yPCJzIBCGwM6sjuZd8Obeme//izri2OUU/Pc=;
        b=QLiCvBs5tO+DZwCZy2ntnmkAkQfTfXsTMRTNvl0011RFDqJ3oPuI+f4UmDeIZLgnuC
         OSmSztusWzLOhLruCHiDSvd+QAlQFK1BR4UbySY0k6REeIEsNcPhj2TwYYT0AkNf17nj
         NdF21QBY79Tr97R5oMfMiXYLDdhW7KbZv5MXB+cHPsO7e9FZkZ4/wluYf5jkQ3ETNhyo
         sfBNIHzr7hXNSNY7+J7oryO2pmfk28XM1Sv6w9BeXc1brBcqaBat+Rtq+mr88L0rWXVo
         Nk1z17nbhVQmWscosaiTdgb0MTqXk/xFoncgoAayXc9Q82yhjC5xkz62x/srQ02QvGbN
         uLSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790156159; x=1790760959; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Cs8T5ZcWIq5U6G9Vf1GtZypFn9LtOBQKVlGIKm7mFCo=;
        b=mYyZp+z4/7XsabuwE3I7fSaBtp43dKdqyFxHCirwnvJiuGU8N7LDol7QNViUQUhB8N
         IbMGm8VLHjrYDog5fbG0oLA3mmyGNXNFE62o81cVzgm3bCYVgX3kyUzP3Togc+UxnQyQ
         c1ODf/LZ+SCyK9FmMOHwz16dTo0pki5ROxp+tBnzUxs6CI2PCxFe7RgllgNqlImjBUFC
         9xX7571GVzoo5xqxYWESKYmUrHgiz46KftxNk20y2KEroAAmdFTNKsI8mXTJtVjePLXe
         xOoKySSEslSWJ7pfGvhdlIK+e+zlD1ahUD7HGTo1jk/S34OtoKCAFX2ErAbKqQHjrU9g
         WV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790156159; x=1790760959;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cs8T5ZcWIq5U6G9Vf1GtZypFn9LtOBQKVlGIKm7mFCo=;
        b=Atz/CAtG0WMW/uGxFuoVntYrQloQzxym1tB+8g9jCvAZmzchhnKOThJ+d5mrcQ3AWN
         A3ZwISZiyjEgElKncTEWYqxX0h+WOjSqGYYUBNQReJ6P56JBRB2r+O8x5xaACIb27KM2
         dp8HXGWsK8dWvIeA8MMJ8fgUyYVFWkdz9jBgV4ajJlQQpK299JK0STB2KvalYGFO6511
         1bzWCJrREhxM0hEShL7RUwMH/cDN+vmMZB+NFVyvfAL5npwiGgg21UfcfRUSebSISYqP
         FuYqSVG48Uni/PWo4XHdzcTBz1bfGpAQ4vSVCdoW+cNf8FUsV7x36W1Y5NFhPveXHlh1
         L7GQ==
X-Forwarded-Encrypted: i=1; AKwUvBwrgwStE6LP49IrYID3IUvCqY4nYN3LS3YvVBGaKGJlUsBL87ePpHs1hpLrv+72CYP9mLH2Lqx6CxtCN9iZ@vger.kernel.org
X-Gm-Message-State: AFuF++lqeIj6jsAZufd7O1+XwWSf2IMh0dx5v0FL4x6yvNa1nPNgtx/2
	K7/elCd/+PGMw/ud2NGeL46z4iltLekQ/00FL/WjSsICtdQUBrNghIAgiThAHqWBgawTh4bwsd0
	4OuJ3C3zCqbarXtfnUZTcNrmA68exLV79HEfm
X-Gm-Gg: AYBFou3lzDYP9BuvpCTxfxe2hM0bFP/A0RKkOwCEH31y38R0qD75JauZhj6aFk8yZeN
	GATCTk6Y8d+U2ELMd5yqmVcGTI+aY9l5Tu5iqcSSQoHOQ7GBB9vnA9+8l07DtY4gWLhNxw40Gu1
	CRWVltEvCnlOECTsxQoJq8zkSZVKSrq2JwVThKCVuf72wXQlE0ryMedQ3F/4wgnoPN/oXF3GfLm
	GAqA9H7v+wNW2QVSw+VNg4xK3hf5/zekCZPPlFRfgHhWKQkIzxVh8HwMprmSD9Dms1YLNtOWEgy
	DwvSczcu948nJXMtTeeMrM/I5CY9yoxEj5wvw2ax5h0KyErigJTSe1zaJymDPAA6Es8TXuY0cDx
	Rdod0dW78oe43qehpxes8vNM=
X-Received: by 2002:a17:907:9409:b0:c2a:9e6a:3b4e with SMTP id
 a640c23a62f3a-c2aadc5bfb2mr169512866b.0.1790156159160; Wed, 23 Sep 2026
 02:35:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921152449.629486-1-alex@ghiti.fr> <70cae945-3a4a-40db-96ac-5ce66a3fa186@kernel.org>
 <CAGsJ_4y8-wD0yMV8GCtCz5MfNrOKqUaTd+UgH=8MoP_nuvPnGg@mail.gmail.com>
 <108487b7-0529-4282-b5f4-355804b4c0cf@kernel.org> <CAGsJ_4zGmGh70QtRBpnhueev3qt_bgB4ZiE9fkW-hgNjAVhv+w@mail.gmail.com>
 <2e695c8a-4212-42b5-bb51-fbe1aa162e1d@kernel.org> <CAGsJ_4z2nakqBCKd_uAn4bfub99r3NJt2spOUx-K0M7bHW3_-w@mail.gmail.com>
 <4c7c6ea0-84a7-45f6-989c-d1502b90694c@kernel.org>
In-Reply-To: <4c7c6ea0-84a7-45f6-989c-d1502b90694c@kernel.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 23 Sep 2026 11:35:22 +0200
X-Gm-Features: AclHuK-XFajsGqUIFgSM4jp7unmbhFgPOMy4tt_SeGm4xDkZtIbvSE-oUeT-3wI
Message-ID: <CAMgjq7DeYsJxG_VCf2KnViV5nd10m-PPYzXRD1fi8QcGWwD0qw@mail.gmail.com>
Subject: Re: [PATCH] mm: madvise: drop MADV_PAGEOUT folios at swap writeback completion
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Barry Song <baohua@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>, akpm@linux-foundation.org, 
	willy@infradead.org, jack@suse.cz, liam@infradead.org, ljs@kernel.org, 
	vbabka@kernel.org, jannh@google.com, chrisl@kernel.org, 
	shikemeng@huaweicloud.com, nphamcs@gmail.com, baoquan.he@linux.dev, 
	youngjun.park@lge.com, qi.zheng@linux.dev, shakeel.butt@linux.dev, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	hannes@cmpxchg.org, mhocko@kernel.org, yosry@kernel.org, 
	chengming.zhou@linux.dev, kunwu.chan@gmail.com, tz2294@columbia.edu, 
	hch@lst.de, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 10:46=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 9/22/26 22:55, Barry Song wrote:
> > On Tue, Sep 22, 2026 at 7:26=E2=80=AFPM David Hildenbrand (Arm)
> > <david@kernel.org> wrote:
> >>
> >> On 9/22/26 12:37, Barry Song wrote:
> >>> On Tue, Sep 22, 2026 at 6:20=E2=80=AFPM David Hildenbrand (Arm)
> >>> <david@kernel.org> wrote:
> >>>
> >>> I suggested this to Alexandre, and he found that it could regress som=
e
> >>> workloads [1]. That is why Alexandre is only making the folios
> >>> immediately reclaimable for `MADV_PAGEOUT`.
> >>
> >> I really hate to add special sauce for MADV_PAGEOUT. Also, I don't qui=
te like
> >> that we do something fundamentally different for sync vs. async.
> >>
> >> I assume, though, that async writeback that is very fast might just fi=
nd the
> >> !folio_test_writeback() scenario just like the sync case. ... or if we
> >> reschedule after pageout()?
> >>
> >> I am wondering: if we can show that letting async swapped out pages st=
ay in
> >> memory a bit longer improves performance, aren't we swapping out the w=
rong pages
> >> in the first place, and not swapping them out would help the sync case=
 as well?
> >
> > I guess that's because the LRU is not always accurate. There are cases
> > where our prediction of future access patterns may be wrong, resulting
> > in refaults?

Hi All,

>
> Right. But these would happen in both the SYNC and the ASYNC case. Which =
seems
> to indicate that making the SYNC case behave like the ASYNC case (keep in
> swapcache before evicting) could actually improve performance?
>
> Or is the SYNC case in general so fast that it is not a problem and the
> swapcache is just not a good use?

I think the problem is not LRU being inaccurate, but ASYNC case could
overshoot the anon reclaim very easily. File folios can be simply
dropped, and increase nr_reclaimed, but anon writeback (swap) can't be
done durig the reclaim iteration so nr_reclaimed never increase during
the scan iteration. So the scan tries hard to scan and reclaim more
anon folios, more than it really needed.

I think the real fix is some kind of different watermark, throttling,
or a different counter to limit the scan of async swap. I mentioned
this at LSFMM this year but I guess I presented too much at the same
time so few people remembered it :D.

>
> >
> > Even on Android, which uses zram with very fast synchronous swap-out,
> > I can still hit the swapcache from time to time. So perhaps with a
> > slower device, such as an HDD, keeping the swapcache around for longer
> > could allow applications to hit it more often?
>
> Why is that specific for HDD? It's the exact same app behavior independen=
t of
> the underlying swap technology.

If you have a shared folio, you must use swap cache, and even for
single used folios swap cache is the way to do synchronization,
regardless of the device.

> >>> See Alexandre's description:
> >>>
> >>> "Future work
> >>> -----------
> >>> Barry suggested extending this to MADV_PAGEOUT and general reclaim. I
> >>> prototyped dropbehind for all reclaimed swap folios and it regressed
> >>> sysbench OLTP throughput by ~15% on NVMe swap: dropping the swap cach=
e
> >>> immediately turns cheap in-cache refaults into disk reads and collaps=
es
> >>> swap readahead clustering.
> >>
> >> Thanks, does this represent a workload pattern we care about?
> >
> > I don't know. Maybe Alexandre can share more details about this
> > benchmark. I'm also a little surprised by the 15% regression in
> > Sysbench OLTP. My initial feeling was the same as yours: we should
> > release the memory immediately after writeback completes, for both
> > synchronous and asynchronous I/O.
>
> Right. And see if we can identify why we are swapping out the wrong thing=
s :)

I think we are not? It's about over-reclaim. In the worst case we
might put every anon folio under writeback, while no folio is
reclaimed, if the device is super slow. And if we drop it on writeback
completion, we could drop the entire anonymous portion of an
application. Of course, the performance will be horrible.

We don't have such problem for ZRAM because ZRAM just releases the
folio during the reclaim iteration so the nr_reclaim counter gets
updated properly, and the iteration ends properly.

For async swap device, writeback is async, so the reclaim loop just go
on without updating nr_reclaimed (they are not reclaimed, still under
writeback). The reclaim iteration only ends after it reclaimed enough
clean file folios or previously written-back clean swap cache. MM
reclaim is expecting to see clean swap cache after writeback is done
and rotate them back to LRU tail so next reclaim can catch them.

BTW we could hit OOM even if swap is enabled due to a similar problem.
Anon reclaim can't really free anon folios, so it always relies on
having enough clean cache (page cache or swap cache) to drop to avoid
OOM. It just keeps pushing anon pages into writeback when under
pressure (expecting that this helps the next reclaim cycle.

This is ugly, I also wanted to figure out a proper fix but got busy
with other stuff :D
