Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EF53A2546
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 20:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778790883; cv=none; b=eWtUz45OUeJgvL8RT4iTvbJM0koHUTHi7/BlTVAhnsOm54G8mRDCOYJbid0NWq8BtjEhfrkFr+AKK2j9hIA4z+iUIRDGUhK3SryxDth0Xr4/HN33LZ82Guh7SJYT3tNaV1UUhFcOLeNAkMoyvnPrFWwJY6KoHrlAp3acaHRMGqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778790883; c=relaxed/simple;
	bh=m7QJc4bQxofcs+Cu3bMJnwPsgVk+kdl1UkCRrZUD+mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k2HJSkwHQ4tBsSLOVwONep14UqtA6LcSzTsx1/uhrAVMoCJxaYucr6lPzKBEghth8NL1dNgJnsjddQ7mOxUdL+ChSbs2ssA2gX41qqGoFbVvs4Jz24ppLXhYbSy2MHF+MnE4ja/wxJzX8oDZqtNd/9QEOnIcl+j9P7W6HZJH0q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBLUCW/s; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBLUCW/s"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48909558b3aso81459895e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 13:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778790880; x=1779395680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OVjGcDYWvFPm8krx+qeokcjERyyTX5R5vL7GgQ6JTJM=;
        b=QBLUCW/sTmDcjWffKvucIB4AO4Gi510if5dnElYpzHWFQ4Q4159OpZzQpi0LU0bakM
         BB2wLBoryfthBg/AwWZAKAgq4RLM7EtiCfBwHe/ln47eQxABfGZGFpCnbSghvsflJrsK
         3EBiscuf+xmMDolYPiCbRnIS8oE+z36CF6o/WCexQF/K2ml2BsLB7PvKUXXCVgg+Y18O
         tNjxQe40517r38NaIfZwHtnLMV52t+Jn1kalrVHfuZzgKcDNsXndCNUAbEsunwY/ffYp
         9bVplaFNHoWfd1HST2twUbxeHF8xHG5ca8VH6Fp9mZA5TBmmNWLWkJsOIFzFlacWN1Ry
         U1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778790880; x=1779395680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVjGcDYWvFPm8krx+qeokcjERyyTX5R5vL7GgQ6JTJM=;
        b=Tqf5jDCJNYGjNxv/gAd+hOxZHUJDD4OBERStmKYqMaSZDFovp36R6x7cBC2ZAQnvNN
         m9l7z3OZsDXEAfmeloGAUcp2whvNCtn6tI7FePDjVxSg+dBnbCmJW35sIsp5tm1aAJL1
         ylh0c6ceO0jv/HxL8DOSjuWYFGKVs0GK0Cr/+8UQVZfXUy+5Xx7MggjG5zjNAT4VCRlh
         64Zw3mbSaEdU1p0R5gN8ZoiOhGVuHVAiFSKq8v37yCToxSutcddwUk4HhFPFsgqWqoH0
         bfSnSuOeVVeuuPHSusTFNDPEW9TcSFKTfW9ZMdijuH/eF1ufm/aUarZeE0Jlng5kCrhy
         e4IQ==
X-Forwarded-Encrypted: i=1; AFNElJ9c2RAEvj1vV2IKctr2Jj+B83yLQ+6rAYwL/W1uUZfRkky5F8N5Relr290MGoT21TydG/WqKgCJcRBpXfzF@vger.kernel.org
X-Gm-Message-State: AOJu0YxNc5ky8LPOX1sf3t/+oMLEM1Oh0QrXgwvak2YRPY6la7xYI8C4
	dzTpilwUbK3HMaUg8HZHywj5cfVOSr8hM4ZWnbGm29DYu9GCj/5wimqn
X-Gm-Gg: Acq92OGXZhZpYgSWbuxDGsoqeWqFepn4Ho7krk82Sp+PUF0aJ7hgTlIcLuKlMPfu0UZ
	thwLpts9BEJWHgQrfRQcuSD4FFgOPtV1jusLyWhkiwQfx2QFNWw0CbD80nWVCpDSxIKGFv+M9qj
	RbKM109JtkCRsZlIGmHYDLNnNNA1ZRKbkfkCtbhdOfl8L9CVZTgvSO2IXia5exWykfmmAvF//KG
	FkyczB1vHxXcP9JIerqLCsbGfw9cb3xNs/BPWiGkn3JgXdlRxyPoW+6Trb9QTeDUIn6ciNkWgFv
	yQfyvu3XZC7pciSjW7K5Wgh+qIXJow3+2aRw2zB75jOOUHKRYm8CT3feQxNqaeQSBbhHJuPnRPF
	xOQnUdfh9rGNKfnYZt2yIKzk4ppkfM8kD7F6xc8JVxyidW751lCdRqopMx4X05cPpW70XcHtO2a
	U7r11vwfT0VASxlFtGtXqEZyZrQM30L/qzn5uDgPOUPUsmgZA=
X-Received: by 2002:a05:600c:3f1b:b0:48a:7965:b943 with SMTP id 5b1f17b1804b1-48fe661db6dmr11736865e9.29.1778790879745;
        Thu, 14 May 2026 13:34:39 -0700 (PDT)
Received: from turbo.teknoraver.net ([195.182.211.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd7483926sm24633875e9.16.2026.05.14.13.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 13:34:39 -0700 (PDT)
From: Matteo Croce <technoboy85@gmail.com>
X-Google-Original-From: Matteo Croce <teknoraver@meta.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Timothy Redaelli <tredaelli@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fat: stop reading directory entries past the end-of-directory marker
Date: Thu, 14 May 2026 22:34:36 +0200
Message-ID: <20260514203436.13789-1-teknoraver@meta.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The FAT specification[1] (FAT Directory Structure -> "DIR_Name[0]") states:

    If DIR_Name[0] == 0x00, then the directory entry is free (same as for
    0xE5), and there are no allocated directory entries after this one
    (all of the DIR_Name[0] bytes in all of the entries after this one
    are also set to 0).

    The special 0 value, rather than the 0xE5 value, indicates to FAT
    file system driver code that the rest of the entries in this
    directory do not need to be examined because they are all free.

Linux doesn't honour this: if the trailing on-disk slots is not zero-filled
(buggy formatters, on-disk corruption, etc.) fat_get_entry() keeps on
advancing past the 0x00 terminator and the driver parses arbitrary bytes as
real directory entries.
On a typical affected image, `ls /mnt` returns ~150 bogus entries with
random binary names, multi-gigabyte sizes, dates ranging from 1980 to 2106,
and a flood of -EIO from stat().

Earlier attempts (was "vfat: don't read garbage after last dirent"[2][3][4])
added `de->name[0] == 0` guards at each call site.
As Hirofumi pointed out on v3, those guards reject the entry but
fat_get_entry() has already advanced *pos past it. The next readdir()
resumes after the marker and walks straight back into the garbage.

This patch:
Adds fat_get_entry_eod(), a small wrapper around fat_get_entry()
that returns -1 when name[0] == 0 AND rewinds *pos to the marker.
converts the read/search paths to use the new wrapper.
Leaves fat_add_entries() and __fat_remove_entries() on raw fat_get_entry():
the write paths legitimately need to operate on free/zero slots.
Additionally, log a rate-limited warning suggesting fsck if it sees an
allocated entry after a 0x00 marker.

[1] https://download.microsoft.com/download/1/6/1/161ba512-40e2-4cc9-843a-923143f3456c/fatgen103.doc
[2] https://lore.kernel.org/lkml/20181207013410.7050-1-mcroce@redhat.com/
[3] https://lore.kernel.org/lkml/20181216231510.26854-1-mcroce@redhat.com/
[4] https://lore.kernel.org/lkml/20190201001408.7453-1-mcroce@redhat.com/

Reported-by: Timothy Redaelli <tredaelli@redhat.com>
Signed-off-by: Matteo Croce <teknoraver@meta.com>
---
 fs/fat/dir.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index 4f6f42f33613..109330da77b1 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -130,6 +130,26 @@ static inline int fat_get_entry(struct inode *dir, loff_t *pos,
 	return fat__get_entry(dir, pos, bh, de);
 }
 
+/*
+ * Like fat_get_entry(), but honour the FAT end-of-directory marker:
+ * a dirent whose first name byte is NUL terminates iteration per the
+ * spec. *pos is rewound to the EOD slot so callers that persist *pos
+ * across invocations (e.g. readdir's ctx->pos) keep reporting EOD.
+ */
+static int fat_get_entry_eod(struct inode *dir, loff_t *pos,
+			     struct buffer_head **bh,
+			     struct msdos_dir_entry **de)
+{
+	loff_t saved = *pos;
+	int err = fat_get_entry(dir, pos, bh, de);
+
+	if (err == 0 && (*de)->name[0] == 0) {
+		*pos = saved;
+		return -1;
+	}
+	return err;
+}
+
 /*
  * Convert Unicode 16 to UTF-8, translated Unicode, or ASCII.
  * If uni_xlate is enabled and we can't get a 1:1 conversion, use a
@@ -327,7 +347,7 @@ static int fat_parse_long(struct inode *dir, loff_t *pos,
 
 		if (ds->id & 0x40)
 			(*unicode)[offset + 13] = 0;
-		if (fat_get_entry(dir, pos, bh, de) < 0)
+		if (fat_get_entry_eod(dir, pos, bh, de) < 0)
 			return PARSE_EOF;
 		if (slot == 0)
 			break;
@@ -489,7 +509,7 @@ int fat_search_long(struct inode *inode, const unsigned char *name,
 
 	err = -ENOENT;
 	while (1) {
-		if (fat_get_entry(inode, &cpos, &bh, &de) == -1)
+		if (fat_get_entry_eod(inode, &cpos, &bh, &de) == -1)
 			goto end_of_dir;
 parse_record:
 		nr_slots = 0;
@@ -601,7 +621,7 @@ static int __fat_readdir(struct inode *inode, struct file *file,
 
 	bh = NULL;
 get_new:
-	if (fat_get_entry(inode, &cpos, &bh, &de) == -1)
+	if (fat_get_entry_eod(inode, &cpos, &bh, &de) == -1)
 		goto end_of_dir;
 parse_record:
 	nr_slots = 0;
@@ -885,7 +905,7 @@ static int fat_get_short_entry(struct inode *dir, loff_t *pos,
 			       struct buffer_head **bh,
 			       struct msdos_dir_entry **de)
 {
-	while (fat_get_entry(dir, pos, bh, de) >= 0) {
+	while (fat_get_entry_eod(dir, pos, bh, de) >= 0) {
 		/* free entry or long name entry or volume label */
 		if (!IS_FREE((*de)->name) && !((*de)->attr & ATTR_VOLUME))
 			return 0;
@@ -1302,6 +1322,7 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
 	struct msdos_dir_entry *de;
 	int err, free_slots, i, nr_bhs;
 	loff_t pos;
+	bool saw_eod;
 
 	sinfo->nr_slots = nr_slots;
 
@@ -1310,12 +1331,15 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
 	bh = prev = NULL;
 	pos = 0;
 	err = -ENOSPC;
+	saw_eod = false;
 	while (fat_get_entry(dir, &pos, &bh, &de) > -1) {
 		/* check the maximum size of directory */
 		if (pos >= FAT_MAX_DIR_SIZE)
 			goto error;
 
 		if (IS_FREE(de->name)) {
+			if (de->name[0] == 0)
+				saw_eod = true;
 			if (prev != bh) {
 				get_bh(bh);
 				bhs[nr_bhs] = prev = bh;
@@ -1325,6 +1349,12 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
 			if (free_slots == nr_slots)
 				goto found;
 		} else {
+			if (saw_eod) {
+				fat_msg_ratelimit(sb, KERN_WARNING,
+					"allocated dir entry found after end-of-directory marker (i_pos %lld); please run fsck",
+					MSDOS_I(dir)->i_pos);
+				saw_eod = false;
+			}
 			for (i = 0; i < nr_bhs; i++)
 				brelse(bhs[i]);
 			prev = NULL;
-- 
2.54.0

