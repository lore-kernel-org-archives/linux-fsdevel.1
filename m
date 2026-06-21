Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8577E2517AC
	for <linux-fsdevel@vger.kernel.org>; Sun, 21 Jun 2026 08:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782029771; cv=pass; b=Lm16bt/Ig/umnwsvs2Rbzj+bUXHrNoJr0Upr+j1UotGc8HMBrr8Dt1x46ouYiUCf7FoClq0j44hUKqQL2xzraj0RzxOeLGlX8PLHFzjz9ryux/uXeg4Lg3XgilYyyyf/aOSOgX4LU5mHSGg6fTpsK0j3ojrv3H3Y0vg3g/EQq3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782029771; c=relaxed/simple;
	bh=V7GOH5C4+1DTcmNxi1wdCRV0V1K1Gn/8pkL9PttbCHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nHXBGVHsChFY7lHyGd7CQXDjlFCKtpFdFTmhtXEqVI0NNYBCJ2KZLmNWK5HXm3VTXQlTM8AfXtDvNQgvwCwQtYoeoP/4xtphlMUJl0gtemktET56XjKyKIvnEUIYM3LSKBGGbEGRMtfh4VdS7OvAmp8pYuIT7UyXosnrLlwn0hQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHepuZ5k; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHepuZ5k"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-663271f8694so378983d50.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Jun 2026 01:16:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782029769; cv=none;
        d=google.com; s=arc-20240605;
        b=jI3Zn3fwYoheSitK8f/I8gW0GfUm5hqf8qfiRaC8jjhoYRQ2cKxIUizOn3yrNz3jyp
         Am5pQQbB09blVKizRVTCjt5SmMgm7haeNsF0H8UcEG7JxIdYZK9R5DH1Df5SXfsTjqme
         ojTqMxpsYOTfP41bcE+6ns9FaRLsD/jtbFvEmaLo+l4jIH6Vh/dR6QpzIAGrLm+t4UTf
         9W6sRkfwJJCHw+rdwIKyTxf5iNe9oaSt/M7ZbVJMKY6sDj4jvHVfh61pE818bZqexABt
         zdhW99NdUdyJHIzafdbzIxOm5ZvBa+uEcdDXTE4RVWJ2wdZ8/mEMy6ycNy+Mqyr83lrX
         0FTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SC2+17GkjZ69cx9PrkeOnmndcAz/zR/Mdyod+HkB8jI=;
        fh=4HyRQ7rRgivcul5oyfujo0zrQwX8E0uYoX1fig+OFco=;
        b=ZngIMfxSm8KFajxIHpsl4z2Uo1aFzx5LbmzVAsA/Q9eqetT+HlfCaWqF2igYYDHCH4
         JdRtgYSFyvpl8Wso6xhQkb/vkKwmhWVJS/P/VSqwJfjIlPRltEJV+GJMs2vsJGBWFbil
         OCsl5PzPLEMYin409ImX0MBl5bZqe1Upni1DllXT7dheNF6FR1kgfOBCVEYmdy/8z0V0
         3yowfNKYLdzoj+2D+YtRKtM+xmEuQT8qoCtvU/QPtgmsKiue0GNCdt8xq9NazEx98FGQ
         vBE0FYK3j2KIGy6UQt660BJs7sqZCAAT1c93PznCsu7o6deDeXn2p8P72mbzi0Hacjc2
         r8FQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782029769; x=1782634569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SC2+17GkjZ69cx9PrkeOnmndcAz/zR/Mdyod+HkB8jI=;
        b=aHepuZ5kvxq05tSU/Ku2BZF15U3cItkQlYSNNzETtj03pgSDbYhl7MCCCH2OABTaqC
         XBJaj9w6EVzq6xoUyeqmqk2Toj54GIWNUGmN/ZtqW7P8kHlfVj4tOTrN7v6CN47+KhPr
         abDwtyZAGsQqI+SVkk/X5sblXGv2YRAPE1W3P/IKOidF2PzZfrmzmT0S+ijUS/ghT7CC
         PGeyl4AHoxyAuQEl6UlB66vpd5hDbC5hOuOJAnZbTgUZw2vQQCFWe/a2sUjBPELuIYDK
         lf9dPsftruXRSlf1QYdtz9DYSv+/4QNtoFI+VxUDhNVhUYd6RpoH/ynxwPMqTqoizJwU
         zYCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782029769; x=1782634569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SC2+17GkjZ69cx9PrkeOnmndcAz/zR/Mdyod+HkB8jI=;
        b=o/cfOdh7zopFuhb6MNjiS4DYUmL11Jkz7Nzjf/0fM51xnhgipgTms8yaju9PddVAL2
         t8BRSmKdGCPTW0RdJK6SnIqgDYFKeU8ksUBUPfx5H3OUvfemdz6FGUQnL3/mo+G7NAsI
         RU0iaQrJItRKATCN3Vz/n5RrZzDQQj21/TEN3FUB7Kb/Bpk6qOEQ/YiOAz0Nz7exwFJ3
         ppl/CCd4IrIiLl0/jxAqJuPDs0xncLCepfI1KXCpjjGPsVwOFroz1C38Wf9LTr06Wq25
         wqJwd2VMcgC1c7TtxwWCtWtVNmQx29zDh8AhIoTSqauEpCj8/GVgKdBINUk1FEA6j4pj
         nzIA==
X-Gm-Message-State: AOJu0YwmilnG//2kAtfRNGJ8gW6IqQGMcoqv24yTGqptu1cYjNgiLZw1
	QRa0JY/0n+SJYWzg7I185rS5sgSWHSLtpmceo4ayuZANIS+LwpsAGzbK2vt3i4lRvoo4zGIZw5Q
	XPgT2UNNiZgPMwCRJSL2CSkiV1D7NcIA=
X-Gm-Gg: AfdE7ckAmJSKBUmw0F0eBwx76tfnpMT2eBb+50NupGu2bLlJ93DSc/2aYsZfncdiCQa
	iuUGv/pE5JrnOo9R9IPPxkfijwBUIsbxOCFI/w5cGNMsmSrFrZv05r0gkHnPehOA1qWo1XvkBSd
	bcz6kxld+WBzgbyb9ZPZOymrst4/eh52xHox+bP4v06pi3qjfK5Qj7kJxqe1gFFiJ+d/GUSJOm+
	DoR0PUhZiEMI64sgf/kXvNsfFapp9Mm3wvYmzg3CU3mXi+lHjI9J71d5VGe+/NrzGSY0kHgN9GU
	fXXI9dy5TZSTc30KCEwIVbBKQhnw3x9p7PAKXY9BEGJYLmxRy65ytn9tqCDnoQ==
X-Received: by 2002:a05:690e:b87:b0:651:b938:188b with SMTP id
 956f58d0204a3-662ffcec93amr9144541d50.24.1782029769493; Sun, 21 Jun 2026
 01:16:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529131242.89876-1-kartikey406@gmail.com>
In-Reply-To: <20260529131242.89876-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Sun, 21 Jun 2026 13:45:57 +0530
X-Gm-Features: AVVi8Cdiq2G_AX7XITiCC0IRk63_uoLegTs-RUgojpMXeVhGATANChA5FTtwWeM
Message-ID: <CADhLXY6NYbjE9FS3fVmQQC-0b_HcmUh0QzX4=LRUVP-T9PV0dQ@mail.gmail.com>
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
