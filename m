Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3548E2147E6;
	Wed, 15 Apr 2026 13:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776260950; cv=none; b=JWqRi3Yg3To8jJ9z2tABHJ+WM64Sb0wnuih9RM7xSfuyU/+xTGN/E62lO5QoAfAOiz/VgU7Y9mXl4VFzo20XIhmoYUj4AqgByAwVOmu2hlkicmB2/7bmvz/kEAd4YrOThaNS1z2LhIGLNbFR1E5VFfIFQazr1JAavlKEOMpoiM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776260950; c=relaxed/simple;
	bh=Fk7RhCrUS8fA76oEyaVFdYAkHx6CWOfIGgL6Eh7I9/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eKV2LWUohuY5OMCw1QKHGIfsYurEmMTcsH1LITTOd7HXL8/aWAlbtJJWAttUCY86NjnNkmxFGXud92MkPZujxDuRYTCoREcu+QUdpYzNAyba3iRLd8/83F5OWu+O+ZqUzqRFXWDsurwUYnVHRIFcdC0pcHegLrI7qr0SQRr+xbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lb0B9D7V; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lb0B9D7V"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=q/tU1okJVzaxXTViQ/3laOZYd2h/NA0JuaB4Pnl9NHM=; b=lb0B9D7V07a6Yw+bcTZqmmrDFJ
	lXWjdJyO3ZLv61ZMHjRSc82OiBm9pKpvsLdw2RvAp8aIR3JKFhzrdXodD7Hc5ZHbDSJRD+8tAyXxV
	KmGtqHMQGtDhXo+ndb40yI+PwhPTRbxf8RHkAijA4g5RDr3cET0xK1J7zFY9AsBAWR4HLRS3J/b2l
	shixh241cHbr0fYPMWzoN6AiaNSV3jYrtTxFlzXcoF9iMORPH373DvJ3D/zo3g6Me/VgCCZh4Lg/a
	dNSuI0QMIOmNgxM5BpnbmdimzUPW6p8pjCPn8I1V+VZd2P3IiLYtR18gZOKWgLwzaMN7rNFYQdIAz
	7JhpEc7w==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wD0c5-0000000HW1d-0xZ5;
	Wed, 15 Apr 2026 13:49:05 +0000
Date: Wed, 15 Apr 2026 14:49:04 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Mingyu He <mingyu.he@shopee.com>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
	clm@meta.com, linux-kernel@vger.kernel.org, kirill@shutemov.name,
	bfoster@redhat.com, Jens Axboe <axboe@kernel.dk>,
	littleswimmingwhale@gmail.com
Subject: Re: [ISSUE] Read performance regression when using RWF_DONTCACHE
 form 8026e49 "mm/filemap: add read support for RWF_DONTCACHE"
Message-ID: <ad-XUOoN3wj-PnRC@casper.infradead.org>
References: <CAAoBcuSK38z5Nh7rGuHDFwpNvtc0W49OZKc1_d1QkCbK_nL7Ew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAoBcuSK38z5Nh7rGuHDFwpNvtc0W49OZKc1_d1QkCbK_nL7Ew@mail.gmail.com>

On Wed, Apr 15, 2026 at 03:28:27PM +0800, Mingyu He wrote:
> I found this feature quite useful because in many scenarios, files
> only need to be read once and then discarded. Keeping them in the page
> cache can lead to a drop in read performance during cache reclaim.
> Therefore, I conducted functional tests after the official release of
> v7.0.0. I found that in normal preadv2 read scenarios (write has not
> been tested yet), the read performance actually has a significant
> regression. I would like to discuss whether this is expected, or if my
> usage or application scenario is incorrect.

Your entire premise is wrong.  This is not a magic "make I/O go faster" 
flag.  Comparing it to cached I/O is entirely wrong; your workload
clearly benefits from readahead and you've asked to not do readahead
by specifying RWF_DONTCACHE.

Rather you should compare against O_DIRECT reads.
