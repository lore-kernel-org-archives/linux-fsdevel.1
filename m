Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69CB44C4F7
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 16:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784909786; cv=none; b=EBtOwbXTYBR7KF8oct5ujeNzl1zaJt9aoteXz8vYut2fJ0ASjQy/HmBk8buFiYlpOFKm6zE3Y9M3A/x7OjoQsNmp695r/z2N8XMLsVpS9tCMg7LeiNUY3rtOM+aFXmvTKLSgNMF5lNOQnP7y+QHLuPewVbd+Q7M/eSfycpp4q5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784909786; c=relaxed/simple;
	bh=O3WmRU0rK3NSBssLfskheuof5N8D8eRd0P1fh4GZaYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gB2cQPi/ymoUI5fOHurlXbCMIOMaiVaq06/9wCTLcN2q1XuNlUC/EY/O4WzkeyWFVLvw6q4KQUoEd5etFLDacsgGkN9j0WjyIopxrNc46jSoXHEmcxX1WzK5gLnfhULRKZ6o9BfMt65Arrumj1QUyL/R8BoHHxmTz8HshVpYRqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GUOTG2G3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GUOTG2G3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=O3WmRU0rK3NSBssLfskheuof5N8D8eRd0P1fh4GZaYM=; b=GUOTG2G3RjG5GfqbwCcfshxemE
	vYR//JBT7GpRxU5C2guOqa8rlG/I4AxBU5OhNlbW9+QC50IM+4sxDbWNOe3WrWlQL2SSZVaS6tVU0
	dmsUl9a+8CysAiRAxmS/QrsjO1v9M7VmOtKcF9JLnuzCS80hs7yOhkNaczLz0yGKBwhUTrQ9z8vwX
	F74Ao0CxG6ywYcQCyRg1smiQKzh1VCqbqaY8eXAoZLz1vHdzvHRPmTPJt54JxwuuF/LXCNADzLdlc
	xBUUd35ib1oFcyb9hotLF+4wUtgWG+pkgmxRnDcZNR5wtRBhiE+rqwrLdEpar+WVF2igQJCeyElpu
	8W630ghQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnIZH-00000003tSX-2V1q;
	Fri, 24 Jul 2026 16:16:11 +0000
Date: Fri, 24 Jul 2026 17:16:11 +0100
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
Subject: Re: [PATCH v4 12/14] hugetlb: Set mapping folio order
Message-ID: <amOPy2SPO8845YNM@casper.infradead.org>
References: <20260723143034.175661-1-willy@infradead.org>
 <20260723143034.175661-13-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723143034.175661-13-willy@infradead.org>

Sashiko review indicates only the problem in the previous patch.
