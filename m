Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0611470808
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 23:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771631123; cv=none; b=pSer1TBvzBbmblTTRmVmBYTyql6JJQMsri1GIcoIjIyuy2KH6gHQS4j0WE97AeFEL5cgOE2kNG4FQvnwX41nh1yzvk2OHkjIf8j+ifPafU96hNfaaQm7N9QHNPA9ZnZCSRIWxI3fu68H5UsyAQrSSuyB5JSQPIdmPJO/npAvkBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771631123; c=relaxed/simple;
	bh=NUa0ZvWk81Un3U+HrnS3fk9ftpj1C3nw66+Wpf5Earg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GAEXySFHAXjJjVO48HClIl1iRXfL0dXBJ+5hD2Br3rPufZ73mDHiGEmLCe/PdYkkLwo0YXNEgR04YHjk/MHOOo739uMtCjx1V8n6/LFPY8k0RDo2zISSoCytMGP4gKQN4rsF5nvSGDjPu+QnW+DI1vxaK+O8LE8Cqbpt5N6cMuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=teiNMy/J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="teiNMy/J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3C9C116C6;
	Fri, 20 Feb 2026 23:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771631122;
	bh=NUa0ZvWk81Un3U+HrnS3fk9ftpj1C3nw66+Wpf5Earg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=teiNMy/JIhvfqh8gXH7ek4Hp+9fZ6tCWb22lVxlsRPU1MvJRHcNlHWMI7MIkURnY/
	 LkkdgGH89767ULkijKxc1U58DXtTEBc6iQDKP4qLR5d49vmcRTAmKgroniaNoF58Yp
	 nSuLgxhy20j0I+V8zsdcFyDjqbMAI2g3SPkra4OAP07lSyS3lihgY/obLbMz9AFxQA
	 P8cDWtueS1pORJx5JRBwoYYPMtJve4a6M6oEofTDhVu2wcI4aV4BTbTka2T5NCkE7E
	 wKKkYO3/LqlJJpK+geDtdBbvakhcw5x4xzZKYs9U1dNTts8mu88HjsSydn8fg5/TrU
	 hH3rFojr6O3uA==
Date: Fri, 20 Feb 2026 15:45:21 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, brauner@kernel.org,
	wegao@suse.com, sashal@kernel.org, hch@infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] iomap: don't mark folio uptodate if read IO has
 bytes pending
Message-ID: <20260220234521.GA11069@frogsfrogsfrogs>
References: <20260219003911.344478-1-joannelkoong@gmail.com>
 <20260219003911.344478-2-joannelkoong@gmail.com>
 <20260219024534.GN6467@frogsfrogsfrogs>
 <aZaQO0jQaZXakwOA@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZaQO0jQaZXakwOA@casper.infradead.org>

On Thu, Feb 19, 2026 at 04:23:23AM +0000, Matthew Wilcox wrote:
> On Wed, Feb 18, 2026 at 06:45:34PM -0800, Darrick J. Wong wrote:
> > On Wed, Feb 18, 2026 at 04:39:11PM -0800, Joanne Koong wrote:
> > > If a folio has ifs metadata attached to it and the folio is partially
> > > read in through an async IO helper with the rest of it then being read
> > > in through post-EOF zeroing or as inline data, and the helper
> > > successfully finishes the read first, then post-EOF zeroing / reading
> > > inline will mark the folio as uptodate in iomap_set_range_uptodate().
> > > 
> > > This is a problem because when the read completion path later calls
> > > iomap_read_end(), it will call folio_end_read(), which sets the uptodate
> > > bit using XOR semantics. Calling folio_end_read() on a folio that was
> > > already marked uptodate clears the uptodate bit.
> > 
> > Aha, I wondered if that xor thing was going to come back to bite us.
> 
> This isn't "the xor thing has come back to bite us".  This is "the iomap
> code is now too complicated and I cannot figure out how to explain to
> Joanne that there's really a simple way to do this".
> 
> I'm going to have to set aside my current projects and redo the iomap
> readahead/read_folio code myself, aren't I?

<willy and I had a chat; this is a clumsy non-AI summary of it>

I started looking at folio read state management in iomap, and made a
few observations that (I hope) match what willy's grumpy about.

There are three ways that iomap can be reading into the pagecache:
a) async ->readahead,
b) synchronous ->read_folio (page faults), and
c) synchronous ->read_folio_range (pagecache write).

(Note that (b) can call a different ->read_folio_range than (c), though
all implementations seem to have the same function)

All three of these IO paths share the behavior that they try to fill out
the folio's contents and set the corresponding folio/ifs uptodate bits
if that succeeds.  Folio contents can come from anywhere, whether it's:

i) zeroing memory,
ii) copying from an inlinedata buffer, or
iii) asynchronously fetching the contents from somewhere

In the case of (c) above, if the read fails then we fail the write, and
if the read succeeds then we start copying to the pagecache.

However, (a) and (b) have this additional read_bytes_pending field in
the ifs that implements some extra tracking.  AFAICT the purpose of this
field is to ensure that we don't call folio_end_read prematurely if
there's an async read in progress.  This can happen if iomap_iter
returns a negative errno on a partially processed folio, I think?

read_bytes_pending is initialized to the folio_size() at the start of a
read and subtracted from when parts of the folio are supplied, whether
that's synchronous zeroing or asynchronous read ioend completion.  When
the field reaches zero, we can then call folio_end_read().

But then there are twists, like the fact that we only call
iomap_read_init() to set read_bytes_pending if we decide to do an
asynchronous read.  Or that iomap_read_end and iomap_finish_folio_read
have awfully similar code.  I think in the case of (i) and (ii) we also
don't touch read_pending_bytes at all, and merely set the uptodate bits?

This is confusing to me.  It would be more straightforward (I think) if
we just did it for all cases instead of adding more conditionals.  IOWs,
how hard would it be to consolidate the read code so that there's one
function that iomap calls when it has filled out part of a folio.  Is
that possible, even though we shouldn't be calling folio_end_read during
a pagecache write?

At the end of the day, however, there's a bug in Linus' tree and we need
to fix it, so Joanne's patch is a sufficient bandaid until we can go
clean this up.

--D
