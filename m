Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7256A3B5847
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 21:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780090195; cv=none; b=oxVtQBeDvy1B/s0f8I35EfF0rooaB8M+Hux1z8y2sCXTjiabiJe74D9SPLjLuaosoXPA5rZMSYq9AmZjn++hrh1XPeh829UEpqF7/2fLCBuios2ZsncxsfChU1HK7dMRL36TshC46ggLmcgcPARAtrqGfeqdz/Pw544VH0CfaJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780090195; c=relaxed/simple;
	bh=w4xQFU5tRgjfLbPEt8TjimZcmZhh9cbrlSHwZ+a2Zic=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=caYVdecgUKEZm8LaqEqzVLI9XyLaj0sCJKMHTvPhibmOYLTH31n0feP1BjcMwxWbXKtXfjOrH1yyPGhRkQNzBqJtM6r2IFO3uYV8SkuDORbV78ulWvOV7AiQz0WcPAUR6GNjJDVORFuy7jIRr2iUbOvaw0zawHro3uTLAiG4yJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jOeuW870; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=G/cBHvrH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jOeuW870";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="G/cBHvrH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780090193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HgyT9tLzh1QiCnPkW1tZpnmTPoK8Bx2AucQrx8Q+VSE=;
	b=jOeuW870ix8ozQ1GAv7qT3xEKU14nNwwO6+pyusocZCa2OIL7vl/vlsv+yKa+G33jJhlA8
	/WjfscrINkk6iUpDEYhIZfhy7a+PRrt/84p2JFMlu6IJKTdVm13LeOGkmfQOP1U/xV8AX3
	3iE8dH0oPd9v7sAedXwt79rQ7Jbm8F0=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-3ZgJqIG9O4aob19OL_SyUA-1; Fri, 29 May 2026 17:29:52 -0400
X-MC-Unique: 3ZgJqIG9O4aob19OL_SyUA-1
X-Mimecast-MFC-AGG-ID: 3ZgJqIG9O4aob19OL_SyUA_1780090191
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-485421d1109so5503453b6e.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 14:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780090191; x=1780694991; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HgyT9tLzh1QiCnPkW1tZpnmTPoK8Bx2AucQrx8Q+VSE=;
        b=G/cBHvrHs0f0UzYw9A0fq+HLPIqt1+8ZOV7zrREfsmQgPs7iGQubnC5ILIoZhfBFxb
         H559f3sdDjdn2AwYjvg1+rR+RshM9vAhu4SYFeyyHoN4vcvLzmSyr4R3ytD8tJdVP5l7
         7ZH1CcHGr44xJZqN6Jut8dO1v5mh0C4NeTcSEt6PNg3W00oDKPAdiMzMOrr+XrKs05Gi
         K++Hkh/jdTmLHEVPj01r2gqaYgrBSqXxXfLGGE9iR/sSsL1/xdJBeMGB+fHqD4N01S2a
         qKp4KCjTQzd8nXSL3SpjwS4DDdADgi4IBTyYbbAsiBa6kxDqJnurrr8ihXZ6J26aRj1p
         sz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780090191; x=1780694991;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HgyT9tLzh1QiCnPkW1tZpnmTPoK8Bx2AucQrx8Q+VSE=;
        b=puS3RZjkUw2vZKu1/lZZ09p5KUZAj2l2fILrDgyXaTzhE5bgflKk0RsdsMI8ucqqKW
         P2uGn0XgnpDivMJv052LzXzmgbQjmfWLLGbp/P7A3EjxxuBHjXW0b/qmQblGOvSLpKfJ
         nt1cb84TOMpM66SiQQ0k6jEePBPi/pWu7fyEcMjP2i43cfp+o+GpzPSqBrEFeZGIODeE
         33uAocre8RLl0hZg8FxxbQh74hxFqt5EUgt1ut7322/+rXF+7Gcy2THOSZibDESYbecz
         /x/L5+4ZjP30v/P1VZmytdz9HfDHAbQrFu/YaHmWId4iwWBN1Wyg+DwsR5o3dqSyiMoy
         eIyQ==
X-Gm-Message-State: AOJu0Yz5h2ooJi2kIybI55Uhaer/l1LEMXWg7iV3y913ORfCadUm1x0h
	KyQJSkQpPY+cizhDD+M/8LdnSUri4aaYzEpJBUBa2ulEYDvS1hHWVvEF1bVAwfT2bc1LQcKwYhv
	FfwKGT0bmLlE8sDgdTWlBA3scCsEn50sxaUJosUQofMpG5jTD2Ch4CF2HczeA2JtMxsQ=
X-Gm-Gg: Acq92OHwRT85+Uyaf2/f86Haaq20UleLKWWdBUmvICBG5dASIgE/FkKMW9J6Im7TLxa
	gER0Ku4F4nXb8PDcCU0oNWwOf0ifDCvf9ofrRD5BgGAxaqL0bcLwlgbnfT7JbhjRr4blwwFBVrA
	e6ljacd2ryfIUvb/JaRol4qR9unNpt8OUVmx8smtRnb0eJcndbccs+iglY2KYashf26zbAtg9tO
	07nD3Nu3N3qEhDc/NUC6OmDUB3K0gJaadRW89SYsAgLhzeH+Crv9TuXJMWZ+JSjBg/oNGeAsgfZ
	Q8c+wBSpO5i+gKd75iOltVIoVLEbH37PRuQ+wWvmjVzZlAfeX9HYEo01LEnmCZktzgBeSZJ8lKQ
	80wxetNqfkKbPfzrq7lTD6nXM7RxHMuuXshlfruYRk7neh3PrMghPvybRs8Lupi0=
X-Received: by 2002:a05:6808:6ecc:b0:466:f60b:19c5 with SMTP id 5614622812f47-485fb2fdc9emr788230b6e.6.1780090191288;
        Fri, 29 May 2026 14:29:51 -0700 (PDT)
X-Received: by 2002:a05:6808:6ecc:b0:466:f60b:19c5 with SMTP id 5614622812f47-485fb2fdc9emr788214b6e.6.1780090190818;
        Fri, 29 May 2026 14:29:50 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43c93ae0eeesm1838696fac.6.2026.05.29.14.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 14:29:50 -0700 (PDT)
Message-ID: <09c2bf1e91f7ddabc24240379cd7dd0b4e15dd8d.camel@redhat.com>
Subject: Re: [PATCH v2] hfs: prevent MDB and bitmap buffer_head aliasing
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Yue Sun <samsun1006219@gmail.com>, slava@dubeyko.com, 
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 29 May 2026 14:29:49 -0700
In-Reply-To: <20260529103428.99099-1-samsun1006219@gmail.com>
References: <1d26872db999da42b2d8452ace8a98b79e569cc8.camel@dubeyko.com>
	 <20260529103428.99099-1-samsun1006219@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-05-29 at 18:34 +0800, Yue Sun wrote:
> hfs_mdb_commit() writes the volume bitmap while HFS_SB(sb)->mdb_bh is
> locked. A crafted image can set drVBMSt so that the bitmap block resolves
> to the same buffer_head as the MDB. When writeback later calls
> lock_buffer() for that bitmap block, the task tries to lock mdb_bh again
> and self-deadlocks in __lock_buffer().
>=20
> Reject images whose volume bitmap starts at or before the MDB during
> mount. Also guard the bitmap writeback path itself: if the bitmap block
> would resolve to mdb_bh, force the filesystem read-only and stop bitmap
> writeback before taking the buffer lock. This keeps the deadlock fix in
> the MDB commit path and reuses the existing bitmap size/writeback logic.
>=20
> Reported-by: Yue Sun <samsun1006219@gmail.com>
> Closes: https://lore.kernel.org/all/CAEkJfYMB47v1yOWHB8q2dc8kf=3Duj-rLO=
=3D+yMyudwPguJ8Kd3jA@mail.gmail.com/
> Signed-off-by: Yue Sun <samsun1006219@gmail.com>
> ---
> Changes in v2:
> - Add a commit-time guard before locking bitmap buffer_heads.
> - Replace the mount-time byte-range check with a simple drVBMSt check.
> - Reuse the existing bitmap writeback size calculation.
>=20
>  fs/hfs/mdb.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
> index a97cea35ca2e..53cd137892b5 100644
> --- a/fs/hfs/mdb.c
> +++ b/fs/hfs/mdb.c
> @@ -185,6 +185,11 @@ int hfs_mdb_get(struct super_block *sb)
>  		sb->s_flags |=3D SB_RDONLY;
>  	}
> =20
> +	if (be16_to_cpu(mdb->drVBMSt) <=3D HFS_MDB_BLK) {

Technically speaking, if we are trying to check the overlapping of volume b=
itmap
with the main MDB record, then we need to check the overlapping with altern=
ative
MDB record, and with Catalog File and Extents Overflow File. However, it so=
unds
like we are trying to add some FSCK logic here. :)

> +		pr_err("volume bitmap overlaps MDB\n");

This situation means volume corruption. It makes sense to recommend to run =
FSCK.

> +		return -EIO;

This code error is wrong because the read operation was OK. But we have
corrupted volume. Even if we have overlapping of volume bitmap with MDB rec=
ord,
then we cannot reject mount operation. We must mount in READ-ONLY mode beca=
use,
potentially, the rest of metadata could be completely OK. We simply cannot =
mount
in RW mode.

> +	}
> +
>  	/* TRY to get the alternate (backup) MDB. */
>  	sect =3D part_start + part_size - 2;
>  	bh =3D sb_bread512(sb, sect, mdb2);
> @@ -341,6 +346,11 @@ void hfs_mdb_commit(struct super_block *sb)
>  		size =3D (HFS_SB(sb)->fs_ablocks + 7) / 8;
>  		ptr =3D (u8 *)HFS_SB(sb)->bitmap;
>  		while (size) {
> +			if (unlikely(block =3D=3D HFS_SB(sb)->mdb_bh->b_blocknr)) {
> +				pr_err("volume bitmap overlaps MDB, forcing read-only\n");
> +				sb->s_flags |=3D SB_RDONLY;
> +				break;
> +			}

At this point, we already wrote main MDB and alternative MDB to the volume.
Theoretically, it is possible to imagine that if size of volume bitmap is b=
ig
enough, then we could partially process the bitmap too. Probably, we need t=
o
check the overlapping at the beginning of the method and reject the whole
superblock commit.

Initial issue was the deadlock. Could we implement some check that buffer_h=
eads
don't overlap before trying to lock? Does it make sense to you?

Thanks,
Slava.

>  			bh =3D sb_bread(sb, block);
>  			if (!bh) {
>  				pr_err("unable to read volume bitmap\n");

