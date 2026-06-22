Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD512F5485
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 19:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782156864; cv=none; b=NY9sTUiTvOoVMijDWjoOEnLrF+ezyn1PtZStSP1R+wnWVostAIF9dib/GnQCV/U0MB1S+KRSuMKBmKHE8cfDgXoIH7epfJkuJozevuAg8h+bOpzJNuS9xfrdAPBO2hFFIMuwUJw4adzdi7lkwIe+5l3qL9OMepcnFYSlrpQfVME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782156864; c=relaxed/simple;
	bh=cSc7S3mRXJRkKD09GxO9AqWgZc6HlrKlKQjeqN4Lx4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvynktoY2ZqTC7IyCyfEuIbhimU5jOnyYn7Nke2/3VkRf4V4phCmf3WqRtk1ao+4HYqzknRxbHAfpXKh/KP4HwWaxpoognwKEmtTXF3ntaJvAIBD+K6Pb1/iyz7dAyzcsB7kWLSR9MwkLFuQf4y2z6v4HE+A9PdqpfsNXQlvElA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hkm+Lm7h; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hkm+Lm7h"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xn4BQmH5jE2QFSOGntobZsvGCFIf+b2KZja3Sp0t2bE=; b=hkm+Lm7hxbFeaqyd0eOwZthJf0
	N/TPgn5Hwa3OwYWRIzQDtqsJMiUJNlXchFuZJkWpd9O8TDNZUWy8IMroy6ROfjTBHzgaOTLoFIX1q
	x3N+mavONrBzYlQLZLNyVrrnYlREUMHyjTIRve5Quoh/uZalulCkWoNvMdXf8IopmFtFul6pQVd0Y
	bJVDhgb3LS1aUvmbULopATP4bkV0nWLVl2rKOzJzkM6KvyPudV0RL/XAUPBAaisdhVIRUhbS1grG2
	VOUJmAOdK5z1rMnU6cfCQl+/li0An+eWaBj7blvN3RebnTokGbD01YBGm4mgv/y/1Scq7TEGDFRXk
	QTFBC1/w==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbkPU-00000004pMW-0XdB;
	Mon, 22 Jun 2026 19:34:20 +0000
Date: Mon, 22 Jun 2026 20:34:19 +0100
From: Matthew Wilcox <willy@infradead.org>
To: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [RFC PATCH] filemap: Remove file pinning during fault handling
Message-ID: <ajmOO0v2ndBFLaSU@casper.infradead.org>
References: <20260622192114.1147198-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622192114.1147198-1-willy@infradead.org>

On Mon, Jun 22, 2026 at 08:21:12PM +0100, Matthew Wilcox (Oracle) wrote:
>  		if (!(vmf->flags & FAULT_FLAG_TRIED))
> -			fpin = do_async_mmap_readahead(vmf, folio);
> +			do_async_mmap_readahead(vmf, folio);
>  		if (unlikely(!folio_test_uptodate(folio))) {
>  			filemap_invalidate_lock_shared(mapping);
>  			mapping_locked = true;
>  		}
> +
> +		if (!folio_trylock(folio)) {
> +			if (vmf->flags & FAULT_FLAG_KILLABLE) {
> +				if (__folio_lock_killable(folio) < 0)
> +					return VM_FAULT_SIGBUS;

... clearly didn't hit this case during my testing.  It returns with
the invalidate lock held.  I'll fix this for a v2.

