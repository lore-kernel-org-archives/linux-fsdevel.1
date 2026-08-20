Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAD11F8AC5
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 06:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787206477; cv=none; b=OP/Ln//pnkWjYGhWH/txq5nHUyt5V4q7Xjscr/5lVTmGYJiCBr1dj/jchgzvtxUxg+bf1BekN78g0dFcp8YGtqF43SqeRMOlebe3tftcU4AXwespf5lo/fZQbPO4TBNI+5B+aBmCrdmzY30nPN6gT1BCyyegoNg2VRsTq8ccNyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787206477; c=relaxed/simple;
	bh=XphsRVHisIgHEkr3NKDtW3uHbuEgB8oi40ZHxI1Uz4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ItK6VxdCjLyw/oSdlbWg21iy6gjb0u75Iqx8kgiVtUzLo+p0UN99P6xU5YDvjASAyMuIOBcsdO9hf3KT03GMJThNoXgY3cVRCa/Gq0k49NQ0dO6IDHRHb6HUah0D66x9ceiDKXqt9OAtgoaPhRmSpq0zabBw2LL/sQwQVeeA/no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 794A668C4E; Thu, 20 Aug 2026 08:14:30 +0200 (CEST)
Date: Thu, 20 Aug 2026 08:14:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Christoph Hellwig <hch@lst.de>, glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com, linux-fsdevel@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: Re: [PATCH 4/6] hfsplus: add iomap operations for regular file data
Message-ID: <20260820061430.GB18804@lst.de>
References: <20260722213759.1360225-1-slava@dubeyko.com> <20260722213759.1360225-5-slava@dubeyko.com> <20260724053229.GE4181@lst.de> <5fb1c7c0eb68fd882df837b7e031e3957c5f070d.camel@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fb1c7c0eb68fd882df837b7e031e3957c5f070d.camel@dubeyko.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Aug 19, 2026 at 04:27:50PM -0700, Viacheslav Dubeyko wrote:
> Hi Christoph,
> 
> On Fri, 2026-07-24 at 07:32 +0200, Christoph Hellwig wrote:
> 
> 
> > 
> > > +static int hfsplus_file_write_dio_end_io(struct kiocb *iocb,
> > > ssize_t size,
> > > +					 int error, unsigned int
> > > flags)
> > > +{
> > > +	struct inode *inode = file_inode(iocb->ki_filp);
> > > +
> > > +	if (error)
> > > +		return error;
> > > +
> > > +	if (size && i_size_read(inode) < iocb->ki_pos + size) {
> > > +		i_size_write(inode, iocb->ki_pos + size);
> > > +		mark_inode_dirty(inode);
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > 
> > We've have a copy of this in various places, maye add it to a header?
> > Or even into the core code based on a flag so that these file systems
> > don't need an end_io method?
> 
> I think I need more clarification here. :) By "various places" do you
> mean HFS+ code or Linux kernel as whole?
> 
> I assume that you mean this code block:
> 
> +	if (size && i_size_read(inode) < iocb->ki_pos + size) {
> +		i_size_write(inode, iocb->ki_pos + size);
> +		mark_inode_dirty(inode);
> +	}
> 
> Do you suggest to introduce this logic as a special method that can be
> used in other file systems too? Am I right?

That was the original idea.  But I think what is even better is to
do it when no iomap_dio_ops.end_io method is defined.  I think I did
an audit that there is no such current case for writes, but we should
double check it.

