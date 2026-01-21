Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5592BCF4C
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 01:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768957638; cv=none; b=HGT5RPKjxThIebC630lfjZJc7GXUHMakf5jDhnZx8tzqI34HuQZDN/TEkHW8NqrmuWTZ8Ev8Mjafo41vTLFo72CDMsLO5lwBT+ZNRJvy37VZdwl3wsAwfWoZC57g8o/yyo6ok0mSoWDtd0YulWjOxJQjBHyKHUNlhvDyoOc7jXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768957638; c=relaxed/simple;
	bh=4x1KsmHsBSngbx85jWT9fFs3J5EUrtzGPGU+m9EmN2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmsCxpVvjvAUTHDegwKdIDVTyEX/VY/eNbGsIPKyMKUC/sYzHmrMJZwsJt+HLh/jDy37HG2IGVJyOAhKZFDTsospKUoFf0qSFBpkvZGV8MkGwCYqomU1pOXGaCNV9wfUiaAG3Xd0WBKo8CZk2pIqP1c5RSxxeI+ywO+2AuIICJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pCopAwdN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pCopAwdN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=d2EOAfaB/wm2Ixr6PE3ztyaVxd+flPCDdKbqraVnKJw=; b=pCopAwdNIipooXM80kTt/DOgu/
	sDBW0JzjJWEPnT2Xu1VQ5xjMPnFNPDO0wLyHbr/zHBTraX+PwRNMs0LUm3a0wfWrfR4Wap/Zta+6H
	FZk/RmMYHjvFHoDuGk7R6qCVscTtnzA1YqoG+UKcQ08B6vSX9ng9rp8RBWgoR9c5E/wCmCdduytU3
	P98kHO32FdiWDAl5vS/uYKPqk39C7pNNfa5ObMmUmrp0O5w3lAAIf6o0rLzoGRnoYaJninD3rkMhZ
	nSeVnBPt1yxilbaxvX5OvIdv4jAPmxrKX8Emt0SpaUeTYG/P7bA3ZJdCyw7z+w2szHVq2w/FfAEqe
	S5zxnXFg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viMgi-0000000Fh8n-3mqv;
	Wed, 21 Jan 2026 01:07:12 +0000
Date: Wed, 21 Jan 2026 01:07:12 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, brauner@kernel.org,
	hch@infradead.org, bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] iomap: fix readahead folio refcounting race
Message-ID: <aXAmwHNte1TvHbvj@casper.infradead.org>
References: <20260116015452.757719-1-joannelkoong@gmail.com>
 <20260116015452.757719-2-joannelkoong@gmail.com>
 <aWmn2FympQXOMst-@casper.infradead.org>
 <CAJnrk1Zs2C-RjigzuhU-5dCqZqV1igAfAWfiv-trnydwBYOHfA@mail.gmail.com>
 <aWqxgAfDHD5mZBO1@casper.infradead.org>
 <CAJnrk1YJFV5aE2U6bK1PpTBp5tfkRzBK5o24AhidYFUfQnQjNQ@mail.gmail.com>
 <20260117023002.GD15532@frogsfrogsfrogs>
 <CAJnrk1ZSnrMLQ-g4XCAhb1nXBWE_ueEM_uTreUNxuT-3z_z-DA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1ZSnrMLQ-g4XCAhb1nXBWE_ueEM_uTreUNxuT-3z_z-DA@mail.gmail.com>

On Tue, Jan 20, 2026 at 04:34:22PM -0800, Joanne Koong wrote:
> But looking at some of the caller implementations, I think my above
> implementation is wrong. At least one caller (zonefs, erofs) relies on
> iterative partial reads for zeroing parts of the folio (eg setting
> next iomap iteration on the folio as IOMAP_HOLE), which is fine since
> reads using bios end the read at bio submission time (which happens at
> ->submit_read()). But fuse ends the read at either
> ->read_folio_range() or ->submit_read() time. So I think the caller
> needs to specify whether it ends the read at ->read_folio_range() or
> not, and only then can we invalidate ctx->cur_folio. I'll submit v4
> with this change.

... but it can only do that on a block size boundary!  Which means that
if the block size is smaller than the folio size, we'll allocate an ifs.
If the block size is equal to the folio size, we won't allocate an IFS,
but neither will the length be less than the folio size ... so the return
of -EIO was dead code, like I said.  Right?
