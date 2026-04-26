Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE03140DFCF;
	Sun, 26 Apr 2026 02:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777171366; cv=none; b=ITRVPT2FwDcoACRlUtyLgJ16rOkHklwUFFa4YTTtYdqjP4G9+cQHQiXOp5QI4nATm3Zwvz8sTMKlHchnmLq2pjOP2RjH7AcB9ammxr0uSJyi4CMowCaYsIVqqZxwxlspMvRjQXf6JJ3qRahmuxBJxgp8ZbVRA5O41c/qy96HQu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777171366; c=relaxed/simple;
	bh=CjhCp5fRVC980m/+udFpBkFSQnX67dE7Re3A+imQ2eI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhf6px2BpfnVgt7aegQgKTIVObwddcJBvJywZQZeviph7HHaUZiVO2aTQoJEQyR5qUIMeJNLnUzN4r9+Y2XN1wmjc8BwQFHWTqdC/rg+MPklWrphIY26VyWqJg63fsh53iYs1vix4S3RxjFTp4YS9rnLGFbFTdcJ5xQjNlk3uAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CfV9pkNu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CfV9pkNu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mB5UHsdu8+y4wAx5rCysNkh/rqLgGuKADwB1/3r+L0I=; b=CfV9pkNuINvn0qS2zGITIfZy66
	eKWOSVvcMUj4wK9e7ZvuPIjDIZTaSfdx9xigPIMWi2XiLj8EtDavE+s3qU6+0jozEDWOogi7jYrYy
	f5xporBg2W/MLh9KLuBtwD3qgI2DNDMhokv9J6qAAH3SBfkzxp837IyqQTRR/p/5I5kAGZN9oPiuP
	tTSNa3V5nI/fCaIBRC1UnK4a13OKQU9ezNyZMjc1hF1HTvBN/phV4y3aVO72zXo35l/M924oPBFFG
	9zzU5cNtwetDM4oAIcIRq2Bf3LpdRmLk15EjJu1X3+Ida500Gj7P+A3OMH0zXbyMFjNZ4m3PMLcbD
	67fPKCtg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGpSA-0000000HYgD-2ZUm;
	Sun, 26 Apr 2026 02:42:38 +0000
Date: Sun, 26 Apr 2026 03:42:38 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Chao Shi <coshi036@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org, Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [RFC PATCH] fs/buffer: serialize set_buffer_uptodate against
 concurrent clears
Message-ID: <ae17nszpQA7Eqbc6@casper.infradead.org>
References: <20260426020137.1221985-1-coshi036@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260426020137.1221985-1-coshi036@gmail.com>

On Sat, Apr 25, 2026 at 10:01:37PM -0400, Chao Shi wrote:
> A WARN_ON_ONCE(!buffer_uptodate(bh)) in mark_buffer_dirty() is reachable
> from the buffered write path on a block device when the underlying
> device returns I/O errors at high density.  Reproduced by fuzzing an
> NVMe controller (FEMU) that returns crafted error completions for a
> sustained workload from /dev/nvme0n1.
> 
> The race is:
> 
>   CPU A: block_commit_write (folio lock held)        CPU B: end_buffer_async_read
>     set_buffer_uptodate(bh);
>                                                        clear_buffer_uptodate(bh);
>     mark_buffer_dirty(bh);  /* WARN fires */

Why are we calling clear_buffer_uptodate() in end_buffer_async_read()?
If the buffer is uptodate, we shouldn't be reading into it.  If it's
not uptodate, we don't need to clear the uptodate flag because it's
already clear.

I've been deleting calls to ClearPageUptodate and folio_clear_uptodate()
from filesystems; it's almost always the wrong thing to do.  But the
buffer cache does have slightly different rules from the page cache,
so this may not translate well.
