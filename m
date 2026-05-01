Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793B93B6BFD;
	Fri,  1 May 2026 14:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777647435; cv=none; b=I46HOCxYtRCNnc7qQuk4xghOMPK5c536YLVuCcu+SwwvYvYgq+WVu6ip5Ho4STgq1PCeoIRDSVJzdvi33nrvzVpw53xP0F4JzwgyCIRg3asJ5mIswX8AGCVsAkYjQf50ELkYLKpXSl5w8P+Z4bR0Sk6JI8xTpI9ZsNGUPw5ytsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777647435; c=relaxed/simple;
	bh=cD5tD6Wwp/+XKkn2/rBqtCfExQPEk48vj4DKlX6CW9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0yKOIMhFxRI1Y8YOvvr6gz/kTsZ7YiCgJF40Vvx0GzD/sn6NlLQS0kdJfkupHlfKRpnnPceR/IcJN9QwNYu74BY9tlrJbTpfuDW+WHyB1R6YXAzIR1PsGIFfoOeNWYvz9jkikW+ke+N/t4rA6bBusWHgfPJMB5dQRg3fy8eNlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCXW9Z9t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCXW9Z9t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F265DC2BCC9;
	Fri,  1 May 2026 14:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777647435;
	bh=cD5tD6Wwp/+XKkn2/rBqtCfExQPEk48vj4DKlX6CW9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cCXW9Z9tOVe03lA5sgszdhSe3z6mCYcfYG0AhmgcZmKLHVI1weSZqUOT2a/Dr096R
	 ZUnhgc8ihi5Sz6gs3A74A61MX57bHeyUxkUoeVzyit8jQ4alTeF6ebHGokrtwNZ/NY
	 8FOXS2r9IpDqg9IJ8Op765OXW/8sQOouw1Zx7n02k5wyo7sptnmbOQYeHYEZCBnUEh
	 MpngsAQckEn4gsyWJ4fQWP0m/Dbe722l9hBxWaC7agEEmNpM2HzEdfbajx8IZNEeLk
	 x0qK/zpv5NgpFBxm1uabTmBShwh6elIf+GBqbyjqkCNiNxzuHo2LuaMX5RPP9ZphQE
	 LOnB1EM0LhLQQ==
Date: Fri, 1 May 2026 16:57:08 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@kernel.org>, Jan Kara <jack@suse.cz>,
	Peter Xu <peterx@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/2] userfaultfd: merge fs/userfaultfd.c into
 mm/userfaultfd.c
Message-ID: <afS_RKHNBuiDoR11@kernel.org>
References: <20260430113512.115938-1-rppt@kernel.org>
 <20260430090110.f3ed78910ea7cface7d73199@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430090110.f3ed78910ea7cface7d73199@linux-foundation.org>

On Thu, Apr 30, 2026 at 09:01:10AM -0700, Andrew Morton wrote:
> On Thu, 30 Apr 2026 14:35:10 +0300 Mike Rapoport <rppt@kernel.org> wrote:
> 
> > These patches merge fs/userfaultfd.c into mm/userfaultfd.c and make
> > functions used only inside mm/userfaultfd.c static.
> 
> It's kinda scary how often Sashiko finds existing issues just because
> we made it look.
> 
> 	https://sashiko.dev/#/patchset/20260430113512.115938-1-rppt@kernel.org
> 
> Do either of these look legit?  If so, it would be better to fix them
> before doing the code movement, for backporting ease.

One is real, another one is not.

> Another issue in the moved code: the ctx variable is annotated with
> __free(kfree) but allocated using kmem_cache_alloc() from the custom
> userfaultfd_ctx_cachep cache.

@Roman, can you please explain to sashiko that kfree() is fine with
kmem_cache_alloc()?

-- 
Sincerely yours,
Mike.
