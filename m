Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3988428838
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 11:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781608026; cv=pass; b=MZIM8LhyBYSiDQBlcJ58T7AvEikMtx+VuPcuDEwhELHFKH+DjbiQDeHg2lQzTwOTTegPx0EsBYRReK5rRkotm37Jstjl13JlSRcU54Hvw66dCQmoHQmDBUCtog3+vp6nw6N1lMJeyfgPeO+GdX+JRjAwxoLcTu41uCJ33+iljXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781608026; c=relaxed/simple;
	bh=UKgvFqDQMLtLEF6PZjpH7+zKeHvR6wY1BelpszDmhso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eLZ1y844JLkHbc0hn03BsWihI5aVvNq6YBzLh8NoPqsW+VAcRe9Tk0qMf97Ny3093obqsfKtaMD4IbJEP1ISfRgVNgeifYz1pYM9SoHXGokp0cswIFlpLrDkv1C3qn4ps7do1QbI6+Ipg8n2prApb7lpkEfSlmhnvIKaIFtAcBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bT6P2SvC; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bT6P2SvC"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-691c5776f95so8610876a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 04:07:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781608023; cv=none;
        d=google.com; s=arc-20240605;
        b=imnrvLRseq3W608Lr2k3OqlC7+8WSZP054R52MfOQo/LbQRSqwXBv56E1qCnMwR9AL
         sRsIO6Ghj8INhYTBXCclBCR38i+SFrfmqBQKOJggJ8HauPSEiFodKL1/y3QiurT7y8pJ
         dW2oUf2PqyPjFg9f7GF6U+FscHXisOZtOuw6WvvtvdSzGtjorx6Eru5jINTMrHYJ7Bv4
         vbiiJUCFJ6fw11JoSAC0TwJ58Mb9uAGRo2WmeZ1Bcqgq7uS88ajqnaTKTmvnELA+cGLy
         NsH8dVJV4MjP09Li90OSryw71oT0djLOhYEfM8rCsQ5OoUFwRWyfdtBD5ZpKtSqE5B5p
         o/QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=20q/BGHO10i85mG1oAr9AYp71NMXEjLfTQeksDW/K5s=;
        fh=G247raRK+0I6KG5FVHKn+vkbxmjSAHmAFk9LsBQFGFY=;
        b=ENOO0tQuvz1tk5BRiKTV4fNVQp2uCjSlniQxBpKNGQTAvcylq6JWz1s0oQKIqL2ViB
         XPRKfawlETBwyv5xY+2sTqLmTikT8SMKO/iNwiZjPQcUuvJBzfo9CYxgHq0FArmtd/JS
         9u+vgXLWwGOjVD6mXHgdkfJHWtGslRdQTcWXSc2E5rmFEAeaslgvG+I+MYul3q3scB+2
         gGx9PqNpCiN288XbSK2kWAmzskIx9dVZRcIyrbrHjNN3TXyvP6moWLz+Vaj0qw2qeYD4
         EKzH443bwPxJazdqeR5on/YTgtTEmNecXYsxGnZBQBw1cr4ayc+CFoKLnliMH48r7eR5
         XehA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781608023; x=1782212823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20q/BGHO10i85mG1oAr9AYp71NMXEjLfTQeksDW/K5s=;
        b=bT6P2SvCuWCSnxU2jr9ONR07+ZW4h5RmiblDXplFY3XBA8j6B0UjZB2Tt1JBonehag
         tWFdKGK9XSCghyXW4aU4aaAfNKa7AzC9bKdGr8rtXpm3Ve4Nk8rsvR68ASa2nY2QKBAF
         rKYR+vI1bkM6vQExAOR9xRf+MvtLNXJVeow5gCBw3SW2lfWnGUgm7KXxCxCQOaaaaZ+F
         LDOUHva1577CMryB62Gl9DX65Uis0ck2nbEDGjIuWuXer+Vfm7gV4igK29CVIzvaO6/g
         Yjlk+6I5/pnsC6o1qXZGNJijtn/ldfXM0AoX61vK/eX/wDkE5/bbqC3M+wczVZI6fclc
         45bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781608023; x=1782212823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=20q/BGHO10i85mG1oAr9AYp71NMXEjLfTQeksDW/K5s=;
        b=K8xs9YbmKXnojqD7xEOmVzahAx9h+cDRhZQ/dv7cUc/HX/tyLpeyIYLjTd06prS2oR
         /nR1t29XQMkZ/y+FfdiOCA98DatNdizhxUYSBpCGIjiSkb8zqtbvZv6MaeNVGJ5jLbfZ
         zD5jFP4wjyYklQonW5nnrGAX1ByQHbirOeDqO1hjCJTE+atZNFsWqOcGdsGouWix4Lgy
         FuD5vxykbsJ3Tns/jBjk8ZKa/IFLNMk6EXsQMkWQ5rCkKEWflXcXphuSq8Iesm5oVUul
         vXAu/uV982EyOGkVykFqhEDPQOtqWqGrvfKde0PU/D+UyldNrer1U38kBtLvek/q3nnz
         ZWng==
X-Forwarded-Encrypted: i=1; AFNElJ9L08hUeliFzQaKEcecVYhJkOIVCcvq4FduDo/tSlZSTvV49X4fMm39VGyWdLzpRimABxuDFYBaCVQPZoAP@vger.kernel.org
X-Gm-Message-State: AOJu0YzZkzXTAIR6M3TmBS2qE2iASjhSW10hd01PjYPaOkakJ9EehpkQ
	2VilU4NNqnhYUH4LO70eGQhKpehbxQltQPDFbnne7/gFQX3rUEU7hJC5jFFIjeEqKGdhMIZ/1CO
	YhM2cgz+cXyHQLSRbNn7v3Zwg7gOTC1c=
X-Gm-Gg: Acq92OErqt3r73dgjBR/MeM5qdcKaKrNdu8hf10t8GUrVqc5OzwxBLjYkME5mKLdQRG
	Zq59bsk1zm9+sgFprXaaebnYYnbTrl9++61EdPqHZ+39kbEH60zT3S1wF274b69X3neZxHkeQdY
	0oBIy0GuZm2ZrZSP7EDR1LZu9A80jf6tHmcAowtlhGZlk4PirD0v6u3jm/IXoDVE/6J07CV+Ul6
	5/3f5oS++Gbc4rtxHJWR5PnfmD1CotgftvJUVfD2a2ZiPQ3WBoXGdCRMOjikU1aahuF7m9HmxyC
	/I265NujJAP0CqrZU4Ke1Ddd6aLLGIE53XY3SWPnkA==
X-Received: by 2002:a05:6402:548b:b0:674:40c3:f047 with SMTP id
 4fb4d7f45d1cf-69378a13834mr7848637a12.12.1781608023195; Tue, 16 Jun 2026
 04:07:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529031918.7361-1-russ.fellows@gmail.com> <20260616014419.7913-1-russ.fellows@gmail.com>
 <20260616014419.7913-2-russ.fellows@gmail.com>
In-Reply-To: <20260616014419.7913-2-russ.fellows@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 16 Jun 2026 13:06:50 +0200
X-Gm-Features: AVVi8CeB0X6EyzK00L2fugoUV9YOSNlq4homkq5QHUNDaYttuIbu1Ks3xO3WC3c
Message-ID: <CAOQ4uxiMEG+wMot+hcL48AoT_FFri=+RimQ2JbLA0Pi77pvzKw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] fuse: preserve FOPEN_PARALLEL_DIRECT_WRITES for
 passthrough opens
To: Russ Fellows <russ.fellows@gmail.com>
Cc: miklos@szeredi.hu, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Russ Fellows <rfellows@xlrait.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 3:44=E2=80=AFAM Russ Fellows <russ.fellows@gmail.co=
m> wrote:
>
> From: Russ Fellows <rfellows@xlrait.dev>
>
> fuse_file_io_open() currently strips FOPEN_PARALLEL_DIRECT_WRITES wheneve=
r FOPEN_DIRECT_IO is absent. That rule is correct for the regular direct-IO=
 path, but it is too strict for passthrough opens.
>
> Passthrough I/O already bypasses the page cache through the backing file,=
 so it does not need FOPEN_DIRECT_IO to preserve direct-I/O semantics. Clea=
ring the parallel-write flag for passthrough opens causes the kernel to dro=
p the server's request for parallel direct writes before the passthrough wr=
ite path ever sees it.
>
> Keep FOPEN_PARALLEL_DIRECT_WRITES for opens that also carry FOPEN_PASSTHR=
OUGH, and continue to clear it for non-passthrough opens that lack FOPEN_DI=
RECT_IO.
>
> This is a prerequisite for passthrough write parallelism: without it, the=
 subsequent shared-lock path never activates.
>
> Signed-off-by: Russ Fellows <rfellows@xlrait.dev>
> ---
>  fs/fuse/iomode.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
> index c99e285f3..0301a48d8 100644
> --- a/fs/fuse/iomode.c
> +++ b/fs/fuse/iomode.c
> @@ -216,9 +216,12 @@ int fuse_file_io_open(struct file *file, struct inod=
e *inode)
>                 goto fail;
>
>         /*
> -        * FOPEN_PARALLEL_DIRECT_WRITES requires FOPEN_DIRECT_IO.
> +        * FOPEN_PARALLEL_DIRECT_WRITES requires FOPEN_DIRECT_IO, except =
for
> +        * passthrough opens which bypass the page cache regardless and d=
o not
> +        * need FOPEN_DIRECT_IO to guarantee direct I/O semantics.

That's a very round about way to say FOPEN_PARALLEL_DIRECT_WRITES requires
open in either direct_io or passthrough mode, but an even better way
of saying this:

#define FOPEN_IOMODE(oflags) ((oflags & (FOPEN_DIRECT_IO | FOPEN_PASSTHROUG=
H))
#define FOPEN_IOMODE_IS_CACHED(oflags) (FOPEN_IOMODE(oflags) =3D=3D 0)
#define FOPEN_IOMODE_IS_DIRECT(oflags) (FOPEN_IOMODE(oflags) & FOPEN_DIRECT=
_IO)
#define FOPEN_IOMODE_IS_PASSTHRPUGH(oflags) (FOPEN_IOMODE(oflags) =3D=3D
FOPEN_PASSTHROUGH)

>          */
> -       if (!(ff->open_flags & FOPEN_DIRECT_IO))
> +       if (!(ff->open_flags & FOPEN_DIRECT_IO) &&
> +           !(ff->open_flags & FOPEN_PASSTHROUGH))

         /* FOPEN_PARALLEL_DIRECT_WRITES is not supported with cached iomod=
e */
          if (FOPEN_IOMODE_IS_CACHED(ff->open_flags))
                  ff->open_flags &=3D ~FOPEN_PARALLEL_DIRECT_WRITES;

...
        if (FOPEN_IOMODE_IS_DIRECT(ff->open_flags))
                return 0;

        if (FOPEN_IOMODE_IS_PASSTHROUGH(ff->open_flags))
                err =3D fuse_file_passthrough_open(inode, file);
        else
                err =3D fuse_file_cached_io_open(inode, ff);

or some variation of this which makes those modes and comments easier
to understand.

Thanks,
Amir.
