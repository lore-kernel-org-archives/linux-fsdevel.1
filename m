Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8D246D2BF
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 16:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787589558; cv=pass; b=WRDQvbl0d6LitQZPSsi+2J8G/dSqZTCtRCiZSfLCU/NIfTWPSBw1+OZV2Mccw7q37OflIw2ScyZLQFdrnk0V11IyGCk5bYNCl1KA7hxY0IcNQsQiEVHxjGAUHGpxcZYc8H99+svlQD+Y82qQ9fFMI+Cj6VBa0zjDFGnofaE0gnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787589558; c=relaxed/simple;
	bh=s9ENCUqu4cuAG/MA+I55viOKUq7kKs/v6Uip5cil7A4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dRlY4sn2t46ENbx40JObzUeVlWXRzkQY7tbd0AK5HtmSHJoXYOKR7u4Hor+AeVR+Cr5TX/HuJc3ax/9e5Ev6UST/ts4Rbzd+YYP1AQGyFZj9nao+nAwBF9+rZoG6Rj32px8WDE0qHierYYDhcVW1eOoU6DOiwi2nYcKqGcdiY40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDrIZbE6; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDrIZbE6"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-499b6c02b02so17108065e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 09:39:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787589553; cv=none;
        d=google.com; s=arc-20260327;
        b=nW0R8s0hHQ4dsgcRkbqyb7slRzXM36KzZEZKDbqiBb5im8ublxkQ8IqLRgfsiZ/vzW
         wAx5a+SFhRtgtmXEMXAjX0qaPX9at9GHwJx89PFkw6T3l6mg2nnBiUkn86XHGRQGRRp1
         rw+ugHykyi8qiIeCj+2tTMpqb5lXkTXHFTgypr7LG0J5cueYUWDh6y1FVZycR0h7nMSL
         QtieZOrj4YHh535ZfNkCDfHNG9EOuj+t4vKFsy88kAZKsuku7aDsqwPqMdI54dWE6MGv
         a3LYKT2a6DaJPsFu3LXoKoDSp7xaIRvEdIarH0X0Ne1pe/j6nyGMyKGFpBEHrY3l4S5N
         P01w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Lxchaipo0XOkASCChG5mzH54uBQ7bEpO8g3CtzEDtkk=;
        fh=CAkFO65VSwZICE28NCc/pPrMf3SeFbglUFaki6F8c0s=;
        b=Z2AYMxBGWinXYxxt5dIyHkxvPtehjWns2SK5CskGvtF9XE02DS0O+oKWq3cbOVXfXX
         jgifxAGYl42JLBSVQsbcS9qmDtHY0do4ARAXQquDd+ijfcurhCbz/Ewf2UYNpSOWA2/K
         vbxRMnpTq1iDIklwL/rJDv9UZRDr1382DSrQ1HskuH3VHoia7yz4xeFqZSVzmQGdz1eX
         RMdYNDXd869aMhGWyJ9RymP2QP8XEZxIBY1EfUAUbAtMe4AQXvWkElcKzGSnD6oueVio
         Q264XHxLJuKTkyDbVFds7PF142wWLZoFsifSAYR264m4yW2seYCTBpjunNpUb5JA51Bj
         e28Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787589553; x=1788194353; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Lxchaipo0XOkASCChG5mzH54uBQ7bEpO8g3CtzEDtkk=;
        b=LDrIZbE6NpS3sPYmqIUHsxi7WHj4NK66IspPlURRCOsM/SxyNtFm42UraZRL3Oiv8I
         5gadKqB3vV8AGzeMeuVYCrC7zZ3hgffldWmTsOv+vAhvFXmljnJzG6tRTlNkKIQeCbJY
         lL6mCNhczB2kpn54JwKjAsxF52Zl1Evf+S+j7TIN7oaDqnGZlHGN4YON6hxv1x2hb07u
         e8PnPxoB/NZOXNswNMfLDH1bIf3dbe6vITUdwGkIuCT51CwsZG75IcepES+PGYyLxq5c
         Jb3bKeezxqTwhtlYSuQx17tICCHUTIPWEGDbVEcxceuCbwyKEOlxCUmwHHQ+XZ6F2Dnz
         1Crw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787589553; x=1788194353;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lxchaipo0XOkASCChG5mzH54uBQ7bEpO8g3CtzEDtkk=;
        b=quXAoBAcFWRwEogHMvDt0zOvqGFApYi/f+0omM+BVw4ahk6AEyZ1Wqsz3ARgC04AKe
         pOQPvAxA35nI+dkNVrflnEdMyxoQRA/5L0Z8Y/q6HOR8m/f4/EQ6NDKIfWh8qHNJ/+NQ
         C0HhVoE6cuf+DGurvP4TG4TmB+F+PKuy6pYOU6KBo91zt8qV/WCCV/QPinjeCUImeIPb
         f+Vp60HXJbz9jVFyGS0E0dgcrfYquxvFWXyxfyWi1Sgzf0ZiHYaqMUtlTTGsxmeyS87f
         5zpZO2hMQaBnDC8OQCS3pfAkx+Z89PvtbP3DieWgLkDOrhdqKUdJT8nq4Apw81fU0KtZ
         IX7Q==
X-Forwarded-Encrypted: i=1; AHgh+RqzNyLu7NhWUxL5U26h/FJ+/u9ocidzJcaclITFgk+AQJpkMUiAdIY10bNKi7QZHzC5EK/4d+IEzevOm0cQ@vger.kernel.org
X-Gm-Message-State: AFuF++kN8p98gME2A8LHafBX5YlnUmkxlp8UsFH6A3loTg1NQJx+sfxM
	GkvizS+jm3lOvyiRzvII1V3pKk8W/TPLz4txtcfRwKFUu4DBslmFp/06rB0vhcE2D4BknZXWKDQ
	ZTBzwVfs+c+reH/6Dgi4+bYfpjXPtaQM=
X-Gm-Gg: AR+sD132KOcXNhp1TtXE1j1KzOuZrQyYYYDW5Cn8cjRcJGCnKvhUDovdJi4Caf+Hlob
	YfI5q0JRhsAwGuGYJYCowk9jjrOevszGz7OrBlDwTuD1augnvnrVA5iYinvaHOC4VttwhnW2QtJ
	nJ7HrgPeKUnrlOD6TAAbl1dvxn2OAIHA5i18Wl4tYYGD/rj4ED8zHQcUpjl+KS0qC6wRziOGuT6
	yO4J6Nzok3ACaWNyg6HFfHd8UNx+aY7jUc8gfUsaKZqW//WUz5geXQgrCC/CdhiMPpiwyGyjD/E
	BFqKWnOhn3FBW31FfMC6a3Tegyqo+/oulLh/AzWgW3NjONgbvWCA9zE6
X-Received: by 2002:a05:600c:4e89:b0:499:53c4:1daa with SMTP id
 5b1f17b1804b1-499b8474febmr346530335e9.15.1787589552280; Mon, 24 Aug 2026
 09:39:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818163221.589352-3-alex@ghiti.fr> <20260821083500.856970-1-kunwu.chan@linux.dev>
 <CAEmasaUzCU7r7DzJfMFbQGZCJvA_wOJifPywQmy8mOz0efWn8g@mail.gmail.com> <CAEmasaX8QPPNFjrTWn4jn+hoC_q9BrRhia9Zz5FYHyzbMjN2SA@mail.gmail.com>
In-Reply-To: <CAEmasaX8QPPNFjrTWn4jn+hoC_q9BrRhia9Zz5FYHyzbMjN2SA@mail.gmail.com>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Tue, 25 Aug 2026 00:39:00 +0800
X-Gm-Features: AcwNN1UaQAkZTylCiVANyXjbN8zO4d5pJy1P5Gk4Q_Uw1URMWPexKU-CeqwqgRw
Message-ID: <CAN_Opa8Bp3udH2hVGMGwomncFRrZ11FpqkN7gogPgYJYNtAe0Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] mm: swap: drop dropbehind swap cache folios on
 writeback completion
To: Alexandre Ghiti <alexghiti@meta.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Kunwu Chan <kunwu.chan@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry@kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kairui Song <ryncsn@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baoquan He <baoquan.he@linux.dev>, 
	Barry Song <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Wei Xu <weixugc@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 5:30=E2=80=AFPM Alexandre Ghiti <alexghiti@meta.com=
> wrote:
>
> On Fri, Aug 21, 2026 at 11:53=E2=80=AFAM Alexandre Ghiti <alexghiti@meta.=
com> wrote:
> >
> > Hi Kunwu,
> >
> > On Fri, Aug 21, 2026 at 10:35=E2=80=AFAM Kunwu Chan <kunwu.chan@gmail.c=
om> wrote:
> > >
> > > > >
> > >
> > > Hi Alexandre,
> > >
> > > I have a question about the reference ownership/lifetime model in the
> > > synchronous-IO case.
> > >
> > > Consider the synchronous writeback path in Patch 3:
> > >
> > >   zswap_writeback_entry()
> > >     folio =3D __swap_cache_alloc_folio(...);
> > >     ...
> > >     __swap_writepage(folio, NULL);
> > >     folio_put(folio);
> > >
> > > During writeback completion, Patch 2 does:
> > >
> > >   folio_end_writeback(folio)
> > >     folio_get(folio);
> > >     ...
> > >     swap_writeback_dropbehind_folio(folio);
> > >       llist_add()
> > >       queue_work()
> > >
> > > With synchronous I/O, is it possible for the dropbehind worker to run
> > > before zswap_writeback_entry() drops its reference after
> > > __swap_writepage() returns?
> >
> > Yes, totally! The window is short though and in that rare case, we
> > would fall back to the initial behaviour (almost, since we put the
> > folio back onto lru but not rotate it). And for async devices, I don't
> > think it can happen at all.
> >
> > >
> > > If so, the worker will attempt:
> > >
> > >   swap_dropbehind_drop_folio(folio)
> > >     ...
> > >     remove_mapping(swap_address_space(folio->swap), folio, true, memc=
g)
> > >
> > > while the caller's reference is still held.  Looking at
> > > __remove_mapping() in mm/vmscan.c, it expects a refcount of
> > > 1 + folio_nr_pages(folio), but the extra reference still held by
> > > zswap_writeback_entry() would make the actual refcount one higher.
> > > It therefore looks like folio_ref_freeze() will fail in this case.
> > > Is that the intended behavior here?
> > >
> > > If the removal can fail, the fallback is:
> > >
> > >     folio_clear_dropbehind(folio);
> > >     folio_add_lru(folio);
> > >
> > > This appears semantically safe, but it means that the dropbehind
> > > optimization is lost for that writeback: the cold folio goes back ont=
o
> > > the LRU and has to be found by reclaim later.
> > >
> > > This seems particularly worth checking because v3 intentionally remov=
es
> > > the synchronous-I/O special case from v2.  The cover letter describes
> > > that special case as an optimization that was not worth the extra cod=
e,
> > > which I agree is a reasonable direction if the generic path is
> > > sufficiently effective.
> > >
> > > Could you measure the corresponding fallback rate on a synchronous
> > > backend (e.g. zram)?  The 99.996% success rate in the cover letter is=
 for
> > > asynchronous NVMe, so it does not tell us how often this particular r=
ace
> > > occurs with synchronous completion.
> > >
> > > More generally, I'd like the reference ownership across
> > > __swap_writepage(), folio_end_writeback(), and the deferred worker to=
 be
> > > made explicit.  If the caller's reference can overlap with the worker=
's
> > > reference, I'd also like to understand whether that is an intentional
> > > and acceptable trade-off, or whether the overlap can be avoided witho=
ut
> > > reintroducing the synchronous-I/O special case that v3 is trying to
> > > remove.
> >
> > I need to look into the patchset that Matthew and Barry pointed to and
> > check if it's still relevant with this patchset on top of it. If so,
> > I'll add a debug counter to confirm we don't fall back too much for
> > sync devices :)
> >
>

Hi Alex,

Thanks for checking this and for the detailed explanation.

> As you noted, in my implementation, a race was possible between the
> worker and the folio_put() in zswap_writeback_entry(). Now with Tal's
> patchset which *only* defers atomic context to a workqueue, the
> dropbehind folios on synchronous devices get freed inline which is not
> possible because of the reference held by the zswap writeback path.
>
> But it's cleanly fixable by dropping the zswap reference before
> __swap_writepage(): the folio is locked (when it is allocated) until
> writeback starts, then PG_writeback prevents the folio removal from
> the swapcache and right before clearing PG_writeback in
> folio_end_writeback_no_dropbehind(), folio_end_writeback() takes a
> reference! So remove_mapping() is happy with the refcount :)
>

That makes sense.
Dropping the zswap reference before __swap_writepage()  avoids the
overlap, while PG_writeback prevents the folio from being removed  from
the swap cache until writeback completion.
The reference taken before clearing PG_writeback then ensures that
remove_mapping() sees the expected refcount.

I agree this is cleaner than bringing back the synchronous-I/O special case=
.

> So there are no more races as you pointed out, since we drop the
> reference before the writeback. I'll post the v4 today.

I'll take a look at v4 after it is posted.

Thanks,
KunWu

>
> Thanks again for your comment.
>
> Alex
>
>
>
> > Thanks for your comment!
> >
> > Alex
> >
> > >
> > > Thanks,
> > > KunWu
> > >
