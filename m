Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F423F5BF0
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 23:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781651613; cv=none; b=Uwv8lPXl5HMFMtnUOWSOQqvhSBI5asG5FV4CG7A0DHoW4H1ncr2CX3cgnCvXDCotsYOo9GwPwtfT+q6lqUaLwzg6wZTh5vzBhdSJdcrFXkNZZduaauD9hiAq/QV2PLaiJhYvexalvBsO1nhyI2cmPQ28pR5bYcmk/4Y3HY+O0LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781651613; c=relaxed/simple;
	bh=lkS+KHBqJXeYGJHdOSlajz6hbM4WTk5DhH53EzMx/6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gv6VTw7S3d+Hag2/BOjDb1B69HC+TUQZpjXzcJrU4z6n5I6cUP6vUfBzUvfWz0oTbtSonQ2qPmDu8G1rjQem9hvSlEqo3R9+qADL1VlZRrvZcFn71qF5ke8618LYHvFkO1iUySy7L7DBBR72M7i7qdDEHMJHnxr8+liUPRcFSCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NNnWIQkR; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNnWIQkR"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7e6cfdc8382so3906288a34.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 16:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781651610; x=1782256410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84DiwMXLdEq4yqPEouNIMtm8S6/TgLWUF9alM51937s=;
        b=NNnWIQkRrtGaD2RqE1DhXlNbxcO+qallXnOBUZktB8HgHPC9axHpo6/I4hKL1P5Pad
         v6SGSPdZRj8E2tL1oawurmZqExgq6oRoOzqLMPiHO3sEJA8GiEoRZyzj5TcgPpGULqpd
         cDuSDRKiEeX5hy2rKNk5PFQt4btLLgCtnoP9sI+fQWTnCm8y97x8zAxUWmec48DCwNv+
         3F2cy90ythcMX/R+TAjIMpz+CCjcLzAK64JsJDTkHgEtGq8RanXTMbAKUzPwsQtg+XCk
         a1+jUdxahy7ABT6jfHTbPhZMSgOfhoq4gZVqBaCjAocS4nuC3D6cd6HoIyOt36Utsrvo
         dacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781651610; x=1782256410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=84DiwMXLdEq4yqPEouNIMtm8S6/TgLWUF9alM51937s=;
        b=KXEPdbpXwBCpKExmK2EvJeuUAZWeH3VAcKRypmOzfN7RXMa5PIAqtodC+f0bKnhgC6
         FcawNDZUvVO2RDtBB3mqXSOXmH0JaQ4tydrVryUYjz8c+N1EBU46qWWELYEXZESh7Vn5
         Mk1hKnJ9AtghoGFeYre804aIiiP50RANScZilBDdPl0ssBbaNA8Cg/0fPGcjicRGEDGV
         40ZJn4Tl9UTcK8nkwhas5VWLgjnd8Ts7Q4hKAh+6OlkVEr1NNAhA+WZcOqGj7KdBqL+o
         D59wcGqr+X6F6nfZNutPgCOLbFw79rtOTH58JxUlukBXSpnI8pnF7we2bCsPot0UhmFc
         bE3A==
X-Forwarded-Encrypted: i=1; AFNElJ/ptK3l5/6L7BL1vcz81LPLSMHkGuaz+Mf2Ix4UIUSLif0rSXxKXncNH0yXNwROlS6aYy6ekH1p8io2K8Y0@vger.kernel.org
X-Gm-Message-State: AOJu0YyYc8PZ8yqMIRhp+OWeHwq547HqQwxqKfQP2iiu2YKs0rC4yDjq
	plFKRxSI+F6tq8NRt0JSR4lyxArlJTAnzgdRpXUY7W+OWksuEAd7qmNnfKafqQ==
X-Gm-Gg: Acq92OH260QrhlfPVrY6o3EsrbJ1MjLmmQXwluNKApgCczG4PgkB8VyIb2B+bX//tdl
	3wFZYfiXBVAo8uD+hhuBLjlDhVSJINNbyQN5J6lUAOMD64Vx9KRb2L2fxi7d228h+i4Q/gfmv9g
	4kHsO2InuCNgSY8j02yjUULk1mh/PM9Qgk5657LayTZOnLIwjmGBd0QakFIS3PIlNZA6tfThY06
	hY3P37kxDOQRWAplS6lVwvAOjHX3ahT5m3BFbl+tJuu5TLJJquVwdxSRmJKTgILNHmQAPmzXafM
	JbS79nTNTqQQ+1A9AJ17fJuOUqItiz7RSp+yyZ5F047OViNkD22Hs6Sg1C1aKvzO0RaYqK8lonN
	wHAzgIK/vHyq4tbfw8wOqUaU7WgHQWLE/NlPDJ36iMaUB1v07bSh8+Cmpsv9psO+uZ81DXD9FPL
	f5XAEXn0c5Fk5BZzUDMeneYQ2R0cqkpq25DPUFc41xWbwcnzLknQ9I4yJkfKWG9dsokAR3p25Tx
	lGQp8a3OC/Vg78NfT5qlbkUtRWJ0ZFfjuK919x8Wm5awnnC9yxOgL8=
X-Received: by 2002:a05:6830:6ae5:b0:7e6:f2ef:e231 with SMTP id 46e09a7af769-7e90b2ae089mr1702940a34.2.1781651610294;
        Tue, 16 Jun 2026 16:13:30 -0700 (PDT)
Received: from rdf-gcp2.us-central1-b.c.storage-xlrait-66065.internal (163.80.112.136.bc.googleusercontent.com. [136.112.80.163])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f5a1b86sm7530924a34.5.2026.06.16.16.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 16:13:29 -0700 (PDT)
From: Russ Fellows <russ.fellows@gmail.com>
To: miklos@szeredi.hu,
	fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Russ Fellows <russ.fellows@gmail.com>
Subject: [PATCH v3 1/2] fuse: preserve FOPEN_PARALLEL_DIRECT_WRITES for passthrough opens
Date: Tue, 16 Jun 2026 23:13:21 +0000
Message-ID: <20260616231325.16788-2-russ.fellows@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260616231325.16788-1-russ.fellows@gmail.com>
References: <20260616231325.16788-1-russ.fellows@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

fuse_file_io_open() clears FOPEN_PARALLEL_DIRECT_WRITES for any open
that lacks FOPEN_DIRECT_IO.  That rule is too strict for passthrough
opens, which already bypass the page cache through the backing file
and do not need FOPEN_DIRECT_IO to guarantee direct-I/O semantics.
Clearing the flag before the passthrough write path sees it prevents
the kernel from ever taking the shared-lock path for passthrough writes.

Introduce FOPEN_IOMODE helper macros to classify the effective I/O mode
of an open file:

  FOPEN_IOMODE_IS_CACHED(oflags)      - page-cache I/O (neither flag)
  FOPEN_IOMODE_IS_DIRECT(oflags)      - DIRECT_IO is set
  FOPEN_IOMODE_IS_PASSTHROUGH(oflags) - PASSTHROUGH only (no DIRECT_IO)

Use FOPEN_IOMODE_IS_CACHED to express the PARALLEL_DIRECT_WRITES guard
cleanly: the flag is only suppressed for cached iomode, not for passthrough
or direct-IO mode.

This is a prerequisite for passthrough write parallelism; without it the
shared-lock path in the subsequent patch never activates.

Signed-off-by: Russ Fellows <russ.fellows@gmail.com>
---
 fs/fuse/iomode.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
index c99e285f3..46e60b04c 100644
--- a/fs/fuse/iomode.c
+++ b/fs/fuse/iomode.c
@@ -165,6 +165,23 @@ static void fuse_file_uncached_io_release(struct fuse_file *ff,
 	(FOPEN_PASSTHROUGH | FOPEN_DIRECT_IO | FOPEN_PARALLEL_DIRECT_WRITES | \
 	 FOPEN_NOFLUSH)
 
+/*
+ * Helpers to classify the effective I/O mode of an open file.
+ *
+ * FOPEN_IOMODE()         - extract the mode-relevant bits
+ * FOPEN_IOMODE_IS_CACHED - neither DIRECT_IO nor PASSTHROUGH: page-cache I/O
+ * FOPEN_IOMODE_IS_DIRECT - DIRECT_IO is set (may also have PASSTHROUGH)
+ * FOPEN_IOMODE_IS_PASSTHROUGH - PASSTHROUGH only, without DIRECT_IO
+ */
+#define FOPEN_IOMODE(oflags) \
+	((oflags) & (FOPEN_DIRECT_IO | FOPEN_PASSTHROUGH))
+#define FOPEN_IOMODE_IS_CACHED(oflags) \
+	(FOPEN_IOMODE(oflags) == 0)
+#define FOPEN_IOMODE_IS_DIRECT(oflags) \
+	(FOPEN_IOMODE(oflags) & FOPEN_DIRECT_IO)
+#define FOPEN_IOMODE_IS_PASSTHROUGH(oflags) \
+	(FOPEN_IOMODE(oflags) == FOPEN_PASSTHROUGH)
+
 static int fuse_file_passthrough_open(struct inode *inode, struct file *file)
 {
 	struct fuse_file *ff = file->private_data;
@@ -216,9 +233,11 @@ int fuse_file_io_open(struct file *file, struct inode *inode)
 		goto fail;
 
 	/*
-	 * FOPEN_PARALLEL_DIRECT_WRITES requires FOPEN_DIRECT_IO.
+	 * FOPEN_PARALLEL_DIRECT_WRITES is not supported with cached iomode.
+	 * Passthrough and direct-IO both bypass the page cache, so both are
+	 * eligible to enable parallel direct writes.
 	 */
-	if (!(ff->open_flags & FOPEN_DIRECT_IO))
+	if (FOPEN_IOMODE_IS_CACHED(ff->open_flags))
 		ff->open_flags &= ~FOPEN_PARALLEL_DIRECT_WRITES;
 
 	/*
@@ -228,8 +247,13 @@ int fuse_file_io_open(struct file *file, struct inode *inode)
 	 * Note that if user opens a file open with O_DIRECT, but server did
 	 * not specify FOPEN_DIRECT_IO, a later fcntl() could remove O_DIRECT,
 	 * so we put the inode in caching mode to prevent parallel dio.
+	 *
+	 * Pure direct-IO (DIRECT_IO without PASSTHROUGH) needs no page-cache
+	 * iomode machinery — return early.  When DIRECT_IO and PASSTHROUGH are
+	 * both set, write_iter uses the direct-IO path but the backing file
+	 * still needs to be opened below.
 	 */
-	if ((ff->open_flags & FOPEN_DIRECT_IO) &&
+	if (FOPEN_IOMODE_IS_DIRECT(ff->open_flags) &&
 	    !(ff->open_flags & FOPEN_PASSTHROUGH))
 		return 0;
 
-- 
2.51.0

