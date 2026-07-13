Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F9935CBCB;
	Mon, 13 Jul 2026 21:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783978540; cv=none; b=B01+eCqw11hS/JeOeAP47lHLZisLIJJPKhf4tKnGBbXg/YIAkF/ev10uYQRwlvvOwG0eb/ovchYZKgAZeXtte9uW626iNaEu//Heml5PI4Ns37wbzqP+BINEhZ0ayFywwhCJwNP9XYY7wfgN60QZBs8kzPmdf3qwl2iXeSAmPjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783978540; c=relaxed/simple;
	bh=AliUxmNyrizUMRRhJy3s7jAwqFR7fHVSuT+vubFa39Q=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=s4+KWIP6Sk17erMrlTNh9ZFWpFCn5zoPL6s2gbc1Fu2m/f7RSHRtrhPToJzWJ6uQVfiunIORgzFa26Oznd/P2iQ61eklIn70kTMYPjF200vUHeGf9DhuoXBsgrc1HHpJTDwWwrSrnKdrbsL8dX4MAJMi3mcBWwDKfzb5YYCyn70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=C6fdiMUs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZZQPaU0M; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="C6fdiMUs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZZQPaU0M"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C714D7A00EC;
	Mon, 13 Jul 2026 17:35:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 13 Jul 2026 17:35:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1783978536; x=1784064936; bh=0EVvWbVcGBIS6O5UeL0LM+IVNHJIUz2Wbbj
	blRTNrvE=; b=C6fdiMUsYRAk/hxo6erUEq1Bn1G00o/+GY42vW9lA6ZuSs2Y+OD
	x+dANJ//dKw+L997jojf8sUsL1yvYzHEzNniYTGceyvZY//0YmuOM1r5jVeiD27k
	RdVsaU8/dbc2YXTPGAFVi987mWxTvc/16IhAWi/gZ6aCYIpZJU0mAAAWlcKlBauc
	5VuRbnERN9KVc5uW0JHFLphX2IwDc1WKc7dxVkLOG6ijlHq77CgiLCd1iy+W2Hha
	3rsQ7qdJAnUFpVYLCmLxuK4Fa7J6Gu2TXawXIR9kl0Qh2zqigh7WfwEW7dCD2QBl
	G46vOwI7YTm+ijzXseNV+3IpDFw32Grc8VA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783978536; x=
	1784064936; bh=0EVvWbVcGBIS6O5UeL0LM+IVNHJIUz2WbbjblRTNrvE=; b=Z
	ZQPaU0MC5KCVATZEUNY8LehFE0OyMYFlns39ZKrMD/1D2jpuJPsm1ZX8SHKvDzhs
	mE4GvnC3nq253zKckE6MLiHkUmy17He3QRyRGiJlkyngSrs6WJwKBAqRxneC31R6
	9Y+ccIujqg1dXLPpRGpYaACLXbXXzVrwF+341nde1QM9OYbf3pIea27k8tdnMK2s
	Lm0L6ap8Smih1tdgC4FRHXNr8Peeb1XB0ZJkM6quKTUDAi1UA58ZOgiAmRUP57LG
	PXjSqsCmWZgWFPxdZSOE/nFU7gFSFBh4dSJkooviMqdZ8ifZJMioAcQVHs1R2RS2
	UoFnPGoXmOVRmpTw9CJ4w==
X-ME-Sender: <xms:J1pVapmayCf2qF-4fGZnNLkRAfVE-h6WF6i2Cf1gO5zCE9uWLsObDA>
    <xme:J1pVapOCrCZHzVitIK_fVoO9nSaTa01MCY3onEEE8QbPNW9Fanb_I1bA5tNejNo-d
    5dHZiKOhuLrZ7izQ5Zghm4GpFE7vdHuIkAjaehBfJPThtrWSNg>
X-ME-Received: <xmr:J1pVatjn9YAfI4yjXQVxoo3w-_piPP2jaB0EoX6We1m5G_jpapfY8RnkSENg-FlOQbTXsGyU1teWiDvGtPIqOv9ibbvzgF4>
X-ME-Proxy-Cause: dmFkZTFtVWcyvlj9dX6LbGORFVr9QDTacQt3uZB1gRccUQ2b6/yyi1RVLf7dSyGuwiSUms
    xl2G16j8fgIZkA4o8hPJQwcAQxuqZ/YOcjmhVVss8/B3D9lUOn7MkIkfuNFXtqsu6qzA+W
    vv1UjvM6C/KQzfkDlGn5Fjb90odMZWo4bjTfmEK8UJ3uiUGxadSJ9KSnyrwd+02ADhUP61
    +5ZrMYNURkdKEee3gUCm9P8LW9FxIcmZltm1nUCnQEqmDp4wr9upmPt3VtCmTmSsS3yWal
    DhaVVagRLw12/KCml/X9+8bJJGaQPLLkYk5OknVMTqZuFbpusBmkJiYR+9QzgB/wgRc9Ls
    7JUeTat4PkaFwHoM7kBuU904pshF2Vs+uKMSw4PLdAwVIUNXAtyrexrltGMTK7pm7X/Khm
    FfR+qmHCHUSGplHirIRtSn9LPhrY+FmOxGBhotwTV9B2Sa5v8BWBBmZD7F6SMnEmZ77rAL
    F4DXLiBNgoxMOQt1Ex/v6KdeOhBCBrBjL8tdCOqbp4O+bKAcmmrfsCkR89ahOG4ZyQQZRG
    14H4pg3vveO3BmWk62N8gPHVlDMQbcle1moQC31Hc94WSeUGraTk3BCJsgiXviIl1uSTMg
    dRA4807FeK0V//tbMbF6Xn4nfOkHT5p1YmhzStDO2t+51SrX+r74Lb2kLnMw
X-ME-Proxy: <xmx:J1pVanhdqig5HTUgYWP0e_huf3n_p0Pn2E_XlFJQwIL8oa6f2XYITw>
    <xmx:J1pVasJtIsZeCOYa1_1xBkjubQwocTDGypiD-9YyOuL7Z90_J1YgBQ>
    <xmx:J1pVamkVtn8w8kLDjxII9rZTO8eU9XC96Y96ex9N0dAHpQ4gN9zt8A>
    <xmx:J1pVakPy-RR9vNZSyyRzONE26-yDlowZ2Mc48tbj_hWZB2P1WRt8RA>
    <xmx:KFpVaobtj3l1QRVPeE_023hdK3uh6wZ2yeUZ1mGdTLMFjdEqupUInJ6W>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 17:35:32 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Christoph Hellwig" <hch@infradead.org>
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Pedro Falcato" <pfalcato@suse.de>, "Jori Koolstra" <jkoolstra@xs4all.nl>,
 "Jeff Layton" <jlayton@kernel.org>, "Al Viro" <viro@zeniv.linux.org.uk>,
 "Aleksa Sarai" <aleksa@amutable.com>, "Amir Goldstein" <amir73il@gmail.com>,
 "Jan Kara" <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/14] vfs: add O_CREAT|O_DIRECTORY to open*(2)
In-reply-to: <alS10NN_OduZEqvt@infradead.org>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
  <20260704164149.3480051-10-jkoolstra@xs4all.nl>
  <akyyqnv9EpY7xVdC@pedro-suse.lan>
  <20260707-vorteil-unhaltbar-apotheke-47bb105161ff@brauner>
  <alS10NN_OduZEqvt@infradead.org>
Date: Tue, 14 Jul 2026 07:35:28 +1000
Message-id: <178397852844.3371781.6900199568039042534@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Mon, 13 Jul 2026, Christoph Hellwig wrote:
> On Tue, Jul 07, 2026 at 12:04:18PM +0200, Christian Brauner wrote:
> > I don't think any of this is really an argument worth considering.
> 
> It very much is.
> 
> > This is a lot of handwaving for the sake of portability and concerns
> > about past API mistakes. To both: so what. If an API is useful it's
> > useful, POSIX be damned. We're not going to be fenced in by some
> > standard.
> > 
> > 90% of our interfaces blow way past POSIX already - in most subsystems.
> > If we'd back down ever time someone shows up with "what about POSIX"
> > Linux would be irrelevant.
> 
> You can totaally ignore posix.  We need an interface that is self
> discoverable on Linux.  Any combination of flags that was accepted
> by previous kernels and gave different results than the new interface
> do not qualify for that.
> 
> > It's been years since O_DIRECTORY | O_CREAT has been made consistent
> > which means all LTS kernels have consistent behavior. We often make flag
> > combinations work that didn't work or where inconsisent before. Nothing
> > here is special at all.
> 
> No, we can't rely on something being backport to old enterprise/cloud
> kernel.  Doing so makes the interface unusable for actual applications.
> 
> > 
> > I appreciate the concern but even if this were to fall flat then
> > worst-case we'd add a new flag and we'd still make that work. But I see
> > no reason to not try the semantically obvious thing and make
> > O_DIRECTORY | O_CREAT work.
> 
> New flag as in new O_ flag for open does not work because open never
> checked flag.  Which has always been a giant PITA, but as long as we're
> dealing with legacy open(2) that is what it is.
> 
> 

So let's add OPENAT2_NEW_COMBINATION which instructs openat2() to reject
unrecognised combinations.  Old kernels will simply reject that.
New kernels can start using previously unsupported combinations safely.
Initially reject
- O_DIRECTORY with any  O_CREAT O_NOCTTY O_TRUNC O_APPEND O_*SYNC
        O_DIRECT
- O_EXCL without O_CREAT
- O_NOCTTY with O_CREAT O_TRUNC O_APPEND ...
- O_APPEND without O_WRONLY/O_RDWR

and probably others.  O_TMPFILE woth O_EXCL, O_CREAT with O_EMPTYPATH ....

Then the O_DIRECTORY|O_CREAT patch set changes that to allow O_DIRECTORY
with O_CREATE and user-space code that wants to probe attempts to openat2()
with

  OPENAT2_NEW_COMBINATION|O_DIRECTORY|O_CREATE|O_RDONLY

Maybe OPENAT2_NEW_COMBINATION could just reject *everything* at first,
then incrementally allow new combinations as they are defined.  Old
combinations can always be accessed without OPENAT2_NEW_COMBINATION.

NeilBrown
