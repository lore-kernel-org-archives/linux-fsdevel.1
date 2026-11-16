Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794866601;
	b=li7V6aWv5REYfQdfNs2LZm0KhHWiDG0rYBSUsGFFa5CHjuiCwxulYa1i7bs8nz7Vc33h
	 fbZ+RbUpjXE6aPDy8boZXbIxWwK6DWTqxOqPfqJXGuDctssdSTkXJ/rt5qhbRRWqWcaod
	 FgQmUZ6KvO/cFmMZ1d92e7ecejm/qzP/jbuQ904R4emmNMmHv/dBLY9HnUkwXYEJk+ake
	 yFIt5MYwyvv2l44cAJRoPw10H6pbkfyUq1d3XW3m28602lhoEt8RnbpPNl3QiddS52W+p
	 VLVgtDI9AnAAgAyjemLyEPm3+++ndWcmhUGeRuuCXNgwI4yNqDTaeVkyxrpQgV+XlLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794866601;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=NBD/5iw4xT3/0a74hPu534D88yzVhd7jhnkrzXOn+no=;
	b=0Z6AWOSJQ5sQkMuVYAO/+61AMNF9vX1XSKl5TEm6NnyGKuow9MJ9QEzolOFukMWft/3J
	 8mGCQgHGkVvZHEnkVFFH/dRpY9iNxW5XlOlOXYQGLdjRFil+jS1V1CbmkvR+6UAHtVd68
	 HEpWgKnoHQ28+IlMDMwQdrkLk98Ek6PFy4ZOdOQY6jxZnIVr6+969WG+lCBOfA4bAPsjj
	 nIbOET8WGcM1wgQk2pIk0Up4JLoaa2/n7KUEXP9N4JzLI5LqvEd3YXorPa4l1opRyj5FR
	 y9fPVpJqIZN8cSBCJRvapx7lX01tLhbN9rRNPutlek5kV957sxqEtOXcBFgbSgZN/9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="aROjm/Hh";
	arc=none smtp.remote-ip=209.85.128.175
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9097C606A323
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 22:03:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9097C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=aROjm/Hh
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8b4d07494b0so4182697b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 14:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1794866600; x=1795471400; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NBD/5iw4xT3/0a74hPu534D88yzVhd7jhnkrzXOn+no=;
        b=aROjm/HhVSdxa77z/apfieQCL3AURQPrWQdpvysWpeC6eN25wvW9UnYcZAsNhpJZ+V
         2F4jIvRZs9it19TTztgDsg3vC6TmaDKd2wWtZ4q/ZOInLrQ3e/Ig1tUYJOm9Yl4Cobbu
         wgmmIvUneTC0Lad6bFV1x3f0kuutudaRVpAKZAKHEO7s0llYYx+0uiJmQviZwNwCeXki
         VZTEVQJGHrEf0EX5fLWGVtKGQv2+VK8vihxXXDfzrYkK0kFodEuMA2KBBgryysc+wXoD
         vX3RE9xvTIuaSkxEpwxgp6XvMGZ3zoG4g10q4hcx8EBNaq1HyxOQ8VnyJdAr5tnu4cQT
         fMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794866600; x=1795471400;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NBD/5iw4xT3/0a74hPu534D88yzVhd7jhnkrzXOn+no=;
        b=U9g8f5ElKq5NslDQgCBD9VE1fsN0e+3tNVy5X5Nfpnn3r7VpKN4ByWCTIpKE7kmEb/
         I3TbuyVphq6OjE1iaS8tLzS8f370/b0pc8wA4UAV8HnxRi5++cU/f0L9FBNvZm84UPlJ
         habo94zJNevLXhFUh3viw17A5irijnEm4405AZbwlqKtFd6d192xILXLEPy851EyO/k3
         O1b0J3jl0BK6ZEFQ+/21jM4oEy3C/NBaU7c9qo+hhhlxKnri9zDFQiszP2JJQbQxo5Mv
         aMmmHwoKoyKAHYws4lF1hB9lDdtu1AVflAWiZF2/a0DvoFva4Q7wxrikqkgypgzxwdoN
         hofQ==
X-Gm-Message-State: APuU4Z81HlRFXRoUBs4qGKMRx4wtSc45QibNB4cCN0KV62VQUpZPUhkt
	6fgnTwIah5UupF28gzZVbJJLAZiVQ982i0i4I3ghrBXmmWQU2IroeF3l1S4e2340C5w=
X-Gm-Gg: AZFdTZcVrUHyJRGC8AzUqDRXDwKjJiZ8qfthcenzY2/DX0FllvTn0G/Uug0h80sM9Bv
	uTq9EBZ1Oy/uQAJH5ngH+Dtaig5jWSzv7vFTJut18szMMhEMXvJzi7fvVBPdzHj3KhPm/QEyF1l
	VkeRR6FoYVt4ywEOq9M4FW5u2b4QAGagmzqRad4jQiNjmK6PW2g7239IV6K2wiuiFo5dZCUcgSh
	HATzopILnAJXHhwy+HqX6LvinUCd/3908tZPIFGLuWwnvyHv+gZQBu1y7C4Y/XMZ8SfUWpXrjlN
	z4/aEXHglo+ZvMxhuFpWEB1hHtbDGhK2mospeWjCy/adC9qTzyQ+io0LRViWr07cVnXHXAoymnv
	+O3SzavwgXnD/fBolRS5yAmBZmdxCfrMFIlcGoDR2ACYWi2FcV7HQytPTwcjuxD6j60+eW7mLjL
	D7BF2H2dJvQPAYw2YxIyJz26DFR9r7pjjUV8QXcTDHtjRcHZaVczThXAi/T2P4dl8q8c+1GeVPo
	sFXX3AB5VDr/5MW9QCPdNBcTqFhIs5u3kX03ft4dmRK74nXAm7aW1L4XA4rx4wEvK5ksdxngXYR
	wiPwYQKuv+emWLqWc7efLvVbTorQ9tWLNEp+gK9oux1o4oySlrLDH32lbmYsn3ftO2vnS92/UBH
	bFmckbW+BqSCsdhlgV8lw5d9N3XCOX+oiT4SPRCMICIgaRJbM0GXq4m8kX03OOHTA3AK2BJoIJX
	gaq0rHNC3IgFSGShqdWJg=
X-Received: by 2002:a05:690c:4f08:b0:8b0:dfd0:5679 with SMTP id 00721157ae682-8b4ee288ae7mr3857707b3.31.1794866600644;
        Mon, 16 Nov 2026 14:03:20 -0800 (PST)
Received: from ?IPv6:2600:1700:6476:1430:48ee:a3ac:5a4b:3831? ([2600:1700:6476:1430:48ee:a3ac:5a4b:3831])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4eb7f0530sm9981017b3.1.2026.11.16.14.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 14:03:20 -0800 (PST)
Message-ID: <8b572986326b875b0bacbbc88e44e2ef448191d3.camel@dubeyko.com>
Subject: Re: [PATCH 2/2] hfs: bound btree keys by the tree's max_key_len in
 hfs_bnode_read_key()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ozgun kultekin <ozgunkultekin@gmail.com>, glaubitz@physik.fu-berlin.de, 
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org, Guikun Yang <yangguikun19@qq.com>, 
	stable@vger.kernel.org
Date: Mon, 16 Nov 2026 14:03:19 -0800
In-Reply-To: <20261114043522.48764-2-ozgunkultekin@gmail.com>
References: <20261114043522.48764-1-ozgunkultekin@gmail.com>
	 <20261114043522.48764-2-ozgunkultekin@gmail.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
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
> The classic HFS variant of the same bug: hfs_bnode_read_key() accepts
> an on-disk key length up to sizeof(hfs_btree_key), while the key
> buffers
> from hfs_find_init() hold tree->max_key_len + 2 bytes (18 bytes in
> total
> for the extents tree). Bound the length by the tree's maximum and
> clear
> only the buffer's own size on error.
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
> diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
> index fcb5b9c..f678eed 100644
> --- a/fs/hfs/bnode.c
> +++ b/fs/hfs/bnode.c
> @@ -83,8 +83,9 @@ void hfs_bnode_read_key(struct hfs_bnode *node,
> void *key, u32 off)
> =C2=A0	else
> =C2=A0		key_len =3D tree->max_key_len + 1;
> =C2=A0
> -	if (key_len > sizeof(hfs_btree_key) || key_len < 1) {
> -		memset(key, 0, sizeof(hfs_btree_key));
> +	/* hfs_find_init() sizes each key buffer as tree-
> >max_key_len + 2 */
> +	if (key_len > tree->max_key_len + 1 || key_len < 1) {
> +		memset(key, 0, tree->max_key_len + 2);
> =C2=A0		pr_err("hfs: Invalid key length: %u\n", key_len);
> =C2=A0		return;
> =C2=A0	}
> --
> 2.47.0

Please, explain the issue more clearly.

Thanks,
Slava.
