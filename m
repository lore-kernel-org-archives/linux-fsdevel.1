Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D1847F2C3
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 21:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790026395; cv=none; b=b+x/q+x6+bnFm2mB9ZEmNIr9oY1qx6bwS+CkTlBtmaUwBusjShcmgYCpOgJ/kbVzsV7torbNIyK9TGYu7lX5fRVa3A2eWpAlwX5xzRUgMzXEWwjGL9OHWNuIzdImHXZM1Mp9yXqm3SfG5azs8szMFMXtG4Jfc6f4EENxckMx9W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790026395; c=relaxed/simple;
	bh=PfkfUgBBH4+gt9nP0fAfRVLhu+EQ/uA/stjuvdTdtYE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cWh++JKLIBYSSxVuo6++AtgIN6cxLIR2eqSIKR0aBzWF4M6QMHxBDmDijlvy84uaSibVrErod14ETfBsAQIO5XHEINUe9OxmhCRyFZecySs/QuqSd+zWQqsJlUDFx8XD0dzGIRG2Bn9BCwgN3P/L/yAG8KrjIsHU6AYNY9NS0Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=0cB0l3vl; arc=none smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="0cB0l3vl"
Received: by mail-yx2-f43.google.com with SMTP id 956f58d0204a3-671563fb8beso3307804d50.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 14:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1790026393; x=1790631193; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/vtBA2br0mdFH+MTeFUpCL6R+w/dADsqHz7aoBQi8r8=;
        b=0cB0l3vlpUrUVYW2gP6CZRD3gkhHC6U9Irno7iioMwA6ecHOVLxm5v1l9PuWksUQ+6
         acfuF6kshORtq2qPYXkN3YP7SD4BsS8rhOKtIoP6/wRRltL3Qt1nyxpKLP7TYYOXTpGS
         TWPJirgPIuSzDzAIiaZqLm8omf1VXMjUbMcavUOzfJEl2k2mKKLUsO3GlFWZ9coB+B33
         Qaic1hSr+K5g5d2/rlALVIqfEbQ1CIX4uB31B/kRruzXv7uLK+ObxNMWZL8r8gmzFwqn
         KYpoylcOBYYPZDDYHya8AIXUZSUhRv/wjoDkDyQVQKy4j3AmeRy5uD57V4cIZseMr2h/
         aJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790026393; x=1790631193;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/vtBA2br0mdFH+MTeFUpCL6R+w/dADsqHz7aoBQi8r8=;
        b=Q4hkACj2u/E3vcprpWzbvLnl0haVLdVJs2GsI3SZVTTzOHOVg7HHUxY+B9BZJGQvYp
         9zCy+agZrgg0ANGVuW858QFCjNeUu1w2fNCWP85nxr22rT9wE5do0HvFtWFF+wyMu502
         111WB100oG+xEPaDVVM8Fb1603firNiSp+MD6Tom0vLQkWDkZR2d1Bs4AlZ5Be8hNcwW
         Ms2Jec5gA3/Xu9k4CLCSse0ClHZY5PI2LYv/eDYxSLmbYOKJrU7kbRvb9S4SiUhT6YVs
         K0Xm1mEnyekJIYHtHv4T039Km4Pl7oguZUlTinAZK4KMEjZxnCcIuyZs3Evi0LJ5VTdO
         5EJQ==
X-Gm-Message-State: AFuF++lLSUpUkZj5UxzBmzoT3niv7OCHlEpwLZwiSmPnEwk1mHSzLcC+
	CLa6X1sQUM+j3S/Y56ghUNy8fqtggoMUOBYBq0awU9GjmgVT5/qfYoHT0c1jbB7r33Y=
X-Gm-Gg: AYBFou29LeEIbv2GOv471fKmWZaz60w1xgNf2Qj9pzKh87DV+4f5HBUcPzTJpQwWMz9
	KehI1bK0aLN3fYroCAB3MTy/AR+hcdt/Wyq29m1tTmTCYjvS0k+ZamZerTkVMTKpl3Ipx+pERiE
	DNP1ngi/SePLOqhypGKSKdhQTS7wPYJt1P5yWbmAtkWk4EKCQ7sj/BBc1y5UXB4OqykRlPAHxml
	EqbUnckj6Hh+OwMSy91HVH15IToiXEq3UNfYFBhwRcOEusbprlMGF/oOrrUGtjRng6NGjLbSdDs
	JsOc7pnU9cWDjsZvAVZXY+3MWOCV0MP0gN8XGnjy2CtN882kPOrjt+8fYUkOk0hMQ8D/2vcdAdR
	AR2Dtv1u/s6t8K26H5CX6wrz56nTBoQsMxGspXHFVCOHuYRa6ftnCtNRPhlyrBuakTm6fXsYJ6l
	oSj6iN64dzqV9eVhqdrEv6JD3yBDPDU437SzA95gfkgeMTh9M8SDXYnlPA9XlDHUfzL4WIrlpVu
	kLXnJSt9/FnPJWz3tpXn6A6ct3VbSitLK8UZcjJ+ENpXQJjD6nYyyEv5ZsjaOSWuHOHQOdzkEpO
	7qWNMeEF2hFP960aGOOFnTM66sCX3MleSt+uwVm7aH7Vsj4tYlHVPD2v86JMqk90
X-Received: by 2002:a05:690e:4382:b0:670:f743:6eb0 with SMTP id 956f58d0204a3-672c55186a2mr73689d50.98.1790026393256;
        Mon, 21 Sep 2026 14:33:13 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:8475:e6ce:2d2c:ddc2? ([2600:1700:6476:1430:8475:e6ce:2d2c:ddc2])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-672c50bb1d8sm145972d50.20.2026.09.21.14.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 14:33:12 -0700 (PDT)
Message-ID: <1164821496f54d2fe03af44283d48db707a5e391.camel@dubeyko.com>
Subject: Re: [PATCH] hfs: validate drAlBlkSiz and fs_ablocks in hfs_mdb_get()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Hui Peng <benquike@gmail.com>, glaubitz@physik.fu-berlin.de, 
	frank.li@vivo.com, brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 21 Sep 2026 14:33:11 -0700
In-Reply-To: <20260919222605.3794529-1-benquike@gmail.com>
References: <20260919222605.3794529-1-benquike@gmail.com>
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

On Sat, 2026-09-19 at 22:26 +0000, Hui Peng wrote:
> In hfs_mdb_get() (fs/hfs/mdb.c), reject images with allocation block
> size (drAlBlkSiz) of 0 or not a multiple of HFS_SECTOR_SIZE (512), or
> with fs_ablocks =3D=3D 0, preventing a divide-by-zero trap and out-of-
> bounds
> bitmap scans on crafted HFS images.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
> diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
> index 277de712f9d4..9e78c561a3f1 100644
> --- a/fs/hfs/mdb.c
> +++ b/fs/hfs/mdb.c
> @@ -204,6 +204,11 @@ int hfs_mdb_get(struct super_block *sb)
> =C2=A0	/* These parameters are read from the MDB, and never written
> */
> =C2=A0	HFS_SB(sb)->part_start =3D part_start;
> =C2=A0	HFS_SB(sb)->fs_ablocks =3D be16_to_cpu(mdb->drNmAlBlks);
> +	if (!HFS_SB(sb)->fs_ablocks) {

This check doesn't look like checking that it's "not a multiple of
HFS_SECTOR_SIZE (512)". Could you make your check more accurate?

Also, if you started this check, then let's check that all these fields
are consistent:

	__be16 drNmAlBlks;		/* number of allocation blocks
*/
	__be32 drAlBlkSiz;		/* bytes in an allocation
block */

	__be16 drFreeBks;		/* number of free allocation
blocks */

Could you please add these checks?

Thanks,
Slava.

> +		brelse(bh);
> +		HFS_SB(sb)->mdb_bh =3D NULL;
> +		return -EINVAL;
> +	}
> =C2=A0	HFS_SB(sb)->fs_div =3D HFS_SB(sb)->alloc_blksz >> sb-
> >s_blocksize_bits;
> =C2=A0	HFS_SB(sb)->clumpablks =3D be32_to_cpu(mdb->drClpSiz) /
> =C2=A0				 HFS_SB(sb)->alloc_blksz;
