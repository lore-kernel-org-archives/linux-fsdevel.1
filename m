Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0483B3C1C;
	Sun, 17 May 2026 13:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779025413; cv=none; b=U+VkMdOnXVHxNuZJPyPK4vI1LbD+3mlSVKrj5fS/d2f+PhsU6iWlPtbN9Df5Ms1YikUGLXAr7O0EtR7qPfYWtIWS8Gz3N34ZRb8pdptXIRL1ygIvSQ5/GYQzQzkC144eJteLxHHu8O5Dkfa6xq+2rOlqMtMcjFW0lKoZlih+Opg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779025413; c=relaxed/simple;
	bh=mv3chxnEcXEwMHvCAEmLLasEdiYg6paywtYUe9PUFAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NZDigpBNUQXaEGvYo1UhrcPiAScd9Xw9kBl/qR7RIPy5MTfzS7YxMFrAjp3ECQYfBT/nIehuxujEpWoLd/1QawYTwXGKSYl58Xb52d9eJ4jSYyzavxMPLfmPQsI7uYxPN4yLCGY3ktgnDAo9hJYb04jMF/bORU3YRrzJYKOY7bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=lQe4uKmt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HPjHzdV8; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="lQe4uKmt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HPjHzdV8"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id BD95DEC019B;
	Sun, 17 May 2026 09:43:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sun, 17 May 2026 09:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779025410;
	 x=1779111810; bh=4bCt5l73L+kUqvGEq47rCXo8OAeb/BK8y2e4PG2ydWE=; b=
	lQe4uKmtpMZQuzW9iCMtVwlMKc3gQ8Jfj1KVNiurUV/6OVRl2PmXgvVFlppmZ+I/
	ITlkqvIk9UjQfzzD/6o7RmeBjUlmgdh7FMPts3yR/o6HWKx35MpYNR50fnRNllwQ
	1W3MCdby1ce7rxGxDqWnTmMk2lwKmbQGbenhpjbuRjY+fV59bQDGiOrlvtJky15H
	w/xQIlkUv6uOKavqpUfRVxQfCa6YzPGDx4CmelMlavN0S1WBODW4DNXTofuLN5YY
	IHa6mk9vw9A3hqRfLczaT38LuDhkjBg66z320UkPJ3mvfvqrFInZbjABnWAjgSYi
	AmOXh7rdUC75LHzrVpeYmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779025410; x=
	1779111810; bh=4bCt5l73L+kUqvGEq47rCXo8OAeb/BK8y2e4PG2ydWE=; b=H
	PjHzdV8D7oDZIyHIXur+jEfPZwHk3tXXQC7n3yMR3gRwCp/PSeIXs1X9RbJIzB04
	+WabXjkGCHWk97GOmvDCV3O8hKD9Ec8mpxL0GrdY+75jRwTFnFvD1EZB/xKW2ctT
	0xhN0yuRsUSq7Kod4/gXzCnaj5An+gHj4D4rUwm9yiZd6LqAIvTvHQwSAXzNpJxo
	E7JvlhbqaIORKjfxYIvlSjgPEFz0v4R94Hj69NiWCD4uSi3nEKVoQIwdCGtGzw1G
	FZltkDF02KlrnP3dPJPRX1ZLVVA1BktodvVTZOFBFvCZFMEok40vQuXd9hbTp8Zu
	LQyJfXhDvEQgAB7j7UxlQ==
X-ME-Sender: <xms:AsYJaqC_i3XfOEhi26GzfBtlsAESq6_DNrecUaxnP9Y7JkVotHrCAQ>
    <xme:AsYJauh0E3doxAgZQwhxcorwbkPyljBW2bAPx9baS96PTLOzWHXHJXUMS4U3J7ijO
    Duf2v3wBwZII5TeuQlZnSgfDe2iQTmj87r4wVh6UZQ2SwugK6Zh>
X-ME-Received: <xmr:AsYJakPFb0z1aOYvHLiedZlAq7Ppx1BSrGK1hgH08VTRDPVoyvinVuK_zbJcKr0HzU8b1ooB9Y9m1xRvcvvXXwfDqVcClsSFWOOkRp4LbPauo5LDOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeeiudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeejgfeljeeuffehhfeukedvudfhteethedtheefjefhveduteehhfdttedv
    keekveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugessghssggvrhhnugdrtgho
    mhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmh
    gvsegsvghrkhhotgdrtghomhdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhu
    nhgurghtihhonhdrohhrghdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhh
    hupdhrtghpthhtohepsghstghhuhgsvghrthesuggunhdrtghomhdprhgtphhtthhopehl
    ihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepshgvtghurhhithihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohgrnhhnvg
    hlkhhoohhnghesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:AsYJam8tTcuLWmdE4uuIZwfHjFGuUO-_tfxefEibbJ7FieL8A8tDkw>
    <xmx:AsYJatdixY0ewCrWMlRMCgqocyTzhohMxh37tPU9l7WFFZLUVDZrVA>
    <xmx:AsYJatwfwHaPVikDeHDVbXPNjK63a2woXri6e4ZGfG28_vto7BJWsw>
    <xmx:AsYJaqINW9qSOk3qqkejRWJGqZbnBO_A7KTjmKmAjFU-TDzGaFK1Zg>
    <xmx:AsYJarLy9wo4-qavmIXzzzftnIy-1Bf1H1pA7Pk6j8jLFvc5ii2cw4W7>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 17 May 2026 09:43:28 -0400 (EDT)
Message-ID: <08523a14-61f6-4d88-8523-d12c7a5edfa2@bsbernd.com>
Date: Sun, 17 May 2026 15:43:27 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] fuse: io-uring: fix two UAFs in dev_uring.c teardown
To: Berkant Koc <me@berkoc.com>, Greg KH <gregkh@linuxfoundation.org>,
 Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 security@kernel.org, Joanne Koong <joannelkoong@gmail.com>
References: <20260517095846.fuse-iouring-uaf.dc5f5dbb71dc@berkoc.com>
 <2026051703-equinox-multitude-91e2@gregkh>
 <20260517-fuse-uaf-cover@berkoc.com>
 <20260517-fuse-uaf-routing-fix@berkoc.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <20260517-fuse-uaf-routing-fix@berkoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/17/26 15:14, Berkant Koc wrote:
> Quick correction on the Cc list of this series:
> 
> linux-fuse@vger.kernel.org does not exist as a vger list and the
> three patch mails bounced from it (550 5.1.1 User unknown).

The right list is fuse-devel@lists.linux.dev. MAINTAINERS file is in the
process to get updated.

> Per MAINTAINERS, the FUSE list is linux-fsdevel@vger.kernel.org;
> adding it now so the series shows up in the lore.kernel.org archive
> for the FUSE-fsdevel readership. The original patches and KASAN
> context are in this thread via In-Reply-To.
> 
> No content change to the patches; this is purely a list-routing fix.
> 
> Apologies for the noise.
> 
> Berkant
> 


Thanks,
Bernd
