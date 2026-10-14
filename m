Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BB25477E
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 12:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791982764; cv=none; b=YUsIS4tku4i9gJ62I3h40AX5JzDvTOeu8LgD2aViSnGMwLe8QW5XjV9eD9a1kVq2zGlyCTW+CT+bF/LpjwECSUjZ9vwEaEMTLpEi1z8lQcT+K2/JVxfKy1FDO/4XaetdeJdIs9IO2pwXNlUwnfkrYFFMWXlz4bNS3uQEnfIWErw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791982764; c=relaxed/simple;
	bh=XwD6uZPUOqO16G217Oc87tHtEofjQpPiRC+ldHc0UPw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=aYLzG8bBSzK0DjuGjcI5WKrXhq0x/O9O5ZDSaJqBmB+s6epW8KQfyRAhPsmqX1vLg1FkaV0JPL+Gl/O1lAhvtATiqrv/haINgeVesbQsewPjzewZskd/+n2zgc6pbpFerG3nGSWfEJFTYqDzkUAQT5BnFFPJ33I9mZl5hgowajg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=ejPbDASh; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ejPbDASh"
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 69ECwnej1090762
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 14 Oct 2026 05:58:50 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 69ECwnej1090762
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026092801; t=1791982731;
	bh=QIEdQ+jljzVM/uHfGWmHvQDETjLZEiCwFQ9wBmQaQNY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=ejPbDAShLXQI3zL7SH4juLYz9osk5CGY+0Z7ENCg6coqpr7LZn5b9mLfdKg7qOmTc
	 lGhhL9PSPOrmkRGFU8X4FxM0/hTVltiVg3AOAh5G0VlI57dyBWtr48U2uuD22QsUuj
	 4G99IGX7WRFrU9GyGx0LmbWtTUAkgIfpyYTH35rxWZZDRuMqN+rXCHJ6vM6gEeCeyC
	 dYMt3SNXJozOuuNBuPsFbtO3tiyw8tOwnxds7VlPA+EUhswgBaprIVuNX5WwqfTBnz
	 uWaXkkvAfQEZD1he0Efwopiw1eCEb+dbV8RKsml5SfFIuXIi+WQ21msc0qsocH3Mb7
	 NYmJGpjIASyMw==
Date: Wed, 14 Oct 2026 05:58:42 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Zhiling Zou <zhilinz@nebusec.ai>, linux-fsdevel@vger.kernel.org
CC: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, alain@knaff.lu,
        vega@nebusec.ai, zhilinz@nebusec.ai
Subject: Re: [PATCH 1/1] init: distinguish compressed ramdisks from image size
User-Agent: K-9 Mail for Android
In-Reply-To: <154af2b4bce7fe546be4e921439060aa0b616fc9.1791977727.git.zhilinz@nebusec.ai>
References: <cover.1791977727.git.zhilinz@nebusec.ai> <154af2b4bce7fe546be4e921439060aa0b616fc9.1791977727.git.zhilinz@nebusec.ai>
Message-ID: <2EED1C95-742F-40E6-BD12-FE8DE83F6F5F@zytor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 14, 2026 4:44:00 AM PDT, Zhiling Zou <zhilinz@nebusec=2Eai> wrot=
e:
>identify_ramdisk_image() uses a zero block count to mark compressed
>images=2E  A malformed legacy filesystem header can also produce a zero
>block count, causing rd_load_image() to call crd_load() with a NULL
>decompressor and panic=2E
>
>Track whether the image is compressed separately from its block count=2E
>This keeps zero-sized or overflowed legacy image sizes on the normal
>validation path while preserving the handling of compressed images=2E
>
>Fixes: 30d65dbfe3ad ("bzip2/lzma: config and initramfs support for bzip2/=
lzma decompression")
>Cc: stable@vger=2Ekernel=2Eorg
>Reported-by: Vega <vega@nebusec=2Eai>
>Assisted-by: LLM
>Signed-off-by: Zhiling Zou <zhilinz@nebusec=2Eai>
>---
> init/do_mounts_rd=2Ec | 22 ++++++++++++----------
> 1 file changed, 12 insertions(+), 10 deletions(-)
>
>diff --git a/init/do_mounts_rd=2Ec b/init/do_mounts_rd=2Ec
>index 48bfab2fc62f=2E=2Ef113469448e9 100644
>--- a/init/do_mounts_rd=2Ec
>+++ b/init/do_mounts_rd=2Ec
>@@ -31,9 +31,9 @@ static int __init crd_load(decompress_fn deco);
>=20
> /*
>  * This routine tries to find a RAM disk image to load, and returns the
>- * number of blocks to read for a non-compressed image, 0 if the image
>- * is a compressed image, and -1 if an image with the right magic
>- * numbers could not be found=2E
>+ * number of blocks to read for a non-compressed image, and -1 if an
>+ * image with the right magic numbers could not be found=2E The compress=
ed
>+ * flag is set if the image is compressed=2E
>  *
>  * We currently check for the following magic numbers:
>  *	minix
>@@ -50,7 +50,7 @@ static int __init crd_load(decompress_fn deco);
>  */
> static int __init
> identify_ramdisk_image(struct file *file, loff_t pos,
>-		decompress_fn *decompressor)
>+		decompress_fn *decompressor, bool *compressed)
> {
> 	const int size =3D 512;
> 	struct minix_super_block *minixsb;
>@@ -63,6 +63,7 @@ identify_ramdisk_image(struct file *file, loff_t pos,
> 	unsigned long n;
> 	int start_block =3D rd_image_start;
>=20
>+	*compressed =3D false;
> 	buf =3D kmalloc(size, GFP_KERNEL);
> 	if (!buf)
> 		return -ENOMEM;
>@@ -87,7 +88,7 @@ identify_ramdisk_image(struct file *file, loff_t pos,
> 			printk(KERN_EMERG
> 			       "RAMDISK: %s decompressor not configured!\n",
> 			       compress_name);
>-		nblocks =3D 0;
>+		*compressed =3D true;
> 		goto done;
> 	}
>=20
>@@ -185,6 +186,7 @@ int __init rd_load_image(void)
> 	char *buf =3D NULL;
> 	unsigned short rotate =3D 0;
> 	decompress_fn decompressor =3D NULL;
>+	bool compressed;
> 	char rotator[4] =3D { '|' , '/' , '-' , '\\' };
>=20
> 	out_file =3D filp_open("/dev/ram", O_RDWR, 0);
>@@ -196,15 +198,15 @@ int __init rd_load_image(void)
> 		goto noclose_input;
>=20
> 	in_pos =3D rd_image_start * BLOCK_SIZE;
>-	nblocks =3D identify_ramdisk_image(in_file, in_pos, &decompressor);
>-	if (nblocks < 0)
>-		goto done;
>-
>-	if (nblocks =3D=3D 0) {
>+	nblocks =3D identify_ramdisk_image(in_file, in_pos, &decompressor,
>+					 &compressed);
>+	if (compressed) {
> 		if (crd_load(decompressor) =3D=3D 0)
> 			goto successful_load;
> 		goto done;
> 	}
>+	if (nblocks < 0)
>+		goto done;
>=20
> 	/*
> 	 * NOTE NOTE: nblocks is not actually blocks but

Why the hell do we still support legacy filesystem boot ramdisks?
