Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794948842;
	b=eWQ2AhMJEGAOiQnO+TGORcoZkXQFcVoM8q1PxjooFerz2CGPIo1Mm/TUmRMI128k9PE8
	 RriB1EcAQxHVOvkkgzKUQnUu3vrGw4n0m+zqCxEqa7fE/3Pw0ki73j20JEn883qSpO53X
	 AeYFOac9yP2IdKRcq/j3D4YvqYVWvFt4yQKafr41VicgEcd5GTEjlJBVeanHXEepwhx9R
	 96PnPe0mKlmvDw8JfO1mFnh3HqykpxOXTyEUH4OYS0OCrUIQ1sLIYUJFIvVUXxdcN9Ygk
	 6GzwH0L6BcsaNjCX67Iz5cIVvdHuv7ziwy2O+q32nHdT5XTxhMPYo0qsZjhQW162iCg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794948842;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=lxMCjoGZWG4QAWp+HpCFavF1sxg7OOCbkVFjQuSNzhA=;
	b=OveVL71gAUG1ljZb9FpBAoCqqPOVDd0SqZs+CWt9ia4DdZVwR3890+zXUDabMed8KWHl
	 j3dkOjkQ6ncEiSa87OIHwDABC0/o0gs736Ad8ccqA+n6qVw477vY9KvfuXyW97PVfkr1U
	 05L2WmW6Jm36po+LW6Vs6626OkM115YOrvgroU/L/ghGM6E8ACJ7rH1ZF7otBt4JYEUNR
	 /zLja1qcfBpToFivUptiOxVPMqA9jln7zvkzvLNA/GsxOC2GMUH5hh4OeW4JFVcw+60/F
	 HxKNazGOVIAkxtSIx+NRFlUzu1khWgII8FS07X3WG73723hqHgqT4o9VnQ5vCliHieA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=amacapital.net;
	spf=pass smtp.mailfrom=amacapital.net;
	dkim=pass header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=LslQjUmg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.50
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A38D606A32F
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 20:54:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A38D606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=LslQjUmg
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5c14f3dab66so148877e87.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 12:54:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794948840; cv=none;
        d=google.com; s=arc-20260327;
        b=X+sV0/Y+LmiT8Cbc4YQOyrDZx23ZLP8LCtiTD/FNUHuAveWoDtOtWRlfwFj4jdphRd
         Vouln/U/0uYUdF8X6hgJvUQmnuFwnOnqxkWsx+ykEt7dQKa8/c5uIuu2foe2lvN+iB+u
         p1Y+KIoMkypDizNN7YS75Nua5J45G47S2jRWsIzY9zuNFHT9OQGMPAzphF2NrNFWgbo7
         ycuRC9q8W4AvIEjgndD0sSY3l0qG8NgKci2TWhy9wZg/QZIslmeVAij8HA7pJE4aIf5w
         eGkTliTWioelISekpvv2cbAcGB1TZg3mWhrswbrwJEQ4L8Un5kmd7/9SvqmPAZj+CtME
         yxiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lxMCjoGZWG4QAWp+HpCFavF1sxg7OOCbkVFjQuSNzhA=;
        fh=FppMR6JMyF1YXQa25y6IQk8nx7nob/FsJ1gbH6Zr6KI=;
        b=UZYQRvELUFT02ESvNjLno2PWGK7k2tebbgNwaIt0H4br4MrFW0Llb1o+JkTZCRNBI9
         upGXV6JvgmEb9TO722BKyobeQ4LKJ4K8BO1wd8VFn+u5jF0/nW98UDvZMaxa+Ew1ccqO
         Ovr0YN7W2LML8Vq2GLbbOhA7epbH8vOkIhzpeid57EtsZj4UvR3/tBeeSed101uVf/hv
         q/RvEAXOGXnoATSE/eb72RPmDS1MWzsDXenVDlJQr9X7NGP09v9Ly9WGfk0YMvlKJVOi
         mdVdy0xjeNGwEvi09HW7S5Hx79rVYmdQrGUfGoj/iutb8OvZMSRr0u+Zkpjfbp4lFQuL
         A++A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20260707.gappssmtp.com; s=20260707; t=1794948840; x=1795553640; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lxMCjoGZWG4QAWp+HpCFavF1sxg7OOCbkVFjQuSNzhA=;
        b=LslQjUmgXp7ppoB5z9C6lIh34ojfvcQ8nzfZ/Bus0FFDGG0DUi+QbKakM0fZFVIykq
         5mE0e/s/CpUqdx5hmSPPf4ZqfdbbG/4eR1cdypM9sQ7xLq3NiWuooniPj3c+oOnP/Gs/
         9eulqTIqNDLgU092uHWrXSQFQOUQ0Ybq8I+KARDSFo99l3A76mmdMOP5EIWjKF4SsU8k
         CLRnBvH95KDC8joQwrmPsfza+TxJts5K4ekF1BkXcERhq9o5i5YAd+8YKoGtExZnN7ex
         +BuNP6j+NU8hBGd6crUPCUF5Rx+iT4Q8fvcxMfppbSleGXT6F0Sca+oO5jRTOaHafzSk
         UZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794948840; x=1795553640;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lxMCjoGZWG4QAWp+HpCFavF1sxg7OOCbkVFjQuSNzhA=;
        b=AkUWmA4dRDmlY6sBt00QqPsNh5J71VqFaJMwJZQtXPGC3LLZYf04qFLdrZfFRKxNUD
         ARmw6EX8BLyofv1a4iomrT/R1RCt9sKZU0btDw9qWaZM2jpHBHVHDk3B/eaeQZp5iSTf
         ifimGqJ00MHtZOBceiWrMMlT6BerdOxT9QVdf3z6NVANht8DgT0ZoiRk3iKwNkEvCuxR
         laPzS2xF7Sd93Yv7hGmYMJcBq4V9/Gbtn1xR1yNSGfTTO2iooASI8Jml3Xd2pD9gTMzM
         xKyZjSwjkSmnjOiMRiFPWmuEyZ5boJ4xS1nkK11VCy6cSJbFPecOJJLxzVHYsBWOSrN6
         AyXw==
X-Gm-Message-State: APuU4Z8BewvcImAHdRfsLV/AQ3qKIMmEvlfPur1pNct1hhPlP6xl7oYO
	3XrDxof9XhZWi3LfCiXmZZzJCgvjxJgTvJ2OZ3dT1PjFFGHVASbkSlCQYe3++txAzBcq4iGtEWK
	q2+WljUSA/ahSeOn1PvuoMwGNWXJOJ1mGo1x7np4f
X-Gm-Gg: AYBFou1eCLiURbo6sKts4N1FVQw9LMXjpPGDlnMa4BPlY/fbH7ppez8GT9Zi97E7Q56
	8fMfx0KeNB+cbB+JgSAiP2wbUdHFR81rUZf5OoG6u+bPTMkt9knhxZUb0N9MWu+G50eBPBP2PIn
	LBv4h9zgPSMyMvknaXpRL5dBJQIbMe/4aZzgzGAIpoyIiNdQnIVhSPFRQiTjz6juU6+aADJh6yu
	JNiNNZRMD51yg1fixnB5bw1V/FUKnRnG41IxDBRYur15s99N0FCkoo1b3Um5asuDn3JV2sqhwJ4
	WKmKD9wscR53XLmn6m13i3U+nZXldkGV4A3NY2wAJSzMAEJGSZpBhN19IobAlSITlGpCpNSL8w8
	+ypG49nu5hrZNRPR3FLxdgoA3uvqwyWNH7w==
X-Received: by 2002:a05:6512:224e:b0:5bf:b96b:89f4 with SMTP id
 2adb3069b0e04-5c1a0f1b8e2mr1319677e87.19.1794948840370; Tue, 17 Nov 2026
 12:54:00 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117050841.3289652-1-jarkko@kernel.org> <20261117050841.3289652-8-jarkko@kernel.org>
 <CALCETrWtbUFQGDOCHkxAN9O4i29ixfL5KKF1Cqw2-CjxKwC6gQ@mail.gmail.com> <avyzFnKQrNOid25y@kernel.org>
In-Reply-To: <avyzFnKQrNOid25y@kernel.org>
From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 17 Nov 2026 12:53:48 -0800
X-Gm-Features: Aa3M54qx88-je4c1jdCxPXUBmX_p3qTxglmaltFgKplV78kiTxOHsj4XFF6xQaI
Message-ID: <CALCETrWHxjrQvRC66d1fvkZw1e8_+38BdzmjSYHmqRjXZnD8nw@mail.gmail.com>
Subject: Re: [RFC PATCH 07/13] rootns: Add rootns_enter() system call
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Ben Segall <bsegall@google.com>, Christian Brauner <brauner@kernel.org>, 
	David Hildenbrand <david@kernel.org>, David Howells <dhowells@redhat.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ingo Molnar <mingo@redhat.com>, Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, 
	Juri Lelli <juri.lelli@redhat.com>, Kees Cook <kees@kernel.org>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Manfred Spraul <manfred@colorfullife.com>, Mel Gorman <mgorman@suse.de>, 
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Neal Gompa <neal@gompa.dev>, 
	Paul Moore <paul@paul-moore.com>, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, 
	Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Serge Hallyn <sergeh@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Suren Baghdasaryan <surenb@google.com>, 
	Valentin Schneider <vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Vlastimil Babka <vbabka@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 12:03=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org=
> wrote:
>
> On Tue, Nov 17, 2026 at 09:42:26AM -0800, Andy Lutomirski wrote:
> > On Mon, Nov 16, 2026 at 9:09=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.=
org> wrote:
> > >
> > > Multithreaded userspace daemons cannot call setns(CLONE_NEWUSER) or
> > > safely mutate process-wide filesystem state in place before spawning =
a
> > > child into a target namespace set.
> > >
> > > Add the rootns_enter() system call to fork a child process directly i=
nto
> > > a rootns whose root mount has been installed. Transition the rootns f=
rom
> > > ROOTNS_READY through ROOTNS_FORKING to ROOTNS_RUNNING for the first
> > > process so it becomes PID 1, serialize concurrent entrants on waitq
> > > until bootstrap resolves, and admit subsequent callers into the runni=
ng
> > > PID namespace until teardown begins.
> > >
> > > Require CAP_SYS_ADMIN in the target user namespace, forbid credential=
 or
> > > PR_SET_NO_NEW_PRIVS privilege escalation
> >
> > Why are you disallowing this if no_new_privs?
>
> For no any good reason at all apparently: no_new_privs is inherited by
> the child and only restricts privilege gain across execve(), whereas
> user_namespace transitions are allowed under it.
>
> So yeah, it's a spurious check, and thus I'll drop it.
>
> > This isn't necessarily a showstopper, but fork() is really quite slow
> > in many cases.  It would be nice to have a more spawn-like API
> > available.  I assume it's possible to open a file in the target's
> > mountns by some sane API even without entering that mountns, as a side
> > effect of how the fsopen / move_mount mechanism works.
>
>
> If the caller retains the O_PATH fd returned by fsmount() for "/", it is
> able to open files inside the target mount tree via openat2(...,
> RESOLVE_IN_ROOT) w/o entering the mount namespace, and pass the
> resulting fd to execveat().
>
> For avoiding full fork(), there are (at least) two options:
>
> 1. A rootns flag in clone3() (e.g., CLONE_INTO_ROOTNS) and a rootns fd
>    in struct clone_args (disallowing incompatible CLONE_NEW*, CLONE_FS,
>    CLONE_THREAD, ...), and callers can pair it with CLONE_VM | CLONE_VFOR=
K.
> 2. A flags parameter in rootns_enter() (e.g., ROOTNS_ENTER_VFORK), which
>    would map directly to CLONE_VM | CLONE_VFORK.

There's also been some work on using a pidfd-like object to build and
spawn a subprocess.  Supporting that would make sense, but I don't
know to what extent these projects should block each other.

--=20
Andy Lutomirski
AMA Capital Management, LLC
