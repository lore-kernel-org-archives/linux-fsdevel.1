Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D643A5E80
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 19:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780516802; cv=none; b=M52+iodzHy6pLtHon8AblOcdMeg5IJ0pny2rxJfp2pMQ8E6xqdNFT5rDgViPWBJYDiCrTkbh/waJgf46s/1go+JJxhpySNfxAjx9FeOwpjRBiEseJ5naEliUUClqUbXRr2zdpqLo3BSYDndlda5aV4mruz1WOCVsa8iFjuofgX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780516802; c=relaxed/simple;
	bh=cJCdMggMBtlaRufFOzf56NF2SmvXVse1UnTO+KmUUY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CqCf/O29C7PSAXW/5y4glOoIC7/95uZ9hj2HklAOKbomYHClprcqKL2mtim21vjcKttk3zFLtB8QOxr6H7KqByofzD6PYqoeylV/iYnTb3EPkNv0XMs4f+gFC5ma3mZUdubqz2JIDgacLrVzEi+8gapiFlFhaIX78wId/pPlRNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FdaO0QAS; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FdaO0QAS"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36b95eb4bb4so3397490a91.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2026 12:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780516799; x=1781121599; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rLwU6+VwyCgHprpb82bpoZ1vCU00viaTeQ4mjhQKQr0=;
        b=FdaO0QAS68QWZT6jQqIW4sa4Ov++CF4dW/hkpwuHa5YogIfOMTRRb7tEkWBZe/Wg2w
         5lPTmM5Qk0b4p3OD4lBcrq7256uc2LWeh6DFFlNa07IFXkwp3dKExRcXNUJus6YMUWBc
         8GGY63KpV6K9UZc69JVnJZfsEIZNNMNyam9OI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780516799; x=1781121599;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLwU6+VwyCgHprpb82bpoZ1vCU00viaTeQ4mjhQKQr0=;
        b=ILf4y8N53pUUesrRZ0dSJpxZljQFsQePxEj47LJw6Ud7gpEuno5e+vU/9L4XCJ396g
         HV8HnpOUGvDAIwGczJPR4AmHF32QdbRrE3MYJrxKvvqyBTlmX+TmhbJkZjfMj0tZa6Gh
         f5r++nHLPJPUjlCDqZ1hdFXsHyFZiO6REp9kjrX5oDN7qrqfyayr1Mk8nfqIhumYv6ox
         CTG+pIbEBZ2o2EaGgxUgKWeL1Mpfkm1FA78Nlis4/j8cw2iBL3jKVohGexdyag43z0PZ
         azO99gwTseD5aA2iq3wzQbG5qI/fxr/EeFVzLb+v+lalT0KaSula8BMDdJiEA9NbAtXi
         Z+6A==
X-Forwarded-Encrypted: i=1; AFNElJ/WAN9Z6JXjW05UdeeHgkFjY3X6MmpPBuAHYZ+/6ZMfsFq6YsWG6g0iuaOTi3k6ISyJRoy5Bsg4kZHnc17u@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2BfZ3EiKIi2SwczlVQ14EQ4h85IJlE4Tq9Cs8eGE8UCT81yue
	v/S69wI/5NL2oKC5M6QCxVFnKdPzkNeNeIYem52jq/m38sZ8I/9M3nUtXUhbto/urb2n1RTM9yt
	jYBrBcAxj4Q==
X-Gm-Gg: Acq92OE6XHZfJwKTN4DwWUUDPL6sMxzZB1etrEku9A/XqtFYHCmemrPo008Ws+1bgXl
	f1pGY10OrPweFeSgqvH/6ju4oPdAxeT/Mh6+R5M7A7nDNzS3995MfVKMP7FViMUVjqXmytPTcjv
	JJJ2lp6u/RWRCxkX4kZcd8x4bO6A6xQ+8Yg7x/ltM6cNMcTI+BHOWCIEDmiBOn9XBJIAcYCV4UF
	AHFhu8aTZ8uelrakw7aRbUEMdndGeVLUzSPXwzv8lqtZlXqqrT5TkFEJLt16IP5CuDbIb7mQB55
	y7rpGFZVY00alvXtKRt5NXz/sDUMF+bSuCJkwnvSwir9sTeODHcn8uPXxyVTYHGuVRjaAwUs6Dl
	5udk95HEgFERhH+zcth1Y+oaVRcq2CNwRULD4HM2YcX6H7jgGantKDTlzunfy3oFWtM4Dsqe6G6
	+l2UMzSdJ3d8rKkHR6bPQaVZ877uPAwthXjXUZw/Y7wmPIU0AMhezyYhhhLlaLEti24MCI0uBwi
	aa8+PtS42A=
X-Received: by 2002:a17:90b:4f85:b0:36d:f28b:72e0 with SMTP id 98e67ed59e1d1-36e30f0eb4cmr4781238a91.12.1780516798873;
        Wed, 03 Jun 2026 12:59:58 -0700 (PDT)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com. [209.85.216.46])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36e6b904cadsm3207379a91.0.2026.06.03.12.59.58
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 12:59:58 -0700 (PDT)
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36b8e1760ccso3901654a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2026 12:59:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+SVBBY+3GmW1tn5PVFu2wbYmCOPeGwjeympnX/8HKn6NuNQGyegD1BBKK76YYxACv5sjoQAl8PCdddlazQ@vger.kernel.org
X-Received: by 2002:a17:90b:2f86:b0:36b:77b9:5c8c with SMTP id
 98e67ed59e1d1-36e3237e125mr4484034a91.17.1780516797989; Wed, 03 Jun 2026
 12:59:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiAqf0PdZ4AKj_4riUnnEb=g_ZNPkLnXrByA9BBHYiFRg@mail.gmail.com>
 <20260602225426.122258-1-safinaskar@gmail.com> <CAHk-=wgKy4dP0oQCNKyMQQf3-uVpaigmDyH6_T0Via76gWST9g@mail.gmail.com>
 <CALCETrWx8-Q5-rK1KnAPCxCbXaWCd=Yfs_Pr8qVMa8k8L6of1w@mail.gmail.com>
 <CAHk-=wizkDXRut5xLXRF-CVUVYMaZ5AOexxeghOAoXPb4yAvQg@mail.gmail.com>
 <CALCETrXzxubt4eWue3+wv7Fq9C2m7uu6bWPstqFh6Mo57bPwQQ@mail.gmail.com> <CAHk-=wiEwSjfbjfO74xu=UmkkdHXkJg5QNQ8pP-3iYmunmeV9g@mail.gmail.com>
In-Reply-To: <CAHk-=wiEwSjfbjfO74xu=UmkkdHXkJg5QNQ8pP-3iYmunmeV9g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jun 2026 12:59:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=whkGbMoP-Dym8pAd3hV21=BZST+6sK++1X038+9Q-TgeA@mail.gmail.com>
X-Gm-Features: AVHnY4Jw9pwWVUIawcRWYEJbSOr_4eFJHRjDI61fxjs_qgnMfY70yBDODQXhxd4
Message-ID: <CAHk-=whkGbMoP-Dym8pAd3hV21=BZST+6sK++1X038+9Q-TgeA@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Andy Lutomirski <luto@amacapital.net>
Cc: Askar Safin <safinaskar@gmail.com>, akpm@linux-foundation.org, axboe@kernel.dk, 
	brauner@kernel.org, david@kernel.org, dhowells@redhat.com, hch@infradead.org, 
	jack@suse.cz, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu, 
	netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jun 2026 at 11:28, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But even then you need to have a *handle* to the buffers for the
> general case, and that's what the pipe fd ends up then still
> effectively being.

Again: for sendfile, you don't need the handle, because you can just
"read the file data again".

But the the handle is needed for any buffering that can't do that -
iow pretty much *any* other case than a file-backed source.

So the original use-cases included things like copying media data from
a TV capture card to a GPU for outputting in a window.

There it's actually the intermediate buffer that is the important
thing, and it needs to have a lifetime that is independent of the
system call itself, because the system call may be interrupted by
signals etc, and you can't just "read the data again" when you
restart.

So the whole idea with splice() is that you have an input, an output,
and a stateful buffer between the two that has a lifetime.

Having just a iov_iter isn't enough - even with the current much more
capable iov_iter we have now (compared to when splice came to be: two
decades ago when the modern iov_iter didn't even exist). You have to
have that notion of a buffer with a lifetime.

(iov_iter came a couple of years later, but it then took many many
years for it to become the powerful thing it is today where you can
put almost arbitrary data into it - it started as purely a user space
iovec iterator, all the bvec/kvec etc stuff that you need for IO
buffering came a decade later)

So there's historical reasons for the use of pipes, but there really
is a very fundamental reason for it too: wanting to *generic* data
transfer between two points, not sendfile.

It's worth noticing that in the generic case, zero-copy isn't really
even an issue.

When you think operations like "splice TV capture input to a pipe",
you typically need to allocate the pages that you then DMA into
*anyway*, and you'd just put those pages into the pipe. And the facty
that you can then just take the data directly from those pages when
you splice from the pipe to whatever GPU engine that does the decoding
is kind of secondary.

So again: the big deal with splice() and the pipe isn't really about
zero-copy. It's the in-kernel buffers where the drivers control the
allocation and you don't have some "user space allocates memory, then
kernel looks that allocation up and uses it" model.

Having less copies is kind of incidental. It *might* happen just
because it's natural when some streaming device just gives it data
away and doesn't care after the fact.

The problem with splicing from a file has been exactly the fact that
it's *not* streaming data, and the filesystem zero-copy case gave
direct access to the long-term cache.

Which is undoubtedly good for performance. But it fundamentally
*requires* that the sink is trustworthy. Which has been problematic.

That's why sendfile() is bad. Not because splice itself is a bad
concept, but because you have to have that absolute trust across
components.

          Linus
