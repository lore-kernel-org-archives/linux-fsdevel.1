Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D7029D26C
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jun 2026 17:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781371704; cv=none; b=otInfqIHPqlbQLhBfa4TUMHb9ky8oG4UXClA7olwOxyn0eM9PiKpC3a2eS0XzDhlW8AL98GuQgqb6h36LJIOpepbHcPNdCN2RT4k1kE61+nA4tljUsOn9kwDUTTmHUqp2/L1IqqjGE7KeT7WxUiAAa3EwUW9RyWkOJmAtZzHl7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781371704; c=relaxed/simple;
	bh=deOTC8NPZxFEV2yYsMnVBUoqmD6NoGL8zO8BRowez+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VxNhxVM50+eR1yUDnCMKAZLpR5YMOoI3rxNIm3YS4JPsUIPIHNl4RFm3GNUWN/Vu2aChcBJamRLPs4Jvx81lhhPIK0MII1xrvpyx09Og/9p7r7+DDG/+g+hWlCrZAsrDLgU9wpU5+30rwwiQcKnNjxvv1G//gqqxjW9rbgjNaH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oozdasVO; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oozdasVO"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490b211ee6aso14429015e9.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jun 2026 10:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781371700; x=1781976500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=phTgejwQLMIwdLJsj/unHy6Y+zSp3fQCdxUWdpYKXyU=;
        b=oozdasVOP3E2gowOdc0DDxnPQIqL79UlFlYLuaZccfYvQ08rkrG6wzTO73QeQJicOS
         P/X+JlrkaDotY3DSAD0uYDKqv+0xeH5aOmXDIJgKf0rdRbKr6nv6Pu99ITJwb024Rr0g
         1tDR0eN1i6sjC2ZXuou4HmVNSAT7kzbs871CnVOPzsuCuLMAhWl6Ovzf8jdXBnKsHOgT
         BdlX47ttQt7++UFMX9TAHhPzdCE2vhPEimIvAelKoaMupptlXzlfZLtETSle7G0qisw9
         Y5PSCLXRsfrLYg2meRJmN79ahSzUzWheSevYJtBycTK+NCzn0oAT/ohUHahyJE4N/rlu
         4dzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781371700; x=1781976500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phTgejwQLMIwdLJsj/unHy6Y+zSp3fQCdxUWdpYKXyU=;
        b=Fs9lgFqPdLcwsWAgfna2Pl0Hy8w2ojAb/Wg5AbyGHTzFzKQyH14OSAIWJ0OhZ6994p
         ir2Tw2R6CxMtwHKAG3c4QbWB7vfcTvahD5eiDzFIgOjkDcaPwi/fVtj+Hww57ozAtqws
         wAs/KDIITF1twvsH6AvTh0Sk+8Z4IRSwjCTWQcLBD2MPi21nFl3rGdriv+Atw47qcqsJ
         TpfThlSYq+P4JSK6dwkqXhhhytl54itASEjRg4Kv+kkOaRIia+N283LoWzd60kTnE6lh
         nStQ9u3VsA4qFqYeX5DilifYHsw4EkYDnbT1AxE0IPIUjTj4EErT/JUKfVDxP2E/QBSh
         ZowQ==
X-Forwarded-Encrypted: i=1; AFNElJ9U9xOwVYug6LytFA3/LWmEXK6veLuMPbK+WxSVylAn1dz/W8anzQHo/21VvBgXAXSwXf/3ooyYdjO2j0lm@vger.kernel.org
X-Gm-Message-State: AOJu0YxAcRJeokSnSOpqfRKdoJI05aVVW5R4OwL8C+YvBtiiOC2goSBC
	Iz0PnwzlKqIgjlyC2LylkKHqREAhJGhOjcL8J1AwkqaDsEuyMT7lbtWa
X-Gm-Gg: Acq92OGaDMRSDMOBQDPtwsr0OpOE8YuZ13ZP61ZjSe0sOMX63HU1ybrtQErqgT5Rsg8
	S2dFtjmw/IKPKobchHgp/paBXst4usM3dtZQD6me/YRZOh8AQPIwHARqmPDHyZB7OXWVN0/gX0h
	El6S1di1mwgiSMEGXyN05IoEGQ1c13vm+ZUXMHF16B82d+G+Clus+DYqI08YZIQT5y5/8U587EJ
	+TwGycc6wJJ+tZP46/G5vJlv3XNjBhW+sLMdOifPWLINU5J9gCLQH4GPh/x+j+YXCKFQBbboO/W
	yuYVO+8Y0xgeXEiKs+QHePT8Xm4HafluSLM6G4aq/OiNlrd1qdp54PvkG7Da/NU8ujvod5mXn4V
	/mmn0c+7HIRjBFT+CgDl6+4162zxT4goLrfiJVm0Pewj8uvuiRGfPn7k3mkdApNBEBKPJguze9d
	2e4QzJPSa1bgUE9ZQM9+E8qwTeE7c0LjifixQIGCFzZRFyNt+7HnD63DogFyM=
X-Received: by 2002:a05:600c:1d15:b0:490:c01a:5f10 with SMTP id 5b1f17b1804b1-490ec4bf07bmr95703645e9.15.1781371700208;
        Sat, 13 Jun 2026 10:28:20 -0700 (PDT)
Received: from teknoraver-mbp.local.lan ([195.182.211.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922031b21dsm88785065e9.6.2026.06.13.10.28.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 13 Jun 2026 10:28:19 -0700 (PDT)
From: Matteo Croce <technoboy85@gmail.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Timothy Redaelli <tredaelli@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matteo Croce <technoboy85@gmail.com>,
	Matteo Croce <teknoraver@meta.com>
Subject: [PATCH v3] fat: stop reading directory entries past the end-of-directory marker
Date: Sat, 13 Jun 2026 19:28:16 +0200
Message-ID: <20260613172816.18034-1-technoboy85@gmail.com>
X-Mailer: git-send-email 2.50.1
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

Linux did not honour this. fat_get_entry() kept advancing past the 0x00
terminator; if the trailing on-disk slots were not zero-filled (buggy
formatters, read-only media written by other operating systems, on-disk
corruption) the driver surfaced arbitrary bytes as real directory
entries. On a typical affected image, `ls /mnt` returns ~150 bogus
entries with random binary names, multi-gigabyte sizes, dates ranging
from 1980 to 2106, and a flood of -EIO from stat().

Earlier attempts (v1..v3, see [2][3][4]) added `de->name[0] == 0` guards
at each call site. As Hirofumi pointed out on v3, those guards reject
the entry but fat_get_entry() has already advanced *pos past it; the
next readdir() resumes after the marker and walks straight back into
the garbage. His suggestion was to centralise the check.

This patch:

  * Adds fat_get_entry_eod(), a small wrapper around fat_get_entry()
    that returns -1 when name[0] == 0 and seeks *pos to dir->i_size.
    Per spec every slot after the 0x00 marker is also zero, so jumping
    to the end of the directory is correct: subsequent reads return -1
    from fat_bmap() without re-fetching trailing zero slots, and
    callers persisting *pos across invocations (notably readdir's
    ctx->pos) keep reporting end-of-directory on re-entry.

  * Converts the read/search paths to use the new wrapper:
      fat_parse_long(), fat_search_long(), __fat_readdir(),
      and fat_get_short_entry() -- the last covers
      fat_get_dotdot_entry(), fat_dir_empty(), fat_subdirs(),
      fat_scan(), and fat_scan_logstart() transitively.

  * Leaves fat_add_entries() and __fat_remove_entries() on raw
    fat_get_entry(): the write paths legitimately need to operate on
    free/zero slots. fat_add_entries() additionally detects an
    allocated entry past a 0x00 marker (the spec violation that
    produces the garbage) and treats it as filesystem corruption:
    fat_fs_error_ratelimit() is called -- which honours the configured
    errors= mount option (panic / remount-ro / continue) -- and the
    operation returns -EIO so we don't write fresh entries into an
    already-corrupt directory.

[1] https://download.microsoft.com/download/1/6/1/161ba512-40e2-4cc9-843a-923143f3456c/fatgen103.doc
[2] https://lore.kernel.org/lkml/20181207013410.7050-1-mcroce@redhat.com/
[3] https://lore.kernel.org/lkml/20181216231510.26854-1-mcroce@redhat.com/
[4] https://lore.kernel.org/lkml/20190201001408.7453-1-mcroce@redhat.com/

Reported-by: Timothy Redaelli <tredaelli@redhat.com>
Suggested-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Signed-off-by: Matteo Croce <teknoraver@meta.com>
---
 fs/fat/dir.c | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index 4f6f42f33613..c7d0bc5de697 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -130,6 +130,28 @@ static inline int fat_get_entry(struct inode *dir, loff_t *pos,
 	return fat__get_entry(dir, pos, bh, de);
 }
 
+/*
+ * Like fat_get_entry(), but honour the FAT end-of-directory marker:
+ * a dirent whose first name byte is NUL terminates iteration per the
+ * spec, which also guarantees that every following slot is zeroed.
+ * Skip straight to the end of the directory so the next call returns
+ * -1 from fat_bmap() without re-reading the trailing zero slots, and
+ * so callers that persist *pos across invocations (e.g. readdir's
+ * ctx->pos) keep reporting EOD.
+ */
+static int fat_get_entry_eod(struct inode *dir, loff_t *pos,
+			     struct buffer_head **bh,
+			     struct msdos_dir_entry **de)
+{
+	int err = fat_get_entry(dir, pos, bh, de);
+
+	if (err == 0 && (*de)->name[0] == 0) {
+		*pos = dir->i_size;
+		return -1;
+	}
+	return err;
+}
+
 /*
  * Convert Unicode 16 to UTF-8, translated Unicode, or ASCII.
  * If uni_xlate is enabled and we can't get a 1:1 conversion, use a
@@ -327,7 +349,7 @@ static int fat_parse_long(struct inode *dir, loff_t *pos,
 
 		if (ds->id & 0x40)
 			(*unicode)[offset + 13] = 0;
-		if (fat_get_entry(dir, pos, bh, de) < 0)
+		if (fat_get_entry_eod(dir, pos, bh, de) < 0)
 			return PARSE_EOF;
 		if (slot == 0)
 			break;
@@ -489,7 +511,7 @@ int fat_search_long(struct inode *inode, const unsigned char *name,
 
 	err = -ENOENT;
 	while (1) {
-		if (fat_get_entry(inode, &cpos, &bh, &de) == -1)
+		if (fat_get_entry_eod(inode, &cpos, &bh, &de) == -1)
 			goto end_of_dir;
 parse_record:
 		nr_slots = 0;
@@ -601,7 +623,7 @@ static int __fat_readdir(struct inode *inode, struct file *file,
 
 	bh = NULL;
 get_new:
-	if (fat_get_entry(inode, &cpos, &bh, &de) == -1)
+	if (fat_get_entry_eod(inode, &cpos, &bh, &de) == -1)
 		goto end_of_dir;
 parse_record:
 	nr_slots = 0;
@@ -885,7 +907,7 @@ static int fat_get_short_entry(struct inode *dir, loff_t *pos,
 			       struct buffer_head **bh,
 			       struct msdos_dir_entry **de)
 {
-	while (fat_get_entry(dir, pos, bh, de) >= 0) {
+	while (fat_get_entry_eod(dir, pos, bh, de) >= 0) {
 		/* free entry or long name entry or volume label */
 		if (!IS_FREE((*de)->name) && !((*de)->attr & ATTR_VOLUME))
 			return 0;
@@ -1302,6 +1324,7 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
 	struct msdos_dir_entry *de;
 	int err, free_slots, i, nr_bhs;
 	loff_t pos;
+	bool saw_eod;
 
 	sinfo->nr_slots = nr_slots;
 
@@ -1310,12 +1333,15 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
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
@@ -1325,6 +1351,13 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
 			if (free_slots == nr_slots)
 				goto found;
 		} else {
+			if (saw_eod) {
+				fat_fs_error_ratelimit(sb,
+					"allocated dir entry found after end-of-directory marker (i_pos %lld)",
+					MSDOS_I(dir)->i_pos);
+				err = -EIO;
+				goto error;
+			}
 			for (i = 0; i < nr_bhs; i++)
 				brelse(bhs[i]);
 			prev = NULL;
-- 
2.50.1

