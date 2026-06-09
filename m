Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBB43EB0EF
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2026 17:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781027650; cv=pass; b=ZX7zmJvk/kvkijMH7ZcmWkBr/7sodXmOIiLhDk+DhO9yslIt/kbgviLtI1kTRmhChEgWWcQ+oBx9MJ/hguwRZ6TwQAu7Kp9Sk9UmpgXWsLeDrgsimlhKiVWCqiv0CYSKzfQLT2VEI7hVSA6L0foUAJOk1zHcNByBbHBhD4ALkW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781027650; c=relaxed/simple;
	bh=Hq4A7JGxJMTkiPV3o4Xs1UnKUenCIEORnYI3PIpLLJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FYhP171aeWmv0Rpmq623EBBvKkWx2q3L9KAZYQJ98j8/Fx93vpGRosuZaUfO0niFKdA/wb40/jINu3dEBC4ZTsQ49VhYieigxam17gCNdbF+iPY5+rIpMwdKbpCbrz/2iutn7dMq5DyptzhQvUVOJrAjkKWjjTjhG5bERvZC0Kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iZfBKXHF; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iZfBKXHF"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-68cb445dd5cso44054a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jun 2026 10:54:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781027648; cv=none;
        d=google.com; s=arc-20240605;
        b=eecVtBY5dKZZoWmicQolm4Ea4eli9aWtVeC5hMV0fbyjQfWEz8ugohDJ33sy+KSXHY
         aTUmnNxrJp3CTtHVrXVk0NmdZP5mLh6dR1QpPP9FN0KG89qZi/rTy6N9mT1u2bpEbFh/
         8LoSewa3ITpZm7IW8qlIn9LCNkc1lrt6wOnA34kekk6ULdbWVjKGbzPZvGfcE6VMbISF
         xfefXIVfLypNGdOvEdGcG9FOvlcIhPp9ddnBg1FeIHRyUjDmgEjluwFZFqh22swGjFbg
         yiNxw5lFzjfNBIwpG9EET/2oMI8UKwgRrp9IqVQZrGQEhIY8Sebk165HxH0AjtpTzZBk
         o/EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iPo/rNEwfs0tGz+mQjgisI/ZCW4vs/mt/EjG+vliJIU=;
        fh=UrGL0qI6UQ0EcfEf4WqHJHD88R24sF07WDDfvtNom2I=;
        b=B/Ey7RgAkKr+1f4dWJRXkyp6Had0RBaTNJvCaGel+x5Iuhytu4WVU8mqOsXP+MR9Uf
         3hX/1cbcnkstEkJsig5+bUytNAIzWFa46mPcnZV2AU8wYjyuraztKaPrpRUWLYNAxSqQ
         wsNXS3n1Hn1PL5EBC88Fys4mxtJCSW6eD9CrJRc4Y4GXp5h4IvyuZBGcDFiQTwML4sO4
         kCSUSQ6ciEtSMN8oIuwQ42X7O0VBrfsn0OjbGWf7/HeZQMBabRfTBLZZ9fTlXrP3+ioI
         FV1HwL57WCTKV0e3Z6o8YVYAySe+db1suWAOLVgPrbWYA4KqUA8ipQNAFltsIo94yRwl
         bNNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781027648; x=1781632448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPo/rNEwfs0tGz+mQjgisI/ZCW4vs/mt/EjG+vliJIU=;
        b=iZfBKXHFAby34uHGpYi2VbZP+Pazod5Qc+pxnkwolhQruv5pTqedVLudlVv+YX3wSY
         Uvs1bWsokvHd9EcxespPGitXQUjQ02oG0JGpJMnsFiMTnvIw0gyWIUX/SB6RMjsEv+2r
         rhxt01z2rd5I/RDkyxkfpr3Oe8Hodptu2WuaiHnsd3DEDQ/nKhUoOSbttVz68dwtuT/j
         b+0OdPmoDhTN+E9jd6VE4rPpwar+vQttOWkEP8TTSpQQLlYx1hjyQJ7qHhos34m8vrKX
         mnbEnNErlEybTK8zbZ55NtPOVouI00Ayg/Ef+ogwn4FfwQIx5o5Ut5OR/Z/VmEkyhfB4
         7qlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781027648; x=1781632448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iPo/rNEwfs0tGz+mQjgisI/ZCW4vs/mt/EjG+vliJIU=;
        b=eDj4GpDn23jz779LRPZM1C7/9LuE43Ggx55qDVmVnjUSlxDKZwu8Y9KSGEdxbwjyDq
         RBQ+HQNaKckmyuzqftZqLW8x3v5pDUgmRAyfePxF+X5gKemiqTliLaXFeaQYywx8DdIz
         Y0WBGmUiE7aYZg0KI1OCdKEiL8cbpurClLHY8gx4dMC8UrDN10XMMe6FTxG0HlSF4nRp
         DCXvsYkSM4zxW0BnTcJx/OaK33MoWkQA8j1wcbG+We4kIb+aiwscN3XYHC0joGp0kKrJ
         G+jLpVbLuK4E2oJgHW0rSCfKuT28mrUDvQGGcVDYeuy7FrYvyhh620SLjoZtOMN5x+Gk
         qF/Q==
X-Forwarded-Encrypted: i=1; AFNElJ/bqYGnbbr/BYPSTQDqZkUb/28PISXWLdj7PysXQqOdGycm98L2H0PamV+LYeqr8zMBVjribGnT4GCWfpTd@vger.kernel.org
X-Gm-Message-State: AOJu0YwOP9hpXq/HORmlFX/kMoWDSp7GtF1C+jq4isGyBDMXxz8j6riO
	qGtuGXOa9DERgvZLYD43q0t2AxO/aDluCcEsnYeUu4a/TjlK3n3TXWaFSSfrC7RQmGFHH7BI4/8
	23M+odxCg4YguZPO0ZVQUMISTkRQ4rHEjvKZCr5Oj
X-Gm-Gg: Acq92OHkRr5M3p5zJ9kLCn72Oy+PNZIZjBwItzjWko5UKUprgUDk1feDsoTCJ/lDMvM
	mFxVaCzlrz5gTig3oDYbXwN9ilvtcS0YFcFqg9Xj2oqbC1Msteb+hnWrjPJDQ6RbP6/INJVEHfY
	a9OorATc1t5n7p8Tirgvgi3Ob4pR6HeQJkh98amLet2bSMRNuqUd2b9bdwbeWJSuPuSNGFz4y3i
	xGFpc0VV0T2agYl7f4tMp0CYvamryeuUCd/p6si84RfKAU5kjOuCwx2u5fSyfVHeEFX2V5hk9JG
	ATJKPTLGbbrHr0+mGWvTVAvpFjkZ7ucQsIDGT68lI+YbNz6X
X-Received: by 2002:a05:6402:708:b0:68f:d45f:e497 with SMTP id
 4fb4d7f45d1cf-68ff191f2f4mr222363a12.14.1781027647308; Tue, 09 Jun 2026
 10:54:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528095235.2491226-1-me@linux.beauty> <vealb52tv5suireenkke4lul2l3wbnaul2rp3ea545ly5wa5ty@yk3aksvp7skt>
 <CAG48ez38OEE8ZPLyU6nr9=cYx-hMsdoh5WRrv-GMZGMDKyyOTA@mail.gmail.com> <lhubjdk1c1m.fsf@oldenburg.str.redhat.com>
In-Reply-To: <lhubjdk1c1m.fsf@oldenburg.str.redhat.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 9 Jun 2026 19:53:30 +0200
X-Gm-Features: AVVi8CdbotQb6TdiuBRRRFJLKPXdrZXdsDiaDY2tYNXV6Fkhva6G6BZKR3tezyY
Message-ID: <CAG48ez0FCqMaEgosy4K59pKan6Wn5RMbJeOuNWAc_m_56nDVYg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 00/13] exec: add spawn templates for repeated
 executable startup
To: Florian Weimer <fweimer@redhat.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Christian Brauner <brauner@kernel.org>, Li Chen <me@linux.beauty>, 
	Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, x86@kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 8:08=E2=80=AFAM Florian Weimer <fweimer@redhat.com> =
wrote:
>
> * Jann Horn:
>
> >> Per the above, the primary win would stem from *NOT* messing with mm.
> >
> > As you write below, I think we have that with CLONE_MM? The C function
> > vfork() is kind of a terrible API because of its returns-twice
> > behavior, but I think if process cloning with CLONE_VM|CLONE_VFORK was
> > wrapped by libc in a way similar to clone() (with the child executing
> > a separate handler function), or if it was used in the implementation
> > of some higher-level process-spawning API, it would be a perfectly
> > fine API?
>
> No, there is still a problem with SIGTSTP handling because we cannot
> atomically unmask the signal during execve.  We need to unblock SIGTSTP
> before execve in the new process, but this means that it can get
> suspended by SIGTSTP.  Consequently, the execve never happens and the
> original process is stuck in vfork:
>
>   posix_spawn: parent can get stuck in uninterruptible sleep if child
>   receives SIGTSTP early enough
>   <https://inbox.sourceware.org/libc-help/2921668c-773e-465d-9480-0abb6f9=
79bf9@www.fastmail.com/>
>
> More on the low-level side, it's difficult to make sure that execve gets
> a consistent snapshot of the environ vector.  Both vfork and execve need
> to be async-signal-safe.  Any locking or memory allocation (except for
> the stack =E2=80=A6) persists in the original process after vfork returns=
.  The

I think that's not entirely accurate; if you call set_robust_list() on
a futex list, then call execve(), the futexes should be released once
the process switches to a new MM, in
begin_new_exec -> exec_mmap -> exec_mm_release -> futex_exec_release
-> futex_cleanup -> exit_robust_list.

So in theory you could use clone() with CLONE_VM and without
CLONE_VFORK, and let the parent either wait for a futex that is
released on exec, or somehow asynchronously check later whether the
futex is still held... probably not the nicest building block but
maybe workable? Though I guess it would fit more nicely if there was a
"munmap() this range on exec" API...

> environ vector can be large, so making a copy on the stack is not ideal.
> It's even harder for getenv/setenv/unsetenv implementations that use
> locking instead of software transactional memory.

Makes sense, that kind of sounds like a pain inherent in being able to
execute from signal handler context...
