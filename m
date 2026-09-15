Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B12414A08
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 16:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488482; cv=none; b=qxcoRDuE0K+CS3vDMv41Cplz2zBfg4DMygegERtT913yTl4H8v3kDi+LJxrlASaiQhkIuQ0hkjojmMDloh2tGe4FRRubf6NQ1nFOTfqCJs4m18ctMjsBU8nKi8Al1QjoNl0SZ9xYyD8LhBWRZwjhCm07gogVCL7IhbFRGJun9kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488482; c=relaxed/simple;
	bh=TaD3IKHcoZf0PQ+wUUh3mHvOgYZf6uXYuUZRFHNcE+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YxFWP81a9IO7a/AXfxEISINe0bGDqPj/RI3weyO9RbiHR7tQOCk7hfMB5bwBsBsjVAUFsHeCmgh4vZYu6V8UjbkgWAuH7X9DT4asfkETHFVZq0AVe3oXcpq7VHz4VkcRzepHNbPjpAwOp9RIkiWhdJuuuADhCPiH17do6zQAZk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Qi0beMd5; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Qi0beMd5"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c2953a01240so287666b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 09:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1789488478; x=1790093278; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cj8iWYGkmy9fr6Sp+MjBMi0cvssqzarl8Tgut8FUMEc=;
        b=Qi0beMd5t8m+Cply2TK1f1p2aG5c4gjP3sPDt1xJeFNYwojCO/mnLMMg3Jp3PGHbwG
         nd6obIWFCfradrTgFNlMuTke/SHzuSXZR9IZJSTnaPwnZqrLMj/NnbdyFd6vEioXEzfo
         Xi2E+1F05vW5UFTKwrUL/Y+Ts7RapCe7o1QP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789488478; x=1790093278;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cj8iWYGkmy9fr6Sp+MjBMi0cvssqzarl8Tgut8FUMEc=;
        b=WTxaMVZD7IEG2RQhObBNOddk/R+s37IYYOVH5PWzkk38wCDgi1qMcjHuof3+sWYfvZ
         DEa6BIU3hNgpVoHhbjB1hY9h7DI8zM7xEtHkoBWqhCQEE0q3DyEY0amIB9bfym7pxOab
         dHBRJOI4h5SK7gQ4gJ+CL2XTq5G8Z7HHsuCwA8O7cSDpRnYaVD4VUK7Mq7NENdDYYtaD
         A/zusfk08w26hugZ7YjMEHLb+i8aohDlRbDOhcZ/RiRdL0ZcD4WxM4RF3nrcXxm5pdFv
         kVAQWS8oHJbwJDkzU+NDisZYfIGSL8xYQTkVzPKrqzpf4YrHIWSfCItwEe0yD/NVjC2g
         lNLg==
X-Forwarded-Encrypted: i=1; AKwUvBx8DmlaKA2JTHtgqPNMbeFIfjyGIlsiO021NzFmZXPQDYrBLFrEt89mVQsNfZ7WvqYQPZg25+vGtgyfoVF9@vger.kernel.org
X-Gm-Message-State: AFuF++kvnSQJh8Ysmorh0XmY1i9luudUIYzbcuKUAcPhsIkm5HRtkGlE
	95Ca6GeDFQE9F11GTXNjkOnVruyAw8bbsCsNwU7g9t+7bKuxJ9m7glIn9SyAnkWV6mpgHjf8L1W
	tPfp4utM=
X-Gm-Gg: AYBFou3t2vydZfeoP+MjQQqfZj+bm474n5TI3AS8CzjlSsYh+8R2aX1+cBD9u3fQKLP
	rFRumBGkKGZbx+Rq14lkspoocYi58r708Pt6wHgtiYEGGoZhHZhRpPAc3jPB8wrW/yVkoib1Qr5
	6tkUV73SC8M0gPKY/PyzdL8HCj/cFGjBT/60DU+rUBb4/FouJzWsFoHVsa3V1Vb16ML3ufmY8B5
	M/IaCYfEBIaSpgAp7P68pOcwXDFC6NZa2mA1N2ZpNZVMih6cvkrVlAYtfJk8Ein15kx4uOe+q0P
	+n3LMds/4MEa3bQjl12cYvDnAH7HtCNmLSvEALJlUTg5bZOelMJcuZvEC4rRl/D2vJxTdwStws/
	c2+mrkz03D/zwDbIDhbh2S8SN4bAuCknYzKIOH+h/JHAWa3A50K+6WVA1v8VE5bjz78YzFyZ+Qn
	MnKF79TbmbdaDinWSAqdDutwTXT2bo37ByajFIM30vJWZMTJcsfpOlfNbS1/UHpGLcBZpU04uDS
	SZOpSIDSuuBpnjv9y/PyHsZZCRlbJL0iFQIsTrB4NBZWawx
X-Received: by 2002:a17:906:7951:b0:c26:19de:9ac8 with SMTP id a640c23a62f3a-c29b86f9999mr579581566b.32.1789488477598;
        Tue, 15 Sep 2026 09:07:57 -0700 (PDT)
Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com. [74.125.228.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de4add55sm927066b.33.2026.09.15.09.07.57
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 09:07:57 -0700 (PDT)
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a99cd5115bso5810716a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 09:07:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzEWqImhCe9RJIG55wbww+FkCdZUaRAX4gw5kVPZUtiFEsRhHxzXb61OvpXOxUcgUy4YfpqmxzicftUCLTU@vger.kernel.org
X-Received: by 2002:a17:907:cd0d:b0:c29:439b:d5c1 with SMTP id
 a640c23a62f3a-c29b86141b9mr553591866b.16.1789488168046; Tue, 15 Sep 2026
 09:02:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 Sep 2026 09:02:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
X-Gm-Features: AcwNN1WK06t9f9BcKFBIanysXcyUXK4eRICuH4x14s60AdlpF6ijCATIYaYAAvQ
Message-ID: <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, bpf@vger.kernel.org, 
	David Airlie <airlied@redhat.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	kexec@lists.infradead.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Sept 2026 at 04:31, Christian Brauner <brauner@kernel.org> wrote:
>
> TL;DR, this lets arch code handle fd install and cleanup. fd_prepare()
> allocates a descriptor like get_unused_fd_flags() does and records it in
> a slot on the task. fd_stage() attaches the file to that slot and
> returns the number.

Honestly, I am *not* a fan. At all.

I think this adds complexity rather than removing it.

The diffstat tells a story:

>  106 files changed, 962 insertions(+), 861 deletions(-)

in how this adds a hundred lines more than it deletes.

But to make things worse, it adds them in bad places: low-level
architecture assembly code.

Those extra lines are *not* making complicated code simpler. Quite the
reverse. They are taking fairly straightforward "just deal with errors
with normal cleanup in the place where it makes sense" and makes the
*straightforward* case simpler, while making the big picture more
complicated and subtle, and adding new code to places that are not
simple and just blindly do somethign that makes no sense in that
context.

IOW: it's more code, and it's more abstraction, and it DOES NOT HELP.

And yes, most of the well-maintained modern platforms (read: x86 and
arm64) use the generic infrastructure and they don't show that
low-level asm effect. So for those cases, it's mainly just  that added
conceptual complexity and a new odd rule - and makes a *successful*
system call go through that "extra work" and indirection phase that it
didn't use to go through.

So it just spreads out the work, and moves it to a less obvious place.

All for the very questionable advantage that you can now randomly add
a file descriptor without the few lines of fairly straightforward
rollback.

IOW, I do not see a single real upside to this, and I see immediate
downsides to it, and a more abstract complicated machinery.

I do *not* see why we woudl want to make this be a "every system call
exit" kind of thing. If there are places that think it's complicated
to do, they could have *their* local little stack of fd's pending. Why
force it onto the low-level system call entry for every system call
when there are only a small handful of actual real cases (the vfs
itself, and random ioctl's by odd driver subsystems).

              Linus
