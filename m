Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8294E0B61
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 11:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791978258; cv=none; b=gQ9ae9TN3Y6cuVs/4xbzbPfO6uT0K3pVcRMDh2wjRaN2UqRDgVPJDFxhlSBq1joXglBOdzfQvvdoQabTILpuyISC0vAr6UdYmbl1NQXfTFsBXJVbdiUnG/AYl1xd8G3ZisKfTk5hx/vIENb5Rb+TfqvuTbRi2bN7OslxK4YJ2t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791978258; c=relaxed/simple;
	bh=1Qgq7/saPiO0XH+iRMiL6gsOydviUiEy835/bUGhdxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PBzt4AzBqwe40iVphceAUKBo+3ubw2Vm/t2HJiG4kpnHaxG0qID1NuIhWHUFu/3NwiBNzCxGrfyVgod9DCQqCoMNl2y5TUS8mfmE/koEjwHg7ZiyOComNR7TQTACFy91ZHkJdS/QK2gxt97Mna6obRd9PXQ+FGmZ2o0yjsQJc7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=F+X0A2Pb; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="F+X0A2Pb"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso3377880eec.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 04:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1791978256; x=1792583056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pkmum5UAp9BVL0CmNM6CxhtdgT1d/3jbpI1MnJgKoXc=;
        b=F+X0A2PbGxFtINE2raQm3H9FY8AOJKpvHVb/iF0GiZ4K4sQIr9k1FT3EtVtkwxuYzd
         F3D3fniomcNP9isSQTOPS1wHRW5cz3vHPlmm7YCMUTqBY7HAI0wh2/53bu3P99X3qJ3Q
         r67TpMFnESFDwdZ/3yYAJS8//FRLUDYJyEP4e+PTXcdjreOSqWzQDcl6Cndh48EOvl62
         1USVeM0CIQyGqevTNIWNfrBvFkkfWwxRbDKtEnMSzwZr8rDkhwsjhoyzpMUOIT6HRIq3
         Zv0oXljKdbP3VC67XRfnNrp8vzLaLOYjBpcyfQITCuuXv20BijnQ4nILWKo3vgUzE4SE
         uSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791978256; x=1792583056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pkmum5UAp9BVL0CmNM6CxhtdgT1d/3jbpI1MnJgKoXc=;
        b=Q2iVp6vPTOWmNmtWS6dwRKUScVZiqOd0SNFgyh2q/bYhg3xt5QewpFHUPTJDXx81Co
         Bjltd3D4hTgenvCKarR3l/71CFCtIfiG5F0sxeCSoT6pX/Zy/8Jy9zfz/WCAAyeh+rpQ
         aYbtpjHA2TheA/D8ESiAvJBKJKy5Ryz+NxrxXQQjyyyyCIjDFWRgr17D4rz46ZNIvRhr
         pnyNueWkYOYlgI62u1PKX4ROjaWKehU3nC4+i6EQgOtZ29hyYPizNc+gj0yb2ZRelB7S
         /5q0DnXuuSZEtJGxrZBfuQLw6DIG5LrZSodaWZHWNS0DQN7ew6tZNQHhkDShO/SzzrUr
         hkjQ==
X-Gm-Message-State: AFq9FYIt+1T5QF6daBMGQamEHGT++s5XSPjEPJczUlS7L/pTMjHH8siO
	5s1GAUAACYZUhMruvAPBK0F4gJlZxs53yGijhnWVRK9Y0L/Mb4df6OMSb6T96grrA8LwfJ80LC9
	9v1E1+JMoz8Q=
X-Gm-Gg: AYBFou1Y1vvkLfVeP43hk/7AglutN3wqCr3djWrD5R9jy9rVX9vPfrd2h7imxBsglmd
	iaVplnngPzEBGSJCv/1oh/0C4Au9Abiv4m/pHwjVuPVrrmoyPyaCuttSoLLh0+hojTaiqyslo5X
	gGzTuzmQVZ9sLEkkP79s/d9YEHcHlAiDvr6H0Zqphkys0ExMEX/A3eLoR+ObvlVbtTgLuZG8V95
	byxH2Vh9Apyd/gJENnvTH5wrwnCuoltX+jbFnMrVONMpGFzDB9NIxe5pVarrz94Du3iRaGwI6Eu
	VgIg8fphNDyxA/uuLQcfQPb0PIx7OlW5xaYs5xuxROlcDw8pAmlg3dBTSxHmPUgvbNjX4idxSA+
	jTV3jmfHYmjo0ruA9A6ST4dhgxBlSKSefzSOnRlxFzCXJe+cObLq0qwZYg3Bhj2AoW2NiGRf7Ia
	dLaLHjixmcHM+wGNshJqGTdap/UCGxwgG6DGJXDeSH0qxJuj1RReDhwoN4OQkf6HBWFJj0AWDsO
	bij4as=
X-Received: by 2002:a05:7022:239b:b0:14f:b8c4:2908 with SMTP id a92af1059eb24-16a60ce751dmr28629004c88.19.1791978255396;
        Wed, 14 Oct 2026 04:44:15 -0700 (PDT)
Received: from Roxy.sysu.edu.cn ([2602:feda:30:ae86:295:dff:fe84:68f4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a442ac67sm71379213c88.18.2026.10.14.04.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 04:44:15 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	alain@knaff.lu,
	hpa@zytor.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH 1/1] init: distinguish compressed ramdisks from image size
Date: Wed, 14 Oct 2026 19:44:00 +0800
Message-ID: <154af2b4bce7fe546be4e921439060aa0b616fc9.1791977727.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1791977727.git.zhilinz@nebusec.ai>
References: <cover.1791977727.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

identify_ramdisk_image() uses a zero block count to mark compressed
images.  A malformed legacy filesystem header can also produce a zero
block count, causing rd_load_image() to call crd_load() with a NULL
decompressor and panic.

Track whether the image is compressed separately from its block count.
This keeps zero-sized or overflowed legacy image sizes on the normal
validation path while preserving the handling of compressed images.

Fixes: 30d65dbfe3ad ("bzip2/lzma: config and initramfs support for bzip2/lzma decompression")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
 init/do_mounts_rd.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index 48bfab2fc62f..f113469448e9 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -31,9 +31,9 @@ static int __init crd_load(decompress_fn deco);
 
 /*
  * This routine tries to find a RAM disk image to load, and returns the
- * number of blocks to read for a non-compressed image, 0 if the image
- * is a compressed image, and -1 if an image with the right magic
- * numbers could not be found.
+ * number of blocks to read for a non-compressed image, and -1 if an
+ * image with the right magic numbers could not be found. The compressed
+ * flag is set if the image is compressed.
  *
  * We currently check for the following magic numbers:
  *	minix
@@ -50,7 +50,7 @@ static int __init crd_load(decompress_fn deco);
  */
 static int __init
 identify_ramdisk_image(struct file *file, loff_t pos,
-		decompress_fn *decompressor)
+		decompress_fn *decompressor, bool *compressed)
 {
 	const int size = 512;
 	struct minix_super_block *minixsb;
@@ -63,6 +63,7 @@ identify_ramdisk_image(struct file *file, loff_t pos,
 	unsigned long n;
 	int start_block = rd_image_start;
 
+	*compressed = false;
 	buf = kmalloc(size, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
@@ -87,7 +88,7 @@ identify_ramdisk_image(struct file *file, loff_t pos,
 			printk(KERN_EMERG
 			       "RAMDISK: %s decompressor not configured!\n",
 			       compress_name);
-		nblocks = 0;
+		*compressed = true;
 		goto done;
 	}
 
@@ -185,6 +186,7 @@ int __init rd_load_image(void)
 	char *buf = NULL;
 	unsigned short rotate = 0;
 	decompress_fn decompressor = NULL;
+	bool compressed;
 	char rotator[4] = { '|' , '/' , '-' , '\\' };
 
 	out_file = filp_open("/dev/ram", O_RDWR, 0);
@@ -196,15 +198,15 @@ int __init rd_load_image(void)
 		goto noclose_input;
 
 	in_pos = rd_image_start * BLOCK_SIZE;
-	nblocks = identify_ramdisk_image(in_file, in_pos, &decompressor);
-	if (nblocks < 0)
-		goto done;
-
-	if (nblocks == 0) {
+	nblocks = identify_ramdisk_image(in_file, in_pos, &decompressor,
+					 &compressed);
+	if (compressed) {
 		if (crd_load(decompressor) == 0)
 			goto successful_load;
 		goto done;
 	}
+	if (nblocks < 0)
+		goto done;
 
 	/*
 	 * NOTE NOTE: nblocks is not actually blocks but
-- 
2.55.0

