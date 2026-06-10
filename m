Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F5A40D592
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 22:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781132363; cv=pass; b=uLtgP6q4m2tzXr21cnOgj2g1nhulXGKDvGChzLQqiMfYSU9ugOzQEmp3hnTJcFrAGehYnmrY++WhSaOyFBS+1wY8cmx0GzPT3IzlqlMcThtzhJaGYW3FPeMIKoAPXmGT+YisUhqnXE1+q0sSN2rBk85rPR6d05ubYUUwh2NwVFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781132363; c=relaxed/simple;
	bh=oEzIwJCTEGfUPAMEdjx97uQ6KkcVMIzM//6ziaFjsoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BqtJW4ZyOZ+KVtoIilTwHHbPw+FMRoS9SYdIdOlN2+80am3jZ9B5/50YdwKeqKYJShmGptY3YelfVU8Q0nXi6vYrj4j1nTnEu1uSHDEoanjAmoHRgjOnYjk2iqGlRMKVYe3QHaQBykM7xl9i/79qdlRbYHTQud0hksONBLQk07w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qEn4tIWy; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qEn4tIWy"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bed2b9bfa02so988601566b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 15:59:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781132360; cv=none;
        d=google.com; s=arc-20240605;
        b=TjYBcDI8vJyEIaNNjeQTijHTfVxqBWRqWor8/lrU31VtA+CrSagf5pvNhLwk/4JDhK
         vHxBIBScRewhyAXDDjJF7WH6K4zEv9DSmfGJa+16T6HDNtpmPOqLAmRyDKZi6uR6PwGh
         m20bNVbLpmkzfurL8vdHdcEqMHAXRCIu3dCMKDvnvS5BsZVl1Bj+93FTmmNUCaRrcY03
         5X6LLilYC5W3NoeWN/RZ3QQHAOsZaWw9yTHvd358V/HfbZmNQdwV57rv0QjefG6WO/XA
         Qk4tfDeM0W+XpHqKSvJXNnKrM/YzFscej7dh+M41qz06wjWv5lMFAVvgNtNEzvYDWoyK
         N5Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oEzIwJCTEGfUPAMEdjx97uQ6KkcVMIzM//6ziaFjsoE=;
        fh=dyUlh9Xxs2HAP2U+JANj7Tf2aCjJf/l7WPsX+YQzjQ0=;
        b=LEadxiFkERKb+B0iIMS+HU66vGZNHyFqFVy7awYhKu5wS87OOQLqreFduC3lnhOiPO
         r0kI82dWu6NlkhvrEHYu0yPmTkosxx+YWjqgewKFdEQCQ/L76NQPv+zikymj07ENR/if
         vzF23dkwmKk8iTUY+zCNajaCPFe1mdIJobsvWX6n3G1pX2Ow5YFnQgOhxUNK6EOU6dbr
         w+jtR3Chowq8dTbtkosUN+ThPYGjgK9rZX29vcQPee3mt3U2fmwVT4CvwBOLIxtA9UGj
         soyBGRKNq/iAEM4O1nytOU/QQJpNBaUbF+fwZyhILd4HmdLsUy0lf36WJghFNx+Naxx4
         8Lag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781132360; x=1781737160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEzIwJCTEGfUPAMEdjx97uQ6KkcVMIzM//6ziaFjsoE=;
        b=qEn4tIWyzGrvjUgvO574u6bAFB8n1Bu79d+gI2oyFcZSTG2PxL2qFkS7fainrrfrV8
         JBMIOmi08eKO7E1Aj9XPkaMb/2J2V2mSI7ole22hdtrek8TO+kg6IQXol5thJJGLcXMe
         TvO4cEC9g7XMzDu8Gbw6Hh4RTK6UDyqZgmnbe9NiDrFgl0sQHcsJgFHeiKnJjdk481Pa
         w4sUsM1k/OBPwW1b8N0SWLEtBrHQN5WlmEpsaRUJglIosxsDBsE1YWDA5Rex2p+aGKkL
         kFPkBD5MrcWH4toiaQBJb1V1kvARUTSG8MKzUg5hBPmu5IGHxgP6iZ423hIxmHohe/Ax
         vulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781132360; x=1781737160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oEzIwJCTEGfUPAMEdjx97uQ6KkcVMIzM//6ziaFjsoE=;
        b=YA9cRrycsBmseqhHlE/gKPre7HuvjrMQ2Pj2WRWXakKI6Om4LRzCI9oz4bGYw5xV5E
         DcP6FKHf0KuejAM0O546NXxbv5TEQ6sMBZ1pYlyYKSlknKWs78TEoyt9XZXabj0CMZiE
         SVJOCAcZLzSQy0fAy9RLmOZmO0ky0bTjNSfrTo8Hb5/2Wv9A2zS6Dua47TlrOAytSCM9
         PcQT99jiXOV7wYqWN+JfoO3k1VIW4miQyVxU+eznJgbT1VIuE1UISw0gUr8P54oCV37p
         ohezkzWm5CN/a9citvPfWHJvZlKaeq0EGSFGt/81qV+aHFq4ncy5zSp2FBJ42dZ79Tq1
         XRmg==
X-Forwarded-Encrypted: i=1; AFNElJ/ObFLG/CzAdeOeE1hmm54J6ksAio31corYSYofMkno1uhIkon0nFRzKfHyzN/LxdC2M0vN3wTe2/iXAsBA@vger.kernel.org
X-Gm-Message-State: AOJu0YzHRXKF3QQ7xI27TlJftNM+GQPRpZZClWOhU4sDjI+1Q37QWSEr
	+c1Md4ow6LveNqh9MVzNovamj7Ll4OGmaB1zxB5owe7D4kMQcJhVWrtVKvLCQ0AaXMBxIogVStZ
	MMRy3SOB9pd5J9oNDMPMDhK5YTcteNZ8=
X-Gm-Gg: Acq92OHGUodNqncVvQ0r1B/iMgPK0/PtA+RzFBn6MUI+Q1UDHPtrSL+frvyjfzpjSb/
	SCKXoT/YEyyQIhGY/9ZTCoBbxVkEdw086qJLoW4JEZa+4LG3a0gXS+sGaB4F2jcXxiLPDhwMEnL
	jF320gYt0I6r1W1LNwkfJH0uC8z5bGIqn9l0K7+jB43CdGjVDm+o4U3D35Gxgd1p8sljdB+dU8U
	Y974isxVcFyJXxNCWe5MLIsUfkiWY8lYXGR1leQX+RGFws6n62AmsEtx2O5sy0lKwkgOewgUxyv
	HWn9RdIf8kjQejOeiYAtJw0tfSOKYPWXVeTImNsWvRyVRIROVQ==
X-Received: by 2002:a17:906:6a1c:b0:bf1:ac1d:94b0 with SMTP id
 a640c23a62f3a-bf373eec601mr1347239866b.35.1781132359944; Wed, 10 Jun 2026
 15:59:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528095235.2491226-1-me@linux.beauty> <vealb52tv5suireenkke4lul2l3wbnaul2rp3ea545ly5wa5ty@yk3aksvp7skt>
 <CAG48ez38OEE8ZPLyU6nr9=cYx-hMsdoh5WRrv-GMZGMDKyyOTA@mail.gmail.com>
In-Reply-To: <CAG48ez38OEE8ZPLyU6nr9=cYx-hMsdoh5WRrv-GMZGMDKyyOTA@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 11 Jun 2026 00:59:08 +0200
X-Gm-Features: AVVi8CdthNiQaFys6OtVKdO_jwR53Q5mhKecw8_q9iDf4OCUN-Dc5Jgmeo3bc0c
Message-ID: <CAGudoHHq-AKfWwRXuVbmz0B3PPK=Z7gW=HeUYOe_8k4fvPJFHA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 00/13] exec: add spawn templates for repeated
 executable startup
To: Jann Horn <jannh@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Li Chen <me@linux.beauty>, Kees Cook <kees@kernel.org>, 
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

On Mon, Jun 8, 2026 at 5:02=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> On Thu, May 28, 2026 at 2:55=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com>=
 wrote:
> > This problem is dear to my heart and I have been pondering it on and of=
f
> > for some time now. The entire fork + exec idiom is terrible and needs t=
o
> > be retired.
>
> It seems to me like vfork+exec is a decent UAPI building block, on
> which you can build nice-looking userspace APIs, though I agree that
> this is not an ideal direct interface for application code.
>
> > Additionally there is a known problem where transiently copied file
> > descriptors on fork + exec cause a headache in multithreaded programs
> > doing something like this in parallel. I only did cursory reading, it
> > seems your patchset keeps the same problem in place.
>
> I think we almost have UAPI that would let you avoid this issue?
> You can use clone() with CLONE_FILES, then unshare the FD table with
> close_range(3, UINT_MAX, CLOSE_RANGE_UNSHARE). That is not currently
> implemented to be atomic with stuff that happens on other threads, but
> if we changed that, and it doesn't provide a good way to carry some
> FDs across, but it feels to me like this could be fixed with a variant
> of close_range() that removes O_CLOEXEC FDs except ones listed in an
> array.

Suppose you want to exec a binary with the following fd set:
0 is /dev/null
1 is fd 1023 in your process
2 is fd 1023 in your process

You have tons of other fds and you don't want any of them anywhere near thi=
s.

Clean interface from my standpoint would avoid any unnecessary
overhead and would allow you to clearly specify what do you want.

In this case whatever the interface it should provide the ability to
map 1023 to 1 and 2 in the child. With the current syscall set you get
refs taken on these on clone, then you have to manually dup2 these
which is separate syscalls with extra atomics on top. A fast & elegant
solution would allow you to tell the kernel directly where to install
the 2 files.

Also note in practical terms userspace likes to closefrom/close_range
anyway to get rid of unwanted fds which happen to not have the cloexec
bit which is yet another syscall to invoke on the way to exec. A
better interface would instantly avoid the problem by not copying the
unwanted fds if not asked. For viability for use as foundation to
build posix_spawn over it such copying would have to be supported of
course.

>
> > There are numerous impactful ways to speed up execs both in terms of
> > single-threaded cost and their multicore scalability, most of which
> > would be immediately usable by all programs without an opt-in. imo thes=
e
> > needs to be exhausted before something like a "template" can be
> > considered.
>
> (I think probably a large part of this would be stuff that happens in
> userspace, like dynamic linking.)

I have not investigated userspace, even putting specific APIs aside
the kernel has *a lot* of avoidable overhead.

>
> > Per the above, the primary win would stem from *NOT* messing with mm.
>
> As you write below, I think we have that with CLONE_MM? The C function
> vfork() is kind of a terrible API because of its returns-twice
> behavior, but I think if process cloning with CLONE_VM|CLONE_VFORK was
> wrapped by libc in a way similar to clone() (with the child executing
> a separate handler function), or if it was used in the implementation
> of some higher-level process-spawning API, it would be a perfectly
> fine API?
>
> Or am I misunderstanding what you mean by "messing with mm"?
>

I was not aware of this functionality, let's assume it indeed works.
You still have the file issue described above.
