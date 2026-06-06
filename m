Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638E023EAB8
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Jun 2026 10:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780743266; cv=none; b=WX0myWPMC9/BRPhCn0Y09CLGh8cBPRB/LAh5h+H0Oc3KISiIbmESfUEfWASVXbxr4AUp/0G97XIC7jA/jlRPavt1TBXm2lDbfCCFsArvuCVJrmCtUSDC4z9DCVcyVsuf12EmB2DevNPWPivo2Hi/mITaG8k5k3ob0RXhoA7jHo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780743266; c=relaxed/simple;
	bh=oeoEJ9W1XVpjGTrxUUmi9T31Za0AID7tKfHQLHj/PWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VbwGRjELBouNtQNcSsO1J/qJ+UEcqNy46tNunlDPF0mNiold67ZnNatFCRll/abvP6QdP25l4qzywhEZXygbrtx/AB7t2cOELz8eCTAOPgoHW0kMyHkKTovl1cey+DyG+2+otWA2LopMGwYP6T1LunCRg33c/thgUmX0dfD75uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jshMtjYe; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jshMtjYe"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45eeba68948so1787865f8f.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 Jun 2026 03:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780743264; x=1781348064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+AJSFzrr5zpyMoKiDGSq4fh1tbHBNpuAmHOkyOL2p/o=;
        b=jshMtjYejpsDK2fmdu5TsafGe9qYNScI5gAJMnGhfcNeH3NbwX5IxQfemsHnlWpXK4
         erBH0O9bPApAc/38r+ZMLA7hAIYtPgvykg2hBEZ1NbocajHltHgRJvo+/ECyhXXgR7oD
         35KYMvhD3GsUjsQpAwDXV5bXnhgjnYhBg+uUV0q/huiNQhu7UqHpLcWRHcjwX5N/V1u3
         UcmSR1jsDlH/nsG1nDp17Vs1bbEYerngaD/607nUnsj20FTqeNhgx9TxjFCFKq+xXH8A
         zyGzIFhO3JYgBj4T7pAOtSNJcfB+q4YnTu/8Cg67h0wqq6kC18huK7C6FsO/qOeqxVz/
         2y6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780743264; x=1781348064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+AJSFzrr5zpyMoKiDGSq4fh1tbHBNpuAmHOkyOL2p/o=;
        b=QzeOHIhqfLWPQoFdl9gLUpngIr1LdvhOw5/wiXZi3hKzWDN9oZGvIyIdfFcnOJEhR6
         vMXAyyAv2Q4VU8zT9SFxhbqp9lY93kDKkYNAGtt07lnhjKmQk6VpUE2YOEm+qR5iXagd
         uHr7a34S1jVQEji2s1A4eZV7vM8YdzH+iZ6YshQQ9qGlgRnX7vYYdc7k8xLr8uv4CYHE
         zPhwzC9HK6r2jLMt6/6fYeJDtlk2A+KlCpmzbN98K3iy/vIwoij/hUeXBHmGMKoFki7o
         BCbY03mwPMaXIAFKGoga7PF4hQx/IdEs5NZe5oy0bVg1i44EWYM0IH9V2Ja6JQhh0kDN
         GSZw==
X-Forwarded-Encrypted: i=1; AFNElJ/SrzVxJ/QlbsQ+4zYg65Rnrhy2ngj8IEfpB/Q7ktTYLlF1Mj8Z9VCC7AdI14uVwcr61BWfhkkQyH5kmMJx@vger.kernel.org
X-Gm-Message-State: AOJu0YwW74kn+i91+EoPGYxBtMFbCAiu1/gqGWb8Jl7dhDIqm+TeXQMN
	844nUFvnnPfVNXPBakiGJvnJzayHHVdY92ephDKVlcaVZEHNRoRRjzOc
X-Gm-Gg: Acq92OGSOWe3Ky/FPNogd0M9IweDCwkzFl0xdndx+QmkMAmycy4284yS+oJ2iIQvNEn
	gGl0E9BND0irD1MJy+a7DPOYzHC03zX9Ucqj4lLFyW/iPrz7ec8kEA+n4VflFMysRhzg1gUu/DJ
	edjIpEBKxGJzdlGsXhgregbgIq5GlTx3r8Z3xW1z2tb66L7KA3L+VzC6cAD57PUPRMPNufsNyMU
	clqMiIDjOztwsDPlKqhm2BEi4xw0koQTl040Kk1Hs5RFZ0fMdlIYdOPjqvlfUvL6zxd3fywH1f3
	izOL4I6J6jmOvUTqySG77x2jIhN7GkE4GaROtHBHNApAhCfpr9Lxxr0zAdPEIMmY6td/iWx9YpT
	ZWVav7yS0oYFcUnVu2dYGN1xTs/1s39dd8t7QIHaw1UWI58u90EKH/gqX8huC31ZawQUx2uU2cC
	bN0z+m/m6fp3yN+O9fNYb1WfTs22adhF/4Gj8izCFMz3yBEybCi3y3ZH1jdW3qFsQ8f8aH4w==
X-Received: by 2002:a5d:464f:0:b0:460:1695:89c9 with SMTP id ffacd0b85a97d-46030501a85mr8832824f8f.24.1780743263315;
        Sat, 06 Jun 2026 03:54:23 -0700 (PDT)
Received: from teknoraver-mbp.local.lan ([195.182.211.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351d69sm58166070f8f.29.2026.06.06.03.54.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 06 Jun 2026 03:54:22 -0700 (PDT)
From: Matteo Croce <technoboy85@gmail.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Timothy Redaelli <tredaelli@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matteo Croce <technoboy85@gmail.com>,
	Matteo Croce <teknoraver@meta.com>
Subject: [PATCH v2] fat: stop reading directory entries past the end-of-directory marker
Date: Sat,  6 Jun 2026 12:54:20 +0200
Message-ID: <20260606105420.26641-1-technoboy85@gmail.com>
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
    free/zero slots. fat_add_entries() additionally now logs a
    rate-limited warning suggesting fsck if it sees an allocated entry
    after a 0x00 marker (the spec violation that produces the garbage).

[1] https://download.microsoft.com/download/1/6/1/161ba512-40e2-4cc9-843a-923143f3456c/fatgen103.doc
[2] https://lore.kernel.org/lkml/20181207013410.7050-1-mcroce@redhat.com/
[3] https://lore.kernel.org/lkml/20181216231510.26854-1-mcroce@redhat.com/
[4] https://lore.kernel.org/lkml/20190201001408.7453-1-mcroce@redhat.com/

Reported-by: Timothy Redaelli <tredaelli@redhat.com>
Suggested-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Signed-off-by: Matteo Croce <teknoraver@meta.com>
---
 fs/fat/dir.c | 40 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index 4f6f42f33613..f2869549377a 100644
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
@@ -1325,6 +1351,12 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
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
2.50.1

