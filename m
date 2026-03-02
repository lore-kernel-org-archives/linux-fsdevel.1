Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E283426D33;
	Mon,  2 Mar 2026 16:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772469964; cv=none; b=rAiD9hzj+tp3+Ej9KflEww0BlP7Rwtfx+NwrVodwdXPCIZS8WyYmj20fQwmkE6BzXyHBKwmnBcV5P6aHayezUhec+iim3hD+/R5+zzMh2Hw3w8ooG5e+RvaqWqpGv3HSSL4q6Dh+yemtq7SQpJ6bbIX8l/2S45MSSrm2beAYZ9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772469964; c=relaxed/simple;
	bh=YdYqAtsqv1tLj60VfDFC1Rqku23CARifpQgzNEg87eY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kH+f703RFSk/MDVQtvH4/m//ECk7m8Usij/JgEB8JBsjya6R1vhtFGPexySvhRddmZvvXfyX9hPYBYc9LHEWk0fQH/0rGkjgU8GCPMMO5mbblz6fHsMDmcGvzUTKqC4gf8ArSVJ4uFQ6XbBFFySgxVz7wMuTM2k3echwDIjxEvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=owS2QK6j; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="owS2QK6j"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8Vg7gqMeiyzPknt3qyMKgO+85Gcdawf8YPVMOwCXhuA=; b=owS2QK6jKnt+GVdLtj0zS8Wvnv
	omE+YRDnz15+BbCFScMK0nqhIE+g2d1g9cWeoRay+sPdP9qOR67XZZ1Hop8ALT8uO1s65oRagWMn7
	lzM58aSkEa9MJwJf4RWxmXXbN+r17MR/kwfI4iE1z7i3nMP8Y322XYS90pMvSu2lHiW2rSQzNulb5
	mPoNFIW2Tm0GTGn4inHkp5LiBPSQCt9Tgd0wv8Vqpp+TMEmesZYqJ0D/ZYz/5KIwR0IlwiQG48LPn
	IDG7qFF/nIVP5yO/j+/qmADSO53CG+iTe/CdnxFa1UKEnuYum7FRAsPRpjHitiNuFMWbjxGK9E4pC
	vNDIxDjw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx6P9-00000009mbi-1QvE;
	Mon, 02 Mar 2026 16:45:59 +0000
Date: Mon, 2 Mar 2026 16:45:59 +0000
From: Matthew Wilcox <willy@infradead.org>
To: WANG Rui <r@hev.cc>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] binfmt_elf: Align eligible read-only PT_LOAD
 segments to PMD_SIZE for THP
Message-ID: <aaW-x-HVQpSuPRA1@casper.infradead.org>
References: <20260302155046.286650-1-r@hev.cc>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302155046.286650-1-r@hev.cc>

On Mon, Mar 02, 2026 at 11:50:46PM +0800, WANG Rui wrote:
> +config ELF_RO_LOAD_THP_ALIGNMENT
> +	bool "Align read-only ELF load segments for THP (EXPERIMENTAL)"
> +	depends on READ_ONLY_THP_FOR_FS

This doesn't deserve a config option.

> +#if defined(CONFIG_ELF_RO_LOAD_THP_ALIGNMENT) && PMD_SIZE <= SZ_32M

Why 32MB?  This is weird and not justified anywhere.

> +			if (hugepage_global_always() && !(cmds[i].p_flags & PF_W)
> +				&& IS_ALIGNED(cmds[i].p_vaddr | cmds[i].p_offset, PMD_SIZE)
> +				&& cmds[i].p_filesz >= PMD_SIZE && p_align < PMD_SIZE)
> +				p_align = PMD_SIZE;

Normal style is to put the '&&' at the end of the line:

			if (!(cmds[i].p_flags & PF_W) &&
			    IS_ALIGNED(cmds[i].p_vaddr | cmds[i].p_offset, PMD_SIZE) &&
			    cmds[i].p_filesz >= PMD_SIZE && p_align < PMD_SIZE))
				p_align = PMD_SIZE;

But this conditional is too complex to be at this level of indentation.
Factor it out into a helper:

			if (align_to_pmd(cmds) && p_align < PMD_SIZE)
				p_align = PMD_SIZE;

