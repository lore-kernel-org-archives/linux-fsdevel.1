Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2544E409632
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2026 09:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783502257; cv=pass; b=UCmC/wCtzoeM5ixLsIgjG/ldTMyI4m2nVui3nFB0N3W9rcv9dg5Ui4JDSqDZioKT+1lCszMcreI3EMOVkr6nj/mnjR2Vwuh6yEJ+kZgMRv4zuk/fml/qReX+P5H6FZ3Z6Y8m4hLxORry5ZAL1//mInUGtBks3TO4sthUAEvYy+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783502257; c=relaxed/simple;
	bh=FWSqZGg1iw842431MXioEMnmIXSocIbOkpSbhPNXHXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RMHMNSEYARmyrGFqko8ppKi3bDWSAF99e5NZk1bmviBACkNAzyvAMmZNwKhfgwo8IldqY4I/xQJZHlPZbJxPF6S8J4KXPNUYoDCAro1aW9qYn3OYp+oWfwo2Gvmxnd7DBOtUpH3h8nmPidRaCQdaD13RtRQj5n/x75o1k/ys2Bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=ToTMQIZz; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ToTMQIZz"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c2cce930cso3772211cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2026 02:17:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783502255; cv=none;
        d=google.com; s=arc-20260327;
        b=QkaIt1edpsGJtTDQkGmrNJCFp7MUxvN/XUyBQShk+bwjj/QGhn7n+BeOAQXL1gUfft
         CNq5ljXm7t4qTnfRNXLsQHDlVNzMkCD/DhgdarJ2iWzZcDfIBHXiOChCorymDLogQiM6
         BeqpGpR/9JsNJeVQMkQEKe4W/ubKWEuCitIUWujh+S57LcyPQwXQ319mj2pSgFZ5SznN
         ufWCVGQb+AnsSRG6z0Tde6ML7f7Ov29SnBeJt5W/Z+jBGLgYAl+YcpQSue28WRYOEOUd
         ahj0FiSzAN/9Rps0+hPuRVEVNzHy1ncxY978ukmy3flV3RzAwzBD7quuj+ha6OoQyqR+
         YhsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FWSqZGg1iw842431MXioEMnmIXSocIbOkpSbhPNXHXg=;
        fh=sOANY1fbyZ6N6wL+HGjScI4kwqtWvvsOYQQDNH0WNUU=;
        b=D5jJyUpQbn144YjMib0vOqRcnhXCnvcxE617EfgUa5qKTii9nzN8stWM7PdHQxxNwr
         ROCfUgZaKkklTldPyKyJX3+WEaKXL+BoTu5UYWjnp1F2n9yH7Pmz5+K0ozwI1o2P0Jls
         nITTVCY8407/3Xs9LhivD2Xz6rFeiH3SLmdHigHDmlY+U5ImHrIcu4q/j4y/IzakwZAg
         1cyTbxOFnrAWDkeOnoM/nCTIe4yOupiYRJfIA097gC2fx1CNsfFL8SmHjAWZNSy7zgi8
         Oby1opFVSJswkAyWiE8rpJ9kfC9JfJ+BYCUJUFNO6t/ZYLtspWaKwH8UANE9zRQFh6vR
         regQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1783502255; x=1784107055; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FWSqZGg1iw842431MXioEMnmIXSocIbOkpSbhPNXHXg=;
        b=ToTMQIZzyvu1qsf/zF3dM1XH11laGmGo2XcPhh5q/PHPf/816775/8AbSj6EtceWsT
         Y5f8MKY/mDeVOpjeljQPbghk+Z91eYPLe3rwewMGPglPDAxUxwexErynqXmvf25tGkb/
         HpBrV/J2sZ1LB0wGwpU9npftbnQTY5VXFVeAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783502255; x=1784107055;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FWSqZGg1iw842431MXioEMnmIXSocIbOkpSbhPNXHXg=;
        b=UVXI/qo3+sLhBoKqj9O8qdhBh/7WuVIyjsLU7JzUNdIDyHtzspmSElLP6gIIz0NSRE
         Mo2kQgW1mAM7z9MulGFSOiW4N+EwYbBq46Bq5X/DyoFx9eyyH82ryX5MrTKFVBw3EXV9
         cimmwqGHyyvGu8rXfMLREqY1nVhR5lAMUW3Q9nJumr26VriXgIJDBFwRQQJMUatZQyfl
         BRk+52SjAVv8CsNCZRb80XjZIY8fYsrzVsNwmNFakkOUNhc7YUfl+GP6vR/+e54aOxOb
         tZxmKw74g0p+IrxiVBK64eUJi6FlXwglfAtdNS/orZSN6ePC3VOOeCXrBJTabm3LJ1lr
         2P5w==
X-Forwarded-Encrypted: i=1; AHgh+RrbJ9y+Wcgdp9YcOfB+r9wg3bHBkmy839e/xiGXq1AWHOTFmlGbxDMQ17jkvLIpL3r98w67GKODfTl67q+b@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/UCPF5BKv+aUyoRrxc1fSwcWPR5R5FRmlEwI/YXDL9+vc2Rd7
	kWA1aE2/u7v8n6MPlnfdjvonPHUoCOgWAvAVsrtrrq6vag+FgiaLS+NlmdzT/141+1Gu7QGQgBY
	cxbVNICibTWu4VKV2UUqXIo5L148CFIWX99y47W+uz4ubNFbvq4sp7Mc=
X-Gm-Gg: AfdE7cmNCulTcoy4DluR1KlT362vDrYeAf8cxmCpMpBu03GJYmJs6EeDytGiwdsE4IX
	OdkMhGJnXe9ZzkKwFTFOBNPzB8Mbwma0pukfaVx2MTnJchHiJUvuD59dr21Zt9nh3u3I3X/gMwJ
	cevfJH2STfnL1sYBOXGIlhSCfflkFbf12bA/QihUxo+RnDW3doNI4X7G+yHoSQXk0XouqZuHWnD
	wJEKwjWHZn+erEzComMjRsanpLE/IhEOYG89YI3A3fx0m4GYyC/slzp/UfmpVQU0H7W6VyuyWvz
	GcAfV0T19ls5liGfiyYoysYicDI=
X-Received: by 2002:ac8:5fcc:0:b0:517:98e3:d939 with SMTP id
 d75a77b69052e-51c8b48ec53mr18403861cf.49.1783502255124; Wed, 08 Jul 2026
 02:17:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707220450.1200943-1-joannelkoong@gmail.com> <20260707220450.1200943-3-joannelkoong@gmail.com>
In-Reply-To: <20260707220450.1200943-3-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 8 Jul 2026 11:17:23 +0200
X-Gm-Features: AVVi8CeYTH3ACY_6YwdTFHUZ5cWS3-FV4ZZe4B14RS5HKokm3x_yXmm3PXUXZro
Message-ID: <CAJfpegv4t3GBU9efQXTWgPSEsGRRaL0OAeZeph5-84eoyRyFqA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] iomap: add helper to mark folio uptodate
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, djwong@kernel.org, hch@lst.de, willy@infradead.org, 
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Jul 2026 at 00:05, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> Add an exported helper iomap_folio_mark_uptodate() to mark a folio as
> uptodate and update its uptodate bitmap if the folio has iomap state
> data attached.

Sashiko has a non-regression comment about this:

https://sashiko.dev/#/patchset/20260707220450.1200943-1-joannelkoong%40gmail.com

Can you have a look, please?

Thanks,
Miklos
