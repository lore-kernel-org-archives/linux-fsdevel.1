Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED05D364EB2
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 16:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784910041; cv=none; b=lRllhzsGhte7gqyl4lYdM73MNa5aK10xaQhqOTh/jJpKDLgoQca5XC5uj6fF0Sn3sCPfgK+pJIgx4ud5Onp9eDWg1u6wZfcZQEnfMJW/ZTtvaKp+KPkJOLR2JsmZp+2yeAGtFD4SL4c2lGfz8dc5btsG6yXYpYIhnTEltCYl4ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784910041; c=relaxed/simple;
	bh=f5lUzLuDOtgjTTzZczrx6bIv7ISJiHMCRqUVE9vsVZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHYeZ2ddlSW5meeB0vvuUg5tdzSIfvvAqgQSvYlRUDLWBOerTCJUEFpkQmK0VqLNa5pY9N9u43KU8k9PrrDHdwBTqUs1bhTDZqt99nrB2RD1/1f6IAfpGXBK4SZITOhfsD+tPT6balIUqvwWQbgluDgf5MQSFcwua3fZQDioQtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pygx5pgl; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pygx5pgl"
Date: Fri, 24 Jul 2026 09:20:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784910034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fUD055KHyWsi0IQQ2hgaYMP8tx9U7htfcme7A3iola4=;
	b=pygx5pglgn9Nv3USmoYxULnZQw13c0fbkkVf0Z9OpdMc3TVuvDrJYzLZ0YabMKtPHdfQh0
	1+0pEm8yelUS38J+gNff5Y9VQH/F2vWKLknEAvuhsZinMTcuMj7zsZYXwyc6P9QHTjIHo8
	lVyARhd4hb4wkrLLxzucqVTvx7e5ebs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Usama Arif <usama.arif@linux.dev>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, d@ilvokhin.com, 
	hannes@cmpxchg.org, riel@surriel.com, kernel-team@meta.com
Subject: Re: [PATCH] eventpoll: compute timer slack lazily in ep_poll()
Message-ID: <amOQpfraUUmpJr2w@linux.dev>
References: <20260707190238.3478608-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707190238.3478608-1-usama.arif@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Tue, Jul 07, 2026 at 12:02:38PM -0700, Usama Arif wrote:
> ep_poll() computes the timer slack via select_estimate_accuracy() up front,
> before checking whether events are already available.
> select_estimate_accuracy() reads the clock (ktime_get_ts64()), and the
> resulting slack is only consumed by the schedule_hrtimeout_range() call on
> the blocking path.
> 
> A busy poller such as an L7 proxy event loop calls epoll_wait() at a very
> high rate and often finds events already pending, returning via
> ep_try_send_events() without ever blocking.  In that case the up-front
> slack estimation - including its clock read - is pure overhead.  read_tsc()
> attributable to select_estimate_accuracy() sometimes shows up in perf profiles
> of such a workload via the epoll_wait() path.
> 
> Move the slack estimation to the point where the thread is actually about
> to sleep.  The timeout passed to ep_poll() is already an absolute deadline
> (ep_timeout_to_timespec()), so deferring the estimate does not change the
> wakeup time; taken closer to the sleep it is, if anything, marginally more
> accurate.  On the common non-blocking path the clock read is skipped
> entirely.
> 
> Measured on a host running a Meta production workload with the following
> bpftrace script:
> 
>   #!/usr/bin/bpftrace
>   fentry:__x64_sys_epoll_wait,
>   fentry:__x64_sys_epoll_pwait   { @in[tid] = 1; }
>   fexit:__x64_sys_epoll_wait,
>   fexit:__x64_sys_epoll_pwait    { delete(@in, tid); }
>   fentry:select_estimate_accuracy /@in[tid]/ { @sea++; }
>   fentry:schedule_hrtimeout_range /@in[tid]/ { @shr++; }
>   interval:s:30 {
>       printf("sea=%lld shr=%lld wasted=%lld (%d%%)\n",
>              @sea, @shr, @sea - @shr, (@sea - @shr) * 100 / @sea);
>       exit();
>   }
> 
> Over a 30s window:
> 
> sea=3,587,704 shr=3,003,920 wasted=583,784 (16%)
> 
> So ~16% of ep_poll invocations of select_estimate_accuracy have no
> consumer.
> 
> Signed-off-by: Usama Arif <usama.arif@linux.dev>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
