Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6981A9F91;
	Tue, 17 Feb 2026 05:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771306587; cv=none; b=BqznZvBYBzrGpZeZlm/f2BKwIEqijSJ5ScMh9SlTzdNU28tVD992tkSfHkw9zJZCSFUeUgYaSIeYGi4Ge2lIFmwWsgclhBG9Hzjzo46KD5hLSha6C5mhY9OIPzOVg59QX69rV7tdNU97jig5UeVc+cVZEKBDwRjGLXsrsx6Q76s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771306587; c=relaxed/simple;
	bh=Vw1yWF0Y4bPZu/NH62MxUlVYzxnY8/zuN6APZzd3cr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ghq3iByGR5x1V6BD6Uu1kl3UEJtYObQdf6iYngTrb6/DlDTps25p/1ZjnCIFvw82lsju3ObNFE7kPjVl+zOMAYRCzPvHeIFPAL3kL/ja2ANWSq0pxpCcKlKjy6omxVk4nw7BuobBTeEWeyJmEiL7ydqddj0jWdz33JiA903Bvco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3OXEl1VB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3OXEl1VB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oUQd9aN1YNBwK0GRI+zqCnDPDmHN4dFR3i34SLyEQnM=; b=3OXEl1VBLrOHijeRAD7VI3lMfQ
	Cpgb3Mg3Gc2RQLyXOxxwIobsVsAAYJfMIJG9W/ketJBmeyfCBOeNv2XvoA8X/p5CNadtxEfaFei3q
	37xEDroiFdq4W1Dd8+fOqZ+g4ZIzEfjSZJnLdCcun4RQt0W08KidCpQkXz/dKCBB7ZXd67Cd4vRfI
	iWRoCo3qnuhevqmU4+NKVthLbRMe4GO9FWLr0fycnwy4l/+7fuY7yeLo/uNrPGAUUbWpbbutWgQ9N
	HCCuEbqQ0fWKstEdO9Lnqwjbnw7h6mbIO0sd8tr2Ujb7mtWaL+wjX9p5pe7wWTfhUQyCS35i1/v/Y
	Ii1SsKDw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsDky-00000007eLL-2Ka6;
	Tue, 17 Feb 2026 05:36:20 +0000
Date: Mon, 16 Feb 2026 21:36:20 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
	io-uring@vger.kernel.org, csander@purestorage.com, krisman@suse.de,
	bernd@bsbernd.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1 03/11] io_uring/kbuf: add support for kernel-managed
 buffer rings
Message-ID: <aZP-VOoX1OyuVQ3B@infradead.org>
References: <89c75fc1-2def-4681-a790-78b12b45478a@gmail.com>
 <CAJnrk1ZZyYmwtzcHAnv2x8rt=ZVsz7CXCVV6jtgMMDZytyxp3A@mail.gmail.com>
 <1c657f67-0862-4e13-9c71-7217aeecef61@gmail.com>
 <CAJnrk1YXmxqUnT561-J7seaicxFRJTyJ=F3_MX1rmtAROC6Ybg@mail.gmail.com>
 <aY2mdLkqPM0KfPMC@infradead.org>
 <809cd04b-007b-46c6-9418-161e757e0e80@gmail.com>
 <CAJnrk1Y6YSw6Rkdh==RfL==n4qEYrrTcdbbS32sBn12jaCoeXg@mail.gmail.com>
 <aY7ScyJOp4zqKJO7@infradead.org>
 <7c241b57-95d4-4d58-8cd3-369751f17df1@gmail.com>
 <CAJnrk1b2BHwBzz+AS7x0WuJSpf98x1xGhf1ys2rm4Ffb0_5TOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1b2BHwBzz+AS7x0WuJSpf98x1xGhf1ys2rm4Ffb0_5TOA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Feb 13, 2026 at 11:09:13AM -0800, Joanne Koong wrote:
> 
> I think the circular buffer will be useful for Christoph's use case in
> the same way it'll be useful for fuse's. The read payload could be
> differently sized across requests, so it's a lot of wasted space to
> have to allocate a buffer large enough to support the max-size request
> per entry in the io_ring.

Yes.

> With using a circular buffer, buffers have a
> way to be shared across entries, which means we can significantly
> reduce how much memory needs to be allocated.

Or enable such flexible use cases at all.

