Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0733F273D6D
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 08:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780303339; cv=pass; b=BynuMpzdjH6EwaCSwE5Q+v4IFIi8qmfZ2kVWKvqt1XLI3xCimhWK4ffkDnFaDs2JEnds7CCJWJTOoW7pNmsus7BBMGWLrh30dd+uboaAaj0YYEA4+1bG/4JrikZrcyYPdjOo3xD+Hhj5vS1usiOlfq2cAZBzDECsLBnB+SpX72Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780303339; c=relaxed/simple;
	bh=UTbkwMsrfw5DD1bwnCMaOoHJmgEVR8v1IDZFFZ9xH+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GSh/gpfpPsAfBptn0wsPmbOZf9qz8Q/RAKB3nYlRUUH2M0+hCGbakKGQiEJSMx9DuIznkb4vTzChuvAR+byCocIeurrsULNMwmLzqfYhrpgutK7A+UkFzgR11tXbYt5P9E9gy+PLgSLnEOD6TkbueigqABfUVD8QlWl+yiBR4NY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Hw/x04Bc; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Hw/x04Bc"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51746c4dd6dso12867961cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jun 2026 01:42:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780303337; cv=none;
        d=google.com; s=arc-20240605;
        b=ZkjbW8YIv7LjcWZf9Nf8yL169HNd2oJhgcFOInN9gxUMXdruBSQ19kJRCCdlpFvs+P
         vlrh/8nf9LIB8EjueFbpwCdEpDxtvfu/Z/BZixMO8s/on0MdHp2TqSpTkQ4Ej01gJPyy
         l0kl9590xS7/9rUEiFR/UHkyIqsZp/Hne7QZDOFQ/ViK8WrcqdzOwvgkDNzLA8BJ/VVh
         HMW45ndSOVFK8WmtnHvZ9RGEALm+yaDwds47fLO313wSdlCJDr3w16+CtHU4shmAZbr3
         PzLMP3D3OeVKEAHR5O0ke+QQMCdgrAnZB2CCBqxbhwMR+NLlmJ+QQ8+72J6zs1hiOZ5z
         Icjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fLytNvYVztilDxrcrU7bSLGgh4QOhycsAm+cSCqJtbw=;
        fh=mLQs+2r4WG5lhFMS9nTOk262G6wbg2oMc5lwRjU1yng=;
        b=BvXpgFf7UdTi+c6YxsOwztJSqxgQkXNAfZ+A0AjdJCj92fwS7t4Y9kLMt9Ia0+gh5K
         e5pjoYUH98paJzRoEj00Xn84CygvCyk+FbkiIRqGGfdRDfBcXrcl9Rn0fzi7lxKdMszz
         UwLdpUTUwonCVP5IRNWZFtd+mffy1yQr1gDuUXDrpnN0Kw4elrQiIdjwFzdBkuxnU/iC
         4OTMR6wOwpiROdFCiSYa8XSJIHyHzsYpGq/i+W1DaNCXGZNDxAN853VE/9BiVwB7oaLX
         eLvYefzhaDtWvA9A658yK0GfNrHNWYj+TsAxfeeP6L4pPlh4Wt9VakeVoaxX+zw8us1r
         t7Mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1780303337; x=1780908137; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fLytNvYVztilDxrcrU7bSLGgh4QOhycsAm+cSCqJtbw=;
        b=Hw/x04BcKsEa/AzDrD/rOSxYe+y8NLOnMrUzuH7aT3Qg7M8024/zMOBZVR06py3cMw
         +FAjux+kQCLfJPa9s9MEnP1+YeV3gxHJGXAHSrVrG4bUnjhwIAxT5jPd3EWhX9EgLDHJ
         Ru/A4wYPQ4YCjgipxWaRr9IlLRyZmDTGKW3oM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780303337; x=1780908137;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLytNvYVztilDxrcrU7bSLGgh4QOhycsAm+cSCqJtbw=;
        b=ovbnwom2/1h+b9i7jJbP8kYMKWTbMo3lHvMoufkqN+DHeJeRfAZ/ueQsFJZ3GaVFM8
         W6XFTmGeNT4KxjDothqzBM5cdebeux72Nr4JKsjgPgsNPx1WdnTeOJHE0PtFVWi0KPXI
         oTXercd1dukMA6a23az9g8NfhNAo6jUbitD55DJnpIiTEZYoqicIe9xYPdJyMNgQOUJ9
         w9mmP4znX+fBxBRvadpKidpsyZfNpPWl+tNw1QDM+OD+NbIfZDvBUQaDuEi4xTq6mcLY
         uOlWM8JMbK14hIatiqMnLgGZCgJcoeLQU7VLRCjf7Uoxi4Fv20AWYaGJlbjymL0mqoad
         sztg==
X-Forwarded-Encrypted: i=1; AFNElJ9AFhwgLKuYi0yy8iT7lfF35KQWrT9b2eRPnBrSBuso20XpwBlQisSLq6mzNvir9eCmrZrpGYnSQ/Tz7bHy@vger.kernel.org
X-Gm-Message-State: AOJu0YzrS+hNV9POTp0o64+Ut+/nWYJkL1SA8Y/xLYXU1lNH+nwPJuYa
	YHDMO5xyCAu9pRiF/hS2qU0ijd0WLGzrhcHA7qNUz1fQqyGY0Ko7R0Sep9HDxPkvggybiN0UkXy
	mx7S8XbbC82tobeljHXg7yudqODeeB9OUXqTKJtox5w==
X-Gm-Gg: Acq92OENDec+ymtrBexs/oTa8Wjr1EMVJBgy8luAjhqpWExq9dTTq7ZMcmkprc+EN5G
	LcOL7Cn75Y8sZ6+RMuHKM/nuokq1tFhmqrww/q1L/iZKmbl9o3SzviiTPlSigZtMt6OcXkmR+Sn
	nxqlhz1YI7ObATBIi3j193aZVuEt8cGeErWAaOADVv5ZRILJDpGeczCFjIaVsO+JHDpoXlaYGYo
	XIUVoNDjAlTQ/Fpro2KWdLdkla9/SbdFsMYrM8M0lmXDnP+R2JRUwLUKNvDZSKz9IHE4G5WKF5v
	GZ17T3xfMSVbZcFoQLefVSjI1RZY9wN7d9tN5D7hx2OzOE997w==
X-Received: by 2002:ac8:58c8:0:b0:50b:3429:a10b with SMTP id
 d75a77b69052e-5173a72badamr116737761cf.12.1780303337147; Mon, 01 Jun 2026
 01:42:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529134302.1989958-1-mszeredi@redhat.com> <CAOQ4uxjZ66rSmbsDMRbrohC4LE4RgLzKotH6N_TYz92bZ-nR8Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxjZ66rSmbsDMRbrohC4LE4RgLzKotH6N_TYz92bZ-nR8Q@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 1 Jun 2026 10:42:06 +0200
X-Gm-Features: AVHnY4LsP-cd8mjcfQ-DpqLYZy-SDFfzupmW4YT8BHxYon500RdtNkfy48x3EaM
Message-ID: <CAJfpegt6x_CNqdy65xKQgRfAg=RiNPbCiESYAUWnH1X_=W3MXA@mail.gmail.com>
Subject: Re: [PATCH] famfs: FUSE_GET_DAXDEV -> FUSE_DEV_IOC_BACKING_OPEN
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, John Groves <john@groves.net>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 31 May 2026 at 19:36, Amir Goldstein <amir73il@gmail.com> wrote:

> Could possibly use fuse_backing_ops that Darrick used for iomap
> backing devices to generalize the backing id ioctls:
>
> https://lore.kernel.org/fuse-devel/177922945327.2436837.2738315299316875094.stgit@frogsfrogsfrogs/

Yeah, this is very much just the userspace API fix.  Cleaning up the
kAPI will happen but is lower priority.

Thanks,
Miklos
