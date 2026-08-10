Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A843E431A3E;
	Mon, 10 Aug 2026 17:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786383417; cv=none; b=ZPqaw1+VlIPkRFVOWXz4xILmKsijcz21IPtZE4BbJrLIuvpT/H/o9spLiMkcAv8ChKP3BI7gfGoIzzdsuIEZApGsH3v7QmXzzTe3Wza/vdliDVNfG0iYzJmarcloejpqwx2lx8prIyHdZjdUnUMRi4NJXCd2+5u6nanJ/D+iQfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786383417; c=relaxed/simple;
	bh=td/Ywf2pair9AI/oS1fM5P5312l8ol5DkJBkL1WbGdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5zvX4sdjNvk6OK5tXtz1HUlEUMC8MCFzzTH1m34Pu8VReajmqsGM4xDLPPfN6N/CwG+dpNiHGj7F4LiSB5G67YECVw6geFLJwkzZnSRfVMJOvmD9gwWDKEPCvPCjS+14lNkzVYsO23gRsKCKl+vFxV+EczLmfubLeluwM1N07s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HTMKTmrB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HTMKTmrB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=td/Ywf2pair9AI/oS1fM5P5312l8ol5DkJBkL1WbGdA=; b=HTMKTmrByhqE4dP2zF++KyGzmR
	dlftD2bzy/cjr1MXcgNkUHD9jhpsGZxGfjVA465yrF67SJ1Q7NCqaL46LGfZFxGg5XX/Ad+vb9S2Q
	Jsp2Erz+pigdYa8djEcQGKNBpYrw7ks955wIgI+jtlqEBIcFY9Gl2Ecl9s1Cm43LzcYwjmqDIQeUO
	yCptljuWi0qLcZ7eDBlSR8/YMHihH5tTCfTC3rV7V+brZFpmW1o5svPQYzZBHukJt+gSuSQ0pUIFL
	bHQcy3TtB0DP9G3BepFuN9Ivl2bFG0UnAD6tI9nhel7zplVKrKJknIvlCxEFYbp7zswNMmjTqL8nF
	lF+ZmZGQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtTvh-0000000CXW1-0n5U;
	Mon, 10 Aug 2026 17:36:53 +0000
Date: Mon, 10 Aug 2026 10:36:53 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jann Horn <jannh@google.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page-writeback: document folio_mark_dirty() locking
 more explicitly
Message-ID: <anoMNezqJ10YgcoN@infradead.org>
References: <20260810-set-page-dirty-warnings-v1-1-53cad4890808@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810-set-page-dirty-warnings-v1-1-53cad4890808@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Aug 10, 2026 at 06:02:36PM +0200, Jann Horn wrote:
> I have found two out-of-tree driver bugs in the past where set_page_dirty()
> was used on a page from GUP without appropriate locking, leading to UAF:

More documentation is always good, but out of tree drivers are totally
irrelevant for upstream, so please reword your commit message to be
relevant for the kernel itself and drop these references.

