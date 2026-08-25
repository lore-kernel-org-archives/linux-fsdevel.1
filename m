Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0840481A92
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 13:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787665652; cv=pass; b=HZ1dBpJwimTpu286VcQ+j32AZVREpDNcWWfDHrcNFxvMLC8Zbuidh5Ohb8eUqaosN1m9UNGf2eenDpHqp3HUhPISKY6oOrkOHKfQ69kPLzXEf8jJJ43tAjVMJ9X0G3nV3PgQEfthVECCWgYQ12XN6eH9ioMta7p039Vv3XEvvo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787665652; c=relaxed/simple;
	bh=f27C2IG9jxEp5m5m+A45U94PwUHYq9WXQ+b1ZTPnZCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=svsh0rI1gusSq2970tishkDN6Nm1BQ/J9g0Y5BFvfMWlhrB4YJxiNPrc6RfH+z5mHVj3Z666eyjzghxlKaMcGwSHZrxWjgOLos8bfWqY5i1RqKJM6BKW8J0/yphWpxFSF2QEbrV9rxYsgq/WJ9cKM8bTMKDB9rI+DoQCgpEN2dI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pQfCLGzK; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pQfCLGzK"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d3b440b97aso103535ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 06:47:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787665650; cv=none;
        d=google.com; s=arc-20260327;
        b=TUnJXtRffIl3zqZ24YJSByuMkIODOQ/BiFowA0xMMGIBJZJxVlfA+TFlE2HcSDqkNz
         EaABZEuYy6u74QEW1nQM/5MtwMCaLxutUHTOy2dtFDqzjRXHKrtHqb9oLi+KD+KvvOly
         n3gD/bBFyuwNXpMGGG72kd40tGyYJTMVTJvc0DikWXP0ZhKMNZ54qG1O5FMysRuaZpIZ
         GqojzBzlkUrF08W6y193NoZ0YkXZBe94OOQ6/TpLbptBhUMU4NefsdDy7eV8uX05tc0S
         HklDVw5kr6sFLR0y09mzoeZJTBPEe0Q/T9uNGHvF/eLCUTNQlmRpfrDhJejIJLvbVO4V
         kFiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f27C2IG9jxEp5m5m+A45U94PwUHYq9WXQ+b1ZTPnZCY=;
        fh=S5mOwxfDcAV2+u0FSVA6GcTxj2KHs1rWEkKL2FQjT6M=;
        b=OKARF45AaDP890jfjBDAQDZ1dcUdZ+S1kX+mJMoGPQwXmzHUO+Z6EJMEioa2AbdJQu
         J/ffoqx0M4r5NtLMBAP2WMFWo5pL7huqahALgqnDQLBhD5XFVdtASlFPvpBYi0lPgsP1
         1k35Oo6t8hH3U2Bw2iATtzHM4ZMpfgxkhUYB3nZQZZFYbBFrEML6YWMH2rjIeQb0/S3W
         Yf/R/IQJwlKBUjCIb4lYEJNln+Baaw+5TZ3hpfG2aLAvwBAkNboro/F+Z/kswWcYns1I
         p4tpdaS1r0qGv9rp8IJr82fm5OX0tVGf+sWE4wd2w0eVJtWHekT52mpjFllwZ1p6+jPK
         WSlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787665650; x=1788270450; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f27C2IG9jxEp5m5m+A45U94PwUHYq9WXQ+b1ZTPnZCY=;
        b=pQfCLGzKXbJopNI4+KcVgfsQq1F8p0CjJtsfYdHWRAQkL5eRP+32k1FD8Jt1lDOdKI
         5h0Rspo6RfZObUsE0agFw1NLNHW4HgwVFS/eLezGlS6iW+QeBLLkBaF1up1/qNX57b1M
         oIN3sNEwjYmpkPyNRewHCOhrFGcRVNT94tU9GKJPZeJ2E17RLhVgnBngdEsmaIUwcP3m
         4tGr/g5DrgibwEsm16Tws6a3TcMgyDK7oT2GmfhDqtf2y9lRrIVvcA6/hxhMaHqFCQqV
         yrXQl3Nazf9w87Sxuvi5dcawq6JSLQA7OkOFgns3kHO6bxXFQGmapNRQahbg4i1Zux3j
         b0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787665650; x=1788270450;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f27C2IG9jxEp5m5m+A45U94PwUHYq9WXQ+b1ZTPnZCY=;
        b=SWI3p4o9FfOo9xl77scUbg7fSKa+Ps54NI+vRjBRLBQ/dTa+HGcr6aeNhSxckExIGB
         /xK/oqbjGVxoFJHo1pBWAnIj6B3rfjRXoX/IzAlc27lhIv6+ZJHh4Tu+qeoW3MtlB+NP
         BP2Avefc+ELUrwCMS+JDWrO9x5nQWmuqoLQny2TpFE2lVV5NLFX2BnhXKlGXZfL5xZFd
         AOA0asnu3CZAeRLLBaLmjloIPOce0OurY3vlOViE+AjHYsqCox8YE5EgY9YzECj5et8q
         gMfuAsa1Gnxm9zrHAczOXncv61tJIRWqxJfKjvdOye7FkhYeXZniMgrg8yX+WbqU9KYt
         udWQ==
X-Forwarded-Encrypted: i=1; AHgh+RoLufVMu9qQ/ZJzhlolbFkbkSF5ZbXsZg+FjbevkcwTUEDrYU7KQZ+aOYco00Zj8t+XO4HGK2GJCVW7kHq1@vger.kernel.org
X-Gm-Message-State: AFuF++lQS6dOZtb9BOF50qSezHHgSfj4SJHLZ0ycc63Z2l2oiRKDwUpU
	de3BBdABNkLviTMS73IBqwbjXlWFBHd1r/b3Vh7UZt2MwF7AQZkcSoTS9JBjWKg0+s0tADVg5fN
	Gif8sqIMFHzJh1tMUXw02YDGCYoxyNp9bdoR5GP2Q
X-Gm-Gg: AR+sD13Galy7IBWBKG7Pm8PfWFhYEpO50AcA1JiNvFyYT+pjcvL9i15pvK2scogN0bN
	1/DlKN/PWh/Nr35a0CndrQtu16h7avkYqe4QKJXw31eWXDNX9703sNlD3ZYqIuIixcx4Pqr+YpN
	gTDGUA4mmXfg6y9Brheg/lBsEG8UhWB4A2Tl9c3a7K9OFUPwEzZPL7WQ8BpPGvIrzM1IelHrD31
	0CAezX3SuS7IopiWq1uZbIMasZxGzVPaEF96W+DTWsyms2PqhFk36mdI0cgULcjpQoFSD9joYcu
	xtePkDazetIWD6zg1Cl4RU7IRzT9V7e19d597JwO/5s83OqP+LlFlfVp3mGuTN5SbFmRGuqVKjr
	jhy9UyndmRGoQ9Jbp2tRfA07Abr179g==
X-Received: by 2002:a17:902:c394:b0:2c7:b1e7:501e with SMTP id
 d9443c01a7336-2d6e0833465mr5727505ad.3.1787665649437; Tue, 25 Aug 2026
 06:47:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-2-90cd2357ee05@google.com> <20260825-passt-semmel-primitiv-37712c04e6c6@brauner>
In-Reply-To: <20260825-passt-semmel-primitiv-37712c04e6c6@brauner>
From: Jann Horn <jannh@google.com>
Date: Tue, 25 Aug 2026 15:46:50 +0200
X-Gm-Features: AcwNN1WZJkxp4obi4wAiUHBJBjq7knCxVUW1syYekpF7g7n4ms28g-sCd7iZ7lk
Message-ID: <CAG48ez22J6tYZv6cG0TEoUFBrbhtWh6BHrZYBWuD-ee1hVr4ZA@mail.gmail.com>
Subject: Re: [PATCH 2/3] proc: query LSMs for introspective mem access (if PROC_MEM_FORCE_ALWAYS)
To: Christian Brauner <brauner@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jeff Xu <jeffxu@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>, 
	selinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 3:13=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Tue, Aug 18, 2026 at 09:51:06PM +0200, Jann Horn wrote:
> > If the system is running with PROC_MEM_FORCE_ALWAYS, LSMs currently hav=
e no
> > good opportunity to block a process from overwriting read-only code in =
its
> > own address space through FOLL_FORCE writes via /proc/self/mem.
> > The security_ptrace_access_check() LSM hook is bypassed when a process
> > opens /proc/self/mem because this is considered "introspection".
>
> Useful. I ran into this issue just yesterday in:
>
> https://github.com/systemd/systemd/pull/43511
>
> Btw, it's kinda annoying that PTRACE_POKE{TEXT,DATA} still allows foll
> force writes even if PROC_MEM_FORCE_NEVER is enabled. So ideally there'd
> also be a hook for that option.

You need either /proc/$pid/mem or PTRACE_POKETEXT for installing
software breakpoints. I think if you want to completely block
FOLL_FORCE through ptrace, you're probably in a scenario where ptrace
should either be blocked completely, or at least restricted to
mostly-read-only operations?

> The other thing - though not directly FOLL_FORCE related - is that
> process_vm_writev() isn't subject to any security restrictions other
> than seccomp filtering either.

It does go through mm_access() and ptrace_may_access() unless the
access is same-MM, so it can be blocked by LSMs like Yama.
