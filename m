Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049150;
	b=a6015EtvOmkaBlbbau15dukY7bsRu+T9stxrQiguMoMFxFshz4jSbRvdslOlNSp2x9eH
	 boPmnB22lVtt1BFZrL/yvqVEGXvKshsP/JfjITJ+Sx5eY0UJFJHjvNtnFFveNspV+LqCn
	 YpVWVOlBR+eRV0zayCxEzRTxjE3thllId/aXTjip50T9N+JKaKtha8L55z24nHTNDdZe/
	 tsUC/EIcqNvVfmip9YQgktUZkwek4xXEGu/LGVvis1l/sGzBNQCxhzhgnmEt7VjFYbyKb
	 EOSZI9b3vpU5CyGShfQ7qfprPrJRgaFmGtnF59QwNgCda3w6wdkCNOaQxeBgMuYQuzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049150;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=y7eKlQFnzHnXX2CdTEqVqjFeVAewWs55ryAaOGj8KvE=;
	b=4xyJII7wOOzQfexWOWKpFw4Hxj4B4Oiq5GIZl5Rf/9HnUnlXX+ahTpZO2rv1lH26Rx8a
	 znN4ECdhZOoos/57YnFNBisabRq9OH7oUp2KutRaZ7QEciUREoBlZ9hOqmFAhHJxwjfr0
	 LEk10xV9qvKn3+kHM+DObhpAlkcRptZPELS31yrCtYBCrPN8d8KNyfRL6Jjhwzalo+vda
	 k0h9eYoLv4LAMMwgyaQllOVSfE9ThXSU/0a2RBHibYLBsN8WB6VhpHqkvRI9PUcDsjc1c
	 ieB+LEn/0tYzY7a/5h18nbG94BRWCq0yh5GnjoDdzf4LLu1VgokS8Kdg6WBLMXWjU7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y06Y0WFV;
	arc=none smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C49606A336
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Nov 2026 10:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22C49606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y06Y0WFV
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c49c32650adso192176166b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Nov 2026 02:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794049147; x=1794653947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y7eKlQFnzHnXX2CdTEqVqjFeVAewWs55ryAaOGj8KvE=;
        b=Y06Y0WFViwKkS32pCebWEBBoJbm6etoFc+KHIQ4KUvTNNMqrREM3XOZT7Ismb+7Ixz
         ju9gaUCeEu0qpYjIqShKelhTtnyGF7y9w/wYb9DueOPa69HhmccCwzIOPLdhK0sJ1I5c
         x/Jy+uQDWou8xD/muiYNkWVAINs3RaqNKXFuRDSVK1cM2hsMrcKNb6URLanbATBaN8D4
         yr7UpIhLF2DyhvG7GFaNDjqiySfzSJSdZRFK+6rF3Pjn7u1v6kiCHc3LyAveTxPKEekC
         SBe88C+ff/dPWzE73Jy4CSTO+pfz2vS7DFG6xLiEcGD8IvN0vTMLUm4LhvN6OPuiQNos
         cL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794049147; x=1794653947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y7eKlQFnzHnXX2CdTEqVqjFeVAewWs55ryAaOGj8KvE=;
        b=LuL54Eqza3idSvXikEygL8z48DB/bc+csIFXF2vLKHJW+5oBLGQMVr8z5gpzSzQvNJ
         NlgjWrvk/ymy+UtLZi5zcAd+nGkdDIXAPRrlkEGJWF0waBbbWRdV6pGrhBthqS0EqcAt
         CtQBpV4nNqpUhRDWqlQDktYgLdPef9KKkSeRnZeacNL0y9T8gWnR6c4JMuXqgBh6wIdE
         WwMuTajBgck400NvP3GqTNORu28jgNV03m3HGHl/sHHEz504/faVRnakSoojOLd6dnKy
         bPrAXaVT0eiPkJiHVwOFuay4AsyW9ixkCIyNX4d1o3z+/zmk7f722P9hHWC8A2/gwr7u
         XMAQ==
X-Forwarded-Encrypted: i=1; AKwUvBwxcXdiDAg9UDDAZx6fmAduiGfrHGVC3vSTv8oBzST5xE9XbxJJEs485r1FTMun00zGudQ7GM+MnuoYOuOr@vger.kernel.org
X-Gm-Message-State: APuU4Z/Wk5EU9PZTOJzSP+mRizFTzy0gj6jFe3clZ+ap0XZm3QmiKnNl
	QintthcnYFIQ4Fz7ArFYuBewQjZYzAQLDGPZR/m/jwMPLVVuzeu5texd
X-Gm-Gg: AYBFou0FDEbflUe1YoPAdvRaAq2nV/876vHoUr+ZEcx8YkYmaKLp2MuGKwmpSyYj07T
	qDi3Ohq7uk7SMziIgW4PW1TZjW8qP5zGXph/DZy1dswRV3WYEOPa1lG0htKGIXpIpxSacCtrm9f
	CjVh0QF3P1EoIzQa6FYangrys7GzGS6/F3vRyNtmALKMKz3AN/j5k5ThtUAKWCuVKeGbUcjAKm6
	H5x/9MyLD4YjH4c+98e/sSy1riJOXI/CVMAP3+aHpdM3Vp4Y5pszL3IJKB4H7qwx0doJ8etAgy8
	ahyK/7IYLZIIWbPD/ASLCozjQhOgSzfXrZ5C8OwdDEtL7cmjuGCMg2r+1/rK3dfoGfbO5x/ce+1
	FrMaLzkKssUgI8kISPm1Kpqzqdo/ETSglE8etiXNKdW9Fh8HFHy46xF1Tol0k+ObCl1oCy25j3O
	NC1hNiVxMDxwAv7UWuYMVpJDJVvNBAfOD/gKPAYwAw0zSK1rwOVutCOnOS5vo9e9HzKWtb9nM4V
	jp9dB72HSXBS+qA04QurIPV9v4a0lEWogVizMtIexdhOTeBfE2rh3srbPDULp0eF88tu7X8bkTj
	GVMVQTERG5tLF/4XzLPA2g1oTiySJUwdjRJXdvCfcjkSqoJNE5bNJf8bv/g1Rk4NcsvHivks5wQ
	lFNVoprB70LM=
X-Received: by 2002:a17:907:3ea8:b0:c40:33d:f06f with SMTP id a640c23a62f3a-c4d34cb8b07mr416804266b.39.1794049147355;
        Sat, 07 Nov 2026 02:59:07 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d3569f6b8sm139673366b.54.2026.11.07.02.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 02:59:06 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	stable@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Chris Mason <mason@kernel.org>
Subject: [PATCH 6.1] backing-file: always end a queued write
Date: Sat,  7 Nov 2026 11:59:02 +0100
Message-ID: <20261107105904.3962893-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107105904.3962893-1-amir73il@gmail.com>
References: <20261107105904.3962893-1-amir73il@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Mason <mason@kernel.org>

commit 627cdcbc2a2eceb0452078a0c14370f9f1f17a91 upstream.

Writes to a loop device with direct I/O on an overlay file make the
next freeze of the upper filesystem hang for ever.

Every kiocb_start_write() needs a kiocb_end_write(). For a write that
is queued, vfs_iocb_iter_write() leaves the end to the completion, and
backing_aio_rw_complete() only calls kiocb_end_write() when IOCB_WRITE
is set in the flags copied from the submitter. In-kernel submitters
such as loop do not set that flag, so each queued write keeps the
freeze protection of the backing filesystem.

Direct writes to a loop device with direct I/O backed by an overlay
file left fsfreeze of the ext4 upper filesystem, and a later touch
there, blocked in D state. It takes write access to the node of the
loop device, which root has by default, to attach the file and to write.

The fix used here is to mark a write in struct backing_aio and to call
kiocb_end_write() on completion of every marked write.

Reproduced under qemu without KVM, on v7.3-rc6-21-g602042bf29f6 with
earlier fixes of this series applied, with and without this change,
once each. The kernel was not changed for the run. With this change
fsfreeze finished in about a second. Not run: the nvmet and LIO file
backends, which do not set IOCB_WRITE either, FUSE passthrough, and an
xfs upper filesystem.

Fixes: 2406a307ac7d ("ovl: implement async IO routines")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
[amir: use aio->is_write to explicitly mark a write aio]
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Link: https://patch.msgid.link/20261029180319.2852090-1-amir73il@gmail.com
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
[backport: no fs/backing-file.c, mark the write in struct ovl_aio_req and
 test it in ovl_aio_cleanup_handler()]
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -19,6 +19,7 @@ struct ovl_aio_req {
 	struct kiocb iocb;
 	refcount_t ref;
 	struct kiocb *orig_iocb;
+	bool is_write;
 };
 
 static struct kmem_cache *ovl_aio_request_cachep;
@@ -269,7 +270,7 @@ static void ovl_aio_cleanup_handler(struct ovl_aio_req *aio_req)
 	struct kiocb *iocb = &aio_req->iocb;
 	struct kiocb *orig_iocb = aio_req->orig_iocb;
 
-	if (iocb->ki_flags & IOCB_WRITE) {
+	if (aio_req->is_write) {
 		struct inode *inode = file_inode(orig_iocb->ki_filp);
 
 		/* Actually acquired in ovl_write_iter() */
@@ -396,6 +397,7 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 				     SB_FREEZE_WRITE);
 		real.flags = 0;
 		aio_req->orig_iocb = iocb;
+		aio_req->is_write = true;
 		kiocb_clone(&aio_req->iocb, iocb, get_file(real.file));
 		aio_req->iocb.ki_flags = ifl;
 		aio_req->iocb.ki_complete = ovl_aio_rw_complete;
-- 
backport
