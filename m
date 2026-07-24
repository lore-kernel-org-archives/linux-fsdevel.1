Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B895C1DE4F1
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 12:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784897124; cv=none; b=QYKXlVJAkyGnEDzGNvEYoVZnhRFTMZ0rx8MzmkBOFqmWSYdwbXggFqC3WZwmKSb6kGJKLAikDYZC9sN3yENaZGMbgepnunJBf5tlU5LeYMIZv6YMMUrNxjdJlKxVtb4ReXZfAkbhawC4/qjilPlrAXOrVxPxQJS/XHhAAPwcMUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784897124; c=relaxed/simple;
	bh=j9FkAcADkptXK+VYSYgJmUWhT49FWNMBvgdLcEYJFEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvXClvqGZGmhRzIeQhbPvB1l1TW4KzQCBeiyzbdaLiZqJm/sYh+Kd+fdf8bNHCp8Llb0wdN4LLgjUJqGzdpew8xl5NguX6vG5upGBO91rKyxxzLprTB7b7TI0ADNbh+WNc77OBn+G6w/Ya73JLByCbzHPW+ZgUqiz+2KDCml3nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EQbMwHMm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EQbMwHMm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=j9FkAcADkptXK+VYSYgJmUWhT49FWNMBvgdLcEYJFEQ=; b=EQbMwHMmdEgoJejfBOjo5/eBam
	BeGPIsGcmG0o5+55Cijdo3TqLPTRIheMAGLBE1SMtL3EX4Ty0CKncjXA0cFitvvcWdPZUsSiH3HQF
	6lQ+4Ntj1NGoHsO1mOpxP+sH5utY3bsCCY3chdh1++oTR3zaRFv+5GJ8+vWa7AL67VzhqefszSYeD
	HJcknILtoF7sqmoJNg2C+kKE5HrEM+jPn7u0OWUPf/LKDzFGjM1PAeqSUEbHxhfdKLytfX/lupTW4
	ey1xWR/d7ZhE4CVg8smK8uFtlyG6Hw/AwV9eABxbiE22OQMTSiNps8WcaFuCzuSklrqqT8acRrvwt
	aLSLnXcQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnFHC-00000003U26-3PQK;
	Fri, 24 Jul 2026 12:45:18 +0000
Date: Fri, 24 Jul 2026 13:45:18 +0100
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
Subject: Re: [PATCH v4 06/14] memory-failure: Remove raw_hwp_list_head()
Message-ID: <amNeXtnxn0yV6-Gw@casper.infradead.org>
References: <20260723143034.175661-1-willy@infradead.org>
 <20260723143034.175661-7-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723143034.175661-7-willy@infradead.org>

On Thu, Jul 23, 2026 at 03:30:23PM +0100, Matthew Wilcox (Oracle) wrote:
> There's no need to hide the llist_head; we can just declare it
> directly in struct folio and do away with raw_hwp_list_head().

Sashiko finds no issues with this patch.
