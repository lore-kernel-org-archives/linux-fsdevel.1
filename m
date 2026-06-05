Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337883845A6;
	Fri,  5 Jun 2026 16:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780678777; cv=none; b=FGVCylTcIupk1q6Tkelm6yu/i1cpl+yvETH1esoapddjrkdivghyPcAEB2pG84r4WR71PTB5Z0QAC2gjmkrNrc6AklFig3Iim9G1yHCJiXFOYB73XeEl9HucLbw86vkzM6v+RlLTlNHFylHk3CiLUkirttZzjpv8Wzd4yTYl3Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780678777; c=relaxed/simple;
	bh=Sp7kIAouqrVBGkZlB5n5AcCoGDET3LuOOuYwoq76BhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4Qx7tm1E28yIQhSWH8snLSGrkVDuSl6Yxwo97Lx7WyQTP97o6lXJLN20ShG62mY7CVPgiGhUozo5Ku7zfneNzli1ZaGycmL0cghgq/Slfy+Pf6gfne5sMl4Vj6U4J8yDu+8iumYNiEuH+FAGboXZtmZvepHRfiQufruM21UBHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B0jWb1Sq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B0jWb1Sq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=7XmqSOwi8v9FGoAwYYe6tCp3ObjfaDSD7+XFE44fObs=; b=B0jWb1SqcT1a/41p/bqOMsn3XP
	pTkbjbIzENcp0nq+KErY2r74UoTorLID5w94z+JGPIxRUEZrY+YifQQZsYTmSzcDhtmYeQcJxLJ9s
	JmxKnltkM+/zO40VDAz3TTYIz+JMlgWQF08YQfmbE5hzbH1z8zE2NNdMJhyu/lmNsYlFqqGCGmjn5
	VwRho9czLiBESGqnKmZDC5wj/1HMFeelOhMYiMkQ+7NcUbrWae7a5ppLHTJPI///zQFKQZjfuPp9B
	k6xDbrBbW0Jrg1yluUzrHcfWpqHvUOnav7EeD+ofMuuBLgyHvDnyCXZ6kvYo0gm+xrB0y67ss86tI
	c7vbH9Tw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVXtJ-00000008GbQ-1NNI;
	Fri, 05 Jun 2026 16:59:29 +0000
Date: Fri, 5 Jun 2026 17:59:29 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Fabian Frederick <fabf@skynet.be>,
	open list <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: efs: Fix compilation bug and use pr_debug()
Message-ID: <aiMAcSooHzy0TMCN@casper.infradead.org>
References: <20260604202441.65226-1-m32285159@gmail.com>
 <20260604143040.61f70396c568b7433110fb3d@linux-foundation.org>
 <CAKqfh0Eu=sp3rfAGzhTPcx1Vw5p=sjxTigAWhkzskYrAWB9iWQ@mail.gmail.com>
 <20260604195355.c2446336f3f8cdefabadc697@linux-foundation.org>
 <CAKqfh0GR1EbuxTcuTnUUS34QLiinkD7TPCCEqpd-8oS3S824ow@mail.gmail.com>
 <aiJCJNgm6pYKgqbn@casper.infradead.org>
 <CAKqfh0FFB0EkTAh-+6uK0aNqWVZhdwMpP5-Nnz4GEoWYXQM3Dw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKqfh0FFB0EkTAh-+6uK0aNqWVZhdwMpP5-Nnz4GEoWYXQM3Dw@mail.gmail.com>

On Thu, Jun 04, 2026 at 10:33:10PM -0500, Maxwell Doose wrote:
> On Thu, Jun 4, 2026 at 10:27 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Thu, Jun 04, 2026 at 10:16:44PM -0500, Maxwell Doose wrote:
> > > ps: I noticed this was listed as an orphan in MAINTAINERS. I'd be
> > > happy to step up and maintain this, I've got a bit of experience
> > > maintaining stuff in iio. Hopefully this isn't too far-fetched!
> >
> > I'd be just as happy to see it deleted.  efs was succeeded by XFS in
> > the mid-90s.  The last efs filesystem I personally saw was in 1999 (an
> > SGI Freeware CD).  If there's any filesystem crying out to be converted
> > to FUSE and removed from the kernel, this is it.
> 
> I guess that is a fair point. But given the fact that we quite
> literally just found a compile-time bug I think there may be further
> underlying issues that need to be resolved before conversion to FUSE
> :/

I'd argue that shows the exact opposite.  efs just isn't useful any more.
While looking up some information on Wikipedia, I discovered that XFS
filesystems from SGI used v2 of the directory format.  Linux no longer
supports anything from before v4 (and even that is now under a CONFIG
option).  So we're in the weird situation where SGI filesystems from
1992 are readable in Linux, but SGI filesystems from 1995 are not.

