Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE2930C368
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 12:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777292752; cv=pass; b=jwxgO1O16RQoqhh5Wqg/00nHaklRqmspq0hDNXMDx/fCLIeiuxO0rTKEDaFlhR9smdzXHdxgH7gqYCXm3Ux4QOHSgIfpRHgQBMRErEqlMAJQq6SHYAykUPu9FGzePsv9VxDFo94k89+oTzGCdT+dcMiC9ko5ghVpjaOrfYkP5sc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777292752; c=relaxed/simple;
	bh=iPkU5RuEL8Iy6q2f8Fs0pTAtTlHnZJ/9+nx794HDw9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ROuOMMehy8m/9GYlHW6fuFwump/zw86eKzFdekKbM0elSq1495FKZmvyt3feb0zBAdazWA2lOuUm0jN1MatrCLyMsY9QJBEfrWjEyqFJg8Fq66heaHp3JES7+ja28Bc9/3/9w8UdOE6kfPjfXtkvfDCeT2TQLeXowaGT6b0UZdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOgyCp3y; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOgyCp3y"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43d7badbd7dso5000096f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 05:25:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777292749; cv=none;
        d=google.com; s=arc-20240605;
        b=X8CMv2kuQyROqAxHFQxxfOtqzV7VSwLYtmXBRZaMYfwjzGBHtbqdJmJakqGQ6l6iiM
         DreL6fB6+HQTSAzjDNyx4O39To3KZMhu7cggHf205aUQk8+aJSjE8YJ6PwASdtdHpuh7
         hB88kAeliiLy+5+mlziGBMLlAMnB22+nbJc31NPdplh8/XL41adC1FrPe0cN7Q5RAULg
         EjapnStIG2e71+0tlrAa7809PZRX65xC5Lf6k7INLD3ymHVWwdLgrQp50nz37IzWiTdL
         WZBVWEyYWB2Z9g5tyjzHQNGSI3uEUkchgxYiMBgCV6U9wX0S1Nime/IzW89K5FzHMouO
         tfRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BHgplsNg6bzhAd39uFIAQ0QQ4UvkzNmBSSVztLVGu7k=;
        fh=YrwS/UwsRIAFC2vyo4ATWgDnoj40tzC2szoOiHxaw8A=;
        b=d8wHhIr61bRx+zsPA37CgBS2y+1mozrLzH0k2grMq1/Bs6beX2MOMPr6isrjTAvbom
         HFL9kNJYQKCFiEyQ/km4EUZbIypzU/wF0I9h0azi/hzqYvN/62SWLcJ1A/H15piKjGs4
         kTo3jCwyDraIpT1z1mXW9VH2CzqcnJWj7uvRKsJGr3bzl23cjwppLNgpGCgNEH7rotbH
         STt3mjmnCQAhbKSqhuisbMVblHJ4iJoNCrWI0MTPY/hr+wuzByHVv2T2aMVXXUnc8ri6
         9MY16/iOFEFX/o5y/WXPXBAhQYdbopjIqoo9N1F7vjbjk4Oc6ShK4PkfcJtspdI6h7CF
         EU6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777292749; x=1777897549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHgplsNg6bzhAd39uFIAQ0QQ4UvkzNmBSSVztLVGu7k=;
        b=iOgyCp3ytKAp2SWtTxUNk4/ANs7a/vv50JeBv9pgDd5727KPCir/Bq38yN2bBT2Wbe
         G+T5T5XZm/KeJEwmAYL1tLB6DoO/KQ0O6mI4o0tvCsXKmCgHBh8Wz7lDmmJHEftMF286
         xVujVekU3AxGefYEo5fA00IOd7bdHkzewgQXm7J1ORGT31IIGWoJrHEkLIUyhVqbb4bH
         soi9PJu5SM1qo45KdlX0iCraGP3P9XxvPryBU014u7NbNYsIkn4wHjTYvILgji1o5T3f
         2YTOVf3pHFUyNX4Ff61GcRfxYhRrYvNL48b/CiV9lOzJB/J8Lq9bXBf4vSajrvNVGOmm
         9fmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777292749; x=1777897549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BHgplsNg6bzhAd39uFIAQ0QQ4UvkzNmBSSVztLVGu7k=;
        b=GF1ebVIex+DtF1UKcbNz8EfQcCSsYInj8CtS4gcdaTU0rp9uawBkC2xsJUVe4uSdJU
         Wf4kVYI8z//33EctlqD/hqSjGlyBW9qyOCVTNAWt5lzX+o1k5PifGrsun8GhS8ZbyNv+
         hUsuGpQa4tGdGBhEFq48Hen1SFhWkQlNqrNuGayFOn8R9ztYTEwdq502cv61c75Pnaan
         i6THGtFlUCuQWps71wKUqRyJ6zf5f4kt4XksO2wx7vrKH6L5RIdlhhWcgozCo/PLCzo6
         E11anbSDrFBtzpDk7MtpsE5yPj/nffHAmjVEAbDt5Ra6u7+nBhtr3/U6Em2bA9FGW7uc
         Gtsg==
X-Forwarded-Encrypted: i=1; AFNElJ+3pqQlJ49APk3FyXzMokwSIPv6OkM6HMC5kctG2KP1pTShyRfZp0jiGWQ3UPEhIShTQvs+8v0qLlXqcYbw@vger.kernel.org
X-Gm-Message-State: AOJu0YyQtzWY+qOg8l2VvwWqN2lm+xq73n1TjjSbyUoG5KlM9F1FUxXA
	Gawf/4L32GDAgFt5ZE98zNUrup+cKzLbZg8uaS3Ta1myOpe8aSheG1sMHHwBuWC+EMQeZehOGAc
	sTU/8tojS2WB4cgUYcTxoy7mLp1Uxu5E=
X-Gm-Gg: AeBDieutVz8gXHJByv/oGEw/Tydf9xu1fJ6eLG3S8cV3aGaFj3TKLbwIYLVxos8QJMC
	c9F+Fa0rPua2285WNPLWWD8O0ePzjvI5GOgLcVZLKRyTGZMN6GdQRu/D195YlxG4SxYmU9cmLRN
	1HqUKW5P76MECv+FlWqaWvc+Bmq6pK3MFzYBzIjgYZy2kDYMFHUAy/a7lKh5snWXWO2ea1V9hf+
	FOEoN9l5o9sFxxWLo5HPgQPJdvFQuu/ZGvBDrruIBPvIi06ycnYoCAsI7iXrUQ9+NVLYgtUtKni
	DluZG7SrwWepo3UdUlXhl1pa1E7NJtbfUw==
X-Received: by 2002:a5d:584c:0:b0:43d:7403:4b57 with SMTP id
 ffacd0b85a97d-43fe3db3ca7mr63378813f8f.10.1777292748623; Mon, 27 Apr 2026
 05:25:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403035752.20206-1-liwang@kylinos.cn> <20260423110954.2676-1-liwang@kylinos.cn>
 <CAJnrk1Zb=+syR_aOLVs4aXMTOUO7BRBi=MU-20xQOcDpf2iQ5g@mail.gmail.com> <1a25fd7d-f122-42b0-91e2-487235263af5@bsbernd.com>
In-Reply-To: <1a25fd7d-f122-42b0-91e2-487235263af5@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 27 Apr 2026 13:25:34 +0100
X-Gm-Features: AVHnY4I9K_5cEt71SBZmqbWqe61axndnexoDDSQnFGq1mtWGqmUKRI3sf_8p-Og
Message-ID: <CAJnrk1bgpVyzE2++BpPxK6RAhXHxFsQw=Jamf3OYmSvURDBj2g@mail.gmail.com>
Subject: Re: [PATCH v3] fuse: optional FORGET delivery over io_uring
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Li Wang <liwang@kylinos.cn>, Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 26, 2026 at 4:48=E2=80=AFPM Bernd Schubert <bernd@bsbernd.com> =
wrote:
>
> On 4/24/26 22:38, Joanne Koong wrote:
> > On Thu, Apr 23, 2026 at 4:11=E2=80=AFAM Li Wang <liwang@kylinos.cn> wro=
te:
> >>
> >> Deliver FUSE_FORGET through fuse_uring_queue_fuse_req() when the io_ur=
ing
> >> is ready and userspace has opted in by setting
> >> FUSE_IO_URING_REGISTER_FORGET_COMMIT in fuse_uring_cmd_req.flags on
> >> FUSE_IO_URING_CMD_REGISTER. Until any REGISTER
> >> carries that bit, FORGET continues to use the legacy
> >> fuse_dev_queue_forget() path even while io_uring is active, so unmodif=
ied
> >> userspace (e.g. libfuse that does not issue a completion SQE for FORGE=
T)
> >> does not wedge ring entries.
> >>
> >> Benefits:
> >> - FORGET can share the same commit/fetch loop as other opcodes.
> >> - Reduces split transport for high-volume forgets when the ring is pri=
mary.
> >> - Reuses existing per-queue io-uring machinery and noreply/force
> >>   request setup.
> >>
> >> Signed-off-by: Li Wang <liwang@kylinos.cn>
> >
> > Hi Li,
> >
> > Thanks for sending this. To be completely honest, I'm not convinced
> > delivering forget over io-uring is worth the added complexity/cost. In
> > the /dev/fuse path we rely on forget batching/amoritizing and explicit
> > scheduling/fairness logic so forget processing makes progress and
> > doesn't get drowned out by regular requests; I think we'd likely need
> > something comparable for the io-uring path as well. Additionally,
> > routing it through io-uring makes forget behave more like a "real"
> > request on the ring (it needs per-request state to live until
> > userspace completes and the entry can be recyycled) which introduces
> > extra allocation/lifetime management on this path and it requires a
> > uapi change and corresponding libfuse changes.
> >
> > Forgets would consume ring entries but they're tiny one-way
> > notifications and imo I don't think they benefit much from io-uring's
> > main advantages (eg data-path/zero-copy). I worry theyy could contend
> > with read-write heavy traffic where ring capacity is more valuable.
>
> I think when FORGET starts to disturb writes or reads, there also must
> be some metadata load that causes many of these requests. Going via
> /dev/fuse also includes another two syscalls and cpu task switch to the
> libfuse thread handling them - that is not for free either.

I think the /dev/fuse cost is already amortized by batching forgets
and the io-uring path would have its own per-forget overhead (eg
needing to reply back to the forget request which would be a syscall,
needing fuse_req and fuse_forget_uring_data allocations). I agree
benchmarks would be useful to make a conclusion about performance.

>
> However, this currently might disturb reads/writes, if the queue depth
> is limited and memory optimized to carry reads/writes. The missing
> feature here is to have a multiple request sizes on the same queue.
>
> Btw, syscall overhead is basically the reason why I wouldn't like to
> have multiple rings per request size, but one ring with entries of
> different sizes. Will try to respond to the other mail later today.

I'll keep an eye out for your response to that email. I think we
disagree on this but maybe we can discuss this at the fuse BoF next
week .

Thanks,
Joanne
>
