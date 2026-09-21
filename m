Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD3549BD9D
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 13:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789997292; cv=pass; b=K+NVWBVSYpB2wXAmOx7DvmMHMC69JFdXJtuHr8Mf1N8gqK8cwYHx9bir9cQL0XU9v5gYTVVEJMu6xKOx2Fm51aFHgOR31QNaObzVKi9uGiUHN3loevZmrbXrAvpNauNUbMjJ6ww9ZDsbTQFrgqwsaB/smCNHJH1LBY0cVKUGcQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789997292; c=relaxed/simple;
	bh=ayinjUi8Pgp9G+S1LnRNG4EOwgo3RpV/l+nq7MHooFw=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=knA59s+7dKJ2PC/H202ox1KF02L9zb4msp3+urvEne/gmV1zSXly1C/Vm49vmYfxgatnFXny1W45Y4kuSDcqhNn2biP8iIkg6qG/9CgQXEEMxSNCVRW8xOeAV+I3c9aQyzov4Mc5q+Yhc8ScULci6dGCIVGoUi4Vn+eO9dR2Zsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJ4RNPHT; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJ4RNPHT"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a98505364aso4904712a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 06:28:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789997289; cv=none;
        d=google.com; s=arc-20260327;
        b=I+3ZfsTLdmQxZChd6sS2/yIriadWyz9AnXh5EEb9hXlttriN9aaxpR2A2g9be8MXzz
         /qvvgjJX3iz+Un9ignqNZFKD7I20O2CgkJibyDtlqqe79sMM73b43UXeqTY3Xj67XruI
         UXIjVP66ucHkgYcTf/icJWsHWFVieFrgs9Yll/JLDMxmg2xopuI3ISE2e003HfxvK9LW
         MReavlWA8QxlCIyNeOXllodGgO06+Ajz7fvrMexpLYfC5eo7BuU1mZ/x+cnh6F0TWIfh
         5oLf+J86N+vfteGRAKIBM0VBdQLc+wFjtPfEKGlCpBerfALJp+TrdWPFNvvzmW6SV7xm
         HHgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature;
        bh=ayinjUi8Pgp9G+S1LnRNG4EOwgo3RpV/l+nq7MHooFw=;
        fh=InKNPadVDVFNtjh5/mtC5c0bfppPw3KUHsQ3mhlR8a0=;
        b=p0Bqp1/cy8NvAFcP3OFTEKgNkFtWUZvsdOoVd2ViiRBTZgI0TeEsgGzAJ/5J6Lqgne
         OWChZOANKs2X7YMDKAyAm++vBzf5AdgsQYldBWjJvSZjdNXeyD6ON7TdXlfAtwAB2JTX
         x0WRebZrXn1VC8JUWXZXMr1IK4BUDWV0GQQQ0hLANNH4fdodhRYlI7qwcWvWuYFvf0/8
         r9VV9b8HtLXQ6FRHiZPlmZNG2DxurbTVu7sJ75SbKFR3OqX4sFTifRwdpwAYGtFsmFPx
         vW0oJUVpPhlORsEhJykktvEGOPcPPyl+A1redVheso2Dzxeww6ArufK0N7Wot+o2dQ3X
         hXsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789997289; x=1790602089; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ayinjUi8Pgp9G+S1LnRNG4EOwgo3RpV/l+nq7MHooFw=;
        b=nJ4RNPHT2Tdrpq8mOOplE6tLzDf5+B/dgdK5CYpVR0I+5CknfJ8TEAi5eWt1qPh7m6
         4me1VDPsGCE1LpwhIaoTIzeP4aCHxmY1M5JleDB0SQEgzfzB3nXXWArHypw1vnX1TCcJ
         Sjv8KIIQwlt9XwmEbx03hRBQWqoK/rsfMSfwr3TlQD6I6eV2r5T+bZ2J5K+dpilGTcBU
         miqbKkoU2qhSJai8Uh/CJhJpmcw9R13EMcRpEsxXIfe27oHUoJ4vcIAA/sRzllqFddT0
         A+3j0xPaixl7Th1xPWjgaGVuyg6d4ZrqNTcQlyu52LmvB+zkUP9RxZgNATnuTFNYqDW2
         Tw0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789997289; x=1790602089;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ayinjUi8Pgp9G+S1LnRNG4EOwgo3RpV/l+nq7MHooFw=;
        b=xsaUjLuhF0gFfz1dQdO9LI3DP+mUVKGmsnRFHTHMU89YOSXhv2bt7fyYxAGA+tD24a
         daR0Mdm2qC7SiNNePr0iOSg25KUStoi1/IjAKoyuG2tfSHOIAR9SX6P29tNApzKeJtBh
         eGfA1fHrIkIu/I9dvmzUpDil6J9AeIdgep9oja0n8CWnS2khDBslGThwFMVE0fXgTJyQ
         eIBds7vBXD/79EsRH7wiACT8Is15K6B/+KLbg8TL8tkXDqYuhIBQolLi/Gtk3HJ+vbBz
         uf67AR7saOU3n29p9TAj+0p70QGP6h5/xOpdRxAXdYC/MVbZflzLuaYWFGPMt+oP+/ir
         fHMA==
X-Forwarded-Encrypted: i=1; AKwUvBxWzOWTId2v0T9x+lei6sJRsrTR07wyJf4trGrmA2UjN3U9ktzTgE1v5viPJUMinj/hV6RtvkGmFnsvR97J@vger.kernel.org
X-Gm-Message-State: AFuF++mMSifaIW16bYTY+gXAu7DDTq/3ppUEL2fi1dVoXfMO5aLctUmd
	outK2HD/y6NFGuG8K5hsDpQ21NCJK2fsVcVvc17+Z6IWKhYavvHe66N5t5yPUdLgTBstgqJm75m
	ygrtgwoqWV0fvroAW1ZI9rqhb5ZfMN9Y=
X-Gm-Gg: AYBFou3nP4mPQt85pSqnce4QxKAt+02vEWkbDmAketONSO4fvZJM4dHH1Lpp9difmus
	Odff8JuPgSxuiGQFVkOxCT7z/tF95eLH5indVehG51Jflw+Z1soi7aSTGH9iApZbRM7nDR9VUER
	mSscGac3stwf8GKuNg/5y9Sota5RSiGaU5MHSeTZtcmklJ8QH9jNrc7s3sHxCGyozNLqRS1mjeg
	kIM2LgujOBgqCDaNmXaxH2LGS9Wpxg//6o1C1LfGOLsTJ14vsdbCJDQpes3zpbCJV4mYzzrM9ce
	1p+Mgsxwzo6UfVswjxPHTQdKZsWOlrSzyzL9U743JIkE6YS8SrH+h9edFg==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6402:324d:b0:6aa:4d8d:a08b with SMTP id
 4fb4d7f45d1cf-6aa5316a711mr6298513a12.14.1789997288686; Mon, 21 Sep 2026
 06:28:08 -0700 (PDT)
Received: from 292895732794 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 21 Sep 2026 06:28:08 -0700
Received: from 292895732794 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 21 Sep 2026 06:28:08 -0700
In-Reply-To: <<arEkgM15qewERAOJ@pedro-suse.tail5790ac.ts.net>>
References: <20260725182628.221603-1-nsd.project.dev@gmail.com>
 <CAFLp9PEQQVuDpJPwrNvLN1-u3w3TMwZPUUrf0+rOBrvDjBBf1A@mail.gmail.com>
 <anlByPDZmvEhWeXI@casper.infradead.org> <ffcij36vnozf3rginqd2opd2dwqyki7xhtdo4veuty734hhgba@utjav2k263o6>
 <nsd.1787001235.35928@mail.gmail.com> <w7vte4itudtkw2yf4vbmuofiumfffmp2y52dpu2bqvqtdgjvpd@5femyiozss3e>
 <CAFLp9PGkVYZcQT5qAx-RKFOF-urZ92m417zpAeF7ZQempbS1HQ@mail.gmail.com> <arEkgM15qewERAOJ@pedro-suse.tail5790ac.ts.net>
From: =?UTF-8?B?YXloYW4gYXlkxLFu?= <nsd.project.dev@gmail.com>
Date: Mon, 21 Sep 2026 06:28:08 -0700
X-Gm-Features: AcwNN1WBEO2eUe_0S1kQSTFGaynIVHRfEIP-ijo60mrzoXWfLkGAo2lMMObTUKE
Message-ID: <CAFLp9PGgfLJtqeSaTqrG0jcFAu4stP0og4Txy=ewCw0ZxFdCMQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] Neural Storage Driver - learning page cache prefetcher
To: Pedro Falcato <pfalcato@suse.de>
Cc: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks for the heads up, Pedro, fair point. I had an LLM help draft
these mails and it shows. I will write them myself from here on, and
noted on Assisted by, will add it wherever one was involved.
