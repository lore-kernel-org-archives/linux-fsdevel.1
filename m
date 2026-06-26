Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F003C09E7;
	Fri, 26 Jun 2026 21:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782510299; cv=none; b=d2M7TTuyJoPq07RgZG9QVT9iSG0eeaUaqm8fSp8XtF5u+aTUz8x3bsgGSMq8W4Ro8/I0yND7CB6IeA9npvCTqok/4pc0NbxoPTk/7+2EMRCn7Gx4CAlouVFH7y8fEaf1qpZf+5ynU3xGLNxNEGU4zSbWf9cu2A3dNyrzjFpr0Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782510299; c=relaxed/simple;
	bh=6DDsul9hyqsbcfeXb8XvtZYlQRGaxIH/qcwuB1Lg/uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkoIXjYj+n3xNr6pZ38gZo4JlsbgIvV7EM6ymoqAjoDRQld5jSTQbczE6e0NkFHHelGkoAA+vhkBy5DVi2fvZPCTw/P3Xjvuf5XzKIsXiUr2zaIeeCS5ux9OZz4IF/qaJzrovL+mCYH6+drVIhylccH3bJTK2QBEPfnyb4CH7mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fns/utCP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fns/utCP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LCu89Y+oe7Q3AvkYm1VrNDLLfemQ+TeHt7rrpfLUO50=; b=fns/utCPPxq5Zby8nTXadepBbl
	BX86YA4zVGgkYNkc3o01rRRVLEH24w1AEROA7VZP2WVFYMKT2P7XmQZjR6/P9NRPvPEmW51ZlH+VS
	hH0YHgtA8RDhH/u27LD69Mf+AMV/GjJjb1EeVuGyMgvDxlNXOBGd6UcP9mPl+7UAEibQ2MAmv6LA8
	SPU+LrODzYlzaC6KDAAOGSmt/Qb44hDDb8U2uh2WZMGMcjd9sZj3EJk6n5kd7t7R8rJ4unHG22XG0
	6YWfF03lAQSEfY+9fG70A40HR3hf/k2ey1zw1IQ41e582DSHSh+ER9dhuF3/Gu8chxyINH2wh/J9t
	40zHbRyg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdELx-0000000CY2V-12aj;
	Fri, 26 Jun 2026 21:44:49 +0000
Date: Fri, 26 Jun 2026 22:44:49 +0100
From: Matthew Wilcox <willy@infradead.org>
To: sanan.hasanou@gmail.com
Cc: slava@dubeyko.com, glaubitz@physik.fu-berlin.de, frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller@googlegroups.com, contact@pgazz.com
Subject: Re: kernel BUG at hfs_write_inode [verbose debug info unavailable]
Message-ID: <aj7y0RVR8LMtiTNP@casper.infradead.org>
References: <6a3eeb80.c68533e6.3320fc.f244@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a3eeb80.c68533e6.3320fc.f244@mx.google.com>

On Fri, Jun 26, 2026 at 02:13:36PM -0700, sanan.hasanou@gmail.com wrote:
> Good day, dear maintainers,
> 
> We found a bug using a modified version of syzkaller.

Do not so this.  Get your changes upstream into syzkaller and let syzbot
do the rest.
