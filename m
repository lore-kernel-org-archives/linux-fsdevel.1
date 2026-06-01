Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B13348C5C;
	Mon,  1 Jun 2026 17:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336143; cv=none; b=rfYpSjbc9dhQE0+q+6dgCZ0bAG7Ux2Mzpo479Nu9rLKY2L6oqKRuqbH53rIFd1wQ/F/zLWZlaAJT75jAT7NcFqEgEITZJIr9uBXu4CKOKR1LTK9tgEPDDy4sWrGq5/z+ehKve8PZPGxmtq9fohhhZm97fUIz3ADIfRYnpl7tu9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336143; c=relaxed/simple;
	bh=2fDVb0aHUepZO8YfamR0NQOQodqSlZukaAS70NRzAFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fa9pKIG3td7hxon9/stqNc8xlmgXp78DUCoy78UcwdvaVNXtJhH5xe8j1jtsvhB/etNNPZsXMkKgFmeyHRTYYTZyDJmr5dVCAyFbbDaWDezeBEZwAdNnJPLbcq88WkAxPYbbNs29s4+06hXqk6FZjVpaksU1YjpldJ8v/PsMEkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qVpxpP6j; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qVpxpP6j"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Qwdk/pI6z0M9pmHJY0eaojInR/B76JcdGEXnXVatnqE=; b=qVpxpP6j+td4VHBF4PDCfsm1mz
	8HSqXK3eJRsLFYmDMMbDHMC+4DTvLNmxTh17W8ksydYCJqNrYET6REyBZPzNnCenAxBwpPso1ivKA
	ZV1ITNDf1dbF7d/OkpAaNhqLF2E6jxPoOwE8L3LXYezLxoprYzYlopgd35mrDtb0IaJ4e7CeCrY6W
	5cDGwblQSKoPFj8k4kGBvn6J/FEc/KurTI5k47sc+Aa2gPX8d+xw+8R5fz2F3f8zIKi+5+XsxRYB8
	Mk/Xrt0YUQGPvoulCG6f9sI7qA2ha6vS2Zts+AXF9XOTJ/GK2JY4gdiSBilmVpEYxbb20i0jgFOWl
	EzuWbsOQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU6l1-00000000VXH-2AA7;
	Mon, 01 Jun 2026 17:48:59 +0000
Date: Mon, 1 Jun 2026 18:48:59 +0100
From: Matthew Wilcox <willy@infradead.org>
To: tanze <tanze@kylinos.cn>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	jack@suse.cz
Subject: Re: [PATCH v1] mm/filemap: use folio_next_index() for start
Message-ID: <ah3GC_Ho8IrGuq5d@casper.infradead.org>
References: <20260601110425.44784-1-tanze@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601110425.44784-1-tanze@kylinos.cn>

On Mon, Jun 01, 2026 at 07:04:23PM +0800, tanze wrote:
> Use folio_next_index() instead of open-coding
> folio->index + folio_nr_pages(folio) when updating @start in
> filemap_get_folios_contig(), filemap_get_folios_tag(), and
> filemap_get_folios_dirty().
> 
> Signed-off-by: tanze <tanze@kylinos.cn>

Thanks!

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
