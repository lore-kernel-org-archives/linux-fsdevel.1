Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0164D3F412C;
	Thu, 20 Aug 2026 09:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787218457; cv=none; b=t9SlitOFPUHEv/gW+fs6tPfEK3x3vjI1iHbOJAh6VVQzQ0m3g9uIUsuq5/wJ7MuiKTo26NpnnnzJUmVIAoISNLSP60h75Bm1IQyLaabijeRxSVqKMa2xvAJwrx/FMv0TOAkAzpXOpaNfHV6wwgXu71ig1e4xpbSpCtW4iEH2luU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787218457; c=relaxed/simple;
	bh=kuWwDSw03PkgBTqOuH3meg65KlJAHazS/QjDMDaeRac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRe+3L/W1Jg8paMf1tzvBrR+CrnFkQW2hCO6eI0xbM83nO3Js4wwbzzMBu3HRZo2m20+4+GcqukId13Nw3g1u9Egs+z6yMCmTxStnUS7oLmM4ID0SQimQbYfHcJAaAZ5FotvAJzNdcHA0oP8HDYPzme/3WmOq854mQkYxeX5VPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W2tT8Bo1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W2tT8Bo1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=H7gCDzni55oVks7PNzXc86ACaW1ScSM8jXmXt53OjgU=; b=W2tT8Bo1dmu6Mq/TdWUZQCylad
	hLzajjRZ0Qi0QTtFGlSbEtIUoQ9V+k27wwd+Zsj2lDhS3+x1KODjF/HNEf6dADiNCrKpSVfA3YYtS
	sO65coxQqEiKSY1SV5GoIQIKSiNH6PCyZcupBYa5VY9/23+iYE4gRg6VdAvunXckt9Oz2aL13oJPL
	hxjU/91j/opQkihquYY9P+yWRu0HO2sMebtzA7juinaztZovm1M1x34HP5zOzukMd6JDHoc02tS/U
	0WkHwH4x0+qr+btRBZ8lma0/GJhCRjzot/cI7GtaTbyHWQIQoG0b5B0bEHafnRiLbh91VthXO8Zxo
	c6ig+cLw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwz9v-0000000FH1W-0Riq;
	Thu, 20 Aug 2026 09:34:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9E34D3006FA; Thu, 20 Aug 2026 11:34:02 +0200 (CEST)
Date: Thu, 20 Aug 2026 11:34:02 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fuse: permit freezing while waiting for request answer
Message-ID: <20260820093402.GB1837346@noisy.programming.kicks-ass.net>
References: <20260819023542.561653-1-senozhatsky@chromium.org>
 <CAJfpegu2wOG85R6KSvCwHOuxe2fWczA1KbrFcCZz=ofUch4K=w@mail.gmail.com>
 <20260820084933.GA4036497@noisy.programming.kicks-ass.net>
 <aobDGgivy43cz7xQ@google.com>
 <20260820091018.GA4120091@noisy.programming.kicks-ass.net>
 <aobGRjc7SE1rwIHu@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aobGRjc7SE1rwIHu@google.com>

On Thu, Aug 20, 2026 at 06:24:29PM +0900, Sergey Senozhatsky wrote:
> On (26/08/20 11:10), Peter Zijlstra wrote:
> > On Thu, Aug 20, 2026 at 06:07:18PM +0900, Sergey Senozhatsky wrote:
> > > On (26/08/20 10:49), Peter Zijlstra wrote:
> > > > Message-ID: <20260820084933.GA4036497@noisy.programming.kicks-ass.net>
> > > > 
> > > > On Wed, Aug 19, 2026 at 12:03:32PM +0200, Miklos Szeredi wrote:
> > > > > Why is this unsafe exactly?  Does that unsafeness apply to
> > > > > filesystems?  If so why do we allow freezing while blocked on
> > > > > sb_start_write()?
> > > > 
> > > > Getting frozen with lock A held, while another task is blocked on A in
> > > > an unfreezable state results in the system not being freezable.
> > > 
> > > Right, but then the system says "suspend failed" (tasks refuse to freeze
> > > after 20sec) and just thaws everything back in?
> > 
> > People don't like suspend failing. People like to close their lid, throw
> > laptop in bag, and expect laptop to not cook itself to death.
> 
> Sure, that's exactly the problem I'm looking at.  Throwing TASK_FREEZABLE
> addresses some of the cases.  Failing laptop suspend because of uncontended
> VFS lock is not an uncommon scenario for us.  Ideally, however, we need
> some sort of server/client aware suspend, maybe moving clients to cgroup C
> and server to cgroup S, and freezing those in strict order.  Or teaching PM
> that some tasks cannot be frozen in random order during suspend (e.g. a
> special flag PM_FREEZE_ME_LAST).
> 
> fuse is not the only subsystem that doesn't fit current random order suspend.
> Another troublemaker for us is notify, which basically has the same server/client
> architecture (where both sides are user-space processes).

Then propose patches creating freeze order.

PM_FREEZE_ME_LAST is going to be trouble I think, before long you'll
need PM_FREEZE_ME_REALLY_LAST or somesuch nonsense.

Using cgroups for this also doesn't sound right.
