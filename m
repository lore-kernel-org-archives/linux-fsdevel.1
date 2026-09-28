Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F60A4F799F
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 20:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790629025; cv=none; b=m3sl4InWyL1XVTx3HIo+X//hTMepANjNbs0QkzXs9HJ7Li+2TZTgADNbcBfyMZZrKZDx750rvru5wcmHfNcm1wf1ilLSW8DaJu/x7o5WV0TXxhoSl0isKSdeWgNDMCg5AV5eYQy7f+KW/Q42XVNiEmxj5LXXZoRuzm7gah3XpuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790629025; c=relaxed/simple;
	bh=zpC1ExKteyur5CkRIV5diCeaDt5y/APvhpo27XSbxjY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i4tnLTJjMM9Ey0eXof8ypJMO6btcC0A4qy5TWAbTrZCJm9Alq6ktV89ulg3qBH1/J5DdWXecEXzlfqQWuaAomJ4uhPM8qjjCFNrIkrgL4GW7/PYhidjQ5qxHSi/OymeAvUjACYVebwdUmCN+mvG9w7J41zJEqhThhrFIR/G+r/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=ZSbFc+5F; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="ZSbFc+5F"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e56a1b327so2871726d50.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 13:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1790629023; x=1791233823; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QU+Dw9OV8hXvUAg+6qx9gdzK2zTaZ+3agVUM3ninEK4=;
        b=ZSbFc+5FSaazAp5vkAGJlw/4f2ubI9ADRpqF6e/r36IAPOOODbXHw/ehTdH3tws7bZ
         Zmn+yqA6qYIm96EWoDUvIf+P4i2G9GYclgCF6crI59mYCgBAdIBziNwumYLKOI7EUdxi
         KN/M6gtTkJclYGq0G615cFlpKOOJuzndshSYiyfm+ttAN33Bm+LnUsYpat/k5rfB1wxk
         SvA+Pi+Z3VQn4xAYHdcdXcLHPCK07q+9Kf2M0H82gfiy3GANybGS3M9IIeXnjaVTGJLQ
         nIStUhACWkx2Llp1h1jvJ8ttjb4LdZdqKVjffunrkYwci+hP64RY1JlDrAR9uylT7nIV
         CYIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790629023; x=1791233823;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QU+Dw9OV8hXvUAg+6qx9gdzK2zTaZ+3agVUM3ninEK4=;
        b=YxMIegYZEZBzjdqiNFsl9j2LWYbUI8PD0z9gErjSQM9InH7VJZwka1qsTDR2+bbMXJ
         B0CiTeatPFnb93jVZQzI0Gm3F1Xlhjxiw50QpWogtnv8pC9v5k+QN/PJns0nXjGkcpZR
         bIn/dSpRStGl+H10DB0ElojQ3o1P9aPytB+uhTDc/iJpteeIMNCYgoxMl2sqEG29dNGF
         v/wZIr3IXXIX6i2eXxyzAvQVZqbZNLHY5aUVv9TKiiGt1AGn9GTeE0JEwqcwQHaAmWYG
         Jkzt6Jx82aTtMmYMdv8oaoUv776z3AGH7tN64Qyk9QVjyPdAsQQhDup3WBrTU3RPGtBU
         Cdew==
X-Forwarded-Encrypted: i=1; AKwUvBxkqJ3sjlAuEE4Rtk+0Pg+hW1vUyihzpxl5HZBi0Pnq+O/ui5I1ff6W/ZEF32rxv1yEz/CXZ3eCp7WCYJ7f@vger.kernel.org
X-Gm-Message-State: AFq9FYKOTSNpBQPZovQj3bJN6wwsG04vlk7mnSh+pnCGf63NmK3zKNrh
	ts6E2BAkJfoahIMOj5/NMPOrFjfgN7eAbF8AZk//UxmOeZJu20mhvhCLDz6fn9BO7FrXoD5vTNS
	EpkI7YOQ=
X-Gm-Gg: AYBFou2hdgzxqk4n4K0QKHEqHO07tBUs9UZrWQlt+zOXnHmNiOcVeYHEclGcLF66cSw
	s1fN36nvBDcYvKDlnwHa34iDbBxZUS+EOcn/fcYtwKSyASyF/q8/8bm9avGVn603ggcIRN97mXC
	zV6L+pLOWZSi28zzVwpcHoq7Vbc6dy1SDkS8ddaL7wqk2SqSsxTfaGUfLwOquJi5hpweyCcu54P
	Y+W8wDFjgXq4z0gzOnu0RefkBHtSbS2KwJ/PM4Uy72FOPkyzG8bCYdv0rawE/ISd9Ido89ciGKV
	rCCsC2oH9hXp2/SrZxJxaePUMNkWaNnu+Ulqg62dbppEnapARcdHExP9Kvy/E53O28gQegALmLW
	f84kNxoXvMVuDaTel7hu1O28ARsYRJdUm+blTk+f1tEo7TrSSKjz1WjAxcIbawK34U/+iSQGPGY
	fm7UqUS3sLN8cB8PQMqc76h8cF/n2HKINgC37+euRNf6UPoF4k3VdS+i2u5rntRSwG7S5PdaEW9
	d9QrZwSWv/AqUlE+imeSjg6ZO4R1G/9nIVkYiJz4OCiiAgXpMzBJlsnP5fKd4KQ2FXmbfg4bjE5
	G8va9D7wpjCeDCwA788+HMJsOR3xECB7JZlkbVuphZZzBbY4sNS1PpRmfarGoLPeyABEH9NJ
X-Received: by 2002:a05:690e:d89:b0:674:2095:58dc with SMTP id 956f58d0204a3-674209582a9mr4161618d50.86.1790629022900;
        Mon, 28 Sep 2026 13:57:02 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:9da4:6df:559d:f4cd? ([2600:1700:6476:1430:9da4:6df:559d:f4cd])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6740ef87db6sm5265370d50.17.2026.09.28.13.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 13:57:02 -0700 (PDT)
Message-ID: <a30d61829abae665aec2faf5db93ab6e59bf1c3c.camel@dubeyko.com>
Subject: Re: [PATCH 1/2] hfs: bound the partition-table hop in hfs_mdb_get()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li
	 <frank.li@vivo.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 28 Sep 2026 13:57:01 -0700
In-Reply-To: <20260926084010.569552-2-matthias.goergens@gmail.com>
References: <20260926084010.569552-1-matthias.goergens@gmail.com>
	 <20260926084010.569552-2-matthias.goergens@gmail.com>
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
> hfs_mdb_get() loops "while (1)" around hfs_part_find(), rereading the
> volume header wherever the partition table points.=C2=A0 A partition entr=
y
> with a zero start (pdStart or pmPyPartStart) leaves part_start where
> it
> was, and the loop reads the same blocks forever.
>=20
> An Apple partition map sits at the start of the raw device: the boot
> ROM
> reads it from block 1 (TN1189), and nothing Apple documents nests one
> inside a partition.=C2=A0 Follow at most one partition-table hop and fail
> with -EIO after that, as for a table that cannot be parsed.=C2=A0 A zero
> start is caught on the second pass, when the loop comes round again.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
> ---
> A partition entry pointing at its own table hangs the mount forever
> without this patch and fails at once with it:
>=20
> =C2=A0 img=3Dhfs-partmap-loop.img
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
> =C2=A0 mount -o ro,loop -t hfs $img /mnt
> ---
> =C2=A0fs/hfs/mdb.c | 10 +++++++++-
> =C2=A01 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
> index 277de712f9d4..1704f332e28d 100644
> --- a/fs/hfs/mdb.c
> +++ b/fs/hfs/mdb.c
> @@ -134,6 +134,7 @@ int hfs_mdb_get(struct super_block *sb)
> =C2=A0	sector_t part_start, part_size;
> =C2=A0	loff_t off;
> =C2=A0	__be16 attrib;
> +	bool part_hop_done =3D false;
> =C2=A0
> =C2=A0	/* set the device driver to 512-byte blocks */
> =C2=A0	size =3D sb_min_blocksize(sb, HFS_SECTOR_SIZE);
> @@ -152,11 +153,18 @@ int hfs_mdb_get(struct super_block *sb)
> =C2=A0			break;
> =C2=A0		brelse(bh);
> =C2=A0
> -		/* check for a partition block
> +		/*
> +		 * check for a partition block
> =C2=A0		 * (should do this only for cdrom/loop though)
> +		 *
> +		 * The partition map is at the start of the device:
> follow
> +		 * it once, or an entry pointing at itself loops
> forever.
> =C2=A0		 */
> +		if (part_hop_done)
> +			return -EIO;
> =C2=A0		if (hfs_part_find(sb, &part_start, &part_size))

If I understood the problem correctly, then we  have issue in
hfs_part_find(). This method should have the proper sanity check.

Thanks,
Slava.

> =C2=A0			return -EIO;
> +		part_hop_done =3D true;
> =C2=A0	}
> =C2=A0
> =C2=A0	HFS_SB(sb)->alloc_blksz =3D size =3D be32_to_cpu(mdb-
> >drAlBlkSiz);
>=20
> base-commit: 6812ce4e4379ffc99c52401ec28f0d7ffbc36206
