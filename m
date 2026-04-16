Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56585314A8D;
	Thu, 16 Apr 2026 17:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776362320; cv=none; b=gIBUJrK+a6L5aT2rkR+s5R8PScM4fBrlOk6KYj92wNC8WvV6TH3DQ4j/bAyNlxYGnu09Bq1oNTtAQH0oVnX0WI+5mnRL6KWWOJNo79QxkvebdC78Yu+LNB8L9ts/oWgv95dJf8yUN/rSU1vg1S5tosWDjLFVCkSqSJp2cOMwEHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776362320; c=relaxed/simple;
	bh=BgGNQ+kg+PMcTmbwTcJ94wixg6gzwPdyPkcDKJiuCLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obi4JITs58DuOXd3WkIMwF1aT3XAAXQwM8pNhL3dGEZdtVxDxKIGnAMCxbB+yodtt3WSj4wvUpBVJldnit3TTaA4ZuessxZUR7WEskhaqwmtZg/7PTLySzvObBXQ0wenDxoLMCv+PCLILiZKw+3KKno3uYooCLW3ZWTGxqI7bu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W7vSzFZ0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W7vSzFZ0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lJRRddWkYSALa0B6GSWFZ3ZeCBLOx02UZufpyBXheIs=; b=W7vSzFZ0BBGM7+i+x9PUT7gKhe
	jPD3siMA85ibGG/JGILBT1ddf3YoQPK7fRTVInbjKF4FQJBc11khwjd23Rp6J2iG/8qt/kh8llS1o
	ap5pbJLgDrs1IVciGeLTgxin2oNQqMTBYlgbaxrIXbvmPvNxZra5KHy4bBvM+TV8cH6GkcjK3a+4v
	ZNNM4dmKA3clrYTWt1OQ9Cnb7Z4pOyzPt+avTRg7EQyJ9hi8vLKbaoowF3ds+rKBG8PrqwwGeGYN4
	/RgycR1C+ELH5qfHtyQUWcBcp4kQnwCFWbuLEKsNdWEfDGMMUsAn2uQ3B1MbL/rp6UAzeu62JEVOL
	5ge3LqHw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDQz0-00000001zKZ-2xpR;
	Thu, 16 Apr 2026 17:58:30 +0000
Date: Thu, 16 Apr 2026 18:58:30 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Barry Song <baohua@kernel.org>
Cc: Anatoly Stepanov <stepanov.anatoly@huawei.com>,
	akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org,
	Liam.Howlett@oracle.com, vbabka@kernel.org, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, wangkefeng.wang@huawei.com,
	yanquanmin1@huawei.com, zuoze1@huawei.com, artem.kuzin@huawei.com,
	gutierrez.asier@huawei-partners.com, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] filemap: use high-order folios in filemap sync RA
Message-ID: <aeEjRtNbQI71I0wA@casper.infradead.org>
References: <20260415192853.3470423-1-stepanov.anatoly@huawei.com>
 <20260415192853.3470423-3-stepanov.anatoly@huawei.com>
 <CAGsJ_4yBmrFDHLg8Cf7x0dCLELBp+kY6yoMuP_sHt4Z1wuVrBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4yBmrFDHLg8Cf7x0dCLELBp+kY6yoMuP_sHt4Z1wuVrBg@mail.gmail.com>

On Thu, Apr 16, 2026 at 01:30:32PM +0800, Barry Song wrote:
> > Or introduce some dedicated tunable like "sync_mmap_order".
> 
> I guess we could benefit from a small order, such as 1 or 2.
> Order 4 is really too large for many systems, such as Android.
> 
> But it seems Matthew never likes new control knobs?

Correct.  It moves the burden to the sysadmin.  And either there isn't
one (eg Android), or the sysadmin does not have enough information to
set it correctly, and doesn't have the time to know that it even exists.

We need to be self-tuning.  There's no other way.

Now, that control loop could run in user-space.  And if it does, then
we'd need the kernel to expose a control knob for the daemon to tweak.
But then the daemon has to come first, not the control knob with a vague
promise of a daemon to appear in future.  Preferably it's part of some
userspace collection of utilities that already exists like util-linux
or systemd, so we're not relying on people finding & installing some
new thing (that again they won't know they need).

THPs in particular have accumulated way too much cruft over the years,
and there's a huge amount of misinformation floating around on random
webpages about how to configure them.  I think we'd be much better off
just ignoring all of the knobs that we've put in.
