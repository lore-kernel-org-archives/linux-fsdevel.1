Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2A33B7B98
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 15:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077809; cv=pass; b=cLUWhlB0+sY8YAuuaIkRoPZMUVCT7r11XRR4lCAtiaGAzC/Mam/711AiMuwpL+3JS+4DZlK4BiCxflz3lgzk4AN6LAF0IEGJKANVLOTxcanGF/3duQ3sBHhNhf53gjKDaz5dJ4H8z3p2N1gRpILmThnhU/aJFb6O0JtGLnijNxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077809; c=relaxed/simple;
	bh=2EOHoPv3BQDykUH33A3omRl0PnRrEhVuncaHNdWKUGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D0+Owwu1eiguxieRlGIiL9iCxvhkY+JkphM9pzbADm5b2GiF7xa9TXBAwF3immjCLUXGhzrCl5WJepcAePPMvyZ9IeXvD7MjND8aAM+fI0fE0kU6D04OnEEZG5VjFN39GP9PhCPMGwjrDBZoRtw8u1J8YKklmHHKDZU8oh/rqRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJvOiHM9; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJvOiHM9"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-679aeeddc6bso275166d50.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 08:23:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792077799; cv=none;
        d=google.com; s=arc-20260327;
        b=pHNr61JPQoY1XwvZlEGMwRdHlZlyCguVyXufcTlU80HD52CD3Klg1SIPBdXzkHhbwO
         1IwKY7xgy7BeVPOmlcfg3Z4hl4IYY+I92STHNv4gTmHucssmg/TnXMSOymubFuulczpF
         cT0p6MsxbrHYZdBOuQsiYLOjNDRQYnnsqnu7/CxKkub8PX45pmDvutYq+ehoZhXYMztB
         PnFArI4t6ybd2Bl5GOfFAxMob89LustJL0Xh33jZ7pgtArE3CppTLojSDRPrFA1qBH+T
         8QK1GJi6OHGyEe9SIbH57HuPFqa9+oGXJKPdrpWhlZZEgHpIbnnMiNix8qHUUEz0GdYo
         +/Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2EOHoPv3BQDykUH33A3omRl0PnRrEhVuncaHNdWKUGE=;
        fh=jhE83w9ir/0XeGy1nG9pa7emAGxvmgTDsE5L4tRg4c0=;
        b=UgB1s9t9RS7iQfmHk1obsaQstkgX45PjFsSMNtTsN9kqRpW2ymhysQFz5cGfkysIMa
         2Ui8uXCu+0h208/ivDVRALi0ezPvei1SIntxMEVQ198YaBEjO6nKIelQgSPq5Aeynn5R
         Ck7Ds8wEiG5fGHecVUZ28v9GKzZwRKjhZlWuBl1UQ0O0If8iDaLETghSAJH9naFuwH2O
         sWv4q87piwM1y6s0yXnKVG9mFoIoh/drtf99HKdP0NAc93G6hbizTNqDvPJF9fZRUG9Z
         kbn3sxRxJCsJOHn8514NkQ0TrF1Z/8WNJkVlm9ueVpBOJSDUgCeMPMBPva9c9IO0DcyZ
         9ZcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792077799; x=1792682599; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2EOHoPv3BQDykUH33A3omRl0PnRrEhVuncaHNdWKUGE=;
        b=kJvOiHM9M0WnN33nHmHK3r+01pGpxKYp5aY/UMKhQFhOLUSVrDioLgyfEQddwhvQ38
         PSxocSnNo4gQUdIbe4ErVPJiV96p+kqbiIxQcBbi7vbgtMDwRxN5BGIrrEmVjrvwbGhi
         0YCuafuazhtWQFzgBrSCDze23oQAIfATfnChfJJA42QV55tZXBH4DSzlHC4euw7F+JYX
         ieWEFUQcCTMYDeBtXjSe9qtkAAJtz4+p2iCkdX7bjFDQxaCuc8msRNw56cgXEz9EFzHv
         UEuv6DmGT5a0nd7IP8MfwnoWyF+3btMgkyS9YVwMoxdO2oDWtDnoZXek8Em3C42YaF85
         mLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792077799; x=1792682599;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2EOHoPv3BQDykUH33A3omRl0PnRrEhVuncaHNdWKUGE=;
        b=hqOR+GkQc3227UoN5n0+yq7rQ5IouAf+Pvp5vMM3N3xZhKnq+pn+n5azLJ7+PgpSW1
         PvsnzV3HnqqajCQlFajnWhkc3h4FXdUODcR8d9LkqbMW+Z0ydw7bqE7sIjcdT6nm8O3T
         VmFPQA/DzkixITwrJa3n/66h1lzvROSD5Tw2tSA8HOg60EwmKta9YUaZ52g8fWkENXn3
         RCgnEpCV+NBEHSgs+eUsVF1VrfK5kvFSYspY5zm3RNPhRgSB8eEW9+SQnxkYm2S4K2zw
         yyoc6lc9UNUlG7Rw23x6EhqHSRfGrTPGzL4GST36W7QJMVZrcTmLgWhyc6YpktX/auLR
         +WVA==
X-Forwarded-Encrypted: i=1; AKwUvBzjHGZwL3MrtKZHW31Ky2dxMVxQk4qUcstgDTuVo4caVnBYheGsUeM+sjDOTsSDd8MmBjQdH7fxwZFR54oh@vger.kernel.org
X-Gm-Message-State: AFq9FYLJGrK3mrAwIWXhN1MEj95i01FKeawcecRuwnpZ8kRCSTYC59pB
	z1PnrtnzjTWBBjvVNVH2u0WeDCRlZXuuOuQ+NwRKCzoEn3DIOh67FIkQ7SOtlor0EyP+oVAQm45
	gADEdd6HFQWRFU2CYBg34gVBi06fqDiQ=
X-Gm-Gg: AYBFou08Ew9unHMXtpeEMB2P5JRLQj2FkoS0O0T8RTzg9VC1JRTO6B+aCYEk13vanMJ
	nktVp56q+/Ar2FBTzjWGNevDJuLeF+d/y4YXSOT8UxT5OHmLgHyCaQB8ZBlX3jXia6lbi8Ml2F+
	fejWJLLG7Jrz+TbXvukOKBGYBaC55/SQx5Hp0P8lEMOcIFsArpQPxd+h/7ekYAjo9D6t/YvEkSC
	mbXgcr1gzji7PebWFoeQ1MfxLIn2giQjMoMsAxXhvZ2oOrRpLu4oVHcirAjWWsOm9R3jBBZrD+b
	6dteoIY7/q9C3h9wZ16fETPaPzKtIYP8+EqM6mW2uqxJPvIU/Sso6hU=
X-Received: by 2002:a05:690e:1286:b0:66f:94c4:51ea with SMTP id
 956f58d0204a3-6793603db52mr5927090d50.47.1792077799474; Thu, 15 Oct 2026
 08:23:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015093854.2082600-1-huangsj@hygon.cn> <20261015093854.2082600-2-huangsj@hygon.cn>
In-Reply-To: <20261015093854.2082600-2-huangsj@hygon.cn>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 15 Oct 2026 11:23:07 -0400
X-Gm-Features: AclHuK8xZfXzISQM_5AP4aKpkZUrwKcxhhqslcqF8aMXobo6HxWE2h1pVZC0fso
Message-ID: <CAEjxPJ7xgpYOQVRSoBMK-_w4kmrPu_v37iS+q3Oj5TvtKUvJqA@mail.gmail.com>
Subject: Re: [PATCH 1/3] vfs: add inode iteration method super_iter_inodes
To: Huang Shijie <huangsj@hygon.cn>
Cc: axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	zhongyuan@hygon.cn, fangbaoshun@hygon.cn, yingzhiwei@hygon.cn, jack@suse.cz, 
	agruenba@redhat.com, mic@digikod.net, gnoack@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, aleksa@amutable.com, legion@kernel.org, 
	david@kernel.org, sandeen@redhat.com, ebiggers@kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-security-module@vger.kernel.org, sunjunchao@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 5:44=E2=80=AFAM Huang Shijie <huangsj@hygon.cn> wro=
te:
>
> This will be used to replace the explicit sb->s_inodes iteration,
> with the caller supplying a callback function and a private data
> pointer that is passed to the callback along with each inode that is
> iterated.
>
> A single iteration function, super_iter_inodes(), is provided, with
> the iteration mode selected by the INO_ITER_F_UNSAFE flag. The
> INO_ITER_F_REFERENCED flag can additionally restrict the iteration to
> inodes that still have a reference.
>
> Without INO_ITER_F_UNSAFE, the callback is called with a valid,
> unlocked and referenced inode, so any inode operation, including
> blocking operations, is allowed. The iterator is responsible for
> inode lifecycle management, so the callback only needs to implement
> the operation it wants to perform on all inodes.
>
> With INO_ITER_F_UNSAFE set, the inodes are iterated without taking a
> reference and the callback is run in an atomic context that must not
> block. This mode is for internal VFS use only and runs under a RCU
> read lock so that the VFS inode is not freed from under the callback.
> It is needed for operations that require tight control over the state
> of the inodes they operate on.
>
> This mechanism allows the existing sb->s_inodes iteration models to
> be maintained, providing a generic implementation for iterating all
> cached inodes on the superblock.
>
> Signed-off-by: Huang Shijie <huangsj@hygon.cn>

Perhaps SELinux could also use this to replace its own inode walking
logic at the tail of security/selinux/hooks.c:sb_finish_set_opts()?
