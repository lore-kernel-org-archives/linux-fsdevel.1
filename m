Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com [74.125.224.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6876F5505F0
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 18:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707305; cv=none; b=t8NnyfWnS1Kdbw9huzo8nB3vcxswqPU3zlYQxXY+fFRxmvYZlaEklrZ0x0WvGgG3KWyhPLA7KvIc/Qz24Nohx4txc///cv/FVzjFXESj7APDWbypaPrksvFsk77BO5Y6wxtqjrupi2+jq3Tf4HB8OaEckTxE6MXRBZ/nj0BU1II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707305; c=relaxed/simple;
	bh=1MiRCRcVjQo2tPKimMHxz9ZnzdJexnBq/Q+79QbFSIQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SyUkniMGO6EIYBVCfGhlsg6rKLN97RyQk1dbVMt8V0belJZ/7MlMuu8CXrknbI5vqe/ByLv5J0r6a7196tQciUzTeqqWtmQqxbaRWvQcotpENY6XzdIMaZY9kzrldUZ+RJRjmSmLQciF8n5NkfkKPGXugGePhETckLlzT1845UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=TO2aFk7f; arc=none smtp.client-ip=74.125.224.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="TO2aFk7f"
Received: by mail-yx2-f41.google.com with SMTP id 00721157ae682-8a860e532bbso41545197b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 11:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1790707301; x=1791312101; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0STZbLia+9vH0OMcQlA8OjMvk50duMe8TRp0A+I9r+g=;
        b=TO2aFk7fJTqECAcqlOvp4rb0cOCJln0kQkthnVTl2LEIIH7u4LLGwPkQKkfEZJ7UtZ
         SxYlguISFgB9W8noy3LfDozIF84mSPHZskAHmFIMQbHZwgxMxDWNEz+Fm+8HHVdcaAGq
         U4P/lTzLyl+6W/wnMGseyCz6Hnmj7lsH90OlRJSJD/cnUDAWXrv+jEeFN/K88PRVFERx
         zdZrmlZGoBtvKpylZK/IoRa3F9n0Iv7WXu/62dzxwOmRD7bQIMlBVdtho0uKoSQJ07qg
         v5tjmEOaRLIhVZmerv4lVJZNp6dj7E4lM9yVwT6bf1xbeXaLlgnkMRU90M6uATwRrN+S
         J+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790707301; x=1791312101;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0STZbLia+9vH0OMcQlA8OjMvk50duMe8TRp0A+I9r+g=;
        b=MUvng8iDN2uRwm949clPXODxWYscLzr5zbwLFx35HdE27BaRGbdJEEmGuLhuBpMRHO
         mOHbvHzos2QwhAwfsFTG0Hy7xpse+zcuHFDYZM4JzSidCE7zXDhumPvmKtT6z5Hnr/T6
         77+lUKZ7StuSb71Oq3CD0i6Bbjfh4j15M648AP5r9dA0fLBvnTV3HRUdsTYHF3U/V6t+
         ZHaSxfB0xmryuDSmDMXsYT9532cvadue/GiWT++nqEK1qiXvDC4CGdCNtjDPmAVdlte/
         s5n3uFgJ7SJyPkSmuCB6P5Co1YDTVLnuJXtgysyA2opTOghwsbMswFjNEl1sZem5OKfu
         pgcA==
X-Forwarded-Encrypted: i=1; AKwUvBxcFTwg0o/OlgoMzBP9LFbrsY/U322UMEVO96RBzPo76JDb+dW+rVXzzXvqUUKsyPsl+2Mxf2C42HwDbQvo@vger.kernel.org
X-Gm-Message-State: AFq9FYKOILn4wNUPotb3bSrwcxq/HTdYJzQOOUa8lhivYFnFtOGD2o7s
	aPpQY1P8FNA7T3OdvMpuRioUvXm2aq4619mL26Gs/0IfyDwxiRKtVmW9dMwmdoEXodo=
X-Gm-Gg: AYBFou2WhWTLPhoOLfrEHKysQdI7WpzZU6RJMkdGA7BJBXkH+PBEmYnvTOSzUlVBD6E
	+LzqdZePD9TgfkuPoK7uhGQOACQTmBq/q8/YemQwwp3jVOL2LVlpi0Qy8/l+kN6KQShrRUtOT+d
	XPwmslJo0QpSoPdRbjXnV42E4tiUEu7UZSAgfvvO8gxMYTz6kbqhxMj8Uct/GZNcW0SYkr1tKM3
	bv/OI4L78+KOFGm563TZHLs442Gky6p5IQtua0ZCPstY3ONKNw/CEgXDjN0Gokl7k2Hx4IwqqPH
	Pu7z7GV9DNMg9iWUSWzyxMrzd8qZTn63PI2BiMIYPe9VXtnGq3FLPz5zZ0L4Z7xLZZOSBOe5x19
	V2G87esyTAucM5KI2ApqkAVhIwYRoz9icGrYt4CKOImOHxSdYB6nkle0wEQ2zhAUk/ernGITBH0
	X6ZrqNW4RkiPmXnMIscT+zPFJghLECEeHzIlImKujFFBwZHy5mxoMswQNwc3NTzr8AR49x0ymO5
	glueN19DVYBt8Y8QdHjnlafkjJhSOaPppIDAJCDFWxDrtE4CPMGtRZs6y2hexesxQ7uf5yhC2+g
	FOXzd+1N6QeRVYgzF1TYZxdCHb/+6l2Hh75IclSxuRZebLzOUty8Q3B6qms38r6IiEqbeFMr
X-Received: by 2002:a05:690c:5706:b0:8ab:43f7:f061 with SMTP id 00721157ae682-8ac1acc0d26mr296187b3.34.1790707301224;
        Tue, 29 Sep 2026 11:41:41 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:ace4:86e:1afc:3c4e? ([2600:1700:6476:1430:ace4:86e:1afc:3c4e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8abcea3142esm2052677b3.43.2026.09.29.11.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 11:41:40 -0700 (PDT)
Message-ID: <533efce8b12245de484c3fdb9b1931f988c79119.camel@dubeyko.com>
Subject: Re: [PATCH v6] hfs: handle extent B-tree write errors
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Davy Felipe <davyfelipe34@gmail.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li
	 <frank.li@vivo.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 29 Sep 2026 11:41:39 -0700
In-Reply-To: <20260929020329.32911-1-davyfelipe34@gmail.com>
References: <20260924231054.2175660-1-davyfelipe34@gmail.com>
	 <20260929020329.32911-1-davyfelipe34@gmail.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=mQINBGgaTLYBEADaJc/WqWTeunGetXyyGJ5Za7b23M/ozuDCWCp+yWUa2GqQKH40dxRIR
 zshgOmAue7t9RQJU9lxZ4ZHWbi1Hzz85+0omefEdAKFmxTO6+CYV0g/sapU0wPJws3sC2Pbda9/eJ
 ZcvScAX2n/PlhpTnzJKf3JkHh3nM1ACO3jzSe2/muSQJvqMLG2D71ccekr1RyUh8V+OZdrPtfkDam
 V6GOT6IvyE+d+55fzmo20nJKecvbyvdikWwZvjjCENsG9qOf3TcCJ9DDYwjyYe1To8b+mQM9nHcxp
 jUsUuH074BhISFwt99/htZdSgp4csiGeXr8f9BEotRB6+kjMBHaiJ6B7BIlDmlffyR4f3oR/5hxgy
 dvIxMocqyc03xVyM6tA4ZrshKkwDgZIFEKkx37ec22ZJczNwGywKQW2TGXUTZVbdooiG4tXbRBLxe
 ga/NTZ52ZdEkSxAUGw/l0y0InTtdDIWvfUT+WXtQcEPRBE6HHhoeFehLzWL/o7w5Hog+0hXhNjqte
 fzKpI2fWmYzoIb6ueNmE/8sP9fWXo6Av9m8B5hRvF/hVWfEysr/2LSqN+xjt9NEbg8WNRMLy/Y0MS
 p5fgf9pmGF78waFiBvgZIQNuQnHrM+0BmYOhR0JKoHjt7r5wLyNiKFc8b7xXndyCDYfniO3ljbr0j
 tXWRGxx4to6FwARAQABtCZWaWFjaGVzbGF2IER1YmV5a28gPHNsYXZhQGR1YmV5a28uY29tPokCVw
 QTAQoAQQIbAQUJA8JnAAULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBFXDC2tnzsoLQtrbBDlc2cL
 fhEB1BQJoGl5PAhkBAAoJEDlc2cLfhEB17DsP/jy/Dx19MtxWOniPqpQf2s65enkDZuMIQ94jSg7B
 F2qTKIbNR9SmsczjyjC+/J7m7WZRmcqnwFYMOyNfh12aF2WhjT7p5xEAbvfGVYwUpUrg/lcacdT0D
 Yk61GGc5ZB89OAWHLr0FJjI54bd7kn7E/JRQF4dqNsxU8qcPXQ0wLHxTHUPZu/w5Zu/cO+lQ3H0Pj
 pSEGaTAh+tBYGSvQ4YPYBcV8+qjTxzeNwkw4ARza8EjTwWKP2jWAfA/ay4VobRfqNQ2zLoo84qDtN
 Uxe0zPE2wobIXELWkbuW/6hoQFPpMlJWz+mbvVms57NAA1HO8F5c1SLFaJ6dN0AQbxrHi45/cQXla
 9hSEOJjxcEnJG/ZmcomYHFneM9K1p1K6HcGajiY2BFWkVet9vuHygkLWXVYZ0lr1paLFR52S7T+cf
 6dkxOqu1ZiRegvFoyzBUzlLh/elgp3tWUfG2VmJD3lGpB3m5ZhwQ3rFpK8A7cKzgKjwPp61Me0o9z
 HX53THoG+QG+o0nnIKK7M8+coToTSyznYoq9C3eKeM/J97x9+h9tbizaeUQvWzQOgG8myUJ5u5Dr4
 6tv9KXrOJy0iy/dcyreMYV5lwODaFfOeA4Lbnn5vRn9OjuMg1PFhCi3yMI4lA4umXFw0V2/OI5rgW
 BQELhfvW6mxkihkl6KLZX8m1zcHitCpWaWFjaGVzbGF2IER1YmV5a28gPFNsYXZhLkR1YmV5a29Aa
 WJtLmNvbT6JAlQEEwEKAD4WIQRVwwtrZ87KC0La2wQ5XNnC34RAdQUCaBpd7AIbAQUJA8JnAAULCQ
 gHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRA5XNnC34RAdYjFEACiWBEybMt1xjRbEgaZ3UP5i2bSway
 DwYDvgWW5EbRP7JcqOcZ2vkJwrK3gsqC3FKpjOPh7ecE0I4vrabH1Qobe2N8B2Y396z24mGnkTBbb
 16Uz3PC93nFN1BA0wuOjlr1/oOTy5gBY563vybhnXPfSEUcXRd28jI7z8tRyzXh2tL8ZLdv1u4vQ8
 E0O7lVJ55p9yGxbwgb5vXU4T2irqRKLxRvU80rZIXoEM7zLf5r7RaRxgwjTKdu6rYMUOfoyEQQZTD
 4Xg9YE/X8pZzcbYFs4IlscyK6cXU0pjwr2ssjearOLLDJ7ygvfOiOuCZL+6zHRunLwq2JH/RmwuLV
 mWWSbgosZD6c5+wu6DxV15y7zZaR3NFPOR5ErpCFUorKzBO1nA4dwOAbNym9OGkhRgLAyxwpea0V0
 ZlStfp0kfVaSZYo7PXd8Bbtyjali0niBjPpEVZdgtVUpBlPr97jBYZ+L5GF3hd6WJFbEYgj+5Af7C
 UjbX9DHweGQ/tdXWRnJHRzorxzjOS3003ddRnPtQDDN3Z/XzdAZwQAs0RqqXrTeeJrLppFUbAP+HZ
 TyOLVJcAAlVQROoq8PbM3ZKIaOygjj6Yw0emJi1D9OsN2UKjoe4W185vamFWX4Ba41jmCPrYJWAWH
 fAMjjkInIPg7RLGs8FiwxfcpkILP0YbVWHiNAabQoVmlhY2hlc2xhdiBEdWJleWtvIDx2ZHViZXlr
 b0BrZXJuZWwub3JnPokCVAQTAQoAPhYhBFXDC2tnzsoLQtrbBDlc2cLfhEB1BQJoVemuAhsBBQkDw
 mcABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEDlc2cLfhEB1GRwP/1scX5HO9Sk7dRicLD/fxo
 ipwEs+UbeA0/TM8OQfdRI4C/tFBYbQCR7lD05dfq8VsYLEyrgeLqP/iRhabLky8LTaEdwoAqPDc/O
 9HRffx/faJZqkKc1dZryjqS6b8NExhKOVWmDqN357+Cl/H4hT9wnvjCj1YEqXIxSd/2Pc8+yw/KRC
 AP7jtRzXHcc/49Lpz/NU5irScusxy2GLKa5o/13jFK3F1fWX1wsOJF8NlTx3rLtBy4GWHITwkBmu8
 zI4qcJGp7eudI0l4xmIKKQWanEhVdzBm5UnfyLIa7gQ2T48UbxJlWnMhLxMPrxgtC4Kos1G3zovEy
 Ep+fJN7D1pwN9aR36jVKvRsX7V4leIDWGzCdfw1FGWkMUfrRwgIl6i3wgqcCP6r9YSWVQYXdmwdMu
 1RFLC44iF9340S0hw9+30yGP8TWwd1mm8V/+zsdDAFAoAwisi5QLLkQnEsJSgLzJ9daAsE8KjMthv
 hUWHdpiUSjyCpigT+KPl9YunZhyrC1jZXERCDPCQVYgaPt+Xbhdjcem/ykv8UVIDAGVXjuk4OW8la
 nf8SP+uxkTTDKcPHOa5rYRaeNj7T/NClRSd4z6aV3F6pKEJnEGvv/DFMXtSHlbylhyiGKN2Amd0b4
 9jg+DW85oNN7q2UYzYuPwkHsFFq5iyF1QggiwYYTpoVXsw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-09-28 at 23:03 -0300, Davy Felipe wrote:
> hfs_brec_insert() may fail while inserting a new extent record, but
> __hfs_ext_write_extent() currently ignores its return value and
> clears
> HFS_FLG_EXT_DIRTY and HFS_FLG_EXT_NEW as if the insertion had
> succeeded.
>=20
> Propagate errors returned by hfs_brec_insert() and only clear the
> extent flags after a successful insertion.
>=20
> When updating an existing extent record, hfs_bnode_write() returns
> void. Validate the extent write parameters before calling it so an
> invalid update is reported as -ERANGE instead of being treated as
> successful.
>=20
> Use a reusable B-tree node range helper that takes the find data and
> the expected record size. The helper validates the bnode and tree
> pointers, entry offset and entry length, and ensures that the write
> range fits within the node.
>=20
> Negative-path testing in QEMU confirmed that an insertion error is
> propagated to the caller. Testing the existing-record path also
> confirmed that invalid write parameters are rejected before
> HFS_FLG_EXT_DIRTY is cleared.
>=20
> Signed-off-by: Davy Felipe <davyfelipe34@gmail.com>
> Changes in v6:
> - Rename hfs_bnode_is_valid_range() to is_hfs_bnode_range_valid().
> - Use size_t for the expected record size.
> - Drop the redundant expected_len validity check.
> - Return -ERANGE for invalid find-data/range parameters.
> - Incorporate the final review feedback from Viacheslav Dubeyko.
>=20
> ---
> =C2=A0fs/hfs/btree.h=C2=A0 | 19 +++++++++++++++++++
> =C2=A0fs/hfs/extent.c | 10 ++++++++--
> =C2=A02 files changed, 27 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/hfs/btree.h b/fs/hfs/btree.h
> index b4c3f2a31471..1f703f2c53d8 100644
> --- a/fs/hfs/btree.h
> +++ b/fs/hfs/btree.h
> @@ -84,6 +84,25 @@ struct hfs_find_data {
> =C2=A0	int entryoffset, entrylength;
> =C2=A0};
> =C2=A0
> +static inline bool is_hfs_bnode_range_valid(struct hfs_find_data
> *fd,
> +					=C2=A0=C2=A0=C2=A0 size_t expected_len)
> +{
> +	struct hfs_bnode *node;
> +
> +	if (!fd)
> +		return false;
> +
> +	node =3D fd->bnode;
> +	if (!node || !node->tree)
> +		return false;
> +
> +	if (fd->entryoffset < 0 || fd->entrylength !=3D expected_len)
> +		return false;
> +
> +	return (u64)fd->entryoffset + fd->entrylength <=3D
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node->tree->node_size;
> +}
> +
> =C2=A0
> =C2=A0/* btree.c */
> =C2=A0extern struct hfs_btree *hfs_btree_open(struct super_block *sb, u32
> id,
> diff --git a/fs/hfs/extent.c b/fs/hfs/extent.c
> index f066a99a863b..26357086517f 100644
> --- a/fs/hfs/extent.c
> +++ b/fs/hfs/extent.c
> @@ -121,12 +121,18 @@ static int __hfs_ext_write_extent(struct inode
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
> +		if (!is_hfs_bnode_range_valid(fd,
> sizeof(hfs_extent_rec)))
> +			return -ERANGE;
> +		hfs_bnode_write(fd->bnode, HFS_I(inode)-
> >cached_extents,
> +				fd->entryoffset, fd->entrylength);
> =C2=A0		HFS_I(inode)->flags &=3D ~HFS_FLG_EXT_DIRTY;
> =C2=A0	}
> =C2=A0	return 0;

Looks good.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.
