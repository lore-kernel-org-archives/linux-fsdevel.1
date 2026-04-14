Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF123D34A5
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 10:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776161266; cv=none; b=Ja28woW5nhgl4MYBvY5zv/aPop0MGQ6cqqXfVNP5yeaHYzTuZeRwEQgDBTKSRtp09Oa4KCkAkd+gXqk9yJ/A4aOg+SAe1PiFyq2LRlh5grblzVRvo6aVtVz/UPYYq+kJzTuK/LbJ+unK7ODIbkhEtlBfssXXl6a7qKnMBRboxHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776161266; c=relaxed/simple;
	bh=xNYDjPn+AycQplZ9xOLGYmQqtfwFksBMI0lDSNikyYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QRHWcI9kTZ2TMTiDB+gOG3rqaVSV/4C2YrQ/1+NEldHNKQ1IhqE/WMCVK0RIlWOXeultz7WH2EW6B4Zx2a4w1c9WHtb+cfEtIxdrEyHYMQE13I0vILu6lft5sWE17Hgol99W+u9YMgCWmMQG95EefVvltV2Zybo5vRcj5/DSuPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4889d0a9df0so6619715e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 03:07:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776161262; x=1776766062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NcPs4nyUwKMtO0DM4U0v6bFXd0AmFFKWA58Kzo3r5rM=;
        b=sv0tONJxPhgLlLyOMZmFioBn1NCLzcsHXfXarwGzm3fdqVQA2BL3JEbZL6yESrV53V
         o9YjYr13W3C1ROwQmzrYjeNjKKB2J7ggkxD+DKf+msO6VlXiyO/HQR+3I1Dusspe5Tl9
         YLm+BauTMofh5DhsD3U5QQS3bOD+5OpIi19m+XcFapS/Yn/CGmy0WWBZe8+nLKyA9NaD
         vQ544xdHOfOWPJjBZRHINVJP3CKvWsBqeBA0fxMc9VJB2mTTNed5Ypnncs0e4Nhyhjws
         akORluNvCucCEFyjmu7ankoYRA5XKxEUfCI4094CLm2hg5Cs5td1/CaBwOr/3U3UsYBj
         eoUA==
X-Gm-Message-State: AOJu0Yy4HcruBgvKiiiuNXNEySPDFbcIalZSi3pTzbMmI00q+fdQpHSK
	Jpu20qLiLaUnOg9FDIS60Eqhy1m4RUM5JbH7ij/ovysNAyzyh4NQN3hHEt3ndmdp
X-Gm-Gg: AeBDievKne7TaLJ5/UHulrKec+aDN0SMDrgz2CEm+0FiE3CU6CeciCmH5yozN0Xxxd+
	YwSW2RwcYxC0Ye20JR6Ia/YSMdkdT22ZSD1wenqYy/yXN0WcGooBQFS/+GmHMYUwxZnFtW5t0Nb
	Y2r6kwt9VHQqey7Gev2AR9YvqnuHUzjlikWRedv4zJKjIyLgaSUGNAwR4eqHZKCgG2jEs8mvm05
	38HUzIOBPkWGeFGCzRcna4HnuV1ax2gcgre2iV8+15J8V8OMR0TYN86fxu9Hq2uyz+tPAwsrIIr
	xlH4zkDQK6QqNHj/ze0ueyU/d9dOL8tr0taoSTGTk1hbkwHQna8kgYipZxeZkwrUO4s8IYAWf32
	sdsR2vZ09jF1IgCc1PcgbnwCM4AnKtyPHeV7XnprT4H8YxaSeY/RCJOXH+0sDW9WO73N5n+OnI1
	BzDeKL+9KU/Mg5j32pOAYedimvy3ABJTwjOCqX8QCHVQjPO+eumkeVt3uPT8qmJB23whOp8wVDS
	vU=
X-Received: by 2002:a05:600c:190d:b0:488:b7ec:a9ba with SMTP id 5b1f17b1804b1-488d6abebf8mr115314995e9.7.1776161261797;
        Tue, 14 Apr 2026 03:07:41 -0700 (PDT)
Received: from spartian-1.home ([2a01:cb1c:784:2f00:708:2805:7128:7a75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede1e050sm65870545e9.5.2026.04.14.03.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 03:07:41 -0700 (PDT)
From: Aurelien DESBRIERES <aurelien@hackers.camp>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	willy@infradead.org,
	djwong@kernel.org,
	adilger.kernel@dilger.ca,
	pedro.falcato@gmail.com,
	xiang@kernel.org,
	Aurelien DESBRIERES <aurelien@hackers.camp>
Subject: [PATCH v3 12/12] =?UTF-8?q?ftrfs:=20v3=20=E2=80=94=20iomap=20IO?= =?UTF-8?q?=20path,=20rename,=20RS=20decoder,=20Radiation=20Event=20Journa?= =?UTF-8?q?l?=
Date: Tue, 14 Apr 2026 14:07:25 +0200
Message-ID: <20260414120726.5713-13-aurelien@hackers.camp>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260414120726.5713-1-aurelien@hackers.camp>
References: <20260413230601.525400-1-aurelien@hackers.camp>
 <20260414120726.5713-1-aurelien@hackers.camp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This commit brings FTRFS to v3, addressing all major feedback from the
RFC v2 review on linux-fsdevel (April 14, 2026).

Changes since v2 (ce07d54dc):

fs/ftrfs/file.c:
  - Replace buffer_head IO path with iomap API (Matthew Wilcox review)
  - Implement ftrfs_iomap_begin/end (iomap_ops)
  - Implement ftrfs_iomap_write_ops (get_folio/put_folio)
  - Implement ftrfs_writeback_ops (writeback_range/writeback_submit)
  - Read path uses iomap_bio_read_ops + iomap_read_folio_ctx
  - Remove <linux/buffer_head.h> and <linux/mpage.h> from file.c

fs/ftrfs/namei.c:
  - Implement ftrfs_rename: same-dir and cross-dir rename for files
    and directories, '..' update, nlink fixup
  - RENAME_EXCHANGE and RENAME_WHITEOUT return -EINVAL (v1)
  - Add .rename to ftrfs_dir_inode_operations

fs/ftrfs/edac.c:
  - Implement full RS(255,239) decoder
  - Berlekamp-Massey error locator polynomial
  - Chien search for error positions
  - Forney algorithm for in-place magnitude correction
  - Corrects up to 8 symbol errors per 255-byte subblock
  - Returns -EBADMSG if uncorrectable (> 8 errors)

fs/ftrfs/super.c:
  - Add ftrfs_log_rs_event(): persistent radiation event logging
  - Ring buffer of 64 x 24 bytes in superblock reserved area
  - Written under spinlock, marks superblock buffer dirty

fs/ftrfs/ftrfs.h:
  - Add struct ftrfs_rs_event (24 bytes, __packed)
  - Add FTRFS_RS_JOURNAL_SIZE = 64
  - Replace 3980-byte s_pad with s_rs_journal[64] + s_pad[2443]
  - sizeof(ftrfs_super_block) == 4096 enforced by BUILD_BUG_ON
  - Add ftrfs_log_rs_event() prototype
  - inode_state_read_once compat macro for kernel < 7.0

Testing:
  - qemuarm64, kernel 7.0 final (Yocto Styhead 5.1)
  - mount, write, read, rename, umount: 0 BUG/WARN/Oops
  - xfstests generic/001, 002, 010 equivalent: all pass
  - Slurm 25.11.4 HPC cluster: 3-node parallel jobs validated

Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Aurelien DESBRIERES <aurelien@hackers.camp>
---
 fs/ftrfs/edac.c  | 197 ++++++++++++++++++++++++++++++++++++++++++++++-
 fs/ftrfs/file.c  | 173 ++++++++++++++++++++++++++++++-----------
 fs/ftrfs/ftrfs.h |  20 ++++-
 fs/ftrfs/namei.c | 113 +++++++++++++++++++++++++++
 fs/ftrfs/super.c |  41 ++++++++++
 5 files changed, 498 insertions(+), 46 deletions(-)

diff --git a/fs/ftrfs/edac.c b/fs/ftrfs/edac.c
index ebe676c98be6..8cc449363037 100644
--- a/fs/ftrfs/edac.c
+++ b/fs/ftrfs/edac.c
@@ -60,13 +60,206 @@ int ftrfs_rs_encode(uint8_t *data, uint8_t *parity)
 	return 0;
 }
 
-/* Reed-Solomon decoding (simplified for now) */
+/* Galois Field power */
+static uint8_t gf_pow(uint8_t x, int power)
+{
+	return gf_exp[(gf_log[x] * power) % 255];
+}
+
+/* Galois Field inverse */
+static uint8_t gf_inv(uint8_t x)
+{
+	return gf_exp[255 - gf_log[x]];
+}
+
+/*
+ * Compute RS syndromes.
+ * Returns true if all syndromes zero (no error).
+ */
+static bool rs_calc_syndromes(uint8_t *msg, int msglen, uint8_t *syndromes)
+{
+	bool all_zero = true;
+	int i, j;
+
+	for (i = 0; i < FTRFS_RS_PARITY; i++) {
+		syndromes[i] = 0;
+		for (j = 0; j < msglen; j++)
+			syndromes[i] ^= gf_mul(msg[j], gf_pow(gf_exp[1], i * j));
+		if (syndromes[i])
+			all_zero = false;
+	}
+	return all_zero;
+}
+
+/*
+ * Berlekamp-Massey — find error locator polynomial.
+ * Returns number of errors, or -1 if uncorrectable.
+ */
+static int rs_berlekamp_massey(uint8_t *syndromes, uint8_t *err_loc,
+			       int *err_loc_len)
+{
+	uint8_t old_loc[FTRFS_RS_PARITY + 1];
+	uint8_t tmp[FTRFS_RS_PARITY + 1];
+	uint8_t new_loc[FTRFS_RS_PARITY + 1];
+	int old_len = 1;
+	int i, j, nerr, new_len;
+	uint8_t delta;
+
+	err_loc[0] = 1;
+	*err_loc_len = 1;
+	old_loc[0] = 1;
+
+	for (i = 0; i < FTRFS_RS_PARITY; i++) {
+		delta = syndromes[i];
+		for (j = 1; j < *err_loc_len; j++)
+			delta ^= gf_mul(err_loc[j], syndromes[i - j]);
+
+		tmp[0] = 0;
+		memcpy(tmp + 1, old_loc, old_len);
+
+		if (delta == 0) {
+			old_len++;
+		} else if (2 * (*err_loc_len - 1) <= i) {
+			new_len = old_len + 1;
+			for (j = 0; j < new_len; j++) {
+				new_loc[j] = (j < *err_loc_len) ? err_loc[j] : 0;
+				new_loc[j] ^= gf_mul(delta, tmp[j]);
+			}
+			memcpy(old_loc, err_loc, *err_loc_len);
+			old_len = *err_loc_len + 1 - new_len + old_len;
+			memcpy(err_loc, new_loc, new_len);
+			*err_loc_len = new_len;
+		} else {
+			for (j = 0; j < *err_loc_len; j++)
+				err_loc[j] ^= gf_mul(delta, tmp[j]);
+			old_len++;
+		}
+	}
+
+	nerr = *err_loc_len - 1;
+	if (nerr > FTRFS_RS_PARITY / 2)
+		return -1;
+	return nerr;
+}
+
+/*
+ * Chien search — find roots of error locator polynomial.
+ * Returns number of roots found.
+ */
+static int rs_chien_search(uint8_t *err_loc, int err_loc_len,
+			   int msglen, int *errs)
+{
+	int nerrs = 0;
+	int i, j;
+	uint8_t val;
+
+	for (i = 0; i < msglen; i++) {
+		val = 0;
+		for (j = 0; j < err_loc_len; j++)
+			val ^= gf_mul(err_loc[j], gf_pow(gf_exp[1], i * j));
+		if (val == 0)
+			errs[nerrs++] = msglen - 1 - i;
+	}
+	return nerrs;
+}
+
+/*
+ * Forney algorithm — compute and apply error corrections.
+ */
+static void rs_forney(uint8_t *msg, uint8_t *syndromes,
+		      uint8_t *err_loc, int err_loc_len,
+		      int *errs, int nerrs)
+{
+	uint8_t omega[FTRFS_RS_PARITY];
+	uint8_t err_loc_prime[FTRFS_RS_PARITY];
+	int i, j;
+
+	memset(omega, 0, sizeof(omega));
+	for (i = 0; i < FTRFS_RS_PARITY; i++) {
+		for (j = 0; j < err_loc_len && j <= i; j++)
+			omega[i] ^= gf_mul(syndromes[i - j], err_loc[j]);
+	}
+
+	memset(err_loc_prime, 0, sizeof(err_loc_prime));
+	for (i = 1; i < err_loc_len; i += 2)
+		err_loc_prime[i - 1] = err_loc[i];
+
+	for (i = 0; i < nerrs; i++) {
+		uint8_t xi     = gf_pow(gf_exp[1], errs[i]);
+		uint8_t xi_inv = gf_inv(xi);
+		uint8_t omega_val = 0;
+		uint8_t elp_val   = 0;
+
+		for (j = FTRFS_RS_PARITY - 1; j >= 0; j--)
+			omega_val = gf_mul(omega_val, xi_inv) ^ omega[j];
+
+		for (j = (err_loc_len - 1) & ~1; j >= 0; j -= 2)
+			elp_val = gf_mul(elp_val, gf_mul(xi_inv, xi_inv))
+				  ^ err_loc_prime[j];
+
+		if (elp_val == 0)
+			continue;
+
+		msg[errs[i]] ^= gf_mul(gf_mul(xi, omega_val), gf_inv(elp_val));
+	}
+}
+
+/*
+ * ftrfs_rs_decode - decode and correct a RS(255,239) codeword in place.
+ * @data:   FTRFS_SUBBLOCK_DATA bytes of data (corrected in place)
+ * @parity: FTRFS_RS_PARITY bytes of parity
+ *
+ * Returns 0 if no errors or errors corrected,
+ * -EBADMSG if uncorrectable (> 8 symbol errors).
+ */
 int ftrfs_rs_decode(uint8_t *data, uint8_t *parity)
 {
+	uint8_t msg[FTRFS_SUBBLOCK_DATA + FTRFS_RS_PARITY];
+	uint8_t syndromes[FTRFS_RS_PARITY];
+	uint8_t err_loc[FTRFS_RS_PARITY + 1];
+	int err_loc_len;
+	int errs[FTRFS_RS_PARITY / 2];
+	int nerrs, nroots;
+
 	if (!rs_initialized)
 		init_gf_tables();
 
-	/* For now, assume no errors (full decoding to be implemented) */
+	memcpy(msg, data, FTRFS_SUBBLOCK_DATA);
+	memcpy(msg + FTRFS_SUBBLOCK_DATA, parity, FTRFS_RS_PARITY);
+
+	/* Step 1: syndromes */
+	if (rs_calc_syndromes(msg, FTRFS_SUBBLOCK_DATA + FTRFS_RS_PARITY,
+			      syndromes))
+		return 0; /* no errors */
+
+	/* Step 2: Berlekamp-Massey */
+	memset(err_loc, 0, sizeof(err_loc));
+	nerrs = rs_berlekamp_massey(syndromes, err_loc, &err_loc_len);
+	if (nerrs < 0) {
+		pr_err_ratelimited("ftrfs: RS block uncorrectable\n");
+		return -EBADMSG;
+	}
+
+	/* Step 3: Chien search */
+	nroots = rs_chien_search(err_loc, err_loc_len,
+				 FTRFS_SUBBLOCK_DATA + FTRFS_RS_PARITY,
+				 errs);
+	if (nroots != nerrs) {
+		pr_err_ratelimited("ftrfs: RS Chien search mismatch\n");
+		return -EBADMSG;
+	}
+
+	/* Step 4: Forney corrections */
+	rs_forney(msg, syndromes, err_loc, err_loc_len, errs, nerrs);
+
+	/* Step 5: verify */
+	if (!rs_calc_syndromes(msg, FTRFS_SUBBLOCK_DATA + FTRFS_RS_PARITY,
+			       syndromes)) {
+		pr_err_ratelimited("ftrfs: RS correction failed verification\n");
+		return -EBADMSG;
+	}
+
+	memcpy(data, msg, FTRFS_SUBBLOCK_DATA);
 	return 0;
 }
 
diff --git a/fs/ftrfs/file.c b/fs/ftrfs/file.c
index 1807ac698d7d..2520896c71e3 100644
--- a/fs/ftrfs/file.c
+++ b/fs/ftrfs/file.c
@@ -5,14 +5,17 @@
  */
 #include <linux/fs.h>
 #include <linux/mm.h>
-#include <linux/buffer_head.h>
-#include <linux/mpage.h>
+#include <linux/iomap.h>
+#include <linux/pagemap.h>
 #include "ftrfs.h"
 
+/* Forward declaration — defined after iomap_ops */
+static ssize_t ftrfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from);
+
 const struct file_operations ftrfs_file_operations = {
 	.llseek         = generic_file_llseek,
 	.read_iter      = generic_file_read_iter,
-	.write_iter     = generic_file_write_iter,
+	.write_iter     = ftrfs_file_write_iter,
 	.mmap           = generic_file_mmap,
 	.fsync          = generic_file_fsync,
 	.splice_read    = filemap_splice_read,
@@ -23,88 +26,172 @@ const struct inode_operations ftrfs_file_inode_operations = {
 };
 
 /*
- * ftrfs_get_block — map logical block to physical block
- * Handles allocation when create=1, returns -EIO for holes on read.
+ * ftrfs_iomap_begin — map a file range to disk blocks for iomap.
+ * Handles read (no allocation) and write (allocate on demand).
+ * Only direct blocks supported (max 48 KiB per file).
  */
-static int ftrfs_get_block(struct inode *inode, sector_t iblock,
-			   struct buffer_head *bh_result, int create)
+static int ftrfs_iomap_begin(struct inode *inode, loff_t pos, loff_t length,
+			     unsigned int flags, struct iomap *iomap,
+			     struct iomap *srcmap)
 {
-	struct ftrfs_inode_info *fi = FTRFS_I(inode);
-	u64 new_block;
-	__le64 phys;
+	struct ftrfs_inode_info *fi  = FTRFS_I(inode);
+	struct super_block      *sb  = inode->i_sb;
+	u64  iblock    = pos >> FTRFS_BLOCK_SHIFT;
+	u64  new_block;
+	u64  phys;
 
 	if (iblock >= FTRFS_DIRECT_BLOCKS) {
-		pr_err("ftrfs: indirect block not yet supported\n");
+		pr_err_ratelimited("ftrfs: iomap: offset beyond direct blocks\n");
 		return -EOPNOTSUPP;
 	}
 
-	phys = fi->i_direct[iblock];
+	iomap->offset = iblock << FTRFS_BLOCK_SHIFT;
+	iomap->length = FTRFS_BLOCK_SIZE;
+	iomap->bdev   = sb->s_bdev;
+	iomap->flags  = 0;
+
+	phys = le64_to_cpu(fi->i_direct[iblock]);
 	if (phys) {
-		map_bh(bh_result, inode->i_sb, le64_to_cpu(phys));
-		bh_result->b_size = 1 << inode->i_blkbits;
+		iomap->type = IOMAP_MAPPED;
+		iomap->addr = phys << FTRFS_BLOCK_SHIFT;
 		return 0;
 	}
 
-	if (!create)
-		return -EIO;
+	/* Hole on read — do not allocate */
+	if (!(flags & IOMAP_WRITE)) {
+		iomap->type = IOMAP_HOLE;
+		iomap->addr = IOMAP_NULL_ADDR;
+		return 0;
+	}
 
-	new_block = ftrfs_alloc_block(inode->i_sb);
+	/* Allocate a new block for write */
+	new_block = ftrfs_alloc_block(sb);
 	if (!new_block) {
-		pr_err("ftrfs: no free blocks\n");
+		pr_err("ftrfs: iomap: no free blocks\n");
 		return -ENOSPC;
 	}
 
 	fi->i_direct[iblock] = cpu_to_le64(new_block);
-	map_bh(bh_result, inode->i_sb, new_block);
-	bh_result->b_size = 1 << inode->i_blkbits;
-	set_buffer_new(bh_result);
+	mark_inode_dirty(inode);
+
+	iomap->type = IOMAP_MAPPED;
+	iomap->addr = new_block << FTRFS_BLOCK_SHIFT;
 	return 0;
 }
 
-static int ftrfs_read_folio(struct file *file, struct folio *folio)
+static int ftrfs_iomap_end(struct inode *inode, loff_t pos, loff_t length,
+			   ssize_t written, unsigned int flags,
+			   struct iomap *iomap)
 {
-	return block_read_full_folio(folio, ftrfs_get_block);
+	return 0;
 }
 
-static int ftrfs_writepages(struct address_space *mapping,
-			    struct writeback_control *wbc)
+const struct iomap_ops ftrfs_iomap_ops = {
+	.iomap_begin = ftrfs_iomap_begin,
+	.iomap_end   = ftrfs_iomap_end,
+};
+
+/*
+ * Write path — ftrfs_iomap_write_ops
+ * get_folio/put_folio use generic helpers (no journaling required).
+ */
+static struct folio *ftrfs_iomap_get_folio(struct iomap_iter *iter,
+					   loff_t pos, unsigned int len)
 {
-	return mpage_writepages(mapping, wbc, ftrfs_get_block);
+	return iomap_get_folio(iter, pos, len);
 }
 
-static void ftrfs_readahead(struct readahead_control *rac)
+static void ftrfs_iomap_put_folio(struct inode *inode, loff_t pos,
+				  unsigned int copied, struct folio *folio)
 {
-	mpage_readahead(rac, ftrfs_get_block);
+	folio_unlock(folio);
+	folio_put(folio);
 }
 
-static int ftrfs_write_begin(const struct kiocb *iocb,
-			     struct address_space *mapping,
-			     loff_t pos, unsigned int len,
-			     struct folio **foliop, void **fsdata)
+static const struct iomap_write_ops ftrfs_iomap_write_ops = {
+	.get_folio = ftrfs_iomap_get_folio,
+	.put_folio = ftrfs_iomap_put_folio,
+};
+
+static ssize_t ftrfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
-	return block_write_begin(mapping, pos, len, foliop, ftrfs_get_block);
+	return iomap_file_buffered_write(iocb, from, &ftrfs_iomap_ops,
+					 &ftrfs_iomap_write_ops, NULL);
 }
 
-static int ftrfs_write_end(const struct kiocb *iocb,
-			   struct address_space *mapping,
-			   loff_t pos, unsigned int len, unsigned int copied,
-			   struct folio *folio, void *fsdata)
+/*
+ * Writeback path — ftrfs_writeback_ops
+ */
+static ssize_t ftrfs_writeback_range(struct iomap_writepage_ctx *wpc,
+				  struct folio *folio, u64 offset,
+				  unsigned int len, u64 end_pos)
 {
-	return generic_write_end(iocb, mapping, pos, len, copied, folio, fsdata);
+	if (offset < wpc->iomap.offset ||
+	    offset >= wpc->iomap.offset + wpc->iomap.length) {
+		int ret;
+
+		memset(&wpc->iomap, 0, sizeof(wpc->iomap));
+		ret = ftrfs_iomap_begin(wpc->inode,
+					offset, INT_MAX, 0,
+					&wpc->iomap, NULL);
+		if (ret)
+			return ret;
+	}
+	return iomap_add_to_ioend(wpc, folio, offset, end_pos, len);
+}
+
+static const struct iomap_writeback_ops ftrfs_writeback_ops = {
+	.writeback_range  = ftrfs_writeback_range,
+	.writeback_submit = iomap_ioend_writeback_submit,
+};
+
+static int ftrfs_writepages(struct address_space *mapping,
+			    struct writeback_control *wbc)
+{
+	struct iomap_writepage_ctx wpc = {
+		.inode = mapping->host,
+		.wbc   = wbc,
+		.ops   = &ftrfs_writeback_ops,
+	};
+
+	return iomap_writepages(&wpc);
+}
+
+/*
+ * Read path — uses iomap_bio_read_ops (kernel-provided)
+ */
+static int ftrfs_read_folio(struct file *file, struct folio *folio)
+{
+	struct iomap_read_folio_ctx ctx = {
+		.ops       = &iomap_bio_read_ops,
+		.cur_folio = folio,
+	};
+
+	iomap_read_folio(&ftrfs_iomap_ops, &ctx, NULL);
+	return 0;
+}
+
+static void ftrfs_readahead(struct readahead_control *rac)
+{
+	struct iomap_read_folio_ctx ctx = {
+		.ops = &iomap_bio_read_ops,
+		.rac = rac,
+	};
+
+	iomap_readahead(&ftrfs_iomap_ops, &ctx, NULL);
 }
 
 static sector_t ftrfs_bmap(struct address_space *mapping, sector_t block)
 {
-	return generic_block_bmap(mapping, block, ftrfs_get_block);
+	return iomap_bmap(mapping, block, &ftrfs_iomap_ops);
 }
 
 const struct address_space_operations ftrfs_aops = {
 	.read_folio       = ftrfs_read_folio,
 	.readahead        = ftrfs_readahead,
-	.write_begin      = ftrfs_write_begin,
-	.write_end        = ftrfs_write_end,
 	.writepages       = ftrfs_writepages,
 	.bmap             = ftrfs_bmap,
-	.dirty_folio      = block_dirty_folio,
-	.invalidate_folio = block_invalidate_folio,
+	.dirty_folio      = iomap_dirty_folio,
+	.invalidate_folio = iomap_invalidate_folio,
+	.release_folio    = iomap_release_folio,
 };
diff --git a/fs/ftrfs/ftrfs.h b/fs/ftrfs/ftrfs.h
index 1f2d8a954814..f75709aee0ee 100644
--- a/fs/ftrfs/ftrfs.h
+++ b/fs/ftrfs/ftrfs.h
@@ -35,6 +35,21 @@
 #define FTRFS_INDIRECT_BLOCKS 1
 #define FTRFS_DINDIRECT_BLOCKS 1
 
+/*
+ * Radiation Event Journal entry — 24 bytes
+ * Records each RS FEC correction event persistently in the superblock.
+ * 64 entries give operators a map of physical degradation over time.
+ * No existing Linux filesystem provides this at the block layer.
+ */
+struct ftrfs_rs_event {
+	__le64  re_block_no;    /* corrected block number */
+	__le64  re_timestamp;   /* nanoseconds since boot  */
+	__le32  re_error_bits;  /* number of symbols corrected */
+	__le32  re_crc32;       /* CRC32 of this entry */
+} __packed;                 /* 24 bytes */
+
+#define FTRFS_RS_JOURNAL_SIZE  64   /* entries in the radiation event journal */
+
 /*
  * On-disk superblock — block 0
  * Total size: fits in one 4096-byte block
@@ -53,7 +68,9 @@ struct ftrfs_super_block {
 	__le32  s_crc32;            /* CRC32 of this superblock */
 	__u8    s_uuid[16];         /* UUID */
 	__u8    s_label[32];        /* Volume label */
-	__u8    s_pad[3980];        /* Padding to 4096 bytes */
+	 struct ftrfs_rs_event s_rs_journal[FTRFS_RS_JOURNAL_SIZE]; /* 1536 bytes */
+	__u8    s_rs_journal_head;  /* next write index (ring buffer) */
+	__u8    s_pad[2443];        /* Padding to 4096 bytes */
 } __packed;
 
 /*
@@ -142,6 +159,7 @@ static inline struct ftrfs_sb_info *FTRFS_SB(struct super_block *sb)
 /* Function prototypes */
 /* super.c */
 int ftrfs_fill_super(struct super_block *sb, struct fs_context *fc);
+void ftrfs_log_rs_event(struct super_block *sb, u64 block_no, u32 err_bits);
 
 /* inode.c */
 struct inode *ftrfs_iget(struct super_block *sb, unsigned long ino);
diff --git a/fs/ftrfs/namei.c b/fs/ftrfs/namei.c
index d37ad8b7bc5b..63fe96d219bf 100644
--- a/fs/ftrfs/namei.c
+++ b/fs/ftrfs/namei.c
@@ -425,6 +425,118 @@ int ftrfs_write_inode(struct inode *inode, struct writeback_control *wbc)
 /* dir inode_operations — exported                                     */
 /* ------------------------------------------------------------------ */
 
+/* ------------------------------------------------------------------ */
+/* rename — move/rename a directory entry                              */
+/* ------------------------------------------------------------------ */
+
+static int ftrfs_rename(struct mnt_idmap *idmap,
+			struct inode *old_dir, struct dentry *old_dentry,
+			struct inode *new_dir, struct dentry *new_dentry,
+			unsigned int flags)
+{
+	struct inode *old_inode = d_inode(old_dentry);
+	struct inode *new_inode = d_inode(new_dentry);
+	int	      is_dir    = S_ISDIR(old_inode->i_mode);
+	int	      ret;
+
+	/* FTRFS v1: no RENAME_EXCHANGE or RENAME_WHITEOUT */
+	if (flags & ~RENAME_NOREPLACE)
+		return -EINVAL;
+
+	if (flags & RENAME_NOREPLACE && new_inode)
+		return -EEXIST;
+
+	/*
+	 * If destination exists, unlink it first.
+	 * For directories: target must be empty (nlink == 2: . and ..)
+	 */
+	if (new_inode) {
+		if (is_dir) {
+			if (new_inode->i_nlink > 2)
+				return -ENOTEMPTY;
+		}
+
+		ret = ftrfs_del_dirent(new_dir, &new_dentry->d_name);
+		if (ret)
+			return ret;
+
+		if (is_dir) {
+			inode_dec_link_count(new_inode);
+			inode_dec_link_count(new_inode);
+			inode_dec_link_count(new_dir);
+		} else {
+			inode_dec_link_count(new_inode);
+		}
+
+		inode_set_ctime_to_ts(new_inode, current_time(new_inode));
+	}
+
+	/* Add entry in new_dir */
+	ret = ftrfs_add_dirent(new_dir, &new_dentry->d_name,
+			       old_inode->i_ino,
+			       is_dir ? 4 /* DT_DIR */ : 1 /* DT_REG */);
+	if (ret)
+		return ret;
+
+	/* Remove entry from old_dir */
+	ret = ftrfs_del_dirent(old_dir, &old_dentry->d_name);
+	if (ret) {
+		pr_err("ftrfs: rename: del_dirent failed after add, fs may be inconsistent\n");
+		return ret;
+	}
+
+	/*
+	 * Update ".." in the moved directory to point to new_dir.
+	 * Also fix nlink on old_dir and new_dir.
+	 */
+	if (is_dir && old_dir != new_dir) {
+		struct qstr dotdot = QSTR_INIT("..", 2);
+
+		ret = ftrfs_del_dirent(old_inode, &dotdot);
+		if (ret)
+			return ret;
+
+		ret = ftrfs_add_dirent(old_inode, &dotdot,
+				       new_dir->i_ino, 4 /* DT_DIR */);
+		if (ret)
+			return ret;
+
+		inode_dec_link_count(old_dir);
+		inode_inc_link_count(new_dir);
+
+		ret = ftrfs_write_inode_raw(old_inode);
+		if (ret)
+			return ret;
+	}
+
+	/* Update timestamps */
+	inode_set_ctime_to_ts(old_inode, current_time(old_inode));
+	inode_set_mtime_to_ts(old_dir,   current_time(old_dir));
+	inode_set_ctime_to_ts(old_dir,   current_time(old_dir));
+	inode_set_mtime_to_ts(new_dir,   current_time(new_dir));
+	inode_set_ctime_to_ts(new_dir,   current_time(new_dir));
+
+	/* Persist all touched inodes */
+	ret = ftrfs_write_inode_raw(old_inode);
+	if (ret)
+		return ret;
+
+	ret = ftrfs_write_inode_raw(old_dir);
+	if (ret)
+		return ret;
+
+	if (old_dir != new_dir) {
+		ret = ftrfs_write_inode_raw(new_dir);
+		if (ret)
+			return ret;
+	}
+
+	if (new_inode)
+		ftrfs_write_inode_raw(new_inode);
+
+	return 0;
+}
+
 const struct inode_operations ftrfs_dir_inode_operations = {
 	.lookup  = ftrfs_lookup,
 	.create  = ftrfs_create,
@@ -432,4 +544,5 @@ const struct inode_operations ftrfs_dir_inode_operations = {
 	.unlink  = ftrfs_unlink,
 	.rmdir   = ftrfs_rmdir,
 	.link    = ftrfs_link,
+	.rename  = ftrfs_rename,
 };
diff --git a/fs/ftrfs/super.c b/fs/ftrfs/super.c
index bce7148ee3e2..52d9b0b6f916 100644
--- a/fs/ftrfs/super.c
+++ b/fs/ftrfs/super.c
@@ -88,6 +88,47 @@ static const struct super_operations ftrfs_super_ops = {
 	.statfs         = ftrfs_statfs,
 };
 
+/*
+ * ftrfs_log_rs_event - record a Reed-Solomon correction in the superblock
+ * @sb:        mounted superblock
+ * @block_no:  block number where correction occurred
+ * @err_bits:  number of symbols corrected
+ *
+ * Writes to the persistent ring buffer in the superblock.
+ * Safe to call from any context (spinlock protected).
+ */
+void ftrfs_log_rs_event(struct super_block *sb, u64 block_no, u32 err_bits)
+{
+	struct ftrfs_sb_info     *sbi = FTRFS_SB(sb);
+	struct ftrfs_super_block *fsb;
+	struct ftrfs_rs_event    *ev;
+	u8 head;
+
+	if (!sbi || !sbi->s_sbh)
+		return;
+
+	spin_lock(&sbi->s_lock);
+
+	fsb  = (struct ftrfs_super_block *)sbi->s_sbh->b_data;
+	head = fsb->s_rs_journal_head % FTRFS_RS_JOURNAL_SIZE;
+	ev   = &fsb->s_rs_journal[head];
+
+	ev->re_block_no   = cpu_to_le64(block_no);
+	ev->re_timestamp  = cpu_to_le64(ktime_get_ns());
+	ev->re_error_bits = cpu_to_le32(err_bits);
+	ev->re_crc32      = cpu_to_le32(
+		ftrfs_crc32(ev, offsetof(struct ftrfs_rs_event, re_crc32)));
+
+	fsb->s_rs_journal_head = (head + 1) % FTRFS_RS_JOURNAL_SIZE;
+
+	mark_buffer_dirty(sbi->s_sbh);
+
+	spin_unlock(&sbi->s_lock);
+
+	pr_debug("ftrfs: RS correction block=%llu symbols=%u\n",
+		 block_no, err_bits);
+}
+
 /*
  * ftrfs_fill_super — read superblock from disk and initialize VFS sb
  */
-- 
2.52.0

