Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E2A42A80
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 21:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784581340; cv=none; b=eGzm607b/+jgK/qKjDAC8K+E0sR0sO0FqKrCHiQH9Xv0c2p6qCZN6xT87uatYZZheGXpY0qZkQekgajcUdzg8F524WuWZTdDTQM7d8+ltr1mZkeNU/JML/rAj8QWWq/3XJCLZgtA9rPhRW5qJN3VtFZ7qtsV/ZBVu2hADywXKIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784581340; c=relaxed/simple;
	bh=ibLlsK0kdCXpjOCay4/5p4RnYGibBpbKQR68bmny7Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WfsSpug04mL+VLy5Rwo1AHywtzUf2lpu4btGbWeeoT5XAmoK+nqe+pDrgattMB0i4oAzmHpnI+Z9mxKS0BodRRMf411r/B/WwJ+Q04g/hE7bDkLyK77nqXYUnGX5xZ88cHW+EF4k0M8SQRuUI0BCb/mLllvFM7FMNzuNY3qhaHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rgwdb7Cz; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rgwdb7Cz"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so5732630b3a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 14:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784581338; x=1785186138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0rwzS9SAIc5cuLcUnpCyeE60DuZ9QzAM3gHRyPeqNyU=;
        b=Rgwdb7Cz1TFQc1IcOEgpNxe5w/kt8MSFZJLw5oWTVkBFOTla4iaPIeo2Za9kxcPCH1
         htesrIRlJSCtdjSMDXkzg3t8tWm/fDaEWGQIQpxTG6jcvUXSZbm5VQWcoKPS+xWBvJ/K
         p3sskeN1zhwdIrt/Qlybn5fjq0018XxOIGzZakfbnK7HTRxXbF6j97ezUiq/kFpAAkDg
         fqFeo4wvSVG+4PIsmGfkZtCByEZ9pnB6IKLuLKycYtOzQchloEQe0tHO8i2nD/lgvgaJ
         uCgUWs36sGNNjhKZyDhBBokJ5i6ryHVoRlB81VQnu2ntfZTrwxJvXnV+sEAYz/spFSlP
         mwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784581338; x=1785186138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0rwzS9SAIc5cuLcUnpCyeE60DuZ9QzAM3gHRyPeqNyU=;
        b=PyypSyn+aV3epmLcwCQEP2AXIaRKih9D0kY3kf8CV6nD3ceK/Sm1BEWp/B7QD2wQ2i
         Q9QdKRgQQsKtFSTfAI0Rz7RoEAE6ooy1z77YwnukJEsf4VAn9gqEYpynCFU5XI/HDQNh
         wVJnIM0zDqIm1ucZJaEx83L14SbfB1PMdTIMXKC3KvDL0UxVfBrBEmq64ugGnxXOVpbu
         q06sC4SSlZihfqbeU3XqgCDnJjS4NCVjei2KM0ZuV4+tylZNcMOndEL37/59ygR+ASBw
         ySHVdXNbxuNQGT9tKSM6Co/D0XIq80lZ0F6EaBw8waD1tRw3o7eT/8JEAUwS96J+hyJc
         KPHA==
X-Forwarded-Encrypted: i=1; AHgh+RpAwkiAvN50P+ZVegZQrz2m2M3RAuEPS5fsMLH+feYQbdoHHKBVd/yUWQ5rf0jwd4crZ/aOH6h+IlO1EdpG@vger.kernel.org
X-Gm-Message-State: AOJu0YxapxPASLrZlya3ydXTDgbNh35dUMNUxirwDikIFHXgOCOgJiXG
	DXMiqhSYDLYwYtGE5CuFtHVL8UjR3F0qbTF+dgPbM2NnrZC7Epb/ALBF
X-Gm-Gg: AfdE7ckrfHQXN9tmZy7k1YWoSakyeJy6IpbW5WHC2k58fb/528AO1ZcXo6LQvxjLjzi
	mjsV3z1k2PiNAZsAbYqvh+CfwLDA1uxpECczkSVRESR7oY2ApgWF+/0QC24Bwj4JjMc0IIsxyTx
	3kTuv7ZxHg2hSB3xOQUNS/NSbRCrTXvXeu6/Ek/443Kw0WvxBQZ1Xboc7jlH5UAMWQUXkig/zcC
	ShGyYVPYZnR5XfPIPcWS/qGUqYFcxpAEMEyhWiVB8YH0U+MM+3v9SOow/IIzr6PQXQcJlBPYuap
	2IcZYBjbkUcVxJ2XddrgTkMJKJJQvQRdIFeEXBBFn9PlET4ZxRLaTKSyIuO+MWA1jA/Mqwow7Z4
	F7gHZtpPyJVesDT8A3yn7Sh16zc06Ew1trOKnJupakJS1ebwKTesEpyLgcu8WtlR6JveeRmIaha
	bSluVk+wCXWXXRkH/GTY45abIAbITyxaEJ6joQfFaIrRWsGmI/Z6p+ppkVWZYNKRIk
X-Received: by 2002:a05:6a00:9283:b0:848:2f74:1d5f with SMTP id d2e1a72fcca58-84c29568665mr14720168b3a.69.1784581338085;
        Mon, 20 Jul 2026 14:02:18 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:40::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb519de3437sm4927207a12.28.2026.07.20.14.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 14:02:16 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	hch@lst.de,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org
Cc: changfengnan@bytedance.com,
	kbusch@kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>,
	David Sterba <dsterba@suse.com>,
	Dan Williams <djbw@kernel.org>,
	Gao Xiang <xiang@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH v3 03/20] iomap: skip the finishing iomap_iter() on the simple DIO read fast path
Date: Mon, 20 Jul 2026 14:01:45 -0700
Message-ID: <20260720210202.1163861-4-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260720210202.1163861-1-joannelkoong@gmail.com>
References: <20260720210202.1163861-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fengnan Chang <changfengnan@bytedance.com>

With the ->iomap_next() model, iomap_dio_simple() will run a second,
full iomap_iter() just to finish the range.  For DIO reads on
filesystems with no ->iomap_end() work (ext4, xfs, exfat, ntfs) this is
a no-op, but still costs an extra indirect ->iomap_next() call and the
iomap_iter() frames on every I/O.

Add IOMAP_DIO_NO_IOMAP_END so such callers can promise there is no
->iomap_end() work and no folio batch, letting iomap_dio_simple() skip
the finishing iomap_iter() on both the success and error-exit paths. Opt
in the ext4, xfs, exfat and ntfs direct read paths; filesystems with
real read-path ->iomap_end() work keep the existing behaviour.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Fengnan Chang <changfengnan@bytedance.com>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/exfat/file.c       |  4 ++--
 fs/ext4/file.c        |  3 ++-
 fs/iomap/direct-io.c  | 16 +++++++++++++---
 fs/iomap/trace.h      |  3 ++-
 fs/ntfs/file.c        |  4 ++--
 fs/xfs/xfs_file.c     |  2 +-
 include/linux/iomap.h |  8 ++++++++
 7 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 5fc13378d35f..3a278c95239e 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -809,8 +809,8 @@ static ssize_t exfat_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		file_accessed(iocb->ki_filp);
-		ret = iomap_dio_rw(iocb, iter, &exfat_iomap_ops, NULL, 0,
-				NULL, 0);
+		ret = iomap_dio_rw(iocb, iter, &exfat_iomap_ops, NULL,
+				IOMAP_DIO_NO_IOMAP_END, NULL, 0);
 	} else {
 		ret = generic_file_read_iter(iocb, iter);
 	}
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index eb1a323962b1..7bd5de67ce78 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -91,7 +91,8 @@ static ssize_t ext4_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		return generic_file_read_iter(iocb, to);
 	}
 
-	ret = iomap_dio_rw(iocb, to, &ext4_iomap_ops, NULL, 0, NULL, 0);
+	ret = iomap_dio_rw(iocb, to, &ext4_iomap_ops, NULL,
+			   IOMAP_DIO_NO_IOMAP_END, NULL, 0);
 	inode_unlock_shared(inode);
 
 	file_accessed(iocb->ki_filp);
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index a89c7c697c63..fcdae3ef6dd0 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -1040,7 +1040,9 @@ iomap_dio_simple_finish(struct iomap_iter *iomi, const struct iomap_ops *ops,
  * @dio_flags must not request IOMAP_DIO_FORCE_WAIT, IOMAP_DIO_PARTIAL, or
  * IOMAP_DIO_BOUNCE: this path does not support forced waiting, partial direct
  * I/O, or bouncing.  The range must also stay within i_size and encrypted
- * inodes must use the generic iomap direct I/O path.
+ * inodes must use the generic iomap direct I/O path. IOMAP_DIO_NO_IOMAP_END is
+ * a fast-path optimization the caller can set if there is no work that needs to
+ * be finished after a mapping.
  *
  * -ENOTBLK is the private sentinel returned by iomap_dio_simple() when it
  * decides the request does not fit the fast path.  In that case we proceed to
@@ -1154,7 +1156,14 @@ iomap_dio_simple(struct kiocb *iocb, struct iov_iter *iter,
 		WRITE_ONCE(iocb->private, bio);
 	}
 
-	iomap_dio_simple_finish(&iomi, ops, count, count);
+	/*
+	 * The finishing iomap_iter() only runs the filesystem's iomap_end()
+	 * work and releases any attached folio batch.  When the caller promised
+	 * neither applies (IOMAP_DIO_NO_IOMAP_END), skip it to avoid an extra
+	 * iomap_next() call on the hot read path.
+	 */
+	if (!(dio_flags & IOMAP_DIO_NO_IOMAP_END))
+		iomap_dio_simple_finish(&iomi, ops, count, count);
 
 	if (!wait_for_completion) {
 		bio->bi_end_io = iomap_dio_simple_end_io;
@@ -1171,7 +1180,8 @@ iomap_dio_simple(struct kiocb *iocb, struct iov_iter *iter,
 out_bio_put:
 	bio_put(bio);
 out_iomap_end:
-	iomap_dio_simple_finish(&iomi, ops, count, 0);
+	if (!(dio_flags & IOMAP_DIO_NO_IOMAP_END))
+		iomap_dio_simple_finish(&iomi, ops, count, 0);
 	inode_dio_end(inode);
 	return ret;
 }
diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
index e1ea8392cf47..e43ca419b13a 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -127,7 +127,8 @@ DEFINE_RANGE_EVENT(iomap_zero_iter);
 	{IOMAP_DIO_FORCE_WAIT,		"DIO_FORCE_WAIT" }, \
 	{IOMAP_DIO_OVERWRITE_ONLY,	"DIO_OVERWRITE_ONLY" }, \
 	{IOMAP_DIO_PARTIAL,		"DIO_PARTIAL" }, \
-	{IOMAP_DIO_FSBLOCK_ALIGNED,	"DIO_FSBLOCK_ALIGNED" }
+	{IOMAP_DIO_FSBLOCK_ALIGNED,	"DIO_FSBLOCK_ALIGNED" }, \
+	{IOMAP_DIO_NO_IOMAP_END,	"DIO_NO_IOMAP_END" }
 
 DECLARE_EVENT_CLASS(iomap_class,
 	TP_PROTO(struct inode *inode, struct iomap *iomap),
diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 6a7b638e523d..2e72069c593a 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -458,8 +458,8 @@ static ssize_t ntfs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		}
 
 		file_accessed(iocb->ki_filp);
-		ret = iomap_dio_rw(iocb, to, &ntfs_read_iomap_ops, NULL, 0,
-				NULL, 0);
+		ret = iomap_dio_rw(iocb, to, &ntfs_read_iomap_ops, NULL,
+				IOMAP_DIO_NO_IOMAP_END, NULL, 0);
 	} else {
 		ret = generic_file_read_iter(iocb, to);
 	}
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 845a97c9b063..8b8de8064e31 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -251,7 +251,7 @@ xfs_file_dio_read(
 	struct iov_iter		*to)
 {
 	struct xfs_inode	*ip = XFS_I(file_inode(iocb->ki_filp));
-	unsigned int		dio_flags = 0;
+	unsigned int		dio_flags = IOMAP_DIO_NO_IOMAP_END;
 	const struct iomap_dio_ops *dio_ops = NULL;
 	ssize_t			ret;
 
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 74d79b963533..8662bd528e9e 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -674,6 +674,14 @@ struct iomap_dio_ops {
  */
 #define IOMAP_DIO_BOUNCE		(1 << 4)
 
+/*
+ * The caller's ->iomap_next() has no ->iomap_end() work to run and this I/O
+ * does not use a folio batch, so the iomap_dio_simple() fast path may skip the
+ * finishing iomap_iter() call entirely.  Only meaningful on the simple read
+ * fast path; ignored by the generic __iomap_dio_rw() slow path.
+ */
+#define IOMAP_DIO_NO_IOMAP_END		(1 << 5)
+
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
 		unsigned int dio_flags, void *private, size_t done_before);
-- 
2.52.0

