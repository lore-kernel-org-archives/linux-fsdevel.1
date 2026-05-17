Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528AD3D544;
	Sun, 17 May 2026 01:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778980648; cv=none; b=Mk7gl3gkQd4Af3JykhY8BfAOij0Z1mzsFMl5pH/YBxLgou1GM0sy+sx9+Wb3MGkW5ZX0ml3HPKMNX9q8LFGv3BDbc+ZXEufUp+rx7w+ZD7Bs+cxI9kan4u39NemObw1whIQjAZ5LNMIEWTDeEUbsuQfcJ17O98VppP4LTG1vGT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778980648; c=relaxed/simple;
	bh=hsjpNms4GfV/K3VFCwe1cH1ZSgVqAW+2x1s9kat+y2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=szf5ZB4Z7XzXGwVYcuHR4scYbP02pOhyB+QKTGM6fkh0/R8Af0aY88/QPdbxZCTnHUhqZXVUG9fLk/NTrLiYOjFQrQZr1JS3HtwY2BYPZ4ps2A33yF7LJXwlpY8hLEquwP7t7NPKUCS1ZCW5vOLhsH+nIaeCIMHdBdjQeGLt+UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NEIkA09J; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NEIkA09J"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LVUG8R5Ol9Z00xWIgbyWnXRAWw9NOhAMo2nx4jxBrzs=; b=NEIkA09JHKS9iHhK0PDstOLAJO
	4poRQS5PydOp8NktO4wEHxTzKNjRva5w8io/rxe2FsWL3YtxOghY8Oo2pdvfLxly8tPAesorhx46+
	kBkEir8UkvP/0fZIPx5yI7PQdkxJXyWVGotQp411XAYLHBKwVJ7XYsM0ZFHteLRL0fWsXs/h9nStF
	oFwL81QvgpeJyeNCwUNJ6leYrobO0eIZLozBayzGXHImu0V9sbp05l4yRWuGYHAPB45U24EUJhRRp
	LD64IU0RhL5jmZLRLp5KIaVqYtCgJaPtUX4gQ/Kh7w2+Hn7UUbxe6/GpuNcZfxv9gW0dC/2hU93mc
	47EgUjeQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOQ86-00000003OQn-1PpD;
	Sun, 17 May 2026 01:17:18 +0000
Date: Sun, 17 May 2026 02:17:18 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-hardening@vger.kernel.org,
	Kees Cook <kees@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [RFC PATCH] fs/splice: allow for a way to block splice() with
 read-only files
Message-ID: <agkXHu_ON_KyWtvP@casper.infradead.org>
References: <20260516182126.530498-1-pfalcato@suse.de>
 <agj4mXKRVW44ZJ18@casper.infradead.org>
 <agkRpj4oU8TPgmTS@pedro-suse.lan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agkRpj4oU8TPgmTS@pedro-suse.lan>

On Sun, May 17, 2026 at 01:59:41AM +0100, Pedro Falcato wrote:
> On Sun, May 17, 2026 at 12:07:05AM +0100, Matthew Wilcox wrote:
> > On Sat, May 16, 2026 at 07:21:26PM +0100, Pedro Falcato wrote:
> > > +static bool may_write_to_page(struct page *page, struct address_space **plast)
> > > +{
> > > +	struct folio *folio = page_folio(page);
> > > +	struct address_space *mapping, *last = *plast;
> > > +	struct inode *inode;
> > > +	bool may = false;
> > > +
> > > +	if (!READ_ONCE(sysctl_splice_needs_write))
> > > +		return true;
> > > +	/*
> > > +	 * Always fine to write to anon folios.
> > > +	 */
> > > +	if (folio_test_anon(folio))
> > > +		return true;
> > 
> > What about KSM?  It's not something we've seen attacked yet, but it'd be
> > pretty nasty to be able to change a KSM page in another process.
> 
> It's my understanding that only anon pages can be KSM'd, and KSM still keeps
> the FOLIO_MAPPING_ANON bit set. So folio_test_anon() should still test true
> for those.

I think you misunderstood what I meant.  If we have a buggy user which
can write to read-only file pages, then it should also be prevented from
writing to KSM pages.

