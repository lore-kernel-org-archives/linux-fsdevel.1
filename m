Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9C43DD857;
	Tue,  7 Jul 2026 10:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783419624; cv=none; b=fXnhrxKYp7nVgdZ+/G/U37LxCRKyWDpWZv8z3zPC9LJE7hOR+fR4kQXz2Q2hskvf7d1KmPufbYvREqhEvUlbvjzBSNUGOmV6eTkO1wjCzLJIn4avtjiVszZ2QY+YjddKeu23EjFY30RJREJG1DgQyvKgkqBwLlSbvL/Cm+eJMFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783419624; c=relaxed/simple;
	bh=Saj76Lq9BEvEFw8B7zH2j9ldyhjzqJM6VhTK7aEmel8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5B6WY4PQhXMHpLyS0EKvOOLU8DVl56uus1isOx0nfm9Ba1CfziVA7PNOdqnbKNuvd7I1lMcuIEJUSFAZLH6alAt12zkMa7iHbtHYEitYwtQPX8CFpn8X968Wbve/Lnc/Wx3Poc2n7saWmfKoner/Ck+A/9Kcn6v92zpaSBuytQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lL3ZLL5Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lL3ZLL5Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3941F000E9;
	Tue,  7 Jul 2026 10:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783419622;
	bh=zFHdqMXUD4SifWHe4Jfr5ztqAyuGMXTfuQjJsFdb/OY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lL3ZLL5Z5OQvQbkEcbNVoPRVf3P5h5jCaReGEPBQj+/jrb7a21WPSOyf9zclCmCNs
	 sVOoZdxJomPR57xbNB4bnlwZXN2wIESuAH9rxblIHR2iOwzwe06htZpU3BftgzEIfY
	 wa7kgbORZ5rhHe4NSVns5TVheR/iIoCsMwsSdDK0i7yxniRb/CU6cyV1kgFGO8KMYE
	 EmtCLoe5g1v3qojA+K1ZnVGNRdJ5I7t9PWkaukoo1SZQoocWzUAWBKYNVUvH76N9l+
	 1HcXmK2B0WzR5nIyepAZ3Cw2DXHG+qwO4PdJkcXSyF3p/H8/brCjKtkwWR0+71IDcE
	 mGnv5NpK3CxXQ==
Date: Tue, 7 Jul 2026 11:20:09 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Boris Burkov <boris@bur.io>, Jeff Layton <jlayton@kernel.org>, 
	Greg KH <gregkh@linuxfoundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Justin Stitt <justinstitt@google.com>, 
	Carlos Maiolino <cem@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Brian Foster <bfoster@redhat.com>, 
	Christoph Hellwig <hch@infradead.org>, David Disseldorp <ddiss@suse.de>, 
	Mark Brown <broonie@kernel.org>, Jani Nikula <jani.nikula@intel.com>, 
	Jens Axboe <axboe@kernel.dk>, Vlastimil Babka <vbabka@kernel.org>, 
	"Christian Brauner (Amutable)" <brauner@kernel.org>, workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Documentation: remove the requirement for LLM attribution
Message-ID: <akzSY47Rjn7TDOL6@lucifer>
References: <2026070227-payroll-eradicate-8f66@gregkh>
 <16c507cea8f2873766e1de586d9a0d73234a3038.camel@kernel.org>
 <akaWnQ5Pkg_676B-@lucifer>
 <20260702211740.GA639365@zen.localdomain>
 <3f447113-4407-471f-878f-e6d6edafee71@kernel.org>
 <akez23ZhLRSGMFQ1@lucifer>
 <20260703163251.GB3734786@killaraus.ideasonboard.com>
 <e93d28e4-750c-4a4f-8bfd-7a0b404cd05c@kernel.org>
 <akzETpsps4TMfqpC@lucifer>
 <1778033301.182575.1783419343917@kpc.webmail.kpnmail.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1778033301.182575.1783419343917@kpc.webmail.kpnmail.nl>

On Tue, Jul 07, 2026 at 12:15:43PM +0200, Jori Koolstra wrote:
>
> I haven't really seen anyone opposed the following I wrote earlier:
>
> - it's more relevant to know how an LLM was used than that it was used (and the
>   tag is just a quick indication of this)
> - advertising for particular corporations does not really serve any purpose to
>   the community, so just say "LLM"
> - the tags may be used to prevent arguing
> - the requirement to be open about LLM use (whether by tags or whatever) makes
>   it easier for maintainers (if they feel the need) to de-prioritize patches
>   by someone unwilling to abide by these rules whenever the maintainer perceives
>   or suspects prior undeclared LLM use. This prevents an asymmetrical situation
>   of LLM slop being produced much faster that what can be reviewed.

Yup completely agree.

I just want to get something merged rather than just talk :) and so to avoid any
_possible_ argument 'keep it like it is but add a comment' is a much, much
easier sell to everybody.

Then we can follow up with anything else one we get _something useful merged_ :)

>
> Perhaps the last point is more controversial.

Not in my opinion. We're only at the beginning of this horror show and I think
far stronger measures will eventually be needed (e.g. newcomes will have to
build trust first, which sucks, but it may be the only practical solution).

>
> I would really like to adept the systemd policy text.[1] If I have time later today
> I'll try to write something up... although maybe it is too ambitious :)
>
> [1]: https://lore.kernel.org/linux-fsdevel/20260702-bahnen-ertappen-verspannungen-0eaaf1e3f5af@brauner/

:)

Cheers, Lorenzo
