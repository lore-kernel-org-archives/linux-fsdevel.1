Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684E6361640;
	Mon, 13 Jul 2026 09:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783936469; cv=none; b=NZkFdxLu5UetYl77KUDb2y9Ft9ts2CepNOYpQoOXoJohBn+ZYiQmJfpb1l9QPsw/67W1ECRFCkbMlF/tUB0WeLiswJh/I6eHRTjDrg7wfhaPopjWlHIuas8Gry6RWurT9iNFfHM84S7LSKzP+zXESv2qIfT3+S5pE5IsKzCh4ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783936469; c=relaxed/simple;
	bh=26GXNLuPWwm5CbIbNH4q/RXdjx+O3/YkqdBt40TMLWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tg5enJBFYPQEutHZBO5bnkH+In4Gfx9MVKqpnb9mjREw/Ll44dTWLZaLNRFKo0O/IEgdMPESw22/kc6+rDrxw/qQctQXH5pTh4QZEEa5qDMC2llox7XeChFI2TL2y9gofnGIxJPm+e2aexAzltsiCShEoTwR3C3lBUJpNA0a7ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=E3ApafmT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E3ApafmT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/OWwIwvX/5OZCSXB7kUrsOa32NuFLL4I1A7QqdIigI8=; b=E3ApafmTcZxo9STmkc0/bFGOnS
	Qut7d4vZs0hTrDdNrzcpumZ2PDGfJbRganBN63AyVM1ptWkcOPYCP79Iox3AS2vm8BxRF7N5XAN+e
	6ZRVMXgrEi02uOjEfjKjcCwTaAJKCL4O1nChfI6qIDgrM+rzMab8BZ+CIWZ5YXVX+Ood4rH8N6NzP
	NSSKMgV1KJYuyYC+hb2Ef4BAf4S90QEPOHlURoeN1gXx4zx1aoHzay3A5qKcOsh7o05aJopSQYRhr
	zymHxwdz+bsi/RXv/zSutZHOdhh83ORpDbnopMFVFkcAhCOVl+kwG00QBpM84bR5eMtQlVnlDU9OG
	sqZdGstg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjDMm-00000008nQe-1m52;
	Mon, 13 Jul 2026 09:54:24 +0000
Date: Mon, 13 Jul 2026 02:54:24 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>, Jori Koolstra <jkoolstra@xs4all.nl>,
	Jeff Layton <jlayton@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <aleksa@amutable.com>, NeilBrown <neil@brown.name>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/14] vfs: add O_CREAT|O_DIRECTORY to open*(2)
Message-ID: <alS10NN_OduZEqvt@infradead.org>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
 <20260704164149.3480051-10-jkoolstra@xs4all.nl>
 <akyyqnv9EpY7xVdC@pedro-suse.lan>
 <20260707-vorteil-unhaltbar-apotheke-47bb105161ff@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707-vorteil-unhaltbar-apotheke-47bb105161ff@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jul 07, 2026 at 12:04:18PM +0200, Christian Brauner wrote:
> I don't think any of this is really an argument worth considering.

It very much is.

> This is a lot of handwaving for the sake of portability and concerns
> about past API mistakes. To both: so what. If an API is useful it's
> useful, POSIX be damned. We're not going to be fenced in by some
> standard.
> 
> 90% of our interfaces blow way past POSIX already - in most subsystems.
> If we'd back down ever time someone shows up with "what about POSIX"
> Linux would be irrelevant.

You can totaally ignore posix.  We need an interface that is self
discoverable on Linux.  Any combination of flags that was accepted
by previous kernels and gave different results than the new interface
do not qualify for that.

> It's been years since O_DIRECTORY | O_CREAT has been made consistent
> which means all LTS kernels have consistent behavior. We often make flag
> combinations work that didn't work or where inconsisent before. Nothing
> here is special at all.

No, we can't rely on something being backport to old enterprise/cloud
kernel.  Doing so makes the interface unusable for actual applications.

> 
> I appreciate the concern but even if this were to fall flat then
> worst-case we'd add a new flag and we'd still make that work. But I see
> no reason to not try the semantically obvious thing and make
> O_DIRECTORY | O_CREAT work.

New flag as in new O_ flag for open does not work because open never
checked flag.  Which has always been a giant PITA, but as long as we're
dealing with legacy open(2) that is what it is.

