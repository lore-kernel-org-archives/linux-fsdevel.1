Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794175959;
	b=Ys822UwjF/cEDUnls2xSHkBGm8jTGzTTJ8E2yeB2aWGCpW0kMD7xwo2oQWHuOdOLQxj/
	 XBFFLG5txeUkhLE0A8e4hxNh7LoM8k/K4MqAfdXJWWqzLq5GkbtyCInPDDTIETQZ6zDWZ
	 /FVPgmTwA9FEAwHyVymyTih2wQdahaaFTal6YCYLg/iTKjV/UX0ZVYXtcacPVKQ7Kj/K1
	 un5KV1sPa1BTfNUfUwg1173uZdITVXty6olL7jMdHPbXLxD9D2idmVElte52jN0/oZGxE
	 5UYOt8rptJkBIwFn+bXHMQEDYC/jVDiAFSa/avYq7NztIgPo6dq0Jo+S1VwDZFiK7PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794175959;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=b2QVcEh0btg1HMk0NwMa89lrKVc8kAcQU1mXuN1qs6U=;
	b=DHSjKLCZ5pxdQwj4ZSdjBIAvX0TJhowsZ2SEISUcR5XUYEpY1OWer2cJDrZN3nu3oyrW
	 UXSa8ELJD7M894Yx84depisqWaFaKCbbqV1maRqdUTXFIkhDGG2XD1G9UmX5gcqZm79Y8
	 b31RuHq2PRSshU0SEUdaT8IwLjC1De1GOT3dlm4IuGebIUQeeaK3NZCkEmaGoWdpJL6eX
	 DrfcvMadPmfsp2kfQ5T4AFQpHgC777B/+FDCEIRruYy+ru7tNCb7hP879FxTn2tfT3gsC
	 u69Z7lHi9wt7g9pqgjsUoRiZOTEMGLK+qAVD9tVePlti0n+R94cJmXO2c1KlXblURog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gx5Iof3G;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B37606A31C
	for <linux-fsdevel@vger.kernel.org>; Sun,  8 Nov 2026 22:12:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36B37606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gx5Iof3G
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36f6295304dso295326eec.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Nov 2026 14:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794175958; x=1794780758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b2QVcEh0btg1HMk0NwMa89lrKVc8kAcQU1mXuN1qs6U=;
        b=gx5Iof3G4f/7ojo0mKeDd2o4t3xVTRL0EDnxZwdgy5KRyszugobzD1ww5AjoFNhuqf
         FGg7xiegLMhiJHsJxurwL+dRk2g3wWgoDdHoV/i9rmI4oUDPEmE9iaeCLWKzxMoowb9m
         SpHVDzA+Kd0iqB4m7db8AMWURwCl9NEV7gG5ei3QkzWOSsvTNhnPjrYKyNnJcTDwH33W
         VF2lDzoFPKjN3bRHKdavz6Ipgmay+mdVM3I6uua9N9skSfhcEOLdM/pgcfkxT7S60Or9
         zbXkVaoQW4pSaSdMFXraX3jE7ujkbGKmW2D9VM2mki/fH7ksaTLhVkWGXdJ5JgfMMhSf
         pZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794175958; x=1794780758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b2QVcEh0btg1HMk0NwMa89lrKVc8kAcQU1mXuN1qs6U=;
        b=2UBMLXLGuhh1SzwQjB07zAsrRfL3HqifBIzjv6HgWs0Ho5wlr44aBKYjJAwRV5oBnn
         0/FQR/kmy+UqWDRzvOMhX2igXc6NxmSGyZkILRWv0/TFi9gMrFXoEs0CCTfM4ecPqUZH
         zCXvqAMnGY+nOK+IGZWsMHypmmIk/cpqKvrubFyBdi68CGYqvUstCddNfk72MG9D8i/Y
         IwvmIq9xDaA6gpHP90D54tGcciu+4PGxh4ho3s4OotSpeebzByLDcJduGY5cIPbGy/at
         BJgxsKEO2NrdR2i8cWJEatpduV5kYxMLqlokvlhBACdA9yJpBVqKX4VmGg3Bq8Qgpv8D
         ooKg==
X-Forwarded-Encrypted: i=1; AL+hErHA7Uznp6Gvr6AvsseGclnJHkC4dzHKjiQcaeMpeRSoJ14nSK9swlIBKBjN+9jaUHSHtQM3n0S6poXtK0j9@vger.kernel.org
X-Gm-Message-State: APuU4Z+lD4U4y6xJ79RmW/kCl5/G/ov3w4fD6+jMthFOS/O2zYkUbaLS
	zF3QA2SS7vp3Wk3jIPBvQ1FAKQH/OO6JE2any+c+WE41jh0iHhXlpmC7
X-Gm-Gg: AYBFou0Zc6wCKnf3B+/j2GyjxlyZE/hMBDQoiyUcyJpk0fj/7aJ70IWEm6H7Ut17Ggg
	VT32YpHRHdtgWaXsUYUkcvNyIhXe7/4JJVpC6Ya9IScRT/ggy7QT2ClfOPxUkNl2JiW/XHLMn7M
	o/lWN16u521I6VkApn9Gro0zwZGTVakKXyvadswLHTFtDBdIb+i9RHn/PMWOzcjVdeLzPK7vjnT
	NjfLzwQPAUxR7M5WW5gNmU39rGMyFweZn9/kUQRAhHKJ2JOnAGaPpgUxCuAEIreLqjQ/zkAtELJ
	mhU9qCUA4vNntMm4OfZBYE55Dbq1cYKV5WLkE1hDFaKVTPXKbOti7XULL4Co2UKjkxjBbZVUEiJ
	7m3g4JVzB0C06MofWNZMe4J3WY9Zkrf0q/6CBcYiUUS2ypeSVq7pbRW4gHUln/ZxFsNUC+x7UB/
	keJNXdsWaD+GNtAdlsDcVkcPvmCYNG/ahciC74idJJ/qtiCdCRlm8YyTz3wYAnyGrDF6HhKe2gb
	1fud78PiFvHfmYf31P3kcJVarzAW9RxXsL9dFV7SePX+bVwjNnPtHKWqolhCr8aNjzkf1pbV5PD
	Q4ObEdv26R2flxJe6+o30xbDzfb3ZIcNwhHbY8c2NcIKcUdi0Co2ESsp9RPS6ncfqw==
X-Received: by 2002:a05:7300:d10e:b0:36e:aa5c:7851 with SMTP id 5a478bee46e88-372570db210mr4300108eec.27.1794175957931;
        Sun, 08 Nov 2026 14:12:37 -0800 (PST)
Received: from anon-laptop ([103.187.196.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372667d78ebsm8097933eec.27.2026.11.08.14.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 14:12:37 -0800 (PST)
From: Wahid Khan <wahidzk0091@gmail.com>
To: linkinjeon@kernel.org
Cc: hyc.lee@gmail.com,
	ntfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v5] ntfs: convert a named $DATA stream safely when making room in a record
Date: Mon,  9 Nov 2026 03:42:27 +0530
Message-ID: <20261108221227.1083022-1-wahidzk0091@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <CAKYAXd9=crUmmGbO1vcPsdz-GmWoHxD_W_bRv2PQ_Db3Q+EkCQ@mail.gmail.com>
References: <CAKYAXd9=crUmmGbO1vcPsdz-GmWoHxD_W_bRv2PQ_Db3Q+EkCQ@mail.gmail.com>
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
  only tries to free space. The same inversion exists for the conversion
  of the attribute being resized, which waited for folio 0 with the lock
  held and hangs against an mmap fault or splice reader. Use FGP_NOWAIT
  there too. The resize then fails with -ENOSPC while such a reader is
  stuck on the lock, instead of hanging.

- A stream that is in the inode cache can be open, being written, being
  removed or already unlinked. A write that passed its residency check
  before the conversion carries on with a non-resident attribute, and
  a stream in the middle of ntfs_stream_finish_remove() is converted
  under its feet. Convert only a stream that is not cached.

- An attribute inode of a file that has no links left is evicted on the
  last iput() with its dirty folio, so what was converted is lost and
  an open file reads its extended attributes back as missing. Convert
  nothing, of any type, in a file that is being deleted or has no links
  left.

- The unnamed data is opened and converted through the file's own inode,
  whose i_rwsem only a resize of the unnamed data itself holds. When a
  stream or an extended attribute is being resized, a writer of the file
  can have passed its residency check and carry on with a non-resident
  attribute (iomap_iter warnings, recursive mrec_lock). Convert the
  unnamed data only when it is the attribute being resized.

- A WOF compressed file reads its WofCompressedData stream straight
  from the device, not through the page cache. A stream converted here
  is still dirty in the page cache, so the file reads stale clusters
  until writeback. Leave the streams of a WOF file alone.

- The lookup of a stream ignores case, so a stream whose name differs
  only in case from an earlier one resolves to that one and the length
  does not match again. Compare the names exactly.

Fixes: 495e90fa3348 ("ntfs: update attrib operations")
Cc: stable@vger.kernel.org # v7.1+
Signed-off-by: Wahid Khan <wahidzk0091@gmail.com>
---
v5: Sashiko's review of v4 found more, each reproduced with a forced make-room
    pass and a debug delay, fails before and passes after:
    - the WofCompressedData stream of a WOF file was converted, and the
      file read stale clusters until writeback (249 of 250 bytes wrong)
    - an attribute converted in a file with no links left was evicted
      with its dirty folio (open file reads its EA back as missing)
    - a resize of a stream converted the unnamed data under a writer of
      the file (iomap_iter WARNs, recursive mrec_lock)
    - the conversion of the resized attribute itself waited for folio 0
      with mrec_lock held (hung task against mmap fault and splice)
    The six v4 scenarios still pass.
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
 fs/ntfs/attrib.c | 82 ++++++++++++++++++++++++++++++++++++++++++------
 fs/ntfs/inode.c  | 19 +++++++++++
 fs/ntfs/inode.h  |  2 ++
 3 files changed, 93 insertions(+), 10 deletions(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index ce7c1b524180..5af7bf191295 100644
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
 
@@ -4895,8 +4910,14 @@ static int ntfs_resident_attr_resize(struct ntfs_inode *attr_ni, const s64 newsi
 	/* There is not enough space in the mft record to perform the resize. */
 
 	/* Make the attribute non-resident if possible. */
-	err = ntfs_attr_make_non_resident(attr_ni,
-			le32_to_cpu(ctx->attr->data.resident.value_length));
+	err = __ntfs_attr_make_non_resident(attr_ni,
+			le32_to_cpu(ctx->attr->data.resident.value_length), true);
+	/*
+	 * A reader holding folio 0 waits for mrec_lock, which we hold. Do not
+	 * wait for it, try to make room some other way.
+	 */
+	if (err == -EAGAIN)
+		err = -ENOSPC;
 	if (!err) {
 		mark_mft_record_dirty(ctx->ntfs_ino);
 		ntfs_attr_put_search_ctx(ctx);
@@ -4933,18 +4954,59 @@ static int ntfs_resident_attr_resize(struct ntfs_inode *attr_ni, const s64 newsi
 		if (a->type == AT_DATA && !value_len)
 			continue;
 
-		if (a->type == AT_DATA)
+		/*
+		 * The attribute inode of an unlinked file is evicted on the
+		 * last iput() together with its dirty folio.
+		 */
+		if (NInoBeingDeleted(base_ni) || !VFS_I(base_ni)->i_nlink)
+			continue;
+
+		if (a->type == AT_DATA && !a->name_length) {
+			/*
+			 * Only the caller that resizes it holds the i_rwsem of
+			 * the unnamed data, a writer of another attribute does
+			 * not.
+			 */
+			if (attr_ni != base_ni)
+				continue;
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
+			 * or in use. Its file must not be going away either,
+			 * and a WOF file reads its stream from the device, so
+			 * the stream must stay resident.
+			 */
+			if (a->type == AT_DATA) {
+				if (NInoWofCompressed(base_ni))
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

