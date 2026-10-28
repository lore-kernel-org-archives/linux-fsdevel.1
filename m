Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793202516;
	b=3Ff8xR9xmUh7tOvQJaKELuXLf/ZcfduOW1WzPbLDQc0wHuwQpIq41qSVF8YV6i8WzDeA
	 X3Pk2TqnScVjh69nqlsPCdQijXthC3Wp6Z98jz03hSqexR7n/5HdCgKgkWYA5T6fG2sdD
	 E8oQEJIlkPtoj9c9B9ON3+FdsObI2nDr0jPugpaA4WgTAx39LDR1ekcugi5jLzDRnF2pl
	 IKW+6pm0h8E0eoXMNwwIg/1ApMX2rMBKI9LnyAkpt2f7qOvTSJUwC1BcLRoAomamdXKLQ
	 +7meelRc/dymXHx5w7akMrnBCPaHahJUBSQuIH0dB7SCrpjeOANo5GoGw1uW1CIH8rg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202516;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=P2Gtmc+yPPyy4dGekEnPEtmKjhHWq0oqn8nEo9QjzPA=;
	b=kyTVlxvKI3PhI8dxj3yKhxHBVTavlF/GJD5MxjDPMByyg/djiR29NcEv3qXc1ZG0+xQR
	 1+D7BgljGImTVDIxSyFFM3f4mrt/xNSCF0ljJ39jSxltE9expIny5uA7fPnkOzdj0qtCF
	 sCQpfpdtWb5xywABvTiXxmYgTwv5lviY4qa8fqvQMjg+wxKBr3uMsKieDudFPauLwOIPu
	 IFB60byuSr3Z7a/6u9MTEw+asLW9R7WbGCsrV1Z+oDKqTOxu6qq/4aUWIfojrQBqnhV+q
	 acVszIhBn8MD4tOks0llUwcuedC+d40YbLnblgAdbW5AP5LZ6NvvUK2kD3BszodcFyg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sR9JdKFc;
	arc=fail smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C950606A324
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 15:48:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C950606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sR9JdKFc
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b40fc523faso1444441a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 08:48:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793202514; cv=none;
        d=google.com; s=arc-20260327;
        b=aFblnXeXBBBJuXd13MAyhollMNsS5QVWuip2hfr4KvghpFF0fYTSpFASQ6xghmWc3u
         BhvdIC6AOFJyJnHFjiwT/6i2rCcMQ1szCrIjjCVY4yEgrx8YWZGfCfu6HZzR53+mTyVF
         3vqNZ/uLRTzuyvKzIcR2LR21eZfPKk7ovdVaksLbR/cLQBSNoWYCO5xJ3eG8egTy+LFQ
         +ENYELNC7tPJpRLwQ29++04zWFW4FkcSEU9UuY8HPyhH0ZPLwX2vsDTRsllpkcCKUXmk
         QM1BPGoEhR443AP2puNvpq/o0FQcFLGVmNoqkbnzxCNcHAJZLClgIqejnj1PbeYX+9V+
         KSYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P2Gtmc+yPPyy4dGekEnPEtmKjhHWq0oqn8nEo9QjzPA=;
        fh=GVtWt67yDBUNLE/8Ibk4i34/xHbf7Z2V6GhNCXvIUgI=;
        b=EubmFlLdjcVXjiyvpbHjYiSUdBVJZT40JnC3AewL8muNB8SHtTQ24FRMBuMECs+Qta
         4TlJQIoBEUIdCLU6ja5jqy84l/uExZf8e9StUook2QLStE56DI20rV2HT3P5P2WgvtwP
         gFtIA3Cc3ARr+hUnuNey0RQIGWAmqBpLIg8nk7g6kosaIcJhfxWxCFWNtAd01x0p3SbR
         Qi0rK0Yvf4UzLgIhunEorhyawUXfYFifcZqNql8rWR1k79Cy2R5YwpGUPA7GVTZLIHTH
         Z2btK2WqahHjvCRmNIvX2zOblKiyXDGAB0CflwOYjSl7SgQPwqr103R5EBDydssrrhqA
         C/NQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793202514; x=1793807314; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P2Gtmc+yPPyy4dGekEnPEtmKjhHWq0oqn8nEo9QjzPA=;
        b=sR9JdKFcgs0bpN4QkQ2MTdIADGBy0OfZK9Uc2xzngxH1OUHE6XPlgmotix5n04kE4V
         tKXhDVWcUi7R8x+WsSxO2XKULm2UrCLa5ugS8f2l/Nicboyg/Xq7P2T+CyBQwzwtUuSA
         00kvck2jyr72g40j3aOA8r0nVAnGYbDjdTazXmR+zx5OSZKFqq0rBsYi04jxNiTiLr2b
         b4k1CJpjGAKX5SIh8b5X0Vz9tLapvrzMIh1IAEh+zcElg7kBwxHx+E4aiBCISBHpzRVy
         sK/o6PxDR0wcadqZ7HwH7sh84bKXO5+wNcvDUBoiIhOwr2Otqj8bsp55EB6PBwliFnGI
         NU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793202514; x=1793807314;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P2Gtmc+yPPyy4dGekEnPEtmKjhHWq0oqn8nEo9QjzPA=;
        b=wIR1Zm9udpBbc/+697YwEDfFhpKSRsd4qh/49Hg5sNamkQ1ZKOlNUeT1PTt9BhHd7F
         Zrf/P2LtaVGXmtpjOBnRAlSlC8bRkkCw7L+cc9odNX+wTHoeDHE8204w7rWSrczgnLN9
         6WqZQln4bdu46G4bTGMde6OpCYu/2XZpgYi2D69fS6z8G9oWJGJS8YKJSvCaZu/e5nmp
         DDGM3RblaP+3HVYJhZnH+R4Ze0j6CDiV/6TRIMapmEjm1qiSxhJC+wLfssHQ8xgJ892L
         sjwdrAI1oelQzNP3y0ozfMgOYSEyAtG0AZN5exRXd4nZwGXqEiX1MF4rpmWQdx+a5Cbo
         5A6Q==
X-Forwarded-Encrypted: i=1; AKwUvBwN2TnsO2xfINt1ejfHIQdtr87XOXmxhyuNQ2nAcDGaIQSig1PT01JGWJOQtY3j/AquZNb+LVVcSr01k+Yc@vger.kernel.org
X-Gm-Message-State: AFq9FYK6fZ0qaxRmjLAobhbxHv6Y9GdapjFbD7WxkurKFmnfMsqREdsO
	t5zGZEVZCEOg2r5+lVdK1U4Zs6e8inrBEiZfVUY6Wr8kGXF7CcP8e2y/DLiZruKo3sOQvjDqyga
	SEwup3OBNlInQ1/NYvHe5bWfUsawXivBLuKYLvFI=
X-Gm-Gg: AYBFou3lkqVqzlxv+kBrHevYvD2EwY6zAhv3vV+T8smHFMlSdZnscLosCheywSKwmCf
	FuEqavMUugfRUOoKk/GhP0Rmar1ikqE514/B4u7/sYEb330RPepr6filtvKnVzQ5AogyMuQgJvz
	A/fTSH9LUhDS3hUqA1UGzl2pwUVsvosVWFAU2wfB18dVZllCzXMfEw/T3ZbNGvwre3ManJNU83E
	oOZO5SdKHPj30q6XVIW1eUzZMeScIEIY8z+p2P/i+1QJMgmdwEUzXmPuhJfuWJlaXUvI4JSe781
	pHhHMfO2USt/qMqrQvPOfd5h8pF6Q1oL0akorVB/ybzFvSU47mPEWox7kKN0u8IANJSj6PWR6FM
	KPLO2nKUcWuAuKMSWWIr1LXjZ7QfjyyHm6bgAbtPgnFHD3BvAQwNf9RS1/rweCFBdb19DUA==
X-Received: by 2002:a05:6402:4414:b0:6b3:c0f2:eccc with SMTP id
 4fb4d7f45d1cf-6b49cbf6a9dmr2006612a12.27.1793202514481; Wed, 28 Oct 2026
 08:48:34 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <P4wUBaI--F-9@tuta.io>
In-Reply-To: <P4wUBaI--F-9@tuta.io>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 28 Oct 2026 17:48:23 +0200
X-Gm-Features: AclHuK8ls02xbX493_Bp1EqA0zzJpZtmFJofnLekSziZPblGB53hacKp5SDR2jU
Message-ID: <CAOQ4uxhT4i=UDvLmPAunehFujouFka8UKDCuB_exR4oSx_V01Q@mail.gmail.com>
Subject: Re: [PATCH] backing-file: inherit FMODE_NONOTIFY from the user file
To: Edvard Conrad <edvard@tuta.io>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 10:32=E2=80=AFAM Edvard Conrad <edvard@tuta.io> wro=
te:
>
> On Tue, Oct 27, 2026 at 12:53 AM Amir Goldstein <amir73il@gmail.com> wrot=
e:
> > Any chance you can post this as an LTP test?
>
> Yes. Written and verified, I will post it to the LTP list shortly as
> syscalls/fanotify26. Two cases: a mark on the overlay only, which passes
> on every kernel and keeps the test from passing for the wrong reason,
> and a mark on the overlay plus the backing filesystem, which is the
> shape that deadlocks.
>

Great!

> > Urgh I hate how special case this is.
> >
> > How about something like below (untested)
>
> Agreed on the shape, and it covers backing_tmpfile_open() as well, which
> mine did not.

There is no code that adds NONOTIFY to backing_tmpfile_open()
the only code that could add NONOTIFY to backing file is from
dentry_open_nonotify()

> As posted it does not fix the deadlock though:
>
> > -       f->f_mode       =3D OPEN_FMODE(flags);
> > +       f->f_mode       =3D OPEN_FMODE(flags) | fmode;
>
> Five lines further down init_file() calls
>
>         file_set_fsnotify_mode(f, FMODE_NONOTIFY_PERM);
>
> and that helper clears FMODE_FSNOTIFY_MASK before it sets its argument,
> so the inherited FMODE_NONOTIFY is dropped again. The backing file ends
> up at FMODE_NONOTIFY_PERM, which is not FMODE_FSNOTIFY_NONE(), so
> fsnotify_open_perm_and_set_mode() does not take its early return and
> still raises FS_OPEN_PERM on the real path.
>
> Measured in a VM on a defconfig + OVERLAY_FS + FANOTIFY +
> FANOTIFY_ACCESS_PERMISSIONS build of this tree, with the reproducer from
> the patch and with the LTP test:
>
>   kernel                        reproducer    fanotify26
>   mainline                      hangs         1 pass 1 fail
>   v1 (fs/backing-file.c)        ok            2 pass
>   your diff as posted           hangs         1 pass 1 fail
>   v2                            ok            2 pass
>
> v2 keeps your structure and routes the fsnotify part through
> file_set_fsnotify_mode() instead:
>
>         fmode_t fsnotify_mode =3D fmode & FMODE_FSNOTIFY_MASK;
>         ...
>         f->f_mode       =3D OPEN_FMODE(flags) | fmode;
>         file_set_fsnotify_mode(f, fsnotify_mode ? fsnotify_mode :
>                                                   FMODE_NONOTIFY_PERM);
>
> One deliberate difference from your version: it inherits only the "no
> events at all" mode rather than masking FMODE_NONOTIFY out of whatever
> the user file carries. A user file in the HSM mode (FMODE_NONOTIFY |
> FMODE_NONOTIFY_PERM) would otherwise leave its backing file fully
> silent, suppressing the events on real files that bc2473c90fca
> deliberately enabled.

The problem is that I wanted something more generic and v2 is
still very much special casing NONOTIFY and much bigger than
v1, so there is no gain.

Let's admit that I gave you a bad advise and a wrong sketch patch
and feel free to add to v1:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

BTW, pls remove Assisted-by it is not needed and remove the
newline after cc: stable

Thanks,
Amir.
