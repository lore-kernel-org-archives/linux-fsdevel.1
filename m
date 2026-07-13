Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93B4299943;
	Mon, 13 Jul 2026 09:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783935984; cv=none; b=NQBzTHSl20y1qmbK4UYj7X6ml7ry8UZMiLgkjjm6mIx4oyYwYCvusCMMCu7Ek8x5eo651m/Huu+pz/0sMmOrOKxnlgQ+d42vA6biWBiRecCEgEpywR8ezWBl/BsjX3M/HBdwJIywzA3tRpEsdbJjPtempMoPi3IZeug8LCJbWCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783935984; c=relaxed/simple;
	bh=fqOiogvTdJ1fUrXdw+UzoLk8SljpvXnGex/3IYgo73E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIbY4X9CbAhBb/Oy9SVeDeFoP1JI/7B9k++nwVnlgUE2tAtokLSHRCuUXKqCsHx3L4E13/RCE8YXdrE/nml3RAMEstJY1YEh1KG5skdr4BYSRdfdg2xwtutxo67j91Aro9F8g5ddTUWLE6qm1Jm+7IcS/+NKywbvS1UXw/c03yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4DnTIGzo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4DnTIGzo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vnEh4wx1SP8GKhugiaqfF0tKeBodLemLvD6ncfFgk94=; b=4DnTIGzoAtyuHP3g0oPt7BYqLM
	yiHb4MB5ypNIVyzqC1fLfTL/LT7XPICftUeRbdj6ThrWM+2du/CEJhTYiFPkkp1x13SPIrDKNloPA
	Tsz0RTSLwgrCKkOj/9A2ft8JT1U400OQRCTtNxlYFzYC5ysxPIrbIPMeWATXeMM6Wwdcu7qVcFIMv
	Z/8pBd7bcx7AphOJ8cpvu5IR6sU1sJPu8fQ61+EzS8gPgyh3mZEdHwN3XZIiQwuxST5k2802v1YM/
	T8jv+n66FlIfoj2Zzmhm9NOdZLw7TcXzstHLGCDgHD5+lLloLnKTDTpGlcPqXEDWxCEoA4h/ozqr3
	yabLQ6pA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjDF1-00000008mPP-060E;
	Mon, 13 Jul 2026 09:46:23 +0000
Date: Mon, 13 Jul 2026 02:46:22 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jeremy Bingham <jbingham@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	brauner@kernel.org, jkoolstra@xs4all.nl, jack@suse.cz,
	djwong@kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v3 2/5] minix: add base iomap begin/end functions
Message-ID: <alSz7t4x0qjNO9ee@infradead.org>
References: <cover.1783707063.git.jbingham@gmail.com>
 <555d199291b37e5c1241df648b3adcd760c1fca6.1783707063.git.jbingham@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <555d199291b37e5c1241df648b3adcd760c1fca6.1783707063.git.jbingham@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Jul 11, 2026 at 01:59:06PM -0700, Jeremy Bingham wrote:
> Adds a new file, iomap.c, to fs/minix. This provides minix_iomap_begin,
> which is the iomap-based version of get_block in itree_common.c. It also
> provides minix_iomap_end, which is a no-op but required by the iomap_ops
> struct. This also undoes the nest of gotos inherited from get_block and
> uses a set of helper functions instead.

You don't need to describe what you do, you need to decribe why you
do it.  Bonus points for explaining things like design tradeoffs.

