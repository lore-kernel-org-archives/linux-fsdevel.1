Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967322FFF8D;
	Mon,  2 Feb 2026 06:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770013751; cv=none; b=Ek483nTNeHRmKoje7hoCkIzxtVqt0qoiG3PR3Nx7rYPLGzc50eOR2EkTXtyaAkuiN2HlYHlAMddHF7W7WiSNJJD3Z3K6T+ea50LEu/aIiOjIIK+lZ3tf8A0EJ1Mc1JWvoWgSO3j+lDHs6gL3SyNf7w1lccIcAH82zOAxhBWyrp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770013751; c=relaxed/simple;
	bh=USoIlGY2W29ToM4EFnIWwqqfgO2VY0cok7WrY2g5CbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAUBTyd+TezWEWr5uGrTvUb+fPi8KqnrIdKZ6WVaxYw//2biC6of0ocTuG8Wu/GJfqxb1WvJiXEr+sfngm9YaW5jrJS5wcDhIuYdOkJiAu90mxC2xv9KG5+aH0zpYE2TEZ+BEXV1CaJIuQ/hVVTQOr0XMCqnvEMmYTLMw30V8/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1GahBN3U; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1GahBN3U"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/oKjHTVG6CyAT8j6qbVMz//QsWPZewlOwFkp4rGlQEw=; b=1GahBN3U6+mmZ2qIYiduF81d7K
	BbzNQaOvzG5FIn30dmH6YUt8Y6tGO4GWXdDgQu7K5672XX25tRGn1so1rMa8AsoZCwH9sahAcWJ9E
	bJEUhjGue+By5C5bDbQG4uzH9LNmISuQc2tz1XtbiUEIGF0vO7X2EcMvkYR/nJuuAkjkA130rZOFN
	dgSkA//FaHq+f8V4TxSoA14HCAhA2n5zE7F2rZZ8q0xesw7DDK1t7ce6BYdZjpApX4XijCqOrOo+c
	GBmlXd42iMbm+FegR4CqplBf6gCnWu3547YbGIn4GRV5YUCWmZ1ekEMwdQ56go/juMLmVkLSDwe3/
	H2fc04uQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmnQr-00000004Vwn-36uL;
	Mon, 02 Feb 2026 06:29:09 +0000
Date: Sun, 1 Feb 2026 22:29:09 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Cong Wang <cwang@multikernel.io>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH] dma-buf: add SB_I_NOEXEC flag to dmabuf pseudo-filesystem
Message-ID: <aYBENSqGtp0XUZBw@infradead.org>
References: <20260201170953.19800-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260201170953.19800-1-xiyou.wangcong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Feb 01, 2026 at 09:09:52AM -0800, Cong Wang wrote:
> From: Cong Wang <cwang@multikernel.io>
> 
> The dmabuf filesystem uses alloc_anon_inode() to create anonymous inodes
> but does not set the SB_I_NOEXEC flag on its superblock. This triggers a
> VFS warning in path_noexec() when userspace mmaps a dma-buf:

As last time, I think it would be much preferable to set SB_I_NOEXEC and
SB_I_NODEV by default in init_pseudo and just clear it if needed.

I can't think of anything would need to clear them from a quick look.

