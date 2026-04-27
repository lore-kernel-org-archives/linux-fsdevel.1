Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782BE34EF15;
	Mon, 27 Apr 2026 18:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777315228; cv=none; b=s/iFLaAX5ptkEE1tkA1XNBHNhxrMiX1KtF9bKHguzUA2JfZNDSR/AqjZ83ehJNTB8IenSFW+9sxvuEtsps0I58fUcqhn1DPgUXTX+/bJ0cS4YboHbz1QSUefaXsG5Tn2uEE4+5G4vBwGMEFWRoYkrFk5r67Yu3dlRb9vobWONiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777315228; c=relaxed/simple;
	bh=bUzTJSnwCcGX220RDWaMzISvuZ2VCC8k7wfbbe6lyEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8X9JUNQyYtXQGedVAjhv3PzL0iyyzqH2e6AdDV4nX2mcJJtSbRcRMFo6z1LAz48/BgwppedVg2rQ6F3X4jDUvYjmI86SCeP1ZcEBnBuqFibQDn9922tPBJePFHkHZqAzOAdJEibL8Rl1Wy6nchAhpASHeJRYbO8GKUoHq+pwqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NvSnnN9M; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NvSnnN9M"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NbhMhi8ifkGp8/FOlSoCcOAfIyRaJ/euhlZ0Qm1rNXE=; b=NvSnnN9M8bZk87DNUoaecIYSrE
	EYKgxS7e+S/0NCsnyMZ4lZ9lYs1QUNKyxGP5ae3g+ENk/JYMfPUk67y6zNjiaSTzT20pPFPyCB1P3
	IR779oDSxa/pCKSiXqVc8gL/M+vztZGV0n58nkBhyBPuRi2uFetJWTEZjbPR5oWS6K5nZP2oEAszx
	IuRx6agaDHLDNjCWeIGgy7C9L31h0Jzbv3mA/mwwH6NgcBscevHPM4/sHIU4Tbxa4tozBMYo1pj4j
	nX+ZLTqfqi2VMYUm6E7asgDYJuCSFQCZDa5kyyRlutePQHe0b8e8NsKAXJcOuN1ggxnuVUoQO96Km
	Gjo0EQAg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHQsV-00000002Vp4-3mzc;
	Mon, 27 Apr 2026 18:40:19 +0000
Date: Mon, 27 Apr 2026 19:40:19 +0100
From: Matthew Wilcox <willy@infradead.org>
To: fujunjie <fujunjie1@qq.com>
Cc: Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Haoran Zhu <zhr1502@sjtu.edu.cn>
Subject: Re: [PATCH v2 1/2] mm/filemap: count only the faulting address as a
 mmap hit
Message-ID: <ae-tkz6qe1zFmXVj@casper.infradead.org>
References: <20260427165751.746502-1-fujunjie1@qq.com>
 <tencent_949F3B157FE71D3C7247AE6FAE2C5AB82809@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_949F3B157FE71D3C7247AE6FAE2C5AB82809@qq.com>

On Mon, Apr 27, 2026 at 04:57:50PM +0000, fujunjie wrote:
> -		/*
> -		 * If there are too many folios that are recently evicted
> -		 * in a file, they will probably continue to be evicted.
> -		 * In such situation, read-ahead is only a waste of IO.
> -		 * Don't decrease mmap_miss in this scenario to make sure
> -		 * we can stop read-ahead.
> -		 */

I'm sad to lose this comment.  Why not move it to ...

> +		ret |= map_ret;

here?

> +		if ((map_ret & VM_FAULT_NOPAGE) &&
> +		    !folio_test_workingset(folio)) {
> +			unsigned short mmap_miss;
> +
> +			mmap_miss = READ_ONCE(file->f_ra.mmap_miss);
> +			if (mmap_miss)
> +				WRITE_ONCE(file->f_ra.mmap_miss,
> +					   mmap_miss - 1);
> +		}
