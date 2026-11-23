Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795475973;
	b=BXpJW23SDe1OfGDqg9PUwwOpDAqooYnj9vw+j4PXgQuiQPyJ7s5oHKOqhT6/MRlwOfj5
	 FBUuVOu8ayIyXaFtjqph6yeybw/I+fgKJymzW+rRK7Es5jA9KijALJYGeXOpmYlRoFIzU
	 9EUPHANoUoJV1TQkwqp1qTQHwR8bBE+USZyKZ7wd+/kf8NuYBOOCbPPxB/RzkMBxaThkg
	 oJK4jVvugt/U/Jb3Ftbh9KIoMnhrXNUS3iDROTeiNKnfAP6R3HMj8HgzL2jxClNegi/kz
	 ZzBX0j2aHXMBJ3KUsJV+8LpiMOeEx2oG9mmyJY6z9GXzNL2BqoVVp3XH1e1XUE4STYQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795475973;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=cLhWqv/VagBjB5zuhR0ieKg5bnQX3hK7LoyWZzsgt5I=;
	b=WbYX7s5fs/y5m+ULRd4zBeAUfbpHylWjK1ucOjkQ6Uh49kTT3pMdlUCXhLNLPjSQ8UUp
	 NHJTy3l9vvz3sVSVAOLF6ZA9fVHsFbZnDI1Y7EXN8Qua/NHgf8bj8Eq+i0PqNv66E59Tw
	 23qhEQjdFi4+IIen+0K/gewp0u6poHHklEOO/eZiWlqOFlkvACfa9liWcpBxfb1rGH8pm
	 P/1okE3w5cUYzTI1HHPTny9M1QQ1gBJLRZ7LL2RlLhRjGFx/LCJs0ScO8ImcQeMY9IWlc
	 YOlJUbmVjPuv3GziruIerm8V+wnMkbhGdMMdAFq61J6UQE7S8PM0azPU8nbx0eswHMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=YhXtktK3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B95606A327
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 23:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21B95606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=YhXtktK3
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8b9c51097e2so1349198b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 15:19:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795475971; cv=none;
        d=google.com; s=arc-20260327;
        b=d0xTi8AFLx5wkeCNhEwBoAsKgQTRaBHuVY+SxEE6TKIGTWz21bwNSHRibydP0MlpxT
         voKqOP9FHlKngrx1TN8wOFVZf1AWt0wpz7/AQq0Ez2jYRAfZ03NBlW4sBJW34zZYL6rD
         jtUA4aWAYAb9e+rWmegdwQmC1cVfSz7OF4LbXj+OwHJQCaYO7vDayNsZFFrXyRn0oX78
         9Ra/Dz3fE9VUlK02D1NVJM2VIXU7F/FDwZ9jJmH0XwOxrKaNWkUI3ZV4gRSobJcMma34
         DTnur3Le9tRz3JJ8av7Vr46GP+iC2uoayNQ/uzsIhSnz20B2qh6GQ+y8Zcpl/KCo73pM
         2CPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cLhWqv/VagBjB5zuhR0ieKg5bnQX3hK7LoyWZzsgt5I=;
        fh=SVRf1FX0pn3orfkSWevt00CjaMb3GuNecOe071Cjlss=;
        b=fcsUPoMeTc4T9BZN8hmYoI1zUn6jv7y+gixJhmJjTStkowJhcRvtH2KMXVV8O+qXI2
         OwJwjK/e7ch1Ij85qmu3BFnRowt0S8EN5pla4rMyeoKTHG8gEyaEBlPCSMvk7RRuuhZD
         kxFdDgjUw6jXXHj1IxMpfrgfUGmHFkUpYFGl7CDssFr0v934rNYinK2DkIp6RN2Rdt1s
         O9OvzgntkV1PMzJFnutTfeWFH4Dp2ppdkyemDtOPa4kS+lwqoogvqNvMFziYY8GL+FqA
         Ax18IvcEMFxo7D/L/TYrLvO3dkBhY3Kszck/vdcycb55JiuQxAPChOfWYvaWoe3Vdd/x
         E4sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1795475971; x=1796080771; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cLhWqv/VagBjB5zuhR0ieKg5bnQX3hK7LoyWZzsgt5I=;
        b=YhXtktK3TaxHoEAlQRblBl5NwaiIJzMRG08xeTEasVOlhXF9VzuYseXJhgLWW2EHGt
         JukoaxQupFfWcUqLaF5oxSvwZynvmpg5wICI4n+s01aIPBDvOkU0KbknfNARAEWMBVN7
         OKYXJaegBPz6ilzvzpEe6ACY1YEwIQVhkcYg5inow+PiZfU/wA6/6QKhD3ePBVWJhPrL
         ERwCuv/jfq+xLZhDIsBTa0sAaLtawlsX3BJ5AfDooQoz4b2oyft7coosdea7B7X0T8EA
         b4VjDkmEl/GIJJrySearV1rDJhdFqmMygt7PmizPlzGdZTWHEWeZjplLfY0n2sMGlpjv
         8/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795475971; x=1796080771;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cLhWqv/VagBjB5zuhR0ieKg5bnQX3hK7LoyWZzsgt5I=;
        b=bqIUdMK/2r7dtqhQxKs+PeeUIY9H0UfwAPkqD9yaPvidBMbqrqEDmTX9UEjK6eybyg
         ++QyryhB3R+ofiMl++wD6Xo6YIxuOp6fXQWunnky8aWbiIwqRSSiaetDnBZlAKArrQ5G
         ync0+QXDkvLIEIaiDVkGVOmAtHsq2G+8Ggn0blCJplN5FHTvB/rIlrnWUD3XqWr5nBPN
         S4pLcXANZn4XqAhJGo+kdby4CxSyLn8M5/cBLkyVcgRX3MftmDrMUaym/ggXsd4iP4Vw
         oq36jS6HmIonLalTpxRh+98f+YdwRqmmJFFNW9lNqIwx+iZr5v7BbORvyWFy8iKZapRx
         VRUQ==
X-Gm-Message-State: APuU4Z9ifdoQx/HdNyvrSYOEfLnptDldFgY1w+O+5Ep4KD8LViMouUa4
	rgx10YVcJCwLSQoqQUARAW7Ij75ezoxS0GRji5Lsk5xhyBXQxkrqb19x6MKAskBxRvOex3naXpv
	wNPgORthj7mw6SnoGOGMwbl7+FqOA0LLpNMwnonQG
X-Gm-Gg: AZFdTZd3hdHY3+PWJLyCgUj5uVe6/MyvV/z+L6yYTBqoxxIkFVOmlA0Cg6ls/+rc2By
	a3fvUsWq0DKiY+op+drY8w9Fh75YPMAekdTGVJk4w1V2+M5hMv5AoeK8ARKdVonSAVbkvQik6rn
	/7o5d0aqggh5JcfR3iKwdjAEPaYvsmHEY3irSP4CjzbPv8kVuptzU37nSYqUpNjmL3GJaBNN0LO
	SFM7L7+GYoq+Xc72tCDR2WYXhEzTtzrFGVio/CrqHED8xZ4husFsYkOC3pXMsU4fYz/G7BXNvN4
	MpsmbWlHiwC29LGNfoGDqzs2Rgo7VKjslFkaGLXeXxrmhCak/tfqyCKRuzKYB2CTkTpH67MU0eO
	YwnPMAIh5F11WTlfynYLUtVmPdj2PW1gp9JDNcB7rwJ/J19wEu4heLeWE7b/ywT5uHYOyfQ==
X-Received: by 2002:a05:6a21:7111:b0:3fa:f23f:a1ef with SMTP id
 adf61e73a8af0-4014da5d430mr11922129637.61.1795475971432; Mon, 23 Nov 2026
 15:19:31 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029-work-security-namespace_free-v2-0-65591dbba7b3@kernel.org>
 <20261029-work-security-namespace_free-v2-4-65591dbba7b3@kernel.org>
In-Reply-To: <20261029-work-security-namespace_free-v2-4-65591dbba7b3@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 23 Nov 2026 18:19:16 -0500
X-Gm-Features: Aa3M54pQLfC4vU3-6-r9j0PdP3_OAJ4uOdt5cmk3KHNndD-uhH08FyqH6wqPWRk
Message-ID: <CAHC9VhSq+VXrs-M0ezGGW66d=-w8rjqCggpnS=ORiRZwMRPdmw@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] ns: allocate the namespace id before the
 namespace_init hook
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, netdev@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 12:41=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
>
> Currently the namespace id is allocated only after __ns_common_init()
> has called the namespace_init LSM hook. Most namespace types allocate it
> in ns_tree_add() right before the namespace is added to the namespace
> trees. So the namespace_init hook always sees an id of zero.
>
> The namespace id is the only identifier of a namespace that is never
> recycled. A bpf LSM wants to use it to track a namespace from
> namespace_init until namespace_free, e.g., by using it as the key into a
> map that associates data with the namespace. The inode number doesn't
> work for that as it is quickly recycled.
>
> So allocate the id in __ns_common_init() before calling the
> namespace_init hook. Every namespace then has its id by the time it is
> added to the namespace trees. The initial namespaces still get their
> fixed ids, either statically from NS_COMMON_INIT() or for init_net from
> ns_common_init(). So ns_tree_add() doesn't need to allocate an id
> anymore. Ids are still handed out in creation order so mnt_ns_loop()
> keeps working. Mount and ipc namespaces already allocated their id right
> after ns_common_init() anyway.
>
> If creating the namespace fails after the id has been allocated the id
> is simply never used.
>
> Landlock logs the namespace id when it denies the use of a namespace.
> For a denied namespace creation that used to be zero. Now it's the id
> that was allocated for the new namespace. That namespace never becomes
> visible to userspace but it's the same id that other LSMs see in
> namespace_init. Update the Landlock documentation and selftests
> accordingly. The selftests can't know the id of a namespace whose
> creation was denied so they only check that it isn't zero.
>
> While at it, drop ns_tree_gen_id() as it has no users left.
>
> Reproducer, 100 user and uts namespaces:
>
>   bpftrace -e 'fentry:bpf_lsm_namespace_init {
>       @[args.ns->ns_id ? "set" : "zero"] =3D count(); }' &
>   for i in $(seq 100); do unshare -Uu true; done
>
>   before: @[zero]: 200
>   after:  @[set]: 200
>
> Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> Cc: <stable@kernel.org> # mainline only
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  Documentation/admin-guide/LSM/landlock.rst |  5 +++--
>  Documentation/trace/events-landlock.rst    |  5 +++--
>  fs/namespace.c                             |  2 --
>  include/linux/ns_common.h                  | 16 +++++++++-------
>  include/linux/nstree.h                     | 18 +++---------------
>  include/trace/events/landlock.h            |  3 ++-
>  ipc/namespace.c                            |  1 -
>  kernel/nscommon.c                          |  7 +++++--
>  net/core/net_namespace.c                   |  2 +-
>  security/landlock/ns.c                     |  3 ++-
>  tools/testing/selftests/landlock/ns_test.c |  7 +++++--
>  11 files changed, 33 insertions(+), 36 deletions(-)

See my comment in patch 6/7 as it impacts this patch.

Reviewed-by: Paul Moore <paul@paul-moore.com>


--
paul-moore.com
