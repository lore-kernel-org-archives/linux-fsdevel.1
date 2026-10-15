Received: from flow-b7-smtp.messagingengine.com (flow-b7-smtp.messagingengine.com [202.12.124.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B7948C8D7
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 08:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792054049; cv=none; b=qzhAIMiJoX4k7gZQz8zIpBZ1hbLFSg+9Umgf5txJhXieqoqsnDyjYJNCxKFHFhrpK+evb+D0VrEjRl4ORxVxVMqq3lFq5bbOUal0tefz9s0WgeREpRMfOllj0uOJ6BbfIyOAARoQ+CVXOv8HUJaz3Y7wXXM+1oWpPV7AHmcmixM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792054049; c=relaxed/simple;
	bh=3DzHIzJFG/LKDyQ+ooB2t4Kz1ibLoewNe1K4ZAt8fTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGftrezN8RBVvkOX1+fkIZ3Z4CS46ee1IwVDHOrlxrCQ3o8ttLrtNc1uRxIO+EBvEeirRj5XaHVHOcXIWs1rHPlV2r4ORtR7/bBdYDtKFuSllTgEx41IcjJp8VTSXn86OSOXIfVbz0s4tig7+ghNt9L4AQiDa46Ee4Fa6/OxvbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=nlLDeU3R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RO/mq21G; arc=none smtp.client-ip=202.12.124.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="nlLDeU3R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RO/mq21G"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id 241981300D07
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 04:47:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 15 Oct 2026 04:47:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792054045;
	 x=1792061245; bh=Xf58ua4FdgrM9Nf7kURSBCDP5FY876Tka1oD3hKlBSY=; b=
	nlLDeU3R88x+C+XcDEWj6mCG0aacaM47ieOCjV6jMsvXWKNAeSJn+jRphkHQxjVa
	/Hcjt9Nx4sADAacO6ezlkEaLIS5p4hJ2nixWUDZ1Lm8B0EEjEE15yo0BIGNLvjDY
	R991/veHVfTvIocmLZ32JaWgZxRp0WizOklplKlPNcisyLB7HArCStpbK6K2j7+6
	p0Kpl5uBFgjLpqGovCBnso3ajW9/JbFYwbBhyyzHPPXPoRw7R2ygxKpRTEMyurzM
	bT8deJsY+xxm8SAz+/ckQW0vqTXxnN8pHwY+oxMwU96rdnNPjHomm/fxYYK0HdzP
	cNDSQIJeLpEZIH1BjHHXcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792054045; x=
	1792061245; bh=Xf58ua4FdgrM9Nf7kURSBCDP5FY876Tka1oD3hKlBSY=; b=R
	O/mq21G6S1V/MDGK5O2JeW3wnBdTY/cNMxw3hkbAvnOh0i2Fw3DgYAgqqYw6megl
	GAwWvJzMwEFuSvaZXLlodkQR4ZDzcg6xmSqWZqEXFEYTlU6j74AQz9rO3wB2um1p
	kxzB8+h0dQGWUXPL/HimmVcTZ6omcUui/xsFAS9r0DqxgZ9l7wdJGHUfeDjZImKm
	EKeYPF6HRAizWckAvJBB8ptYOc1nK8i9v+XJJu3gXKlyZuTKqF2iUsgE6Qs516lr
	R/0YG34DScYNDLs8ExutwwSCKI3+hnnSUfjFfJxdqFZDh0UsBdt0WMlY824aOg5l
	wGj4iLYqb4t14GhGOTq4A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=kroah.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792054045; d=kroah.com;
	mf=PGdyZWdAa3JvYWguY29tPg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:RwLXzh7qMLHABwHPElAu4Zpp+9AXkV27bsCHlkuGuEl8xZL
	v9aMeM21giBvwyvVUfRZoFx5L1Y+6eP6ZQGiij4WdXltvgPPcAKsUm8wlg8QYe89
	RE0V2KAgA9wtPxphHogS657HvJ2r7sVAznWf2C6st6YkKQTLAGXamGeOdVh6z5QA
	eEYjoXywh1wceCFf31LnASgKQ5vWpaawbEuUN+LZy91s9r5y4IGYzLN2aChg9H1J
	tc/7g7/cswGso5FLSVrUPbRqB1Nac1LTGqaIocSemGTFokAgRSsQHXUk6VSrLO/w
	T2tLtG8Ei5ZhVyPXdz4X2kjWp7o/eXfsrSv9THA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:4z7b+kvGW4W1BUFE+mDvvDnNuAnYVdcCWZXSNWUhwmM=:3DzHIzJFG/LKDyQ+ooB2t4Kz1ibLoewNe1K4ZAt8fTE=;
X-ME-Sender: <xms:HZPQavoazQGlCC_srZHMX3zRWqrThV6il8fnwG4GbOBfpTAz3_1guQ>
    <xme:HZPQaqYhfPYR573HAZvMLwDDb7DjT7H9Twd7O97X6q11dQFkwFUgAn7R176AlGKtf
    vazLFYgW12RMxr9HjC6waKMZhjPhqj9t_D3b0CRP9IX8JdhKg>
X-ME-Received: <xmr:HZPQalGn4p8xkMKahMV0zzyK9EX2oMyvSaut_hdndJkOJJWw-jzX_7zpcGwBcGb_rQBTXmnG8WcIRpw-0gd6H0xJYFxSkR_3_IiIAkQBTgI>
X-ME-Proxy-Cause: dmFkZTGdnHDF2BEuJTGH/rfkQEccsg/HRvyWcJAAXBDVUhsoha6DEHd535yO0ryVPimrP0
    PJs1iev2ttBqSBMTRYqueUudaunYx/fk6khoDVVdL4E+Bxie2LBiACKezmG9jkopFmFqM+
    KpeBMecM9r5dOdrWk1DwUx8Bzl0yJMnB/2CTC4TwatOmi3P4gQQ1bKQKuhEwTP5//JuQpR
    DQVVVxzMh9qpzkQy/Faf3dZA/NOyhhP7NMYJkgeeHxgYHy17ui7Ye8SM6OkN57eWqn4RJR
    hDMQRlhBpytg5bOpfLAXtNKmnu53objtZUDw/OdYr8irRcK6yiAqsMP/Nyo7S5yxz2/rNR
    LU0WwSuOL+V3NSd0jTcX1dXBGdrCJWwNnE9cF18dOEhVXpixk+d9jhpY66gYCLvWcBtSvj
    fDe1zQn7OOZ+Unk3EYstRqXQP73r7XhNTeaXbQd0cSZnEptou4XGtK0+Jep0cTcRvBc2Zc
    NFdIdlMnJ+0Wm44JxC3Fqv9eDXoQhLWHsoygzqsak6+/i5fNUBt/EdsGxCOUvZpvMjMU9e
    tNWjCvUuDc0d5L4/iiDzJAuq4CmaPfJ/juDmzaw4sr5NBYYn5DzakDdAUmmJTQ6Tci8VBP
    d6QuajwptKO0izbH6dPfA56pGr/IBZHmPMKs3ulz8YPlp6jVFh89bLSNRbkw
X-ME-Proxy: <xmx:HZPQaqyZHngyoXjPcGRE03S0wgl1A0YUUZtn5DPbk9SWYKS6tuEzDw>
    <xmx:HZPQauA4elDgV_z4Uti6KqGx9uSggAW1zonoLEeIVHr63eYLxnVdBg>
    <xmx:HZPQahXnthiPhLqMqBbMbMmTmZ-jyc9En74IoVuAQBlGWVRMCN1c3g>
    <xmx:HZPQaoj8rRh2nVnUKW8U2hcP6UunGYIoo9oywsDH2naGWHMfBiQG-A>
    <xmx:HZPQaq74FgGVpFzFiB6G3lvvVM_1UdCzVTsn49sjIv_dJy4KI2Fuld5l>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 04:47:24 -0400 (EDT)
Date: Thu, 15 Oct 2026 10:47:29 +0200
From: Greg KH <greg@kroah.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-fsdevel@vger.kernel.org, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2] seq_file: Require explicit initialization of struct
 seq_operations
Message-ID: <2026101515-oversleep-related-e4dd@gregkh>
References: <20261014225811.i.852-kees@kernel.org>
 <20261014225818.3457479-2-kees@kernel.org>
 <2026101517-profane-opponent-4523@gregkh>
 <CANiq72m_iyquf4Lc8AWvbsBp++ASz4+C_MQ5iYQW-fHd_MNDxA@mail.gmail.com>
 <C46E97AC-3722-4264-B541-04EBC3091E00@kernel.org>
 <2026101532-fantastic-deafness-e04c@gregkh>
 <CANiq72=wS5NJyeKKaYiHKWhDq2Wjk728qkCUNq4xVoHrPEPCRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=wS5NJyeKKaYiHKWhDq2Wjk728qkCUNq4xVoHrPEPCRw@mail.gmail.com>

On Thu, Oct 15, 2026 at 09:47:34AM +0200, Miguel Ojeda wrote:
> On Thu, Oct 15, 2026 at 9:11 AM Greg KH <greg@kroah.com> wrote:
> >
> > __must_init might be smaller?
> 
> That sounds fine too. I like that it says that something *has* to be
> done (like the original name did). Hmm... On the other hand, I guess
> "must" could sound like one has to initialize the field "somehow",
> i.e. writing:
> 
>   struct S s = {};
> 
> definitely initializes it, yet the compiler would warn. Would
> "explicit" hint a bit more at the fact that one has to actually
> "write" the field, even if it may have been initialized anyway?

"explicit" is a description, "must" is an action that tells the reader
what they have to do, so maybe "must" is better?

Anyway, I don't care, naming is hard, either is fine with me, I'll let
the authors of the patch here pick what they want :)

thanks,

greg k-h
