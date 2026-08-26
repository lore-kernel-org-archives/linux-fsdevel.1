Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBA52D949F;
	Wed, 26 Aug 2026 04:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787719223; cv=none; b=XStdRO/1vg5Ohv/aIvyMk+0281ts54g0UpCRpqq2Y7Le7v8pLFTRcQmawZOhnAqccG01EA0M7cxxjvdgnMwo8ZTuAz0TgMd5AJj/sEv0hjlHMuynQvYizX0YMFPGJhrQuC+YfCKGj3Urm4eRnWRRKNGDKirVig71Pw8ASuDLZHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787719223; c=relaxed/simple;
	bh=rbnxXlzusyU4DUcwC+ND9+vQQAbDhdLUTY4nmbnDm/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jr9rb3utJ0ZrpzR62Uyg2oIAReFJ2EYk9VnTKw2wqCIpLS8iRlAeAkMEDHqQGhgxgAk9I1ap3eFOKVhVWx1wHXMiUD7T89PChm+/tn5uorDqYcVxaZu0/CWaj7/+11HHfbE9kevEB6jYx75nD8PoOD4/LX5BD/UHqWfoWr7SEXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VoI+GkCl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VoI+GkCl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=p30MTcyBufrYNaiv6371E/aWtzY2AMPq8/F5SxBlSWY=; b=VoI+GkClDOoGUmjNfMfDHZlhB2
	D7aokuzXE2a9itGcHUTN7SKZVpdvicblAu9CiOSN0ZUHtM+yLyl+LpKAOjB7OBf4j0N2r0Ihw26Z0
	MnjagqaJRhN9ZAOu1ZPy8OmG077a7DNJibK3Pxpv2TwX0m4wOGBReWvOnQhhtZxa8EFFg9kSfuMVx
	r/4CeymiqvUyYNDZjvOHmBoOUJT5gRES+eFC3BBPFKYto8hpLyE1/XaiJ2HK+TRRI4GBSXWI9vdUA
	0JgF0nRBSMEYVbc7NOcgvwRKCaZ8BAZf4UXFwwyWn1n5rMkIAsrn0jWXkEklBqgGt1WG0ck55GC69
	e1HQxhLw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wz5Qx-00000001tNt-0oEC;
	Wed, 26 Aug 2026 04:40:19 +0000
Date: Tue, 25 Aug 2026 21:40:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: David Timber <dxdt@dev.snart.me>
Cc: Christoph Hellwig <hch@infradead.org>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] fat: add noflush mount option
Message-ID: <ao5uM1BFiwROcKsb@infradead.org>
References: <20260822173732.10230-1-dxdt@dev.snart.me>
 <ao0tUKyhsm1wNYCx@infradead.org>
 <aa36b1de-70d9-4234-a240-770fe66aa19b@dev.snart.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa36b1de-70d9-4234-a240-770fe66aa19b@dev.snart.me>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Aug 26, 2026 at 01:13:29PM +0900, David Timber wrote:
> It probably had something to do with DOS and/or Windows implementation,
> maybe a "monkey see, monkey do" situation. I think this is why FAT on
> Windows is quite slow to this day(again, I might be wrong so don't quote
> me on this).
> 
> Whoever first came up with the idea was probably worried too much about
> users(who are not familiar with UNIX systems) unplugging removable
> devices without giving the OS an opportunity to sync. I have to say
> that, compared to Windows' default behaviour, the default 5 seconds of
> vm.dirty_writeback is quite aggressive and that's why we have the flush
> option in the first place...
> 
> But I still think being able to flip the option on the fly should come
> in really handy in embedded systems that just can't afford to do
> explicit sync.

As I said, no objection to adding the option, but I think addressing
the root cause in addition would be very helpfu.

