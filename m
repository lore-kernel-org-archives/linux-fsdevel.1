Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F6930FF20;
	Fri, 20 Mar 2026 17:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774028858; cv=none; b=mRBSKe3lNhgIWrKPIMY87SXKwBFdWaudnkEP3NDyTJdj8TF+6v//QFuMGDZxb8VfBsLHlAhS7acxTtZp2/OW/V7yThmEwzuA44Hb91oMgQQwHOFkarN28VyTBcaO02fiBGVZnvkV3yZZBD+R7hWBU1PPRBnrJVwX7r3rkn4WVV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774028858; c=relaxed/simple;
	bh=YBrE+ETl3QSBu97biTA3vK5m68jytBBGssPNHhBNDT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5U5VkLk7MHu1C557OCpeftgK1xTqOtvBQl1iGJpY73TD2ABY/ImGBxcX6q8cvrPIQ7W6mgEE5mUeXe1MPlAVzGsfWqXAwrSw0+mkOiPCHSp58jteArPVpbPLyE40MtNKt1Q/r9GBuEOuhIAW0QyEEJR5HnctbFV8Z9zIklDscA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T605LByc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T605LByc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YBrE+ETl3QSBu97biTA3vK5m68jytBBGssPNHhBNDT4=; b=T605LBycL3rI4RFN580+M7TbGh
	aCtU6vIGOVxGUwytuHLYp/1ZLkr27qP8DQeq4BOYtdqrVVL7wqOyT5X593nCLlATcEz6u0jOP573S
	Ui6lMu0pcx0mOEggwfgy/xeErgiLPY6i5Atl+6FZuDnHJf/jVwDXtFVk28OQjIvLgQLqnccrJC1il
	ptJwQFvaNBAZEPXJGG6jm1esBTUZ7TfOux7cY9wHxOz0GGaGeCZLrlw58J4aim0VjVLtWzxZKjMv4
	ISz7tyHvSHWMmQuU03PUvGHLpCMGBRVES9neSGXWnsFJ6ZI/TZNJY3nCKyBuPApHpwPAmkHEihWgV
	BjW0+lsg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3dwK-000000088lh-00QQ;
	Fri, 20 Mar 2026 17:47:16 +0000
Date: Fri, 20 Mar 2026 17:47:15 +0000
From: Matthew Wilcox <willy@infradead.org>
To: WANG Rui <r@hev.cc>
Cc: usama.arif@linux.dev, Liam.Howlett@oracle.com, ajd@linux.ibm.com,
	akpm@linux-foundation.org, apopple@nvidia.com, baohua@kernel.org,
	baolin.wang@linux.alibaba.com, brauner@kernel.org,
	catalin.marinas@arm.com, david@kernel.org, dev.jain@arm.com,
	jack@suse.cz, kees@kernel.org, kevin.brodsky@arm.com,
	lance.yang@linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.l, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com, mhocko@suse.com, npache@redhat.com,
	pasha.tatashin@soleen.com, rmclure@linux.ibm.com, rppt@kernel.org,
	ryan.roberts@arm.com, surenb@google.com, vbabka@kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2 3/4] elf: align ET_DYN base to max folio size for PTE
 coalescing
Message-ID: <ab2IIwKzmK9qwIlZ@casper.infradead.org>
References: <20260320140315.979307-4-usama.arif@linux.dev>
 <20260320160519.80962-1-r@hev.cc>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320160519.80962-1-r@hev.cc>

On Sat, Mar 21, 2026 at 12:05:18AM +0800, WANG Rui wrote:
> >From experiments (with 16K base pages), mapping_max_folio_size() appears to
> depend on the filesystem. It returns 8M on ext4, while on btrfs it always
> falls back to PAGE_SIZE (it seems CONFIG_BTRFS_EXPERIMENTAL=y may change this).
> This looks overly conservative and ends up missing practical optimization
> opportunities.

btrfs only supports large folios with CONFIG_BTRFS_EXPERIMENTAL.
I mean, it's only been five years since it was added to XFS, can't rush
these things.
