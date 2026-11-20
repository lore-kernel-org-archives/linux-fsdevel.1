Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795199392;
	b=ggXg93XWoX0ZchmknlgTfCt+9+HOO/Ffg2XAjFvdOn0NWOnaSOkqUTb9KhFvpMMIcZf3
	 m9rs05fSzOtToawIRSTo7+mG2DC0Wl6gHKtbVeXLUYoxBLgPn2s/YBnnYe1AklwtENnzU
	 pur0+UYZHFRsuN6tn9nld6i//C5tclrUsnRI0zj+ZNoMVnYzGJMPQxTd+TbMLmVBIQOBG
	 u0/zBl5SW11JZ4HJTrA2NN3Oz75NedpPg/qEdA+EAJOq1vld0vFqYxjshtXGDS5xi9A7K
	 FYXlt75nGd5BzSeJcq0zuRdGrLBYD/xK143/6+ZxEJs72buema0edI6R22LozoWWCyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795199392;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=NJSvfH3hHlUS9OIt5zexWFq1GP7XSwRop22U8RBchEI=;
	b=vPOkspeQ/R3eJm2EH6b5web3g7BdKSwDYA3fEZGYekyWkVpllgirWVNjsZxXKNAJ13lT
	 PLEynDxHo450jV/kQu6yufULRxT8mOHuMOUU2mfrUzX4vv0m6a78RFpBZAPGxViQbz/l3
	 EZ/AYH/yqj/DMwo5PcfCEvuYKRzVlW8gtEqeozDPJ0dnC0yJj95/VjcSVpdDej4ihDZfE
	 t+3kmPJUpc3VAIaKfDd+SbxfWM5yRboSndXNji9WYQSG2eJ5LB5MJqHXK+CajRh2ZOIXC
	 a2lGYRpdNx+De7MOs+gtIQ51q36F7IbwXmo3iorqkPmHs1b7ZZOnE3Ri6SK3zVGGRkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B44606A33E;
	Fri, 20 Nov 2026 18:29:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57B44606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1DA666732A; Fri, 20 Nov 2026 19:29:47 +0100 (CET)
Date: Fri, 20 Nov 2026 19:29:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	linux-fsdevel@vger.kernel.org, brauner@kernel.org,
	djwong@kernel.org, hch@lst.de, linux-kernel@vger.kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: Re: [RFC PATCH v2 3/8] fat: add iomap direct I/O support
Message-ID: <20261120182947.GA2339@lst.de>
References: <20261118020150.1023865-1-matheus.aalmeida@inf.ufrgs.br> <20261118020150.1023865-4-matheus.aalmeida@inf.ufrgs.br>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118020150.1023865-4-matheus.aalmeida@inf.ufrgs.br>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 17, 2026 at 11:01:43PM -0300, Matheus Alves de Almeida wrote:
> +{
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +	ssize_t ret;
> +
> +	if ((iocb->ki_flags & IOCB_DIRECT) == 0)
> +		return generic_file_read_iter(iocb, iter);

Does fat never cause a fallback to buffered I/O?

> +	/* Wait under the inode lock for size updates and partial-block zeroing. */

Overly long line.

> +	if (iocb->ki_pos + iov_iter_count(iter) > i_size_read(inode) ||
> +	    !IS_ALIGNED(iocb->ki_pos | iov_iter_alignment(iter),
> +			i_blocksize(inode)))
> +		dio_flags |= IOMAP_DIO_FORCE_WAIT;

Explain why the wait is fored please.

> +static int fat_dio_write_end_io(struct kiocb *iocb, ssize_t size, int error,
> +				unsigned int flags)
> +{
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +
> +	if (error)
> +		return error;
> +
> +	if (size && i_size_read(inode) < iocb->ki_pos + size) {
> +		i_size_write(inode, iocb->ki_pos + size);
> +		mark_inode_dirty(inode);
> +	}
> +
> +	return 0;

And just as a I comment on the hfsplus thread, this really should be
the default in iomap if no need_io is provided.  Please coordinate
with Slava so that we get this into iomap first and then rebase both
series on top.

