Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33D43B7B79;
	Fri, 19 Jun 2026 17:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781891176; cv=none; b=fCXXyL6EfVnSNW4bBnRWHqYbutP9ZYofHCHHH5i6+bppefpttyfcK/cnuit0RRTwk2k1lb3jkvYczR9W97S1s4fVqYgLGHbpi7qQoeISxn2KxnbstxiP9X21kBEuIHu6H66Fn3lrdkiNDrSFnXg8br+zMpJ7PBs6cZxM5J/H+7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781891176; c=relaxed/simple;
	bh=LCXc21NTLAAaF8ZV9mHzTj7u5xa1Gw1P/7c70+jYtmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fop13Sc8JrT1Ah3NjNN2pnjpccpFOEBW/rGbe5elTOkoCorjg2Fl6QBm1/LqH7/5UG9ponx69JIIwKv6ZBhxp4zW4n3PrjJBzVzc1Q82y1RDVcwuJ0XYd0B0pg46NNjgW/282ZQH/n7toMw6vH+vTERLZeXw0DT1+C/OF3afF8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=l+8i67WL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l+8i67WL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pZ0VaGBnxQ8weCfxrWdQENSWAlIhEKkOkvtxqoUh3/c=; b=l+8i67WLK+tGGnvHIBAB8ABVlD
	V4sYUV2GFjhQ9DH1/Y2zSBz2J9mOYvHbx6Lte7/VOfG5w2I3a5Z1dPc8J8HGpZHamai9P9rAFiril
	C7zg11k6Uf1Lx/W3dqvlZT1M20EMJUxeu3t35Djes6x/in+IdCHcqGSHtGI3jRNS4LMB0/+FvupVw
	XS6/YjfQ6ici6nTVE9BzistNWsKeG/UX7FIdr/QAGzZVf6y9tB1x9634uE7op25gphNkEs0E4ehBc
	D7FWCA8OFLvNOJDC+KeUWCHWe1RTPHjQzf5/JcP697J08ApglWEXKKHkWxBtlFOXTZiEJZfXvwPk8
	9esPMJrg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wadI9-0000000GcN0-0E0O;
	Fri, 19 Jun 2026 17:46:09 +0000
Date: Fri, 19 Jun 2026 18:46:08 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Pedro Falcato <pfalcato@suse.de>, Lorenzo Stoakes <ljs@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Frederick Mayle <fmayle@google.com>,
	Kalesh Singh <kaleshsingh@google.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH mm-hotfixses] Revert "mm: limit filemap_fault readahead
 to VMA boundaries"
Message-ID: <ajWAYBXHJniJAO4u@casper.infradead.org>
References: <20260619112852.104213-1-ljs@kernel.org>
 <20260619093711.d0d37c9920b3a16394c356a6@linux-foundation.org>
 <ajVz1nhMn2JwucMY@casper.infradead.org>
 <ajV0TbwEyaKMzoa6@lucifer>
 <ajV49Fyogfa6aIjy@pedro-suse>
 <CAJuCfpGdxsPDbxOwQFdY+Xt7mZGFvoKWmed6FteTongvFgjgww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpGdxsPDbxOwQFdY+Xt7mZGFvoKWmed6FteTongvFgjgww@mail.gmail.com>

On Fri, Jun 19, 2026 at 10:43:06AM -0700, Suren Baghdasaryan wrote:
> > Yeah, the mmap usage on SVT-AV1 is a little suspicious, but I guess the
> > pattern may come up time and time again for people doing chunked mmap
> > reads. I think we need to take a closer look at this change.
> 
> Frame-by-frame mmapping for a streaming workoad is quite questionable
> IMHO and I don't think we should be optimizing or encouraging such
> usage, but I understand the reasoning for the revert.

If userspace is properly tuned, it doesn't need automatic readahead
at all; it can disable it and issue manual readaheads.  The point of
automatic readahead is to cope with userspace which is doing stupid
things like calling read() for a single byte at a time.

Could it have better defaults?  Maybe!  It's worth a try.  But those
attempts need to have a very low bar for reversion when it turns out
they affect other workloads.
