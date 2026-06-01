Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978CF13D51E;
	Mon,  1 Jun 2026 02:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780279802; cv=none; b=D5ksUUaRgr2B+b3dBEdWcz8JhxKwJnCsNagmj9S9cuaAeFX2xuPcck4UXl+vwTy3tAuZDPPfDRXbgBhI5Lcepa2UXBDuWf/9wtIqZFU5aTTidNsSTcarawvkJpUtKkxS9a8ACbXyAaskmkZkU0gSJE+9632vOYL5+wuImaAQ5c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780279802; c=relaxed/simple;
	bh=8rwiN+OUP0Eg5TvzN3ecW65ywr8EZNtvIAZcFPQ081U=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=G0SipbfxiP/cMQixEBFk5N1sZ2w1GdbR9Qrzqh/Cu7ENOJ4Hq9/e/vY3UY2Kz0BN1JZvVyFhnWnetsBX7zMH5qXTvQVIqchhsWeFcsfeMUHrsXxG8+uFs8GKGY+6MOvrVtys8Azm5XP2qF4VkcdlGbJ/LB1rIcSNx6WT6jejShU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=KCCZo4Fn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q+IgCyLH; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="KCCZo4Fn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q+IgCyLH"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 477CC1D0016E;
	Sun, 31 May 2026 22:09:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sun, 31 May 2026 22:09:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1780279798; x=1780366198; bh=qvxnqwf4UifI+LQ3v+BCO7M2QwLlydH+REb
	VyeK9NEg=; b=KCCZo4FnNEhMHerfGxPZpwNVMErXCk4zXay0+6Dhx6DMM7xqyl3
	6W1hXOBHASQCfo0P+UPuamhYxjgDLpNE4Qh7DpNBTXic6CoZC+ruL5S9+NEeNT3B
	UCFYf8zH3VrZreIDL+n2o+SuVrfDQ6PPURbsRZsJQSk+9ni6a0kL4/RbnUviCtV3
	JIXMYOuzBowULGt7kW7yVfcX9GWd7rijbpOSN8y53QqW6R+l0bYRpbwLjNwIYODQ
	AL0hmydC/Dm400+eKPcUOp9Azmn5CTzEtMAaFMSTMHXxSf5B2CncIb8Mxg6DqWUG
	D/eQGg+OcO5vSaVB/UQp4vYukIn+nkN1WFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1780279798; x=
	1780366198; bh=qvxnqwf4UifI+LQ3v+BCO7M2QwLlydH+REbVyeK9NEg=; b=q
	+IgCyLHL97EpvTLnK+Nd5mGWTCOe812bJHI6dAG3OoYD29d9SFxDRrn23ffM0b1e
	6clkGtNJMz0mc4+EhX04VlMw09dI6KFpbxpBrB/8oURtn5PSoBuDr2dabnv19egZ
	Wn0cUEx2hV6B/E1d9HRb8DYmr1tNAZVC/0v0hidUcAWUjuWstPkOroTiuEnuAmLG
	3TD5y5VQ2PxFuNEoHwyPGZ3oYh0THMuY1td9byMWA0SxJE4hVY9qjPdTeoi9bb/P
	bJ7Dhjc8lBHLAYFYLvMpxdHOuQodbitslWXraXumjXfWjO9zAaONi0ljDk59HHRp
	7mG6f9Fwf0EXR6rxBlEQQ==
X-ME-Sender: <xms:9ukcaivyJGyEZDKKtycPuXOWfGxaIbfHG_cFMSrAbysNTkz0KAlA8w>
    <xme:9ukcavrOY4mKi-g-_QddZmsgsk5vzumiYcK4UHF7qNtJhS7XXfgQWR7bzxqi7gM6F
    f8t1zH0IZgNC5G88Af43TJVIXhO9s1ZIqLz4PWiQyRiUFtSbao>
X-ME-Received: <xmr:9ukcapV-Zk9I4niIAHsHdyGe3V-psOEqjvBRgl5q9cRSjEte97QqBGTHFrlqXaWylH_kDCndL7eTjmUbRWb-AqUOu4ukqnE>
X-ME-Proxy-Cause: dmFkZTFtPJjajOHYkxtbpmwrc593mBdNxXqYqWoGjd2pt1HSQkuIZP9u0IuYOa6+owAHzp
    /plzgH0fpAsOYXvTQIkWTZ6T2yqx6yJQp84mQiksEslTsULVlZYKQtZa0gbP8REnAv63rB
    YL0pmVrevLClRLM/XOheTaW6QaEnjkwd8M2WkNUzN7omYf5RHlrp4sxNteLJoblgbH/soB
    jUWMQZf9IAxiW3gMC24a+RAf+YN2mlE67u8D+AXSGOQrOiiFVD+6HS060TYPAVU+DEpASz
    J7EOnAzeUvvDKLG7viJ1Ut8l0h0EkQiYWZaGnhmmQmFsC1z/fKtLMboGf2wBQeiRFcFgHR
    0hGGjv12ilTB5V55VE5xvKEVaW2d6W9roJZ8aRcBsbUpr3nM2I2IXMIchJW/Ri+dBNWVA5
    E4ogRB9hFa0D0yAyJW102GBnpikRENTYBAr4T+40VYtPQwFHU/SQN818VPoqKqw9P4RQrw
    8Ac6cOwOYACIao0hVdWi9c7kkfLathSkXZJ/T4XZIpll601Z2FuVfpjFDpXed48xxYpl2z
    Zzwr80gia688nAUtoV8R12PVdy+ZRTtNHlor46tTJVUoSmijrwrXRUGcBcvOYNjrXEGxV9
    J9rCGtuXL0mXeZGR36Vso/TO13DCvoSNl2vfGmRCB4rYTaWW8DUU2tAD2Z0Q
X-ME-Proxy: <xmx:9ukcan1JMi4sFlaW3obl1uDcphrz0juy90BYdWXgqdPnrie0i34l2g>
    <xmx:9ukcauvb-fWbMgW0b8P8olJfuIZGsjQM9L1rS4061F1LPkrF0WAdpA>
    <xmx:9ukcavWXgLRgtyHZYd86kCGFgXHnjBY4XuwtOm1PBfSrgMLJwPrUIA>
    <xmx:9ukcamzs7b48ihdf3asf_8DdXhWQOk9P6VnijT-4L1fZ6_Mj3EGkiQ>
    <xmx:9ukcaj32LIXzsqriuKQgiUu9xX-HloQwl94rMWTRASZBq3Ow9MRprSBh>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 31 May 2026 22:09:55 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jori Koolstra" <jkoolstra@xs4all.nl>
Cc: "Al Viro" <viro@zeniv.linux.org.uk>, "Aleksa Sarai" <cyphar@cyphar.com>,
 "Christian Brauner" <brauner@kernel.org>,
 "Jori Koolstra" <jkoolstra@xs4all.nl>, "Jan Kara" <jack@suse.cz>,
 "Jeff Layton" <jlayton@kernel.org>, "Mateusz Guzik" <mjguzik@gmail.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Charles Mirabile" <cmirabil@redhat.com>
Subject:
 Re: [RFC PATCH v6 1/9] fs/namei.c: make lookup_last() use trailing_slashes()
In-reply-to: <20260531182045.171711-2-jkoolstra@xs4all.nl>
References: <20260531182045.171711-1-jkoolstra@xs4all.nl>
  <20260531182045.171711-2-jkoolstra@xs4all.nl>
Date: Mon, 01 Jun 2026 12:09:52 +1000
Message-id: <178027979241.2923901.12962660679778862180@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Mon, 01 Jun 2026, Jori Koolstra wrote:
> Small cleanup to use the existing trailing_slashes() function in
> lookup_last().

I think this is good and useful but could be better.
There are 5 other places in namei.c where trailing_slashes() could be
used to replace the same test.  Let's do them all at once.

Thanks,
NeilBrown


>=20
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  fs/namei.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/namei.c b/fs/namei.c
> index c7fac83c9a85..137d9fffbe80 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2777,9 +2777,14 @@ static const char *path_init(struct nameidata *nd, u=
nsigned flags)
>  	return s;
>  }
> =20
> +static inline bool trailing_slashes(struct nameidata *nd)
> +{
> +	return (bool)nd->last.name[nd->last.len];
> +}
> +
>  static inline const char *lookup_last(struct nameidata *nd)
>  {
> -	if (nd->last_type =3D=3D LAST_NORM && nd->last.name[nd->last.len])
> +	if (nd->last_type =3D=3D LAST_NORM && trailing_slashes(nd))
>  		nd->flags |=3D LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
> =20
>  	return walk_component(nd, WALK_TRAILING);
> @@ -4524,11 +4529,6 @@ static struct dentry *lookup_open(struct nameidata *=
nd, struct file *file,
>  	return ERR_PTR(error);
>  }
> =20
> -static inline bool trailing_slashes(struct nameidata *nd)
> -{
> -	return (bool)nd->last.name[nd->last.len];
> -}
> -
>  static struct dentry *lookup_fast_for_open(struct nameidata *nd, int open_=
flag)
>  {
>  	struct dentry *dentry;
>=20
> base-commit: 174914ea551314c52a61713b9c4bde9e42d48073
> --=20
> 2.54.0
>=20
>=20

