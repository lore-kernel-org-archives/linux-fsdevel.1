Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC1C3B1B4;
	Sat, 29 Aug 2026 14:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788014863; cv=none; b=Gak/m4awm4j8yaxwCPokbuTY2e+CYcGDtG1RX680+u+EjvoCPSHCIoNMa4iyUomCL54qR+xKuuPFGUpramdCGGMcIhHa7SaivJIZ3ioVTsyuccQlDtpLZGKyDuYXv5TEP3fkhka+w/VMXwsLT2S0bvhaSlOzj6s9om9Y+yrtDGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788014863; c=relaxed/simple;
	bh=KAr+8bbwiyLK61Luj+b0j9fHioRLQNLSHQk+eb0BS6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWLIs+4E/Ww40F1Oid9INs72XVf8ZkSjm1cV5gJjFaSJ5JTwqtsOeguTvX/KBNZhkAnWR0/nOcPzgYJQmp+d0TMaUCOODK2BTDN7oH1hRl0odQY+YsbRpdlKtwCBHEPzG+Q5WNjUi8HB9h8Ms+Gh7QL8rZzXUOnFx4EnRnzUlcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=c11WGKUc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c11WGKUc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=451qKNGAxHR8XMQ8rJK+DM1y3GkdvqoIqzCuFMlj2JY=; b=c11WGKUc0QL+aSOLuWat6Mnz54
	vyrOGredngk9WE4fBm5aLGD4kX7pz0aYwyq0oalgHkgJBFFUWJJ0EohzJjFanrGdKw7agomkxuk3R
	NugGYXt4VvtntimIGrpChZWS068W/yZlcr3a/zfPTYQ0DA425LuE+LPl9b16ZtSNLx8EqIgZNHx6e
	dOpHizf0Wyn2UR7uq04FGbT5sYcPFo6QOj2cXBbBMVHCZ0+tS9lB9fGUtPgTM6UU16S4TkHSXyZY6
	YQU9f9GmRZnNfzw9kRUNueg0JsW5yLJBcbO/CgL2AQ+8xsBJXYPe0HX0J1pDvBxpi7dy7qr3nYse0
	ep1DJ5TA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0KLH-0000000Gbt5-16nI;
	Sat, 29 Aug 2026 14:47:35 +0000
Date: Sat, 29 Aug 2026 15:47:35 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Wenjie Qi <qwjhust@gmail.com>
Cc: jack@suse.cz, akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, baohua@kernel.org,
	axboe@kernel.dk, trond.myklebust@hammerspace.com,
	qiwenjie@xiaomi.com
Subject: Re: [PATCH v2] mm: filemap: retain mapped dropbehind folios
Message-ID: <apLxB3TIwFExyWOC@casper.infradead.org>
References: <20260820142956.1414337-1-qiwenjie@xiaomi.com>
 <3fa43eaca792bc0bbde4b82a6c1fcdd3f528b398.1787999152.git.qiwenjie@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fa43eaca792bc0bbde4b82a6c1fcdd3f528b398.1787999152.git.qiwenjie@xiaomi.com>

On Sat, Aug 29, 2026 at 08:30:47PM +0800, Wenjie Qi wrote:
> From: Wenjie Qi <qiwenjie@xiaomi.com>
> 
> Fault-around can map ready dropbehind folios without going through the
> normal page-cache lookup that clears dropbehind. A mapping represents a
> competing cached user, so retain the folio instead of forcibly unmapping it
> when writeback completes.
> 
> Unmapped dropbehind folios continue through the existing invalidation path.

Yes, I think this is the right approach.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
