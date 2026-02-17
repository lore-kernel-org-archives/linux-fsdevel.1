Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43583237163;
	Tue, 17 Feb 2026 06:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771309744; cv=none; b=hsZOQFGstZxO3UdpN1aQpbHjrKI7ua8TaGG7nXCbQuR8UZ3nV07pYT/oLAPMR9T3qRcNCJSNmsl62/ozqpSpblhxuNUwgBKNqhc7WeApH8qzpprGdVJLeWDhTrKXXZ3PCHaZ0Cn9meWySlGo5M7hfvvqTsLW+aTJ5n6HqFasAyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771309744; c=relaxed/simple;
	bh=WyAIcLIv591hmrCnNshjx/uIcz10rfxE5sQqt9EdVlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZR4HcNq12g4oDCVAGVOG/HHwxGYFn87YZMqZ83GsVz1eNWDVqdpE4ormQVWeHOYA+uvX8wHgWWFeQ+LIGcTfMEDbOKAZppiFEo/CCZwmWZHwCAufdhwARP1qlqJ62kjxYDYcXQsJgW6v660tCTb0jiiaT6fBBLFmA+m8bfLEtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M00YFvKX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M00YFvKX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WyAIcLIv591hmrCnNshjx/uIcz10rfxE5sQqt9EdVlc=; b=M00YFvKXrh4rOKik0+lHpzZ8if
	FA/zuidbNWaBqmRS7jg9mLSzMNqVM3O35q7nPgWKzkV9Z319PSbTGnDv0IsKu0IkC1McUPcYvzpo6
	VtX+L4r9QwxnBhiLV7bqrqcbjDrhKcQl8+rqIcmlxVDi11Ixl4B8iZ6nYgYKsNuxkggU7BOHmYflY
	MyQf9YMSGeQymKBKFj6V5Vq/TBqULhansGQ2tXxaY788QqdPCixiHEyBxsgT3zKzqghUiawsZv/8E
	W6uSmV6R2TLv7jpHw4XjXhYinaqttsC/ZiWL/NOorIy8V2q3YpRML6ii8WhTl7PceG/ZElowlqNJV
	5xycsmkw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsEZy-00000007huO-3Wc9;
	Tue, 17 Feb 2026 06:29:02 +0000
Date: Mon, 16 Feb 2026 22:29:02 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 2/2] fsverity: remove fsverity_verify_page()
Message-ID: <aZQKrpBZdRNkGGcF@infradead.org>
References: <20260215042806.13348-1-ebiggers@kernel.org>
 <20260215042806.13348-3-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260215042806.13348-3-ebiggers@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Feb 14, 2026 at 08:28:06PM -0800, Eric Biggers wrote:
> Now that fsverity_verify_page() has no callers, remove it.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

