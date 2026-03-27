Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBE334A3DA
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 06:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774591869; cv=none; b=OPdOw2J7s8J265wFgE0EZP4eKv4BOajFEESS4oO4Fsm27ZvsDop5yVLqop3cHHdH+Dp9231UBsGy5V3STA0JBh9suFPrxHCMhJaMsG5JijHn2xKYwTpL/G0TN3Tw9fsX9hwxlKC/r0wt+yVNqrh9orgSvyFX5koOX4HlqAdeJTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774591869; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZcNEDTJ9p7NjHNX9vBjdJcYvlWunEiyCw14GXKH8/i92I3oWgosKpisSyGvPvhvoBEtS0V4PlQM/K8WSoBGsg/os4AUboAX5FFpFmMv34LtMgkzGnPwhAKDEPJmV/PzvExsMYBd2zDXv8RuLVXsampdmxUjXa9KX/2oNe3pE+VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1QGou0Un; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1QGou0Un"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=1QGou0UnUgt5Kn1tS8XmgPeJ5t
	jwk4VtKUYMIHyAo9v8y5cC295kkfOj0IAWUE7TV8fAU9IXqjpDvWRP37iKFW31Fqh9cle0FpItJx4
	Yz4kkWOK0XImvDZK9XonPvbzAs5Uo0A+t1tiZ5Y77MnxRaTWM2v7ZSpnExlrQ/flfkgSYOrl7BEP/
	PUjHw0vHaHEKs+Hu9B33VZK8sT8PgIPb3J59+TLfYa/4zNqw8mNlwy62P6jfBjUMBH/+IsG6cxokq
	tBV6Db++j2R2bvEfNPD1uZ6fCmZtl9OY56diFKtVWHdTYADzHB1qRzB19tmb/dGdkevPjazOJOeiD
	VEoLi/Kw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w60PS-00000006k1p-3B6y;
	Fri, 27 Mar 2026 06:11:06 +0000
Date: Thu, 26 Mar 2026 23:11:06 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: akpm@linux-foundation.org, jack@suse.cz, hch@infradead.org,
	hannes@cmpxchg.org, willy@infradead.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] mm: reinstate unconditional writeback start in
 balance_dirty_pages()
Message-ID: <acYfep_yPp_Gg_-d@infradead.org>
References: <20260326215127.3857682-1-joannelkoong@gmail.com>
 <20260326215127.3857682-2-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326215127.3857682-2-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

