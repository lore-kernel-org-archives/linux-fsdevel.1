Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06404413247
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2026 15:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930970; cv=pass; b=AQDf8BNFUtdLFCVwZ52Y3Vb04R2Sv9V5QVYOXZDd3HCU5cZc/a3Ypff0F0XGWSajfuuQ2Csv01N9KpJAqM8nxS76EFAUR2Q0FSQD2m7SIiv3Qip6F6La3go1awyX5pTI+C8NXwJWLqLvs1Q1FvT3wOTOVI+eKxfjIvs4UOEeY+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930970; c=relaxed/simple;
	bh=g51x3Dke8m4hq5BD7mWP1JIENWwriEm4dzZwpkBeih4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U0h5qcVLIzt/ptGEmZuXX5dLVqtvju6tfpVHOQvQyeikCECm2F/VASsxaO0iKq4vJvOwO7+5+tXg24wdR9Jnce/VW4rq+yIl/URgPDQKQk8RAsyTQzSOBzp6VHCMDXaxLLj1AryoC1MycedVvhHLhx5K12OSw1Y/acFh3vPSxIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SN4g2w+7; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SN4g2w+7"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-68d22476e88so29123a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jun 2026 08:02:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780930963; cv=none;
        d=google.com; s=arc-20240605;
        b=Le22fdmP1qdFI/nT6X+idikbrCjruQNn+0EY/t8zwoJXXAVq/EiNNStYg08g3rYhHM
         QUwnwOObBmu+e71Z+gN9wUFf8gwX96NUmSDYTcwpj0cbt3belvnTarKUfmUNmbL1kXRz
         j2YSNSQmcrNGvyGlEDlDeGs6s6+AiOGPMJ/wzTKLkOUT0U8hFxsAxERpx0MVQU/QTdfA
         u7cvoLiVB3j2+ZO6Wjzz6klfsAE6r8tcQvk7sS2vRgKIkTUhZ6eKG0imXlA0S4UYhs6/
         FPMZgym/anRPoBzprG9MnRMuxg5a0Svm18xmLa/StlsE6emJnkFR7MpPbMic5bDX4ohk
         6raA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g51x3Dke8m4hq5BD7mWP1JIENWwriEm4dzZwpkBeih4=;
        fh=DwlqHzg9yyoe0LgyMfiFZttXnikBnN9QHFhJT3sQrCs=;
        b=aAV37GuygrwzfF3yFKEjQUtT41K0JZhFg90zknrX/gQbbDGek4Ypyo7jqSBew4vFU+
         mVAdxpXmWadh/NZsOlhiuVxC8hV60o3j9fNwxCbSeuZL+L8jaqJbjcEPCaCC5qKosZ32
         fXO8S994sAEJYyTIyHGGFKEorsEs7ZWsUzGBrTvJjfZQTK4VPobvQQyR75s9NrWjJX3T
         qZ89S5R0tbUc/QnjWtNIOl9Dj21MTd7AYI85+CL351FSR2L5NY9FzxvPlbK2681LpOcL
         0R7lePFg4iyZd+yaw9mtKPUWv0ZbBcK8YcmO3hlPQyjegGbxcFCKCgVMFz6FlfN5xDrB
         qFRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780930963; x=1781535763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g51x3Dke8m4hq5BD7mWP1JIENWwriEm4dzZwpkBeih4=;
        b=SN4g2w+7L37u55NOHnH62hsXGmHRkvICDQ97Qol/4mqxJN6kaeE8TAGexGnPVk+0Sj
         vOwhOYMqgm/ZclL9AVkos/+Rx8n4xUQp6WI17G0GvGaF7oUhQmM6qa4pgZfpehiTajlm
         1SDyEkqnzK56xnyHFwufRSwSX0EjLVEUE9paFJ3tapzaLxxpDd9MLsnbyCvYHXQ8eyRx
         jqeFQF/H5AIlNqAkFEFS+VpK/60tXK9rrfMmWz4xC7aWMinwx328dqWwShlEraX65KC1
         MjGPFslpEltXzdQ+rgN6o+Eovk1f5szk3IXtjEeBQEUbHxqXHqaAtVntDNampvk7JuT5
         Eqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780930963; x=1781535763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g51x3Dke8m4hq5BD7mWP1JIENWwriEm4dzZwpkBeih4=;
        b=jUZ2LP3GXdspr3AlKEohUfzdVzJlJG8Eey0vuyv/Kv8+0AFBajwgH1oCQ6AH1CffYQ
         gaaDfMFXmbwS/fh71CSP8+UDeSa2GKPc1/R3Sj8UHI3HAQUJO13JRY+/gViOrkxyd79E
         BUwi4ckfrEbkdAvtjcgtWK7JGHBCAbt1Vz1iIB/lzfi9K4YKvQYFaNwhk0+PtVH1gyIM
         Z+sDcwDqv6APWgcLEst/hwRwqjZrL51zX803/SeJIGBdJfSAESbhdmwI0ztEk2U0Zx+1
         /Pm4W8UjrJlGYRb1UgDmEtup4cby+btdQK7r6qDn5ISCmuwf+BI8kr+RrZCLT4Mb2rSM
         hIqg==
X-Forwarded-Encrypted: i=1; AFNElJ+83Tc0ZBopm+KB1ZW3CWJ4u/92w+5+RC6acjQ99ZBBUKaB2oyr/oWJlXO/cjUK5DBuBnSn/F1DLr4B19b/@vger.kernel.org
X-Gm-Message-State: AOJu0YxoiGUhrqre4lLI8KDXwItvdCmydOBz5uEnfZZ/jZx1ayhRXGVM
	Mx/FCEEjgXj/7PLfPtADNOWKiTds7DoyuKtun3rmBP8kfXiKn8swRZcKvIWu1c3kYcjK8xmo13i
	HNh3v0RlZK6phst2LTBjjIwS7ne46Du/jl5AYxxbs
X-Gm-Gg: Acq92OGIqwetkG8NO7/OkbOwW1ptqaztHao4dyrD2qGlQ0Cgsux5i1ErcYO7eh5G8+d
	VIBpzDJEWuBo8JAdQrevE3yEO4tko7bmm61z/P2TEbElRBQqMfTE4jFEx4kU2yJIEVYD23IksLP
	/vm231drVw2eVDpULs0/Y1ANlC/z80d5iLKE7vCf+MorItSy//rS6SH8WlJJvyD+DaN1XHwCd/C
	IwINOGdi2Qxvs5zp2s1ZE7MW9U5lG5lUpJcGGFLVFsP3H+Xc/YUzMq3/kpTpa4pmwzTcCkUtSAg
	/yP7qIKdahp2x0MlxYSQkzc12uZz8V005ielP3bn/ozK4Ycv
X-Received: by 2002:aa7:d848:0:b0:68f:d41d:ca5d with SMTP id
 4fb4d7f45d1cf-68fe907ab8amr167661a12.11.1780930962621; Mon, 08 Jun 2026
 08:02:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528095235.2491226-1-me@linux.beauty> <vealb52tv5suireenkke4lul2l3wbnaul2rp3ea545ly5wa5ty@yk3aksvp7skt>
In-Reply-To: <vealb52tv5suireenkke4lul2l3wbnaul2rp3ea545ly5wa5ty@yk3aksvp7skt>
From: Jann Horn <jannh@google.com>
Date: Mon, 8 Jun 2026 17:02:06 +0200
X-Gm-Features: AVVi8CcAEOXMmuMTSZ94akkMqWU1PSwZDT3Kns1-hWwyFL18yvP1h0y8fjumjnQ
Message-ID: <CAG48ez38OEE8ZPLyU6nr9=cYx-hMsdoh5WRrv-GMZGMDKyyOTA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 00/13] exec: add spawn templates for repeated
 executable startup
To: Mateusz Guzik <mjguzik@gmail.com>, Christian Brauner <brauner@kernel.org>
Cc: Li Chen <me@linux.beauty>, Kees Cook <kees@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, x86@kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 2:55=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
> This problem is dear to my heart and I have been pondering it on and off
> for some time now. The entire fork + exec idiom is terrible and needs to
> be retired.

It seems to me like vfork+exec is a decent UAPI building block, on
which you can build nice-looking userspace APIs, though I agree that
this is not an ideal direct interface for application code.

> Additionally there is a known problem where transiently copied file
> descriptors on fork + exec cause a headache in multithreaded programs
> doing something like this in parallel. I only did cursory reading, it
> seems your patchset keeps the same problem in place.

I think we almost have UAPI that would let you avoid this issue?
You can use clone() with CLONE_FILES, then unshare the FD table with
close_range(3, UINT_MAX, CLOSE_RANGE_UNSHARE). That is not currently
implemented to be atomic with stuff that happens on other threads, but
if we changed that, and it doesn't provide a good way to carry some
FDs across, but it feels to me like this could be fixed with a variant
of close_range() that removes O_CLOEXEC FDs except ones listed in an
array.

> There are numerous impactful ways to speed up execs both in terms of
> single-threaded cost and their multicore scalability, most of which
> would be immediately usable by all programs without an opt-in. imo these
> needs to be exhausted before something like a "template" can be
> considered.

(I think probably a large part of this would be stuff that happens in
userspace, like dynamic linking.)

> Per the above, the primary win would stem from *NOT* messing with mm.

As you write below, I think we have that with CLONE_MM? The C function
vfork() is kind of a terrible API because of its returns-twice
behavior, but I think if process cloning with CLONE_VM|CLONE_VFORK was
wrapped by libc in a way similar to clone() (with the child executing
a separate handler function), or if it was used in the implementation
of some higher-level process-spawning API, it would be a perfectly
fine API?

Or am I misunderstanding what you mean by "messing with mm"?

> As in, whatever the interface, it needs to create an "empty" target
> process (for lack of a better term).
>
> In terms of userspace-visible APIs, a clean solution escapes me.

I think we already have relatively good API for this - you can use
clone() to create something that initially shares almost all the state
that a thread would, and then incrementally unshare resources and go
through execve().
