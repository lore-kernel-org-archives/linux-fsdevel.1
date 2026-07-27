Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D49348C7C
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 20:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785184091; cv=none; b=iC6csa+OosGxPzzLuf7VV3OyvYh0hQ0p2xKImWBilI61c1aa187OMTeJCgT6m9d5S67kvsOy/t4euov8sGT5WLQby2RuMye21qb66iB9Gm/3T0+ptstet1fqUvgE1ApNt9JwxChYQN3LnkIJnvJu1wTyaKnPr0SAFxADT/HYXNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785184091; c=relaxed/simple;
	bh=wrxCJ7U7RKSY+izvIpgXpJE2dp/4OXbtvj1HPvdfB5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uT5iabxl4afj+sLUWatIqxNBnZhPC/E0Kck0Y4wbsOUF0UYpyWGhnPSYzqBN9xhdBTYk9EzXOAUa3dC3UwBAQCrF1mWYmwdfn6WXXYxxHEpRvbcX4soqmsURX7YP0yS+jM8JZDlTc8z4oMJdlRPKTNrPk+fb153+Ct5bQLpWINI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iuw6Pkpt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iuw6Pkpt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=C798dAa8fw/QYuryBKFnwSYvO0o2tExwKWEloLNlk4k=; b=iuw6Pkpt/Riscm6bIYyF1Pg/fA
	20IED5i22Z4fUJhPAxkUChEfggKUFosybNALvSvNa3iFaYo1CD0P/7hlQoUdCV5XKCFw/2Mp7iTy8
	311VJxGtq5jQpOd+L4qJ+XffqjEWZoDN8TgWbyfmoO0YzNJ5T34sjxYBQV2sr5c/87D9Md3stPV+4
	ZC8nl8VbTfQ5rn+uu3g1k0q6mszgqzHAo18ivmSm3322kYCTDj5m0aBhZJz2F1TUlw3LoVaUuxOmz
	p2nfmP5vfuEPFC4HBX8I2OyHVpuOD4+LAclEE8Zv/BEhZiGD4L2p8PRP2ECSTdcgFeqs2hnTnzWAh
	EQi3jJRA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woRva-0000000BOw3-348l;
	Mon, 27 Jul 2026 20:27:59 +0000
Date: Mon, 27 Jul 2026 21:27:58 +0100
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
Subject: Re: [PATCH v6 00/12] Use generic_file_read_iter() in hugetlbfs
Message-ID: <ame_ToR5rr3m9x6V@casper.infradead.org>
References: <20260727181310.2671972-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727181310.2671972-1-willy@infradead.org>

On Mon, Jul 27, 2026 at 07:12:56PM +0100, Matthew Wilcox (Oracle) wrote:
> This set of patches are separated out from Jane's earlier series.
> https://lore.kernel.org/linux-mm/20260617172534.1740152-1-jane.chu@oracle.com/
> 
> We need three things to use filemap_read_iter() instead of a hugetlbfs
> specific read_iter: hwpoison handling, treating gaps in the pagecache as
> holes, and having hugetlb set the folio size in the mapping.  hwopison
> handling turned out to need a lot of prep work; the other two things
> are fairly straightforward.
> 
> Sashiko complains that the implementation of AS_AUTHORITATIVE is
> incomplete, but hugetlbfs doesn't use any of that functionality.
> We'll add it when we need it, either when hugetlbfs uses it, or when we
> convert shmem to use filemap.

OK, down to two Sashiko reports that I think are real.  I sent diffs
in replies to this thread.  I'll give the meatbags 24 hours to look
before I post a v7.
