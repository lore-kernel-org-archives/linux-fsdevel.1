Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03AB3D9544;
	Thu, 20 Aug 2026 09:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787217024; cv=none; b=D7bKb4yMl2nVy7kCqsTbv7MVhiFQ/DLSOswXS3TxAE+Le5CwwmF6M3Rldcu4cZVxAVCmpLlxOn8cTr9q1l5s+emcJ4AvIaAXwceg4RcGufIGVqr+8grYtO4JPdhOVkIS5yGH/3+B3YGPkOrEVafdpKsRaGYpr3bzh5TdltbVmOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787217024; c=relaxed/simple;
	bh=EqfKLhU//OFBs6OTvjbqed9nlF1pEprwancPXtG4OxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o88C9VGPRUfxFNlJhvEccJ+Nln8M0fnrStH/WxyN/2arLzevza9k5jnrDMCe1nMHWRysTZz5abwbAuauJLLh4uBufw4m6YizYADkkWMIM8i0d3YpNIO5fgr3yFtHwuWKnqrhvgEgY+lhXkJLHBQyxQAuBAYFO79OP0NoDfMB2+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hJjO9+4F; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hJjO9+4F"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5dBVRnhidfoLU0S8715OX6iAUkqOyaPiamhb8ngMZXI=; b=hJjO9+4FjNWbEBh6E58MJ+kxOQ
	YF6bvl0T6o6Pp5MW6vxfCpjHHYYIX8/gOKzUKNeW7P8u6yEV3isiT7f7QsjtDdgHWHNxl3uwFa0eL
	MrvF5Z8cTdJAr9OL9zwkjgcJKlgxnrIOeLMxUvH6Nvvvwv+Q6NTcNdN6ssFPyZnNa2PsWV9SCuGkW
	OX7GzMLlSNDmXAT43ySSvc8/eXJpAD1kCh1L8ZXJ73Spq8NrDnb51+JBhqet0JCj+wIbQyWb45jSt
	EsYQsKFJUbH1lRowE+nD20TGykfyD+IBq1q6LHEhF3b4+QpoqCbNd0WKVuVbh9RnvUVNxIXc4t/Og
	OJhxaKGA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwymx-0000000FEuL-1rph;
	Thu, 20 Aug 2026 09:10:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E2309301BDE; Thu, 20 Aug 2026 11:10:18 +0200 (CEST)
Date: Thu, 20 Aug 2026 11:10:18 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fuse: permit freezing while waiting for request answer
Message-ID: <20260820091018.GA4120091@noisy.programming.kicks-ass.net>
References: <20260819023542.561653-1-senozhatsky@chromium.org>
 <CAJfpegu2wOG85R6KSvCwHOuxe2fWczA1KbrFcCZz=ofUch4K=w@mail.gmail.com>
 <20260820084933.GA4036497@noisy.programming.kicks-ass.net>
 <aobDGgivy43cz7xQ@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aobDGgivy43cz7xQ@google.com>

On Thu, Aug 20, 2026 at 06:07:18PM +0900, Sergey Senozhatsky wrote:
> On (26/08/20 10:49), Peter Zijlstra wrote:
> > Message-ID: <20260820084933.GA4036497@noisy.programming.kicks-ass.net>
> > 
> > On Wed, Aug 19, 2026 at 12:03:32PM +0200, Miklos Szeredi wrote:
> > > Why is this unsafe exactly?  Does that unsafeness apply to
> > > filesystems?  If so why do we allow freezing while blocked on
> > > sb_start_write()?
> > 
> > Getting frozen with lock A held, while another task is blocked on A in
> > an unfreezable state results in the system not being freezable.
> 
> Right, but then the system says "suspend failed" (tasks refuse to freeze
> after 20sec) and just thaws everything back in?

People don't like suspend failing. People like to close their lid, throw
laptop in bag, and expect laptop to not cook itself to death.

