Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3523430E82B
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 05:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769490649; cv=none; b=TB34fxe9xgO/MC6w6yrEsYt4mVBkqwNzPBkniC6JkoPtLLiOVHefhb4uvhyupKeYyZsLJ8R/8r03lrJPeQqi4UqPOxZhBsRmEDvDd9iD85APZZITRnUArIwFx2u2bSaA8AYraDMPXE5xM20EdZL6civr2etrqOwu+7UN85i3APY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769490649; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVJJa/1+71+tNoy+WVGTAK+Uf6cThMrTI7wmp7whYehbv7S96M7hbTTwajGkBhLRo6mbL/s/uMac6GoSTlyEtiRyI8R8u1kL897OVo5KG/fYaXv++ACdD/gZuChqUi1x6jH+HAaWccgTWUNdRqHPYVqwyuW5hxlFB/iNR5JGdys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EGQZD4MB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EGQZD4MB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=EGQZD4MBR2Y4FkA1EpKkH/fCkF
	mih+7XT67lArp0n7BVCQFztJRPlRxuRs7Gf6ph6T8EE3ezlfNuVa8rmY3VNKq0NKuDD6ecLMCdkU1
	LGKDjsN2HtTl44DYprRQV/y26BcTX+D5TpF8anoIERK3cWL0guzEA+cZxbtuILHdWBUupl9MTTxpl
	z3qzc/IFuOCiSP/tC0hNSlRcG6hPvJDFLcAGG1Ixy8NDg2eg++AEDNlUdZZ23DPyG4vBCE7vHuil1
	NELWsyKnAU8LCqQLs7hKUbgsH9dhdh1XypZFTwZUKV0PHzlw+/cbT4YEuL2WnrZlqL0yZqv42vH6+
	JDFMvPlg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkbLZ-0000000Dfrp-1RUa;
	Tue, 27 Jan 2026 05:10:37 +0000
Date: Mon, 26 Jan 2026 21:10:37 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, willy@infradead.org, hch@infradead.org,
	djwong@kernel.org, bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 1/1] iomap: fix invalid folio access after
 folio_end_read()
Message-ID: <aXhIza2Oo_O99Vbi@infradead.org>
References: <20260126224107.2182262-1-joannelkoong@gmail.com>
 <20260126224107.2182262-2-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126224107.2182262-2-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

