Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601F43314B9;
	Fri, 15 May 2026 04:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778820525; cv=none; b=TOT/1HVJQcA7jXCCC1RA/HT0oFZybrc9B10x5YGjZORy2g0SYELULhFfgrsNc/KRMcPpYT+BlDKVbb8uNA4v2Hm4bQSt818XIYlX+Fon1aOBbBE9dxJFi1pL8AxwmJu1RATpFbKpXvakKqpLTfC0/OSeaJuxW/NBg4jW6dfsf/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778820525; c=relaxed/simple;
	bh=qPBRSjwjGRgAzJf676c33YJBsp4pgtTFcmom5aggXCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvuY7dDLcFcXM7Xy87YMLcjmS/1+0d41HPFXCKkiA8CQrzmsaXD8S8/roJU82VSMik/zGSvtUfxpRii1ReoGDpKjOIBUXpBJoDBEjYngGGma0F601ApBKcNQ3A2Kz8xzB/QVySJ09ox92SlT1KXH1JHjOfkGOBcR8VHOF0AcRR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7A1DB68BEB; Fri, 15 May 2026 06:48:40 +0200 (CEST)
Date: Fri, 15 May 2026 06:48:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, brauner@kernel.org,
	djwong@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org,
	anmuxixixi@gmail.com, dxdt@dev.snart.me, chizhiling@kylinos.cn,
	chizhiling@163.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/11] iomap: introduce IOMAP_F_ZERO_TAIL flag
Message-ID: <20260515044840.GA4059@lst.de>
References: <20260513112156.9122-1-linkinjeon@kernel.org> <20260513112156.9122-2-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513112156.9122-2-linkinjeon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +++ b/fs/iomap/buffered-io.c
> @@ -837,6 +837,7 @@ static int __iomap_write_begin(const struct iomap_iter *iter,
>  			folio_zero_segments(folio, poff, from, to, poff + plen);
>  		} else {
>  			int status;
> +			const struct iomap *iomap = iomap_iter_srcmap(iter);

Please keep variables initialized at declaration time above those that
are not.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
