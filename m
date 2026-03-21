Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D7F5D8F0
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Mar 2026 01:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774055974; cv=pass; b=X2/oX844/nkLSdgqrH454S24gPi9GSvOEOzF9rE4+J5X/M+mN1+SBFVXfQFx+oHJvs45aaFDALi5UPxvlUgsMiEfmHU8K+OY7TrOXCJBVBJrvF3GAPsIJk5OTvb/SHS/Bw/XBpY4VM/GId9nMB6uZuINlITYz8zXfR0lHf/9Ohc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774055974; c=relaxed/simple;
	bh=Jqo515c/BgZK/5yBJ9BaW0HLWKPr8AYiv9O9CAKZy8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hTkzOWICQvGYzZu7C40eZyvnbMr3Xn8khfzczV0Lc/Mwee3qO/IiS3B6lTbRd2rb6dSJ951weRMY/js3S/B3bmBTUAnSjMLalgvh61dHUpLwX7DAynBviGkCa9czoickHYsqq7YlmahWQKJGJm7j6gRgHg9DNi02Bn1Z6XZMkhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=heITtZXt; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heITtZXt"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439b9cf8cb5so3256879f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 18:19:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774055971; cv=none;
        d=google.com; s=arc-20240605;
        b=ijuqfpy2KTV2w1bwmMwRnT/dL15CX0UhNPrG6OG0NBJK/ajCxp+tniUkdgf4gw6WbT
         YgonGs3tSynVWtzCq3la+HbaivHbgT/AZXYnoOx464eL3e57p3CTDQo/Hy1SI1Qa7A0B
         r7iMv1sbqSL2g5OY74TXYdTI46+8pQgw+QzUhpZStrG7ukX4apW5IK4csqrpDQP3YHFY
         ciQM8OPRF+8ClCeBqHDgB03wCPCH6Xh/oYJCi7El2ci+oTvRXeK2OKS0ubkhmy71HqrR
         gy8bCRJRT4MBhkj11S9TfQU8IdrYRF9RXEEDsJ6GjqdQ3NpduDI+5GwmgoACl4q2GQDp
         rsaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5LziXhS+PKsI2U4E0Nmh6m6esRTglmNzqvqsZu+LVXA=;
        fh=1Dp/pFfQtghumT0WpcwAy3NHHn3qmQxeUSZJmo5oLL0=;
        b=FqCu2l+8dUfbo9qsomUxZ78Ol2mAIg8MMKtqzOddWYnR2UgFtj/UteULUA4Lg2ntye
         NHp8QcWw8ffBb+NHe+kegud8cT3j+31cd/SCZBV2xs5Nw+gnCFHhLxF2blJZ4ozvc4Lg
         NgwOEL8P+6UEicdEVPvofvtTz/C51oGIkS49IcCPgopKuMX1kqSJ08Dw+SvPh/qBYrhV
         rH77LrDSqGaUvcDzm26JRuzYEfVYtBn+kFAUA5J1msy3yvwuMefE4AoNo29bkwLpDAvh
         s2HiR/WHmCHLMiVX23MF+pFgyU3Qnt5lWWEzmlF93/fD3khRFxW2iovyrPFQw2Y/Be+R
         9h8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774055971; x=1774660771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5LziXhS+PKsI2U4E0Nmh6m6esRTglmNzqvqsZu+LVXA=;
        b=heITtZXt6dVI/qC6HVd95zt6PYnfcKRWMUNVYSAgwxthqe6AdsIaFbqOofPvK3Vjuk
         r1ovnrn39nuqeg6XyrPtzVDy58edEJ2AGL6ILOyWIzdHtsi0ORB1uK45181ZzxP9mN3z
         D+ETNxHjf0pCnbh0gZ7B+ZDC7DkFu1hGpstKtoUyT6WPpXspDSEyAgf2hYksjiF0a3mc
         DWv7+uOtePvlHt9fs8TC79on0RKQtdj3lsoSXMoLiTLP+s1HBwOvRu7Vp2VfhlEYKHj8
         BArScNAmvWqK78rtsijYUJBbJBAKnNaU8eUyQCueyXVeeVPR/tp9MWZvV6QY49Djrd8N
         zX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774055971; x=1774660771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5LziXhS+PKsI2U4E0Nmh6m6esRTglmNzqvqsZu+LVXA=;
        b=SfhGWNgJN9zKcvK95j5EaUUBQXSwnjR8tqsitpihUPJDIJHm3YVm9yPvGvEjT3Ts2k
         s0UclhogClBD07BjeeDxLYy9qgDRI8FENk/iB2u4ZDHc4+7d4nHuZEmsFVVKqN3xcIPE
         f9RZwlJVYfWW6k4HFwyVPZmQjqB1gpt8vtks6Bxp1NsbZ94vC8TzOkhpx0oeV2R7kq/j
         Lg6CZmbc7y/HgEYZDjcBRkTTyWtZuhTo0CFLlk2CP+Z43iQjSYF0fO4gZzdD5V33VW2Z
         ZmDqbm6078MpNHWUMo2YryuZd7dzkYW2Wt3kMapA23eUTmsG4whUs037XHAx5W5J16NE
         vZ0g==
X-Forwarded-Encrypted: i=1; AJvYcCVZq1jMIvJd4O79GUsFqhASgYJOHHi//Kc/3o2Eqag3xcehvAxYs9nrb+LeBivxU8Xeo14AM+TkoFg+0wAc@vger.kernel.org
X-Gm-Message-State: AOJu0YxMa3GXLVvwQEnVvzWj2cpFkeEllqRmKR0iCFs0VoN328bWC1fJ
	eLonzcxWHPG+crAgaAb7O11t5NOt+/K8AfoW8FFkxLPAAFb2C8KI1gpCNyc+nuEXXPUk5Cj3UiU
	IaClacWZ/SYsmoyqojz6rWnlYVmjWIk4=
X-Gm-Gg: ATEYQzwOZQP80bI1IdXxIKAPj4RPDCtz8ZoYUlZLPuCLdf+r/fpOYw2m9t5DSRfo25E
	FXjEViKjBEiAdBHM9DML5Dc8cLvhvtKzwyuNQ66iHaqX6YtALGetWPrf7zy2bYv0yI6O0tqgmhC
	s7r80PchI1DhSOzVEb4CuOsPkp2MW/nkJkPXOWNHiZAowqhVv7FMfdgyLqq0mcK9Fp1UhiMZE11
	POgCdlZCpwhoryK5NenmjhkZR+FFpVGVVqUIePxeHrLayAyQJbnyTmJwFD8h+vA5OxAXIIPhoTw
	7wnTxw==
X-Received: by 2002:a05:6000:290b:b0:43b:4468:b112 with SMTP id
 ffacd0b85a97d-43b6426b65fmr8200715f8f.25.1774055970677; Fri, 20 Mar 2026
 18:19:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306003224.3620942-1-joannelkoong@gmail.com>
 <59dcb27f-875c-4a2a-82dc-63b832f8eb1e@bsbernd.com> <CAJnrk1YLtQF=SF-GoG4irKYzzePNewNgyTeU7VLvUN6Ub_NFVw@mail.gmail.com>
 <d9aae2bf-b81d-42c8-b919-5e64292323e8@bsbernd.com> <CAJnrk1bYLwHpZsW85XiyWfM=gXXXS6pHg4=p9fcbDOwpca8UXQ@mail.gmail.com>
 <f8a1808b-4068-49a7-a17d-8dcab1ae9cdf@bsbernd.com>
In-Reply-To: <f8a1808b-4068-49a7-a17d-8dcab1ae9cdf@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 20 Mar 2026 18:19:19 -0700
X-Gm-Features: AaiRm52angp4XSylGzFu5XLXSrc6TjmoHSygxSLjL3zcUmW3aIneWHY-_S5Q4Mk
Message-ID: <CAJnrk1armV9VzBqrrdfr15K5ySBx2YJRk_P0okGnkzyMx_eDOw@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] io_uring: add kernel-managed buffer rings
To: Bernd Schubert <bernd@bsbernd.com>
Cc: axboe@kernel.dk, hch@infradead.org, asml.silence@gmail.com, 
	csander@purestorage.com, krisman@suse.de, linux-fsdevel@vger.kernel.org, 
	io-uring@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 3:44=E2=80=AFPM Bernd Schubert <bernd@bsbernd.com> =
wrote:
>
>
>
> On 3/20/26 22:58, Joanne Koong wrote:
> > On Fri, Mar 20, 2026 at 12:45=E2=80=AFPM Bernd Schubert <bernd@bsbernd.=
com> wrote:
> >>
> >> On 3/20/26 20:20, Joanne Koong wrote:
> >>> On Fri, Mar 20, 2026 at 10:16=E2=80=AFAM Bernd Schubert <bernd@bsbern=
d.com> wrote:
> >>>>
> >>>> On 3/6/26 01:32, Joanne Koong wrote:
> >>> Hi Bernd,
> >>>
> >>>> Hi Joanne,
> >>>>
> >>>> I'm a bit late, but could we have a design discussion about fuse her=
e?
> >>>> From my point of view it would be good if we could have different
> >>>> request sizes for the ring buffers. Without kbuf I thought we would =
just
> >>>
> >>> Is your motivation for wanting different request sizes for the ring
> >>> buffers so that it can optimize the memory costs of the buffers? I
> >>> agree that trying to reduce the memory footprint of the buffers is
> >>> very important. The main reason I ended up going with the buffer ring
> >>> design was for that purpose. When kbuf incremental buffer consumption
> >>> is added in the future (I plan to submit it separately once all the
> >>> io-uring pieces of the fuse-zero-copy patchset land), this will allow
> >>> non-overlapping regions of the individual buffer to be used across
> >>> multiple different-sized requests concurrently.
> >>
> >> That is also fine.
> >>
> >>>
> >>> From my point of view, this is better than allocating variable-sized
> >>> buffers upfront because:
> >>> a) entries are fully maximized. With variable-sized buffers, the big
> >>> buffers would be reserved specifically for payload requests while the
> >>> small buffers would be reserved specifically for metadata requests. W=
e
> >>> could allocate '# entries' amount of small buffers, but for big
> >>> buffers there would be less than '# entries'. If the server needs to
> >>> service a lot of concurrent I/O requests, then the ring gets throttle=
d
> >>> on the limited number of big buffers available.
> >>
> >> I would like to see something like 8K, 16K, 32K, 128K.
> >
> > My worry is that for I/O heavy workloads with large read/write
> > payloads (eg client access patterns reading/writing MBs at a time),
> > the limited number of big enough buffers becomes the throttling
> > bottleneck.
> >
> >>
> >>>
> >>> b) it best maximizes buffer memory. A request could need a buffer of
> >>> any size so with variable-sized buffers, there's extra space in the
> >>> buffer that is still being wasted. For example, for large payload
> >>> requests, the big buffers would need to be the size of the max payloa=
d
> >>> size (eg default 1 MB) but a lot of requests will fall under that.
> >>> With incremental buffer consumption, only however many bytes used by
> >>> the request are reserved in the buffer.
> >>
> >> Doesn't that cause fragmentation?
> >
> > With incremetnal buffer consumption, there's not fragmentation in the
> > classical sense (eg scattered unusable holes). The buffer gets
> > recycled back into the ring as a whole once all the requests in it
> > have completed (tracked by refcounting).
> >
> > I think the concern is that if the server is very slow to fulfill
> > requests and the workload pattern has it so that slow requests are
> > packed into the same buffer as fast requests across all the buffers in
> > the queue and that queue has all its buffers saturated, then the next
> > buffer is available only once the slow request has completed. We can
> > mitigate this by assigning the request to a queue on the nearest numa
> > node as a fallback if we detect that case. We could also do the same
> > thing to mitigate the variable-sized buffer scenario where there's not
> > enough big buffers for the queue, but I think that logic ends up a bit
> > more complex.
> >
> > I think overall we're able to support both incremental buffer
> > consumption + variable-sized buffers if there's a need for it in the
> > future where the server would like to choose.
> >
> >>
> >>>
> >>> c) there's no overhead with having to (as you pointed out) keep the
> >>> buffers tracked and sorted into per-sized lists. If we wanted to use
> >>> variable-sized buffers with kbufs instead of using incremental buffer
> >>> consumption, the best way to do that would be to allocate a separate
> >>> kbufring to support payload requests vs metadata requests.
> >>
> >> Yeah, I had thought of multiple kbuf rings, with different sizes.
> >>
> >>>
> >>>> register entries with different sizes, which would then get sorted i=
nto
> >>>> per size lists. Now with kbuf that will not work anymore and we need
> >>>> different kbuf sizes. But then kbuf is not suitable for non-privileg=
ed
> >>>> users. So in order to support different request sizes one basically =
has
> >>>
> >>> Non-privileged fuse servers use kbufs as well. It's only zero-copying
> >>> that is not possible for non-privileged servers.
> >>
> >> Non-privileged cannot pin, at least by default mlock size is 8MB. I wa=
s
> >> under the impression that kbuf would be always pinned, but I need to
> >> read over it again.
> >
> > The kbufs get accounted to the user's mlock usage (this happens in
> > __io_account_mem()). If the user running the unprivileged server
> > doesn't belong to a group that has high enough mlock limits, they'll
> > have to use regular fuse over-io-uring buffers instead of kbufs for
> > most of their queues.
>
> That is exactly what I mean - in reality  unprivileged servers will not
> be able to use kbufs. And there it would be good, if that server could
> use unpinned pbufs.

I think it's fundamentally wrong to use pbufs here. The buffers are
completely under the sovereignty of userspace. If userspace chooses to
free the buffers at any point or reuse the buffer for other purposes
(or a free() and later malloc() ends up mapping to the same adddres),
the kernel should not still be accessing the data in that buffer. When
it's userspace that recycles back the buffer, this isn't a problem
because userspace maintains direct control of the lifecycle and kernel
usage of the buffer (eg if the buffer shouldn't be used by the kernel
anymore since it's freed, then userspace simply won't add it back to
the ring). This gets worse with incremental buffer consumption where
multiple requests now simultaneously use the buffer - the server can't
know when the kernel finishes reading each sub-region and on the
kernel side, refcount tracking the pbuf becomes impractical. The pbuf
buffers are a shared mapping that userspace can dynamically modify at
any time, they can add and remove buffers from the ring at will. We
can't add the refcount to the backing buffer struct directly since
that is modifiable by userspace; we would have to track it separately
in its own kernel-private list, but keeping that list in sync is
difficult when userspace can add or remove buffers through the shared
mapping at any time invisibly to the kernel.

I agree that for unprivileged servers constrained by low mlock limits,
it's annoying that they can't use these features, but I don't think
pbufs are the right direction. I think for those unprivileged servers,
if the memory consumption is a pressing issue, then we should either
just add the variable-sized buffers you mentioned or the servers
should just use fewer queues and entries and accept the tradeoff that
running unprivileged has a lower performance ceiling.

Thanks,
Joanne



>
>
> Thanks,
> Bernd
