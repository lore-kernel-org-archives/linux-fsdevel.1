Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E405F502D43;
	Fri, 18 Sep 2026 13:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738615; cv=none; b=jnmSdVLTC0rfl5HHI0iw0vpWIUy4HWRQDMU/khhJ5rzpyyk8xNRKfqhHGnVbil5de3249hY9JSHyKPi5u4hQmF+YtAeVSQsMi0KXXDxQo7U92aUNDbY4VoGYPKU/qzDFmU9r9h4p5ALGeahzHY8dOx9qZXX6+YpBa9Z3hAo1S0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738615; c=relaxed/simple;
	bh=H2dI1h5h+c5Uh/u2gvvatOss6nAl1NmWk5puAsF+4dQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fk79fL1WO8JKnziS86UBsTgSqVy8O1PiVMGSnjcgN12vUGBntERzSTHXKueWiIlzs2Ju4YsMw2yU37IrY/Bm29UByZZqQdqtV1Nj7VYq36aCaii/YsIr3OsTP85yX+yi+Q5Gk31VtjIBX/JQD0R5hcftTwhf1/mWj7wuJEPPgSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5B92B68BEB; Fri, 18 Sep 2026 15:36:49 +0200 (CEST)
Date: Fri, 18 Sep 2026 15:36:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, hch@lst.de,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com, willy@infradead.org, brauner@kernel.org,
	djwong@kernel.org
Subject: Re: [PATCH v4 4/7] hfsplus: add iomap operations for regular file
 data
Message-ID: <20260918133649.GE18107@lst.de>
References: <20260914233941.2966421-1-slava@dubeyko.com> <20260914233941.2966421-5-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914233941.2966421-5-slava@dubeyko.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Sep 14, 2026 at 04:39:38PM -0700, Viacheslav Dubeyko wrote:
> This patch adds iomap.h and iomap.c files. The iomap.h contains
> declarations of hfsplus_iomap_ops, hfsplus_write_iomap_ops,
> hfsplus_writeback_ops, and hfsplus_write_dio_ops operations.
> The iomap.c implements __hfsplus_iomap_begin(),
> hfsplus_write_iomap_end(), hfsplus_iomap_cont_expand(),
> hfsplus_writeback_range() methods that become the basis of
> HFS+ iomap operations.

Adding this without the users in the last two patches is odd, as this
isn't really the kind of atomic change we're usually doing in Linux.

I'd vote for merging this and the last two patches into one.

> index 000000000000..5723e854e58e
> --- /dev/null
> +++ b/fs/hfsplus/iomap.c
> @@ -0,0 +1,192 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * iomap callback functions for the hfsplus filesystem

In Linux terminology these are methods, not callbacks.  I'd probably just
drop this comment entirely, as it doesn't really add value, though.

> +static int hfsplus_iomap_begin(struct inode *inode, loff_t offset,
> +				loff_t length, unsigned int flags,
> +				struct iomap *iomap, struct iomap *srcmap)
> +{
> +	return __hfsplus_iomap_begin(inode,
> +				     offset, length, flags,
> +				     iomap, false);

Odd formatting.  Why not:

	return __hfsplus_iomap_begin(inode, offset, length, flags, iomap,
				     false);

?

Also may_alloc as flags with a readable flag name might be nicer here.

> +}
> +
> +static int hfsplus_write_iomap_begin(struct inode *inode, loff_t offset,
> +				     loff_t length, unsigned int flags,
> +				     struct iomap *iomap, struct iomap *srcmap)
> +{
> +	return __hfsplus_iomap_begin(inode,
> +				     offset, length, flags,
> +				     iomap, true);
> +}

Same.

> +const struct iomap_ops hfsplus_iomap_ops = {
> +	.iomap_begin = hfsplus_iomap_begin,
> +};

Please use the new iomap next scheme merged in 7.3-rc.  In fact
the old begin/end methods were supposed to be removed after -rc1,
but someone they managed to still stay around.

> +
> +/*
> + * hfsplus_write_iomap_end()

Duplicating the function name adds no value.
Same for the other functions.

> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * iomap callback declarations for the hfsplus filesystem
> + */

Same comment as for iomap.c.

> +static inline
> +int iomap_dio_end_io(struct kiocb *iocb, ssize_t size,
> +		     int error, unsigned int flags)

Odd formatting, normally we'd do:

static inline int iomap_dio_end_io(struct kiocb *iocb, ssize_t size, int error,
		unsigned int flags)

or:

static inline int
iomap_dio_end_io(struct kiocb *iocb, ssize_t size, int error,
		unsigned int flags)
