Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3431D3F20F0
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 13:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781791112; cv=none; b=A/80PshyC18gllFDaPQDTkYoP0g+ytdd8HRcqMX7YkGQo+Cs2T5ERaoaYxykyQiwMKHRutdRvVOLRWL8W2cLx60Ap74UuAtNme3EOTM+DnWI+hEoXDSjYB3AuwP20JwG55p6e3apZsAuUot2yKV67M3I0DBRwxJf+0FdRyBfUYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781791112; c=relaxed/simple;
	bh=qA92zUOb3slrFKRM0dFudlh/bOkhEeVA8iMHOn638BY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swdUNbspF7sMsCwBKAEBkzkde323skIc6v7O7EzL4gtII5HpB7pP43gv46e/vNIwoL784Nw390B91hKIcQKHh0dTrN015m2V2XbgmIPJrxG+j4KQPh0GF6dHGYKoQzGj/JWqe/CVB2xQDqHX50TeI6YqyJibjtcVtQ597eTPowY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FIiBOsu+; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FIiBOsu+"
Date: Thu, 18 Jun 2026 15:57:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781791099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mr4LWNB/ttP0Z1Y1ct7LRrIF6oUiEjnkIFtWHFqubw0=;
	b=FIiBOsu+NhxRkAO5TyuJhoRWyLPV6Uy4tDdS1cUk7122raGGdgQ8NX333QM7uHlalgQfi/
	ryTKG/U/GKCFjjpunm4Jqn6qwmqCJ7JGwLWtv+YyeVj7NswhuzTvlYLZPRU7W4RXqkIYJ2
	nTs/YnnJwThzxSQLDy4Mk9OWzFLfiaM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Pankaj Raghav (Samsung)" <pankaj.raghav@linux.dev>
To: Christoph Hellwig <hch@infradead.org>
Cc: Pankaj Raghav <p.raghav@samsung.com>, linux-xfs@vger.kernel.org, 
	bfoster@redhat.com, lukas@herbolt.com, "Darrick J . Wong" <djwong@kernel.org>, 
	dgc@kernel.org, gost.dev@samsung.com, andres@anarazel.de, 
	kundan.kumar@samsung.com, cem@kernel.org, Zhang Yi <yi.zhang@huawei.com>, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v6 3/3] xfs: add support for FALLOC_FL_WRITE_ZEROES
Message-ID: <4qxthszoqxeccbor7je2vdrgzsyz6omj32v6kiypl5ogrmbjpc@qsynowbvvaz3>
References: <20260611114029.176200-4-p.raghav@samsung.com>
 <ajFQPANpajmFuKpi@infradead.org>
 <kn5dyqdxmsydibpfcurgpom5vwqtwinrz27oenh4pekks6ybdj@wyi4zkh7mogy>
 <ajOzoBt_peOCtNUm@infradead.org>
 <au3yznolpebvd5vphmzv73fzosdy7bxrb45kv56n734jnwwj3l@43d7sqlef27k>
 <ajO8AHsMFolUQLra@infradead.org>
 <xklmkbxoh7yfm5mkxxpp72wfifngzr2v4nfrn3lgzc57ep7nkj@louxc6z3gfmk>
 <ajP0sno47hihsCCo@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajP0sno47hihsCCo@infradead.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Jun 18, 2026 at 06:37:54AM -0700, Christoph Hellwig wrote:
> On Thu, Jun 18, 2026 at 03:26:14PM +0200, Pankaj Raghav (Samsung) wrote:
> > existing code **does not** overwrite any user data. Here is why:
> > 
> > - xfs_free_file_space (punch hole) punches inward (offset_ru -> end_rd)
> >   and zeroes out from (offset -> offset_ru) and (end_rd -> end) with
> >   xfs_zero_range
> 
> Ah, right.
> 
> > - Luckily, even though we consider offset_rd to end_ru in
> >   alloc_file_space, XFS_BMAPI_ZERO will skip zeroing already written
> >   edge blocks and only offset_ru -> end_rd are zeroed using unmap zero range.
> >   ( (offset -> offset_ru) -> EXT_NORM, (offset_ru -> end_rd) -> HOLE,
> >   (end_rd -> end) -> EXT_NORM)
> 
> Oh.  So this was lucky because of the corner cases.  I still think doing
> the proper alignment in the higher level code and only calling down for
> the area that we really want to zero would be benefitial here, if only
> to make the code easier to follow.

I agree. I will do the changes and document some of the nuances in the
code.

Thanks!

--
Pankaj
