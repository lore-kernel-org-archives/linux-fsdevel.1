Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67C553B5FD
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 19:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790192025; cv=none; b=Uoj4xjDzjcYGiE+TQMVw7fx22xXje0X5Sw6t3+H3iCFtEI8pHuVfnoXnVicE5+nnAS7Ed28lYUC/p0/e8/roqbzx/80clIoNFtHieMO1/017dhuRYVsCSCf6Ny7irgWhyaRu3fxWccMUDI4C/+gjxFF4AaIEHWD6Z2GM2D2H2Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790192025; c=relaxed/simple;
	bh=UZod39GUIKVbghrrg2N588sF2lnmKRTQFRDsESSbkQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTyY3XfMyNaEoYpCoTCC//ZrXYOpYTJxjoLHgRW+viEDg8284QeyiwyHEpX85Id3Klbu8P8Xeam4K9QaIsbciUFAoc63RWL9uATpdHmoPX/3MDhONOUVOhpGx++27qC8D5LCqQ+REUEtGzioS9QAR48ZWzZV7LUfrIIXZQ27MPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QT1PAU98; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QT1PAU98"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zlF2IHBpGoMsAW+PGueMhFZSAFiwVwxev332r0gbKW8=; b=QT1PAU98ZJkp/BlL5ftLjhFNug
	BvKHevpJ/YlLkvNj7hHwEBJFcr1zf3E35h+m+BOgBYCSWdEnJw1X9ZQrO/SRYn9gAZuif4BJGCDhT
	ayLU+GyxTD4uxXdG5K3P+XCMwxpWgm/2OVTBg6GKHuVhlQyQabwuyDVi6gw+vtf5roZTHa9V+klxR
	4admyx1UoGsAwtPMvenoa7xuolkH8RXP7HL2Zt3uVomKQWKWzrSvkl/iZfdF2aCir6Oey3NJNpBfD
	IKfg5fvDK77dRtl+YtR95MQ0T647+VaUOIRu3PqwLSef1QUsyBpYYrvQmt6zjlS+7iUQ00RdsMlZT
	v9QZ5UcA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9Sii-0000000EFUQ-2XSG;
	Wed, 23 Sep 2026 19:33:33 +0000
Date: Wed, 23 Sep 2026 20:33:32 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>,
	Jiaqi Yan <jiaqiyan@google.com>,
	"Gregory Price (Meta)" <gourry@gourry.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org
Subject: Re: [PATCH v9 08/15] hugetlb: Use the has_hwpoisoned flag
Message-ID: <arQpjJlN9CGee5Xj@casper.infradead.org>
References: <20260805210557.1118966-1-willy@infradead.org>
 <20260805210557.1118966-9-willy@infradead.org>
 <d30db03b-ffb4-52ce-c922-415ad75661ea@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d30db03b-ffb4-52ce-c922-415ad75661ea@huawei.com>

On Fri, Sep 04, 2026 at 11:46:07AM +0800, Miaohe Lin wrote:
> > @@ -1950,8 +1968,8 @@ void folio_clear_hugetlb_hwpoison(struct folio *folio)
> >  		return;
> >  	if (folio_test_hugetlb_vmemmap_optimized(folio))
> >  		return;
> > -	folio_clear_hwpoison(folio);
> >  	folio_free_raw_hwp(folio, true);
> > +	folio_clear_has_hwpoisoned(folio);
> 
> Should hugetlb_clear_poison be used here to clear huge_poison flag now that hwpoison flag
> is transferred to the raw error pages?

I think that should be safe.  is_page_hwpoison() looks robust against
that to me.

> Apart from this, this patch looks good to me.
> 
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks!
