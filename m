Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B652C21DD;
	Mon, 10 Aug 2026 03:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786334284; cv=none; b=CN/6/1NzR31OJPu1b8oJxW6kEQC7Us+crtvkop8oDwu3VeIBBfrUfddit+umg+vxVWMbyauPpzc5gFoYgW8eSsEMfc+aGw6nVGx+Cbsoczw5leK6PO33b0DswY2MrQW6yJFA21u8aCL8S802kSiTpl5+LI7dcHr6raERhn7kawY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786334284; c=relaxed/simple;
	bh=clHP3IDfl4IfUAR9zQps8eHApxZWDbbm44890vI2+yM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GyPGQYtQsoZKxDpH+K+YBaiTB6LyPAykq+QgHhuH3ZAqY6SYQLYWfcBGhNP3w59kIepwgW0yM962O8AP5VAECdlzyS9cyglsPpi2M11HMqcy/i6sVCRrowuFJzfWeZIlImHc6wbarfGbW8cRZ2VzLurXif0WtquLFVNZIL7clo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tYuBJESp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tYuBJESp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5cyYkN1EQ24tQxXyVZTOoGkVO8nl+cTo+yqYQ284NsA=; b=tYuBJESpdcm+Dv9QOEZSn22Too
	TnHBuP2jdAqn/HfzU2H5GjQUuAht7e0wO3h/CGvn/4Mzsbu1HXq21DlyH2sF6ieSbHUXubcNSEpr4
	PJOXDhspx92K0GiEzLRDclqoCVe071JPuEzrqff7ta0VO+GEbnN0Gn+5j7OfGHu0Qkqlmv01cpB/x
	ku9t2+CHPnW5FBz2GZ95NpIbEe5gn1B57HsnpxkDaNTRiE2d3iyr1+VeWfgfkdlBT68AM481nhSpx
	mt6nj7pyvJsBhkC1Q1OeIcTyr0b2dhCTYZlqrCszJbAJ1dUqopyU74yhC8wUVBaf5YACdR/dr7Vc9
	GK1heIYw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtH9A-0000000AEYp-2ots;
	Mon, 10 Aug 2026 03:57:56 +0000
Date: Mon, 10 Aug 2026 04:57:56 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Mike Marshall <hubcap@omnibond.com>,
	Martin Brandenburg <martin@omnibond.com>, devel@lists.orangefs.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] orangefs: use folio_pos() and folio_size() in
 orangefs_page_mkwrite()
Message-ID: <anlMRDG9xqB-DMMA@casper.infradead.org>
References: <20260809-orangefs-mkwrite-folio-v1-1-4978a4239475@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260809-orangefs-mkwrite-folio-v1-1-4978a4239475@columbia.edu>

On Sun, Aug 09, 2026 at 04:07:10PM -0400, Tal Zussman wrote:
> orangefs_page_mkwrite() records the faulted range with
> page_offset(vmf->page) and PAGE_SIZE, although the write range it sets
> is attached to the folio and the rest of the function already operates
> on folios. Use folio_pos() and folio_size() instead. This gets rid of
> two calls to page_offset(), removing two calls to compound_head().
> 
> No functional change. orangefs folios are always order-0, so the values
> are identical. However, if orangefs ever enables large folios, this
> change is necessary for correctness with the current write range
> tracking scheme. Tracking only a single page of a larger folio would
> leave the rest of the folio's dirty data outside the range that gets
> written back, leading to data loss.

Yeah, I agree.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
