Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA9D4F799F;
	Fri, 18 Sep 2026 13:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789739342; cv=none; b=VgcBitlu98z4MU58qgptFzfZr0WVTeSR/niZ5WPyBv6L4/SQJQvHi8LG+ny0ywCi8LO2a/exf29Whr6wxNqI14Z3SKyrnq2fAbruzJNtmTGGbPRGVP+3d9aZNpRn9UrZ8i2LtsKh5n7jHjmqeJqvH/nyGfVCWbkrkAqqt4OE9S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789739342; c=relaxed/simple;
	bh=KB3s7O2NaGvlwmc39OeC00206YHtiQqP0b11Jh1vlDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrDNvZcI4b8lG9KcM4g+FLSPF0JG78bQs0cQrHZja05wxY/cJg9+tqyg8puCHbYWkHC05qSIXc362XTFph1vGB2FuM02ay6TWeZt3LG6rOTITCjIdi5M+0WT8sW/+BI/UPUa+Ve9Wj+bfWo2uLcuavydrA7J8T1kfjWgTqok9go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gI5qV62i; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gI5qV62i"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FAuPdXT/kLAjLQUrVRunbicyUxlGVEedAP5+OdZF8Ss=; b=gI5qV62i57R0uKCkSJLjsm9K/J
	bvM6q0Lz/sXCj30IDwpo0o3DaGDzc4Qz4nOdPsJS7Ti3mR6lCIQEYgsEMpYyLQRroABCgwfkRees5
	IPTCu05teF+YHLQ3OhX2wieo8jVS5CqfmZI9y09tbgiOQUo6o6xt5tHwDb2MeoGDMcqh92wbKbD7d
	HMAO4SA9a0uNuWOnnEDgcnuplUBs2xrhs5vVK3BbsBqNUjPbbNJc4a1hnJhLMp/IqQTOphZuUDIca
	dGkpkCj7mLXzleGA0No3JJ3K+hRARV5EQFM77FeungMWHYKhkuNGU6GNPrgwQnNSCE98tbO8C6nhJ
	kYqeozoA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7YxX-0000000Ed5X-3QAS;
	Fri, 18 Sep 2026 13:48:59 +0000
Date: Fri, 18 Sep 2026 06:48:59 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jeremy Bingham <jbingham@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	brauner@kernel.org, jkoolstra@xs4all.nl, jack@suse.cz,
	djwong@kernel.org, viro@zeniv.linux.org.uk, hch@infradead.org
Subject: Re: [PATCH v4 1/3] iomap: add iomap_symlink_write
Message-ID: <aq1BS8nRiceHouk8@infradead.org>
References: <cover.1787770110.git.jbingham@gmail.com>
 <348ed49a8aa85c6c23c21034c8598401e9938e3d.1787770110.git.jbingham@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <348ed49a8aa85c6c23c21034c8598401e9938e3d.1787770110.git.jbingham@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Aug 26, 2026 at 02:41:55PM -0700, Jeremy Bingham wrote:
> Add a new iomap_symlink_write function as an iomap based equivalent to
> page_symlink found in fs/namei.c. Part of being that equivalency is
> behaving similarly to page_symlink. This function now expects the same
> len as page_symlink, where len is the length of the null terminated
> target string. The target is still written out without the trailing
> null.
> 
> Suggested-by: Darrick J. Wong <djwong@kernel.org>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> 
> Signed-off-by: Jeremy Bingham <jbingham@gmail.com>

No empty line before the signoff, please.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

