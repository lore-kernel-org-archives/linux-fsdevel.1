Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794658799;
	b=LrlQBJbNc4vM+wmKttsCtHdfXITo3PGaGaZT6m6sRZXFgb4nEq6x0S5eBUkRzlxGKTmE
	 nJvoR3JPHHSNotts934vxh295162N9k75G5WNK9iU1TZxklGUm1trt5/lBzBWbrGVw8Rb
	 sGbf7AfWBrbekW1v8Hw+QAN6eLJogJ2b+RYYkG5EptLD4/cY9AkTplfQiLQv1v7dgk/Jb
	 x2Eh3oVZqypp04ra3p5roMnuwDDfI4Z1kbs0pjqx4mgCl8qL3z85p72Ah73OIFmUlF1cX
	 JVjvvmsLrAwE7V0cg8vqJpFOOwzin4jjlG73Wu7ph0H5DSlvdj+4oV5ah2rDkWMPzDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794658799;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=nkM3J4QAu8kIsGHpB1EKb0NRF0JxtY2T/gqGpQ/nt0Q=;
	b=dPfiefFBG/XWXJoe6KWkbAMh7ehyWBFrAedTp60kbH79+1X9VSPsAgBQV31vJNFXR7jD
	 6/MuerOT29YiCbNh0INmaK9g/g8F4BAVX5dimwxA4Q5tZjvmIcRRmWGwjDiqXz2Sv9nJE
	 ZqFl2Hy8DRNE4Rn2uhHr17Bdatxz/vVN4yyw0Ibgsc6mQZl1Rlt8lxKXjJOhruRLOTwaN
	 jhiUp6vZWJRF0tgAfF3EbZ+J9NaM/OCjVkEboQMFhB34VIm5KLwvrOlBuxP6/3M50hxHN
	 QHt/BKR9DwdLtHnJnfs9O0qURUQ2uVlavoJLvbqRKWdpiX4OYiokNZQ2EVLq44m/KwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zvg2B30u;
	arc=none smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D853606A336
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 12:19:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D853606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zvg2B30u
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b7245ab5e2so5209519a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 04:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794658797; x=1795263597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nkM3J4QAu8kIsGHpB1EKb0NRF0JxtY2T/gqGpQ/nt0Q=;
        b=Zvg2B30uBzOFFo54OpfHCzqSK6TOyxTRmwNZV7t2nfrBwunaCrRH+5tI09/jIosXZS
         GdYk6iMfyO0nJ3moVzjaSKnXCCWxcV1Ye+R/4YjiwdwGG8ofIv4PWH24MjP/VV4CkNiq
         nSM7j6UNEdEDdNWpjUjn43q9YL/wt1IFltOrsPhL2VYrn8g/yyR7Uz6PFelA0j1tolIT
         QTqiv37OCVMy+5oEwlNBsw2cKiejzgZGAC7AZW2QPAu9cR2dMcfIteYf8vq02JyCIN53
         /PYiFz/vA+fp7KPo0fCiRfu55fCeLd5qLFIcUMGbAUVH1mkivaDzQTprXnn5n1PDT9pn
         6ZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794658797; x=1795263597;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nkM3J4QAu8kIsGHpB1EKb0NRF0JxtY2T/gqGpQ/nt0Q=;
        b=L8IAgvD0Kjcsco49vN7dAfi3b8AG+fpG4u+Iijo5x4YdHM+USHxlE70AzG/Q8EZV8A
         IRkwcA20RIOOVaUNpLc02L5JKE1ip4HyWyoR1ulAh0Brfy8CjOkOA1kCqtRq0wK5WTIp
         Y1QvwV748fxqEADhxjaxO/glsj1eYOgPAe2BjQpepChaf0ZSfMFC5YS4+ej/qAs+MBNc
         /ywaTcm7uirkHdoEvP6CA2tOeldoRXp1OPjiE1pSMH4Q6OqA4H9SUWDpCYBjMNwuJ1US
         lxky79oEsy58xOVqJc8Z3vRVaSXXglaZPbfrvopdF2w1/cBxx5ZArKX6JOTukhmd4Zwd
         uXyA==
X-Forwarded-Encrypted: i=1; AL+hErEd9D5aYM9wmzRTGswYS8eaKdRA4MwEvMJxvSaIGF6U5e0QB9gyOd3UsGfJwQZyaUm+JK7V1iEYckqF1gDi@vger.kernel.org
X-Gm-Message-State: APuU4Z9EgsGQtakQEOX80Lp6KvnjsZr6XxUbnals2T6Q/0ywYB9SDinz
	LBke+dREx+jZ0rjf+eEO3fXz5hHKeltGbvfdz0BzZo6jhG5vwOJAluhZ
X-Gm-Gg: AYBFou0zp/OuvHsWqqV59kCE/n3MpT2yDtqrQ91cHoYLJ8jFsdnK5fwR4R7cNeG7swj
	d/dzHdAMCEyhoeXNECNvhAqGurDAQJKu0SHrauRwFGJMngVf/K8yZ7su1nk3ng4WhAdKJb295wr
	p279/rU+RtBKV3Zk75yomimFmAwSh3TIsc+R//hpAHFe/1Ikl4U3d/3OEtb0i9exZnGXM/7Xegn
	jq1v2zGT+VKBxgxIj+d4QzwDI/14gSG/Z+SFbRgaEyiRbNkZvuYNwQSXwZ38thEKQ4doOlv57YC
	EVvadQtHel+NNFGjUA9z8opxCI+kPMjw8T/tOwGdwLoK3hJoqSiMne8PXF9wPEJagNoCdGt8r+j
	oBb54NUeQMZin020nUN4reuXhjF9ijjI/lpgqxmesZINrhn5IoXhEXWllYKlQIFhey3xe7MOZzP
	PupmngbogCLY8LiHcJ2RiBPEHmDNowoWqXBgxl+ZXt4mt4NuC9rWPYZ/6tB8G874NYsxT+jfzWj
	B8lnMIbhcYEkreEYKVLwQ76TtRdg8zvmsXb4BE6NUOWBnERuag/768u3Ee0w2UPGVmPxC57Gqjf
	FVyYvjRENebbQbdA+0SjxJ92lFIpfCev9nurFmSII8M9Fb6n0C4UfSRWCad5+XRWMSJfH9sPGCv
	Na/t3qDRgIdYU
X-Received: by 2002:a17:906:1001:10b0:c41:4512:560d with SMTP id a640c23a62f3a-c5096387b02mr309942166b.16.1794658797424;
        Sat, 14 Nov 2026 04:19:57 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b5ac2asm211518966b.55.2026.11.14.04.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 04:19:56 -0800 (PST)
Date: Sat, 14 Nov 2026 13:19:56 +0100
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Shakeel Butt <shakeel.butt@linux.dev>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org, linux-unionfs@vger.kernel.org,
	bpf@vger.kernel.org, linux-nfs@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 10/12] ovl: take freeze protection when storing the uuid
Message-ID: <avhR7DbNbVDCyPDO@amir-ThinkPad-T480>
References: <20261114-work-fs-frozen_writes-v1-0-f5ae61c898b1@kernel.org>
 <20261114-work-fs-frozen_writes-v1-10-f5ae61c898b1@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261114-work-fs-frozen_writes-v1-10-f5ae61c898b1@kernel.org>

On Sat, Nov 14, 2026 at 11:47:17AM +0100, Christian Brauner wrote:
> ovl_init_uuid_xattr() stores the persistent uuid in an xattr on the
> upper root. That happens after ovl_make_workdir() dropped its write
> access to the upper mount and before ovl_get_indexdir() takes it
> again. So a freeze of the upper filesystem that lands in between lets
> the mount modify a frozen filesystem.
> 
> Take write access to the upper mount around the xattr update.
> 
> Fixes: d9544c1b0d9e ("ovl: store persistent uuid/fsid with uuid=on")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

> ---
>  fs/overlayfs/util.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index 521717209b2e4..67aa7b71e9c83 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -829,8 +829,12 @@ bool ovl_init_uuid_xattr(struct super_block *sb, struct ovl_fs *ofs,
>  
>  	/* Try to store persistent uuid */
>  	set = true;
> -	res = ovl_setxattr(ofs, upperpath->dentry, OVL_XATTR_UUID, uuid.b,
> -			   UUID_SIZE);
> +	res = mnt_want_write(ovl_upper_mnt(ofs));
> +	if (!res) {
> +		res = ovl_setxattr(ofs, upperpath->dentry, OVL_XATTR_UUID,
> +				   uuid.b, UUID_SIZE);
> +		mnt_drop_write(ovl_upper_mnt(ofs));
> +	}
>  	if (res)
>  		goto fail;
>  
> 
> -- 
> 2.53.0
> 

