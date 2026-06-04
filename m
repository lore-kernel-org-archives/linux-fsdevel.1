Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4213DA5AE
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jun 2026 21:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780608741; cv=none; b=CdaFfPvnF+WRxkOSisDfjB7i2Ngzc4iSFq+hzZ7T41k7Q3/hmk02UtrjkzptEXMIlBuE3IcIf7eqIj4RMJiuRQRoLnVPCTRXMp80ZX9NBJ8RDoltWSGOGpid9pkuWeHwyXkjHcHy/I9xwOIoHJvWLWkkAVY6vRjzL/yRW+FDcrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780608741; c=relaxed/simple;
	bh=SgWKOY85N4QXHw6DJquJOy0hqfu11eB/INo5oQyQqiw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H5ghDWRKhN03SeT/5x4MHH725jHvUHe4XkUad1255xyDPKg4mKcsh/UeqEheiQsMBhRGNpTvUmJAKEAw/YB49OjPiiduuuKz3XK0i2AHTlMjGRglc5pi5z+iXnP8DI1aXk0ZH1e8yyixOf891r118cgfIyjJEnrRyR8MBGwsQVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRNqCzl3; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRNqCzl3"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490b3e03939so10095785e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jun 2026 14:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780608739; x=1781213539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQN7agybo6gzy0fVoImTNH+8qqV3opcO9FSCB/3Heuk=;
        b=FRNqCzl3sbzOovDDK978itlbuhw2Msse9nhImaUZTPk6UF67PziAOWjVIcPIk+8ALo
         8YY5/h8G1rsC0C041mmtds/9kfbCfhpe5OroEUoax84EXhJ/rQEaWVwG8zWS73M0FXG+
         5780ygw4cLNX4n9G2SDqg4BbQAmPB3ehcbTy6IRURs/lv6iNBm61LMY3QxQq/FEiB74L
         1H/iSXfZQ2XiRKAHo/hLDw/6khkBJIu8xChkKgkALJPhdzgMcNsyz7pF2NTwdiQ6JwE9
         Ci2332wI0A0RwxWDFOaMf603qqFIIHQkl8aLC3n3BeKqCghDikbtGmFTracqB+y/P7Cf
         5t9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780608739; x=1781213539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IQN7agybo6gzy0fVoImTNH+8qqV3opcO9FSCB/3Heuk=;
        b=eaU04T5vdkFUwAD79KSSroczbvfojzzAythEXzOSKfB9kAiefW/CiCQxMAyEgkvLOj
         74VfkpOiNS8AlxSZxvq0vVY/nAFkvCLf54zP6QfRF5l/aqbLr3T06u40YtlMXEF2AWwx
         MhgFr2cr6XhdNr/u3KzmQjeEeicOhUoLaNZU/fBr3pZ9Ehu2UjFz/OaivEvMDplbWQKz
         a4qj9SLGBGusE6NMcKv+WE/W2e+ynzFl/kEyspjBTtIhET/tTmlLciQq6mzCC6/8Elto
         ahSE1Q3VIA5fNsMCjlgvdHtNvXPnRi+68hj1Q6MN9gZn7VLWZbppvSODnCCpFTRd5ytS
         +uow==
X-Forwarded-Encrypted: i=1; AFNElJ/96qV5+45EBfWc4T5VAONBN2H3mhvIuaYxRn924STWI1+oGTgdcHniLTy9Vt/Izd4ZY4sLPDQdCHdAl+kB@vger.kernel.org
X-Gm-Message-State: AOJu0YzkRFgWJWw0D+nij7iSEUzI8AcihfBkNkcWm71VCYbMYMeurxhQ
	CorxSrXY9Ez/KuYMhGowEbH9nCa0zO/ZCj22VOxGVJvbWVd03/taxR8l
X-Gm-Gg: Acq92OHQUWzAtB/k1IDbFuAnxq4CcT5T+kXahDX3e+YGDdVrucDkvYNHbBUeryFpQ1f
	LPczxgUfwV4bOSRq3uMRgQ47kg7TfHRmUw5L5/M0roQ03S/5jUzMJ/G08JJHLpHweNpvOe90t8t
	JP2VBsaGLXJ19ZY12RjGXZ54mp8q9cttIisIAKEm3H2Q5H3kK2JUPC9ZwxX11CKym3jQVmLg2Le
	Gr3kCd82fZ7Ns1brO3TMXqGZPsYe92aww71/+svSwvwQu2maQTpakivEc87B5xpAQ6eqjpQpgK2
	lPwnFNqgoFT4RbZgb+VnHaKiRIP5mlPf4rtrK3J6uXKW8xfY5JVymNYWwqspxFQD/qtITqb8kif
	6t96g6rUXmpUWSpVGUeR3xy9FrFvckiyh1wXA0wbZUxsunAOHCe2cr2KpbOEF0oi6nuRm1MGcvd
	Pbj5TLUlmrQ1oWCNhZ9zArjqofwSWyNBoCaRs0BebdJAuduUpFQyirdm3fEAve1V3qapyYH3Q=
X-Received: by 2002:a05:600c:348f:b0:490:4b89:5372 with SMTP id 5b1f17b1804b1-490c25e2739mr4133095e9.11.1780608738825;
        Thu, 04 Jun 2026 14:32:18 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3918fcsm111713545e9.3.2026.06.04.14.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 14:32:18 -0700 (PDT)
Date: Thu, 4 Jun 2026 22:32:16 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Askar Safin <safinaskar@gmail.com>, metze@samba.org,
 akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org,
 david@kernel.org, dhowells@redhat.com, hch@infradead.org, jack@suse.cz,
 linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu,
 netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de,
 viro@zeniv.linux.org.uk, willy@infradead.org
Subject: Re: [PATCH 2/3] vmsplice: make vmsplice a trivial wrapper for
 preadv2/pwritev2
Message-ID: <20260604223216.73468830@pumpkin>
In-Reply-To: <CAHk-=wip3mwLOHOYJ9TtjDxOaq9YUXmuCg2AycyASGgeY6qqUw@mail.gmail.com>
References: <f919874c-065e-48be-ac5b-300c4ab86d4e@samba.org>
	<20260603211736.755139-1-safinaskar@gmail.com>
	<20260604100609.6b37f500@pumpkin>
	<CAHk-=wjvb56qo27-axALOKCY-CjLsj9_294zeBovPVJaYm14dA@mail.gmail.com>
	<20260604183829.63c35fd9@pumpkin>
	<CAHk-=wip3mwLOHOYJ9TtjDxOaq9YUXmuCg2AycyASGgeY6qqUw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jun 2026 12:30:30 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, 4 Jun 2026 at 10:38, David Laight <david.laight.linux@gmail.com> wrote:
> >
> > Bool is another matter entirely, (IIRC from a couple of weeks ago)
> > gcc will assume that the low 8 bits of the parameter register are
> > either 0 or 1 and clang assumes that the low 32 bits are 0 or 1.
> > You can't even check with 'if ((u32)bool_param > 1) error()' because
> > the compiler 'knows' it can't be false.  
> 
> Nobody should ever use 'bool' as a system call argument. Anything that
> takes a boolean should take a 'flags' field with bits.

I was thinking of more generally, not syscall arguments.
In C you can't really guarantee that a 'bool' variable will always
contain 0 or 1.

Even if you write: https://godbolt.org/z/81P87vv7o
int f(char *p, _Bool b)
{
    return p[b ? 1 : 0];
}
you get *(p + b), neither (int)b, !!b or (b & 1) make any difference.

Talking of broken compilers, had you noticed that:
struct foo {
    int a;
    char c[32];
};

int b(struct foo *f)
{
    return __builtin_object_size(f->c, 1);
}
returns -1 (size unknown/indefinite).
You can't use __builtin_object_size() to stop code running off the end
of anything referenced by address - even when the size is constant.


> But this is basically what a lot of the SYSCALL_DEFINEx() macros are
> all about - sorting out ABI assumptions.
> 
> For example, on powerpc (iirc - maybe it was 390), a 32-bit argument
> is always sign-extended by the ABI, and the compiler *depends* on
> that.

I think riscv might sign extend 32bit values in 64bit registers.
x86 and arm both zero extend.
Zero extending is more friendly to the kernel where pretty much
all values are non-negative.
I think I've used signed variables slightly more often than fp in the
last 47+ years.

-- David

> But at system call boundaries we can't trust that the user side
> actually follows the ABI, so SYSCALL_DEFINEx() will actually take a
> 'unsigned long' and turn it into a 32-bit argument so that things like
> this are well-defined and you can't fool the kernel by not following
> the ABI rules.
> 
> The same would be the case if some system call actually takes bool
> (but I don't think such garbage exists). The SYSCALL_DEFINE() macro
> magic would take the full register content and *force* it to follow
> the ABI conventions, whatever they are on that platform.
> 
>               Linus

