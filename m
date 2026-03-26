Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A2F392C50
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 19:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774554927; cv=pass; b=jCqMvNLMS7DD8rGoWg4OPxHFCJDMWullzMKSE9USQT42tP2kawospGkLuxiJTGGG6tQJVd2oKkVfQd6Ag/07m+aWm4zxWzkPta6cQxMh1UDEbGfTZAuTwZn4pCHGqokXyubyLyK2TnAzitDEk3AdvwIaL0lmMAugfW4VcNaCYcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774554927; c=relaxed/simple;
	bh=qJB8SEu5Gzh2X/aY5+g1o/ERDdeeYta/+1GGVuE/JHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uS2S3mDP7M1inZdYRS/zd9CiAAOjci/IoYj8XbnghdAHkmSXUjpoIwWpVDvlRouT12+dzsSjP8zHLhtTJuxNVpeXkNuYugzYSuPQxCTnwUzSOScFPiQGyIRf0Zpwby2EW+tlbO4tKw7YJHex9cbPPYhEO829+CLoJpX1NTUs758=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYrwleOl; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYrwleOl"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48557c8ad47so10419185e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 12:55:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774554924; cv=none;
        d=google.com; s=arc-20240605;
        b=HyMXqV2S6W4HGHW4vmNjXm44MqXQUYLSMhEpa/b4QLlCFSahQ8kSKcbYgTBIWL24nT
         +OK1AU4mtiiCPKfHPUNNrA48YfHlaELX+jnKDc2SjxfbVifmLQDBxz+rgSoOwvprAHlt
         /c044LPt7KzmAEvutCxtgyuZ/MvV3AO4qJNDodf7sgrRBCO+zK9m0EZQO5BAw01HOa03
         KOwxKKj9fQh68P4HbEU0LzRqDO/Vuny4eC7u88w95vSfe4yzFNf+Woxt4xtqXQSuRblq
         Q1JA/VeOnOi1ZGHiKwoNyAR+qztJ3H2nlHe87PEy3cOdma8sYONHBCnGE6qdHI6trBDD
         gmZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lkPPHiKupVPWpO71CuQgtbfFz/Cj/q7S+eUyMYfo/8A=;
        fh=c79MlXzC+q1qErymLaVQgjJ8xwc+u4q0mf0Jsce7N3I=;
        b=WlE7QY6WX2TQ5pCqjks+gPh81bYqL57YRp4VV+PObLc7pbahjPyGr1xIJgQW7qVpQZ
         WnfGoTmKgadnFqYAVALXjftTedYQyhOHQgH1UdSzv/gP9PAIwdwIXyoG+Z0SNxjuS/YM
         ajTHNIkmDAgN6CW6zIP0hmjSh10wrzJubHK/TZyYx60my4dIjxJNR5Nx7tDq0EIgTee3
         SxO6CzTgqDv6jG9VD0wJWBKAi2GnwuZKs+nsLvkGOYb5Uqqooo5Qjk2Md8q4S4tzWuZw
         drvuVXFCkmjCTKZ4cFbO/toeX+dHBHWlcuwjFKD+u/CtfnkuaRzBje1GXGwRhPFQjrsk
         3oVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774554924; x=1775159724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkPPHiKupVPWpO71CuQgtbfFz/Cj/q7S+eUyMYfo/8A=;
        b=mYrwleOlB+2c/4hBh7bxJ9oWEr4uP9gGuh1SPStTNWJVXvJnwi0BX6GGKhIFy/G8Me
         yE5FvInNPrSFkTObcxtt4MM+bvXJz53c1jEu0Gra0S6R2Sp4TY7t0zSoE7NsjBkTl0MT
         XHqaePRqma5nk0drV6w9fjYNxVX/mabHMM3gTnoNUspRljD0AQRB1sHP0TAEhADlfmi7
         1XjY9LdIj8ojkHGL1GQTStHft3/350xUuhtPeBezTTBiNciqM10A1R6sTy0854DAcjjV
         G6VceX/iXOZ07Zy8VqybF7sKKkFpYMyGIm7Gi9RM9U5MYEPwTYTelHQKpAzloLtur7AV
         KAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774554924; x=1775159724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lkPPHiKupVPWpO71CuQgtbfFz/Cj/q7S+eUyMYfo/8A=;
        b=OzyK3gO1kynhnzlEjDZJhb06fN4ug2yt8qZm8yH7vqUcMu92wL+3xzhmit9FgIZAiK
         Zb6VA0JugXvTCndSdb/JudDJgNmO+R7w+koDcWKBWWypdKQTKM0RgTgCIotA7O0Nd4Xb
         RbDhQ7m45MMS1qUzpCX/ows7oSuxFuW10+TCYditQ4pOTC2uO4IoeyY9D0hC8Rl9Bknu
         3gSUMCp6VAV4Xk6NEKrydVGnasrZspwpFnhEWoivNEAmI88xDynoDcx4xa2dEivPd+99
         ZGT7mGX1IrkYjLXJUARzjTowzMZw2T0NpjHAferWB5WHrXoOATWueIfpU2j16tCRynyL
         VooA==
X-Forwarded-Encrypted: i=1; AJvYcCXxUj3skFRFg9mKngUA+Z9im2scKukj/KZQxA16fiXUSlFnIVLJA5xoFBNCOSBSb2s0JsGcHJ1OAb/MtUUH@vger.kernel.org
X-Gm-Message-State: AOJu0YwNsTIBWAEFzNa5oK45aBQuVX8Yk/Ays9SezBStTgI5EQM+y9e3
	OTefx5Hjmvfvx3PApUXBuyqjAl4TMZ7we5RmSYTYpTSuzW3Lz8hHGJPRJzInpjgG9iZVSTU5zi6
	CIPZDaDyaAjtj4ZS+mLRbYZuHtGdHXSb39iI/28Q=
X-Gm-Gg: ATEYQzzXuG6vj9mmArmJZGMgBmuCVwomGGtd/3e++a8j6GpphhHGxRiYYgl1sR1uZ5q
	oDXUjkYjDRVUd5nsfEj+Rgk3HHxRR8GiZCfA1JU6kPocebmDy5LzrRlD3MWvyQtbJ/8eYGJf3S2
	pjSeeb5nntMT0iZol89dYg+j5pbSzrjmiPy7FBFwqCiAa7BwoJWqxMBc7ZwOq/Q8Cd0oDySAXwG
	d2oSIZ0K9fLMLB91Skf6WY3gl+Dwyd7rUt8r/rnxLGMwFL9vCxGG/DtIMutWzt/1YZa2xWxfxEO
	cZBeCw==
X-Received: by 2002:a05:600c:8b31:b0:485:30f7:6e88 with SMTP id
 5b1f17b1804b1-487160881a5mr142368355e9.31.1774554924176; Thu, 26 Mar 2026
 12:55:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306003224.3620942-1-joannelkoong@gmail.com> <CAG48ez0H_Z-NQvfOeczECz_sO=MzVDvu+8m+msB55rcAPfQOgQ@mail.gmail.com>
In-Reply-To: <CAG48ez0H_Z-NQvfOeczECz_sO=MzVDvu+8m+msB55rcAPfQOgQ@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 26 Mar 2026 12:55:12 -0700
X-Gm-Features: AQROBzBznLpAcriYs7FOg-wSZ9wJOdMDsPqfGWaCCg1zWSKC80EiZ9XGhT4z_sg
Message-ID: <CAJnrk1aTnoDwDVdgYrcN3tHm-_j79GKYY=8q_Lu=xi8=Cxi4bg@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] io_uring: add kernel-managed buffer rings
To: Jann Horn <jannh@google.com>
Cc: axboe@kernel.dk, hch@infradead.org, asml.silence@gmail.com, 
	bernd@bsbernd.com, csander@purestorage.com, krisman@suse.de, 
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 12:33=E2=80=AFPM Jann Horn <jannh@google.com> wrote=
:
>
> On Fri, Mar 6, 2026 at 1:32=E2=80=AFAM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
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
>
> I'm looking at the next-20260324 tree and trying to understand what
> happens if normal userspace (without FUSE) tries to use
> IOBL_KERNEL_MANAGED.
>
> For a buffer list with IOBL_KERNEL_MANAGED, io_ring_buffer_select()
> will write a kernel pointer into sel.kaddr, but nothing in this series
> seems to ever read out of sel.kaddr; that only happens in
> fuse_uring_select_buffer() in the FUSE series
> (https://github.com/joannekoong/linux/commit/fae19be22ab629b1301f37f2a942=
d5d84b45cc5c).
>
> Instead, looking at the reverse call graph of io_ring_buffer_select():
>
> io_ring_buffer_select
>   io_buffer_select
>     io_recvmsg
>     io_recv_buf_select
>     __io_import_rw_buffer
>
>  - io_recvmsg() passes sel.addr into iov_iter_ubuf(), which creates an IT=
ER_UBUF
>  - io_recv_buf_select() passes sel.addr into import_ubuf(), which does
> an access_ok() check before creating an ITER_UBUF
>  - __io_import_rw_buffer() also passes sel.addr into import_ubuf()
>
> I think that means io_recv_buf_select() and __io_import_rw_buffer()
> will first access the union through the wrong member, then fail on
> access_ok().
> io_recvmsg() will create an ITER_UBUF pointing to kernel memory (which
> AFAIK isn't supposed to happen?), which I think will then cause a
> later failure when you actually try to access the iterator (because
> copy_to_user_iter() checks access_ok()).
>
> Am I missing something that prevents normal io_uring operations from
> grabbing IOBL_KERNEL_MANAGED buffers and accessing the wrong union
> member?

Hi Jann,

I am going to be submitting the changes for kernel-managed pbufring
compatibility with normal (non-fuse) io-uring requests as part of a
separate patchset. You're right that there is a functional gap right
now where trying to use kernel-managed pbuf rings fails with errors.
In those patches, an iter_kvec will be constructed for
IOBL_KERNEL_MANAGED rings instead of an iter_ubuf. I'm intending to
submit that patchset upstream in time for the 7.1 merge window before
it closes in mid-April.

Thanks,
Joanne
