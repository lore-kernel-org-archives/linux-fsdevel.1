Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E724642A9D;
	Thu, 18 Jun 2026 21:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781817576; cv=none; b=DlE7LH1G48pp8kELTTP7dJzHooDS8LI+/2duiiyMuvE/kcaCpo4+Fr5+S3HMW//z+6D3MlyS+0mE4lpmsiYVXEnO+SFTA97ajIMvIpIdAPQZgZI+cNhoFTaA8h7GMy7takbEiAsvLaPZ2pVIKkhJJop7byTa1WLGKlST8yVa9OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781817576; c=relaxed/simple;
	bh=AEC8EtRQTpXafenk0bh6hFH5DsDYw3TBXZYhvurjdr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWV0QXW4TngV4HAQzli1axuFMuxXhgA7KiD0KTvPk/2nK1x8zAEl23lCgNczgsj5/hYWqam0XQSj1DoqOBTtC2e9gSIGjS1A+joms9X//XRi1anzy1VecdKOKULimKVA66c3MRgZlrkq3IdQgG7q7eJsW948xHjYqSuv00gD+mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Z87EDrS7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z87EDrS7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dpdFeM57wWPvFK0V4ghASe99rdmZvYSdNbqYdfGXhHs=; b=Z87EDrS7QkE9bnev/fO16Er4ld
	GDG6BiSYvOUJm1D4LjTLzh7iMLZRZYR3QbcgU64JMtb7WCCHbrRXJI69/G/+zR3keVlHJyF/sh6O6
	no4IvpqKIscssvf/Q65Kxa+DuwCrNsiR6kMQIu81+mJKbTka4tKbnA5+77GPLtjMC+YhFfk6NILbW
	50zMKX9ZNhOGz4/7nJw7ZsNukatYo/EZqmcWK6Nj+HgPJiesaSiJVOlnovF1K2TWmYLSP9XcntPR7
	A94HeA5ZXV9Lf98gXPXhtJY55pjaqNuk2PeW+ObwTdppUJLaob0s31xA1WplUFbAuDemi8KTdviSr
	nykykjMQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waK94-0000000F6LG-1NOy;
	Thu, 18 Jun 2026 21:19:30 +0000
Date: Thu, 18 Jun 2026 22:19:30 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Keshav Verma <iganschel@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] efs: fix direct extent lookup for indirect extents
Message-ID: <ajRg4gkZswI5ox5l@casper.infradead.org>
References: <20260618193005.3162-1-iganschel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618193005.3162-1-iganschel@gmail.com>

On Fri, Jun 19, 2026 at 01:00:05AM +0530, Keshav Verma wrote:
> The loop that finds the direct extent containing an indirect extent used
> cur < ibase as its condition. Since ibase starts at zero, the loop never
> advances for normal non-negative cur values, so only the first direct
> extent is considered.
> 
> Iterate over the direct extents and stop when cur falls within the range
> covered by the current direct extent.

Nah.

https://lore.kernel.org/linux-fsdevel/20260618211822.3599089-1-willy@infradead.org/
