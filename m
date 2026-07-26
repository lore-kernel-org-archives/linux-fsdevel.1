Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24F135DA43
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Jul 2026 01:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785031199; cv=none; b=tj7jLqUuZmaJhO/XzNfMEU3uWL+eeaDeYWO33o0i8O/dZa5xCM0JjyCR/MTgANtr7zk7lTufixvy6SjpZ/a+EP+jSMU15YGZrsTmbSa5DDvzGAQlFhspf/zzSkLgRkfrY0hKY3+LpCpbb13SqAGzEWaXuR4Hza1OXUTyzqp7UuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785031199; c=relaxed/simple;
	bh=2V+3m0fgntJtbg8ymQ5J7H5s4f+81WfW9BhXC4k8GHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=auZ+1jQkiBQIiZnYw2xhbP9IIlWG1lnOGyCZ1X73/bNpjlnTOyft8hCrt4ceCots+1DjB3vtdXaYQcWhUL4MMuMNG3forNYB0xAthRgd9oGMHoykVF5d3/fUY2pXug/VHZ+5eF29OGpUbH34WW1abr1xy5Siw0oj6MhtT8fo+og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izDqyoD6; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izDqyoD6"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7e9ecd7216cso768885a34.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2026 18:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785031197; x=1785635997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DsHLlh0udDqVC+emmPBCCltHi5t5SZsNobdjX3Jo96c=;
        b=izDqyoD6HC2S+9wCGI5Dek+lE+PwSAEdQTLEgF5wzmdVZh0fUWZbAz6/DaXxjTuZKl
         jNnnQePShI3P7wRdPlgv9s9I3CU/p+gUl2MjLKlRhqgk1ztGut8/Ej+Up6Vj1vOFB3Tp
         JJ9UxI9ovnVuOHJOTHtWoU80J8IRmdgy8XhGQIzrd2HG9UncGUqCEEMUms9Sa211pXhD
         ojUPprdT/Bp3i20Fkw/6eM9yLZIf10AFYJUkyFagy8vjwjITOO2vaIXO55uV2HMo5KUt
         kUEMWmykpP8jHc7gxfRggsDP3SbcgKKM1qnb8YGwv3j1u0hIInwuBQXOOJx0CTEQqUr/
         QHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785031197; x=1785635997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DsHLlh0udDqVC+emmPBCCltHi5t5SZsNobdjX3Jo96c=;
        b=Dr5bb6k+rYx7BqZ8BNsRHGXgNYGrPLXxiP5dNAafPkhiMw2RUI4EhpGBoyV9dm3gNY
         kjXl5HYdRWT2qIWYV8ywVR3Y3nQcMol4TsdY0LGSyqThcz8xxRNiWrJeW9n8dmbKN4XD
         rMKXZkdHTp1+iUR74kLByFx32jugMDEAQFfWWscy39MAQCMVh9yz4QsPS/A9RgstYhP4
         97sFfNIi+AKaLIy7+Avzmv7X7k/jzGKberEKSv2jmRDKGnxAB7s7U74u40C+FjMf52BM
         LAiHN/Ft5j4tUyN6XCVOl4VIdjT/j3dUKSWQv4Bp1fKsfWuWV657KWXevQ2RVvvwewqS
         NEYg==
X-Forwarded-Encrypted: i=1; AHgh+RpE/ILePBIyKiArSATMnRT4JXsMnaajmToLCLTrHCuKEWc1WYARZnQYsHu0atUTO5BhpJW6ZAk9BbXLxgQy@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhp2M/plJEEc7mQMOrZd1yykRR28soq8ON1D05AvT9f6OVO2N+
	6L9G4nHFvQzVnr/xi9HPmBo9lCMlcZiudczc1zGudfR+0k4H+YxPiE1ruhvR7Q==
X-Gm-Gg: AR+sD13XpKeunCOsFBQBUVtUadMyFFeyakhbKhA9JlGKJ6SN7NMnS3rDnwzvLeoo7iK
	VvoInyTeeSp77HezFPLjA+OFqcR33001iOQJtjsUsKCfeXDB9Jr0qD/716/oW6AoMcUfnYsl5zN
	eWnfcnqZowbLmHOhBYmQgo04BdU8+lKTbxD/c7Li+JkJy3qjeG3o+gOZphCwg9dpTx2yQGGp63e
	pfPMoOpy3GgysBmrxe9TH72meT9XJESbFLUJP+HxKKJKK3rkyReukocSJnlAQd37oC2KtgFwimH
	oD4dR48sd5TRb16ikq7PBqzLUFOOpEx8Yquy8LBDPkTlmRWf6mCobKPXTr2LpXkjz+cMRUhgIeg
	jRJ5WTBdvxbgT7PFhdf2qMDG2J4xntMKjEQsew3lcrJXh7wMWgjt6A0NpNd62kTVy0nLhKNkV9U
	1SLWCGQPW9e67YA2ej3N651gjZ8Ysb8u4ijhdcFyVmDcuQzB4avDNYTSfXpEnkMfnBN++lVjfVm
	ILZ5wS4fp2iT52ZrzidjQgq6TNTVRt5lN7/P/CTAAQF
X-Received: by 2002:a05:6830:314d:b0:7e9:cf5d:b7c3 with SMTP id 46e09a7af769-7ee78db7dd2mr3701023a34.23.1785031196730;
        Sat, 25 Jul 2026 18:59:56 -0700 (PDT)
Received: from rdf-gcp2.us-central1-b.c.storage-xlrait-66065.internal (163.80.112.136.bc.googleusercontent.com. [136.112.80.163])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ee29e0ec5bsm9335656a34.10.2026.07.25.18.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 18:59:56 -0700 (PDT)
From: Russ Fellows <russ.fellows@gmail.com>
To: miklos@szeredi.hu
Cc: amir73il@gmail.com,
	fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Russ Fellows <russ.fellows@gmail.com>
Subject: [PATCH v4 1/2] fuse: preserve FOPEN_PARALLEL_DIRECT_WRITES for passthrough opens
Date: Sun, 26 Jul 2026 01:59:54 +0000
Message-ID: <20260726015955.319132-2-russ.fellows@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260726015955.319132-1-russ.fellows@gmail.com>
References: <20260616231325.16788-1-russ.fellows@gmail.com>
 <20260726015955.319132-1-russ.fellows@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fuse_file_io_open() clears FOPEN_PARALLEL_DIRECT_WRITES for any open
that lacks FOPEN_DIRECT_IO.  That rule is too strict for passthrough
opens, which already bypass the page cache through the backing file
and do not need FOPEN_DIRECT_IO to guarantee direct-I/O semantics.
Clearing the flag before the passthrough write path sees it prevents
the kernel from ever taking the shared-lock path for passthrough writes.

Introduce FOPEN_IOMODE_CACHED() to test for cached (page-cache) iomode
-- neither FOPEN_DIRECT_IO nor FOPEN_PASSTHROUGH set -- and use it to
guard the FOPEN_PARALLEL_DIRECT_WRITES stripping.  Passthrough and
direct-IO opens both bypass the page cache, so both are now eligible to
enable parallel direct writes.

While here, simplify fuse_file_io_open(): drop the early return for the
pure direct-IO case and dispatch the caching open through the same
FOPEN_IOMODE_CACHED() test, so a pure direct-IO open simply performs no
iomode setup instead of returning early.

This is a prerequisite for passthrough write parallelism; without it the
shared-lock path in the subsequent patch never activates.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Russ Fellows <russ.fellows@gmail.com>
---
 fs/fuse/iomode.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
index 3728933..937d9e6 100644
--- a/fs/fuse/iomode.c
+++ b/fs/fuse/iomode.c
@@ -192,12 +192,18 @@ static int fuse_file_passthrough_open(struct inode *inode, struct file *file)
 	return err;
 }
 
+/* Fuse uses page cache if no passthrough nor direct_io open specified */
+#define FOPEN_IOMODE(oflags) \
+	((oflags) & (FOPEN_DIRECT_IO | FOPEN_PASSTHROUGH))
+#define FOPEN_IOMODE_CACHED(oflags) \
+	(FOPEN_IOMODE(oflags) == 0)
+
 /* Request access to submit new io to inode via open file */
 int fuse_file_io_open(struct file *file, struct inode *inode)
 {
 	struct fuse_file *ff = file->private_data;
 	struct fuse_inode *fi = get_fuse_inode(inode);
-	int err;
+	int err = 0;
 
 	/*
 	 * io modes are not relevant with DAX and with server that does not
@@ -216,25 +222,20 @@ int fuse_file_io_open(struct file *file, struct inode *inode)
 
 	/*
 	 * FOPEN_PARALLEL_DIRECT_WRITES requires FOPEN_DIRECT_IO.
+	 * Note that if user opens a file open with O_DIRECT, but server did
+	 * not specify FOPEN_DIRECT_IO, a later fcntl() could remove O_DIRECT,
+	 * so we put the inode in caching mode to prevent parallel dio.
 	 */
-	if (!(ff->open_flags & FOPEN_DIRECT_IO))
+	if (FOPEN_IOMODE_CACHED(ff->open_flags))
 		ff->open_flags &= ~FOPEN_PARALLEL_DIRECT_WRITES;
 
 	/*
 	 * First passthrough file open denies caching inode io mode.
 	 * First caching file open enters caching inode io mode.
-	 *
-	 * Note that if user opens a file open with O_DIRECT, but server did
-	 * not specify FOPEN_DIRECT_IO, a later fcntl() could remove O_DIRECT,
-	 * so we put the inode in caching mode to prevent parallel dio.
 	 */
-	if ((ff->open_flags & FOPEN_DIRECT_IO) &&
-	    !(ff->open_flags & FOPEN_PASSTHROUGH))
-		return 0;
-
 	if (ff->open_flags & FOPEN_PASSTHROUGH)
 		err = fuse_file_passthrough_open(inode, file);
-	else
+	else if (FOPEN_IOMODE_CACHED(ff->open_flags))
 		err = fuse_file_cached_io_open(inode, ff);
 	if (err)
 		goto fail;
-- 
2.51.0

