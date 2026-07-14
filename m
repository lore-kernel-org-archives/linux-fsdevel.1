Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB9F2EEE9E;
	Tue, 14 Jul 2026 05:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784005864; cv=none; b=Zwz7ZdSRgGeYvOw9mT5NSNS/XXnXDcbCNgaVDSzR7mkLndG1oYimArMiz4Ly2n6nIOXRzUoZV1eRRdC7X/ivwNmZb1J/0WXE9FVA57dd5ucof5m78ogZmqgkF7Y1BtMHAdbeWpmUCv+S485DzCNXrkPSTkXwdmyBv733hczgtvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784005864; c=relaxed/simple;
	bh=62nkcN2GS5tNpXoVLCNwdmTcPvHhkuIEePRmXSq/wLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLKfAdGHRvQiHFpEVj/RqOVKVH4R8h9wnh63m+xw9MWqbLOsaFXpdYRGckKq/yevlAeQcL+fDnwS+EVnnDJtYFfhRjnRbYR0gVNBGtCVCfmywyMqiOcC/mvnSyDeeikADyogKWT0hJEVr0EnyDk4fEqIhWa7HWIkyKXWqvIyhBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BHmBuC8A; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BHmBuC8A"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qUi4Rh0+1IDvQIX84J3kbI2scpn/t9a2/Lj2eQ7V1wY=; b=BHmBuC8Ac52mSDrLcw+7wlM9O+
	cPxSiEf2htJ9HCDfxs3uYwBcQbY00u2bezh8KDMHziY2W16VFwiOtlLvEBD4WgAUgjKb1LmI3VpVk
	9IAmLxzyts2EkcYj8LGOXKPlp0P8ChbSqEZlj7XprJLGH60OjEhBGkFEi0uI6XG2eGXE5FSSjHT13
	yEGaDxKqiW6W09n+aUsBSIa8/x5JGfPBW3RdC2Iis8lHBwqMWXU3jXyCkyXJ1KACq/a2b6+oLu2PX
	IgDPBJfgu7YL2OhS4Tk5zCWi3qWz0iOqMrooZXRX9UMs7P63MhYJpREthZhU4Om5VX+utSQXnDNGN
	+Bgs4IFA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjVPx-0000000AumR-2jql;
	Tue, 14 Jul 2026 05:10:53 +0000
Date: Mon, 13 Jul 2026 22:10:53 -0700
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neil@brown.name>
Cc: Christoph Hellwig <hch@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Jeff Layton <jlayton@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <aleksa@amutable.com>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/14] vfs: add O_CREAT|O_DIRECTORY to open*(2)
Message-ID: <alXE3cOXcJm-uDNs@infradead.org>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
 <20260704164149.3480051-10-jkoolstra@xs4all.nl>
 <akyyqnv9EpY7xVdC@pedro-suse.lan>
 <20260707-vorteil-unhaltbar-apotheke-47bb105161ff@brauner>
 <alS10NN_OduZEqvt@infradead.org>
 <178397852844.3371781.6900199568039042534@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178397852844.3371781.6900199568039042534@noble.neil.brown.name>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jul 14, 2026 at 07:35:28AM +1000, NeilBrown wrote:
> So let's add OPENAT2_NEW_COMBINATION which instructs openat2() to reject
> unrecognised combinations.  Old kernels will simply reject that.
> New kernels can start using previously unsupported combinations safely.

Yes.  Also the name OPENAT2_NEW_COMBINATION feels a bit clunky :)

> Maybe OPENAT2_NEW_COMBINATION could just reject *everything* at first,
> then incrementally allow new combinations as they are defined.

Yes, absolutely.

