Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795224211;
	b=xfWddWzlHObyALq7Dqi3Je4T5AuMDraCg0Gmh/gn6C6NRxrAQ0c9ZJG7nLtOxNenIgEG
	 ZeCRMhIr/tNKIGCLkTmavzT9f2KT/MxlSSDK/8N/GQiC5LfOCeJh4zv38ku02DqvAyCht
	 /LlfGLpabNrCs9W4VJvBYDe0mgieNBmuC1hXvzJ3PZkTK+h3PNOZ7e9Jr8Az0EfxCSVHc
	 XJY7cXgHLaO7fw+/klfDFc7HapBfpp+36gdVM1yrzUEvUH8Su1syVN+8/EOaa94+6tFjF
	 299oIIvzFFgLIu7rKWFkWWT2YjGR1fvQjmje11zndM66fp8eeTm6FIDH69eW+tyXCNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795224211;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:From:To:Cc:Subject:References:In-Reply-To;
	bh=C/s9wcJ+8gC3Nb5xrepSAAC9C96LJN04eXTPT7Jkc7c=;
	b=TYdXDA261jf15sVEg766dVm6sfB1jUxG9Cxs1qSjj2d6K9MeL4KPr82zzDb2hZi21pCp
	 Xr/wVh4XHho6YzhtNLqoPMCDz8/mqwjTs7tRfAGrJkod0P78z9e7SzriwEhzHgAZ/Ih0r
	 iEp6QOgjaGsETrDhwD8aLfUeN+4wN4//PQOtGzQ4UUoypiTYtBtzGPVHjMpk2No4AAsEZ
	 DkGgxlIcECzqxF2fuaK0TPeeOE2wAutFOIjpRxh4Z9sJfMzNddioReY9J29OxSUoovRsT
	 BjzkkDhIUxC+kzpfT+/XwzP1GHJE2GHccj4+ZrB3GEwZox6lTHtNJ09KA59smyzsq6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=TjfjEOc0;
	arc=none smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8957E606A339
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Nov 2026 01:23:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8957E606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=TjfjEOc0
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-92134c4592dso14091396d6.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 17:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1795224209; x=1795829009; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C/s9wcJ+8gC3Nb5xrepSAAC9C96LJN04eXTPT7Jkc7c=;
        b=TjfjEOc0aofEpvFrY7KXYL11LNUhWl2DuCcRBIpqPGojBhPT7K/iBi8R6H+e+xS5+U
         57JpMW+1HxZDQx9vcDxyE0znqBVsyOswu+Nra4t6TUITj3wR6bWHE/jeo2co37BZxlIP
         1BXoCxCjAMAHG25xHYIYt6r0mV97y3xmE+8jHSGQZtj2vGWciLZvIh/5WYMSV6DlC8XO
         fom8Ib+tTQ6nUOrPGhtqzAebhHP0ViJt/NmIUhcveERdwSJJ8JDC3m4qDyCsJLHJs0lD
         N6kNDNnWFpe/3P5/pieXrSxcxTjb/5fVQg+xguXEo8mdMDKIymt3Fz9bW7rmvNR2Zh8X
         7x5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795224209; x=1795829009;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C/s9wcJ+8gC3Nb5xrepSAAC9C96LJN04eXTPT7Jkc7c=;
        b=bnD8oN71cTbHyaUYE5vHtQhxonq2Co2N17V7EwuXl3QhtXVyNEtRDgGMGPhlDDTngn
         6Ttul6Wr4zD7bXnM9anyI9tfwUI/qxUi33jHudtADc50W//zHdFUjWHC+LzT23XqccV3
         xsJRpXvGsbZfoNhRAiEbawEoiy28guElVkdvyJ9gnpfg8gEu7RHVdshtgyWWLHrTwmJX
         nQ/SYCXKQA38U01t3lj2h5mFhCby+BDoWxCggatvaHkKsBq4U7Ue++CJjwthKALTjiYz
         7lXCUroIS8LPh7B8BuAN+n3Ado82prt/Rw1AJ2lM6mZna++rSkrBCc177mpc1mtUxozJ
         gHIQ==
X-Forwarded-Encrypted: i=1; AL+hErEtWe/vXzsDLV4dJ0bbrWQe/fM5MrTvIWphvu021HSnAXDvOFnFPZP8XzgcvjGL0Xf8wmSjcv6PObxzUV3v@vger.kernel.org
X-Gm-Message-State: APuU4Z8y6OSDwFmmmTW5jdru4zdddLXq/LRqaJEh9k8mcd4M93eK4WO3
	cC6jYCJAHe7c3zwUxwKcqrjRn1WYV8TNNe86dG+CQ+2OmQpDQr9DKI7xYLs9pnUIYA==
X-Gm-Gg: AZFdTZcTthPb1fqGDpQH7Wrv28Q9PLKjYYacj/VNpvt0ZNHQu7pAE8vodKWxQ5H/XIn
	mmOyunYYG842AumolcD6wqgoOR0DFbg820Qok3MOQn4NcDoBVpJvl4iUnOHx1jswcWIFTso6b5E
	uWstU1lxQ29TgeLA0p33uINpd33Pdt+uH/nNNnZSOxU9ze2CAHIbbUNAYozpQlEyfD62LWxGAp3
	gOK9u5BxN4nAfuPYIqzqlYJu/GG5Qp4Bppj1ufUSx++nVookx2jFUUr1lts6CanX0S1OSjO2LjQ
	ZHnZiujTht8oUn1BdFNkc4WoawuBwvo7p80DYidOnJgCZmfLeO1dpiRmBH3fRpXlXI4diC0Jicm
	TGK6p726yHHKohPkvI3wTpwo4s1Tm6kohhqN5IWJoqVqf78FSUo+9zGdWfSN8JvtHzGZu5k7Cuw
	1s5gHsNQbL1pQWti3WlhZbYLaGaS4DbAMpu7x2WJ8Ur7BuJJ5hybN8juLPdnekT6ryCkqpysmmC
	7hX9JexRYqWajLryXCw7tvUbHvh4l8tzlQGYLoEzsr3XPE6tD3rw2lbS8aJ1hlE0ZeJgvGiIAA7
	ZMOQvd54U0h+GaXcwWdIplSOlH0ycxo3rOTBDrxRPcX7qF7hdlj78w5L0UGOkQTiNoKTJjL67uv
	K18Prbz0Clij4jDMdKYSpNFpIMzFuvQ==
X-Received: by 2002:a05:6214:29e8:b0:91b:8b2b:5a0 with SMTP id 6a1803df08f44-92134a59f89mr82088546d6.23.1795224209503;
        Fri, 20 Nov 2026 17:23:29 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921347a0b6bsm40207456d6.1.2026.11.20.17.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 17:23:28 -0800 (PST)
Date: Fri, 20 Nov 2026 20:23:28 -0500
Message-ID: <7695c09e696343176f9d1e1c3a3f4105@paul-moore.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20261120_1711/pstg-lib:20261120_1707/pstg-pwork:20261120_1711
From: Paul Moore <paul@paul-moore.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, Miklos Szeredi <miklos@szeredi.hu>, linux-security-module@vger.kernel.org, linux-unionfs@vger.kernel.org, Stephen Smalley <stephen.smalley.work@gmail.com>, Vivek Goyal <vgoyal@redhat.com>, Christian Brauner <brauner@kernel.org>, Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] lsm: put the copy up creds when an LSM hook fails
References: <20261120073717.1588080-1-amir73il@gmail.com>
In-Reply-To: <20261120073717.1588080-1-amir73il@gmail.com>

On Nov 20, 2026 sashiko-bot@kernel.org wrote:
> 
> security_inode_copy_up() leaks a struct cred when one LSM allocates new
> creds for an overlayfs copy up and a later LSM then denies the copy up.
> One such pair is SELinux and a BPF LSM program that denies
> inode_copy_up. Enabling both LSMs and loading the program requires
> root. After that, each denied copy up leaks one struct cred, no matter
> which user triggers it.
> 
> The hook calls each enabled LSM in turn. SELinux or Smack allocates the
> creds and returns them through a pointer argument of the hook. A later
> LSM can still return an error, and the hook then returns that error with
> the creds still allocated. Its kernel-doc does not say that the caller
> owns them on error, and the only caller, overlayfs, does not put them.
> 
> Reproduced with SELinux and such a BPF LSM program: 36000 failed opens
> and chmods by an unprivileged user on an overlayfs mount left 36000
> struct cred objects allocated, which kmemleak reported.
> 
> Fix this by putting the creds in security_inode_copy_up() when the hook
> fails, so the caller gets either creds that it owns or none.
> 
> Fixes: d8ad8b496184 ("security, overlayfs: provide copy up security hook for unioned files")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [amir: put the creds in security_inode_copy_up() instead of in overlayfs]
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> Hi Paul,
> 
> Apologies for missed the LSM list and maintainers in first posting [1].
> Resending with proper Cc list.
> 
> I think this LSM hook was introduced with confusing contact for chained
> LSMs and this change makes the hook contract more sane in this case.
> 
> Thanks,
> Amir.
> 
> [1] https://lore.kernel.org/r/20261104082128.3573690-1-amir73il@gmail.com/
> 
>  security/security.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)

Thanks Amir, Chris - this looks good to me, I'm going to merge this into
lsm/stable-7.4 and I'll send it up to Linus after it has had a few days
in linux-next.

--
paul-moore.com
