Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com [74.125.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9297377A93
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 14:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790691319; cv=pass; b=ouAX1UvSI9tZWs8w1G4Q6zihO52NQ6rEjQgIFkt247N16vbkCSIdmRQTjuycYtIk5AnAgp23r192PN/GPO4h651t5iuqJsIlHdyIdQ1ml2L8izF5UcUs328lUmYamckmDR6cj0+EwlqHNwuvFkBDwxvQ51vfWZya5PZG3GptjFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790691319; c=relaxed/simple;
	bh=WNPiWlZ8WpoGHZK99aHcbTTI4gKFUrGP6Bht4p9ETqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YJ8cCC+07IBK7XEdYUNHNzXDntTxBKnfHtsl5uHcAs35K98J09qe3Ls2+9tKzLOHspRppaK2S8FkQuzremKOp1a2tYLtBcAopsEL7rPJXPD/Z5TAzYbtFanOIBOk0lLS/IuBkYUVKaEX7tSCSes9pxFDxZOb15uSSJ+l5etdW1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5y2zrvd; arc=pass smtp.client-ip=74.125.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5y2zrvd"
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6acb91ecaccso961961a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 07:15:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790691316; cv=none;
        d=google.com; s=arc-20260327;
        b=DnQ6dzPAIyvIsbFCdsiVmOlt6TFI9/kpJ8/rCV07fti6siLNeg2G/yG3Jc1Qlg+aqe
         v8ewJWoJf8rDTPPdSCskjNe5UEZ6wKEVjYG/HymnQOksad8eaIq5mat8iAH+O/w4e8sA
         55thUKAgEdzYgWtcwtDSkQn5fqRdlG+9G/FRdzUra3OQKLhqvqKxd7Vt7j/L6vcvIfgw
         qOLcNwSu2nh7stTzU0rxBO4yrl0SuZxWENhrXiOkQDC725BvkT75OV0Is1vC991m1mLh
         0Wz6aE65Z6WbKG+SmMpHzKO+SOiqLxaDjr0xzafJlzVgmv8ZUXGbF10BEAj5Dj5aLLo8
         MDVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=trsZq/IgHnE0dFOaiSMsY9WGT+wIu9sqLXFKuCxoh54=;
        fh=WZhX1q+rrynwDa+s6aYoF1/2F3JP+ucX6SeGalb8nzo=;
        b=Iee1mEKYNdVzYxa002eyVYvvNEvxoGmk0BKjOxuum34i6iuKhhkvoYhrMDXkFIcRdi
         W4XObegGHcRCAEQALY6NUPWIGN2FoI0t9yzH8kxz0wyoDP3alat1DDxXQDKWdacZ2JWN
         2MiD+mA8MWmA9Jcho6l7A39oDfPSEusfVn0A8RPC5SVqpPiSz4pMqR/62PnEADSOlTbU
         jFzAZaJC609fgTutiwbatWsWvHKDn7qmhi0aMwVpRJraWR8EUN7fFwK5lhFufgjZeBQC
         /DCPcZXnjMJQ+ux6KpfzIy1qUiVhLEKD+wlm7P7SBH8L2WXHKnfyDTH4aBzJAiGu8jDE
         c+lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790691316; x=1791296116; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=trsZq/IgHnE0dFOaiSMsY9WGT+wIu9sqLXFKuCxoh54=;
        b=m5y2zrvdfKrrDlWmbGVWkbKGlBSJlMpl4+t0+q1faSnSoOJXN6vDuwrx7Q5hAD3Jpa
         TY1linw7bcIDan8EjtIzhGgc+cyoOOwyRE9RzgVeKFdxqJx0w4V70OU8Hj01JopcA6Hn
         WUcTqIB2KUfNBRFKNWoiCbphBarMs/ugh+VFmI9cyBvZd/KaML1Tx0RbvsQGKM0Zw7BW
         7Pw7XjOq/uRJAEVaeBmKNlOq4oCWmiCOwzzEWoGrPOkTbvUPc+hZQDS6ZR8C1hSEvJ9h
         mJ2XaYaEL0wMf1AGO+tJPkEy03kCRy0RMlpqaxhBeISH8gpSJDejJ/lXf8WFf3CQ9Ewc
         K6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790691316; x=1791296116;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=trsZq/IgHnE0dFOaiSMsY9WGT+wIu9sqLXFKuCxoh54=;
        b=e4m/zDmuGaxwnNmhYPpCmN5clV4cHSk6YwVrgDk6xriiqoX5y7jEi4z/ppF5NCLURB
         eC0BReaGcsgq9QTxb7X/tY1KkWHh7aAVIwloDoN0ukGhZkAfl9jihvdOsGpCfX9kdJhM
         RPXeKPo+G10dqg1s+l5U2lfYbP/58SkKk1if7mLHbmUixI1WMZ2MmmurPUN4pHw31WQW
         ZdHvmmUkIVF5loWc3DMrBavFWe7/lmQON7Quj80aWEBUOoMLw36QqS95+1y2xW68afAy
         f/yGtqq3ZHrRf82lgsz0sRSSoYpiAYPkRD6PrWTksln1mG2vtJVnV0ky2KO+nNb1Gqja
         Zy5Q==
X-Gm-Message-State: AFq9FYKgeN/1e/38+vwB3iuNuxks3v8azmUwqKgmefpHnm02lJDb+Xq6
	9srDDCPF5vHDF+eZIy6hewFha1Hgr2yzzYOF4HpS4Huk1ZeM8hHuDV+PAaxCEeca6hARX6kUL2S
	k5+ztlRhzHdc2c+jsDln8Xd8Uq+9pM2g=
X-Gm-Gg: AYBFou1jVtn/xNhT06R2uDmJP5XngA/80khFvuoDLrELlEZiitSYg5y6F6H0SQccS1t
	5d5fj01XlSFbUhiCXYsD2pvcYqLR0qja7CfhfaulK965wP7PlksVtM7FezmlTfGskq6n+qfoPVU
	Hwp2KnlR8ZTUotJleWK4jzNShvX1aECgG8+IABSGgpmBOzmy7zG4wcvgIsHkPqvGB1lux1OQiGb
	m142lE02kgaZjomTn5eT1D3cmAvhsDsDMQGnv90ZeZNAmnzQKofT2/VafzzdS7UstRB/mR6O/Yp
	AHmG3zYVS2YCHr1B+aZXSvfxOS0GoDdzxOhAkqWbH+u3ntxF5XPVu50u
X-Received: by 2002:a05:6402:380a:b0:6ac:bd84:2b84 with SMTP id
 4fb4d7f45d1cf-6acbd843b1fmr1090820a12.34.1790691315590; Tue, 29 Sep 2026
 07:15:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928213155.2612039-1-krisman@suse.de> <20260928213155.2612039-5-krisman@suse.de>
In-Reply-To: <20260928213155.2612039-5-krisman@suse.de>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 29 Sep 2026 16:15:04 +0200
X-Gm-Features: AclHuK8ytKjl4O38jVPReRqXBMm8kcLwbRELyjNeXdrdxLC7F0LMOcN0dvJ9ryk
Message-ID: <CAOQ4uxj7Vx-UGvgGGr9hPC0qUgJZ_WRAv1ZLi=gJ6r=ZJW0QAQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] ovl: Expose the filesystem encoding through sysfs
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>, Hugh Dickins <hughd@google.com>, 
	Daniel Tang <danielzgtg.opensource@gmail.com>, linux-ext4@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, linux-mm@kvack.org, 
	Chuck Lever <cel@kernel.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 11:32=E2=80=AFPM Gabriel Krisman Bertazi
<krisman@suse.de> wrote:
>
> This patch reproduces the same interface from ext4/f2fs to have feature
> parity, so users don't need to rely on parsing dmesg or trying +F on a
> temporary directory just to check for support.  Note there is no
> encoding_flags file, as none are supported by ovl.
>

Gabriel,

I am not ok with this API.
It is wrong in several ways.
It is not generic, we have already file_getattr() to get casefold status.
There was a suggestion by Pali [1] to get the supported xflags - statx styl=
e,
which can be a way to say if a fs could return FS_XFLAG_CASEFOLD.
In Chuck's v2 [2] FILEATTR_CASEFOLD_TYPE was already suggested
as an extension to file_getattr(). I think we can still do that if we inclu=
de
proper versioning in the casefold type.

TBH, I don't think anyone requested this - you only mentioned
the need to know if tmpfs was mounted with casefold on and that
doesn't mean that etx4/ovl patches are justified, but ext4 can decide
for themselves.

The point is that this sysfs is not going to be the standard for all the
fs that can return the FS_XFLAG_CASEFOLD, so I see no reason
to add this sysfs interface to ovl.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/20250216164029.20673-4-pali@kerne=
l.org/
[2] https://lore.kernel.org/linux-fsdevel/20251211152116.480799-2-cel@kerne=
l.org/
