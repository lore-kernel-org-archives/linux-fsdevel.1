Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794507333;
	b=hqFcCNc6/g/N5xsSeHpEQb+3AW2v0LMFJbsnUg/2unfhCbcvIgMoA0Qbz1KyYFG9RdoI
	 xwhnAXLK8quaQtIG4D7tJ+IzUZAMby2Lqg4qKjoP8H4QjGKFWsU0RRtd39Uu1FzbD2cXv
	 Tt6MNHseaW53yJ+uw2Nv7+4D1vPq+ZhiId37y9zjehQIL+cymI1Y2g0KrjevpBWVJ93wx
	 aYQDIrSNQJ5YLKVwR9GFl6yzZYysOSLmww/hFs7R+DJ3JdIkLDTx/3RqRWa3tdBbKjgdx
	 lKcIkuVJMcCJ8R2ikhxO8TE7dF8EIjmSDq2YA1D0k2YyYU99wxsa3a3EGSqSVZFqMYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794507333;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=Ec7ksqE5j1xr/gXWS49S8KE9vtv5SLUNhac3dhFnc4w=;
	b=m24qe4+ctHT8/ckknMfZEnk9XIHJ+/bZOvX+g4HnIEW8G4LbPlyOJRnr6dH+DSyQKFPO
	 4RwKbeBx3Jw4bS6BTwMPb7optLM47Hpbpr38EFTmmfvRfJqpqtWhYnrc4gAopfakbOEB5
	 yHcN9US6tTWPpG011BuPDSz84zgEss+ZYPtjh+ApyCMY+X/CQ/SseCV23LSP+9Mro89Vj
	 zROhKtt9AAF4XkHVRwK7+/GcINwmdhigWnE7oTJ7Jm54FHLg7WNcO/kw3Ajx4uvwNvGXO
	 2Ywivv6HfDP3FmhVX2R9vSvznFT+r8eqJF6/yyMNO/In3naaP4FQ3XDcVEefB3nshlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=EbBhSSYh;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D76606A31C;
	Thu, 12 Nov 2026 18:15:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2D76606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=EbBhSSYh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ec7ksqE5j1xr/gXWS49S8KE9vtv5SLUNhac3dhFnc4w=; b=EbBhSSYhiUr1r4pefun4FGpnsq
	7/UasVlP4zd+Edl+hqoAfKFDoBMx6RUk3SkmaEreYrp8HRCjKawMZ6kPRbsEnCchjYhPh4TSbJe+w
	sMFLgYz5pt6qdb69Ccngi2KjlR0uUqDTkbMZzAGEyDQSvbW2rU/W3Gdgnjny5bBXqfJzLZXILUXyt
	+Fd7BK5GjiV3yJTkv23yOJD5eGo4qCLs+Bx9ASpYsEbcKZyQ5Lz2hhrywwhP7J90NjG9g8V3RCmaF
	dkA08F0PMUFNwewouccIs8GGboV+wJLKdn7UQcswQk+zATK5qQBL5JAkaPfCVBiSjFU5/4M1A3Wvg
	YFlgFTvA==;
Received: from willy by casper.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRZKb-0000000A4en-2Sbf;
	Thu, 12 Nov 2026 18:15:29 +0000
Date: Thu, 12 Nov 2026 18:15:29 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	William Kucharski <william.kucharski@oracle.com>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Chris Mason <mason@kernel.org>
Subject: Re: [PATCH RFC] mm/filemap: fix lseek() skipping a new large folio
Message-ID: <avYCQdIFg5EejtDG@casper.infradead.org>
References: <20261110-lseek_hole-v1-1-c089c960b846@kernel.org>
 <wkpls4kiwl3ktyu5ekahlchabnaqq45o4tgv26cmrs552ljse4@oczec23ankdt>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wkpls4kiwl3ktyu5ekahlchabnaqq45o4tgv26cmrs552ljse4@oczec23ankdt>

On Wed, Nov 11, 2026 at 12:45:45PM +0100, Jan Kara wrote:
> I just find it unfortunate that we have to play complicated games like
> these for such a simple operation as sequentially iterating over all folios
> in a mapping. And it is not a first bug of this nature trigered by
> compaction. So longer term I believe we need to provide saner apis
> shielding pagecache users from these nasty details.

I think the long-term fix is to switch to the maple tree as the backend
of the xarray.  Then there is only one slot for any folio and we should
be able to unambiguusly iterate over all present folios.
