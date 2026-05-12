Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F2A47AF67
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 08:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778573490; cv=pass; b=kYc1zY49wuEZ1dyVFVZdNNHGy7YpGAzUTdDeyFAlDAZ8T967RhOsCJ6Rw+TQrcg2TS3lpX9sr+QeS6nGerBpoYrnXaHmTwkJOvuzoLc7ARtInDreVJy6BlN4teoKRY+CavIJzbOty3XHS8GbZcN9yVS4w8tiiHRnIgnJfbaw+rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778573490; c=relaxed/simple;
	bh=vR4B6nWAaNG2wL5FxOLIegQKVBpVfVi5VwP039YC8TY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hbAKMYEEzFYhvhf83aQRFduaZ/CKy9WdMOdfwtivXqeZHEHMPx73qogOQLHkIQDFs8Dy+TZVHd7Xsr8VLOB/CrZq6WDgMa1TfAxjkjhjQEvnwSKC1Ip8DpS2M3v7fNmKPXGfX2p8BNTkIkBxu7MxJMVMSgrWdF3DKqK475puQ9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Xsc5WUGd; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Xsc5WUGd"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-515226c0cdbso344501cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 01:11:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778573488; cv=none;
        d=google.com; s=arc-20240605;
        b=LiTlTvDvQ5AHXleqqjjnJdgmS8KqizT/JoQb7ui5O7CoKyIW4XO3DV+bDUUocuJ88R
         uPqaSlcvcCsAfv0ZiboCUPRY3VrIG/JjZ0AwB2UetN3Ymd35u71omW6llrvWN2SXqiVV
         03GkwHEijgbSIu2+Wb0MlGTRT+QjFtMf0R0O3WIwSzoXMDwAwRoi8TMlqnP2WPQLxx1J
         FWoH+7aOG+q4CazMS9xBgypPHhDvS41CWoe/y2aOWM43/e05bijenZsul19gCbr0FhAm
         WP2+JAKzNHuWdViUn9kpS25K760sGgRz9cA0s3Ukd0QIK1buzK0491EB5xsnBYk2KuUU
         p7Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=36Q9ZJb+S+FYcY8CC7VRpk3QMo0+LrgwTutEyNv7Gxo=;
        fh=4T/VpUoFWxWrHm6vrxP5pVELgOohsFcWCmS8JSicgmU=;
        b=NKQaMNdYkTL+Q3vL1ODVzlQ9NJV+yyLrh+nBSOc8Iad0W5Fl9AM6Cb7DiyvUtX0xRA
         ppozzXIaZTPuJDycSrA4ozwsYvXRDYtk40C6KN6a4RWsoUBzJ+9gYfdQl7UOa2eItbCk
         RX0BgZiw66SXrFjc4ETHVAstLYkt0QNHrDyjTIMyZUv+Ef2Hv/uqeK11Kra3pdpRjqB3
         yjlqui4V70CTOyvsfl809fmoAe6ltEphD/ZT9h6oRW6zDOQfSdMpZkUZDUsveI+ReXFS
         zV/6X243DmZ8hhWECptdH2TXSy9/NpGOVlyr1et4o2ozLNONQI/PWxINTVP/UP/p+aKj
         VP5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1778573488; x=1779178288; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=36Q9ZJb+S+FYcY8CC7VRpk3QMo0+LrgwTutEyNv7Gxo=;
        b=Xsc5WUGdcycvyFVkhczhT7v4tFPTZ41uoAXuhySdVz+KO7Wgv1Q4uLHxfk6Mt7x0ZF
         WY7wQZICcLDVkghdEt6D3ODsuywIYtttiytlmkPLdFpm3WNRqguMrH1EbTzgiz51V+Cu
         ylRKG9iFzGXFcWXDwibAXpr8tumnh6jUfqQ3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778573488; x=1779178288;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36Q9ZJb+S+FYcY8CC7VRpk3QMo0+LrgwTutEyNv7Gxo=;
        b=tNQmBEoA3Oof6R6KKdZHOfcptR5NV+8E2P6H6M3HRYaMtKC+uSJ4Kyz91Hb8Qw8d9I
         OOZueIzbzU4yHGudjMWSIlrIDT+qhbNNryPDYoc0MlkhIscIJ+FAIvsVk6n0ttsRDEru
         ilO0yWcMrwUMx/Z9lQm9Q8lcAfBlidwgsBoUXrhxSvq+f9yiCodKC9FW3ApGhPSywGYJ
         vJWBret0GaHvdHD9vvcmErxIbYDM8UTv8igmxQZz72DhKs4Tulr7elsrukrVgOP74MGs
         1ivQSyeMcgkw+oHGCMGELlX8VUNdLCxdXelFHyWPXrCZ93TMDWCxtikOoCqR9OTT+hVc
         pMLw==
X-Forwarded-Encrypted: i=1; AFNElJ+B5EUvQ7z+40e8tK+0DwYm4D+OBwdn7xgXlU6UKGkaZsumhzBCeTKpnf92VEBSvDTZ/fLU8zwuIDz9N471@vger.kernel.org
X-Gm-Message-State: AOJu0Yx10E4+o+MXQqJjFCDmtblVlB6L5Xf5EeGnoLs18plFKhSciEBB
	xmZhE3oIF23E3LhhruPsbLq5c+EcYyeTVFIH19YreupLr7b8TabQpwt4R4hFBHPWILekEOsgE3i
	PtCfpIYi7COcZOE2uYgL8Hj85KARILkx/JEoClpAxzQ==
X-Gm-Gg: Acq92OHKSPnmGPIfcGeojn+ziOZQcTGFcL9FQbWDwBq7ztaD+v0/hZjp5UBmOMxrBq+
	lcsrlz+X2D+c+W6ZKrvRXmjUh5CDiWaYeeey/GssCtcM62C7XbCBn88aTDO5I/HycfUgLPIxCsy
	B0PuzkW4LUkamzp4YZGcUyjiY7vGyVyawXxBM7LyFUehgP/kSvg5WEylLV3tv8qxjg6udSzJ/Qu
	uAzlmjSLwsx7ANByvtwRYueTkn40nL8K5/2W6uXVA82clUfOghSApsS5DNRxyzIeU5gLPfXR7uT
	ghmyHZXifPaafrfDamOZ+PecM3twZvRbIyGZSMC0OwwSsT0Ocg==
X-Received: by 2002:a05:622a:48:b0:50e:5752:d1bb with SMTP id
 d75a77b69052e-514d1c1e4dbmr28870181cf.4.1778573487886; Tue, 12 May 2026
 01:11:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429102058.1362965-1-mszeredi@redhat.com> <afxK2HSiwY32KaWw@fedora>
In-Reply-To: <afxK2HSiwY32KaWw@fedora>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 12 May 2026 10:11:16 +0200
X-Gm-Features: AVHnY4IqKjt3bWi7g4y-OK800aSsTbqj0bqZHtMvDztGN5Cxy1jvogln1dO19q0
Message-ID: <CAJfpegvYM2bdAJJHaqydxRzyVPNwOU95-MS5F+YrnOkJR+6yNg@mail.gmail.com>
Subject: Re: [PATCH] fuse: add fusex filesystem
To: Horst Birthelmer <horst@birthelmer.de>
Cc: Miklos Szeredi <mszeredi@redhat.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 May 2026 at 10:37, Horst Birthelmer <horst@birthelmer.de> wrote:

> Where do you see the biggest challenge for this. To me, it doesn't look impossible to add that,
> but I'm sure I'm missing a lot in this context.

The biggest challenge I see is API design.  I'd really like to have a
simple and consistent API for this.

First task: need to document the current interface, which is long
overdue.  Here's a start:

https://docs.google.com/document/d/1SInG6nc5dF-db3WtCqFOnRDCY1jRl5JQ0Toiryn2PRc/edit?usp=sharing

This needs refinement, i.e. try to document by cache type, how is the
cache used, invalidated, etc.

Thanks,
Miklos
