Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A03D3CCFD9
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 15:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774018827; cv=pass; b=sifxYqmg0TrP+rPIy6oTvWoZNNAVXTugkMF1vtqEReQzggsDw+g4iKILVUEpPAH8romyQsV9r2M1JOXh4lyisRt5edQBB+CkW0BUB+xI9IPZRDdSFm3XLE+vx3OWph1491eWy5OcBRmR0QfqRUTxBRP3spfGXWR1LMsEJrNdB0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774018827; c=relaxed/simple;
	bh=T//X4/fJkR1oeZd4ePkbHp1KaPM7ugaGmDaRiFm/0I4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=luOdNoYT0qYGqjXeZIK+LsObr6jiJLhR2IY2AWv+mkUZSdXsdixya7Afq+Id3+LByVC7UQclNVFL1FdUyHw2Mw8IbxEsvdc//lMzSR5TIyoYFpW0BXtR9cq4Fyu12VLRwM5DIVYc+hhHc4FYM55eZbptWfXr7HCLBmz/bjsyzCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmuAoPgU; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmuAoPgU"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-668d4751a3bso1142707a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 08:00:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774018819; cv=none;
        d=google.com; s=arc-20240605;
        b=RH1JqG0N7zxgYAVPQV5BWn3fAN4vBEkK540hQ7BItX0+jNblebXBW5pn7XLYy0wvOR
         BoB5AIut07LvS4NjGtXhZQMPbdvDU62N17tCpGvxfG7suD5b/o6zxtKfXQMT4xqlgJrc
         toc3LS+eTMjL7m8UbU700MsXyWHw/QGyVMobTvHf9/GEGnD74bdeK+r9FkJ8IXCvNnKu
         uAv/xn2SuLanIczvV2S+8dinSC0tTbzCBmWdPGW8jUefhSTcDfJ3+1zFWgtTQFj04yGn
         g75HW+WweQWDjYhvq56iVmDzcMWXAVZio+jU9rG122mV2kPLz1cac3nfCvxnntBCdX4u
         oqsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OqajqpvSgf8sKnTU17XNoO03H85xM7YFWH1WJ0jdhSk=;
        fh=mXQWYnKxyCVlmhi/2pyFIjS+sgZ4ZEoSu8IwofJD6ME=;
        b=E1mw6eUgcDmCTsnbeBnaZVh5lRAYvDCxYAjb8iku+rCttx+5HB9yEgJ8tfPuGL1jAL
         ry7aERAaHTDowkqyDBVaqZ2I0Rj0HCB8/ZcrjWc1kf9XYSn0tAMYRV2mDoKDIMcFxnUy
         6ODaeZ8SXIjpqZe21RYuLAwYoW1X8dNun3CBs1ucUnBN2tG0WaPuWx2qLaNuagVxMvk7
         9pkbt28Bu790pOgIqzsrbnrVoHIk7Fm+0FClJOCgSfsDLexQTi8SSiVfis9pT4YzpXDj
         n5reU0zI/QE3IFotJY5RKunzBMioWEeq9zUI6V0pG5Y6yxlTsERA7RSZ98z3J7L4n1nH
         RKnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774018819; x=1774623619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqajqpvSgf8sKnTU17XNoO03H85xM7YFWH1WJ0jdhSk=;
        b=mmuAoPgULmWN27L79KQerTt2XI6z6o+1HJ7U7xDNaKJHs9EY5ntm3Mc0taUMW5KMBI
         fgH16gnST+lXp0M3KHfF4K9+qBQfKbZbL6M5HjI4iOsO1TaLIng4bFXgN2IgkrUoX8Qs
         66Or8D5E9BCogc3gFzM/O9BdXpAgEMUMAGG/izJGU0QN7y0u/OufCMKpHDLsYQphMum/
         Bp6IbUkTwfCeqTDrcSgHNtbawuZuBcFT2vzeOKPN0e3lgjQy3Ar38bA7DEXdhF5acyu3
         0bd8ZUYkkTqNfknUBVCoFq/4FmfAokGJ5i3Az0AmYnUrSiOcVbeqyMvGGGFsh48t99ia
         ibMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774018819; x=1774623619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OqajqpvSgf8sKnTU17XNoO03H85xM7YFWH1WJ0jdhSk=;
        b=ECQHBEnX6jcPfh1L63nRhj276KQs0F72Io05eUviQiMjbC7ShUiwiJ12Aw/fB1KXTl
         iWfU2PUj1rcnPcrAhr6HsOzjQ+UKD8aNvi4ni42gFcEpzIl3Ec/3g5lv1DT+Ug2WhT4q
         kXRqCARBLpTC4/aJYISO4ZCRY6rEeiUP5j6qPA7BPv6dXxwZk/tDvyZCamN66bmTnqQH
         ss7koUBJLNl4f1d+wl0Ri1qj2BR0NVryPgjtMb18kvYvaTANvyjfe8gdIn9BIsR1dm+o
         4A2ofKDrjiY+c88Jksak4JeY2e1N9cRvowZkwASg9eqyrEDY2io49+BwTZaWKyOUcnVB
         lYDg==
X-Forwarded-Encrypted: i=1; AJvYcCWyscx9RODelDwEaQNtybH2IA3xIySMYgr9n4i2o2WcfEvi+ue2ULPnfHWA0FBUgRXfpk4p0qjCjtETul7s@vger.kernel.org
X-Gm-Message-State: AOJu0YyMmN4oNhnSDjEXvWxh0MB2JK4zG+pLoSXh9fmR6ykrz2Q8vRhM
	/1gNljw2iq5I5RE3nr4yDBPNJJLshppzEw7av/EX/269O+nm1Sd6JH7dg9Ec2mulZwjLe21738f
	cWf6BRRowg/mm+K49bvPLC+93QPl33bs=
X-Gm-Gg: ATEYQzyt0ckuhkxhYdsfYBgG553Lyqc1IoSE9OB2akTuKAiFpamdP9bztxTs4gh2nVl
	Ah6H+g93aLdTUWFElUE8e+GZXxvz+pybZnGgvajIKguSg54kCZK6GZRZmjeUGu25KUmyCuaGrd1
	+NjnrXy5RP2bMwAwEc1iKHaLfNDUq3WbYLIUv4Tjau28UWLgpmux2dhB9YHEByc/EaeZTbObnzI
	LuBeQpjIYWZRX896nGaPCLldeKrQwa6jD0ALnv0dHORXeb7/CjRuYbvgFeOD5k0y8uYUXwpS2Hb
	arMYnVgAqckBCFhkclGODqUPMU19MWqb9tJbJw==
X-Received: by 2002:a05:6402:278f:b0:668:50eb:bcb4 with SMTP id
 4fb4d7f45d1cf-668ca30bfdamr2648714a12.25.1774018818532; Fri, 20 Mar 2026
 08:00:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319025609.10721-1-liwang@kylinos.cn>
In-Reply-To: <20260319025609.10721-1-liwang@kylinos.cn>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 20 Mar 2026 11:00:05 -0400
X-Gm-Features: AaiRm51A69MYmUGOXnhjmFUpFf9waVwNEvtB-ds7Ig0pLeHbNnczwyxWNEa8KKc
Message-ID: <CAJSP0QXErw8yDeCnOgK6jco1-yDpS5x73vQLMtrj7oy7JxNEFg@mail.gmail.com>
Subject: Re: [PATCH] virtiofs: Verify that server properly follows FUSE protocol
To: Li Wang <liwang@kylinos.cn>
Cc: German Maglione <gmaglione@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 10:58=E2=80=AFPM Li Wang <liwang@kylinos.cn> wrote:
>
> Verify that server properly follows FUSE protocol, by checking
> oh.uniq and oh.len.
>
> Signed-off-by: Li Wang <liwang@kylinos.cn>
> ---
>  fs/fuse/virtio_fs.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)

Earlier patch series addressing this:
- https://lore.kernel.org/all/20251028200311.40372-1-brajeshpatil11@gmail.c=
om/
- https://lore.kernel.org/all/20260216073158.75151-1-ytohnuki@amazon.com/

The second one was applied and I think your version conflicts with it.

Please take a look and let us know whether you want to drop your patch
or send a v2 rebased on Miklos latest tree
(https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git).

Thanks,
Stefan

>
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 057e65b51b99..c30f6f58664c 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -768,10 +768,34 @@ static void virtio_fs_request_complete(struct fuse_=
req *req,
>         struct folio *folio;
>
>         /*
> -        * TODO verify that server properly follows FUSE protocol
> +        * Verify that server properly follows FUSE protocol
>          * (oh.uniq, oh.len)
>          */
>         args =3D req->args;
> +       if (test_bit(FR_ISREPLY, &req->flags)) {
> +               struct fuse_out_header *oh =3D &req->out.h;
> +
> +               if (unlikely(oh->unique !=3D req->in.h.unique)) {
> +                       pr_warn_ratelimited("virtio-fs: bad reply unique =
%llu (expected %llu)\n",
> +                                           oh->unique, req->in.h.unique)=
;
> +                       oh->error =3D -EIO;
> +                       oh->len =3D sizeof(*oh);
> +                       goto out;
> +               }
> +               unsigned int num_out =3D args->out_numargs - args->out_pa=
ges;
> +               unsigned int cap =3D sizeof(req->out.h);
> +
> +               cap +=3D fuse_len_args(num_out, args->out_args);
> +               if (args->out_pages)
> +                       cap +=3D args->out_args[args->out_numargs - 1].si=
ze;
> +               if (unlikely(oh->len < sizeof(*oh) || oh->len > cap)) {
> +                       pr_warn_ratelimited("virtio-fs: bad reply len %u =
(cap %u)\n",
> +                                           oh->len, cap);
> +                       oh->error =3D -EIO;
> +                       oh->len =3D sizeof(*oh);
> +                       goto out;
> +               }
> +       }
>         copy_args_from_argbuf(args, req);
>
>         if (args->out_pages && args->page_zeroing) {
> @@ -790,6 +814,7 @@ static void virtio_fs_request_complete(struct fuse_re=
q *req,
>                 }
>         }
>
> +out:
>         clear_bit(FR_SENT, &req->flags);
>
>         fuse_request_end(req);
> --
> 2.34.1
>
>
