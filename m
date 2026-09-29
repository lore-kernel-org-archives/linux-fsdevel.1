Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4393EC815;
	Tue, 29 Sep 2026 08:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790670577; cv=none; b=DEYbISmyBwAzXo2Ev2P4ZWHwpStNLjxtcuunyMqPeKBReuAwVdaNe6eY2n74xbVwqp7KUSxUYedbSU/MSgbScJalR+qNhxYR+1PfkD4ZbsLwPJm3FagC2qzMmtBV4IvRR5gP9G2tusBcVjpx2YRhj9cYWnotM1UK9UYM/Dk+hSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790670577; c=relaxed/simple;
	bh=u0sg1Ti+E4aZiwfKlS9ydD3fFdToUW4lWf8TY7zxPwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LANDpVaoXD23XEXpCE0LE6gYwIK+XRWmEmRgrIWg5W7tIcLxP+ay0yPaMaWS3vZIwKP5RL6ZMSda4ETGW/iHVP+PWOIpjSO962U7OE+e7S7BO5Es01zZSm/laXDVRTh8oMIKoC7Gl3Tx63/+CUlF/On4ndNSJ2EDcie8GH8So70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4Ec+mUu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4Ec+mUu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EED61F000FF;
	Tue, 29 Sep 2026 08:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790670576;
	bh=SvYs8oTTLWW30Z0Y3Id5dc1cjq+MB+XC02/n2Rslonc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F4Ec+mUuo6iSWS/a0bAmilxDGLqrNdoBVhLiAsG3fhr3cnyvAYAVsgsy+OEso/Y2c
	 HecQdvqIl+OFkZ+V2NG04p9XlOoKsVba8tehPWO4+IxNAPnlcCOrXio4on1Fv9jJwU
	 UoIEQsGTvndst4632zx3z5vux1mj/MihB8mVGvUzzz5Lw6+wQiIIawM38OFLtOqy24
	 OdACzt4BCLi700IPhZvFOVHM5L8xhGFgKJmhVraaYazdN7ltNsQKMklIcR/LsrBshu
	 7B8lshGy80lC4jWykyXRtZvxcrAuFQP//zwRSVeFpHEg5pUCn+kBqzOA1lIrS73VCY
	 l7oRVr4zjCx0w==
Date: Tue, 29 Sep 2026 09:29:28 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/6] mm: make MAP_PRIVATE-/dev/zero mappings truly
 anonymous
Message-ID: <art2jydFy43SQB14@gremlin>
References: <20260926-map-private-dev-zero-v3-0-d4781e84ccfc@kernel.org>
 <20260928163957.832a27ee9596a25a282c2707@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928163957.832a27ee9596a25a282c2707@linux-foundation.org>

On Mon, Sep 28, 2026 at 04:39:57PM -0700, Andrew Morton wrote:
> And...  really?  I already had David's tags so we did a full resend for
> a single comment typo?  Little -fixes had their role...

You kinda asked me for one ;) unless I misunderstood what you said!

In any case, yes this is very much stabilised!

--
Cheers, Lorenzo
