Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2543B8D70;
	Wed, 21 Jan 2026 23:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769037662; cv=none; b=S+MUrTCY/0F3aH1kgaqnxHiTISL6MhdQLga3HlWf4w7KHHaGMErSsKdErLNUbGtcQwrltu4XedNmvgZqG059I+AGDodMyqMNynixaPtw08bsYn3QyEkZrrEQWoeo3AC88VcR14422DyJn0q5SzjW3aFGPIcPKXqvIozZCsgyvjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769037662; c=relaxed/simple;
	bh=OGS/fNnlPes+JePKrm0CsA/gNGfnZi7LTgyUV5rtYQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HoAG46aP1YQ40jthyzvwgKbX0adGnxPJ5xHzXjajf3+dI2WbCoJOCnWTXvFs9yO7J2V/di+Cmfbdvj8hE3wWFt42QYLuIxkvjRDMT0e67+UhUONHFltPPUKtudmGjCUwSgpDeAPZKEqpXRJk1m3ZL3COyVUs5f/Y8fhdOlMMyzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=RnxCtGYR; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="RnxCtGYR"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 0CA0D14C2D6;
	Thu, 22 Jan 2026 00:20:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1769037651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CuLgIEQicKxAzOp7ggur18BjDbH0Izb2IJBPplUcKjY=;
	b=RnxCtGYROU3Pzp2Z6VJ6IjGSi82WzhLXQc24UTMxeHcSzMD7dKgx/s1lQ88dCz+4EKmJbu
	0CGoB0nFkL0VurFlq1k/wtHBeu1decs5N6FkwlJIIaCxZQr8Rl6DCEO8k/RQl/4ruMm9yM
	e/dvKLZzP6oX9xZVUoM3yrBr+0KGgmvM0zYThcfFKp28ZECgcdNmWnngl3FAp/YV3ivqG0
	aHSag9Vwx0hi/RdFekpyOC74Pk1PNFvi92UlvgBTE4qzHrpvy/WeH7yFYKnoxg3SFmSlDt
	GQYzFqPj/Nbte+2rHZw8SzqNROl008NDHIe9tjY5OrGDk+VMxG6kg7adLupryw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 6abc6ff1;
	Wed, 21 Jan 2026 23:20:46 +0000 (UTC)
Date: Thu, 22 Jan 2026 08:20:31 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Remi Pommarel <repk@triplefau.lt>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	v9fs@lists.linux.dev, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] 9p: Track 9P RPC waiting time as IO
Message-ID: <aXFfPweqq25iE-UC@codewreck.org>
References: <cover.1769009696.git.repk@triplefau.lt>
 <47f0b44f159084f4032a9424e0e2e586b8640a12.1769009696.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <47f0b44f159084f4032a9424e0e2e586b8640a12.1769009696.git.repk@triplefau.lt>

Remi Pommarel wrote on Wed, Jan 21, 2026 at 08:21:59PM +0100:
> Use io_wait_event_killable() to ensure that time spent waiting for 9P
> RPC transactions is accounted as IO wait time.

Thanks for splitting this out of your other 9p improvements!

I was about to ask Peter/Ingo which tree this should go through, but
could you also convert the other few wait_event_killable() calls in
net/9p/trans_*.c ?
They're either waiting for other IO to complete (virtio x2) or for the
current IO to complete (virtio/xen), so I think they qualify just as
much.

(the virtio ones will likely conflict with some other rework that's been
dragging on last month, but given the patch is trivial it won't matter
much, you can send as of master)

Thanks,
-- 
Dominique Martinet | Asmadeus
