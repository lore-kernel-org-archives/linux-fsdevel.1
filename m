Received: from mail-yx2-f38.google.com (mail-yx2-f38.google.com [74.125.224.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D3E4A4993
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2026 21:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790889533; cv=none; b=gmK+uOsfkFc2HwpDb3umvNfy9rsWrzTKtT0SHiMZkAMv223kvDsAGJ7b7P8P9tmk06FbMkTi0jRuip0Z00jDgiv9DyPdhQBCjoYMqiLkyRozKtuQr4BcCqcq67sU20pDXfWiVjfnDKRtz6cRAYiGFwx+yNwl59LUGe1Z0CvsACw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790889533; c=relaxed/simple;
	bh=AaMRzA3GwCcruC4vcKsIY/ctppwPd6yHkgn55D5RW4M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ITx+/36CtrEbZ5uryZqMIWSemDhzZPAbRRcFyK9u2N/kanbbaw7h82lqvs+FjV4hMH30VP7nzcyW0xgrYdrI01Mt+T9Q28emLe5mZ9SaFuXenJfdSzqMBohehCMjgCxCnuXdBRtUBLQY4aTvik8ORT8jLletN+vlf95orb6VPZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=yg8dzKmw; arc=none smtp.client-ip=74.125.224.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="yg8dzKmw"
Received: by mail-yx2-f38.google.com with SMTP id 956f58d0204a3-67561cbafd0so3019599d50.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Oct 2026 14:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1790889526; x=1791494326; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=npnMeLxosNDOnJqoWDC8WVPBYhMiG2jAQo0sTJwzvWw=;
        b=yg8dzKmwkWUkKuQiGHIIex5bqFEBz969NfuOjQW2JBHCL7HGLuJPtxiftnM4NNcCt6
         CFifgGmDNW9zUMV82twIXMI08tmnJvKGAoZ9x5ZMVaHeNKi2Hxccbiiq5d6oPI+1dw6y
         Zypo+J9MlWjOqfYz7JInvWe9Z/WH8BPwbvR/vJsr6reZRwgakrmCcDdk2h5nrxwj9Cyw
         wq7Pe3c63OP/pD3PHPU+y2Z5hBdoFaO7Njc6IJI8J7eX0u77FXFnuYabs+vIw7GzSAd9
         5QDClnyM0DBii04i51gaG45RCzJ6Tm9MBsm9FsuGVEw9WV4pu9Ygo1pawdVTKkrrAEql
         Owsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790889526; x=1791494326;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=npnMeLxosNDOnJqoWDC8WVPBYhMiG2jAQo0sTJwzvWw=;
        b=u+xFeNeTM24LGaf+2cqLWO+Wik4tyjkn7bxObel2syNNvdILJwfo13T0NYyY1hgEsM
         ThC1YqUj40ZblVllINxNLjFP4r6zQLTxlHo/YorKqr8fmUXUYVnE2dt8tEZL7pYifss4
         EfUjwVYJLUGClrujzNMdaVUvf6QpzBSx3sbmpE55LCYtsdTI77zIDbbg+YD2cB55zjR/
         LgTiU7FmOn+Im/VJ13rLeiHeLIyLIqy9dano20Xw8I9racFujRbV7c2kOAz9Mfwnde4i
         n49wEHeuYFmnUhcryWFXUL4Bb/6tzO8rjm3a9Wtg9Dg1XEXsFxrP3O1HeHTjYUfPNNWP
         hckA==
X-Forwarded-Encrypted: i=1; AKwUvBzzWJNcEjMA5nuhK/hY+UHmJLvNiAEwPSA8wipGLaXB1kMLliIbdNSwaqAx9SHtWeUqorFTe0b+ya5+v1ZW@vger.kernel.org
X-Gm-Message-State: AFuF++nbXvb8Iznp1ph3Yrh8QUx/IkndVrnhpYAghed12xi1ijIMbrmB
	ADHVb3sQsotPfIIA6N2UFKYuta04KXAn40GrqY5wHlKFNMEBbMDqUqOaPeAoyhHvnNw=
X-Gm-Gg: AYBFou1tDXOLDxBWaoAkVYqbRhMrfBTVJyRF9xB6EWk/ne6tO1Skai533Kk+T2tQ9Ag
	deftf9dH/OF4A8pI5z2MnjLyEG3B3AJ3bTuibo9nJ43uzBQZQzmC35xz5uvczMmqzTE7jPAS2O5
	UMheFZITue99AHFWti50DM6AkKVN3cp60DMRodOuc8piGnThszi1JzLdgVDMOH6PUTiU0HCRtNO
	V5sQTFo9fKgcoHHFtoynx19k36fj0d5a+1WRykszES7jXrkbOvCxVXie3h/jq4rb3xPI11YE02u
	cuUTq720btmnrPMemAsRHXiOwqKbRRwh4WKlKp6IIX3E+EzQVx5UotMSqSq4F6Cz2DICX+gs3JB
	3y7FCw076RHVlbXxGDsVIpAJ4WBf1FUV+HjJF0P0iccjMSTQRvoaHNPmxMEly1RdokcNMeniezf
	CK2Xm+svfnDqVZXFy/nDSNPaObZwcnznwP/2W1dATnugLIypm9zTadC9z5ENrOazkWRASRNz3zH
	WrHbq4Fgjj1VTXy9Y36b6CaiTSNL2j0+GbllfuQMRrr8oZzDU2npPK8gKp+RP7pRMrS5VxxT3rb
	n4bfu6K9KU8Ar+tkrSmsDSz68TKzF/lD2POu9xFZ2iShOPOmRSBWgK+skTpVjQLV
X-Received: by 2002:a05:690e:813:20b0:675:38ab:5f0c with SMTP id 956f58d0204a3-677ac03bb78mr277646d50.17.1790889526016;
        Thu, 01 Oct 2026 14:18:46 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:67c2:3447:e08d:9418? ([2600:1700:6476:1430:67c2:3447:e08d:9418])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-677ac5ac1fdsm157307d50.13.2026.10.01.14.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 14:18:45 -0700 (PDT)
Message-ID: <1a1408e2ef7d3e5c27e520958ffa2116b3250ea6.camel@dubeyko.com>
Subject: Re: [PATCH v2 2/2] hfsplus: validate the wrapper and partition map
 before following them
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li
	 <frank.li@vivo.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 01 Oct 2026 14:18:41 -0700
In-Reply-To: <2037378c974c98794dcd1d832e3c31628e9801b8.1790689266.git.matthias.goergens@gmail.com>
References: <cover.1790689266.git.matthias.goergens@gmail.com>
	 <2037378c974c98794dcd1d832e3c31628e9801b8.1790689266.git.matthias.goergens@gmail.com>
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

On Fri, 2026-10-02 at 00:21 +0800, Matthias Goergens wrote:
> hfsplus_read_wrapper() rereads the volume header through a bare "goto
> reread", following an HFS wrapper's embedded-volume descriptor or, if
> the header matches neither signature, the partition map found by
> hfs_part_find().=C2=A0 hfsplus_read_mdb() does not check the offset it
> returns, and hfs_part_find() does not check the start of a new-style
> map
> entry, so a descriptor or entry with a zero offset leaves part_start
> where it was and the mount loops forever.
>=20
> Check both where they are parsed.=C2=A0 TN1150 places the embedded volume
> in
> the wrapper's allocation blocks, and the boot blocks, MDB and volume
> bitmap of an HFS volume are not part of any allocation block.=C2=A0 So
> hfsplus_read_mdb() now rejects a wrapper whose allocation blocks
> start
> at or before its MDB (drAlBlSt <=3D 2), whose embedded volume is empty,
> or
> whose embedded volume ends past the wrapper's last allocation block
> (drNmAlBlks).=C2=A0 hfs_part_find() gets the same check as in hfs: a
> partition must be non-empty, start inside the device and, for a
> new-style map, start after the map, which begins at block 1 and whose
> size the first entry's pmMapBlkCnt gives (TN1189).
>=20
> A wrapper hop now moves part_start forward by at least three sectors,
> and a partition-table hop moves it past the map entries it has read.=C2=
=A0
> So
> the loop ends, at the latest when a read goes past the end of the
> device, and the maps read on the way do not overlap.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
> ---
> v2: check the wrapper in hfsplus_read_mdb() and the entries in
> hfs_part_find() instead of limiting the hops in
> hfsplus_read_wrapper().
>=20
> A wrapper whose embedded-volume descriptor points back at itself
> hangs
> the mount without this patch and fails at once with it:
>=20
> =C2=A0 img=3Dhfsplus-wrapper-loop.img
> =C2=A0 put() { printf "$2" | dd of=3D$img bs=3D1 seek=3D$1 conv=3Dnotrunc
> status=3Dnone; }
> =C2=A0 truncate --size=3D64K $img
> =C2=A0 put $((1024 + 0x00)) '\x42\x44'=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 # drSigWord 'BD'
> =C2=A0 put $((1024 + 0x0a)) '\x82\x00'=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 # drAtrb: SLOCK | SPARED
> =C2=A0 put $((1024 + 0x14)) '\x00\x00\x02\x00'=C2=A0 # drAlBlkSiz 512
> =C2=A0 put $((1024 + 0x7c)) '\x48\x2b'=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 # drEmbedSigWord 'H+'
> =C2=A0 put $((1024 + 0x7e)) '\x00\x00\x00\x64'=C2=A0 # drEmbedExtent: sta=
rt 0,
> count 100
> =C2=A0 mount -o ro,loop -t hfsplus $img /mnt
>=20
> The partition map from the hfs patch hangs an hfsplus mount the same
> way, with "-t hfsplus".
>=20
> =C2=A0fs/hfsplus/part_tbl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 24 ++++++++++=
+++++++++++++-
> =C2=A0fs/hfsplus/wrapper.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 16 +++++=
++++++++++-
> =C2=A0include/linux/hfs_common.h |=C2=A0 1 +
> =C2=A03 files changed, 39 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/hfsplus/part_tbl.c b/fs/hfsplus/part_tbl.c
> index 9ec21664eda6b..ceba3139f1f56 100644
> --- a/fs/hfsplus/part_tbl.c
> +++ b/fs/hfsplus/part_tbl.c
> @@ -67,6 +67,22 @@ struct old_pmap {
> =C2=A0	}	pdEntry[42];
> =C2=A0} __packed;
> =C2=A0
> +/*
> + * Check a partition map entry before following it.=C2=A0 The partition
> must
> + * be non-empty, start inside the device and start at or after
> @first:
> + * after the driver descriptor map in block 0 for an old-style map,
> and
> + * after the whole of a new-style map, whose size the first entry's
> + * pmMapBlkCnt gives (TN1189).=C2=A0 Every hop then moves forward, past
> the
> + * map entries just read, so hfsplus_read_wrapper() cannot loop and
> + * reads each block of a map at most once.
> + */
> +static bool hfs_part_valid(struct super_block *sb, sector_t base,
> +			=C2=A0=C2=A0 u64 first, u32 start, u32 size)
> +{
> +	return start >=3D first && size &&
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 base + start < bdev_nr_sectors(sb-=
>s_bdev);
> +}

Please, see my comments for HFS patch. I have pretty the same comments
here.

> +
> =C2=A0static int hfs_parse_old_pmap(struct super_block *sb, struct
> old_pmap *pm,
> =C2=A0		sector_t *part_start, sector_t *part_size)
> =C2=A0{
> @@ -76,7 +92,9 @@ static int hfs_parse_old_pmap(struct super_block
> *sb, struct old_pmap *pm,
> =C2=A0	for (i =3D 0; i < 42; i++) {
> =C2=A0		struct old_pmap_entry *p =3D &pm->pdEntry[i];
> =C2=A0
> -		if (p->pdStart && p->pdSize &&
> +		if (hfs_part_valid(sb, *part_start, HFS_DD_BLK + 1,
> +				=C2=A0=C2=A0 be32_to_cpu(p->pdStart),
> +				=C2=A0=C2=A0 be32_to_cpu(p->pdSize)) &&
> =C2=A0		=C2=A0=C2=A0=C2=A0 p->pdFSID =3D=3D cpu_to_be32(0x54465331)/*"TFS=
1"*/
> &&
> =C2=A0		=C2=A0=C2=A0=C2=A0 (sbi->part < 0 || sbi->part =3D=3D i)) {
> =C2=A0			*part_start +=3D be32_to_cpu(p->pdStart);
> @@ -99,6 +117,10 @@ static int hfs_parse_new_pmap(struct super_block
> *sb, void *buf,
> =C2=A0
> =C2=A0	do {
> =C2=A0		if (!memcmp(pm->pmPartType, "Apple_HFS", 9) &&
> +		=C2=A0=C2=A0=C2=A0 hfs_part_valid(sb, *part_start,
> +				=C2=A0=C2=A0 HFS_PMAP_BLK + (u64)size,
> +				=C2=A0=C2=A0 be32_to_cpu(pm->pmPyPartStart),
> +				=C2=A0=C2=A0 be32_to_cpu(pm->pmPartBlkCnt)) &&
> =C2=A0		=C2=A0=C2=A0=C2=A0 (sbi->part < 0 || sbi->part =3D=3D i)) {
> =C2=A0			*part_start +=3D be32_to_cpu(pm-
> >pmPyPartStart);
> =C2=A0			*part_size =3D be32_to_cpu(pm->pmPartBlkCnt);
> diff --git a/fs/hfsplus/wrapper.c b/fs/hfsplus/wrapper.c
> index 30cf4fe78b3d2..35cd2563dfdfe 100644
> --- a/fs/hfsplus/wrapper.c
> +++ b/fs/hfsplus/wrapper.c
> @@ -66,7 +66,7 @@ int hfsplus_submit_bio(struct super_block *sb,
> sector_t sector,
> =C2=A0static int hfsplus_read_mdb(void *bufptr, struct hfsplus_wd *wd)
> =C2=A0{
> =C2=A0	u32 extent;
> -	u16 attrib;
> +	u16 attrib, nmalblks;
> =C2=A0	__be16 sig;
> =C2=A0
> =C2=A0	sig =3D *(__be16 *)(bufptr + HFSP_WRAPOFF_EMBEDSIG);
> @@ -87,11 +87,25 @@ static int hfsplus_read_mdb(void *bufptr, struct
> hfsplus_wd *wd)
> =C2=A0		return 0;
> =C2=A0	wd->ablk_start =3D
> =C2=A0		be16_to_cpu(*(__be16 *)(bufptr +
> HFSP_WRAPOFF_ABLKSTART));
> +	nmalblks =3D be16_to_cpu(*(__be16 *)(bufptr +
> HFSP_WRAPOFF_NMALBLKS));
> =C2=A0
> =C2=A0	extent =3D get_unaligned_be32(bufptr + HFSP_WRAPOFF_EMBEDEXT);
> =C2=A0	wd->embed_start =3D (extent >> 16) & 0xFFFF;
> =C2=A0	wd->embed_count =3D extent & 0xFFFF;
> =C2=A0
> +	/*
> +	 * The boot blocks, MDB and volume bitmap of an HFS volume
> are not
> +	 * part of any allocation block, and the embedded volume
> occupies
> +	 * allocation blocks of the wrapper (TN1150).=C2=A0 So the
> embedded
> +	 * volume starts after the wrapper's MDB and ends inside the
> +	 * wrapper.
> +	 */
> +	if (wd->ablk_start <=3D HFS_MDB_BLK)
> +		return 0;
> +	if (!wd->embed_count ||
> +	=C2=A0=C2=A0=C2=A0 wd->embed_start + wd->embed_count > nmalblks)
> +		return 0;
> +
> =C2=A0	return 1;
> =C2=A0}
> =C2=A0
> diff --git a/include/linux/hfs_common.h b/include/linux/hfs_common.h
> index d6a615e74b26e..123475efe5b37 100644
> --- a/include/linux/hfs_common.h
> +++ b/include/linux/hfs_common.h
> @@ -44,6 +44,7 @@
> =C2=A0
> =C2=A0#define HFSP_WRAPOFF_SIG		0x00
> =C2=A0#define HFSP_WRAPOFF_ATTRIB		0x0A
> +#define HFSP_WRAPOFF_NMALBLKS		0x12

Does this value is based on specification? Where does it come from?

Thanks,
Slava.

> =C2=A0#define HFSP_WRAPOFF_ABLKSIZE		0x14
> =C2=A0#define HFSP_WRAPOFF_ABLKSTART		0x1C
> =C2=A0#define HFSP_WRAPOFF_EMBEDSIG		0x7C
