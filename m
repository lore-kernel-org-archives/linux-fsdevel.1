Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1527F33938E;
	Tue, 18 Aug 2026 08:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787043018; cv=none; b=mHvaXSYB1evHMPD90ycCdAHdQeeSkrM17b8+1YtCs7I0xSkS82zG6aH3WO7YgT6SgVJLPsHPDS4/yWh1d1OSv0kKT5dKe91iH8+35ZilNfc8/wM1IbyjwJ9rM9EEmhMe/8mdJ74yH753mJouc5XSlOyTFaVkuVlvRQYFEq71NpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787043018; c=relaxed/simple;
	bh=0y9R3ZcmQ15fuELTXVpXDqeQEj3Xu7rICfO6G1A9Bm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J66Cj2iuO0PO2PqizYyjD4qAyXxHgwNY/uW8CW/hoPgj4QOTwbkKV/w2WSIuxG2dMviomAlyxb4PqZOQQPvyPtzAIeWN1tSR/EwRphnbcrOuAne450RGXH75t0POoTYaJNsTFyo7L5Iv7xk4y1fEhY9rTcV4W53jKR72sRBJGB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=paSv7V6O; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="paSv7V6O"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oN847bTjjDCpx4Fc/BriFXqA+Vaus4mgE8p723QmSbg=; b=paSv7V6OX0AmY5fAIa3/wiZiI2
	Anc0967S9TJA8opPdfkT90H8p9yBTa7nMUlur0UR8aRP0yEC2OAEm2jODnkoDpJoNfc2Tkzcqux+Q
	ykT5Iat1fnzx2loyYXzkOpyctS8louzeLp357vm4DMvSHV+r2PQP/vcHTT9ag6gLqrE3KKewJbzS8
	UO04BD32u6wnAlMvqauMw6qkA5kqH3rEvlPwEoFhfyFR02nIekX1sfVOcPZcmzmJpngk2AsEJgH01
	NwmZZQ0XJQU2OYIhFWk0lsG8b13gBAAgk95lOv/C4oKYTec3ilnz9aGFN6adxB6TNTBxvsPq2UTqu
	QritzX6g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwFWG-00000007YCF-3xXj;
	Tue, 18 Aug 2026 08:50:04 +0000
Date: Tue, 18 Aug 2026 01:50:04 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
	ansgar.loesser@kom.tu-darmstadt.de, djwong@kernel.org,
	david@fromorbit.com, amir73il@gmail.com
Subject: Re: [PATCH v3] vfs: add FILE_DEDUPE_RANGE_REPORT_PROGRESS flag to
 FIDEDUPERANGE
Message-ID: <aoQcvGw4UmkMKmUz@infradead.org>
References: <20260814082326.3756669-1-matthias.goergens@gmail.com>
 <20260817115609.3586664-1-matthias.goergens@gmail.com>
 <20260817115609.3586664-2-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817115609.3586664-2-matthias.goergens@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Aug 17, 2026 at 07:56:09PM +0800, Matthias Goergens wrote:
> On success FIDEDUPERANGE reports the requested length in bytes_deduped
> even when the filesystem shortens a destination range and deduplicates
> fewer bytes.  This predates the VFS hoisting of the ioctl (the btrfs
> ioctl behaved the same way), and changing the default would change an
> ABI that deployed consumers such as duperemove depend on: they advance
> their offsets by bytes_deduped and expect the historical semantics.
> 
> Add a flag to opt into the truthful behaviour.  With

What is "truthful"?  It just is different.  And you completely fail
to explain why it is useful here, instead spewing a weird AI-like
monologue just duplicating the patch content.

Start with why you care, i.e. what application or type of application
cares how much actually was deduplicated, and how you define the
user visible behavior of that having happened.

