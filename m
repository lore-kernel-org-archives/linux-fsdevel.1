Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADE43002CF;
	Sat,  1 Aug 2026 04:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785558230; cv=none; b=Rv54zQIsX8gYOnC3UfNCrFaQI3BWEBnMsOpgYfFkFh9sfs/RWrlNue53OT0gy8cZ04kyl0/WOGEJ9nSiz+GwSGGvTjwaA9CsjZCcwiN8s0ILs+eAuVn8O4a8oaIFHUOxaFUcc7PiJdyVi473CZbw8BgXzfwqruXKv0K5khZwd2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785558230; c=relaxed/simple;
	bh=PAGPgZFy2YxwvWNwpcrFt+tVBwZ1ihJpG38DoiiNB0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdwswLgAUCq0Mse+VhSbxrVJvR2ql1gifJ7nQMVX+se81AMaogLbOwDvLJ6SVQR/XwgXUbu/737iHLxou7twyOSxpXoUrcGW/jo4C+vgCgcUW5m6u6bAzj48b9SOB/kh6U+e4KPZ/Rhq0RztsUzQGXWoR4hBLdwjUejG4qhfxZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rqUr0meg; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rqUr0meg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=irUMURAgbNOL5BbrcDJjjqtFu8d/EclReYQTyBtEALE=; b=rqUr0megb5+6kquJL9k9MMK/1j
	1Cj+CUBQOzs8WKZMY/uWZCpSQcPnkJ04Ve62Upn4eDEbpatD2ykTPr60R0JgbWsXk2jAorlt75fsx
	nS6ml1tLgTOb+GGFTcpRT07DbiqwYnAFZgVXWE0WXJ4a2fqvh8eS9lkfNWXKNy+EOYkLFLjzuSaVm
	szrdERs8lHGe4ylV5OZQzGhfezyZVvs1XcDhuQkHAVjLJrdeSDceLi8q0e+yxEl7Ll0rhvNkZsOeX
	1ofncsM30WnJ6dRLjzgg7OYrgC/Jkmd4Jz8UA7iWGAAf/mATbvXP0wqdpZFjS2My5e9/30K+BeXF2
	KARCpx1Q==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wq1G6-0000000GWIv-1mo5;
	Sat, 01 Aug 2026 04:23:38 +0000
Date: Sat, 1 Aug 2026 05:23:38 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Ali Ahmet Memis <ali@iusegentoo.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add myself as UFS filesystem maintainer
Message-ID: <am10yuQx5a3h2pXH@casper.infradead.org>
References: <20260801025030.14178-1-ali@iusegentoo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801025030.14178-1-ali@iusegentoo.com>

On Sat, Aug 01, 2026 at 05:50:15AM +0300, Ali Ahmet Memis wrote:
> I am willing to take responsibility for fs/ufs: review incoming patches,
> carry the pending fixes, and keep it building and correct. Add a
> Maintained entry to reflect that.

Convince us you aren't Jia Tan.  You have almost no history with the
Linux kernel (one commit that I can find, and that has a different email
address attached to it).
