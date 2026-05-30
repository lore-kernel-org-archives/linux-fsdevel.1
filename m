Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C0D329C6D;
	Sat, 30 May 2026 16:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780157730; cv=none; b=XCxrK/Bf2LwKe88l9HuGlLwKE54vnkUQArZPBkVBCU+sMhcgeG8we4g10DZhEH82FNeRAoG8/aEoDeRqqj/Wguw2d0oJiPlz8yCwNND1VaDCUiBUwihMlcy6jrqf050t3SHy421fD4d7JWdxxk0f1jr9WDgP4s78xxqCA8dFnLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780157730; c=relaxed/simple;
	bh=ZEjhVkTzEZe02lpF1D5FVpB0PktFr8q11+aU7ABZ8iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gDWCfR0zLuhgQkwjCaHNtsBr0hmmysulmH/eMh6jBAGqZK7mvo0ySjgdxKKJBH8zo8V15c9b9UH5DvwcBc4Az1MVJJOQ2a5/86zpC1zDqGr9L0P/e6ElTmFrgXg9zVTQOtPNCpwcghkGrHg4QjVVm0/rh/Bk2WeXbUxd+8Vc9Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jysGEgbq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jysGEgbq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OoUzWgK9VbS7ydruAlaYlubDCeG8VBUFAExW/DqXEFc=; b=jysGEgbqg/Z0nUgD7wTZmtRPQU
	N1+8o8aA4/veyX1X+ITuBZ/Df/7pSYKneKz0DdNY3pW81BEKUkVhzW0fFFj6ltI/9AHLCW2MuJ52q
	8KfCehwmjK91sN0/DQzrERIACHYkhKItx0w88Uc2h68vwynWtqlcC5uoNAENUOQWH3SWamiy2+am1
	3n/gFMeQQpCKev3mTl8A6TYNMZvcv7RmaxluHfx9pMkrgJ/nAVYng4XC6x186PkYuJR5r3qfymns5
	GNEQOSPg55uevIiDzBoQfEr00c4SZIPogfITIY27p6rDyiyA9g/wcc4IUhEsf6J7ZnIxx5CZSWpo5
	OKVZhSaA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTMLH-000000088qW-0TYY;
	Sat, 30 May 2026 16:15:19 +0000
Date: Sat, 30 May 2026 17:15:18 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev
Subject: Re: [PATCH v2 33/34] buffer: Change calling convention for
 end_buffer_read_sync()
Message-ID: <ahsNFkp_9q8PhLFc@casper.infradead.org>
References: <20260528173150.1093780-1-willy@infradead.org>
 <20260528173150.1093780-34-willy@infradead.org>
 <2lbdmkqnz62wulcq576mvhjwiirgky6vpyvpjwxkpm275qf7a4@zlkck3bcyqby>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2lbdmkqnz62wulcq576mvhjwiirgky6vpyvpjwxkpm275qf7a4@zlkck3bcyqby>

On Sat, May 30, 2026 at 02:07:40PM +0200, Jan Kara wrote:
> On Thu 28-05-26 18:31:46, Matthew Wilcox (Oracle) wrote:
> > Unify end_buffer_read_sync() and __end_buffer_read_notouch()
> > by requiring the caller put the refcount on the buffer.  The only caller
> > is in the gfs2_meta_read() path, and there we can put the refcount
> > after locking the buffer.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> It seems a bit sad to keep end_buffer_read_sync() alive only for gfs2
> metadata reading path but let's leave that for another time. Feel free to
> add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks!  I agree that we've got two entry points (end_buffer_read_sync()
and bh_end_async_write()) each with one caller, and I'd be happier if
we could make both of them go away.

I keep reminding myself that we'd be better off converting gfs2 to iomap
than improving buffer.c to fit gfs2's needs.

As far as I can tell (... and I am so not an expert in gfs2), the main
thing we'd need to add to iomap to handle gfs2_meta_aops is the ability to
set REQ_META | REQ_PRIO.  Maybe that's an AS_METADATA flag on the mapping?

But maybe there's code elsewhere in gfs2 that depends on there being
buffer heads for the metadata address_space folios?
