Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736D836F428
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 05:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784870926; cv=none; b=djkbg7tCjcd0RSIW3w/YsSIFXRGNOeeu8Gw4GkvLWscs5VkuGgcOAdAZPDkgpSH0MM3DuQsx/TcBTGhfMy7ztie7grXY41XfUeYE+vzvLY8Aj60x622lCcYlIo8QGY1SOy4cSIoIkBUah2lw3Lpfd0s9C8WvO9Eak7ZFRvX/dWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784870926; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+VVmL4eOn0eJ/OykQbcGzO6jV35eNEEGQXXbJZsBWPChCUmXVirtkVzJ7N8RS0sUVdMtE46TnVWq6n0Onmrn64XfQoeDTSfDDWC07zb6tMsimn3UddRQsRY9NrrPkR3StH5oXuJ7Y0/pJuGWF4c7Ls1KON5gPilUi1+8vADdUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AC24368BEB; Fri, 24 Jul 2026 07:28:41 +0200 (CEST)
Date: Fri, 24 Jul 2026 07:28:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, hch@lst.de,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/6] hfsplus: rework hfsplus_get_block() logic
Message-ID: <20260724052841.GC4181@lst.de>
References: <20260722213759.1360225-1-slava@dubeyko.com> <20260722213759.1360225-3-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722213759.1360225-3-slava@dubeyko.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

