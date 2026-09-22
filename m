Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3314351AFCC
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 10:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790073473; cv=none; b=gCjenu8rUOVbzLuUX7krVL+zzdBiH3oFZyzbiyjqUELF1e9yDHz/G4OlX8q2tRPep3Ml62gCw+MJy92OpSwLo7Ir/nxzkveFGN+KMR6sXsEzUeHqEB13fTQGWjmqeSizQFC5DwH84EemEijOENTD5KMiiTVaoDW7XNX+NepBj9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790073473; c=relaxed/simple;
	bh=8JSFfIOR2fYyMqbn60xzTN3TiCBndTmuqv+8JkopuP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pku1+PyjcZ9J0tPu8dnzkk6RAmqATXr8YDucllE/7vqlH8BxTFSv7/hy3O+F4cocAfUdJltS8PHwDa5dawtHOb0+bJL9pIlfr7hqGr7rwU7A3qI/NixUXfRmSl0EMj5VD6PI/3zc9pZgYoj0J9PU7KfNOecM34n0Ymo3pVNiEvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYfSKpdK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYfSKpdK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10451F008AB
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 10:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790073471;
	bh=8JSFfIOR2fYyMqbn60xzTN3TiCBndTmuqv+8JkopuP0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=dYfSKpdKcScI4OnACyb+qIUkbtczzFWpPHkNZqKNm4t+0mL49+SiUaYeDab4lgZI8
	 Sf31i/J4uK2FjCxjTmfpFRjUuc6OHnhi9+R804I9R+2TpJF5nCcS6siALwf/Ef81/b
	 uePkKyMhbajpqj7euOZBpdi0LMBS2vMsbm977Z2gfAOaabzBgglDbFgjlsX/EODJqm
	 1RHmEnk1rEx05F03qcjf28TwGrGTViBBnqaXFmUw3LlWbBPT0jJuIOhkkvGE7Ya6ym
	 vXIb2MT3VVg1v2VPq6pyd/EGeYGRzSxIOj78emajQXL0fcLtuqVXIRb/RXj+cB9eAQ
	 bfYcpcpsOfBfg==
Received: by mail-qk2-f37.google.com with SMTP id af79cd13be357-93910cc46c8so508201885a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 03:37:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByubSuvPSxUVL4TwU3qtUQbR+7/Co4aOXmhxhzpqpCVV5mMkR0d4VAnpPuMwMEkSZB2jUGVd3YxPbVYzG/2@vger.kernel.org
X-Gm-Message-State: AFuF++ktyByp7iAfX7nMx4lkmhw/4Zspoj/2HBplTCLyHIHsIllcSMG9
	1FXZXMLRZqweziMb+TzctneCkjN/EY78EZImJqvRDleIyof6S9XYv7VSYYQB9w3h/P5j28ImaLM
	c6UQjoVBJaHEKDUSYWYXxbnBSglAyzLU=
X-Received: by 2002:a05:620a:2556:b0:93b:d7a0:d9ee with SMTP id
 af79cd13be357-93c19a9683emr286636685a.72.1790073471173; Tue, 22 Sep 2026
 03:37:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921152449.629486-1-alex@ghiti.fr> <70cae945-3a4a-40db-96ac-5ce66a3fa186@kernel.org>
 <CAGsJ_4y8-wD0yMV8GCtCz5MfNrOKqUaTd+UgH=8MoP_nuvPnGg@mail.gmail.com> <108487b7-0529-4282-b5f4-355804b4c0cf@kernel.org>
In-Reply-To: <108487b7-0529-4282-b5f4-355804b4c0cf@kernel.org>
From: Barry Song <baohua@kernel.org>
Date: Tue, 22 Sep 2026 18:37:38 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zGmGh70QtRBpnhueev3qt_bgB4ZiE9fkW-hgNjAVhv+w@mail.gmail.com>
X-Gm-Features: AcwNN1UWmFBBjyVOBpgbroObIEOZiFHFaTZdwoniNhkfZtgQcsm0FIKNvDnSJaM
Message-ID: <CAGsJ_4zGmGh70QtRBpnhueev3qt_bgB4ZiE9fkW-hgNjAVhv+w@mail.gmail.com>
Subject: Re: [PATCH] mm: madvise: drop MADV_PAGEOUT folios at swap writeback completion
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>, akpm@linux-foundation.org, willy@infradead.org, 
	jack@suse.cz, liam@infradead.org, ljs@kernel.org, vbabka@kernel.org, 
	jannh@google.com, chrisl@kernel.org, kasong@tencent.com, 
	shikemeng@huaweicloud.com, nphamcs@gmail.com, baoquan.he@linux.dev, 
	youngjun.park@lge.com, qi.zheng@linux.dev, shakeel.butt@linux.dev, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	hannes@cmpxchg.org, mhocko@kernel.org, yosry@kernel.org, 
	chengming.zhou@linux.dev, kunwu.chan@gmail.com, tz2294@columbia.edu, 
	hch@lst.de, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 6:20=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 9/21/26 23:56, Barry Song wrote:
> > On Mon, Sep 21, 2026 at 11:37=E2=80=AFPM David Hildenbrand (Arm)
> > <david@kernel.org> wrote:
> >>
> >> On 9/21/26 17:24, Alexandre Ghiti wrote:
> >>> On an asynchronous swap device MADV_PAGEOUT only marks the folio
> >>> PG_reclaim and rotates it to the tail of the inactive list once its
> >>> writeback completes, so the memory is not actually freed until a late=
r
> >>> reclaim scan removes the by then clean swap cache folio.
> >> But we have the same behavior when just reclaiming memory ordinarily? =
It's added
> >> to the swapcache and only the next scan actually frees up the memory.
> >>
> >> Wouldn't we memory we reclaim ... just gone, like in the sync case?
> >
> > For synchronous I/O, such as zswap and zram, the memory is released
> > immediately after sync I/O is done.
> >
> > For asynchronous I/O, such as NVMe, the swapcache is currently
> > expected to be rotated back to the tail of the LRU and wait for
> > another scan. Alexandre once mentioned that when he tried handling
> > async I/O the same way as sync I/O=E2=80=94releasing the memory once th=
e I/O
> > completed=E2=80=94he saw some regression. So, delaying the release unti=
l a
> > later scan may allow swapcache hits before the folios are eventually
> > reclaimed.
>
> "may", do we have any evidence that this actually is relevant in practice=
?
>
> We asked to reclaim memory. We wrote the memory out to disk. We unmapped =
it from
> the page tables. We made the workload the could, access the page immediat=
ely
> again suffer already.
>
> We should just evict them as soon as possible to free up memory.

I suggested this to Alexandre, and he found that it could regress some
workloads [1]. That is why Alexandre is only making the folios
immediately reclaimable for `MADV_PAGEOUT`.

See Alexandre's description:

"Future work
-----------
Barry suggested extending this to MADV_PAGEOUT and general reclaim. I
prototyped dropbehind for all reclaimed swap folios and it regressed
sysbench OLTP throughput by ~15% on NVMe swap: dropping the swap cache
immediately turns cheap in-cache refaults into disk reads and collapses
swap readahead clustering. Neither blk-wbt, mq-deadline nor a PG_workingset
gate recovered it. MADV_PAGEOUT alone may still be worth it, since there
userspace has explicitly declared the range cold, but I have not measured
that case in isolation yet."

[1] https://lore.kernel.org/linux-mm/20260921151306.625134-1-alex@ghiti.fr/

Best Regards
Barry
