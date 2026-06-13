Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44992BD0B
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jun 2026 16:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781367342; cv=none; b=Sk/kxLx3htAg6iKzxjTTy85w5LblO7pu/rha6ISUXQCKWvBJSsVTTKSFgrrdTuk+4zAK6nHz0PqCA0UOpbU+lMZuoJGzCi55uJuDOxgJXza/oECQGN4hN+gYEPsjbpQ/6XJ13uBcqbmYI/DQ9q3EmB5AtHEvzVoAwcouGvLUT6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781367342; c=relaxed/simple;
	bh=tIcNE8IgBuSZcM5Ws6JuVq47MAnkqV+zi3LY1aRzvkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=up7Kn+Q3Eh+HWTTnfb2TlkzZL5lzhwZPzR8vaOgFhzwZpnAslpUqRBV6ilZQ9+nxi7OgN/lcnDYdeV2D4FZZ5AX0C/jog6RySaqTnokKq4YssMhYnj7/sXctMreh9HTegm3CaUSw7I95M+RpVSROYJn0CyadqGd4ElR8SpwA/VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NxCGY0uv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NxCGY0uv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=JFSLvO6lacXDS1M4MjlvSD3QCJFp6gqwb5JykZl1KsU=; b=NxCGY0uvjFzYhSjwQECIASiSA7
	Qpk5qinecD5gVkrLZLtQGNry9rQ/Y7gb3xnypGXHETOo8lipL5YMo+zhwA58AAZ7bQjQIyXCDXPw1
	1HvKForhY89Lbdgpo3M0obRyUobmObSJq0G7vkrjtu9/Exz3KIMyRmjdhGBG6wTnLCRd+F1FvA/BY
	IpVEmmoofWHCRVrzXYmzOiEfqqtAZibNgQ2ygAR6r6hDhnWwLL2+3+dsrOcIEXsWSoM0D/+GbvWRP
	swPIrWnqOSrGth2D0Ns8JCKjLuNwI8D3rmzIK2TBrAlkldTtV4SQY8QubgarreBQfXUIg5j2YHy9A
	CG1n4sZw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYR16-00000005jo2-1uBj;
	Sat, 13 Jun 2026 16:15:28 +0000
Date: Sat, 13 Jun 2026 17:15:28 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Ye Liu <ye.liu@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 5/6] show_page_info: Remove printing of page index
Message-ID: <ai2CIGzlCeqbOz5o@casper.infradead.org>
References: <20260608210618.3437216-1-willy@infradead.org>
 <20260608210618.3437216-6-willy@infradead.org>
 <20a5a752-3ed6-4fde-96c9-e8369b15524c@linux.dev>
 <ainCu2HZTTdP4skd@casper.infradead.org>
 <11cc4dca-7841-4897-8665-e27d7555f246@linux.dev>
 <aizL_QrL4dNWMJ8Y@casper.infradead.org>
 <661b47de-af1a-488f-a691-82df7add1f49@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <661b47de-af1a-488f-a691-82df7add1f49@linux.dev>

On Sat, Jun 13, 2026 at 12:16:38PM +0800, Ye Liu wrote:
> 在 2026/6/13 11:18, Matthew Wilcox 写道:
> > On Sat, Jun 13, 2026 at 11:02:06AM +0800, Ye Liu wrote:
> >> 在 2026/6/11 04:02, Matthew Wilcox 写道:
> >>> Thanks, but could you explain why you don't just call dump_page()?
> >>> It's more comprehensive and will continue to be maintained.
> >>
> >> This script is based on the drgn tool, but the drgn tool does not
> >> have a dump_page helper. What kind of method do you mean by      
> >> directly calling it?                                             
> > 
> > void dump_page(const struct page *page, const char *reason)
> > 
> > in mm/debug.c
> 
> I’m aware of this kernel function, but could you please clarify
> how to call it from a user program?               
> Or how to achieve the direct call you mentioned?

https://drgn.readthedocs.io/en/latest/release_highlights/0.0.28.html
