Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E833B27ED
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 19:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911364; cv=none; b=FiA+GzDgaYLUAu5ZW+0CNAxAT470hXbQQPGwy1JMnsY/w177Y26Veg/DWvWVQ8qE5RhKNpqcWGRDSYzHddFvBmDgUXW6QVOluz7oiARy73sdt7i+Y/nsQPa3C9pYC2jDrJD7dHbDfBoMCq1OyQjYQVBIa7A9vQAYXAwIl/OVhsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911364; c=relaxed/simple;
	bh=1VX7dQqrhyxM42aOJqsFe18tEj1zm1eELprqELEHgWw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RCfVoWvaDf7gEuCHxhqLBoNo03z5cixf8di14GApEP7+29bPmHJSAzU7YPpwdL94Hsj35h+zt5YlEICZpaYs1UYBptBAYbFRord5AXWgR3VTgnVAXgSXzWVDbOkSYtRvAD1N7T3bipIjquwp/v8v9DWiAUeABQnnqpqgVcvkQ0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=oIlGoQEL; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="oIlGoQEL"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4854166e1efso6224533b6e.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 12:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1779911362; x=1780516162; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iGDr2RH1M47w9vRwh+ddVqffMm7NNJFajgGCLuO3PlA=;
        b=oIlGoQEL+P6iqaXh1XCBYigYf8JgwClcm4E8z3Kv/JpBrw5nNJi4keyaNvg7JM+Hv6
         xu/Uup5dMo8XYELmmVCgcqzE0aUKq/ihnihq8LdVa5Lmu0jP2vZzTujCOLywcJiGivfJ
         X9kmXaUbQwGNJChZkfilK8srmmgDH7JPp6+nBrLwUMh70wslMQsvBqZlNwsqtbIa6Q74
         sQvgIvcqe/qmTvbOYBtSynGILaS+bDbRB/hY/5eo9Bp+bG6D77ipDqSdO5Ua53melShi
         m/aE5PfuJDbxW2GO/X30g/BAFPL61q+KDNptfOzZ5386noHuZhjbA2Gvl5D60J5V9LdK
         +JrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779911362; x=1780516162;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iGDr2RH1M47w9vRwh+ddVqffMm7NNJFajgGCLuO3PlA=;
        b=Xjp4qhCK2mhLfdjcjGeiTeLlPKg9ksMzmiThFK9TrQZtPslVzjnxyjZ9dlpNSwkdV7
         aygBgVmgrkj5WjXgO7e+WsdMmZq/bssu5FxCTVXpahSmPh2eLJApWIxIBhG0wwD2rLWE
         v4nS9D9J04C6xmExnLitxLTDCORPFyP6K/AtEgARHqXbZ9V58MsepbhcMK033R0kOwNr
         XV0vlMASHPLapVmrYE4DV1fRL9aGsgZQV+0FI6AOBZ7RE6ozdHQ6MkGC9twc32GFCNc5
         /nHZTQ3gRN4ZbbBb8Dc84ItpnitUlp3nII9JTToBxs/CtISs/ErSVDqv91fxqtBzhwta
         ORwg==
X-Gm-Message-State: AOJu0YxZa1ZW8KZcRj5Wdk0WtNN5ZEQpYc4yrCLVVCXMb+4NAltWPndb
	B1PBIgl7QJLedpVt4v7EQurdmfMH3CwA0ahdNVHlKSVKIgzBzQlx0QaDKuq7QhJxZIs=
X-Gm-Gg: Acq92OE4btbgT+H+UBWJSF/qjJXHKdDXoRscAXBL9jrlZNJtORW00sCZcPUqUqSUhAI
	DpyUEXDvGvjStqCWGpAJ0PDCk6eiIxjwrc5sACB1WmqeuUYtgssiX0N9dPrJ8C2E9JaTYcZ+gSU
	Z1RPuhGrRdvGY8/TQeiSBEhheoD2+2Xbfn2fyxiRvliEtw/BQs9KLaQDQx4FkpX8PIYjn1J7Yvf
	bQdu2QOJNzaVM1M45KEseB0MPUOrYmeYArXhWkF4e4gPWKlYDuuOolcTAZCLUOxUTRsl3S4FGEk
	SH7oa09Fe8/p4EjJntCZVo5pfqrPdkZVHiT2pbmQhSDuQ8jRQ9h4GM44mJnwQ1PG9pTw9+A2Q4e
	TzYQ9G2EsNXc2dGBSG4zcd4Z1pSVquSJwqE8yFHNliK4hEeTVjay0FG8usAgGtsncb3KkCixxyx
	ICd/1uhC/nzUr6xOH9XApuZ5yFAzvzENOgykesPOcZ5mt49YlY5TomufsOR7GHri9UXp35Ens9z
	Vwsd+SYtTWvdx/6ZKTu4IZ3eNBs9RIyRjZuCzncXrVRIAFrlV4cZCTLSwmWUhIETSccwJDDa6QF
	bRg=
X-Received: by 2002:a05:6820:1f05:b0:69b:bf80:2db3 with SMTP id 006d021491bc7-69d7ec8a6aamr13540638eaf.44.1779911361897;
        Wed, 27 May 2026 12:49:21 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:ba8:c4d7:97bf:1bb5? ([2600:1700:6476:1430:ba8:c4d7:97bf:1bb5])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b63512d63sm16848068fac.2.2026.05.27.12.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 12:49:21 -0700 (PDT)
Message-ID: <1d26872db999da42b2d8452ace8a98b79e569cc8.camel@dubeyko.com>
Subject: Re: [PATCH] hfs: reject volume bitmaps overlapping the MDB
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Yue Sun <samsun1006219@gmail.com>, glaubitz@physik.fu-berlin.de, 
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 27 May 2026 12:49:20 -0700
In-Reply-To: <20260527153206.85701-1-samsun1006219@gmail.com>
References: <20260527153206.85701-1-samsun1006219@gmail.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-05-27 at 23:32 +0800, Yue Sun wrote:
> hfs_mdb_commit() writes the volume bitmap while HFS_SB(sb)->mdb_bh is
> locked. A crafted image can set drVBMSt so that the bitmap byte range
> resolves to the same buffer_head as the MDB. When writeback later
> calls
> lock_buffer() for that bitmap block, the task tries to lock mdb_bh
> again
> and self-deadlocks in __lock_buffer().
>=20
> Reject the image during mount if the bitmap byte range maps to
> mdb_bh.
> This checks the aliasing condition that can deadlock writeback
> without
> trying to validate unrelated HFS layout fields.

Even if we reject to mount the corrupted, then it doesn't resolve the
deadlock itself. Because, location of volume bitmap can be potentially
incorrectly modified by HFS driver internal logic. So, anyway, we need
to have the check and the fix during MDB commit, anyway.=20

>=20
> Reported-by: Yue Sun <samsun1006219@gmail.com>
> Closes:
> https://lore.kernel.org/all/CAEkJfYMB47v1yOWHB8q2dc8kf=3Duj-rLO=3D+yMyudw=
PguJ8Kd3jA@mail.gmail.com/
> Signed-off-by: Yue Sun <samsun1006219@gmail.com>
> ---
> =C2=A0fs/hfs/mdb.c | 19 +++++++++++++++++++
> =C2=A01 file changed, 19 insertions(+)
>=20
> diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
> index a97cea35ca2e..abaa636db938 100644
> --- a/fs/hfs/mdb.c
> +++ b/fs/hfs/mdb.c
> @@ -99,8 +99,10 @@ int hfs_mdb_get(struct super_block *sb)
> =C2=A0	char *ptr;
> =C2=A0	int off2, len, size, sect;
> =C2=A0	sector_t part_start, part_size;
> -	loff_t off;
> +	sector_t mdb_block, vbm_first, vbm_last;
> +	loff_t off, vbm_off;
> =C2=A0	__be16 attrib;
> +	u32 bitmap_size;
> =C2=A0
> =C2=A0	/* set the device driver to 512-byte blocks */
> =C2=A0	size =3D sb_min_blocksize(sb, HFS_SECTOR_SIZE);
> @@ -185,6 +187,25 @@ int hfs_mdb_get(struct super_block *sb)
> =C2=A0		sb->s_flags |=3D SB_RDONLY;
> =C2=A0	}
> =C2=A0
> +	/*
> +	 * hfs_mdb_commit() writes the bitmap while holding mdb_bh.
> Reject
> +	 * images whose bitmap range can resolve to the MDB
> buffer_head.
> +	 */
> +	bitmap_size =3D DIV_ROUND_UP(HFS_SB(sb)->fs_ablocks,
> BITS_PER_BYTE);

If you are trying to operate with MDB field (mdb->drVBMSt), then you
need to use drNmAlBlks (number of allocation blocks). I assume we
already have likewise calculation already. Could we reuse this logic?
Or HFS hasn't this calculation logic already?

> +	if (!bitmap_size) {
> +		pr_err("bad volume bitmap size\n");
> +		return -EIO;
> +	}
> +	vbm_off =3D (loff_t)(part_start + be16_to_cpu(mdb->drVBMSt))
> <<
> +		=C2=A0 HFS_SECTOR_SIZE_BITS;
> +	vbm_first =3D vbm_off >> sb->s_blocksize_bits;
> +	vbm_last =3D (vbm_off + bitmap_size - 1) >> sb-
> >s_blocksize_bits;
> +	mdb_block =3D HFS_SB(sb)->mdb_bh->b_blocknr;
> +	if (vbm_first <=3D mdb_block && mdb_block <=3D vbm_last) {
> +		pr_err("volume bitmap overlaps MDB\n");
> +		return -EIO;
> +	}

The volume bitmap should be located on the volume after the MDB record
(superblock). So, it's completely enough to use the mdb->drVBMSt for
checking the overlapping with main MDB record. Potentially, bitmap_size
can be use to check the overlapping with with alternative MDB record at
the end of the volume. However, volume bitmap cannot be so big.

Thanks,
Slava.

> +
> =C2=A0	/* TRY to get the alternate (backup) MDB. */
> =C2=A0	sect =3D part_start + part_size - 2;
> =C2=A0	bh =3D sb_bread512(sb, sect, mdb2);
