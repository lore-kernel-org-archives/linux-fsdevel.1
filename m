Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C7741F37E
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 19:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784057344; cv=none; b=PeCGa6yNW6sPyU8GEdqaA9bBkBMF9Po2Zcj5LfY2jB9npcvdK5o++K3GB4dhpjTn78/vUxP7X3IxHQqBze+RuCrpbHUY9iE9plnhAidXNuQNF28NpVzKqLnXamjMgLYMsg2SCJJe+KUEbXlQy4tjCUotnDOekbAJIDDsql5EvT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784057344; c=relaxed/simple;
	bh=ERFt2ldLIhTM/JdmLcXDIgw4tzN4vuokhOefiGFfQog=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ibhrH20UV6L4qyjhm358p2meW9qIETjmQZ1tN26MSsL8YWnUK9EUO3Xw1CjQvK++5rDPYgic8TrO1duHiMOTnk4I+MqVOXcYkAX5Q3kmX8uJyuVw4DN2odRi2GfpRW8rc/QLVTN3YYoerEgNkL0DkrkLIFGsBlOARDGfhC+s1e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=lpzRNt+E; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="lpzRNt+E"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6626b5ace23so2071040d50.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 12:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784057340; x=1784662140; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q5eAIuwrz3Szwb8aM2czXr2T8IAWifvag7+ZKVXdx2c=;
        b=lpzRNt+EYNrSH8MlRYvF14vXHg0LhUBfZtZUBotBWWCLq3daH51gJjHRC4KgDVGPBQ
         ZdPCXgJikvCqCOyM/yC2nzaxCjXafbVgv9JlN5b2PyyOVM7G/BBjSwPyi8XHEKreZf5i
         vVaM4cweTXDHVZLBXqh7Cu212oWNHprZc9f0aIuLD5Te4uYOafoXEy5EAZ6p3T+imopi
         1jorr33kzzj3YWNRFBvSpPfoa5lq31tsiaoCJNh2gMPQtslVNZOydABr3cdYhZq/7c2b
         2hQYgqYWEVkg2x8tAtPcTRQh6jJhHHPpRMUgfYtxOnDMrpjFgBj16puzb7Yo/tb77Vf+
         VpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784057340; x=1784662140;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Q5eAIuwrz3Szwb8aM2czXr2T8IAWifvag7+ZKVXdx2c=;
        b=tOrJlV8mF6ymRW27xQn01koqgwEQWpvcfpq/LYwF4KctRTlIS+dWs6umbBXZSTbUWu
         oDpEDKbw6j5BGmFiPlr2dQ0nIy5HhTLPIV5j6X3CTRXjQm9v0tGbaKemgeHzgBEdGpHD
         FR5xRowUSpLFfv7ANHs/2UxL1btiDQ09FAvzgipUIlw22zKnnImeA6YfbDXpI3HcLwmw
         y5ftK/rBK9rFjhwgxwJjqC+gwKmaJyhhnvGK8YB9l/lH7AfKd6fO30lYba4AC8XaIwnh
         K1He+RymajDQmt3TIRjVu2HCAjQaHgAANK/RbmCllU7lXYMElMGPIhJDlGbWsbApICLw
         swNA==
X-Forwarded-Encrypted: i=1; AHgh+RoG0mv8C4xgUjWD5mVV07uDJ+aqzUVM46zXr4WsVE6REl/pHddK46jSwrW6jo1KnGtsu6AYUljWiqbWH4HJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhqcfo31DiKW47SmbN4t0rGsOHAjVBt1S7EKJTEhZPP4uLSeg+
	PD59jdNxVjdzi1+rZFLceSoqcCm0K/9L/b9UUBOophrPIdyLrr6gYRk5BzLmvvLYKaI=
X-Gm-Gg: AfdE7ckQj4eGONJyL3RC5dYXCiR11vHUYBzWKtrrPgbTBmcjm3pIIyWCY6qa7plP9AO
	0Sjua0ACs/S0n0i6UNDVsfOG6rVID8i+5w0cuOz9ZxGaJzIpzXugfe9o8L3OrUJytgOBl4O3PGR
	JVFSrDo0g5SO6HfQI4yuOm1lB1YBw3RWmiVo8XLox2ZoXTAVWdlIX666hfHYIbQAJg75Q9jMnH8
	i5LeFT0AScWvSDBHPDae/PcSORDkgrCLXoRV0LfmX8D5NerIRwQNlpQIdTI5h+7FRoqeLISrl3x
	vuN9yFomHfOiGqixF8tiYIUI3Z5ruHZcTGsr2gqGBiWIn+H4IkNlazrAAwWBCELJWNkBvTnM9uJ
	s+VMFkH2CEVhRxjre4gnpu/oDBjIdC7H8DOi4Qz8aRy6ZfUVTdWoTq0Suucrn9tug7PByglbS8F
	yOSlVm8fuDG5BTfFrT16WcgayorsQaqpTWtb4GMdub3DrDYs4W+8U9MzDk/K9lWulMqoNQwZGBJ
	a3wO0eq572/0ASnsV5LjSE9zW4q7PDeS6dyd84IGqkTAA==
X-Received: by 2002:a05:690c:e64b:b0:81e:9be5:f7ac with SMTP id 00721157ae682-81e9be60e64mr61977437b3.11.1784057340336;
        Tue, 14 Jul 2026 12:29:00 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:9b87:2209:14fb:1802])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6c22441csm150702577b3.43.2026.07.14.12.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 12:28:59 -0700 (PDT)
Message-ID: <f33f164b5c8cf6b12c92629700b715971a1d22a8.camel@dubeyko.com>
Subject: Re: [PATCH v4] hfs: port HFS+ b-tree bitmap corruption check
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 14 Jul 2026 12:28:58 -0700
In-Reply-To: <20260714092715.2758-1-aditya.ansh182@gmail.com>
References: <20260714092715.2758-1-aditya.ansh182@gmail.com>
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

On Tue, 2026-07-14 at 09:27 +0000, Aditya Prakash Srivastava wrote:
> In HFS+ filesystems, during b-tree open (hfs_btree_open()), the code
> verifies that the allocation map bit for the tree header (node 0) is
> set. If not, it indicates a corrupted map record/bitmap and mounts
> the volume as read-only (SB_RDONLY) to prevent further damage.
>=20
> HFS filesystems share the same b-tree structure but currently lack
> this corruption detection check.
>=20
> Port this check to HFS, aligning its implementation with HFS+ to
> maintain consistent b-tree logic across both filesystems:
> 1. Define struct hfs_bmap_ctx, and define HFS_TREE_HEAD and the
> relevant
> =C2=A0=C2=A0 map record indices in include/linux/hfs_common.h.
> 2. Implement static hfs_bmap_get_map_page() in fs/hfs/btree.c, and
> port
> =C2=A0=C2=A0 the necessary offset and length validation helpers to
> fs/hfs/btree.h
> =C2=A0=C2=A0 as static inline functions with robust null pointer checks.
> 3. Implement static hfs_bmap_test_bit() in fs/hfs/btree.c to inspect
> =C2=A0=C2=A0 the B-tree bitmap using the new get_map_page helper.
> 4. In hfs_btree_open(), retrieve the header node via
> hfs_bnode_find(),
> =C2=A0=C2=A0 test its allocation bit with hfs_bmap_test_bit(), and releas=
e it
> =C2=A0=C2=A0 using hfs_bnode_put().
>=20
> Suggested-by: Viacheslav Dubeyko <slava@dubeyko.com>
> Link:
> https://lore.kernel.org/all/6a36101b.be22b350.2a3e9.0001.GAE@google.com/T=
/#r446d0fed2a2900bd805534bbcb799d86619ae2ea
> Signed-off-by: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
> ---
> =C2=A0fs/hfs/bnode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 42 -------------------
> =C2=A0fs/hfs/btree.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 86
> ++++++++++++++++++++++++++++++++++++++
> =C2=A0fs/hfs/btree.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 40 ++++++++++++++++++
> =C2=A0include/linux/hfs_common.h |=C2=A0 5 +++
> =C2=A04 files changed, 131 insertions(+), 42 deletions(-)
>=20
> diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
> index da8e5342c91c..1b331108d9c0 100644
> --- a/fs/hfs/bnode.c
> +++ b/fs/hfs/bnode.c
> @@ -15,48 +15,6 @@
> =C2=A0
> =C2=A0#include "btree.h"
> =C2=A0
> -static inline
> -bool is_bnode_offset_valid(struct hfs_bnode *node, u32 off)
> -{
> -	bool is_valid =3D off < node->tree->node_size;
> -
> -	if (!is_valid) {
> -		pr_err("requested invalid offset: "
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "NODE: id %u, type %#x, height %u=
, "
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "node_size %u, offset %u\n",
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node->this, node->type, node->hei=
ght,
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node->tree->node_size, off);
> -	}
> -
> -	return is_valid;
> -}
> -
> -static inline
> -u32 check_and_correct_requested_length(struct hfs_bnode *node, u32
> off, u32 len)
> -{
> -	unsigned int node_size;
> -
> -	if (!is_bnode_offset_valid(node, off))
> -		return 0;
> -
> -	node_size =3D node->tree->node_size;
> -
> -	if ((u64)off + len > node_size) {
> -		u32 new_len =3D node_size - off;
> -
> -		pr_err("requested length has been corrected: "
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "NODE: id %u, type %#x, height %u=
, "
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "node_size %u, offset %u, "
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "requested_len %u, corrected_len =
%u\n",
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node->this, node->type, node->hei=
ght,
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node->tree->node_size, off, len, =
new_len);
> -
> -		return new_len;
> -	}
> -
> -	return len;
> -}
> -
> =C2=A0void hfs_bnode_read(struct hfs_bnode *node, void *buf, u32 off, u32
> len)
> =C2=A0{
> =C2=A0	struct page *page;
> diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
> index 2eb37a2f64e8..2c841221c45c 100644
> --- a/fs/hfs/btree.c
> +++ b/fs/hfs/btree.c
> @@ -15,6 +15,8 @@
> =C2=A0
> =C2=A0#include "btree.h"
> =C2=A0
> +static bool hfs_bmap_test_bit(struct hfs_bnode *node, u32
> node_bit_idx);

Logically, implementation should be here but not the forward
declaration. :) Could you please move the implementation?

> +
> =C2=A0/* Get a reference to a B*Tree and do some initial checks */
> =C2=A0struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id,
> btree_keycmp keycmp)
> =C2=A0{
> @@ -23,6 +25,7 @@ struct hfs_btree *hfs_btree_open(struct super_block
> *sb, u32 id, btree_keycmp ke
> =C2=A0	struct address_space *mapping;
> =C2=A0	struct folio *folio;
> =C2=A0	struct buffer_head *bh;
> +	struct hfs_bnode *node;
> =C2=A0	unsigned int size;
> =C2=A0	u16 dblock;
> =C2=A0	sector_t start_block;
> @@ -155,6 +158,20 @@ struct hfs_btree *hfs_btree_open(struct
> super_block *sb, u32 id, btree_keycmp ke
> =C2=A0	kunmap_local(head);
> =C2=A0	folio_unlock(folio);
> =C2=A0	folio_put(folio);
> +
> +	node =3D hfs_bnode_find(tree, HFS_TREE_HEAD);
> +	if (IS_ERR(node))
> +		goto free_inode;
> +
> +	if (!hfs_bmap_test_bit(node, HFS_TREE_HEAD)) {
> +		pr_warn("(%s): %s (cnid 0x%x) bitmap corrupted,
> forcing rdonly\n",
> +			sb->s_id, id =3D=3D HFS_EXT_CNID ? "extents" :
> "catalog", id);
> +		pr_warn("Run fsck.hfs to repair.\n");
> +		sb->s_flags |=3D SB_RDONLY;
> +	}
> +
> +	hfs_bnode_put(node);
> +
> =C2=A0	return tree;
> =C2=A0
> =C2=A0fail_folio:
> @@ -356,6 +373,75 @@ struct hfs_bnode *hfs_bmap_alloc(struct
> hfs_btree *tree)
> =C2=A0	}
> =C2=A0}
> =C2=A0
> +/* Context for iterating b-tree map pages
> + * @page_idx: The index of the page within the b-node's page array
> + * @off: The byte offset within the mapped page
> + * @len: The remaining length of the map record
> + */
> +struct hfs_bmap_ctx {
> +	unsigned int page_idx;
> +	unsigned int off;
> +	u16 len;
> +};
> +
> +static struct page *hfs_bmap_get_map_page(struct hfs_bnode *node,
> +					=C2=A0 struct hfs_bmap_ctx *ctx,
> +					=C2=A0 u32 byte_offset)
> +{
> +	u16 rec_idx, off16;
> +	unsigned int page_off;
> +
> +	if (node->this =3D=3D HFS_TREE_HEAD) {
> +		if (node->type !=3D HFS_NODE_HEADER) {
> +			pr_err("hfs: invalid btree header node\n");
> +			return ERR_PTR(-EIO);
> +		}
> +		rec_idx =3D HFS_BTREE_HDR_MAP_REC_INDEX;
> +	} else {
> +		if (node->type !=3D HFS_NODE_MAP) {
> +			pr_err("hfs: invalid btree map node\n");
> +			return ERR_PTR(-EIO);
> +		}
> +		rec_idx =3D HFS_BTREE_MAP_NODE_REC_INDEX;
> +	}
> +
> +	ctx->len =3D hfs_brec_lenoff(node, rec_idx, &off16);
> +	if (!ctx->len)
> +		return ERR_PTR(-ENOENT);
> +
> +	if (!is_bnode_offset_valid(node, off16))
> +		return ERR_PTR(-EIO);
> +
> +	ctx->len =3D check_and_correct_requested_length(node, off16,
> ctx->len);
> +
> +	if (byte_offset >=3D ctx->len)
> +		return ERR_PTR(-EINVAL);
> +
> +	page_off =3D (u32)off16 + node->page_offset + byte_offset;
> +	ctx->page_idx =3D page_off >> PAGE_SHIFT;
> +	ctx->off =3D page_off & ~PAGE_MASK;
> +
> +	return node->page[ctx->page_idx];
> +}
> +
> +static bool hfs_bmap_test_bit(struct hfs_bnode *node, u32
> node_bit_idx)
> +{
> +	struct hfs_bmap_ctx ctx;
> +	struct page *page;
> +	u8 *bmap, byte, mask;
> +
> +	page =3D hfs_bmap_get_map_page(node, &ctx, node_bit_idx /
> BITS_PER_BYTE);
> +	if (IS_ERR(page))
> +		return false;
> +
> +	bmap =3D kmap_local_page(page);
> +	byte =3D bmap[ctx.off];
> +	kunmap_local(bmap);
> +
> +	mask =3D 1 << (7 - (node_bit_idx % BITS_PER_BYTE));
> +	return (byte & mask) !=3D 0;
> +}
> +
> =C2=A0void hfs_bmap_free(struct hfs_bnode *node)
> =C2=A0{
> =C2=A0	struct hfs_btree *tree;
> diff --git a/fs/hfs/btree.h b/fs/hfs/btree.h
> index 99be858b2446..f8afa33f709a 100644
> --- a/fs/hfs/btree.h
> +++ b/fs/hfs/btree.h
> @@ -129,3 +129,43 @@ extern int __hfs_brec_find(struct hfs_bnode
> *bnode, struct hfs_find_data *fd);
> =C2=A0extern int hfs_brec_find(struct hfs_find_data *fd);
> =C2=A0extern int hfs_brec_read(struct hfs_find_data *fd, void *rec, u32
> rec_len);
> =C2=A0extern int hfs_brec_goto(struct hfs_find_data *fd, int cnt);
> +
> +static inline bool is_bnode_offset_valid(struct hfs_bnode *node, u32
> off)
> +{
> +	bool is_valid;
> +
> +	if (!node || !node->tree)
> +		return false;
> +
> +	is_valid =3D off < node->tree->node_size;
> +
> +	if (!is_valid) {
> +		pr_err("invalid offset: id %u, type %x, h %u, sz %u,
> off %u\n",
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node->this, node->type, node->hei=
ght,
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node->tree->node_size, off);
> +	}
> +
> +	return is_valid;
> +}
> +
> +static inline u32 check_and_correct_requested_length(struct
> hfs_bnode *node, u32 off, u32 len)
> +{
> +	unsigned int node_size;
> +
> +	if (!is_bnode_offset_valid(node, off))
> +		return 0;
> +
> +	node_size =3D node->tree->node_size;
> +
> +	if ((u64)off + len > node_size) {
> +		u32 new_len =3D node_size - off;
> +
> +		pr_err("corrected len: id %u, type %x, h %u, sz %u,
> off %u, len %u->%u\n",
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node->this, node->type, node->hei=
ght,
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node_size, off, len, new_len);
> +
> +		return new_len;
> +	}
> +
> +	return len;
> +}
> diff --git a/include/linux/hfs_common.h b/include/linux/hfs_common.h
> index 45fb4c9ff9f5..8dc10e0bfa7e 100644
> --- a/include/linux/hfs_common.h
> +++ b/include/linux/hfs_common.h
> @@ -510,6 +510,11 @@ struct hfs_btree_header_rec {
> =C2=A0						=C2=A0=C2=A0 b-tree but not in
> extents
> =C2=A0						=C2=A0=C2=A0 b-tree (hfsplus).
> */
> =C2=A0
> +/* HFS BTree misc info */
> +#define HFS_TREE_HEAD				0
> +#define HFS_BTREE_HDR_MAP_REC_INDEX		2	/* Map
> (bitmap) record in Header node */
> +#define HFS_BTREE_MAP_NODE_REC_INDEX		0	/* Map
> record in Map Node */

Probably, we need to re-use HFS declarations for the case of HFS+. I
suggest this way for all three constants:

#define HFSPLUS_TREE_HEAD          HFS_TREE_HEAD

Thanks,
Slava.

> +
> =C2=A0/* HFS+ BTree misc info */
> =C2=A0#define HFSPLUS_TREE_HEAD			0
> =C2=A0#define HFSPLUS_NODE_MXSZ			32768
