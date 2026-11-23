Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795442891;
	b=2IydjuyxwYVWH4638hr/JZV3ZjW8E83hpQqrQxDhW0AmYIB0Zg79filpRXK2atOdAsq5
	 iN+s/m0DpuxjflcJPtCnEGdp9HbSiFXtkOUCq16XA8RI+bFQ5sJb7r5/cPdR/JEGmTSa3
	 wzwbEMAxYK1s+pSKqYIg/eZy7+LWGpqsPfTMcAQoFL8pp4OOZxfKzI46Np168/KmzWqAr
	 x2GmWJNELzywtDiqHvBvbKGaU0QFjGWhnuR8KhvcT0lQ4rygwH4oYTSB0Ey3tVwfs/7K4
	 qciP97ZJ3IwHk9YGh7v7zu/Hiu1soGpJ6pzTehjfhmkVRwm+QKcqMKta3+HI8VqKX1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442891;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=Uz1t2WKqlXJVIyc0jqpnA6TrFMwUBuQ3w8Lin5TW0wo=;
	b=VNIfG9671ovZB/8zjdL6lvTKAGjX6LIxZM7aur6qdIALjcxjFY4iAuWSOUbCyzRPJGPb
	 TboHomC38G015yx0Ut4YsW7GVu5m/+XqE5iQfZksOcEl1PZhr3YOXL2h9d3192Iwu/z58
	 TSt0OGSI9YS2A5CNqdICQ8+utrS7F97CPLjtMPdFnFXnMUjo9jFbNx6c+ahjfIsNWT/54
	 XUECXAkcQtgsxLLTh9JNCHYL0Y30XvfZK+KqYfJM21cpOY1IYW2oPtP6G4TEiMmDiOiPD
	 Y/SJ3kxrihYwwor3Po8zeIBbdpWqdvTRKMwsdhPDwJBKcp8S0q5HrUGQTchDNUM38SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=rm3d4Egd;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EB9606A31E
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 14:08:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58EB9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=rm3d4Egd
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so25707515e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 06:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1795442888; x=1796047688; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Uz1t2WKqlXJVIyc0jqpnA6TrFMwUBuQ3w8Lin5TW0wo=;
        b=rm3d4Egdg95zqoJ+AzUgcOFS3XW4sheOZ1VwzC0TWizqkgSfFE6+zkmGcoyDRDqsnW
         KY68jdkXnGEYwccHsTtIWM/vWE5yv9XU4YB7kvVX6npNGon4RrzX1ls2h+IROSLZc14/
         kIt1jVKga0PUjxX+aiYbxd5kkdkQCJyFr/WXMXbLsfDOCwO4OioMbVe1LMk5l+za0ckZ
         79X337svb2jnvQmo2Uzf1ej/JM8WP8xeZKcfWs4Y8Dr4O4b9+w631GY8puxKRt+O4RcY
         chw0+J8Xad1M5me9c9yCxkznwQSKBXyZw3Dlp6VUCymSG/LaKntJsGb5GGFwLp9TCMhd
         AO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795442888; x=1796047688;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Uz1t2WKqlXJVIyc0jqpnA6TrFMwUBuQ3w8Lin5TW0wo=;
        b=I68Ja6Y1/W49XkHiFQTgbmzcvcaFlGIbPB10vVoNLWqgZfwhFs5iY4aBtgLkxSCSdE
         2+tHqwT2NMjWQcSQDVYRCEMugn4GcnbugDHlqF+7Zh94UfqrTOzypP+p3oml+cFqjNpv
         sOAvX0gPZhIs5iUyUS0iEmBRtO7gWjP39d+zS29cyl5LUDpBiCe8Tw1D+2XuLKBDb7H3
         WSwOo8N2vxsxpd+jAXCSmkfBJiCOp7J5SmSEbv0TEenONkr2dNnPTqDO79qSjizEWZ2S
         l7eYIVKwuEq6ynCLi1MopZd5v6jDx9c0K2NMM4vHxktdW0wrU5C8tsZuHrCTaApGw9l5
         KwXA==
X-Forwarded-Encrypted: i=1; AL+hErGmgedBSszMNVqWD1+Ll/pBGSv5Jn/An5IY5Q4FDZtXq5ZEtyvNAZDHuAjptHu+/0SlO9R74Din4AJT1wTL@vger.kernel.org
X-Gm-Message-State: APuU4Z9NNJcTmVwGmktNq4Sr8lcA2TQxFeiQv6J+lmRKp+L/xssro2cY
	geZLYpXTkgyAYVspvLlvUf3G5OUEpBfqFs4BiTyhbyKnL+eyo1cQb4nm+MXO3f+M9zHP
X-Gm-Gg: AZFdTZciMyNCJhN3keFDvRJxoGyHieg+gVMu5dcGBJCNQKUDB1l4BhgIoI0Fq/K1Ov/
	ACrhnsd+Lso7gjKVNNCsqyF3QXAhjt3wT0pyOaCRGbhs58lAaJx4GGVZ/t8aK+pOdQZXPSWboeC
	VeYbmMo4iz2u8EcJG/CHcXMNitLAQpqoUJEpP1vryakT5hR64i9lMCKaw0Yu3YqkEiwcAIk7fab
	f7vMxXHWb8bBET7oxl5kV4SZhnymjMj5pTAgepFxH9ssM8WkCyafIY5wT0kfXVf3XM1tOdDLHpR
	OkQ80YovikeKeobDdkc0tkZ0L6ZUs4AlIBsqn0TwBkgNS6zN2sFzS+b8414lrAxZzlt6fkb9o0G
	NSfsqHP+hoedEqKMfvuk4xMQjZIOjQgQO3qOYlyCCKFDyfBmPYWxheDzeAN0hoqBysigRe4FJYR
	EQqoTFEbzrYqavu0ZFO0s0VTVCjbjzVRz47Eu0lTTTlrcgkpls+VD3yLOGt+WefnVqCn4jilC0I
	Fv2qRimkFFHQhsv8aML2SdSx6eWs4FFjBeB9pRqLvcLQ7y74V4ZhKnuOK/9okYcx5NZtQ9Vki2G
	V3V5NznQg/+qEbu9ZobBpq3Tvi9Rakysv+X/j7XDp72hhJCJkvOUgIRWGh1GXkT3wpJTs2lQ0kk
	VsbTLOw0+nAUheZKPIvuX6L4rDw6I80UoKyRgftbWh47P1DykEcY=
X-Received: by 2002:a05:600c:3e1a:b0:4bb:6814:7391 with SMTP id 5b1f17b1804b1-4bb8881921cmr230462625e9.25.1795442888314;
        Mon, 23 Nov 2026 06:08:08 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:799:2965:d32:cc64? (p200300cf572c2800079929650d32cc64.dip0.t-ipconnect.de. [2003:cf:572c:2800:799:2965:d32:cc64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b09bsm659142555e9.4.2026.11.23.06.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 06:08:07 -0800 (PST)
Message-ID: <9de7d49b52769206709d87749085cc453aabf104.camel@amutable.com>
Subject: Re: [PATCH] xattr: enforce the name and size limits for in-kernel
 callers
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Amir Goldstein <amir73il@gmail.com>, Christian Brauner
 <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Chris Mason <mason@kernel.org>, 
 Christoph Hellwig	 <hch@lst.de>, Theodore Ts'o <tytso@mit.edu>, Carlos
 Maiolino <cem@kernel.org>, 	linux-fsdevel@vger.kernel.org,
 linux-unionfs@vger.kernel.org, 	stable@vger.kernel.org
Date: Mon, 23 Nov 2026 15:08:06 +0100
In-Reply-To: <20261123113513.1910906-1-amir73il@gmail.com>
References: <20261123113513.1910906-1-amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, 2026-11-23 at 12:35 +0100, Amir Goldstein wrote:
> The xattr system calls refuse a name longer than XATTR_NAME_MAX and a
> value larger than XATTR_SIZE_MAX, but the VFS helpers do not. An
> in-kernel caller may pass a name or a size that it got from another
> filesystem, such as overlayfs copy up from a lower layer.
>=20
> Check both limits before calling the xattr handler of the filesystem,
> and fail with the errors that the system calls return for them.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> =C2=A0fs/xattr.c | 31 ++++++++++++++++++++++++++++++-
> =C2=A01 file changed, 30 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 0705801a62cc5..824e8349e8c10 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -178,6 +178,18 @@ xattr_permission(const struct mnt_idmap *idmap,
> struct inode *inode,
> =C2=A0	return inode_permission(idmap, inode, mask);
> =C2=A0}
> =C2=A0
> +/*
> + * The xattr system calls refuse a name above XATTR_NAME_MAX and a
> value above
> + * XATTR_SIZE_MAX, but an in-kernel caller may pass a name or a size
> that it
> + * got from another filesystem, such as the lower layer of
> overlayfs.
> + */
> +static int xattr_check_name(const char *name)
> +{
> +	if (strnlen(name, XATTR_NAME_MAX + 1) > XATTR_NAME_MAX)
> +		return -ERANGE;
> +	return 0;
> +}
> +
> =C2=A0/*
> =C2=A0 * Look for any handler that deals with the specified namespace.
> =C2=A0 */
> @@ -209,10 +221,17 @@ __vfs_setxattr(const struct mnt_idmap *idmap,
> struct dentry *dentry,
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t size, int flags)
> =C2=A0{
> =C2=A0	const struct xattr_handler *handler;
> +	int error;
> =C2=A0
> =C2=A0	if (is_posix_acl_xattr(name))
> =C2=A0		return -EOPNOTSUPP;
> =C2=A0
> +	error =3D xattr_check_name(name);
> +	if (error)
> +		return error;
> +	if (size > XATTR_SIZE_MAX)
> +		return -E2BIG;

Hi Amir,

> +
> =C2=A0	handler =3D xattr_resolve_name(inode, &name);
> =C2=A0	if (IS_ERR(handler))
> =C2=A0		return PTR_ERR(handler);
> @@ -416,6 +435,8 @@ vfs_getxattr_alloc(const struct mnt_idmap *idmap,
> struct dentry *dentry,

Don't we want to have xattr_check_name() in vfs_getxattr_alloc() too?

Kind regards,
Alex

> =C2=A0	error =3D handler->get(handler, dentry, inode, name, NULL, 0);
> =C2=A0	if (error < 0)
> =C2=A0		return error;
> +	if (error > XATTR_SIZE_MAX)
> +		return -E2BIG;
> =C2=A0
> =C2=A0	if (!value || (error > xattr_size)) {
> =C2=A0		value =3D krealloc(*xattr_value, error + 1, flags);
> @@ -434,16 +455,24 @@ __vfs_getxattr(struct dentry *dentry, struct
> inode *inode, const char *name,
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *value, size_t size)
> =C2=A0{
> =C2=A0	const struct xattr_handler *handler;
> +	ssize_t ret;
> =C2=A0
> =C2=A0	if (is_posix_acl_xattr(name))
> =C2=A0		return -EOPNOTSUPP;
> =C2=A0
> +	ret =3D xattr_check_name(name);
> +	if (ret)
> +		return ret;
> +
> =C2=A0	handler =3D xattr_resolve_name(inode, &name);
> =C2=A0	if (IS_ERR(handler))
> =C2=A0		return PTR_ERR(handler);
> =C2=A0	if (!handler->get)
> =C2=A0		return -EOPNOTSUPP;
> -	return handler->get(handler, dentry, inode, name, value,
> size);
> +	ret =3D handler->get(handler, dentry, inode, name, value,
> size);
> +	if (ret > XATTR_SIZE_MAX)
> +		return -E2BIG;
> +	return ret;
> =C2=A0}
> =C2=A0EXPORT_SYMBOL(__vfs_getxattr);
> =C2=A0
