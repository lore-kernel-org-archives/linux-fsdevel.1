Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288444B487D
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 21:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790025600; cv=none; b=AoIVs1lAwqb0AxSVKYPcdNJ0IMzxl7juzTqqkeAZJntdtl2vtl9khCo0Q4dzjQ2W8fPkteYvXhiIiLcCMVVvayxvc0J7HxQJN861xVEidmPa9Rmhb1Uf2iKvCARaQJASOu77eys/gP/yhcnlMavxfOegwH1JCyWDD7caqNN5bwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790025600; c=relaxed/simple;
	bh=xVGQt5MuV3cUiZxUeOR9+A+ce+0m4H6k5p7si+ipYfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRH6hStzeQRzmiTa/cHghY/TDLM0Ws1g1JSqeohlEXM/VTILU/KCIJ0JUhDw0SsiSpDwDIiVGgZXz8/huYzEdQyPPUW3RQ5se5hYMoQcCEC5ne6O1vPRv+dJuvjMowJT+cvqFe/OqdweT8dEM2fnBxna93MgRNEQ4fl2eSAwGVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BGqiyqf6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BGqiyqf6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RsKa6xtGpVrKjIKV82En0dvWYXbJt5+yoZDKyIsIQkI=; b=BGqiyqf6xDxb3nrgigpwzr6zw0
	TsULh7HP4rRDfVuvJZdXyMBCWNYoLFwJiSlbb8HEl/J0WO3r6BYhGCrzTBGM1dmzVPFYwffeddwew
	LOapQ2TrqU5dhgRK/8UbAPF0yTfcj7GtckO7RxKUx/lsw6dI3Hd45zbaJ0xTLFy4ryv2ZQMe0OfQi
	83tGp3Q96YEkmcZ05AySXfFa8mIn3HFEbWVXWyqaqi2rVRKGyPZMhT2Flx3KpsU2VMe3qA9MR2Bof
	J5ImoJnfCyBOL7PuiDVZnLRRoPYg7g5OeoL1RdcRrfoZY/dZtqK7ZUYjfnrHibyUTrA24W4U76tiK
	r8cHKrhQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8lQM-00000005Xnu-4A8c;
	Mon, 21 Sep 2026 21:19:43 +0000
Date: Mon, 21 Sep 2026 22:19:42 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>,
	Jiaqi Yan <jiaqiyan@google.com>
Subject: Re: [PATCH v9 14/15] filemap: Add support for authoritative mappings
Message-ID: <arGfbk5Yv9UTlNqB@casper.infradead.org>
References: <20260805210557.1118966-1-willy@infradead.org>
 <20260805210557.1118966-15-willy@infradead.org>
 <0e0a0908-8e5d-4cee-9fbb-ce730bb662e1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e0a0908-8e5d-4cee-9fbb-ce730bb662e1@kernel.org>

On Fri, Sep 18, 2026 at 03:51:59PM +0200, David Hildenbrand (Arm) wrote:
> On 8/5/26 23:05, Matthew Wilcox (Oracle) wrote:
> > +++ b/include/linux/pagemap.h
> > @@ -210,6 +210,7 @@ enum mapping_flags {
> >  	AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM = 9,
> >  	AS_KERNEL_FILE = 10,	/* mapping for a fake kernel file that shouldn't
> >  				   account usage to user cgroups */
> > +	AS_AUTHORITATIVE = 11,	/* If we miss in the page cache, it's a hole */
> 
> Just curious if "in-memory file system" would be a different way of looking at
> it. There, a hole in the page cache always expresses a hole in the file.
> 
> 	AS_IN_MEMORY_FILE
> 
> Just an idea, because that's why I always had in mind regarding that (all state
> in memory).

I suspect that's always going to be the case, but I don't want to be
quite so prescriptive.  I'd rather describe the property than the user.
