Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB9E418A30;
	Tue, 28 Jul 2026 13:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785244935; cv=none; b=T6IP4YMD3v/wn/13HqGplYNAdDNmzJbMOcdQ0gKJw4OnnXnXVMv/P3bThwQUKlEwJ1g4Ex8CG5igsKN3ezbOWd/DfLOBEGedr+PTI8iXdiMaXke9Ju90vzesiDz1Euu0dwC3xWZvkpe/7TWZcbw9KHlnkGgq3F4CCMOc892Rtr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785244935; c=relaxed/simple;
	bh=EuJ+24wMvEjiTGvRpiGvYYLkgozeZAl9Pt0eOWktyvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYQeWS85B418+1PICceEfi7i8Q5ZeT95nWmFgvjdDFNVyu3IVBZv50E8tujwhHlsqxoUA1jmBBqXGbkCA9bSj9j68/U4f626N0m22c1loLItU6/5CszbYc1j391cZopw6QSfy80eRRQt1TjRBUVBa5PFziuGNHGvHx5FIHAhSM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FrPIU76G; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FrPIU76G"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1sJavEPudU+OUEHx6GFAB0ZMrxFOTjDav1o4MCgxz9c=; b=FrPIU76GLS5DXSBE02ydrmWMJ9
	Pgsno8a+Xt51jt/rM/d32DR8Pjs5vU+CDoRCN8xjNu3e7OYu0QkXevaITuKQU0bkX6jZXVkW+av50
	1cZsY6xw6ytvzYFsRa13dqpgp4E19xOr92mJDmyzyhR6/84UGQ3kL39Tl+J/oqi9GwVucquawcA3+
	Uvyk837KZQ8Gww98DQS1+txFrTxkk5td09vxtvMNfQY72dMfMwN8Jr7KQTOu1Dm58gba4UrEbwD1n
	1uuNXpgFJjJCxZFMijEYUM0K4mIi9mZiSIakuaJajNIp4ULuv1dZtxwFY2CD+/9mDCOQpWWsOSHXj
	LWnespRg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wohkz-0000000DIUA-14sL;
	Tue, 28 Jul 2026 13:22:05 +0000
Date: Tue, 28 Jul 2026 14:22:05 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
	Kairui Song <ryncsn@gmail.com>, Jan Kara <jack@suse.cz>,
	David Hildenbrand <david@kernel.org>,
	Kiryl Shutsemau <kas@kernel.org>,
	Chris Arges <carges@cloudflare.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/filemap: __filemap_add_folio() restore index before
 retrying
Message-ID: <amis_VNEmkifOAoI@casper.infradead.org>
References: <562fbfa6-dd6d-0b6a-2461-ed2ff1173bc8@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <562fbfa6-dd6d-0b6a-2461-ed2ff1173bc8@google.com>

On Mon, Jul 27, 2026 at 10:24:14PM -0700, Hugh Dickins wrote:
> Production was suffering from rare SIGILLs and SIGSEGVs, executable text
> found a page away from where it belonged, !folio_contains() bug hit when
> debug enabled: symptoms not seen since this patch went in.

That can't have been fun to find.  Thanks, Hugh!

> Fixes: 200a89c159a7 ("mm/filemap: use xas_try_split() in __filemap_add_folio()")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
