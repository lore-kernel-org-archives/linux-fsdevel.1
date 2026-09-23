Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA80B569F20
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 19:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790192246; cv=none; b=G1brobTbJcd5NsUGWdNPDDyfsmXx3/aWsDeamCAKtLRd8ZsnLlr2ljEQ1lXLraMWFRIKQumubMggRrn3sQNrm8bsdIzaOA42f8VSmO24n8HeNaV+GGUJjQiAFUbrXgFGqoP+rJoazcf7v2vD2f5egyydAF40iEuBaNRhhhyfFaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790192246; c=relaxed/simple;
	bh=JLzZSoPIlpT92wrCJe3bJKnULDFaKnYRop08lI3wxtI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tS2crs9uFJXDihJ6I1FrTHojCnhbNTs+zWXDZXxWRrJdgIrEldX2erJFsl7cxe7W7kVxpH2ODkQWizt3BkGBmLzP5zgezDFi1mBW/WRUhT/Ad0acxIQD8MnXnKXlkOckZ/hmzaCW6QeEJtKu71JbibuV8f1TSE2hGyN5ghrErSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=G6UiEStA; arc=none smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="G6UiEStA"
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-895eaf30817so21544997b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 12:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1790192242; x=1790797042; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=loBYYtQi+U/lITiqeVwilMMdTEV6PFCxnUE1D2PL3Zw=;
        b=G6UiEStAzS/7qLCkb4j5eX+HcLNPI+C5uqlDs6Q4AyXCz640mhwvD7dmEc3FWKnCoA
         P4A+nYWKMmq7wDNDw3uiezPk0VHF0DHwL4vbfEfEhFiAZ+HKvtxvId8VD6imrmoMbwBp
         AQTlpHwFFNwP6tIprfupTr+RTNy3V/NBp2HGlzSFWbpkaB/SGNAXBmC7k1aq/IixuX4H
         WCcm9DUyGBZoS2/2j1kek83QiI2v3v2tVGPgnqe8ibZS+ZYthEFpwA8hzU8s3hlCdcJI
         DfDqmO82qui6FBENpnTAYhF1rz8QIC8Qsk0wzm0G8ztNVYEDXcK+1IhVQcEVa0yAEmfl
         KkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790192242; x=1790797042;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=loBYYtQi+U/lITiqeVwilMMdTEV6PFCxnUE1D2PL3Zw=;
        b=nWmdRDkZNTUd48ITo8Kg9HEc62RXkgsEJJMu4TFf2hT00SWG+4qYbooX/bLu82Xu7d
         qxtlbUuZa+K61Uv2rmm2C12+u/fwdItz3BOFdJbR7SySY/Nk7NdyL028RrQD53j+g926
         7nv3zvtOqDG42am6tA0BD/lc9ZNtEqTo5Ds86sHAYoC1v5K283Z64QJaBagkc5q/2yrK
         mEZqtfPIasKR/AqwF2g4Ny9KnMHqyetXvKe1V8jVpnlcJ7mZ2kw+V+pX6n9oak+um2aK
         IUkWDam1SiQyIu8jWwkQKvA5jVg+1H72Mss+oZ1bmgcoSgQzat898r28Ys/WqCqewjH+
         dpOQ==
X-Gm-Message-State: AFuF++mqUZ7rWZkUM7q/M1i76yCsVcse48x2r2J7/y94g9z9jOMbgGCV
	BSXTH6KvOuUbxcSGZDvhL4MunFJNEhAUvnWnH3H6VMEGv3c1yw1zLLVH7v9hZ1Q+2rv639YHjyh
	mPXa0bsvabg==
X-Gm-Gg: AYBFou2Lq2rVuIcTIH627dSrguIRO4Wwq44X6gDGSSYXtV8IJzcThsJ3ZcloyJN49sI
	6o621wjLi0RJtUtvArshjdV7t9zgiysswo5IZwojQ8gnh0W8g0Fpb8dDPNKqFRvGNeuLZrkLD7S
	TseBHqtmamAIL1z+PwObDaWrTg41ZMWGs0tglys/ihMbSs0FLQ/f+oZPscic8MgSkYk5eyUi5l9
	QVFIP0LFpKgJEGABkkfY5y9VHuPjUFrg9X2cQr0s8Peyksm+DLNWL1T+2UdL/hfVvKTZggQkTMq
	lo9HD8whEVvfZNwssKqLXuhk9Qr9rcX+hSP05k/K05HId7f8rTRD4gMq/bnMA7xsFOT9s70tcrz
	4qGQCbwU/9BNaFBPeAe4zWO7i2xKnmLCWD6zlddDw8b/AZ9FzXJjeIuln4OjzTRkuFGb/YXQxgT
	Nu6WvTARjwP39fJGlrANk0KpUILI0Ts0I0tmWtqvEQOurmeoC14i5Y3jLxG5Alr6DU/7hXB7CCa
	pWEgpEON+ojndwXb1WRJd3ETluQp9/n/XtNUnb+lJlcS85i/9b1meYNpu1trAO9Qy2Rks53FMyG
	nMWDDEmyJHpaWvlIXdHWfhmDpSGbI/nDMuOTjhs6htZiMVqdL6McxdejUB1NIpSY
X-Received: by 2002:a05:690c:e251:20b0:85a:89f3:f53 with SMTP id 00721157ae682-8a64ca2fd13mr1033917b3.24.1790192242366;
        Wed, 23 Sep 2026 12:37:22 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:25ba:d67b:9196:e10c? ([2600:1700:6476:1430:25ba:d67b:9196:e10c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a64e7e9806sm525637b3.6.2026.09.23.12.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 12:37:20 -0700 (PDT)
Message-ID: <c569d5f8ee542e5c86a7e4dee23df99f4ec0becd.camel@dubeyko.com>
Subject: Re: [PATCH v2] hfs: handle extent B-tree write errors
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Davy Felipe <davyfelipe34@gmail.com>, John Paul Adrian Glaubitz
	 <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 23 Sep 2026 12:37:19 -0700
In-Reply-To: <20260922234039.1307375-1-davyfelipe34@gmail.com>
References: <20260920160213.285316-1-davyfelipe34@gmail.com>
	 <20260922234039.1307375-1-davyfelipe34@gmail.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-22 at 20:40 -0300, Davy Felipe wrote:
> __hfs_ext_write_extent() does not report all failures while updating
> the extents B-tree.
>=20
> When inserting a new extent record, the return value of
> hfs_brec_insert() is ignored and HFS_FLG_EXT_DIRTY and
> HFS_FLG_EXT_NEW
> are cleared even if the insertion fails.
>=20
> When updating an existing extent record, hfs_bnode_write() returns
> void, so its caller cannot detect a rejected write. Validate the
> extent
> record size and node range before calling hfs_bnode_write().
>=20
> Propagate errors returned by hfs_brec_insert() and return -EIO for an
> invalid existing extent record. Only clear the extent dirty flags
> after
> a successful operation.
>=20
> Fault injection confirmed both failure paths. Insertion errors are
> propagated to the caller, and invalid existing-record writes are
> rejected before hfs_bnode_write() without clearing the dirty state.
>=20
> Signed-off-by: Davy Felipe <davyfelipe34@gmail.com>
>=20
> Changes in v2:
> - Validate the existing extent record size and node range before
> =C2=A0 calling hfs_bnode_write(), following review feedback.
> - Return -EIO without clearing HFS_FLG_EXT_DIRTY when validation
> =C2=A0 fails.
> - Fault-injection tested the existing-record failure path. Before the
> =C2=A0 change, hfs_bnode_write() rejected an invalid offset internally bu=
t
> =C2=A0 __hfs_ext_write_extent() continued and cleared the dirty flag. Wit=
h
> =C2=A0 v2, the invalid write is rejected before hfs_bnode_write().
>=20
> ---
> =C2=A0fs/hfs/extent.c | 13 +++++++++++--
> =C2=A01 file changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/hfs/extent.c b/fs/hfs/extent.c
> index f066a99a863b..13426503fbb3 100644
> --- a/fs/hfs/extent.c
> +++ b/fs/hfs/extent.c
> @@ -121,12 +121,21 @@ static int __hfs_ext_write_extent(struct inode
> *inode, struct hfs_find_data *fd)
> =C2=A0		res =3D hfs_bmap_reserve(fd->tree, fd->tree->depth +
> 1);
> =C2=A0		if (res)
> =C2=A0			return res;
> -		hfs_brec_insert(fd, HFS_I(inode)->cached_extents,
> sizeof(hfs_extent_rec));
> +		res =3D hfs_brec_insert(fd, HFS_I(inode)-
> >cached_extents,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(hfs_extent_rec));
> +		if (res)
> +			return res;
> =C2=A0		HFS_I(inode)->flags &=3D
> ~(HFS_FLG_EXT_DIRTY|HFS_FLG_EXT_NEW);
> =C2=A0	} else {
> =C2=A0		if (res)
> =C2=A0			return res;
> -		hfs_bnode_write(fd->bnode, HFS_I(inode)-
> >cached_extents, fd->entryoffset, fd->entrylength);
> +		if (fd->entrylength !=3D sizeof(hfs_extent_rec) ||
> +		=C2=A0=C2=A0=C2=A0 fd->entryoffset < 0 ||
> +		=C2=A0=C2=A0=C2=A0 (u64)fd->entryoffset + fd->entrylength >
> +			=C2=A0=C2=A0=C2=A0 fd->tree->node_size)

I think it will be better to introduce a small check function that can
be reused then. And code will be cleaner here. What do you think?

> +			return -EIO;
> +		hfs_bnode_write(fd->bnode, HFS_I(inode)-
> >cached_extents,
> +				fd->entryoffset, fd->entrylength);

I see that you are trying not to go into huge modification. But,
frankly speaking, I believe we need the refactoring of
hfs_bnode_write() calling. This function should return error code and
we need to process this error code in other methods. Maybe, future
refactoring work for you? ;)

Thanks,
Slava.

> =C2=A0		HFS_I(inode)->flags &=3D ~HFS_FLG_EXT_DIRTY;
> =C2=A0	}
> =C2=A0	return 0;
