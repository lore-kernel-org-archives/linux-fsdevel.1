Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC1A3CA49A;
	Mon, 14 Sep 2026 23:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789429972; cv=none; b=taR5hpRmwud84cSq1jVZJcMt1pejW8ch+ndfYwg1ZINtpN+/aBiTtRWLb9e4MIOFbPOVn8pJSUqQ71B0ZUPf15TL5UeCt+fx15GYgwIn70agcjIVy208INei/yFp6NwVcQSwNtyWle0irObvb7UMGuWMpc0mUVGpSypl4M+/0gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789429972; c=relaxed/simple;
	bh=PPqmxAeyXc9gSdooeNiojJ0Q23kLq+8wldcRrjNz+ZI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=E5Qf6SN5XknEvmcr1g3fMt03M2N5ZGf6L/Fn9ZA4i0PN/SA7eCx63G4GDVJvFxvOCpEvLh3oV3FHA0ythsn+3FAjkmxrEr2fxmuMi1K9fkCAgtNT5BmIz9pQP33XbJFbIPeUYTOgcUKUPUIBJ+6HQcs594o6HFDTU3X7AS4jOyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=OK81/Yx7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lU5nvoYW; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="OK81/Yx7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lU5nvoYW"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 757BD1D00073;
	Mon, 14 Sep 2026 19:52:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 14 Sep 2026 19:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1789429970; x=1789516370; bh=o944dJYBZQA5c3a1lpusZvxs1ErBpVPtt4z
	gaYD4Pj0=; b=OK81/Yx7lBYFNKoWFzw3kOwVRa395ilFdvWoekunXeRw4P1d7qH
	rXmnwpmIy6T3CGxYIlweLqKc9p+MvQrEzN96Avw274GRJ5YLGTLZJGregxuiSSAE
	AgIg5u7uo3EsG1AL7XGj34eu8Ho7Ym+ZSbj79Phy1F43sKc8dVMpWRSZLZLq8FGj
	Y6OXH1muMtR6nLf6yqqZkqIBQCmEVVwdjJj8+dfQLLZx9xgSAXiPQx1YaF07pj0N
	zmS1xC9B9B7DhVWqebHIn7wfmb4gnQsyCC9IqYfTC372lkEQ6jkHjudE4fbn+Q1o
	E9a55/VZ8Wi5au2pIxi3blL0qSQM5SmxpOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789429970; x=
	1789516370; bh=o944dJYBZQA5c3a1lpusZvxs1ErBpVPtt4zgaYD4Pj0=; b=l
	U5nvoYWzYO5HAt2JfGPXvGNMe0umKGOw18NWB6CepB1xU0bgSDQqg1YSzS9lvffG
	pJsgHrkkRbYdSJicxHIjBu8Fj4HBLhwCmTuuCW7etIf0tUaFnUCwqwh/FcNk8EoU
	dTnKDMDHMQhEZSg/G3leoHdWOik8wC3g1mCjCR7+4JUc4Tu9mTg2+pJF51xXMh2M
	F0fXKn7O1iJAqHX0UiqyywgXiYN2GAVz1YeZE4D3FLo9ALYIPaA832a3ktBX7Lut
	eCQtD4+mq2r5AR2EELuCXqvV2L2RVioJvA2Apf6Bx6MKl294J2vyPFT60ntV5J74
	V0GSzccKdiDH8/aulRH/g==
X-ME-Sender: <xms:0oioagq9dabQpK3RwvhPCVFMqQHuId0ea63Vp_D5cOPNED1nc7RQdw>
    <xme:0oioao59_pelnM7fd37KXYyOm54fuFg4bRM1q_nSanfAIhui2WA2glZKsBPspRaIV
    7sTv-xlkRRKI38zZmoEh0MyGKQeQyzoRUj3DWXQ48DfihVGbi8>
X-ME-Received: <xmr:0oioanflVCpRbcGKGjX_JrFIJBAd86q1qUvc6sbZJyxK1uFFzs7VpN-JsJ2LxJ86nlY_F6EouVNgtKNpBcEzFrGuqBEyN0s>
X-ME-Proxy-Cause: dmFkZTEp/wQeYxOj9YCgyriKxwDB8cDZxr1mz9ivC4G1HaF+RRw6Gt4iPLxUDP/fteVMxF
    o/R4Fms46dqPIZZs5xrahihdJjRvK+Dz8xDmWAprd62w/9PCm5u2xt1GhmQDUN4qsyvzbk
    hWgSM+rctHToDZDoUK5T4IYd2d/L8VrzPco2AFDdXpwMRMdY4Z8AS2xhwTRtHhFgmmG8zd
    hODpDWnx2var+aVfDkmroObh2lg28nlhq/PyvHBJK1MNIfLi77M8ow6vWOIp6YF00krIov
    IfU/AMtDG2DSd4l+CejNS9r6Xgwd2CblO85TsQ660QZ2iFxKVvToFPP7FwHhR0nm4PmFk0
    8Gk7cMrf5MX2FbnJcFG3H/OCsQ3/WO6WUen2SvHIqnUV080AXWFpQaRbrTQF0NqvhHkwJS
    VbOjIY/+aDb26GJK8ZKw2m24/nA665yuo+wsrACps7mKjUOOneOBFy3qh/MWpW0G6Q95qE
    0pLT8oV1bSmiuBc6ztxJMQcllpTWJ6vz4f12hVTAw8+UYfenGrJoUF7oxBfErt8/9jZ3JO
    HqoJN3xJWj/jX1IiIbEBev5UIYzz6VPrOiUwgeJQHKJoI0QTtS673ZQt/nmbCoMd+GLAny
    IZp1KnQuNSBTjTIN7ufSADFc6lzmxslJuOC1U66OyHJcQbSJ4+xHGenC1s6g
X-ME-Proxy: <xmx:0oioat4LspaNsBUOMGaXddgby-zQEbbIfpzJ6toinsT0VjyoGFntxA>
    <xmx:0oioautV1dyen6qHP3-ifvf-T7mT435VLMgBB6BqprlU3TqWm0BIGA>
    <xmx:0oioatgW-ALobjDJmyF22DLKoEgEkSXonXhHPE_9UhmNcc2CYyodjw>
    <xmx:0oioapolIvvh7kXMfgv9QG-Y4BE7L92NZxHNSC77uLc_xBfogNkSrA>
    <xmx:0oioanD8Pqi1M6hAc0vGUJ3M5J3qVJa8fo6fE1gbbHiMlgFdCSpcKLsM>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Sep 2026 19:52:47 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Mateusz Guzik" <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Mateusz Guzik" <mjguzik@gmail.com>
Subject: Re: [PATCH 03/10] fs: use path_clone() in path_init()
In-reply-to: <20260913144918.1606123-4-mjguzik@gmail.com>
References: <20260913144918.1606123-1-mjguzik@gmail.com>
  <20260913144918.1606123-4-mjguzik@gmail.com>
Date: Tue, 15 Sep 2026 09:52:46 +1000
Message-id: <178942996601.207413.10112030781484547857@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Mon, 14 Sep 2026, Mateusz Guzik wrote:
> No functional changes.
>=20
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>  fs/namei.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/namei.c b/fs/namei.c
> index c8754c7ba8be..11937cfa8c7f 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2745,13 +2745,13 @@ static const char *path_init(struct nameidata *nd, =
unsigned flags)
>  		struct inode *inode =3D root->d_inode;
>  		if (*s && unlikely(!d_can_lookup(root)))
>  			return ERR_PTR(-ENOTDIR);
> -		nd->path =3D nd->root;
>  		nd->inode =3D inode;
>  		if (flags & LOOKUP_RCU) {
> +			nd->path =3D nd->root;
>  			nd->seq =3D read_seqcount_begin(&nd->path.dentry->d_seq);
>  			nd->root_seq =3D nd->seq;
>  		} else {
> -			path_get(&nd->path);
> +			path_clone(&nd->root, &nd->path);

If path_clone() we inline, the compiler possibly detect that both
branches of this if had the same assignment, and could move it before
the "if", restoring code size.

But I think the code does look a bit nicer this way.

NeilBrown


>  		}
>  		return s;
>  	}
> @@ -2801,23 +2801,23 @@ static const char *path_init(struct nameidata *nd, =
unsigned flags)
>  		if (*s && unlikely(!d_can_lookup(dentry)))
>  			return ERR_PTR(-ENOTDIR);
> =20
> -		nd->path =3D fd_file(f)->f_path;
>  		if (flags & LOOKUP_RCU) {
> +			nd->path =3D fd_file(f)->f_path;
>  			nd->inode =3D nd->path.dentry->d_inode;
>  			nd->seq =3D read_seqcount_begin(&nd->path.dentry->d_seq);
>  		} else {
> -			path_get(&nd->path);
> +			path_clone(&fd_file(f)->f_path, &nd->path);
>  			nd->inode =3D nd->path.dentry->d_inode;
>  		}
>  	}
> =20
>  	/* For scoped-lookups we need to set the root to the dirfd as well. */
>  	if (unlikely(flags & LOOKUP_IS_SCOPED)) {
> -		nd->root =3D nd->path;
>  		if (flags & LOOKUP_RCU) {
> +			nd->root =3D nd->path;
>  			nd->root_seq =3D nd->seq;
>  		} else {
> -			path_get(&nd->root);
> +			path_clone(&nd->path, &nd->root);
>  			nd->state |=3D ND_ROOT_GRABBED;
>  		}
>  	}
> --=20
> 2.53.0
>=20
>=20
>=20

