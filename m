Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2E535DA67
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jun 2026 08:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781856791; cv=pass; b=l3GmX0+GpAxZVqxBmE9ndmtlxIhNVV9wzNVRRo4fAQZjycNRaoD576syyCQ7kBKpcD9BB33uFBsPL2QgkTpWVb6Y2mUzxfgp0/FTVAnQlYhgjc7sdky+ELypku5pkwYHMn3B7L09TTLgoTjE6dSBJDHUM17VkQJSC6Y1xlYveJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781856791; c=relaxed/simple;
	bh=bbwtfad5cn0MEp6KC4yj9vpW5t+MNRiToYYy2/vLbqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G9OzAqmtriy95Gy35NHCnEBVb97rI+fSIhlmBqhAGMqdQYo1gFpu+FT3jsnXarFxKJJHKRIVjvFNRJuqapMniyaByJx2DuVcjow6lNeY45FZlv+PO1uXNtNmBbWbnM1e3d7RGiAOIRT9auEYC+4xdpnSVB8BqZ0kxhNprW27fu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIYj0whU; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIYj0whU"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-695427c153fso2533479a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jun 2026 01:13:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781856788; cv=none;
        d=google.com; s=arc-20240605;
        b=FzXBa/zWLumANZFQFN9I0hdb3cVrr0OEIMAqw+5rFjiBU4GmCCnYsO6+EZqnkEA2XP
         bCjzBURG4ZG6JDMCfdZEdf4Sjqdpqk/tjrH9By27B0N2xgvosqaLKqvR5VURDfsqprX1
         OEr0T+K7/6nAFxCT234Yhh3dw0LnlvsrknB0GPPYUUIfiv+tmj55Hj9sDUxQ5RGWMrPZ
         0ct73k5Gixf7p3JeE+G4J+r1MUZbDFbg/+3MpT5UjxGcQnSo9laQvEoMVNqTyWVKzqym
         vc4XyZ9i/YFNJiKWHfJ3Pfs+0p43RFZfwUTjFCuK0dVSuoyLyb2QsOnA/8IqRgsdNEBp
         11wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=28hW1tkOzDweveawPLlld9OpZbweiBBXAKPJ+M7e1+w=;
        fh=nHK14hQmOQ97JkhSVtAMJnW6CBGTDLvQDU/cIho9i4Q=;
        b=X0bW3XYl8XJHbyImBjmPxrVP2iGTuNZUHtNkW5pIqQnUp0Y8XwMPf/+rzf0sIGSbWS
         gh3UQnNKs7G9VBTg6RqMq4+AfCIg0JuIrOeSLYCOZp1JO6oksj+jO91jTd4pERruDNLH
         xJLWh7ClTB8tCfecPpBovzJ28fb2cElvf269zQyxsetTXcS0MeYXAhuuHki66dPEmn1F
         dhG2OEsNpb8FdflN4V7EpRIMka/4JQsmofnR7gC31YaEf/ElPNVgAZ7vQaGpu/enlnTS
         COgRrkZGuyVWCIC0vCfxAGAq53DOk7fi+Kzs3NF6wdUCIvbxjmV19mRQTfZTjZh2NZ3Q
         SITQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781856788; x=1782461588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28hW1tkOzDweveawPLlld9OpZbweiBBXAKPJ+M7e1+w=;
        b=SIYj0whU/uzkLpKdbRLqudKXYwP9yJwQUM5mqi0MF2NHm9VNv4lP9i3ij2ZrccbvO3
         k7Zs9VAnC+pu9SQgBsb1oeqR/fRDtpx/N5oEzQGUT8rsWG3dDg0bjeZlYhaw7gknJjCn
         zX6KIY3EArJL7mI93fGRFRtZQZji9xFEf5eh0PfKvAGjodSiJzHzH/8DT5IaQvQrpY3b
         ohTDtEyzQ43QyxR7YJLsiyrFpWi80wMI3lOMY3tSBhfxg/iUEFpqyhQ1LnVxxWV/HhlX
         ppeV7yIL3X9UIwofTI0SI39jPrAlSg+pxGqOVMdteq+HxiojtLgjYdMux57GQ+Pejkm0
         GJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781856788; x=1782461588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=28hW1tkOzDweveawPLlld9OpZbweiBBXAKPJ+M7e1+w=;
        b=Gqrjf6stjoEo2fK6WJZEg7KK5x81jV8AD+BTq6Tq44wW1Qji18WQZL1h4BWhU6Rlod
         m5yyV6zFDr+XT2pBJw6GwXmjJNtP7SptzqKbTyCNduLHSVFw+bz2CjbvU95W5foU5/9X
         P445+hOGQyE+lJ679yqw3Azf/xowEFv1a9fGo5FnRTSLqh/KFZOZcNG5H53nQ3/wdZRs
         s8uG7EKVEPZ3Rib0lD8F136RUfZYRO/8Pb0A94/iJIBRK+hSbh7/08jNIqTdfds34dBm
         jAfEdmMx+wUubwPEhv9+wxLR4U2jBdg1RlUQO1/VhVGpemHIJRSVMYbtPolv3v2N91e2
         A+EA==
X-Forwarded-Encrypted: i=1; AFNElJ8EDQfAOo0VZ+pzL5nDoMW3jaIVo3Py77otJdN6GZcN5MYu6eMeu2dLfTnAcTKA0t9nKSB7e+ac/xOl3BBc@vger.kernel.org
X-Gm-Message-State: AOJu0YybAejZ93mqd7PwuIK8Upb4oFJfIVkeEWBScUT5h1VbGREdeopq
	Sxx1M4nC5j+0cHXOt1D8bROYkGQQS19cYo3TU6YI/msoo2uOTNMTQu+HqzxfUCIViGd69CDIMpD
	BttvwdaMX58KkqU6ZFihaMkEjKZi7I5E=
X-Gm-Gg: AfdE7ckP5nguttZp18PtxVkHJp4d+kCYVpujrGQASp4e/8b0kS2RWsa2+377NhRsGnE
	nZRLHesiN6bbDJiNBCNKqN4owUZfa+SH0Zu+v5HFZNH0XlgCL+i6EyUIfGvstbn32p4q/nxj93Y
	vfXcunAAod1Ik0zFssmSKDuC01CVsVrJGsxMEcg1I7HkZMsiW/HheR8TzUj4922q+o74vSwD3Bj
	2jP/uTu7/bpUDXHr6Jo56+eTnGSKviyvYmP6Fa8Q6EDHnlX/ttZgPoBKW5ZWZTIh61ufrF9L/mV
	SaTSzRe4TyFQPBXjzPpJPhMuM6Y+Ous=
X-Received: by 2002:a05:6402:3510:b0:697:6463:8329 with SMTP id
 4fb4d7f45d1cf-697646386b5mr325196a12.17.1781856788275; Fri, 19 Jun 2026
 01:13:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616231325.16788-1-russ.fellows@gmail.com> <20260616231325.16788-2-russ.fellows@gmail.com>
In-Reply-To: <20260616231325.16788-2-russ.fellows@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 19 Jun 2026 10:12:57 +0200
X-Gm-Features: AVVi8CeiFULsJHypLlaGSIHwy24ESWJ1NNu6qzJkLpvWJUeN6zLmsAgdkxZLb58
Message-ID: <CAOQ4uxgmMqtg5YrL=gXR=XB=y-yrG64rxm1c_3Gn3Gwj9bv8zw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] fuse: preserve FOPEN_PARALLEL_DIRECT_WRITES for
 passthrough opens
To: Russ Fellows <russ.fellows@gmail.com>
Cc: miklos@szeredi.hu, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 1:13=E2=80=AFAM Russ Fellows <russ.fellows@gmail.co=
m> wrote:
>
> fuse_file_io_open() clears FOPEN_PARALLEL_DIRECT_WRITES for any open
> that lacks FOPEN_DIRECT_IO.  That rule is too strict for passthrough
> opens, which already bypass the page cache through the backing file
> and do not need FOPEN_DIRECT_IO to guarantee direct-I/O semantics.
> Clearing the flag before the passthrough write path sees it prevents
> the kernel from ever taking the shared-lock path for passthrough writes.
>
> Introduce FOPEN_IOMODE helper macros to classify the effective I/O mode
> of an open file:
>
>   FOPEN_IOMODE_IS_CACHED(oflags)      - page-cache I/O (neither flag)
>   FOPEN_IOMODE_IS_DIRECT(oflags)      - DIRECT_IO is set
>   FOPEN_IOMODE_IS_PASSTHROUGH(oflags) - PASSTHROUGH only (no DIRECT_IO)
>
> Use FOPEN_IOMODE_IS_CACHED to express the PARALLEL_DIRECT_WRITES guard
> cleanly: the flag is only suppressed for cached iomode, not for passthrou=
gh
> or direct-IO mode.
>
> This is a prerequisite for passthrough write parallelism; without it the
> shared-lock path in the subsequent patch never activates.
>
> Signed-off-by: Russ Fellows <russ.fellows@gmail.com>
> ---
>  fs/fuse/iomode.c | 30 +++++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
> index c99e285f3..46e60b04c 100644
> --- a/fs/fuse/iomode.c
> +++ b/fs/fuse/iomode.c
> @@ -165,6 +165,23 @@ static void fuse_file_uncached_io_release(struct fus=
e_file *ff,
>         (FOPEN_PASSTHROUGH | FOPEN_DIRECT_IO | FOPEN_PARALLEL_DIRECT_WRIT=
ES | \
>          FOPEN_NOFLUSH)
>
> +/*
> + * Helpers to classify the effective I/O mode of an open file.
> + *
> + * FOPEN_IOMODE()         - extract the mode-relevant bits
> + * FOPEN_IOMODE_IS_CACHED - neither DIRECT_IO nor PASSTHROUGH: page-cach=
e I/O
> + * FOPEN_IOMODE_IS_DIRECT - DIRECT_IO is set (may also have PASSTHROUGH)
> + * FOPEN_IOMODE_IS_PASSTHROUGH - PASSTHROUGH only, without DIRECT_IO
> + */
> +#define FOPEN_IOMODE(oflags) \
> +       ((oflags) & (FOPEN_DIRECT_IO | FOPEN_PASSTHROUGH))
> +#define FOPEN_IOMODE_IS_CACHED(oflags) \
> +       (FOPEN_IOMODE(oflags) =3D=3D 0)
> +#define FOPEN_IOMODE_IS_DIRECT(oflags) \
> +       (FOPEN_IOMODE(oflags) & FOPEN_DIRECT_IO)
> +#define FOPEN_IOMODE_IS_PASSTHROUGH(oflags) \
> +       (FOPEN_IOMODE(oflags) =3D=3D FOPEN_PASSTHROUGH)
> +


Sorry, mad bad I gave you wrong code samples.
The open iomode is not about how the io is performed direct/passthrough
but it is about the state ff->iomode, so the FOPEN_IOMODE_IS_DIRECT()
is misleading and it does not make the patch simpler which was the intentio=
n.
Better loose all except FOPEN_IOMODE_CACHED() to avoid ambiguity.

>  static int fuse_file_passthrough_open(struct inode *inode, struct file *=
file)
>  {
>         struct fuse_file *ff =3D file->private_data;
> @@ -216,9 +233,11 @@ int fuse_file_io_open(struct file *file, struct inod=
e *inode)
>                 goto fail;
>
>         /*
> -        * FOPEN_PARALLEL_DIRECT_WRITES requires FOPEN_DIRECT_IO.
> +        * FOPEN_PARALLEL_DIRECT_WRITES is not supported with cached iomo=
de.
> +        * Passthrough and direct-IO both bypass the page cache, so both =
are
> +        * eligible to enable parallel direct writes.
>          */
> -       if (!(ff->open_flags & FOPEN_DIRECT_IO))
> +       if (FOPEN_IOMODE_IS_CACHED(ff->open_flags))
>                 ff->open_flags &=3D ~FOPEN_PARALLEL_DIRECT_WRITES;
>
>         /*
> @@ -228,8 +247,13 @@ int fuse_file_io_open(struct file *file, struct inod=
e *inode)
>          * Note that if user opens a file open with O_DIRECT, but server =
did
>          * not specify FOPEN_DIRECT_IO, a later fcntl() could remove O_DI=
RECT,
>          * so we put the inode in caching mode to prevent parallel dio.

Merge this "Note" into the comment above about FOPEN_PARALLEL_DIRECT_WRITES=
.
It is out of context here.

> +        *
> +        * Pure direct-IO (DIRECT_IO without PASSTHROUGH) needs no page-c=
ache
> +        * iomode machinery =E2=80=94 return early.  When DIRECT_IO and P=
ASSTHROUGH are
> +        * both set, write_iter uses the direct-IO path but the backing f=
ile
> +        * still needs to be opened below.

Loose this text, code is self explanatory

>          */
> -       if ((ff->open_flags & FOPEN_DIRECT_IO) &&
> +       if (FOPEN_IOMODE_IS_DIRECT(ff->open_flags) &&
>             !(ff->open_flags & FOPEN_PASSTHROUGH))
>                 return 0;

Sigh, this function is a mess, see my untested patch below to make it simpl=
er

Thanks,
Amir.


--- a/fs/fuse/iomode.c
+++ b/fs/fuse/iomode.c
@@ -192,12 +192,18 @@ static int fuse_file_passthrough_open(struct
inode *inode, struct file *file)
        return err;
 }

+/* Fuse uses page cache if no passthrough nor direct_io open specified */
+#define FOPEN_IOMODE(oflags) \
+       ((oflags) & (FOPEN_DIRECT_IO | FOPEN_PASSTHROUGH))
+#define FOPEN_IOMODE_CACHED(oflags) \
+       (FOPEN_IOMODE(oflags) =3D=3D 0)
+
 /* Request access to submit new io to inode via open file */
 int fuse_file_io_open(struct file *file, struct inode *inode)
 {
        struct fuse_file *ff =3D file->private_data;
        struct fuse_inode *fi =3D get_fuse_inode(inode);
-       int err;
+       int err =3D 0;

        /*
         * io modes are not relevant with DAX and with server that does not
@@ -216,25 +222,20 @@ int fuse_file_io_open(struct file *file, struct
inode *inode)

        /*
         * FOPEN_PARALLEL_DIRECT_WRITES requires FOPEN_DIRECT_IO.
+        * Note that if user opens a file open with O_DIRECT, but server di=
d
+        * not specify FOPEN_DIRECT_IO, a later fcntl() could remove O_DIRE=
CT,
+        * so we put the inode in caching mode to prevent parallel dio.
         */
-       if (!(ff->open_flags & FOPEN_DIRECT_IO))
+       if (FOPEN_IOMODE_CACHED(ff->open_flags))
                ff->open_flags &=3D ~FOPEN_PARALLEL_DIRECT_WRITES;

        /*
         * First passthrough file open denies caching inode io mode.
         * First caching file open enters caching inode io mode.
-        *
-        * Note that if user opens a file open with O_DIRECT, but server di=
d
-        * not specify FOPEN_DIRECT_IO, a later fcntl() could remove O_DIRE=
CT,
-        * so we put the inode in caching mode to prevent parallel dio.
         */
-       if ((ff->open_flags & FOPEN_DIRECT_IO) &&
-           !(ff->open_flags & FOPEN_PASSTHROUGH))
-               return 0;
-
        if (ff->open_flags & FOPEN_PASSTHROUGH)
                err =3D fuse_file_passthrough_open(inode, file);
-       else
+       else if (FOPEN_IOMODE_CACHED(ff->open_flags))
                err =3D fuse_file_cached_io_open(inode, ff);
        if (err)
                goto fail;
