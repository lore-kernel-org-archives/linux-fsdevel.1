Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C273CBE9C
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 16:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784909331; cv=none; b=u0/R8lvLFmeG5/bbwnJT+ONWgdqlUE28+7IIz2sWR8b4P+AgEZoddpwVJrFu+K2wqXffj70AJfdjm6BhG8cvzx236IvoYS+6SvDPc9uSfDLPILRthPlPl43IJnAqAxsZ/qw3FCm9XL1yFjoDOOdAVQaf3TPuXIiE/WxM40MXSXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784909331; c=relaxed/simple;
	bh=HbwXutWDBIndd4mPWLZBguRoKuIcyE3i/o3aj/iv0hQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1tmIQPofnBYgck7DCRHtS2V618ltKL7Dok9GVtFn4IqYDAl10DbO3NkYlyScT42pgkE2Fc3zjVeGXGZDTBg78px+KTGgj7MSlyw1TsrdS17jJnCLHTnWoi60s9xgWqMxlJZi/3fB0A9cgv7IES6JmgoQa7fsiyCxHhyg0EC238=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uGVl2qU2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uGVl2qU2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qXStzKxn08yiwCsk0RV725qSWDOorXbCbPNItU+sABQ=; b=uGVl2qU2We/HQriv2zRTu8jrWe
	52XFKY+0Eg0r8WY5X3dRexzhOALY4O2Er6CL+LrQrvBWdIS/DM1Pej2Uq0JUmSw/9wvbcdR7ciZNS
	mGNF2vHYdlPt3Vl2Chl03tLVrCgws7F7HWbZ2JKRir5pAc+7pAX5gSnl1xIu9S5bCKkT+O8ECq/PW
	FUtrkdJvJskpytGyVKOk0WZda9IxTihCH2xXyIXXU9npsZylISma+aJomMuiUtmtRQsVt06ZoAkR6
	NRCJ9Wzl9o9+J/kdh8/sTy4Xi/3/tvou5YhQWXYoO28ORfclbOJhv5sKBE74HCjvEdJtH6tIUl7T9
	dqmSKWmA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnIS0-00000003sba-1Q6u;
	Fri, 24 Jul 2026 16:08:40 +0000
Date: Fri, 24 Jul 2026 17:08:40 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>,
	Jiaqi Yan <jiaqiyan@google.com>
Subject: Re: [PATCH v4 11/14] filemap: Remove checks in
 mapping_set_folio_order_range()
Message-ID: <amOOCGrT2LEDIl60@casper.infradead.org>
References: <20260723143034.175661-1-willy@infradead.org>
 <20260723143034.175661-12-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723143034.175661-12-willy@infradead.org>

Sashiko review:
> --- Patch [11]: [PATCH v4 11/14] filemap: Remove checks in mapping_set_folio_order_range() ---
> commit 795dd7139e11d246506bb93b2bb441409e4bbfbf
> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> filemap: Remove checks in mapping_set_folio_order_range()
> 
> This patch removes max and min order bounds checking from
> mapping_set_folio_order_range() to allow its use with hugetlb. It also
> switches the configuration gate from CONFIG_TRANSPARENT_HUGEPAGE to
> CONFIG_FILEMAP_LARGE_FOLIO across several folio order functions.
> 
> > diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> > index 2c3718d592d6d..436987f47aed4 100644
> > --- a/include/linux/pagemap.h
> > +++ b/include/linux/pagemap.h
> [ ... ]
> >  static inline void mapping_set_folio_order_range(struct address_space *mapping,
> > -						 unsigned int min,
> > -						 unsigned int max)
> > +		unsigned int min, unsigned int max)
> >  {
> > -	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> > +	if (!IS_ENABLED(CONFIG_FILEMAP_LARGE_FOLIO))
> >  		return;
> 
> Is CONFIG_FILEMAP_LARGE_FOLIO defined anywhere in the codebase?

Oops.  Forgot to continue the rename into this patch.  Fixed.
