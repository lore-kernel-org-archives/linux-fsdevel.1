Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C293399340
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 15:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785857737; cv=none; b=nyrqEd21JWSf0SYmSevxsUbNBSUsj40SMdlj5o+L0STdRSVfNQ6jGkYAqOQxhViBuay1UXVMdyHLR+Q95gRqqNbysVFR9zULZmdxb3lGdmllJFskQ2UbxB8oJRnItrRt42l/xnvpTy6AF5gErH+Dk1o9Ki4nP0AT8H77ZAR8wzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785857737; c=relaxed/simple;
	bh=QXJIXbouAKaDq1yQ2zHVoyObhcolmrYCHntKPz3lg94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppbVIKtDQ+LmAACwyDhAQmTaQ/KdfcjqlSoZ5QsQm66MOYDoTGZrIdNW8iMnrwMyFSBKtS5LvoH+VOvKluXqCXnuV6hd20zdSmEu1vLMIoX7nm8zWmMXAaYVoj5sqXpD06FQvppq5OnFfZKH6dfElBLfIXo2eBymX7HdXUvm5qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jP6W4WUb; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jP6W4WUb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=r67WbSGJFOJ3m1cb1BTsiBKOB/G7xLlz+d84UQNgMrg=; b=jP6W4WUbd+BQvlFAif99nMriLt
	QB7Z5FQtFkh9MEJFpTavQl03ecClCBbb+ORaTP287JSk6Wxbwy/GqFhBaM4UosHej5/AgcWkYtniZ
	t+HGWIVJIs+ADEa/x46vd54UfcpKvGLhbXJTnlvIAVXqDJiKXmDr8cG7+PNdYokV8TD3s5JnD2Xwe
	UcRZNBNbhqAnAyU6BOK4CEJoDazO9mHSIFyNkXFQ1u+1AxwnKrn7pjVjKJuFYGhe7kReo3a0CbVSW
	QNn0OR88uSrnYvcM/TCiCOpMf5B7Cxd19YZGYV47wU8d4CsetablOYuc1O2uSF687oeOhsUtqF0fe
	R6vB3+qg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrHAm-000000048FO-2n8G;
	Tue, 04 Aug 2026 15:35:20 +0000
Date: Tue, 4 Aug 2026 16:35:20 +0100
From: Matthew Wilcox <willy@infradead.org>
To: jane.chu@oracle.com
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>,
	Jiaqi Yan <jiaqiyan@google.com>,
	"Gregory Price (Meta)" <gourry@gourry.net>
Subject: Re: [PATCH v8 02/15] memory-failure: Prevent hugetlb freeing during
 unpoisoning
Message-ID: <anIGuLZ-x2pIb6mg@casper.infradead.org>
References: <20260731200802.574821-1-willy@infradead.org>
 <20260731200802.574821-3-willy@infradead.org>
 <2f5fb8e1-67bb-41ec-af8f-b4da60be4583@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f5fb8e1-67bb-41ec-af8f-b4da60be4583@oracle.com>

On Mon, Aug 03, 2026 at 11:40:25PM -0700, jane.chu@oracle.com wrote:
> Patch itself looks good, so Reviewed-by: Jane Chu <jane.chu@oracle.com>

Thanks!

> That said, there is a pre-existing issue:
> folio_free_raw_hwp() should check HPG_raw_hwp_unreliable, and fail the act
> of unpoison just like what __update_and_free_hugetlb_folio() does -
> 
> static void __update_and_free_hugetlb_folio(struct hstate *h,
>                                                 struct folio *folio)
> {
>         bool clear_flag = folio_test_hugetlb_vmemmap_optimized(folio);
> 
>         if (hstate_is_gigantic_no_runtime(h))
>                 return;
> 
>         /*
>          * If we don't know which subpages are hwpoisoned, we can't free
>          * the hugepage, so it's leaked intentionally.
>          */
>         if (folio_test_hugetlb_raw_hwp_unreliable(folio))
>                 return;

I'm not sure I agree with that, but I'm new to hugetlb & hwpoison
handling, so please check my reasoning.

We set the unreliable bit when memory allocation fails (ie we can't
allocate a raw_hwp_page).  That does mean that if we have a real hardware
error, we can't know which page was poisoned, but for a simulated hwpoison
which we are now clearing, it doesn't matter which page specifically
contained the hwpoison.  We're going to unpoison all of the pages in
this hugetlb folio anyway.

Maybe there's more to it than that.
