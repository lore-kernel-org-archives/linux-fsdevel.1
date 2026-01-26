Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1781633556D
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 12:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769431490; cv=none; b=ET051Txa3WWQo97Zc3w3I+/UDQOT0tSBhkh0FftbFtnRc3s6uQk/1sTfopDqzt0mGpaNYBfQtR91Y3JkRSdGdeHMdtmWBIIvzNF8qjyd+v1W9Z69pnVTrbmW77GQeL945qExoFzZf/GYFBe+t9F1qF2xoHbz0gvJk6L0nXLRspA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769431490; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXJLUMArHfCzdUJnjg3/C/sHqbgyTFTG/uFkXAE6Eupqe3gF8BMlE8aqpW6ul6oUxXr/HejTRMyV6zK0MU1Ox77brwd1j8JmvtRCkFXW1z6XKOV/aK4avhqLGClzqFjWDfrZ1ziqvWypt6mrtf4H8KrM8zSslJ9ucn0Xgykp7LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uF/Aec1o; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uF/Aec1o"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=uF/Aec1ok4RqH1UIESZq3w8+18
	Mh2uafhINAgc2JGxmfOjlGpBIxCXPn3RSQZy7R+58AEIm5WHbP+lZBLDx0T/WOml2YBBvgbKtRZ5P
	/QrF3OXqO03LiLujD7ilJYcvdgeTFHArjEs8WVWPgzq/T5jwvyHjPWppXOwbphJB+YJiFdbqHgvln
	ftJhS2Jmbah7XKmFfH5hlkprae8WNT7L4j0TmdeofxvTiBKsdCp2/5kSQL6xFnSMZKhTdQDx18E4M
	r1U1L2+L90/nWHBnKTeuFbRDks2lr9YFuB7+y50HL1wDRmoR2n7PtYuipIlBhkb65jSBgcMOkMayE
	plGMhaKg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkLxT-0000000CZLA-3NuZ;
	Mon, 26 Jan 2026 12:44:43 +0000
Date: Mon, 26 Jan 2026 04:44:43 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: brauner@kernel.org, djwong@kernel.org, linux-fsdevel@vger.kernel.org,
	hsiangkao@linux.alibaba.com
Subject: Re: [PATCH 1/1] fs/iomap: Describle @private in iomap_readahead()
Message-ID: <aXdhuwnv2p06VWwE@infradead.org>
References: <20260126120020.675179-1-lihongbo22@huawei.com>
 <20260126120020.675179-2-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126120020.675179-2-lihongbo22@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

