Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61E920B80B;
	Tue,  2 Jun 2026 06:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780381100; cv=none; b=NdQB9bm0e+b8EXdyFqrDwBDjgVZdgEDW4VJCGmCV4qQdKSR1ZxxW9NejXUlsj6xgbfiflsXj9aPygdNL5cG/hqjMQZSIsW0IlL7THniZnVkkCYkJDbPv1JgG45vkPADgqmM83os2cVGXyo9r6VGuSwyhtczlPootUIE+FnCb77I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780381100; c=relaxed/simple;
	bh=hyxpncf/t80jVUqFcJG0wRjrQ9AF3VD/x6qqlvfP0hU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A5z36MBdkMUA0DuQvC5Tv5fRDnokQKN8HyYHHivI1k0/J/3dqAXqgUcyye1gLW/3a1OQbkkJOKopmUxo35tY/QAOU8Fr9RaCbkV37TntPaKagpg8uJdc8eJRmpKgZe4/4iqN4YpNboVR2SGasMHiI5gcekZlb64aMCmbqL/ZkSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VfhfK5bQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VfhfK5bQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hyxpncf/t80jVUqFcJG0wRjrQ9AF3VD/x6qqlvfP0hU=; b=VfhfK5bQmuOly0X0SwGcSDyTSa
	k3lyankE57F+HwUaE2hP3Y2EnGYyxYNDzdFVTeUdf5rQzErjK7sNJkG+5S+U3GP0ExGy9FHFXHtC3
	T9RoaObPQijyPTq/tFC8ibFdgHcEGsOCwSFFZ/l5ZzjEYY4/4aYUmhXAJCjuRgoVDX9+IUZ302i6B
	uy/ZPUEY/zZ0o1Tx+jmPcP09XquwwX7TvOiAp25A4DfBFB5d5v7CVni3iTeoPOR38sGMif36Ly+nV
	VhjTUVgmyA6bOyXMiMmIOPq5+DH/E3nGVINYuG1SRONE6Fk+yHtV0F8SKyk81/POKNGrLB+ZPVv4r
	IjDrApgg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUISB-0000000CNc2-0vqt;
	Tue, 02 Jun 2026 06:18:19 +0000
Date: Mon, 1 Jun 2026 23:18:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Farhad Alemi <farhad.alemi@berkeley.edu>
Cc: Christoph Hellwig <hch@infradead.org>,
	Christian Brauner <christian@brauner.io>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] freevxfs: don't BUG() on unknown typed-extent type
Message-ID: <ah51q5tW6us0yegJ@infradead.org>
References: <ah0wDkTgo3L1scql@infradead.org>
 <CA+0ovChveuAwv=t15dr2m09E32bM48hHJxvfeEYZOhdNiEc9Tw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+0ovChveuAwv=t15dr2m09E32bM48hHJxvfeEYZOhdNiEc9Tw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Christian, can you pick this up through the vfs tree?

