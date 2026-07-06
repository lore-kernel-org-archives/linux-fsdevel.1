Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1193D349A
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 16:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783355578; cv=pass; b=XYATEq6hHWhjTNWawZt6XooKwAQYMAknRmphAF5r0Rl73yl35UQLwwJ/YhqgLYw8DQjJHD/GybTaq7vB/3oOdlxPFkYqQ3FE5nluko1MzblKCOYT4a/Hz8sDOM84nodvVO+OQjP0oNyQ4VFcu39Lc2rdc9/apzmKl0FYt06MW80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783355578; c=relaxed/simple;
	bh=t4c/prX2kM47f73KS173peuhIQJkJQX0xyrhbtLBLqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gnoI9rMhn60xoBW9LSYIX/a4fbT74tDjmELkJo+D/s001kLGcfUObb3QZebnaN7546STmvBrGjC5iwEx/qhaiJ2zW/07A/0na/SBs26oIiejvblKFBOVv1s7KK+TVTZFZYzJmWh1OeFWZDwHSS31/fh+cr1BSzjbw5ECg6AGwsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EmYQtEHC; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EmYQtEHC"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-69a19eb2e6dso666a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2026 09:32:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783355575; cv=none;
        d=google.com; s=arc-20260327;
        b=fWuD/3/BE02nDzVtu/k2zSAGH480x0rMTNREfRIQ9xNse6b/Km4hbJ7mAbnbzUyoFe
         nSUk6QDDUDyhBOI+JGA640RXPdNB69pQ096iF+jU9tx9mcMs80oz7tN0auEFUSYDxm0X
         rRirbgimrhAimwCnA5IxASdDUyBfYODt/wEgdxAggSHOBKjeXFvNoM/hK4qxM6LMbV5Z
         yHMlzOrIXjoE8ma+Gb1s9ckcxnf1GgifLbolLOlLiGPmvK5m2Pe6HmxPndMNL1V9F9tU
         27CFLB67sy3zX1+fbJf6cF8fXrmsxaJbUai4PcrIjqpMrQ1mVcqB5dec9iiCrTLwzrED
         /MUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2UNDUGiqVvt711IXtO4cz//8EytDsjGbLNuNJRhGABA=;
        fh=4RHQBlVJ657zec9hg8s/+8L9JJeo36Hvz4UpW0k00yM=;
        b=dRSIKeuQP6m8UvrIUmJAPx1vhFgZQRvMFABHG9HOJeSDmD3WFeZljcfj751pu2ICtp
         TKEdKz2CN3yyrAm3u6+6u5zTXShyx1mrOgvevU0uV8A67CZmUxyHlqGoq/r8wyO7OxT0
         q5C6BMqQYrd6F+CXlsseP0760oq50tltkhJeBuqrwixCjYn9hSeuFlPshsW3rwVLTtgY
         iGNt3nbPuvDyk1t0FCQJ8gvwdVXZkUs2wmfXTV8w+v4KeTZ+2gF8PFpOintDnDa+CLez
         5ogxqmN5+RzrUGf5yB/V11r8W32h0DB5ZW58+1skOHc/IjGViN1Cx+ekue59GWs3tkXM
         zS2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783355575; x=1783960375; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2UNDUGiqVvt711IXtO4cz//8EytDsjGbLNuNJRhGABA=;
        b=EmYQtEHC3rJK9HuS6kuhKNlf3FDP85kdds1TVxEbvBE2CqtRgDgemp5I9xUh9tnBu2
         Pmm0OgtS3uY0N6QsXw910miH8lxqm0bfHjPUhL4Ek4JBY/zoqbl9BkzdUqaA0+5tD5RY
         rNO7Q//VJ149kJcW/XbNYcj9t9FzcZOHRhA7SmFrY/sKor2xHrbqUgtQtSVmh2TSjyBg
         JwYG6Qc5DXlYY+dByxKM3AGG8A8irZgfL7etu+XqHtZtwqifu/muoHjp628twd5cB6Mj
         kWqdZlIk4igcZMHlTl22SlmXY0Niy5uHDkuTGPbHsXrpYvXzGyUDAI0JWBvdEefs12KE
         tSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783355575; x=1783960375;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2UNDUGiqVvt711IXtO4cz//8EytDsjGbLNuNJRhGABA=;
        b=OmGA/SBhsDDZFFSUqAu7sacQ6c2ZqjuFZBPxkTumpY4pJP5O0xKD3wNJIebKUmQ/Pz
         2pDd7mjvaytBnN2+y+dVqHjhhW3JjWgwCChJJO62TKCTtmvUD5aB4fQjt5/k8LV5juCK
         cCEiggiI1dCjkrDpqXmtNAgZAoJKmM3XRUuO6jDNKY4oAjIDvYBPFb7Fb49t2o4OZJsT
         V5ea42u//gQn4w+eNgF3gKQpR5cwmg6Epybl1Odwq82/6ZW/L0UkAP4WOcetxt7Q8CGP
         FiLKq1bIt41/oOzsFn3ag4y+P5+u2WHANUpsWgGvtdxbDtQyu2EomH8gDAQhyWEf3vDk
         pqvQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp1v36EQNYFR0ZRAUKJz9Gwz2KsQQpx/SBiDlbaBFNxgjs2D4KBRla3XbLfSMRT2OFzXecFKldJUfTpChh5@vger.kernel.org
X-Gm-Message-State: AOJu0YzJgesPkBac9GnwS026GIaZ9BSFS5WHKh9rov/GCIX0p16qd0gl
	Y268PD3Ug5D2FkdO6xrnDYDFw+KyKQ0UHdmtFjRQOylyQ+6c5YL54NjbLm5Up0LrFdrlwmhtHMh
	Dxa5dhA5A8D7AvXo7aI9H8LYpESErjQQt75aOsQjV
X-Gm-Gg: AfdE7cl7fv73cP1V6cuQjVm5gUU0nsninu8/P8dezBrywBiJQTHDrbD6IqzYDm7U8se
	faACzw/3bcxR3Y1v/HmaQCTgJCI2ERcrmi/FqrH58F7ZduN5uyLj8+c5atIB9H2KBqIMudfa0m8
	xn3a5skYHdQqNhRGj+rIeReKh0AkNLqrNvBGUX+hISrQ/Qe/mPy7w4RM5S21+emT3WStodF/Pah
	DtbwkcLM0jFUjRJDjGDovO4UjzgtCbZL2X+bbl9JaB0M1GuxGmzB5gea23XVwxnpz3kOdtyeSzI
	TazuE+26Vs8Lg3JambriNbwzPZtK2K+D65cRu+vrD+f+pxCXr9eTOWIQOg==
X-Received: by 2002:a05:6402:a2c6:20b0:698:aaf6:88ed with SMTP id
 4fb4d7f45d1cf-69a8d5ed3bfmr4552a12.3.1783355574513; Mon, 06 Jul 2026 09:32:54
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a49ce818-f38d-41b0-bbf7-80b8aad998b1@app.fastmail.com>
 <20260629-hauer-erhitzen-sobald-96d3dff68707@brauner> <CALCETrVuh0-biOw=TgYN9ERTFAoiki57XeZ3S2T3dO2+hL54gA@mail.gmail.com>
 <20260702-entladen-farbkombinationen-klarheit-fe24cb608f23@brauner> <20260706-dabei-radeln-glitzer-71ecb835029c@brauner>
In-Reply-To: <20260706-dabei-radeln-glitzer-71ecb835029c@brauner>
From: Jann Horn <jannh@google.com>
Date: Mon, 6 Jul 2026 18:32:18 +0200
X-Gm-Features: AVVi8CeD6mwq1gcY0rcYzICnjlSpXjKTO3gnqdNJY9gW__HUf8Q1MpIvTqehCOI
Message-ID: <CAG48ez0sh7vEzBxtaG1HCJ0bmUMmhF_JR3=xXcc4+vpfB6LUOQ@mail.gmail.com>
Subject: Re: [RFC] Null Namespaces
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>, John Ericson <mail@johnericson.me>, Li Chen <me@linux.beauty>, 
	Cong Wang <cwang@multikernel.io>, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Kees Cook <kees@kernel.org>, 
	Sergei Zimmerman <sergei@zimmerman.foo>, Farid Zakaria <farid.m.zakaria@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 4:52=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
> I think the straightforward solution to FD_NULLFS_ROOT would be to just:
>
> - make it always available
> - refer to the caller's mount namespace nullfs
> - work with fchroot()/fchdir()
>
> So I considered two chroot() use-cases for the sake of simplicity:
>
> (1) You want to isolate yourself for the sake of lookup
>
> (2) You want to isolate yourself to assemble a "private mount tree" but
>     not really be in a separate namespace (very odd use-case... but it
>     helps to make a point).
>
> The problem with this approach is that everyone who chroots into the
> nullfs root would suffer from the problem that any mount on top of it is
> still visible. So that kinda makes it pointless for both (1) and (2).
>
> Also all mounts that someone else would do would also be visible
> allowing multiple chroot()ers to affect each others state. That also
> would somewhat defeat the purpose of the chroot(). So I'm not convinced
> this is what we should do.
>
> IOW, I think FD_NULLFS_ROOT to chroot to the nullfs of your mount
> namespace is mostly useless and just not workable for unprivileged
> fchroot().
>
> Instead, this made me consider whether it wouldn't make more sense to
> allow unprivileged mount namespace unsharing for both CLONE_EMPTY_MNTNS
> and UNSHARE_EMPTY_MNTNS. Look, there's no real risk at all. It is
> literally just placing the caller into a new mount namespace with only
> nullfs in there. I fail to see any attack vector here. It's literally
> self-sandboxing and you give up access to anything that you didn't have
> a file descriptor open for. It's actually a bonus, because you don't
> need to use userns for this. You just throw away your filesystem state.

I mostly agree, though we might want to gate this on no_new_privs just
to be sure - you could theoretically have a setuid root program that
gives the caller more privileges if it can't find its config file.
That's kind of a far-fetched scenario, and in reality it would
probably fail because the dynamic linker can't be found, but there is
precedent for other sandboxing stuff also requiring no_new_privs, so
we might as well require that here, too...

(I think it actually might be fine to just make chroot entirely
unprivileged as long as no_new_privs is set, but I don't think we
should actually do that, that would just be unnecessarily playing with
fire and would probably confuse some security monitoring tools or
such.)

We should probably also reject if current_chrooted() is true, for the
same reason we reject userns creation when that's true.
