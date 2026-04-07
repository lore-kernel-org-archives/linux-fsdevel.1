Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F0B386C00
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Apr 2026 06:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775543336; cv=none; b=NO7OIzw20++XjgdQRBtfO+oL7GHg6IqVsTlh6MyQRuFSrRIGKunLVrcEWJGZi/LXwp03ZpIiHO6e2OqTvApGPigLxQu433nND+oFTSa7g5XzhBeJM4/ZkLZiAEyjj/10/4NN2TGMVw8B9uHpROwnGOJFOFKmEonVIMqs6P5q6+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775543336; c=relaxed/simple;
	bh=8Fdnrh1PExdcSHl+ZFjTuoWX5gMRBLpON8xvYkJBTec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/LaZsjQMn+WPIc/GxlrauZv59FI0PHsEGFskkR4Y8qjvAnyyDNKgpJ30q84jzdZbQ6T+iUSk3MlWnHv+1PwU1VORz7eLJejAfdGzLguggOhFuuVyLVxeMV5dj/N10NkFF0aOkeE1j0oXWD7O1KAd0HqRMUyzwNA0GX9mEqLnUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DCEB168C4E; Tue,  7 Apr 2026 08:28:49 +0200 (CEST)
Date: Tue, 7 Apr 2026 08:28:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: David Timber <dxdt@dev.snart.me>
Cc: Namjae Jeon <linkinjeon@kernel.org>, sj1557.seo@samsung.com,
	yuezhang.mo@sony.com, linux-fsdevel@vger.kernel.org,
	anmuxixixi@gmail.com, hch@lst.de, chizhiling@163.com
Subject: Re: [PATCH 3/5] exfat: add iomap buffered I/O support
Message-ID: <20260407062849.GA6966@lst.de>
References: <20260326115045.9525-1-linkinjeon@kernel.org> <20260326115045.9525-4-linkinjeon@kernel.org> <149dabc5-5e88-4589-aec6-fd22925ce974@dev.snart.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <149dabc5-5e88-4589-aec6-fd22925ce974@dev.snart.me>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Apr 06, 2026 at 10:09:42PM +0900, David Timber wrote:
> > -#define EXFAT_CLU_TO_B(b, sbi)		((b) << (sbi)->cluster_size_bits)
> > +#define EXFAT_CLU_TO_B(b, sbi)		((loff_t)(b) << (sbi)->cluster_size_bits)
> 
> I think type casting should be left to the users of the macro. These
> helper macros are quite dangerous in case of (ex)FAT because integer
> overflows are unchecked for shift op. The on-disk format is 32 bit but
> the kernel has switched over to "all-64-bit".
> 
> That particular macro is used in dirent update code and, in particular,
> in exfat_map_cluster():
> 
>     inode->i_blocks += EXFAT_CLU_TO_B(num_to_be_allocated, sbi) >> 9;
> 
> The type of i_blocks is blkcnt_t, which is unsigned. loff_t is signed.
> exFAT got away with it because Linux write calls expand the size of
> files no more than 0x7ffff000 bytes and the size of dir is limited to
> 256MB. However, someone could come in and decide to use
> exfat_map_cluster() to allocate more than this limit.

But that will blow up in some many other ways.  The only sane thing
to do here is to replace those macros with inline functions that
include the proper casting.

