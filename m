Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792700570;
	b=u4Dsv/BGEY/yfi/NA66TaXFjP+hSEIK435sRaOxWtwrlMoNEPKD0uI9KOveWSaKonC9t
	 aaf2xxVdK8hMA7GqnGItSzqcKiISd+oA8ERMTKYVagWhcHWbCZ8dHUfLqVSUIfN22Q9Kd
	 7tfg7Gi6afJojxsDtxrsnLSbJnelXoU2P28gFFRCUoljMsHz1IBwbYexN5is0dNR7uuPQ
	 osvXjCRPcNgIAgT6D+MZ7mgIEI9riI95z4F+31KYT8s+mAIIpB7wD96Wdlj2CTszrmZEH
	 FpmR3R8VEZmmeJzrTMksQb8JpRZPhmMKl/xxagzaNUTLx87f/DUkwFMULO4knGH/Ecg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792700570;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Autocrypt:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=6+OZ7UAj4wpyLIvTVHWqEA215IR1A8qQvTEaOHFShS4=;
	b=UqyzXl+oMXnq913N8jdBCbvW1SgwHHtchGUvaHdfzUF1g3902+pEhP0qWrjeeBmaNb/i
	 ze8HxfNpoavL+D/+GPhjj88BxMa7F9+f9GfUhScw7Q+lcVLh+DtOWIbRuItiG1VZxAo8+
	 nEMV8DRgOMtrsDgWC+Lc5buywP+35WHIrhRicdp2mkcZVA9mCkH78DyINSN8O95vxUdVo
	 TS2WZO44Er6VGQNVrUMplnZDa9ETes8p6qKBwp7cOjijGZPwHqe5qa5rwjwq9HGmNnOaL
	 oCpsQwZXaQ2hl87vGaIKjnuE8eTU1ndISR3PMhd/Nxz8dgshcaNQNqaV9FAUWVY+xug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b="LX/PbAP3";
	arc=none smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC297606A31B
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 20:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC297606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=LX/PbAP3
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b056d58f2aso2367657b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 13:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1792700569; x=1793305369; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6+OZ7UAj4wpyLIvTVHWqEA215IR1A8qQvTEaOHFShS4=;
        b=LX/PbAP3SVuSBH9kbpXY0xPdGlqMqb9hUY2i/eVrUHvo3AcBCIjUXvpkN7qNFuEUkr
         IMaSW6GIzwyYRoM26Eot6lV+mYkFX2IuQYXc5XA7qVqnyKO/PRNtI2qD4+8h3vUl7mgy
         P+snby1i4L73rC75zcNABoO4L/fcZDb0n8LmliR9IH1LUnjYxyZ/d2AwP0fmlMHS52hF
         /vrIwBii/xYYYsz9D4A03iWhrSJMERu4FLL5tDehyr9tza6Hlykp4tDWhgZOJspflkMY
         kB1G8Mm/JSqUSN2hj6p/w6SCHo//aJzhqBb7k9G7u7Mtyz9BP3iAVGUxsu5OPo0ydvt4
         F35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792700569; x=1793305369;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6+OZ7UAj4wpyLIvTVHWqEA215IR1A8qQvTEaOHFShS4=;
        b=I15+BcPzaRoMRHCCTdpjVorDGj44gszR3olaCz8rxj1lqAQaeARdyhVzan2tFe3Or3
         KUE/rlUEMCuZk5+IcPzh/2e853wDnvogM/mHbOo4Gjy6A7ORd9DI7/p9bwWwBrkon7kQ
         bD62EKDofsG2/xiC4PEsRjAcaerFb5u1aV4fml1alJJgl8C3hXIj104Dv0KhNCPOZjL0
         JLII9jFUcxRfgLs9nI0Rc6gFQiyCYLO2E9rL34lKtLSmAm2kLqYKAXKyS8gUldNKBCTP
         01iD51BGJnEq0adnCtgTLksKkauXOjDLgicn0qjLzZyYX4MH36kEH7tn5DfjXo0igqfe
         9m3A==
X-Forwarded-Encrypted: i=1; AKwUvBxlqnHozDaqiHM0jCdHVMySUkzzTaBFhGSRQxArY0ANN46SLEPQjtdBrJqIjxI09o419oDYZV9mmd0ATZ5L@vger.kernel.org
X-Gm-Message-State: AFq9FYIBtI2+tyNI52At3wBT1d+5Kkexw0JCIJ4DV19O/DPgCZjL035u
	9Xmc4eVNOiQ5EYX93NR95AK/+5JDcBu2E3rG45COTSvSSyTQdwR1XEwzehycSlu4z4c=
X-Gm-Gg: AYBFou18k0A1ZRrbtRrI8KeaUlTDzm8Zp/siLkEM3PZJskSDik7LzK/IR9JUcVrTHjG
	M51kbR3d3Sf3tii+H5pvS0glqdsi+zoR7Y7CbWj/q/TZfA6CqtdZ0bd+/nxIOeFXnZCCO7Ba3id
	lkhfp3ZJi5my5mKo6BzXMsLKGK0gZckGwtOWE/4ZCPSIenrDsrPNSDGSaWvThVZ8+SW6N9iOrsa
	IOS9F/HNb2djXJtDXuBty1A6gmBjrToH3sUVs3qN4vD2FQDpFYwpoc7WOu7PAkDqUo1/B9ipUbj
	q3Wfc6fWDJGOSZWY8PomP9a2wyurgRUxfFWaPe7OyqyrqbJ6k5VNdQ5RcPdDMFeX0FJYG7xmpHk
	8XilCs86dloWqUCUFnHTxR+IXTvAjdczizcWNSluXbH8o1yhMTWYhlZBrQFcig4DeOKS4J89ZCL
	fZYTrK7092KqYkPDD9D5n1JERfNj9yqHKGOaIYqWx1teaj+lJ2FFPBlC9iUdhNtWFX/1rX6cjzf
	uawHpVN6InHlfPysZ8aLfALnp5vitDuT8O8g+Tzx2SsPkbMveevRhhcKBg8l/Sa3ry0iHWi3U78
	3Mb73kR8x+ly8VCHLc/5eGgwxB/Tzge+eUFsxrzy1zfOkLv3PzbVrYr7wTx0f8nZ8H0yN08qEjg
	OfIzy0xDExOyN0nxoX0yIpyFGQDdS4qS0aHTXY1isge0hkw==
X-Received: by 2002:a05:690c:60c7:b0:8af:e4ee:a91c with SMTP id 00721157ae682-8b157dd761cmr909137b3.41.1792700568859;
        Thu, 22 Oct 2026 13:22:48 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:d350:a0e4:db9b:3217? ([2600:1700:6476:1430:d350:a0e4:db9b:3217])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b1561e365fsm3568247b3.45.2026.10.22.13.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 13:22:48 -0700 (PDT)
Message-ID: <4d28ca686fee764bb0eb3710f390a6f5fc9c0d4a.camel@dubeyko.com>
Subject: Re: [PATCH v2] hfsplus: fix truncated xattr names in listxattr()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, kees@kernel.org, 
	justinstitt@google.com, maurycy@maurycy.com, linux-fsdevel@vger.kernel.org,
 	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 22 Oct 2026 13:22:46 -0700
In-Reply-To: <20261022111700.1288273-1-hengyul@cs.unc.edu>
References: <20261022111700.1288273-1-hengyul@cs.unc.edu>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, 2026-10-22 at 07:17 -0400, Hengyu Liang wrote:
> From: Maurycy Pawlowski-Wieronski <maurycy@maurycy.com>
>=20
> Commit 7dcbf17e3f91 ("hfsplus: refactor copy_name to not use
> strncpy")
> made copy_name() build names in the osx. namespace with scnprintf().
>=20
> However, the size passed to scnprintf() leaves no room for the
> terminating NUL, so the last character of the name is dropped. As of
> now, listxattr() returns every osx. name without its last character,
> and these names cannot be passed back to getxattr().

Yeah, I see the point now. Thanks for clear explanation. The main=20
point that scnprintf() expects buffer size that includes terminating
NUL too.

>=20
> The issue can be reproduced with:
>=20
> =C2=A0=C2=A0=C2=A0 truncate -s 64M hfs.img
> =C2=A0=C2=A0=C2=A0 mkfs.hfsplus hfs.img
> =C2=A0=C2=A0=C2=A0 mount -o loop hfs.img /mnt
> =C2=A0=C2=A0=C2=A0 touch /mnt/file
> =C2=A0=C2=A0=C2=A0 setfattr -n osx.test -v 1 /mnt/file
> =C2=A0=C2=A0=C2=A0 getfattr -m - /mnt/file
>=20
> Without this patch, getfattr lists "osx.com.apple.FinderInf" and
> "osx.tes". With this patch, it lists "osx.com.apple.FinderInfo" and
> "osx.test".
>=20
> This patch adds room for the NUL to the size passed to scnprintf().

Usually, "This patch" is not good idea to use. :) It will be better
another way: "Add room for the NUL to the size passed to scnprintf()".

>=20
> Fixes: 7dcbf17e3f91 ("hfsplus: refactor copy_name to not use
> strncpy")
> Cc: stable@vger.kernel.org=C2=A0# v6.10+
> Signed-off-by: Maurycy Pawlowski-Wieronski <maurycy@maurycy.com>
> Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
> ---
> Changes in v2:
> - Rewrite the commit message. No code change.
> - v1:
> https://lore.kernel.org/r/20260828-hfsplus-copy_name-fix-v1-1-75ed9f0f378=
c@maurycy.com
>=20
> Maurycy, v1 got no follow-up, so I am resending it as Viacheslav
> asked
> in the thread below, with you kept as the author. Let me know if you
> would rather send it yourself.
> https://lore.kernel.org/r/dc187921249a3f6716b829624853e64c10321cd1.camel@=
dubeyko.com
>=20
> Answers to the questions on v1:
> - generic/377 passes with and without this patch. It only uses user.
> =C2=A0 names, which go through the strscpy() branch. That branch already
> =C2=A0 passes name_len + 1. No xfstests test uses osx. names.
> - Why + 1 helps: the prefix and the name are name_len +
> =C2=A0 XATTR_MAC_OSX_PREFIX_LEN characters long, and scnprintf() writes a=
t
> =C2=A0 most size - 1 characters before the NUL. Zeroing the buffer first
> =C2=A0 does not help, as the last character is never written.
> - Why the write stays in bounds: both callers check that the buffer
> =C2=A0 has room for name_len() bytes, which covers the prefix, the name
> and
> =C2=A0 the NUL, before calling copy_name(). This is also the number of
> bytes
> =C2=A0 copy_name() wrote before commit 7dcbf17e3f91.
> - All xfstests: see the full run below.
>=20
> Tested in KVM with KASAN on a804c5742bff, without and with this
> patch:
> - The commands above, and a C test that compares listxattr() with the
> =C2=A0 names set on files and a directory: short, long (up to 127
> =C2=A0 characters) and non-ASCII osx. names, FinderInfo, and user. and
> =C2=A0 trusted. names. Without the patch, every osx. name loses its last
> =C2=A0 character, fewer bytes are copied than the size query returns, a
> =C2=A0 buffer one byte short does not get -ERANGE, and getxattr() fails o=
n
> =C2=A0 the listed osx. names. With it, the names match, the copied length
> =C2=A0 equals the size query, and a buffer one byte short gets -ERANGE.
> =C2=A0 KASAN reported nothing with exact-size buffers.
> - generic/377 and generic/062: 5/5 passed on both kernels.
> - Full fstests (805 generic tests, 608 not run on both kernels): 188
> =C2=A0 passed and 9 failed without the patch, 187 and 10 with it. The onl=
y
> =C2=A0 difference is generic/617, which fails on both kernels most of the
> =C2=A0 time (19 of 20 reruns without the patch, 18 of 20 with it).
> =C2=A0 fsck.hfsplus -fn reported no errors.

The xfstests cannot help with testing osx. names. This is how I missed
the issue. It will be great to have a KUnit test(s) dedicated to
testing HFS+ xattr functionality.

>=20
> =C2=A0fs/hfsplus/xattr.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
> index 71364e093fa7..470f090b2699 100644
> --- a/fs/hfsplus/xattr.c
> +++ b/fs/hfsplus/xattr.c
> @@ -515,8 +515,8 @@ static ssize_t copy_name(char *buffer, const char
> *xattr_name, size_t name_len)
> =C2=A0	memset(buffer, 0, name_len);
> =C2=A0
> =C2=A0	if (!is_known_namespace(xattr_name)) {
> -		len =3D scnprintf(buffer, name_len +
> XATTR_MAC_OSX_PREFIX_LEN,
> -				 "%s%s", XATTR_MAC_OSX_PREFIX,
> xattr_name);
> +		len =3D scnprintf(buffer, name_len +
> XATTR_MAC_OSX_PREFIX_LEN + 1,
> +				"%s%s", XATTR_MAC_OSX_PREFIX,
> xattr_name);
> =C2=A0	} else {
> =C2=A0		len =3D strscpy(buffer, xattr_name, name_len + 1);
> =C2=A0		if (len < 0) {
>=20
> base-commit: a804c5742bff224d4cb4d25dd383554d598be32b

Looks good.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.
