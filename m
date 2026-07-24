Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81915456E17
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 16:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784909751; cv=none; b=D/gQgRiDVXKNgffRe/UkeRNAq+BDokp3Hh9o5NoX0bDDKwDGXQFQb4TY+xuZ5YCieE7KjR+21mq1DSr3Xo2EpjHmWl8T9yV+NftyyEAixdVf2+7KxVqutfyAoWiuv7xxNgW+EQ0+Ji6k1CuKIqqAlbMsdNQ+/qpNUz4Nf6kjSt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784909751; c=relaxed/simple;
	bh=51KJHbIf7JheF/TQON1Nt2IkrAoXsCVlhhd1llA6W+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVac7fcy2hl1Nq+HN3g9Hhdin81qlJIwOMrFEvw0nYh0KJSy6cMO/lqZQuhQlIyULOqIv8gZZF+kn84bsajKLof63TGUTmfS1bgQHYvWZBN6bm50k9V9GDFtZosC2MN9bhfYch9V9ugCctMxFhU4/CfQvGAY1AP0UmxoqYP+1LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kI0Hv0Lu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kI0Hv0Lu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=51KJHbIf7JheF/TQON1Nt2IkrAoXsCVlhhd1llA6W+k=; b=kI0Hv0LuOACoyAzgS8CUk/Ex2m
	Den0ilnMsK3bgo1B8LYf2YhaE65vJVCWWaRmslS74gU2uW5ZOL1yL9GCHIjdYwUHek/LbxCwaQThC
	qt87qrTL3t3VgaRuL6CGTaVx34VoOZDhy96seeAzYe3lEAAfIgTRgzzRp4DkG20nrh4LF7IArlcat
	GvyU0WSpIT39snbPOdflEKRog2eWGCfcsuyIZeuFH24yIY7/NoRbHSS5ePEo3AmqIyPRjkvx4Z3HQ
	gr/Yzz7uo+PLFCR1LbIPMbC8u9nuUtDgkZFG49uPtfRaj8XdTSMmoazX4N1qTP12GeZ97gck1wZpM
	8a2T655w==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnIYB-00000003tNF-2Shw;
	Fri, 24 Jul 2026 16:15:03 +0000
Date: Fri, 24 Jul 2026 17:15:03 +0100
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
Subject: Re: [PATCH v4 13/14] filemap: Add support for authoritative mappings
Message-ID: <amOPh_oXhrIE44nE@casper.infradead.org>
References: <20260723143034.175661-1-willy@infradead.org>
 <20260723143034.175661-14-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723143034.175661-14-willy@infradead.org>

Sashiko review identifies only a problem identified in the previous patch.
