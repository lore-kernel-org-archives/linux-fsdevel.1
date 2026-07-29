Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B63D496906
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 13:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785332756; cv=pass; b=HDW3yebQQhhPKPhV+RPXnEQh+4xdN3WKVeElyidD+WzJUWV23349LIBqRGiYPgXzwvS7LYy5IEfMhYxVPhUv1lqexF+WTVVGhUU9af55lhzL6URqCkvDuZs/wxLWl0K2tYlm3ctx0QDBvJzGNiROgmp6l6flw2D4EmsS6un3MwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785332756; c=relaxed/simple;
	bh=mGh7aPjSndBqYRyw5BEhShjb7bEIv1j0KN/b7zULSLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rYnzojvNtUvSp/RM6z3LX/p4I7Q3fh9fDmMOiYz5yrMIl08DTnDEUjk+tlj0RzvvM9LPV/0oBjpPFK8QNpyUsCEr3RzmJXSryn5RGlQulotxXHOitZ43hTiHbmwDNun3VHnAC2Lf+VdFdClrM+eQK7jvozAhJKpwZrgF3mTXz5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T1oEdTOS; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T1oEdTOS"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cede6375caso106665ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 06:45:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785332753; cv=none;
        d=google.com; s=arc-20260327;
        b=oLC/H+roOzQsR+IdzMqjIndL6FIi6mQWbgMQTTI5E67UrHl4NV90z4DOr4zM/8vGGZ
         MU4jYANr3SsqzmMYz5q5Du54dQMDTawneF7a8G7VY7O7iWV2tYdDxd3hqzYrdGUhhMpO
         xsuRvDpmfa3x0F6YZiK2TB0l2KHPtDuaBl9WcqH1lpNf24Vnger5ZkaG6BInUSyCNebm
         pAS2OoEYcUWlrfAb6S+Q9cyodWuXiumjlSd3Niokm/SgDCkwi8b7nNQ5JSqUaOokFWwF
         zD6qYJphcFwGaGIKGlGYDYaVG9aJqwDlBSscBaB0GfhLRtf+aNHZMJ9w7rwADv0+PtJg
         hOsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ks5TFAOq/gdfF/gi/pS9Qk0bZtw7kJzlANbbfAI7J1A=;
        fh=sFeCCnPPz8mTIfQ8aGo7qW7wwPXxaEBUpSrH/bye5EU=;
        b=TaZ1XyH5VlXZGctqQop1nskksmJO1MHOAuD5Puftf16ArE/kT3NfHHjwX4RrvKjvfn
         NVqo2VxTfMx4F2qnkR6Q6g2yIpM6Gk1jabtd61ADh1314xUPu7d4seA3U7KMbbTdt0h8
         wHke3s8Qlzizj45tuffTqdD1AqNomLEdexn4wIzGm2VlLvnKW5s0WVwhNhiBo3T+/OWi
         lRni561Wo+x+CK3GZ2MFxDLA38oByZEQTpkqXPMTJCQKuGVb033PTwz1OYBNmpGpDjTr
         fRlqYQAiRMIwrHzuQrvh4wUOTEKNuaBxsjCvpwI4F0Qtfe8gWygZtquHCG5L7pLBFib0
         pGHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785332753; x=1785937553; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ks5TFAOq/gdfF/gi/pS9Qk0bZtw7kJzlANbbfAI7J1A=;
        b=T1oEdTOS49cer5gnPZKX6R/7j5wjqVpooIKnFof2mjStctmyBGEZobn4DG0VU+Ou2A
         evvDx6eE1KNP1ZSSCXQBNLXNbBnycHMv5nIB9KYdSdGoGyQKE1QZaaLyFXXMma9BMwNr
         eOXvgezl8+ZXQg3kjkOjILiqRuKBYqpTMSwbjoWcXvSR1yS22GG89HHYC72MJDl2Ntj/
         INmJ0FYOvaB7F1vQfI6MyCiqQMnr0tKb2RAWCVbRwUUJOkZuMkV3tKieYvKJRYB1XqXa
         Tm7q+ba7z6845RqWYpagX1Q4yqfWYpZR9tO5ddSG0dPcF6B3GoE08oRbqUl0L/YkpxtB
         t8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785332753; x=1785937553;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ks5TFAOq/gdfF/gi/pS9Qk0bZtw7kJzlANbbfAI7J1A=;
        b=drdFzO3F/DngBRiQij2H1CPUxkddGATBJx0Jqb6o+zXLgHmVTRk0YLj/rjqNPIj2iz
         9EYo9l9YbNJWaPmqe3Nr5iGzTiH2/bitLv8AB8Yl0fw1sQHmsXEel/HkpaEdf6oZxiOl
         bLmEvoJ2LnoGXxr7RAnASJoZ+Z7YIro1UXjMHLUxg1jNqUvYKi0JHr2Gjww4ea3Spcry
         G0yyNhvDoi005CpMKBdkITId9LFX1e10ghLcafEmpqf9KcaSsENGSECuzpsmLTWw5ofw
         U2TYTKe7N7fPyJ1wtOQUXR+iGJ1tiJQy1eEn6JY3Hp0i6+yJFbPJ1Hsz+PMzIQhNCvtH
         qyDQ==
X-Forwarded-Encrypted: i=1; AHgh+RruYev+Pbb1tot8q+UbQ/8eAynQFkBMOOlDuGSNzHPzOkrKsErafzuWh97qb6TmsfDVS7NEoB4Wvpu7/iqf@vger.kernel.org
X-Gm-Message-State: AOJu0YyNcnCKi+re05qmJEaLfKOdheNELFmWEt/d/q5wzUOmAtQjUEN1
	MkbKQh/Jxrve0JVjnKQ9ow9ObObfFbOr6YSwoikzecdzbQtveTXz4bMvec2sVvxfZpmzj/ShKpW
	0Y7hYC5sAUpUb7dTdVMgCt+jWoC6w6Ba0cqGCe0HQRTrvHKC8UJ4sVQ==
X-Gm-Gg: AR+sD10T2Ma5LP3/GCPQaqWVjI7Moz+JaD5KOflN6ssgaNMnx5w8SF4hM0GASclZqmV
	V8HYXhzBQJMgD/mUHo0lOZaS4CH2tqG5ac/leWTe6Q1Zy+kdXcOWMV/90W7MMInMZUyJQ1w7T/J
	W+3hM784kZbqqUectHc3Pu4alVOf8yDClaTzVUjtF+UnZi3eSZq3qT0anj1n4aT/ISp4dp+xguf
	a9oTg7A4CBDr+56skhvXhJiHvaV7AxRHgkRgilzfpzo0zjBypFAzhpIpAcDPilxCNq6VNvcSaMs
	NmYsxig5Zk+5Qu0rTbru7ZeqSokZi+zcxMbnHlFQvcGqT71Vv/Nvex5s4BWk6+0eyMLXtvbckz5
	1WpgrwZUc6tR4xhOjfa0uOwYGJQQTj18=
X-Received: by 2002:a17:902:c952:b0:2c0:defb:557e with SMTP id
 d9443c01a7336-2d0285f20a9mr3388305ad.1.1785332752533; Wed, 29 Jul 2026
 06:45:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHmU7G=Dsf31mJ1VH4+Tp-McSvXCg=GcO-eC+O52-_t5gc7Pyw@mail.gmail.com>
In-Reply-To: <CAHmU7G=Dsf31mJ1VH4+Tp-McSvXCg=GcO-eC+O52-_t5gc7Pyw@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 29 Jul 2026 15:45:15 +0200
X-Gm-Features: AUfX_mw1H1BJk8-06Poeq5ugv4lVmHOUqQIoBJgTQ65YT8V8bf_xn_rABd3RXqE
Message-ID: <CAG48ez1UqV8E8nHGq50orS+3oqXbP80R6g7kVa3Hq-domHCSsQ@mail.gmail.com>
Subject: Re: regress caused by upstream commit 6650527444dadc63d84aa939d14ecba4fadb2f69
To: Pasha Boroffski <hex.dec.bin.oct@gmail.com>
Cc: regressions@lists.linux.dev, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 11:08=E2=80=AFAM Pasha Boroffski
<hex.dec.bin.oct@gmail.com> wrote:
> Hello.
> I believe 6650527444dadc63d84aa939d14ecba4fadb2f69 has a bug in it as it =
causes "kernel bug" with PREEMPT_RT enabled.
> How to reproduce the bug:
> i used 'find /proc/ | grep 123'. When scanning, the kernel triggers an "O=
ops".
>
>
> [  344.465851][ T3715] BUG: kernel NULL pointer dereference, address: 000=
00000000000f8
[...]
[  344.465888][ T3715] CPU: 0 UID: 0 PID: 3715 Comm: find Tainted: G
   D    O       6.12.98 #9
[...]
> [  344.465905][ T3715] RIP: 0010:down_read_killable+0x9/0x40
[...]
> [  344.465974][ T3715]  proc_map_files_readdir+0xc7/0x500
[...]
> I think calls
> mm =3D mm_access(task, PTRACE_MODE_READ_FSCREDS);
> if (IS_ERR(mm)) {
>   result =3D ERR_CAST(mm);
>   goto out_put_task;
> }
>
> should be fixed like
> mm =3D mm_access(task, PTRACE_MODE_READ_FSCREDS);
> if (IS_ERR_OR_NULL(mm)) {
>   result =3D ERR_CAST(mm);
>   goto out_put_task;
> }

Ugh, yes. This is not an issue on mainline, but the API contract of
mm_access() changed in commit cd3f8467afd4 ("mm: refactor mm_access()
to not return NULL"), which landed in 6.13. So we'll need a
stable-specific fixup for 6.12 and lower.

I'll try to come up with a patch for stable later today.
