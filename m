Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765CE1A275
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 00:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782864676; cv=none; b=aPlyCVhnq8n0r13J1pDhSg3wze/WM6XlsTueTeqTHcJJITNjqxnYNhJB1I564RagXhsfIPQc9rU+zVp9x46RSY6lZK2Sil64q/MXWnx10v8+LXY0qrnL/R9SqJyM6Ye/ZUXWwK2mCsJEUNs02lFLoPA4wJ3bsNtk6qNCb0rzvwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782864676; c=relaxed/simple;
	bh=zHWmKUCnN9WkUCSZXVq2kyOq9l5T0i6QS1ziiAD3fMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5MKincNRi/eM6khKPUmwXjV6w9rMm8Ne9Eu/gbWxtue0oiiB64Vzp37iGmnrOvLlHhYLIdPD6lwHMofnMp+NbT/0AStNCIaCGkx91B4BcxTn3uV/rWrc9DSO4DCdcna5UeeGCQQDxV1dI9JnGCLbBnQ1gwBUUp/Pufl3Hgnbfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqegPpk6; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqegPpk6"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6a17e36fa79so31840eaf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 17:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782864673; x=1783469473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNPbzx+vXvTNK/IK2NGcoyn2nveTdVJbNDgmvFlw3Co=;
        b=QqegPpk6ZFxWjZ0P0x7QqsQzHJouuNh3I5khH5Vz5JflEAw2IjjYIaYri9/e6AL26O
         boea6qJ9R82kOTnu65PavNPteJx6MyOn7a2zCKB/JPjeERU1EVh//We8vH1N8Or9oa9R
         qhvtERVqtDmluTY1Pkc+uws2upzOGFyPyCXTm947fifCwgY5dDJ+n2d9EyPmGdYHyhTW
         G9AU7EQyg6gdRFwa/jfHbk22OBt4bTYOOsGzIAfYjQkg2+ss7+4cRyV3kMeFlKCL0C8q
         1/SFbOhN6Lz3tw0+4VY4WjDvSoVDg5L6MV2DzILvlg7X4SJmDDxyT8TeZn8OqlrHtwV4
         5FRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782864673; x=1783469473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oNPbzx+vXvTNK/IK2NGcoyn2nveTdVJbNDgmvFlw3Co=;
        b=CSIZVV4S38ziKl5nqcAlR4dOTjw1A/FDG5iQLiUdDOrxUzlCBkqDerK9K3tNEQjaX0
         /XSOpGUn2ck7EE87M8aVMWzKXhrUZlyATlZAKY5Be0ptte3qBaaH7V8ktFZ20dRnuy+Z
         i4hw43H//h+k4elNTcGBCTlLoWxz4Rwv4NFMu7JLtklNBq24+rwEVejeDHvMmcNdoSRU
         G4PzgEKcFnTNXUv8G7GUq1W2SFk/Fk0ZOAXfZihXnzlnlt0MI+tj8dUXu4le8go8Dpf2
         sz0MBnMlN4N0V8oQ34kNHl34gl6XKfbHrZtQ5HtD61R3TBEZ0OonN3h/8DQaqgkYUZ1P
         jePw==
X-Forwarded-Encrypted: i=1; AFNElJ96ug3I/WrhNFRA+0pNePfMTGR/UZkoLb3YTO/ZNQap0I8rPcYCbf5qS8klm/1K2rulwChqRNzvgTVISk22@vger.kernel.org
X-Gm-Message-State: AOJu0YwBAOiFgDChRWnxgj3dVgpPqW0mIx58zqXY2wPDcoBO5m93DVsN
	F9/UiEqqg9ZkGXDBbP3P2UBhIwfMBGgWd04vNedk31cI+M/vYgTALyLo
X-Gm-Gg: AfdE7cm29FgxMxhzhZMwEb09gqdI4iu0lXUsiOMQVQsePsfMiywE4jnmATgN6/vgu6j
	pycnMoFEOcydMj1WrLPjMCKXBGHIcPa5q1F6xGGdNaWvo7i9ieSlXuD/2+UgM0n6GOPbMjEf42c
	O42ch3totxMw3dHoU5bKpMjjoNN8CzlqsZnYu5mxRgADa0X1bbfGxW92ZV3WN1grniOEKTGLZNd
	uFazB7YEqzgsWUGMtwlu6NTyB7wbyCQYS0faqX41GZCQJJ9xrEHW8m29wQiWyv1zCLBKIjbyFwq
	VODprHcpHkvYtUGSOw7pOMWEvPy0LhuPBYmjPqoWCAnGtAQqEeHEWEUUTdnu9yGwPbv1pv0NvR4
	O82YKmCXUG123wiNxLmM++L3qgiG8k9sbACvKtMkGh6+VcBGe/URWOrBF/S/remTizdSXBn+u6A
	V4nXhGT/s0MZtjJOhfqMNt3NUdjqGcsWvXEAWACBtKKMbRphJxwU7E1IsQzs9MXBs=
X-Received: by 2002:a05:6820:4dc2:b0:6a0:a791:6885 with SMTP id 006d021491bc7-6a1890a59b5mr4146462eaf.23.1782864673320;
        Tue, 30 Jun 2026 17:11:13 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44c5f7b8b80sm366853fac.0.2026.06.30.17.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 17:11:12 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	hch@lst.de
Cc: djwong@kernel.org,
	willy@infradead.org,
	hsiangkao@linux.alibaba.com,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 02/18] xfs: convert iomap ops to ->iomap_next()
Date: Tue, 30 Jun 2026 17:09:17 -0700
Message-ID: <20260701000949.1666714-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260701000949.1666714-1-joannelkoong@gmail.com>
References: <20260701000949.1666714-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert xfs iomap_ops to the new ->iomap_next() callback. This uses the
iomap_process() helper, which finishes the previous mapping if needed
and produces the next one. No functional changes are intended.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/xfs/xfs_file.c  |  4 +-
 fs/xfs/xfs_iomap.c | 96 +++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 88 insertions(+), 12 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 845a97c9b063..7f8bef1a9954 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -857,9 +857,9 @@ xfs_file_dio_write_atomic(
 			NULL, 0);
 
 	/*
-	 * The retry mechanism is based on the ->iomap_begin method returning
+	 * The retry mechanism is based on the ->iomap_next method returning
 	 * -ENOPROTOOPT, which would be when the REQ_ATOMIC-based write is not
-	 * possible. The REQ_ATOMIC-based method typically not be possible if
+	 * possible. The REQ_ATOMIC-based method is typically not possible if
 	 * the write spans multiple extents or the disk blocks are misaligned.
 	 */
 	if (ret == -ENOPROTOOPT && dops == &xfs_direct_write_iomap_ops) {
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 225c3de88d03..4fa1a5c985db 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1037,8 +1037,18 @@ xfs_direct_write_iomap_begin(
 	return error;
 }
 
+static int
+xfs_direct_write_iomap_next(
+	const struct iomap_iter *iter,
+	struct iomap		*iomap,
+	struct iomap		*srcmap)
+{
+	return iomap_process(iter, iomap, srcmap, xfs_direct_write_iomap_begin,
+			NULL);
+}
+
 const struct iomap_ops xfs_direct_write_iomap_ops = {
-	.iomap_begin		= xfs_direct_write_iomap_begin,
+	.iomap_next		= xfs_direct_write_iomap_next,
 };
 
 #ifdef CONFIG_XFS_RT
@@ -1089,8 +1099,18 @@ xfs_zoned_direct_write_iomap_begin(
 	return 0;
 }
 
+static int
+xfs_zoned_direct_write_iomap_next(
+	const struct iomap_iter *iter,
+	struct iomap		*iomap,
+	struct iomap		*srcmap)
+{
+	return iomap_process(iter, iomap, srcmap,
+			xfs_zoned_direct_write_iomap_begin, NULL);
+}
+
 const struct iomap_ops xfs_zoned_direct_write_iomap_ops = {
-	.iomap_begin		= xfs_zoned_direct_write_iomap_begin,
+	.iomap_next		= xfs_zoned_direct_write_iomap_next,
 };
 #endif /* CONFIG_XFS_RT */
 
@@ -1274,8 +1294,18 @@ xfs_atomic_write_cow_iomap_begin(
 	return error;
 }
 
+static int
+xfs_atomic_write_cow_iomap_next(
+	const struct iomap_iter *iter,
+	struct iomap		*iomap,
+	struct iomap		*srcmap)
+{
+	return iomap_process(iter, iomap, srcmap,
+			xfs_atomic_write_cow_iomap_begin, NULL);
+}
+
 const struct iomap_ops xfs_atomic_write_cow_iomap_ops = {
-	.iomap_begin		= xfs_atomic_write_cow_iomap_begin,
+	.iomap_next		= xfs_atomic_write_cow_iomap_next,
 };
 
 static int
@@ -1298,9 +1328,18 @@ xfs_dax_write_iomap_end(
 	return xfs_reflink_end_cow(ip, pos, written);
 }
 
+static int
+xfs_dax_write_iomap_next(
+	const struct iomap_iter *iter,
+	struct iomap		*iomap,
+	struct iomap		*srcmap)
+{
+	return iomap_process(iter, iomap, srcmap, xfs_direct_write_iomap_begin,
+			xfs_dax_write_iomap_end);
+}
+
 const struct iomap_ops xfs_dax_write_iomap_ops = {
-	.iomap_begin	= xfs_direct_write_iomap_begin,
-	.iomap_end	= xfs_dax_write_iomap_end,
+	.iomap_next	= xfs_dax_write_iomap_next,
 };
 
 /*
@@ -2168,9 +2207,19 @@ xfs_buffered_write_iomap_end(
 	return 0;
 }
 
+static int
+xfs_buffered_write_iomap_next(
+	const struct iomap_iter *iter,
+	struct iomap		*iomap,
+	struct iomap		*srcmap)
+{
+	return iomap_process(iter, iomap, srcmap,
+			xfs_buffered_write_iomap_begin,
+			xfs_buffered_write_iomap_end);
+}
+
 const struct iomap_ops xfs_buffered_write_iomap_ops = {
-	.iomap_begin		= xfs_buffered_write_iomap_begin,
-	.iomap_end		= xfs_buffered_write_iomap_end,
+	.iomap_next		= xfs_buffered_write_iomap_next,
 };
 
 static int
@@ -2214,8 +2263,17 @@ xfs_read_iomap_begin(
 				 shared ? IOMAP_F_SHARED : 0, seq);
 }
 
+static int
+xfs_read_iomap_next(
+	const struct iomap_iter *iter,
+	struct iomap		*iomap,
+	struct iomap		*srcmap)
+{
+	return iomap_process(iter, iomap, srcmap, xfs_read_iomap_begin, NULL);
+}
+
 const struct iomap_ops xfs_read_iomap_ops = {
-	.iomap_begin		= xfs_read_iomap_begin,
+	.iomap_next		= xfs_read_iomap_next,
 };
 
 static int
@@ -2302,8 +2360,17 @@ xfs_seek_iomap_begin(
 	return error;
 }
 
+static int
+xfs_seek_iomap_next(
+	const struct iomap_iter *iter,
+	struct iomap		*iomap,
+	struct iomap		*srcmap)
+{
+	return iomap_process(iter, iomap, srcmap, xfs_seek_iomap_begin, NULL);
+}
+
 const struct iomap_ops xfs_seek_iomap_ops = {
-	.iomap_begin		= xfs_seek_iomap_begin,
+	.iomap_next		= xfs_seek_iomap_next,
 };
 
 static int
@@ -2349,8 +2416,17 @@ xfs_xattr_iomap_begin(
 	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, IOMAP_F_XATTR, seq);
 }
 
+static int
+xfs_xattr_iomap_next(
+	const struct iomap_iter *iter,
+	struct iomap		*iomap,
+	struct iomap		*srcmap)
+{
+	return iomap_process(iter, iomap, srcmap, xfs_xattr_iomap_begin, NULL);
+}
+
 const struct iomap_ops xfs_xattr_iomap_ops = {
-	.iomap_begin		= xfs_xattr_iomap_begin,
+	.iomap_next		= xfs_xattr_iomap_next,
 };
 
 int
-- 
2.52.0

