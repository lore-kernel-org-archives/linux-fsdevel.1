Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3D043E4BF
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 09:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780480067; cv=pass; b=sgfrsIZpu58MrlTh5UyBQFCN9Mznn5Ab0EXSWZm4/6NBsB5EQ6ahdz+yOIEVd0J17IhXbwEY40Uprgf93XbVnuEq+xRy6E1QwoCB1Mcr/iAVgi9+AFxS6wm9L+JlEnlXW1Y6x/zK6j2fHNx+QKtkanYWkCG5pbxheEWyuWeRCnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780480067; c=relaxed/simple;
	bh=Rp22GKZLhdvn+vuEM+jw0CqkEgJs0Z3d8HmQXbOoRYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qvf5wLWiDqTT85AKI45gfjRF4SZaC0ixiWo8q1rpd7mGrXg3byXdY034LYY00J2P4gcmIg3JQiG2dtbcqlfI1k2X0QQ9NBXT6HFXPYyT4qkZjX6AnS2FU719TtjvtV2cHqPH8ZLiolE07ciFTHcTIYIVP3lNwwv/OEto14X4dNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=gg8hOB+G; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="gg8hOB+G"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5176bbb9384so17596171cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2026 02:47:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780480064; cv=none;
        d=google.com; s=arc-20240605;
        b=kct40a/f9QDfVdKAtXr1PmVSJvKRFXO0ScSC6KCw4MC3rip/rHRaQUdR6/j7qcnp0e
         +ZxCa3QICt1DwcXdtcxep6qoQDhnHd2+GpMXpLMd5Zs1pV/sm6nP8R0ihscXPs7KCox6
         Usi6RgKlLDH8/9FAMoC71qEi1MEt1LYX32wyw4CEb2UZayFHEoM42AyU93THWlIIWzUR
         O9XwanfT4TrUFXKyG6m3svRVxI5PkKaZhGYWldrcqT2yEP9ClPnVwOKrW42gWlZU2I1r
         vvpeOscSvHoILLHeN/7d1o+iUurP+D1QYLBmi/qg6JzyAsLcfZiIjLRzFWevHo1zFHEK
         +PDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cwMmpkwceKnk5WH5016VjmF5XkCan6fdvYBiuBhZlDI=;
        fh=+aeQRzGvs6UOzvuy+aMZpUUUbay1BFQzi0xJl6To/VI=;
        b=l2IPPzokNYe68ABhWKPwK5qMM14uMPMyoGMQqkGqk/0ekaZWGRW0TCU/0bpNE+Qbdk
         Q3YNgsQ4eyWvR+z11l7K/bLKor4i/RuWKJfc2sHV1ongPANtAi+Kg5fcQ3F0ORHP9jbn
         gxNiIIr1GV7sVJULKveQPgM9yyUTGYlciREGaEz6O5/S3BCJFf6A5LTdBPRedy5xv6tX
         r4GPI/k7xOwiMydhkSkcUbjB+ALugFQu5M7xlXt0svJyTMhrJ+4ORo51t79C4an0a9wt
         Stb0V1mKUb96phIe5YMjLUsh+/cVaPcg0q8b4IruNPdsIZok20G4NgKZ0ZL1GpUimxl3
         0fXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1780480064; x=1781084864; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cwMmpkwceKnk5WH5016VjmF5XkCan6fdvYBiuBhZlDI=;
        b=gg8hOB+GU80KFQGGKKIWbZWc4Z1xAC5eozU9/4/qwWdFp4twXuJlcmAvkVI3jo1VbU
         j2CwTcc6xOfKTCYQMKdoN+W4qnY28JAJ7LFoUpUeG01nG11I+7We0SpewUiroxXwUXR3
         BgqVnaU83Bms8axXIkQH68IVoEK4cX1Pwqigo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780480064; x=1781084864;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwMmpkwceKnk5WH5016VjmF5XkCan6fdvYBiuBhZlDI=;
        b=nksK4sKQBMBhot/5+l/qjPPCRlS5YJMw29RgY1ggfCXSVRTJKQuEiRWM+lRqxI11nv
         Yeaehw8E+6dOd1oOTS64MN+T2A+gOJ7oaflB6T1a6wTZ93NaDhTuL3+92uTbBXMfZDLm
         T7G5NudqMPG4xRed1f8nm5CsJRtuRiFCFlrFPomL7wEoS9s5zRqBkK7lEZXG2qd1XRA8
         0iIJcEGUDNOlu3fhK5GvC61UDdi+0OXfc3rP8uhmL6CIcz80rPHEZ6tlqbqRkYwJKE+w
         uA4iG5ifEMUVN3KkjuuSRS5O40T04EnS23R0D6QtTT86tBaLP04lxk4q3CpU4bhdYmPd
         fCKQ==
X-Gm-Message-State: AOJu0YzAAra3A2mrN1PRUPDeTrnNEqz1dGfSloJbKr5WX6OlGWgDfzOt
	fHR8K4C5KTCtyhbpwalB48oP9AFfvq6Upr30iyKh7qALA0bcDr5jSjKXPkRRY3f3ni1+xH3KRZz
	14xEO11iALrA+ifVe4KlJPQc6ZwMaokMJqGi/+4S8QeCdSqpHq50qJv8=
X-Gm-Gg: Acq92OFDdmcH0VcW7bPMHTk4ZfrKaKwTPGu17HvMgqJPcZow3lyGrInoN56FYPE8iXN
	Z6zVIf6iEVZXzRR6I3j/y8tb0lTbhXF/xl9e98dnClM+8ruK1VkJOLMY1ZUa1/RmUrv3/IArUV3
	RCJQ2QNX0US2KVTwmiBqBFMr0IGO+pjvG2ulVzeNoo/tGxLI+RtIKLO5/b/jb0/HOQWT9+09FhL
	jfzpbaj201U5D3MguWBWXrhMr+xUdxTNcvYYzhFVMkzuAJhFqae67PHlJ+bxRNhys/xBBUvUeT9
	ML32pXjD+naKYAor93mwaQ7nDwrOw/rAhDDwV5E4gTnsBvg=
X-Received: by 2002:a05:622a:1814:b0:50d:efc1:841d with SMTP id
 d75a77b69052e-517786447camr37422011cf.23.1780480064330; Wed, 03 Jun 2026
 02:47:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601192934.617233-1-william@theesfeld.net>
In-Reply-To: <20260601192934.617233-1-william@theesfeld.net>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 3 Jun 2026 11:47:32 +0200
X-Gm-Features: AVHnY4Le1rRh24Wl3nmyOzYWKhHYzqQ0xTX8IxO1VfvIXiLHcawUZjrbeprbZKc
Message-ID: <CAJfpegvyUdMkpk4e0dFKbqUwu_uz6ORRZ_0W=AVvz93c8-_qPg@mail.gmail.com>
Subject: Re: [PATCH] fuse: convert page array allocation to kcalloc()
To: William Theesfeld <william@theesfeld.net>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Jun 2026 at 21:29, William Theesfeld <william@theesfeld.net> wrote:
>
> fuse_get_user_pages() allocates the temporary pages[] array used by
> iov_iter_extract_pages() with the open-coded kzalloc(n * sizeof(*p),
> ...) form.  max_pages is derived from the inbound iov_iter and is not
> bounded at compile time, so the multiplication can overflow on
> sufficiently large iter counts; the resulting too-small allocation
> would then be written past by iov_iter_extract_pages().
>
> Switch to kcalloc(), which carries the same zero-on-allocation
> semantics and adds the standard size_mul overflow check.  No
> functional change for non-overflow inputs.
>
> Signed-off-by: William Theesfeld <william@theesfeld.net>

Applied, thanks.

Miklos
