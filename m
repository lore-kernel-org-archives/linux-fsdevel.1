Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6154F7CA0;
	Fri, 18 Sep 2026 13:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738139; cv=none; b=hQbbmjXQGbmuAlS6T8hVp8STKru4vxbh4HS1D7Mu0e5zO6nEv04wMAIc4GFfaaLJ9FDLcH+Ll5/q2Gu9a+OTHr2fwDybRhlaHmbXLYBn9HIf3xDAqMVqH2nV7vUJ2CoVw6UcopxQIA7pW2v5iGjtOz0Qmx7kbGaWi2tvmBuehtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738139; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fd8Ns+g8oxWV4lCyDHYmjgTLlfqzLTK6aY5l4HjBq8WeeTXpPI1CIvW0dw/+RXN710KxxtWPUavOjG9FaJuw3U0mHmHsROvorj5OJdRdFgV3ySdSTl4qbwefHW3j2S/gSG8Hm/a9IAld2IoLRh+/OhAFXi3bXGwhTqi14yCbsts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3DE1968C7B; Fri, 18 Sep 2026 15:28:52 +0200 (CEST)
Date: Fri, 18 Sep 2026 15:28:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, hch@lst.de,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com, willy@infradead.org, brauner@kernel.org,
	djwong@kernel.org
Subject: Re: [PATCH v4 1/7] hfs/hfsplus: exchange hardcoded number of
 extents on named constants
Message-ID: <20260918132852.GA18107@lst.de>
References: <20260914233941.2966421-1-slava@dubeyko.com> <20260914233941.2966421-2-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914233941.2966421-2-slava@dubeyko.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

