Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216F8379C3E
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 14:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792161958; cv=none; b=YXtODpS/VxJQl8y5E3qVFwQAmdfvCmhAomrkJiiJJtZIGXykSczkstR/A5ursug8Pu62wn6uhZcwaSeFxq9wsnLP9hxgrNVVPibJ0HPAJ0/Kg51fmtxQDlO1xz3BIVpBjH19wxP61l3pybN90e9vnGKgUmOB/Iwj0yvLvzXIyF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792161958; c=relaxed/simple;
	bh=/c11faq5GxP8gvTRyY5UgItu3Wh4cqwHiK13zX3Xpwc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ltNVwyFWi/hkwppfkoZEXVGsHBw3RBHnhxksmMcnw/T1JNiAcDlPUpfbfCWB1o6E80bRLO95giT+xVcMhl/LSqikr7+RIc9LC36W7B06QxZSlBmJMg56LfHW3qIlzxpxp/13DHOzZutCbHwp9zHhvJ4KVW6kWemPwgcX4GZmbHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=kmgx72yM; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="kmgx72yM"
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 69GEjEei2113394
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 16 Oct 2026 07:45:15 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 69GEjEei2113394
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026092801; t=1792161916;
	bh=Y0Z1kKwzAm3iTGOrLqHFfR6uL7qxYeZgSOSS746WsaY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=kmgx72yMtj3mYSOfda8NrR+mT1mq/ls+iTynzyJKHwAKl2LCu05F/nHuAZEuL4tpH
	 NAYV+l6keyZ36PftH9omh3707qxvhd973ljFpi5sLKvop6Fmjs2NNZ2xxPTJBay0If
	 /iZ0PDMXpHpV01d4naFa6stwiIwlWTdGhzC38RVTAXYnJBtlb1L8GFM+EtzxSixXHc
	 v9NHRIzXV4rHDsKoNNk+fdVhGSZogAg9LOiByYXWcrcXpuxdvvojlZ5HXYnHRe1Qgf
	 +KYOoa3lP6DaqRw/wPuZQVL2Q7956typXuq/QxiexUuFSeUR2LYdZsuJo7eYl4LG9h
	 OsFpnYx7tpF6g==
Date: Fri, 16 Oct 2026 07:45:06 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: zhilin zou <zhilinz@nebusec.ai>
CC: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, alain@knaff.lu, vega@nebusec.ai
Subject: Re: [PATCH 1/1] init: distinguish compressed ramdisks from image size
User-Agent: K-9 Mail for Android
In-Reply-To: <CANB6i5xcKdHWiuN677U+3Eoz62G6KbggMYE4EzOQ1ook---z7w@mail.gmail.com>
References: <cover.1791977727.git.zhilinz@nebusec.ai> <154af2b4bce7fe546be4e921439060aa0b616fc9.1791977727.git.zhilinz@nebusec.ai> <2EED1C95-742F-40E6-BD12-FE8DE83F6F5F@zytor.com> <CANB6i5xcKdHWiuN677U+3Eoz62G6KbggMYE4EzOQ1ook---z7w@mail.gmail.com>
Message-ID: <CF26178D-6F7D-4685-A8E2-4560054F57A9@zytor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 15, 2026 9:58:47 PM PDT, zhilin zou <zhilinz@nebusec=2Eai> wrote=
:
>On Wed, Oct 14, 2026 at 8:59=E2=80=AFPM H=2E Peter Anvin <hpa@zytor=2Ecom=
> wrote:
>>
>> On October 14, 2026 4:44:00 AM PDT, Zhiling Zou <zhilinz@nebusec=2Eai> =
wrote:
>> >identify_ramdisk_image() uses a zero block count to mark compressed
>> >images=2E  A malformed legacy filesystem header can also produce a zer=
o
>> >block count, causing rd_load_image() to call crd_load() with a NULL
>> >decompressor and panic=2E
>> >
>> >Track whether the image is compressed separately from its block count=
=2E
>> >This keeps zero-sized or overflowed legacy image sizes on the normal
>> >validation path while preserving the handling of compressed images=2E
>> >
>> >Fixes: 30d65dbfe3ad ("bzip2/lzma: config and initramfs support for bzi=
p2/lzma decompression")
>> >Cc: stable@vger=2Ekernel=2Eorg
>> >Reported-by: Vega <vega@nebusec=2Eai>
>> >Assisted-by: LLM
>> >Signed-off-by: Zhiling Zou <zhilinz@nebusec=2Eai>
>> >---
>> > init/do_mounts_rd=2Ec | 22 ++++++++++++----------
>> > 1 file changed, 12 insertions(+), 10 deletions(-)
>> >
>> >diff --git a/init/do_mounts_rd=2Ec b/init/do_mounts_rd=2Ec
>> >index 48bfab2fc62f=2E=2Ef113469448e9 100644
>> >--- a/init/do_mounts_rd=2Ec
>> >+++ b/init/do_mounts_rd=2Ec
>> >@@ -31,9 +31,9 @@ static int __init crd_load(decompress_fn deco);
>> >
>> > /*
>> >  * This routine tries to find a RAM disk image to load, and returns t=
he
>> >- * number of blocks to read for a non-compressed image, 0 if the imag=
e
>> >- * is a compressed image, and -1 if an image with the right magic
>> >- * numbers could not be found=2E
>> >+ * number of blocks to read for a non-compressed image, and -1 if an
>> >+ * image with the right magic numbers could not be found=2E The compr=
essed
>> >+ * flag is set if the image is compressed=2E
>> >  *
>> >  * We currently check for the following magic numbers:
>> >  *    minix
>> >@@ -50,7 +50,7 @@ static int __init crd_load(decompress_fn deco);
>> >  */
>> > static int __init
>> > identify_ramdisk_image(struct file *file, loff_t pos,
>> >-              decompress_fn *decompressor)
>> >+              decompress_fn *decompressor, bool *compressed)
>> > {
>> >       const int size =3D 512;
>> >       struct minix_super_block *minixsb;
>> >@@ -63,6 +63,7 @@ identify_ramdisk_image(struct file *file, loff_t pos=
,
>> >       unsigned long n;
>> >       int start_block =3D rd_image_start;
>> >
>> >+      *compressed =3D false;
>> >       buf =3D kmalloc(size, GFP_KERNEL);
>> >       if (!buf)
>> >               return -ENOMEM;
>> >@@ -87,7 +88,7 @@ identify_ramdisk_image(struct file *file, loff_t pos=
,
>> >                       printk(KERN_EMERG
>> >                              "RAMDISK: %s decompressor not configured=
!\n",
>> >                              compress_name);
>> >-              nblocks =3D 0;
>> >+              *compressed =3D true;
>> >               goto done;
>> >       }
>> >
>> >@@ -185,6 +186,7 @@ int __init rd_load_image(void)
>> >       char *buf =3D NULL;
>> >       unsigned short rotate =3D 0;
>> >       decompress_fn decompressor =3D NULL;
>> >+      bool compressed;
>> >       char rotator[4] =3D { '|' , '/' , '-' , '\\' };
>> >
>> >       out_file =3D filp_open("/dev/ram", O_RDWR, 0);
>> >@@ -196,15 +198,15 @@ int __init rd_load_image(void)
>> >               goto noclose_input;
>> >
>> >       in_pos =3D rd_image_start * BLOCK_SIZE;
>> >-      nblocks =3D identify_ramdisk_image(in_file, in_pos, &decompress=
or);
>> >-      if (nblocks < 0)
>> >-              goto done;
>> >-
>> >-      if (nblocks =3D=3D 0) {
>> >+      nblocks =3D identify_ramdisk_image(in_file, in_pos, &decompress=
or,
>> >+                                       &compressed);
>> >+      if (compressed) {
>> >               if (crd_load(decompressor) =3D=3D 0)
>> >                       goto successful_load;
>> >               goto done;
>> >       }
>> >+      if (nblocks < 0)
>> >+              goto done;
>> >
>> >       /*
>> >        * NOTE NOTE: nblocks is not actually blocks but
>>
>> Why the hell do we still support legacy filesystem boot ramdisks?
>
>I=E2=80=99m sorry for the noise=2E I overlooked that legacy filesystem ra=
mdisk support is
>deprecated and should have taken that into account before sending this pa=
tch=2E
>I=E2=80=99ll withdraw it=2E
>

This would be a good time to mark in BROKEN=2E
