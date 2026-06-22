Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2702342509
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 17:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782150830; cv=pass; b=sbS/oGgfhyw9pifdke0X8mxIve1cPjydkDxZOPTLN8b1gAJVZLqdEroAdeO07hyxusnKz4FFJD7n4BADZsFtqefczOtQgNR1Gr4SsDL+hayvhzVIjIMFNUTZb2WsW8ZXYjLoLimbaTDF9bBeATRceDJKs+8TdsESiV6dDLJLAXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782150830; c=relaxed/simple;
	bh=792JthRakdk5sbEo8g+d1nmVLBE1qYjza4D99D/L3GY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pkIToCq68MfWuCcl8nCmSDPTUbCU5iHuYsp5uVB8TUaaFAg8Pt2j8QrWNrk9pE6taqhwG4hJ9vV/XpQp5c6OOK53dgvNvDOHQs4q8jjsXYAAhMWBRNYyfNpv7RFAPYeaA1ZDu84lRg5B9+mTcrr3rNcqmno9yVYHUUjMJquREQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnrzrHxQ; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnrzrHxQ"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-69767cb5d4aso5215238a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 10:53:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782150827; cv=none;
        d=google.com; s=arc-20240605;
        b=kozASZ1k1xmoEXmobGMqYW74pFdjkPMaamYDQL9h2NbZcz0xHRXl78lFBpNlLKwTaA
         0rpEWcbxrTaNDSBw+52iM+EUGiXr/IJ8SXfy9dJ3GEqGHkObX4hgiX04cTPTS6vPuPAF
         S5F+WPKvEYHFbD220hGMuFxZQarO1z1EVMQjTL9EB7BjqMAEBxl0HgvkvPBfg2ByTIjh
         OBy6zLXbh3Q5D3Q92Lj+HzZTHBqnuign7MGp7080UnxsWVTBQu+FU+Xh4f9pIgpndFwa
         +qcNOSLxeWIQQdggd06SuL8TcEu4mQPWy5Nfofqbwa7Lsgqwj2A4jXPxbrYor0jqlwxC
         Ou9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xWxywB8yX97dTgz4W7+C3cuW4P0X8MyukDE24mZ3+gk=;
        fh=NLnXuFEmfgxQeq+yZm9U2nq5W23xvYYdJsLVryUig00=;
        b=Xwbg5JbZAfhUl0apOgB78r7z29SRy8LsSej5dm51TsBJgaXveADf51UPo7QT3at1iT
         /F+S5M8C/xWiDhauEgiQ6c56Re3MFy9OsfUNJqW03zNiPL014Em8f0oGLwoWNKyOpJh0
         txbLxRbk2sltADg1gBNhv0Kx20bSCnr2JzwEHzzeP9nZB2PuePHjLckhQMtR6K/TaHv1
         XIRbE1V75KQgzDbOnSNcosgrvB77aN4H7Av+aHDgLTenneIBLnPvP3RawuRP2DcEI6Vr
         ckRO7C/yFiUPaa8bUNk327Qef65vT7T176+PrFR/gh21FMD2Qw2YVQQi+8mFR73yOVUQ
         wFIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782150827; x=1782755627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWxywB8yX97dTgz4W7+C3cuW4P0X8MyukDE24mZ3+gk=;
        b=jnrzrHxQU4ZCqVsfPnMHcES83wfZKqap5cReGyCqbz9z/JH3Ib2VF3TOMyS5lOGPId
         t+3/cMOJpByjoo7vhP9JPzGRpE/UyJY+qF31uXXiKgk1AaMN3o63jcxXTxybOLPQ52Xp
         T3JWvp24yvXO3YuK9WojYHgtjQPeIe3lSm1zy30Pbkku+40t5L60LSZ6SGqeiJDA0Aey
         Pt0v8BJ+EfTcRqTaH4UyiJ3PuSv5dTZyx4nw2wNTZyUWFxIj9PEwle/i6pkNrcyWYFvI
         PPOf+VcPLdsPJlH4nl+bMUtZfaNace3aopN9xDAkXRlTLuHfE3zMnOeso/IYCWHuMWob
         VNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782150827; x=1782755627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xWxywB8yX97dTgz4W7+C3cuW4P0X8MyukDE24mZ3+gk=;
        b=F+CSGovcRXQ4evVGyhNDryF3GKW+79vIk8aTeEo7A8JFCjWYUhcx96innDdYsM5W7l
         tQnfw0d/St6aDx8GYwwp0SooFkpNNmfqlbQAvpMKYoBLe7Oz5Wvjx0Y39nmj9bvgu7iL
         CcA0IrKwLr6VZZLCEuHXHk/003bHubedxfK9R+UUAKd8FUVWP4x5dbVORzI5NzgY596Y
         pqqXjuUJwCVSvPSeAT3zmK6br8WsjIlbEL29rBl+4vVW+b19n/0lvtlIC612sp5dRWD6
         qFT7B+/ZAlgyawTKGDSFfbi+yjHvn+Olj4LUwva9c896ADn7etvZbMZI6PszkuA5Frw4
         IJ9Q==
X-Forwarded-Encrypted: i=1; AFNElJ9ju3/awH8recNOxzavrqx7afBlaQkOhPiJhrMGPhpH4r9tBuCxYONBJHLEmyukB1O5huCK8KZzkoc0/ILp@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3cGVP3nCPTV6OoFwwsJbPtpN3RAEBDJou+kumAlKN/Cb9UsWw
	xKxRHvxtUgLK6DJt46hOXxnccJxbgmuRH8MVHNTcUMNbiDTeRDVIjhs5NusJ0UtiRs32W8xEHwf
	xBp5PPpg03OWDq8yJDi4wFNSgPZzV1gHTjuII
X-Gm-Gg: AfdE7ckDBeO7TSwdpZrsXG4lAxvOnADxDMALRbQcMDX/QBgZvRWCDzgGcIHoyZN5OmW
	kABH7hK9wDUw1uq8+BCb1QPHbTUdeErzwvJXdOru7N+V+QgOI+MJETy+ptCLPTWYM2rw74VEIWI
	vkfQAIU/KiUIIQiie8Vn5j9Pn61A0I4CTHmo3yUxaH+5mKDixBgCS0xJlJ/Enp29IvqTB3ewWwA
	cZf43bv3AGUR/l69RTSI9Gyi3nFv2+/h/j/N5bzM+WsfkCofOHP/Zr+MjawWdZuOi08px+XQL4h
	o02b1K8KoSWzubumxxE6zQhWzqANJwk=
X-Received: by 2002:a05:6402:ea0:b0:671:a18b:32b8 with SMTP id
 4fb4d7f45d1cf-696e5275851mr6985046a12.0.1782150827279; Mon, 22 Jun 2026
 10:53:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619120026.2630196-1-tristmd@gmail.com>
In-Reply-To: <20260619120026.2630196-1-tristmd@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 22 Jun 2026 19:53:36 +0200
X-Gm-Features: AVVi8CflF_ZPJwZiHQ-Fm5jcIlERe35O8dwHLZPmPNek-7hP-ECJ3tNgWCYTdTQ
Message-ID: <CAOQ4uxhEqS-ALvuP_YxBi=MDpF5fWOsWfgBm2BBOu+GT=d+xKQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: check fi is not NULL before calling fuse_passthrough_release()
To: Tristan Madani <tristmd@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
	tristan@talencesecurity.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2026 at 2:00=E2=80=AFPM Tristan Madani <tristmd@gmail.com> =
wrote:
>
> From: Tristan Madani <tristan@talencesecurity.com>
>
> fuse_create_open() calls fuse_sync_release() with a NULL fuse_inode
> when fuse_iget() fails. This propagates to fuse_prepare_release(),
> which passes the NULL fi to fuse_inode_backing() via the
> fuse_passthrough_release() call, resulting in a NULL pointer
> dereference.
>
> The existing comment in fuse_prepare_release() documents that the
> inode can be NULL on the error path of fuse_create_open(), and the
> fi->lock access below is already guarded with if (likely(fi)), but
> the passthrough release path added by commit 4a90451bbc7f ("fuse:
> implement open in passthrough mode") was not given the same
> protection.

But passthrough open happens after this error patch, so this sounds
like an invented problem

>
> Add the missing NULL check for fi before calling
> fuse_passthrough_release().
>
> Found by syzkaller.

Where is the report? where is the repro?

>
> Fixes: 4a90451bbc7f ("fuse: implement open in passthrough mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  fs/fuse/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index c59452d60b8d..9b368eab159c 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -313,7 +313,7 @@ static void fuse_prepare_release(struct fuse_inode *f=
i, struct fuse_file *ff,
>         struct fuse_conn *fc =3D ff->fm->fc;
>         struct fuse_release_args *ra =3D &ff->args->release_args;
>
> -       if (fuse_file_passthrough(ff))
> +       if (fi && fuse_file_passthrough(ff))
>                 fuse_passthrough_release(ff, fuse_inode_backing(fi));
>

This should not be possible and if it were possible, this code would
be leaking ff->passthrough.

I don't know how you got to this issue and why, but if you are sending
me code fixes from an hallucinating AI agent without really understanding
and really reproducing the problem please respect my time and don't!

Thanks,
Amir.
