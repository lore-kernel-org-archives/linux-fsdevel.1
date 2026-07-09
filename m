Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF56F39BFFA
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2026 19:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783624802; cv=none; b=Tlef54Mc5kiHiehZjq8gFhP8qoJtkG5rmGwix6NjSyMH7IyFp8+cIZ1pftjMQH+l41YkSX+E2pE+1YEmcHFSUg9Wht4RgtauJ7vmsz52Nr1NWjFQIxc5NUsXk1VafWuW2qwYNoXJBCqwLMv9R4E6sS0e4Tx3+etbzCuEX7GPT74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783624802; c=relaxed/simple;
	bh=EXsE12mIOQIdvsb18ZYfcSxdg89TG3jWm22XsYWvfvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2qLPwZo3OQZSY3qufIOr19MBqWGAtwx24FPVi36Ce/2nzWxLwQ/90PaoI3w/ExADcDMVCTUwVe73qmBACQGqSojlDUaWJoS9+H4+8fQ23JxNaeudxz+v/T6vyD+MKXopJUNzM3c/XpH9sXQxTakSVmaOUP0GSkAGr1kMu3YkvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vklztZeQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vklztZeQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ywJuDuX3pJR00dpC/wU8zi9tZDyVl8qDRYGEK5siP2E=; b=vklztZeQzyUAabKNBVOE3K0ahb
	Ka1tU67W+PoS/sQxtr4NG4BQwiez3iuX5S2h36+DS+lX5zq2jLHmAVk6yKZ7hSqxZs0OLlg6xRg4j
	JafG3aADCjWO2kDujximy3Gcs051dMGvxswXCoD8wuGpcNKDkyfZ0uPdRJHw1ESJ6ol55rEb4e0je
	vbkVNOjnkOyjW9Z8LANE/jRcHyp2cbQMdYygffskKGtrI7tnNLqjDc5MEtkFGnQtpKl+GW/yqQHlF
	VUBDJnfND6Hcgj6XZrgT7g/DGF6nmmSgWKtZVv9r8rS7dYZvMcGcuIofpEac0HsIsIB5rs+Dw+Qzd
	e+7KN9Ug==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whuHn-00000005Rtz-0Jqc;
	Thu, 09 Jul 2026 19:19:51 +0000
Date: Thu, 9 Jul 2026 20:19:50 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH v2 00/10] Use generic_file_read_iter() in hugetlbfs
Message-ID: <ak_0Vg7_qyPquaOh@casper.infradead.org>
References: <20260709184740.1286561-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709184740.1286561-1-willy@infradead.org>

On Thu, Jul 09, 2026 at 07:47:28PM +0100, Matthew Wilcox (Oracle) wrote:
> This set of patches are separated out from Jane's earlier series.
> https://lore.kernel.org/linux-mm/20260617172534.1740152-1-jane.chu@oracle.com/
> 
> There's enough potentially controversial things in here that I think
> it's worth considering them by themselves.  First, handling hwpoison
> in filemap_read().  I want this for shmem as well as for hugetlbfs (a
> later patchset, maybe).  Second, handling misses in the pagecache as
> holes rather than opportunities to populate the pagecache.
> 
> v1 here: https://lore.kernel.org/linux-mm/20260707181713.208282-1-willy@infradead.org/
> Sashiko had a lot of valuable feedback on that, and that's all addressed
> here except for the things that I don't think are relevant.

Well, Sashiko pointed out a few different things this time.  Will noodle
on them and produce a v3:

https://sashiko.dev/#/patchset/20260709184740.1286561-1-willy%40infradead.org

The only one I think is invalid is:

: Does returning 0 here with an empty batch cause an infinite loop in
: filemap_splice_read()?

No, it doesn't, because we don't call splice_read for hugetlbfs.

The rest all seem like legitimate concerns.  If anyone spots anything
else, let me know.  And really what I want from humans is higher level
feedback like "This is the wrong way to handle hwpoison, it should be
done inside copy_page_to_iter()".
