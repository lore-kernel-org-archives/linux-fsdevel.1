Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5739E2AD3C;
	Mon, 13 Jul 2026 09:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783935134; cv=none; b=hpbDnU4CNBmaNc7AB6IKc/akL41QEx5fCo9UAkbqTVftVWFtW0czxxv/IHjmtkZvuxTiHFnNgX+jwuYjW2Z/mQXU5CvKsXE1qzXKNuicxH8mAPNFXCGRUAXtSzrnMnP7up8W3+lFUNYyNmne1cMReCUmETx6qKh6Eg7b9gg3yLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783935134; c=relaxed/simple;
	bh=QkXAV0zBiRXwwSHPz/YY8Yz2dSU69hpNMYTj1Zy+yLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aj8JUYy+jRZxacMAfsLQux9X0mEAVvhKWluO++Ucl7L5Ol1iIpJ8bUDVsVPZp5p9oLhcfQZ0AgHfaXvE5oxZUI4ivYvNPKSaYG60F0bZj8PAcQX60kPGAgrkKd/1P66WNqPrz1WxPQ5osM66GzZUF+ZzbS3OZtf9iwne7Zwb9Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XQZ4p9Pg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XQZ4p9Pg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uP13plPILC7OCFNCpAqpwNNrIKlA9RwJz1xvtbKv2z8=; b=XQZ4p9PgRIar3otTj6/MOs7mat
	zSK99QFeaWaRKKK0Wr3nDhIxESZ/tBZPY1MfW1u71CSPNc6057B0O3UFHHYV0WL7Pj9jDdm8wdmRI
	uoebKrfqG1TdW/KHKcHs6ut3+b8xsWGK6C4an1f27ybsJscJSiTk390zuCOX6qnpVYgeGcGNXjYWd
	j7TifPIFVmHyO9U9alqD7z54tu6brCbyVmtvmPD/J0jUZQPLvQGGSg7NIUCQBgDxqfNKXpjGEKKzc
	dJK/GKLenY62r732OT2xwhwcCpWpehAhG2jcpPb2WeQngu71N7tg7lkUKTGUeCnoH+guv6l4SqdJ5
	EuIVEx4Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjD1I-00000008kEn-1MFj;
	Mon, 13 Jul 2026 09:32:12 +0000
Date: Mon, 13 Jul 2026 02:32:12 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jeremy Bingham <jbingham@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	brauner@kernel.org, jkoolstra@xs4all.nl, jack@suse.cz,
	djwong@kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v3 0/5] minix: convert to iomap and add direct I/O
Message-ID: <alSwnFoGwVBRVlu0@infradead.org>
References: <cover.1783707063.git.jbingham@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1783707063.git.jbingham@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Jul 11, 2026 at 01:59:04PM -0700, Jeremy Bingham wrote:
> This is version 3 of the minix iomap conversion patch series. Versions 1
> and 2 both had issues that syzbot found while testing, while Darrick J.
> Wong gave some critiques of the version 2 patches that I have addressed
> here.
> 
> This patch series converts the minix filesystem module from using the
> buffer_head based path to the iomap API, and adds direct I/O support in
> the process.
> 
> Patch 1 adds a new iomap_symlink_write function to

There's no point explaining each patch in the over letter, that's
what the commit log for each patch are for.

How did you test this?  How do the xfstests auto group results look
with an without the series for minix?

