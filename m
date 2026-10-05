Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DCB372EFF
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Oct 2026 19:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791228046; cv=none; b=c02PXvEPkGxW1KRT5vACsdpu5uDukL3rH0joELEgIV9S0Q6pZFfTXWe7I9rH33TkF1OY6C5YA6kZTrkfA35sr7FtPW+pysLr7SweayuvV64G3Gc2oTESpuh2JqKZVczN6O0jUQGxQG6bWbdLzaUE6scVH5qDC89vAHfLkMJoGxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791228046; c=relaxed/simple;
	bh=7uMgTvJ/2jWF5CieZNXiJtpOEIxrr6FOQuNBV2lCipM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oSCwXKYCsxvx3usbDEc3d3sa5IBqlL0XkVnr7tx9JdMtz3g782FmUVnzQ2youPB3UUPawJbK6mFFJbgg6EI4LtIJJbvNiWanqyTMVjSfS+cT0iS0wxjAaMVJ2Dzj+KlFefSki7ZUnH6iDv777F7WyUcqakWBUNZgC+gA6UukQLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=kc0xXuxJ; arc=none smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="kc0xXuxJ"
Received: by mail-yx2-f40.google.com with SMTP id 956f58d0204a3-6756a6320f6so1677386d50.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Oct 2026 12:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1791228043; x=1791832843; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r3ddCUU12UfEhOvaq9Jj0tjrF27Mf6/B/ICeK/6Qy5I=;
        b=kc0xXuxJXqegc8j3rDuGXKgqijsFTVNDnbbQJqI+rnohDzpq+jRfsqTwnccKI0mvHy
         n+xlPuD0C0FgrSTBykIBAOu/GcBscXTjdZ7dHSYCSCEFindYhgJ1LNiWKaGQfXgt1IuK
         xCCCdKeWwzbxtBmCIWV7cYNh2nLnovlaZY7s9ndT0zeNPtoOoafUHnCOdootNheh+YWM
         tt89yPi1e5BQDjzQD8QgxjD9ulHXNJOHiKweOCIhWmuT7IPlxFn4QTPC3SdPIrmiv++b
         axUc75nQTWuatgbEjj4O9g3WEGP606ovv1a5EokZ7fs2QKvdQTTF8bvtCIHt1wNVQ7as
         S4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791228043; x=1791832843;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=r3ddCUU12UfEhOvaq9Jj0tjrF27Mf6/B/ICeK/6Qy5I=;
        b=e0DtZBRE2C15qZsvupZTicfpNdTIvHh7rHRtEsFNur/4DBVzdYJazLyCKwF+Jyr3zk
         qEsug6aSjtv2psYdkRSNK18W5fxlnlWsB1pVPLOXIpyiliY+Pv1/fhYlj88es4KTglXW
         4OObRxY4MTL5jOxydSRzmQZ08bxp3UyG0wmhjciRMHmyLkOFRizDwHk1iA2+bhdekEMC
         9yrI4d7peQrJg0BzUyfpAry5haRV67pJMIx3VVBgzHkKrHO379oFEazE/LIl1CCb1gXh
         liUjgWXKNfLmiKEkcOqzNZNOhc9cVp7AhYWbp3nTKwKdm6qa6A7RhVPbXevmBaRZRWC7
         Dfkg==
X-Forwarded-Encrypted: i=1; AKwUvBx7/3gCnBZfWLMFJIm5dUnw4OSaGO4ttYwuwxyfFHjRMcOELuWu/kqrH/ti7EYXPaRIfglzHnjtQaPXIQeu@vger.kernel.org
X-Gm-Message-State: AFq9FYKEmtkhGB1t4FSOizmAGryMO1kzV1BbG+g6SM5g2iTOjpBqf56s
	e2cC1h/yd88aGMIrRfbGuAmAQcXFOyEWrh9JZqbalR2TZFG2MQs07YkLgsTK4tUUfSFhPE9YmNP
	McgD+4pA=
X-Gm-Gg: AYBFou21vUzs2ju9nyPmxbuIFmHrsQ+gs4faMnvqiNFv3bsJdfMOYPtw7Zq4mRaw7/2
	zzMkdhxHZ9byls/g1f1I9PpdxWwdy1x8Rv0AmE2PsWaWm8Gfn6WxSv1ZG1r+yik/e5wJaP6V7We
	M/LZniOjU0eVCb28onagedPsdkH/JbOYxoNdhwiQpB7R/p7rquAn+9K2YbFHdgMfxuAMTpKnvqe
	3xn0hMveBPN+uVM+5hlg4VbSIjOJgQqOOFWl9AppOUmoqudpZM1L/3BiV3LaBbb+KiJR6yqqEH3
	gPx5tTzm5JU03Yf9RaZz5E/rXZ5IbPMzW48uFeAzt66yOCOI15wO4axNpE39sxNS3nDA+t4IRGK
	4Uu8Gxu8IwhZq1oIFGNzs9hb2LdEFlcxb0QPXkMHC+ftok6CRkA8eCZQ/GHmHx4sYaRSmATXyIT
	9R8ateDX9PNmyEDam2+YCK1pXtwmGaPhocaK4h/T7tYIwBp/c0vsWe/wasmAvJAHqJRVnXBz0rz
	2PWS8RdxaGvSlfZJnZnsAIESUnqcge97eD9SE6EuhcQhybQpc6OC4VdOCRMLqLY4Dd06EPQfTT7
	ai5sNCz1D/uRNneb2rTN48gm0B36ODvWAyRkdGUS8Ju8Ix8ezl5ZWOXt+WTBViet
X-Received: by 2002:a05:690e:b81:b0:674:1b39:fe1 with SMTP id 956f58d0204a3-677bbc010d4mr3663453d50.107.1791228043201;
        Mon, 05 Oct 2026 12:20:43 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:3aa0:911f:4e09:b45d? ([2600:1700:6476:1430:3aa0:911f:4e09:b45d])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-677c1bb2b71sm3312948d50.15.2026.10.05.12.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 12:20:42 -0700 (PDT)
Message-ID: <29df2c2288ae460c14adc33ad2ad3ef818916099.camel@dubeyko.com>
Subject: Re: [PATCH v3 2/2] hfs: free cached B-tree nodes on
 hfs_btree_open() error path
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Mahmut Emin Kurhan <guvenlik@noroxi.com>, linux-fsdevel@vger.kernel.org
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-kernel@vger.kernel.org
Date: Mon, 05 Oct 2026 12:20:40 -0700
In-Reply-To: <20261001213807.1519745-3-guvenlik@noroxi.com>
References: <0de056179e3e0a7c4ef525cdb143647b7493dc71.camel@dubeyko.com>
	 <20261001213807.1519745-1-guvenlik@noroxi.com>
	 <20261001213807.1519745-3-guvenlik@noroxi.com>
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

On Thu, 2026-10-01 at 23:38 +0200, Mahmut Emin Kurhan wrote:
> The classic HFS driver has the same B-tree node leak as hfsplus: on
> the
> hfs_btree_open() error path after hfs_bnode_find(tree,
> HFS_TREE_HEAD), an
> errored head node left in tree->node_hash is not freed because
> free_tree:
> does a bare kfree(tree) instead of walking the hash.
>=20
> Apply the same fix: factor the node-hash freeing into
> hfs_bnode_hash_free()
> and call it from hfs_btree_close() and the hfs_btree_open() error
> path. The
> helper keeps the hash_lock serialization from commit dce0e0248205
> ("hfs/hfsplus:
> serialize B-tree close against folio release").
>=20
> Found via coverage-guided fuzzing (syzkaller + kmemleak) by Noroxi.
>=20
> Signed-off-by: Mahmut Emin Kurhan <guvenlik@noroxi.com>

Please, see my comments for HFS+ patch. This patch has the same issues.

Thanks,
Slava.

> ---
> =C2=A0fs/hfs/btree.c | 40 +++++++++++++++++++++++-----------------
> =C2=A01 file changed, 23 insertions(+), 17 deletions(-)
>=20
> diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
> index 4f0ddc76e8..140cdb5ec6 100644
> --- a/fs/hfs/btree.c
> +++ b/fs/hfs/btree.c
> @@ -131,6 +131,27 @@ static int hfs_bmap_clear_bit(struct hfs_bnode
> *node, u32 node_bit_idx)
> =C2=A0}
> =C2=A0
> =C2=A0/* Get a reference to a B*Tree and do some initial checks */
> +static void hfs_bnode_hash_free(struct hfs_btree *tree)
> +{
> +	struct hfs_bnode *node;
> +	int i;
> +
> +	for (i =3D 0; i < NODE_HASH_SIZE; i++) {
> +		spin_lock(&tree->hash_lock);
> +		while ((node =3D tree->node_hash[i])) {
> +			hfs_bnode_unhash(node);
> +			spin_unlock(&tree->hash_lock);
> +			if (atomic_read(&node->refcnt))
> +				pr_err("node %d:%d still has %d
> user(s)!\n",
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node->tree->cnid, node->this,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_read(&node->refcnt));
> +			hfs_bnode_free(node);
> +			spin_lock(&tree->hash_lock);
> +		}
> +		spin_unlock(&tree->hash_lock);
> +	}
> +}
> +
> =C2=A0struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id,
> btree_keycmp keycmp)
> =C2=A0{
> =C2=A0	struct hfs_btree *tree;
> @@ -296,6 +317,7 @@ struct hfs_btree *hfs_btree_open(struct
> super_block *sb, u32 id, btree_keycmp ke
> =C2=A0	tree->inode->i_mapping->a_ops =3D &hfs_aops;
> =C2=A0	iput(tree->inode);
> =C2=A0free_tree:
> +	hfs_bnode_hash_free(tree);
> =C2=A0	kfree(tree);
> =C2=A0	return NULL;
> =C2=A0}
> @@ -303,26 +325,10 @@ struct hfs_btree *hfs_btree_open(struct
> super_block *sb, u32 id, btree_keycmp ke
> =C2=A0/* Release resources used by a btree */
> =C2=A0void hfs_btree_close(struct hfs_btree *tree)
> =C2=A0{
> -	struct hfs_bnode *node;
> -	int i;
> -
> =C2=A0	if (!tree)
> =C2=A0		return;
> =C2=A0
> -	for (i =3D 0; i < NODE_HASH_SIZE; i++) {
> -		spin_lock(&tree->hash_lock);
> -		while ((node =3D tree->node_hash[i])) {
> -			hfs_bnode_unhash(node);
> -			spin_unlock(&tree->hash_lock);
> -			if (atomic_read(&node->refcnt))
> -				pr_err("node %d:%d still has %d
> user(s)!\n",
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node->tree->cnid, node->this,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_read(&node->refcnt));
> -			hfs_bnode_free(node);
> -			spin_lock(&tree->hash_lock);
> -		}
> -		spin_unlock(&tree->hash_lock);
> -	}
> +	hfs_bnode_hash_free(tree);
> =C2=A0	iput(tree->inode);
> =C2=A0	kfree(tree);
> =C2=A0}
