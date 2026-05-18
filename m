Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9546A3EF0B3;
	Mon, 18 May 2026 11:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779102897; cv=none; b=QU5EwacFsI8LhsSKvQLQisVhbirjlhmAxUgTY/JP3nfRrvlQ779SY/BQYI+uwoqPSr5Amtgkq4eD3D/K+hThXybvAsLgefmM73m/O8d2mOE+LFgbukeVg8iUM6vsphm3Qq/uB8cVe1qT6N09YcxBheUznNFW1fLlBF0wHh20D4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779102897; c=relaxed/simple;
	bh=j0u3whe4mpE01o1xzXOgmnTDWRPRqQSlBrj1WRufm1w=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=hw7awJFSlgE9CspW723/DqJcSsl27UMZgfD2BUOxs2hPV2FhFNUZQ/o63nTQRZWUcXzTYyNa4xKT2ptvatiH/TIcwqq3EcqafRnrB8wLxNnKW303bwGh1sW3K76MpoRFHJxwPLRgfJm0IUh+gDRsSY19ZwBauU5aR4VCiAvmHGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Zl3U/YGl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kpil097/; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Zl3U/YGl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kpil097/"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 010D4140008E;
	Mon, 18 May 2026 07:14:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 18 May 2026 07:14:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1779102881; x=1779189281; bh=yh2KZLHhhNOiMGJIQrEnNmFHilZBFq4++O1
	BzN78bl0=; b=Zl3U/YGlhYm71Jk/hZEw+frD4tZ4ZIxxc2kzUfzbD2zc9ZEWknM
	v5P6L8Hq/bGziNtkKs0g0YAAZw7JY+nrmvb2Zf40d16yiIJCkRlFvI8OKOTrTU6X
	dgoG6DSNHlx0ubEH8Ags8B/jDcFFEbhBRsBiwuncdW8ZDMHnkWFU8M/ZvfLBoF1Q
	1ST26lL09yZCood/sl2huYUd1n4FKhFw7GSt/RR3CismXsaYG3EJF2QIX7zEMvnY
	Eh321GH3iI2bHTaTvMzGNDGJAwucu65EiGTdu8QwSM0C0HG+dJ/39hCT7APR/R9G
	vr2sk07eXvpcpMuNhCyxt9W8c2gp8Fgitbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779102881; x=
	1779189281; bh=yh2KZLHhhNOiMGJIQrEnNmFHilZBFq4++O1BzN78bl0=; b=k
	pil097/RDZGv1r9qI22+BIr0iq7oKJN8Y00cK7aICVF/Oj4rPrX/EupyXkBWUacr
	cn4Uen1mzY2PGp5AYLfNV6Hu+LiUouQMF10xrS+1i9/OZDTqRbUCKYygVDaiRXXk
	n89555lrSTprH/XRaGbWPWQRjOO9u1dAlwbR68QbNvc1uKF6Yv9wrx5Dn6fgsrYf
	7WLICBwIMxQkoC2piJsMRLyxLqKGBbiMy6xjiLirGx4c+mSBgtNOE9W/pwwv5i+2
	qo5Fa9DAUkoQBtxYnv9Ww4KbqwTMETPY8SpWKhQxisXovunrJr8VQ01hO1VaniNw
	GT/WG0lXXcw41zvWWaS0A==
X-ME-Sender: <xms:ofQKapNnlSq8zyM_13O5lKO3u1Dvrv263_4O7R_hR85omY2ZV4aTPg>
    <xme:ofQKajuv-TrOHQTJVAyMMPhhLGtMxZtlDzF7d0Z6N2TAOIHa7RjhUZCNHQLbCRadP
    XAHxxBOrVqrQOaVFccWDqUS1rQcmtTSwk04-obcrXA4eAS_tA>
X-ME-Received: <xmr:ofQKarUZhI6MJ2S5tTB71fZWn_tBm4w3yrNfJpdpfQIiKzve4AcOG5z3_L1IFoe7rBqEDFDMIWEyIS70Non-wBZr_j7HkwI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeekjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epudetfefhudevhedvfeeufedvffekveekgfdtfefggfekheejgefhteeihffggfelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehjohhshhhuughsohhnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:ofQKajsRxRAk3yu-0awhQ-qRrZD0kCL1mxpt1SFjJm6spubP6ylcTQ>
    <xmx:ofQKavVhmqtAqHaSfTtXzv4nEr7MgoOjizPJi7aKiDBLyE8UUY0BIg>
    <xmx:ofQKaumTyOtXmG9M77kWaJuEPi0g6ZS8fxSZgOo2Qkf-yWciGc-sNA>
    <xmx:ofQKagZeAHCZfPn68UWjT7u_4nKxHNvj2WKN_BG3BQb_S2EvwD9nNg>
    <xmx:ofQKaisMSs5FnrYTaCN3eiHNivMoNDA45e7RWrbNbdUOOaWEPhHdv0Sk>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 07:14:40 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Joshua Hudson" <joshudson@gmail.com>
Cc:
 "linux-kernel" <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject:
 Re: renameat2() RENAME_NOREPLACE errors trying to change case of filename
In-reply-to:
 <CA+jjjYR-J19O--HNLOtQPf+f=4_05Q8tunTrrAWAbXtpMnuREg@mail.gmail.com>
References:
 <CA+jjjYR-J19O--HNLOtQPf+f=4_05Q8tunTrrAWAbXtpMnuREg@mail.gmail.com>
Date: Mon, 18 May 2026 21:14:37 +1000
Message-id: <177910287701.3947082.1208072952351817555@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 14 May 2026, Joshua Hudson wrote:
> Consider a file on a FAT filesystem (USB stick, EFI partition, etc.)
> 
> If it becomes desirable or necessary to change the case of the file,
> the old way of calling rename() works, however calling renameat2(-1,
> "NAME", -1, "name", RENAME_NOREPLACE); fails with EEXIST. I have
> traced this within the kernel, the noreplace check is very simplistic.
> 
> Logically the bug is as follows:
> 1. Get source dnode
> 2. Get directory of destination (and lock)
> 3. Check if destination exists
> 4. If it does, return -EEXIST
> 
> A fix would look like this:
> 1. Get source dnode
> 2. Get directory of destination (and lock)
> 3. Check if destination exists and not the same dnode as #1
> 4. If it does, return -EEXIST
> 
> I deliberately wrote dnode and not inode; we don't want to clobber a
> different link to the same file.
> 
> I encountered this the first time in running a battery of unit tests
> for library code, and basically said "who cares"; even I really didn't
> at the time, just documented faulting kernel call and moved on.
> 
> I encountered this a second time when correcting something on my EFI
> partition and got slightly annoyed.
> 
> Related: Last I checked, mv -i has a TOCCOU bug in how it avoids
> clobbering existing files without prompting. Someday they may fix this
> bug (which would be done by calling renameat2(); when they do,
> observing this on FAT filesystems becomes trivial.
> 
> This came up again trying to write some other documentation and I
> thought time to report this.
> 
> 

Thanks for the report.
I agree that using rename to adjust the case on a case-insensitive
filesystem does not "replace" the file, so in that sense
"RENAME_NOREPLACE" should allow it.
However RENAME_NOREPLACE is not documented as "does not replace an
existing file" but as "Don't overwrite newpath of the rename.  Return an
error if newpath already exists." So we have to return an error in the
case you mention.

We could introduce a new flag such as RENAME_NOREPLACE2 which only gives
an error if newpath exists and is not exactly oldpath from the
perspective of the filesystem.

Individual filesystems would need to explicitly enable support for
RENAME_NOREPLACE2.  It would be simplest to only enable it on
filesystems where it matters - i.e. case-insensitive filesystems.
Userspace tools could then try RENAME_NOREPLACE2 and if that fails with
-EINVAL, try again with RENAME_NOREPLACE.

I've Cc:ed this reply to linux-fsdevel which might make it visible to
more people who might have an interest in this.

NeilBrown
