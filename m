Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55C63A63FE;
	Wed, 15 Apr 2026 13:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776259153; cv=none; b=Xfh2/QkGk1Y3R2lRhDylFUfEuL0GMps5+JbeLTNUfBnG2sG3jXpuWs/7qBQzuvvsA7K+9LN+IfAo0EnjviECHV4uCv+pvl6CdiwXRuy7SjBM2vdZ/uAVhsaPO8KtdSlVZvZiRbr7rckPkg6Kx2VOhnh6FUxUtFU0i0nrkj2grD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776259153; c=relaxed/simple;
	bh=NjyQrc/SIWsRx9LrfF9k0Kny5CSr4/ZI0CBx7OPtN5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBns7YeoJjSeOk7bxEj0liVJluyRP0mr+NObu606hVHy9rpjxTbnGN/vcU6e6k203KjFcyguPVM7nAvL8Krg/wAOM1kAQBkL4/Mly9ATXJEVHtCsZ9wrZG1ruOjkPJd9FpcRgXv5w0SK2IdOXBSVivjPwAn01g0y0dwuct8kkEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cTsWp3lK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cTsWp3lK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=orY6koiAJaNJGnwmy/hv4MlDyhppHnSuDXJ/omxV6HM=; b=cTsWp3lKKMHyGaOX1tBCXsBfvP
	BMZB5NncQ90AOdtdmQlKCI3ihoRE64ilhTCAlPLvIBXKnjyaURFD5I/tKITPjL09Ez6gGG+Ed2TmY
	itAW3JQd5ZB56jAD49XacwFMyIbfzSk5RwvQ6ieoKPBnbXr1uMvHPTS8qWKEDZqbizPH+YNEggTpO
	2sfHTIyVwSM3GAEEwQVaucksjZHTABfr5JhexMmo90VH6WkS3VltIy+6YXp3oCoca8xN5W2cb7AO9
	XKLz7GJeWKr0jE8R59VSDS313GzG/TpIYAjwjqfXDfzq6vHA43v35IeD3ICmyC4BfduFHl5ej5/jV
	VTvjJ5QQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wD08x-0000000HU0R-3bxe;
	Wed, 15 Apr 2026 13:18:59 +0000
Date: Wed, 15 Apr 2026 14:18:59 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Anatoly Stepanov <stepanov.anatoly@huawei.com>
Cc: akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org,
	Liam.Howlett@oracle.com, vbabka@kernel.org, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, wangkefeng.wang@huawei.com,
	yanquanmin1@huawei.com, zuoze1@huawei.com, artem.kuzin@huawei.com,
	gutierrez.asier@huawei-partners.com, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] Use high-order folios in mmap sync RA
Message-ID: <ad-QQwctxvJVHW4U@casper.infradead.org>
References: <20260415192853.3470423-1-stepanov.anatoly@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415192853.3470423-1-stepanov.anatoly@huawei.com>

On Thu, Apr 16, 2026 at 03:28:51AM +0800, Anatoly Stepanov wrote:
> When "fault around" is enabled, 0-order folios might significantly
> slowdown filemap_map_pages().

There's a lot of "might" in this patchset.  I'd like to know that there
is a real workload that benefits from this, and if so by how much.

You raise an interesting point that faultaround may be slow, and maybe
we should start out with 0 faultaround until we've determined (somehow)
that faultaround would be beneficial for this particular mapping.  Like
we adjust the readahead window.

> For example when async RA won't be able to start,
> we might end up with a large mmap'ed file with 0-orders.

That is a feature, not a bug.  If access is random, then we don't want
to do any async readahead because we don't know where the next access
will be.  We just end up occupying large chunks of memory with
never-used data.

