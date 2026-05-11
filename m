Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B748532E137
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 16:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778515597; cv=none; b=mv4aAj0tj24Ib1w3lQlj3BWgZETLKDxRMuMCreWynBBRYJ8VbOaU0PTNqwBvCOM2cqrXmLFRZIrx8wk3GrDyKOOQE+VUYYC8+VKTie2kBiJuJdK4TC7T6d5QvO9vGehb0plzyJ4AjakY25ZURtekNPw/YF2QGcaQ/vaps2dzkvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778515597; c=relaxed/simple;
	bh=O7vxKwK4Frz7hw3ZsessBjAsAnJnPJnx/DkxIn7A+M4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JzHtLc/XoHD+91uWZ/G84zytH24GXmRXApZmeOvv+30jIoS/CJ/c1A8QpWH3PUdM7eYP7I/3AXkvkkQe+F7xjsaqMKfdXBsBcG5AZ5Ur1r1YINEmDZpc/Q0D1lm+v2McLogt7OsDEdGO02vwwm2BlsGKfjJOPGuPjZxXmq0F0mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cv5idmbU; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cv5idmbU"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-365f36d7b88so646649a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 09:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778515593; x=1779120393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGyckoWlKcj/g+dvE3DVtCFjUKqFutWWvhlGNP+u3/Y=;
        b=cv5idmbUvwwbsLar+rJ+v0orLgJTCjLfgcHPDdRDEFretshVL1lbVBejHNm3+Wt1Y2
         CJvjyrcWOTe+opE6bE4C0Q/OQeBpN4FMR6NZjGukEQtjB2ljJZVjePxX5DIdaYo+yNxc
         Gb09LpHs6SqRb1Ph2oeGqnNpnUwBxpqLLXObN0R23m+MwzgSDCP06vfO8WnPJM4y5cLq
         Qu3gBruJWTk+kVOQbxW2nGD/3YpwOOrDtljOnCUDccYfLV6prSJjCs5SYfvZqHSgVrT6
         Pn0TcDoDXi7fFYTvT+Lbhwof6NImX4eUPk6AnLZ6Ts0ICTYALm6lWbzVS+A+C43LtZDe
         ernA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778515593; x=1779120393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DGyckoWlKcj/g+dvE3DVtCFjUKqFutWWvhlGNP+u3/Y=;
        b=N+AWqM3JpllYGeIJ0HdTMVMl+Oom4dm/uGX6YdRCedeAIb+OUM54af0H9iFqO8xwGb
         Ge98WzkEDTyfY8NcB3RrACThouk1gY5QQrGCX0AC4k4bw5dK0ho+klG06XGxj4+wI/im
         Qsmbpz5ofwv/OAgeXCU3DwKrXvlFbBeslNfeGEFzWZkkWnpaUgKiYNh/FLVEwulMyQYF
         if8r22zqJDHtAD5oCKzA5JppEq+DoKU8wNGJmHg+y2cr5fePkZrZJM1PD9xAflVzwDI0
         Ms7UIBgh3/n2stMqC024ASyGbBzOXm4VRMwd5Sxp/e2H01UBjQoVdXBBP7eauOiR72qc
         RHtA==
X-Gm-Message-State: AOJu0YzYPiItSmoaWYsyoVa+gDZXrI3UiPwuVI7xp0rOBI+eKMhcH3Yx
	gWoLwxS0vHC6EB+evd9rkf80hhyAZNWrA+bUR055Y9ScsQ3+RGiDkQx7
X-Gm-Gg: Acq92OFdvEAXIiaFI1G1H3xnVCjTGqMvucl6SdPSav98DgUTq66/YaKU+XVcYGneECH
	l0PWKRXVR7T9v0t8tU2toj+rSpRzkH5XDDP1KDn2d36CBkG67Ty5m4HcTLYoodlZbmnC/ZP9rr1
	kzp8sS0JcxvnPG7oNYjZgNkRZAWl/O42I7tXIVbiylKb1iykcQed2V6rjWa/lg9rFdPM4mhcUx4
	sFZNhpxdHVxChVAInvMLr4liNYQUGqYMPFVMStFqpDkD3VvMXQv6MtsazDAumwmF4cHXcjkIu6k
	PBT2suunnfJFBm/4G/uHo0q0BWnxMnoFYPiRaPpCSqNNoBuTt11A6E8cTZwZzciyzxWxI1PT8u0
	6D2/hCQfssv0BpwhuN8qtG6uY4aPR+TiA4G5sRnNx1o/EdG+AA6EIRzleZelVm9my79LW1lt9XQ
	7Ie07IOiNWPXKPPIFo/U9ZT7/flmc=
X-Received: by 2002:a17:902:d2cb:b0:2b2:aa7b:b3bd with SMTP id d9443c01a7336-2ba7f425857mr135549775ad.6.1778515593031;
        Mon, 11 May 2026 09:06:33 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e35ebesm112447045ad.43.2026.05.11.09.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 09:06:32 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH 1/3] ntfs: return view index entry data from lookup
Date: Tue, 12 May 2026 01:06:23 +0900
Message-ID: <20260511160626.1268612-2-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511160626.1268612-1-charsyam@gmail.com>
References: <20260511160626.1268612-1-charsyam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_index_lookup() always exposes the matched entry key through
icx->data.  That is correct for file name indexes, where $I30 callers
expect the key to be a struct file_name_attr and update it in place.

NTFS view indexes store a separate value in index_entry.data.vi.  For
example, $Quota/$Q uses the owner_id as the key and stores the
quota_control_entry in the entry value.  Returning the key makes quota code
see only the 4-byte owner_id instead of the quota control entry.

Preserve the existing $FILE_NAME index behavior, but return the entry value
for view indexes.  Use the index root type for that layout decision:
indexes with ir->type == AT_FILE_NAME expose the entry key, while view
indexes have type 0 and expose the entry value through data.vi.  Validate
the value offset and length before exposing the pointer, and clear
icx->data when the key is not found because the context then describes an
insertion point rather than a matched value.  Use unsigned arithmetic for
the minimum data offset check, account for the VCN stored at the end of
INDEX_ENTRY_NODE entries, and clear the returned context pointers before
returning an entry-data validation error.

Move the matched-entry data exposure and validation into a small helper,
ntfs_index_lookup_set_data(), so the done label stays flat and the bounds
check has a single return.

Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/ntfs/index.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 fs/ntfs/index.h |  3 +-
 2 files changed, 73 insertions(+), 5 deletions(-)

diff --git a/fs/ntfs/index.c b/fs/ntfs/index.c
index a547bdc..30dfcbb 100644
--- a/fs/ntfs/index.c
+++ b/fs/ntfs/index.c
@@ -696,6 +696,53 @@ static int ntfs_icx_parent_dec(struct ntfs_index_context *icx)
 }

 /*
+ * ntfs_index_lookup_set_data - populate icx->data for the matched entry
+ *
+ * For directory $FILE_NAME indexes the caller updates the key in place, so
+ * expose the key.  For view indexes the value lives at data.vi; validate
+ * its offset and length before exposing the pointer.  Return 0 on success,
+ * or -EIO if the entry value is out of bounds.
+ */
+static int ntfs_index_lookup_set_data(struct ntfs_index_context *icx,
+				      struct index_root *ir,
+				      struct index_entry *ie)
+{
+	u16 data_len, data_off, entry_len, found_key_len;
+	unsigned int data_end, min_data_off;
+
+	if (ie->flags & INDEX_ENTRY_END)
+		return -EIO;
+
+	found_key_len = le16_to_cpu(ie->key_length);
+	if (ir->type == AT_FILE_NAME) {
+		icx->data = (u8 *)ie + offsetof(struct index_entry, key);
+		icx->data_len = found_key_len;
+		return 0;
+	}
+
+	entry_len = le16_to_cpu(ie->length);
+	data_off = le16_to_cpu(ie->data.vi.data_offset);
+	data_len = le16_to_cpu(ie->data.vi.data_length);
+	data_end = entry_len;
+	if (ie->flags & INDEX_ENTRY_NODE) {
+		/* The trailing child VCN is not part of the entry value. */
+		if (data_end < sizeof(s64))
+			return -EIO;
+		data_end -= sizeof(s64);
+	}
+
+	min_data_off = offsetof(struct index_entry, key) + found_key_len;
+	if (data_off < min_data_off || data_off > data_end)
+		return -EIO;
+	if (data_len > data_end - data_off)
+		return -EIO;
+
+	icx->data = (u8 *)ie + data_off;
+	icx->data_len = data_len;
+	return 0;
+}
+
+/*
  * ntfs_index_lookup - find a key in an index and return its index entry
  * @key:	key for which to search in the index
  * @key_len:	length of @key in bytes
@@ -710,7 +757,8 @@ static int ntfs_icx_parent_dec(struct ntfs_index_context *icx)
  * If the @key is found in the index, 0 is returned and @icx is setup to
  * describe the index entry containing the matching @key.  @icx->entry is the
  * index entry and @icx->data and @icx->data_len are the index entry data and
- * its length in bytes, respectively.
+ * its length in bytes, respectively.  For file name indexes @icx->data points
+ * to the entry key; for view indexes @icx->data points to the entry value.
  *
  * If the @key is not found in the index, -ENOENT is returned and
  * @icx is setup to describe the index entry whose key collates immediately
@@ -836,11 +884,30 @@ err_out:
 	return err;
 done:
 	icx->entry = ie;
-	icx->data = (u8 *)ie + offsetof(struct index_entry, key);
-	icx->data_len = le16_to_cpu(ie->key_length);
+	if (err) {
+		/* When the key is not found, ie is an insertion point. */
+		icx->data = NULL;
+		icx->data_len = 0;
+		ntfs_debug("Done.\n");
+		return err;
+	}
+	err = ntfs_index_lookup_set_data(icx, ir, ie);
+	if (err) {
+		ntfs_error(sb,
+			   "Index entry data out of bounds in inode 0x%llx.",
+			   (unsigned long long)ni->mft_no);
+		icx->entry = NULL;
+		icx->data = NULL;
+		icx->data_len = 0;
+		if (!icx->is_in_root) {
+			kvfree(ib);
+			ib = NULL;
+			icx->ib = NULL;
+		}
+		goto err_out;
+	}
 	ntfs_debug("Done.\n");
 	return err;
-
 }

 static struct index_block *ntfs_ib_alloc(s64 ib_vcn, u32 ib_size,
diff --git a/fs/ntfs/index.h b/fs/ntfs/index.h
index e68d6fa..4b8c5c8 100644
--- a/fs/ntfs/index.h
+++ b/fs/ntfs/index.h
@@ -58,7 +58,8 @@
  * To obtain a context call ntfs_index_ctx_get().
  *
  * We use this context to allow ntfs_index_lookup() to return the found index
  * @entry and its @data without having to allocate a buffer and copy the @entry
- * and/or its @data into it.
+ * and/or its @data into it.  For file name indexes @data points to the entry
+ * key; for view indexes @data points to the entry value.
  *
  * When finished with the @entry and its @data, call ntfs_index_ctx_put() to
  * free the context and other associated resources.
--
2.43.0
