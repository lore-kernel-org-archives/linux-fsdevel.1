Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9FF337B87;
	Fri, 19 Jun 2026 16:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781887964; cv=none; b=tGNso3sGR1273SPPeAK7e+ld0RkkCEkfHysu6n2u3fbVT85gJ/E5YuKDO21Fj4Ukg+8YvkWmZAR+cXneYjJIojBOlW04am3HQQXRxnpqjBTl2D+prjjLpzJDo75UV2iX50S150ZRfx5ZcHw4W5t0tKKM/UXxAGvBc24glsjepoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781887964; c=relaxed/simple;
	bh=U4YX01M1Qvb+x7KKhotL7yRAw/tQDX5+XxUpv4EuMe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2HRcyw/i7Cj0ju5LxvjPT+wS119hUYumPDbl72o9xtDfEOAA8AcErjc0mPZYXl7FnHyXgp5uB3pJWWrua5HEgi9Q9uNzYfHPxJ46WalR+YuGFQGUNRMRpxKaUAwDKFfBryHSTRYsolaXaGYWxPgyNaz5FTRY+6BY+qgkJkzLhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bKyc/pzZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bKyc/pzZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hdjDLGlryqVwr0moNe7lsmTyx0ASJxTqJKFc2ZfLjBI=; b=bKyc/pzZ1YVWuPzbPNCigqj8rD
	HraegruLXZEFA9MPV8LE89PEgKV2ec0lmFdrVcbMNJU1fQ+D5NL8HUSq7ZUKMFp5Gsw+LTVX/Y7Bn
	Q5h+Imphw1ewkt6tAJiKicvNaw2m3nrFyLbdId5T2VEZNz2VWUZNY1KkP+fHYmQzZRAvUvqkq+iFe
	6R3tffdj1WxbVIODYT8SzGM0/ZHT3dQ1myFpjRMnybvhozyQNmUNe6w1tZRmuS6OjynMaGs0LtQUC
	cmmQRxr9HAzMUhHuyxBjabwewGlOYqcaLL6r08/KXhXXy8K1cYQoEMBM/pVBNMQVdg6kn+ANm9u+h
	FT25tpfw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wacSM-0000000GYZF-3Kyr;
	Fri, 19 Jun 2026 16:52:38 +0000
Date: Fri, 19 Jun 2026 17:52:38 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, Frederick Mayle <fmayle@google.com>,
	Kalesh Singh <kaleshsingh@google.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-hotfixses] Revert "mm: limit filemap_fault readahead
 to VMA boundaries"
Message-ID: <ajVz1nhMn2JwucMY@casper.infradead.org>
References: <20260619112852.104213-1-ljs@kernel.org>
 <20260619093711.d0d37c9920b3a16394c356a6@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619093711.d0d37c9920b3a16394c356a6@linux-foundation.org>

On Fri, Jun 19, 2026 at 09:37:11AM -0700, Andrew Morton wrote:
> On Fri, 19 Jun 2026 12:28:51 +0100 Lorenzo Stoakes <ljs@kernel.org> wrote:
> 
> > This reverts commit 7b32f64bc512b40b268776c5ac4d354b325b3197.
> > 
> > This patch caused a significant performance regression, so revert it, and
> > we can determine whether the approach is sensible or not moving forwards,
> > and if so how to avoid this.
> > 
> > There was a merge conflict with commit de97ae6222c1 ("mm/readahead: no
> > PG_readahead on EOF"), care was taken to ensure that the revert retained the
> > behaviour of this patch and cleanly reverts commit 7b32f64bc512 ("mm: limit
> > filemap_fault readahead to VMA boundaries") only.
> 
> I'm a little conflicted here.
> 
> 7b32f64bc512 avoided readahead of "file pages outside the mapped
> region", which is clearly desirable (arguably a bug fix?) and we care
> about performance of executable mappings.  Whereas it isn't clear that
> we care about whatever the heck that test case was doing.
> 
> IOW, the revert might make the kernel worse, overall.
> 
> If someone plans to get down and analyse that test case then come up
> with a new version of 7b32f64bc512 then OK.  Is there such a person?
> 
> I'll park the revert in mm-unstable for now, but would prefer not to
> rush it in until we better understand what's going on with that test
> case and what can be done to address it.

Suren did that work.
https://lore.kernel.org/linux-mm/CAJuCfpH_Fp=J-m-kVZ3VVmqH0cAfNX6CQKWt3XmAJq1Rp9sFwQ@mail.gmail.com/
