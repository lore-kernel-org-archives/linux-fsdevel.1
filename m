Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D0D36D9E6
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 22:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780351413; cv=none; b=YbmOU0A3UAL3iBPOwflqPTVlZXlYQv+f+bt9gG4DDPN7IQOgroJXFQFF4EdiGD7bAHIGRxnx07mXG6uRy88O6UYyubWYM8rHs8zrJIofc62V+YCfDt0NglQ+MMAgMAZKgBBDx+nWAo6rMux4rk9qhCRjfYukgM+icn/LLLcgHeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780351413; c=relaxed/simple;
	bh=83lncxcpot/Afd5XIwcskqRkvp1vv5KnwdPLSaz2B1c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dqsP/rRzN2OlGGTDHCwwZJTqFBZfJehYkxeHEq3qC0rQW0zos30Jm/IoXdoieE9gDyk8rvX4kdnGSG42LIqNzfiqEIjkE4zEjyVzKpCvQLTG7O6OHw7+NIt5QfvGlJd6C/cId89pUfnJK6nmn1x3APn+33JyFWdDV6qwnfPeNik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BH7EXDYi; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BH7EXDYi"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490ac357c55so12249305e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jun 2026 15:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780351410; x=1780956210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldPi0/vo1HBN6vtwxFpHQongTWGF3H0cNZG5BgrmAm8=;
        b=BH7EXDYi7ssUFijv/vTYa5M29cIxuI021KvN6+hxmv87oT5Yy7769qJzs2HpoY4MZu
         VMG4mwyC9l5pkn5alGAoQcJfgCzO+MRcopCBmXCTC77YLSnIeKXDBhmx9xZpFSrqFxQP
         KrWA9c4MjOEWIGlH7dBmCD/fX7Q7/MWXN6Iz2WcYnUfgeL6OjvOXXSsHyowAaqGKZYVQ
         iRjTxwxjs8oMgqLj2y8usMdJoVazEB0r4ZUu5jsLzS/VH3ZP4u6MGbys2IsG6e+qkkfU
         4zX0q9mdpas6JB+8I4Y9/cCis7OwGvnDX3bEOnfLQnSwTrYKXUO2Fy4rsxPseXjeVWY/
         6ssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780351410; x=1780956210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ldPi0/vo1HBN6vtwxFpHQongTWGF3H0cNZG5BgrmAm8=;
        b=VAhI+zugoM1du/48UDVGS5F+KCEFLPiQHU4DeLUcodU+y4vhH1dq6Q+LetIwzNXyog
         gCx9Hbnshy/C9gClCNZD/Gy/SbTQkbcrJu6FIuxw5ds+D8HyyLeRl0xRf68iXOiQWBmf
         uvPMPoXaWAb5hlPZsFal10BHmKWmE8wMUUB9PlkP0EqgjkaTx0CXv/sF1qI3jtH/Hn4w
         2D/5EuWsGhYHv+kdNBrrRlLeiNoLp3gyHtprjLOQdflChwQLHGNXky4rV2s2pkI8Hrwm
         bFbTBcdcSOToBY28N0lJN04kBn7aEX5Xgvquc76ewuAfQRtx22xDGSGER8eeW9hbQcLJ
         TJJQ==
X-Forwarded-Encrypted: i=1; AFNElJ+fIMqna9LcYR4ASi5Gg3aWzEjLRgHSM2qn4zKmfEhAvDAWsZ0wqlWLzXNDzJk8W1FgNN1UvDEd8rahglNO@vger.kernel.org
X-Gm-Message-State: AOJu0YygMziQ+gLOFGnRjFpIkYYJphv3UcWmY9u8x+CM3ynWOdR/W47W
	lTryHEzmZ94aJltsOe2hc07SGEqLkF2PhShe4VecVl3hTOad8JfsLmDt
X-Gm-Gg: Acq92OFSZG4TQc665eKwzfko9QtM3JQXIumPm177+U6mFrIOuiqIDV8ay9umIm+VHdZ
	knoNl7kk/X/3TM0kCycKf6M4lfsUY8HVbHqxr2wm+Rp5SgIhiuY4SWwVhP1smaTBvP7mtgCb9RB
	qL8R5R1TIfU6LaD9h2/4M6VcRPV2z0ot3WWpkAXEpFHveL2SIkdIGN7KrjyB7N0GeSDV+bND2P2
	j1x1zGHHRorrZQgpa8m+5Z9/OIp1/jfrg2RMZKGV9MJtwp8/HpYIptGhI/WUX4kPaBeWPJl2OOM
	WeXtoVDgu0BmdYZIGgfsGihQxe9fy5PpXlRwPHkgj8nD7Rz5fAotRJJUtTdtqbtpIDR6MasR/dM
	5fg/9Oxc6cOXtlaeOYl1v6VTjcjGmB47HluyHi9SpsjGQB0K0GZeql7LTsKyZ3/9RX+0WTCegbd
	uU78LU3uPjWX3LpiIGGJxxSQMjMSLPj2n4IVvfaY8Dk61b3BOo2Zji8r/roEHExoPb/Ktu2RE=
X-Received: by 2002:a05:600c:8b35:b0:490:5380:f2cb with SMTP id 5b1f17b1804b1-490b0702af7mr28495355e9.0.1780351410286;
        Mon, 01 Jun 2026 15:03:30 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c09ac4bsm84800275e9.3.2026.06.01.15.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 15:03:29 -0700 (PDT)
Date: Mon, 1 Jun 2026 23:03:26 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, Chi Zhiling <chizhiling@163.com>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>, Andrew Morton
 <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Chi Zhiling <chizhiling@kylinos.cn>
Subject: Re: [PATCH v2 3/5] mm/shmem: introduce copy_zero_to_iter() for
 large zeroing
Message-ID: <20260601230326.09981e44@pumpkin>
In-Reply-To: <rvvwfa4dp2wovn4vlglajxwpumiudvcgbnrj6fwh4dxtxemawh@rbav4cliyraj>
References: <20260601055704.167436-1-chizhiling@163.com>
	<20260601055704.167436-4-chizhiling@163.com>
	<ah2HfH3jJZDiNAQc@casper.infradead.org>
	<rvvwfa4dp2wovn4vlglajxwpumiudvcgbnrj6fwh4dxtxemawh@rbav4cliyraj>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 1 Jun 2026 17:02:01 +0200
Mateusz Guzik <mjguzik@gmail.com> wrote:

> On Mon, Jun 01, 2026 at 02:22:04PM +0100, Matthew Wilcox wrote:
> > On Mon, Jun 01, 2026 at 01:57:02PM +0800, Chi Zhiling wrote:  
> > > Currently, holes larger than PAGE_SIZE cannot be handled because
> > > ZERO_PAGE is limited to a single page. Add copy_zero_to_iter() as a
> > > wrapper to support copying larger zero ranges to the iterator.  
> > 
> > I think Hugh put this optimisation in the wrong place, and you're
> > perpetuating that ;-)
> > 
> > So perhaps we can start by moving this optimisation to lib/iov_iter.c?
> > And then you can redo your optimisation on top of that.
> > 
> > diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> > index 243662af1af7..06c54d719fcd 100644
> > --- a/lib/iov_iter.c
> > +++ b/lib/iov_iter.c
> > @@ -451,7 +451,23 @@ static __always_inline
> >  size_t zero_to_user_iter(void __user *iter_to, size_t progress,
> >  			 size_t len, void *priv, void *priv2)
> >  {
> > -	return clear_user(iter_to, len);
> > +	/*
> > +	 * it is noticeably faster to copy the zero page instead of
> > +	 * calling clear_user().  Shame.
> > +	 */  
> 
> 
> This is a rather suspicious claim. If clear_user is indeed so terrible
> that it is faster to copy, the routine needs to get unfucked instead of
> the problem being worked around.
> 
> I can't speak for arm64 or other non-amd64 archs, maybe these are
> horrendeously broken.
> 
> On amd64 some archeology shows the following:
> 1. 0db7058e8e23e6bb ("x86/clear_user: Make it faster")
> 
> 2022 vintage, replaces thoroughly terrible 8-byte per-iteration write
> with rep stos usage
> 
> 2. 8c9b6a88b7e2f33c ("x86: improve on the non-rep 'clear_user' function")
> 
> inlines rep stosb at the callsite if the CPU has FSRS, otherwise
> fallsback to a new routine which does 64-byte writes per loop iteration.
> 
> FSRS is reasonably popular by now and chances are decent the test jig
> used by Chi has it.
> 
> For a size like 4096 bytes, the 64-byte loop will be slower than rep
> movsb and even rep stosq. This needs to be patched and maybe I'll get
> around to doing the needful(tm) in few days (it's not hard to write, but
> some care with testing is needed).

I think Intel cpu from Sandy bridge onwards execute 'rep stosb' just
as fast as 'rep stosq'.
(I'm sure I've done the measurements for 'rep movs' and stos ought to
be similar.)
I suspect you get the same big gain (twice as fast) from an aligned
destination (IIRC 64 bytes on later cpu).
(But I doubt it is worth the cost of aligning the destination.)
The source alignment (for rep movs) make no difference at all.

The 'elephant in the room' is older zen cpu.
Some of those are no where near as fast as you might expect.
(Look at the issues using 'rep movsb' for all copies.)

I can test a range of old Intel cpu, but not amd ones.

-- David

> 
> I could not be bothered to check how the workaround showed up, but it
> definitely needs to be removed as opposed to being perpetuated.
> 

