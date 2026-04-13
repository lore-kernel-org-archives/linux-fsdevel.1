Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313B534B69C;
	Mon, 13 Apr 2026 15:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776092960; cv=none; b=sE8egH6U/tP1Iq9LSEX6RD093RiNVEiFgwjip1gWuVIk5zx9x/hI/UHYh6/98fNt3tzJZLXg1GolYhpS/Kpa/f1NZTTCZ2JAeJgUwGEAWhQFhrgURBuUQUud2J8crMW9ygNeU0xbTBYmISM0myFpqGwa7R0F4VrVgB/fzj7ifJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776092960; c=relaxed/simple;
	bh=SKAzL3Yq8wXS7838HUXvKLtOK7sEtRRDjp+BXoCmWQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhVj6hEzpMcdE4mpGWxu11gafv1c4jjSenOfjiGK6DrEsgOiGxkAMaO2kXAE0MdvwMqfUT56QdwP31sNohcDM4RkMutyoNmXXETGK/PLUtHeEc3mWQ3kkQYV5YUPAOs91j36E/gUROcX+9lo9eZ0UN4ECF8UXdxx8YQToD1VEJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VS8nmYSN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VS8nmYSN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=p5+8HmZ+UOEZA8FzGHT3s0GYagF4SWgxaz82IDTYLWg=; b=VS8nmYSNeVgHpsaZaEZSc7alrd
	Ece6UfwpZo0gYAYOLFOJZZE/hBFiJouZpyUiuGmRLoG9nqad10NdYlmSwRfkKXaEpyxIortVDBZzB
	YHwfpcKYlHTflaNEEMhTaG9P3dk7kA5c9F1ulpcfrDhLhiu1a/K8+BeE19DOewDuNqIjS6UUAMqpi
	XOzy5is1AAJvzZa59KIoHkQ3/7tzq7g8aMyQbwGDt3kS3ndlAZmRFyPHqKaVfy+uK5Vh5EQV8sX4F
	vY0XZt1Uu2YhgWYEkyT+BhkpDUS38GmLSdtcYWd8vc4aVvj7ayThTM3Ic0fxW+OMSya0pgylj3us8
	eE0PL3CQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCIua-0000000E3Wi-0R8x;
	Mon, 13 Apr 2026 15:09:16 +0000
Date: Mon, 13 Apr 2026 16:09:15 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Aurelien DESBRIERES <aurelien@hackers.camp>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org
Subject: Re: [RFC PATCH 05/10] ftrfs: add file operations
Message-ID: <ad0HG2nC51h2ZHEv@casper.infradead.org>
References: <20260413142357.515792-1-aurelien@hackers.camp>
 <20260413142357.515792-6-aurelien@hackers.camp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260413142357.515792-6-aurelien@hackers.camp>

On Mon, Apr 13, 2026 at 04:23:51PM +0200, Aurelien DESBRIERES wrote:
> From: Aurélien DESBRIERES <aurelien@hackers.camp>
> 
> Implement basic file read/write using generic VFS helpers:
> 
> - ftrfs_file_operations: generic_file_read_iter, generic_file_write_iter
> - ftrfs_file_inode_operations: getattr via simple_getattr
> - ftrfs_address_space_operations: readpage via block_read_full_folio,
>   writepage via block_write_full_folio, bmap via generic_block_bmap

... where is this?  I only see file_operations and inode_operations.  I
don't see address_space_operations anywhere.

> Read path delegates to the page cache via generic helpers.
> Write path is wired but depends on the block allocator (alloc.c)
> and write_inode (namei.c) for persistence.
> 
> Signed-off-by: Aurélien DESBRIERES <aurelien@hackers.camp>
> ---
>  fs/ftrfs/file.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 fs/ftrfs/file.c
> 
> diff --git a/fs/ftrfs/file.c b/fs/ftrfs/file.c
> new file mode 100644
> index 000000000..ef121359b
> --- /dev/null
> +++ b/fs/ftrfs/file.c
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * FTRFS — File operations (skeleton)
> + * Author: roastercode - Aurelien DESBRIERES <aurelien@hackers.camp>
> + *
> + * NOTE: read/write use generic_file_* for now.
> + * The EDAC/RS layer will intercept at the block I/O level (next iteration).
> + */
> +
> +#include <linux/fs.h>
> +#include <linux/mm.h>
> +#include "ftrfs.h"
> +
> +const struct file_operations ftrfs_file_operations = {
> +	.llseek         = generic_file_llseek,
> +	.read_iter      = generic_file_read_iter,
> +	.write_iter     = generic_file_write_iter,
> +	.mmap           = generic_file_mmap,
> +	.fsync          = generic_file_fsync,
> +	.splice_read    = filemap_splice_read,
> +};
> +
> +const struct inode_operations ftrfs_file_inode_operations = {
> +	.getattr        = simple_getattr,
> +};
> -- 
> 2.52.0
> 
> 
