Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229F0405C51
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 18:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779820299; cv=pass; b=VDknOmuxfMgdth9NPfWD6hoXylZFJgKeC9BAo9rWrJpn/KbgYCzGlJUIdJ8unKNdKOwpY/nUpkRLVeJIPw7nHWTUkaZFibCl2e8EI+iw5Lw7FugiVw9DLd92BnuWbw8FzbSv2MEv0yzaH1i1S1xGUvp7rfBkrxudSR2xTJ6R2Hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779820299; c=relaxed/simple;
	bh=/5+vAEgH6rFZ7VGwpIrcSyHpEzUK+m8zCzYVaRaOEcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R37CRNB1BwastFPlbriaMDrDi0MODmWbxY9THKEhxQWp6ZIYaTmrB5NDa5lftMjsoMJuEbuwCZKQOAA2aVXlSPt7QCLODpEVm2i4ju1QQr+Lyjj2gcdOdWMbWqjXIjjVlwvQOLkJIpV5atI3gA7Rw7AyjiqbYwXFFCivmPWkAJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JYNa8eZl; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JYNa8eZl"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-67bf769704eso50a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 11:31:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779820296; cv=none;
        d=google.com; s=arc-20240605;
        b=R19T42vZxnLnSCNWKVE4jHv1nCsMIraa3iSFR6YVJSmaMSvvifbU3Tr2XU1eJvfhv0
         5aQojup7HSThykAqSfSrG++PUjeVKTMzPy/v1E573qrSLsDwvGfnrgDZilGGbAZyeYrj
         LBA17NP9SE91cHKRquk0h3vPs7raZrzH1X2O9Q7b0dg6Z83vjr3uv3kFuB//TmixTZmf
         xOW66wcIAXBLBds44M8ARfFqXaYQzCmFFWyVigm/2R3Ixw5V+KW2du58j2PmEXHmKxLl
         L2r914jeiu2UaqrLhEy8eyMb4N7tIiI8W8nQ3huYlArYTZGOOozGcT5ZuWTQks2M2OhA
         fRVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J7eX3Wy9gjbwHpl8XY5PP8KTjEFr0hiAHBwfibpJH30=;
        fh=FzTn+8i3gnZiFIrGdwsLON+fFp7/az6L/B8wjegcYfo=;
        b=ERIhuI+JtJqpSwdxH9FofhqR4DWrnGtQxp9mDYmodPY92oHgde40hDTb/eSzcjTnBl
         qJB+Ku90ccl25aQjibeOJfilycEAXGPJ6AkYvVTpAhr2oxOXt6O4O3iuG3ouacarkYPn
         m3QjVOEMQRFrW/QVKF/ynmWngFMEVgIVv92VESPgmvQwpP71g2FYTL2KcI40E27UUO+s
         XDnU3BUm7I26Oqh7+feh65eZu7G6mZVT+DDIihJ7iD0PkcI2jBDJW8+7n7NuMLtfmGiv
         rfBM11Rfua6JWy5SWcLCHb2DoFVZayunwBlnNj7jmrG81s1yBMBESh7RCRAXOzTq7y5i
         WZsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779820296; x=1780425096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7eX3Wy9gjbwHpl8XY5PP8KTjEFr0hiAHBwfibpJH30=;
        b=JYNa8eZlIsKgeuSgZSJNegqWUB0HqT+gWZlDYW7BVWX0LafSE+UGM3F5OBYR8hyg6I
         y2e2aIGuN8CNv+WqghM5LaOla73x8YRIwzGR1bU1659AKJP3OX3cHRA4BezeQcFRX5zJ
         hZSAP8sSKA1JPyENPqJDgZKYf8541GnZtZwBGwGPG1hP3AEmINADUKUOENMzX6YWkHMk
         Q6Gnt7Kq9ST9bHMOyll+KkCd1vWY/O11/bvi7/uO8ceNKx2RDyQiBRv8T99nCHRSKHQk
         eApdbKlOlw0+2Y0h4azzc4l6SgsprMcUgwEEHqly7MJy8yTqcSrX7xP/45AA2bOuplYm
         WlVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779820296; x=1780425096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J7eX3Wy9gjbwHpl8XY5PP8KTjEFr0hiAHBwfibpJH30=;
        b=IxDTID5Zb4odOM89C8jlRHnVK0pvPKN/SqtnvZDpjKwGff5kfTIPUb+Blua9V8hN6N
         7X3sN9/4ftVg7UFoAGY1sdLaCJiUlHhU331BXUTC0wgjxDcCcJB9luRUDwxzcXsX6/An
         /PiihJ0CJX43lwUC7389nyKW0w1/vmYcFZ4XNBD8T8Gz+tjXny8WbraW3f5Aqv2+73Sw
         UaPDlQZYb+3Aw4mmj/vzkX2WuD7NnDkNgKW3IM+adB0qlmFz8xkeVDD3oEz1OAlIT2qu
         xe/RxASUHtx4BSxS5e1Lm/kWlH4U466gWrW6FsqjoWtQ0/IrodhVDvHTiT8fcuF0Oaoi
         9bcw==
X-Forwarded-Encrypted: i=1; AFNElJ8KMPaMgEUJ/IrT55kRW/0geWXR17IIo1yYza8uZidyhvP5o+GbP7IAVzWG6hKd6Y4h4MWEc8OEPG7dyysR@vger.kernel.org
X-Gm-Message-State: AOJu0YwQRtiMxQiIM9VVKFdJmYIJzKUkx3n9QjWY3GR9y/C7Keh4WUee
	4BNkSRqffYXvKmxL4TBnj5xyf76z6OFL3IiuWQhLWGGOEMUuRzLHekbE1D/Nh11+8QIi92eMN5i
	Qskp9bZdpGnrStUOyflL6tFyyZtJSRBza7VIVCrB7
X-Gm-Gg: Acq92OG7of2sL/mGb7K2eufl5c/JBDTAseeCoDn1Zb6l+t1OFu7KjWNrrHyvF9n5YxE
	B6dz+2Pep1EHPeh3q8EJv1GDbdy2qOnmnOKqqpABT69NHM5ptrYVG80ImWhesC0dPdXmngducdZ
	/O0iI2FRWbctpYDRutcW0e1G2L54N4GER+LMUOG4Vt0INHYOSGwXZ2exaqWu7g6QQREr8g1GbKn
	1u2N6xcgnRPu1aTTvG+NXbeYOYh4g+SU6ZOQjecw1tN8Xjcc6NpdT/qSere9iaBnjt+7A5SIRmf
	cigATZAh+fmvw+M+ZyAvSZ5mZ6d+hUUDdJ6DDq+tCwBvbKM=
X-Received: by 2002:a05:6402:534b:20b0:672:117e:55d4 with SMTP id
 4fb4d7f45d1cf-688fd0681a6mr139240a12.0.1779820296179; Tue, 26 May 2026
 11:31:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518-procfs-lockfix-part1-v1-0-5c3d20e0ac33@google.com>
 <20260518-procfs-lockfix-part1-v1-1-5c3d20e0ac33@google.com>
 <ahVeT9TTxlJiW2Qu@redhat.com> <CAG48ez0RXFp6nFfOOz0MeQMPknnCPeBj9j1ndR6kL9oE=ZSc=A@mail.gmail.com>
 <ahXk0lBmeewqINHh@redhat.com>
In-Reply-To: <ahXk0lBmeewqINHh@redhat.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 26 May 2026 20:30:59 +0200
X-Gm-Features: AVHnY4LuoQlinjRspeV8e6aumcDxAU8ZpBjvLoLqcRI91yjMkt2lsu3If10i5cQ
Message-ID: <CAG48ez12wbXQsD4e8EYPS=jLQz3H3dDUn_unbLjvaMgkyQdX9w@mail.gmail.com>
Subject: Re: [PATCH 1/2] proc: protect ptrace_may_access() with
 exec_update_lock (part 1)
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Arjan van de Ven <arjan@linux.intel.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Jake Edge <jake@lwn.net>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 8:22=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wro=
te:
> On 05/26, Jann Horn wrote:
> >
> > On Tue, May 26, 2026 at 10:48=E2=80=AFAM Oleg Nesterov <oleg@redhat.com=
> wrote:
> > > On 05/18, Jann Horn wrote:
> > > >
> > > > Fix the easy cases where procfs currently calls ptrace_may_access()=
 without
> > > > exec_update_lock protection, where the fix is to simply add the ext=
ra lock
> > > > or use mm_access():
> > >
> > > I thought about this too, but I do not know if it is fine performance=
 wise...
> > >
> > > And what about proc_coredump_filter_write() which doesn't use ptrace_=
may_access() ?
> >
> > Yeah, this series doesn't fix everything,
>
> Aah... Of course, I understand. I wasn't clear. Sorry if it looked as
> "you missed proc_coredump_filter_write" from my side.
>
> What I actually tried to ask:
>
>         - Do you think it makes sense to fix proc_coredump_filter_write()
>           as well?

Yes. Another example I've seen that should probably also be fixed is
seq_show() in fs/proc/fd.c, the handler for /proc/$pid/fdinfo/$fd,
that also currently has zero checks at read() time.

>         - If yes. Do you think we should add another down_read(exec_updat=
e_lock) +
>           ptrace_may_access() into proc_coredump_filter_write() ? Or perh=
aps we
>           should discuss other approaches (exec_id/seqcount/etc) from the=
 very
>           beginning?

I had thought that this series would be the easy, uncontroversial
improvements, and that we could then think about the harder aspect
with read handlers afterwards. I guess I was wrong about this being
the uncontroversial part.
