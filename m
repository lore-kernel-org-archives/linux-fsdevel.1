Received: from mail-yx2-f39.google.com (mail-yx2-f39.google.com [74.125.224.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A35C47141C
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 21:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790629213; cv=none; b=VVdqLCYUzze9N/Rdixvxk7IPsfKM6bpwaPZCvyLaYC2xF50knVDHtXYEkf3aulPA01KVNHKtzx8hXVa96Dmwqwg1ru6TrmbTRbyG1HJx8HXjJxDUIeile3FQByAotgGVQYTQyioHQiXs+8VAIoeuguvIfUnCUB3/Pau1dK98JHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790629213; c=relaxed/simple;
	bh=4LuBzUkR8PJIag45F2rrrn8Atg8tUTl5+vC4vphpMHc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TR40suuoW5hS/pU5LVfKTGeP65DGQuVZ812xkXwqnqaBF1StKaGgfCY/SWVBAUvAb2JqmufDRlTswCc9cnEticOGb4dZ3+/7iQhqj/KCoMLlm+H01a72HbJK3/BgiDf6ArRC10ka3yrgU1gQo1002tMNNtvZi4eJBMJo7RhaSSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=aqjvEhIJ; arc=none smtp.client-ip=74.125.224.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="aqjvEhIJ"
Received: by mail-yx2-f39.google.com with SMTP id 00721157ae682-8aa1a918093so16442547b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 14:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1790629209; x=1791234009; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=otlHemocIxoxSM0PMaZCLOGZnqEjuQVINl8oyxq3M3k=;
        b=aqjvEhIJSSnEblSfS1OGYYMeGFnFVXckYmCIh+rCYWv0MsW3AGT27jFc93pIhcznY4
         2j6kALtvz9APrPEUTg5AVZz1vkh/oOLW4kinIHjbJyz69JSsNdIdbRnQBrfd5Aw1XdCI
         1M4lkUP6rha+qf+KIJTeg8VhVvzKs1rWzbpGK4bzNfjqGOp3YJAruQt3KQgzdA1xm4s7
         5tHqxWxXYDhjtwUsIIjnsgsMSjMqZLTwxZTKScrA8xUKgCtD4e3LAkdRfEJ+7FxyKeAt
         2A45NYRklZ8J8tz11GOWXe2TgTuVqw34sV3xAIQAO89eqfwRamvl3MbP3GCssLHSMJyr
         YKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790629209; x=1791234009;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=otlHemocIxoxSM0PMaZCLOGZnqEjuQVINl8oyxq3M3k=;
        b=oTiOZsA0/SnGSYe1Tu6tsO+2ExLfO+1Dm20M80mLblbasBW1KunufAB00vFyr3gOyv
         a0ICl/nuLFZrw13dNLKigGAXCzScHWvWdOC9Ly7sjk/+XWmK+FbeWKNeoFflbG0IuRRV
         18DWx/Af2e86DHn1MLSlaZCY7WfLX1uRu10teXOqLo1I5qjFLTCOMWmmUEpVbMeTmR9z
         u5fbMyl3EAMNVep9rfEf3V21qsSIGJ1DZuduw8qDCZXcMlcBzjoNcXNmpAFuGPxvJGPR
         ifHNYxL86e4GKIYYuTgLGSoYEaciMo1OBE690zJR53lbhl0O18i4rPD+nXTdHlSwzBhQ
         QJLg==
X-Forwarded-Encrypted: i=1; AKwUvBxg3F79wKlfClA1CvHpk8E7ARw5Q6Fn1CkXR+6hZvl+AJ6HfktiB9nX2Xyw7MDASVqb3UsfrtKMMTuEQPvM@vger.kernel.org
X-Gm-Message-State: AFq9FYLyr4buNuclFYRP6Nxyg8UymwIlUyFE7BAAyr9lQRyBE3r8j2b5
	c3TW8IxznW1v1Lu+bPfGCvDiCjWf14rB0CzhJik7OIYlz6RYK+p89t6wLstFmzeZSc8=
X-Gm-Gg: AYBFou12v0LoOWJ2iF5to2NfL6Hx+4Uc0VFtCO5lIFLVdP0sBGjefvVxP4GOX4kANui
	fPXC6v8SlyVhoQv626V6fge1Fg/6VCqfBF7/wJkcEbCrmfRGDJ8OqjDZ4/u/ZxZ6RoDSXCOfhb2
	Z1boKdDlAM21jXwGyUIP07XAxC98HjLy1p18hnTWOUUxAtV8u+4g0ROkTtOg4v++uHOaigts9s8
	2/pZ0v3+VRdw0NnALj8T6F31fjZvbeePmRtJQ60WW6aFg69fRGPTdqm1+1Avf6T/JfBjkSzMO+L
	zcM2WHwW6btcs5+WRAb0xgrbZp2ocKi98r0nKV0XERNao4B9JKYhGlQzoAXIgY+f3XgctvAvEoF
	HSWrD3iV8le9dJdrvebJ5A1KeLkgAMATUT0rj4I7ogBGNFThISRaayHNyNXyDn2Fqq6acGBm6Dx
	AM33T6UXfC1x6dJdDZQkxZF0REaYAZ+OTuwTxQWSRPgrBKFsqUJV3xyk37kx8a99aMTfEkL/oJI
	/f/MTFfJIVr4QaiCjyMFrJVECfcnq+yPeH95stvovpsiYfm/XaNObZw65iOQ+gWVtvxYb8KFTYa
	z/7Ov2GGLHbEJQyKCRdz39c/CXgeSXMuFTTw3Q==
X-Received: by 2002:a05:690c:600c:b0:8ab:3938:dfb7 with SMTP id 00721157ae682-8ab3938e378mr8897887b3.25.1790629209379;
        Mon, 28 Sep 2026 14:00:09 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:9da4:6df:559d:f4cd])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a860326244sm49004057b3.6.2026.09.28.14.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 14:00:08 -0700 (PDT)
Message-ID: <c2d61b16570fb6dd6b0c4130fe4bfc707e2334b1.camel@dubeyko.com>
Subject: Re: [PATCH 2/2] hfsplus: bound the wrapper and partition-table hops
 in hfsplus_read_wrapper()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li
	 <frank.li@vivo.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 28 Sep 2026 14:00:07 -0700
In-Reply-To: <20260926084010.569552-3-matthias.goergens@gmail.com>
References: <20260926084010.569552-1-matthias.goergens@gmail.com>
	 <20260926084010.569552-3-matthias.goergens@gmail.com>
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

On Sat, 2026-09-26 at 16:40 +0800, Matthias Goergens wrote:
> hfsplus_read_wrapper() rereads the volume header through a bare "goto
> reread", following an HFS wrapper's embedded-volume descriptor or, if
> the header matches neither signature, the partition-table fallback it
> shares with hfs, with no bound on either.=C2=A0 A descriptor or partition
> entry with a zero offset leaves part_start where it was, and the
> mount
> loops forever.
>=20
> TN1150 ("HFS Plus Volume Format") requires a wrapper's embedded
> volume
> to be HFS Plus: "When an HFS Plus volume is embedded, drEmbedSigWord
> must be kHFSPlusSigWord ('H+')".=C2=A0 So there is at most one wrapper
> hop,
> and Apple's hfs code, GRUB and 7-Zip all follow it once.=C2=A0 A partitio=
n
> map sits at the start of the raw device (previous patch), so a
> partition-table hop only makes sense before any wrapper hop.=C2=A0 Allow
> one
> of each, in that order, and fail with -EINVAL otherwise.=C2=A0 A zero
> offset
> is caught on the second pass.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
> ---
> A wrapper whose embedded-volume descriptor points back at itself
> hangs the mount forever without this patch and fails at once with it:
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
> The same partition-table entry as the hfs patch hangs an hfsplus
> mount
> the same way:
>=20
> =C2=A0 img=3Dhfsplus-partmap-loop.img
> =C2=A0 put() { printf "$2" | dd of=3D$img bs=3D1 seek=3D$1 conv=3Dnotrunc
> status=3Dnone; }
> =C2=A0 truncate --size=3D64K $img
> =C2=A0 put $((512+0x00)) '\x50\x4d'=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 # pmSig 'PM'
> =C2=A0 put $((512+0x04)) '\x00\x00\x00\x01'=C2=A0 # pmMapBlkCnt 1
> =C2=A0 put $((512+0x08)) '\x00\x00\x00\x00'=C2=A0 # pmPyPartStart 0 (self=
)
> =C2=A0 put $((512+0x0c)) '\x00\x00\x00\x64'=C2=A0 # pmPartBlkCnt 100
> =C2=A0 put $((512+0x30)) 'Apple_HFS'=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 # pmPartType
> =C2=A0 mount -o ro,loop -t hfsplus $img /mnt
> ---
> =C2=A0fs/hfsplus/wrapper.c | 15 +++++++++++++++
> =C2=A01 file changed, 15 insertions(+)
>=20
> diff --git a/fs/hfsplus/wrapper.c b/fs/hfsplus/wrapper.c
> index 30cf4fe78b3d..df8079a4d8f5 100644
> --- a/fs/hfsplus/wrapper.c
> +++ b/fs/hfsplus/wrapper.c
> @@ -137,6 +137,7 @@ int hfsplus_read_wrapper(struct super_block *sb)
> =C2=A0	struct hfsplus_wd wd;
> =C2=A0	sector_t part_start, part_size;
> =C2=A0	u32 blocksize;
> +	bool part_hop_done =3D false, wrapper_hop_done =3D false;
> =C2=A0	int error =3D 0;
> =C2=A0
> =C2=A0	error =3D -EINVAL;
> @@ -172,21 +173,35 @@ int hfsplus_read_wrapper(struct super_block
> *sb)
> =C2=A0	case cpu_to_be16(HFSPLUS_VOLHEAD_SIG):
> =C2=A0		break;
> =C2=A0	case cpu_to_be16(HFSP_WRAP_MAGIC):
> +		/*
> +		 * The embedded volume must be HFS Plus (TN1150), so
> a
> +		 * second wrapper is corrupt; a descriptor pointing
> at
> +		 * itself would otherwise loop forever.
> +		 */
> +		if (wrapper_hop_done)
> +			goto out_free_backup_vhdr;
> =C2=A0		if (!hfsplus_read_mdb(sbi->s_vhdr, &wd))

Ditto. We need to have a proper sanity check in hfsplus_read_mdb().

> =C2=A0			goto out_free_backup_vhdr;
> =C2=A0		wd.ablk_size >>=3D HFSPLUS_SECTOR_SHIFT;
> =C2=A0		part_start +=3D (sector_t)wd.ablk_start +
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (sector_t)wd.embed_start *
> wd.ablk_size;
> =C2=A0		part_size =3D (sector_t)wd.embed_count * wd.ablk_size;
> +		wrapper_hop_done =3D true;
> =C2=A0		goto reread;
> =C2=A0	default:
> =C2=A0		/*
> =C2=A0		 * Check for a partition block.
> =C2=A0		 *
> =C2=A0		 * (should do this only for cdrom/loop though)
> +		 *
> +		 * The partition map is at the start of the device:
> follow
> +		 * it at most once, and not from inside a wrapper.
> =C2=A0		 */
> +		if (part_hop_done || wrapper_hop_done)
> +			goto out_free_backup_vhdr;
> =C2=A0		if (hfs_part_find(sb, &part_start, &part_size))

Ditto. We need to have a proper sanity check in hfs_part_find().

Thanks,
Slava.

> =C2=A0			goto out_free_backup_vhdr;
> +		part_hop_done =3D true;
> =C2=A0		goto reread;
> =C2=A0	}
> =C2=A0
