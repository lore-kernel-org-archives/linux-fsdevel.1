Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5D53B9DA2
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 12:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777552568; cv=pass; b=DIjD5zNj37tbNEVKnHutNcpmWqbYh7qqhg+gbP+HFZclIn5XQXpNNfGnG+Iv4NpTXXmc7LaqSIumd9a8yO7g4KKitUedpeHImDsTZqLnlDcwpd78W5LC8akoPeuGuEamPf7bHqQMqrGIs8rmBkhsEGnX6tOb41MGeBqHNPZ4q4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777552568; c=relaxed/simple;
	bh=DdDaa61+jY+6HVqQ++Ejg6Qq5HjMvZNVYAqdh+QEvcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CQsM8ejky15iDnomRVakvO4craDRTYmOCsP3oOdt8QnjJxEGnwPvfqmdbg4FxgaOKc8NPr+p+GtNlg/QWxGfrbk8tCUnUCqm3yCU4Hj+gO26AADTm4pdhKhYn1nXLwlCMkUP7Em1fNKNVS4b7UyO3JvQPqtGTmeAdPeVug3oxkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYK5FEV1; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYK5FEV1"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488ad135063so7747555e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 05:36:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777552565; cv=none;
        d=google.com; s=arc-20240605;
        b=IkQ8z/+75SuLHmq2Vt1IqrTvQbHwkIhrLaPfbpm+5VVRk8aCvu94FONzNF1xurVkdA
         v+QGhMcc70C4ZMGnCuxpOwiq9ScgTlNA3ko74XrlwHvVdn54FAAuxODzi4A2ew+4uUwo
         3qs7673qSHqvQh0FHlBG8mH+Gl5iiveAV4OZNITVHTVwnyRdjp/ZVYes9YGGBtxjwBMO
         C0hPqHqmoDAeBQ1MAdRvwdvWRAsnhBplCwAn1ffclgfNz5d2AatgKTxg77o585W16cev
         ZaYhUY3H+xVOt85GpPzIwgduZcOIHD0PT7aOZHJTipKclUsimZCTmRjXZw/KDr6HwYb4
         9HFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DdDaa61+jY+6HVqQ++Ejg6Qq5HjMvZNVYAqdh+QEvcs=;
        fh=FMyCs1fNA1kIC8jm5PGPPc62xc61ZcQO0MzKYqwsYic=;
        b=VTJ/BjEP+wZX3iy4oLzYpL3JFUFdc649gHzZOH6dvR8ujdj8EaGyP5nXLprn9X1qai
         ITgtTN715neVPEAkIeOu+/wrgTekdnZBLijqq0W3AGNffcOcfWN7ulogP1oC+D63QQSy
         2LZMO0iW7LOizln+SgY5f40bLh/2OaVXXC5NfsQs7+YBvK+LnvsHJYG+IMU3cIUV1lcJ
         OEvq/GE4ygFywPlB9y6I33GukLBl4rVWjABY2a5yasI5MhjF3y9r9TnMXPsjv8HhyM3u
         2JA5bZcYCtdCKb/PvfKuUuW1DWF/5klOPSbPxtoVkNcUyHsBnyuD5qfC49pG+4rqHKbY
         iSgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777552565; x=1778157365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdDaa61+jY+6HVqQ++Ejg6Qq5HjMvZNVYAqdh+QEvcs=;
        b=BYK5FEV1T+moegi22AEvNTYRrN1wrZ1of//vJgwTBPl1hW32fcpPb0HhC6JN3n4eXi
         K/q51VbF1DryNqCIMWJstAOh5J0ORoQ8GkYfpwbyotqzUl8oxPCQqkt7f2TFVE4Oeh8B
         6AqsEkQLUQSwN5MxW7s6ciBQUjpXItWGaYpBOuI86SUJ5k8U9Gca1yijzWRayNfYsizc
         CnCKn5m+x0QdCtpSSOnCRDR8xXVGkoZr2wBxb5s7Ky/COR8xTo4Pz8B+bWtYQ9+MQ5Ka
         3k5qmIfkhBD+KhjQrwZsMge5DG65S8fI46y+rCHXw06mtpT28Az7/rt/B3u6muMZ7F/E
         e1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777552565; x=1778157365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DdDaa61+jY+6HVqQ++Ejg6Qq5HjMvZNVYAqdh+QEvcs=;
        b=V0f+msjQbGvy0l3+kH5VLnqCyQB9hbmvCTKTHaWc0BYGU29g9zXujf3tGd6uQO/atD
         QnW4w+0uYZbk7VJH+lFqKU9kRDvXQC72MPTzeajuYjIvUBH6Y9AMUWU2Yg1CLLJGwd4S
         JZTPzmtoTiLjqzI4/TbgtCFk681uAUNrPPGFcAY96IM7QnB/2VlOk7d//sX1SecX8vH5
         OimHo2zvsEe43+ZcA1Ay6CKDA3MUJFPtjIxRoyLUpikOG3QUM/HXAsviTqipLOUznR/9
         9srGgjkoQ1nueFNIIHYRF5p4KzgIoH/KjdYBHL8J/l93vBLxWdPyaTjkyN9LfjM4+BHf
         jvdg==
X-Forwarded-Encrypted: i=1; AFNElJ86a8p2OEabO0YrnzJGiuHshcyumHx8xoECDw3wdiQWuCJoIoP0I8oG51pbCgO45CI3pZrYPM2jGsVRrOz1@vger.kernel.org
X-Gm-Message-State: AOJu0YzXU66FxlNkHT6FStIttf2fP0MtjVSjzgugaHJoKFb1NAhJ5lTQ
	KPfqZOkx0hYwAqngsBbmB1LjIOfQdPIUY35TZ5VOq5fzwX5kKEnubky+1NiZ/bP0DoqGj35Bz9W
	qYw7q7XcGNh51izv7ORJ5V3bVW+fSjVw=
X-Gm-Gg: AeBDietKT210n23rxuvT7cWX5qnvv3mX67GFNLTcn/zGmgVOT1IoW3iKpVcb6kH2o6y
	ezcPwwVLd66RK/btlwlXEZbLhZM7qj31Xfes2qFtFZvyS6mFjVTSU4MwOK1FMvFyEtZMx+sKFYl
	l7VKKLime6qZQO02nI5TlVtI6jHOsIsCaVvUR9uXSjouTNE9a33F3D7uy0T/txmh2fUuPaGOpcf
	zDwdcMzMwTEJwYeXv+aETWat14CDFYnUDjDUdn5oHvsy5aw27unZNtLo9hWpEdrc8VZEjRa75Es
	6f8CsvEUjB4rLj+TwKheNo93QxUCNzsUFLRuaGHvH+Hu
X-Received: by 2002:a05:600c:3b28:b0:489:1ba8:5bf0 with SMTP id
 5b1f17b1804b1-48a8445e761mr46705835e9.21.1777552565133; Thu, 30 Apr 2026
 05:36:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402162840.2989717-1-joannelkoong@gmail.com>
 <20260402162840.2989717-14-joannelkoong@gmail.com> <08e937f488a261d7bd3684c0db8d517a1f33422e.camel@kernel.org>
In-Reply-To: <08e937f488a261d7bd3684c0db8d517a1f33422e.camel@kernel.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 30 Apr 2026 13:35:50 +0100
X-Gm-Features: AVHnY4LC9KSaotyLQdeiKqC8JHnm21gn-MonhClgkxjATNi9_j_Pt4nuM4BIXII
Message-ID: <CAJnrk1asUJqskOidATL8SBFcgmWLxS=J93ekW5YdJdLAF1Jr=A@mail.gmail.com>
Subject: Re: [PATCH v2 13/14] fuse: add zero-copy over io-uring
To: Jeff Layton <jlayton@kernel.org>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, axboe@kernel.dk, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 12:42=E2=80=AFPM Jeff Layton <jlayton@kernel.org> w=
rote:
>
> On Thu, 2026-04-02 at 09:28 -0700, Joanne Koong wrote:
> > Implement zero-copy data transfer for fuse over io-uring, eliminating
> > memory copies between userspace, the kernel, and the fuse server for
> > page-backed read/write operations.
> >
> > When the FUSE_URING_ZERO_COPY flag is set alongside FUSE_URING_BUFRING,
> > the kernel registers the client's underlying pages as a sparse buffer a=
t
> > the entry's fixed id via io_buffer_register_bvec(). The fuse server can
> > then perform io_uring read/write operations directly on these pages.
> > Non-page-backed args (eg out headers) go through the payload buffer as
> > normal.
> >
> > This requires CAP_SYS_ADMIN and buffer rings with pinned headers and
> > buffers. Gating on pinned headers and buffers keeps the configuration
> > space small and avoids partially-optimized modes that are unlikely to b=
e
> > useful in practice. Pages are unregistered when the request completes.
> >
>
> Can you elaborate a bit more on why CAP_SYS_ADMIN is needed here? It's
> not immediately obvious to me.

Thank you for reviewing this series, Jeff!

This is gated behind CAP_SYS_ADMIN because zero-copy allows the server
direct access to the client's underlying pages, rather than operating
on an intermediary buffer that the contents of client's pages were
copied into. A malicious unprivileged server could keep direct access
to the client's pages (eg even if the client tries to cancel a
read/write, if the request was already sent to userspace, the server
will still have access to the underlying pages). In the non-zero-copy
path this isn't possible because the server only operates on the copy
of the pages and not on the actual pages.

Thanks,
Joanne
>
> --
> Jeff Layton <jlayton@kernel.org>
