Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2296A394492
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jun 2026 07:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780558783; cv=pass; b=WnKkL/KyKAIDP73eS7tgjufkzqiP1giChQLKvM+7xIzSMVS1h7CGnR5ZJc7uhfFZ2QEQbjU0YuEnrvJtKVE9fMU1zHGplGvLRjHF2UWH9qSOqhxXhQW29MJFLe7cMoS4Dpq/nBotpkeduN4BNsFkkRDF21UvyL1Yawlex/yNTOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780558783; c=relaxed/simple;
	bh=e+K8JI98tjf5hP5bAgSr4Jd5kzHe6QJIzHF3gbCUJH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gJeVSyUGTzdd6+JxJn57gIgjPRiC2947jyJGl2+qVoHci3LM9MqHAtUPtLNheSTv4dYNZefMXrODMCMiFFRjSWEDoG06iSnSi0nqlrXYS6MWVjib+zf/Ccs/z8BKK9v3MobnlhX2AfIdBSxrjPyEzvT6cT0WBwpLweuN+9V1fng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFFYVmpQ; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFFYVmpQ"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-68d23430690so712157a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jun 2026 00:39:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780558780; cv=none;
        d=google.com; s=arc-20240605;
        b=Hxi3s48EWdP/KzmRfRoJPZNrM1h33rg8JVl0Z0CZsalMbBDL3qWak8LPZD/eiqOuLu
         kE2rRryzqGFbpaSKlhWisVle8iNywQuLcJawU7r4dpGTZOzeCb+C3n3W2jfjEy5CTzvj
         TKqCwkgf8MWtTavcl//slHHC1QJKwsYcufTRW6g3LfYxn5m/FaK5dNpAX3VXu6Bis6tW
         Q0767/ESw6nczQgf0Fq8W0956cLFIN3Hdpmeyd5bVlG+aAQsPZNzI7Dg05pt4poMpwzU
         8TCBZAmGAeupbfSThWmNuhRFP6K5/lplDRMLJ9fIOtqdG+QG1IJcQTcfYVxia6aRcuUK
         q9zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Bh+JpTqn5WaQ/HfI1QK63mlUNBVv/IjZhQGAlbMSN4g=;
        fh=I0oS1rPd61gNyApE7LyyEAejoQAgEWxrTXqeoIpCzas=;
        b=Qg1cjRgFJu5v084F6AvmV06VYIa9TbBER1vYFv4aimL61EkhOe0BoefZ0DyT+qKX0Y
         sWwbWf7/BMH6OrA/uWVPceBIVDSQPaO9XDW1HEr/HPr4GMHdjtgqet5NrVRMb8OEOym5
         AewZVNu0XjWhErL+gMRXUeu2vpNWjEDCeWItWAxz8maRBbbG3fkzMdXPbGqUd7hYhv1X
         0BBoTFRzG9absoy7IkpeoyXhM5RGU1hZxTj7UFAGmb7VtdTQqE4tUwev1YccjTf4nrhB
         c2/2hf1l89pUvjP/sPGOcghU5aqCJVq16XYP27fzCfDlx8qq5H4S7yM9pOJQ2bm6qdY+
         js2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780558780; x=1781163580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bh+JpTqn5WaQ/HfI1QK63mlUNBVv/IjZhQGAlbMSN4g=;
        b=kFFYVmpQmWs5f35SFrCBs2kqXiiQ0rDQEq4z6POzxIfIS2XVVrG5L9bWyHjGMhQERi
         AW+p1nEn3zabBT2iygx8KYB71Dy5SlklsxWvbeGCLUUcK/lAS34B35LqTkD0RYFulpW6
         F2G1FO3ESnQBuE1cHHhYK9wRD0ct6CzmEFscdCZmec/Xvigobe+rYE1eGIcxOYTZRqTQ
         jImRTyZcC1O83dxi2rub67tuz57KavjubXDNNyq0dho/J6FbKzCWZt3ngHvWVjhI2Ki8
         3xdBMKww6vjJqPiZYVz9cI5BvU+rOOxduu5SnMkufN7vOZLUOMi7kWV6d3mV7a5XLzJQ
         Nz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780558780; x=1781163580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bh+JpTqn5WaQ/HfI1QK63mlUNBVv/IjZhQGAlbMSN4g=;
        b=pBoYQiQK7mHk4s6Nung1+qxsJJhc6SQGNjO2xTdzJf04iNh08P7ijsRcZLp30vEuim
         tsFNTaAIxqNZOQlCCGZsA2ft42oo+GGR21iTbcNNGo9H47d/xxi8s41I84YzTdXwU4LF
         djBhxF62VZRIi5/UCNOcViXxO2lIL15FUAqSAUrMkJshtSrG1glOvdpiHhMTAnP1b5UL
         ylVoS8hF6ue7KdNDLyxILWRNTq4hxRI0dftnU9aLiqPo7CwZ2lacnFZsKJWp8wVnNj0o
         JVRkuSPrqweXEDlkgFRXaahZ9MuYNlpETFWJNWDFPfXGBQEHjvlbIjxRfmBJKAatwCkZ
         2tLg==
X-Forwarded-Encrypted: i=1; AFNElJ9gDvztWAAKT2qn9BtYRzLy6x57nJ30IM72ly8Nld6G6Vh7+MMB0Zg7oHyEzQEDVpmIYlJIKtIhwHKL40Q6@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2W1smcAGtntNkD6ryuSy2vZg3+56cMLGhHhO6hoNVatTVQzXy
	7LotJY1JQh06aEs/W38gfOZkJLsKWdtjvxp/PQijUz4vcPyFZoxv/CJkHfcxGDA8AZxftJeSVz4
	12EmB9FK8/zE0Sba4N1ecxAmXH+VgvX0=
X-Gm-Gg: Acq92OGszM+0gk8fpwj3+GL95GQZNu1qGnTZJRP/b24WMG9awLqVWWr9wLFfeccPT1W
	mL3Elj+1x2q3jnME+SXHAWqPHk6BckgaFOHZf8nhqkzLrj9u24d9aBiQbbk1DRmKl9wwN6K3sKr
	YQckwntU854DY36+vP71R5PUxwI7QUGpCQeRugaqwa1YqNYuzSetUKg3Pm1rXI4ohTs3C9Pm78h
	0jG+6VgREKvcj/DQOIvebzV8fdOB7K9mp15l5rRgJG4hUClOUuClaMNMQCivIHQvClEdnPB+ioh
	2zrLcogpckrCiZAnzeRmzOneDv9urxA80HbvDCpAUyS+H/iySdw=
X-Received: by 2002:a05:6402:4486:b0:670:8acb:e822 with SMTP id
 4fb4d7f45d1cf-68e70ce79c3mr3510055a12.12.1780558780334; Thu, 04 Jun 2026
 00:39:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601152327.2069787-1-mszeredi@redhat.com> <CAOQ4uxjFg4rjwGjU2LvZT6AhC+gBk_6Ej5S4p4DKuk8=a71cRw@mail.gmail.com>
 <CAJfpegt5Q0nmK0JKAfa4Bp_SydR1qiqu7pB0JKkXSCFOYSVDDA@mail.gmail.com>
In-Reply-To: <CAJfpegt5Q0nmK0JKAfa4Bp_SydR1qiqu7pB0JKkXSCFOYSVDDA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 4 Jun 2026 09:39:28 +0200
X-Gm-Features: AVHnY4KAGkPR4XMrGJ1v2HaS6C6G0nzM70KVbpCrnsTsdQpjDfIqLFHVtkWLhqg
Message-ID: <CAOQ4uxgc_pW57_xeHjm6xauB3Cfx3ZY3Y-NaXO_xvL==vKcFOQ@mail.gmail.com>
Subject: Re: [PATCH] famfs: FUSE_FAMFS_EXT_INTERLEAVE -> FUSE_DEV_IOC_STRIPE_OPEN
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Miklos Szeredi <mszeredi@redhat.com>, John Groves <jgroves@micron.com>, 
	"Darrick J . Wong" <djwong@kernel.org>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 8:12=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Tue, 2 Jun 2026 at 15:21, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > Considering that John wants the daxdev ids to be allocated by userspace
> > I suppose the number of daxdev ids is limited, same as with iomap
> > backing devs, so we could probably start allocating backing stripes
> > from max_daxdevs (1000?), to be negotiated at init time.
>
> This doesn't belong in the kernel.
>
> If we really need to have allocation policies for backing IDs, then
> just move it completely to userspace.  I.e. pass the backing ID in
> fuse_backing_map together with a flag (FUSE_BACKING_ID_SET).   It
> would make the open/close more symmetric, and is a nice flexible
> interface, so we should have done that from the beginning.  But I
> guess we opted for the kernel allocation scheme due to its similarity
> with file descriptors.   Oh well.

fds also have both dup() and dup2() ;)

Yeh it's no big deal.
Auto id allocate is a convenient feature, which has cost us nothing
to implement.
FUSE_BACKING_ID_SET would be just as easy and would not
add that much complication, just do idr_alloc with range of 1.

We could already reserve the code point for user assigned id
for famfs or if we want to use this in the future and shrink the
ops_mask from FUSE_PASSTHROUGH_INO patches to 32bit
as Joanne had already suggested:

struct fuse_backing_map {
        int32_t         fd;
        uint32_t        flags;
        int32_t          id;
        uint32_t        ops_mask;
};


>
> > > +       res =3D fuse_backing_id_alloc(fc, &bstripe->backing);
> > > +       if (res >=3D 0)
> >
> > 0 is reserved, it cannot be allocated
>
> It is confusing either way.  The (res >=3D 0) is expressing the fact
> that this is not an error value.  If the condition becomes (res > 0)
> then the zero value becomes an error condition, which is crazy.

OK. make sense.

Thanks,
Amir.
