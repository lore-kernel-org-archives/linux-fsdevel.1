Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049151;
	b=WVTfSa0wtNaA9qjw40c0pP3gol7EC6oSYlhWiIjdgZf834Zm+WWmOOfbJBk3NvDHb9T6
	 PV/ujQWhE5+jopbJ+z7YWfTirRKAplh4pCodyJvDysFkY11MdmBkGBGz6YbUFPOzpNS+w
	 iM/RRpRq05zQtS6JcnXUFO/McPK4Uq0EupthVxX+aQCT9lJXaMckCGJ+NKyJ1ahMP4cQi
	 SutmoY6UVlfqpYJAx2AZ5q9wgs6qQsaoPkrEWhXDJZb94OHboMbPDY+i0boO9mlqMi3PD
	 7Ot0t061ERWp/Q862kxnb+EGAw2Nt3IxBHmWvjyg6YmPniqgOkrafBz1b1SwnNMahHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049151;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=f3l0zpGiWBDLrkdGS//TuXETPQIE+ln1iP7r/4acX0o=;
	b=3yyo4MVP7Nn0JldHfl8DHTmqCK5Wy8UH8teMbh/blLqVNXIG+jBouUMszELSqCfxe9e2
	 bBWa8Oq9dRiAIxIZBcRkraCBMoOgYkLQNbNugn2SUYffRb/dP2PUQ2xh26wcAzuKIxG8+
	 ElkyuzIKgohsf81dvSseECPLYz5lkoRADFn0TCn8BSs80LXv564B8dJqCQfVrp/hQtqnm
	 6vnfoywHHk3AaI1spjT16o8cdIEIrge6WmDKDyamcBk5z+qKuUpauSKcSXXt2VVHEnJ2F
	 Kq247LAOJYHg6nNF1AxBKTnayBG7oIXED6LE9QWTcs+gRmv535SP6gdXx0J83MU7kQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jmoJRG5L;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4F0606A333
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Nov 2026 10:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB4F0606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jmoJRG5L
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c40e30c26a4so63682366b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Nov 2026 02:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794049149; x=1794653949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f3l0zpGiWBDLrkdGS//TuXETPQIE+ln1iP7r/4acX0o=;
        b=jmoJRG5LFPkpneFDc4+nTlERpAkw2Fyx79LANkHmU59Esr0Sy1tds04Tq+dLppDxGz
         94oKJZiMGy71L3Bqbv5rs7n0FN+yvV/HGbD6bBQQ6IvMBvUf6nmUV10ZkIhsjP2Wx+YM
         gyZ1KX7TIX1phuvp5z54OJWwDV7zeVDmMxPwKQQ4WQkVYTeQSSdA7UGAhE+3TrYbXtbh
         9BKDqRcRkct+tABBB1DbwKxAikMQlzq8tzEaNIHnuXCOVBU0BGFG3OANucQV5fAULe6x
         pqMxDWhomIWm/9+YWS6F3scQ0wlwSWTazLHOF6/Fx+/mQnkUinV5ur6KSJf2beTaWSsY
         Vp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794049149; x=1794653949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f3l0zpGiWBDLrkdGS//TuXETPQIE+ln1iP7r/4acX0o=;
        b=dOzPUXDQIaZmq0Ony/cq0tAG6BiH/RHEfAWJhupTmv3l11yIJlOHH/dCSXBdMQK0+h
         7u04JVq7ISjzg9yfu8TLdE8rrHlQcEbIc9h5AsMM0XvEX+N71np+L81cjRu3t9MmH1GJ
         DC8uJOtfaAZsNJ4VHV7k3ieh44mLiMxvoT+E8RBSAC/ZAphsXXP2BuwcWi7gzstDxhN2
         F7kO0/EFeAbl31hNOMHOCnRwjd8nj0Z6MHrOxamtv8mGLIw7gz19Dcuu36org46J6b6a
         4LtdA60UvmD7zsFwdXtIZF02ZexPCCxugmhTKIoYsSrzDP9hnOWA4CDamAmX9G3hzovb
         kqLw==
X-Forwarded-Encrypted: i=1; AL+hErGrFBw9FXqqOfJuTZkj+De5800CKOhetgMR+st+gQ4pf45+UGkH9K+fFGUNBEY+icHG15bbLEg9Nt0MNn37@vger.kernel.org
X-Gm-Message-State: APuU4Z9mdvuHI1L3Cw2AflNj1FMFvzTOD83UnsnqKeMC4Ekhnl1ifRMJ
	Qx9fwM4J6IvAhtLEgCAOCmwn+EeRUV+6BmGi3/F0YP40eQ7Vn6Yr9Aes7O3Aok9w
X-Gm-Gg: AYBFou2+27FWO68S0sBniifZmLst/VZ58Qqjgp9Iajs0DmTq9J5HBowURAyRdlvIlLb
	pibwv8ppPQhdU/7ZRMbhsSO2lgQzDa1jT3ECiiDsxwk+4XX/uPZcnfrPcEHM4KPNPzOYSVmnEu0
	/mrGuxLRSMwZD0TJ6wHf2z8Y6N35lDYiCAKZzl7NB0JZ2aeSXwa7btjG0b5V5ssW7kODqH5Ir10
	vT7K7ZtZgmlbQmKpxdLhtan4STH/LZeQWKAwCas/g3eP9UyCg6EGG2Xdq9dIyfntG1jr1kM4FeT
	gi+VsmZvsdW/FRJa72BugS6rS58G4Q8dhz3RyU3DbGXPUAz+DQzGdK+l29RrRWxygF5KtaMbBNW
	oYg2cP/oVUMb543SoreeCnb1Cb5pSE6gBlmCHgHMyLW8txdyLwHFBjbB25336jj2pgXCzKuu5Ax
	USBJcQkmrbxYmCFAcqxpubhof+H9g0u7dkbzYj8q+i1U6+v5czuZ1gGQZxrgv94B3Zoad5yTvvk
	BuYFWzWqf0LzKk68NOrj5SHAFeCRvGtvliXAThuGiROxDesU+c6OLhmasMNxJrFUcubIA8ZyL2G
	TyhEXp7HOqr4ma4jchuZFen78HSnAe9jH/YYRahi6Sa+eQTcShb9NwQyH6pyTrER+A6aBEjXV/r
	YxTFmAJ2/NoA=
X-Received: by 2002:a17:907:94c9:b0:c26:1cfd:4244 with SMTP id a640c23a62f3a-c4d525794f8mr109604366b.11.1794049149018;
        Sat, 07 Nov 2026 02:59:09 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d354ac7ddsm144880566b.8.2026.11.07.02.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 02:59:08 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	stable@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Chris Mason <mason@kernel.org>
Subject: [PATCH 6.6] backing-file: always end a queued write
Date: Sat,  7 Nov 2026 11:59:03 +0100
Message-ID: <20261107105904.3962893-4-amir73il@gmail.com>
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
 fs/overlayfs/file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

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
@@ -289,7 +290,8 @@ static void ovl_aio_cleanup_handler(struct ovl_aio_req *aio_req)
 	struct kiocb *iocb = &aio_req->iocb;
 	struct kiocb *orig_iocb = aio_req->orig_iocb;
 
-	if (iocb->ki_flags & IOCB_WRITE) {
+	/* Pairs with kiocb_start_write() in ovl_write_iter() */
+	if (aio_req->is_write) {
 		struct inode *inode = file_inode(orig_iocb->ki_filp);
 
 		kiocb_end_write(iocb);
@@ -413,6 +415,7 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 			goto out;
 
 		aio_req->orig_iocb = iocb;
+		aio_req->is_write = true;
 		kiocb_clone(&aio_req->iocb, iocb, get_file(real.file));
 		aio_req->iocb.ki_flags = ifl;
 		aio_req->iocb.ki_complete = ovl_aio_rw_complete;
-- 
backport
