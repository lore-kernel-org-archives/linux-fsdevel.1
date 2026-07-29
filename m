Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0B43C1D75;
	Wed, 29 Jul 2026 16:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785342998; cv=none; b=Px9Ps1PuiRjL8uT8KKaq8w4nUxClogC7wHsvdpe9vJEpkpJgtqRdTvDOs4O/dGPQGrmh49xGW4g1l5QS2mD/8rwrzF8od/VAB2b2cs7td8qMh5kp0M+tI0JEw9H6E6zVBQTShdLiTknKoJCeo1WJbh0fMilt7WMxglDL2Plvw9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785342998; c=relaxed/simple;
	bh=tvcXzXQti28HxlHlWQJNIDfbNAoPnOK8M4bOGjwwAw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bolehy8E97IPsA+nX2K8ypSVAyiyhOglc+NTOBjv6WVcbWUsJWh9bZoAqO0m36L8RAUAeeRgKFLPOCxUuS17LDIy0D/999anQ9yjlmwu06OSOIvzxF4EvvctdgFrzN4sZsQTqkN/uQcehMp7ixltcS0czATkhOe5o8zrLc5EXj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=hyI+bd6v; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="hyI+bd6v"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3F021684;
	Wed, 29 Jul 2026 09:36:31 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB8783F66F;
	Wed, 29 Jul 2026 09:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785342996; bh=tvcXzXQti28HxlHlWQJNIDfbNAoPnOK8M4bOGjwwAw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hyI+bd6vl2+Z07rzTz0iR5xyuVsL2EdKpJqN72ssnwQmzDLnSwbLWRI1hRI2iorTw
	 tfjk+FhGzAV6skpFiLOAMXa87pbO0DTF4odlyG0sH53sP/YQAq51TxBHJGD4cAuqkt
	 i5H1kPTA/88DqMb9Pe+8aHpoxzDh1H9fFsbluZmc=
Date: Wed, 29 Jul 2026 17:36:20 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org, sudeep.holla@kernel.org,
	james.quinlan@broadcom.com, f.fainelli@gmail.com,
	vincent.guittot@linaro.org, etienne.carriere@st.com,
	peng.fan@oss.nxp.com, michal.simek@amd.com, d-gole@ti.com,
	jic23@kernel.org, elif.topuz@arm.com, lukasz.luba@arm.com,
	philip.radford@arm.com, brauner@kernel.org,
	souvik.chakravarty@arm.com, subrahmanya.lingappa@oss.qualcomm.com,
	leitao@kernel.org, kas@kernel.org, puranjay@kernel.org,
	usama.arif@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH v6 00/22] Introduce SCMI Telemetry support
Message-ID: <amosBNqF8umNmlWm@pluto>
References: <20260724144430.1440170-1-cristian.marussi@arm.com>
 <634717bf-d188-4de1-8465-31e31ea3642e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <634717bf-d188-4de1-8465-31e31ea3642e@kernel.org>

On Wed, Jul 29, 2026 at 11:12:20AM +0200, David Hildenbrand (Arm) wrote:
> 
> > NOTE THAT from v3 onwards the firmware interface level NOW supports ONLY
> > the latest SCMI v4.0 specification [0].
> > 
> > TODO
> > ----
> >  - [ABI]: add genric events supports -> generation counter/updates
> >  - [ABI]: add Secondary UUID support
> >  - [ABI]: add BATCHED DE_CONFIG and add per-de status to BATCH READS
> >  - [ABI]: more DOCS
> >  - [ABI]: some more dediceate space to grow all around the structures
> >  - (maybe) TLM chardev open-exclusive mode to ease userspace co-ordination
> >  - a few residual sparse to fix... 
> 
> Is this a TODO list as in "must be tackled before this can be merged" or rather
> a "future works" list?
> 
> Especially the "[ABI]: some more dediceate space to grow all around the
> structures" sounds like something we would want before considering merging it?

Hi,

indeed the first two (UUIDs/generation) and the reserved space to grow
were meant to be the bare minimum to have, but indeed the other ABI
stuff is not a big deal to add and so it would be better to have it all
given that they have been asked explictly by the tools team...

...anyway till now I was trying to incrementally add new feats (like the
above) and carry-on SOME cleanup bugfixing following Sashiko reviews mainly...

...so as to simultaneously progress toward a more complete and correct code...

..but, given that the stuff in my TODOs keep getting flagged as "...ehi
this is still missing..." despite being in the cover TODOs (O_o), I will move
away from my incremental approach and I will instead aim at being at first
'feature complete' by the end of this week and then resume cleanup activities
next....

So, IF I'll have a decent feature-complete series by this weekend I will
post such a v7 (to gather more feedback), and postpone final in-deeep cleanups
in next week v8....IF NOT I will go straight for a v7 next week with
full feats AND cleanups...

(... not that I am expecting Sashiko not to find more stuff even in v8... )

Thanks,
Cristian
