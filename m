Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843E2318146
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 12:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780664212; cv=pass; b=mOo9LoeFWCPm4VHTM7JUCZLtydsg/fxGiNn+CK83tC633tYbVsJr1KWjxeWX7l5yN7Xza9zHfXwMiVHF2m5C/nN5tfbzgNvcsetJQXFu8KilN/WLJAqttZ+kwA8jLO1B27SdLreHQOSaTCobMusmoMViSRuP/p4kMAJMmh/CsA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780664212; c=relaxed/simple;
	bh=rsXLmPn0bzqQ+E3dJfcvgQPBjvd6GQoy+sI3S2Aixnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kgWkcS8JUlTdi10U6wSoO4zN2vKx4NGD/A+/36LCGN/wV15oVscE7fo0CxGpYkaGgO6HdPhO/ZW1D5T6sENwJUFN+zYCfuHpAcAPZZQE202seg+Y5JKzS1UGa2D+06W2tJUnq5YXwAKwR3FjiojXNd1qc0zkhVZrqameAJTxN7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=WBwqUj/U; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="WBwqUj/U"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51790c0a692so15601871cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2026 05:56:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780664210; cv=none;
        d=google.com; s=arc-20240605;
        b=LJGn2SUSgJMqTvcDkHUlogtOBtLcJmcdqnJT8J/L65D+dS55kA4nthDFjNxJtEXYcf
         alw5TqcU5ZWkJQFUNWgz4TPUCFkjcA8Jp0RJkAb4/VWpvvxnv3krR7iJXdkjFWSHtwTR
         93pzPfqxBXHpBpqtyttvbDv5+ytb/1MkHUmpyEjGMtCm2/1NdodpYISqNxTxARmi7dhf
         UPPNbvX9BZ6TimeV87/SQe4a+uXNSVEtg4v+8T8MSuWQkUuygAH9xJd9l2bWRN1KlnrP
         VVGwtuR/G4WPpKESoCy259+rhZKiaHjLCDFhGJHZzAvuwtjpVz6IsJzQvCj4qCSKy/+x
         vq5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rsXLmPn0bzqQ+E3dJfcvgQPBjvd6GQoy+sI3S2Aixnw=;
        fh=EsvVdmNEDh+3xJgrRvMrKka+LVmQHELVSzL5X20OcJA=;
        b=g6JfUeb2Edemqi50BZ3IryZ1pPcuwLI5+UJ2HqPuX2aCLunoStUumNoc0pb1OEpMEd
         iBe1NPVYIURiQceuIY2aSYh5cvqkxbSctUfXB1EqkDXPWQoGHvHHxwt8cJduCVpYyWPW
         prSOyjorLCq/uFqzRoARBbUgO76gq0bSFUaZV49rD08NNXsaBmIm79lNo7TI4Q3oUI2e
         RPGjL/h6whllMHhV0SerNepB7iwRyPvrax4GgcmK/ei2N5TyZwrhwrmoSVd83Izctdg6
         GG8QWwwJ7HBhMDM4+D60qWC0dtOHWnMa4Ulhi5LhCAxXY8/jpo2R6pAli5mQHgzjxgLi
         l7dQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1780664210; x=1781269010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsXLmPn0bzqQ+E3dJfcvgQPBjvd6GQoy+sI3S2Aixnw=;
        b=WBwqUj/UmS/oe42cYsTxIp/yFkuWMI7ke7aAVtIyX7E176e2HKy8R2HFiGpTY+5Ibg
         npu76HUqabYAaN4FgE3+4opaWz1FDwSGX15di2va4RdFzJSo6ffnqbhziwQ7qsgTsaNF
         gfg2Im0E5xr/D2yPRa/sZG3lsVCpL+AQoRllQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780664210; x=1781269010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rsXLmPn0bzqQ+E3dJfcvgQPBjvd6GQoy+sI3S2Aixnw=;
        b=rrUw1C6dkJNY3dYf4TaqCDY6f09nLdQU49hTAbm8geNM6atqj4t2j1/XMcFk1leOZS
         hsVDlRSa7jjzf0fwUmRtKgrUHHsas2g+G6fSSmZb4MLWBKBsm18iRde1Z4IS/ocjZD48
         wwCtRBY4VoexUihsFN2OjhGRH0yKXx04KQyvbK8Lojypo3fWacqComBsq4OZC6P5NpZJ
         pt8uANZsiyayPZIBky5HGTgdKQOjICr3MdevjwjNnAV6zQFB9lmxBaKS4KIuPX5MkBjX
         FwPVjg/bpUIktrU82jj4a36l3gTyMuAUS/2pmQY2lmXwSxoxFHKa+yDfk7jaV43LDEK1
         FSIQ==
X-Forwarded-Encrypted: i=1; AFNElJ8JhSekVr+Hsf6Ul3JaNMAHoK/4WMo3aO2EIDkFtPtVsS3Lioln9t7rSO1dFAyX5aHwMTZbSRw8vs02ibgU@vger.kernel.org
X-Gm-Message-State: AOJu0YzVdAeiW1tp/ziylm0TKxzqhzWdsDUjcYQ5EqQczl/vYeuBfym/
	FgfY0SsYD5YYHgRB9o6Y+M6D2qgNIXD3aCg5xCMQpHqUtjqHqSF48eCGTOl1ihDmt29aCSA7D7B
	9TQhHQgqTSeVwvzPz+QHN2icK+YSgRE0JEvFqsFRNsddT7XGIqxUwpao=
X-Gm-Gg: Acq92OGA8t6i8cs1JMLJIAdhaiVsUGYJC2bsVVEQMlb2iw3EJ5esFHhlAx0xCdu/Cm4
	avr9G1VPxZPeX2O789dl8rX5mBWpRBaWTib9kZ1kYRiGL1O2sRTwOQoz40oejcAwKC6pqI2biHG
	NLps1Z+E5cx7rei4yZXw2/4DBYYGvEW5eFxlLO6BSC4rnuOyByw6HVuJjJQxO1oqpN0nAkUVIl8
	DPjFrjdDvplLV8SypiZ4CAExQalV+RwUAalg2/h2ElP+i72GE5n+hyU69gqQQofvJUiFEdmXCON
	gUSiicfRebg9kEjY+EyCk0EXCFY+gWeE23sJl3HEN0Lrexo=
X-Received: by 2002:a05:622a:620a:b0:517:7406:ccf7 with SMTP id
 d75a77b69052e-51795b6864bmr45976731cf.49.1780664210438; Fri, 05 Jun 2026
 05:56:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601152327.2069787-1-mszeredi@redhat.com> <CAOQ4uxjFg4rjwGjU2LvZT6AhC+gBk_6Ej5S4p4DKuk8=a71cRw@mail.gmail.com>
 <CAJfpegt5Q0nmK0JKAfa4Bp_SydR1qiqu7pB0JKkXSCFOYSVDDA@mail.gmail.com>
 <CAOQ4uxgc_pW57_xeHjm6xauB3Cfx3ZY3Y-NaXO_xvL==vKcFOQ@mail.gmail.com>
 <CAJfpegsiA9A8tc0w4JdQ52k2qMr9UrYFF3PRsxRTd1PAfhf4Wg@mail.gmail.com> <CAOQ4uxgQUvpp816ZNX5YZXm9pAzn5DyAwxX4npTfis=0FZOLKA@mail.gmail.com>
In-Reply-To: <CAOQ4uxgQUvpp816ZNX5YZXm9pAzn5DyAwxX4npTfis=0FZOLKA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 5 Jun 2026 14:56:39 +0200
X-Gm-Features: AVHnY4JSw5QR_037DA-qDPTE8i1Jc4sk6y-PRRmXUo5gdeoS3PcX002rjYw2wFE
Message-ID: <CAJfpegve9GMTRwvoA5y7AzUSD4e_EDJFzsqhCVN8xQ+RjQ=+Sw@mail.gmail.com>
Subject: Re: [PATCH] famfs: FUSE_FAMFS_EXT_INTERLEAVE -> FUSE_DEV_IOC_STRIPE_OPEN
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, John Groves <jgroves@micron.com>, 
	"Darrick J . Wong" <djwong@kernel.org>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 5 Jun 2026 at 11:06, Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Thu, Jun 4, 2026 at 4:09=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:

> > Or make backing ID 64 bit (same as node ID, can cast from/to pointer)
> > and ops_mask be part of flags?
>
> Feels wrong to mix them. I would rather extend fuse_backing_map for
> ops_mask in that case.

Both work.

> But note that if we support 64bit ids, we could not use the idr map

Idr map wasn't the best fit anyway, since it works best for dense
maps, but a 2^32 cyclic allocation could end up with a very sparse
one.

A hash map would be much better.

> and fuse_open_out and FUSE_DEV_IOC_BACKING_CLOSE
> would be incompatible with this id, so do we really need this widening?

Argh...

>
> I agree that it would have been useful to map a backing file directly to
> an inode on lookup, without having to go through a backing_id mapping,
> sort of a compound LOOKUP+STATX+GET_BACKING
> but there is this security risk of writing an fd using write() syscall.
>
> This risk is not relevant in io_uring AFAIK, so with io_uring we could
> map backing files without a temp id unless the same backing file needs
> to be shared among different inodes or referenced from backing stripes.

Yeah, we could allow using fd in place of a backing id in io_uring.

Someone was complaining about extra syscall overhead with the current
scheme, so it's probably a good idea.

> Anyway, if you think we should reserve the place for 64bit id just for
> extendability I have no problems with that.

I think we should bite the bullet now instead of having to modify the
interface yet again sometime in the future.

Thanks,
Miklos
