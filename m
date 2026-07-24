Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510A3257854
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 05:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784870975; cv=none; b=jj8lV9hvxgq3/j7d+JIsH7XX4XmznIweu3l6E0H1GgD54C3/oSif2ur9rOKw+s/Ivsopz0elgcn87w//jc298mhIlvyxXilz2yKBS+60ZCPSgnEytXi0BO2dsbWseerCYW3dppN5T1Q/kfPGrW1WSRkcq6UazGWht3gdj32Hm64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784870975; c=relaxed/simple;
	bh=oDya3/gamx+6MPlT+pBtPxjzOH2vhpKEOexwm6AJUT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avyXPLakynfA7saY9CSixoEayyUNxYoVqsZSZSUosdGJplpY0DQdGm3s6G4GK/gC85WJnT4HuUmTHMocgQxtj3E+F73L8vHWDRm8GckDW/Bf+szkZrncgd4e8ZmIYNTtQEspnLN5ewbCM8PWNLWKJ2BoL58m2MDlz8WlWTHkExg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 564EA68BEB; Fri, 24 Jul 2026 07:29:31 +0200 (CEST)
Date: Fri, 24 Jul 2026 07:29:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, hch@lst.de,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/6] hfsplus: take the bitmap page lock for
 allocate/free
Message-ID: <20260724052931.GD4181@lst.de>
References: <20260722213759.1360225-1-slava@dubeyko.com> <20260722213759.1360225-4-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722213759.1360225-4-slava@dubeyko.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jul 22, 2026 at 02:37:55PM -0700, Viacheslav Dubeyko wrote:
> The hfsplus_block_allocate() and hfsplus_block_free() kmap
> the allocation bitmap's pages and modify their bits in place
> under sbi->alloc_mutex, but without holding the page lock.
> That leaves the read-modify-write of the bitmap bits
> unprotected against a concurrent writeback of the same page,
> which can read a partially-updated bitmap word or race with
> the dirty-bit update.
> 
> This patch adds taking lock_page()/unlock_page() around each
> page's kmap/modify/kunmap section.

You are still unprotected against concurrent writeback, as writeback
drops the page lock before writing the data out.

