Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62AF2ED84A
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Oct 2026 08:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791188069; cv=none; b=IaqINgbOBHhv9O500riD15qg8jwEBoEvJbN1+4+VWFFeOg26s9hbIKM9bWrM7UOEacborzyV78wbgyhOwwrH8L97IUROQ2omQl6zfV0ENWq9dYVy1vbI+GhHs5A5dK9iVRNHCkjNRJPKVgShfu5XeJqUb7zntVElparE/aSmi8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791188069; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NvIa1Z5tL+0ymx2YWnoL0xIcOmjQr5AjILsNwrne1/7+85wyyMnulLePeJACLmBEirf0AwSwHl77DwIQ4nASBo5gbeTUMzzFrQc/0G7bNcQ6JXElR1OUVIJqGiJGRIFaaLG4yoYZHAsL9iMi8HUCuLaSg72oy5ENXawyd5WDF44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=voGYnLYw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="voGYnLYw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=voGYnLYw7LRWDRfrLPu2cB2s8s
	5X2eqIm72RX/YNF+BXZsY38xR2cXY8NvNI9nCNR0Y0kqTkz36vkXyjBIxrd1TUtD1/XaYVlbOjLDM
	zvaeJWzvUM7JZ2bB4IPl7UHCeuW7u6tiy75swU7z9ETqgbd/jeulJvZJC+6ikvkPhdUFpfu/sq1ap
	i9xt228JjzZU7Hzlx3SjVg3LVgnfPw7rJ5uLrsgp7nNqz5FN5oLt3bU/H/kzA5Xu+cwYhnHl/T8oH
	wo1q61GSzlJVXLtDUUqt2QkLmyVnJ/6q5TMkTkTFjGE9T69gkRDtaKvJV+zipgU6x8r6mUCU1OwIV
	AA/p3PAw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDdpv-0000000FrJj-3n7S;
	Mon, 05 Oct 2026 08:14:15 +0000
Date: Mon, 5 Oct 2026 01:14:15 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Giuseppe Scrivano <giuseppe@scrivano.org>
Cc: linux-erofs@lists.ozlabs.org, xiang@kernel.org,
	linux-fsdevel@vger.kernel.org, amir73il@gmail.com,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	hch@infradead.org
Subject: Re: [PATCH v7 1/2] fs: rename vfs_get_super() to get_tree_super()
 and export it
Message-ID: <asNcV-k_V0dHXGC6@infradead.org>
References: <20261002163225.1258203-1-giuseppe@scrivano.org>
 <20261002163225.1258203-2-giuseppe@scrivano.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002163225.1258203-2-giuseppe@scrivano.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
