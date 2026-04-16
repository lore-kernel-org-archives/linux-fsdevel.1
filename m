Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489221643B
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 01:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776304338; cv=none; b=M8QVUjetgoUw0B6nGt/rx32bjV6qOoclVJm2jiviERzjOomibrheWzJQT083l6eFouXulxvl04RZDJYja8ly//PSWQoltLcMdAhGphvomw/5k7w0cmyb/Y3M1UNq1Lm5S9YVXCJP84cq+Xn7/965pVhAZeKu5pG4mEAW6IvRUlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776304338; c=relaxed/simple;
	bh=mSwl4u8HhjXZDns83uJQ0TQsHuRsmHDji46r5AoSykI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XbIHNWKF8WSBWq5RIHfHin3k2lpmm9UwVC8RzpmM7T9CutOrhFve+joaXBG5w0yC5thEjc0X/lw/2ZhbF9t85JMceUYZkwdUhE7od9RTgsKNcncCdzxSqp5h6Iq8xN+Dqg0Aq+6X95l3WBA1ZwMvwZ5tis1RDyld/eQcQJ/H4XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=Z0lSBv92; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="Z0lSBv92"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id A5EF914C2D6;
	Thu, 16 Apr 2026 03:52:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1776304335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9d1whCYX3+76IRyfvmsAIlYlgS+rkVQnb15O/vm/Fv4=;
	b=Z0lSBv921G4Of31k54izWzr3XhH6UnC7AxF51GLrOTnMbazTjACN14WN5ocnGQPxt5xfV8
	VRO4t6kRXgdGMGd8cFuFpWZOBwkjXUKI2JiEuOYOR77tHKOsotac6DPQqXP9RR5Q/oK6zp
	iyc6CYPRWRfut3IkQvLyp13aVnEIXofJOKwXEQ52okMoyMQkcdzcBlKn54spwlFqu7WTf0
	bSk32gN/JUFGXb6qUf7djZfGANtXcu9GBaGHUhgrQetVekJ3SvqUz4zDyZM7h0hs4rVz5L
	+PFEl9v9GMOrFuuX49nkoxTLDt6TbLRylZavrjiCVcRWmdUeTEHXBA6O1DpAEQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 50a6848c;
	Thu, 16 Apr 2026 01:52:11 +0000 (UTC)
Date: Thu, 16 Apr 2026 10:51:56 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Pierre Barre <pierre@barre.sh>
Cc: v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org, ericvh@kernel.org,
	lucho@ionkov.net, linux_oss@crudebyte.com
Subject: Re: [RFC] net/9p: raise MAX_SOCK_BUF beyond 1 MiB for fd/tcp/unix
 transports?
Message-ID: <aeBAvOIZCbICnImG@codewreck.org>
References: <c2c75b03-e95d-49f4-be9a-2429fde4b5fe@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c2c75b03-e95d-49f4-be9a-2429fde4b5fe@app.fastmail.com>

Pierre Barre wrote on Tue, Apr 14, 2026 at 04:26:36PM +0200:
> MAX_SOCK_BUF in net/9p/trans_fd.c currently caps msize at 1 MiB for
> the fd/tcp/unix transports. The commit that introduced this ceiling
> (22bb3b79290e, "net/9p: increase tcp max msize to 1MB") noted that a
> further bump would need the allocator moved off contiguous slab
> chunks.
> 
> That prerequisite appears to be met now: p9_fcall_init() in
> net/9p/client.c uses kvmalloc() when the transport sets
> supports_vmalloc = true, which fd/tcp/unix all do. So the original
> slab fragmentation argument against raising the cap no longer applies
> to these transports.
> 
> Before I put together a patch, I wanted to check:
> 
> 1. Are there other reasons that the 1 MiB cap should stay?
> 2. If a bump is welcome, is there a target value you'd prefer (e.g. 16
> MiB, 32 MiB)?

I personally don't consider trans_fd to be performance sensitive so I
don't care much here...

In theory it's possible to implement a zc operation for trans_fd as well
(send/write directly from the bio provided by the vfs) but this has
never been a priority as far as I know;
using kvmalloc() does allow bigger buffers so I guess it'd be possible
to allow larger buffers as an orthogonal step, but I'm honestly not sure
how much performance gain you'll see here?

Since commit 60ece0833b6c ("net/9p: allocate appropriate reduced message
buffers") there shouldn't be many max size allocations but iirc there
will still be some (e.g. readdir?), so a very high value will likely
still somewhat impact performances, so if you do care, feel free to
provide some quick benchmark that shows improvements in IO workload and
not too much degradation for metadata and send a patch -- since it's
something folks need to opt-in by setting the msize anyway I think it's
fine.

-- 
Dominique
