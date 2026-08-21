Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB77204C31
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 14:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787320884; cv=pass; b=AkCAEGqoClRUFHT/muQCNNUKyl9TRWmKb6pPdiVgB1jK4M5UxUJKEzFfqmUF9pwnlxHN1brruXQnjhKccFDPEjELbm1k67nLyF41aDguzq2Bo3L2VCMYBix9/zGrLH2ORqMFszDVKnqs5Hs/CQVdl7M/ggJw1wwMuOrs1iE16DM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787320884; c=relaxed/simple;
	bh=4/5+J/20cbZhzKUUVEVkWpfpuIcSJPF4vXSaA3+hSSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qhyZIf/pRJdlAfcGoj52K4MyBTCbY+3Os7OnWceanqiGNXsaF9xbQNGLleSWZbTJhZ1cy3eQ1VFNlWx/OAEyBG6H4XEXwXLuCz+T8+PAAdrMyvyJLBFcnHLqq/nHJ9sTjSt8pu9kYd78BY5qsoiOTa6KMHXMKkD5g3MvFD6B7n0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNGD2MtL; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNGD2MtL"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49954b88fffso8778735e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 07:01:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787320881; cv=none;
        d=google.com; s=arc-20260327;
        b=TjbJqlJViJXoMuCUrY+KydHKt/x+KTw6THDp4c56kJhBqLL2DMSPlb5OLXZBOXeEbX
         DruyGjjpTyJenpEiR9lMuhnEXEgq5H8exGSAebd018c2QQ3ccwHHXnx8hHpyqXTaqjM1
         TWX5G9HFwcPDvl2SQUtIetTlG+vmyEk6Tph+Qg4b6LuyShOPkz+wUQK1ClCXN6MpXdBW
         abgy9JjOzyU+geuuCwSR7/xnKQR97KeShcasNmI512+O5BHbtqf4T1BKe8Pf0Tik7rwF
         yRHCFuGW81A1wEW2mIWMDawSKypMjL9ntzETQs83qleyuKUg66b6kLJDSAgqadbdwL1A
         b7lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H1ffK8I93i5V8IKh3wYZJYM9LRAB/3UG35EKVm7QGl0=;
        fh=R0ynXAUlj0A68budan8Y25jQuzxW2lPJE3gGj+yGd9M=;
        b=rWZiJ9aDsLFbHgNE1EMG0gU3iItgvxlMR9szCWXXc66l5aM+nlXFyY2FBgQlUwhMH6
         H62iMBdzUNOdQ4QIH9DAFApWVC4OvbAC9KsvGbLa0foYHsWdIviwOmoL7RfQQOqi+3eb
         CINe7vfNH+AsYgWnyYMo8jC6bKWcm5u9VlqX7oztxB3z4T9ohzE0kxdXgrNRzWGoYwyd
         Ya4nhMgt3hRkK8dtLTB+rIPpHsb7U1qM63GQ7hktiWMzWfIYaCotBgFxLfmTjS4cFLWP
         UBlqVuFMklLM/uga3KY6RjdvHpbGN3BfLmiWo80exL/bHw7DZCvqEqtVMbHuSOwEdYj7
         sBpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787320881; x=1787925681; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H1ffK8I93i5V8IKh3wYZJYM9LRAB/3UG35EKVm7QGl0=;
        b=dNGD2MtL4Y1mNCzWndHXLiMEWXfih9MJSrusJsJnS90lONBNlFOksfvGTfWbqeg0vt
         OPzDE+agBLDTSWRQybLq6bW2WSSZBAGx8lQYa5Rv7RvRkVHHUksWvCN7Zb/hHPdlSyoJ
         k83wEjipxshpFJIyPW2c4TrL2Hr1Yyv/ZQb46P++fEop7Kn+VJCd/1mcYrhiyqVm4Kz+
         cLDxsTIEFprXnvVQ9fECx88zaI2OlomCywXkZp0kAfTicR1Vi2aUFaQ+dMA7jYLQsvym
         E0xMXUMRaB5CGGS1PsqlziXqmjN/rFWH7Pf9Sn3gE/6wK9tmla0bvpWMowC1n9LO7Lf6
         DMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787320881; x=1787925681;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H1ffK8I93i5V8IKh3wYZJYM9LRAB/3UG35EKVm7QGl0=;
        b=EKy7o951QMW5iJjbHu2VarABR4+t494rfRPWaWBNr3+Z4sCdLq4xhqIP7HF6wNdZre
         XduJqHZJNwWy81uQnbBKFTl/UsQZkI8sn2uOzwy7Rjx8ig2MPn9xgA9DtMd7QURxcjDO
         7777hx8IbTGDVt3SpA+Cz5Ns5CnukVdTShr+r3+LPZ5unMTOj0gUuVI0Iju3TVq7+ldq
         4hnlbnmmlx0kOQYZLa80Kkydt8LOJvDI0BL0kbgCXmYAc5HlFTR1YbMpuHaYcQ94b+/t
         s8dHzyi2JzB1lL4FHXUJxIM9HKY7wPn/T74TwP9lcfVmqIjDFyclsMOz1r+iqkr2ugOp
         VI9Q==
X-Forwarded-Encrypted: i=1; AHgh+Rq9HdR7tlx1imStj39KV7amDSAaEmtWS41Iw2yBJKXwV3xRuZwwgDkCllNzq/e2q489TzLwhcr2z3r+Pen9@vger.kernel.org
X-Gm-Message-State: AOJu0YzdBB/H+TOgwPCT7F3CF/MQGn+xTWnyET5vF0hTegXph+2PMvos
	caXUmvrQD7GDjxw71jlNcpAijVCA8DsPIoYs58oOsVtNDyiiF8JKRaiBbxx3BRD1tOpqX+X/Xuz
	2ZzXaTBi4NeD6cQsvy5Psn50qwdHXjnc=
X-Gm-Gg: AR+sD10ZpHzKmV/dVz9XNHlhH1cjJqE1Gu4T6YkzV4T1CStaUCa30IL9ji0KdFc06B5
	+3V8AfqDJz7q2T4xMBZEdZfPBLYvJVM0P29Ai6hBeXgcF7RSOrD63G3qI7PkyG/OiSqjQqcwepV
	Bxs7olBdTaidf1ithGK4UaRFL4cNljYIwQ7bdXyNWOmuUnycWuX6FDih1JqMrJK3bcONjHNEjTu
	qehc6OgXLpeUfOOtx24Lyun/TNAarDV+dBUAi2fP7z7/iAqOAhen+yGHTs+1PK8Ey1LGofF81Dy
	lDmDJwM0PWzr8JuVrRfviiYRzWM/j8nj0hul+ajl0ByFeXE=
X-Received: by 2002:a05:600c:1548:b0:495:7888:281c with SMTP id
 5b1f17b1804b1-499b8268eb4mr102805535e9.0.1787320878874; Fri, 21 Aug 2026
 07:01:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818163221.589352-3-alex@ghiti.fr> <20260821083500.856970-1-kunwu.chan@linux.dev>
 <CAEmasaUzCU7r7DzJfMFbQGZCJvA_wOJifPywQmy8mOz0efWn8g@mail.gmail.com>
In-Reply-To: <CAEmasaUzCU7r7DzJfMFbQGZCJvA_wOJifPywQmy8mOz0efWn8g@mail.gmail.com>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Fri, 21 Aug 2026 22:01:05 +0800
X-Gm-Features: AcwNN1U-quZRJWiWdw6RrMN6dMLen2bBdHYXmOqgfoQQew-i8a7acS4dXR_5YhQ
Message-ID: <CAN_Opa_vhvgxZUvsXN8ZvCMv2-9ZBywzJRo=LLjcXYWarZF-ZA@mail.gmail.com>
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

Hi Alex,

> Hi Kunwu,
>
> On Fri, Aug 21, 2026 at 10:35=E2=80=AFAM Kunwu Chan <kunwu.chan@gmail.com=
> wrote:
> >
> > >
> >
> > Hi Alexandre,
> >
> > I have a question about the reference ownership/lifetime model in the
> > synchronous-IO case.
> >
> > Consider the synchronous writeback path in Patch 3:
> >
> >   zswap_writeback_entry()
> >     folio =3D __swap_cache_alloc_folio(...);
> >     ...
> >     __swap_writepage(folio, NULL);
> >     folio_put(folio);
> >
> > During writeback completion, Patch 2 does:
> >
> >   folio_end_writeback(folio)
> >     folio_get(folio);
> >     ...
> >     swap_writeback_dropbehind_folio(folio);
> >       llist_add()
> >       queue_work()
> >
> > With synchronous I/O, is it possible for the dropbehind worker to run
> > before zswap_writeback_entry() drops its reference after
> > __swap_writepage() returns?
>
> Yes, totally! The window is short though and in that rare case, we
> would fall back to the initial behaviour (almost, since we put the
> folio back onto lru but not rotate it). And for async devices, I don't
> think it can happen at all.
>

Thanks for confirming. That makes sense.

>
>
> >
> > If so, the worker will attempt:
> >
> >   swap_dropbehind_drop_folio(folio)
> >     ...
> >     remove_mapping(swap_address_space(folio->swap), folio, true, memcg)
> >
> > while the caller's reference is still held.  Looking at
> > __remove_mapping() in mm/vmscan.c, it expects a refcount of
> > 1 + folio_nr_pages(folio), but the extra reference still held by
> > zswap_writeback_entry() would make the actual refcount one higher.
> > It therefore looks like folio_ref_freeze() will fail in this case.
> > Is that the intended behavior here?
> >
> > If the removal can fail, the fallback is:
> >
> >     folio_clear_dropbehind(folio);
> >     folio_add_lru(folio);
> >
> > This appears semantically safe, but it means that the dropbehind
> > optimization is lost for that writeback: the cold folio goes back onto
> > the LRU and has to be found by reclaim later.
> >
> > This seems particularly worth checking because v3 intentionally removes
> > the synchronous-I/O special case from v2.  The cover letter describes
> > that special case as an optimization that was not worth the extra code,
> > which I agree is a reasonable direction if the generic path is
> > sufficiently effective.
> >
> > Could you measure the corresponding fallback rate on a synchronous
> > backend (e.g. zram)?  The 99.996% success rate in the cover letter is f=
or
> > asynchronous NVMe, so it does not tell us how often this particular rac=
e
> > occurs with synchronous completion.
> >
> > More generally, I'd like the reference ownership across
> > __swap_writepage(), folio_end_writeback(), and the deferred worker to b=
e
> > made explicit.  If the caller's reference can overlap with the worker's
> > reference, I'd also like to understand whether that is an intentional
> > and acceptable trade-off, or whether the overlap can be avoided without
> > reintroducing the synchronous-I/O special case that v3 is trying to
> > remove.
>
> I need to look into the patchset that Matthew and Barry pointed to and
> check if it's still relevant with this patchset on top of it. If so,
> I'll add a debug counter to confirm we don't fall back too much for
> sync devices :)
>

A debug counter for sync devices would be useful to quantify how often
 the fallback actually happens.
I'll also take a look at the patchset Matthew and Barry pointed to.

Thanks,
 Kunwu


> Thanks for your comment!
>
> Alex
>
> >
> > Thanks,
> > KunWu
> >
