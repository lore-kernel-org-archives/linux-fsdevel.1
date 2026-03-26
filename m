Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1D737CD41
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 14:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774534980; cv=none; b=UO59jEOwMr8IYcihZd/6kX4H3UjADBlGnxawT6vJjNTgM06iyVdMA/nKOohn85rjw3PN8Co9TfXfzdcmQ9uFPUrpnsdNC8mUtB9jjogVCdykJZIhlLedLJj9I/Or9Rq0m4HUwbbaUdBm4VZ5EAS/+xiwGXT5hXY8gDsF2DtvJ6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774534980; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOzVYBDYUl+x5g3rUbUF9BaWOMhJKwjFAbSL4ul+OVkFHMyxpV9twBQFRi8pieoXSIREkJk9K9aumsTUOnliCfwAGt74uDd+iy+6O6sv6/nqKmR3Skxjoj8e7to2T2tgLFgtewpbsnlCjoWfQ4oyF7wYkXF5E8MZqT5S0xmTq0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wtbtWPd0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wtbtWPd0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=wtbtWPd01anyoVA4ZFANFd1rph
	fkUYuAQwTw71hza+CIAqz6wBQUKtP23TxT4NvvAwEohm12PJv/f8z+6vzqs4vgMbrDTL1EGtlZdfn
	Fm01SEfHBWFE00IRoAkIC+42G9md4qC5YgUpcGaepM/cVFxqFjOlbJ7zL9QDoRNxleZyqibktu4L6
	lT8/2RRx2JfSmLt3OsF04f1P6Bgnv8X3HAPk4xAKqomqeLtb2fyaDk1rFj0njkI0PxQyWVIO0aruM
	dIxiMiAzJcnMPxUbt10SNbPMpwG/iM+ITQYqmm11tp37XLydhYq/jJlgacELD86BY1i97rgscZ4pd
	2m4ppRag==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5lbs-00000005daB-0pRo;
	Thu, 26 Mar 2026 14:22:56 +0000
Date: Thu, 26 Mar 2026 07:22:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Jianzhou Zhao <luckd0g@163.com>
Subject: Re: [PATCH v3 2/2] udf: Fix race between file type conversion and
 writeback
Message-ID: <acVBQGok-aP06H-F@infradead.org>
References: <20260326140257.15908-1-jack@suse.cz>
 <20260326140635.15895-4-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326140635.15895-4-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

