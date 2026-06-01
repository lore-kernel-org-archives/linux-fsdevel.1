Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84F78C1F;
	Mon,  1 Jun 2026 02:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780280220; cv=none; b=i9d1Ej1GxHskKcxLBrDQyJclafQQFqI42S9aNE40ZtpJvqzluBC4gtBcDWNt7NQy8tgGxXop1YlJvAQQiCDW0ZFUvmI4Gy3ZFKpUYvp4iQaZxm1UUFu4n5oQpgAj/KYe1BID0ki4RYfn1wi0sNOH4p4vWSoetXMxsuBc91wOWsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780280220; c=relaxed/simple;
	bh=PRQk05QuCpAO16cW5k1DHwB2qIJ7UxKevpTQhIG932Q=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Hf0DwNuzEnvvHX4kyICJqerGiZF/Si+b+v2rOL8Q7G43hVH033OGCApKI9TUGySGFyDkyQiLhc3Fu0ZRJ8Bc9mDmMJQkoUdqrwyqGEeugJNY9Y1bpjNZ9cwHTt1B5hC1hwSk2LnoDDQBk6I0lK3ueQoyYH93bILu/SrhemSYX7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=mmocPz2+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gqjxm6i9; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="mmocPz2+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gqjxm6i9"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D9DF57A019D;
	Sun, 31 May 2026 22:16:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 31 May 2026 22:16:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1780280217; x=1780366617; bh=yxsc69bfu8cwLVxrRuGEQ2OfEoEWXBS53jf
	UcLZ7L8w=; b=mmocPz2+5oO0DOAwgQJWMbzu9el3jnGZLbEJP3zjasIzmgpxkfM
	VUUwadPMTfEpP1vP0PdS/MBu7YyrtbTVGwQMHr2chF+3P0D0F7IgTx6Ot7PEvN4F
	7/FMNwrHTw11hFK8Hm54rBc6cU6tIEI6wrz2RnyMpxU/Zk60t3L/MD2NRkIfjPBE
	YpG7rGsJ0VRYx0Cs6TsOfKNbgg1VzPYwJMXaRW696PjHO/r8n6k3VEwC6zyP3gE/
	JRpqvfTE7Ptqg40IIaAhgSO6tT/sMozprbKi1pfFUcP3ebpsg+Keb4v4bfeZqfQo
	Ed/hWhcmsmPkI7c3jFPbUsSpfxbUWi5YEuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1780280217; x=
	1780366617; bh=yxsc69bfu8cwLVxrRuGEQ2OfEoEWXBS53jfUcLZ7L8w=; b=G
	qjxm6i90+ZjqITAOrqKujJ4doZir7Kg6nPQmwZUqIgLy8rZhJZzc9SPvegmQd7rM
	MwOgJEwC4sxJ7G5APAusETcG1qYr77agq340bMhi4vOgrXUmSyxEps+9D4NrlOHT
	nnhyOd6tGr5g5UuAFuHQIZPqQgu7qkTzmka8GEyBlb3kfqWH7qe6XvTHzwr+p4P7
	Cz75LYwR/ywDq48H2zYFA9mm0tIy3gnlGb3pKp5ouoaiFLLyvpP+gGq7ipbpq8wL
	WMiWd0mi9oTuq4TcIw4/NC28rMmQ0DPeKHw6gX3sFIj7mA0HjLkm5FoSdvq0ezne
	jR3/ZLL/LQIbzwLRdRl3A==
X-ME-Sender: <xms:mescag2CcPmLH0uvnB-rsLyxVV8bMjoxX6nvTxUyPC_GuD1PSiuCCA>
    <xme:mescajQeLTYBxzbOEKK0KjEHHXVoyYKRSngaBA7WvKi8tUYSDayFio7piB-_vczFA
    whsNR9qx369IumbxJSmWIMyz9CEa9Qmj_jiSl9En3sBe_nKHQ>
X-ME-Received: <xmr:mescakdWwxOoqBbK6WGyimLuI4cEgozKw7IwTIgo8zs57D3gqTCwZCBDJz2pmGVrtWTDXehg8sAQcsF_keJNouteFuAw7Ow>
X-ME-Proxy-Cause: dmFkZTFWI4tdiVE6FvW4O0zdNae+tfNARZNnoBkxJ6eQqyqHO4YGD5H3SmLWMpSKcAIXvA
    dE3MIjI2gM9Jk3X0I41ZuVYDuMbRh1sDUARejpCOtInO7MAf728pVjhNQ1xfMv9W55eI3l
    VzKcVTARaas7G9+qR6tG2YMty3YhSu1+7Z5+QXUQ1oOpZSuB/ZAM/oz1MvC01WwrQaG6pc
    mFEU8XRQ0CdmvQh/c/jGAlByrj7TZfkSXwR6ISITLp7213MgwNejUTMCG22Y4B75KztQec
    0piHIieZ6WhHvPvp0Kco0cVih1lqyBv+HFJdqyXbDbZe6GnORrXtjr2xlJ/5AsENe9RujS
    lYJ+7Se6cQJDqaRZjtdUUUFMM5nVnEKftpSJzJLQYVrZi4/UmlJrwetMNK9WC1o2IGlbAg
    ma5sTqFLEGFb0AEra1XJu2WgSG2GpVGYmfIX2SGtP8UIZE0z4WMcBq5XI7JG0bBRk0XK7o
    uFnA5INRqXiT0iUeoLwXraGDiPrZnHWUNjoCsvUfpJm2OmzjBbx5y09ZsIm+I2mQvetWBw
    rTc+AUZ1/MRNQfgx2s5IY+HsnRnN3ROL133VUpUBZYo4fb9sdX2E8HVSXn3mIXxsQ7tHte
    p71nRnyVPCMkLJihgtjE3bKzBVr3XmvoEEw9Yi3y7E1F6tTfiPBTiga/6/9g
X-ME-Proxy: <xmx:mescakcMnGdv5yTujUmTQPRA4QGpAv0gdwWh8W_WlQ2_OBhjCfHTOw>
    <xmx:mescau1HOyv_oHEoHRFo9QkGOC_p1dr0UiX-ssO70RK3EyOJsZ1eww>
    <xmx:mescas9gPXaRV90TSU-__nZfRhM94-pLJwiPTwhuzdBJIobKpk15Vw>
    <xmx:mescaj5Nuw0vxEx_rE1_kWfZiPy9HrC5Mqr1r3hxPoi1X469PcXXNg>
    <xmx:mescao9za2ewq38J_LmgOH8BKgp0ICfzXAlaScX3JXw6wNDuIgHAVhgK>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 31 May 2026 22:16:54 -0400 (EDT)
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
Subject: Re: [RFC PATCH v6 2/9] fs/namei.c: move create error && negative
 dentry case in lookup_open up
In-reply-to: <20260531182045.171711-3-jkoolstra@xs4all.nl>
References: <20260531182045.171711-1-jkoolstra@xs4all.nl>
  <20260531182045.171711-3-jkoolstra@xs4all.nl>
Date: Mon, 01 Jun 2026 12:16:52 +1000
Message-id: <178028021247.2923901.4938449009208472585@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Mon, 01 Jun 2026, Jori Koolstra wrote:
> O_CREAT is stripped when create_error is set in lookup_open(), so when
> lookup does not return an inode, the case
>=20
> 	if (!dentry->d_inode && (open_flag & O_CREAT))
>=20
> is always skipped. We can get rid of this cognitive step by handling the
> error case first.

So you are moving an if() statement which can only do anything if
create_error is set (so O_CREAT is clear) before an if statement that
code only do anything if O_CREAT is set (so create_error must be clear)
and either statement changes either create_error or O_CREAT (in
open_flag).
So that must be safe, and I agree that it improves clarity of the code.

Reviewed-by: NeilBrown <neil@brown.name>

Thanks,
NeilBrown


>=20
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  fs/namei.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/namei.c b/fs/namei.c
> index 137d9fffbe80..4cd132fe3981 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4499,6 +4499,11 @@ static struct dentry *lookup_open(struct nameidata *=
nd, struct file *file,
>  		}
>  	}
> =20
> +	if (unlikely(create_error) && !dentry->d_inode) {
> +		error =3D create_error;
> +		goto out_dput;
> +	}
> +
>  	/* Negative dentry, just create the file */
>  	if (!dentry->d_inode && (open_flag & O_CREAT)) {
>  		/* but break the directory lease first! */
> @@ -4518,10 +4523,7 @@ static struct dentry *lookup_open(struct nameidata *=
nd, struct file *file,
>  		if (error)
>  			goto out_dput;
>  	}
> -	if (unlikely(create_error) && !dentry->d_inode) {
> -		error =3D create_error;
> -		goto out_dput;
> -	}
> +
>  	return dentry;
> =20
>  out_dput:
> --=20
> 2.54.0
>=20
>=20

