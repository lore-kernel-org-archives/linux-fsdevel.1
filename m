Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3B03A383B
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 03:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780458679; cv=pass; b=E3Pm7XPwKBy5k8hfJsqMyQLJ7X8RGy/Lr73cQCt/qIWYvHmQQsmawEBXBDhWKXy7GIJiKqU3/LJ9hWPKNNi1Y165M9zg4V3J09Y2+s/AeiK5txoO3j80QVW2uVT5JftoJBeMJGvGIoOsmBhA6hM6W8ZZxxfaVOR92AtdOmpBczM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780458679; c=relaxed/simple;
	bh=anjN+nTOXqNBWHTS9fQMFqGEaXiDXaRnabq18gPz6kk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZTXaK2azs4j1SM+c5wOQY1zXW19Kkoa8Q+y5isx/Yjuc2yqiAYn7sBNi3JyYS3B9ekmpdWs/Vrky/qRzVRh9uO7xojpAXsSVL1vbuDxmLBxsRWN5EzwpqO8TygDhdTizVQr3MfAj9RZVB0pRQyCtVi+7tQEve2S7jtg0vVpRqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b=pACszlmx; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b="pACszlmx"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aa2c25c632so13311917e87.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jun 2026 20:51:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780458677; cv=none;
        d=google.com; s=arc-20240605;
        b=A1PSCBoO0bay2TxwyCNjdBpzxDpwaCrGAbcbu3ypv4ybDNDkhT8CjmWXzzZ+xXjzHs
         Mz9oqRw5/ZqMPbU2GSNdmaKVTtOOjnrjx8hIAHsRItLo8FXhNhELGrD5XtZRuz+O7fUE
         swr4cM0M7FPzsZUx9ot71jwLKuFtRg+I6S0Ixe0FNJlYmT4183pAEP/kgST5PtASevAg
         H5iOAzD3DvZwebUouPLIofOtr4nwmBfDTKF8ksvz+3rYRXSySThLGdtCr1Oi++JLXzVN
         W9AVfqNjibfBB/QgumKZ0EfrzGPu6WgrIfcWGXeIskdAGD70w+hF7i3mog3Oeb/jHQHH
         5Aig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hLctvnpeHHKwaBCwCGUFctRGdwexf3XsJleZhrQYpkE=;
        fh=cPhgK57gDYyeZygRmQAQYjByCi0keayjPCwHL0xDdYc=;
        b=QyVgDX/M94pNwuksMrrpYQVfpkFPKei0A1PK1H3KSAGoqc1+MBzf9ZCY3Uj/UofRlN
         3NZG1A5bDdL6Wo/N1hABWt8hVeW0RjHpAiTT3TZfK78KYApqWa3WQkayMNpW9XRkC2zu
         cj8OwgLcwAWwLEfkegvUlPgiLK+JdM0MqCuWyulHFjt04eZn5lH1SPOEpzr4eTBUuzfr
         X0Y3HXq6KNVdf+HdhvXSRLWL0H5SxncmmmZDm1qcddyJDdWifCmF9PViZNWTEpjRtwWs
         c6SuyIG5WiA023q2zaeQzysr+pX/lfqobaQ059XliwkWRAsB/iH05qoMJceUiJWfDSC9
         4y3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20251104.gappssmtp.com; s=20251104; t=1780458677; x=1781063477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLctvnpeHHKwaBCwCGUFctRGdwexf3XsJleZhrQYpkE=;
        b=pACszlmx3Ln9947bgLM/fx/VQ32WWmcPDl9URflypHU47mh09zCUoDdMN0TpbQjwR9
         L4NKNbN7iJdFMkZ549+BK69za4lWIlIR3xkSdAT6lkQPV8xhZBiZlxXrUY96pwWuJaxt
         P4x/pOcbxq556iCMRflqurGV2i89lN/szwObKm/fmWCeSr/BRC6KFwjmPjQnL6ZZ9JNS
         EIIxI4iPFVjGJsfoYJ/CFvh2a/nsPjzBg9jzRp8MP2Ht/HC38+DL88wJ4lIup0I+zzsF
         fmJMB+9s5U7yo9b1xnvi8lyffz4vX7cPHzYB3U02huylW/P16aPOngD1G2DduXNGEGC+
         tORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780458677; x=1781063477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hLctvnpeHHKwaBCwCGUFctRGdwexf3XsJleZhrQYpkE=;
        b=WfrVB1xkwqykkEjBb7c1k+fMYrTXYM69BbqJ8hYcqbXen7aPTBMqgo047K+m/RlXVq
         WDOzDo+jXSNlG5KiMb7hQGg/Val/uQvdsf4RO11oenTiddhwbVRlBQoCdgHqbNUXyAgI
         vx/YMw4NegZjH3+94x1iaVjHTdw2UfU+6Mr06tJU4gYC+thL9Wbij6B0+ctYNzbzt0Rq
         IV0IW9ziTBiwf45zFOpW5BbWIZm37ex2VpP/pytVV/tm/Xq/8/MS39wfZdw30kJzl8wO
         Lqxh1erH2SBR6eKMkFqv5Y6Bt4bntkDqm1rScADACig3X4yZzLAooFx7pIpDGZPYmN+j
         VF+A==
X-Forwarded-Encrypted: i=1; AFNElJ9SyWMVelev5Ah1+jE8sSfeyHg0UC0nKbly0NeK5wDkrKx5u+wqHLeePYgBFm2zHU/jJ1hPCKQtfQjD53y0@vger.kernel.org
X-Gm-Message-State: AOJu0Yy35qT8U2jY0ZbE0eZGLF4LNoeyPTF994t4jqqvzpcjdRObwt/d
	6ySaRhmpntCN/0AHZOiXMqKDE66/nDw74Ame5oDwKgT8zh5HgKB7oujvGAopvrpS8YZSnR5ht83
	7mfbgElXh+MPn4Jypd4FSxzW5348FIE8XLZA0cY50
X-Gm-Gg: Acq92OGQzpWZgt2N4AZRt6CiPG3X3K3vukicRwz4IU4c19D6acalfNCQKdy4ndStSj6
	km3dbOYywgH7VO5Tlvm2yTOTF14DShUQfuwqT+wUoPp5qyFlbo/rNf850RNgDkerj/9D6+wOm3V
	uvMF9Hsng9HP251YqwwIv9dTbqwlr920V8LVyI+jN0KDoDg4ihNBeAhQr37u9229rfOGZxXYdtj
	v+a+veIz1DSJVkUhicIKoQEIe3Q71JgN4q5pVQCFdWnOub8x2glCEyI29paJpvaWmTW62rvWd/X
	6P1JmRsXuIBjiO8=
X-Received: by 2002:a05:6512:1587:b0:5aa:6d0f:1dc7 with SMTP id
 2adb3069b0e04-5aa7c0bf470mr459675e87.19.1780458676548; Tue, 02 Jun 2026
 20:51:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiAqf0PdZ4AKj_4riUnnEb=g_ZNPkLnXrByA9BBHYiFRg@mail.gmail.com>
 <20260602225426.122258-1-safinaskar@gmail.com> <CAHk-=wgKy4dP0oQCNKyMQQf3-uVpaigmDyH6_T0Via76gWST9g@mail.gmail.com>
In-Reply-To: <CAHk-=wgKy4dP0oQCNKyMQQf3-uVpaigmDyH6_T0Via76gWST9g@mail.gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 2 Jun 2026 20:51:03 -0700
X-Gm-Features: AVHnY4I4B2wg7ilf1zQmemgKARTlVUvTJ9JxDnVBlHgiDg-UsafiWLR7jiVDKio
Message-ID: <CALCETrWx8-Q5-rK1KnAPCxCbXaWCd=Yfs_Pr8qVMa8k8L6of1w@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Askar Safin <safinaskar@gmail.com>, akpm@linux-foundation.org, axboe@kernel.dk, 
	brauner@kernel.org, david@kernel.org, dhowells@redhat.com, hch@infradead.org, 
	jack@suse.cz, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu, 
	netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 5:12=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 2 Jun 2026 at 15:54, Askar Safin <safinaskar@gmail.com> wrote:
> >
> > Pedro is talking here not about this vmsplice patch, but about
> > my future hypothetical patch, which will remove splice-pagecache-to-pip=
e.
>
> That absolutely would be my suggested next step.
>
> Something like the attached - get rid of filemap_splice_read()
> entirely, and just replace it with copy_splice_read().

Am I understanding correctly that this will completely break zerocopy
sendfile?  sendfile is, internally, splice-to-a-secret-per-task-pipe
and then splice to the socket.  How much to people care?  These days,
a lot of high-bandwidth network senders are sending encrypted data,
which is not zerocopy frompagecache.  But there are surely some users
that care, for example the person who went to the effort to implement
IORING_OP_SPLICE:

commit 7d67af2c013402537385dae343a2d0f6a4cb3bfd
Author: Pavel Begunkov <asml.silence@gmail.com>
Date:   Mon Feb 24 11:32:45 2020 +0300

    io_uring: add splice(2) support

Now maybe someone cares about a different path?  Splice from socket to
pipe to file?  Splice from socket to pipe to other socket?  Does
anyone do any of this?  One can, of course, recv() directly to an
mmapped file, but then you pay for page faults, so that probably a bad
idea in most cases.  At least all of these cases don't have spliced
buffers that refer to a potentially read-only file.


But I'm a little concerned that zerocopy sends from files to network
are actually important.

--Andy
