Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A1A3A7F7A
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 06:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774593216; cv=none; b=AjnM+EAT5nFHEKtS8HddBeJO2JKhr6CPsXiIqb+4m9zHlOPkQlG+imCDfh870HIotmR082UkJMNDe7IAVJOixAgPDyEFv2+BZMvDRmIMHLyRdnpMcs/cWNyCIU0bohh3WN2CcFKF2s77ecuOIEAMP9liTxvSj5DJsh4ogBYZgKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774593216; c=relaxed/simple;
	bh=m7LrA3QLinIHQ42Xp9uQVfzdT5queMe/xPj+qNBzAms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mo5rLYZzePuCs0teiq8FTwywt1185NiU+bWEEo46N87F1ebFm9H22GcAZM66lyePgF0la1HiHIKlj+NWHUK0oIW+IdLiHXxpZTbTrP4Ipih4J32c10rQhRtK0AODlO/Df8GcY5TF62O7VU0odnsep3wkfVsxM509Tl+IV4+7cSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4D48968AFE; Fri, 27 Mar 2026 07:33:17 +0100 (CET)
Date: Fri, 27 Mar 2026 07:33:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com,
	linux-fsdevel@vger.kernel.org, anmuxixixi@gmail.com,
	dxdt@dev.snart.me, chizhiling@kylinos.cn, hch@lst.de
Subject: Re: [PATCH 0/5] exfat: convert to iomap
Message-ID: <20260327063316.GA8318@lst.de>
References: <20260326115045.9525-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326115045.9525-1-linkinjeon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Mar 26, 2026 at 08:50:40PM +0900, Namjae Jeon wrote:
> This patch series converts the exfat filesystem to the iomap framework for
> buffered I/O, direct I/O, and llseek (SEEK_HOLE/SEEK_DATA) support.

What tree is this against?  Patch fails to apply to current mainline.
Or if you have a link to a git tree, that could be useful as well.

