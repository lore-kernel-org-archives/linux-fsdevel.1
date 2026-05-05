Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE8C2877E5
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 08:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777969324; cv=none; b=CRJMAhFpRt3yO1zatyDtiSXajwXAavPcjCkwjNZtZSwmuTsKekh31azFMUCohMG/KtnFVhnplqcxoXkzEmLoER/5lIKuXTgVIPT5nmDJJIm2wdYUnyQ+DpP2CPIw23CsXLtHZ5pPDo+UIlPs/IX3gP2KgPRQwgycA8QUJO3tThw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777969324; c=relaxed/simple;
	bh=ONqfPdRu6BtGHqoFnfxSOF/dZMMyqwjtx+iFglG3Cv8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=i49C2IXH1WG+BX58Lc61rWM0ld04gmZgCwoXha8JPJLqqBzDn29YGjqGvtOxKSdUf8owzY6iVOE1op7EIOGDERfq+5tVPbgOKFAqPj1Ex1eRcXPJFpYAw1BfXqkspRAWP0pZgBk5T4dyGEyi6Ed3Sq8YfDP6zKjFCL3d5hfCbA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=NkGcYmXa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VwQQwDcV; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="NkGcYmXa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VwQQwDcV"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5DDDB7A0039;
	Tue,  5 May 2026 04:22:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 05 May 2026 04:22:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1777969321; x=1778055721; bh=A9MsunxMmbcSYuRxyGEAuip6Aw5mh7EszGr
	rDhtPWXE=; b=NkGcYmXahnsxUbRpt9otcfhLl2P3QYqdG+iT5Sc4fa8zj7OKefl
	05TVtCCexJ7M4pHU+lvqJni+v0NfxeBMBYxgs7ltpJussTWUV7dYPU+IWa241bPe
	/wzebf/IGwfN6tdDnaVaVvE9pWmEP28WXIhUWDgQkfJu94id/rO2DPF4ZwIx7CMp
	LikMazEK1Z6Ptgm5Yb5UFHnAfOdPRdHK94vgLmXlIluQl2c71OJ2R9Qe2gn9iVPR
	DciF19C8fjegzGHBOAk97yp5D86mO4d2GLru/7MjUZEjA2uTPi9xFIi7/pk+rZFb
	nOiyz9bVVWuselLZ9NPAYlZn5xe4jFq2d8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1777969321; x=
	1778055721; bh=A9MsunxMmbcSYuRxyGEAuip6Aw5mh7EszGrrDhtPWXE=; b=V
	wQQwDcVVeFYkAFSRFkY/oZkVfjjWrd31dYuCt+LSrWI9RJ8qxCyL3NCNkQofWMFr
	xr4uHpr+1HhKOaT4b6VPpCHdij/JcFy5mosSGYOPs/4T034hHijVmwBGVcS0Wiyw
	NIxerA3UV5obxNmtTQEN+Bvx3Ghgt2HLvqUeCCKIJXXbZxaAaEnJs1k5MBPoquW6
	LaTZpiGdYtOOQxn9RAsFr6Dx1KTQ6sy/NmcNpRchHJn/G3HCkRmuZKeedqOJCm/d
	gTlvn4LDp2h2+UKU67F4H9xo+NhffqSkzUdRhHDoCvClmMFAd0CU24ivUm55Zy4x
	ttLTcwSWcTNCcbZMs7n4Q==
X-ME-Sender: <xms:qKj5ace5-oLNazZeHJ4pgK6m5-4u_T2Xr1FYgLIVTzw3KxCwCi4CfQ>
    <xme:qKj5aXI9GuFE-W3ZL8-oFZKH_e35tECW6cWO7x5YHjGx1Nr5vYLupHpHkKg9e1BWt
    hSlfY9Y28FwjwOcmfR5qRb9O8FwpUk4lU7SVlL5izffntxlwA>
X-ME-Received: <xmr:qKj5aZHdsUJop8tSIgAABPTnJ8_r9bakOdCxojMtt2yu-A-gYp6aF7lot9tQ2HYHwwWoGrAYcwrqIgOiyuD-FaOb2U-ejrY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdduvddvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:qKj5aSDe6CmAAVxBGOA2WdrTK3j1q1mcHKFJyanf_OtgKkNC3-NQiQ>
    <xmx:qKj5aU-u-t2_X7PNyUL61s60LUiltZt6YmiODkYGRe3OzffNVx8orw>
    <xmx:qKj5aWChGNMS93WmhbX3Ka-TmQiMRJN5c8_EZqVYd-QLtKGrSYsinQ>
    <xmx:qKj5aRTFbm35zm8-bknwSIqm-hP2vdPStYw6rP2X2KntUVDYv3pfQA>
    <xmx:qaj5aQ_S5uN3UDnqjbC0lfzmQWhsqceetCT30RmVsKfs8AVhbJN_2jVN>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 May 2026 04:21:58 -0400 (EDT)
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
Subject: Re: [RFC PATCH 02/25] alloc_path_pseudo(): make sure we don't end up
 with NORCU dentries for directories
In-reply-to: <20260505055412.1261144-3-viro@zeniv.linux.org.uk>
References: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
  <20260505055412.1261144-3-viro@zeniv.linux.org.uk>
Date: Tue, 05 May 2026 18:21:55 +1000
Message-id: <177796931573.1474915.17389032143652405017@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 05 May 2026, Al Viro wrote:
> A lot of places relies upon directories never having NORCU dentries;
> currently that property holds, but the proof is not straightforward
> and rather brittle.

This requirement is only indirectly documented in d_alloc_pseudo()
where it says "the stuff that should never be anyone's children or
parents", and they are for "lookup-less filesystems" wherein directories
obviously cannot have a role.
Would it be worth making it explicit?=20
  "A pseudo dentry must never be used for a directory"

NeilBrown


>=20
> It's better to have that verified in the sole caller of d_alloc_pseudo(),
> so that any future bugs in that direction were caught early.
>=20
> That way we can be sure that
> 	* current directory of any process is not NORCU
> 	* root directory of any process is not NORCU
> 	* starting point of any LOOKUP_RCU pathwalk is not NORCU
> 	* dget_parent() can rely upon ->d_parent not being NORCU
> 	* d_walk() and is_subdir() can rely upon the same
> 	* alloc_file_pseudo() won't create multiple aliases for a directory
> without having to go through a convoluted audit.
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/file_table.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/fs/file_table.c b/fs/file_table.c
> index 16e52e7fc2ac..108ba09fb402 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -402,6 +402,8 @@ static struct file *alloc_file(const struct path *path,=
 int flags,
>  static inline int alloc_path_pseudo(const char *name, struct inode *inode,
>  				    struct vfsmount *mnt, struct path *path)
>  {
> +	if (WARN_ON_ONCE(S_ISDIR(inode->i_mode)))
> +		return -EINVAL;
>  	path->dentry =3D d_alloc_pseudo(mnt->mnt_sb, &QSTR(name));
>  	if (!path->dentry)
>  		return -ENOMEM;
> --=20
> 2.47.3
>=20
>=20

