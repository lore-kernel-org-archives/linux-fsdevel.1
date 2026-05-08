Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61F9330B0B
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2026 10:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778237000; cv=none; b=KTS8m4gBoFf2OBq6eK77m/EBJaqeurFogCahvj0P85KaYeW3x1hr2jmQMfpQa960IDbLLDrwwMVfpcvTfRZUlfdRnfilOAbSjxegWLPGeWitgVbHXMvqivKpXGsoWDztQ/RiT09iLMQwvchOlROnqyZSMS01460JB1mPKwqF3Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778237000; c=relaxed/simple;
	bh=lj095PnXNVGxSaO9uhhAnoBWMXArt4qVTKac/ecG39w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ui16UGPM1QJR7n4abvUwM4paDPcHCZQMirLNCBaChxXTsGfivWmVVydPioEgwBj75sPxPPIBBrHOsyCYHv0vmDmYBBHYNx0totCuQt2dRYJjBgoDgtRy8NRezKXWX4636cAwFVCn1szOQLDERHCHqCzXDiEqRLlXnnCcnUg8s3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=sNGx008A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FvBbHg99; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="sNGx008A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FvBbHg99"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 88D951D0007D;
	Fri,  8 May 2026 06:43:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 08 May 2026 06:43:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1778236997;
	 x=1778323397; bh=SDDn4AgzsTYYgSuJLh908btmskYTyXTdlToS1bfJppg=; b=
	sNGx008AylRFsK+1xFhIUjzj6lYOINCDOQhxQTMi5sZlebhc8XWFZV5Pk9zt+Xtk
	J4ix/iChbb1i/tHxYuztHJ1XAccF2T0ZcQ4GgCSMu3Kip9pf5oZ1u7xoQcdzIe8z
	1gIBaby4R5feqF/Ryxb9BJ4ZA2lV7ZCIfHvCJD/uk74KClfs4oJx5S8qlOPENqjA
	y4RCOFgdClNrw9B2FR0kEyX14D/M/zbjZT0QNBjOGaaxGGLjvQfnytQuSqPRV7fo
	YLHIEOrC1LpPWxSELAJpQI7bzyQ7GiDpnkwchHa99RNQFKCmHDAvHY7OmoSnZmvy
	vHd4jIJzjUGOpgjQ3/heuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778236997; x=
	1778323397; bh=SDDn4AgzsTYYgSuJLh908btmskYTyXTdlToS1bfJppg=; b=F
	vBbHg998w3MoLFAtYS6cACtsTHsYyLQ2j81ebT1fJUsrekv4289w/4zOVKgefKkl
	YJDHauOP0ZvVHokYOr2fIqvKdhIBIhUb2CmgTGJd89uCUPjKlZs37s/QAc8FyD/m
	0VqO0swXSeP0YHh7zikENz8rPAXbNG8pz/lLVvZ8O7lct5jUPFIbsJmOu/KKk6RV
	ocA6DTmAd+DPKoNejo6QVAa4KeWfJ9Uf1MMRk7Uo1OIYO4jMakRWCDbRwJ/lvXSg
	cPngRtkgmqAUqHxlBToZRvpyVuIGOg7Jap93iwkbNJSsr5jp4s0Ot1cFmpx+SB8A
	2tdGDGPfrI2wABUU8t9dg==
X-ME-Sender: <xms:RL79aYVlzWb4lDRwG01-6j49fiCTR8cG1FoVtRPAGT04Q2Lwjy79TQ>
    <xme:RL79aV4nMx-G2UB_RWfnOTXfa09s5atn209jfrsjJ1uTLItO-Xd4Dp5oTskstcc7G
    tvb_Bv3s7dguNbzmq0tVZF6V8xjIruL-2t0tCjIQDQh0zcbS6dI>
X-ME-Received: <xmr:RL79aToGRHMsUYEV5EMHmpg8Z-UjHKZcv7uxfRS3Hvd0-uqWxgK1AyeCpOm_YWBIXnBWV-xyUngF7vsYiFf0gU-W4OL4FBUIbZ6EztUKostGyOIOnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduuddtudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehjohgrnhhn
    vghlkhhoohhnghesghhmrghilhdrtghomhdprhgtphhtthhopehfuhhsvgdquggvvhgvlh
    eslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehnvggrlhesghhomhhprgdr
    uggvvhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:RL79aYnhNsqXqOjpmpksE-kTLGOTvY63T8N0H0AVrgRyy1kjsX8D3w>
    <xmx:RL79afOTUy4zWeSEQ5hKwYy6s6cuMnVwnnb7LQ37GIyOSJUv2QwbLA>
    <xmx:RL79acNUVO32CVqRzpgBxcGyFUbNmiSGwd9Tsz4Ci6NX8QXGxL3YZQ>
    <xmx:RL79aQglF_pDPBmq0J5BXfPyunrPSrJDte87Ir9eJFCfgBgE-voYeQ>
    <xmx:Rb79aWnfC8Su-1mKgvut0RZatAgj9yT18s7eSTGVZZGFTYkYe0WVvonS>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 May 2026 06:43:16 -0400 (EDT)
Message-ID: <6276b3d6-cc8c-4e37-b670-ff2a25c69686@bsbernd.com>
Date: Fri, 8 May 2026 12:43:14 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mount_util: fix mount_flags entries for MS_RDONLY
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, fuse-devel@lists.linux.dev,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org
References: <177819197881.3490692.13850589276777261250.stgit@frogsfrogsfrogs>
 <177819197899.3490692.5280827494230619038.stgit@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <177819197899.3490692.5280827494230619038.stgit@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/8/26 00:13, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> MS_RDONLY maps to MOUNT_ATTR_RDONLY in the new fsmount API, but the
> table omitted that.  Fix that.
> 
> Fixes: 0d7e72541564a5 ("Unify mount flag structures and remove redundant is_mount_attr field")
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  lib/mount_util.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> 
> diff --git a/lib/mount_util.c b/lib/mount_util.c
> index 1a0aec9bfe1a70..7ab1dba91e28e3 100644
> --- a/lib/mount_util.c
> +++ b/lib/mount_util.c
> @@ -110,8 +110,8 @@
>  
>  const struct mount_flags mount_flags[] = {
>  /* opt            flag             on  safe  mount_attr */
> -{"rw",           MS_RDONLY,        0,  1,    0},                      /* fsconfig */
> -{"ro",           MS_RDONLY,        1,  1,    0},                      /* fsconfig */
> +{"rw",           MS_RDONLY,        0,  1,    MOUNT_ATTR_RDONLY},     /* fsconfig */
> +{"ro",           MS_RDONLY,        1,  1,    MOUNT_ATTR_RDONLY},     /* fsconfig */
>  {"suid",         MS_NOSUID,        0,  0,    MOUNT_ATTR_NOSUID},     /* fsmount  */
>  {"nosuid",       MS_NOSUID,        1,  1,    MOUNT_ATTR_NOSUID},     /* fsmount  */
>  {"dev",          MS_NODEV,         0,  1,    MOUNT_ATTR_NODEV},      /* fsmount  */
> 

Hi Darrick,

I had already pulled this the night before and it fails the new tests as
well. I think issue is that ro needs to be done via fsmount(...,
MOUNT_ATTR_RDONLY) *and* fsconfig(SET_FLAG, "ro"). I'm going to add a
new column into const struct mount_flags mount_flags[].


Cheers,
Bernd
