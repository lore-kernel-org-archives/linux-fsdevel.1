Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794866548;
	b=TeOCr3PcYOyN5XMnrTAaDKiDXfByyf9gOAUVPmA2XtEOOFf8UMA+EpjP4jCt7Jw638h5
	 GLOt8OhmB4kXs7xDFBdiXkj51hlTK7Cq5mMFNap0jMGmerlqG65jHw1YEcXeGroRIGNVc
	 LauiUqTAORBKWtuneVWmiuj5rQFbljCyXVLoxBq1vCYz3WSe6e9AwuRcJ+dVVW1uRX46B
	 WnF1D3T2hvUlgg9jIFwOSQoMN9FvL0h0Kw/KZTf5CmeHtRaPeko8HIRddrsQLt5+nQ6YH
	 6CV792YX7EfJkMVT6wFrvyccBIYMefDPnbMM/WtR68w1yBA8WVkBWsN4THsWerrpopg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794866548;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=ETqs6DxejkpVOQvRklLap6bIJv44iisLss+lfdx7Ch4=;
	b=bCJob9wAHjqlLdiyiJ+DgwvZ3fmw113PATlnUiMto4WbHcuwBGUUZlxxIS/Zs7nkVuPo
	 B6tunvNVOWkVX+gINj/47+0Eq7sC99SU4y52ty6DWcNVxYObZdfgumMVUw/tjEoB33+X9
	 5CqPM3+Lvwxn/r2YCxTMznXrYlJotwrL0Wz7VQvkugwdZVixHKHFaqouphBq7wGKniBcC
	 zDAO0PlAe0lSlsuic3rsriyWnNvmigpbQscrYhk5ShXBHmJgDl9cA+S+9ty3IlWRoFWnh
	 +y6ynF/JK6pqIwaHSSNYhVxleuhkPvQaeEajcAStXAnun/o1S3TKk+GeyG1xkePileA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="mB9pzhB/";
	arc=none smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F22606A31C
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 22:02:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84F22606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=mB9pzhB/
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b3402105b9so30209967b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 14:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1794866546; x=1795471346; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ETqs6DxejkpVOQvRklLap6bIJv44iisLss+lfdx7Ch4=;
        b=mB9pzhB/eqsMPqeEVznb5ZVjXcdNhHe3ywHvDDY0YdhZTRWDXjmwxN1mHrRkDCSjzQ
         8zP1CBxobWnkgNMr0KwbQjJ3L4JNUCBsmQLHAhm0InVpVQJ45rQ7uJ4uHwXNoozg2Ow9
         lQFf+e4mXXsgPeSB9Xe3LAx8bEP3PWPqB+hMKDGIiST1RfUz7dca9G2zCIGu21xD3l9p
         ewY1/8PxdXRfGy+nYZ/DwqMAxnLM9Soc4VlSJMoOA11zDZyRwXW6vLPtcUprXZJ+6DV/
         RPKX3zAAoz0f1KeLqQZ7Abgndu4hyLMX54LhmT3z4QB8RjxDDjWkHuR/hX36lVtJFTYC
         oj3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794866546; x=1795471346;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ETqs6DxejkpVOQvRklLap6bIJv44iisLss+lfdx7Ch4=;
        b=PxAfvIe+01oaXs2XqNYjJ8Ife9yIVrWhwdsfuET0zZZK4Sa1wKvNey7oC0CxXUddkG
         O3XdMksqa+moPEOP6rvFDKnN1w3fN6Z4bhAjuvtROdGXTkqt4epSmZLFelS8EUvoqxtT
         5PvEO7iZIzp7v4F5NkeQ2EagUME/i55oQKmKkdIkbwmndjD2uk4OSTJnxDthrbHnXPlY
         JWa2mWEiP8gB/Ph8Lo2e31r5u8duW4JwFTkYzDRzWLdH1IvopUX/1EUzScA/5c5qwD1r
         UBdWvi4BoM3RDoX8edaNNCdS1UKp3IVYimeexFMXelM/CdHJSGyUvjkSngM5Ke3msZHl
         bNWA==
X-Gm-Message-State: APuU4Z9VLbJWtUiLWfNwfyZxo4h9I3UcPPzEUncSB4LSZSyXwL81bja0
	SMsdFuM3rgVP1JXdYvYtpyKpUbi0T6o34AqMqOR5/8DgT71/SzqqGpJV4cwb4AXeqW0ND8yeABe
	jf1+C60g=
X-Gm-Gg: AZFdTZdjOJ8Pl8F6EM/cY+mHIepAOAdeT/KlpI5yCyBRndJdE3NB8oe2wWV8kNS3h6T
	vK/AhEtdudAKPXUnDPVNSQHqxoWTC/GBfK0VLN9K80VWL2rUYCKr10tArkBoyUo0zMgxRFbTmRd
	1Znvb7qAVRPFeVCMqnYK4Uj7AZywkKSsZxQFeSlQTi96UXvqghkzRSRGRIf4jVCvM/5c5G2Q16Y
	XeaNxIU8mgpcfTvt7EQfDYBZZlfu4SUAEIShnhziQhm89ziLteliZ7Ewty2I8LkDRgoYLtFSbYc
	UA/IW3nUZxvyRu1atxFUwH3yPrDNVbBdMzsl4/+i8Q0Fm3QvLxIEldvqSFYXPrRD5IETRErYROq
	mPGjsRnhv+PqgTzwgK7yBdaA7Ivv/SE7i59ymgFvT7fqlZpqI2d2F0YGyiKxf4X6aZJpGtPiPRc
	K8A67izueQ0ajyquDdgeR3XQKp+EaWAL4Y/L0d+58NSSGzmHYriAF8ZdEWsljznmI7mC6XIKTvg
	cbUNT+YpDmxCyv74eQKzZ4upLPU85Ux/t6pOhwgLuEK2iKpMoQClZaUmIHKzCS5N6Y5Z6OFChpE
	WJDxRrQpPSbHo6SNZSDmOO1pZSlc1fyJ29VUvjWZdKB7eOmcXsVSWHRiziSyZyh5ih+BuRCGCOZ
	R/8ribMte0ni+CxH9djN8ZutNybQMv1lWEZ3GKbZm+YBf7+jdsyjmPunjRxYOzvgQJlC4Ys169G
	ENMhpYIRMWn5oW05oWiI4=
X-Received: by 2002:a05:690c:f8a:b0:8b4:ddd4:d554 with SMTP id 00721157ae682-8b4ddf35f29mr14513937b3.65.1794866546428;
        Mon, 16 Nov 2026 14:02:26 -0800 (PST)
Received: from ?IPv6:2600:1700:6476:1430:48ee:a3ac:5a4b:3831? ([2600:1700:6476:1430:48ee:a3ac:5a4b:3831])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4ec2a5b9bsm9654327b3.34.2026.11.16.14.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 14:02:25 -0800 (PST)
Message-ID: <342f864c01c694acc0ec59b4d79f18e627a1ea24.camel@dubeyko.com>
Subject: Re: [PATCH 1/2] hfsplus: bound btree keys by the tree's max_key_len
 in hfs_bnode_read_key()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ozgun kultekin <ozgunkultekin@gmail.com>, glaubitz@physik.fu-berlin.de, 
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org, Guikun Yang <yangguikun19@qq.com>, 
	stable@vger.kernel.org
Date: Mon, 16 Nov 2026 14:02:24 -0800
In-Reply-To: <20261114043522.48764-1-ozgunkultekin@gmail.com>
References: <20261114043522.48764-1-ozgunkultekin@gmail.com>
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
 tXWRGxx4to6FwARAQABtCpWaWFjaGVzbGF2IER1YmV5a28gPFNsYXZhLkR1YmV5a29AaWJtLmNvbT
 6JAlQEEwEKAD4WIQRVwwtrZ87KC0La2wQ5XNnC34RAdQUCaBpd7AIbAQUJA8JnAAULCQgHAgYVCgk
 ICwIEFgIDAQIeAQIXgAAKCRA5XNnC34RAdYjFEACiWBEybMt1xjRbEgaZ3UP5i2bSwayDwYDvgWW5
 EbRP7JcqOcZ2vkJwrK3gsqC3FKpjOPh7ecE0I4vrabH1Qobe2N8B2Y396z24mGnkTBbb16Uz3PC93
 nFN1BA0wuOjlr1/oOTy5gBY563vybhnXPfSEUcXRd28jI7z8tRyzXh2tL8ZLdv1u4vQ8E0O7lVJ55
 p9yGxbwgb5vXU4T2irqRKLxRvU80rZIXoEM7zLf5r7RaRxgwjTKdu6rYMUOfoyEQQZTD4Xg9YE/X8
 pZzcbYFs4IlscyK6cXU0pjwr2ssjearOLLDJ7ygvfOiOuCZL+6zHRunLwq2JH/RmwuLVmWWSbgosZ
 D6c5+wu6DxV15y7zZaR3NFPOR5ErpCFUorKzBO1nA4dwOAbNym9OGkhRgLAyxwpea0V0ZlStfp0kf
 VaSZYo7PXd8Bbtyjali0niBjPpEVZdgtVUpBlPr97jBYZ+L5GF3hd6WJFbEYgj+5Af7CUjbX9DHwe
 GQ/tdXWRnJHRzorxzjOS3003ddRnPtQDDN3Z/XzdAZwQAs0RqqXrTeeJrLppFUbAP+HZTyOLVJcAA
 lVQROoq8PbM3ZKIaOygjj6Yw0emJi1D9OsN2UKjoe4W185vamFWX4Ba41jmCPrYJWAWHfAMjjkInI
 Pg7RLGs8FiwxfcpkILP0YbVWHiNAabQmVmlhY2hlc2xhdiBEdWJleWtvIDxzbGF2YUBkdWJleWtvL
 mNvbT6JAlcEEwEKAEECGwEFCQPCZwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQRVwwtrZ87KC0
 La2wQ5XNnC34RAdQUCaBpeTwIZAQAKCRA5XNnC34RAdew7D/48vw8dfTLcVjp4j6qUH9rOuXp5A2b
 jCEPeI0oOwRdqkyiGzUfUprHM48owvvye5u1mUZnKp8BWDDsjX4ddmhdloY0+6ecRAG73xlWMFKVK
 4P5XGnHU9A2JOtRhnOWQfPTgFhy69BSYyOeG3e5J+xPyUUBeHajbMVPKnD10NMCx8Ux1D2bv8OWbv
 3DvpUNx9D46UhBmkwIfrQWBkr0OGD2AXFfPqo08c3jcJMOAEc2vBI08Fij9o1gHwP2suFaG0X6jUN
 sy6KPOKg7TVMXtMzxNsKGyFxC1pG7lv+oaEBT6TJSVs/pm71ZrOezQANRzvBeXNUixWienTdAEG8a
 x4uOf3EF5WvYUhDiY8XBJyRv2ZnKJmBxZ3jPStadSuh3Bmo4mNgRVpFXrfb7h8oJC1l1WGdJa9aWi
 xUedku0/nH+nZMTqrtWYkXoLxaMswVM5S4f3pYKd7VlHxtlZiQ95RqQd5uWYcEN6xaSvAO3Cs4Co8
 D6etTHtKPcx1+d0x6BvkBvqNJ5yCiuzPPnKE6E0ss52KKvQt3injPyfe8ffofbW4s2nlEL1s0DoBv
 JslCebuQ6+Orb/Sl6zictIsv3XMq3jGFeZcDg2hXzngOC255+b0Z/To7jINTxYQot8jCOJQOLplxc
 NFdvziOa4FgUBC4X71upsZIoZJeii2V/Jtc3B4g==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, 2026-11-13 at 20:35 -0800, ozgun kultekin wrote:
> hfs_bnode_read_key() reads the key length of leaf records (and of all
> records of variable-key and attributes trees) from disk and only
> checks
> it against sizeof(hfsplus_btree_key), 518 bytes. The destination is
> always one of the two key buffers hfs_find_init() allocates, each
> tree->max_key_len + 2 bytes long. For the extents tree max_key_len is
> fixed at 10, so the whole allocation is 24 bytes and a crafted leaf
> key
> writes up to 516 attacker-controlled bytes into kmalloc-32. The error
> path has the same problem: it clears 518 bytes of the 24-byte buffer.
>=20
> hfs_brec_insert() reaches this with an unvalidated key: when the tree
> root is 0 it reads the key of record 0 of the leaf it inserts into,
> and
> after a split it reads the first key of the new node. A read-write
> mount
> that extends the catalog (creating the private data directory), or an
> append to a file whose extents spill into the extents tree, is
> enough;
> no other file operation is needed.
>=20
> The 518-byte bound was added by commit bb5e07cb9277 ("hfs/hfsplus:
> fix
> slab-out-of-bounds in hfs_bnode_read_key"); it covers the catalog and
> attributes buffers but not the extents buffer. Bound the key length
> by
> the tree's own maximum, which btree.c already validates per tree, and
> only clear the bytes the buffer actually has.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Fixes: bb5e07cb9277 ("hfs/hfsplus: fix slab-out-of-bounds in
> hfs_bnode_read_key")
> Reported-by: Guikun Yang <yangguikun19@qq.com>
> Closes:
> https://lore.kernel.org/all/tencent_F85118A9AFDF9B230D4E8FA672510A3E2F08@=
qq.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: ozgun kultekin <ozgunkultekin@gmail.com>
> ---
> diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
> index 3a1a1fa..f414020 100644
> --- a/fs/hfsplus/bnode.c
> +++ b/fs/hfsplus/bnode.c
> @@ -84,8 +84,13 @@ void hfs_bnode_read_key(struct hfs_bnode *node,
> void *key, u32 off)
> =C2=A0	else
> =C2=A0		key_len =3D tree->max_key_len + 2;
> =C2=A0
> -	if (key_len > sizeof(hfsplus_btree_key) || key_len < 1) {
> -		memset(key, 0, sizeof(hfsplus_btree_key));
> +	/*
> +	 * The key buffers come from hfs_find_init() and hold
> +	 * tree->max_key_len + 2 bytes each, which is far less than
> +	 * sizeof(hfsplus_btree_key) for the extents tree.
> +	 */
> +	if (key_len > tree->max_key_len + 2 || key_len < 1) {
> +		memset(key, 0, tree->max_key_len + 2);
> =C2=A0		pr_err("hfsplus: Invalid key length: %u\n",
> key_len);
> =C2=A0		return;
> =C2=A0	}
> --
> 2.47.0

I don't quite follow to the fix. What issue are you trying to fix?
Could you please explain it more clearly?

Thanks,
Slava.
