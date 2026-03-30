Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5887918EFD1
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 06:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774851553; cv=none; b=YMKcLWMVy/IsZ4igg7EgmkOmj9NM8/9BRfrH0dz+jpBiZ5RASMxU3cZ0JTrt1Rceq5mlqGVN5FHh76/m0SOoh+8WTEse9NfzgEyuyw8/7/tZMC1z2HFZ99/xPDnRlu2L9aZFpqlwbTbhkR4VPKPeYF9QqtK1JNzl+CLZ3BKWwj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774851553; c=relaxed/simple;
	bh=7MtTwDUlhRif9KRRFKGAKiwTfEimF03dH91kO+aM9Rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4rZDcyky3/VUluKpJXNVtdbydVHJ/bvz+5LBBKnAGsd9aOJ8qLjImRCvBzMXv5XqHTLCGY8WD5rn4icE0JKpwEFM5VHI/SI5LETNWXjS4P5QV+xaS02NSpjF51Foh+g08fzcc8NPTbSLryCN7AKQt7KZt0lH8cOIiEFdwxtFek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CCwPKs3Z; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CCwPKs3Z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JwBV4jm+but4MAN8kKBiCeb0uqDq040P1TzalkC1hxU=; b=CCwPKs3ZjdOvFmpMzW98Z8QmGZ
	I8zbtMPlMwLntCgZTu8zRaBGmO0NEzRr01HJ358zwMYVE4e0ZdqR+zz4swOnwsebhq73azf7E0IQY
	O8S9pfk28/VzQ+vctwBUxkWsDNno5SzLSevZ+8OxzmNb1Z+tFuSybxVGR2lseBgcqNMpa9GSvmJSd
	rqkviJYBfptSGz7Ga5sNTN5Q6gDDzrJaoS49Yfjt0ij01MwCBXezUKReBw/iIFNrRCZALdswBXkgm
	lD9U1OxbS9om55yLXq8zZkgZ1q9Bs/v7h7fZg08wER6yAUH70HkzuogjPPRuNCuedLknHKrlLHR9d
	A4lTQXHA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w75xu-0000000AfsM-05D5;
	Mon, 30 Mar 2026 06:19:10 +0000
Date: Sun, 29 Mar 2026 23:19:09 -0700
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/4] VFS: use global wait-queue table for
 d_alloc_parallel()
Message-ID: <acoV3YBaJjl0Bh2X@infradead.org>
References: <20260329225603.2177730-1-neilb@ownmail.net>
 <20260329225603.2177730-5-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329225603.2177730-5-neilb@ownmail.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Mar 30, 2026 at 09:46:39AM +1100, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
> 
> d_alloc_parallel() currently requires a wait_queue_head to be passed in.
> This must have a life time which extends until the lookup is completed.

Remvoing that looks like a good API change, but the replacement looks
a bit cumbersome.  Any reason wait_on_var/wake_up_var would not work
here?

