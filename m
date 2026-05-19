Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018E740961F
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 16:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779208139; cv=pass; b=ONhF1kcN4C1XWk4CgCvaDjNzA78qUk7LS17wmWpUcwy6iU4x1c+dNAtADejoWd7wv/NOP5yDx7MEWiQMyfH9YdO+zvqVMV8gu1VNZus2Ge05zHsh6akTI5P2Jpp3gCm23fexomy83Q2/Upqb74VYEx3vYaBzXu/lkfZUpte4FyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779208139; c=relaxed/simple;
	bh=kgHIUZbE96lJi5/obMLvIptZs8Oy9Rc15UQ301wY7TU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k5UAoITihzWUv3wGJZKaXs0xBy1afNIDqWcCRX/9VKgY3nngX8JPpKXNoWX5hNKD+bUPfOyJMo7OViGh6P9sZlYpc6FQoE0ijLICbdUEfFhjNIk2BGnNHxmQXJoDE+I8DdZiUxLj52SIJZaN4++YkxTCjaGxrGjK3bvD55klbtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YJ6s1aDR; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YJ6s1aDR"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-67c1eea6b4dso480a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 09:28:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779208136; cv=none;
        d=google.com; s=arc-20240605;
        b=V+YCtaesid6eNtGqSJEblrhA3gFz8cLaIt3LouOF3hF4FWDrSUtDuoLqrpvSuMNyGI
         QL5I0NXDWxmZNiZq+PXfEXEvtWu2diyyrNcDWxIH5sPFrzL34FXIw48Vm2kcSzjux8Yu
         XWnUQc4ss4pZD5Z7zoLwQUkI867quYsXVljx5ILQWZGh/zH5rguFSeH5zXkkykjHA/sS
         mUSz1p17bGsDC7LxbFoK1ShpE1TuERj9kKHjNBrNR9NFlf2hgdAuLzlt47VKmBi5opnz
         sdMLQHJ9RUFm2zUh9iku66ipSJq/LYBetK7RSckSFRZL2lQXl2K0B2V3kyqE4fnkFqE/
         /bIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kgHIUZbE96lJi5/obMLvIptZs8Oy9Rc15UQ301wY7TU=;
        fh=M40f9wM/CXStGWoP0nOpHkdIUSSMXejr5pZu58rikfI=;
        b=VcM1RlZl0zuu3CH+BwaPM2tt+oWx6+FRnSThSELtAjlpFbLJKIYxhQqH6OEsZB02ND
         RAFnB9DKh8OcgYEuhoQtyob79wTGpqL6Prbf28sZT2ycl5pVuSNX81zx/IIYja2c9TU1
         EPdtX6XFVVYDIT0Po1/s2Ne1J2YQaQ/5fsW9PoJZK70x8S6ItRHU+sjOQ4b7run/Gvil
         t5TeTIYecHUBQKKqTRS76r3l9QXWZwXDucmkugvW4e0XLclR1q5HbkiO3nygL6sRCKid
         oru6OMmH7kvg3PWONzkyY+8nCXuqQPK6nr5rNujZncd+i0J6VLmSzul+UcWj0Ck/8m/4
         GrzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779208136; x=1779812936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kgHIUZbE96lJi5/obMLvIptZs8Oy9Rc15UQ301wY7TU=;
        b=YJ6s1aDRD6a0PChTjnEP5x/EkLSMoTLVNwujSt6rF2+ZhN9h6DRSRai+946Td+GI2G
         NkeTBhseY5Z9OaFZrgMk+WoaKD1a+t9IiB4vFUkoHaymTeBBA4aTaV39WAC+TWotvT5Y
         s2Z9ez87T3Q0SzRduyxnCL31WZLhXZprdvI6P/GePNgH8mZlJZKb9B5fkJsxymZkQdb9
         LOYhbn0WZ0YnUyl4iqE8sDAUP1KVCGNuNKvEQ17D93JL8R92V0AWP/YFF7TCWDcXGwQJ
         D0oTn71c9Tzh8qtsklcW40tG+qBE5pOPy950ESdz1ibiEQ0NtcZf3UzHCHwXuqbt87O2
         RUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779208136; x=1779812936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kgHIUZbE96lJi5/obMLvIptZs8Oy9Rc15UQ301wY7TU=;
        b=GWmNYfUFnitk1uGjyk8cwrwBQayad2rMIQUqAOYFPV4G50doAGfnx1FMr8BX9H9m5M
         ltw+5uvtKvPMCMYjLd0knIZ/ro8q7pfEcKIj2J+foCo8VYEZhUlicY20ZzdFnVfcQanZ
         jYQL/MZBcP2y9WfWoPwUmSZ8d3THqZpjkGd0A69ygUSmjYuq7BVBezAWqrev519wjbgi
         8ueDWvitN7YN6NoeLmdV6hWC4Yh2lqEbub/s8jIgFOZHuu1TcqWL6iHe30jog3rY+RQI
         nBsWe7GaGSRkSWiqeMbHcEzOJu7u3BEZ6lLEZl/vJZf1uNCuxeu5MkCxdFbZCx1rW4P0
         GDEQ==
X-Forwarded-Encrypted: i=1; AFNElJ9wXglSYAceiWXcRmqgmy8Tf8DN/QbxPbxrjKmb5tuGe0+YNywpieI0cd7xMEl8um4gpQFlJsx8PC9BnHyr@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm2icpr1DxjQH9E2ebBZLtY7Ew9M/DJjczI8dWT8FoAOKAUCTz
	wx2xZlU+cM42fZgoOCGNkNEWvOXtzfFYANBeIDhdgbAGws1zjYQxyG+zDi41VL8NvL9hJG9K7Q6
	FF33ArzUB0LQdz4cMuY+rk6YINXYwjrxW3hSG/ZTn
X-Gm-Gg: Acq92OEpnEyDeGl/anMO6QOhS6z2K/y7dYjOIAaYU2Ot3ArMwrF+ztJW7PAA7BJ2Xp3
	gpPQuoJxLfJHeNYtXCW9wSNx2rW65BM+zGhO2zblDQUIdWYDYbm0fPfq4GoK1T3r50YUn0QElcB
	HqBMiYtepVn/q8PVS9wMI6pV0T6EHLiw8/BsutULx34ifyqe4f4jnp4TzyYSHQZvS7URj4NmM4S
	ItXfNzoTpQliK3JNs+p9AOtUD39QLyluf1tajUXdIBLfffqw4v5DJmauqqr5oOwcaUTySs4T6Sn
	HXwQfmlX26ayM1O2+zjDB+qu3Rs0+tY2fy358ZYxzqFQUDTX
X-Received: by 2002:a05:6402:a143:b0:67b:8283:6240 with SMTP id
 4fb4d7f45d1cf-684986edae8mr162870a12.7.1779208135980; Tue, 19 May 2026
 09:28:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260516182126.530498-1-pfalcato@suse.de> <20260518-starten-messdaten-3b8aa670ec85@brauner>
 <CAG48ez0jbSUgT3ZxPKZP7Eu=K7ce2cX7k2NzHCHNMOxQjOGT9w@mail.gmail.com>
 <177918418452.771415.4371785688744608623.b4-reply@b4> <CAGudoHFtecdkcYpFrtM5RAAPSU11eL_ALPGp_jhtHW=WxyHE4Q@mail.gmail.com>
In-Reply-To: <CAGudoHFtecdkcYpFrtM5RAAPSU11eL_ALPGp_jhtHW=WxyHE4Q@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 19 May 2026 18:28:18 +0200
X-Gm-Features: AVHnY4KItrX90sdPIrOiWL_DdFaddul15rGgYiuLpLDe6wZbCoeUuSPEm4x5pzQ
Message-ID: <CAG48ez03iWJteZiUvRe6o6_O9N_G4BYwgBBvAXF2QOJvXkKELQ@mail.gmail.com>
Subject: Re: [RFC PATCH] fs/splice: allow for a way to block splice() with
 read-only files
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Pedro Falcato <pfalcato@suse.de>, Jens Axboe <axboe@kernel.dk>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 12:51=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> =
wrote:
> I can't stress enough that mucking around splice (even if worthwhile)
> is merely addressing the currently popular attack vector and not the
> general problem.
[...]
> The huge attack surface was always a problematic position to be in,
> but with the advent lf LLMs any unskilled person can drop a 0day and
> the position is straight up untenable. In the long run there is no way
> around blocking access to code by default, way beyond the current
> splice proposal.

Sure - but the path to that is putting restrictions on the
availability of individual kernel features, and this proposal is one
step toward that.

These splice/vmsplice functions have been part of security bugs in the
past, and have contributed to making other security bugs easier to
exploit too. I think it's a sufficiently big problem area to warrant a
disable toggle, especially since this is more or less just a
performance optimization that we should be able to nerf without
outright breaking anything.
