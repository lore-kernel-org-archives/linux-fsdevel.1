Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89EAEEC3;
	Wed, 16 Sep 2026 00:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789518377; cv=none; b=B9CPJXj7K18L8jXvtrBWkjXZau7DaA1w8++dggtwUpmDWToGKTUUWuaQa6NNJXqXA+sKlMvL1qVewjZ/bQ5ITAVzYr0oUMLVLMcznAAJYkQUsonlBxriHJ+hAT0ZHfwZUN2w3QkD424sWX05snkXRiDibKncOEkhF29WXqCe06s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789518377; c=relaxed/simple;
	bh=o8taVg9Rr2Kigvw5mo6DgWhYdzIfpvEHcg5m6Cf0gJA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=O4yM8RQDfhrrDisOkID2G3ZnzttZH+vBAEqUr5tlRVzQEFmIxWRC0lpP3XjEV9W4ZMTUsQE6h1EntyFXsgqFKMhReT5T3keHeIgJMfWKXhN/iMjnWjebsIJnGpmL/Y/QA2UESJzM2FpK5t3EdOTeW7dkLTJawE8bv3luFzNzuFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VSpPMCTl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VSpPMCTl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56D81F000FF;
	Wed, 16 Sep 2026 00:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1789518376;
	bh=3+ztgyIfOhj2tASJ/91ZyWCK6hnrxelPzrr3OzJFsW4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VSpPMCTldQ00Bk4kYwJJbuZtbwNpq2bfq71QdVaYl3Lmdd4wcD4Sw7gcBliD01fHe
	 S47da42zxwVVOFPq4pHa5LUINedqgmgrP4CCiNRCftyON91dF9CR3moH7pluYxp3Ba
	 K3mgT3K5L0yupGA2vw2gaTkB9xlTMUfs4wJl/n3E=
Date: Tue, 15 Sep 2026 17:26:15 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yuan-Hao Hsu <aa9736195201@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Jaegeuk
 Kim <jaegeuk@kernel.org>, Pankaj Raghav <p.raghav@samsung.com>, Chao Yu
 <chao@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/readahead: use large folios in
 page_cache_ra_unbounded()
Message-Id: <20260915172615.c183c61c774f529ca57f1fb5@linux-foundation.org>
In-Reply-To: <20260915135909.1007-1-aa9736195201@gmail.com>
References: <20260915135909.1007-1-aa9736195201@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Sep 2026 21:59:09 +0800 Yuan-Hao Hsu <aa9736195201@gmail.com> wrote:

Thanks, and welcome to Linux (I think?).

> Forced readahead still allocates one folio per page.  Everything that
> reaches page_cache_ra_unbounded() gets mapping_min_folio_order()
> folios, which is order 0 on ext4, xfs and btrfs:

Are any other filesystems affected by this change?

> 
> ...
> 
> Allocate the largest folio that fits instead
>

This all sounds great, but I worry that the resulting increased
consumption of larger-order pages will cause all sorts of unexpected
mayhem to all sorts of unexpected things.

: bounded by the mapping's
> maximum order, by what is left of the request and by the alignment of
> the index, never below the minimum order.  Nothing beyond the request is
> read; for a forced read the request is exactly what the caller asked
> for.  If an allocation fails, or filemap_add_folio() returns -ENOMEM,
> do not ask for that order again during this request.  If
> filemap_add_folio() returns -EEXIST for a large folio, something sits
> within the range it would cover but the index itself may still be free,
> so retry with a smaller folio and only skip the index once the minimum
> size collides, as before.  ra_alloc_folio() already does the
> allocation, the PG_readahead mark and the accounting for
> page_cache_ra_order(); move it up unchanged and use it here too, so
> the mark goes on the folio that contains the mark index in both
> places.

So for several reasons it's

- allocate a large folio
- check it
- oops, can't use it, free it and retry with a smaller one

People do all sorts of strange things and this alone could cause
meltdowns which we don't get to hear about for two years.

So the change seems quite logical but right now, I don't know how to
move ahead with it :(.  What do others think?

