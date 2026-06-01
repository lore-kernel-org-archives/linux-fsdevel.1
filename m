Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE593A4F5F;
	Mon,  1 Jun 2026 13:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322353; cv=none; b=hW10VMXGlTfZC2GfdX68v44w2vfCCguk1dHvXU3BQtkEdk5omiULRdPQD5po//GYxc3EkmOW4FCy5pZK5qs6c9x4TgPhgnSdrsu3hHCnugQG19Uvd/NNKsEUTCQ3YFVWA0AmwAmqnoK9Uwin9x84QgG04Zkju0xB7BS/FGZKmfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322353; c=relaxed/simple;
	bh=Y7LUlWnCBuFlIl0ZfSxLQrQhlcHF0tpOZ7ItCvKLOcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=deWm4/tZ1kyvrBcjyZKokMK21DRlf8tlIGMlcY8FlMI17B6OfIIj3btRcaY52qzDUPwI1FiPMzGVe/oRREZNgFDhPwPqkh5eLHtM4iNshOXyx0cRGGH3r+he0jCp+07Ui658w61hrwrHiLejZA6KV8jhjRjExwyrnBMmQL/dPx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XxXYGu7h; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XxXYGu7h"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BlO9fhb4LnpJsMUQrtw5sIyHWQGmZWd74UWypqIxzL8=; b=XxXYGu7hAOfubhOHWn6yu7LcOO
	F+qHetGLL4ojNK5CMLYmsnOTXpunLAM7wGwYqNkKN+qNDr3jKx5ULh21ZYBpWCF+n+jD81YlBgR99
	tdySmQnpN/A9KmP7Q+fih7rz1gjySVEBrZECJk4ju5fY92RhkZi5c7p9KN3ScAS80ZzXFIaDgA1Je
	3LaJ5Ga1v0Kjm7MaPjnNey7YQgZ8pU6E0Znhy0fF95q0om4m4iAgd9OnvlcgQer5MCkokdWU/VDF7
	6mnXDDKzry492oZlQ7BuuTdaty/R46g9bmhFY5PpMixqH9LFbJ5NNmrKvtFwDTkmmiE6Vua91DWyN
	PN8rNqKg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU3AW-00000000CEl-14rO;
	Mon, 01 Jun 2026 13:59:04 +0000
Date: Mon, 1 Jun 2026 14:59:04 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Chi Zhiling <chizhiling@163.com>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: Re: [PATCH v2 5/5] mm/shmem: optimize file read with folio batching
Message-ID: <ah2QKCFWdzXIW448@casper.infradead.org>
References: <20260601055704.167436-1-chizhiling@163.com>
 <20260601055704.167436-6-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601055704.167436-6-chizhiling@163.com>

On Mon, Jun 01, 2026 at 01:57:04PM +0800, Chi Zhiling wrote:
> +			if (folio_batch_count(&fbatch)) {
> +				for (int i = 0; i < folio_batch_count(&fbatch); i++)
> +					folio_put(fbatch.folios[i]);
> +				folio_batch_reinit(&fbatch);
> +			}

folios_put().

> +	for (int i = 0; i < folio_batch_count(&fbatch); i++)
> +		folio_put(fbatch.folios[i]);

Also folios_put().
