Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731C4539775
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 11:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075447; cv=none; b=uANwUMZYqfg4Xeo0J3pZpZFDDNLzmfKJR1yOkAz2nh7fvxpRbQe63VgUtzJta7bIGkBJRNcZkw9+yeKRD5AS7/mBgYx/JJWYFa28sawaktNlaOIfEQ2RkazxEaHckOOdsXeE7cTfjaGozWzdKzIvUustbDcUE8Ig06D0agxStIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075447; c=relaxed/simple;
	bh=MkrfUt1epWhNjWVGPMcKDFbIjfl6pN/EZeBjPwxWSkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bZA7ObL5iO1ogsnZP/fgOfm1mIiSMBk/ktcN4/uccIOqR4XwH3Ij24sBKXBj4P6aBcT2JJAEEGuT1uveScrz7UG1JShbQhp0mekcKqx6wOyyK5Az4h870z8D6G6HSK6atCz39bWrVZlO2Z7Y84uOGXO0YiPg1LfEnz8GgdRIWmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxv9WifW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxv9WifW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BEBC1F00904
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 11:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790075446;
	bh=FWjWwozCfG09p014wbFDCqQeW+3NpBoNoOf7ed+0xEM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nxv9WifWNl1QjTfdD70/Qyvxl3pei3lReTemQfJFQwo3IntYJfMGYz6n1SFfPoxNj
	 ECMmqEEo9Ie0iUHpFauYlI+F82XBi/pS1R3xt5xtjNrbgs1rsvSKoUFHGn9AqMgIZm
	 Na0U8g4KsAZfC5KrSeeRwLiqXR9L/BKCvE7PL7b04Ct8AqcW+V5azK5cWdmVppUmR9
	 Q4/zAJgBrQdXrscR5D6bZKMvxkEuZqFGSJqQ/RqbWfovxyF5bMONRm6/1vC+tS3DAt
	 Lp+mIdUzcmfvjjkay5wTk/0lHU272o3J2cGcIpRgzvk+FqKpAR9JZfphllLKPMNqhO
	 l9eKsKSxSJ+tw==
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93910ad2273so476994085a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 04:10:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByhfxgSj5HbXpPYuPPBXB9y5OSwNfxIqeKi/4V26bzJ93a/HsytpC1siT8m4QRiVbMPKk8pf0mivC2zGBM7@vger.kernel.org
X-Gm-Message-State: AFuF++nxQqklF9FiYfBrYwrUjItZu1BhkSI5bQfvR561NFo2nOJRNjFD
	Z4PH/FvKwPshGqDv19SNjlnOK5GKQsXDhRCfjIdMN9sJFhs7cHHmXGGEIlZRlFZxKvUxqpO/Sup
	guepJ0do0c7s0C6sIdlVmtHxaehNnZzk=
X-Received: by 2002:a05:620a:6cc9:b0:939:6de8:43dc with SMTP id
 af79cd13be357-93c15e78cefmr509373185a.48.1790075445161; Tue, 22 Sep 2026
 04:10:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921152449.629486-1-alex@ghiti.fr> <70cae945-3a4a-40db-96ac-5ce66a3fa186@kernel.org>
 <CAGsJ_4y8-wD0yMV8GCtCz5MfNrOKqUaTd+UgH=8MoP_nuvPnGg@mail.gmail.com>
 <108487b7-0529-4282-b5f4-355804b4c0cf@kernel.org> <CAGsJ_4zGmGh70QtRBpnhueev3qt_bgB4ZiE9fkW-hgNjAVhv+w@mail.gmail.com>
 <arJcPIaqJOzLpkel@gremlin>
In-Reply-To: <arJcPIaqJOzLpkel@gremlin>
From: Barry Song <baohua@kernel.org>
Date: Tue, 22 Sep 2026 19:10:34 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zLY6eZWUufuVqLgEVf93G1JoKtk9ObftkoTwbAimG8Yw@mail.gmail.com>
X-Gm-Features: AcwNN1WGDooBKfoE6NAcLPXoe3osiB8r5tT_HlJWIcwGy2CzV98OLFsDfzwfKSw
Message-ID: <CAGsJ_4zLY6eZWUufuVqLgEVf93G1JoKtk9ObftkoTwbAimG8Yw@mail.gmail.com>
Subject: Re: [PATCH] mm: madvise: drop MADV_PAGEOUT folios at swap writeback completion
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>, akpm@linux-foundation.org, 
	willy@infradead.org, jack@suse.cz, liam@infradead.org, vbabka@kernel.org, 
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

On Tue, Sep 22, 2026 at 6:47=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> On Tue, Sep 22, 2026 at 06:37:38PM +0800, Barry Song wrote:
> > On Tue, Sep 22, 2026 at 6:20=E2=80=AFPM David Hildenbrand (Arm)
> > <david@kernel.org> wrote:
> > >
> > > On 9/21/26 23:56, Barry Song wrote:
> > > > On Mon, Sep 21, 2026 at 11:37=E2=80=AFPM David Hildenbrand (Arm)
> > > > <david@kernel.org> wrote:
> > > >>
> > > >> On 9/21/26 17:24, Alexandre Ghiti wrote:
> > > >>> On an asynchronous swap device MADV_PAGEOUT only marks the folio
> > > >>> PG_reclaim and rotates it to the tail of the inactive list once i=
ts
> > > >>> writeback completes, so the memory is not actually freed until a =
later
> > > >>> reclaim scan removes the by then clean swap cache folio.
> > > >> But we have the same behavior when just reclaiming memory ordinari=
ly? It's added
> > > >> to the swapcache and only the next scan actually frees up the memo=
ry.
> > > >>
> > > >> Wouldn't we memory we reclaim ... just gone, like in the sync case=
?
> > > >
> > > > For synchronous I/O, such as zswap and zram, the memory is released
> > > > immediately after sync I/O is done.
> > > >
> > > > For asynchronous I/O, such as NVMe, the swapcache is currently
> > > > expected to be rotated back to the tail of the LRU and wait for
> > > > another scan. Alexandre once mentioned that when he tried handling
> > > > async I/O the same way as sync I/O=E2=80=94releasing the memory onc=
e the I/O
> > > > completed=E2=80=94he saw some regression. So, delaying the release =
until a
> > > > later scan may allow swapcache hits before the folios are eventuall=
y
> > > > reclaimed.
> > >
> > > "may", do we have any evidence that this actually is relevant in prac=
tice?
> > >
> > > We asked to reclaim memory. We wrote the memory out to disk. We unmap=
ped it from
> > > the page tables. We made the workload the could, access the page imme=
diately
> > > again suffer already.
> > >
> > > We should just evict them as soon as possible to free up memory.
> >
> > I suggested this to Alexandre, and he found that it could regress some
> > workloads [1]. That is why Alexandre is only making the folios
> > immediately reclaimable for `MADV_PAGEOUT`.
> >
> > See Alexandre's description:
> >
> > "Future work
> > -----------
> > Barry suggested extending this to MADV_PAGEOUT and general reclaim. I
> > prototyped dropbehind for all reclaimed swap folios and it regressed
> > sysbench OLTP throughput by ~15% on NVMe swap: dropping the swap cache
> > immediately turns cheap in-cache refaults into disk reads and collapses
> > swap readahead clustering. Neither blk-wbt, mq-deadline nor a PG_workin=
gset
> > gate recovered it. MADV_PAGEOUT alone may still be worth it, since ther=
e
> > userspace has explicitly declared the range cold, but I have not measur=
ed
> > that case in isolation yet."
> >
> > [1] https://lore.kernel.org/linux-mm/20260921151306.625134-1-alex@ghiti=
.fr/
> >
> > Best Regards
> > Barry
>
> This patch as-is is just way way way WAY too complicated and fragile IMO.
>
> Whatever cases you have found, they need to be fixed somewhere
> fundamental. All of this feels like a hack.
>
> If you're having to write a comment like:
>
> /*
>  * If X is Y, but not if B, and if Z is J but not if the moon's bright at
>  * night, then maybe we will foo the bar, but only if the baz is blarghed=
,
>  * ...
>  */
>
> That usually means you're doing something horribly wrong.
>
> And this patch has multiple comments like that.

I'm not quite sure if you've read the context carefully :-) or why
you're angry with me.

I did suggest that we should reclaim memory immediately after
writeback completes, both for general memory reclaim and for
`MADV_PAGEOUT`, while Alexandre was working on zswap dropbehind.

Alexandre then found that this might not be a good idea for generic
reclaim, but thought it might still be worth trying for `MADV_PAGEOUT`.
That's why this patch came about.

The discussion between David and me is whether we should do this for
`MADV_PAGEOUT` only, or also apply the same approach to generic
reclaim. So far, we haven't even gotten into the code details.

And this is also the first day I've seen the code. I agree that I can
work with Alexandre to improve the code through review, but please
keep in mind that this is literally my first day looking at it,
my respected Lorenzo. :-)

Best Regards
Barry
