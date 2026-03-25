Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088B63909B6;
	Wed, 25 Mar 2026 07:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774425303; cv=none; b=uETGPgxEjXh0JlTRxPqwVpoMry6rWMEuPKLNZ2Blb2D0dPcIov9zCZdUCUtrVetQTVv2QGneb0UP3hQM37NI55/xQH3sPd5uXf9Vxs+LHomLRj/LuUTKwi57U8mcbqIBCWLT+IH1mHF8zX4yunBfQry4DY5H7cZgzQrF84PQh38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774425303; c=relaxed/simple;
	bh=Kjt1y0s8FJ9zfHevi8WrISAxv2PKxgazD+LGxmPI++g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D85TK3g5fmn68F8iKAz1AvzBd+tJnDa+Fih6IBcq8SP0rYH8zXoA4B2BPyOZziup384h2z8JHXpmB8FQSEDoCItPPeKUjOI7Yeze0PXWDRB0lH89HLez1YSczUqWXblOXLv5lA6wQA102i3EZ9WsWvpRp2ri02KWpfaCgjelEN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=DvnJwoOl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f/ZdNCR5; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="DvnJwoOl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f/ZdNCR5"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D80831400241;
	Wed, 25 Mar 2026 03:54:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 25 Mar 2026 03:54:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774425299;
	 x=1774511699; bh=uQbnUjXHdE+g7JuA+BmgsCDDzTu6UGzkqYP3k2/g0pQ=; b=
	DvnJwoOlS+t1xgYleRKdinhrS6gKHQRo9KrJMTU97bNz5AE23E0S92ear5TjOdso
	xVn9EbdE4GPf2avxBPir77K/4eEDg4zPf9Ik5LJ6V1c0EysucjHMK5zXJwIYw9If
	KpsdyvEO4PyGgssUbu9rPw9XI+Fl+ksLUo8/j/2vwKPXvOV1p1Xk22nv3MX6k56N
	kGh4HMtdnKbJDjuBaB/iIA9vm74RegJs+C9PeALa2qleXBdootF3tfWr1nLMjC8W
	L1hbhb9sDEqZy4XISllGwI8uBOLoEj+ZAuw6seerCPGJJK0FMgRosrbb69ljMBiC
	CDY8U4z07l/t2aXTblGsvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774425299; x=
	1774511699; bh=uQbnUjXHdE+g7JuA+BmgsCDDzTu6UGzkqYP3k2/g0pQ=; b=f
	/ZdNCR5oA4pJ+tK6U6pu6+Sq5/W9OMsuJEzRlv/6AXrqwDigHmTK6pwI6SOCvGoY
	hrGhFuyMHmvwqAO1oE8NY20j5fnlWGlbnyhzmDX5qjNEtgYpxyC6ZV4BVPw1Y8vU
	CsfdiIYedUzTsfOjM3iZ19GNNrJtXq1KEUZs7cJADG+8MSvvVPLvjSjzgTRJwVgo
	KqRer1Vlnr0dcVyCnNwJJNs3uJ9fosBfXE0QUrzObgNKIXv0HUP4DwcMUK75jToh
	tNVhyJv+bXbQr7Q8HeD+AZ3zsnOQ9LwUo2kKpO4Ac2913HgFX5cMDghO6Bw4rLun
	0yrdGBSwNtuF1ss7Fh62w==
X-ME-Sender: <xms:05TDafT3HFSWL8iyNQGDz4K8Oichc-eSex97bVaL5XcPx3cB4c1FmQ>
    <xme:05TDaST1q4lvTyXfgm8fmaeEAHi_Pg-YXSSUhXxIIVWUqNtvmMxaiDRly9ArskcNc
    1KMDix1Q0Cs1kRiHXvC08610n9EbClEQ6LFoJEdPllNtbLW8UM3>
X-ME-Received: <xmr:05TDaU51u4YdyP_MaIT1fmrLLbuMbHI0MI9GXhnghOV3iuKf9Vg9GEeh5ytIDfnu4IBtvam5O8TmMag9vdANaedTAFIz48BAcJUw-XvpFTlXHfamvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdefleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehhohhrshhtsegsihhrthhhvghlmhgvrhdrtghomh
    dprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheplhhi
    nhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehhsghirhhthhgvlhhmvghrseguughnrdgtohhm
X-ME-Proxy: <xmx:05TDae1fGZWYccJSkb6Um_JoXnl6_Uj70tFLcD4Dw4EnWrCmK-8Vng>
    <xmx:05TDafANspKq8TSXEOaRbuqEHSY5-6-tyv4mvjzPgm21CPL0Zeutvw>
    <xmx:05TDaZPQBl9NqrdwAn7WBFP--Lxa9bqND4lILAjAwCrMELEbokAHtg>
    <xmx:05TDaUY7kp9fjseqBDiQweT32J8eihvt-Xw7PxrAZ3pMsb9hmTESjQ>
    <xmx:05TDaWGUMNdH13kDg6RLdm3Fv6h1rmCboQNp6CBfvKg4BTxjwTA5Mb9w>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 03:54:58 -0400 (EDT)
Message-ID: <3a7d36c3-0ce0-4f1d-9649-1742f752c5f1@bsbernd.com>
Date: Wed, 25 Mar 2026 08:54:57 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: fix inode initialization race
To: Horst Birthelmer <horst@birthelmer.com>,
 Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Horst Birthelmer <hbirthelmer@ddn.com>
References: <20260318-fix-inode-init-race-v1-1-a7e58b2ddb9a@ddn.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20260318-fix-inode-init-race-v1-1-a7e58b2ddb9a@ddn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/18/26 14:43, Horst Birthelmer wrote:
> From: Horst Birthelmer <hbirthelmer@ddn.com>
> 
> Fix a race between fuse_iget() and fuse_reverse_inval_inode() where
> invalidation can arrive while an inode is being initialized, causing
> the invalidation to be lost.
> 
> Add a waitqueue to make fuse_reverse_inval_inode() wait when it
> encounters an inode with attr_version == 0 (still initializing).
> When fuse_change_attributes_common() completes initialization, it
> wakes waiting threads.
> 
> This ensures invalidations are properly serialized with inode
> initialization, maintaining cache coherency.
> 
> Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
> ---
>  fs/fuse/fuse_i.h | 3 +++
>  fs/fuse/inode.c  | 8 ++++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 7f16049387d15e869db4be23a93605098588eda9..1be611472eee276371b3bde1a55257c1116cfedd 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -945,6 +945,9 @@ struct fuse_conn {
>  	/** Version counter for attribute changes */
>  	atomic64_t attr_version;
>  
> +	/** Waitqueue for attr_version initialization */
> +	wait_queue_head_t attr_version_waitq;
> +
>  	/** Version counter for evict inode */
>  	atomic64_t evict_ctr;
>  
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index e57b8af06be93ecc29c58864a9c9e99c68e3283b..c6e7e50d80c0edaea57d9342869eaf811786e342 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -246,6 +246,7 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
>  		set_mask_bits(&fi->inval_mask, STATX_BASIC_STATS, 0);
>  
>  	fi->attr_version = atomic64_inc_return(&fc->attr_version);
> +	wake_up_all(&fc->attr_version_waitq);
>  	fi->i_time = attr_valid;
>  
>  	inode->i_ino     = fuse_squash_ino(attr->ino);
> @@ -567,6 +568,12 @@ int fuse_reverse_inval_inode(struct fuse_conn *fc, u64 nodeid,
>  
>  	fi = get_fuse_inode(inode);
>  	spin_lock(&fi->lock);
> +	while (fi->attr_version == 0) {
> +		spin_unlock(&fi->lock);
> +		wait_event(fc->attr_version_waitq, READ_ONCE(fi->attr_version) != 0);
> +		spin_lock(&fi->lock);
> +	}
> +
>  	fi->attr_version = atomic64_inc_return(&fc->attr_version);
>  	spin_unlock(&fi->lock);
>  
> @@ -979,6 +986,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
>  	atomic_set(&fc->epoch, 1);
>  	INIT_WORK(&fc->epoch_work, fuse_epoch_work);
>  	init_waitqueue_head(&fc->blocked_waitq);
> +	init_waitqueue_head(&fc->attr_version_waitq);
>  	fuse_iqueue_init(&fc->iq, fiq_ops, fiq_priv);
>  	INIT_LIST_HEAD(&fc->bg_queue);
>  	INIT_LIST_HEAD(&fc->entry);
> 
> ---
> base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
> change-id: 20260318-fix-inode-init-race-a47a7ba4af1e
> 
> Best regards,

Had reviewed that DDN internally already. LGTM

Reviewed-by: Bernd Schubert <bernd@bsbernd.com>
