Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B84C19A288
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 05:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784871154; cv=none; b=DAjk9hYk+2089sF+cFhMPvZ/MlTWWJKyk5vxt7TmZ2YZmm3axGg8wHqulbPr7Fh9lAeOgOOuuQCzappLqxg129d0qHHhh++UVPG2CgTGg8AlqNi4+W3XS1ohC9eTCDXgRgWc6S3dEIhl237T1BYsNwRaPI5n64sU7aoNqvVYRdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784871154; c=relaxed/simple;
	bh=pbuNVZ7HtStSY0jBFP2QIRMadf43m9p8s4yZA8Oitu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYgyz8ZAuX9Kmybm6MzAVZVVRfLb9EwxIkWOvrDbiLcRPK/7aAMpnMsQOE+n9MdG5b+MoQlzuK9YjmxkJK3aMqNVefYkRMVR/kBBg+/rjuZcqy1DrKjLacW3zc7fFlpcWJ78WcKsQc7TOM1/v8RxSsLJPP9DnQoqq8I/uy3KY5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DD4BF68BEB; Fri, 24 Jul 2026 07:32:29 +0200 (CEST)
Date: Fri, 24 Jul 2026 07:32:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, hch@lst.de,
	linux-fsdevel@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>
Subject: Re: [PATCH 4/6] hfsplus: add iomap operations for regular file data
Message-ID: <20260724053229.GE4181@lst.de>
References: <20260722213759.1360225-1-slava@dubeyko.com> <20260722213759.1360225-5-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722213759.1360225-5-slava@dubeyko.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jul 22, 2026 at 02:37:56PM -0700, Viacheslav Dubeyko wrote:
> This patch switches regular file operations on
> iomap based approach.

Maybe spell out the benefits tradeoffs, odd bits here?  This commit
log is a bit short.

Also does this actually work without the following patches?

> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  linux/fs/hfsplus/iomap.c

Please don't put the file name into the file itself.  It is pointless
and prone to get out of date.

> +static int hfsplus_file_write_dio_end_io(struct kiocb *iocb, ssize_t size,
> +					 int error, unsigned int flags)
> +{
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +
> +	if (error)
> +		return error;
> +
> +	if (size && i_size_read(inode) < iocb->ki_pos + size) {
> +		i_size_write(inode, iocb->ki_pos + size);
> +		mark_inode_dirty(inode);
> +	}
> +
> +	return 0;
> +}

We've have a copy of this in various places, maye add it to a header?
Or even into the core code based on a flag so that these file systems
don't need an end_io method?

