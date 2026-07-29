Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0877B463B99
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 19:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785353414; cv=none; b=XE13tGixBY0yoI/weaycChHlfs/pYRb4nIAnwAoCQn1ooLdYdJfGibEUdAjI1QoKRVwxKh2D2qbtnEXARN6GHhDOrDBYMCGpNuF1GbyY2v/0UMy0bUnYSBMK2dFEX/Tf2zbeBgfSItQUA4YtELSCrrH6+XFKNwV4t8bdWyUh+TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785353414; c=relaxed/simple;
	bh=K8BrKecw6uXGDxTWCk08ni93yyms9UC/GDj7MkfjZVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qCkV5A8pAas+YXYxLmcGC6+chd2w76VwD9XzC8lRuxmFpqy1P42VSxSXZH/e7lfCQaKayNYFxG9XLD4dRdr+r80PQ6jT1siEDiz45bClI80ILg8VZngJijq3vWaZUl4SJKlTgMG++LvaKvNaQXfXI4dgsQYrvJDMA3iuNyO9itQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+FLovW4; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+FLovW4"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8486672f03cso1496994b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 12:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785353401; x=1785958201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uE0LjfKNhl8kzjVRKnr3dsoBJ6HNUFyTJRWoUOQfCiE=;
        b=U+FLovW4U2wlAaOguqZEmGkM1u4q+2fnpZxvg/oU49iwLhqN5ci2bEje/+rVZtEKgD
         WpptpdqZcr/+pmlAqYw8jIGaGKx7ZtEjhh//BUOb1Ds96MuxlHq0F9x6yyGm/ZCttlxU
         DGZ0nJILSccrn+ynKxA2WyvH5d+VOpLB72cLO6bfdxmSMvuwvih+FXarhs/uRT08ZtgU
         KSeDnkSWgIjG9XN4KBSpXExHlRIfb/XVmWRE1FmLPJkUccEDS5u9Y65tD0dWWs19melu
         E6MwM0qGVMbqWJpTaCz8KTnT6dzW3HBQXfhU3X6kTGSucvKHg3sxBXqdAXprMZoo9Ey2
         1/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785353401; x=1785958201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uE0LjfKNhl8kzjVRKnr3dsoBJ6HNUFyTJRWoUOQfCiE=;
        b=er1gP+ZnyPsV902KhXjj4t2+D2sLna37UFUPS2Xh0nQWKM9mLKgUj4hjm2gUX0g+6O
         dqudZIoRFD0PwHsDryZf6IjkHQT3b+ttv9LBlAGjUgGuU8va0L1F1ozyhRFoIYtFpQi9
         C05skgzZo69uRdI9Lq6vh6wNy/5668dGGu5xp3WPjtNTI4qrjrIdpt3QC/8TnLmDlZzO
         UnGNBX0rcvhBdOy36WUl6rriyr7Bx+zrPion40QDiPtJwNm0HKIDrHjXWG2Y8qdN9dT2
         OIrdHVA+c7ZF5TfQ5AelGe65f/r5fPPf/e06XRIhgDoVDbu7ENcZ/zsFWzIHPoHTegDi
         vY2A==
X-Forwarded-Encrypted: i=1; AHgh+RrzChoIHCZ7SgIggazjHDNK4BcXqT5cMeVgZxtfy9lLCg5xoyq6FhBbPKu66WrIDAGXk3E8STcSnm7FRSK5@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh9rimkPjlMBr2TN6JLzkDeR7x1bEVSiOxR+3awOw0LC14R2Z9
	MEy2pgUHJIkcCGlncLkvq/mv0gnfa7/hW6lFbyAT0GoorIki9X8amFyD
X-Gm-Gg: AR+sD11QyRxF7l7bKNObfkVQIOqw/lLFypNvKcpypMN7UCBlkChInRf0Q3nkpBq74mX
	wMyfhb7ZS/00dR14/FBPQmqNpcoYdJr+nShRqVg69TCTRM9MlZOoP3UNo6VTXU0lKEDxujMCdWj
	RSxa/VbtlY1o49AJjA40FmMCag3m+VD1zsekePJpro8ld0DDMMzlw44ySZIjhX99e1exIk9O5e1
	AoIR/A1m/7KhfACfd//P2tdYR0WtiB6ZfP3eUF42m4bO/SiodOvVYDRpDZJAuldSMana0OwjNRN
	9BT4tadZVjzUvrXhA+PhTos2hLdTxsfdJdzkQsMGR1GngVlZ5bAp+TddC4yuFxShmu1dhls4lB6
	kR9cjTdqi/g5CHUvYKnPKgj+XAslmlpfCKUITeCS+vX7OnhVl7Fm8umowhscTB9l2FOZaf3okXQ
	bAdmKr9QoJe1b5OBhHS5uUq7wcN5bi6pBh+llYBIx6uAaIRw0eaVa2cuEDW1CXez+ntP5/+GkBK
	QUB9OKRR85G/Wiuuged2k7PgawoUnp8LpXJLfpUSu8F/Qu6EFU=
X-Received: by 2002:a05:6a00:180c:b0:847:982e:cca0 with SMTP id d2e1a72fcca58-84eb9ebd657mr102429b3a.19.1785353401071;
        Wed, 29 Jul 2026 12:30:01 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:53::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea02ff637sm1861034b3a.39.2026.07.29.12.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 12:30:00 -0700 (PDT)
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
	Damien Le Moal <dlemoal@kernel.org>,
	libaokun@linux.alibaba.com,
	bfoster@redhat.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH v5 06/22] xfs: convert iomap ops to ->iomap_next()
Date: Wed, 29 Jul 2026 12:27:21 -0700
Message-ID: <20260729192737.3190206-7-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260729192737.3190206-1-joannelkoong@gmail.com>
References: <20260729192737.3190206-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert xfs iomap_ops to the new ->iomap_next() callback. Each callback is
generated with the DEFINE_IOMAP_ITER_NEXT()/DEFINE_IOMAP_ITER_NEXT_END()
macros, which wrap the iomap_iter_next() helper to finish the previous
mapping if needed and produce the next one. No functional changes are
intended.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/xfs/xfs_file.c  |  4 ++--
 fs/xfs/xfs_iomap.c | 39 +++++++++++++++++++++++++++++----------
 2 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index b733225d2864..768cabf6250b 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -859,9 +859,9 @@ xfs_file_dio_write_atomic(
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
index 0536e2aeddcc..71c45be8c652 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1037,8 +1037,11 @@ xfs_direct_write_iomap_begin(
 	return error;
 }
 
+static DEFINE_IOMAP_ITER_NEXT(xfs_direct_write_iomap_next,
+		xfs_direct_write_iomap_begin);
+
 const struct iomap_ops xfs_direct_write_iomap_ops = {
-	.iomap_begin		= xfs_direct_write_iomap_begin,
+	.iomap_next		= xfs_direct_write_iomap_next,
 };
 
 #ifdef CONFIG_XFS_RT
@@ -1089,8 +1092,11 @@ xfs_zoned_direct_write_iomap_begin(
 	return 0;
 }
 
+static DEFINE_IOMAP_ITER_NEXT(xfs_zoned_direct_write_iomap_next,
+		xfs_zoned_direct_write_iomap_begin);
+
 const struct iomap_ops xfs_zoned_direct_write_iomap_ops = {
-	.iomap_begin		= xfs_zoned_direct_write_iomap_begin,
+	.iomap_next		= xfs_zoned_direct_write_iomap_next,
 };
 #endif /* CONFIG_XFS_RT */
 
@@ -1274,8 +1280,11 @@ xfs_atomic_write_cow_iomap_begin(
 	return error;
 }
 
+static DEFINE_IOMAP_ITER_NEXT(xfs_atomic_write_cow_iomap_next,
+		xfs_atomic_write_cow_iomap_begin);
+
 const struct iomap_ops xfs_atomic_write_cow_iomap_ops = {
-	.iomap_begin		= xfs_atomic_write_cow_iomap_begin,
+	.iomap_next		= xfs_atomic_write_cow_iomap_next,
 };
 
 static int
@@ -1298,9 +1307,11 @@ xfs_dax_write_iomap_end(
 	return xfs_reflink_end_cow(ip, pos, written);
 }
 
+static DEFINE_IOMAP_ITER_NEXT_END(xfs_dax_write_iomap_next,
+		xfs_direct_write_iomap_begin, xfs_dax_write_iomap_end);
+
 const struct iomap_ops xfs_dax_write_iomap_ops = {
-	.iomap_begin	= xfs_direct_write_iomap_begin,
-	.iomap_end	= xfs_dax_write_iomap_end,
+	.iomap_next	= xfs_dax_write_iomap_next,
 };
 
 /*
@@ -2168,9 +2179,11 @@ xfs_buffered_write_iomap_end(
 	return 0;
 }
 
+static DEFINE_IOMAP_ITER_NEXT_END(xfs_buffered_write_iomap_next,
+		xfs_buffered_write_iomap_begin, xfs_buffered_write_iomap_end);
+
 const struct iomap_ops xfs_buffered_write_iomap_ops = {
-	.iomap_begin		= xfs_buffered_write_iomap_begin,
-	.iomap_end		= xfs_buffered_write_iomap_end,
+	.iomap_next		= xfs_buffered_write_iomap_next,
 };
 
 int
@@ -2214,8 +2227,10 @@ xfs_read_iomap_begin(
 				 shared ? IOMAP_F_SHARED : 0, seq);
 }
 
+static DEFINE_IOMAP_ITER_NEXT(xfs_read_iomap_next, xfs_read_iomap_begin);
+
 const struct iomap_ops xfs_read_iomap_ops = {
-	.iomap_begin		= xfs_read_iomap_begin,
+	.iomap_next		= xfs_read_iomap_next,
 };
 
 static int
@@ -2302,8 +2317,10 @@ xfs_seek_iomap_begin(
 	return error;
 }
 
+static DEFINE_IOMAP_ITER_NEXT(xfs_seek_iomap_next, xfs_seek_iomap_begin);
+
 const struct iomap_ops xfs_seek_iomap_ops = {
-	.iomap_begin		= xfs_seek_iomap_begin,
+	.iomap_next		= xfs_seek_iomap_next,
 };
 
 static int
@@ -2349,8 +2366,10 @@ xfs_xattr_iomap_begin(
 	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, IOMAP_F_XATTR, seq);
 }
 
+static DEFINE_IOMAP_ITER_NEXT(xfs_xattr_iomap_next, xfs_xattr_iomap_begin);
+
 const struct iomap_ops xfs_xattr_iomap_ops = {
-	.iomap_begin		= xfs_xattr_iomap_begin,
+	.iomap_next		= xfs_xattr_iomap_next,
 };
 
 int
-- 
2.52.0

