Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1452882BE
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jun 2026 01:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780537957; cv=none; b=ehlPL/4FDGraiqtSF5xKwummHZEJpuasXz3mr9Lwyj9MSbKl13/DtRQ6F9mw2Y5ttMW+FtezfqcVT3QJpB8LpCQ2JoUiLVfPVk+Yr76lKXow5Nm4YvxZFf4ObziiCSdjO2Rc9Q1G9e64MmHh9oKcvmiZvscof2qSYHhKX/shgGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780537957; c=relaxed/simple;
	bh=n1SkdCcNZQRg1IgD5sSmDSj8j+GpuHeY4/Td660VL9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gfqET62z3AH8nKfgnZlH4OvCbu4av70x4pQQUI0HpDDN1uQc6oyiExOBNvQAAtCjwEI3smGU88X/U5JVk+wPcy5lGLLd7pXD8CD5KPSudvbpgM+ezk3R/zttol6pf5DXayNMVm68odf6rkphL+l7TheI8vt4XuTRfVmzbPkOmkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZCyHWoya; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZCyHWoya"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bec3f69d343so18999766b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2026 18:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780537954; x=1781142754; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ti3H/yNlOCN9jiz2PA4OGwlivuSMT91KkxAffb1eRD4=;
        b=ZCyHWoyagQn4jEw8+2BqwvYDxEsb3NKp8UQt5a7vjIM7b49dA31y5YQ6nLrvmLkxwk
         m2U87KFya7eSVerBTp1zyFzoBLbCQbyWNqE+Q2NVnA6lCr+jbohqhEDvR2usn7lNca7N
         tN290XPLwVYPJOb55/oaR6T/LJe5GhmDWXZco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780537954; x=1781142754;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ti3H/yNlOCN9jiz2PA4OGwlivuSMT91KkxAffb1eRD4=;
        b=rGMmDXqh/d3XDsJQRJb4pzVdPfNgO8IED6tRRXM6XvHezclu0UkfNQ5Rwq/70cbdqe
         tbhmVmoCFWLbZ6gGa2lJPuHvlLM6wtHsLhK23uh5N1OGgd/u59iGoaR9ICQpG7A3zNfJ
         4zv8v5JWdjqPgIF/gdPZgIpEuq4sEzXb3KnhSIVY0vq2SqFoQ+FCCk+P3mycmaNoWB7C
         7ZcOdJHxl2CNJbpRcYJwDn2kTPIaaifwOn9/lCCpigg5OJe+/72Epw28kA88xLT4h308
         JYxbuQVGq+3YUPvQxTcjbVdQF9tByvPIeEvjc2XR18M/ap+f8mQlBVU8NTBRfTv5iCRE
         8Eiw==
X-Forwarded-Encrypted: i=1; AFNElJ9t5dRgxnVWXHhwhkoO2z8hG0eAg9iaI10vca3HyScr4J4Ojt+MT5EdWrOZY8hcyfKGc1SleP5tVVhF0KD6@vger.kernel.org
X-Gm-Message-State: AOJu0YybFD1YBdKeEpWYJY9PvncXW4S0UgNOTpVhXxB7NFeKAh8cSNan
	nZUduVsTqXLAMs6AsKuZsEg2PYm01fynltt4gQujcE446HQdgCceYsM3XRnZZ+t+EeojhIZbQue
	iHmFIK014bA==
X-Gm-Gg: Acq92OERPEYMNIbUgVvorRCY0K7AdPppHyO8GTpEyld1T1jKVv99akWU5/9JtZSZ4nj
	BCOzmGpMJ7wzxPSMaIKOD1FkmFJkp0fEOe60vSOjHTHvdHJV0VtWbhBK2gVp5RfCvsRsc3j/dEg
	q84W9AWgo9TQQb524DN4g7hIEZVWjzcbNBY06QK+1QV1OuGgdZoGQ4RSvxdezmVnCVwe7oTjJS7
	nJUvg2VQdoqS8nqT5vZyNHIFucYfib+05mH8MerJUgwUS9k2Lai3ehmp8Lvz0Mhg9mhxmVBIsFt
	+A2e7rWazRP7WuNwiif+AIZ1/2Rm7duMv6NJEwhn+0y7BLdpirQgJLfvIJ780zunycaru4ccfkg
	/7SuloWmZZmroYL0cykJNsmZOsaDjfmzZuAAmvJ/nWdsRnYGLvpZ+8iE5CZ3qLiG8c2j1GG0Cp2
	IV7QJ28Z9A0pyAx0CmWHaq/gaRk/POtwxeyxF30FZTmUfXlCVr6sbEJVFWuoxqrZZCD4/wyt2se
	yAd0JonOng=
X-Received: by 2002:a17:907:c282:b0:bec:5234:af7d with SMTP id a640c23a62f3a-bf0ac20eee8mr303970366b.6.1780537954214;
        Wed, 03 Jun 2026 18:52:34 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf055307a35sm230614466b.52.2026.06.03.18.52.32
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 18:52:33 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-68ca6f01079so134921a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2026 18:52:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+cXj8DrqaYfTIS56I+2X9XupGlDOFP/EidvZLRzn8itkiKnljRrrBK98d8/NXoZ8DwTKh0WyyFuC7fY+8n@vger.kernel.org
X-Received: by 2002:a05:6402:550a:b0:66d:d2f9:520c with SMTP id
 4fb4d7f45d1cf-68e72250122mr2844444a12.19.1780537952777; Wed, 03 Jun 2026
 18:52:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531010107.1953702-1-safinaskar@gmail.com> <20260604004559.1112474-1-safinaskar@gmail.com>
In-Reply-To: <20260604004559.1112474-1-safinaskar@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jun 2026 18:52:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPzxQL9Bdze=qnSa5v8A2D6cPaU0Bi=j4N38+ja1NkzQ@mail.gmail.com>
X-Gm-Features: AVHnY4Ia6Rugs2gzhFv567LCSFsgwGvMvJbpyqp7BVsPOVMqNGKAIqxMQwoy6bY
Message-ID: <CAHk-=wgPzxQL9Bdze=qnSa5v8A2D6cPaU0Bi=j4N38+ja1NkzQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Askar Safin <safinaskar@gmail.com>
Cc: akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org, 
	david@kernel.org, dhowells@redhat.com, hch@infradead.org, jack@suse.cz, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu, 
	netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jun 2026 at 17:46, Askar Safin <safinaskar@gmail.com> wrote:
>
> For example, in vmsplice I do "CLASS(fd, f)(fd)" and then I pass
> "fd" (i. e. integer) to "do_writev/do_readv". I don't know whether
> this is okay to do so.

Oh, good point.

It's ok in the sense that it will work, and it's not really going to
cause problems, but it does mean that the 'struct file' will be looked
up twice.

And *technically* it's a TOCTOU race, where the first time you look it
up - in the vmsplice() wrapper - it could be one file, and you make
decisions based on that. And then pass it off to do_writev(), and it
will look it up again, and now it might be a different file.

Does it *matter*? No. Even if the file changed, and is now something
else, it's just going to be a different file that the user does
writev() on. do_writev() will still do all the appropriate safety
checks etc, so it doesn't really change anything. It just means that
you could pass what you *think* is a pipe (because you did that

+       if (!get_pipe_info(fd_file(f), /* for_splice = */ false))
+               return -EBADF;

and by the time do_writev() then looks up the fd again it might be
something else, and now the user used vmsplice() as a really odd way
to write to a another non-pipe file instead. But the user could have
done that with a regular writev(), so it's just the user being silly -
not something that really confuses the kernel.

Coimpletely harmless, in other words.

But it would probably be *cleaner* to pass in the 'struct file *'
pointer that you already looked up once instead, and use vfs_writev()
instead of do_writev().

And I do suspect that the wrapper system call should use the same

   SYSCALL_DEFINE4(vmsplice, int, fd, ..

that the original used. Because it somebody crazy had the high bits
set in 'fd', the old vmsplice() system call didn't care, but your new
emulation system call will actually see the high bits on a 64-bit
architecture.

Again - that doesn't actually *matter*, because "CLASS(fd)" takes an
"int fd" and those high bits will be masked out at use time both in
vmsplice() and in do_readv/writev().

So it won't affect any behavior, but it does look a bit odd in the conversion.

And I already answered Christian wrt the change in behavior: I think
RWF_NOWAIT should always be set on the writing side - because splice()
never waited after it filled a pipe - and instead that
SPLICE_F_NONBLOCK flag should be used before write to check for
whether we'll wait *before* doing the write like it used to do with

        ret = wait_for_space(pipe, flags);

in vmsplice_to_pipe().

(On the other side, vmsplice_from_pipe() used to do
pipe_clear_nowait(), but I think that becomes a non-issue with the
conversion to readv()).

And once you need wait_for_space(), that probably means that the new
vmsplice() wrapper simpler needs to remain inside fs/splice.c, and we
just need to make vfs_readv/vfs_writev non-static.

              Linus
