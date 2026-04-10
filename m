Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52A025A640;
	Fri, 10 Apr 2026 01:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775783734; cv=none; b=SYGhf9aFCqVhx+G7BdtP+HcDsEySb9euKftUMibD+vtgAKGgJOfuZ9PrdrboaEatgRUr9hhPz9ukQaAtmTtzwD+kDBjZQ2nz5BnEqUFM96OpOUeqt3P/9RpTA58kKwMmI5OWDsrKuHvzKSmmVp3IHq5tye8a6ED4FUxqbu4x56A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775783734; c=relaxed/simple;
	bh=82GZ4KNob8JYqSsZTREpcrcft6ZYfucxtR+SCLEQTTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5vx5LRdRJpHW9P036BYjORxu7QC8HG7xiU9O9I1adGeQvsG2dlOkAaKgqJ4L2hxuTHXVcaKm0xbUe4kr2uBm/xwUwnrXXPMHURGM5TE5phBw9NiELb7jW7r0m6KbjoTB2nmxakKdcP+9brrf6FGAnPwVtA4sqe22FwnvRwUozY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nqkeab3W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nqkeab3W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C8C2C4CEF7;
	Fri, 10 Apr 2026 01:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775783734;
	bh=82GZ4KNob8JYqSsZTREpcrcft6ZYfucxtR+SCLEQTTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nqkeab3WAwCYXh0hgzomJb+0jNUlUxcdx/ESJpMn9jt2YiCXrMO4oVqcDnwSW0FkX
	 DekQwDHj+mA6oIA31uB2wCKKXkQDU3+pWHvpzL8RvIEPRhtcvLtGER5884Un8RpVwn
	 YJNiwopI15oJxtrHkrRpzV+qRrx1+wmpU+kRHsN6B5DsWGon8ceWucuyxYv2Ov6iDk
	 EiSQb93ea0zpq9A5HYRbfiwirLyxw7fdejtVRhP3mLOTEbsXQDnK1B2+nyGUREu3lw
	 P3reDXvVmaLVcMSs3oOm+EsZ4ABLwbkWD3V7PoJug8rewBhUj5cFT7LM/k2MYA+nU5
	 i2+DB5HR8DN1A==
Date: Fri, 10 Apr 2026 01:15:32 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3] f2fs: do not support mmap write for large folio
Message-ID: <adhPNLtbAlqI8F3l@google.com>
References: <20260406154940.2407853-1-jaegeuk@kernel.org>
 <adaasm42rLxRY2GN@google.com>
 <adc7yo1_sr_eeV33@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adc7yo1_sr_eeV33@infradead.org>

On 04/08, Christoph Hellwig wrote:
> [adding back fsdevel and mm to the discussion]
> 
> On Wed, Apr 08, 2026 at 06:13:06PM +0000, Jaegeuk Kim wrote:
> > Let's check mmap writes onto the large folio, since we don't support writing
> > large folios.
> 
> What does this fix?  As state in the previous round of discussion f2fs
> only support large folios for immutable files, how do you get ->mkwrite
> called for them.

I'm approaching this as a safeguard first, since in any buggy case, this will
crash the filesystem.

> 
> The only way I can think of that is when clearing the immutable flag,
> but simply rejecting writes with SIGBUS after that seems like it's
> breaking the expected API, and I don't see handling for normal writes
> after that either.
