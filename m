Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B173A366066
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 18:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771612857; cv=none; b=tXOo0gOSe4CM3MICcVg6VZCSGJqpS0AhlV8wezH6OLXcV0MEPkJM38LMW2L8/J68b1XkS4MIoH/MRhjsF2qgTGeCn1g020i5FL4F5FOCcdRLY7il3k2UGEdizKTFGOXqhFCeQWW+jtLAD0UyUMPRT4/0JkvPOOiQXc9aAdHEPrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771612857; c=relaxed/simple;
	bh=QJRu6ie7e52j/TbGIrWuPslxz/Fx+zg/B5ds4yz/zwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=usxSv/UmkF6QRWSngFLBfhBhgmiI+EfD0ZFnqGw+n6S6Yw6663SLrT4j17MRY/d+BEWapuZQ6AotVqTeQ0d9/jDaufSihlgyreijKbYRlvfmTiNccnKgRLf5sCDeRxQiSyYSr16Yk1Ni6WvDetXUCPR1laziQHqX8NT8WB9DwbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Lftq8RNq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lftq8RNq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Svo7BSgQV4vCJSDKQ04CEuFAs/IZlnbqXYSdfZ0/Cv0=; b=Lftq8RNqkiD5bR6H7u3Dfw/kRW
	O2I+2JavXhryv9T191MyUNBhtlTbI+gApgh9CZaGKbTzkapV7XjzxFpkqg9BJZO+5ezuiBQSd/kHt
	xYGM51EEfPu6P283MIn6UKTAUTG5RXB7xYEWa5nu6GqLAnHtfFgfa73Qg1C78HK6YEIcZ/1fQqtAy
	ZGzzpHaDkEd3WruJG8qXLUFFJ0KBYHzLXup/GJKxZgeeOglT6tdT7ueJsSiUsdBrA78a35pS4wCl/
	2tbwyjfOWasI05Lnf4eomtl/yP79RKSBAiQmt4VO+pwmvMDCabwylrdVXMjpLuJa0KBwLn/7sD9Ln
	LDmx4fbQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtVQn-00000009zoX-39c0;
	Fri, 20 Feb 2026 18:40:49 +0000
Date: Fri, 20 Feb 2026 18:40:49 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Nanzhe Zhao <nzzhao@126.com>, lsf-pc@lists.linux-foundation.org,
	linux-fsdevel@vger.kernel.org, yi.zhang@huaweicloud.com,
	jaegeuk@kernel.org, Chao Yu <chao@kernel.org>,
	Barry Song <21cnbao@gmail.com>, wqu@suse.com
Subject: Re: [LSF/MM/BPF TOPIC] Large folio support: iomap framework changes
 versus filesystem-specific implementations
Message-ID: <aZiqsQsWFSCjcfE_@casper.infradead.org>
References: <75f43184.d57.19c7b2269dd.Coremail.nzzhao@126.com>
 <aZiCV2lPYhiQzYUJ@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZiCV2lPYhiQzYUJ@infradead.org>

On Fri, Feb 20, 2026 at 07:48:39AM -0800, Christoph Hellwig wrote:
> Maybe you catch on the wrong foot, but this pisses me off.  I've been
> telling you guys to please actually fricking try converting f2fs to
> iomap, and it's been constantly ignored.

Christoph isn't alone here.  There's a consistent pattern of f2fs going
off and doing weird shit without talking to anyone else.  A good start
would be f2fs maintainers actually coming to LSFMM, but a lot more design
decisions need to be cc'd to linux-fsdevel.
