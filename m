Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0E73BED73
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 14:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774534946; cv=none; b=qfpyFeWsbKSXT0/ilIPt8hbew9N+TUuzDk1DSb6GdAIAOGQ3otHcvfZyLrRT8CkaWHfT3Q4eMAxtUlFH7ISa+XviStw/f8h+R59ChcBwZuYZCMTHjon/Bz2Jm3wNQVKU5cj5Pi0dHUWejnnLz7nbN6ToQgvbzsIicg6YOSXYWNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774534946; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mzad/THwE9E/r/whSqOForlRjNwvO+UyZ8WlGR96cmH0n6fNpBgA9vTmh++eHERuP7HkeGg6EZevGkcGSl5bhWAZcwqczYuRh1L1qhnsNYDDFMIT/0FQg786KeM8IzZKCCc0OhF8BkPQTu+8U/aZDjpz7emSlaCUL3XpjBeo7RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=z66rAKqf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="z66rAKqf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=z66rAKqfrMH9ko2v8aqQqWTdYb
	br2AaW/fgGlENJZHAB8382qxE8omnhHPx7HveJ42lMb9D6kHSPskMfPX95ptVJ8BLeX8armgnEQx4
	7RUxQSrsXqug3sy3oBuiXyXkabnEYvwsB3nHmnfevuDlOKW5/9VCL9vfJqWUNQXEfS5eCn0tI5G1t
	RCzMoYAhX/ytQ+KevRv1l0d9eXVaPn5+EuSeOhEmCDYcza8s5bSop9JzV5kAnoO8nxmap9QiwdjxX
	fSl2RwWQAAkrYJsC/RNr/HPt7i2nT7bew3hmq46Dw94j8J5cb2fHNOYRG9Flm9uzGWqi/oSc++dgn
	9eNPSyQg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5lbE-00000005dXP-36eQ;
	Thu, 26 Mar 2026 14:22:16 +0000
Date: Thu, 26 Mar 2026 07:22:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 1/2] mpage: Provide variant of mpage_writepages() with
 own optional folio handler
Message-ID: <acVBGNGQ12QJK2xy@infradead.org>
References: <20260326140257.15908-1-jack@suse.cz>
 <20260326140635.15895-3-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326140635.15895-3-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

