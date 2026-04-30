Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46EE477992
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 17:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777569666; cv=none; b=fImDFw3DQ6G5Wv6hVYccvgJVD1hcHnSFl01uSmx9Atd+4LLt4Wb2uIUJ13u5kAiZ5hS6iQQpcpbhxwmQChCzFl9/nhG5Mi5auBK03ONAkd4ikwiWtThlP8++xz/qBV1rdDuvcFFpJB2UMv7CrllgAWRQxW13UMS3OJeXdgG9xY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777569666; c=relaxed/simple;
	bh=bhrIiFkqisYrNnLDHJt2WB+bQ8eTaLnEMB4CU7n8KPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OAWwpzXy4mrxzvmMouU2mV8GNeSA2c6uGXAT5os1Tm1ipaWf2m79Oy2NJkHhvX4JrGrsKc/NRWzzYLwfNdW8IAZ5VboWj1CLWUTjg3A4MHyK8xW3BY6YcJ54Vf91yrKc5zFf3pXvO456ZKVBDiBIoa43QPCf3wugHjcT5CbvYsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sl3pODq9; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sl3pODq9"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ae1255a90bso1578775ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 10:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777569663; x=1778174463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rkZuFsQKFtmCUkCnQjdOLllhL4V1PYXXSXU9jElRg0=;
        b=sl3pODq9mP2Ee2WVxhH3kPdRuQPydc5PKfZ6GaBSehwf0DVpOSdWLJiwgA67Dd/lgR
         R3J+32iSQOLAkKvYjRaNlWdXkHti3c+KLEcV04xmRHxphwXAGjOxzYFlC2e8G8Wdvtvk
         pAR9we3lixXLaOAdsMW25p50NqFIRTr6Qi3bzcmisdwKklLqFqDBlmurgZnaX3rFvM3P
         Dk9w3lZgRhN85iS56qLoPUMHWqkS8nfdzUsP2R8sTGd/gSvCo8KO0AE/123oP7ph//y5
         YY5ueB+YTY5tK78ExlSpxIcgw6BmNLdyJ21EntqXeR48SWaZCz0VOT++BuqJaQCFg21D
         UVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777569663; x=1778174463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0rkZuFsQKFtmCUkCnQjdOLllhL4V1PYXXSXU9jElRg0=;
        b=ZmXLT7BHmC33zqh4dskwrv8T1pKhPH4DO6+FzJgFywtnq+eiIaxab7Bw39sfZPWjvl
         1MuD7jKJx3HyqoFtDS+cpXq6/GZ7PINAa4UFdiKbIiuR1BEKzyU89fY3afl+uGOtCV/a
         QRK/3MYNo+AI0GWd3hlN0eXfbsrNv5z+tHLSJkQOEZ1ZZQQg+rk+LMfujzqQ4eVnFhHJ
         3YBZ8v2TXHzzC7+AFqOwu2GZIsWgQ9pI9OR4eWNlhYKxFZM2GpwE2Mz3YlnyCnRXflw3
         FLFGQIsvDUgynfD+ZGXbRJqrzz1rjcQzIMPmvii6AGSpbUbOiH591QakT8G8L8zp4Ptp
         ZKPg==
X-Forwarded-Encrypted: i=1; AFNElJ+8yTLZLdjJ47A+NyWL0mFsw+Na8VOv5IcrU5mhxtX6+0vgIQ+CW2e81Y2MECMuMgI6vXbbxvEqbl3wx6sx@vger.kernel.org
X-Gm-Message-State: AOJu0YxDNJg5IS5ClIW1Kb3VatbE6oPUUBn1InDh3O0+WHEIa23YFuGq
	AEsTS9ftJ6XPKvR9cvbJnuKrNC4IOYkhpufiBO6gcbYja9WT1WYi4E7Y
X-Gm-Gg: AeBDieskOlPPWNAoSbDOJEsZq/S5C4WaOBcNH7wLAFqjm2danplaxgSiLNUulf48Zu0
	zN4bK1qlq1OwSlH4k6EiWQUXGvmrSFZMWF2RKuiqlBbluL6yniuBFjRVX6wvU6YIn2uoZj64opZ
	DkwAKYLvOy+xEYPPp/OjgN0DwkTjVvdNDpJLDN5+7WxpGh6ImRxBf23ZGzg2kJteplAKN+Cr301
	vajL3c/tr8Wk0CoXR7a9+1/zCCrMYo/zUPLxTZLTwTWZWzVCG1LV/zXt3n81sG2hraR3l/UhoLk
	5yxCONHfqjAgathdRVtpcusnn9rCX/ouWOI/3qYVXO5iatlBcl7kXkuo1Ao0QP/rWVQ3Di1nV5Y
	wB+IV0h2ZhXGW/XwIYEplGMfz/oOBMQpij+xcJnLk18oRfsnJA75S5VmL4078wAi8FRToG+nq4T
	loXrjM722aRjpz5WJyW+amqkfaO+8=
X-Received: by 2002:a17:902:7c06:b0:2b9:5926:d057 with SMTP id d9443c01a7336-2b9a1d2c524mr15730205ad.0.1777569662739;
        Thu, 30 Apr 2026 10:21:02 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caa7e7besm2043795ad.12.2026.04.30.10.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 10:21:02 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH 1/3] ntfs: wait for sync mft writes to complete
Date: Fri,  1 May 2026 02:20:53 +0900
Message-ID: <afaac877edbd92ee82bb443ca35fd110f823a31d.1777568957.git.charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1777568957.git.charsyam@gmail.com>
References: <cover.1777568957.git.charsyam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_sync_mft_mirror() and write_mft_record_nolock() with @sync set
are both documented as synchronous, but neither actually waits for
the bio they submit nor inspects bi_status.  write_inode() can
return success while dirty mft record bytes are still in flight, and
bio errors are silently dropped: the volume is not marked with
errors and the inode is not redirtied.  This breaks fsync()/sync
metadata durability.

Switch ntfs_sync_mft_mirror() and the @sync path of
write_mft_record_nolock() to submit_bio_wait() and propagate the
returned error to the caller.  Capture ntfs_sync_mft_mirror()'s
return value at its call sites in write_mft_record_nolock() so a
mirror write failure surfaces too.

The @sync parameter only controls the main MFT bio.  The !@sync main
submission is therefore unchanged and still uses ntfs_bio_end_io() to
drop the folio reference taken before submission.  The mirror call
has always been documented as performing synchronous I/O regardless
of @sync, so making it actually block restores the originally
intended contract for both @sync and !@sync callers.

Note this only fixes the synchronous mirror/main paths reachable
from write_mft_record_nolock().  The main MFT write submitted from
ntfs_write_mft_block() (the .writepages path) still does not wait
for completion or check bi_status; that requires a larger
restructuring and is left to a follow-up patch.

Fixes: 115380f9a2f9 ("ntfs: update mft operations")
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/ntfs/mft.c | 63 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 22 deletions(-)

diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index 7d989267a82b..4051b4823162 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -449,7 +449,7 @@ static void ntfs_bio_end_io(struct bio *bio)
 int ntfs_sync_mft_mirror(struct ntfs_volume *vol, const u64 mft_no,
 		struct mft_record *m)
 {
-	u8 *kmirr = NULL;
+	u8 *kmirr;
 	struct folio *folio;
 	unsigned int folio_ofs, lcn_folio_off = 0;
 	int err = 0;
@@ -479,6 +479,7 @@ int ntfs_sync_mft_mirror(struct ntfs_volume *vol, const u64 mft_no,
 	kmirr = kmap_local_folio(folio, 0) + folio_ofs;
 	/* Copy the mst protected mft record to the mirror. */
 	memcpy(kmirr, m, vol->mft_record_size);
+	kunmap_local(kmirr);
 
 	if (vol->cluster_size_bits > PAGE_SHIFT) {
 		lcn_folio_off = folio->index << PAGE_SHIFT;
@@ -490,20 +491,22 @@ int ntfs_sync_mft_mirror(struct ntfs_volume *vol, const u64 mft_no,
 		NTFS_B_TO_SECTOR(vol, NTFS_CLU_TO_B(vol, vol->mftmirr_lcn) +
 				 lcn_folio_off + folio_ofs);
 
-	if (!bio_add_folio(bio, folio, vol->mft_record_size, folio_ofs)) {
+	if (bio_add_folio(bio, folio, vol->mft_record_size, folio_ofs))
+		err = submit_bio_wait(bio);
+	else
 		err = -EIO;
-		bio_put(bio);
-		goto unlock_folio;
-	}
+	bio_put(bio);
 
-	bio->bi_end_io = ntfs_bio_end_io;
-	submit_bio(bio);
-	/* Current state: all buffers are clean, unlocked, and uptodate. */
+	/*
+	 * The in-memory mirror is now valid because we just memcpy()'d the
+	 * mst-protected mft record into it.  Mark the folio uptodate even on
+	 * write error so a subsequent read_mapping_folio() does not refetch
+	 * the stale on-disk mirror and overwrite this copy.  The error is
+	 * propagated to the caller via @err.
+	 */
 	folio_mark_uptodate(folio);
 
-unlock_folio:
 	folio_unlock(folio);
-	kunmap_local(kmirr);
 	folio_put(folio);
 	if (likely(!err)) {
 		ntfs_debug("Done.");
@@ -588,20 +591,36 @@ int write_mft_record_nolock(struct ntfs_inode *ni, struct mft_record *m, int syn
 		}
 
 		/* Synchronize the mft mirror now if not @sync. */
-		if (!sync && ni->mft_no < vol->mftmirr_size)
-			ntfs_sync_mft_mirror(vol, ni->mft_no, fixup_m);
+		if (!sync && ni->mft_no < vol->mftmirr_size) {
+			int sub_err = ntfs_sync_mft_mirror(vol, ni->mft_no,
+							   fixup_m);
+			if (unlikely(sub_err) && !err)
+				err = sub_err;
+		}
 
-		folio_get(folio);
-		bio->bi_private = folio;
-		bio->bi_end_io = ntfs_bio_end_io;
-		submit_bio(bio);
+		if (sync) {
+			int sub_err = submit_bio_wait(bio);
+
+			bio_put(bio);
+			if (unlikely(sub_err) && !err)
+				err = sub_err;
+		} else {
+			folio_get(folio);
+			bio->bi_private = folio;
+			bio->bi_end_io = ntfs_bio_end_io;
+			submit_bio(bio);
+		}
 		offset += vol->cluster_size;
 		i++;
 	}
 
 	/* If @sync, now synchronize the mft mirror. */
-	if (sync && ni->mft_no < vol->mftmirr_size)
-		ntfs_sync_mft_mirror(vol, ni->mft_no, fixup_m);
+	if (sync && ni->mft_no < vol->mftmirr_size) {
+		int sub_err = ntfs_sync_mft_mirror(vol, ni->mft_no, fixup_m);
+
+		if (unlikely(sub_err) && !err)
+			err = sub_err;
+	}
 	kunmap_local(kaddr);
 	if (unlikely(err)) {
 		/* I/O error during writing.  This is really bad! */
@@ -617,10 +636,10 @@ int write_mft_record_nolock(struct ntfs_inode *ni, struct mft_record *m, int syn
 	bio_put(bio);
 err_out:
 	/*
-	 * Current state: all buffers are clean, unlocked, and uptodate.
-	 * The caller should mark the base inode as bad so that no more i/o
-	 * happens.  ->drop_inode() will still be invoked so all extent inodes
-	 * and other allocated memory will be freed.
+	 * The caller should mark the base inode as bad so no more I/O
+	 * happens. ->drop_inode() will still be invoked so all extent inodes
+	 * and other allocated memory will be freed. ENOMEM is retried by
+	 * redirtying the mft record below.
 	 */
 	if (err == -ENOMEM) {
 		ntfs_error(vol->sb,
-- 
2.43.0

