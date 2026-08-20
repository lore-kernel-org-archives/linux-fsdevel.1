Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3B135E949;
	Thu, 20 Aug 2026 14:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787236473; cv=none; b=D+/manXU3Ncon0TQi3RL0G04b+yj8+vTWa503rg8F6KPXL5BFtlDSOVGOlgv1mFHt4ujJHbs5+CUjirrsSe1XYTW3H8P1WpTxMLwT3pIRkSNKSkR/j9o1jFwuz4mht4ZrU6mfwug6lWndQ3y4EYkMtV1ghgzgRCVYod3ynTZzFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787236473; c=relaxed/simple;
	bh=cbRnFcbPTEp8ljTPSU8tu5V0osKjxi4emWalhc94ops=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n//zk9T9w85+Cz7MZv/gcZtMA4KWtajUTIpkDkLtbAmGNiZaAHqVje/hrvVhV8s0+aWfJOKBgnwbH2lJ5MC6Ewbm6kzClDz53MWZy32geoeRgHib2duXRZZH+t1nZsWsw69pp16Wg7VDt9dHS7qiEYO1O30nqShWHk7vP3lQnbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OGAzrRdC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OGAzrRdC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nCGTkrhWrZIb3xeP7v7Rxd5y0edHxQjkXYTyHj37cHM=; b=OGAzrRdCCfChHnOWwapbj8AxD9
	CFPWYhncrfUEBMlQp6wUJ+ivIuTG1uNPGw06HgclZIORGuI19uaZtxwjELcOviTT7UQ7aHDJIegWb
	Fh794Y0OvPeZJElYsUXNYLpMMPRSPKAg7oHLxl4CpalsYTqf149MTv28vGTtZrOfi9Wul3XsLIA31
	RxY2q5ajyE9nGGTzYdcQ6HOD30Pub4B84QV36+zeApWGkUGAeUPCPW+ro+tpngeKzN9wGHA7Jr4Kn
	nTCtGxlNek0010kZLJ+BaE4sH2ku8BvWMONqVQpGDYLUIElnFY4PCP49pG5egWizhqQsOgMJbgCnQ
	LmXcCHjg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wx3qc-0000000FoVj-07RA;
	Thu, 20 Aug 2026 14:34:26 +0000
Date: Thu, 20 Aug 2026 15:34:25 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Wenjie Qi <qwjhust@gmail.com>
Cc: akpm@linux-foundation.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, baohua@kernel.org,
	Wenjie Qi <qiwenjie@xiaomi.com>
Subject: Re: [PATCH] mm: filemap: tighten dropbehind completion context check
Message-ID: <aocQcaMMU7-rfn3e@casper.infradead.org>
References: <20260820142956.1414337-1-qiwenjie@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820142956.1414337-1-qiwenjie@xiaomi.com>

On Thu, Aug 20, 2026 at 10:29:56PM +0800, Wenjie Qi wrote:
> folio_end_dropbehind() uses in_task() to keep folio invalidation out of
> interrupt context. Task context alone is not sufficient: preemption can
> still be disabled, or the task can be in a preemptible RCU read-side
> critical section, while filemap_end_dropbehind() may reach
> folio_unmap_invalidate() and sleep.
> 
> Use the established conservative three-part atomic-context test: reject
> preemptible RCU read-side sections, reject configurations without
> PREEMPT_COUNT, and otherwise require a preemptible context. Unsafe
> completions retain the existing best-effort behavior and skip invalidation.

Have you seen this happen in practice, or is this based on code
examination?
