Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0470D3B7B8C;
	Sun,  3 May 2026 12:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777812562; cv=none; b=QqZKL5j7JdLglcDVJ2mmVjLabR3j8aNCiTeOXPK6/8HH3usEpeK6XBcUC/kHukUSCdcwn0qTRmGdgHd0M2ACLBMAL0R5ElyHm49RNwZ0T0O33x3/XkPTcmA+zDZTuocTsT9h6+g4uIL/sjeDezy0YeaRGjitrPB9mv3SwjdrBaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777812562; c=relaxed/simple;
	bh=TrMR0znl6viriI4PvPmdhsELcS1RSADaaddUqOFMxoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SH0cdRa0YYQOJOQGewAUiPlIYUnD6OcC25dVRJIvjCe3c/Z2RHvoYCuTfXM22Vyhmnvk7APlEnZbaCvU6YSlGPKZBlhM9StyGLH6e2rfjyym1iehZ+U92fqAdvcy8CnBdSbFo5EjUSsDPZXw9q5HK07AhfksCuewcKGLP/3u3kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Hvn9Sazd; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Hvn9Sazd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=idO2q8aWz814YWs9BFe+btmFIzZE5I6H/4cz5Z0SIoY=; b=Hvn9SazdQj5U/vpoALIaYpG2rw
	mWXffWb/iDQDGEsFwYsMoknUBgtDVH/wLU7j8o+0jFwrsSrE12+e4Xn5/6o1RuHoQlD/t1v0BGyXL
	tbd3qk0La67/A7IGRMEcFhjrOGIuCjNB3yYfkICXnGcH4m8bi6anW2Jr8jeMGHxX0calnYst7bliy
	owAuFFtToAjmUP7DUBIePPnZ/aucROa7BghIn2QZcRVmatqtOMzfl/xqQpx2NsB6UfYCKsjrJKRsK
	mg++JH4byAVx8zPTJVXADWSLjQLl7pQbsUAx75rqqxg3S/N/+ajCNKcLQ7ht+6qsfw9oX4QpI3ezi
	89/1lHgA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJWG2-0000000H0ev-0swr;
	Sun, 03 May 2026 12:49:14 +0000
Date: Sun, 3 May 2026 13:49:13 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@lst.de, tytso@mit.edu,
	jack@suse.cz, djwong@kernel.org, dsterba@suse.com, pali@kernel.org,
	amir73il@gmail.com, xiang@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hyunchul Lee <hyc.lee@gmail.com>
Subject: Re: [PATCH v9 10/17] ntfs: update attrib operations
Message-ID: <afdESUirlu57HBOT@casper.infradead.org>
References: <20260213081804.13351-1-linkinjeon@kernel.org>
 <20260213081804.13351-11-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213081804.13351-11-linkinjeon@kernel.org>

On Fri, Feb 13, 2026 at 05:17:57PM +0900, Namjae Jeon wrote:
> @@ -215,7 +232,7 @@ static int ntfs_decompress(struct page *dest_pages[], int completed_pages[],
>  				handle_bounds_compressed_page(dp, i_size,
>  						initialized_size);
>  				flush_dcache_page(dp);
> -				kunmap(dp);
> +				kunmap_local(page_address(dp));

This doesn't work.  kmap() makes page_address() work, but kmap_local()
doesn't.  kmap_local() returns a local mapping of the page, and you have
to kunmap_local() _that_ address.  page_address() will continue to
return NULL for highmem pages.

I'll send a patch soon for ntfs_decompress(), but thought I'd flag this
in case there are other places that need to be audited.

