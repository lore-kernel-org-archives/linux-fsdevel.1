Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A554315D35
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 06:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774418530; cv=none; b=b/vpt7QLG7qWUMQpTJ5o2G0kEMHjueN/InapbOjtrXu23tsmmUybGgNSTuhXj68/P2PKOP3Ki9kQjAAmSsO3CRkK0JuicJ0ozELcdhlZlAeI9rqbw7bt4NVLMIkhcWXVT169yUCQnsnlfNb+RIWKYv4uaPqxWRVaC+DKVt4jVR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774418530; c=relaxed/simple;
	bh=vOaBkNKPQOZthjf88p2qEBTQxMkWTSMwFKAq+WdKe6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bvs8D5T/vb/KpH7pvh4XoNNSWOGlPy6kLkoH+y+OvTJOHxtX/O98QjKbBNYefOzPi0lsR3K1yIm0JhAL8AnS6H1RDoPes6NzEvWYb9CL0ZFAQ5vFiiW1xer+KnfAxBoXRDSZJrsQYk+DRa0qMJLoVo/17ONH0LsKBtT0/q3FupI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cIWtZYKJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cIWtZYKJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vOaBkNKPQOZthjf88p2qEBTQxMkWTSMwFKAq+WdKe6I=; b=cIWtZYKJEHy3n2MDiXQL5JqhSG
	XbZI+X7rtKeYd86Po1JNSEH4Lt6L6SiY04TARKw+Z3UqREgoenijeAV8rEQdNgG0AhUu5wKsjEpkv
	80eyogzCiAloS9sQhzU4/TWM8TcolhihA4dP6ulxjvj2RGqHKwSg6EIzkVIuxBLwHR8xFgLadLE34
	vWR7P0qtX9Y4uJ/tn1ppGTM1Q9wnoezBrGl9DmJ+P2/ZvLhslLorn0SKdj+9gTCahhQWGVoriTBT/
	gjD/EQuOvnqiQA6C+sGyaGUVi5zdn5LoIZsZAHMwMZ/JsHhhPJC/6KfAax0pEs2VgU/307kNtbPTP
	Yy4jsDlg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5HJg-00000002lID-1zLE;
	Wed, 25 Mar 2026 06:02:08 +0000
Date: Tue, 24 Mar 2026 23:02:08 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	Jianzhou Zhao <luckd0g@163.com>
Subject: Re: [PATCH v2 2/2] udf: Fix race between file type conversion and
 writeback
Message-ID: <acN6YNzbgVUPGETm@infradead.org>
References: <20260324105132.30490-1-jack@suse.cz>
 <20260324105316.28684-4-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324105316.28684-4-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The race is real, but I don't like exporting the writeback internals
for it.

It seems like the somewhat cleaner version would be to have a version
of mpage_writepages that takes and extra callback called in the
writeback_iter() loop and allows bypassing mpage_write_folio when
say returning a positive value?

