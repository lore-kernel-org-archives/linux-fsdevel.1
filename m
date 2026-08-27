Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B0B1474CC
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2026 00:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787789174; cv=none; b=pVZc2ji4rEWSa0BLbO7L94MQhbp0RymKlrpAMl2itRBLsMTDd0tEUXPnwmsYZ3MI9vGOW2VvkuL4LFkZNQVMmzW/a1LvzIaJZYlNFU+7YzEgabCekuRCx7cJtgppdKFMOefng5ZSe31MUdeRN44wqtjBgqEqFflBFT24TOG4yYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787789174; c=relaxed/simple;
	bh=IUn1+S3qaqYsNqOr+tXl0fC6Fff3g4AuOkIn4oENhcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfkNxzvTVoLkwxI8i+I2h6MJfJ8kGJAHV7qj/sA1vZV/XZxvT5Rifz/5IJQhxYm9mCyDGftKrUzUahZT2TcwYFNF1th572KIucSQuor87uzBlH2pqAuYTtEByVR/zRuH0ZElPOyVsOsFYDBr7yxo03myiX94kGkqjKZS1D5ATzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UM/UtkDz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UM/UtkDz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IUn1+S3qaqYsNqOr+tXl0fC6Fff3g4AuOkIn4oENhcQ=; b=UM/UtkDzvS0lPveu7ouSY8LSwb
	6pvrdgen2UjGW4H1yKjDfVUaIU7n/q0GiOO5GNHFoq/zwat7bV3ZXj4DSjuJ/PPLhch/MC3Kn3Egz
	bq5SKElU73bPhGrICCFsOODJ5SSotDGP/bMBoa1zN/C2x0Sk7DzzvVoCCCUidrn/GEbhpFq3B4mEV
	fKxgbaEe4370LDP4BZrCyOkYbUYUHnOKVDGJXjyG0hvbCuUN1w/MBZPxrMCThBt+NTWQk1+gSFIym
	cGNn4nf7eZuSvV9rrOHj9i2OxR3lm0b/R+0i+MWHts3pUlacNdZPfBZIEF2tDEQY6nSIxKyflGEB9
	cmcHcyBQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzNd5-0000000BevH-3GoR;
	Thu, 27 Aug 2026 00:06:03 +0000
Date: Thu, 27 Aug 2026 01:06:03 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, hch@lst.de,
	linux-fsdevel@vger.kernel.org, vdubeyko@coreweave.com
Subject: Re: [PATCH v2 0/7] hfsplus: convert regular file I/O to iomap-based
 operations
Message-ID: <ao9_az3JPNhHooMl@casper.infradead.org>
References: <20260826225614.486112-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826225614.486112-1-slava@dubeyko.com>

On Wed, Aug 26, 2026 at 03:56:07PM -0700, Viacheslav Dubeyko wrote:
> Christoph Hellwig has detected that taking the page lock around
> the kmap/modify/kunmap section is not enough on its own:
> writeback drops the page lock before the write actually completes,
> so a mutator that only waits on the lock can still start rewriting
> a page whose old contents are still in flight to the device.
> Mark the allocation file's mapping with mapping_set_stable_writes()
> and call folio_wait_stable() right after taking the page lock in
> both functions, so a mutator also waits out any writeback that was
> already in progress when it acquired the lock.

Why would you indirect through the stable mechanism rather than just
calling folio_wait_writeback() directly?
