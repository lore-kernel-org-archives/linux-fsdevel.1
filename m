Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795658471;
	b=I4QUxVELJjSX2/bDKkwzdo9+e6ZsEuYgnrzWQAGXoVW4fAu3H9/7tsSw5oSNQQtC5UZW
	 mksqksveMW0n2cf9ZuHhL2+xkbTUULEYJGmEfsPZu368zFWoxeLFSGZ8K3W6igAa3qeeZ
	 OZFatQh3QO9pxWoGsz3uDspL25UMVfttGd71tcyWkDiAoSr6un6QOr74pflIvmv7QjoyA
	 uOoUQsTiTsq7KWOuzM/YPB7XtMQPyGr2p37+J2Y9Iles7jHFmKKSlUq+vX24kVxHk8EKZ
	 NPKVY2MI5ErZapZVQNE/j5EVBWIJbonFO8FrJWgbhPCMtW0CubkpzqsPiAbu0H7Kuvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795658471;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=znZpPMg7ooF6+R+ZrmeprHnl4R4cuXcKWPuk6CPDlBY=;
	b=ZdTctBpoaOM7YcAg8E/tmY3yR0OVWRFkm6BB2REPnKYS5WHRmYdkMSeMGKftEqBjMPI2
	 7gSEtyQF1pjfX5fifSaeu5w7MIYSQQ9i+R6nR6jdzerF/3TG3XIOO7izJJbvOnb8qKkp/
	 pPJoKF6SUqubovv/IYGnoU5x6c6QnxJnuRyHIsPYjRNBZOGwA82jzDnjoJM8LIBfh1SHT
	 LgTo5pj9MRirRgroqi6gsYfldMP5iyXTiUcwyUbdBCG4ZwssnUkD2JI1DQvMiiYNrzqDN
	 bK6QvMjdwcxi+mUJwrSOuvtZ0hPhVlXe9eCGZ+AfXqjtt8kTTBF2nA3XL8yhczIus4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uHpbrxkV;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC393606A333
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 02:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC393606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uHpbrxkV
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ae1da332bcso3376665a91.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 18:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795658470; x=1796263270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=znZpPMg7ooF6+R+ZrmeprHnl4R4cuXcKWPuk6CPDlBY=;
        b=uHpbrxkV5mu346yeO2eEeutpMuZUMufGBrpF+ekNF6qVjJYbXQ/M0+hECOvjc2ydLr
         6scqFrRXYZEISd0rIspxUXV/dJUVPGGfHzAzGaFEEl8IGRRFXQk8/CcyLUY35DcxYcz6
         nwsZ0we98nABM+5cP+f2NWZdK/amgIqMJvUlUtvLtfQcKXGzIMnTl1EQv0gO+k45ttt4
         QG/Y3i5XvP6vJXxFdvA8yOYns37+bOuv6TtYiF/xRjoiPswMYvzYIV71MAztjXKp8njU
         1Y6JCVIB1RnhIzHmRtyfNAyhihulxVmFn2eogPAZV0QXXmBHBO1H3J1IqqaX5GgBhYdz
         Ki8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795658470; x=1796263270;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=znZpPMg7ooF6+R+ZrmeprHnl4R4cuXcKWPuk6CPDlBY=;
        b=y4loEP8uQ0VYNsDckq8n1yaTmaPeXz7OHi15ZZe7DrwJTFttRPRyDOfkp9VT6w9rT+
         5XRyzMS34VJYVKFSSpx+vMiGSlQBROvjMCQE0u8dQZoQCVADbpdKq7XoFfVdjVBQ0F/i
         4mdHFrBlbjc550seXs9zjF0FkQ5Fsebf1YK7VO7BZ3q570iZP0xau0PvkrcymhD1EqmV
         eHRoJ4KnpLyTKl0AK6c8ce/WxoCSaqlOSg8jghiPXb776kF1FBFaEwOcU5hdTfQcUJre
         /htmWBcp1sdEJaHsJGUazSIcn6WqWGE/BvRWQfH/PruLl8dVEupL782E5I7/IKqpNR2Z
         Ty0Q==
X-Forwarded-Encrypted: i=1; AL+hErF5DIcEgUH45nnT7FJgo1nBNL2mR1ualJy+L5QM40G2A3NKzZvln+QwYqjS+CYLnYH4Fpbz1nqAVm4A6FH8@vger.kernel.org
X-Gm-Message-State: APuU4Z9yEjO1TRRuP06iUTvG5j/RsqgB+YocHbpR4LzXjUwYipRDIze2
	IGcIVVHpN1wHh5u3zT4/kp6IdSRV/K3Vxlm4bNsE2RdQ+o62WGAb3fqD
X-Gm-Gg: AZFdTZcd/8mc3Mg7SJ0Zi/fcj3gHg1MT/U1tpWAO5S2Eq3c8TiVls2qsYbvVIODo9rm
	+tcggV2zHk4WQV3S0x0+30LgIRHOuE+FR46vMY14yTVobeeFNms3JLmPClSPlSEGziVFVLCT0E2
	FLyWSGemikSXnt8o9cih6lrzPsMoKe72rAwA7bGGSgGK7Ld8U5Txa9GHoAu3Ud9Xx/DqAzVgX0z
	8WYiJw+tBdn1SJjeKicTa4jnnxTeApXTl0+i5ASPHwRUucebzfB+CN7nNgtMx+TtCZlhNW3dYOl
	mboL0AwIYoPaQ12C9PevORPWJmgmTpyM3mLQTlp0xGRIOwfAtcVfPzt1rga9rF4+0uEhJVdGixT
	pKGp4vWEOAPUFKsKgLx8cw6waBazrIsZOI3FzwDbd7KyeJtXGmcEhPfIcWtVQZ8h5oRW0KV/oDX
	nkGMw3s+Y69TyQyXEFxXa+6zmuKpg6ZYHl1A8f12k/+FonlpJxJHFib1K29yE9YTYJt0faX8DOp
	tEpQXY39w0De3ToqbGFw1kCxCQex6HDrsLbXT0x/PhvIyqFVIW+o61tJ3R272l7tibTEc53sWOh
	7HeNyX3Yp/ZlugcomcWtg8QWGBwn5nUYNpOegtNx
X-Received: by 2002:a17:90b:3b49:b0:3ac:b048:fa13 with SMTP id 98e67ed59e1d1-3b41c9beaefmr19757865a91.67.1795658469904;
        Wed, 25 Nov 2026 18:01:09 -0800 (PST)
Received: from localhost ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d63728sm35245361a91.8.2026.11.25.18.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 18:01:09 -0800 (PST)
Date: Thu, 26 Nov 2026 11:01:06 +0900
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Showta Ishizaki <zakinko@snowrabbit.org>
Cc: Namjae Jeon <linkinjeon@kernel.org>, ntfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ntfs: keep i_size of a directory equal to its index root
Message-ID: <aweS4uqvdtATt2gm@hyunchul-PC02>
References: <20261125-ntfs-01-v1@snowrabbit.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261125-ntfs-01-v1@snowrabbit.org>

Hi Showta,

> diff --git a/fs/ntfs/index.c b/fs/ntfs/index.c
> index fe2a79b..73c8e6f 100644
> --- a/fs/ntfs/index.c
> +++ b/fs/ntfs/index.c
> @@ -1434,6 +1434,8 @@ retry:
>  		icx->idx_ni->data_size = ix_root_size;
>  		icx->idx_ni->initialized_size = ix_root_size;
>  		icx->idx_ni->allocated_size = (ix_root_size + 7) & ~7;
> +		/* As ntfs_ir_truncate() does; i_size kept the old length. */

Could you remove this comment?

> @@ -611,6 +611,13 @@ static struct ntfs_inode *__ntfs_create(const struct mnt_idmap *idmap, struct in
>  		err = ntfs_attr_open(ni, AT_INDEX_ROOT, I30, 4);
>  		if (err)
>  			goto err_out;
> +		/*
> +		 * ntfs_attr_open() sets data_size to the length of the new
> +		 * $INDEX_ROOT, as ntfs_read_locked_inode() does with i_size
> +		 * too.  i_size stayed at the 0 set above, so stat() gave 0
> +		 * until the directory was read back from disk.
> +		 */

Please remove this one as well.

> +		i_size_write(vi, ni->data_size);
>  	} else {
>  		/* Add DATA attribute to inode. */
>  		err = ntfs_attr_add(ni, AT_DATA, AT_UNNAMED, 0, NULL, 0);
> -- 
> 2.54.0 (Apple Git-157)
> 

-- 
Thanks,
Hyunchul
