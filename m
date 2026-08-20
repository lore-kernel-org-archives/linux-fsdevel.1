Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C5A3F58E1;
	Thu, 20 Aug 2026 10:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787222483; cv=none; b=Rps8Bp7pMOXp2LYK3Vs2gU51ZS7kIbCGQZ7dmZ64M6saSkJWsJwjPYb2ZYaHNq/fw74rWwgG1hZ+Q4wZpzRTsSpDEkXU5KYOf347MCEkYgv65gVDimLO4F4U8UGxJsjWka/VkFqs6NOXzpMZ1DQK1xifGRAslbDhjlF7+0u3cyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787222483; c=relaxed/simple;
	bh=TxptvlsWpoC3IHlBpWmv7Jr3XQBii5dXCz1Wf6tKYFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNce2TFawv6h8XqIjulzjL8WS+CPCAnHhalZYD6ckJMD4DbCMk78UF/hrQI+LWX22HV4ac7/OMpwUswUTdtH1R7SCYhzdFbOgiZiVleUyo4pem348EwqdtQswtDTJvNZyO3prD3RVJUPuulzZFg+yrOKvk4FF8xOIjoqbUwlm6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IbDigmCb; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IbDigmCb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4axu5f3ZFy9nhF6jr3ZiDEC2ngzj+j39W2+MyShgJZ0=; b=IbDigmCb7Shr+VIqVz4otAUxjN
	soxhTWg1bgmougR6KLxriKz4Rp5pFOUKZdCxYY5y1Ax1/MPtuy3ZdLyHPIZzWRU+Z4JO2DR2nxPZd
	XEi+UJP1rgA28s5wEfp1h8xUVjxEl25n4Z0zBjXyytg6DzeFfv3EShwLICDAVazmxf8wdYeLhz86p
	D7siufmLQ8bxz7GtDhW54QDyfsIR+M2wfwk1tw7Skjx1WaHP7c3fhM2WKdqTiabxXDEeziObnkdKb
	oJ38WwK0xgRQVjVbPz7Pau8Kn2ZqVjNMa1mjpv7leyVMYhc1wWc/A0ZP63K2xfvPXq9pzFKCNp1Zb
	9drsCViQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wx0Cz-000000031rx-2y9m;
	Thu, 20 Aug 2026 10:41:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1CACD3006FA; Thu, 20 Aug 2026 12:41:12 +0200 (CEST)
Date: Thu, 20 Aug 2026 12:41:11 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fuse: permit freezing while waiting for request answer
Message-ID: <20260820104111.GC1837346@noisy.programming.kicks-ass.net>
References: <20260819023542.561653-1-senozhatsky@chromium.org>
 <CAJfpegu2wOG85R6KSvCwHOuxe2fWczA1KbrFcCZz=ofUch4K=w@mail.gmail.com>
 <20260820084933.GA4036497@noisy.programming.kicks-ass.net>
 <aobDGgivy43cz7xQ@google.com>
 <20260820091018.GA4120091@noisy.programming.kicks-ass.net>
 <aobGRjc7SE1rwIHu@google.com>
 <20260820093402.GB1837346@noisy.programming.kicks-ass.net>
 <aobKfyGHkdMcleoc@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aobKfyGHkdMcleoc@google.com>

On Thu, Aug 20, 2026 at 06:47:03PM +0900, Sergey Senozhatsky wrote:

> > PM_FREEZE_ME_LAST is going to be trouble I think, before long you'll
> > need PM_FREEZE_ME_REALLY_LAST or somesuch nonsense.
> 
> We probably need more than one, yeah.  This doesn't take into consideration
> relations between tasks within a priority group.  If client A holds a lock
> and enters freezer, and client B sleeps on that lock, then this group
> cannot be suspended.  We need clients to reach some freezer checkpoint,
> instead of doing in-place freezing.
> 
> > Using cgroups for this also doesn't sound right.
> 
> This begins sounding pessimistic.
> 
> cgroup-s sounded solid to me, because this moves all the clients to that
> save freezer checkpoint when they don't hold any locks.  The only
> problem is that if a task never reaches "return from syscall" then
> we fail suspend.  (I'm only talking about user-space tasks here, in the
> context of fuse or inotify.)  Why don't cgroups sound right to you?

The cgroup hierarchy is already a mess, and the more different things
you want to stuff in there, the worse it gets.

Also, I still have machines with CGROUP=n.

Also, you'd be putting suspend success in the hands of userspace, that
sounds like a mighty fail right there.
