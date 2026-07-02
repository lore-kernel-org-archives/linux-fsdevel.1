Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6686213D8B1;
	Thu,  2 Jul 2026 16:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783008704; cv=none; b=qoKYWxSFNPhUxuhxBuOq44u6EmgAKyums9EVlZl8swM71jcPLf/rVC87RBNW6k7glUNIG/OropOlb+QhUpT2Ga8JzM/j3Iu50ty1nxjpItngE+VTtwbxitMwVN/dIl35E3kdnS0dyiDKgDS+L/fZhy6Y+EBYmjiwmGco16fRzuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783008704; c=relaxed/simple;
	bh=Zx7yBkfj4iflclgczmtvb9yPMEoE2DNajCV0FBtCA7M=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=btrcwnYxNl4c/YTfmF/Lp/SJ09MYZ6466+kF9//YNlU4Dp3/5/0ocaKgWIB6TuGC5qUw8xvULzB6rXRIC4vUIqkPMoF6eohKlhBt+5A93ksTzAvhOXrRq5G763u4jHcBAG8FB5JEf713GjH3aclvE6WH4rcU42VH/7SUth1ukdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tm0HAosR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tm0HAosR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0D71F00A3D;
	Thu,  2 Jul 2026 16:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783008703;
	bh=7jJesRTSN4UY/pF5nooQk5ux4I3JeN+OKBLAPg7OGF4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=Tm0HAosREWXSCjAP82UamtrVEGIUUJpYAUX219v4RBjWJ7JOiVzEdzG347SsPB+hS
	 ANXrZQPFfC58bMUU74c9NznetmTbz2AtfnqbuYpSR0wDroXPuLVzMC7bxyQRf7DJiY
	 k4s0vWIidHSpJp7LA6MAsZ+ccNLwSAredX2YIa4Z0M3pDK27QSENKRV1TZzHeihEy/
	 MtBfyN330GuuZUHLE9K9uan+WdVcjnPr7uC7LSvAtTyVitZ3AUrk7M6ILd38ExONNi
	 SZPx7o8dC/6c+i5eT/yBYuKVOAixX+ddpZnD1XKKQ/qClNmjAFTlAqjzt+ApjsZQC2
	 OycP/FgAztbSQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 4D871F40069;
	Thu,  2 Jul 2026 12:11:41 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 02 Jul 2026 12:11:41 -0400
X-ME-Sender: <xms:vY1GakHamotLwY3SXVrVKJWP7754PTluzTeQ_2Z7EUe4kwbV1V92bQ>
    <xme:vY1GaoIngP4EjbcIo9AHQ0fMtytjj5hhfKYpNQG6OWXsVQTC5B8MVtPHl0EeDSzXC
    d9rurowuJ43rHmZ8l2rLfW--oR0lIq-F0EQD_LpcdC5I4JrzDZ-uCA>
X-ME-Proxy-Cause: dmFkZTEhsvyoby4nY2r92IelFirjHkTPIxOTKuouLw81XqL2Hzmr1wi3ruMiyJPv4uYqsh
    9aMZGLtMJHxu5zy4kTYDgOhZRWbRxN1X5XCQvyCbPgepuwlO7IRGP908JWcfFc9WIpHSiP
    gKnsk77hY1jKrqJks205SUNM6E0vRXWwyrTdh2rWgJ4m2Wuh931nOXc2qmUR3aSAJyMB+m
    QZYWcTIL0p+tLo0ud0Ml/cADh8NfOequ8BogirAatbCGdky0UZvD+lBaJo8rui74oHG+cK
    +MDmb/CkheSICIWyOgQM3huDvwjbbBBs0ncvaeobm+nA2Y9OnxUKIS0NQQNMmJe38tpyis
    G56soxDZd0yZx7La8WQ9LHTtrsZzhanGuhMA63pm2uOS8RwBIq01cveQ3wIAeeVsGrCPCl
    VHShLlFYdQG5EOR0sZNdwYBUflXhavPDdqnM/sp8Lj/RCsotF8OOCST/U9PZLOlpfybk8e
    30AqwwIHXxouQVvwXtFrwjV7NKJaDS5v0WPVhbBzR8yTVD+1mnB05vWHYHnGsNcaYFuiYC
    pi5+UMoKgsLQuYbSHtAylmhGpF+bQPtjWp8a1qOWYAIsIxGod84Zf/5OjwKK0pbeG2L+p6
    cXEdCUbOoVvSJUg8mJFTpv8yuqs93cHWKuF4lNq9pPmP7E2/LTgYMzu5SfeQ
X-ME-Proxy: <xmx:vY1GanFnsP2URmPG2l_ySVh0dLqynXre8D_dzfv6OLrek6Z2UuWbVQ>
    <xmx:vY1GapOEiN3dX46h2ONiWO_s-pIEfJCg0ZF7SX-bF2pEgF-AbRFFSw>
    <xmx:vY1GamuV7AO2OI3T6JR4AQy0dT1yhDfsTHPTLL4Emf7wdr51y-NcdA>
    <xmx:vY1GanKQQM9KCS9V_Ka9GwjnE4xzYSApL4LBQtWPcTCRt4ldyJzkxg>
    <xmx:vY1GasdFpOG_dR20EYFDDV2T87Sov9WRvfzYVNnHvnFC5YS9kME68JpP>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 21438780AB5; Thu,  2 Jul 2026 12:11:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AUMuDe2ntHRJ
Date: Thu, 02 Jul 2026 12:11:20 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Jonathan Corbet" <corbet@lwn.net>, "Justin Stitt" <justinstitt@google.com>
Cc: "Lorenzo Stoakes" <ljs@kernel.org>,
 "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>,
 "Carlos Maiolino" <cem@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>,
 "Jori Koolstra" <jkoolstra@xs4all.nl>,
 "Krzysztof Kozlowski" <krzk@kernel.org>, "Brian Foster" <bfoster@redhat.com>,
 "Christoph Hellwig" <hch@infradead.org>, "David Disseldorp" <ddiss@suse.de>,
 "Mark Brown" <broonie@kernel.org>, "Jani Nikula" <jani.nikula@intel.com>,
 "Jens Axboe" <axboe@kernel.dk>, "David Hildenbrand" <david@kernel.org>,
 "Vlastimil Babka" <vbabka@kernel.org>,
 "Christian Brauner" <brauner@kernel.org>, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Message-Id: <98e8d828-bcbd-4075-9b4c-dc1949647784@app.fastmail.com>
In-Reply-To: <20260702-aidoc-v1-1-735572dfb995@kernel.org>
References: <20260702-aidoc-v1-1-735572dfb995@kernel.org>
Subject: Re: [PATCH] Documentation: remove the requirement for LLM attribution
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Thu, Jul 2, 2026, at 10:32 AM, Jeff Layton wrote:
> We've had this requirement in place in the Documentation for several
> months, but it's becoming clear that the signal to noise ratio from this
> is quite low.
>
> 1/ It's not universally followed. While many people do try to attribute
> the LLMs in good faith, not everyone does for various reasons.
>
> 2/ It basically serves as free advertising for proprietary LLM companies.
>
> 3/ It's not clear why we want to collect this info in the first place.
>
> Given that the data this provides is flawed at best and is being
> collected for a purpose that isn't clear, let's just kill the
> requirement for these tags from the kernel at large.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Christian had proposed watering down the LLM attribution, but I think
> it's not productive to try and track this until we have a clearer sense
> of what we want to do with this information and how to make it more
> reliable.

I agree that the current tagging system is flawed and almost useless
for real analysis -- self-reporting and a nebulous definition of what
"LLM was used" actually means are red flags for any data scientist.

I don't have a stand on whether the tagging should be removed or fixed.
But today I ignore it (my 2-cents US) for these reasons.

-- 
Chuck Lever
