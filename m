Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C92E358D00
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2026 09:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778231199; cv=none; b=oj6vzygWg7GNERUwlK9w0UdectJ8RSzi4FNdlPMprawthaT4/nIfjSZKZrClt2pRZHxwpana1qYJaBVR5LUWLi8/b1RtPNb0Fz10gvBsI/EEJaIyk6MQwVq0IylVrj6ZYZnXxBrXR2e/C4mhZbviPdyCQHI6+OR0GsI8ZeyfEkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778231199; c=relaxed/simple;
	bh=KrRS/ePXYWkgYzdAI8tz+yrjyGF1OE0KtTEjLQtKrGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFHWziCWhV1QkQO85mvieRJIsAJhMd3I18hH/NsTGrhHN77suTVkcK3EOHMl/i3OMHaMBvGpLlBOr1TJrUuywCT02vwwSQ/qrkaG6dKLFYa5IpAzA+A+k/uU/GVjPC2uQEA2foozIY86d/Zn9fTSv0yDQDBTHAQjs7kB6X0Jhrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 542AD68BEB; Fri,  8 May 2026 11:06:35 +0200 (CEST)
Date: Fri, 8 May 2026 11:06:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, brauner@kernel.org, fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH 2/2] iomap: allow NULL swap info bdev when activating
 swapfile
Message-ID: <20260508090634.GA20688@lst.de>
References: <177747204299.4101605.7457046403791125680.stgit@frogsfrogsfrogs> <177747204350.4101605.17012857152206455463.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177747204350.4101605.17012857152206455463.stgit@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +	/* Swapfiles must be backed by a block device */
> +	if (!iomap->bdev)
> +		return iomap_swapfile_fail(isi, "is not on a block device");
> +
> +	if (iter->pos == 0 && !isi->sis->bdev)
> +		isi->sis->bdev = iomap->bdev;

My gut feeling is still that I'd rather have this in the caller than
hidden in iomap.

> +	/*
> +	 * If this swapfile doesn't have a block device, reject this useless
> +	 * swapfile to prevent confusion later on.
> +	 */
> +	if (sis->bdev == NULL) {

normal kernel style would be "if (!sis->bdev)"

> +		pr_warn(
> + "swapon: No block device for swap file but usage pages?!\n");

Also non-XFS code tends to just put this onto the pr_warn line even
if it is less readable (and XFS code tends to not do an empty space).

