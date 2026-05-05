Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0515B37B014
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 20:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778012364; cv=none; b=tnq0ZJ3aQjnyXPZcBW3hy+0d8VKHW2XjeUeMKKbdfIqhi5C/usiFhKdxN7+Buaix4rXgahP4PwzCvHLqdm00mXZblY3UVmQNhkthkiGqbXq1nM2o3rTTuxYI7WtGFIM8uj26Rtm1Z0kghvNt93Q0PlwRvQFqUd1YpBtEyjJmd6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778012364; c=relaxed/simple;
	bh=0msNwt01nHds4VPeV/itHABtyNfweqJ/+WrXeQvZULI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Tqsr6tPZCG4XNSHB7e58cRSa3OEPomZ5SvvFK5Q0FMjXIRaEf3rK1YO6li7VmkuHgtnIf6qM7sYwOrICL2YiKVu6FTPB1ln2Q4jzyRSJLMUkjyc4ebUv/YFlGTSju7F5MOWYpC+ikjtbCA0HqpYp3Tkwbr+o14uBrbd7/91wEiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verbum.org; spf=pass smtp.mailfrom=verbum.org; dkim=pass (2048-bit key) header.d=verbum.org header.i=@verbum.org header.b=W/Vfpmy2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hZisomkw; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verbum.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verbum.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verbum.org header.i=@verbum.org header.b="W/Vfpmy2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hZisomkw"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 34D837A00A9;
	Tue,  5 May 2026 16:19:22 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Tue, 05 May 2026 16:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verbum.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1778012361;
	 x=1778098761; bh=+yJjgHKzHMjJIiX5YgX8EBWvyf9VUs47sabKriH+qrY=; b=
	W/Vfpmy268X2m5OUH0VVUWCh82SSiNfnwyPo/KRlbtNRnfayKKMrBNSqefL0TEjG
	IbcsKzrQrSZlvf2MNOWDiauMzhp6NL/abr95MsKM/n077dQhwgDF18nqysfBZoe8
	K3FrkkkVVZRljYH/4DFc1Tyhr2+ABTqFtMx6Er/6YtruIl/IUSV3i10sC1cw2k9o
	gSktRYhfFBmqfIUrtIVXMphqanjt28V1B6gYlYE2Atwv5E0pLmVrwmN1RuEvY5cp
	wDFiyp5DD/sdbS43eQWpFqFVFn8QqQpEX84V9RwJIhlC94cEphlg23nwKovhsDxb
	VvjaUBefbR95RSkXHgQ5TA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778012361; x=
	1778098761; bh=+yJjgHKzHMjJIiX5YgX8EBWvyf9VUs47sabKriH+qrY=; b=h
	Zisomkw4v/kZHNc1j1kojzpPHypZGWQ8p3sbs+uNFGYKFKIOiDqJlvacv0qWsT/F
	R0LraACn36+AjUybF2ILEi80H33imqavRuDmo37XLK1rlfBCT9RDnOGZQMIus7Gr
	xCiR2ughPlP1m4ZOD22RjdF9ezuQByqs9+cXA97ehEJzjgqvrFTu6SdRiToA6E2+
	4yL3jdhnskXYFp0NEIccAq6e9KTVy6MK/Fvw7uF+rW70eRDrlbqGKooSAazoZ7Ap
	w18Hg/k5oSN1qgxnraYsMQi+D9gRQY1RWo9trFAqBswbx2DrPs2YEfx4DZrPzhum
	vI5B6T24TTCoJmPDskd/w==
X-ME-Sender: <xms:yVD6aRrtFsMT_oIbCrPI7wOYVD-1aLYPMhUeZGj4a5O1BJ8g10o0tw>
    <xme:yVD6aecjT6WPam84fu0Dyb-ezLMDLK-ITYDStBskSAZrTqG5JGzX-BY43Jlnz74P0
    2CBBmuJqsf4idjGiG38oVy9hcdhXhQdaeIQv1jdG0MX_bwpXOiU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutddvieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfveholhhi
    nhcuhggrlhhtvghrshdfuceofigrlhhtvghrshesvhgvrhgsuhhmrdhorhhgqeenucggtf
    frrghtthgvrhhnpefggeetueegteelieeggfdtvdekvdejudejgeevudevueeuhfekjeeh
    feeivdfhkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeifrghl
    thgvrhhssehvvghrsghumhdrohhrghdpnhgspghrtghpthhtohephedpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtohephhgthhesihhnfhhrrgguvggrugdrohhrghdprhgtphht
    thhopegrrghlsggvrhhshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvggsihhggh
    gvrhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehfshhvvghrihhthieslhhishht
    shdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:yVD6aS2rtZSS41T_XGes5vrfsvq2OAWKmYa1Sm29QC8J0HtotAMLnw>
    <xmx:yVD6aeCpnGDBX8w4utqDj9eO0tshZpy6Lj_WUjMXIr44ew23PIrggw>
    <xmx:yVD6aWfcDBQ7pSCFzCjP159NoFx_MFxkud8SSch_f4oom1xqe30J8A>
    <xmx:yVD6aT6j449AksKdvAx6a_WbVsOx4nrxcNtyU3G5tV4nsf3cqoxUuw>
    <xmx:yVD6ad4d2oIkNwEMKuNaiv7shlvtXtf6aeylc-K4EgICsoG6dv4GAvEq>
Feedback-ID: ibe7c40e9:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 94E11780070; Tue,  5 May 2026 16:19:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AMDuz2u8DR1N
Date: Tue, 05 May 2026 16:19:01 -0400
From: "Colin Walters" <walters@verbum.org>
To: "Andrey Albershteyn" <aalbersh@kernel.org>,
 "Eric Biggers" <ebiggers@kernel.org>
Cc: "Christoph Hellwig" <hch@infradead.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 fsverity@lists.linux.dev
Message-Id: <6c8e6d08-e12f-4a97-95ca-ef0dec2a201d@app.fastmail.com>
In-Reply-To: 
 <lna7qosffjeymh553wfgew6txfhzb567xqfki7cvq5n6lfsrgg@tkb6wvmyvie6>
References: <bf0ba588-002b-4860-848e-e806b193840a@app.fastmail.com>
 <20260501180725.GB2260@sol>
 <lna7qosffjeymh553wfgew6txfhzb567xqfki7cvq5n6lfsrgg@tkb6wvmyvie6>
Subject: Re: overlayfs: verity validation broken since f77f281b6118
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, May 5, 2026, at 2:07 PM, Andrey Albershteyn wrote:
> On 2026-05-01 11:07:25, Eric Biggers wrote:
>> [+Cc fsverity@lists.linux.dev]
>> 
>> On Fri, May 01, 2026 at 01:14:54PM -0400, Colin Walters wrote:
>> > Hi Christoph & Eric,
>> > 
>> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f77f281b6118 broke composefs's usage of overlayfs verity=require, this was reported originally in https://github.com/bootc-dev/bootc/issues/2174
>> > 
>> > There's some output from an agent run I had in the <details> there, but here's an xfstests patch that passes on without that commit and fails with it.
>> > 
>> > From 14231122bfd1e41337e4fb847acbbe038457c32a Mon Sep 17 00:00:00 2001
>> > From: Colin Walters <walters@verbum.org>
>> > Date: Fri, 1 May 2026 09:45:58 -0400
>> > Subject: [PATCH] overlay/118: test fsverity lazy load through metacopy overlay
>> > 
>> > Reproduces the regression reported at:
>> > https://github.com/bootc-dev/bootc/issues/2174
>> > 
>> > A recent change in how fsverity state was cached in memory
>> > I think caused inodes not in cache to appear to have
>> > missing verity=require for overlayfs.
>> > 
>> > This test catches that.
>> > 
>> > Generated-by: OpenCode (Claude Sonnet 4.5)
>> > Signed-off-by: Colin Walters <walters@verbum.org>
>> 
>> Sorry about that.  I guess it's because the semantics of
>> fsverity_active() changed to be basically the same as IS_VERITY(), and
>> that broke ovl_ensure_verity_loaded() which does
>> '!fsverity_active(inode) && IS_VERITY(inode)'.  I guess now it should
>> do: IS_VERITY(inode) && fsverity_get_info(inode) == NULL.
>> 
>> - Eric
>> 
>
> I guess this could be also fixed by patch 2 and 3 from my XFS
> fsverity support [1]
>
> 1: 
> https://lore.kernel.org/fsverity/20260428083332.768693-1-aalbersh@kernel.org/T/#t

Yes, definitely similar. My draft went even farther - personally I like not having ovl_ensure_verity_loaded at all. But in the end I don't have a really strong opinion on that, as long as we get the xfstest merged so there's less chance of future regressions I'm happy!
