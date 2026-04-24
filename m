Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E4C3D6CA6
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 13:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777037427; cv=none; b=bkKni7/GYWN0I50XPNB0KiIDlqBEm3CqCbXUIWKpQs3pEJwC8EnDIQf/nMY1qiwYxNvIbA3GP5kWNELH1146uRnVH0Sc9Srf5ekYT2F/1btpCfimMIJV4ZsvLuUeag3rwcS6RF0QIrJ2a5632eJ0ecnvGMO3qo5FFNKuUsoZUlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777037427; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lt1MAitDLksUgnkN+l1GduKx3UTj7/+v57BHOabF1R2jxrqp7x4PknXN+YpoDEyVjIojOnkf+ASsMuomozg/2A3T+mtNTc2Q7A8r2197kBUwsM1gGB9gD448z8ZcS7Ec4t8lC/haw9WXkxwPtkFjV6V8GVfyy7OpcMuLkwzcylw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5FA4B68C4E; Fri, 24 Apr 2026 15:30:19 +0200 (CEST)
Date: Fri, 24 Apr 2026 15:30:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: brauner@kernel.org, djwong@kernel.org, hyc.lee@gmail.com,
	willy@infradead.org, xiang@kernel.org, hch@lst.de,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] ntfs: use direct pointer for inline data to avoid
 redundant allocation
Message-ID: <20260424133018.GB16307@lst.de>
References: <20260423213203.5533-1-linkinjeon@kernel.org> <20260423213203.5533-3-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423213203.5533-3-linkinjeon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

