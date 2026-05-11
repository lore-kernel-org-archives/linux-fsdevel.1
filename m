Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF963A3E68;
	Mon, 11 May 2026 12:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778503509; cv=none; b=EvVb7riE2GbLux0q6HnghJVcqEdXoV4bsnHLQ5lUfVmBSUVkOgMWF4kYoR7SnHbYcxLHvEmUiNUy1SGFNfFY+RvamhYDwKapgOT2bAiONxaQE28JfectQObY3uhfrXjpRspEOjcKji/bgdHfku1zPCf1XWisYbTC49IxVzmQpbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778503509; c=relaxed/simple;
	bh=/yNvwTDqUbvovXKBNIOtpKgSlfZgXtb4yLkjW6r843Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C82xUboQnpbphs0YmH4dXCvoabug8+iAWXs1jJibpwFSqplqiilHxJzpwFDPgVTJKs8NWV+9ZZEZQ7nfjUBKcEvhHy7e+dp9CRe1rkfI6YgoS8lwj938RUmedMfMus+Zn8oG0AciXJulBn7R9I8Vy530EW/XV4ROZi7Mi3wwrjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id EAADB68BFE; Mon, 11 May 2026 14:45:00 +0200 (CEST)
Date: Mon, 11 May 2026 14:45:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, brauner@kernel.org,
	djwong@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org,
	anmuxixixi@gmail.com, dxdt@dev.snart.me, chizhiling@kylinos.cn,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/9] iomap: introduce IOMAP_F_ZERO_TAIL flag
Message-ID: <20260511124500.GA18149@lst.de>
References: <20260507124238.7313-1-linkinjeon@kernel.org> <20260507124238.7313-6-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507124238.7313-6-linkinjeon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Note: out of subsystem patches should usually go first to stand out.

> @@ -853,6 +854,9 @@ static int __iomap_write_begin(const struct iomap_iter *iter,
>  						  len, status, GFP_NOFS);
>  			if (status)
>  				return status;
> +
> +			if (iomap->flags & IOMAP_F_ZERO_TAIL)
> +				folio_zero_segment(folio, to, poff + plen);

> + * IOMAP_F_ZERO_TAIL indicates only the unwritten tail of the block should be
> + * zeroed.

So trying to understand what you are doing here.

We're writing to a block with the magic all invalid beyond this marker,
and you want the data beyond the file write zeroed.  This seems really
nice and simply, but talking about 'unwritten' confused as I assumed it
to be an unwritten extent.  But I guess this is not actually reported
as an unwritten extent, right?  Maybe drop the unwritten here or
reword it as

 * IOMAP_F_ZERO_TAIL indicates the remainder of the block after the
 * data written should be zeroed.

?

And for all this to trigger that write needs to be at valid_size
but before i_size so that iomap_block_needs_zeroing does not kick in,
right?
And this does n
