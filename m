Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CF134C9A1
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 19:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774034447; cv=pass; b=NEW8dYt3BHhNmMoOp4fY4wXy6xgJJTCvxMpg0W5QwDLk+8RBzbdSoCs/jKpttgYnh+jKX0jaiCM0fu0cNFYuNb75yUCy8j9aPDwRQaqmQ23kRsASHurEgyAl4Ou04HO2pgK5a80RFIuMC/0PxEM4/dlBcF9Uprk/CcnzhftYjUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774034447; c=relaxed/simple;
	bh=MNfx2BYNGYMTkKqDWTCyruai8zm31dAVqiEWKRHSqh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bcvgmPzCNSI0CJ8A3PmHbk9Vx2IQQUmkA0ia0fA8UEeg+SVEFler9uFTOVZquiRJ3AzNGBHTi0dyK4+BRcMQqQEhus7dsukca4E9DwUZ1WsOAlI6/TsGM++RKZOGZwTlUhhhjTPmjftiOmHcFTCb/BXVGevoMjuvGF3UO1H8TG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9ZLTZ6y; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9ZLTZ6y"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-486ff3a0fc1so8249015e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 12:20:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774034444; cv=none;
        d=google.com; s=arc-20240605;
        b=T02/30cUQViFRPxKNbVvSf0O0DSQlkqJrfwqQrHkUnBW5rQnEykOkL030fv1pitsJI
         W6eNy3A7aHxwJpNQacKBXGCT0TtjvBnWVqasaOHI/jqd2m2quYoyUaUu8uMgyiHrSSIQ
         Hbn3F068HRWGIpfaem651YN2/N6GL96wPtj3kkbisqpNwaUFPV1fmmbCTkpnxGX4hmjH
         cHRZjwF8DlhJwAjLWfhQfHJ26nb5+QfTGKKVH7Me6Tjl+lGnEBdOZ8rkLrH0AbYPOjeo
         ItpMv2c5qZCBoNY8YDm5quN0xScOrBKfTWjPrdxaawDYPXWDmN5kJBVUjEX6oyds7hDG
         yjKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MNfx2BYNGYMTkKqDWTCyruai8zm31dAVqiEWKRHSqh4=;
        fh=MMk73s58iFVkmXEEgcKKiHPGzPx480ieKim3lm4j31M=;
        b=bcX6j+hCcqIiH8spnrcP6DU5649FgmsPTYASC+UdDz3dmXakkbQs/aP5Ly7BLcUkX0
         pDl8a+gY5uXxoLMUAeTCsQDwmhVt1kvKNvxrUrzyogHVUO+uadlfI5zUP5rVKDw2DxlU
         EskF2Gl+lqts5aQ5kEabAtHpadBANiJMfA1RTVDq6O5wV4kRyOoRgYsMUxkPwP+NTQqN
         galDbekKS/2QE1WAt8dyUGMDVFlL4JSwHiiYdxHGSBSOS30RsgzYxVfu7XixR+4koH4I
         mwimL/qW6k1t48rKVBoLWqDlQq4n1+x72cSxCdWUPB11hgqeR85UlYpTooVf9IbpYVrL
         DZEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774034444; x=1774639244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNfx2BYNGYMTkKqDWTCyruai8zm31dAVqiEWKRHSqh4=;
        b=d9ZLTZ6y+I+SEwFC+rEm+Z1SJStEJlDGevPwDUqsO7TCg644hsZTzHWPJUgXbD63H4
         YkI0Zo/09TE38EHtWcp1QeTbQ01fkkjbBqbvl9aZMShqs2vakB3erNDsVlTemDZOmd/G
         rKzM+OewCYR42ai+JWZPsN/3VLYziKVP/YXEKwVCPQ4wvkvvN+mZES3VcruPN4pzV24t
         eCowdxRNm+NzH+1Ush0H3ggu2SCDQX2waM7EC91iABD4VYSRBa1D/j7W/0ERXExOZvsh
         6Yxjgukx0xGImFDtFakoB61Ezjl3g77oEBMwytn6FoIXU+2ysWPFnXShMWXyF2/F7VdT
         uJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774034444; x=1774639244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MNfx2BYNGYMTkKqDWTCyruai8zm31dAVqiEWKRHSqh4=;
        b=CNHyKDs0EtvFcrTP78bm87dF7UjDIHVl2h4iSAfkO4ErcFRfrsFJhxFRvjdvBf8SbV
         zJr6FE/b3t7Ba/ZCAmRydRDpY+cidTNVUKUqFqXxo626YaSkQcgGHJnJuFJk+kza8xtQ
         6eGt6s1uxZ848GYG88CxAAydupKV9ny+W+0/W5Xg3/LAEEH614xsdtss8/MqeVjYWQoN
         2dsgGxM0tHWYc3Nowq4LtG1SMqeHWv1/31TVLtbTQuQJrI4oKR3ZVN2zxzwlyEkIlOVV
         ZGNspA0JxnAs/m/kq3g1ds9OL5wSBGWNdYHEMT3axohyoUs8RJdHBRe0v21+HGWKaMC5
         GQhQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6xMqIi3e8gnmK2PQeVQ8dLP9+MRxbMOQt3Cjny9MafX8PV8BJtRQmds1YrfYRWD7LYPhZ3kB9CGQxG9f2@vger.kernel.org
X-Gm-Message-State: AOJu0YwtcTvV69KgdMg1L4vhXx3ECHY3S8sd22ietb+8hdBiHFVH4NbG
	atbUXIa5rkH8Goa81YBcGH74p/m7GR+Kr056vluDZFG+N8Ua7B4k0xUretKeGjbiPiUHZBXExSX
	ABg/JxXVB4cnSIBTybX7R3PcQWpBynMgK9Bi98Ek=
X-Gm-Gg: ATEYQzw73/9Onq2cRO6O9y6i9Dn8gdg2lemhRU3R48Nglky+7J9fTEtH7/OTjSZwVUt
	A/h1bZ5Y7B1tuDS7KuuP0RhPKulKjNehUHQ3kkOq1w7KMPIL6DtA9EK2KAKYMpsu274qx5u0FND
	fQgV3P574XbkSRYPnSM7MY9evtY4XvTw+tBp4kB+TLoe/CjiykuVFvpFeYFwuGAKrXq0h+vs4u+
	poNmOjOkPG7jvhKM8sTcs02Xdacy5tBy3r4Vs9MmEqrP3Y+dBlk2nkRSxxHcO3DibqHkH72d0Ur
	CpUqPQ==
X-Received: by 2002:a05:600c:c167:b0:486:fc5f:1ab9 with SMTP id
 5b1f17b1804b1-486fedcbeb7mr63242375e9.14.1774034444285; Fri, 20 Mar 2026
 12:20:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306003224.3620942-1-joannelkoong@gmail.com> <59dcb27f-875c-4a2a-82dc-63b832f8eb1e@bsbernd.com>
In-Reply-To: <59dcb27f-875c-4a2a-82dc-63b832f8eb1e@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 20 Mar 2026 12:20:32 -0700
X-Gm-Features: AaiRm50hJzK0X55Rku5ox_27tI_ceg0eV6uUGvyg8VQiHW1NtcpSSQLg_51a0fU
Message-ID: <CAJnrk1YLtQF=SF-GoG4irKYzzePNewNgyTeU7VLvUN6Ub_NFVw@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] io_uring: add kernel-managed buffer rings
To: Bernd Schubert <bernd@bsbernd.com>
Cc: axboe@kernel.dk, hch@infradead.org, asml.silence@gmail.com, 
	csander@purestorage.com, krisman@suse.de, linux-fsdevel@vger.kernel.org, 
	io-uring@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 10:16=E2=80=AFAM Bernd Schubert <bernd@bsbernd.com>=
 wrote:
>
> On 3/6/26 01:32, Joanne Koong wrote:
> > Currently, io_uring buffer rings require the application to allocate an=
d
> > manage the backing buffers. This series introduces buffer rings where t=
he
> > kernel allocates and manages the buffers on behalf of the application. =
From
> > the uapi side, this goes through the pbuf ring interface, through the
> > IOU_PBUF_RING_KERNEL_MANAGED flag.
> >
> > There was a long discussion with Pavel on v1 [1] regarding the design. =
The
> > alternatives were to have the buffers allocated and registered through =
a
> > memory region or through the registered buffers interface and have fuse
> > implement ring buffer logic internally outside of io-uring. However, be=
cause
> > the buffers need to be contiguous for DMA and some high-performance fus=
e
> > servers may need non-fuse io-uring requests to use the buffer ring dire=
ctly,
> > v3 keeps the design.
> >
> > This is split out from the fuse-over-io_uring series in [2], which need=
s the
> > kernel to own and manage buffers shared between the fuse server and the
> > kernel. The link to the fuse tree that uses the commits in this series =
is in
> > [3].
> >
> > This series is on top of the for-7.1/io_uring branch in Jens' io-uring
> > tree (commit ee1d7dc33990). The corresponding liburing changes are in [=
4] and
> > will be submitted after the changes in this patchset have landed.
> >
> > Thanks,
> > Joanne
> >
> > [1] https://lore.kernel.org/linux-fsdevel/20260210002852.1394504-1-joan=
nelkoong@gmail.com/T/#t
> > [2] https://lore.kernel.org/linux-fsdevel/20260116233044.1532965-1-joan=
nelkoong@gmail.com/
> > [3] https://github.com/joannekoong/linux/commits/fuse_zero_copy_for_v3/
> > [4] https://github.com/joannekoong/liburing/commits/pbuf_kernel_managed=
/
>

Hi Bernd,

> Hi Joanne,
>
> I'm a bit late, but could we have a design discussion about fuse here?
> From my point of view it would be good if we could have different
> request sizes for the ring buffers. Without kbuf I thought we would just

Is your motivation for wanting different request sizes for the ring
buffers so that it can optimize the memory costs of the buffers? I
agree that trying to reduce the memory footprint of the buffers is
very important. The main reason I ended up going with the buffer ring
design was for that purpose. When kbuf incremental buffer consumption
is added in the future (I plan to submit it separately once all the
io-uring pieces of the fuse-zero-copy patchset land), this will allow
non-overlapping regions of the individual buffer to be used across
multiple different-sized requests concurrently.

From my point of view, this is better than allocating variable-sized
buffers upfront because:
a) entries are fully maximized. With variable-sized buffers, the big
buffers would be reserved specifically for payload requests while the
small buffers would be reserved specifically for metadata requests. We
could allocate '# entries' amount of small buffers, but for big
buffers there would be less than '# entries'. If the server needs to
service a lot of concurrent I/O requests, then the ring gets throttled
on the limited number of big buffers available.

b) it best maximizes buffer memory. A request could need a buffer of
any size so with variable-sized buffers, there's extra space in the
buffer that is still being wasted. For example, for large payload
requests, the big buffers would need to be the size of the max payload
size (eg default 1 MB) but a lot of requests will fall under that.
With incremental buffer consumption, only however many bytes used by
the request are reserved in the buffer.

c) there's no overhead with having to (as you pointed out) keep the
buffers tracked and sorted into per-sized lists. If we wanted to use
variable-sized buffers with kbufs instead of using incremental buffer
consumption, the best way to do that would be to allocate a separate
kbufring to support payload requests vs metadata requests.

> register entries with different sizes, which would then get sorted into
> per size lists. Now with kbuf that will not work anymore and we need
> different kbuf sizes. But then kbuf is not suitable for non-privileged
> users. So in order to support different request sizes one basically has

Non-privileged fuse servers use kbufs as well. It's only zero-copying
that is not possible for non-privileged servers.

> to implement things two times - not ideal. Couldn't we have pbuf for
> non-privileged users and basically depcrecate the existing fuse io-uring

I don't think this is necessary because kbufs works for both
non-privileged and privileged servers. For how the buffer gets used by
the server/kernel, pbufs are not an option here because the kernel has
to be the one to recycle back the buffer (since it needs to read /
copy data the server returns back in the buffer).

> buffer API? In the sense that it needs to be further supported for some
> time, but won't get any new feature. Different buffer sizes would then
> only be supported through kbuf/pbuf?

I hope I understood your questions correctly, but if I misread
anything, please let me know. I am going to be updating and submitting
the fuse patches next week - the main update will be changing the
headers to go through a registered memory region (which I only
realized existed after the discussion with Pavel in v1) instead of as
a registered buffer, as that will allow us to avoid the per I/O lookup
overhead and drop the patch for the
"io_uring_fixed_index_get()/io_uring_fixed_index_put()" refcount dance
altogether.

Thanks,
Joanne

>
>
> Thanks,
> Bernd
