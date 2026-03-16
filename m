Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B6A343D75
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 18:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773686905; cv=pass; b=IK1ZEe8wWen/dNPDiL1LO75FIEdt1QwF4Ww/G5wmJZX5Okcc3jnPsS8kyGdZBgARayJJp5PoGXJy9XOzwgy6qNRD6Ae39/qa2qxEfmcVAbAtG8f47hNW+hchAkQ6HqzLi1An05antZ3LINpZ52hrK4pQyR//jH6uNbT7KADqYzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773686905; c=relaxed/simple;
	bh=UvWF57nXqI9vHHj3agvW/9JVTqcg20vwpy6Zqyd76bk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VNs7EI1nqhEdvv/8wxlY+8mlletyDTds0kv0pvYNIeSNy6Wyed289WqRE7utu+YYvmTiF8ZEDLHjDwprt00cturwTw4BKpWm8fVsQO0aZpi6FwFkCfohk3ZtSefMmZYUw0LHFR04BImyQorbGi6PmO2aWqJRqPMmHvZNgnixelk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6jycxPW; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6jycxPW"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43b3f91a7abso1055422f8f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 11:48:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773686901; cv=none;
        d=google.com; s=arc-20240605;
        b=NsJ/Vs+Tz+IpgLAWBI5LLVOtJCDZ34DaR8FbMovjUrGI03UQ9A+erEguJMUTr+r9nH
         gyoSAoF44tRofy11/+dBLnCqOR5I5cF0LiLFochNY5lBt8gd1cxVZozl/CUMtqyjyw29
         jSs/JbLHokY5MklWYao2t3hIV6affkNaF2dVD6cirBcWV0RfU5uF/qYKVqlixfVhBRR4
         Hvi0udLNK/cfvqXurn3dHheA1M5N+hJhMAmrxlgz0gSaMFeVEgwZVuo/jsnoJgsrS59D
         ZwfZccp6Vynhb0iLG5EyY51pdZZqOhRuWLXxdUxRsBQ9sHeiIWptk7CS/Tx6sa6ySwak
         2+3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DBjVV457G/se68523LSZtd2ILvGUaX28G26qIIbHCwU=;
        fh=XoOwDRqoehrGQqMvrPFwE6xmw24w8FZm90bJkFIl/1Y=;
        b=f9eE2Ev4x1wAk9HbIQskSkYRTyIvpzlsXyKB9P8iKHS0NgDXm59x1l3BrQPeka+X2E
         YGsw8azni1eTg0g6jyvmIjZFVFuDpE3/Oc9NcMAy0/cpzevPBh+SC9bvfkiHw+TdheFw
         U46fIwj114sXhVw1BT0JRetLwfZxWa5x01KaGfjLh0s6uV/GUFETQo1fY07/pEXnJVUA
         7DAJFP/zv1bxlLmb49jlFIm6/8i0gfnHemeCZPV580Ep8hIQFdBT2N0amhEorKjwbATp
         4UCrUgGHHtgLcxdKYrZC+lFZM2tF4EbFwDzijEowbOPRDKyrIgukoWalGvPBcL9BbLWC
         mg9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773686901; x=1774291701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBjVV457G/se68523LSZtd2ILvGUaX28G26qIIbHCwU=;
        b=m6jycxPWJ6wAimrQuV+R2rgpF6jgeDWP9EFYimZEZxzR264avQErYcND3XyRRwiBjh
         8fnrMYq0oe958ygQ71Y9CYC5uRxaR41A03wX6P1U+ppIKWqLB6lZfaDodvKjC4YMIO/r
         tOdb57w991xgNE1eTb6zygqFp0fV2s3PcEw8ddXgol+KCdXddb9of8mpOvtdNm9/1uIX
         1p1/ZVFMCDA/hu4Rmmc01hQdJWdQcqjshXpchlKYv9fD6ngkCYw1B/g3MHQVkSqMzN58
         FbNOpFoZM11UYXEPZF+h0gDc50EzAS8oi6231xJL2OO/0+CBM11y9uDPbzU0wYnsr+1m
         FKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773686901; x=1774291701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DBjVV457G/se68523LSZtd2ILvGUaX28G26qIIbHCwU=;
        b=LLXjmTWFL675xkx1Z2YJaZWb4om3LlWfBhRUS2HEu5pVgvwg7ezM5cuKAZfOG807z9
         XLTX6ba8TSUhSY5wL0CPlVtGMayM52cp8Zduti+6S+oZ2k+l1JDzEQOGgN4M6ekfwpGQ
         fqtl42HN1wdYp3t1Hnas+olibnL/EEhxAMxepE5dxrE1rd+188OuW5VYsswYKznnikBx
         LwNla9safHg0ygcXV34Wah9873SNAQfuZRJuqYn0y1r1mZmYEORIT86T9iyu9UmESciI
         xZvi+ivQ4f0pJ5hbSfbLwJ/pY0wnYCegt3j5LE8eMUbj3TGPloHg3zgx1xzj7bjGMInf
         RX2g==
X-Gm-Message-State: AOJu0YyQ+DlmGHQxaq4eFm+zXIm+QRxkGOlusAChtAmWR8BRx9KmQfpc
	U3tWjHa4XNPOVXJoyjt3pnA7iKRIJ9+yC/vFshlYtLA9qvoO3yq/6e/IYFL+8tgdDo19koKFtPB
	L347rNAHjrSEaucX1u4XP10JLGd0E/L5lgaXIQYo=
X-Gm-Gg: ATEYQzz01mc9Fi0jk0ug5e1p7JdZrlEtQh/hmVSWuYc0fe3bb2234o7Hie+tpOlNQs8
	5N6wYD9K1xgJIsB4Ibkq9PMjWCkqqkg3kn7Va+jCaeynOuIn7iNxtUoAWp9CfrigfNeGBSo6kiR
	FQdWVnJpQ5hOQhf4kuTfzJDWOidmwAExLSw+CJo+ZGLvXRe1stgrYvvwUMByBgaeQFrQp0UD4tZ
	SpO9mBoLry+Y83ciAmciI3sPFDn3q0o82Gcrhj9KKqlkSNqf3m6+wAdgXsZaO9xT03gmgiDEqcM
	kTpK1w==
X-Received: by 2002:a05:6000:4310:b0:43b:492c:8349 with SMTP id
 ffacd0b85a97d-43b492c8602mr2857424f8f.3.1773686900933; Mon, 16 Mar 2026
 11:48:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316165320.3245526-1-mszeredi@redhat.com> <20260316165320.3245526-2-mszeredi@redhat.com>
In-Reply-To: <20260316165320.3245526-2-mszeredi@redhat.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 16 Mar 2026 11:48:09 -0700
X-Gm-Features: AaiRm52ozqBHON4mjfX3OgUHvOecBGZhPeVdde2955BrAmJ9byyH-P5BG2hpsWc
Message-ID: <CAJnrk1ZCLS4BhGJm7y4HC07tvAL-KHeU_B-0ep_1r9kaaf1Lnw@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] fuse: abort on fatal signal during sync init
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Bernd Schubert <bernd@bsbernd.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 9:53=E2=80=AFAM Miklos Szeredi <mszeredi@redhat.com=
> wrote:
>
> When sync init is used and the server exits for some reason (error, crash=
)
> while processing FUSE_INIT, the filesystem creation will hang.  The reaso=
n
> is that while all other threads will exit, the mounting thread (or proces=
s)
> will keep the device fd open, which will prevent an abort from happening.
>
> This is a regression from the async mount case, where the mount was done
> first, and the FUSE_INIT processing afterwards, in which case there's no
> such recursive syscall keeping the fd open.
>
> Fixes: dfb84c330794 ("fuse: allow synchronous FUSE_INIT")
> Cc: stable@vger.kernel.org # v6.18
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

LGTM but left a comment below

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

> ---
>  fs/fuse/dev.c    | 6 +++++-
>  fs/fuse/fuse_i.h | 1 +
>  fs/fuse/inode.c  | 1 +
>  3 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 2c16b94357d5..f0631c48abef 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -576,6 +576,9 @@ static void request_wait_answer(struct fuse_req *req)
>                         removed =3D fuse_remove_pending_req(req, &fiq->lo=
ck);
>                 if (removed)
>                         return;
> +
> +               if (req->args->abort_on_kill)
> +                       fuse_abort_conn(fc);

Maybe more straightforward to move this logic a few lines above? eg

@@ -570,6 +570,11 @@ static void request_wait_answer(struct fuse_req *req)
                /* Only fatal signals may interrupt this */
                err =3D wait_event_killable(req->waitq,
                                        test_bit(FR_FINISHED, &req->flags))=
;
                if (!err)
                        return;

+               if (req->args->abort_on_kill) {
+                       fuse_abort_conn(fc);
+                       return;
+               }

Thanks,
Joanne

>         }
>
>         /*
> @@ -676,7 +679,8 @@ ssize_t __fuse_simple_request(struct mnt_idmap *idmap=
,
>                         fuse_force_creds(req);
>
>                 __set_bit(FR_WAITING, &req->flags);
> -               __set_bit(FR_FORCE, &req->flags);
> +               if (!args->abort_on_kill)
> +                       __set_bit(FR_FORCE, &req->flags);
>         } else {
>                 WARN_ON(args->nocreds);
>                 req =3D fuse_get_req(idmap, fm, false);
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 7f16049387d1..23a241f18623 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -345,6 +345,7 @@ struct fuse_args {
>         bool is_ext:1;
>         bool is_pinned:1;
>         bool invalidate_vmap:1;
> +       bool abort_on_kill:1;
>         struct fuse_in_arg in_args[4];
>         struct fuse_arg out_args[2];
>         void (*end)(struct fuse_mount *fm, struct fuse_args *args, int er=
ror);
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index e57b8af06be9..84f78fb89d35 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1551,6 +1551,7 @@ int fuse_send_init(struct fuse_mount *fm)
>         int err;
>
>         if (fm->fc->sync_init) {
> +               ia->args.abort_on_kill =3D true;
>                 err =3D fuse_simple_request(fm, &ia->args);
>                 /* Ignore size of init reply */
>                 if (err > 0)
> --
> 2.53.0
>
>
