Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64BA3AA4F9
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Apr 2026 12:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775564997; cv=pass; b=YU9gUaFUtEkZF3c/obrntaUY/NWvhpoT7L87MMkpExaELUlRxDhvC475l5DfCFAkpR5wGY26NT8oTGQrPfJF1q3juEalkfoIFJcYytt0j5sNFWr1MJGkpsj0usIhoOwOMoNo3EU1DgF6d61bSBUtbxqTn0GQ2J8KQAP/dAZYReQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775564997; c=relaxed/simple;
	bh=UdeWs6w4pyYppJdWEkOzIWQs+GkhXkGMndfV9cAFA9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ElcpWjhcgFo36S7IAKnvdK9i5PpDuPCPbVAluPgelX+7ZTChGhPC3gjrLgfgo8EdUChmzWMR6L2Pkd91M4O2lWjdreB9K0SlhftrxePoztSkEpvdDlJvJoTvi+M81KclzhC49/hiS+kW08lD1D7CgLxLZhNTgzDBrbojBk6OA1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jgy6i9t7; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jgy6i9t7"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-66bb4d4fcb4so2326544a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Apr 2026 05:29:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775564994; cv=none;
        d=google.com; s=arc-20240605;
        b=UwF8jLtCEESR94jgXzgdW4kFGILrkzZh6SCq3Aj29AHPGpLnEV8AW1foXfxHEnmWaT
         YLN44Xu/21LjERa5XyjD5sOLtd7bIxOc+C2hMxRJ+UkPPvoYvi+CmnxfvinoujVZ0mbQ
         vmY5+0gi5arSUFrJwYNUROrtTOnw1qTpJuOpY9sWiLsd6BwPb19d8qL4Lm+Aj4TV2bx2
         ycN1sx5U4Ol242tyQlN+lRPEbHzP2RO/+cF/FMf+bnSGw8ivtDkR4/i4j0K65FhPohZ+
         EvRtuXW3zhiCC0brNMMJeUgIUCmGA8TIrtruAW/4iidtDxwQIBV8a5uVAStGVSR6XYNI
         ibIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UdeWs6w4pyYppJdWEkOzIWQs+GkhXkGMndfV9cAFA9w=;
        fh=U5ORRUikbD51UkCivGpmLRfiiUAdrv4DbFFkNWNg/Kg=;
        b=Qqvphr2UQccSWsRXvwPQUzGn1RFJC7lHrvpksWo7xm7Sm+ekLzrJ501OsKxPLA7Lzw
         owQ0eVu99NwQkS6OlRHgtNGIwAjwzTrBpPcu06xPsujxkC/YoRkoYx9YwJyIadmMtWGu
         SaGbvJVWifNG6AlF5LnnjmnIXfAxi2qjaSkDHNoUQkaI6KBoocyzv1c61VGaMyUIKzLi
         NkcShhdbEOnz5rTKGyJ1w5p47aIPSfKatKfzu6KtekEOB7NxlqGJHjXCVwIojeTNLHu+
         lYscpSNQK9pJvgTFYg3AxCQ5KyUu7/mMkt+k5rQkgOyzeaTfSH8qAYm/kPsJQCxic9Cm
         a/UQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775564994; x=1776169794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdeWs6w4pyYppJdWEkOzIWQs+GkhXkGMndfV9cAFA9w=;
        b=Jgy6i9t7IGxhtGkc5hKhpdvYM5XZPfxhJJ+Un5MIRq3K8pAKcJid2S2s51OBgFzMTB
         DGLBBNTOj5bLXjx3iUBk25k0I2Fy5K6yHYxCFoDZ87WgGmQKO69Nd0x3DgIpRmxJxSoG
         xIfHYgdpOI0KJto+9CRzvXN5viVuzQ3bNuRGt+IxbtRdTMZCi/TXvYbNJJy3r694Ps0n
         iITUL91pBXYl3Futr8akHSxqmh3mB2vubbKhU8RlirO9GPCVLccETlv7srdypwvI8c0n
         PBiuE4BVurXNR3FtrmtBcs0XdtzgykReQ9J7lBaWb/KxLfl4nDv2KmrTR5hSwnXc/sHu
         Qzaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775564994; x=1776169794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UdeWs6w4pyYppJdWEkOzIWQs+GkhXkGMndfV9cAFA9w=;
        b=dZFsIwaWJWgaAY8uGGIeWuQbyp8hQSpgS5E1kfebCMksZjCzc8nEPU0BjvAuJ7z5pj
         QGQ8UtTGJe1Ft6umNW/iBPIXohvQLeuxoid7dpXiltjzd/h1YVQu3Clgh21sYS8oJdi/
         WNOIG3HZXusLCMP6spx1C8YrAbKdONnNhrDoD8KZiJ2TAltC2MqkocOE9rHq1LYjsBxf
         Nd+E1TCt7K5tZVnMpj9XT4qEmhrrHhoErNKBPdvHUCA5lCZrlWzr8aWVuorSdz97jiFs
         QO1FUPZrmjcX5lmUV41kyBQ3eeZuL++NnGTCJQ6pT9FxJiRCONu/P/YZD+ud2TdjLd3H
         7t1g==
X-Gm-Message-State: AOJu0YxcHlMcSxcbPk7XGPfL4a7roTeSUjp1mSUtYRnfN0sCto2PvYKm
	EC/w3lHV4vxj7tOas3pC+JyGaIJ2DK2I2c7bMCO45z+v8EvxlqOTnsKCIyZXdm9fC9XX+cWyE7P
	R3AMdzyysFHD92xwQMgoLUv2IC/vLFfg=
X-Gm-Gg: AeBDievpe9nB2GMqeMNLIbb/M/MTs5L2lmjQcfzMuMCCK3uQl4E1qu/p1tHawavFNTV
	16x90yLwVCdFPthoJRRcxNjo+kIeHBx1ElQ0xUulT6mxXzHX6UpucwXhnPZErMcYldQCNhf102m
	yTFiSFXcB7ZWb2wxBXQ5Fa+nyy+jnpmlctvw3OijJXjHDOXYpWf7YtmEJlZD9t6JpEcJ80VTTG4
	TSybEGKbkBIKZRA23DwZM/nzQx6ENoFA1XJ4e7QBOCj0vNjruA8jZOKaMLMzKtnjpDajhcB4ZBl
	ZV/dwjuqtB505iQIZkPykuK7jBVS5Px1FowKq4pPEA==
X-Received: by 2002:a05:6402:5256:b0:66b:aa56:ee5b with SMTP id
 4fb4d7f45d1cf-66e3f85414amr8020225a12.28.1775564993925; Tue, 07 Apr 2026
 05:29:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
 <adTyw4UJ04qOggCQ@amir-ThinkPad-T480> <c4ffec34-fad0-40d9-bff1-06c3cd202351@bsbernd.com>
In-Reply-To: <c4ffec34-fad0-40d9-bff1-06c3cd202351@bsbernd.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 7 Apr 2026 14:29:41 +0200
X-Gm-Features: AQROBzAG8nPjs3GCcMJNR6LuKfolDGuS14Aqzb3Ls7E1CM8SB9lkUU_mYR4hnCM
Message-ID: <CAOQ4uxhBC7eTkaB6Ws1DqewzxkGdEfcCyJ8EZszn+YeHwG0-wQ@mail.gmail.com>
Subject: Re: fuse-devel list on kernel.org
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, 
	Joanne Koong <joannelkoong@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>, 
	Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 2:25=E2=80=AFPM Bernd Schubert <bernd@bsbernd.com> w=
rote:
>
>
>
> On 4/7/26 14:04, Amir Goldstein wrote:
> > On Thu, Mar 26, 2026 at 10:34:33PM +0100, Bernd Schubert wrote:
> >> I'm taking Darricks example here and posting API changing libfuse
> >> changes to linux-fsdevel. We should consider to create a fuse
> >> specific list if that is too much. The existing
> >> fuse-devel@lists.sourceforge.net is rather hopeless due to lack
> >> of spam filtering.
> >>
> >
> > Let's do this already!
> >
> > https://korg.docs.kernel.org/lore-archives.html
> >
> > Do you want me to send the email to kernel.org?
> >
> > I suggest that we ask for fuse-deve@lists.linux.dev

Just don't copy paste my fuse-deve typo in the request ;)

> > and then we can migrated the old sourceforge archives
>
> I'm all for a new fuse mailing list.
>
> >
> > As far as I can understand getting the archives from sourceforge
> > required the admin password:
> >
> > https://sourceforge.net/p/forge/documentation/Mailing%20List%20Archives=
/
> >
> > Mikos,
> >
> > Will you be able to handle the archive migration?
>
> Have that password from Nikolaus.
>

Excellent, so will you be sending that email to helpdesk@kernel.org?

Thanks,
Amir.
