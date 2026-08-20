Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48879434E2C
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 11:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787225815; cv=none; b=FWwzHXfkzFeAls84HbyZsPBPGxGuFhQM+IT4fpHtpbTvQNNZRv/oXJuZs7eAvs4t/u39oHjtCIzOC9J/pVLIM6nIWT5OQTPBakIRTeBLsMXjk6nG/8ZcVrg+Zt0U2jHPpJEeCj1JfCe+9O6Jmn+bJr2W6VuR1jCLMOouNIKysSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787225815; c=relaxed/simple;
	bh=rykG5aWtW03tEfhZSKSzius1a/NFuuaPArnKpTW8nO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=thRQHqjMDzELLCe+Rx7nSV4ztLin887WGclXzmE7NgzcQUqGDU58TDXjdsd5m60KGssAXsrE0uS7OQVdd2NFW8dSwKHuYlZytDwF36i1P10GIS4ElgrBcQxHmrRgmX0UH25pxemtgS6zH6j4O7LowKxRFO71K9Fhu4qdUCtCVx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SB5RDxXv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SB5RDxXv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02ED91F00ACF
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 11:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787225814;
	bh=1rvWP69jNYCLEMQnHPvdNYBrNQ/dPw0juu10J6Hhu5g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=SB5RDxXvl/ioN4+C0+m6YIiRbM3zfhIQb1E+HC/YzVqhU6PxHRd0x0a6YmL5joNdo
	 4e3l72tD2ncq5FK1Tr565oP3K0w/Nb/tTny0pdykkWXo8Prmmwx8YVmI0dDvzwWuUZ
	 CmuIf3KJsbN8mHpAU53cWTy1WVEgyhrsU2VeJtQ/+fwhW6bSPI/GtetqzoOCuqEyzT
	 9kAw3o0uXLdqeU3k8hu9+qSZhUat8YAr4I+/Zr17Ctrnm78JMwHvSosecb6qujzA2K
	 GgSHBJp2/3vm1UjMTwJ8gbq55YX5N4Ykw2B8L6cBHwIAgnY+L7L6WVx1+RFp0DL4gE
	 bybgl27AZtBRg==
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-9349ad9c857so198218885a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 04:36:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RriG+nhbhlvlgKWwSHzORJZpuONi4LO/ZOi6xasTzxvSlrX+Od2bUftIZgRlhjnoGMo/26lm73OEWq6otSf@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1TbpMcWqQZKtnEWX17FVkwbGQcVvuvzarH7XHLaOV0tjBX7ka
	GMSDEBj/YdgY14WaGECBeCxjqVFJNNjy4JN3KijU3p3XKfQfPO0z8TH2+24uS+0Np5o5GrA36Wm
	ZeLo5QMTf3rCtR3FsEeEdF6UyVIRFtzI=
X-Received: by 2002:a05:620a:2847:b0:936:75ba:7c5a with SMTP id
 af79cd13be357-9371e6f65damr960131585a.31.1787225813422; Thu, 20 Aug 2026
 04:36:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818163221.589352-1-alex@ghiti.fr> <20260818163221.589352-3-alex@ghiti.fr>
In-Reply-To: <20260818163221.589352-3-alex@ghiti.fr>
From: Barry Song <baohua@kernel.org>
Date: Thu, 20 Aug 2026 19:36:42 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zC+wAuevG+i5y23rLPGXn0P=D7JpMECnZ1OuP1BsyYkw@mail.gmail.com>
X-Gm-Features: AcwNN1Wdmpc747x_Oxp0xjcXXBYq4rS8x3lyA5XuxyF0aRDk0ej77W6gNxw8_XQ
Message-ID: <CAGsJ_4zC+wAuevG+i5y23rLPGXn0P=D7JpMECnZ1OuP1BsyYkw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] mm: swap: drop dropbehind swap cache folios on
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
	Yuanchu Xie <yuanchu@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 12:34=E2=80=AFAM Alexandre Ghiti <alex@ghiti.fr> wr=
ote:
>
> A PG_dropbehind folio is dropped from its cache once writeback completes
> rather than left for reclaim to find later; this is implemented for file
> folios in folio_end_dropbehind(). Extend it to swap cache folios.
>
> The drop needs the folio and swap cluster locks and may sleep, but
> writeback can complete in interrupt context, so defer the work to a
> workqueue that runs once writeback has completed and frees the folios in
> batches.
>
> Suggested-by: Yosry Ahmed <yosry@kernel.org>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Suggested-by: Nhat Pham <nphamcs@gmail.com>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
[...]
>
> +static DEFINE_PER_CPU(struct llist_head, swap_dropbehind_llist);
> +
> +static bool swap_dropbehind_drop_folio(struct folio *folio)
> +{
> +       struct mem_cgroup *memcg;
> +       bool dropped =3D false;
> +
> +       folio_lock(folio);
> +
> +       /* The folio was allocated off the LRU and nothing re-adds it her=
e. */
> +       VM_WARN_ON_ONCE_FOLIO(folio_test_lru(folio), folio);

Hi Alexandre,
Thanks very much for your patch!

I don't quite understand why we only support NON-LRU folios. Does this
restriction prevent potential optimizations for madv_pageout?

Also, zram might benefit from your patch in the future with
asynchronous hardware compression and software compression such as
kcompressd[1].

[1] https://lore.kernel.org/linux-mm/20250430082651.3152444-1-qun-wei.lin@m=
ediatek.com/

[...]
> +
> +/**
> + * swap_dropbehind_free_batch_folio - free a dropbehind swap cache folio=
 into a batch
> + * @folio: the off-LRU folio whose writeback has completed
> + * @fbatch: batch of folios to free, flushed when full
> + */
> +static void swap_dropbehind_free_batch_folio(struct folio *folio,
> +                                            struct folio_batch *fbatch)
> +{
> +       if (swap_dropbehind_drop_folio(folio) && !folio_batch_add(fbatch,=
 folio))
> +               folios_put(fbatch);
> +}
> +
> +static void swap_dropbehind_workfn(struct work_struct *work)
> +{
> +       struct folio_batch fbatch;
> +       struct llist_node *pos, *next;
> +       int cpu;
> +
> +       folio_batch_init(&fbatch);
> +       for_each_possible_cpu(cpu) {
> +               pos =3D llist_del_all(per_cpu_ptr(&swap_dropbehind_llist,=
 cpu));
> +               llist_for_each_safe(pos, next, pos) {
> +                       struct folio *folio =3D container_of((struct list=
_head *)pos,
> +                                                          struct folio, =
lru);
> +                       swap_dropbehind_free_batch_folio(folio, &fbatch);
> +               }
> +       }
> +       if (fbatch.nr)
> +               folios_put(&fbatch);
> +}
> +
> +static DECLARE_WORK(swap_dropbehind_work, swap_dropbehind_workfn);
> +static struct workqueue_struct *swap_dropbehind_wq;
> +
> +void swap_writeback_dropbehind_folio(struct folio *folio)
> +{
> +       llist_add((struct llist_node *)&folio->lru,
> +                 raw_cpu_ptr(&swap_dropbehind_llist));
> +       queue_work(swap_dropbehind_wq, &swap_dropbehind_work);
> +}
> +

This is good. For file dropbehind, I see both F2FS [1] and block
devices [2] reinventing workqueues in their own filesystems or
drivers, while folio_end_dropbehind() simply benefits from its safe,
sleepable context. This seems a bit odd.

So I'm really curious whether this could be extended to file-backed
folios as well, so that those filesystems and device drivers don't
have to deal with this themselves.

[1] https://lore.kernel.org/all/20260820071438.695893-1-qiwenjie@xiaomi.com=
/
[2] https://lore.kernel.org/all/20260730-blk-dontcache-v7-2-3e8e6850068d@co=
lumbia.edu/

Thanks
Barry
