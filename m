Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794565648;
	b=5ZZ8suaFCYA0Sed4E+cvNru5y7X8r4G0HoMFS3PuYy02bqIdCdYjJafLVHqolyhzdbFa
	 4h7BD4sITRriTabynr/r3c2cshJIJRr8Zs3xJiByaKa7+bCZFX2+3cAQyDnX2CI5UqTTl
	 u8c9Gs5lcCTPAbFWfza1FRQMBt5nhhhh348BVaE/PQQkXICjMI5TxQ6pu+tj3rDxUgKb4
	 +1bp+mpaJDcbjfbxteMfzitMDTiJHfMuT1hDOeNNX0rj8MkU2/E+wb2lWB6EEbm8Q4uf7
	 +dSEb+tanUSzSBC+q0aFFJvz9g7A6Y/znpO/4uo3S7r69+EIMNnv/FgAjJ4hozpDXBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794565648;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=TXY31nY7nMCHyiOZTp7Dn0JSWYPda+tFg8CPAdTq7II=;
	b=DS146a9/6o7836UnOO9IPKpp+T+n6xIUhnsvmQoumorwt+B3wU3mkGr0iKrV3abxUkPs
	 8JnYjvpqd8phqpJC7UNTMInK8ajoPiOGixSnZ4J5SYcenPcwyKtFUAYp2Uq8lUOKA0poN
	 adB9lmd8kbPW7IGKMFQ1erfAM927RqeKxMenoHTGJTGT1WtCKvW2P+DzK11rmt0a51ObW
	 yGfMSSzVeKrRipDO8WxJ71JqaOcJpII839Ynn0JqrIJhyu8xWivXq3Fd56V+7PmCBtfxf
	 ZFLE6tWrO1q73WFQt1THGk9z4gALZsjN5ornz43KNxD1wuow2yTQM85ppFxyu7oM0ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=N7Ff61ik;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAE4606A334
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 10:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FAE4606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=N7Ff61ik
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-49465892f7bso822119f8f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 02:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794565647; x=1795170447; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=TXY31nY7nMCHyiOZTp7Dn0JSWYPda+tFg8CPAdTq7II=;
        b=N7Ff61ikIQ27nXVrR+i5fFuiFp+kpNCkSJ8kzzwXsWXF8oHPQYaaEtIn2sVJ/R61Yt
         eN/EgbWtaqyPzsaKr2MVnoSj+msmKBheiZS6yCjGNfIw7Nev7hKixHBvdeyifMwCAuyY
         p4HuC2pLhsdw/6s4IDRTQYVk2XreSuuUeA2/lEtpnIKw65+UPm9cBNCU3JmsoFXsrPGj
         WUoovGImF4s4dFS6xRIsBa0e81egoKAVqgb5m7AbWjvbiu6rsFasaFfPaH+ik5AAKzYn
         61DshIaK40jfv3WiwMjZKKDrEIOQNGX/IDgIqQj4sI1tIu9ZETTA/xF/QESgBcPouNO3
         9yyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794565647; x=1795170447;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TXY31nY7nMCHyiOZTp7Dn0JSWYPda+tFg8CPAdTq7II=;
        b=RRHgxtRAewQl2bWoOmECCYUUjB6bzu8dTKhqgq4lbRc2vcJBMqcSoHvvqsLx1EKWNB
         PqDLn3MB7+fULdR3SG45Taay64tO2LPn4tmNpha2+tGz/3VG8f8YDf5uxfsGJK4XX9nm
         NbbZ9JIT96tepa84bNpnL26gBg/3ZfBKIqsECx74VYRRwLoFMxuJdNpMfAl2FfC5R6ve
         iDmbgCKyYfMXoW+AQBUHR4QmxsjuKhjo6bS+gWdKHCiv/v1CgpnSBN7FqigoTM8lYVbv
         XetTbTJBQFXe8xP3npUSeyXCvqYxv51ZBLOQ75EwnQrLmQdGG2i5IDIdnr+3ljNNfOzw
         1AfQ==
X-Forwarded-Encrypted: i=1; AL+hErEbftgg2t8uHob5A0iVYFfesdzwCXiE15BC2pJ47JUtnJd1QELWIdZqjUZ4b/9+cNtJOgPOkHXUMjSuAjlJ@vger.kernel.org
X-Gm-Message-State: APuU4Z/6o6oO2XJsBF7dkxGDM9FAdgJ4tIGldbFgSSznlgNcTe/O+EzB
	ll3AuibYZe13otllaTIuKqKR8h8350/FN5E/qMir2S1ic8gr9xuGqZJ7zCzrvp7opQ9G
X-Gm-Gg: AYBFou3g2PCa94sewbsvG1moPH6b0cQ6SJu9ybm42pKYfQoZ9LupveOFD1OqNuUsgGi
	OvUzIV92kgZcOIin1gWtD3bWziqYB63VHMwkNhUaYzOwC0ggiENwLNxvY6LxR+/9UsXAdgMzGFi
	Q/mz7fo7cV+nE+a01nvcCcL9dCTAGt1ieh4WN4mQ2xuR6u8A6dIWxs6jL42suHTtvIkq4uVpnGK
	wRs0vcCtBJhmvMSQjhYZbdcIo8b2IpwesqsiMqZxu7vl254X5IzYhq0mXXDj7yC6pbYTxkB8zJG
	yWlCiTtIHN82qLvHuxksh7exdYlZwZjxBQrkawSdd2Dt+UownJmu6Gm4LDRnFo7+tZ9PRrMInrL
	TK7vSPs2vLJLGkEzLPQLk6LBFobCxncqAN2iCW5T2ZCQ6v6VkeKzu62eSpesFVPdNDo64jgZ49w
	9kwjM8tNc1fM5a8zTmiXlSzIg5crVqO2sQmgyJCvYBKZp/0qASwecejxu2ncvkhM5Pds6UNhsZO
	54vc+klUosvltYe437cZWNlYmY2hCEkEWHvzy4jj2OSyhPxiVAdU3JOITT4sGBW3Q1JnnqNy+qI
	4LFWpcXg2H5DIga0otMJ2ByZeRAXMt0g1HO81DWFt89GJW+ntQYmRZszRf+QZzY=
X-Received: by 2002:a05:6000:4707:b0:498:c419:3728 with SMTP id ffacd0b85a97d-49c713ae367mr4463557f8f.22.1794565646661;
        Fri, 13 Nov 2026 02:27:26 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5a32d336sm5077482f8f.0.2026.11.13.02.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:27:26 -0800 (PST)
Message-ID: <0c109a58804a2d782e549af6ad13e89532d9f9d2.camel@amutable.com>
Subject: Re: [PATCH RFC 40/41] erofs: refuse files on pseudo filesystems as
 backing files
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef
 Bacik	 <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, 	driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, 	fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, 	xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, 	linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-usb@vger.kernel.org, Amir Goldstein
 <amir73il@gmail.com>, 	linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org
Date: Fri, 13 Nov 2026 11:27:24 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-40-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-40-4c998976c6c7@kernel.org>
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

On Tue, 2026-11-10 at 10:14 +0100, Christian Brauner wrote:
> File-backed mounts take any regular file as the image and the same
> goes
> for the extra devices of such a mount. erofs reads them with the
> credentials of the mounter so this doesn't hand out anything the
> mounter
> couldn't read anyway. But files on pseudo filesystems aren't images.
> Refuse them just like loop does.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/erofs/super.c | 6 +++++-
> =C2=A01 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index ce05557bd998..980d5fc2b576 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -158,7 +158,8 @@ static int erofs_init_device(struct erofs_buf
> *buf, struct super_block *sb,
> =C2=A0		if (!erofs_is_fileio_mode(sbi)) {
> =C2=A0			dif->dax_dev =3D
> fs_dax_get_by_bdev(file_bdev(file),
> =C2=A0					&dif->dax_part_off, NULL,
> NULL);
> -		} else if (!S_ISREG(file_inode(file)->i_mode)) {
> +		} else if (!S_ISREG(file_inode(file)->i_mode) ||
> +			=C2=A0=C2=A0 file_is_pseudo(file)) {
> =C2=A0			fput(file);
> =C2=A0			return -EINVAL;
> =C2=A0		}
> @@ -835,6 +836,9 @@ static int erofs_file_get_tree(struct fs_context
> *fc)
> =C2=A0{
> =C2=A0	struct erofs_sb_info *sbi =3D fc->s_fs_info;
> =C2=A0
> +	if (file_is_pseudo(sbi->dif0.file))
> +		return invalfc(fc, "source is on a pseudo
> filesystem");
> +
> =C2=A0	if (!test_opt(&sbi->opt, SUPERBLOCK_SHARE))
> =C2=A0		return get_tree_nodev(fc, erofs_fc_fill_super);
> =C2=A0
