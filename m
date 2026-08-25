Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE9B3DD873
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 08:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787646074; cv=pass; b=e7g0uAmhR3W2Uri+H+1S+1IRahwf56JEMEODF6kf5l3un5apY2ynRduL5idN9WeMFdgD+cRL3miyVeudg0Au0uARNcLgXZ3YH+pye/msf+A8FhVS/eX2pZ6jcygn+8nepQk+MMVFk6nK6fC2v9mr/aprN7zDwIqglFEjCz0y09Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787646074; c=relaxed/simple;
	bh=hDhVjHWeD+vOQmgC4z58IxWumqKfiwZHj6VETFpThTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u3c+zhB4cjDtJaR8vilVzSfsQ+gmkism+9p9I/ae8ZRtNORBX0qGx3VbvOh2ko6qiQ8EsZpQzS8+m38FC8pBcg1cZReR9BLW1Y2s+m33/JkEIpgrVg6YkASv3BBqdIFxUHh+hfj2eaBHLEFtFYRyQ/bDYqyNZBbxXQ9xwA8C7BU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Q0qVHxL/; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Q0qVHxL/"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-52b3934af3fso48819411cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 01:21:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787646071; cv=none;
        d=google.com; s=arc-20260327;
        b=MScHgkS53bc5OWjlTqRrzBlRGEwpJKJyDPvVyVBRGLZNIie1nTR/q5SVCxa9HRv6Fi
         8vSasijHhiqQvl6VR2/jestsS5T9du7OxzsxJJYShu4WWgVWZ1Ch3Rby9Cigc/LvYTSp
         NDedDcY9QC4nuHBfFWwYoKO8I+kDqsy3Itb3f8spyqVhLiTncBj5oR/g42gm7ZlaM5Yr
         8voEKgkJ+Xh0ZXEvX0zpQR7ZmrfUQhItSEJw4k0nOYL0uF8Ca/SQ4Kc/Zp8eT331RpqX
         ccMC8vbD+irSdTudRbddCAS7BOWuNAKoVOaCNEo6TTN1+eUFIx7MnqVWDjlgSOS5eJZc
         UmEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=h/Dfh1yP/dbpR38H0TxYQT1BjjfVbskJsYAFPcy6FdU=;
        fh=rL8/l05mMnpvr7xaTxJ/aUO7fsDpVFr6U5fliHmS7hk=;
        b=oTaITBmwCHPkcMmHXzngkecqvsIx02bgFNuLXq9ePvbqIJS2JdaYBWMo1uowxPKb7E
         uXAuo35XauA/jY4XIhSzXolUlayHnXCFVpmjoEmaAMbCMmtNOPIr5rjXHUAoBOYQZSrx
         JzYaRVt6wIFeAuiPJmu2m95Tzx9voX6lrw3dQFGB8tHuXrPXhX1Dgp570QypjzyzjKb1
         d8t+aJKJ14I7c+GbkA7JFILG19E81p/wVotdz3Mv/I1XiZSiLkb7thtc44R8xYnEL9Vr
         I/rvdHNAsriHg3zLv5p797dPaiNFJsVZi80kM0rnmBuhqxolhjfr4el6zuvZjJskTVio
         6cWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1787646071; x=1788250871; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h/Dfh1yP/dbpR38H0TxYQT1BjjfVbskJsYAFPcy6FdU=;
        b=Q0qVHxL/Xt7oxrcSumONXp5cAU6p1XBpp3s9/r+cqLLvSaHU43XQ4khThcMrCH42/Q
         JzlWWpd1kk9XP/9tBHxKSbHMx2rtOkQoZWKpznulW7wlv426ye21OPwXxLELbUbBHY5M
         IhPcEw1kZI+6AWJneKftoAYo+f3iOU2qhKOjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787646071; x=1788250871;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=h/Dfh1yP/dbpR38H0TxYQT1BjjfVbskJsYAFPcy6FdU=;
        b=WXN3OPVRqhMHrLGlQn2OCUAMpWPyh22zqsYpQ9c0iE4uqm65NpS1vBSk0MW8/Ial8u
         ECC2cOhnBukz0CBcCeoyPg2csLmu6bjzY7um4LWwwHNiI6+zgq4IEgORd/SLPNF+6B+b
         JgZJc0x0yEbxKA18rQA8WlotIGntrzsXJ0t/p0M+4Ehdl0F/+RfShP5X2UFkiZtINC/t
         1YfwIszyBJEP8p/0Wfyf90OVWxytuTyuOuZV4BcTlZ5Ed5Ucu8+sSPlSsEib8C5PusOT
         vzk2W5m/kBasr6L47qJQZ0+eomXCzBESrw1vMJPNZMkLEvQDc+K1sVFrHhpo4vgvZcZ9
         Y+8A==
X-Forwarded-Encrypted: i=1; AHgh+RpXCUdvF8bVY74ETdCGTOY9GP0XYi1b6KRHFcI5emyW3WZU64ArCwaC6Gt/5zJszzdg+G+3j0vqCB3ckCvm@vger.kernel.org
X-Gm-Message-State: AFuF++m8+5YsjckcPd+fjVK6sEks4UIGF1LakTPx8qqDLhnxhsZhu05P
	h2JxGmpNVWgo+OXnLWfLWCLs7i/87sm9tAOZ+YKetOAOon1d2HqenMiPGdGe51rPgCEpkSwzDQl
	3nR1nxYq3fq3rGd9MLZ9MFYVeucqFa2L/FxgeouvteA==
X-Gm-Gg: AR+sD10riDNQSUxQK3wdlxrIXZEHlRhTfyDeQ4pXrQ1kez0uCl0K8dEZn0UBRIxtShB
	phuCXGEEW+EpAX0bH2+jJJo1bYvzojxBXVM+GJ1ejDkPgPxbVJbjvytDqnlpTnxRm/+jAqqSX8c
	46GWtf+QBC68L/YxZgJPN+kyn3nugWRi2FmQtghS7JELm0nTDIrqPL838am21p+RKEbBzf2ILcK
	zz2kHXRNMkdqsdrML31zAz2INrvMVCgS8hHnMLQe3SuGtQNYVLiObWGx8yrQ7WqSGvsfbo8njYY
	jHUyzmwrD7ckjC5cPlse1sXyjInylwCU0cARAX3+NeZA1K//IYJJ1ELFR+YAEyny6Sll50rToLZ
	zeaWs3cpQjLiwbg==
X-Received: by 2002:a05:622a:5c07:b0:51e:47a4:4851 with SMTP id
 d75a77b69052e-52e2f05e2b5mr58533261cf.8.1787646070711; Tue, 25 Aug 2026
 01:21:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxhX_neohTAjZDOT0oSWC-JNiqNWqnfE5YSa7Ln05QPQ-A@mail.gmail.com>
 <20260824204534.1951414-1-fahad@codepure.com>
In-Reply-To: <20260824204534.1951414-1-fahad@codepure.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 25 Aug 2026 10:20:59 +0200
X-Gm-Features: AcwNN1Wyja_Sfk151tzL1ijvvilYTKKAzggc0scqSPguVOvNoswa8jrEVndIrBY
Message-ID: <CAJfpegvbvmznSSdjZH_XqrGZHWgwb4fGux80h02ncopBC48RqA@mail.gmail.com>
Subject: Re: [PATCH] ovl: fortify ovl_copy_xattr() against underlying layer modifications
To: Fahad Alharbi <fahad@codepure.com>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, security@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Aug 2026 at 22:47, Fahad Alharbi <fahad@codepure.com> wrote:
>
> TL;DR: your patch fixes it.  On v7.2-rc6, FUSE probe LEAK -> NO LEAK, and the
> unprivileged tmpfs racer goes from 78 of 5,000,000 copy-ups leaking (5 of 5
> boots) to 0 of 5,000,000 (0 of 5 boots).  51 of 51 functional xattr checks
> unchanged.  One behaviour change worth a look: under a racing lower fs about
> 6% of copy-ups now fail with EIO.  Tested-by below.

> Tested-by: Fahad Alharbi <fahad@codepure.com>

Thanks for the detailed test and analysis.

Miklos
