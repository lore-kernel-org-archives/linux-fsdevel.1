Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48B3199D8
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 16:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774888592; cv=pass; b=rOrstdZHaMchL7+NnmvjMKp6QlB/7gn8/rQAt5YY2bGL99QHAnn2nm5oynZircg0iv8GavoJy4rzsGhes+CrwQn6h6Agz2EG/hd3VOLcRrlAAZT5xwrSarXj1pdmE8J8FoATjNQ74fldegko1wXxPUDt2VadSTR+oeH0I3kVIkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774888592; c=relaxed/simple;
	bh=lRpmBzbJ2y3v5I1vQVYUfVMZX2Rhzu2Tqeud3CF/U1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o5JXHrDRF7Vn+evhB+4tPGh9ku6yRdsj6O9fGkupevQ9ExZ0cJCcbuXrDUeSsWy9KEXJynOhXzS8xb0CdouKNs+AFItAIP4s7RbvtUQ4SAV+GtQ4mgWzpvWHxGQW/ZeryeNd9gUxy0XRPwF++nq1XL9luKVnLYGR6jHSwDoopYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XuClYAyk; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuClYAyk"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-486ff201041so46838355e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 09:36:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774888589; cv=none;
        d=google.com; s=arc-20240605;
        b=YvM9J7+Ix52VAiVSR97yet4150ZExHBN6KqQ3PEqEAXcLLplSC1OJ2PcSEOTP4gXK+
         hiNU+h5Xa/zarIqnfIdVG3+yoLgcgku1d2HlAtJWxjvX1H5nO4JVsGrOleWRk4LCLW8w
         tigDdbp6U3lI5k/a0BUkv3yZE3FHqjG7buavNgLjr/meJVc8nDPJQoY0QohMDf3xE9yP
         YrN7w3s+Tn8cBJmNd5Ky+Y6t+ebYyX5cF3jFuNBEVGMQ7o8fMcpNgnC4wq4uMT1WPU9f
         okDNzrIvpiq34Uc+RqXlYZSviKN5Ky2SIUpkzd01Z4vuZMViYQ8bKkTuSLLMtG6v6999
         Uzww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VKLr+L2TmUFppPid5N5ASUyuTHqufpEapHu+AszqT34=;
        fh=m1xlAMayKCpJ/bL9TT878GVleU2zVBRgr6EkCtrlUB4=;
        b=CDnRnwSIGdmuZN46TSYVt0OUGHeSCjAFn+OwzUZJWCFdL22JJ1zOER2nc3JI2hinMF
         mtCKpfNO7P5zXwuzYPUP+IXPGCXgrTbXe646/5XYj36ZNUfemddWcKDJ3z386nzvGg2w
         4hxdVKBPKgvMEa94a+Q+8JNvPQi9xVlmA0nQ0hj9QyqKY3GNajCJz4lcB4mzA4F4rIv3
         Q/NNqZ1ld+yhDP35z6uaZANffRPBlOGQvZuh0YA9+Mk3S3ZV6RhaCcYKdRagllzweuQ5
         I4lD7uZIR6M9T/Lo5NdStajVbKPxWylla0Upyl8dXR8cDopKy07h2rBcUrRO0s7nHGvd
         84Zg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774888589; x=1775493389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKLr+L2TmUFppPid5N5ASUyuTHqufpEapHu+AszqT34=;
        b=XuClYAykKsdrzS7J7FbyL8QaamVpgb/rLcwenXfGPzqpA7PdGjj/z5JkKkoiYrxePh
         JmoolBuwTpVWJGgaF1uql8ZIRXbW7BTeCSNXSCyAfCrFwUnH5PhlIWNKHWLczwP88agB
         v7OYhfOqRomsY8E6lbt6vEPeJWqWRqglRC7b+oRFvei5TSXiKF6viphJGz/RO8Rkes7R
         IXULMbJlGa2vpf+3FosP5MFnEz57zh/+MeNJkhDOcKYUclbj6QvUwC1dhvm2gVN6+EYL
         hyBg5AS+HzhcXxuXdfqDTISFiihWR8qu/rKLLg4SmY1xQu7ZCvL/Xzhqr5DQq1g6C5+7
         vPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774888589; x=1775493389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VKLr+L2TmUFppPid5N5ASUyuTHqufpEapHu+AszqT34=;
        b=LXSq4p3gGENpgEFbJOu5WUnbHrlCelEffad/1A4rlp09PM3E1UbpXi908OVcaCasiR
         9WhWHdrrzZqFsm3S8/WRHN0YrKdV0q26QePXgVjLfKyZZkHpOPmKnDKX21knI2Te0CuD
         cBEvzqVd9wdESF0/s0x55QCUUIRe+ghGTE6UuCk3+5yY4QnS9oYt7DY3Jt9zeGlPb81N
         OXBvWjtCPvpySPBi83HGbKJ+ulPt+G00bJttTH7LwpDSfR1DIbTdxkYZMwymbUQgFI5c
         fNGxMcCil8O8Qe7rhckD5BFfaWB1nzAccgcFO0sW/26qRRb2U9rZS29pj2GKFeOOeqRM
         Vwvg==
X-Forwarded-Encrypted: i=1; AJvYcCUlE5+USkyFGeF8rN+76AWUvXWgxUNERTseyd7A25s1TmnLZGCaMMALuH9cPfMUddhTwIwSEYrD8WGf2n2n@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3UoRYwSSZrrqvMQuZcMaTc0WBKuw6D2WeyV/HBwL3n01dPUUT
	oDC4AnzgHJzp1KSvjtfSza+jdCoYyQJSjSKtNHu1OxZXSkQ4n9VXKQ5uKP/e5AG2+wQ7xGLF5Iu
	tGM3NbXrXgqKoVoqpIBWJ+DyPeBzlaxI=
X-Gm-Gg: ATEYQzxNSiSArdjHculNE3dVVbUhKhV/2MG26OHA0wCxDRX3zh34+F4OBmp9BmInUaI
	/OKxuiqZkjzozMjuGvXhH1hS7BPgt+GZbhuX0U6A/J5XPqI+9WDrQnx50YxR8U3mrLV1TQRJQb8
	3yetErf0VM/smZMxbNK+lO0TU7g/4SImHpFEAcjNn+hGp4kEVuJMHFk35vZOxBTJVbwYZ2AGGpx
	81zNPo0XpGl62VO0+azNDI1XeGVQ6i8ctBPOEKpQhtcCYmGELgmu1ka8yoq3jWsmXjHxm1QpoWI
	RemzZA==
X-Received: by 2002:a05:6000:2903:b0:43c:ff58:35c7 with SMTP id
 ffacd0b85a97d-43cff583754mr7712708f8f.14.1774888589231; Mon, 30 Mar 2026
 09:36:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306003224.3620942-1-joannelkoong@gmail.com> <177402515458.59192.3003058602103165983.b4-ty@kernel.dk>
In-Reply-To: <177402515458.59192.3003058602103165983.b4-ty@kernel.dk>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 30 Mar 2026 09:36:17 -0700
X-Gm-Features: AQROBzAE47q9ygVHrHM_MasNQdhzhlJXWzZn7kJw7EmcefVJHDk_T2k-X-IbTZQ
Message-ID: <CAJnrk1ZMmRpLc3uPMuD2jcb8J14gZryb7jno5vN4cNE4OXEBXw@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] io_uring: add kernel-managed buffer rings
To: Jens Axboe <axboe@kernel.dk>
Cc: hch@infradead.org, asml.silence@gmail.com, bernd@bsbernd.com, 
	csander@purestorage.com, krisman@suse.de, linux-fsdevel@vger.kernel.org, 
	io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 9:45=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
>
>
> On Thu, 05 Mar 2026 16:32:16 -0800, Joanne Koong wrote:
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
> > [...]
>
> Applied, thanks!
>
> [1/8] io_uring/kbuf: add support for kernel-managed buffer rings
>       commit: ff168843d80cd1855b646c5e8be2c6aa5bfb8adb
> [2/8] io_uring/kbuf: support kernel-managed buffer rings in buffer select=
ion
>       commit: bf4a6eb27f8135f36a5286bd5ba87bf6468c1283
> [3/8] io_uring/kbuf: add buffer ring pinning/unpinning
>       commit: b6ffe5399bc04abab4da9afb2ba092e6269d7077
> [4/8] io_uring/kbuf: return buffer id in buffer selection
>       commit: 9aa9e55e8bad1b65c9bcc2892101b06ae00c96d9
> [5/8] io_uring/kbuf: add recycling for kernel managed buffer rings
>       commit: de48bc0efc58d1ebf7e35c36dde6eb0e6b246b8c
> [6/8] io_uring/kbuf: add io_uring_is_kmbuf_ring()
>       commit: 08b57b67602a98abf4b454a363263cba9fcfc91f
> [7/8] io_uring/kbuf: export io_ring_buffer_select()
>       commit: 4706d1f235ff94f19b5c818bc0a3abd735903695
> [8/8] io_uring/cmd: set selected buffer index in __io_uring_cmd_done()
>       commit: 3515a2aedcdf459fc851df40a3712fc4a9a060f7


After reading the io_uring/net.c code and considering how it'll work
for selected kernel buffers, I don't see a non-hacky way for fuse to
take advantage of selected buffers for socket receives. I'm realizing
that it requires too much special casing to make it compatible with
fuse (eg relying on the bufring being permanently pinned, different
locking requirements for the bufring for fuse vs. traditional io-uring
paths since fuse shouldn't contend for the io_uring mutex in the
request dispatching path). Kernel-managed buffers doesn't tie in as
nicely as I'd thought with other io-uring requests either. For
IORING_OP_READ / IORING_OP_WRITE requests, the kernel buffer would
still need to be placed in a fixed buffer since the sqe unions both
buf_index and buf_group and I don't see a clean way to route both of
those fields through without making the uapi worse. One of the
principal reasons for having kernel-managed ring buffers be part of
the io-uring infrastructure was so it could be easily integrated with
other io-uring requests, but I'm realizing this doesn't hold weight. I
think Pavel was right that it'd be cleaner for io-uring if this logic
lived inside fuse instead of being part of the io-uring uapi.

Jens, could you drop this patchset from the for-7.1 tree? I'm going to
move this logic into fuse instead.

Thanks,
Joanne

>
> Best regards,
> --
> Jens Axboe
>
>
>
