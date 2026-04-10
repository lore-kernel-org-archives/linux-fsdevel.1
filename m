Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943E53290B0;
	Fri, 10 Apr 2026 14:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775831923; cv=none; b=FNNIitrGlhPtIvipuIZ0hePdHwdNEDzqKULX5YWIwnOp4wJXVi00bXdQDziacBZjThbhiPWJS3WR2KbOPXIzIZd/AMjmdpdQGsHucyylsMTqF8TnuywgfP+fe/O7+qC+mphGGOMWHqTwUpaHwpMvLrSutsNzENjZjs6BA64MsbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775831923; c=relaxed/simple;
	bh=F3ujDe7ZjTTxQQSP3g57HntqVPeRaAvrt4MC+7gAeP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9zxUtQzqpKpK1kMqKG3y9g7sB6qcOx0LayXcEkUkEgpVvWSZU7hMxm+bT3xynDWYt8pIloIhQeWVcr7SUVUuD3I5T611nPaJimJoV//Bhhymuz4ilanIXo/9vnlilloSpodd5PkJHfmHebieM+0F1wWIBgKdddraOdYQdYo6ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gCQOrls6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gCQOrls6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=x7Pc7BdpmXYmebB68kH1nFny0rSOm+Pd6TCbUj4Kyew=; b=gCQOrls6VgYStvOUweRSAAAQZF
	BUrrRwSLo63npXXVYJO/lVHwyUfibLgVz565F7/MALV3uYEUN5x8d5jUQYrBVGb8327Wa30nple9I
	TCR5lgStT4r/a5mYNmYowlYpaZU9/ZrRbV1RtXvJ6bRxltfURkDeUEIs1QZE4ciLXwdHYz2QdG3LX
	O1bX0F/klQ77gWzcMoIhcXOcQcF9zAEITEahkfj/eHXh5v5KJPZPv4ENGnDraxDeUlv7c4RapAigU
	gTuUlqPhjPYUpLgFBw/JRZJ2l83GbmTeUDMERbB4YVbtJEsXw0UzwHBaWC4ENkKJOfjDCC87fAMyc
	jYrVk03g==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wBD0G-00000009Vmq-2Ykj;
	Fri, 10 Apr 2026 14:38:36 +0000
Date: Fri, 10 Apr 2026 15:38:36 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Adrian McMenamin <adrianmcmenamin@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] Add support for VMUFAT filesystem
Message-ID: <adkLbCyI7ZnxkSAp@casper.infradead.org>
References: <20260410142403.308108-2-adrianmcmenamin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410142403.308108-2-adrianmcmenamin@gmail.com>

On Fri, Apr 10, 2026 at 03:24:04PM +0100, Adrian McMenamin wrote:
> Document the VMUFAT filesystem with a new vmufat.rst file
> 
> Documentation/filesystems/vmufat.rst |  127 ++++

You should add an extry to Documentation/filesystems/index.rst too.

> +An executible file (generally a game written in the native machine code of

That's spelled "executable" (both times)

