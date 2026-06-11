Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2814C40D585;
	Thu, 11 Jun 2026 17:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781197996; cv=none; b=t9/xMrTl1qIGuEoCCv4N07mAsomvmbe2Cx+gJL0xGYrVtwb0agxd/wRc09CHFMP/g04NeYRUK8vXrruwp8VZDNJf3LLP3WyaKUytAjglG+t2OLq4lfZhsAaZYVvQwC6NxcWIeFrRW5ch9fV+Kn0yLuXai/Xc++P4Spa7WignuTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781197996; c=relaxed/simple;
	bh=RVyohukPr6uQy9BSHx5migLlaOX8zqAG1e0CJbUcNrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNaJ5ePMz5jrMupfrR4/F5bGk3IuAuBjmg1Ei8W3Wl0qVHvtb54Nnhv4rSNNZ2Owt/SLuDgOFMJ14m1WN1DsgQOZDJcC/jJZl36b6RlqZaDOq9QxjnnZUwpADGendjTX5xVJl3IyeE60pBVOdWKLm4Q5lZ1xuHIgDwwZRpmG/1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=MyHry6lx; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="MyHry6lx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cWSowutYt9+is3M9Tr+5oqXpU+VO3hI3Z2ImX78drkk=; b=MyHry6lxoD7fg0AtHNu0ezgNo0
	yk416pq35EwsSBOOhSnDCZQhMZXAY19O5ZBFRmDZ6CDGxCuOrewsnRmAXCY6bFaQ3qi2jv5c0Fuk2
	3WYN9sLTNEZJNskROmjC3JqqNa74dySqkJJH+No/Rlj20F78xzntq7sUX2b02MYlkh61YCoX+2TzK
	HbvcHIH1bw+cPYMhKhJ2keIXu0wY4FKgg91g3aazlqnNPFmrmBF/SANr3RTHxSO/eMPJjMo9zOCx4
	90f7dsM3C7JiLP5JsTSEA6eOVVc+TVn1vLcRu+x4nIG2cjTbzLVt3FhWY3Z5h1B9nLvbSQB745zHq
	6rFQs4jQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wXixp-000000070H2-1eiu;
	Thu, 11 Jun 2026 17:13:10 +0000
Date: Thu, 11 Jun 2026 18:13:09 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Mateusz Guzik <mjguzik@gmail.com>,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org,
	"Christoph Lameter (Ampere)" <cl@gentwo.org>
Subject: Re: [RFC PATCH 01/15] static kmem_cache instances for core caches
Message-ID: <20260611171309.GN2636677@ZenIV>
References: <20260110040217.1927971-1-viro@zeniv.linux.org.uk>
 <20260110040217.1927971-2-viro@zeniv.linux.org.uk>
 <aWdGEI6iQBl3Xibi@hyeyoo>
 <19e0c58f-114c-4bbd-9bc0-25382d7d5cbb@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19e0c58f-114c-4bbd-9bc0-25382d7d5cbb@suse.cz>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Jan 15, 2026 at 05:59:12PM +0100, Vlastimil Babka wrote:

[resurrecting an old thread]

> The merging prevention is my biggest concern with the approach.

How about allowing subsequent cache creation to pick an existing
static one as long as it's non-modular?  That's easy enough to
do and it's minimally invasive.
