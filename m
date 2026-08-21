Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96893769F6;
	Fri, 21 Aug 2026 03:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787283012; cv=none; b=SJ9f7LvH9jgLAT76x0ZlYXftev0ajWHwI1Vrqborx21JZ5p+g5tlUlLHYOnlGy8srVMQ0scahjmVeQ2d/Ekx1TsjfqkwNx7jUAVvpeMgbJY2eHhNjeEN9ik+LGYVOvwBt6VPnGugxo7eE1EpVInFkgDIZRDbrugE1GxDsqy8wk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787283012; c=relaxed/simple;
	bh=eLklAYg4gvR8mdd/CHUq/T4LlpE+Dn6ZlawEMf6/W0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WcaHRHePtB9miNFhl3tjaFpRHOk9rUV6LQULfxaHdXiL1sXpO+c0XyukB3dFl+2kKjOQr3SV7CymEW7Fa9sI6YVfLnU1ZpYjOP2IYj0O87qj5b7uWTPHxMrPOunzd+OGnA5whN8J50606nOi+5ntW+pjOrjvqWoYdoleAbE4mLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tTOV7oag; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tTOV7oag"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=JyBcECjGqB6YkJ8I2MHh23SUvivGmImufXpX35W4aEk=; b=tTOV7oagZmw4c61HKLFUVhiIlo
	IQ9AB3Ko1UOtHTeV/Ir4hjgTFOXlmpn/lYREXaz+4Twk7oYQqTLbWCyiKRs81m4i/jvOjivEtovVi
	92QgQDFU3fYPhdsG3XTofZ+ORQpB5dCaY5TZfQuCcLNOdfMbl3Jgs9MZitQI4jVLOGmmIn29JzPhW
	QU1zN5Oh/QiD7AiYKY2P0A1YU+OZ1cGw/T+OTmc3qoo/xvJgFNlbQUKQZUtrh7gJdR6qI59scZY6t
	EthXa4SrIF8H1ikALpaD3KPJXGOFXD71ogVqbcvZVbXPzb7fASdym4L6FZNatv92jHqjQ2NWxdl+G
	TtNoZG3Q==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxFxB-0000000GhCP-3R9h;
	Fri, 21 Aug 2026 03:30:01 +0000
Date: Fri, 21 Aug 2026 04:30:01 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Wenjie Qi <qwjhust@gmail.com>
Cc: akpm@linux-foundation.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, baohua@kernel.org,
	Wenjie Qi <qiwenjie@xiaomi.com>
Subject: Re: [PATCH] mm: filemap: tighten dropbehind completion context check
Message-ID: <aofGOQB4TViwQQQ7@casper.infradead.org>
References: <20260820142956.1414337-1-qiwenjie@xiaomi.com>
 <aocQcaMMU7-rfn3e@casper.infradead.org>
 <CAGFpFsRarmDScAQxHpCtSZxK5H4WCg4Y=y0hXQLjGT804ZoWkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGFpFsRarmDScAQxHpCtSZxK5H4WCg4Y=y0hXQLjGT804ZoWkw@mail.gmail.com>

On Fri, Aug 21, 2026 at 09:23:12AM +0800, Wenjie Qi wrote:
> This is based on code examination; I have not reproduced it in
>   folio_end_dropbehind().
>   There is an analogous EROFS report where bio completion ran under an RCU
>   read-side critical section and hit a sleeping-function warning even though
>   in_atomic() and preempt_count were both zero:
> 
>   https://lore.kernel.org/r/20230621220848.3379029-1-dhavale@google.com
> 
>   That is not a reproducer for this path, but it shows why task context alone
>   does not establish that sleeping is safe. Here, folio_unmap_invalidate() can
>   reach unmap_mapping_folio(), which takes mapping->i_mmap_rwsem through
>   i_mmap_lock_read(). I noticed the mismatch while comparing this path with
>   the stricter bio_in_atomic() check used by the block dropbehind work.

So your analysis is right as far as it goes.  But if a folio has
been marked as dropbehind, but was then mmaped, we clearly shouldn't
be discarding it!  I believe that we'll clear the dropbehind flag in
__filemap_get_folio_mpol(), called from filemap_get_folio() called from
filemap_fault().

If you can find a way to get a folio with both dropbehind & mapped set,
I'm interested in hearing how.

> On Thu, Aug 20, 2026 at 10:34 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Thu, Aug 20, 2026 at 10:29:56PM +0800, Wenjie Qi wrote:
> > > folio_end_dropbehind() uses in_task() to keep folio invalidation out of
> > > interrupt context. Task context alone is not sufficient: preemption can
> > > still be disabled, or the task can be in a preemptible RCU read-side
> > > critical section, while filemap_end_dropbehind() may reach
> > > folio_unmap_invalidate() and sleep.
> > >
> > > Use the established conservative three-part atomic-context test: reject
> > > preemptible RCU read-side sections, reject configurations without
> > > PREEMPT_COUNT, and otherwise require a preemptible context. Unsafe
> > > completions retain the existing best-effort behavior and skip invalidation.
> >
> > Have you seen this happen in practice, or is this based on code
> > examination?
