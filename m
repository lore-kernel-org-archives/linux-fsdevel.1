Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA63233134
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779903934; cv=pass; b=bH5TzADmPj6LfyKBFBP+Rmbrr0p24N1o7uR2MUptSzXcOKkTB2+t6CW9Bc2TxOcwSM5scJWKiRkdhK8oFzQRV1LRqVyTpgqqRX0Y154Vrkk15VcA2rIqIgR2zcn9cvy0+0w66Kx9WWk7llx/BbYoy6kQd4HCHXM8pSj22XlxsxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779903934; c=relaxed/simple;
	bh=b5hC+lCUmxhklhZzKQ1tvJz89R/bn00ZL3r0t0qYg7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YOzNl1MFKL9htWuq4cl273o2M5000Xmv0jZsQky8hIyxIfgW83dqelbQpop6LoOvZFpZpf4ZT+UfGFtLrgh152foLir2L2lxYicQcJvNQJXW7M+gLmHn906W6KWbP7Ee/rJlgYQ0oBKANKnC/KWVk98GbogvKpMc6Il38/g8rWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9V3rrGa; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9V3rrGa"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a887ebb416so14797971e87.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 10:45:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779903931; cv=none;
        d=google.com; s=arc-20240605;
        b=cZcNfK56hARCIArhzfrnXKDUjQWryinvUL6mDa1C2rZPXXLfOjRRjcT8QG+jbtWqZv
         X1L+OmavGkrwC1uwPQcCKHycyeoMzFBXPa0HDglUBa5Sl3K0qSXflG83hcD5y0gLhYHA
         r+aTZPk7/sMw3Rx+YU194scG/pWpibLjbFDO6kqcdyvjxIkVxkcyuAqcmjjc4CRPbr1D
         nOTKrRCR6+8ovpk12X+2FcIbyE+hKQDedv4HMH86rO7YCKTJkZh4M8Mebg2RTasAGg4o
         u7pHSyCuLPGoU8z0Qh1WlkmOjvEyy01Fc8SYFbOwXjTeupSeulrwt4/hhnWGkPNNmTMM
         Z9Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E2KbyWfoe1K1NYU8w+TYnSm8ZSxgqFTHuqB6tEIoUF0=;
        fh=AH/ADTFvUluH163ZlvR0EFOxJJpebWS1Ljz+VzWWC78=;
        b=eJCT6lGfZxu6vUICWpnEBkNraefI0fXuNdRwLwl4rpMDzs4riGJRxZ4GMHFybGDnDV
         6iIYs1wvOJqDmNXNur6P6JQr8yKZBznmwyaYlx7EEx+MmllY743wV5thZuH7ZbNi7Dvg
         g5hjiidLyOZQONyQfck8aO/x9C0hr2D7YZV1g2GKMSMOfHdFcdloCWj5VLiw9AZgZ4+z
         /wyy01LgjM6kZt59F3lxyx4Lp6UgS45Uvpe9idUbWDjPPMSpKCHXVPJFwobvQX3hYLIr
         9mqroY+AcfPg4Gb4ZPpmf0oN9QhVMmicBGmnJhJOLWjUCHDFMvXDKaHc1ZfPuPkn8x7h
         xbQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779903931; x=1780508731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2KbyWfoe1K1NYU8w+TYnSm8ZSxgqFTHuqB6tEIoUF0=;
        b=P9V3rrGaxoqaustcnTp/oy9PRz6sB8mg8/rgbR+jfh1nYSIEFgsx2sKnzsl6ABKGq3
         1U/jluIpLM24MVtF0mfDUVkd+FpooD9M10/nS1yoXstICmFlj/wDaLp3F0J05H5UjcpO
         mYesMTlVf0QagYQJ0zljUWkNQ+eTRYC0dASdmMnYcfUVJsLJdf0spgJpjKFCG+1aVMxO
         brFL/mj92sj3rd3lvpAaOPiQcYS8IhacurhEu50fzTGx7U8mN36dtprFNaPi6Pq6hcDy
         1ep7sB76yZGAUoHjdJ8ASmsmSsfnAbXbfRf6ZkYfeP14r6j7uOIfWjA2NGnNZaGhybAY
         ovaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779903931; x=1780508731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E2KbyWfoe1K1NYU8w+TYnSm8ZSxgqFTHuqB6tEIoUF0=;
        b=HllXZYBJ8b57Ok1ZbdA+rWOR1cvjL7PYqEmwzedFaoWeYMu3PcVH7qRUkgc53d6+HV
         ll9ZxuZHA2C22jyg92tpGLpxoUsQ4/fz2ckMKLMDUe8055mygYR+xWLUdKaMQM6jEiXs
         N0Hl0OCeDqRl1868U1flb5NAYbQ2GuhowkSPhsUl/dJR+Bu7crL6Kpij1wc62TKB3wiM
         kl7/eXcsnVEzto93qFcKPJ2OWn1cdUsAdJdx4eyFaU6YhNswxAL8Z+AXoK6XunZ7IMWQ
         ljlTTanTdJslmocjGxdfJFb7FBfFDfZqYTC/8yJQtw3Cjy/FfIa8ShTFHaPgFpPZd9Mt
         5Zxw==
X-Forwarded-Encrypted: i=1; AFNElJ/CsJs25fYY7/aXls5uJpsV3pf9tYydxZjkY7B0CVCwte+r4NC2J2AaccXTcMLNJyfa6y6cQS6KNDHvRCVj@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8QsuvfUFzbHdsckqQ70IFd8VWwpVU75PjlZn5tRejAN7WnIxw
	Dsxy+Z8X2d4Q6BJ1dj2k8MIeBIiX0wdXsuP2xvK9LtA3za5oS/lTW3Cw55+95qRv2q+yNAFDYzL
	Er4yTH2DvNpuoCDtMpECVHgi9HZg+ql8=
X-Gm-Gg: Acq92OFS7yvUpnfMY8pEcN+ckbg0DcdpX0A9mooJG+b3lVR1UNUlDYIGmkHnBjUrq3l
	8+/FLLJCXJa2xuR0OoT8vnozNE+2HJ+xJbgsaBv6TuNZTxDQLiAWBeGt9jV5lYdTpCGsPC+cQAx
	24hvAzOqX1Xb62mOZsnS9s9Yof1Q/VXzkfHjl+ION5qhZg5spzhfgtLJa7j/z6L6RQ8vVQmznik
	kRqg0goMdbMnsn0DhGklBPR2FyBuRshx9MNMy2hnfOvwT0zz0i3EMN38sDcfb1tO4+UdTR16Gpp
	duZwQuAxCs9bOq7ssUU=
X-Received: by 2002:a05:6512:3e16:b0:5a8:e367:4ddf with SMTP id
 2adb3069b0e04-5aa323b34f1mr8807488e87.16.1779903930710; Wed, 27 May 2026
 10:45:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260525171931.4144395-1-willy@infradead.org> <20260525171931.4144395-29-willy@infradead.org>
 <41998b761c6b7968016365f499b1153a26c7cf17.camel@ibm.com>
In-Reply-To: <41998b761c6b7968016365f499b1153a26c7cf17.camel@ibm.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Thu, 28 May 2026 02:45:14 +0900
X-Gm-Features: AVHnY4J5Cw6CRKPOH6YrvrOO8Fewrh5g6EQYJ4AEzdxZ39HZEQdRbm2ltBqv68A
Message-ID: <CAKFNMomK_ZXx138bzRW1=fwf9S7=vM8EseYX1BuTyYRhG31J0w@mail.gmail.com>
Subject: Re: [PATCH 28/34] nilfs2: Convert nilfs_gccache_submit_read_data to bh_submit()
To: "willy@infradead.org" <willy@infradead.org>
Cc: Viacheslav Dubeyko <slava.dubeyko@ibm.com>, "jack@suse.cz" <jack@suse.cz>, 
	"linux-nilfs@vger.kernel.org" <linux-nilfs@vger.kernel.org>, "brauner@kernel.org" <brauner@kernel.org>, 
	"hch@infradead.org" <hch@infradead.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 2:54=E2=80=AFAM Viacheslav Dubeyko wrote:
>
> On Mon, 2026-05-25 at 18:19 +0100, Matthew Wilcox (Oracle) wrote:
> > Avoid an extra indirect function call by using bh_submit() instead of
> > submit_bh().
> >
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Cc: linux-nilfs@vger.kernel.org
> > ---
> >  fs/nilfs2/gcinode.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/fs/nilfs2/gcinode.c b/fs/nilfs2/gcinode.c
> > index 62d4c1b787e9..f979dc9d04b8 100644
> > --- a/fs/nilfs2/gcinode.c
> > +++ b/fs/nilfs2/gcinode.c
> > @@ -83,9 +83,8 @@ int nilfs_gccache_submit_read_data(struct inode *inod=
e, sector_t blkoff,
> >       if (!buffer_mapped(bh))
> >               set_buffer_mapped(bh);
> >       bh->b_blocknr =3D pbn;
> > -     bh->b_end_io =3D end_buffer_read_sync;
> >       get_bh(bh);
> > -     submit_bh(REQ_OP_READ, bh);
> > +     bh_submit(bh, REQ_OP_READ, bh_end_read);
> >       if (vbn)
> >               bh->b_blocknr =3D vbn;
> >   out:
>
> Looks good.
>
> Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
>
> Thanks,
> Slava.

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Thanks,
Ryusuke Konishi
