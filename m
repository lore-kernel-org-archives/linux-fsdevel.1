Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BB534214F;
	Wed, 15 Apr 2026 10:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776247534; cv=none; b=so2IlMcYgCpKODTmE+rw9FUenPDGC5yVwRTyZnK6lUmvgaCjwaboQ/ypBh0UmXDwJIshMi/23EAdvWh2FVSSYdhiKUExGSGUEziW1603me9lUJzkc8DTDlfJYgUjvymheAjUGo8x1PMtRxsm+f60u7wOMmOGcVlJJaONlHP8VOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776247534; c=relaxed/simple;
	bh=JoN4f1wET6TLgvaLbPeLo1rx5aM5y2W9uFFgK0F8Vww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmxPu67pt94kvjX4YDL8UrP3a4Vs2ZAxQnDlVE8ID+QCWCUM/43YjaJbwRYgwIlBoaoTrgQYC4Ccgvzaln/u8CK/VOSVzGh3kpcGhnDXakp9WQ2HX9FJCC+Oddroooq3XKRqseHFzLR5+wp0G7zFFM8f9bc77bQ5XFTFqiQHXi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=rMihxMbp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aeRHL9NH; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="rMihxMbp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aeRHL9NH"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 183E1EC0468;
	Wed, 15 Apr 2026 06:05:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 15 Apr 2026 06:05:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1776247531; x=
	1776333931; bh=Gz/2LXU1K8BhzecoWedpHAL3WhAhwdUS9rpTtpz7gUQ=; b=r
	MihxMbpACz6IajCeWCwHlLQsnD7jNefsYQHWduxFgSQDsSIfL8MCWCvlBEmxZ3wS
	HUUpR1Zqx1z4re8ZqJhd1FLLZ3DQQwVH+7QOiD6uZ/ZIewctG7MY6TMdK2zEf2xu
	k8Lul/1m9Af8k12ooQ/mztCl4elVDlB6XkJtOop/DgK4Eq1llUFBv2xqA62beA3Q
	pEW8TPpR3U8ApJV8aaYmSGMPnujQnRfMO6vOc90fX6RjJBYCXRp8pudgm5kcIoA+
	8EtTtCvzPR+FBcvr/4ERTp4UH40dt8C3sEN+lvFBJanoErAjseHA2S3ZIUi3AlXs
	nS7VUl/CVgiAEdNrVxp9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776247531; x=1776333931; bh=Gz/2LXU1K8BhzecoWedpHAL3WhAhwdUS9rp
	Ttpz7gUQ=; b=aeRHL9NHunEMk9W4/cvLQ3p8XcOinFi9Y8oS8+mRouE7JdXm9Vs
	gxFu1jrXco5aWTms3E9BNfcRqpnSJX39se6DYbNZpIJolcx5Gp/Srgot/sQ2xx/t
	Q5aAMlkkOPG1nyDhhWw3HBRbatZ9sU7P3AZZboUg56WuqilFG/NIDmkn+BBxzj8U
	3IKgAi/hps0/iPop0QKkV6ZGva1175TWtfKCj48p/8R7Y4D+OCSUoDtACKUJPARf
	Jfy7wZQYvAfXpMFurUUrvYPLGx2XA9QH3ZvfRbOPopHIYD0wXDxlcnF2FJG2z2S9
	ya02tB7ObCRK40l6LnQTeBxLM9FpqRYTNGQ==
X-ME-Sender: <xms:6mLfaWAc9YdFjHQAGO7gHUs-GlzlHoZP1eNW87__MmlIBF57csJr0Q>
    <xme:6mLfacajXl-iRko3WiIu998OxraCfgWSXdShsu1fPnkaXkiyK6kR2WDv2KXZbo3bD
    NWc9ai9nXevYUYK6FTM14mLF-FvGxmtp35nxygMhVvZE3IcenFRHNC0>
X-ME-Received: <xmr:6mLfaVGGC1r3F-vWXyk1a1er9lfAlmkejm1In5Q0uQmRF7wylZNW_r19GAClLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegfeejlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvqeenucggtf
    frrghtthgvrhhnpeefteehjeduueejieekteduledvveekfedutdekvddthedtteeiueei
    teejueegtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtohepvddt
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmihhnghihuhdrhhgvsehshhhoph
    gvvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgt
    phhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohephhgrnhhnvghssegtmhhpgigthhhgrdhorhhgpdhrtghpthhtoheptghl
    mhesmhgvthgrrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfihilhhlhiesihhnfhhrrgguvggrugdr
    ohhrghdprhgtphhtthhopegsfhhoshhtvghrsehrvgguhhgrthdrtghomhdprhgtphhtth
    hopegrgigsohgvsehkvghrnhgvlhdrughk
X-ME-Proxy: <xmx:6mLfaYvgsxWcMmu7Mk83CMbexwvnD9rgjgGJN10jNwvGk326lNc6Xg>
    <xmx:6mLfaTI2496G5wsWC-omTnhciKbmRbfnmfmIULHnBX8fiQRcwZu8vQ>
    <xmx:6mLfaeOV4hu3ZyUXPuXlBRoBn3UpLMBOIKZPg-NA6Acp1UgBuCI1Xg>
    <xmx:6mLfaTblMYOaDLEYzjXfg5ndAvYoMJpmU-EApVLpflOtDUquS76rGg>
    <xmx:62LfaYTz-M4YyhDbs3i_K9rNoL1qKzMPN7tEiNE8zwD7h-CXmPsugzRb>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Apr 2026 06:05:28 -0400 (EDT)
Date: Wed, 15 Apr 2026 11:05:21 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Mingyu He <mingyu.he@shopee.com>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, 
	clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org, 
	bfoster@redhat.com, Jens Axboe <axboe@kernel.dk>, littleswimmingwhale@gmail.com
Subject: Re: [ISSUE] Read performance regression when using RWF_DONTCACHE
 form 8026e49 "mm/filemap: add read support for RWF_DONTCACHE"
Message-ID: <ad9g22IbYJatwptY@thinkstation>
References: <CAAoBcuSK38z5Nh7rGuHDFwpNvtc0W49OZKc1_d1QkCbK_nL7Ew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAoBcuSK38z5Nh7rGuHDFwpNvtc0W49OZKc1_d1QkCbK_nL7Ew@mail.gmail.com>

On Wed, Apr 15, 2026 at 03:28:27PM +0800, Mingyu He wrote:
> The smaller the buffer_size in the test program, the more the
> performance dropped. Initially, I used a 4k buffer_size, and the
> performance decreased significantly. When the buffer_size was
> increased to 128K, the read performance with RWF_DONTCACHE actually
> surpassed the non-flagged version by about 10%.

Maybe you have block size larger than 4k? Core-mm will allocate larger
folios for page cache if filesystem asks it to. And if you try to access
it with 4k buffer it gets multiple read-discard cycles for the same
block with RWF_DONTCACHE. Without RWF_DONTCACHE only the first access to
the block will lead to I/O, following accesses are served from page
cache.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
