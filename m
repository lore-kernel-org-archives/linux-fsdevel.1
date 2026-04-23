Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512331F5821
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 07:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776928856; cv=pass; b=XnhhG+7XoDhjP5fP4Oaexvo3USaYStr4YYayL22/7vMiXF/f+bkMWqQwKzZtPUtJHrJZsm94tZF8lpxJD89OH4Oxxom4lXQ4eMofgAGG/AcEuAnGYcGAzVQlO5f1EcKnilcY3dnGd3S83dBLWi8VCS7VQEvOT5xc1a1fwLrZkss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776928856; c=relaxed/simple;
	bh=Kynlk3ThA5qwF/0+ADnmZYcZRJ8gAKkHNFPxAd2EGvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dITx9a+aHDddORk1YZFCF01XkuQLQxwkr/pNhyn2CiorS/50xAyKp+TzmFCo0am5RtALpJRNj+kUqQsqSK31HkF6xV5FNsuxiTGL3DcHhIDeXgg8snHT3ni7ZPrqzHewP8Txcghg71pqBgAzXUwduafQl8MCkyFlgZFzAhCT+u8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=nsRyPKWj; arc=pass smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="nsRyPKWj"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8aca2726f61so76572376d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 00:20:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776928854; cv=none;
        d=google.com; s=arc-20240605;
        b=OnyK9Cz6Sm5h397nWxjb83MnPCq5GxX0sjlY6Bi9SOy/kJWRYiqdgPszROAr9AAHdw
         2ObttfBsBtcmzr+dEHcWIm2jyGn3be+0jVuKQzBYQSIbjj+SaBPIym0qoD8GigoXv1Yk
         giy9JoWSfgKNFuc1c7fNqqzZJeMBBBnpVVL+QJph/Pmo9NWGIx5MRw0AR8W97AHUHjQa
         160SvT4s8KTozOwngXWTlgp2GmbFI+8UKD1eoFl/LTmEv/WANm91fLBQYG8uptfzO9A0
         myhGO2tD9lZfa3tE/hnP6cvUDuQvSP1UUKJ4Qhsd/Tawt/u2lRxzp+h6BijQRBkncKhB
         ZqlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wXvIPI6ZSng0Sr/kVOMhLEpDnXdWNurgPCVFV7D44Gk=;
        fh=WZ0/r5w1aOriidDph9UJ4IlL7IyVbfYi5O5hLvez+a0=;
        b=DU4UGT5Z9e0Kybs2x+BJXfNOi0IJd3ezaDLL3uGD8C7FWnTdjHGD1QHLComwX0Jo+l
         xLbuXIeGFFsbQJ6t4cCxJgT2hShp2EqZyLZvy4TPxsgiaNOtcpBFYGlb7AjvxpdqM/DV
         xQD8ilP4lRE/KVVonjCaFmNaQ5/JvewSvmUEQ7OrIpPRca7PKJL1gfIpuJGNnwnPxula
         +C9gVa+195afYPpzK+G2Ol5p+vV6wQPXXmTGSXiNLrk6tiWGImiX02Lh1jBu/vUZgokw
         bjIG6+RPKEkrJ8vWx9m0Tta7QmDly1VNrJhTcjS4NcI4XegC7iQokMO1xM0fF2qFdCC6
         8vOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1776928854; x=1777533654; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wXvIPI6ZSng0Sr/kVOMhLEpDnXdWNurgPCVFV7D44Gk=;
        b=nsRyPKWjoySQ7wr1+NiBgbY40GOvFkVG0p+GK181DxJjyzWTiwbEULrs1ic7jXe/C7
         Bl20jRPILHLgTi4BDukNtAErjvIbujXnjZtfr96Ar5NZI+bJ7m9Zf3xtFJLvYNQZJpu1
         7JiUlxIpmgGZeOLzLebVHqDnVF+5P2usKsJ+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776928854; x=1777533654;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXvIPI6ZSng0Sr/kVOMhLEpDnXdWNurgPCVFV7D44Gk=;
        b=A/B7asOc2vWgZs2GfeyaNRDTmG0hvZvYasgZzctD9J2CdlhLAeBgEfjNxh21PBNwF1
         PZt8QpD2cyO1PDZSoOOkRSXj+I928cSz+eIEV/IU36Rv0jg2jeDEv2xMwWJTorRL5Fce
         9aQ70iaVU6s46NvB6z6io4ldb6r3mRn25ASzTgM4qkb3wF2gu+RbP9E2/6P4nO4kt71w
         oNA/RY4tWpplPywvNgr00eFy7UUD3yU4iUJ5plrfD0YRh3NBvwtI4/EHeRQxFBTiLQaA
         9WMd+XveVV3wuUn52iWLXgYllIB5Zu27Nao1JWST1zgI3Lky5Hl6RbHCCHwABT6WZ6vT
         1Mpg==
X-Forwarded-Encrypted: i=1; AFNElJ+sIz3JFfNvDkPBokt+onmO/qYZmYYwpob0s2OFdVB2VmIou5n5lj6Q0AcdAf+fWpcBwtf2fP9ll1ewJPbA@vger.kernel.org
X-Gm-Message-State: AOJu0YwGReHhOksi6jHo1eLF63eOFzUpziHyW3jWJdcLpOBXM2Z/c0Zg
	HMKNZzzzh7Ejd1VnBBdGbSxpp0ekexs6GGNZDKCN5qGtNnbIq0XDKskaP5mT5rNoJST3VuV1CGE
	otD76cEp87ty6E5166B2EnA/j0noGAHHMH5pMrd1TXw==
X-Gm-Gg: AeBDieuOtdzQZeI90Occcf/oVEWugR36oRUVPuy/AWThhPgyrhFXZLWlOxwP0STjhev
	CwPopo6cm24BIoQEtPP5/dJOxDhLbrTu/wH9t56WYgv3szAO2fGo35GSA3n80oaukfJIah3ZZgf
	KiiIAb6ywp6uevM+NVI+yeEr1UaCSasECCf/GzaEAL5KWD6bi+CvaKjMFT7Oxlp+VhJR2eX4mPT
	s9Mt/TVUeWqlrj4496DAJl04JaOuULayKcNxVwOXd4UFSw/d893UEu9Zempr5PfwmnyKtC6OHy9
	JVBLW5/StXh3yZ42aucOIbkXYwQckDCNArNLoqEayZv27aDu9tg=
X-Received: by 2002:a05:6214:4a90:b0:89c:4c6b:4615 with SMTP id
 6a1803df08f44-8b027fd979fmr407792026d6.8.1776928854442; Thu, 23 Apr 2026
 00:20:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416091658.462783-1-mszeredi@redhat.com> <20260416091658.462783-7-mszeredi@redhat.com>
 <CAJnrk1a+wEqZxgLDYJObfGiAiW=SgVvV4LgR6_PnwwW12t=1LQ@mail.gmail.com>
In-Reply-To: <CAJnrk1a+wEqZxgLDYJObfGiAiW=SgVvV4LgR6_PnwwW12t=1LQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 23 Apr 2026 09:20:42 +0200
X-Gm-Features: AQROBzCE93EyEF4GFLjUFckdPSGhMwPPhhYdVyfggLY4_wbt5kqW7ESzzvJ06cc
Message-ID: <CAJfpegtrURTw5MTbWuwRAiY24KXpt8z-HeZBj5nz96giBw_Npw@mail.gmail.com>
Subject: Re: [PATCH 06/32] fuse: move background queuing related members to fuse_chan
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Apr 2026 at 19:54, Joanne Koong <joannelkoong@gmail.com> wrote:

> > +       /** Protects: max_background, congestion_threshold, num_background,
>
> nit: should this comment be updated to remove "congestion_threshold"
> from the list? congestion threshold is accessed locklessly.

Agreed, fixed.

Thanks,
Miklos
