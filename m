Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794208212;
	b=NQFKZshgSQFYCPGj6PJtNIcpppzl8baY8vzXvfFRic+5RzgX5QXQ1hO3aBEX9RgjSjZf
	 fFQysIX9to4AqVczzDM+pOdQo/mhaaXP04tyS9VYtww6TkkbBvW5LXqXGDeCrFvKXV6bo
	 ZpHBi7jL/GXfL5x0KvnsXYPXW+ILrjF8lLPQ3Vlits0RDq5NpSymyLeueepdVZF05NziC
	 afiYyGK+vvCBLrzIZTVY9Dg/vE5tDtLPN+YHRqSNVdsLoQOeTwVRK215S/nWUT1fNavmP
	 k0sleQtXSzguJnkAELXpzXnLjYGn8CjTuVO9l5kosv9OHm0YXIdBN2+uLhfJebuDQSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794208212;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=pV09QwifzAwa1ef00lcbenE/8qBNihaigjYc1y00wBU=;
	b=PrVqQpi4tAMhwMakFfrLFCMFn73ULtgA3Nyt3WAB1+uE/erF7Ww5IMjYNKZ4T0J2KAnz
	 XNLAtKTunfzbujtxNMSLKVe0/++0hNaf78wmfY6bjBTaTEZVBGYGrmhgkLjH0ewwF9D6o
	 BalUog7OWs0exhSY7/XASnrOwz5tgkp0SgFAZTDoWSSd1puRCHzRIP+RHlZxF1Z5lyV7T
	 3euIaKKylteu6gzm3XAUgPOtFVzBxkJ/MV5MLmNBVgec6yFQ3tckXnolqkYFChbb1QDLy
	 Ym6HOtXEYkEDSGfHlyw8d2uUaXxrLqcZpMc/vdlg7VqO6p3jqhC+INSo3HMsVyz0kHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MGUao2Y0;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0749606A33E
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2026 07:10:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0749606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MGUao2Y0
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3282db206d3so1279160eec.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Nov 2026 23:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794208211; x=1794813011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pV09QwifzAwa1ef00lcbenE/8qBNihaigjYc1y00wBU=;
        b=MGUao2Y0Lbhh/TtXTt/9nJ0HBCr+WDbUh9YHq7g9ve+f8uUfV1iwrtsWjjNrv8cLMr
         0ftqhroSmZpWMPteKP6wvFem4aK+vNAdP9DDlVVRh1wWbs4EQyUdmlHweZ6m1ouYrGJ9
         Sy6Wfe3P6OzqORXB1fktYZsnIxwYMd2laGov0S/9OBS/A2anhUvjegNyF8UHrJY7Ts8m
         NGMWsDz56f39ryZ5fgAQ29h91ylUB7uFKVIWsqoQOQEiohrCs6w/S0rMcXTPOT7P/OfP
         WYJzKPFP/NOmHZMEEBuhpcAhqe6yjyLAlo7g4rWrS3dmMRWQEfov7YWpWjT+pplEdAIJ
         lXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794208211; x=1794813011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pV09QwifzAwa1ef00lcbenE/8qBNihaigjYc1y00wBU=;
        b=sN+iIxjH7RbO9BuEf0mzceN9+U6K/fjeNuUqPxeR4QERZeLG0B8wgqxj3pdIfwkb+V
         H6S1LrGl0+6xWRDpb4/zC4b6B+LbymjQ6VxV9Pj8OIwyBuptcAmTn45lZk2QwaS/D3qE
         WHzXdJYRuCo8gMcrocDc22uHZ+7VTvru7oo6ua9bZCP80+5PAQmllklR5PWWB1EzwtDl
         PTGBQbUpxCImWeDLWBDhwJ6Euwgtjz9sU7gHEwsuizYcJiqxNDOTXWRl95RqMCyrSkZI
         YAlvX/NHh4phd2oDjt6IwhJLNsHkFmF8LqkkKRNK8NnG2//4mn9Lkn8WcjdY3ocTtw0S
         g/vg==
X-Forwarded-Encrypted: i=1; AL+hErFuumn3Ercali3u1wwXUcgZET3LvpkbEFtZCbhQXeXtMbKcHxOV/UNxKoqAXeJeU3dqZaRlcXTI+OiXW9pG@vger.kernel.org
X-Gm-Message-State: APuU4Z/FHGijnj+88ddDleluJVU+33AuiLxHire9960OmxqLEgd1uTFD
	4pudi2bm0skotccm9e4gJ+SowvBtSFkG7hst1tDlpRKKrvDEihhX8lY1
X-Gm-Gg: AYBFou2EGaGbCjQE039gAXeD437a6YbINHxDFzXW7jBaPucm7tzb5K6mR2YTvA983uX
	mVBzZAs41fkUib4E28/sr4+QnCC5W2imlju+VrHcuTxUNHtec4f96X7rabYgQHjHxtCSIRX+04Y
	5Hsl5nQxzfd/ffGc5kqXr+29BicipR84POXsXBSDSCb/XDl6UJ4W936yk+zfiYaQHk+YEY7VLah
	XWxPnVdlRE5ROViBuzg6bgYPbulCidjC9boQTf1rlV3p3DQlrtqljTl6WzD6RazCff8fGbqQg/Y
	NlwkZgz/T2gSkDOsEVFKmrppf6eISGeCsr8SGB407OUv+1NA0JllYE7yprua87YNIStglmxl7hR
	kChRQ5CxI3awt0tC7kUOWG9ORyO6U1G8Bzuj04qoUUsSYPepjsFxvvs7L6HtMOGNJwGhfK6aM3H
	7WOyccZi3SMoOku8DraHXHtpsLHvVPBOWmdKBkdTa9zqH2X6FHveROO5Hff1l0tVwCWYtlxGSjr
	syMlIdiFkxWlHxotrT5Ruubf6IAUa08HKt1VsMVVFArnKF+h2tAmTpaQrKqG5TGDhrlxbNUjlHO
	bvIWCZJNlOzQR1AQ4wgtAVcxEE80c1ey1V31NgQ9n4F5w/BZcoaMnSt9Mp4reK4QgQqEF5JysO/
	77eR+VDpNLv0=
X-Received: by 2002:a05:7301:fc10:b0:372:7af9:b916 with SMTP id 5a478bee46e88-3727af9cc9fmr5425663eec.18.1794208210467;
        Sun, 08 Nov 2026 23:10:10 -0800 (PST)
Received: from anon-laptop ([103.187.196.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372632d7d62sm16641367eec.3.2026.11.08.23.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 23:10:09 -0800 (PST)
From: Wahid Khan <wahidzk0091@gmail.com>
To: linkinjeon@kernel.org
Cc: hyc.lee@gmail.com,
	ntfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v6] ntfs: convert a named $DATA stream safely when making room in a record
Date: Mon,  9 Nov 2026 12:37:04 +0530
Message-ID: <20261109070704.1430784-1-wahidzk0091@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261108221227.1083022-1-wahidzk0091@gmail.com>
References: <20261108221227.1083022-1-wahidzk0091@gmail.com>
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

- The unnamed data is converted through the file's own inode, whose
  i_rwsem only a resize of the unnamed data itself holds. When a stream
  or an extended attribute is being resized, a writer of the file can
  have passed its residency check and carry on with a non-resident
  attribute (iomap_iter warnings, recursive mrec_lock). When the
  unnamed data is the attribute being resized, its conversion was just
  tried by the caller. Do not convert the unnamed data from this loop.

- Do not convert the attribute that is being resized either. Its
  conversion was just tried and failed, for instance on a busy folio,
  and a second try that succeeds leaves the resize to go on with the
  resident layout of a record that is now non-resident.

- The lookup of a stream ignores case, so a stream whose name differs
  only in case from an earlier one resolves to that one and the length
  does not match again. Compare the names exactly.

Fixes: 495e90fa3348 ("ntfs: update attrib operations")
Cc: stable@vger.kernel.org # v7.1+
Signed-off-by: Wahid Khan <wahidzk0091@gmail.com>
---
v6: Sashiko's review of v5: when the conversion of the resized attribute
    returns -EAGAIN (busy folio) and is mapped to -ENOSPC, the loop could
    reach that attribute itself, convert it and resize its record as if it
    were resident. Reproduced with one forced -EAGAIN (the EA is lost, the
    resize fails with -EINVAL), fixed: the attribute being resized is never
    converted from the loop, and neither is the unnamed data (its branch
    was dead code once that is skipped).
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
 fs/ntfs/attrib.c | 90 ++++++++++++++++++++++++++++++++++++++++++------
 fs/ntfs/inode.c  | 19 ++++++++++
 fs/ntfs/inode.h  |  2 ++
 3 files changed, 101 insertions(+), 10 deletions(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index ce7c1b524180..f3dc0579bd5b 100644
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
@@ -4913,12 +4934,14 @@ static int ntfs_resident_attr_resize(struct ntfs_inode *attr_ni, const s64 newsi
 	while (!(err = ntfs_attr_lookup(AT_UNUSED, NULL, 0, 0, 0, NULL, 0, ctx))) {
 		struct inode *tvi;
 		struct attr_record *a;
+		__le16 *name;
 		u32 value_len;
 
 		a = ctx->attr;
 		if (a->non_resident || a->type == AT_ATTRIBUTE_LIST)
 			continue;
 		value_len = le32_to_cpu(a->data.resident.value_length);
+		name = (__le16 *)((u8 *)a + le16_to_cpu(a->name_offset));
 
 		if (ntfs_attr_can_be_non_resident(vol, a->type))
 			continue;
@@ -4933,18 +4956,65 @@ static int ntfs_resident_attr_resize(struct ntfs_inode *attr_ni, const s64 newsi
 		if (a->type == AT_DATA && !value_len)
 			continue;
 
-		if (a->type == AT_DATA)
-			tvi = ntfs_iget(sb, base_ni->mft_no);
-		else
-			tvi = ntfs_attr_iget(VFS_I(base_ni), a->type,
-				(__le16 *)((u8 *)a + le16_to_cpu(a->name_offset)),
+		/*
+		 * The attribute inode of an unlinked file is evicted on the
+		 * last iput() together with its dirty folio.
+		 */
+		if (NInoBeingDeleted(base_ni) || !VFS_I(base_ni)->i_nlink)
+			continue;
+
+		/*
+		 * Not the attribute being resized. Its conversion was tried
+		 * above and failed, for instance on a busy folio, and
+		 * converting it here would leave the resize to go on with the
+		 * resident layout of a non-resident record.
+		 */
+		if (a->type == attr_ni->type &&
+		    a->name_length == attr_ni->name_len &&
+		    (!a->name_length ||
+		     !memcmp(name, attr_ni->name,
+			     a->name_length * sizeof(__le16))))
+			continue;
+
+		/*
+		 * Not the unnamed data either. Only the resize of the unnamed
+		 * data itself holds its i_rwsem, a writer of the file can be
+		 * between its residency check and the mft record lock.
+		 */
+		if (a->type == AT_DATA && !a->name_length)
+			continue;
+
+		/*
+		 * A named $DATA stream is converted only if nobody has it open:
+		 * an open one can be unlinked, being removed or in use. A WOF
+		 * file reads its stream from the device, so the stream must
+		 * stay resident.
+		 */
+		if (a->type == AT_DATA) {
+			if (NInoWofCompressed(base_ni))
+				continue;
+			tvi = ntfs_attr_ilookup(VFS_I(base_ni), a->type,
+					name, a->name_length);
+			if (tvi) {
+				iput(tvi);
+				continue;
+			}
+		}
+		tvi = ntfs_attr_iget(VFS_I(base_ni), a->type, name,
 				a->name_length);
+		/* the lookup ignores case for streams, ours does not */
+		if (!IS_ERR(tvi) && a->type == AT_DATA &&
+		    memcmp(NTFS_I(tvi)->name, name,
+			   a->name_length * sizeof(__le16))) {
+			iput(tvi);
+			continue;
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

