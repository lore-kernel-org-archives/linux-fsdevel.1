Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32453C81AA;
	Tue, 12 May 2026 21:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778619948; cv=none; b=RWIwVdTV3vBBqX+jbps3ZdcWRa1Reeujz7BX2jAZc36pHexQFSE+qWX+LQcj4UotopTgy2dIoTvYDkS4EkTZrUuVOPsU4/fpaucT/p5aY6y2x9QgDNykF/hiWqEZmy2eppf9o7F1lGNJABy2F9ZG/gqvCdPr++Y7O1DG8akvXlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778619948; c=relaxed/simple;
	bh=+PgPIb9hPXsFW1+xDb0rpXaBbkMY+U4rKLL/qu4FdQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3RiC/yevcieaQuukd1QKDEJis119QEQiPo9PSYn5Duo63bB+Bs9e9bqoWf7xQWtJLMKyw6KLMnXTpIKYg9pOSJwqlhf50LUaz+9SC+XpRvae5uC0Db2UcjlVZ7r1Ltm0W7TMrQafUv/G0+AwLvfUzYHMqPk9yhvnGvkZsdddHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jRW7CK7M; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jRW7CK7M"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iNEyL3gLDyzG6nO2vSmePUfY2nRaePWVRT05beAUZoo=; b=jRW7CK7MQ9ezHwr4s0cdjEQqJ4
	EFypHoSxXn8As6dsEPhav0BQSmoMJNbHuurNSp1XGGgbx0RNzuhKUH7WW2pFoxvnXQTJpzyFdJNbG
	XQOobEZTNuHrMkNHOc4MlULRrWfIkP285A2QPR4r5/2S5cP0D1CuDUKbX4/ivZ/8zG5cuC3DDbi8E
	x7xkdcO4ww0vLVS5YI5z5v6a6C+YhF9xc4c0AeBDWh5s5gVFT05JV2dOhQ/8ySyn0NdFHLxe0fnHG
	oscreJQhFeRrVIlQiT5NM1J9YwTyy93+PvMbHDHKZC5W1IO6UxlYVQLJBRUZD2yl15moRB/O7w9Ry
	hFZUYMKg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMuII-0000000APap-26GZ;
	Tue, 12 May 2026 21:05:34 +0000
Date: Tue, 12 May 2026 22:05:34 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Frederick Mayle <fmayle@google.com>
Cc: android-mm@google.com, kernel-team@android.com, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/readahead: add kerneldoc for read_pages
Message-ID: <agOWHm00w2vlh1_o@casper.infradead.org>
References: <20260512203154.754075-1-fmayle@google.com>
 <20260512203154.754075-2-fmayle@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512203154.754075-2-fmayle@google.com>

On Tue, May 12, 2026 at 01:31:35PM -0700, Frederick Mayle wrote:
> Formalize one of the invariants provided by the current implementation
> so that callers can depend on it, as discussed in [1].

We don't normally write kerneldoc for static functions.  I'm not sure
why Andrew told you to do this.  I have no objection to adding
documentation, but I don't think it should be marked as kerneldoc.
And if it's not kerneldoc, it doesn't have to be written in such a
stifling style.
