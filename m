Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FC63B584F
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 20:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778532758; cv=none; b=pAK1ytC6vyIy7VGA2P9BHlNL1rfv6Fltw20GhPME/F4WD89I2NE/kEpEjA3CEI5ceI/sVpcvNl0w0jWFeeBPNFlDZ9t2eWHKOSaSO88b90sigh9CswVdtjEyQm7yTCfqcbkHNwhe2ocof03lpi1W7Avn8emWQsde6bGJChlRau0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778532758; c=relaxed/simple;
	bh=uz1BipeOxO/kV5AdCXAtVjrhZPFvsFevY1buu71ZRP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6bpzPcgWIy/MKrAY85ILO1n3WSDR0vlMJeHFFt2POIct54nnOIgX0b7ezVozXfuTO6Pzfw9+E/srfk8jHBRvOrN2BOya/WbqLFa4s7r/TZTOcuaIraJW5Iit5+XkmBG1PEAx1/YZ3O9sq4+JwLQqFRyNXxTvQNqQI/ZiR/m5MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4EsW0gy; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4EsW0gy"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-bcc1459daddso342934966b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 13:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778532755; x=1779137555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3YsA/sWweaP0g59517piytr1tPPtOa5YFwooaicDPx0=;
        b=f4EsW0gyJuaJmqFK19CVGUXjcC8bJzHbIPuixtBSLe6biw9OMtulrXtjPCM86Np5rn
         9i2Tcp54yzppLDsBobXIuI1UVz65C2fvR2+UJfqCyVZ/HumSX4FRFOdmkMWzGE1aF5ue
         tm8LzUi27MpI++8fL7/3nC1ctngtA3WTwdIajbDnvJl7sQ2LGy7yr6U4Fdc5CdCj79Xy
         Fl2I3tutvnjzJK7qNp8oYnRrovYo5i80M0PCzRzT1EeWVRGSxeP9YCLu5jbwbWc3CqYI
         IJmOL+zJGCyJI9AFOAF2zK1Q6Zv+hDFItQTOYuOLr59XtcBcypeXX2uj9BERJCb9uR+p
         FsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778532755; x=1779137555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3YsA/sWweaP0g59517piytr1tPPtOa5YFwooaicDPx0=;
        b=FXLmM6w6S/fngWqx3LLiZmfEv0lSvvgS/g1/DJdqLSosFd5t2Y0DAOL/2xTyFxFp1U
         SLucBp79cv8CeoKnMTZ7iNyJmjQwAMrgAe7qjuiYq/6QotR/5Y4BcStxioAK9cgSE41g
         KWUpHBdSbTPZ5izCAhTXUXVvt6aJPeetAKaig6IDfwqKsg/MPxJK18f5npkMVa+ssvJK
         GrWM9YpDVgkVWwX5gIRsoRYKwo5Hg8dMEGVcghure3vUkCKBWu4PJwStphZzVg+mvm63
         /NNSIo8zT07Kr0JMiqDjYFh3tRf+uXCpVcUnJkBm9EK7OH45wD4XBPsOl+YqfsfzZUPk
         KYqA==
X-Forwarded-Encrypted: i=1; AFNElJ+ucnPIQDun5c7JwpAiKc9OaYFGfPxwtPmw8Dmmx4xHlsbeWKLeSNPXowNlAVnOYymVpGLYvN8Jtev34igD@vger.kernel.org
X-Gm-Message-State: AOJu0YxKv+IsKsg1PsILFX2MWv3xOoZmq0GUlSPQ1Ny1BIP1QmfSfrh9
	KwvizDwX70x0qi5Eih9mW+DnfBwbyTeFPHEbLMLFJyThTrL8hyqZX4Ts
X-Gm-Gg: Acq92OElxriLfOziLfA2w94/OXXgbsyoqC0oMlYfGiOYjtoLP5EnmuYS+nJMFMvojtb
	nc7TthqeBzVdQyYuq4IcPHW+scxIlJ7IQRDucIuuLuJrwtoM5QYceC3PRQKeM/Z83i6vqTbdx38
	vMdE4S6O5oKqHmXfQrdBph6QF7JbxcliKqR5wbtJEtZGNkpgHDRnWHkXCscCgLC0DkEidlsoTlA
	aSoPpr0BRLfqJ+tvnCdh5kWVDv26+m55SgCx5jiAmVcL73OUE5OO6poOBdepcb77QhWuiUKUEwY
	JfirQKBbwC+KDDOZglwEmqUZksbU7KYgYq+hxWlvoyLTEqgGOgwXiZtS3hzWr5IHfVtWu0h3zMp
	AuPa+BSb/bW3GpcJRhLNGz/Wt1xAjCM+6us18N6VUJot91tGzh26IU/c08DF8sdrSVC34cCMi4A
	w4y6gbGPl+90frbJ0NxQvBMLXPuWbkNpkbAPzw1ML94Ek3xoZ9Jo2yPL8g9vmIRtBVR6MBvEWAq
	p3w19eM+AjBsY0VXMhwwzN0Q2g=
X-Received: by 2002:a17:907:c002:b0:bd0:39ba:8f60 with SMTP id a640c23a62f3a-bd039c9d5b5mr358958766b.39.1778532755368;
        Mon, 11 May 2026 13:52:35 -0700 (PDT)
Received: from localhost (2001-1c00-570d-ee00-8e87-6a4e-f2be-0c04.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:8e87:6a4e:f2be:c04])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcac3989fbesm546407866b.33.2026.05.11.13.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 13:52:34 -0700 (PDT)
Date: Mon, 11 May 2026 22:52:34 +0200
From: Amir Goldstein <amir73il@gmail.com>
To: zhaoguohan@kylinos.cn
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev
Subject: Re: [PATCH] fuse: use current creds for backing files
Message-ID: <agJBkmecYOl1MEgS@amir-ThinkPad-T480>
References: <20260510145437.321141-1-zhaoguohan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510145437.321141-1-zhaoguohan@kylinos.cn>

On Sun, May 10, 2026 at 10:54:37PM +0800, zhaoguohan@kylinos.cn wrote:
> From: GuoHan Zhao <zhaoguohan@kylinos.cn>
> 
> FUSE backing files only need a stable snapshot of the current credentials
> for later backing-file I/O. prepare_creds() allocates a mutable copy and
> can fail, but this code never modifies or commits the result.
> 
> Use get_current_cred() instead and store it as a const pointer. This
> matches the rest of the backing-file helpers and avoids an unnecessary
> allocation and failure path.
> 
> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/fuse/backing.c | 2 +-
>  fs/fuse/fuse_i.h  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
> index d95dfa48483f..8efb43b17c4d 100644
> --- a/fs/fuse/backing.c
> +++ b/fs/fuse/backing.c
> @@ -118,7 +118,7 @@ int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
>  		goto out_fput;
>  
>  	fb->file = file;
> -	fb->cred = prepare_creds();
> +	fb->cred = get_current_cred();
>  	refcount_set(&fb->count, 1);
>  
>  	res = fuse_backing_id_alloc(fc, fb);
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 17423d4e3cfa..36041e405bf8 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -106,7 +106,7 @@ struct fuse_submount_lookup {
>  /** Container for data related to mapping to backing file */
>  struct fuse_backing {
>  	struct file *file;
> -	struct cred *cred;
> +	const struct cred *cred;
>  
>  	/** refcount */
>  	refcount_t count;
> -- 
> 2.43.0
