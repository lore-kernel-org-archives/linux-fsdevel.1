Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A003D9034;
	Mon, 11 May 2026 10:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778496491; cv=none; b=sKCffefB5trjN+fG3b1z/KyvtdnSi6Obtus+ADdytO2DKUdpoY9UzW42YXUnKXlxo5AQoCuDdv/lCqpIK3PEGAsyjBsQqPF/JPti+1sd5f1Gesk/DMAzlCSpvVuYTTeuS3RZZslVBS2W0HaouLuR2ey95kSwFb0k/k9PQnH/DcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778496491; c=relaxed/simple;
	bh=/qkVo7GYeYmwoOBDSYzWQvb+QW8ccM5/OKJJemlcIGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHpjiqFf93Un5+h12sO5aa7PWuYqhNtlWclz27MPuhuEIhCcNrON6q2nriDUAF+t19nPGRJivnMMUjC4V64mJ7ms1IvlBC++8E2Zf5BslnJeaQQE1XveDIBJhb3zfHYnqrwln5CjbxhpMvyUkX2wxz8O+VcMbBOBgRNMs48hesk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=scI0iS31; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="scI0iS31"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD9AC2BCB0;
	Mon, 11 May 2026 10:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778496491;
	bh=/qkVo7GYeYmwoOBDSYzWQvb+QW8ccM5/OKJJemlcIGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=scI0iS31p3r/2zgmu76sbJ2EW57b76Bwi6195T8GsKljBBOukLTZDp9ZQdyhBkGCc
	 nIGSGLldvglCrMJe28eD7d3PnxziysU11HQE18UiSKP4SUys3FZOtNDPrujfHzaK9k
	 BOkVNig+v+YnL/zGYheFNs/vMmqgX/C8uWI5xh0s3qwERargkFEU/BNLlMz6IF8Ml5
	 yu+xl1rL4Iom0LgXbgYwHgkJegIxFADYBZ0yQXma7qUC6I0fj4jDJMJhZmE4LjdxLw
	 r91WLG3CSLavRllAQNe27gMq8NbhTDyD7cbrMZo7BuPbD18dafhJCaqNru/agGxb7O
	 GIOnAPCtWAM7w==
Date: Mon, 11 May 2026 13:48:04 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Peter Xu <peterx@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/3] userfaultfd: ensure mremap_userfaultfd_fail()
 releases mmap_changing
Message-ID: <agGz5J6EKskMk26F@kernel.org>
References: <20260501145433.156211-1-rppt@kernel.org>
 <20260501145433.156211-2-rppt@kernel.org>
 <3a04ae6a-049f-4d3d-b5c9-e60e86be8e5a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a04ae6a-049f-4d3d-b5c9-e60e86be8e5a@kernel.org>

On Mon, May 11, 2026 at 11:15:34AM +0200, David Hildenbrand (Arm) wrote:
> On 5/1/26 16:54, Mike Rapoport wrote:
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > 
> > Sashiko says:
> > 
> >   mremap_userfaultfd_prep() increments ctx->mmap_changing to stall
> >   concurrent operations, but mremap_userfaultfd_fail() does not
> >   decrement it before dropping the context reference.
> > 
> > If an mremap operation fails, ctx->mmap_changing remains elevated. This
> > will causes subsequent userfaultfd operations like a UFFDIO_COPY to fail
> > with -EAGAIN.
> > 
> 
> Sounds like we should CC stable?

Yes.
 
> > Decrement ctx->mmap_changing in mremap_userfaultfd_fail().
> > 
> > Link: https://sashiko.dev/#/patchset/20260430113512.115938-1-rppt@kernel.org
> > Fixes: df2cc96e7701 ("userfaultfd: prevent non-cooperative events vs mcopy_atomic races")
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >  fs/userfaultfd.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index 4b53dc4a3266..ef963a58f1a1 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -786,6 +786,7 @@ void mremap_userfaultfd_fail(struct vm_userfaultfd_ctx *vm_ctx)
> >  	if (!ctx)
> >  		return;
> >  
> > +	atomic_dec(&ctx->mmap_changing);
> 
> I'll note that other users have a
> 
> 	VM_WARN_ON_ONCE(atomic_read(&ctx->mmap_changing) < 0);
> 
> In there. Likely we should do the same?

Yeah, we could.
 
> -- 
> Cheers,
> 
> David

-- 
Sincerely yours,
Mike.
