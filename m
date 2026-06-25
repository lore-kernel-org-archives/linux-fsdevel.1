Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D862D8385
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 11:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782388232; cv=none; b=Yh6XQVkYxk6quNGPrBgYVSpQhNl6Nn47VRQv1hMjh2izxNoCYmyNZ8YURBCJvuGJt4NDIJmjd3wIqmaWh0HXEOCx+Mrfi+dL3cewxN2SF1j7KwMviebhjBqbung030tvlwVwj672TxTIwU4Iy49VBn+N+5WhjEkl9ew4M+hYP+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782388232; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBSHHU7QxGFOkQX4xk8/XRrjoQThBgcCqhYP7oO+k4fbILpXKxo6BUxxmJUERZtyloMnbUXAQL7OguD68K7LHa52cOWZD8w+3KovYRHPwT7JiOtcR/s2QwagMt1hKHYsJl+VZQCo4gzQsIazDhQkziNrrbb9kNlh73+H1qChFOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BF75768B05; Thu, 25 Jun 2026 13:50:26 +0200 (CEST)
Date: Thu, 25 Jun 2026 13:50:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, willy@infradead.org, hch@lst.de, djwong@kernel.org,
	miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev
Subject: Re: [PATCH v2 1/2] iomap: add helper to mark folio uptodate
Message-ID: <20260625115026.GB18076@lst.de>
References: <20260624212925.1668662-1-joannelkoong@gmail.com> <20260624212925.1668662-2-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624212925.1668662-2-joannelkoong@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
