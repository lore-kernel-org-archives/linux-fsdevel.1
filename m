Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15CB344D9D
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 13:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778593582; cv=none; b=J828DGWvTt+dzp3h6eghq/3hO8sOkXYW9iDZm82w/MxhyGLs9NQwUmgt6ITCU2b9PNzjdqmWxwJXdTCXFijHUGSznIplO+fZ6RIGukw5Tnlb/xP0QrrSe1yV2mPclSAd/0hW4l91a08mZomtnVmG3U5jDTS/GQ1vTyy5HcDe/9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778593582; c=relaxed/simple;
	bh=aOskcgxpxnSejEUt/QNYJbvPuYTk4CJA2DNTP7+Od0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qg+kg6k7UIuZqGcwUsMGZgx6WMIfzku1I3cewYYPXl4ENoISKJ9U6YBRI2tQ/rQZuizwMBIpN41ehBEnEESZRjSDHMYfsZS47RT9HkTRW9X9PMZOwbM0Yxuus82weIC9CiszR9ySTP44Sqqhtz4jjJNBnbNu9jeHbx8NfnogclE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=qfDzhWPW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QPG22o0Z; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="qfDzhWPW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QPG22o0Z"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3966614001DD;
	Tue, 12 May 2026 09:46:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 12 May 2026 09:46:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778593580;
	 x=1778679980; bh=ePYcN8LaFhCB4zVDoNe7gz0F1I8EVhd0o7bu6goIYrQ=; b=
	qfDzhWPWIm2BB/j3WfTwptRZ/k4moeoma/VMo/+je7uu1ig1axiITfvW+KIV+CpB
	Doa02KPTVuJr/OWOaOwKuc4px0pKVz3HvTuHVYAc5T8FzAM22Wp67ytNsXmVHRWo
	OKUUGDzZY6XxauNrwc2oSYAAV992WMXh9hZxwMyr5SXPpw74r2Ct9fkSmvoDVWOk
	g1ot2dj+202/JwMtjVPZBDUDvZjYnRV9wQ6qAaW91EokXE0Qc0CIrrY7LiE8ks29
	UIRwut55t07SlWv2mKBk1cQ+a8ff8LHw/dELIJeRBwWyJf6W9PBAANj815UJRVAn
	HUVf65XSyu9oMVsG0sQjtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778593580; x=
	1778679980; bh=ePYcN8LaFhCB4zVDoNe7gz0F1I8EVhd0o7bu6goIYrQ=; b=Q
	PG22o0Zx9Ifv1FzGfBFs6guMGJQsGLY0VIrf/8X86FOJmU365jOpsUniVO/tZflc
	f+0H9DDwnVTex6NfJ48RYGfUI2kVZ5JYNF6EA++DBdFH/YSk7ZlAJUKCm6JlKmcB
	5Gy7imMaOlAWpYE/kz+wFTpGcQyCkcMDUBNuaFOZUoZulYhQv05huXWFdzdxKNkf
	0Tp4Qyv6Eo+wON8OjzOZfnQMRUlT2uo5Dc/wIJF6xJrw87vQFu5rpOz9q5avYUVM
	it1Plt52C9lydp09xOU+z6KLDNnbfRQ4gGQ5cAQhxaxeXhjNPf9g1s28MGFu4G9y
	E8ASG513QPPOa417lVhTw==
X-ME-Sender: <xms:Ky8DaikD4cdHceORcAP66lheDEnJDYdTbD-iumt9CNpeMZUsFCNvDg>
    <xme:Ky8DajKeXp_1FuyOqL9tut0Y9JZ2Cla_d1dSj9kFCjg3JWVjO9WpRVGNZo5baPhID
    vfaLpWZxjkYmM845Ldg7Nm9fziy9OD1Z7rMvVW838oz3YJKHYAa>
X-ME-Received: <xmr:Ky8Dan4W-HUZ_Menq8ZKs_2RQoN-1wu3idL4e4e91Q2AYuxpQDA6pXnrpYyTd5c03mQs5VBlDelEYMlxcBXPqS3YDpIrWsqTPDtOqB9WEFyfOXjtcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdduleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeefgeegfeffkeduudelfeehleelhefgffehudejvdfgteevvddtfeeiheef
    lefgvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomhdprh
    gtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohepmhhsiigv
    rhgvughisehrvgguhhgrthdrtghomhdprhgtphhtthhopehfuhhsvgdquggvvhgvlheslh
    hishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghl
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhhorhhsthessghirhhthh
    gvlhhmvghrrdguvg
X-ME-Proxy: <xmx:Ky8Dan3mLq6fbMKYhoY9Xyz-PqviSvxxIsvnJRpNZu4RoH2bJtLTNw>
    <xmx:Ky8DatfnUDykS2_R_BrmfqtJMBksexLYji3PeWWzWnglXtBAu0Dt8w>
    <xmx:Ky8Datfkv4m4VTUnamTc-_zpzD9hIcyK2h-P1B4NOalgPTKmJz1SiA>
    <xmx:Ky8Daox1xWFDMmep68P6bU6bk1hRBXc4xRkoA7SANXrooQatGbrI7Q>
    <xmx:LC8Dao_Ztf-ddXtgod9_vyGqpMMP432S7IVNheQs57TQ0GaERmihYWHm>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 09:46:19 -0400 (EDT)
Message-ID: <89cb66a2-0f38-4b44-8897-50e932ef6153@bsbernd.com>
Date: Tue, 12 May 2026 15:46:17 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: add fusex filesystem
To: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Miklos Szeredi <mszeredi@redhat.com>, fuse-devel@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, Horst Birthelmer <horst@birthelmer.de>
References: <20260429102058.1362965-1-mszeredi@redhat.com>
 <afxK2HSiwY32KaWw@fedora>
 <CAOQ4uxg-tgCmJkjFAQ86_xB7dDQKGy=geKAcxT2vB8cUSEKdPQ@mail.gmail.com>
 <CAJfpegt7hj=WDKKASjWLVG-R2tGYUKMJ1qR0iv_Y+GaYS0mW4w@mail.gmail.com>
 <CAOQ4uxgoavKU6zNMN9YF5cchvux6CGGxd56BBOJFWX0gkVAChg@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <CAOQ4uxgoavKU6zNMN9YF5cchvux6CGGxd56BBOJFWX0gkVAChg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/12/26 15:08, Amir Goldstein wrote:
> On Tue, May 12, 2026 at 10:18 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>>
>>> I see no reason for fusex to not support lookup by ".", which is
>>> anyway needed for "reconnect", so a fresh FUSEX_NFS_EXPORT opt-in
>>> for "re-export to NFS" may make more sense.
>>
>> Why add reconnect?  If server supports persistent file handles, and
>> all req's get the file handle, then no state (nodeid) needs to be
>> stored by the server.
>>
> 
> Yes, we are saying the same thing.
> What I am saying is that legacy fuse has FUSE_EXPORT_SUPPORT
> which means server supports lookup of "." which libfuse always enabled
> and then we added FUSE_NO_EXPORT_SUPPORT to opt-out of nfs export.
> 
> I am saying that in FUSEX, lookup "." support is implied.
> And that nfs export should always be opt-in (FUSEX_NFS_EXPORT).

I'm confused here, why do we need lookup of "." without NFS export? And
which file system actually supports lookup of "."?
Shouldn't all that be scratched in favor of LOOKUP_HANDLE?

Thanks,
Bernd
