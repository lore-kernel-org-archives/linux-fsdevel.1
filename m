Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A6F53C3AB
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 16:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790180491; cv=pass; b=Vnc/ZkUCRZZYh//ocavp7h6bNSC1gbD172dn1OKPZrZ75AJ73V6tkFeycMg1gqLwT5AfetVakJbdXrK+V5XQN54d9OGR+uUtYSsWK9HgH8w/U3++8TWMYyFuDqV0wAZgxGis8NS1ik2btqYcUxL/kTJkW9jAI9lhGcQpOfMtZyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790180491; c=relaxed/simple;
	bh=+gZQqC9B+BUDyYE+tMiw8bRYJDZM+j4YKIzRl4ESdRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WTJhqavObeOUZMcUG9dFuf7/HkADtkZ4zG5zf4wSF3OYJYXL3VXDrizBXcBcw9gg/hIl6KthJfOuIdb1QHJ8P/kx/myyouTrCG9m2ucellyibyRcoHovPwT3VsmFljCZkcIs27OQPp5U3JeL/KbE5/w6JewsTESrrOaa0o7bxMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+q5sfQf; arc=pass smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+q5sfQf"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e6598dd44so5855505e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 09:21:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790180487; cv=none;
        d=google.com; s=arc-20260327;
        b=hYV75VE03WMpo05VJW6iWBXC8DF4D3aUDabWLM7ltfpUe9OqWdOeiB829dD7r38Hon
         mZzCCOV+cOa1KnyZNezwI52TvubuSUZ6baorrfDphjDil5mUK+E7ql/3fpgb+YjglRBh
         IiQXcMWwy2EIQvD/N0HO3wNjvCIOhshQDi7fmP7cne3wH5IjP85YG+eKDVEI19nsLbuP
         40v8u066LNUimQePZyeqWc5oJxKnPLPA4RbyzJ3YWKbYpWVzhFvLA15xZGNMnKCT833Q
         dmQ0rcAao1WPSrsp3IlltD7pyZdbByLdsZ6z/CMorcCQAixh+4e0ybNNaq9twe+NlJad
         mq+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+gZQqC9B+BUDyYE+tMiw8bRYJDZM+j4YKIzRl4ESdRg=;
        fh=wJeC4V1E148tswx7TclO8dbzNDxUUnul6VoYf0b77tk=;
        b=ZrJ5MMMRAtYm7Gewz8n6EEFp/SrgnmNPu5qJHgpsxpoDt8942Eqw2pygervbLLKxsL
         JeUgNgvXwImNMZEPm9S0oaieYsqvlXVEPygNa5Bi/o9PaFB8o8QUEIlspNyqIQxODnZ7
         ox7sKUh1OmkMtWHgGmKfle42O2OxClHQlAgqPII7GGfWuJmoQGYWdEEwwKO6k6ifonYL
         hZxx21sbYHWJftCDq0hOTq3tsx6IMv1wqxgjS6IJLJ33wDSb7pLZLmZxYHo1u0QqLwlu
         YqkHXcHn+K7jL6/a2G7MuP+t2nYjm3oN9hDwHqj9G2K2JSiTLdjn4dJmw+zv4tJ5PKG8
         oIFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790180486; x=1790785286; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+gZQqC9B+BUDyYE+tMiw8bRYJDZM+j4YKIzRl4ESdRg=;
        b=k+q5sfQf8V5En/Uab0NVCFdRms2+DRyVGp3AHmOysAD5rXZzzZUQ/Ge6XHQhBeyrIF
         0YIH0u9qbl+TasLWyeq52Tp8wQiIV/ks3h/cJO3SIHM8/MWSI4M8f0jic6ng/prsCD9Q
         mvqR/6MFSwmbYhWA54LRNZoqT4RTJGvZ7AIp5JeA/TgyL2sJO5MWbKu3PPwd9xCb/PCZ
         58opr55JLg3c3CZ7g5+xn2wvruKUQlM5a+Sq25gcWW8Robw2UIAFWWRCmQmBAF0MyuVO
         gy2Q2ZKJGlmBAZwVN6yuXVxT5O3GJAkoWxt0kNECXhuVnj+yAe9kgW38Ji8IlwPLSL7n
         nBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790180486; x=1790785286;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+gZQqC9B+BUDyYE+tMiw8bRYJDZM+j4YKIzRl4ESdRg=;
        b=JhRBA3f6Fy5xCwnWWr466gD4UHsR7odyi254G8BM7zzRMLe0/dUevraTeIV/2N1zmX
         +Y1rvIOTowAh14Zc4r1oJY3QsG/pPUYFk5CTyMSvq42/WE+4sRFu2K1JzzpvJJ2yC5w/
         VHtLPu/7IO85Q4SnWRkKhcdh8LZCp2QX6P4Y5Bs4vx97CI4XfnHCx4YIv00Yd2X6bypO
         dcalC8PiZPe7L9nooml/4YDcL/bipHevn36QMuPjGjbPz5uXJoBYuT+2H4IZLPEJ9GEV
         ZwjJcMe0mEBvzdmS/YlaYrTNdX28UnkAt6wLyF+RXES5pvnOSdtc05Jb8sEtPGSDv0S1
         5trA==
X-Forwarded-Encrypted: i=1; AKwUvByWllGaHXBjrl8opcm30utNw44E0dLBuRJ5l26Dl24Z+Sjro0fpWJYEWShakl9BhtnttGH5Lz5O089E2lwm@vger.kernel.org
X-Gm-Message-State: AFuF++lcwnvnE71jSmAPEjnPcdDD1ok8sZJb1TLLmZu5mU+1wcFe3kTJ
	hG6gV+Mp4h3O7GjSzQtrdwQ0fm12A4rY1vkYo0HLjOYsFcCr/VXbDmtEk1IZUcRvdyn+BD0RkZ1
	Vjfx3fTX1dDbFIJFrpJ0sqK5dEDuOKdQ=
X-Gm-Gg: AYBFou2qVTZgYZv/vMKDO3aB9j/Dsxd7LqzT8i2gJSa5n0iuehyDJ2x4Vsht5i+uF6N
	D+K0FN/plnibqnQlIplQDEwKQYaXAS9Tfj/agJJT6iuvTvP7x6RGXWILbwaR/X75AX3yA2CTO/b
	9A53kl2Qh0Tb+CiHDrup4p9tuZlxCxQvF+GqMJ3rHYs2jnDIZL7ReESigJUcbs4A88bbmm/0SaD
	xXipw3xJnicSv4abc1GD8G+t8OuzwF+bnzhjzE/ISyN4KjrV8GwY1oD6KV5Tggj8uR0HZLHYLU7
	hxjUcVCECl9uDVcUpdeYI1JIe2Ucrzzsmk7FaS9J9t6WJuyvgqssFzZvT2yquh8ftwgjKI03+eB
	j0G2ptMtoizP2
X-Received: by 2002:a05:600c:1385:b0:49f:d6b2:4dfa with SMTP id
 5b1f17b1804b1-49fdee0b74fmr42450225e9.4.1790180486307; Wed, 23 Sep 2026
 09:21:26 -0700 (PDT)
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
 <4c7c6ea0-84a7-45f6-989c-d1502b90694c@kernel.org> <CAMgjq7DeYsJxG_VCf2KnViV5nd10m-PPYzXRD1fi8QcGWwD0qw@mail.gmail.com>
 <d9a77381-cf88-4726-9223-c16a5c6608c2@kernel.org> <CAMgjq7CLGyLHi7Lb8WF_m9bWUHpMRp_uDrqYNRQsH2GkuVQ=Ng@mail.gmail.com>
In-Reply-To: <CAMgjq7CLGyLHi7Lb8WF_m9bWUHpMRp_uDrqYNRQsH2GkuVQ=Ng@mail.gmail.com>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Thu, 24 Sep 2026 00:21:09 +0800
X-Gm-Features: AclHuK_BdL6NqIQOym4w0mnD34hD2lehVVu384RLkcQrbTLuEv6NeiVb7h4sMvc
Message-ID: <CAN_Opa_PrLP7mpF7gRjQUKfoCJGP7KvZMB-23bPUG269QASHpg@mail.gmail.com>
Subject: Re: [PATCH] mm: madvise: drop MADV_PAGEOUT folios at swap writeback completion
To: Kairui Song <ryncsn@gmail.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Barry Song <baohua@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>, 
	akpm@linux-foundation.org, willy@infradead.org, jack@suse.cz, 
	liam@infradead.org, ljs@kernel.org, vbabka@kernel.org, jannh@google.com, 
	chrisl@kernel.org, shikemeng@huaweicloud.com, nphamcs@gmail.com, 
	baoquan.he@linux.dev, youngjun.park@lge.com, qi.zheng@linux.dev, 
	shakeel.butt@linux.dev, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, hannes@cmpxchg.org, mhocko@kernel.org, yosry@kernel.org, 
	chengming.zhou@linux.dev, tz2294@columbia.edu, hch@lst.de, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 6:15=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Wed, Sep 23, 2026 at 11:47=E2=80=AFAM David Hildenbrand (Arm)
> <david@kernel.org> wrote:
> >
> > On 9/23/26 11:35, Kairui Song wrote:
> > > On Wed, Sep 23, 2026 at 10:46=E2=80=AFAM David Hildenbrand (Arm)
> > > <david@kernel.org> wrote:
> > >>
> > >> On 9/22/26 22:55, Barry Song wrote:
> > >>> On Tue, Sep 22, 2026 at 7:26=E2=80=AFPM David Hildenbrand (Arm)
> > >>> <david@kernel.org> wrote:
> > >>>
> > >>> I guess that's because the LRU is not always accurate. There are ca=
ses
> > >>> where our prediction of future access patterns may be wrong, result=
ing
> > >>> in refaults?
> > >
> > > Hi All,
> > >
> > >>
> > >> Right. But these would happen in both the SYNC and the ASYNC case. W=
hich seems
> > >> to indicate that making the SYNC case behave like the ASYNC case (ke=
ep in
> > >> swapcache before evicting) could actually improve performance?
> > >>
> > >> Or is the SYNC case in general so fast that it is not a problem and =
the
> > >> swapcache is just not a good use?
> > >
> > > I think the problem is not LRU being inaccurate, but ASYNC case could
> > > overshoot the anon reclaim very easily. File folios can be simply
> > > dropped, and increase nr_reclaimed, but anon writeback (swap) can't b=
e
> > > done durig the reclaim iteration so nr_reclaimed never increase durin=
g
> > > the scan iteration. So the scan tries hard to scan and reclaim more
> > > anon folios, more than it really needed.
> > >
> > > I think the real fix is some kind of different watermark, throttling,
> > > or a different counter to limit the scan of async swap. I mentioned
> > > this at LSFMM this year but I guess I presented too much at the same
> > > time so few people remembered it :D.
> >
> > :D
> >
> > >
> > >>
> > >>>
> > >>> Even on Android, which uses zram with very fast synchronous swap-ou=
t,
> > >>> I can still hit the swapcache from time to time. So perhaps with a
> > >>> slower device, such as an HDD, keeping the swapcache around for lon=
ger
> > >>> could allow applications to hit it more often?
> > >>
> > >> Why is that specific for HDD? It's the exact same app behavior indep=
endent of
> > >> the underlying swap technology.
> > >
> > > If you have a shared folio, you must use swap cache, and even for
> > > single used folios swap cache is the way to do synchronization,
> > > regardless of the device.
> > >
> > >>>
> > >>> I don't know. Maybe Alexandre can share more details about this
> > >>> benchmark. I'm also a little surprised by the 15% regression in
> > >>> Sysbench OLTP. My initial feeling was the same as yours: we should
> > >>> release the memory immediately after writeback completes, for both
> > >>> synchronous and asynchronous I/O.
> > >>
> > >> Right. And see if we can identify why we are swapping out the wrong =
things :)
> > >
> > > I think we are not? It's about over-reclaim. In the worst case we
> > > might put every anon folio under writeback, while no folio is
> > > reclaimed, if the device is super slow.
> > Ah, that hints at the real problem then? How confident are we that that=
's what's
> > happening?
>
> Given the fact that ZRAM/ZSWAP doesn't suffer from this, I think this
> is the cause: the main difference is that ZRAM/ZSWAP frees the folios
> after pageout() so nr_reclaimed is increased (reclaim loop just keeps
> comparing nr_reclaimed to nr_to_reclaim), other swap devices keep the
> folios under writeback, and continue reclaiming unless they hit enough
> clean folios to drop.
>
> I can't say I'm 100% sure, and it's hard to verify but I think we need
> to try fixing this instead. It's not hard to construct a case where
> all anon folios are put under writeback due to very slight pressure,
> e.g. a dm-delay (e.g. 500ms?), 1G anon in one memcg, very slight
> memorey pressure could easily put nearly all anon folios under
> writeback.

Alex, One question about the `nr_reclaimed` accounting.

`PAGE_DROPBEHIND` increments `nr_reclaimed` when the write is
submitted, while the folio may still be under writeback and is only
actually removed from the swap cache when writeback completes.

Kairui pointed out that async swap can over-reclaim because
`nr_reclaimed` does not increase while anon folios remain under
writeback. Does the early accounting for `PAGE_DROPBEHIND` address
that over-reclaim mechanism for this `MADV_PAGEOUT` path?

It might also be useful to check this with a delayed swap device, such
as the `dm-delay` case Kairui mentioned.

Thanks,
Kunwu
