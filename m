Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559E240F73A
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 09:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790328091; cv=none; b=Nh9ssbnaQKSHzByrTdM3Ax5aRBNzwCXcvsI+lLbrXQsYZyBocGf521C6fUcSKNrb++19PLyl0vhjtJAPE+pVayDKUlfDNuZJn1dC2bT12atB4UxbYu19nwzcqS7BmLNv2fMZjzB4TF/6Zb5YApTA0u60/kazxhRmloL+93YlhKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790328091; c=relaxed/simple;
	bh=VX2zuwciIn8NOUKE8jUl/u/MQlWmqQLULpUK6rgBFt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRhv3HflVrzKRVSU7uNDtbn/2qxz1IFwyDm273ExWku/XX8xI7NeHkvomHahBRWpuJYCV2rYQNRBy1LV1BCRL6HnO6V3ghnDG6j380dBQu1fyHQPn+6LYHGVjjUQYGwTsoA3Nb/pP0h7NAgsYaHTHvQUtVS2nYTujfRM1zNMvqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YVXCk9fY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YVXCk9fY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iAdE2cUqIYJRNN1QnfwzdIju6pGQadjufo/cgrRaeEg=; b=YVXCk9fY071c5n/97Tfn3AysdC
	wCnWY+36/MlYgll3ZQn6G15WmzeWeFrVp2AagBJLVr92x+ZFdCyNhG+HtGC3lIofwumh91hOyvqYA
	cfxRVrmzwbQVJA59cLmD+UcWhZVV6NAftzPmMge/uQyZTuHr0hvhTUtHExjPUuQeepGfvGkReWkOm
	yxiunXNrZbi/MRDAzmyNQAyN49lbM+wLHDMLc8iyLdUgrY8bKFAPwK6hNivAcuo7FHRWMa/ZjoX3c
	MdX+U09KBXRVnSrl5/GDk5O5oHjCrUY6tOnMdg2hPJwv1Xlef5tXVlsQCB9stOX7paWmGa7p6Gp3J
	j4BW37lw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xA27Q-0000000CzT3-0ZdE;
	Fri, 25 Sep 2026 09:21:24 +0000
Date: Fri, 25 Sep 2026 02:21:24 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: linux-erofs@lists.ozlabs.org, xiang@kernel.org,
	linux-fsdevel@vger.kernel.org, amir73il@gmail.com,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz
Subject: Re: [PATCH v6 1/2] fs: rename vfs_get_super() to get_tree_super()
 and export it
Message-ID: <arY9FCatWwCw418K@infradead.org>
References: <20260812142907.1010046-1-gscrivan@redhat.com>
 <20260812142907.1010046-2-gscrivan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812142907.1010046-2-gscrivan@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +EXPORT_SYMBOL(get_tree_super);

_GPL please.

> +extern int get_tree_super(struct fs_context *fc,
> +			 int (*test)(struct super_block *, struct fs_context *),
> +			 int (*fill_super)(struct super_block *sb,
> +					   struct fs_context *fc));

and no need for the extern.

