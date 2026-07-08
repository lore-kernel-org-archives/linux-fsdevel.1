Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE223F7ABD
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2026 21:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783547356; cv=pass; b=Mqbc6HVhPrirIDtcA243aYA2QrbAxr9PwiFodnSpmpyuK2GNgUyV0a/1VdxOhSASgw5UGDfqdGgAtv3s9iVQ9fZ6iw0G7dVW5B93b0Hi9sVyzSFTOoCHCgO/JcF6g8hlB+QiwNpz/ugszNJDN+ko8LWsTTKeRevwzyNbACjlbo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783547356; c=relaxed/simple;
	bh=kW39Ysv0VDGIVvAcr+8aBygFDx1j2L9mcscxDiOiJ1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lKuPF1Cu9iuGOXULXimbu2/EPY22QwDPuxpFVsO3Dt22RerYGRHNTUnFzQUgpn93qFHvH9g+aJSEaAhGJWQqUZE14wefZlcLrEzHQcrSUz3h1Mp2qIuo3uXAKkUyBFmz5Elc19/oKsyhCnMHMw91DANq8v4z6lqn7BuiKnDeppg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qK4R9BTG; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qK4R9BTG"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493b786d6c0so6395175e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2026 14:49:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783547353; cv=none;
        d=google.com; s=arc-20260327;
        b=JBznKsjbCoDwDx9poy8cN9WqSEUCtQhs3W2Vwf52pmWnxn8eIEZREWWGRDpPJcVRZe
         q0SfpqUZWPNhOh0wMXayOBd0rWjqW6UtCLleSeCEiGgesqSowz536zOCfqocTZHp97Ic
         GEm3b+idsbTFSr0Xf4vrAG0OwYL8s5A8dxUZdij0LFPN7YMVFxunmGZRPET8ygpTkU58
         EjGZ+IxpMFO58DQ4tw0Ptc7AvFXosCxy7jMz6i3VsE30YkJx/7c+nIZRpyITocc0oNbW
         /AyhQ39dK2sndU3zBfn0deoPzXJX1/6X+FAGTl6/ftl/Int+N7rtoLa5m/iZ3jSaktfY
         bR/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qkuoYBqKk5lyGV++UZy74kJgGza4SOcuN6HeQmJYDys=;
        fh=pIbe4nimNZCs/QacmFxRLRk26sftrFs/WDGMaR5izuA=;
        b=QRMflrpyVy6uvj55Rs375KasfNd1vAurT9a2/dF5L0f3uTa+YfgXlP7nXx9k8Dj2bM
         DRo2+FmCc1hhu27RE+lsEDNva13s4r6RmvKdm7Kcvkcg/Xyde1QSMp1TsxZjxprAKyDR
         idItAKXi3G7KdqQ9xsd5fqGm8jAwWS8bUF2t36eLGa3HoCLLQyOIwGe0MMjxbh5fvlsC
         SRfB2Acxv9j/qevtaQJlh70/JqcHr9kwH+Zjyh50+b6Yyu+TSwj6Jd515WnkfnxuGjKz
         WT8NHfK6PcBVV4h+BeEf9lG3ge0J7/zfOhUXuSp38TWPFogJwjU0SpufX6Fx+HAP7W5V
         md0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783547353; x=1784152153; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qkuoYBqKk5lyGV++UZy74kJgGza4SOcuN6HeQmJYDys=;
        b=qK4R9BTG4Przdm5f28l8s1Cfwec2JQrG3eoBeUvgrNEYpkw1hXTVe9+LI54wfiMT3u
         8SkN4ns0QVba73S9GnPF1Q9pQ+NCt3e56HmDLsrOcnA6Q6u23IukmdSd4F2bYgQGAnc6
         DMaIqDgbP1ZNAWDF7wovZdsDDQn6lB1rt6l9r1gaHWQLzwHLHKmFCQpS/rsNLSLLhJrA
         Ssr5iR+ZV33G6UCPR3rUGrfZ8n/x+nko4S5/MSuhxsjYbufyAI92ijTXjfZuo4QeeVZa
         433fIwrecoikH3bAQTJrx9QQqNKCh3Xm2Saau1X6BaXc6AKQOT5X571uOB7WojjrR2L1
         Bg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783547353; x=1784152153;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qkuoYBqKk5lyGV++UZy74kJgGza4SOcuN6HeQmJYDys=;
        b=Fz0tcuMEgh3YHtVYFIGU3/NfOmu1BBJ7/24uDorl1QHKjXUYHQqzDrqXghZfbIVbFG
         mB9yeGDIiexWQ4izdDaJrmUVMjfCWUBkM3DZo+IzGHwFZxwdVVBchudyK2DiFwKtzC+j
         VYiXdar733fVupcwBeKLgY3Bg9thznD62/7DuvieW3QNk5XjCmNeO32zXDyFoBWQa6Aa
         vWKlWzfgLGqScCGVNNrVvTzWDa/aFRnjtEI9xD9KIrq9yyKxDwma6qy4NbglpGSB1k4f
         RcRfeTInfrvH6bTuORrmY+t4RmItnb0ko3/76ahX3XmLZjeeDuzcUsdcReh74lAkAmKM
         8v8g==
X-Forwarded-Encrypted: i=1; AHgh+Rp1h8+uSXm4VHrydf9x+SEdm8sbFoqnuVb0Pjvht74RQrVDskgDkhwzIebxnqYyPMoIDZcxwSc2lSj4fdPr@vger.kernel.org
X-Gm-Message-State: AOJu0YyNae+g03gGzdGeRUs79bmxNGEPZeQB9lPvc4UqXXJweeQ0qaCf
	RK1LiEOu0TcAMRMy35R9W5JiK9KgMs86sc+QQsiRdGssidH1GDxqnLdD+x4LVunonpYR+MDzUuy
	mfRAZ8GwoOLaOffPqv3l6JvkDWr/bRb4=
X-Gm-Gg: AfdE7cnc97edJ3QFAG3dnpXcvpObTrVITruycCVLtO8z1+4GFkuvreaEenhNYzDnDxQ
	ug+xvTdDCg9Atthf8pgUMDE6iIP4N6Evfd4g+W/MQiRohXSTFM7nnDP4cTWjnaiLs5zdjWz9pAj
	14kN8JUlDIzFCrqBvjbW1SUY1ACOncydYzbWcmJ8eAfd+G8DM6xAc5gaflrlFzVpxAZS/tPNGEb
	ip8IzaHRj31HNlw3x/3QffEQ7Ys9vfkSTLOhTF1lGn0jjtWMKPQyXpPwalJUFGweuietUIaPHmR
	bvdNSQwiK1zXXn7ub3UHP2LGe+iS+Gj2ekwhmcOcCUeKBEZldzMc
X-Received: by 2002:a05:600c:c174:b0:493:c862:3f2d with SMTP id
 5b1f17b1804b1-493e685992cmr40712775e9.5.1783547353519; Wed, 08 Jul 2026
 14:49:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708021705.3436-1-liwang@kylinos.cn>
In-Reply-To: <20260708021705.3436-1-liwang@kylinos.cn>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 8 Jul 2026 14:49:00 -0700
X-Gm-Features: AUfX_mx62gA9FFCAc-X4i4tPrdkHOaslxnhzPK4VfYMPdHiWUJ6-T8GJJH5W0CA
Message-ID: <CAJnrk1bhjybFTgdJnxRW7o=+2D9Ahc=xLCfaONsO8P0_e=1rhA@mail.gmail.com>
Subject: Re: [PATCH] fuse: drop redundant err assignments in fuse_dev_do_write()
To: Li Wang <liwang@kylinos.cn>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bernd@bsbernd.com>, 
	Amir Goldstein <amir73il@gmail.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 7:17=E2=80=AFPM Li Wang <liwang@kylinos.cn> wrote:
>
> After fuse_copy_one() succeeds, err is set to -EINVAL before validating
> oh.len. When oh.len equals nbytes, err is already -EINVAL, so the extra
> assignments before the notification and oh.error checks are redundant.
>
> Signed-off-by: Li Wang <liwang@kylinos.cn>
> ---
>  fs/fuse/dev.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 5763a7cd3b37..7813f6214d0e 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1887,7 +1887,6 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *f=
ud,
>                  * Only allow notifications during while the connection i=
s in an
>                  * initialized and connected state
>                  */
> -               err =3D -EINVAL;
>                 if (!fch->initialized || !fch->connected)
>                         goto copy_finish;
>
> @@ -1898,7 +1897,6 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *f=
ud,
>                 goto copy_finish;
>         }
>
> -       err =3D -EINVAL;
>         if (oh.error <=3D -512 || oh.error > 0)
>                 goto copy_finish;
>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
