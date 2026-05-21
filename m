Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB42395AE6
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 08:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779352824; cv=none; b=Zq9FACRbiTS5i+57DgiDbj78t/S54uupG4X3pAFkYqWxuCOHUWWpwtxe9BST03sYwn6ODvcJBBJExczWI6goyjSRP3TqPXAb2wnPufGKZNKUj8cONBvo8leojeEg6VbwwRm3GE0wnP8wzZJKAiiQZ3ufaFL/tK3/YgubDRaiFyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779352824; c=relaxed/simple;
	bh=aIM5G96fjQG3IFxN+N/k5gGpQAHSAcF+sQiUq3iGoYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZOJU8PkUBTXpZZ05k31klu7STVI7lBNz5005EeISOPOfQoUsQtAULRfYBwZ3QWQk0F8QPM77BNxRZNYKGHQ6U9tGPuvp3iWhNLDiyCDqBPmwGo9uFYC8/WvYlMwI3KWkSY4FGKr0v37mYMsko2dbgMbPoljQamLVhsgI5d3xIis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=DJMVCdY8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MaLVRWNO; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="DJMVCdY8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MaLVRWNO"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 8247E1D000E2;
	Thu, 21 May 2026 04:40:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 21 May 2026 04:40:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779352815;
	 x=1779439215; bh=70yu7/WIDO5i0wlGlfaSr/1hPqkksed6oef94t/+wuI=; b=
	DJMVCdY8iWqIDknNyzOm62017EhdvaX0eeHftJFD5juIA4mEQVdhDaJP4IO5813c
	DLR5HX6MFgVhL5dpxRC3P8OBDwhwkBlAXF+6uLYtBNRPhOQcdndM4d6iFJOREE5m
	I3aVqFBKggSbzaw4IAKBHhD5NsLVwxg3UHvsLDmemEGY0iIYa6v+/uT5mF2cnrgV
	C30l8HyJVXZRbtZnFNFZMQzBB5wUD4UDRbnNtnOzrYmZZuWOPR+Fyv3H7kfispVO
	aq9f50YjHw6C7mwWuSYvHZu8e2LRmNU5+UjqqGano2i4vcsLECWxLoJAoCY31KZt
	LefQVFGtz73ZUnRun2hcrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779352815; x=
	1779439215; bh=70yu7/WIDO5i0wlGlfaSr/1hPqkksed6oef94t/+wuI=; b=M
	aLVRWNOK2GoIls5kwlwPR1SwzLKZkPQGvaAj4K0IP2EPVUWnlS8wSydvRXI6hSHE
	G1VEB9ZHHOLmVar8THbaBSazSSvKQcRrgGmS+72kvWaQWmPxD0s4k46Wcqz//56/
	5Ig4H2jtVt+S5Jn9FXFpghjOvpt1DwG52z9tpecHuz01GPkJj70ixpGVihrICRGj
	nsOxiZD0F41G1CYVk5/mwG/GSwIKk85j6iVZRXwMyyh/kP3+cNRl6km+zfFhtVQL
	N1OdCy7u38zMTROXUUr+ufsh36xewvH7V1BgTUYupny9fPblzYhc3MMKLP1uYVMU
	UwuZr7gMS3VTTo9KE14pg==
X-ME-Sender: <xms:78QOallhfdLMsd59rtVtQZww-dHd4iFXwnliT4JetwMMyvGA1c3gYw>
    <xme:78QOaqLY0RRCA-M9z99uuqtzlB-bQHaJqE6jR6Q0QiBpRqYUqlOCSSa1fKDqkUlWc
    TUwmfKTCSYwsqpiqSwT2Ihz8xLRmGtaKvHDuNBMpMWzwgUaKKmg>
X-ME-Received: <xmr:78QOai6YyP21fWa73bMHduRkiZ_pFsW33KosKXSqAOj42GkdGeAs7kOwmzwL0BYn8R1OSWYUi-Kn3seKZ_Mk24dH7RA3SsITeGQLMsr2vBFsMME--w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejtdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    nhgvrghlsehgohhmphgrrdguvghvpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvug
    hirdhhuhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepfhhushgvqdguvghvvghlsehlihhsthhsrdhlihhnuh
    igrdguvghv
X-ME-Proxy: <xmx:78QOam0-ugR4bD_hgDV5iUktpbl3J11E3DNOlJAlyFKJkQ3YJuy69w>
    <xmx:78QOagf55nf_wVRq36ah86-sKYj3jrDNJeI5LaGRt8wtoYTE42xLLQ>
    <xmx:78QOakdWVjTxvVVJHAr8RfqE5e9LtNdG0tsUrQ6rcSIVANUpZEUGrg>
    <xmx:78QOajxi_uAYYK1XZQvg5-PT2OX4HAoVC1XhFFVpA5dgjIGkOJzPfw>
    <xmx:78QOarv4k2BePbyW7RsYRfhlHKMPVUCBMzl53nPpMlgAyEBxpPGpptt7>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 04:40:13 -0400 (EDT)
Message-ID: <567436e2-46d2-4e23-9647-b9af9670a4ea@bsbernd.com>
Date: Thu, 21 May 2026 10:40:11 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] fuse: use fuse_args in try_service_main instead of
 opencoding it
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: joannelkoong@gmail.com, neal@gompa.dev, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev
References: <177933241435.3536631.9946604261928168710.stgit@frogsfrogsfrogs>
 <177933241466.3536631.2548927904330465445.stgit@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <177933241466.3536631.2548927904330465445.stgit@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/21/26 05:06, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Don't open-code the argument array, just use the existing helpers.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  util/mount.fuse.c |   71 +++++++++++++++++++++++++----------------------------
>  1 file changed, 34 insertions(+), 37 deletions(-)
> 
> 
> diff --git a/util/mount.fuse.c b/util/mount.fuse.c
> index 00b133e6234489..bbfd8355dc7f48 100644
> --- a/util/mount.fuse.c
> +++ b/util/mount.fuse.c
> @@ -286,12 +286,7 @@ static int mount_service_child(char **argv)
>  static int try_service_main(char *argv0, char *fstype, char *source,
>  			    const char *mountpoint, char *options)
>  {
> -	char **argv;
> -	char dash_o[] = "-o";
> -	char dash_t[] = "-t";
> -	char *mntpt;
> -	int argc = 5; /* argv[0], -t type, mountpoint, and trailing NULL */
> -	int i = 0;
> +	struct fuse_args args = FUSE_ARGS_INIT(0, NULL);
>  	int ret;
>  
>  	if (!mount_service_present(fstype))
> @@ -301,44 +296,46 @@ static int try_service_main(char *argv0, char *fstype, char *source,
>  	if (source && source[0] == 0)
>  		source = NULL;
>  
> -	mntpt = strdup(mountpoint);
> -	if (!mntpt) {
> -		perror("mountpoint allocation");
> -		return -1;
> +	ret = fuse_opt_add_arg(&args, argv0);
> +	if (ret)
> +		goto out;
> +
> +	if (source) {
> +		ret = fuse_opt_add_arg(&args, source);
> +		if (ret)
> +			goto out;
>  	}
>  
> -	if (source)
> -		argc++;
> -	if (options)
> -		argc += 2;
> +	ret = fuse_opt_add_arg(&args, mountpoint);
> +	if (ret)
> +		goto out;
>  
> -	argv = calloc(argc, sizeof(char *));
> -	if (!argv) {
> -		perror("argv allocation");
> -		free(mntpt);
> -		return -1;
> -	}
> +	ret = fuse_opt_add_arg(&args, "-t");
> +	if (ret)
> +		goto out;
> +
> +	ret = fuse_opt_add_arg(&args, fstype);
> +	if (ret)
> +		goto out;
>  
> -	argv[i++] = argv0;
> -	if (source)
> -		argv[i++] = source;
> -	argv[i++] = mntpt;
> -	argv[i++] = dash_t;
> -	argv[i++] = fstype;
>  	if (options) {
> -		argv[i++] = dash_o;
> -		argv[i++] = options;
> -	}
> -	argv[i] = 0;
> +		ret = fuse_opt_add_arg(&args, "-o");
> +		if (ret)
> +			goto out;
>  
> -	if (getuid() != 0) {
> -		ret = mount_service_child(argv);
> -	} else {
> -		/* We're root, just do the mount directly. */
> -		ret = mount_service_main(argc - 1, argv);
> +		ret = fuse_opt_add_arg(&args, options);
> +		if (ret)
> +			goto out;
>  	}
> -	free(argv);
> -	free(mntpt);
> +
> +	/* If we're root, just do the mount directly. */
> +	if (getuid() != 0)
> +		ret = mount_service_child(args.argv);
> +	else
> +		ret = mount_service_main(args.argc, args.argv);
> +
> +out:
> +	fuse_opt_free_args(&args);
>  	return ret;
>  }
>  #endif
> 


Thanks a lot much better!
I think we need something like
fuse_opt_add_arg(struct fuse_args *args, ...)
Easy enough to convert to that once libfuse has it.


Reviewed-by: Bernd Schubert <bernd@bsbernd.com>

