Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AF03DDDA5
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2026 14:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778249340; cv=none; b=OUo5eQ6mEYo6xTmdK7MXHhXO8fQb36h+bsKcAkUVk4LtrTQmeeBQ8JnxUgXDfWiHqdmQ+2+RcHbg6oxLHLkWOZIGJh/ndwc5O4voZmUtMCHehc9u7jQ5GVcNDIK0yQyqyTuayaulNJZ4VzqyYsO66oTi6Gmm6NDoF1EHXmNw0MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778249340; c=relaxed/simple;
	bh=B1qtURAg64CeUD33eaN9KXrJzws29EGp5rTB25DKuJU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rJrleYrDjexc3bxmx5Vg2yEOdsxTymD8elzsIRUdcHRsrTnfwiOrYhwYN8fX0OA3jipyp/EqTpVYwBtXTemuQq+M5eyB0EdKG3r8DXlhJ7kW/KvFw6JF3rrTYqIEgSU6Ym4D1WeSzOq4o2xN/4PQHbTlCOGoxTlmPd5MoDxdy1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IynPcEmd; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IynPcEmd"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-365de41f8a1so185744a91.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 May 2026 07:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778249338; x=1778854138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RJFMD2yeb6bn0A7Z5XTSAJOsbkAMlMZA9xNkEC2wN/A=;
        b=IynPcEmd7bPU0o8t5nC06RnJmtQPYPmeU/d/6WFAG6+AwU9OzUrYcoJjJEF41ZsHba
         H/nQpPn2hClCuYCgq9TsZmLXn+e72gwRB6vQtPEqvsmPD3HkMnwtcCljg3KqfhGTgrZ/
         wFj6IMxUpEFTu7788s88x650pUqtNtu6n1ZRQfvtJATmx+31e20FU1viUp08fGoHG3Vx
         B11h6+Vd6LqTDAtP68pzptrK+YqgRiFHCzWTnqxx3x59HYSTlaMHs1sKQ2fgcBPxAz/e
         iOlruuOAsD9+Be4abOW95ncEopYxPwkSt6pUwIP1Nb5ITm2UUTu+EGkpZ0f2RV6x+xNd
         2nKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778249338; x=1778854138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJFMD2yeb6bn0A7Z5XTSAJOsbkAMlMZA9xNkEC2wN/A=;
        b=e6JDM/AQuecI8x6KVkGxakG+SSakhdrD75lKqBVfHJBB5eiaqAK1rtY0JzBy+gMRwZ
         k5JhdDBu8a/WBv8kk8cz2uFINNtiIneRIAqVf3WCnB7RBdBQmKJ9allnrFbaQgAXWbyI
         k3976OcQgu+OAoV/e0mm7xKYi2LIBsdpDY1dNo35Pf3juv6bZ91YTnz4XyTl/o45iekw
         mnDWfb4niSwwOWeSdbkGTpg6y2bqlPWQlis42PQwnEi7oGnP1t5VLSOiBGw5c75/Qpu2
         nBRCZL2VTDE3gtY52BNrOyCIn0bXQMCzOQIL35SVdN2Xqnhon/4iVBG+rYuT8kv+Inm1
         jdUQ==
X-Forwarded-Encrypted: i=1; AFNElJ8TTqZU7NCAWqxsW7pBV4IpkpkAg0Ye7oJny0APAlgtQPui08Yp3q4TZrr1IKn/yOGK/Xn4pDFqyQUDG7Su@vger.kernel.org
X-Gm-Message-State: AOJu0YyTpj6QguTV+fTYb61RKvpXk7BY2Ka8cSK7cnSZCnURhcbDNowv
	SEze3AGuFNy2DpQFpqwLlwiMdk97PpM2C645R4HECEDUMYoEBjbZMOFW
X-Gm-Gg: Acq92OF6MvjN4ZXuVKM6Ee0Dz7u8dQRfZwWpb1I6KEWBxLZS8UcIYyjW7svp/WZLvPU
	GXpEmHO4OGOFYXit94mPDm3PIUfEpBI/KeA5fvlIcIj2eB9m31bK0JkNDcCWE8XGURnbY5qe8Mu
	YZF9zf4A60WFicnve3HSxYlsL2axmWRZbzrapguDUS9eLLLRXEfxeZtGJU9xotGYidhQKsXCnhn
	nPLpIc5VSEHzkOPHa1RUuMIxHAXFP4DorlVgehEDR4KDJDYd4KV/qzL8haMH3a8P1GpuE1qMTHJ
	zDHwXnl4DQr04KasLs9f6qdfE+1DzWpMf88q2uQDaFSAj9npiejtKwItJ0cOW6m06/coPLb6bmQ
	7RooOlY64MFLXGLfci8hoQCM2CONkMT4fqcUmT+6s+S1hpgd4SHJKwGEFWGH52y7EZHdRB8L2rK
	nodl67yE6raJ8rWIp6q0UcrawRoqc=
X-Received: by 2002:a17:90b:264e:b0:35e:55fd:1bd0 with SMTP id 98e67ed59e1d1-365ad0eaae6mr6907441a91.1.1778249338015;
        Fri, 08 May 2026 07:08:58 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3664da73b90sm2536432a91.7.2026.05.08.07.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 07:08:57 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ntfs: validate the full MST update sequence array
Date: Fri,  8 May 2026 23:08:51 +0900
Message-ID: <20260508140851.2564669-1-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NTFS update sequence array contains the update sequence number
itself followed by one fixup entry for each protected sector.  The
current MST validation subtracts one from usa_count before checking
the array bounds, so it only accounts for the fixup entries and not
the leading update sequence number.

A malformed record can therefore pass validation with the last fixup
entry outside the record buffer.  post_read_mst_fixup() then reads past
the supplied buffer, while pre_write_mst_fixup() can write past it.
The USA also must end before the last word of the first 512-byte sector,
otherwise applying the fixups can overlap the sector trailer that the
array is supposed to protect.
This matches the documented NTFS MULTI_SECTOR_HEADER layout, where the
update sequence array is required to end before the last USHORT in the
first sector, and the sequence number stride is 512 bytes.

Validate the on-disk usa_count before converting it to a fixup count,
check the full USA size, and share this validation between the MST
helpers.  Pass the record size to post_write_mst_fixup() as well so
error paths do not restore data from a malformed update sequence array.

A small userspace ASAN reproducer with size=512, usa_ofs=510 and
usa_count=2 triggers a heap-buffer-overflow with the old validation.
With this change the same malformed record is rejected before the
fixup array is dereferenced.

Fixes: d3ad708fecaa ("ntfs: Initial commit")
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/ntfs/index.c |  3 ++-
 fs/ntfs/mst.c   | 68 ++++++++++++++++++++++++++++++++++++++---------------------------
 fs/ntfs/ntfs.h  |  2 +-
 3 files changed, 43 insertions(+), 30 deletions(-)

diff --git a/fs/ntfs/index.c b/fs/ntfs/index.c
index 413a1425d640..c2289550bc8f 100644
--- a/fs/ntfs/index.c
+++ b/fs/ntfs/index.c
@@ -178,7 +178,8 @@ int ntfs_icx_ib_sync_write(struct ntfs_index_context *icx)
 		icx->ib = NULL;
 		icx->ib_dirty = false;
 	} else {
-		post_write_mst_fixup((struct ntfs_record *)icx->ib);
+		post_write_mst_fixup((struct ntfs_record *)icx->ib,
+				icx->block_size);
 		icx->sync_write = false;
 	}
 
diff --git a/fs/ntfs/mst.c b/fs/ntfs/mst.c
index 7f9faad924ad..d1b9ed0703bd 100644
--- a/fs/ntfs/mst.c
+++ b/fs/ntfs/mst.c
@@ -9,6 +9,30 @@
 
 #include "ntfs.h"
 
+static bool mst_fixup_valid(const struct ntfs_record *b, const u32 size,
+		u16 *usa_ofs, u16 *fixup_count)
+{
+	u16 usa_count;
+	u32 usa_end;
+
+	if (!b)
+		return false;
+
+	*usa_ofs = le16_to_cpu(b->usa_ofs);
+	usa_count = le16_to_cpu(b->usa_count);
+
+	if (!size || (size & (NTFS_BLOCK_SIZE - 1)) || (*usa_ofs & 1) ||
+	    usa_count != (size >> NTFS_BLOCK_SIZE_BITS) + 1)
+		return false;
+
+	usa_end = *usa_ofs + usa_count * sizeof(__le16);
+	if (usa_end > size || usa_end > NTFS_BLOCK_SIZE - sizeof(__le16))
+		return false;
+
+	*fixup_count = usa_count - 1;
+	return true;
+}
+
 /*
  * post_read_mst_fixup - deprotect multi sector transfer protected data
  * @b:		pointer to the data to deprotect
@@ -28,18 +52,12 @@
  */
 int post_read_mst_fixup(struct ntfs_record *b, const u32 size)
 {
-	u16 usa_ofs, usa_count, usn;
+	u16 usa_ofs, usa_count, fixup_count, usn;
 	u16 *usa_pos, *data_pos;
 
-	/* Setup the variables. */
-	usa_ofs = le16_to_cpu(b->usa_ofs);
-	/* Decrement usa_count to get number of fixups. */
-	usa_count = le16_to_cpu(b->usa_count) - 1;
-	/* Size and alignment checks. */
-	if (size & (NTFS_BLOCK_SIZE - 1) || usa_ofs & 1	||
-	    usa_ofs + (usa_count * 2) > size ||
-	    (size >> NTFS_BLOCK_SIZE_BITS) != usa_count)
+	if (!mst_fixup_valid(b, size, &usa_ofs, &fixup_count))
 		return 0;
+	usa_count = fixup_count;
 	/* Position of usn in update sequence array. */
 	usa_pos = (u16 *)b + usa_ofs/sizeof(u16);
 	/*
@@ -75,8 +93,7 @@ int post_read_mst_fixup(struct ntfs_record *b, const u32 size)
 		}
 		data_pos += NTFS_BLOCK_SIZE / sizeof(u16);
 	}
-	/* Re-setup the variables. */
-	usa_count = le16_to_cpu(b->usa_count) - 1;
+	usa_count = fixup_count;
 	data_pos = (u16 *)b + NTFS_BLOCK_SIZE / sizeof(u16) - 1;
 	/* Fixup all sectors. */
 	while (usa_count--) {
@@ -115,21 +132,14 @@ int post_read_mst_fixup(struct ntfs_record *b, const u32 size)
 int pre_write_mst_fixup(struct ntfs_record *b, const u32 size)
 {
 	__le16 *usa_pos, *data_pos;
-	u16 usa_ofs, usa_count, usn;
+	u16 usa_ofs, fixup_count, usn;
 	__le16 le_usn;
 
 	/* Sanity check + only fixup if it makes sense. */
 	if (!b || ntfs_is_baad_record(b->magic) ||
 	    ntfs_is_hole_record(b->magic))
 		return -EINVAL;
-	/* Setup the variables. */
-	usa_ofs = le16_to_cpu(b->usa_ofs);
-	/* Decrement usa_count to get number of fixups. */
-	usa_count = le16_to_cpu(b->usa_count) - 1;
-	/* Size and alignment checks. */
-	if (size & (NTFS_BLOCK_SIZE - 1) || usa_ofs & 1	||
-	    usa_ofs + (usa_count * 2) > size ||
-	    (size >> NTFS_BLOCK_SIZE_BITS) != usa_count)
+	if (!mst_fixup_valid(b, size, &usa_ofs, &fixup_count))
 		return -EINVAL;
 	/* Position of usn in update sequence array. */
 	usa_pos = (__le16 *)((u8 *)b + usa_ofs);
@@ -145,7 +155,7 @@ int pre_write_mst_fixup(struct ntfs_record *b, const u32 size)
 	/* Position in data of first u16 that needs fixing up. */
 	data_pos = (__le16 *)b + NTFS_BLOCK_SIZE/sizeof(__le16) - 1;
 	/* Fixup all sectors. */
-	while (usa_count--) {
+	while (fixup_count--) {
 		/*
 		 * Increment the position in the usa and save the
 		 * original data from the data buffer into the usa.
@@ -162,17 +172,19 @@ int pre_write_mst_fixup(struct ntfs_record *b, const u32 size)
 /*
  * post_write_mst_fixup - fast deprotect multi sector transfer protected data
  * @b:		pointer to the data to deprotect
+ * @size:	size in bytes of @b
  *
- * Perform the necessary post write multi sector transfer fixup, not checking
- * for any errors, because we assume we have just used pre_write_mst_fixup(),
- * thus the data will be fine or we would never have gotten here.
+ * Perform the necessary post write multi sector transfer fixup. This is only
+ * expected after pre_write_mst_fixup() has applied fixups, but keep the bounds
+ * checks so error paths cannot restore from a malformed update sequence array.
  */
-void post_write_mst_fixup(struct ntfs_record *b)
+void post_write_mst_fixup(struct ntfs_record *b, const u32 size)
 {
 	__le16 *usa_pos, *data_pos;
+	u16 usa_ofs, fixup_count;
 
-	u16 usa_ofs = le16_to_cpu(b->usa_ofs);
-	u16 usa_count = le16_to_cpu(b->usa_count) - 1;
+	if (!mst_fixup_valid(b, size, &usa_ofs, &fixup_count))
+		return;
 
 	/* Position of usn in update sequence array. */
 	usa_pos = (__le16 *)b + usa_ofs/sizeof(__le16);
@@ -181,7 +193,7 @@ void post_write_mst_fixup(struct ntfs_record *b)
 	data_pos = (__le16 *)b + NTFS_BLOCK_SIZE/sizeof(__le16) - 1;
 
 	/* Fixup all sectors. */
-	while (usa_count--) {
+	while (fixup_count--) {
 		/*
 		 * Increment position in usa and restore original data from
 		 * the usa into the data buffer.
diff --git a/fs/ntfs/ntfs.h b/fs/ntfs/ntfs.h
index e301c68c780b..445101c06ef9 100644
--- a/fs/ntfs/ntfs.h
+++ b/fs/ntfs/ntfs.h
@@ -230,7 +230,7 @@ int ntfs_write_volume_label(struct ntfs_volume *vol, char *label);
 /* From fs/ntfs/mst.c */
 int post_read_mst_fixup(struct ntfs_record *b, const u32 size);
 int pre_write_mst_fixup(struct ntfs_record *b, const u32 size);
-void post_write_mst_fixup(struct ntfs_record *b);
+void post_write_mst_fixup(struct ntfs_record *b, const u32 size);
 
 /* From fs/ntfs/unistr.c */
 bool ntfs_are_names_equal(const __le16 *s1, size_t s1_len,
