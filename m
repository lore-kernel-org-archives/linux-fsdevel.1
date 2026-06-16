Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD9A477994
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 16:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781627635; cv=none; b=ildc4IexLjOlLsGfvKjudkJbeNi6ZYC+UWy+LQ+rvmZzcfFYuRPAvxB+/YJ1nl9TFh9eh0XFnGZLd/v2KnPhjRa2EHO7OID8VUwYVWS24B5bgrIY8g8UXkvNiXvhtmMF3EkOsT4wICTRWa1OpZZnaELpxCqKlaiI/PqpfD/M3zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781627635; c=relaxed/simple;
	bh=PnoFtKhlok/kydzLsOZMi4o7cxdYcskUS8q76C7zk8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dbPvJEvrSQssPW1KgdGZQm0sASbUhVNH8mMyi3iYqO0NX3tZv48BJwzALc8d6kkYqIJWPy5uk481tojszt/2rE63rUDo8kuZ7fdvbdCfFdX2NxwDCN6wfM5ppEKgNN1QaryAsMiaEkdRIVp/9+H5S817mH0cRthHFIfK5qWsp2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQXiLMZB; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQXiLMZB"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490b3637b90so37207875e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 09:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781627632; x=1782232432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8yhyPaAH3aWYiYrjEnHtKrzaZetuX+qyDlsFibNt7Rs=;
        b=UQXiLMZB2NJwopTH/NC0ZEzae0CyEB4ro8JLjV/mfAWK6l1J00MAH+JJX0Jr0NrJeN
         EZOqkja7bMuanKdCZkPcv+qEowjMZoGwtDp1A4LeL9hWhtoOfcJg7rHCEGeGTqG40Dyk
         J/Pj0uO0U9kMGHFpSremfSMovI446KekCOXDoUwJx8zvQqFcqc+2aPjXJ7bLzP1MJyV1
         vgxvLGcYll7u6OP1FSnnfGnUiGZNCpwLwO9QmnaqmXmV6lJXg+Ijs4WOy1ZbitAL9Xv8
         bptjmNdbAprlEPED4inSnu4gRVhYoDjiuSVtYSyEZpMKolp6Shc+NxfiwjvyKTHagCRC
         Pxxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781627632; x=1782232432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yhyPaAH3aWYiYrjEnHtKrzaZetuX+qyDlsFibNt7Rs=;
        b=dbE1dDa/0GAiz1GScnzL+RQZ27B44/YOUozickY1uylTsXdoPnVIc4yR5p+h7DX8pR
         o6sTvuF8/utmTlTkBQejrmKJjPJTEgS0TW+ue+tYVuYjm0K9MUd5k5T7BpEfZlaf0q9w
         zzyAeA6jMqcqXzV7+ZJcSJPEkuAp4xRSLQ+iSw204WunFm0qVPCy9Jj1Z63Tl4mdoKKs
         0O0lzfPfhowi4In5qoH9wbSa5PjHbemO8vWZ3tTzIE8m4IXgWat5pnH5R7RTn+kRwAJT
         VC187QgijL9t8ecX2L2jjSBh3MACNYVESSadqOxK7RKD9yoEgBFfXGXsuZlAa61JXYjG
         GbXw==
X-Forwarded-Encrypted: i=1; AFNElJ8DAtteVud+GBQGF909B17eprF7Ed65Q+EkA4ch2ac2x+FMT1kTC4aOM2AenQl8A05PkJdk7wkYSuWwrGKF@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7uwAanExEKjvRAKJxZffKwd7OpaynyWD6gPtSYThADUaf9pWE
	f62PuUXJq56kWd7nGF25etKoGH+i2WDTF/vZECevD7KX9UW/v18uOrEX8IrSI292
X-Gm-Gg: Acq92OF6Fx0pVdCc15Wm6LyJWyX/RKalJDX78qcyh74u1/xEnXGbPoAJvGgvvwW7+87
	BjaSppolD3SA+2ks/PEjob6kMxZR2T+LSTXs98ZLTl/a4gXKz7jTg2lJEq/5fNNvxMEUv9/9bht
	kgOE4mCzDwK1QjBkLEU3asmkuy49wbY99EjsPdUhb/5Ran5JLsV2/qjfZSdJeduw/q2krOId2M/
	2LlFaF3HCrH19woHD0w5jEQ/72s5vrNaRoB8KMFiBaoDedvFK29Vu7asURJxcqOOPev2/5qSUzw
	UT8/qlxda434yLa+OkwL62NJQsDonr05xogNmUZZk0LpyY/q6Q2iTTL23gK4JNamBWIgdm/wgEt
	sp2eGN9YDph5227A58hsttbFJQBHH52MYa27DP3VOvMfaFeURS8zSi11dDkwwEdxnoPHXtxv5Mo
	YoqwmiNaI/KI3tf8ea2qGqx2OeA0pu7D3hnhpqAL6XVi3WpjgzW1LHHBhq7Rk=
X-Received: by 2002:a05:600c:828e:b0:492:2e7a:9ba7 with SMTP id 5b1f17b1804b1-4923339fca0mr4919215e9.3.1781627631942;
        Tue, 16 Jun 2026 09:33:51 -0700 (PDT)
Received: from teknoraver-mbp.local.lan ([195.182.211.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923343c925sm1109105e9.0.2026.06.16.09.33.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 16 Jun 2026 09:33:51 -0700 (PDT)
From: Matteo Croce <technoboy85@gmail.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Timothy Redaelli <tredaelli@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matteo Croce <technoboy85@gmail.com>,
	Matteo Croce <teknoraver@meta.com>
Subject: [PATCH v4] fat: stop reading directory entries past the end-of-directory marker
Date: Tue, 16 Jun 2026 18:33:46 +0200
Message-ID: <20260616163346.32603-1-technoboy85@gmail.com>
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
 fs/fat/dir.c | 44 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index 4f6f42f33613..c6cca5d00ffd 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -130,6 +130,31 @@ static inline int fat_get_entry(struct inode *dir, loff_t *pos,
 	return fat__get_entry(dir, pos, bh, de);
 }
 
+/*
+ * Like fat_get_entry(), but honour the FAT end-of-directory marker:
+ * a dirent whose first name byte is NUL terminates iteration per the
+ * spec, which also guarantees that every following slot is zeroed.
+ * Skip straight to the end of the directory so the next call returns
+ * -1 from fat_bmap() without re-reading the trailing zero slots, and
+ * so callers that persist *pos across invocations (e.g. readdir's
+ * ctx->pos) keep reporting EOD.  Release *bh and set it to NULL to
+ * match fat_get_entry()'s contract that *bh is NULL on the -1 return.
+ */
+static int fat_get_entry_eod(struct inode *dir, loff_t *pos,
+			     struct buffer_head **bh,
+			     struct msdos_dir_entry **de)
+{
+	int err = fat_get_entry(dir, pos, bh, de);
+
+	if (err == 0 && (*de)->name[0] == 0) {
+		brelse(*bh);
+		*bh = NULL;
+		*pos = dir->i_size;
+		return -1;
+	}
+	return err;
+}
+
 /*
  * Convert Unicode 16 to UTF-8, translated Unicode, or ASCII.
  * If uni_xlate is enabled and we can't get a 1:1 conversion, use a
@@ -327,7 +352,7 @@ static int fat_parse_long(struct inode *dir, loff_t *pos,
 
 		if (ds->id & 0x40)
 			(*unicode)[offset + 13] = 0;
-		if (fat_get_entry(dir, pos, bh, de) < 0)
+		if (fat_get_entry_eod(dir, pos, bh, de) < 0)
 			return PARSE_EOF;
 		if (slot == 0)
 			break;
@@ -489,7 +514,7 @@ int fat_search_long(struct inode *inode, const unsigned char *name,
 
 	err = -ENOENT;
 	while (1) {
-		if (fat_get_entry(inode, &cpos, &bh, &de) == -1)
+		if (fat_get_entry_eod(inode, &cpos, &bh, &de) == -1)
 			goto end_of_dir;
 parse_record:
 		nr_slots = 0;
@@ -601,7 +626,7 @@ static int __fat_readdir(struct inode *inode, struct file *file,
 
 	bh = NULL;
 get_new:
-	if (fat_get_entry(inode, &cpos, &bh, &de) == -1)
+	if (fat_get_entry_eod(inode, &cpos, &bh, &de) == -1)
 		goto end_of_dir;
 parse_record:
 	nr_slots = 0;
@@ -885,7 +910,7 @@ static int fat_get_short_entry(struct inode *dir, loff_t *pos,
 			       struct buffer_head **bh,
 			       struct msdos_dir_entry **de)
 {
-	while (fat_get_entry(dir, pos, bh, de) >= 0) {
+	while (fat_get_entry_eod(dir, pos, bh, de) >= 0) {
 		/* free entry or long name entry or volume label */
 		if (!IS_FREE((*de)->name) && !((*de)->attr & ATTR_VOLUME))
 			return 0;
@@ -1302,6 +1327,7 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
 	struct msdos_dir_entry *de;
 	int err, free_slots, i, nr_bhs;
 	loff_t pos;
+	bool saw_eod;
 
 	sinfo->nr_slots = nr_slots;
 
@@ -1310,12 +1336,15 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
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
@@ -1325,6 +1354,13 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
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

