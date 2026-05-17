Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029BF3C65E0
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2026 18:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779041415; cv=pass; b=Uerkq7aFdk662g1dIgFima1gQOwXFnFX+EiuMi7MEzDB3TAbD3LXnQlhnqZBS2WlJR8rZjZ1c+L4QThxh7RBnfDVkc9zuU1v1ksdP0GCWVW4jHDQs4da4UmNbshonehXRezdmbiTr+or5wEiU/3GIWM5E+Ij7HhphIKzBTmEon8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779041415; c=relaxed/simple;
	bh=3RjzoefNijAAtEdYReG43SQT1lH5gYJxCVcBcogk8UE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CIq3i2ynRVI3+SVdBqlssHjZHyuJdXshr3Wj2gVOI4ssjT+znc6H/o+N7pNlKgNZ99FQ8CmOoygI8g+PhrE6ELEeT+I3JuW4EofnuKwqDS+8CE/6w+cMniizbkwdl30THsYLPlfOax8b5P4zS+qqUBe9wvcxC7ObD0f/2FUm03s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=skydio.com; spf=pass smtp.mailfrom=skydio.com; dkim=pass (2048-bit key) header.d=skydio.com header.i=@skydio.com header.b=X2b2XG24; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=skydio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skydio.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=skydio.com header.i=@skydio.com header.b="X2b2XG24"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7bf14e33f5bso8795927b3.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2026 11:10:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779041412; cv=none;
        d=google.com; s=arc-20240605;
        b=Omd5DAW7XyeFCP4ifT9L5HiX4q3q0N3+W4uQrD3PZ1fibWiy+1iozHGTwNUgMjz59L
         WEqjEctQ4uMiqHCuHx2f4GJ5h3i18MzFw7r+9yGUqJBr0XJFYR9d0crswGxegy/p/fv5
         NNz44UFWofZyq+OH44lFgs1I2S186mE2n7OB7SEoO9lfIgSiAn+SyuCKQMEy/g5PDFm2
         IzHtx2dR9GDnRczUhRpnCThSLck2q2iO5GTUJu1vISAP6SwtQtVMYOunOyIGi+ZEARha
         PV2hzXMnwsKKQC4JuUZFCY4DB7XuDuDsqHjTKdU4holyDeIzsy89oNWzg+KnzfrWfbau
         n1dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3RjzoefNijAAtEdYReG43SQT1lH5gYJxCVcBcogk8UE=;
        fh=yvVpoD4m4ONiG9Bk6vDT8mruprHNPexjYRCIqNNKjpc=;
        b=dvwTJpURBwOrGiRLAlYbvQOjqySEgAO+bSDoZSPxX2fkDPVT42zN1HHzFWjwgd+Gni
         +KZXTBel/ADw+I7kMXQ3uraUUL/PH26e2A7nsTd9vLuq2iLF98dI5InwfLNN2/zgZQAo
         hdM1zwbm6W8x436BfeFmWkuuvNh/5JkAx4Qr0d3EOMfzectN6//xc5+vl0C6P1wEipaz
         +GmZOEJjbI0BRlK9s4bTDsrKZTnxZ8Adt3MGriCknZ88P5jqtSsHK2NfhpLsE1Z4BSoO
         sAhx9gxrtd8OAqMuQdzgdpNkkw6oiae7l8f6xFc7nx7jWz2QdCyUbRgSEVR3lJsRFF8f
         ouDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google; t=1779041412; x=1779646212; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3RjzoefNijAAtEdYReG43SQT1lH5gYJxCVcBcogk8UE=;
        b=X2b2XG246h8Jj9slsPgWefGX+hTuA/cjZy8O4bVpF6X6Pz1srweFkVIPpYDm1SwnH2
         Umuf1ckDBfC+jfsBFqxaamQjMGa2q3MS91Zab3seiARwTX7sPpUVtEoazrZ+eQolLsiF
         HmdbuqFHx3GJGcSy74lEElDbt25GvIyM8/JNLGkm7ozsno1JbsLv1gSYsv+sfr/5i9rr
         lRjB9i5KonNmDWIs/or2mTeAMPGHAqcZP8sKGC3M6KUkvkx0d78fFjYRp//h8GnV6kRU
         1nkJHZYOl9OGHq1xPPYWU9yX63Pk+HS3df0/LgWlJnkp41XU0CzEdWSAiZiTLRb1qEaY
         /1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779041412; x=1779646212;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RjzoefNijAAtEdYReG43SQT1lH5gYJxCVcBcogk8UE=;
        b=k+xAKCTz0z8NQlt4KnPUE8jRqVZ4loIiY2JYtYNtS13i5r9mgWzDxMvwoO09v5/35u
         PU9pn0GNICRkdRM0YZ9WGixMiq2IyIAsZcma9KeQbb1VQ8LfbffyYoGcprdni8xDC3kW
         J/P+42oaBa1otHEaDJAsHtwvECl6cjeRI+QeTwO/WORjkEIe1kMYh4j4/Alun3qsNE0K
         D2uMXSMkxCMR4uJ6E4Re4+lO60tL+t7Ib8ZbB0Du0v8kGFAbzeaZZgleFqXBWHqDWbbv
         xABWg1b4wiYxFymGwOELjEi46tpbNA2osBaWeP2HLKwNsV+t8Agffujc8Ozpx4N++8CU
         hABw==
X-Gm-Message-State: AOJu0YzJHocE0cLYIDt1H8+C1jGd28vq5yA3Inn9y2YysumlluFrirur
	rAaw/6/bN+MtqbAMYAy14p8UaJSNfNEPcz0l7QbMft5fyStPmBUc9ZrZcpvLkKRM2hUMQLf0/r2
	YwQc4f32I4oucSz6XwQDqwRcmJHKpWPPIuvksRQVdQtTsGxwWCqvBLcJ98w==
X-Gm-Gg: Acq92OE1y2++m5ZnaOzPWltlG+B1eUSAIp06YxYpk298VDIRk6A+1MP71tJQhShi+1G
	vgjqLOjwWJ5boaWmGnJwY9EPkVPnDi/LiVaeoFC6EcLLvr1JLC3c5SvjuV/AT/zpYHL7WKGUNUu
	VDzwA58HDZb/Ss5RUUp14Q45PopigDR1q+J4YGArUNWfITOVUA53WrbN4lDfnoPcU/KKNpLeEgs
	5paN9WLny2ZrqAFlIEGReu8mhFtQrllEEdiYQyJWbugRNiwRjQQ/rKjUL1XqwglAwyqXRiWjD1y
	Gyr3ovU=
X-Received: by 2002:a05:690c:7:b0:7bd:4a12:f7ff with SMTP id
 00721157ae682-7c95c00e3c2mr132007357b3.38.1779041411833; Sun, 17 May 2026
 11:10:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG7tbBV--waov7XVu2FHQEc6paR92dufS=em9DW5Kzsrpu3iQg@mail.gmail.com>
 <CAKYAXd8z00CwRgbQbU8U15svgyOT6RK4XH-xcaq7k3dBbsRqew@mail.gmail.com>
In-Reply-To: <CAKYAXd8z00CwRgbQbU8U15svgyOT6RK4XH-xcaq7k3dBbsRqew@mail.gmail.com>
From: Rochan Avlur <rochan.avlur@skydio.com>
Date: Sun, 17 May 2026 11:10:00 -0700
X-Gm-Features: AVHnY4KS8eUXtGUL7UmSGAp6-ctGKp5diINeyR7li4pSbHisXSocJLDaK1-HIxg
Message-ID: <CAG7tbBWWw5pN8OtXyD4f=OYTZqXzOsm4fnj=S-sZW2tuG_FqRg@mail.gmail.com>
Subject: [PATCH] exfat: preserve benign secondary entries during rename and move
To: linux-fsdevel@vger.kernel.org
Cc: linkinjeon@kernel.org, sj1557.seo@samsung.com
Content-Type: text/plain; charset="UTF-8"

From 6b93a97d1999e7b30ecd24ead027f25cf25aae0c Mon Sep 17 00:00:00 2001
From: Rochan Avlur <rochan.avlur@skydio.com>
Date: Sun, 17 May 2026 10:57:05 -0700
Subject: [PATCH] exfat: preserve benign secondary entries during rename and
move

Commit 8258ef28001a ("exfat: handle unreconized benign secondary
entries") added cluster freeing for benign secondary entries inside
exfat_remove_entries(). However, exfat_remove_entries() is also called
from the rename and move paths (exfat_rename_file and exfat_move_file),
where the old entry set is being relocated rather than deleted. This
causes benign secondary entries such as vendor extension entries to be
silently destroyed on rename or cross-directory move, violating the
exFAT spec requirement (section 8.2) that implementations preserve
unrecognized benign secondary entries.

Fix this by introducing exfat_remove_entries_nofree() that marks entries
as deleted without freeing benign secondary clusters, and helper
functions to count and copy trailing benign secondary entries from the
old entry set to the new one. Both exfat_rename_file() and
exfat_move_file() now use these to preserve extra entries across
relocation.

Fixes: 8258ef28001a ("exfat: handle unreconized benign secondary entries")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/linux-fsdevel/CAG7tbBV--waov7XVu2FHQEc6paR92dufS=em9DW5Kzsrpu3iQg@mail.gmail.com/
Signed-off-by: Rochan Avlur <rochan.avlur@skydio.com>
---
fs/exfat/dir.c | 14 ++++++
fs/exfat/exfat_fs.h | 1 +
fs/exfat/namei.c | 102 +++++++++++++++++++++++++++++++++++++++-----
3 files changed, 107 insertions(+), 10 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 3045a58e1..1894f839e 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -523,6 +523,20 @@ void exfat_remove_entries(struct inode *inode,
struct exfat_entry_set_cache *es,
es->modified = true;
}
+void exfat_remove_entries_nofree(struct exfat_entry_set_cache *es, int order)
+{
+ int i;
+ struct exfat_dentry *ep;
+
+ for (i = order; i < es->num_entries; i++) {
+ ep = exfat_get_dentry_cached(es, i);
+ exfat_set_entry_type(ep, TYPE_DELETED);
+ }
+
+ if (order < es->num_entries)
+ es->modified = true;
+}
+
void exfat_update_dir_chksum(struct exfat_entry_set_cache *es)
{
int chksum_type = CS_DIR_ENTRY, i;
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 176fef625..9b6dd3dab 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -500,6 +500,7 @@ void exfat_init_ext_entry(struct
exfat_entry_set_cache *es, int num_entries,
struct exfat_uni_name *p_uniname);
void exfat_remove_entries(struct inode *inode, struct exfat_entry_set_cache *es,
int order);
+void exfat_remove_entries_nofree(struct exfat_entry_set_cache *es, int order);
void exfat_update_dir_chksum(struct exfat_entry_set_cache *es);
int exfat_calc_num_entries(struct exfat_uni_name *p_uniname);
int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index dfe957493..8c33d9dfb 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -1008,6 +1008,52 @@ static int exfat_rmdir(struct inode *dir,
struct dentry *dentry)
return err;
}
+/*
+ * Count benign secondary entries beyond the filename entries.
+ * Returns the count, or -EIO if the entry set is inconsistent.
+ */
+static int exfat_count_extra_entries(struct exfat_entry_set_cache *es)
+{
+ struct exfat_dentry *stream;
+ unsigned int name_entries;
+ int extra;
+
+ stream = exfat_get_dentry_cached(es, ES_IDX_STREAM);
+ name_entries = EXFAT_FILENAME_ENTRY_NUM(stream->dentry.stream.name_len);
+ extra = es->num_entries - (ES_IDX_FIRST_FILENAME + name_entries);
+
+ return extra >= 0 ? extra : -EIO;
+}
+
+/*
+ * Copy benign secondary entries from @src_es to @dst_es, placing them after
+ * the new filename entries. Updates num_ext and the directory checksum.
+ */
+static int exfat_copy_trailing_entries(struct exfat_entry_set_cache *src_es,
+ struct exfat_entry_set_cache *dst_es)
+{
+ struct exfat_dentry *ep;
+ int extra = exfat_count_extra_entries(src_es);
+ int new_entries = dst_es->num_entries - extra;
+ int i, src_start = src_es->num_entries - extra;
+
+ if (extra == 0)
+ return 0;
+ if (extra < 0 || new_entries < ES_IDX_FIRST_FILENAME ||
+ src_start < ES_IDX_FIRST_FILENAME)
+ return -EIO;
+
+ for (i = 0; i < extra; i++) {
+ *exfat_get_dentry_cached(dst_es, new_entries + i) =
+ *exfat_get_dentry_cached(src_es, src_start + i);
+ }
+
+ ep = exfat_get_dentry_cached(dst_es, ES_IDX_FILE);
+ ep->dentry.file.num_ext += extra;
+ exfat_update_dir_chksum(dst_es);
+ return 0;
+}
+
static int exfat_rename_file(struct inode *parent_inode,
struct exfat_uni_name *p_uniname, struct exfat_inode_info *ei)
{
@@ -1016,6 +1062,8 @@ static int exfat_rename_file(struct inode *parent_inode,
struct super_block *sb = parent_inode->i_sb;
struct exfat_entry_set_cache old_es, new_es;
int sync = IS_DIRSYNC(parent_inode);
+ unsigned int num_old_name_entries, num_new_name_entries;
+ unsigned int num_extra_entries, num_total_entries;
if (unlikely(exfat_forced_shutdown(sb)))
return -EIO;
@@ -1023,21 +1071,34 @@ static int exfat_rename_file(struct inode *parent_inode,
num_new_entries = exfat_calc_num_entries(p_uniname);
if (num_new_entries < 0)
return num_new_entries;
+ num_new_name_entries = EXFAT_FILENAME_ENTRY_NUM(p_uniname->name_len);
ret = exfat_get_dentry_set_by_ei(&old_es, sb, ei);
- if (ret) {
- ret = -EIO;
- return ret;
- }
+ if (ret)
+ return -EIO;
epold = exfat_get_dentry_cached(&old_es, ES_IDX_FILE);
- if (old_es.num_entries < num_new_entries) {
+ ret = exfat_count_extra_entries(&old_es);
+ if (ret < 0)
+ goto put_old_es;
+ num_extra_entries = ret;
+ num_total_entries = num_new_entries + num_extra_entries;
+ /* needed to detect whether in-place rename would shift extras */
+ num_old_name_entries =
+ old_es.num_entries - ES_IDX_FIRST_FILENAME - num_extra_entries;
+
+ /*
+ * Relocate when the old slot is too small, or when extra
+ * entries exist and the name entry count changes.
+ */
+ if (old_es.num_entries < num_total_entries ||
+ (num_extra_entries && num_old_name_entries != num_new_name_entries)) {
int newentry;
struct exfat_chain dir;
newentry = exfat_find_empty_entry(parent_inode, &dir,
- num_new_entries, &new_es);
+ num_total_entries, &new_es);
if (newentry < 0) {
ret = newentry; /* -EIO or -ENOSPC */
goto put_old_es;
@@ -1056,11 +1117,15 @@ static int exfat_rename_file(struct inode *parent_inode,
exfat_init_ext_entry(&new_es, num_new_entries, p_uniname);
+ ret = exfat_copy_trailing_entries(&old_es, &new_es);
+ if (ret)
+ goto put_old_es;
+
ret = exfat_put_dentry_set(&new_es, sync);
if (ret)
goto put_old_es;
- exfat_remove_entries(parent_inode, &old_es, ES_IDX_FILE);
+ exfat_remove_entries_nofree(&old_es, ES_IDX_FILE);
ei->dir = dir;
ei->entry = newentry;
} else {
@@ -1069,8 +1134,13 @@ static int exfat_rename_file(struct inode *parent_inode,
ei->attr |= EXFAT_ATTR_ARCHIVE;
}
- exfat_remove_entries(parent_inode, &old_es, ES_IDX_FIRST_FILENAME + 1);
+ exfat_remove_entries_nofree(&old_es,
+ num_new_entries + num_extra_entries);
exfat_init_ext_entry(&old_es, num_new_entries, p_uniname);
+ if (num_extra_entries) {
+ epold->dentry.file.num_ext += num_extra_entries;
+ exfat_update_dir_chksum(&old_es);
+ }
}
return exfat_put_dentry_set(&old_es, sync);
@@ -1086,6 +1156,7 @@ static int exfat_move_file(struct inode *parent_inode,
struct exfat_dentry *epmov, *epnew;
struct exfat_entry_set_cache mov_es, new_es;
struct exfat_chain newdir;
+ unsigned int num_extra_entries, num_total_entries;
num_new_entries = exfat_calc_num_entries(p_uniname);
if (num_new_entries < 0)
@@ -1095,8 +1166,14 @@ static int exfat_move_file(struct inode *parent_inode,
if (ret)
return -EIO;
+ ret = exfat_count_extra_entries(&mov_es);
+ if (ret < 0)
+ goto put_mov_es;
+ num_extra_entries = ret;
+ num_total_entries = num_new_entries + num_extra_entries;
+
newentry = exfat_find_empty_entry(parent_inode, &newdir,
- num_new_entries, &new_es);
+ num_total_entries, &new_es);
if (newentry < 0) {
ret = newentry; /* -EIO or -ENOSPC */
goto put_mov_es;
@@ -1115,7 +1192,12 @@ static int exfat_move_file(struct inode *parent_inode,
*epnew = *epmov;
exfat_init_ext_entry(&new_es, num_new_entries, p_uniname);
- exfat_remove_entries(parent_inode, &mov_es, ES_IDX_FILE);
+
+ ret = exfat_copy_trailing_entries(&mov_es, &new_es);
+ if (ret)
+ goto put_mov_es;
+
+ exfat_remove_entries_nofree(&mov_es, ES_IDX_FILE);
ei->dir = newdir;
ei->entry = newentry;
--
2.45.2
