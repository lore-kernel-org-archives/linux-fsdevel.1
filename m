Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A23A1A6827
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 16:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774456699; cv=none; b=WXMYFQFNZxJ9yfhxKd6kTMBp2kwnhsQ1elBVUcl6sWLYh36df1K8EHiERQnFr0XchGUdsuktGn1+ZmlJpDzUCcNYHBXnZJhaIjiD6kTaBF3OsOUHN3GiXS9dU3kkCMXlh4sbXQkfDZbUg6QK8yV+ugNIBkLlOHAq6yONX9GK/Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774456699; c=relaxed/simple;
	bh=7Q+4/8bmiqBbseXEGCjC5r1jh5loLlKGNz1RtJqr+VM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uj9i1qTctgSLqlvyUy4pLhVXsmvsCjxn0hAWziiyq73uVxwqF00YOWK6m0VmdaAzMVIeXsr3F5Nl/L4r0Dh+d5cb7JC04emD/4A+S+YYRHP9NaJRl38TzJPUuTXyfWMwQHXw3gtfnlkfyV+duAB3Ek8XtVLKnz2vtxaE+O2wERY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dlLYvOEQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BF7F/7mk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dlLYvOEQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BF7F/7mk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774456697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QSosCTg0i9Bjp9rt2ppYHK7BLAc30bqLbiVANu4SoC4=;
	b=dlLYvOEQQ9B75JvckUKhRjSNrpoYMzZ9zLd+m4LeeWXLER/rwdj058rLtmg9SmnFV88CtT
	+B6XdPERJX34A9WesXAvLK0lfRnKKuJnqnizSqCJLGjChqo/sTdr1gABGvOY6PAjZCjVwd
	sy7pN+eoV5ceBIkbm+EJD4EpmP1schY=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-fcvaJIOiM-ebQ6k-TPRVFg-1; Wed, 25 Mar 2026 12:38:15 -0400
X-MC-Unique: fcvaJIOiM-ebQ6k-TPRVFg-1
X-Mimecast-MFC-AGG-ID: fcvaJIOiM-ebQ6k-TPRVFg_1774456695
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-79a51ba2bf9so108337b3.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 09:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774456695; x=1775061495; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QSosCTg0i9Bjp9rt2ppYHK7BLAc30bqLbiVANu4SoC4=;
        b=BF7F/7mkGmo5Xk/0p90VLF5VrJv2E8FK3kwNMLQkT2sRsS4Zmjqt2ou0rKvYYEyb81
         WTeN4IE72uMPUDjVhwpa338x/uavBhpnTjm1IiwMJppuZ95GIBcLv4l/ZHFspjixqIqL
         kKznk6lSKI2mMjIb1UWa9/xCvom1h9axsGFlACJfRnZDvS9eFqoqejqfLEX2yx31yyuu
         Vit0aFNIvT0ef4Xh+dHloAGLVxPetGCmmkv41a/04mFLbPQ9M3uOAHGG5ESr0Nx1EOQS
         IClsFzpq/zajzNxm+5AJnJc1JNrx1P/zj6j4CW9Ff9Vvp8Jps5LUeErjzR7VyIOoJGgF
         iYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774456695; x=1775061495;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QSosCTg0i9Bjp9rt2ppYHK7BLAc30bqLbiVANu4SoC4=;
        b=JGUDx1ZaKpWxx9puibT9FScK1XYfVPif8dGH7hVACTx7Hv3DYIw8XRR46iA+3QgiZC
         w79iphRnR5Yr+clWnG3T0hzNVnDZTZKH48Vfqk94mbXjqZQ6ZVprU+uZdnoC0zVTcG8k
         3M3gYueuei9UhcWyamgJtb8oLtY6F41Sx55d+092MEvNu6zTzyRyiEUVQYf5OYIiFDtO
         lLexUg51r/UUOGyPy/GJQtPOvwGg7+VdQ2zqtu27U5X108DcIpFnY0r7aEbAA+0KUWP+
         Gu/YfH257wtvLrwuiOnvzrU8afhi0hdHsIR696/34/pplgL501Th78WN09k3kUMNpoBv
         7xaA==
X-Forwarded-Encrypted: i=1; AJvYcCXU9t/fdkPP9sdWGSOT0+/wNCOr3/QL44ZizXu/F2Hyhf+nnGHwdeeMD25qEgP/pNyXTN27WyLv6hK/FQj4@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp/RpdF92z497TxzmYp2029lybi4SDbYnqtcwJO9D0IDJQgsbH
	tTxWdu5zvKXGDwRFFjNY2Y+W5qxVutFPWd9LI4rcjxN7n3huab/5dzOGIUKaYy1ei7SqxTe3PSa
	Dk6LingwnVzOkMufykBz7wX01WYgYVIow+Ennr64QLkjDRvWxjucey1zPHILfFT8Hui5JayZs2g
	g=
X-Gm-Gg: ATEYQzwRu3n9nc7ig9CJC6QicINYz3ImeKTtnPehiBEYstjZBj4vxcN22vCbInaYJfI
	nobK3ytyFHkp6+JbJmjJEXWHTBbycW399HELuFVkrm/MfpjYYD8bOkDbeFuwbJONnUw36h0N+4U
	50lu6A9SnNbDbWvYgfUQxNdylxM4BbKHnlL87hlavJefWRy1jR+mNSxQ56/AKe06ha++sjccEvX
	e1/xJQyXBxqwSdFwDV0x3AOzsjMf4xTjjwrp9R4hWnWRUDUj+lCLQXvM0wgxYQINqfiVHco8Iim
	PVJZMfpryrlUmEf4vUkfHt08XZMSkFXQ+E0UonKS74kBn9l2ypZvWdbMOdichw9W0/s8oqaIPLY
	CjVjYNWI8P6qtYD/tlalTEg0i/gGRad5E9saVCoijUllILKrnTRN+
X-Received: by 2002:a05:690c:368f:b0:794:ef94:120d with SMTP id 00721157ae682-79acf39cd20mr45587357b3.24.1774456694569;
        Wed, 25 Mar 2026 09:38:14 -0700 (PDT)
X-Received: by 2002:a05:690c:368f:b0:794:ef94:120d with SMTP id 00721157ae682-79acf39cd20mr45586977b3.24.1774456693902;
        Wed, 25 Mar 2026 09:38:13 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::23])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79b10c6bf12sm484887b3.9.2026.03.25.09.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 09:38:13 -0700 (PDT)
Message-ID: <2b8f442c9f3982a745576a824e004867e4ff0f8d.camel@redhat.com>
Subject: Re: [PATCH 1/5] hfs: update comments on hfs_inode_setattr
From: vdubeyko@redhat.com
To: Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner	 <brauner@kernel.org>, David Sterba <dsterba@suse.com>,
 Viacheslav Dubeyko	 <slava@dubeyko.com>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>,  Yangtao Li <frank.li@vivo.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Date: Wed, 25 Mar 2026 09:38:12 -0700
In-Reply-To: <20260325063711.3298685-2-hch@lst.de>
References: <20260325063711.3298685-1-hch@lst.de>
	 <20260325063711.3298685-2-hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-03-25 at 07:36 +0100, Christoph Hellwig wrote:
> The top of function comment about hfs_inode_setattr is severely out
> of date and reference a previous name for this function.  Remove it,
> and update the comments in the file to record the still relevant bits
> directly.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/hfs/inode.c | 21 ++-------------------
>  1 file changed, 2 insertions(+), 19 deletions(-)
>=20
> diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
> index 878535db64d6..72948eb2fadc 100644
> --- a/fs/hfs/inode.c
> +++ b/fs/hfs/inode.c
> @@ -622,23 +622,6 @@ static int hfs_file_release(struct inode *inode, str=
uct file *file)
>  	return 0;
>  }
> =20
> -/*
> - * hfs_notify_change()
> - *
> - * Based very closely on fs/msdos/inode.c by Werner Almesberger
> - *
> - * This is the notify_change() field in the super_operations structure
> - * for HFS file systems.  The purpose is to take that changes made to
> - * an inode and apply then in a filesystem-dependent manner.  In this
> - * case the process has a few of tasks to do:
> - *  1) prevent changes to the i_uid and i_gid fields.
> - *  2) map file permissions to the closest allowable permissions
> - *  3) Since multiple Linux files can share the same on-disk inode under
> - *     HFS (for instance the data and resource forks of a file) a change
> - *     to permissions must be applied to all other in-core inodes which
> - *     correspond to the same HFS file.
> - */
> -
>  int hfs_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  		      struct iattr *attr)
>  {
> @@ -646,8 +629,7 @@ int hfs_inode_setattr(struct mnt_idmap *idmap, struct=
 dentry *dentry,
>  	struct hfs_sb_info *hsb =3D HFS_SB(inode->i_sb);
>  	int error;
> =20
> -	error =3D setattr_prepare(&nop_mnt_idmap, dentry,
> -				attr); /* basic permission checks */
> +	error =3D setattr_prepare(&nop_mnt_idmap, dentry, attr);
>  	if (error)
>  		return error;
> =20
> @@ -663,6 +645,7 @@ int hfs_inode_setattr(struct mnt_idmap *idmap, struct=
 dentry *dentry,
>  		return hsb->s_quiet ? 0 : error;
>  	}
> =20
> +	/* map file permissions to the closest allowable permissions in HFS */
>  	if (attr->ia_valid & ATTR_MODE) {
>  		/* Only the 'w' bits can ever change and only all together. */
>  		if (attr->ia_mode & S_IWUSR)

Makes sense.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.

