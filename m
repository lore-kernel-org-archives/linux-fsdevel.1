Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4AF37756C;
	Mon,  5 Oct 2026 08:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791188335; cv=none; b=sinRwfWQ+LGi0R2jsN+6HyuSUNn6WVOhabhJbIpQj/ak7LWFUUA2SVHXiEED19kgT+UslelvCDWlsabB8yns4KSegqeuiknnuldcLvT93xTBRQaOCtH8R8wvN7V+aPzt065LDAoLALj/YSgCxzqe+aBwlBiacQgZuSjbUmxGB7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791188335; c=relaxed/simple;
	bh=X/aNMCwnFbB8codqC36u06VqeEmT4RcuD8kZuIA07+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dbw0udZ1gjLb10E+ti0+MVE6VmOkUam3mBx4UApJgzeP8Lg5j3RDTCd9tEfuvicFz1kqume+Q5VDWFN7GA+QlwS0t6cLCrm4MjO7zFH5tTVeOTfwBEqKo6tRAQah0y77m+E92ManxhLQVmcR0YoSzJKQyUGDm9xK5XQYXapqQe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BPYTdJyh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BPYTdJyh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=URfBCQsS/mgH3EduwXOL57UzJOoy0wLXjtQPczlHoMw=; b=BPYTdJyhk40fXCqQcLrHTppOOV
	fXFQu0lJz/j5kQV7Vgdk7l2FBSHAVklC07yqSwR61QlKuimNCNir88kagejdlKMdx8pqER0x3fORf
	TR2mtr0Az0eToQkL3zmN1/Af21rjopSDeXHOEB+03DMPHAmqjpgXt0Lx6xc1sGxnH6AmtWGR57jap
	MZx6INGYgV26MCIws6AhbySfSMl2LTEl74JEmBDJek1vGIwJtSO6fiRf9pb0HPycazKJLgKkp1dQM
	KetN2GGFgUx88q19ioaja6SWrAT9ZbOCOHui0pOfLEblLT7M8c8d09x337LQdX4EY+JjLWtLCsCV7
	NNhfbueA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDduP-0000000Frk3-002P;
	Mon, 05 Oct 2026 08:18:53 +0000
Date: Mon, 5 Oct 2026 01:18:52 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jeremy Bingham <jbingham@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	brauner@kernel.org, jkoolstra@xs4all.nl, jack@suse.cz,
	djwong@kernel.org, hch@infradead.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v1 1/1] minix: consolidate itree* files into one itree.c
 file
Message-ID: <asNdbGAe7XGL3iBI@infradead.org>
References: <cover.1790359547.git.jbingham@gmail.com>
 <29e5bed16cef4904e9649a9b77d42ec10cd33051.1790359547.git.jbingham@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29e5bed16cef4904e9649a9b77d42ec10cd33051.1790359547.git.jbingham@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Sep 28, 2026 at 01:04:26PM -0700, Jeremy Bingham wrote:
> Consolidate the itree functions by adding fields to the superblock info
> struct to store the number of direct blocks and levels of indirect
> blocks because the different versions of the minix filesystems have
> differing numbers of indirect block pointers and different block pointer
> sizes. This allows consolidating the itree functions into one itree.c
> file instead of a system with version specific itree files with version
> specific definitions and wrapper functions that #include a common
> itree_common.c file that are in turn called by wrapper functions
> elsewhere in the code that call the version specific wrapper functions.
> 
> No functional changes are intended for this patch. 
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Suggested-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Jeremy Bingham <jbingham@gmail.com>

Looks good from the high-level perspective:

Reviewed-by: Christoph Hellwig <hch@lst.de>

I assume you've run xfstests and checked nothing regresseѕ?

