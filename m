Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795460958;
	b=3CAmNrDVSs6+lrqsJoWa/NTbaidRy0QEtbZ/dbDxIJ8O06g3CoyhSezxEtOg/RtorICN
	 bA6pYsAHto4WXumj61eVZnEkXDxVwvjcwq9+JGvu5/WFVV0RZmYJY5DNh1sWx92RjU7QS
	 e0DOk0b4+CkKdDdrdCjEGZS4UF2jCiSfV8GOXehSfebHquDV01LV4tHwkpMvwgvnuUBEn
	 QDoWoQjDXxLxj3IwdYE405KIIyPpgwgHlvlQmyrLXj/fEWMO/36k0U1kkvIEWDOxd4Eiu
	 fh9RK+1kKTm1LpuLe5hiMxCTtPVdB7ZYTVw/tIHD56XoVhxV6OoWtnA5/GQIEb1gBuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795460958;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=hnd4FzHApDCtU9UwjS+kT2hf5xcYx05j963Ux7biRT8=;
	b=jEL3o3JXZyzIRESwHDzVX0ON7oDBKvvdsLJX4NTYgom6Rf4tnfpwB4h08favQ5Z7LjW9
	 agNOhzc4pQptLrye+JuHpg2MzYRM4wurDFNj3WzyunnJ+911w5CdfLtPuk/OpnITmCyB5
	 h+sv5n0z0GSHFepuEWQCu2QO/lgNhSPM6vQdmrOotg7OZ3nwNq1foD3R3VZh5b9+t1FCo
	 Igmv68M0l1/FPiHsubYmi48pNcKLLoUqSbxMNWcIU83dJ8HCl47pZqs9MWgTOTDHMx9dX
	 XJL+SkwK/yOjtagrs3La7DBRRru1PXp+KcDmeKVuZwdjOHm69mjuq9XsW7pH/ZtoFPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=GZyS6fv2;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D96606A31F
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 19:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24D96606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=GZyS6fv2
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4bb85e07aadso45393205e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 11:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1795460956; x=1796065756; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=hnd4FzHApDCtU9UwjS+kT2hf5xcYx05j963Ux7biRT8=;
        b=GZyS6fv2Uol+dQe7OQZANbIihQkjmno/hg4JD/MjPHwf4JoR9n1K06zEg8hm3wvg+D
         S6tYpC0CxfDOtImwKqO7UTZhGDwO4l8uFj3QG39TfnkN2QfOVTMi6nfbMvlVtkerX/ls
         lCkZiaz2LXqgIEk4aznMg+ZsTwE8AvwwZBJGxTfihyZe2bnXx/LLOZr2axRzOj4vc2b0
         l1O97P/Ovxx1recHjJrAoSxFT8uzpu2rKsZXD88rrRIVIDdZEcWg7CEf6rPMoz2ElL67
         hLxMdBF9L/xSU6TqnoG2oY1IAzfNh9q2lxBkfo2hUAqL4pGv9ztfgokO7st8goL5cCR5
         Edxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795460956; x=1796065756;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hnd4FzHApDCtU9UwjS+kT2hf5xcYx05j963Ux7biRT8=;
        b=NpXk5EDw8fS3ENckWkDJhK86R/HwO/UerJCkYR0EhzDTxWPMtqj1jR6CZsVjQB5W4F
         PCCWKX+9wVLQJ5LFGYAXlT0sfUgKzaDWh0+6SLyl6Yv5TlHYIyFCtcxBOMHoJNBVFGBc
         liClb5JSjaN2/96MjAG6QnBcQBpFPlzKP5CGEpsLnGvIYPMqaajPp5gv/+AqUaIPSUmk
         ibL6tlWAWXbALXnZn3w+MCgDQSPkaB28/yelav82IVfR1yqv/gXJvY9qPlesUrDdUAQa
         jEe5/wznVisz1/ddc6Ja/MZW460xLAY2DRWGCwURzUQsZJOaAFWqGc/GpBKFqmPhSR/h
         P3Rg==
X-Forwarded-Encrypted: i=1; AL+hErHxjmLo4vwCcLYmhflh0hOv9/bN2Lyt8cFZxVGMJ8fiYIshn7y+hG3ZFLxHYBaiRbXpj3clBAb2OXbQn847@vger.kernel.org
X-Gm-Message-State: APuU4Z/H8/w+8YjtmZNPRfM/GnLDKQWGHCGwl8eT+e5cp1SOhj1h4C/J
	ysoIDxs/lEs2pcO5Tsqisj7hSo7tuGLYyub6kqO47HFY4xApK/D7NaeLNk0btEv2mkeT
X-Gm-Gg: AZFdTZeMrDGkzFzRRSUWTTMo7BuHsmf12V9llYUYM8QJNGvLhzrS8dgsQ6ph8jy6NSX
	8UBKZScarWvcyRwoYa1XtalGDuVPHScmr6vKzFwSh/vg+n1XzPI0qmmzaCJrL50zR6aP3kXKR6V
	xh4hlIyaAL8UfjIs1bBOHWMdxDmEu0T3olKNDutQ2DnKQbKhFQ64ielC15J+1AgGWQPf84YwxL5
	DW8oWq2YyqMW/sOoCCJ4BE+VaRUSmfevZIKV0NDKcPbZtoLRDFKDgRbds6azyMEnJ5gOqIcmQAK
	w4Jmk+T31l+kqeu063GC6rUq6jHAxlsWkJbKEDbj4JejQ5IE4TWBsvB+9PSNn/IXBzYpSYwCwCX
	SV3KXEp5QcW10JRJIrS+nDk5sV96JH3dCVyPKLMrVydbiInKdUuPIa2Pjavd+ET6MSMRIqyvq0/
	aZ6bgcbiQnXfR+5s8WD41w27HT4lNcm9nxgf/ymYXTZCErOsNJq0+xq1j6dzyRkIGNwBvY/NgaE
	vSCg0Jj9aZYLkuenaM81Vr5SVLBnplEutPOs6e6NgGJfquZVBoDRshB3UPr60E8aaReCgIljNQ8
	YFQ3w/J8p4PECi7kR7YGQfAU4Cps6NgrwfMCr0ImsGCptGQwn2fsp1PZ/Uv5kEokWtTnBBajEh4
	pSCzcyAL+UqzP5isGeQD5bciUvLeCQKMxZN3HiQ==
X-Received: by 2002:a05:600c:4e16:b0:4bb:69b2:d3df with SMTP id 5b1f17b1804b1-4bb88813024mr261994675e9.25.1795460956179;
        Mon, 23 Nov 2026 11:09:16 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800::777? (p200300cf572c28000000000000000777.dip0.t-ipconnect.de. [2003:cf:572c:2800::777])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884911e3sm441832355e9.6.2026.11.23.11.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 11:09:15 -0800 (PST)
Message-ID: <f47ec71229a8238f23819995884faed725304247.camel@amutable.com>
Subject: Re: [PATCH v2] xattr: enforce the name and size limits for
 in-kernel callers
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Amir Goldstein <amir73il@gmail.com>, Christian Brauner
 <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Miklos Szeredi <miklos@szeredi.hu>, Chris Mason <mason@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Theodore Ts'o	 <tytso@mit.edu>, Carlos
 Maiolino <cem@kernel.org>, 	linux-fsdevel@vger.kernel.org,
 linux-unionfs@vger.kernel.org, 	stable@vger.kernel.org
Date: Mon, 23 Nov 2026 20:09:14 +0100
In-Reply-To: <20261123165807.1939942-1-amir73il@gmail.com>
References: <20261123113513.1910906-1-amir73il@gmail.com>
	 <20261123165807.1939942-1-amir73il@gmail.com>
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

On Mon, 2026-11-23 at 17:58 +0100, Amir Goldstein wrote:
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

Dear Amir,

Please, feel free to add:

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

Kind regards,
Alex

> ---
>=20
> Changes since v1:
> - Check the name in vfs_getxattr_alloc() too (Alex)
>=20
> v1:
> https://lore.kernel.org/r/20261123113513.1910906-1-amir73il@gmail.com/
>=20
> =C2=A0fs/xattr.c | 35 ++++++++++++++++++++++++++++++++++-
> =C2=A01 file changed, 34 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 0705801a62cc5..fb5e43d4ff356 100644
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
> +
> =C2=A0	handler =3D xattr_resolve_name(inode, &name);
> =C2=A0	if (IS_ERR(handler))
> =C2=A0		return PTR_ERR(handler);
> @@ -408,6 +427,10 @@ vfs_getxattr_alloc(const struct mnt_idmap
> *idmap, struct dentry *dentry,
> =C2=A0	if (error)
> =C2=A0		return error;
> =C2=A0
> +	error =3D xattr_check_name(name);
> +	if (error)
> +		return error;
> +
> =C2=A0	handler =3D xattr_resolve_name(inode, &name);
> =C2=A0	if (IS_ERR(handler))
> =C2=A0		return PTR_ERR(handler);
> @@ -416,6 +439,8 @@ vfs_getxattr_alloc(const struct mnt_idmap *idmap,
> struct dentry *dentry,
> =C2=A0	error =3D handler->get(handler, dentry, inode, name, NULL, 0);
> =C2=A0	if (error < 0)
> =C2=A0		return error;
> +	if (error > XATTR_SIZE_MAX)
> +		return -E2BIG;
> =C2=A0
> =C2=A0	if (!value || (error > xattr_size)) {
> =C2=A0		value =3D krealloc(*xattr_value, error + 1, flags);
> @@ -434,16 +459,24 @@ __vfs_getxattr(struct dentry *dentry, struct
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
