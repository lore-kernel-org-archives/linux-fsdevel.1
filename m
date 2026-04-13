Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7C3371CE3;
	Mon, 13 Apr 2026 17:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776102122; cv=none; b=JKJKuamz2EX2JTFbBM6dxeNBFzStUrCxXh6Yu3Lq5MjgBxD17eMXTqfj5eyab4Vp+pG4QgjHIKg2P0SVD4Zx38VLR9696Ut0pyWG8WzS+e/ArMeJ2SSEtw9hnKwV+mfkAQ7lUeAosGZ106Pel4GBlnDKtsOhGsK428sO5qYjuGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776102122; c=relaxed/simple;
	bh=kvmssUaSk0LREIzl0zAwShTZE4HKMoJak/2ns+b5QFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8/7S9jzVNhE+5uhjkPzRoAQXu1O4CTTrbGbdYPvf6P14FJTMIsGpKFgCD+jMn1XJekJQLrBO9df1p3hVErfr/TEwtEws0l9FJNjG+OIHCA0upTdmwvqgJuqAqQi78zDP8Z93xp3rBRnVoZAnyZppoCv+0Wdr8X/r6ni2M8p18U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EBKuo/lC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EBKuo/lC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QZ59p0FtSGKGN/PxyAs1+V29Vtw3/BQuhY7njFCalBk=; b=EBKuo/lCsECSB0VFXliU1GBo91
	8nZrlRKVG7dSkCvqY5S5TgUOWAiwDhDeYuGZOnRCJmrRDYzXGDMVWZyikiTaFYqrZYQFuZTesP+xy
	nxzLJ20dMHv7efsBq0bHyAFaPmtQSO8t18QlvRR05LlpIx5jrSeGmD0pAjG5h+ncKbSRcw4zLdfr0
	11oRbhlMFs2OzQ04MioXK/s/YlGT1Vqh7JpHB6AtDzCV5ALBt1B2x5/RFnuDWi2/6PDKY4GVdzwmf
	KpzwOlbwybqaBGulfXnjy73mA9jmc8yfS+DcCY7Ahy3+yKqSiRFWXUZERyjtEImjv858Or7bYXAyZ
	/93dch+A==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCLIK-0000000EHd6-0Vyb;
	Mon, 13 Apr 2026 17:41:56 +0000
Date: Mon, 13 Apr 2026 18:41:55 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Aurelien DESBRIERES <aurelien.desbrieres@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org
Subject: Re: [RFC PATCH 05/10] ftrfs: add file operations
Message-ID: <ad0q46aPi-iV_2dD@casper.infradead.org>
References: <20260413142357.515792-1-aurelien@hackers.camp>
 <20260413142357.515792-6-aurelien@hackers.camp>
 <ad0HG2nC51h2ZHEv@casper.infradead.org>
 <CAM=40tU5NppEZ9x07qDVkSxLw6Ga4nVg7sDCqcvhfQ51VbsS9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM=40tU5NppEZ9x07qDVkSxLw6Ga4nVg7sDCqcvhfQ51VbsS9Q@mail.gmail.com>

On Mon, Apr 13, 2026 at 07:17:30PM +0200, Aurelien DESBRIERES wrote:
> ... where is this? I only see file_operations and inode_operations. I don't
> see address_space_operations anywhere.

I think you need to fix your email client.  Usually on kernel mailing
lists, who said what is indicated by a level of indentation.  There's
no indication here that I asked this question.

> You are correct. address_space_operations was described in the commit
> message but never implemented in the patch. This is a bug in the RFC.
> 
> Will add ftrfs_aops with readfolio and writepage in v2, and wire it into
> ftrfs_iget() via inode->i_mapping->a_ops.

When you're implementing the address_space_operations, I would recommend
using iomap rather than buffer heads.  It's more modern infrastructure,
and there's strong aversion to merging new filesystems that use buffer
heads.
