Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98424433E96;
	Thu,  2 Jul 2026 15:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783005241; cv=none; b=j6qeWxVPZpzG71/rhZU2Vgvm6EHdRY5pT7AZY5Y03D4G+17nHlgn/8KWJILNIHjOhvS/aa8j2Zev1lucLTrxcmStvtMlUYwo+Emh/Jf7JWa6WF2eUu8pKHjfA+gazZSG1uE6mwSgvNY9C5lX5D4N4iruhkG6dLn96h8MJvejXJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783005241; c=relaxed/simple;
	bh=m9VdSAGE8YlG1vSVDOcgWFAmcxHMR/RARHprWSlePBs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aA5Q2yT6Yf1lz/onObZlK2F33RbifL33E25riaRl/gnbsurTNn3eVCIxLHnaiXGV3/k3VoY7xkcsEJTIxRn3oj55jvMaDsZJgO2b9c61rFZTJ5LTuR437HuOL7PvdbSAl4UbKQ1H2IfoMoELPY4Lf6Kv1QCXOhfo7vEfzw6DdJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=kgHV1JUh; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="kgHV1JUh"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9625640B33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1783005232; bh=2w2xx6IwQQFudxTTwYKb2duzOeyJBNSTwAs9yFTcV70=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kgHV1JUhskM5+qrbhezXW2MZecyp3nYDagQp+lc0u3OWKQICMin9JqMFTbmglLzWt
	 EgQ992zTTMh2pRNLfbSFCHfr0PAGyPRvsmA05c5qxo/hbg8Ui9f02CAe69T70gE54J
	 5K2Bm4mv+pC0CYl3WjLWRfK9JG/T3SvtDrYBzc6dQLmDqltMnFtqfKaNR7PLKdeXzg
	 +I5lhOXIA3RT6XQw/Z7pk+WoXJc7e7KlqS2I3U42yvlgGApzH/nqIJYbKlewVShLon
	 Fl49I/oYrFgjTY6D8OBXRu8f0qE65bOdFlHs22JdOarGyQ6XZ2Sy9WXTMRdMR/K7+i
	 UAh0u46r8mGFg==
Received: from localhost (unknown [IPv6:2601:280:4600:27b::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 9625640B33;
	Thu,  2 Jul 2026 15:13:52 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Greg KH <gregkh@linuxfoundation.org>, Jeff Layton <jlayton@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Justin Stitt
 <justinstitt@google.com>, Lorenzo Stoakes <ljs@kernel.org>, Laurent
 Pinchart <laurent.pinchart@ideasonboard.com>, Carlos Maiolino
 <cem@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Jori Koolstra
 <jkoolstra@xs4all.nl>, Krzysztof Kozlowski <krzk@kernel.org>, Brian Foster
 <bfoster@redhat.com>, Christoph Hellwig <hch@infradead.org>, David
 Disseldorp <ddiss@suse.de>, Mark Brown <broonie@kernel.org>, Jani Nikula
 <jani.nikula@intel.com>, Jens Axboe <axboe@kernel.dk>, David Hildenbrand
 <david@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, "Christian
 Brauner (Amutable)" <brauner@kernel.org>, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Documentation: remove the requirement for LLM attribution
In-Reply-To: <2026070224-unholy-commode-cf45@gregkh>
References: <20260702-aidoc-v1-1-735572dfb995@kernel.org>
 <2026070224-unholy-commode-cf45@gregkh>
Date: Thu, 02 Jul 2026 09:13:51 -0600
Message-ID: <87cxx5l900.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Greg KH <gregkh@linuxfoundation.org> writes:

> On Thu, Jul 02, 2026 at 10:32:48AM -0400, Jeff Layton wrote:
>> We've had this requirement in place in the Documentation for several
>> months, but it's becoming clear that the signal to noise ratio from this
>> is quite low.
>> 
>> 1/ It's not universally followed. While many people do try to attribute
>> the LLMs in good faith, not everyone does for various reasons.
>
> Then let's move to get people to follow it.

FWIW, in my experience, simple ignorance of the rules is one of the
biggest reasons why so many people fail to follow them.  When I've asked
docs contributors about the source of their work, they tend to come
clean, apologize, and add the tags going forward.

jon
