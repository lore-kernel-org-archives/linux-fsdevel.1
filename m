Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F51361663
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 14:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779892301; cv=none; b=d2jw3EWbNB70HGb0xHu2WetU0DP+FcQBw1xu+6+rj077IZyzRiDP+731HVJbcYbOwDQZLPWmmGv1Z4N9uiCfkR/opLTNzrOVeHGrzKtRilzXvC/wkoRw5Pm9l8vTS9Twurtn7BIjaGAoaStK+YDGIPVFqVjc9TJOJcMjqn9a788=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779892301; c=relaxed/simple;
	bh=lG0y35CyY1DeuQA4Gq6Mig5eFSiQamD/zEbat9hRM5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MunHSO3gqFrS4DOjV2YDYoumAFDggawCcjLmm7gVK0OcULQJpRwRX7kv5xPbpxHYwerBQ7rz/XHi2IHeG5XgvvXDASPG7/mj91pdPdCeegETcaBwaqGtULbu06nlAGPu2Ra/4yhpmoIu598XK68XNKqglMBVbDRNqLR9faGw+aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=J5GyVTJm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J5GyVTJm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=brV4/LmS0ckgHsvCp+uCOAYN3DgBnM4+WTdXgvNrbFI=; b=J5GyVTJmGAcFcjujCziZCrC3E9
	AQX36vyi+q+RAjvDBpreSvQMs0eMYXrUVyVNABGr7Pujb/PiXUzch/g9fpieLWbQEnwYAr2zsSjuS
	64nnfwG2hjsBUpr0cmQYvMkgx/z8Flfu1xVGoeDu4unf1RFmzC7o9/3gYmTPf9qrlRe173LZML8d6
	BYJjjEW3BpIeXloN2OgtQFY9LTfcg35Q0Q6d1UE59DDshWKwVuNONQPLjPM6uhvChYTxRtSUC6dJn
	cD+7TCJ1uD9D9SUkPxjWa0e6Z9WTtDoM4bddUb7Teb2eIRHGZaYBsNAl4k7AhrDRFgAKWtavKQTVV
	/UgI+RaQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSFIG-00000002etY-38Jz;
	Wed, 27 May 2026 14:31:36 +0000
Date: Wed, 27 May 2026 15:31:36 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/34] buffer: Add bh_end_read(), bh_end_write() and
 bh_end_async_write()
Message-ID: <ahcASLgTXUJL3uhN@casper.infradead.org>
References: <20260525171931.4144395-1-willy@infradead.org>
 <20260525171931.4144395-5-willy@infradead.org>
 <zkgzhy6i5tfkxxijrusi36tu6uxibwfh5vcbmo4f3tzsnbo4qf@vsz5ep3lcxpr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zkgzhy6i5tfkxxijrusi36tu6uxibwfh5vcbmo4f3tzsnbo4qf@vsz5ep3lcxpr>

On Wed, May 27, 2026 at 01:02:36PM +0200, Jan Kara wrote:
> On Mon 25-05-26 18:18:57, Matthew Wilcox (Oracle) wrote:
> > These are the bio versions of end_buffer_read_sync(),
> > end_buffer_write_sync() and end_buffer_async_write().
> > Also add the helper function bio_endio_bh().
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> One more suggestion for further cleanup that actually would make sense as
> part of this series: end_buffer_read_sync() and end_buffer_write_sync()
> drop bh reference which is acquired before submit_bh(). Holding this bh
> reference is a remnant from the old times where buffer lock bitlock was not
> a safe primitive to use to protect a structure from freeing. These days
> bitlocks are implemented in a way that they don't touch the lock after
> unlocking and so they are safe to be used to protect against freeing. So
> when touching all the places using end_buffer_read_sync() and
> end_buffer_write_sync() anyway, it would be nice to clean this up and
> remove these pointless refcount manipulations.

Ah, I did wonder about avoiding the bh_get/put, but wasn't sure what
demons might be lurking.  I think there were a couple of places where
I wasn't sure what the current get was, but we can always bh_put()
before submission instead of in the completion handler.  I'll make that
change.
