Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0D0376481;
	Mon, 13 Jul 2026 09:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783936106; cv=none; b=pMwwX/3wUSnambnSCewK9HnIAsfyyNr+A4ah5EGMFA4wXbrwnveS/yftvB3LW08G0HGK+UeDzkrznbYkDsIagZessl3igCcx+vHgYPsVZZ567U0eIJ7sFc4YSt8HilqR2v/D+WIOD0FbMef96UwQ3t3YT+dF80Y09+xCfOU7wNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783936106; c=relaxed/simple;
	bh=fP8yFt8R8D7sAqGz83NpJdPfQ4Ca+oI3fBgflAbp/fU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=duZIN451NjiiIcVA/NI5+nkrYqP1RUr4QC2SaJSb88mIqWvZXYyyzGbdZwMUN5JqhLCnSxqdlFQfojeuG4M/l+wQF6XDpk4DDAI5KNd/bY4SfHCtkxCt3WkGTlHDug3yvTjdMap6XfaDawikLWTybLLQYgKaViBwZkNN8mbcshU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jnUX7DzH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jnUX7DzH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iTbx9r3jCENy/LqLVT+qXo6xfTwI3e9oLbYKG+6sxDw=; b=jnUX7DzHYppkAyNfi4NMxFXK/L
	oAzoTCtZwHoQvYF8shjHgqf4bsCNDy+8O2OyaoQovr85PNDT5PS+Rbk67uKVx55zUWrAoHERGcygp
	NXHtKNEkUmULn0600C2z74OOGNHfDXAtMH3Ay305UR/AqWhjcET9Dwzv2RamrDLjHJyO+8wIO7orq
	hP/+t/Hy5uyKCEM/pcx6AFi5QQz4K3pwaqI+lFQC6v7J1v30+i9HV/TkFg889KH/Ej2E1+P6stFaj
	01lfEfbQXsql5ge0J5Z+Kzz2/jxhaiv3vyPBDce1FqcBEQh2SBaqJzhJS7AcgwGqenZRoSHdUrH2f
	uIibOumA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjDGx-00000008mgw-1stE;
	Mon, 13 Jul 2026 09:48:23 +0000
Date: Mon, 13 Jul 2026 02:48:23 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jeremy Bingham <jbingham@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	brauner@kernel.org, jkoolstra@xs4all.nl, jack@suse.cz,
	djwong@kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v3 4/5] minix: add file operation functions
Message-ID: <alS0Z_wlS-C-2XxU@infradead.org>
References: <cover.1783707063.git.jbingham@gmail.com>
 <3f7e48122d2b280de63e7b901c7a1d7a99c0e063.1783707063.git.jbingham@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f7e48122d2b280de63e7b901c7a1d7a99c0e063.1783707063.git.jbingham@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Jul 11, 2026 at 01:59:08PM -0700, Jeremy Bingham wrote:
> This adds the minix iomap file operation functions, including direct I/O
> functions, and updates the minix_file_operations struct to use them.
> Previously, most of the function pointers in minix_file_operations were
> the defaults. With the iomap changes, though, the defaults are no longer
> sufficient and minix-specific functions are required.
> 
> The previously static minix_setattr function is also now exported; it will
> be used by minix_symlink_inode_operations.

How does this work without the next patch?

> +	struct inode *inode = iocb->ki_filp->f_mapping->host;
> +	ssize_t ret;
> +
> +	inode_lock_shared(inode);
> +
> +	const struct iomap_ops *ops = minix_iomap_ops_ver(inode);

Please keep all variable declarations at the top of the file.

> +
> +	ret = iomap_dio_rw(iocb, to, ops, NULL, 0, NULL, 0);
> +	inode_unlock_shared(inode);
> +	return ret;
> +}

But more importantly please explain the use case for adding direct I/O
support to minix, as adding new barely tested code to a legacy file
needs a very good justification.  And it really needs to be split into
a separate patch.

