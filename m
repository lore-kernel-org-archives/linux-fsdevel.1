Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3873C819A
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 06:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781591398; cv=none; b=bSVbxo8w0QuZ57WYv5rrJa0vf383zIg1e98TX0t/SNtCPKgE3pGXi5OWfRmKNx0Ohm+7ZQ+p45cAf9xYiesLwpK03xZWGohr7ihczdvAwoQt90J/SxKWyqjbsOIBWZWZrnv3fIIKM6QBgDfkdrXRkMFqU1NoZPo9jHf01nOjP/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781591398; c=relaxed/simple;
	bh=TuKCO9Z8rLOfM3+Y/aSGz3TWIKItqY+YcHNrrNF4E1E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oVGEU8ZUdSeCWjNAyTi14YKGf2cuBN1HI1UOuy8su/gWdSTT7un5MutHX9GQ2zXyJ8gQEPRJ65uaWtIsURoz3mTGJaY7ahRpd5fclIbPD1Cc9brpozWH/DsMzRjjRt0cd4ShUeOV5lsgii0lJpCvpTcC49Yh52G+28sUHnqs1U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=S07r59mv; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="S07r59mv"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aa5e0d57e5so3026437e87.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2026 23:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1781591395; x=1782196195; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mtHcjiL4wZ/ZXdW87t46y0DbqcjZ87COPUcQd6kBkwU=;
        b=S07r59mvP0yqsV0OG6AkMFfml/3vGUMNw0oEbHwyMKRvxSj5pMWn4MQcI3yX8wNOL8
         fKFoTMOIR//qtY8r50koqboCxSUeP82tsgVW1BU5dvyiwBaq1NrH6ss7r6X8I+vMeiEw
         8wADBTMZTl9OgNZNT5AfnfsTczeTCITquGXMFhVVlXTaRrtjn0GarMCHqTMXObdhvf+a
         UB6BWtCfSSKcyffU608e4esgqpqxFtG450eCfXbdvZGpwmkHt+89FfObQtlDqOFxTpvX
         fbwG0tr3XdsSRwYmIIMSsHpUMoQ10MJgLt6rPPJMMykGP9756MNTfNY8q0Ed0bfx5CIy
         hCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781591395; x=1782196195;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mtHcjiL4wZ/ZXdW87t46y0DbqcjZ87COPUcQd6kBkwU=;
        b=sTnayyfewdAuXFT38aSw9o8Fl4qHnO+4JM0vTVVmEF3x7rOaJpt+rkjQ+De0hI8qcM
         1kYDRVZ3pvPpNfJuJWqPAxsRV1gI/oFAOUPf6/Dz6DJ7IlVjkzMF6JhKSlOlHXcQQY3+
         15ZEDj/lI4tiHmmjJbcPEF26A/sadxp3Oyo8grFi190Zrp0x7ldH51HqsDk7Dfv9NgMe
         +BWNfHii+zbrxUFqYZnt5NhuNLyYgBjcTPdttI45HUDT6uJMR9FS9IYYby/C8nkX+R4l
         TbMKYUc8Ayg48uCS+l6JWHMdUEQ4G2zF26QKu1JuxqFjsqEFGcSYhLZc3K9P2vwHlaTU
         tTGg==
X-Forwarded-Encrypted: i=1; AFNElJ8UgsxXPMJJCrFVo0W69yfh2On3V20KPvtWPmQiiq6dG28IKJfWKHZUO/8Jt8ugFceRa8GfIX5X9z4PyYOH@vger.kernel.org
X-Gm-Message-State: AOJu0YxY+zLDzZ3hThqvWpZ3SGW50TXfACP93MEqk5mKSaYJeIQS48Qi
	LvmdBQ7+uW+73Q2HBw+xopxc5gbtmO7uhHEf2p6dL1rr/ehQqOLcqX8RVjmDyp9IeO0=
X-Gm-Gg: Acq92OEDnYvP7MrsmwyHJsUpzWKLC0uCjESHfnGc2fAMWHmSUbE9Ze1iL7a1RIhyA6k
	a5+C8OobwlGIxS2GGh7bD5lCcUxzG8kzNkWiFAKFb0gOgnD3Eb5HiTkpCGqYDLSFw68s+/yKj1X
	vrqQNzXfLSPICROHAem4qyG3kp+Bv0xgCNZgWQeWVUY7dvlAkER0vujLGaqnSJST86w1ETBWcXy
	ZconbgONMMjZJf2e+MGHmjQ4mEN4neuHWkyJXwLvxdqhKXDS1ZaJgK/YP/ao3vx/LYCtTY+CDhE
	8L79PPnDFSMvn8GXErMNYuULBY2/j31gzDeCrjxB7UDDr9YmP/scq8XqLFJpxJiCXWMpNKbgI/E
	sDahx4eh+01aO7UaVstm5QiCX1RZa/ToCffpvpIEkCCcAAvR5Ay8lSJ7inNUDccn2vLhIdz0xLc
	62PnBowDQKckRbNYz4Yf4bSyF8Ywcn6giQ+4J3SODtGpp9GCtcZSTGAJOHH/7B4WI4bkT37tL3T
	FztIVO0Bw==
X-Received: by 2002:a05:6512:1595:b0:5aa:6a5c:be4e with SMTP id 2adb3069b0e04-5ad2db37a06mr4645488e87.12.1781591395069;
        Mon, 15 Jun 2026 23:29:55 -0700 (PDT)
Received: from [192.168.3.148] ([31.23.24.48])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e161f52sm3237267e87.6.2026.06.15.23.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 23:29:54 -0700 (PDT)
Message-ID: <52bae72d5ca54eed5b4f2218fca124e5bbb0747a.camel@dubeyko.com>
Subject: Re: HFS syzbot BUG: test patch validating metadata before
 hfs_write_inode()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: David Maximiliano Hermitte <davemadmaxxx@gmail.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li
	 <frank.li@vivo.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 15 Jun 2026 23:29:50 -0700
In-Reply-To: <20260612162043.1524591-1-davemadmaxxx@gmail.com>
References: <20260612162043.1524591-1-davemadmaxxx@gmail.com>
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

Hi David,

On Fri, 2026-06-12 at 16:20 +0000, David Maximiliano Hermitte wrote:
> Hi Slava,
>=20
> I followed the direction you pointed out and tested a small HFS
> validation patch for the syzbot crash path.
>=20
> This is not intended as a final upstream patch yet. I am sending it
> as a test patch to demonstrate the crash direction and to ask whether
> this is the right validation point. If the direction is correct, I
> would appreciate guidance on the preferred upstream placement and
> syntax before a formal submission.
>=20
> My understanding is that the BUG() in hfs_write_inode() is the
> endpoint, not the root cause. This test patch keeps hfs_write_inode()
> intact and rejects corrupted HFS metadata earlier in hfs_read_inode()
> and hfs_brec_read().
>=20
> Local QEMU result:
>=20
> BEFORE_UNPATCHED:
> - repro_started=3Dtrue
> - kernel_bug_seen=3Dtrue
> - verdict=3DBEFORE_BUG_REPRODUCED
>=20
> AFTER_V04_PATCHED:
> - repro_started=3Dtrue
> - clean_hfs_rejects=3D50
> - kernel_bug=3DFalse
> - oops=3DFalse
> - kasan=3DFalse
> - hfs_write_inode=3DFalse
> - verdict=3DAFTER_REPRO_RAN_NO_BUG_SEEN
>=20
> checkpatch.pl --strict:
> - 0 errors, 0 warnings
>=20
> The test patch is included below inline. Full QEMU serial logs are
> available if useful.
>=20
> Please let me know whether this validation direction matches what you
> expect, or whether the fix should be placed differently.
>=20

Sorry, I am in personal trip right now. And I have not much time and
capabilities for deep review and discussion. I am going to be back to
normal routine around June 26th. I hope our discussion and fix can wait
two weeks. :) Could you please ping me and revive the discussion around
that time?

Thanks,
Slava.

> Best regards,
> David
>=20
> --- test patch follows ---
>=20
> diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
> index d56e47b..5f56cab 100644
> --- a/fs/hfs/bfind.c
> +++ b/fs/hfs/bfind.c
> @@ -174,8 +174,10 @@ int hfs_brec_read(struct hfs_find_data *fd, void
> *rec, u32 rec_len)
> =C2=A0	res =3D hfs_brec_find(fd);
> =C2=A0	if (res)
> =C2=A0		return res;
> +	if (fd->entryoffset < 0 || fd->entrylength <=3D 0)
> +		return -EFSCORRUPTED;
> =C2=A0	if (fd->entrylength > rec_len)
> -		return -EINVAL;
> +		return -EFSCORRUPTED;
> =C2=A0	hfs_bnode_read(fd->bnode, rec, fd->entryoffset, fd-
> >entrylength);
> =C2=A0	return 0;
> =C2=A0}
> diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
> index 878535d..beefb47 100644
> --- a/fs/hfs/inode.c
> +++ b/fs/hfs/inode.c
> @@ -369,6 +369,8 @@ static int hfs_read_inode(struct inode *inode,
> void *data)
> =C2=A0	rec =3D idata->rec;
> =C2=A0	switch (rec->type) {
> =C2=A0	case HFS_CDR_FIL:
> +		if (be32_to_cpu(rec->file.FlNum) <
> HFS_FIRSTUSER_CNID)
> +			return -EFSCORRUPTED;
> =C2=A0		if (!HFS_IS_RSRC(inode)) {
> =C2=A0			hfs_inode_read_fork(inode, rec->file.ExtRec,
> rec->file.LgLen,
> =C2=A0					=C2=A0=C2=A0=C2=A0 rec->file.PyLen,
> be16_to_cpu(rec->file.ClpSize));
> @@ -390,6 +392,9 @@ static int hfs_read_inode(struct inode *inode,
> void *data)
> =C2=A0		inode->i_mapping->a_ops =3D &hfs_aops;
> =C2=A0		break;
> =C2=A0	case HFS_CDR_DIR:
> +		if (be32_to_cpu(rec->dir.DirID) < HFS_FIRSTUSER_CNID
> &&
> +		=C2=A0=C2=A0=C2=A0 be32_to_cpu(rec->dir.DirID) !=3D HFS_ROOT_CNID)
> +			return -EFSCORRUPTED;
> =C2=A0		inode->i_ino =3D be32_to_cpu(rec->dir.DirID);
> =C2=A0		inode->i_size =3D be16_to_cpu(rec->dir.Val) + 2;
> =C2=A0		HFS_I(inode)->fs_blocks =3D 0;
