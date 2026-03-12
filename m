Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB3F346E7A;
	Thu, 12 Mar 2026 03:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773285793; cv=none; b=NwKYwjjJ0QiDeRYLFejdy89Rpbtx9asEMfLx7g//z8+txn5U/uuW8uP3rcPobaojgWs4Wxcui1UswUFSbbkeL2zIlg/SptONps43g3RS8tZ7ZJmTiDguLfJrHlPD+ARPfJVoTqTUyXZi0tcTsyoS5Z+p73M8Oi6rK4sOTNuUUxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773285793; c=relaxed/simple;
	bh=KTxCJOEbycdqaraVOslkw/7R+vqhpq7O9pZlIh3PQpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEctWoFwh44XSfoJ11jrZ4J1YZyHZ1uNl5o8t6vJsQcZi5x79w1So/o8sgYKAHFG8d6w7eOHSFb1K2+gYgb6qlk+bKCEz1BECkKBGv5cpme47aufC0oWz1hHxaXE2SLASlYHZw0/Zc/vh2oi+ICRmbqK4Go5lEzCZB/yFpZHzec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lKYEhj50; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lKYEhj50"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DZfhbXHhfMaaHnOXdbaWgPIRivFHLPaM60JvxB6bEzo=; b=lKYEhj50PATd0relnie2QVch2G
	qA/WCI+Su2ZMcdB+akfGJhb/fqM35DnC0tV+O94jb60VXwh0AKCckfqB5v5yFyZuzJ1mmbux5/l83
	XJKd+5woG+5e7TIpOBBSXbDRuxG62fXC2Q+0OE22BWGUCUVXXJ9HaSTyp67+5skE1YeyyM562zc9a
	xWTRcSrsFTWqW6gjnvhAmkWZgD+2LyxUSoqWsOtKePX0oqCOgmQsqfYrg7f2/2HYtmPPMvMkaL2ad
	uOQRcdQXaz2gFBV6CDE3xaqiTUOgpabC+CTjmUGruN0jqCqKUeAZy1URJ/U1bUyR6M4GO5+RqyNcW
	UyAzrrdw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0Wdc-0000000AjAL-00u0;
	Thu, 12 Mar 2026 03:23:04 +0000
Date: Thu, 12 Mar 2026 03:23:03 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Timber <dxdt@dev.snart.me>
Cc: linkinjeon@kernel.org, sj1557.seo@samsung.com, yuezhang.mo@sony.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] exfat: EXFAT_IOC_GET_VALID_DATA ioctl
Message-ID: <abIxl8XEftpku8yf@casper.infradead.org>
References: <20260311222613.2010177-1-dxdt@dev.snart.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311222613.2010177-1-dxdt@dev.snart.me>

On Thu, Mar 12, 2026 at 07:26:13AM +0900, David Timber wrote:
> When a file in exfat fs gets truncated up or fallocate()'d up, only
> additional clusters are allocated and isize updated whilst VDL(valid
> data length) remains unchanged. If an application writes to the file
> past the VDL, significant IO delay can occur as the skipped range
> [VDL, offset) has to be zeroed out before returning to userspace. Some
> users may find this caveat unacceptible.
> 
> Some niche applications(especially embedded systems) may want to query
> the discrepancy between the VDL and isize before doing lseek() and
> write() to estimate the delay from implicit zeroring.
> 
> The commit introduces a new ioctl EXFAT_IOC_GET_VALID_DATA, which
> correspond to `fsutil file queryvaliddata ...` available on Windows.
> With the new ioctl, applications could assess the delay that may incur
> and make decisions accordingly before seeking past the VDL to write.

We already have two interfaces for this on Linux.  One is SEEK_HOLE /
SEEK_DATA and the other is fiemap (Documentation/filesystems/fiemap.rst)
Why are both of these interfaces unsuitable?
