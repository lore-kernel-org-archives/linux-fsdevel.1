Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A70436E478
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 09:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773740151; cv=pass; b=n9RIAe9oWPrvTHp3HM2E/4IiAdh6rjWxjjcU574ZhZ1onkJunnXXxemyP1IuR1rod5IHQONqHoFCdcLM94+Ocu5r0fCf+S/3l0cLWx6DwRwBNPdKO2gILx/d3E2PUwS9Qwo3XQtQgx4Mqbf0FYsGX3FCUujgXaL3D+p8/6CWI7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773740151; c=relaxed/simple;
	bh=hgcQg+kOzklZ35NFhlMpZ4rIvFdPwmHk+5DkaLRC3GI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K2Sz718p0VJsOzQEcgbBZ1ZCWDEwHs2WIiLuPUgZIFhha7db3AGvbt6dnktMdz1kBV9brImPxuR99RgORRoWTo2ewO0ygGLTyqluVeH38rQg3w1MWpI7PRc6ppvgNnXSYeYej1hF9l6aQCnHsobsvPJOX+vRVYTxQKURbz5/jig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=U4jQveZf; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="U4jQveZf"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-509164dce91so47992591cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 02:35:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773740147; cv=none;
        d=google.com; s=arc-20240605;
        b=UFSR9mFoBgQADRdkxXLZ+bCDPRk9ngCqbp5j3RPRGJ3M10VMjMUwXF6YbL737TIOel
         +6Ej7hfVXfKhyu9WM/xJmPrJLMy+JC1LIjzVL3cmw51PD3znkhiqsAAqvkK+d8WPtBE4
         GpEmyvdbn9k21fV1GwLetFI+00s42TjlqzSNBbowfz+l1eVC21kJ/+buRr/hbKAaQWw5
         7bwIHBgwJhujA99KLoyyr56tt6dMbHNJUxepDvff+u6KRYBl1/TJYfzrNBwrCeSEH1SX
         CtpsF1YI/1+opdVGZA1gOVWggA2FuJvVTeFyAD/lpWHppmAEW3IFi0ujBcgkFlR5q37T
         claA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Sdyqe1dfAJR1e5rhX8ld40VVaUdx1OY6SB5fQdXiWDY=;
        fh=i9S5NeZRMY+ffbrKG900QYYN8k0XrxrVSXMF7pRbrYo=;
        b=ZWWlreyc83IrGXzrwsegd40PpI7kY0E6C2sw7CryGpxnDVE4umJ/OV3Q7FwX3JmcPl
         H9/lFAMa9qZoynTfhgkTgYUyJYuxCSjpWqInfn73Z3dRxm/u+sxUUTEKlpJBmPDiJhBB
         K9PGij3eTThH34GdFb/fKMHTEL3MGrJYjGH6H5xKolI5/ZFjdi7tAZNBNGnYReXwIJtf
         tQWYUvCaqjDQSpgUwvATJFv/ldQzEw+lxgBa5Bcg7zYyJZgkv/V0TvUpGuWjpNbQqUGw
         Kmc6hFOC4OolrPU17WEpvhE648UVArTnGkZaAG1akdyM1/9KVxkN/zW8V4piQw43GyDT
         9rMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1773740147; x=1774344947; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Sdyqe1dfAJR1e5rhX8ld40VVaUdx1OY6SB5fQdXiWDY=;
        b=U4jQveZf+1wKxFOkfD4TVyROXtub0CoHyrnYraUjTUS1jeW2+ZgZLXm8icxeqvqoC+
         pHAHIsmTQrQOcgyUJ5knxdSZPQtXAFisWuEaJXFi1K0fpl7Q5N0vv9BXxYTrT+N8VONQ
         z7GZklHjuSCQasZi2Ma7dkJ2ab6hgbHYulsPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773740147; x=1774344947;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sdyqe1dfAJR1e5rhX8ld40VVaUdx1OY6SB5fQdXiWDY=;
        b=BU+u/KD4Gkw59zWy979dmGNFiclpHV2mST4qN+cd4PlyU1PqT8Se+tjKL9007jPHgX
         eR/fLbWW134guiC52qiNLLMesPrzO/0aiHFuDCuYW6SWbeeTUAB5oLqOJQaJ6ZxEv2kH
         VpJwMSz4cHSpdCgyQf0EmuGpPQuctpc0p4dW4Naa2tOuavCuwD4jpKJ8IKBeUREPhErP
         icBUpY0fAj8LEHd0V8UgluY1uyrEJm+Z3knQ9Qo9d6QJaOQQuv7FeJpODnxrU2aONpA5
         I3khdpYzIBvbicsh78P5twHM81uxSx8gj9uYFbVq4dNkpA/pdM5g2Pcm9mt4t18WqkK6
         qQ7w==
X-Forwarded-Encrypted: i=1; AJvYcCWbxmO6RpE2VRHDnp6brD+0YB/y86ndg5lvedBKaLjKWAByWGBT0dmtaDtKtnIMrb7WpvgC0Va+R/lsioll@vger.kernel.org
X-Gm-Message-State: AOJu0YzgUkOFper4AEtAt4wmKwepZg9naG4l05LgznsZs3tgNzl7dfLa
	x9gypVSvfHsHT8fBev2+DhsZxfAOca/OTDAT/493d+PaA23InIRRAkM/YICIVmr3eXn+JJCRAP8
	tFfQ7b0zAavl2SxP7HDVkDmPdyKceFLcTIpDbZ4chiA==
X-Gm-Gg: ATEYQzyyPXqQ72kViuh7vF5C+5RydVB91bIhiQim3igAmA7fuVaw10XIOUovn5mkURr
	aAtAjuJqtZpPEsaNTU/QPl0b2Q025fhks/vZIWQ9vQXr8Dqkn9Eq+Nok9p96csKKvbgvWHp/JFG
	H6SGCg9lGmZ5dWBcb+Qx4jz2rbeSUJnSUFbjo3Aa8CqbNAkbc19EUf0kUq/YeoFoJ1LAikIj3EB
	w8eI1kNZC6fX71qLB0jo7aAHTJs92gOkiK4bY+m3RzNSWFut5rNUdKaFvx/LMGkj1dlMTH1q0Gj
	SGp/lg==
X-Received: by 2002:ac8:5e09:0:b0:506:1c3b:c8a7 with SMTP id
 d75a77b69052e-50957cb14a2mr215076411cf.1.1773740146851; Tue, 17 Mar 2026
 02:35:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316165320.3245526-1-mszeredi@redhat.com> <20260316165320.3245526-5-mszeredi@redhat.com>
 <CAJnrk1b8A0eK51QfNLdSDac6mQXHqs4FUJv7okqFHyTeehBBeA@mail.gmail.com>
In-Reply-To: <CAJnrk1b8A0eK51QfNLdSDac6mQXHqs4FUJv7okqFHyTeehBBeA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 17 Mar 2026 10:35:36 +0100
X-Gm-Features: AaiRm51VY4Dn_ucMkXp59U8Ls2qrXwGtIuvfp3-w9lGBYz7ZBqGS75alhJUhjS4
Message-ID: <CAJfpegsxCHh44NjgwLjspY0=W58mG1pOuS8a94ea=p47oBHLFA@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] fuse: don't require /dev/fuse fd to be kept open
 during mount
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Bernd Schubert <bernd@bsbernd.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Mar 2026 at 20:56, Joanne Koong <joannelkoong@gmail.com> wrote:

> > +static int fuse_opt_fd(struct fs_context *fsc, int fd)
> > +{
> > +       struct file *file __free(fput) = fget(fd);
> > +       struct fuse_fs_context *ctx = fsc->fs_private;
> > +
>
> I think we first need a "if (!file)" check here before dereferencing?
> As I understand it, userspace can pass in any fd value.

Well spotted.

Thanks,
Miklos
