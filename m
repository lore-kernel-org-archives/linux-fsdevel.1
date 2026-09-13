Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FDA39D6FC
	for <linux-fsdevel@vger.kernel.org>; Sun, 13 Sep 2026 23:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789340503; cv=none; b=PHCzLOJjwINn8lVzRTDiYtykwLg29O/SzFDmGRe210otBnRbJJ2PmcZrZsAAlybEmM0Aihv8YvGjr27MnV2z9A4xqXjgWNB/iyHONxAccps8eX/Nfbix3qc5j4uirl87kFUs6ts+GH2mVgA5ZaMBGVIucGY6CGv1hW4Ag+YvhS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789340503; c=relaxed/simple;
	bh=vmS/z30Lrw765wwNobalklNluBOAwT+fYyV0xjUzdP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q0/1GuumvAcC/3O1AyEawUdA5QNGpkKgOoKqZGz18sFAcb/nb9wpLyersBO8KbvWDSEkB/hBxF0pz0xI7tkvO44gdUqFopeKmCwsb+htIQd94a7bZN9GAvOf4Q9D2N3v9SP+REcRBrh7yI7CKNpnbv6PjumJ1lvPg1ubpCFfaz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TM97ARPE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TM97ARPE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA92C1F008A2
	for <linux-fsdevel@vger.kernel.org>; Sun, 13 Sep 2026 23:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789340499;
	bh=99tdpBy09GP4NZtz0Xsy9UP2oQosnHb+3YQeokfanhI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=TM97ARPEPGldOphV61MxaXcJ8Cmz/SeyVMCYqoV2PChipT5EBrAMjpjZuBOcinf4e
	 0yybwGl+Pu9DUtJc5TXlM3ozcaaxByFCXVL4vFpuoRzOGQ6vXt0u+hOmKZYiw2tJzD
	 hQTdan6C0WjJAmpb7uwtuMKvi139ucEos+tilPP5xoOTeGp408O+0bWA6Ygo7pGlf0
	 zymUg47rRdsbv/WQ6h7+izkMVdc5HwXP8/FDFV40TP/+w6ePD5i0YzkU8gPLiwm6I1
	 0im2QAvG3pdG2nWsULgYunv5eOIcRGndeLjeC+3n5JZQvdXpJKQ8iiI9bIFAlj9ZWI
	 FBSZChhNqi9TQ==
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-939109f067cso134556185a.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Sep 2026 16:01:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzWvsdmwkk4xL5wtT/BTgZxHBtw2uYtBmaw9gafBO2nPJYCbBT8imMK19PAqir3TNh7BRDQ9Dqt6MwsmlDb@vger.kernel.org
X-Gm-Message-State: AFuF++mAvK+GU5iadM9M78yT4W6FQqYziTsWroOxYxERZiq9jYwGZ5o/
	HhKrbvx95hzgmrxV2JyGHnkMVXy6jK1+qs7yifkdnYgZJtYyBKuAgHcQsaNBF2SD0e12hpenDjr
	RyzKNFi3urx75Iy2TUwCTjJta8B+Sa/Y=
X-Received: by 2002:a05:620a:8703:20b0:93a:2a59:3377 with SMTP id
 af79cd13be357-93a2a596b4amr5388585a.41.1789340498890; Sun, 13 Sep 2026
 16:01:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911121341.178028-1-alex@ghiti.fr> <20260911121341.178028-3-alex@ghiti.fr>
In-Reply-To: <20260911121341.178028-3-alex@ghiti.fr>
From: Barry Song <baohua@kernel.org>
Date: Mon, 14 Sep 2026 07:01:27 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4z3bSfMTKvkXsKAz=+dzhmdGOerSfL33t2RkN0CXZV-hw@mail.gmail.com>
X-Gm-Features: AcwNN1VeUdFTleVj-F2oE0UDk9S9NWy5SYyYKI8DUBOkx_28Wvoxe5F4EMw-zho
Message-ID: <CAGsJ_4z3bSfMTKvkXsKAz=+dzhmdGOerSfL33t2RkN0CXZV-hw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] mm: swap: drop dropbehind swap cache folios on
 writeback completion
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry@kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kairui Song <ryncsn@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baoquan He <baoquan.he@linux.dev>, 
	Youngjun Park <youngjun.park@lge.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Michal Hocko <mhocko@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Wei Xu <weixugc@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Kunwu Chan <kunwu.chan@gmail.com>, 
	Tal Zussman <tz2294@columbia.edu>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 8:16=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> wro=
te:
>
> A PG_dropbehind folio is dropped from its cache once writeback completes
> rather than left for reclaim to find later; this is implemented for file
> folios in folio_end_dropbehind(). Extend it to swap cache folios.
>
> The drop takes the folio and swap cluster locks and may sleep, so it
> cannot run in interrupt context. Set BIO_COMPLETE_IN_TASK on the write,
> as the file dropbehind paths do, and drop the folio directly from
> folio_end_writeback().
>
> Suggested-by: Yosry Ahmed <yosry@kernel.org>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Suggested-by: Nhat Pham <nphamcs@gmail.com>
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
[...]

> diff --git a/mm/page_io.c b/mm/page_io.c
> index 88962571cb93..52eae99de6e3 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -602,6 +602,15 @@ static void swap_bdev_submit_write(struct swap_io_ct=
x *ctx)
>                 submit_bio_wait(bio);
>                 end_swap_bio_write(bio);
>         } else {
> +               int p;
> +
> +               for (p =3D 0; p < sio->nr_bvecs; p++) {
> +                       if (folio_test_dropbehind(bvec_folio(&sio->bvecs[=
p]))) {
> +                               bio_set_flag(bio, BIO_COMPLETE_IN_TASK);

Thanks very much, Alexandre. I find the code is really much,
much better, but I=E2=80=99m still struggling to understand why we need a
sleepable context after Wenjian=E2=80=99s commit:

https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?id=3D84=
8d2ce2fce15fbdc083fbf9691bfa72911033c4

With this question:

https://lore.kernel.org/linux-mm/CAGsJ_4wj6XvPB+QF+_X1BJ_8Y2sZEEFAw6RaJJz-c=
HaDWLkxaQ@mail.gmail.com/T/#u

In short, it still feels a little strange to me that we need a
sleepable context, especially now that we no longer call
`folio_unmap_invalidate()` for unmapped folios.

Best Regards
Barry
