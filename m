Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E799420E702
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 08:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777971341; cv=none; b=s0xOEMRoP3kBt8byYvK4OF0SSLpxgDsqH9td0Nd5r77GteMLvqNSRpYzznD4SdbWqlHmZ3ptdlXXwWIVgdabvs0ly6PQmrRo/nxAqtNY2ofEgJFiS9x+ukJvQH4jXPoxz4mvCLVx9p1QIaniu3t1htlXrUijD34z6r/pjPOO6kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777971341; c=relaxed/simple;
	bh=KqEbeWBlci6AFpbR+05BQN8ruCmBgZ5592wjY5kDt2o=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ggjGsE+JcEmY5Qa2KV5G9/YRThlghogIfAyeCOS8Zfn8VfJPzJbt3uBEYHBXS6RYwrNZILMP9p6YEFwTnEk7P/heyL0XwTxdNRUL0l0XzirQ0DLfH8SRQCozp2h7QuZzoFzxSrxFPL9YhC2IdK//IWDjyF5ZzuMfVJE1NRYfTkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=o7WXrgtS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NOKsodCA; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="o7WXrgtS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NOKsodCA"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1F6F87A0097;
	Tue,  5 May 2026 04:55:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 05 May 2026 04:55:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1777971338; x=1778057738; bh=Nrwuo/+nYfvvkFdN9r0lVAZqHDvFKDhxxjP
	siSToe70=; b=o7WXrgtSXap1ck/96zT5a/6p/38PvgsSvImGu7cibp4T8JgaZUs
	X5RPkOGHhmGA63+1tAl6cYFFM3ZnBzDLI6PLuy94b0k0cu95u8cegcsiS4ephhi4
	7nFFJo2J9UCwxR11GYHwGC8nE3dysitXHALCxVftMrxJdCyzBJpAv7UikKczkEHj
	P1Et5dpKj4c75t3u/RxsDWinyPLCh21oetUwQjjJyF2O6EhKX9NuhbPYxp/qSOjP
	hscJkfuBEgR96JOvyPvUUmB9+NlW7FWpvrHYZEGQPIOv/kxbh/uSYyNkrLTzc7qO
	gL+i1vivgGvjQ29fc3IWk1Cyc7OlkeH6VNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1777971338; x=
	1778057738; bh=Nrwuo/+nYfvvkFdN9r0lVAZqHDvFKDhxxjPsiSToe70=; b=N
	OKsodCAbsamJLPBcCcCwxhOZ9BfJmKBKNeVI5pNkhGkjCHs+yd/Yn/5OjyXi0EGL
	bLQ5XKZDNjBQFb3OT3yUDIi2jeUSAfes5HnBR5+wTHXu7tvwmVvl7EyO4peMhSoG
	QG+KmBTFAR1wJAbdz6+aDdTumQx+fTp00m9e+U9TyVl4wwmqWP93RP8YvWwyn4fp
	DcGHDOgtx/40qb6WyztYl48z1dfHc5VgdNxkJCRNCHqcRDhZ5q+36W30UFXjCagm
	KqxKAQAR//Hy3r9q6s7xv2gJqsUyClm1LgxKsKMoM8tdpVSd8gn7pmKi1NezKD38
	r8wULbnt/bzysMpIMIN9Q==
X-ME-Sender: <xms:irD5adCvi-1KUVqNYKQlrMdjXI1ApYS0MIhAu0vDZKc7xVz2YTUUnw>
    <xme:irD5aUcVKxz4mIwOI0kvESDA9pfcazLGRA0dFj3ovMo3Y-gjJxgt1WOxM_4KVtjLK
    BdzNZLEGMN1BD6OxRO3rvxlwIX2-VN6WAM4aiE1entam33b>
X-ME-Received: <xmr:irD5aUIhIzka7wazAaTzPNLMksOHdp8YyI9iSZSOeQ1671xKsFJgEOnXn0p7xAjfykilqlM9KkIFNNcZ78xxoXUMRvibPuU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdduvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprh
    gtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepthhorhhvrghlug
    hssehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegsrhgruhhn
    vghrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:irD5aX22H8A6-LjgvTRPqRsROPXI9tpTmKT58th57gse41NbNy7gFg>
    <xmx:irD5aehbdDWEmMxUzi2Iy5yTE1jO1V7HVD6nsRgnLqvwa5RcPgLOQg>
    <xmx:irD5aYUB6xrVNg-KKdJXFwYUrFOco2ClqDhPaBaYabWZxtcUPBJucA>
    <xmx:irD5adXyfryIOwmQvZ2ku3El1lTgNyBe0tuYtd5uY_IwCzM3Kqlr_A>
    <xmx:irD5aSRi5AikivYmkQ8qXdBOWPhBBVSdhxL32TKDe3a4W16uFJYH4MWW>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 May 2026 04:55:36 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 linux-fsdevel@vger.kernel.org, "Christian Brauner" <brauner@kernel.org>,
 "Jan Kara" <jack@suse.cz>
Subject: Re: [RFC PATCH 12/25] reducing rcu_read_lock() scopes in dput and
 friends, step 1
In-reply-to: <20260505055412.1261144-13-viro@zeniv.linux.org.uk>
References: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
  <20260505055412.1261144-13-viro@zeniv.linux.org.uk>
Date: Tue, 05 May 2026 18:55:33 +1000
Message-id: <177797133377.1474915.1770170197135589795@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 05 May 2026, Al Viro wrote:
> rcu_read_lock() scopes in dentry eviction machinery are too wide;
> worse, quite a few of the function involved are not neutral wrt
> that, making them harder to reason about.
>=20
> rcu_read_lock() scope is not the only thing establishing an
> RCU read-side critical area - spin_lock scope does the same and
> they can be mixed - the sequence

Does it?  I can't find any document or code which supports that clain.
Could you provide a pointer?

Thanks,
NeilBrown


> 	rcu_read_lock()
> 	...
> 	spin_lock()
> 	...
> 	rcu_read_unlock()
> 	...
> 	rcu_read_lock()
> 	...
> 	spun_unlock()
> 	...
> 	rcu_read_unlock()
> is an unbroken RCU read-side critical area.
>=20
> Use of that observation allows to shrink rcu_read_lock() scopes;
> it's too delicate to do that in a single step, so we'll split that
> into several commits.
>=20
> This one breaks rcu_read_lock() scopes in front of shrink_kill() call
> in shrink_dentry_list() and finish_dput() call in dput(); in both
> places we are withing ->d_lock scope, so doing that won't change
> the RCU read-side critical areas.
>=20
> With that done, we have all calls of shrink_kill() and finish_dput()
> immediately preceded by rcu_read_lock(); next step will use that.
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/dcache.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 7cf965f9fb29..d690c18f0c33 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -978,6 +978,8 @@ void dput(struct dentry *dentry)
>  		rcu_read_unlock();
>  		return;
>  	}
> +	rcu_read_unlock();
> +	rcu_read_lock();
>  	finish_dput(dentry);
>  }
>  EXPORT_SYMBOL(dput);
> @@ -1682,6 +1684,8 @@ static void shrink_dcache_tree(struct dentry *parent,=
 bool for_umount)
>  				wait_for_completion(&wait.completion);
>  				continue;
>  			}
> +			rcu_read_unlock();
> +			rcu_read_lock();
>  			shrink_kill(v);
>  		}
>  		if (!list_empty(&data.dispose))
> --=20
> 2.47.3
>=20
>=20

