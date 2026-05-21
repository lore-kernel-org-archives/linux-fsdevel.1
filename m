Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC6B33F597
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 14:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374739; cv=none; b=uKlzmy7+KzIu8KNXQy7I9+pkgxxeV5CF+4b+WHmYiWvt1DJXj7ejxBs8Fx9TVT1rkZ3QBbkdNJKHC7f6gwmKS7U7LGIbUnUwFVylkXcexY1XDo7qiH1Je4oh01ouroNTC4lq0CfFOUE8aO2DOM14JDXvF6rwcU1ndRtbpAVklq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374739; c=relaxed/simple;
	bh=1FDax2ITlPGkK9GWM4Kk5hh5Iu9Jo/XTctQgyZ3HFd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aExYs5xkLutCzTSDN9BB5zpZd76iRyRGNSwawflXw90NBvwYSosmydiAUtFsSc43cpS0Z9y+Mp9hsMfoeefqPO0F1Tis2en3PFhzrfuco5IQIEvCNpzx4DDL3CV8E9lyTmVfVZJdFUeHiadH2V1xr3BWm93qrrxWh0BPFcOWCPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgIn6fhM; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgIn6fhM"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso46475475e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 07:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779374737; x=1779979537; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kIWgYSgSur7+TFprKVyhVWjT/8EMs0z3uzklm4FTqYA=;
        b=OgIn6fhMMtxL5dR/Ife+0IdHFexxa8j1dKQ/YRPGSkVGvAKgnqMu95v6kAam1OYWlW
         w8Cu3Pxl7nxqKpW5hgElRKsu8iiKyIGd8NlI3q4dErLwn1FzDi/mNUGYyHZyEIp3+FmO
         aNt+81ELjVONAB72TZ9tpgY5yDngxcSsvXUk+iFPh5yOjSJPk7WOZ0KaJ+0hxe+OwDXT
         6/afSbsBvIGAbhi4xYmU1u073v+zSKjW8vYY6d8BjyIFWcjylzltizNw0qVqyEmix1Qm
         tX6OvGb8he4fSj2KmtqpmCP6meGKX5uXedNdTyqMAH5ikbXJkQcNVMVG57/IIx5wUHul
         R8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779374737; x=1779979537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kIWgYSgSur7+TFprKVyhVWjT/8EMs0z3uzklm4FTqYA=;
        b=o1GLo22ki1LDSrt4nVuNpfvs+OpbqSjCsNLbOROn2huWcworLU6+xeSqzvoi3yMlD2
         YzUx+mCPS00psaV7+DGmK5deS17k8uHSe39duDlVvCxL5avKxNWE6Kv09/j0Bpdj//+e
         9/fFjUOJZiSa8O37MzwxoE8nYvlEMcf0V9nFn5wPNqfu5T9YkrUeYOLSzEEJpSq3iMiF
         dEZ6q9I5e76H19/3ihds5b++QoqJ+oLq3o3QKbEX0u73PZVr29XDjAvAZPgqeWo1zw2P
         po3X5M2Pax166e6Jex/bBvMB2awhnEgcBnLmKSR4OWCi60+180IfTVKGMbt4OoeElUpl
         QiHg==
X-Forwarded-Encrypted: i=1; AFNElJ+2pzuXzpvx+ypeYEJBd74LMHaHBRquX4pYJF1+UXKfU9Bfd6ysHmprvU0ncFE4VnN/sez9RvkqExb3iVzk@vger.kernel.org
X-Gm-Message-State: AOJu0YzS4gbv3aD0OVOnJc+KjoAnvjpTLUjQkEe9QC2IXxG+abp6Q9HM
	2EGcsN7VvNSICEoh4G8nXYEXjZziRGPX3qT3J+OPzhjgqQfyjfpFAnZv
X-Gm-Gg: Acq92OEFE8+36oCP2z5fhVH/0n0JndNDkrIZ+fyJsUAs0+QBraTKS36arTqvLVgXcMV
	9+/VL1I3WWO0bo2X8pHl4cO6lKrtGH0hbj4iD7MyujOzRr++9Tt1WKN891KLT+YsIM9sUtMzwHC
	wWIlVdgNNDuZVsN6FqM0fm3kNTvKfNhhD2quR4u4e5MjhPobT9d2u5BsCBinuNwjWWE+29cuTsy
	DZkxaKLBPFBYvweByfrF9ESNY5X6vKkJv+CBzNWmIUfum3FEk/hJs8BM1XRvwbWZ5RyrJygQsoi
	PIktBxnZi8qC3vVKI9Vje/5ZBilimAVZTK3RNRjuy7MikJcC9m6PoC3A8KCnJlktUQKRwnDILRN
	nVDhyrTzm0ZgedrC9//54xABS/FX9Ddz4uDnQN/BncjK4w/o/9y8yOh8Mgm2rQAW5Qc2dUgZXYy
	O6V2rM0x/da/keNHtXi6xUee7ByQsQQogs8V3Dso65qBcGHSuuOGul2SmhSH///SVXJ/vsHS4=
X-Received: by 2002:a05:600c:37c4:b0:489:1f08:91b with SMTP id 5b1f17b1804b1-490360a87a0mr49352355e9.16.1779374736601;
        Thu, 21 May 2026 07:45:36 -0700 (PDT)
Received: from f (cst-prg-92-135.cust.vodafone.cz. [46.135.92.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903cadc125sm24701585e9.10.2026.05.21.07.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 07:45:36 -0700 (PDT)
Date: Thu, 21 May 2026 16:45:28 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	thomas.weissschuh@linutronix.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhongling0719@126.com, stable@vger.kernel.org
Subject: Re: [PATCH] fs: Fix lock leak in replace_fd()
Message-ID: <m3xus4s4xup32v7ijjolq6p3tlrj3bpwettldpqwxcwxanfvyt@5ihbtgch7liv>
References: <20260521074934.49256-1-zenghongling@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260521074934.49256-1-zenghongling@kylinos.cn>

On Thu, May 21, 2026 at 03:49:34PM +0800, Hongling Zeng wrote:
> In replace_fd(), the function acquires files->file_lock but then has
> two return paths that don't release the lock:
> - When do_dup2() fails (returns negative error)
> - When do_dup2() succeeds (returns 0)
> 
> Both of these paths return directly without unlocking files->file_lock,
> causing a lock leak and potential deadlock.
> 
> Fix this by making both error and success paths go through the
> out_unlock label to ensure the lock is always released.

do_dup2 always releases the lock regardless of return value, so this
patch cannot be correct.

that aside, there is another consumer which would also need patching if
the issue was real

> 
> Fixes: 708c04a5c2b7 ("fs: always return zero on success from replace_fd()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> ---
>  fs/file.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/file.c b/fs/file.c
> index 2c81c0b162d0..d0f019fb0568 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -1361,8 +1361,7 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
>  		goto out_unlock;
>  	err = do_dup2(files, file, fd, flags);
>  	if (err < 0)
> -		return err;
> -	return 0;
> +		goto out_unlock;
>  
>  out_unlock:
>  	spin_unlock(&files->file_lock);
> -- 
> 2.25.1
> 
