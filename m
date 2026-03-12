Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74F9282F12;
	Thu, 12 Mar 2026 17:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773336410; cv=none; b=hjFrT67NOOwGkyrB6VYR/knvBMRd/rjocZF0OIx0Uk8+4eyFgwHwlKIwUdOq6JEXuKlKLUoyQy7zJjQu/lpBmsn3tYJYIW35+5xj2wAe7TdQpTlmN34DqJRWR9lDJ2xL8D64mxdkobvtFIJT/qw9GVq3TLhNfkf23/AbpkxPa38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773336410; c=relaxed/simple;
	bh=yCYXgj255oG7mUEQ4uPhvnymcpC+tIh9Q2Fiu8mJaik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVoxSrX0Cq2oOIaUnobaP/ipsHf9K/59sOACQj/IKYOgMNAEff+t+6XXtWPLEW663+nhhQ01dhTD5CEyYHt7muKQdn4vWMlVjmLXEE1fGeq6KlU0SeGLoR1yymDYBpNYC8YrhFO5WqJIxrTunLbdcIK1cH0mKS72MqPRyehcK5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A5ixb3ZC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A5ixb3ZC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7Xk+xvnF9xI6oTX/V6wddcY3doLv2wOIBRVBX9CcSwE=; b=A5ixb3ZCSIGvqY0U4o0uZpiRAA
	RYWQNKre/gWA/GiwQdJCm5s8H8cLG7NR9KOoeTUraZYUhst8RunSXrThvLChgTJ1vM732NJ7v7X9q
	zT3hGJUUHgtjsD7MBNnHJSUXV0VrfnzCgB6DaHwvjJpIQsCArgcj8GVh6YM5/Ql/H4MfgT0aZlMm6
	hIaf8jFGxSEOC0lo6M+A+gXJ6wn/j4i5CwX9I6vshn5vves/iKElSkz5xaMoIDfUWtMl0pl3JNJuD
	E6nbs7F5kpYu7n4XkEvlXWfWyvG4EPhrjABIOaAt2dbAkUKm0TIX/ttQm3pHTB54tuDBK0ntE1Aq3
	osJwafxg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0jo3-0000000Bfz1-2Ld8;
	Thu, 12 Mar 2026 17:26:43 +0000
Date: Thu, 12 Mar 2026 17:26:43 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Josh Law <hlcj1234567@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Josh Law <objecting@objecting.org>
Subject: Re: [PATCH v2] lib/idr: fix infinite loop in idr_get_next()
Message-ID: <abL3U3xm9c4oSbKM@casper.infradead.org>
References: <20260312171238.7961-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312171238.7961-1-objecting@objecting.org>

On Thu, Mar 12, 2026 at 05:12:38PM +0000, Josh Law wrote:
> From: Josh Law <objecting@objecting.org>
> 
> In idr_get_next(), if the returned id from idr_get_next_ul() is greater
> than INT_MAX, the function issues a warning and returns NULL without
> updating the *nextid pointer. This causes a soft lockup for any caller
> iterating over an IDR (e.g. via idr_for_each_entry) because they will
> receive NULL, fail to advance their index, and repeatedly query the same
> state forever.
> 
> Fix this by setting *nextid to INT_MAX when the bounds check fails,
> ensuring the caller's iteration will terminate.

Can you add a test-case for this?  And the IDA patch you also sent?
