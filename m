Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1AD42CAFC
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 17:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785171946; cv=none; b=DiEDPELwwItX/critNBBAgmMjc1Yh9vIvX9n8e51BfCnOqZJn2LCSAx0I5z3kJqFX+6eb9RPusA3HtprM58Ix+MK44MfMWP6olROjnQ3tOmx2z1XxG9Aoli+nmFheFCXYjE3zErZl95JBXzrYWVQ5OZFnREqQTmfXhbDbGNWs/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785171946; c=relaxed/simple;
	bh=acBPRN+lsRzChrp84ytZ4p1LYzUx1/v/c3Lu3UdiGrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gY5PNLILNul3fRyhTvb7IIayvVZWrKPSgTbN1ryeMNWT939FeVuG9YwkQJoAokWd/S4MpoBq4zwIfyOlpiWHK32Fv2CDdnrO8BA/rP5qFgiQH/9UchcGK8JrTFpYOO6wCsWjxEKHduzCBYJjWfOKOEUEg7cHIkh4GMqf/5dYJwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5J5z06d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5J5z06d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B451F01559
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 17:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785171945;
	bh=TxnKWGgv3kgSGpcOLq+j0ydLE+o+ovzFIuBVVmOhisE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=A5J5z06d+ldD+/vVwpkfraF8fr6YN14SfDoyIifZV7wAu3Y0A5oHKfmQchRpNuz0R
	 XzWjy51xjTv0zra5jT0YR5XOEK/+qDyxFFk9RC2+fHRiiW+qF3Rjb+7YXUghN7KYZC
	 HdgVlCXqVfViTpplqUKG+KfkKgW+07NczS22VAmUSn2e5Hq+Ou8dO1GLyshGTmx7N0
	 liHc53+1rVh0XSTXaP0SWA2y80Rri4VIDb2th9M1/wO2oLwL4lx32kCBh6XMibYdkN
	 ggPewZmj5hPEQS/O8yA5PaPUz6NlG3rPWtl05h5nxY8Kf/m+RvemnyT6exWFFX8tph
	 9oUZtLcd1xT/Q==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c15d47266baso361134066b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 10:05:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rrf1DUPOT+ycpAStmewoEE+IHqaKYPEUrZ4YXKZ8l+Jx0BquHUy6I/C7kH14twA3qxiO6Ch5B7IZG9lZYM5@vger.kernel.org
X-Gm-Message-State: AOJu0YzLqnWsDHVX8TwUmy6gOPHeNkQXY7cNnbFeqTZvHw00YjOZ7w2F
	1kaCfy0KoGVRpYWrDknmwu17E4MrnS/z8ya9GMLsdcYRIq6lezNP0r5isK+SEyR+v1eU1PmkiZ+
	ViJ5SXDgd6gBN+jpO8F8sscqxcAoEtrE=
X-Received: by 2002:a17:907:983:b0:c15:f376:9642 with SMTP id
 a640c23a62f3a-c1f1f119245mr387752466b.65.1785171943901; Mon, 27 Jul 2026
 10:05:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727143618.1582318-1-alex@ghiti.fr> <20260727143618.1582318-4-alex@ghiti.fr>
In-Reply-To: <20260727143618.1582318-4-alex@ghiti.fr>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 27 Jul 2026 10:05:32 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNJ1cfCVgxtpqx4Db380bjZ+Z0P842eAxPXw6Mh4XBrww@mail.gmail.com>
X-Gm-Features: AUfX_mymjXAGe8WFZWwKwVyHcv1lhqsWQChGfs9bdQu1IS7341exKkVzBFQ0Cg0
Message-ID: <CAO9r8zNJ1cfCVgxtpqx4Db380bjZ+Z0P842eAxPXw6Mh4XBrww@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mm: zswap: drop cold writeback folios via swap dropbehind
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
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

On Mon, Jul 27, 2026 at 7:39=E2=80=AFAM Alexandre Ghiti <alex@ghiti.fr> wro=
te:
>
> zswap writeback decompresses an entry into a fresh swap cache folio and
> writes it back. The folio is cold by construction, yet it is left on the
> LRU for reclaim to find and free later, wasting a reclaim scan and keepin=
g
> cold memory resident longer than necessary.
>
> Allocate the folio off the LRU and drop it as soon as writeback completes=
:
> mark it PG_dropbehind so the swap dropbehind path frees it once writeback
> ends. Synchronous-IO devices complete writeback in this context, so there
> the folio is dropped inline instead.

Why does this need to be handled in zswap? Doesn't writeback from sync
devices still call folio_end_writeaback() and do the dropbehind
handling?

>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Suggested-by: Nhat Pham <nphamcs@gmail.com>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  mm/zswap.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 8163e6c5f76c..e37828e02938 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -992,6 +992,7 @@ static int zswap_writeback_entry(struct zswap_entry *=
entry,
>         struct folio *folio;
>         struct mempolicy *mpol;
>         struct swap_info_struct *si;
> +       bool sync;
>         int ret =3D 0;
>
>         /* try to allocate swap cache folio */
> @@ -999,6 +1000,8 @@ static int zswap_writeback_entry(struct zswap_entry =
*entry,
>         if (!si)
>                 return -EEXIST;
>
> +       sync =3D data_race(si->flags & SWP_SYNCHRONOUS_IO);
> +
>         mpol =3D get_task_policy(current);
>         folio =3D __swap_cache_alloc_folio(swpentry, GFP_KERNEL, BIT(0), =
NULL, mpol,
>                                          NO_INTERLEAVE_INDEX);
> @@ -1013,7 +1016,6 @@ static int zswap_writeback_entry(struct zswap_entry=
 *entry,
>          */
>         if (IS_ERR(folio))
>                 return PTR_ERR(folio);
> -       folio_add_lru(folio);
>
>         /*
>          * folio is locked, and the swapcache is now secured against
> @@ -1046,12 +1048,17 @@ static int zswap_writeback_entry(struct zswap_ent=
ry *entry,
>         /* folio is up to date */
>         folio_mark_uptodate(folio);
>
> -       /* move it to the tail of the inactive list after end_writeback *=
/
> -       folio_set_reclaim(folio);
> +       if (!sync)
> +               folio_set_dropbehind(folio);
>
>         /* start writeback */
>         __swap_writepage(folio, NULL);
>
> +       if (sync) {
> +               swap_dropbehind_free_one_folio(folio);
> +               return 0;
> +       }
> +
>  out:
>         if (ret) {
>                 swap_cache_del_folio(folio);
> --
> 2.53.0-Meta
>
