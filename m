Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4AB2C21F4
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 04:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792126741; cv=pass; b=JRonln1Zq8AVqhWaDxsgrxNlTg+s3qpCFnbVue0YBXPyb3koFdyn0ytF8uEeBuZOkkD6cshWZbGWrmmeNPQYegEeD+qrl87a1i8de+56Mk12lknRWHYopEjxFesB8cg35BRW9w0stj6Ypg5J3SEZ96He2/It6QdVgHEbEiWsEzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792126741; c=relaxed/simple;
	bh=QHo3VQMpzYErTQ5bHCnilOwdKHhl9f8PhVMEJhmSzpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FI7jCMzIpEX9EWlfFqIc/YHoZie3CO5/JkyUdVU9J1EdJK7opzxMCx0G76nxs56QqqKy//PvFl1dhh2xvsz+pRQNMkc5lBw8mrTn9fxYktec5tZxnwIQEC6TNT312NPPSxEVuhvqg98nzy1j5VgBu+mZ0X0v5zpBLVSZ0TavBd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=NFjsEk/1; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="NFjsEk/1"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-677d35fd1d2so2476846d50.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 21:58:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792126739; cv=none;
        d=google.com; s=arc-20260327;
        b=iXZNnKPcnD/ZH/3eowM6CnXJq5xkmd3J6VYhMF7in/7sB5y7cMZBTDFMmn2ckmPAYO
         faeaajXGlZEIG/vWOk5VdlpCnHipxDwQDjBKlzyWR/YWXF/phv9rzbe3oy1BB3W9ighE
         9YRZ2KqIyIWvB646LpeqQJlpltQUkFHGfMrwqul4WFDZVk3QrlP79/AiRCg9KZG8TQWO
         NIzNLwPbUIrPJ8qu3We5oR3ja0NbpMHbMPLiUU4lhUbXegfrbIwMOpi4W2vFlQpDCn4X
         w6Gq+1lG2UmSyHeZDggaqvMWNSVUFnRHiarqo1qk0mSEgJhD7fxvDowjwZ7YS4KgIvWo
         VFfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+NF2JMCxAgbkg1eHnllUu9V3lnTPLwRhPxGXEmOs8ck=;
        fh=6LbXCPIUVnHSh+biM/Octoue3tLOOe/vO90nLN2fylk=;
        b=mpi7OIFJEgUZV3ZhSoUxrM/3yH5hNXOyk7rYQaQ6dv2A7oBNrJbyTnoSow8un7rwvp
         RDLmFKBvKR5PBVxBDC/OjANKAYehyVlxOYG53HsiUh3XU01CfnbF/lZTfOIQ2dWVazwE
         RwFnV2plNTB6uVWHhVcB4+BJhToNC5VxJrQFA2RkbKRbJvtTbeMuDr4yjjodcYdBpT/2
         i8N2AWNqW/hTJW4F4sojpZc5L5WSuYW7RH86Ln5BIec3+9T38BdGSjX4PfxBZz1BtOke
         crEUP2KVl6NCaDvlR04ecr6Svrjrr6TxHVY7O016JngPpEcMfsthBE8eA3nArakGbpwE
         h0oA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792126739; x=1792731539; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+NF2JMCxAgbkg1eHnllUu9V3lnTPLwRhPxGXEmOs8ck=;
        b=NFjsEk/1NfJ5EdjC9+RJYCj2aSykVkYQN9Zn7CC50YFZU6yWnRvuIh+7Y8NGlSzznX
         lhhqyjccJ0cTr0sdrqHER+KBLEuzZkakzed5VtRf22hLH3GWY/s72YhqOnkp2ujIQSmN
         HzMWe0rVQSvk3qwEdSpnphoMX0MIDmrXk5gj2SMfaLM1mw12PIksKL+LDRanwhOND7gu
         4UwGj0ifC9FDYKm5vCYUUpaViZehjtYU6sXjP1xBiiTpQg2xsP1VZjoHWtjtjPldi0zn
         DkEPG22O45dWymsm0Vqckn8wP//40xoeUjfhblvv4A8tUyKeDPL+2zr1b9foT57y9kyh
         5w5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792126739; x=1792731539;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+NF2JMCxAgbkg1eHnllUu9V3lnTPLwRhPxGXEmOs8ck=;
        b=jEKy36dq0eeGC0Skjtuh/1lLJZqh+w5ytOsa3d/WobKJE+UHj9hRyzPZ5FD882uQJX
         fFc14Er+jBK0dGhGCHaUB0PSbteefFAXkU7RJIALfU1CL/26YQBa58UU4EsyDdn55+so
         i15KPU1IjSr3yWuvmivBPIAtpxLsUI4cPsVgWam1hXrvkIXK6VY2Hwe9pdYfLgEwxDeW
         fhRN7wbrAu8Kfkn6z3PI8DfZyEVw+UqZD/8OZpMoilbFWjzODfJ+E9c/+r7UAVX9f8Ux
         pLcNBRnqwaT/MF0wPPP/yQGlPrD1Hf3djPcFbjQPdyBrrT6EcuwrLlPPs8ry1fYiHmfl
         GhIw==
X-Gm-Message-State: AFq9FYJiZgLYX+7niPYLe41t4df1z/o1R/FeH76/UOdJeMBW/a45QYjp
	wKh4GRX7gDiNXQGY2O29wqD7o3WwRhmOzJvs+Vm0mU9WbkKmW3ioLC46BQtfZpAhLTahcu5wXtz
	wuDKBFYC9U0pRQGlBMG/z72/hvMVP5rGEsEdhIt02VSiewg2+udteyh8Q21AnuA==
X-Gm-Gg: AYBFou1PsiyRFEDd+2/xYsek/u6iCH8G1auM9+sr8IZpQejLPNhCOwup1ZOJ2/OrjpP
	8yHH6BS4l6RuQmt/8Rj72gsIfvSWutUM3OBJhwtiOcHM7Q5PPqAfZ4/8ABhTfKp9NPo5SnJuxh3
	PtBauPuGr/b2xxMgweNmvNdhVGto4hX+g5yXQwGhK7eNxf0z9F4O0e5N8wKIp5xW4J5y5elz5lt
	bSK+FrlpbuLc1aLFVuejTesXpER+HffY1z4/Yy0EL86k8UUuUr1wnQwAEHdXm3E9ihGhOAuw59l
	nPRNmU9SVL5dm6pvxubSAZFlOE5xNQ557nqHxH8A2dxATt615sBxcS6L65wVtQp8JmYt5s1BnRU
	/WZIr5rc2Mia49JzeU07q
X-Received: by 2002:a05:690e:4005:b0:677:b1da:ba3f with SMTP id
 956f58d0204a3-67936046578mr6938555d50.51.1792126738609; Thu, 15 Oct 2026
 21:58:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1791977727.git.zhilinz@nebusec.ai> <154af2b4bce7fe546be4e921439060aa0b616fc9.1791977727.git.zhilinz@nebusec.ai>
 <2EED1C95-742F-40E6-BD12-FE8DE83F6F5F@zytor.com>
In-Reply-To: <2EED1C95-742F-40E6-BD12-FE8DE83F6F5F@zytor.com>
From: zhilin zou <zhilinz@nebusec.ai>
Date: Fri, 16 Oct 2026 12:58:47 +0800
X-Gm-Features: AclHuK89bJq6DHe1-mhSL6aeyn6HcqHYokNW3TIxKxAvEXqAZ_KlAypbnlzr4V0
Message-ID: <CANB6i5xcKdHWiuN677U+3Eoz62G6KbggMYE4EzOQ1ook---z7w@mail.gmail.com>
Subject: Re: [PATCH 1/1] init: distinguish compressed ramdisks from image size
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, alain@knaff.lu, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 8:59=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wrot=
e:
>
> On October 14, 2026 4:44:00 AM PDT, Zhiling Zou <zhilinz@nebusec.ai> wrot=
e:
> >identify_ramdisk_image() uses a zero block count to mark compressed
> >images.  A malformed legacy filesystem header can also produce a zero
> >block count, causing rd_load_image() to call crd_load() with a NULL
> >decompressor and panic.
> >
> >Track whether the image is compressed separately from its block count.
> >This keeps zero-sized or overflowed legacy image sizes on the normal
> >validation path while preserving the handling of compressed images.
> >
> >Fixes: 30d65dbfe3ad ("bzip2/lzma: config and initramfs support for bzip2=
/lzma decompression")
> >Cc: stable@vger.kernel.org
> >Reported-by: Vega <vega@nebusec.ai>
> >Assisted-by: LLM
> >Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
> >---
> > init/do_mounts_rd.c | 22 ++++++++++++----------
> > 1 file changed, 12 insertions(+), 10 deletions(-)
> >
> >diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
> >index 48bfab2fc62f..f113469448e9 100644
> >--- a/init/do_mounts_rd.c
> >+++ b/init/do_mounts_rd.c
> >@@ -31,9 +31,9 @@ static int __init crd_load(decompress_fn deco);
> >
> > /*
> >  * This routine tries to find a RAM disk image to load, and returns the
> >- * number of blocks to read for a non-compressed image, 0 if the image
> >- * is a compressed image, and -1 if an image with the right magic
> >- * numbers could not be found.
> >+ * number of blocks to read for a non-compressed image, and -1 if an
> >+ * image with the right magic numbers could not be found. The compresse=
d
> >+ * flag is set if the image is compressed.
> >  *
> >  * We currently check for the following magic numbers:
> >  *    minix
> >@@ -50,7 +50,7 @@ static int __init crd_load(decompress_fn deco);
> >  */
> > static int __init
> > identify_ramdisk_image(struct file *file, loff_t pos,
> >-              decompress_fn *decompressor)
> >+              decompress_fn *decompressor, bool *compressed)
> > {
> >       const int size =3D 512;
> >       struct minix_super_block *minixsb;
> >@@ -63,6 +63,7 @@ identify_ramdisk_image(struct file *file, loff_t pos,
> >       unsigned long n;
> >       int start_block =3D rd_image_start;
> >
> >+      *compressed =3D false;
> >       buf =3D kmalloc(size, GFP_KERNEL);
> >       if (!buf)
> >               return -ENOMEM;
> >@@ -87,7 +88,7 @@ identify_ramdisk_image(struct file *file, loff_t pos,
> >                       printk(KERN_EMERG
> >                              "RAMDISK: %s decompressor not configured!\=
n",
> >                              compress_name);
> >-              nblocks =3D 0;
> >+              *compressed =3D true;
> >               goto done;
> >       }
> >
> >@@ -185,6 +186,7 @@ int __init rd_load_image(void)
> >       char *buf =3D NULL;
> >       unsigned short rotate =3D 0;
> >       decompress_fn decompressor =3D NULL;
> >+      bool compressed;
> >       char rotator[4] =3D { '|' , '/' , '-' , '\\' };
> >
> >       out_file =3D filp_open("/dev/ram", O_RDWR, 0);
> >@@ -196,15 +198,15 @@ int __init rd_load_image(void)
> >               goto noclose_input;
> >
> >       in_pos =3D rd_image_start * BLOCK_SIZE;
> >-      nblocks =3D identify_ramdisk_image(in_file, in_pos, &decompressor=
);
> >-      if (nblocks < 0)
> >-              goto done;
> >-
> >-      if (nblocks =3D=3D 0) {
> >+      nblocks =3D identify_ramdisk_image(in_file, in_pos, &decompressor=
,
> >+                                       &compressed);
> >+      if (compressed) {
> >               if (crd_load(decompressor) =3D=3D 0)
> >                       goto successful_load;
> >               goto done;
> >       }
> >+      if (nblocks < 0)
> >+              goto done;
> >
> >       /*
> >        * NOTE NOTE: nblocks is not actually blocks but
>
> Why the hell do we still support legacy filesystem boot ramdisks?

I=E2=80=99m sorry for the noise. I overlooked that legacy filesystem ramdis=
k support is
deprecated and should have taken that into account before sending this patc=
h.
I=E2=80=99ll withdraw it.
