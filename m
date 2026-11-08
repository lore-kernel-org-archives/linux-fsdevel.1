Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794125031;
	b=lXU50GKa7hBGv7uo8SCeUWmJAV3q/aJYv9w5uZYZRTh9bLXEOtcjgZHMTubnTcCRpGd4
	 ZPR4/sIOOCw/7JTIjbgCLpYelf8GUalNJDY7AwBKRg9QFmDKqMF/fqaIBTuKzKNBiKi9w
	 pJ0P8XI3dadVIeWR/ihf81s6JHKuSY8uvES6QlF4fj9gQ/DYQ+LAK60bej0EXZ3UiQYSl
	 sQNvBVrKD7KpaG4fxRlpU6RozvEp1qmywwHbL9ozfl+fUOW14UgoOBZiTipVAFmIiVhV4
	 2/KjIon6998kAhjzy3OEvjmcZrwJ+log69jzAtxeIut/codBGJVbpJ9o9FO1M8M1q+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794125031;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=JOX77fus2x/eG1WoZO3OzTindRAi1WdAyfHFy3V4a8g=;
	b=tVxNushH/Fa2VHGcAprn31ObJqeQoTjxs/LblOxu66IoOB4z8JUwLS6b+QH+q2aBBMHX
	 iFtstFeNNHUyS3aWjcIoBNFL1BdWmo3nppFQFbBOJKMb4H+a47r4J1kciHAzebxlsJ8SZ
	 EoffbtBzX3UxyA8C9l6dcd4M19yHmSUebnUPRkZ31jDiP5bl45nC36GXk9LUvcenAx4wV
	 sevDD8rnCSPWkL3rk4X3wzvZHEgfiBDz4vBbIx7jUaQ+sq/sqH20ssJrIQlRcZ3r92uMS
	 Bm9V6owUainf6KE6RwBK8UpF6+FS76IRPOB0Ono2Q2ZtCAG5Cy5MCQ4VgY5t4UqBa2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BF3Aubl4;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8C7606A321
	for <linux-fsdevel@vger.kernel.org>; Sun,  8 Nov 2026 08:03:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C8C7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BF3Aubl4
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1a2af4c8d00so438459c88.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Nov 2026 00:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794125029; x=1794729829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JOX77fus2x/eG1WoZO3OzTindRAi1WdAyfHFy3V4a8g=;
        b=BF3Aubl4v0ZUvg1OJvLO75TxuEO95rmneinKKX5J0RbJfN/Ff9dGx1miWCPrHpSLgn
         Nxtrf1xvhvtasGyQmYvJ+4K1HFeJVakAcsaf2YphGOKEdmIxyT1VjbJbAzXVPaNPPL4h
         izlqO/KA3+V3XZG+sZNMeH7eov/APDXg9Fyaol9YtOXtGqCQ4zR3fqtNgpXl3ScM/eJX
         q2JkcfPL1k3dRFxsk1x/EmrXaDA2tYLwqC3uhpbM79WUT4nZ2oe8mVZ3GZvCATD4Bv98
         Wcv5Aey9v/qAmtSdUtTaS5Ot2vLAw+Hf80sIccRHbcKQYuGVfhiueEAyuE8KkJRmj7D6
         27YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794125029; x=1794729829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JOX77fus2x/eG1WoZO3OzTindRAi1WdAyfHFy3V4a8g=;
        b=W59Pv2lrj/FVDaMMs4zK26FKOUcHy0oUTuqaf8MBQkSt1o73ENk7WJUMMbho9D4rWi
         YTCwR6pQGrQ/x9ai4OU3Dtj1H/Kvl6njEHvl2llD4f20MXtyKyMZaNeGN1ZAJLX8BKyA
         98AV7KfSeP6LhsxIyNRAWDkFuU1Qv7RfwGrwuGY3mHusFaZTiYth8OuMEiHeOf2i4J7i
         liAhPJLsnnWq26G65upsDl0EftNAaCS9r6KJd5fMaH6LpO2Q7oInhHDgkt1/JJOWyWz/
         RrnvnqlPG/LwWhxKxFQG5o+tQqGiFArX9N9TrBNDJhjWoCns1oyVvCzJZtlhn8Zw0538
         n5Lw==
X-Forwarded-Encrypted: i=1; AL+hErELHjGDocypg+RBmZ/nGfoEPk35PD2NVupHhhmD3D3ZuGJxVawkHyIeiDouEDSm09LupOP9HGAFYe1H22/T@vger.kernel.org
X-Gm-Message-State: APuU4Z/vfKM/XAZ5/Tvr4lDZp92+U01LxuKOv7uF9KADc0LPnMEgT4eX
	n/HQ/ae8MFQkwEhBvTxv5TcReTnsRXiJd+lzuew9FdWOVCF8QP5gLIm8
X-Gm-Gg: AYBFou18dDA1DEEwQuvpfM6qmtnvIbOSwC6oMCU2mGeidFB159DbL6CRvGcL3DxvdMQ
	l2VOn5zZRSi5dxLRbouoRBBJKSaE7bNXoNsiY6MUbhuXQebXeJk6qHv+T3LKopRUVLlMlpsILjT
	CzPAL2HCnpyZH+LiZMQ33a/XA/mPfKO72UxY+kp64YLqSqZ0l1cekHzRLKeKjcRHpZiBwaD/TSi
	zDeU6+I+mw9UeIJvwfTDfLtb5Pb9x8zqD3m2aoUEmVLMG4e+kO4iEKNT3muApSt0OGWK5O9q8Bt
	IyjIzuIWindsa7yZe8DGEf/vGPDwqzIzmQWbnqkz5px66NcKnBE7Ttqi1phpnH9QZ6ON4JgxSea
	BtxhrcoiJtmto3z4a2aJs3LRtr9HfGu8JnGAMMjVJlyERSTGiARsqX5akQJgW7JGKpGgvxevIql
	dvYpXAB9X3PLqIw7KeO95LWSMhPl0Afuz2LiRKawnmgXpKNdF3yk5JkTWH7JlREghKZDaOQsu3I
	iPhMgatUo7t2OqvzNT1g/BJTAeSZjBJuxty1l3eFBGlNeAnJB+yGTzxRP7MKcCfuowJP2WI3nRI
	4rotvbYUTGdQtxM3VxlR7GD9CsIOwWNCf2unt3qokQpMzLA5aANYCwSjrXp8XY1QtQ==
X-Received: by 2002:a05:701b:2616:b0:149:50cb:2175 with SMTP id a92af1059eb24-1b39fef4a85mr1364346c88.33.1794125029163;
        Sun, 08 Nov 2026 00:03:49 -0800 (PST)
Received: from anon-laptop ([103.187.196.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b375604109sm4681740c88.10.2026.11.08.00.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 00:03:48 -0800 (PST)
From: Wahid Khan <wahidzk0091@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	ntfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wahid Khan <wahidzk0091@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4] ntfs: convert a named $DATA stream safely when making room in a record
Date: Sun,  8 Nov 2026 13:33:23 +0530
Message-ID: <20261108080323.468892-1-wahidzk0091@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <CAKYAXd-68oCuAU=x0TV6BMsNJZkmBcdVZTtOQXh3iEm6BptJSg@mail.gmail.com>
References: <CAKYAXd-68oCuAU=x0TV6BMsNJZkmBcdVZTtOQXh3iEm6BptJSg@mail.gmail.com>
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

When an attribute has to grow and the mft record is full,
ntfs_resident_attr_resize() walks the other resident attributes and
converts them to non-resident ones. For $DATA it always opens the
unnamed data inode of the base inode, even if the attribute found is a
named stream:

  tvi = ntfs_iget(sb, base_ni->mft_no);
  ntfs_attr_make_non_resident(NTFS_I(tvi), value_len);

value_len is the length of the stream, so it does not match the
attribute that ntfs_attr_make_non_resident() looks up for the unnamed
inode, and the WARN_ON() on entry fires:

  WARNING: fs/ntfs/attrib.c:2115 at ntfs_attr_make_non_resident
   ntfs_resident_attr_resize
   ntfs_attr_expand_locked
   ntfs_expand_for_write
   ntfs_file_write_iter
   vfs_write

It does not need a damaged volume. A file with an alternate data stream
whose record has no room left is enough.

Open a named stream by name with ntfs_attr_iget(), as is done for the
other attribute types in this loop, and keep ntfs_iget() for the
unnamed one. The loop runs with the mft record lock held and takes no
lock of the stream inode, so converting a stream from here needs more
care than the plain lookup gives:

- A reader of the stream holds the folio lock and then takes the mft
  record lock in ntfs_read_iomap_begin_resident(), the conversion takes
  them the other way round and waits for folio 0. Take the folio with
  FGP_NOWAIT in this loop and skip the attribute if it is busy. The loop
  only tries to free space.

- A stream that is in the inode cache can be open, being written, being
  removed or already unlinked. A write that passed its residency check
  before the conversion carries on with a non-resident attribute, and
  a stream in the middle of ntfs_stream_finish_remove() is converted
  under its feet. Convert only a stream that is not cached, and none of
  a file that is being deleted or has no links left.

- The lookup of a stream ignores case, so a stream whose name differs
  only in case from an earlier one resolves to that one and the length
  does not match again. Compare the names exactly.

Fixes: 495e90fa3348 ("ntfs: update attrib operations")
Cc: stable@vger.kernel.org # v7.1+
Signed-off-by: Wahid Khan <wahidzk0091@gmail.com>
---
v4: v3 (convert a named stream via ntfs_attr_iget()) can deadlock against
    a reader of the stream and has other races with an open or removed
    stream. Each is reproduced with a forced make-room pass and a debug
    delay, fails on v3 and passes here: reader/converter deadlock
    (hung task), write continuing on a converted attribute (iomap_iter
    WARNINGs, recursive locking), unlinked file with an open stream (mft
    record reported corrupt), stream converted during its own removal,
    and a stream pair that differs only in case (WARN in
    ntfs_attr_make_non_resident).
v3: use ntfs_attr_iget() for a named stream instead of skipping it (v2).

 fs/ntfs/attrib.c | 57 +++++++++++++++++++++++++++++++++++++++++-------
 fs/ntfs/inode.c  | 19 ++++++++++++++++
 fs/ntfs/inode.h  |  2 ++
 3 files changed, 70 insertions(+), 8 deletions(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index ce7c1b524180..c824bd3ea9fa 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -1975,7 +1975,21 @@ int ntfs_resident_attr_value_resize(struct mft_record *m, struct attr_record *a,
  * inode i_size is that this is not necessarily uptodate.  This happens when
  * ntfs_attr_make_non_resident() is called in the ->truncate call path(s).
  */
+static int __ntfs_attr_make_non_resident(struct ntfs_inode *ni, const u32 data_size,
+		bool nowait);
+
 int ntfs_attr_make_non_resident(struct ntfs_inode *ni, const u32 data_size)
+{
+	return __ntfs_attr_make_non_resident(ni, data_size, false);
+}
+
+/*
+ * With @nowait the folio lock is only tried: a caller that holds mrec_lock
+ * must not wait for a folio lock, the read path takes them the other way
+ * round. Fails with -EAGAIN if the folio is locked.
+ */
+static int __ntfs_attr_make_non_resident(struct ntfs_inode *ni, const u32 data_size,
+		bool nowait)
 {
 	s64 new_size;
 	struct inode *vi = VFS_I(ni);
@@ -2056,10 +2070,11 @@ int ntfs_attr_make_non_resident(struct ntfs_inode *ni, const u32 data_size)
 		 * outside all ntfs locks, we need to get the folio now.
 		 */
 		folio = __filemap_get_folio(vi->i_mapping, 0,
-					    FGP_CREAT | FGP_LOCK,
+					    FGP_CREAT | FGP_LOCK |
+					    (nowait ? FGP_NOWAIT : 0),
 					    mapping_gfp_mask(vi->i_mapping));
 		if (IS_ERR(folio)) {
-			err = -ENOMEM;
+			err = nowait ? -EAGAIN : -ENOMEM;
 			goto err_out;
 		}
 
@@ -4933,18 +4948,44 @@ static int ntfs_resident_attr_resize(struct ntfs_inode *attr_ni, const s64 newsi
 		if (a->type == AT_DATA && !value_len)
 			continue;
 
-		if (a->type == AT_DATA)
+		if (a->type == AT_DATA && !a->name_length) {
 			tvi = ntfs_iget(sb, base_ni->mft_no);
-		else
-			tvi = ntfs_attr_iget(VFS_I(base_ni), a->type,
-				(__le16 *)((u8 *)a + le16_to_cpu(a->name_offset)),
-				a->name_length);
+		} else {
+			__le16 *name = (__le16 *)((u8 *)a +
+					le16_to_cpu(a->name_offset));
+
+			/*
+			 * A named $DATA stream is converted only if nobody has
+			 * it open: an open one can be unlinked, being removed
+			 * or in use. Its file must not be going away either.
+			 */
+			if (a->type == AT_DATA) {
+				if (NInoBeingDeleted(base_ni) ||
+				    !VFS_I(base_ni)->i_nlink)
+					continue;
+				tvi = ntfs_attr_ilookup(VFS_I(base_ni), a->type,
+						name, a->name_length);
+				if (tvi) {
+					iput(tvi);
+					continue;
+				}
+			}
+			tvi = ntfs_attr_iget(VFS_I(base_ni), a->type, name,
+					a->name_length);
+			/* the lookup ignores case for streams, ours does not */
+			if (!IS_ERR(tvi) && a->type == AT_DATA &&
+			    memcmp(NTFS_I(tvi)->name, name,
+				   a->name_length * sizeof(__le16))) {
+				iput(tvi);
+				continue;
+			}
+		}
 		if (IS_ERR(tvi)) {
 			ntfs_error(sb, "Couldn't open attribute");
 			continue;
 		}
 
-		if (ntfs_attr_make_non_resident(NTFS_I(tvi), value_len)) {
+		if (__ntfs_attr_make_non_resident(NTFS_I(tvi), value_len, true)) {
 			iput(tvi);
 			continue;
 		}
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 62dd5bd5bb81..ec9c7b219192 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -287,6 +287,25 @@ struct inode *ntfs_attr_iget(struct inode *base_vi, __le32 type,
 	return vi;
 }
 
+/*
+ * ntfs_attr_ilookup - find an attribute inode that is already in the cache
+ *
+ * Like ntfs_attr_iget() but never reads anything. Returns the inode with an
+ * increased reference count, or NULL if it is not cached.
+ */
+struct inode *ntfs_attr_ilookup(struct inode *base_vi, __le32 type,
+		__le16 *name, u32 name_len)
+{
+	struct ntfs_attr na = {
+		.mft_no = base_vi->i_ino,
+		.type = type,
+		.name = name,
+		.name_len = name_len,
+	};
+
+	return ilookup5(base_vi->i_sb, na.mft_no, ntfs_test_inode, &na);
+}
+
 /*
  * ntfs_index_iget - obtain a struct inode corresponding to an index
  * @base_vi:	vfs base inode containing the index related attributes
diff --git a/fs/ntfs/inode.h b/fs/ntfs/inode.h
index a18cbcf1c631..7ea52c59c04b 100644
--- a/fs/ntfs/inode.h
+++ b/fs/ntfs/inode.h
@@ -326,6 +326,8 @@ struct ntfs_attr {
 int ntfs_test_inode(struct inode *vi, void *data);
 int ntfs_test_inode_rcu(struct inode *vi, void *data);
 struct inode *ntfs_iget(struct super_block *sb, u64 mft_no);
+struct inode *ntfs_attr_ilookup(struct inode *base_vi, __le32 type,
+		__le16 *name, u32 name_len);
 struct inode *ntfs_attr_iget(struct inode *base_vi, __le32 type,
 		__le16 *name, u32 name_len);
 struct inode *ntfs_index_iget(struct inode *base_vi, __le16 *name,
-- 
2.56.0

