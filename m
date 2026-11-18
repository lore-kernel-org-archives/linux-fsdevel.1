Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.160.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795009103;
	b=gWTP7L2jgrqHVETepb64qRu9BL4RR4GBgn1+914KpsfIQr2XjoGQtW+VlgYddBI9M++R
	 Dg2w1QzLuVJGM90xMD92MWsIr2BcxejMqzH9nm0BXZ+5XG/wvRVS1aF4hXA9vHiLUk2Qq
	 iJ/iAAJbKrqnB8dbPDig6fQL9Q3qI9Ls+/dnvG6ysVQXZKnJba3ZepJ88sgFJaPM7IsCO
	 zsxSn28F3OHqxTrzxk83QSDupP5mBc9NizbbF/y0VNxghSzYS2V0hW90sA+Er/1pNc/xn
	 IERVIHbJ8IphMsRAAC3jr1zKXdhzbW58eisGSNHhqP8d/fRvj9M2rzTeuLs9fojl0nA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009103;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=Gu0OV3kkEAl4D4CjhNeE+xCTUXelNvJBkZGChj72U4U=;
	b=OcMyYdbbhhRpAlFWio9d8m1qTvP0TtpU61sxR6Mf5W6WdlqLRaAfHwt+ft42sP3kqaNy
	 CJw8cjazE4AyPPIgi9FIb67fX2r978mYaQOeXvaMWgIdRVl2eVrozqvNRPU/3CEu26uM9
	 XNocrWdb9mggO/U3t/Tm2HzRwzkU7CKGWAhq0SYU6IHISD4WjTeurq84GNxNDpmG7UZgS
	 zV13dgumELtxNfT0jNMjYzA7lfu7Gi0L/I+h1qNRIWdwwExWn5FgMEfkDaBjQeWHeedbD
	 XnXs0GaIY8umuoQ4J7cXxcZOOTwbAhsHvnxfIUzXhSJrq8f55ge3NWNE6U5oE/W6GhA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szeredi.hu;
	spf=pass smtp.mailfrom=szeredi.hu;
	dkim=pass header.d=szeredi.hu header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b=Pe34tTsI;
	arc=fail smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5262460A2603
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 13:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5262460A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b=Pe34tTsI
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-55d30c054dfso10536251cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 05:38:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795009101; cv=none;
        d=google.com; s=arc-20260327;
        b=rb5rMGwXqbulFbyW8p7KX626XRDfnaDQhQRLFmSQymqDaRdygc7T0CXf1tv2wzFdfH
         HgFTN3/rTq1Szc17qthZ6dbUm7c0nn3vPuhbsmhJERc6Pxp+3JIKcZggdAL4D4cZ03X9
         C19rK3nOa4WSYtR/ZAR2W4Vaw9sDwbSNS2aGajjGROESVtiE7vnXMekZBCySmb70mafe
         BPQEfopPharmV00Pwu+J7MIrKVlX0ZWFKxXq0WZvtmqtbBVTSaeHplXnb8SsxSHJXWKq
         H6yaHguF9rC8HYzjO9rb/Is7HZzbcSA7wOsWeY7wS8rpek9CMIysz2S3DyZFo85xM2bp
         ja8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Gu0OV3kkEAl4D4CjhNeE+xCTUXelNvJBkZGChj72U4U=;
        fh=YweFcjtlXtXnYQOi0eNcPMr3G8s4k39zCe8HJu5bbD0=;
        b=IONsamMTdFruVP6sUNIOGD3OOvW36HwQ9AWDmfjVOv72cTL1zM/2PRgk7JmgBpT67s
         czL/0iQu7tfo38g9KhV6x9L+70QusH9uhYXgiPRVOvaGzoqzMwzlfidwXzFQxU+31dPH
         pqyoEKxXpJ0u44GCiXGvjmnoaXcDk+A9fY80AUxx3mc6+5d0Kcbb+m4ll/m1jXQLmgpa
         bXdYpyxQxZmlHiUdvEbqeMin0//heJG+wA6Y6jIWh6feKslupiLp1MF3pZOxTK0h2PW3
         86yro8xisavCuKtCtCSbGmoq/KgZrJelPqPhpZmFBq1k/JkmJ8TQ02db/YsUdHqderUF
         UpjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1795009101; x=1795613901; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gu0OV3kkEAl4D4CjhNeE+xCTUXelNvJBkZGChj72U4U=;
        b=Pe34tTsIgFeEeOlE8BDyVJuTMubDV7IkG0gfFDkXSbD/+AwMJkcrj2xltdA98E10Jt
         WN8LQd0JEg98Z/33ga26tURmtWsAi7rYQ9NM9Ch20U1RmHdV/OD+mO+UwpY5EnnjM+HE
         8NzXR1OZ4amekDKtfzXQMjpyw8un5pJRKJMmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795009101; x=1795613901;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Gu0OV3kkEAl4D4CjhNeE+xCTUXelNvJBkZGChj72U4U=;
        b=2vg9Vd71TxHNSfk79CvVQjZyeQ5Nv1NKvf0vnL+2wGGWQpH02Y1yz0j0xVMQxX3wkQ
         rR03FpEMGChG3rjPJr/WbBDciEoTTv0Je9DWa061vaNGDGPZuOclgEWqGmYdq/RVCjbe
         dfATadCZoxyA8AjSI3tf4LSMahhm9Eil4w0yPuZekBGn7IoQuJrjx1ByVSm5aMS+gkdt
         xmJGilrWgaj37p8g16vp8J5PxivKJ6mXcZefs+/T0gO4nxNB5Fm6H6PkbnGRoeer5CXa
         SLkcunV8otJ8wDj9NSSmX6raorHmKwENlTyAH9+EZc0zTwV/JCSPZFPxmo4nyl4PeW3i
         2vrQ==
X-Forwarded-Encrypted: i=1; AL+hErEOjpjB1aVdf+YGsj0uLfLcfvdLIlBWbv2Co0vEYDkEuyavUErLybSIDnwqkTw+LVYDpseYKu9lNIH56A4z@vger.kernel.org
X-Gm-Message-State: APuU4Z9IjER5O4uSRlai0x7+IziDAbo+NBfFyez5cuEefnxjtimnAGmV
	qMLRB4hp64qi7MY3YqDk4OkE53e8vh6HSPF8xjjwUKTe7BA6fZSh0K/vzZT+ErL2sIn3LibkQ6q
	K+DFxBLLJyuJwmUCVLMyTnL6mAGgxsNq1riEHRp+DIQ==
X-Gm-Gg: AYBFou0PKDeC2Y+fEPTqy3x7A/IfSAzxCP3OGQ/HpJWSXSYCAByPrVg0bHheF3gZ7I5
	rHMyhzBjew/vLfKe7/EGxSwKyUb63DgD/YRHhUfQlMI4YnFDi69R8j1Gd2GlFVlXIzBPE8kFPIo
	FQMPTdXv1fm3/0Gp50ZQ9HJS2Jk+zkq5JJilDs48lIe/XEVXrToaKai/GF1RBYNcg+YOSNQg2Tl
	YAD2bW/7ikOkTI6G4j8h84Di+8eZaCUBONHc9Y/3yY/hY3l7oTD3lPN+C94XXRgqpmiuXGZLmcq
	WWd4oEJup1apGK0SHYYUXN+mOM8ti7d2L6lfm55JZ1uQGa4obwvT1bLrQyXGI2br/OoEyQOPAk0
	sMFWnuik+dOth8rCOviUYQ3rTe97yfySfqUbWI3N/ozloe9RDLOQQjOjoNjAwIYTdq/1/AaLMKc
	uAveHCHNdaPV8=
X-Received: by 2002:a05:622a:558e:b0:55c:f47a:8c96 with SMTP id
 d75a77b69052e-55d5a340368mr39697851cf.3.1795009101249; Wed, 18 Nov 2026
 05:38:21 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117135146.3174252-1-graypanda.inzag@gmail.com> <20261117135146.3174252-2-graypanda.inzag@gmail.com>
In-Reply-To: <20261117135146.3174252-2-graypanda.inzag@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 18 Nov 2026 14:38:09 +0100
X-Gm-Features: AclHuK95w6kthqK2rcV5FGmp6byHyDgOGBtGbNMoFRdYyxphnOM3Now-gzk5ZLo
Message-ID: <CAJfpegvfKhZYuMQ914GUPNvdPi-nZBYE9qfwHVg6m+8ABuhqCg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] fuse: skip dcache instantiation for readdirplus
 names with embedded NUL
To: Junyoung Jang <graypanda.inzag@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Matt Bobrowski <matt@bobrowski.net>, Gwanhyun Lee <gwanhyunlee@gmail.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Nov 2026 at 14:52, Junyoung Jang <graypanda.inzag@gmail.com> wrote:

> Some FUSE servers include a terminating NUL in namelen.  Follow
> nfs_prime_dcache() in commit 78d04af4995a1 ("NFS: nfs_prime_dcache must
> validate the filename") by skipping dcache instantiation without
> failing getdents().  Return -EIO from fuse_direntplus_link() so
> parse_dirplusfile() sends FUSE_FORGET for the unused lookup reference
> and continues readdir.

Applied, thanks.

Miklos
