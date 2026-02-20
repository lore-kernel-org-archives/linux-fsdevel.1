Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67D125B31D
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 15:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771602522; cv=none; b=Rj62Yo6tNcYWCYCo59dE+O5fZGkKxMfJ4aR3Y9pANgnTlEM/qDD/9OhALnytLeeBeCMGe4VRZaJqE51kqx1U/Bwyff+jGGrY+jV05jI1EdIVqWQSwVt4UVpLGqgQHrvuaZ3uGf/JsF8Y5f/Y11YwkhMb9VO28EUrw3cP0DfE9N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771602522; c=relaxed/simple;
	bh=gmnNpUBKvKiLGLM3Pk7E/9CIskZGdhnWrzhUkfFre8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWvJ+4dVeh7SlmTgSvi0CjYytf6nWqsqE75gMRt5hDAVoLxY/5DBcFcak5a6PzVMi8WpGmzzAgKkMEtDlnxT6dIu1BhDdhs/06iq3NtFSnWF+Txn7SJOgv7GmFp3C70Jk+kMpk065vAD/8tsDDtg3o71ntQzkgboxKaR8PmrvyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gWvDjnLL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gWvDjnLL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oDfl7ujLSAjPqRlO5CUQ6KS6JUy8p8t0K1tQN1Tn7uA=; b=gWvDjnLL035+PY6+cpFHvaeMZA
	o2dJgyipbwR6nisBvBYbndKXYD3gp8cYJiG5KPweJ9HCZoGmey81U9jSZ7L/mOfuDqvKfhQD11R06
	EI/Iq3Hu8eeJO0Ga5ZTGZxver0b9a3LkYTIaTouz8NancMdTSnggKd1bVcwCa5OYF8P3F9GXzXmW9
	ZtRjRPznwlXqDe00Zl6mWpNILZRsjLmU6Zl6HJ7Wj+d9YVOSv7JViddUjcTXWQrUbTUBKDdSDMCOs
	DhvhvCbCG55oGZZFrDR0aKe3Z/7m/VBiPoLs4Hbwu+GR0mXGRXy1jf2TJouBmcrfbL9edMje5obeN
	ItOceroQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtSkB-0000000F69H-1GkY;
	Fri, 20 Feb 2026 15:48:39 +0000
Date: Fri, 20 Feb 2026 07:48:39 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Nanzhe Zhao <nzzhao@126.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>, willy@infradead.org,
	yi.zhang@huaweicloud.com, jaegeuk@kernel.org,
	Chao Yu <chao@kernel.org>, Barry Song <21cnbao@gmail.com>,
	wqu@suse.com
Subject: Re: [LSF/MM/BPF TOPIC] Large folio support: iomap framework changes
 versus filesystem-specific implementations
Message-ID: <aZiCV2lPYhiQzYUJ@infradead.org>
References: <75f43184.d57.19c7b2269dd.Coremail.nzzhao@126.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75f43184.d57.19c7b2269dd.Coremail.nzzhao@126.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Maybe you catch on the wrong foot, but this pisses me off.  I've been
telling you guys to please actually fricking try converting f2fs to
iomap, and it's been constantly ignored.

And arguments about "log structured filesystems" here are BS.  iomap
has supported out of places writes for XFS since 2016, which is
right after iomap.c was created, and long before the non-buffer_head
buffered I/O path exist.  With zoned XFS we have a user that writes
data purely log structures, and using zone append in a way where we
don't even know the location at submission time.  So no, that's not
an argument.  f2fs being really weird is one, but we've usually been
trying to accommodate it, but for that everyone actually needs to
understand what it's trying to do.

