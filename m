Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795779355;
	b=oxmFv4Gy+NCT7xj147lQsy3bwTJirtGk1CAvoBkT8UgP4H5xllfQDLDM4gLEuPZGBzv7
	 NHP9HMI3uEJCz0qxzD7i6tWXy6KqZVBJ+eq+0Ovj+OrTjr1XnU9Z1QwebjBXpssv236aE
	 LEbiflSrrjDnFZ6RkYNde5OPyCAyErvZyJzeetiBg+ntXZRDIqlCTQCHEO0LxYIwn+SvG
	 MdCeE+MdMGe+wJwyhNvL3gpBnon7LUv11vnK0N0V73Q+9iRJDqc8DmmSteSOqcbOIaMzm
	 zaJxwjegBnkYiDw8jxwGO/YrGsgpwVJV0NWKylHpt0jKMiCu9MHwr+hN4J+cNyKkDsA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779355;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=zckLxKTSVIvkUKQrRBT4ZQPN8xSZzGvjPSGz1nKrgeM=;
	b=1d2r+G/FNk7DMPlXvO9mtSiYFViJxU96GS8nOkis1CUC/05NeHCL+gwB+7FnO/N1JPOX
	 Hg93Y5TTlkj+r6WHs4+b/YupSANzYjuLiT4fKN9Q7KejqLwIC3w/efrebOuHLZDucs21+
	 VE4SQLo/ksYKkI23VlQtZHWO8i3e3fb4bLURBKRnFYardx/vt6JU7DqFTPcGKz8xbGZqR
	 cGL/21GwaVguOZMH8TJLcVdMPXMbNrxgVcw/EK67HGc6V2674JIV/iDmmCSiMCm4VvzrH
	 vhMdHXV6dkhbRy3ULe4ebDdQ0C5fnnuS+Ho8NkMofOxNE4FhfSz7QauWpFNcz6ABA1Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vfl6nsas;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13698606A327
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 11:35:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13698606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vfl6nsas
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b87a240de3so10020990a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 03:35:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795779353; cv=none;
        d=google.com; s=arc-20260327;
        b=iR6sW9AxqbNR7xa7WAEQHInGFnBr2qxOZ0wZZ1GUqLue5tpizUxqMRybYS/2CctutA
         6NYvXEO0XB2LJYebTW2bCrUVObCQdhofclR7rQl/qgmqCbwXjm3VxhnXvPthM2uTddM/
         t2TgFhPaEV9YnZD58FUeZMN1Ufz3KEY2tJMmSrSvJ9NMDr9klQHfK9KUkdfEEfy7nLbM
         HlsSgDOEEb2W+NroX11yEFup1T6ssq8WPa1qe0ttSj24XlZY21E8A/mCRXKpVb4HSh/A
         0r4s0y9UWw6dulcu7olODm8x3YEQh4/tAJXmU2k810LL/l21dx5nzmsc5oXz2sBtyYnK
         ZMxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zckLxKTSVIvkUKQrRBT4ZQPN8xSZzGvjPSGz1nKrgeM=;
        fh=c18VFcBL93+mNu53bBo4S/dXjrF/yq5oauALfMpiA+c=;
        b=oE6GIpphsGg4kJHvTY09/3IXXbZ6x5ly76qBWFMMBEALssRAs/yPQSBJsohwQLd/Zb
         rPvz7ZWwqyER1R7Wi6fol/q83itP0htwdtCpeq7HdXmgwYyF8crYWaXg+ibPGhEgtNgS
         zJ36gnRJJALsV4PMSbUThxDBoGCGCWQn9CFcseUMQEl3KikebWYIPxKOnO3O5LZkhUKm
         aIP9+mnHe1JWZ5tBs5teOtxywoc2cwxlCZTlnPCPIxXPj0tohz8rx6GsBnHvHLbBSJl6
         bvQwweOa1RvDSTJI09gj3myysOQvRH4EBt/qewbCoWWMGKVK9OBvjTbEbSbodlXoe249
         2wDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795779353; x=1796384153; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zckLxKTSVIvkUKQrRBT4ZQPN8xSZzGvjPSGz1nKrgeM=;
        b=vfl6nsasnL9MeKJC3PKlnSrIcRDT85xssIPtgR+brRFXXZVzFiEq6BssOPBNi+U1NX
         rACDgNvbgFoECMBGeOSxlv7f9ZZPlw8jbFZGiBU72Swu1vfaeCoxTTziHNw7UcLrHWJR
         AKKiFDsyO93LUbEmoG+hHJdZEh650ptJD3odyQ/w9fPYc4PvSJ0mm2Sf5PxZt3k35+Xr
         wxob5ZuRAYUg/cXXu2K92l8bOQgHSH8rodtPWHXJuG7bBF/5TfgeoeRbDB0Wy/K1sCCD
         uVtxcxA6CrL6WBmCavRtirj9U2/SaEAzfTB9jrKlSoL4xIH/1z47TjHh6YE/4ycLvzHM
         m/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795779353; x=1796384153;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zckLxKTSVIvkUKQrRBT4ZQPN8xSZzGvjPSGz1nKrgeM=;
        b=iV0itH5SkI/JBJ52nrz5UuUf4mIh8EfHgqHs29ZFoa6zQlIEdHyXdvKgi7KdKNhLkQ
         0vP/Y5KrwkNy4UAoHLohldYF67J7rlYfGJkAhRC6DIz4fmnrluAvuc6Wwu/Et+GN6LGu
         qMQD+t0SHrrKpGB32ueMBhT8SJSpIww8l007cv90Ex3/YRwYlauaML57cbGG/pNRqkx7
         VGni7ATFFX/7d6i6mrmAlrpK+Xd08lCD8WZ+Wz6wFJBx67dePbbNwLfNVw49Ai/Qk+S8
         NiiCJypF2LUdZoMOfSjGdfdWQjrxlbCbkKd2341WQqniYqOKOm8R4zXFyiXFVtjq8fmu
         G/rw==
X-Forwarded-Encrypted: i=1; AL+hErHefkfLKeJ38ht/7zBqptPwwOCI3F+Gr5F3WEGwyM2C8cb0aaOLSxwu7eFXfF/RkDaO8Kqab18jG7yK3bse@vger.kernel.org
X-Gm-Message-State: APuU4Z9ZuVGjmeY9tLS60tjtNmkbXn4NL3gRhmFTt7nX9ELk8rq2MBHw
	UxPmoNUQY573+g+1m1tN9lp20ymQMgwVSlkjOx+Fztk56xC3jmuJqHXNMivwpPv1clK5q65oAqH
	/O18pKhLvseBgaERKuXD2T/uwNSP+Aqg=
X-Gm-Gg: AZFdTZeI9/FPDF4D3bk5yHrmLw3PUmo/dTbmAbJzOCbwRnX7/D8hM8S+Kt4j4Fq1Adp
	BDL2yQmY06aEl/wrD2vDxTQ5BfIXvh26AvbpHH/CQRCxSiGOGoS68JuMLur6l4oA/+CdyMU8gbb
	U89RraQeLet3ZVExKyi/FX6N1ukQozxHFAPnNmKyrTYYXgSsGPoUjfFONu+ZDaXOXH3FLOyIAAx
	z+UahzLCH3ymV/wMuorx5pHTPMtmO/disPCmH7QsgQYWXYoKjHeLk1muW7mGXczgkgbCTrmRBJj
	eetW4BzlsemWkMTPsDWgANPO7wma4g42BUMNKdg838Jgn7yGKc+TqOZm7z87btf9X+9vQhgBj0b
	bufVJBO+8o4VjDQgsQ4TXzBPv7ZeoN+4UoWJIP2dIPzTm6H4NchqtWhr4WcYNI3JjwtBgKw==
X-Received: by 2002:a05:6402:42cd:b0:6b7:b872:27c0 with SMTP id
 4fb4d7f45d1cf-6ba37ebff16mr18720566a12.44.1795779353347; Fri, 27 Nov 2026
 03:35:53 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261126163114.403846-1-koray.fra@gmail.com> <20261126163114.403846-3-koray.fra@gmail.com>
In-Reply-To: <20261126163114.403846-3-koray.fra@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 27 Nov 2026 12:35:41 +0100
X-Gm-Features: Aa3M54oDVUmD4L041vA_Ja2kzcuIcnu49jvnV20FPfNA1gUDEEUT8nV16GU1jvk
Message-ID: <CAOQ4uxjGLfuZMFABCwMvdXwnU+P24G_aTJLudWbjeSmWwyDF6Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] fscrypt: update fscrypt_prepare_setflags() to use xflags
To: koraynilay <koray.fra@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>, 
	Eric Biggers <ebiggers@kernel.org>, "Theodore Y . Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexander Aring <alex.aring@gmail.com>, "Darrick J . Wong" <djwong@kernel.org>, 
	Andrey Albershteyn <aalbersh@kernel.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Lauri Gates <lauri.gates@gmail.com>, Christoph Hellwig <hch@infradead.org>, Dave Chinner <dgc@kernel.org>, 
	linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	ntfs@lists.linux.dev, linux-nfs@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2026 at 5:31=E2=80=AFPM koraynilay <koray.fra@gmail.com> wr=
ote:
>
> Update fscrypt_prepare_setflags() to use FS_XFLAG_* xflags instead of
> legacy FS_*_FL flags.
>
> Signed-off-by: koraynilay <koray.fra@gmail.com>
> ---
>  fs/crypto/hooks.c       | 10 +++++-----
>  fs/file_attr.c          |  2 +-
>  include/linux/fscrypt.h |  6 +++---
>  3 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/fs/crypto/hooks.c b/fs/crypto/hooks.c
> index 149498bdab94..52d6a33fc9e9 100644
> --- a/fs/crypto/hooks.c
> +++ b/fs/crypto/hooks.c
> @@ -182,10 +182,10 @@ int __fscrypt_prepare_setattr(struct dentry *dentry=
, struct iattr *attr)
>  EXPORT_SYMBOL_GPL(__fscrypt_prepare_setattr);
>
>  /**
> - * fscrypt_prepare_setflags() - prepare to change flags with FS_IOC_SETF=
LAGS
> + * fscrypt_prepare_setflags() - prepare to change xflags

prepare to change the file attributes with file_setattr() or one of
the legacy ioctls

>   * @inode: the inode on which flags are being changed
> - * @oldflags: the old flags
> - * @flags: the new flags
> + * @oldxflags: the old xflags
> + * @xflags: the new xflags
>   *
>   * The caller should be holding i_rwsem for write.
>   *
> @@ -193,7 +193,7 @@ EXPORT_SYMBOL_GPL(__fscrypt_prepare_setattr);
>   *        another error occurs.
>   */
>  int fscrypt_prepare_setflags(struct inode *inode,
> -                            unsigned int oldflags, unsigned int flags)
> +                            unsigned int oldxflags, unsigned int xflags)

This here is a backporting landmine -

Changing the semantics drastically without changing the helper name
or signature.

Please rename the helper something like fscrypt_prepare_fileattr_set()
so that backporting mistakes will be caught at build time.

Thanks,
Amir.
