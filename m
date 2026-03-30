Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813A41A6800
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 07:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774854054; cv=none; b=fETwOyGBXhrPGZiVYKa+4YZHlsXYJP1nO0N9ZxdREJC2EZZWJ9mhl/EI7MJCPfNefbP9MjalbC58ZdIcsUKXUPz+LZhm5jwWL94Ai2UaIVqutsSwYYTGx9L7lQZYyLl2kj6Fbuj/WbP6ytmEM+tfwynGD+h36rhrZvsA7iwRpN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774854054; c=relaxed/simple;
	bh=R2JyrFpzeaKf95DmxNXQSpwj8V93j2n7ljdK1M+2Igo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=NGMAEIHueIIVW8l+cVgHuSKaD3ehtzT1gDSRFMNDTxAq3nh2rDdUN7TV2g8nzyyX53dW7Nhm4bO+22mx3G6GnBF9SBagFQjSoZd83aJIz9XySLqVZeTe+a62RE3q8eYuJQv9ylQWU+Amikgh0LqapOShDdg6kNCfnduKPIfkvTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=ielsF4aU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QOhR64h0; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="ielsF4aU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QOhR64h0"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 8DC891D002B7;
	Mon, 30 Mar 2026 03:00:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 30 Mar 2026 03:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1774854051; x=1774940451; bh=FxFLg0bonVmLdVuLuLGUsneQdBG2yhmVbhy
	o/jb8BvI=; b=ielsF4aUlvgo9lxHhmJoLgC4q95x0XS8fVmcyHa/241lIkPdx5t
	a2ou9D0hXBAD2PRix4KDPv1MbZ4wpj9iCue6C3E9MZ50ArFoMQIXbn1eeTnobXIC
	USHWRpvpUZzDz4EP0ze/UBx1Gsc4cXLgoxSmHzgBlcbFibMNAIwtSR634m77E7Xn
	PBgRcYCMVpU81iOXEDtf8VTjgE4cI3sBTTS7mA4Wfqqd6dt7f3nHir9Rv3pu3kaG
	962lM21giZaKdVSrAfeJ2WIMzus36G2lsOSrzUy64eEYk/kZo9oo3YO4y3yTFvXe
	HQdhl+Bp7cj8dJDYCWX4xvQcHmeWdr5KU4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774854051; x=
	1774940451; bh=FxFLg0bonVmLdVuLuLGUsneQdBG2yhmVbhyo/jb8BvI=; b=Q
	OhR64h0pZiwoLsZJoJOl7LqM9aQfiU4n3ma0Yq75y4bc7KhB4gTPJ7hDGrhcGeHe
	mvEjwI5G+knoUA66kKEJ1/MURXzImDL51nnfMvKXQDjyhP+2bVxlT5aShhwsfy9f
	oh+tRyAFbcg/5H9adrQkjIvmZnFXMUFE+GSGJ96sb+8ZlWmgTmGItu4LqssP03ms
	0jxLo0r8CGzkEIGHdGNU5litsbtZnrPok77sPG00Pu+pvX32VtEq7rl0kcVX2xzt
	XLLdKL9HLESlB29C3BfLeJb4glrdmfsYF+SoPPIU8laSgw2z3z48u6fpbmCkUhzi
	jhjyAkRW4GZskdJ//4AmA==
X-ME-Sender: <xms:oh_Kaa2l9VcpITHn9Tm6dWOVxL4oITnhMDv9dM5Nqouu8giazNejfA>
    <xme:oh_KaWBS6etUtTdkZyhV2sL22LWybPs1ELRArrC9ANtqt7d7KwQ0Thgjvami0tu2o
    xM4o2-6o6JzHQbn9g6ssKlyGX48P2KLFIGzWafgz-O44fQ3W7o>
X-ME-Received: <xmr:oh_KaeeaE5lClpjRBRwWelcPUWHAuzaXe9mPScUug1VZTsNRKtE9mM_f68rSydO3_6J2jfjYRJt607ySlUmINOiq5XS_I2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeekfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epudetfefhudevhedvfeeufedvffekveekgfdtfefggfekheejgefhteeihffggfelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprh
    gtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepsghrrghunhgvrh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgthhesihhnfhhrrgguvggrugdrohhr
    gh
X-ME-Proxy: <xmx:oh_Kab6_6eDp0Qf959Z6T3xFZ_O9DCYUOpuZ1asWGuaYl9d4nbaLMw>
    <xmx:oh_KaZWytpVT_VZxW-Rqcsryim3UkejDpWxqi89jhCkqROjsrxEZYw>
    <xmx:oh_KaS5XhZ67StbggTKzbrOHA-StuTq0yQ-hrKAn3j8bjOtWlESdSg>
    <xmx:oh_KacpB9_MkxqISQ8FlyosiPMS1FSxO748cwx4H106s2RolLi9D8g>
    <xmx:ox_KaZOWGpTOrI7Xog6iVRtTjPKOV2Ukn-ubFHn1B6wqAuakRV68FfXb>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 03:00:48 -0400 (EDT)
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
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject:
 Re: [PATCH 4/4] VFS: use global wait-queue table for d_alloc_parallel()
In-reply-to: <acoV3YBaJjl0Bh2X@infradead.org>
References: <20260329225603.2177730-1-neilb@ownmail.net>,
 <20260329225603.2177730-5-neilb@ownmail.net>,
 <acoV3YBaJjl0Bh2X@infradead.org>
Date: Mon, 30 Mar 2026 18:00:45 +1100
Message-id: <177485404586.1851489.2979661987621854672@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Mon, 30 Mar 2026, Christoph Hellwig wrote:
> On Mon, Mar 30, 2026 at 09:46:39AM +1100, NeilBrown wrote:
> > From: NeilBrown <neil@brown.name>
> > 
> > d_alloc_parallel() currently requires a wait_queue_head to be passed in.
> > This must have a life time which extends until the lookup is completed.
> 
> Remvoing that looks like a good API change, but the replacement looks
> a bit cumbersome.  Any reason wait_on_var/wake_up_var would not work
> here?

Thanks for the review.

Yes, we could just use wait_var_event() and wake_up_var();
It would be even more important to skip the wake_up in the common
case that there are no waiters, but that is easy enough with an extra
DCACHE flag which we set before waiting.

It would probably end up being wait_var_event_spinlock() and
wake_up_var_locked() using ->d_lock for checking bits in ->d_flags.

Thanks,
NeilBrown
