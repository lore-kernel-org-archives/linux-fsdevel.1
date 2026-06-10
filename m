Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C14B386C12
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 07:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781077746; cv=none; b=jdII+VGQTwWodDVAEzDJXPkpFOK60TKxEQhYVlTZjn84lz+Yn8dUC7vxEOWIQTNWKNZ/+wAWoqtvD6PvZjndj4dpzN6m7g7j4DhsQZBJ0Zwa/bnFejr162K+re6UnU9jA1I+PfVA1biHiIWzwfxxOXrWIvW/6s+X1G71Uvgq9N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781077746; c=relaxed/simple;
	bh=YMFMWtteEbMWJO/ZXxG9nfNGlWI5RE1OGhpZEf6tddA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRvw4yncZL+Bep/K3zMo6GjTh2IENCb//NFR6S8HtzJliBfbZGHGmmx2SI8utqG2+vYH54tDIWHNcV5/XxUn6soaFcuqhWv61bTzFD+XULKdRiaegFUR7IhD799/V3l71TbSZ8HFJaE8ByAaB6l6NvTlZVczDf5qo9M562NvUrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mg0NQs5J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mg0NQs5J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B97601F00893;
	Wed, 10 Jun 2026 07:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781077744;
	bh=YPMsWdDpGC9/as3qFdfQkWrGikBrIlt5dD0ZVJjgJm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Mg0NQs5JeKC5R4JfPuJKebZGfBCTVrDsVLytLl/xnLtWv5QTjmFJLcULWSwvr0W7B
	 c14IXsj1rV0gc2N8LYcQtXrvdh6RZFu/dM+mHVCu00HBwRL0uKe+d0Xm/bcymnBmQd
	 aaLEAlpY5HX+Ov+vjoGGWwXiDs6A50G+BqDVoQei9s6TH1UUXfn8P5LQqFwIhEOmX0
	 H128zncSkyvQ2MV9TAMuzK8vouJ0y7ilpNG5dJ4KU7suGDyrYAxhXnvAenw1QIGKuX
	 Yffxk/5a6lhJuoJO/WL2rxzPUHR2rrC72mCQkNsSqtfQbZl8Z10Dx0oXyu5j/5XMOD
	 G4SMvampvsmHA==
Date: Wed, 10 Jun 2026 09:48:59 +0200
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH v2 0/3] simple xattr improvements
Message-ID: <20260610-mahlen-kolossal-burganlage-477125e4bcf2@brauner>
References: <20260601162454.2116375-1-mszeredi@redhat.com>
 <20260603-fehlschlag-teamleistung-korpulent-5e0b7fa7f12c@brauner>
 <CAJfpegvuY_EcQz8fgyWk22=agPq1sboiribP780DjR4i+eqUUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegvuY_EcQz8fgyWk22=agPq1sboiribP780DjR4i+eqUUg@mail.gmail.com>

On Fri, Jun 05, 2026 at 02:37:53PM +0200, Miklos Szeredi wrote:
> On Wed, 3 Jun 2026 at 09:31, Christian Brauner <brauner@kernel.org> wrote:
> 
> > I've fixed a bunch of that before already but thanks for sending it
> > again. Fwiw, we now also carry support for bpf xattr in the
> > vfs-7.2.xattr branch. I'm still applying my kernfs fix on top.
> 
> And sashiko keeps finding bugs, so I keep resending the patchset.
> 
> One of them was a pre-existing bug with kernfs, where inode locking
> isn't sufficient due to kernfs nodes being shared across super blocks.

It's fine. I'm used to it...
