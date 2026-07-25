Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244F51A6812
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2026 02:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784945021; cv=pass; b=GV9UuHf/voyHdXM5Lkps+z4L6gEhA8FBP9JHTVyBh0H2BBrgz3rhre8spQjUhrWyW07VwFx0lbYKrVpGmd9DhInBVY4jaX0yEeulnnpUXDXc/4UBAYrlLtoFcml3fKs8a6Uzw2pRgpZRNmibqUMXi3CFU6NNIu/BVtaJ5IgTf/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784945021; c=relaxed/simple;
	bh=V7GOH5C4+1DTcmNxi1wdCRV0V1K1Gn/8pkL9PttbCHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mcueqyt/QJnTUl+uU9peiSeRTxJHprXLnpOsfnX0758hUE8soaHDsiy9p00JHUgcX4T3V0lL2us866fwWtietBbOn8Spv3UeOuiS8dodM8HFxz8v7Y6DF4h1hlRyH03ktLgEV1GN0oyJlNE3vUhe8Oo6deaVHoUbPZz6EaT12S8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IuCkiIrX; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IuCkiIrX"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-66896892b6cso926276d50.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 19:03:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784945019; cv=none;
        d=google.com; s=arc-20260327;
        b=pyhiNrq364cy4V9pmc7q7KPIlpAb6yF6suWzMlG2ayP1Efvcm0KHxXtIxqoQr/nfoM
         6XLtaybjb+WjngyXOCncoJ+jUfRswUKdtrnrR/WATZXxXawhGRp5bNsbEF3rPrnSHiIC
         AVDLYSC+M0k0bLmlc7RrPZJHxzEeMj7u/OV5tQYkDQGV8pEAWGRldtI1ALvwA1+wvgQM
         1JGB0GIuvkOyOmEv/Pfke80pfKWklL5S4pZs0JZyXN7KyghDYCFgtQgxoAJIM4IUUnXT
         RkWSTNEIUkjzL4Yd+sUstYhk/cDaLgO0Nq0lE1r2b2Gx8F9tjHMrZQRWVFgFQ/alBNwc
         /q+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SC2+17GkjZ69cx9PrkeOnmndcAz/zR/Mdyod+HkB8jI=;
        fh=4HyRQ7rRgivcul5oyfujo0zrQwX8E0uYoX1fig+OFco=;
        b=H5HDUs1vLekQID1gwAIGASh8w+Z/GplrGPE1pH/gtm4H8gq9Ioh9GBsqYwtsCJedjm
         WedWX2c1RmQFDPugSoJzZsHFMX5/17xc3DqqGNyNujorjP09yk9iw95aYWYIT3MRaxVl
         dJNJ3cN2YUR8CG8WEUS8+gX/piBY5+vwBzRJzjXDF81dFfSvkM2Npkj572MIGSrPg1D3
         k01dc1d1D/DCgiQKcJxiMnRf5wS4jyx4fL5QWrNsESrZfA9/7/8fdysX/5X0KZllYFas
         z2DkVJZDR/mGqoB73W1smFqPLkCXKDh5O+be868ql7T6HYUDQWK4NUHjZpVm4fP91V01
         wRbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784945019; x=1785549819; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SC2+17GkjZ69cx9PrkeOnmndcAz/zR/Mdyod+HkB8jI=;
        b=IuCkiIrXE746vQCDY4QV8Qv2M2LAs/g8hDXD/8/NIWZSGRAVrhk+kuNPwFq23jvLsu
         2Jtx30Ht4UUEMq2g6POXv5W0vT2JUex7r6SC+m/XSRpDJMi3WrnLD9fOKZ2MhOUBsjZD
         wVQoBeB6IzT1rEgHHdtxDgL0FxP54ppZN1vdXlaE/VuywI2fLCKT0XEMJbFe/z0PtfNJ
         YKjqkScDJr+EAjKqcy98J0GF65/KwCUEpOXDXRv7lcpLFduI/Hx5hn/o9LdfczMdMd0k
         pLyF0U33hfwsqRRLL3EBRhXKtUwXvn96uMmp4p5Vy7ox3oJ41WI8NgSMr7EqbVmQX1bo
         9H0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784945019; x=1785549819;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SC2+17GkjZ69cx9PrkeOnmndcAz/zR/Mdyod+HkB8jI=;
        b=b8On6PsL9IRbzgeTBIvMXE4YtXQRSJnhyol2R4UhsRVv9N0Lfkp3rlv+1Xcy5NSdmp
         GB/Fmv3sLnYkbKAl+c7iQNZKpJomFzOjtuzEEt62qQdjyd9CE84i3tdMhSx1IMZ8iFlz
         xit/xeZBkFgHeLLpHLi1lwt3l4onSjd1kdfCVOwG2dvLwu/C98+U1hB59b1DzJ5EeBEb
         bz9AehutJWElBLvHvqVA1w/3tikGyAGjUGYMLkSVKfyfT4uKCxgzFvQTCCoGFSikLbAT
         NlUxNkQW7K/5sEKygK/zDDUhyP2mgaMUQZyhxoYXbGTKpUxLccRUQUmtXGGLsrKvgxSW
         Ammg==
X-Gm-Message-State: AOJu0YyM/CFy1qlRvq+EkUHmyLNqmJh8dOsQHY8/AjBrYyEONImOVoD+
	2jqSjcoYrj1wNjq0sEUl4KXuE/FjCv5zTDhfPYv/7RM7NnNLi3h8yi5Gn6jtoJ6wZSbQIFsuHxO
	xOYOFWHeBFbLNfyn8La7C52kdENEcniI=
X-Gm-Gg: AR+sD10wVU/ikzIv85ZjQ13MAg32wkMSHshNhUnVU7yN39Zd9/lNH8ICAuW1f3K+LMU
	hKxoCcsR/LXUfLtlqVoEU5T5xuCGh6q3LEBgqhaE+MUYbOcfMSL7mwfNXbRpxSw5a4VV7Z5vCE1
	MLwgFxbrDm/rSzKYujpW2UTfTTMIQPkFkxO1rmctPYN4svhNplvZfJ0V3XKjqr+aVIcMB2sEOzS
	HLhpCxgf+7cIND0uXVtWP8PoNNvCP9S1oeaJgv6JoT/g0NVRNPUsSmoGUfwmAonCjt4Ofylwg9t
	jq11ei1qThuVKwLNJzlaTFO97WdEl/YZettCueiGUCdDsBVAu9NH
X-Received: by 2002:a53:af82:0:b0:667:bbca:5112 with SMTP id
 956f58d0204a3-668c7b8cea8mr124371d50.78.1784945018980; Fri, 24 Jul 2026
 19:03:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529131242.89876-1-kartikey406@gmail.com>
In-Reply-To: <20260529131242.89876-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Sat, 25 Jul 2026 07:33:27 +0530
X-Gm-Features: AUfX_mw0bSbxNXbJt9-HzX7_4xMbHqAtLpGXDGdmQ-WxvwqUtgP2madPt_gk6JU
Message-ID: <CADhLXY5gkkXEdx5-i75zSM2n=mRiOAPDmUWn-cJuMrm=VJpdTA@mail.gmail.com>
Subject: Re: [PATCH v3] eventpoll: fix use-after-free in clear_tfile_check_list()
To: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+69a3d7738ad3aa175caf@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 6:42=E2=80=AFPM Deepanshu Kartikey
<kartikey406@gmail.com> wrote:
>
> syzbot reports a slab-use-after-free read in clear_tfile_check_list()
> during EPOLL_CTL_ADD when ep_insert() takes an error path that calls
> ep_remove() before do_epoll_ctl_file() drains ctx->tfile_check_list.
>
> ep_remove_file() decides whether to kmem_cache_free() a struct
> epitems_head by testing v->next =3D=3D NULL, on the convention that NULL
> means "this head is not linked on any check list". list_file() pushes
> a head onto ctx->tfile_check_list by storing the previous list head
> into head->next; when the list is empty that store is NULL, so the
> head that ends up at the tail of the check list also has next =3D=3D NULL=
.
> ep_remove_file() then misreads the tail as "not linked" and frees it.
> clear_tfile_check_list() later walks the list and dereferences
> head->next on the freed object:
>
>   BUG: KASAN: slab-use-after-free in
>        clear_tfile_check_list+0x114/0x380 fs/eventpoll.c:2443
>   Allocated by task 5985:
>     ep_attach_file fs/eventpoll.c:1751 [inline]
>     ep_register_epitem fs/eventpoll.c:1833 [inline]
>     ep_insert+0x512/0x1820 fs/eventpoll.c:1876
>   Freed by task 5985:
>     ep_remove+0x155/0x2a0 fs/eventpoll.c:1135
>     ep_insert+0x1372/0x1820
>
> Terminate ctx->tfile_check_list with EP_UNACTIVE_PTR (the existing
> non-NULL sentinel used elsewhere in this file for inactive list
> slots) so that next =3D=3D NULL unambiguously means "not on any check
> list". list_file() stores the sentinel when the list is empty,
> reverse_path_check() and clear_tfile_check_list() stop the walk on
> the sentinel, and do_epoll_ctl_file() seeds ctx->tfile_check_list
> with it. The guard in ep_remove_file() then correctly refuses to
> free a head while it remains on the check list.
>
> Reported-by: syzbot+69a3d7738ad3aa175caf@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D69a3d7738ad3aa175caf
> Link: https://lore.kernel.org/all/20260523091107.61880-1-kartikey406@gmai=
l.com/T/ [v1]
> Link: https://lore.kernel.org/all/20260529042507.87593-1-kartikey406@gmai=
l.com/T/ [v2]
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
> v3: Drop the (struct epitems_head *) casts on EP_UNACTIVE_PTR.
>     void * converts implicitly to typed pointers in C; the casts
>     were noise.
> v2: Reuse the existing EP_UNACTIVE_PTR sentinel instead of adding a
>     new EP_TFILE_LIST_END define, per review feedback.
> ---
>  fs/eventpoll.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index a569e98d4a99..1756c5f489a0 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -472,7 +472,13 @@ static void list_file(struct file *file, struct ep_c=
tl_ctx *ctx)
>
>         head =3D container_of(file->f_ep, struct epitems_head, epitems);
>         if (!head->next) {
> -               head->next =3D ctx->tfile_check_list;
> +               /*
> +                * Terminate the check list with EP_UNACTIVE_PTR (non-NUL=
L)
> +                * so that head->next =3D=3D NULL unambiguously means "no=
t on
> +                * any check list". ep_remove_file() relies on that
> +                * invariant to decide whether the head is safe to free.
> +                */
> +               head->next =3D ctx->tfile_check_list ? : EP_UNACTIVE_PTR;
>                 ctx->tfile_check_list =3D head;
>         }
>  }
> @@ -1685,7 +1691,7 @@ static int reverse_path_check(struct ep_ctl_ctx *ct=
x)
>  {
>         struct epitems_head *p;
>
> -       for (p =3D ctx->tfile_check_list; p; p =3D p->next) {
> +       for (p =3D ctx->tfile_check_list; p !=3D EP_UNACTIVE_PTR; p =3D p=
->next) {
>                 int error;
>                 path_count_init(ctx);
>                 rcu_read_lock();
> @@ -2438,11 +2444,12 @@ static int ep_loop_check(struct ep_ctl_ctx *ctx, =
struct eventpoll *ep,
>  static void clear_tfile_check_list(struct ep_ctl_ctx *ctx)
>  {
>         rcu_read_lock();
> -       while (ctx->tfile_check_list) {
> +       while (ctx->tfile_check_list !=3D EP_UNACTIVE_PTR) {
>                 struct epitems_head *head =3D ctx->tfile_check_list;
>                 ctx->tfile_check_list =3D head->next;
>                 unlist_file(head);
>         }
> +       ctx->tfile_check_list =3D EP_UNACTIVE_PTR;
>         rcu_read_unlock();
>  }
>
> @@ -2601,7 +2608,7 @@ int do_epoll_ctl_file(struct file *f, int op, struc=
t epoll_key *tf,
>         int full_check;
>         struct eventpoll *ep;
>         struct epitem *epi;
> -       struct ep_ctl_ctx ctx =3D { };
> +       struct ep_ctl_ctx ctx =3D { .tfile_check_list =3D EP_UNACTIVE_PTR=
 };
>
>         /* The target file descriptor must support poll */
>         if (!file_can_poll(tf->file))
> --
> 2.43.0
>

Hi Christian,

Gentle reminder on this patch. Please let me know if anything else
needed from my side

Thanks

Deepanshu
