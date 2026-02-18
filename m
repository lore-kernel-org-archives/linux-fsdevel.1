Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D0F279DAB;
	Wed, 18 Feb 2026 05:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771393223; cv=none; b=c44eYg3VVfLM1Y9XWXZonBBpatB0InQgV3o5Nl3qE2Ki2EM3boSLZIYk6E9lyxbwt3BFlj6nWGA7HO+WHp3Vll2Zh99UCRP4rhr1bxJBFFT4RZSd3FWFvWoqad93JoOfw9RYIA8AXVuch4S2oDXTEK7mAWRDKDZmyPvhdpIemWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771393223; c=relaxed/simple;
	bh=l5qFDGEPfy2hV8GQUDOGe+MbxNCT2YGTPGSQtP0QI8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+pzQM907jx/P/KYoIZscGxZB193dylWgoO+ENv+HoivoIaiG3/EC5Zd+wxaIs9QlXIeYYV5aX2I75THUqumUBUxOlQNZj0Wmz7e4pCchtzyv4M5gfVthKgudQTk1/6T9hZsIBPQ3kpF9zNX+h4H/ZMdgcWWkGlDT+EmAQ2wJdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2qfKRofs; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2qfKRofs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1jlxD8osAAxmiNkGQAgvylVgW1b45QP244UBWD+dDVI=; b=2qfKRofsyFv8MIIk3wyJ7cwYm9
	Q8y22c8jWANVoHmrd2H+xlQxGoXDV9e2IPbmmrr2T4Mt+I+PNt51RulwEU+ydQJVWybsxLS6AEAnd
	RWUqoCCSIxuQpAIeAFzeq8tspDvP8/NSJXS+8U6Dip8A5Ny9FxOzUHKJKsZQ0RGAjumKbFpkIihCp
	6A30PlqYNASbJiZlpzxVpTCqGq+I90Cndg4172NEVwUW235MQN0BG4ZgbaKkKfdw7+118TugqgkGE
	ydyHMQWAZ6Jwo0J6sAZdQm68AI8NqMZeZzoc237S30Uf/tnDur9p0jzYeBqKGpYeZVsRISvVsbtbz
	jsPFWh/A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsaIF-00000009KQo-3RdA;
	Wed, 18 Feb 2026 05:40:11 +0000
Date: Tue, 17 Feb 2026 21:40:11 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] fsverity: fix build error by adding fsverity_readahead()
 stub
Message-ID: <aZVQu_1z_Z_0mQMx@infradead.org>
References: <20260218012244.18536-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218012244.18536-1-ebiggers@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Feb 17, 2026 at 05:22:44PM -0800, Eric Biggers wrote:
> hppa-linux-gcc 9.5.0 generates a call to fsverity_readahead() in
> f2fs_readahead() when CONFIG_FS_VERITY=n, because it fails to do the
> expected dead code elimination based on vi always being NULL.  Fix the
> build error by adding an inline stub for fsverity_readahead().  Since
> it's just for opportunistic readahead, just make it a no-op.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202602180838.pwICdY2r-lkp@intel.com/

Pretty silly that we need it, but looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

