Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E84135F8C9;
	Tue, 22 Sep 2026 13:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082100; cv=none; b=Hb4xH5BDsq2HNQbg0JA1E5sFwofDxMZnRZde/i6bOOH4vvflm7Xr0281Q7GOkGDdNYvZV26ms6STISdSYSIPRskaV7+9B8OdiX00kGb8ulf+o37JZTv9dqmK371gq4otR4c8uxRDwcQjceEzZN9qZMdzuIO2INqvgXKWedA1BcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082100; c=relaxed/simple;
	bh=++SccuCbKBv285ysID1UIv6JMney/tvVrvoFUbNLS7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqg8c3mziQFPmt9Mw7Ae2wFpDf0HV0noXPQTBn4BYfvJN6mAPZf3ZGwpf0YdbMRDmcIfcvaqmyc7ZQOmYPSpLsI7DOS/L/MGYhXfBwxdERH8wpmYrj29K/Fw2AreHjJvrYL3o5+ppayUOFja7I7pkidJAHzaAAT2KduT0pLwuEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Qguy9T9k; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qguy9T9k"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MbrkRELXNcf5gvBNbNySxsJYtwVEF+cOM6jcsoTTHSc=; b=Qguy9T9k3B7GnjxHjwC1FIPdqJ
	N/p37OAJ9UGrIn/D6m9I1/Xhr4LvYapn8ZcAYnBfcxrxV8H5mJ6EbXHjD9cfNdXJV9Z+w5o0b1oav
	Qmv3VzzWJOrW4XwJ1G0M9Ck7vgP6ZtLcZ/9FcMplXi+vQodyv0hAPx2rPkVGUYexO0xFIC3/f9+Jg
	q97Ifq1Z9Hjs+iksoCo+u7rIa/8HRLlt+e8AyFkM/e6x11AWiwPWtQsXJks7qcS+oGEUi6YZBKV26
	ej8uJw7D+d7S/0a9pDb3ecGVnuln6cFbA+NJuEGhDmCU382leMgqHo9F4ioaLA497EsVVmHrfh9+7
	oqvSYj0w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x907u-00000005PTh-3dni;
	Tue, 22 Sep 2026 13:01:38 +0000
Date: Tue, 22 Sep 2026 06:01:38 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jeremy Bingham <jbingham@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	brauner@kernel.org, jkoolstra@xs4all.nl, jack@suse.cz,
	djwong@kernel.org
Subject: Re: [RFC PATCH 1/1] minix: unify the v1 and v2/v3 itree code paths
Message-ID: <arJ8Mpef2gSLvKos@infradead.org>
References: <cover.1783324260.git.jbingham@gmail.com>
 <d9f07a9037d019043ed24d8245d9a58ce2c669f0.1783324260.git.jbingham@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9f07a9037d019043ed24d8245d9a58ce2c669f0.1783324260.git.jbingham@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

I think this is a good idea, and should make the code more maintainable
forward, as well as simply your iomap conversion.

A few comments:

> +	/* Set the direct block and indirect block depth now that the rest of
> +	 * the version-specific settings have been set.
> +	 */

Please use the normal kernel comment style:

	/*
	 * Set the direct block and indirect block depth now that the rest of
	 * the version-specific settings have been set.
	 */

> +	sbi->s_direct = MINIX_DIRECT; /* Always the same. */

No need for the comment I think.

>  	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
>  	if (INODE_VERSION(inode) == MINIX_V1)
> -		stat->blocks = (BLOCK_SIZE / 512) * V1_minix_blocks(stat->size, sb);
> +		stat->blocks = (BLOCK_SIZE / 512) * minix_blocks(stat->size, sb);
>  	else
> -		stat->blocks = (sb->s_blocksize / 512) * V2_minix_blocks(stat->size, sb);
> +		stat->blocks = (sb->s_blocksize / 512) * minix_blocks(stat->size, sb);

v1 always sets s_blocksize to BLOCK_SIZE, so this can simply become and
unconditional:

	stat->blocks = (sb->s_blocksize / 512) * minix_blocks(stat->size, sb);

> +++ b/fs/minix/itree.c
> @@ -0,0 +1,744 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + *  linux/fs/minix/inode.c

Please do not add (or move) file names in top of file comments,
they are a bit pointless.  Also we usually don't have an empty line
between the SPDX tag and the top of file comment.

> +#include <linux/slab.h>
> +#include "minix.h"
> +
> +#define DIRCOUNT 7
> +#define INDIRCOUNT(sb) (1 << ((sb)->s_blocksize_bits - 2))
> +#define MINIX_V1_BLK 512
> +#define MINIX_V1_BLK_SHIFT 9
> +
> +/* The different versions of the Minix filesystem also have different block
> + * sizes. In order to unify the itree functions and not have the split that's
> + * been in place for decades, we're going to have two separate types for v1 and
> + * v2/v3 block sizes. This does require having explicit version checks and
> + * casting block pointers to v1_block_t and a few cases where there's a special
> + * v1 version of a function that gets called where it's necessary to do it that
> + * way.

Comment usually should describe the current code and not the history.
There's a few exception where the history really matters like for bad
on-disk or on-wire formats set in stone.

> + * files, the last master commit before they were merged and altered was
> + * 87320be9f0d24fce67631b7eef919f0b79c3e45c.

Also not needed, git log/blame will tell us easily.

> +static inline int v2_block_to_path(struct inode *inode, long block, int *offsets)

Overly long line.  (a few more below)

> +/* same business with chain as before */
> +static inline int splice_branch(struct inode *inode,
> +				     Indirect *chain,
> +				     Indirect *where,
> +				     int num)

static inline int splice_branch(struct inode *inode, Indirect *chain,
		Indirect *where, int num)

Similar for a few other functions.

> +extern int minix_get_block(struct inode *inode, sector_t block,
> +		struct buffer_head *bh, int create);
> +extern unsigned int minix_blocks(loff_t size, struct super_block *sb);

Please drop the extern for all function declarations that you touch.

