Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EDA46BF
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 05:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769406394; cv=none; b=IvJE2rN050JTqh6ym1+ZaZB1+rXiAA6juFBgK+D0Vo+xhl66T/xTwu2I90xzenvKpPXauWulnDicMRIRKg+hUSdOfj19TXadMlaMfe18I8995sTS6A5GKeTHP/6ZBfDFw9rzBFIDCWuk4GbckUb6JHZAO4qXLZNbCjf09l0uW4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769406394; c=relaxed/simple;
	bh=Xd3pZlfI4YB7FzSx3RCRry3t882mbjmByz4smpZouRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZ1wzGtTnneH7cWArG0B+pJ58tOi65JfytZQmgKoJ6RKwe7LX6YrrnBPMETN0U2HcQbb7EWyMrAy9EiNMEljLRoA3iZTxo3M44HJmNAami21qCtUK7NnuPbdDRGuKLjpmFZLXm7cA2lGDk4Uub9a4poMCz6phTxoa/8fHKkputM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gYt+iiMx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gYt+iiMx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=D4vNgnuIZ22VZkmqCzXAw4jNIslSPxWHauJry15J+2E=; b=gYt+iiMxvsQl3YNt/Ez4KKslik
	HPTDt7H3PsI8ilj5bNhhanKDx4D1byUoRVu0Ec6eP9aJth9E9kT0v/Na3iWuOP8SmAFxv6dnyBgcb
	mEaQwzg2BIy8ofogwxSmO0iq2VUJpBWYJVumZH539Ee/oNdFf9c2Q4kZ0u3CUT2PT47s0+LELg7cn
	x6zxMqhn5OTPE4+50JM46AfDlPyqiNtsaqXF52NkTck/8Pb3lkjeqIldRMy4vc1cfgBGpfY5+WkrQ
	hnt6pmFrYCINriOYNT6eQXGpBdSoZH+kJjjDlr2P25xSBY57SMsjBufpR32wmf0RtOnZcl1xv2ReB
	5c9zXyyQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkFQk-0000000Bwz6-2Hcb;
	Mon, 26 Jan 2026 05:46:30 +0000
Date: Sun, 25 Jan 2026 21:46:30 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, willy@infradead.org, djwong@kernel.org,
	hch@infradead.org, bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] iomap: fix invalid folio access after
 folio_end_read()
Message-ID: <aXb_trkyt-uzdIkd@infradead.org>
References: <20260123235617.1026939-1-joannelkoong@gmail.com>
 <20260123235617.1026939-2-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123235617.1026939-2-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> -	if (ctx->ops->submit_read)
> -		ctx->ops->submit_read(ctx);
> -
> -	iomap_read_end(folio, bytes_submitted);
> +	iomap_read_submit_and_end(ctx, bytes_submitted);

Can you drop this cleanup for now?  I think it's actually useful,
but it should be in a separate patch, and creates a conflict with
my iomap PI series.

The actual fix looks great and simplified the code nicely!
