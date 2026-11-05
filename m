Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793885637;
	b=Y2wwyOMBYUsvUtBj4Cat1Vwo9DQLNsPOdPOK8h7mn40IezajI8A3tCSNBfCg5ThRMMyI
	 BJbubcYDaCXjkDlCD/73hRXdcjYTuQmQbWpdoZjdXsn3/iWclV3pvdcT3dlKWtXjmHqG3
	 njqnZBRuHl0eHsl3NQpytCnlRXh6OAyKg1rn165TnIuYrgGN7EUQGMc/qQVlQ/lGOGSlt
	 4d0ae60O8tCQPxHCGS1NMV6CffNz9X0iBbeaks6KPYdvWpuUf8tF9p2VRg6Zz17eLIUU1
	 OALzvekQHYzq55b+zaQbOTb5HhC3KBYwZzdFP1KwcKOkOB1jmxV0vPswpVjflpZCGkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793885637;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=Mzxnox2ZqcSOtlYhZiL4hy8PJ7Qt6MthNjRC53Mvu8I=;
	b=tpL1/gAkP0JM03Bh8XgWbX5Hg+5UY566DI3NX1ea8JT0hmCOG7Px0bje0QFu+kG+DtvH
	 45ElEEuGm3FiX0AtH5h0AxzTSta5W4Hmqq79nbXkud54uYnqicqhVyjfh48pXIQGjUE5w
	 /XXCZkP3b5XSmnLQshUsG/w1KLVo+NmM4JILZgrxY9PLvEA0/B0W7AZWc9hXY7S05SfXv
	 W1uSpnHw0cH6/mWx5d9XLsLF7nb9M0vya9AJaSZ/zjEkDHRFhE1wkXb94rJj3bvPhD8sx
	 435CwZ8d6uPl5yX1aitVIz0Io4ojCr0a4GWZgb7X1ryle+BtY0HAFHvmNdpL0hoRsPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W6fvU5e4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1480606A32D
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 13:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W6fvU5e4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E967E1F00919;
	Thu,  5 Nov 2026 13:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793885636;
	bh=Mzxnox2ZqcSOtlYhZiL4hy8PJ7Qt6MthNjRC53Mvu8I=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=W6fvU5e4v9VXByYxToyGfUblVQFNT5WuWLgquynT0RDF8kyI1X8tPIXHjCOMM8QKi
	 TB36uNlZnJvDpPmcr84r9evk4qeRURYKcquEJnZZTgrSafak9JljZ5qKQIoUGre7wN
	 F/hompvGtt9N53QUQGuqUv3dCi/2jGp8a9h+gUNk4aOMpyJxRVDUCGbPpIyxbjzxoe
	 mGVOhUP2BwdYxoZAZZlzs580AfwUJfcnN+1PAB4j3WtHbGtwbZOmtMpZbD+YudzfO/
	 uGqllzTSWK8GJe2MHIDMiNnX++9xx8AFZSwOcw/6rq4jgxoM3pI0yhV1EQZ9Y9qyNb
	 1hHFGhuEaqxKA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id D3B3AF4006A;
	Thu,  5 Nov 2026 08:33:54 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 05 Nov 2026 08:33:54 -0500
X-ME-Sender: <xms:woXsammtkXhLPWsH42dXHpryBkz2i7c0bnU2Lcbos2kHCzmRAoeEug>
    <xme:woXsaor_Lf6RBoLVpMG21bH7KQd6BCfSMtpIgKxnDqWGFSMh2mOC5kj2tLxnE5dqW
    H3b_SOiT14cMJSc3cQ95dDArJw6ObEb1IjwO_cBMZrtSQozzrKMBpE>
X-ME-Proxy-Cause: dmFkZTFXNwLxjr3E6RMaivkkQUj61yNTw+BeXqt/FKvD1Sb1j4JPfn+xjgqZl+4+DRKQRe
    3mlUJxce3RaawYdhvit1fIjwgkMuyA1cwwiYj5q0wQM+s3WToqXmiY5vNpMll/QHUocAOC
    dD4HRRG16qL0UNSXwrZRMXRfVo32pPW0neF4XEVJL2OEBtaBwT3L75kDhKsls5Z/VanAkw
    tZfBpQqh0VZ+mNEhUO2zST/Zp/Gj1vmtZKNtHKLQ1Nm0saygMTnCj/dWL0sGne7hCFXKnO
    RbDgZkxQWMDPb4W7D/wEccbEOZ+G8dxVSGwFtLcVup9a9kQxnr5bjO0atIXGEGb7WQE/pC
    kSq+aSjtpNpnd+Qi4U4YmxyBC9sA/6SbSr/MsKzB7wW1UL74y2Ss5C3UyujLzPMP8WG/yq
    r5zXMy0L6GNlxaT0A85WUiDRf4rpKD81/qtDDqVYALIKaaRRfGq17B1px/08Xr6oj9zLVA
    vgIh9uz2Xw3lCh5P+gDmOG0ZbNFnx52PHaFyFhM33DCW8wyuD9EQeMPye2sVW+8/UJ9yh1
    5M7+/BZ5JKAIhsDBrkPvJcgQsNxLgC/zaMMs8WdeGQBY2LZh4bGUPeXGZf9EBxdXaZNpAG
    PhH37UyZ3FWsKQSYeD1Os+dAe0Pf99Zu+CkAskN4X9vT4qniejRYN2FT2gNA
X-ME-Proxy: <xmx:woXsamf3tSjXzZQ4haIv784kpFLWCTAM9kXovrsnrA4MMfNwdf8DlA>
    <xmx:woXsavwf09Tzn6BzjM5c27OkVXfDz7aCUlZGKI2CXjDH3tq4VxIrkg>
    <xmx:woXsar2ZbDMM6LSy8mEm32b3EAu9iB1LuRtbEms2pPVQh1dO9ekZwg>
    <xmx:woXsamfDeVghD6zLhqEou3KbzqeijRKw2q0-uup0Ncf5qUs84TZLog>
    <xmx:woXsagVOFsksHKpQ0-srOIDYQGqnZ3mSF3W7Gs_3Uul5koTzNWOjUTcY>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B0DA8782738; Thu,  5 Nov 2026 08:33:54 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: A-1cIfNAHW1c
Date: Thu, 05 Nov 2026 08:33:34 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Christoph Hellwig" <hch@lst.de>, "Mike Snitzer" <snitzer@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, "Jeff Layton" <jlayton@kernel.org>,
 linux-nfs@vger.kernel.org, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Jens Axboe" <axboe@kernel.dk>,
 "Jonathan Corbet" <corbet@lwn.net>,
 "Jonathan Flynn" <jonathan.flynn@hammerspace.com>
Message-Id: <29851456-2e7c-48a7-bf00-11a1f1a35024@app.fastmail.com>
In-Reply-To: <20261105075935.GA18069@lst.de>
References: <20261103211754.35352-1-snitzer@kernel.org>
 <20261103211754.35352-8-snitzer@kernel.org> <20261104091543.GA31130@lst.de>
 <autk-osSQ8l2LKz1@kernel.org> <20261105075935.GA18069@lst.de>
Subject: Re: [PATCH v10 7/7] NFSD: drop a shared boundary page only once both WRITEs
 have written it
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Thu, Nov 5, 2026, at 2:59 AM, Christoph Hellwig wrote:
> On Wed, Nov 04, 2026 at 12:01:46PM -0500, Mike Snitzer wrote:
>> It is the transfer size of IO500's ior-hard: every rank writes
>> 47008-byte records, interleaved with the other ranks, into one shared
>> file, with O_DIRECT.  It is meant as a hard case, and it is the
>> workload that showed the problem on our servers.  The same happens
>> with any record size that is not a multiple of the page size.  The
>> cover letter also has 6000-byte records.
>
> So based on a bit googling your totally optimize this for an intentionally
> stupid benchmarking workload.  And that's not been disclosed anywhere.
>
> I guess everyone else was right and just ignored this bordline malicious
> submission.

It's not fair to ascribe that kind of intent. I think it's fairly
well known that Mike and Jon are using IO500, and not mentioning it
in the documentation for this series was a simple oversight.

But IMO we do need a broader variety of benchmark results to
understand the impact of these changes. IO500 on big hardware is
an uncommon workload for NFSD.


-- 
Chuck Lever (Come to NFS bake-a-thon! https://nfsv4bat.org)
