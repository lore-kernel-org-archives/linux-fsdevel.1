Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4DD423E9F
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 18:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190002; cv=none; b=rOB+6uroKktdMag3CSrbPbJ0Ip6SJrOe6EYM991fmHyQotU2deA70dq7aU0g2gVGC+wwvzJZmoXPyUwqxgws0IoZHTA+qECWZFgq2pB0SZx6w+rT4LjHxZtwgjI48Lf87ygnFzvzjjCvyEtsT8oQ+BiOLTlDH7CUISAtbmgP4cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190002; c=relaxed/simple;
	bh=3KcD65CsMCJpMUlIcYtRP3z6CpHUHem2ZkUgrBxjaNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9kyG2R56zyDPV5HnWwV89xeEXIONvQJwdOuLiALISoC71HDK6oZKcCkkWaNjR9HpnHmfVLuLpEHNTgrVVp6aw98T/xDUSXnLcwHPOv30UZIfawKXdQOmJ4mwH3/5p+1ZQ6gQ+CzVuJoUZbsXdaUJeh/7rR1mX/zrbS1PlsVV5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FMo0I0mj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FMo0I0mj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AxAHc90wfm9SnYwgDzQ3lzFeh2jo+c35yDwusOijFh0=; b=FMo0I0mjZm80/tjeOHoyWLWDzl
	+JuS0LUThspgxfePa2m6QvZFrVS2IkL+fMSRLNOGnm9aK2VsDTg7WzZFfIFia3px4gILuUpp2t8UQ
	tR6TQDgjn1eveDqqZ5pPLymPIHQuWVryk1YIFw66DQ5XHmCNAgFfQB62LewPtiZ2y52cIfLOXK0zz
	BsKjJl2nJ858Zb6VNfGOLDZwwvq/DYzSN1trSEYTOv4Gzmpq67PSxlxjLdCiEAwWsBrULYuhmlWem
	Dduf0jWFkxom2bLboq32Mh3D2rdqxFOHzyxgfq8ak/0OCMAnfz7iwwWX/RpUFmovH/InQrYrhF6ra
	BGNX3Tqw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9SC6-0000000EAf9-0aJx;
	Wed, 23 Sep 2026 18:59:50 +0000
Date: Wed, 23 Sep 2026 19:59:49 +0100
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
	Jiaqi Yan <jiaqiyan@google.com>,
	"Gregory Price (Meta)" <gourry@gourry.net>
Subject: Re: [PATCH v9 06/15] kpageflags: Use is_page_hwpoison() to set
 KPF_HWPOISON
Message-ID: <arQhpW5tKmu1Vqrh@casper.infradead.org>
References: <20260805210557.1118966-1-willy@infradead.org>
 <20260805210557.1118966-7-willy@infradead.org>
 <3e609c64-a393-4667-be74-6cb2bbdcb717@kernel.org>
 <e68018a5-a8d0-4ca6-b3f7-7a151d17be31@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e68018a5-a8d0-4ca6-b3f7-7a151d17be31@kernel.org>

On Thu, Aug 13, 2026 at 11:01:02AM +0200, David Hildenbrand (Arm) wrote:
> >> +	if (is_page_hwpoison(page))
> >> +		u |= 1 << KPF_HWPOISON;
> 
> I also just realized, that other users in this function now use BIT_ULL.
> 
> > 
> > snapshot_page() takes a snapshot of the folio and the page. If you look at
> > "page", you start going to the live version again.

This is now:

+       if (is_page_hwpoison(&ps.page_snapshot))
+               u |= BIT_ULL(KPF_HWPOISON);

