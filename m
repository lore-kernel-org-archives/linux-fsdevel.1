Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A1931B830;
	Fri,  6 Mar 2026 20:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772828431; cv=none; b=VAEiFfJnN0H4cXixF81UkonIRDcnxXietQHgoiTHcVcdqWnXpFoXW44ZwCdKNLlX4XT7rhrQx/KCqDj2aBP+vqYJbGT28to34uVWKafGPICh/ipV3PrUQMjWHvEANW/+FtvcqcR8hFDH6OfCOoA2f1f2j4ZXaj9HtK0v4g08qMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772828431; c=relaxed/simple;
	bh=3LCkS4J2B/j8Epj46LKB06BgKFk8bbJVSWE1JSax4z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbtCn9NO9ZiSCnbmClb3jxbqPd99wt8s1ccvQ0xnUDWqjUVOSfLLGtmPovP0mcSG9DqFliPoLKjW2zfpG8TGLJY0ZdqPKWgY+iUZ9cxt2+TjZQJZjwb9tfwz/APNuE3fRs1chDEzhRMuxMvbKGbho0qbK6i4eesxk1R0nD+jFU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=g9fC+KzR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=umbMP8h1; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="g9fC+KzR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="umbMP8h1"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 3ED80EC05A4;
	Fri,  6 Mar 2026 15:20:28 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 06 Mar 2026 15:20:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1772828428; x=
	1772914828; bh=377Iiy/2vhfVMCk/VUi+y/E5TjBXp6Xa6UY+t1Y1TWM=; b=g
	9fC+KzRYeUJ0aQGPuz3NL9oCfZt8u35dONToxyZP6jnrCyaM/8eP54E/2ij2gMEm
	Y+VIOLwaB9eZ6jwMMfZVStoBovK466Y5q0xmBo5ua9Vpjx2t6DfkqTMM8lEQEYDH
	G3H2mAXT4C0b/bB7tkzMiWm0j3Yv3B1CEBsm/Roj5hO15gXuDHwGqIo53JDC1140
	KfuTLbwO5jpQPrY4C1BAcHcGy4ExMrKGpBTKm397OurbtY89GOh4IsBtYlGDrv//
	3UtNiqL49YvWJ/2qhAxiXsEyZeLzNQIYesAjwiLuugFPCMjbpdzjrb8xFJ6aF/js
	mVAzyrmotIv90WfsEUZzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772828428; x=1772914828; bh=377Iiy/2vhfVMCk/VUi+y/E5TjBXp6Xa6UY
	+t1Y1TWM=; b=umbMP8h1nm2bsyUUAIt0U8ykWvIY7Cxn0AOrdbf1l9auM32lcvj
	aEuN6Q8YtO+qO6hui5fFDAsdmGXgvcvxUx/G3tDd8KErCkSDW87HiCxniMVoVm8W
	4MtqlggHHl6z+ivhbmD4JXo2kccHbMwxIrPyK2oM04VyC+9iLqMA2EC65rSx4MKX
	SOEr0j7hRKJIwolGzx8m/FmnoyKgQUagJcJN8PrLR/ylSUbmXOI0cfXJ7pesuec/
	22AltRrxTU1eU0M9QSnODL3acmVsSzHNE1x3Hbo3KGSMrC2vMnFyIRZZdWPqat+Q
	+kLTC3izGtHMYwBYXsC2uSwA+kivFksXNTg==
X-ME-Sender: <xms:DDeraf-SWXyF3tgPQoVLqr4qkOSLuBh6Qo8v7JsO8-Dkeu6kZbuplg>
    <xme:DDeraaPuzvAMMocPp33GVWdZfcyXM9bvJYya49Qrl-1wHSOUicp8klt4nypQDvwQM
    lJvPI5FtXN1lG3eaVjgyqRk0LdgTCFIWc4_IEaZJ4yThZDmagWSn3gy>
X-ME-Received: <xmr:DDeraT0pwkDnJEEMBBM3qiKFNkkH7HiXRp65IlGqOcFFlsIa_Uor4nYiYTkpIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedtvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecugg
    ftrfgrthhtvghrnhepfeetheejudeujeeikeetudelvdevkeefuddtkedvtdehtdetieeu
    ieetjeeugedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopedu
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfihilhhlhiesihhnfhhrrgguvg
    grugdrohhrghdprhgtphhtthhopegtrghrghgvshestghlohhuughflhgrrhgvrdgtohhm
    pdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprh
    gtphhtthhopeifihhllhhirghmrdhkuhgthhgrrhhskhhisehorhgrtghlvgdrtghomhdp
    rhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epkhgvrhhnvghlqdhtvggrmhestghlohhuughflhgrrhgvrdgtohhm
X-ME-Proxy: <xmx:DDerabeoWr8rr5r6z3i8Pri8oYx6fZC1nyfchwWaCrrHoFt6OO5lcA>
    <xmx:DDeracZ94ff_KdNbwGjqh4C9Ui6tdaAwvvnGpxDL3bKzGemt8_bUpA>
    <xmx:DDeraYXvwgRYGKcq4gcrdbHiTol7o-fLV7MQzpaBaDCrT207DAUg5g>
    <xmx:DDeraXR_ei3OMJVubNO1jsLAb59RHO7rT28j0-zBHECUYLPYEeHzpw>
    <xmx:DDeraRZDqOfWDBSHmud6kCPdlDueRwdxK1vc4ZJockTKSmlWT61aiw0y>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Mar 2026 15:20:26 -0500 (EST)
Date: Fri, 6 Mar 2026 20:20:21 +0000
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Matthew Wilcox <willy@infradead.org>
Cc: Chris J Arges <carges@cloudflare.com>, akpm@linux-foundation.org, 
	william.kucharski@oracle.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH RFC 1/1] mm/filemap: handle large folio split race in
 page cache lookups
Message-ID: <aas2lmQtqW2tK2u3@thinkstation>
References: <20260305183438.1062312-1-carges@cloudflare.com>
 <20260305183438.1062312-2-carges@cloudflare.com>
 <aanYdvdJVG6f5WL2@casper.infradead.org>
 <aarVMrFptdXhHsX1@thinkstation>
 <aasAo8qRCV9XSuax@casper.infradead.org>
 <aasddOvIfcMYp3sk@thinkstation>
 <aasfxLYRWzNodAYO@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aasfxLYRWzNodAYO@casper.infradead.org>

On Fri, Mar 06, 2026 at 06:41:08PM +0000, Matthew Wilcox wrote:
> On Fri, Mar 06, 2026 at 06:36:30PM +0000, Kiryl Shutsemau wrote:
> > The proposed change doesn't fix anything, but hides the problem.
> > It would be better to downgrade the VM_BUG_ON_FOLIO() to a warning +
> > retry.
> 
> The trouble is that a retry only happens to work in ... whatever scenario
> this is.  If there's a persistent corruption of the radix tree, a retry
> might be an infinite loop which isn't terribly helpful.

Whether the problem is transient can be useful.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
