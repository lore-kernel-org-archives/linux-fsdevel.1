Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4592A3FF1A5
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2026 16:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790871708; cv=none; b=lk3XZTlE0MV+zAU2wtYN/HvwPUqCaXmgcn0aNOsNl4FkHeQYuKP3To0MahuP7MSuaIsyBgfFWu8h4xaW3DlQiejX1jGPKUb9r9zO7tDRCJKBw+GmqWC4MsFG45brKjS+4w+CnPfO8ELOiH96O8QyJp7YBpsN1DU9Kh4VgkhpiKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790871708; c=relaxed/simple;
	bh=ljhZbpLtZmCeMTtmscJsxatjioBy0YNX+KqIEHGZm98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ag8IJtFswkRiBu7ZLJbSDjdxuJ8NG2JYHFAy/cULBum/Tyn2J/j8m+0UJyZPzXFgdkOo0Vqd2T6TaNdW6IDmynjLuHPYfkRaJ6zsffYcjlwHw8jxvX3kddMeW3Pcapb+R7iPS1meajVcoQ0xewkTF5rICdrTopmV1tvOtGUTEXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8Es9q3k; arc=none smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8Es9q3k"
Received: by mail-yx2-f40.google.com with SMTP id 956f58d0204a3-67567ff2e77so2975624d50.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Oct 2026 09:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790871705; x=1791476505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ehELlp2TX+k3fIZ6MXGrY8CwmSbddu3hbPJ15v906Yw=;
        b=J8Es9q3ka5wWGDIioZgICP7THKDgelJbFmitmeKNMFinP6nAFq/73GMCbOAuYvGnQR
         L+aZhB7wNmIzr+hmLpScMWEpOC/MKuWRpfRlG+15s4kcQzr8JBo2XZjA4dW2P2bjBpBn
         4BNlQoAGeLJ22fz+xK8roxr21M6Gn6SeHO/f8bMJ9WBrM+6gUO2oJhw+BlOAA2Gvk1Zf
         cYiy7E68ybVPzD5mYpg0Ob/s67RNdwQbB1WtvSOiGtlg3CB+cJEb7DA0ObXJo36EKS1s
         PrxEXaaLkr1jdUdF+PEyVMKi7EybKXU1TpwfdExoph34/2OSRWLLwhoW6jNTDlbF+axm
         lB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790871705; x=1791476505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ehELlp2TX+k3fIZ6MXGrY8CwmSbddu3hbPJ15v906Yw=;
        b=zXJDRAGsry2kgnPg+Xm7XJhX+upQZLa0ImRBLCtNkP0e6LBcVDMb8eLB3a0hmRKbvu
         lKiweAYUZPTvP0NFoBSDbKW41EBpr9s2h/MrEd6piAKeJ2qYUKb/34tsK7r7pBLxM9U7
         /zmCBapoXBoyc8z+AfKrzhhzINASalv8NoO0ej5vM9j+IG+Qdnbkvm2VTVWfqHEwwp0e
         Wi282EVG9U/cdd1Dq24RcnioOh+q5CtZQ/V6kLXUjKA9bgLDkjD4C3E8xPy2HAYyKnG4
         cbwhH5baMEiTUqt8Xyzl4Uk6bHV00GJ8PpvPzLfWwoHMhqLkNRxB7bSjI2JoR8oJCanq
         TW1g==
X-Forwarded-Encrypted: i=1; AKwUvBxkgY81xxeW7EfJanuvh279JwwQuhBElS+7s/h9c+Cg6Q2YKIMzLa/msIRaZKoNhg6bUiMliZW/QjOOEnWJ@vger.kernel.org
X-Gm-Message-State: AFuF++nS6CrxucrNC+QDEfDoCKPfRQJ5wmOLv7hIKMjQcKeyLN5X3qKr
	OnlQ5wm2OxQxqx2XHCFHq/shKLlzCRH4XCUYr0sovlX8+wCXr0IUnNuKikS8gLc1aYfd4w==
X-Gm-Gg: AYBFou0EJXGzG5zx7X2iD6gVVwrlD267Vn0yqdOck2TwTnJLMB7db3SzPiCUyiBZn3c
	4aPx7jODoR8OBkZVVhgJvu6QaGz7W3SSDTqJ0nz5Uc+OITqJzv51pWvAleTHV1lIm6RRZ2QvCez
	sNAyH9dCNPea517hkzjB97pGePxnK8LzYbVBuMSwzQhJEukFDSS7WMKrBQU0mm75Avn6WsSSX4j
	quevBK0ZoC+xdd5yleSoIHq0bSsUNg2AyWxfIw8a6mBeYhqF/Ng6I6Y7VA3SBiXT3k6TfND4b4M
	a5PceMhRSNX7hJMQCutLvgG/pvdZ2gkwiZLekpj6BP1AFWXLH7FxYPclymVMAt+T0b6vcCxihuD
	Bcg33KYX6OfmbtFKiO9/Wu6xvnOsF/8UDwlWGlGacWUTXpsxj4Helwp3XmOGF26PrjS7OkrTvRs
	Liym23uJM95i2KWRiShRf2p5FqYvwo8yRIZWgyTVHxE/JQKPtRSVcCX9JzL4I/23wqUYdoEob8H
	7KhiJqqfQTMaCz4XSCtMm2aoIrsT7MzFt4VuodEVtxNj1dR8thLw2zvvketeHOpm7WnJ6k8Pe6g
	W5G8GnJ/JMz+VEqRwtFP6BZYjGCyItUsSArulzZ5wjYk5F2BMoWXXs66e8E=
X-Received: by 2002:a05:690e:4391:b0:672:da6e:d515 with SMTP id 956f58d0204a3-6768346cedbmr1886123d50.50.1790871704616;
        Thu, 01 Oct 2026 09:21:44 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-676918388b4sm1243584d50.8.2026.10.01.09.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 09:21:44 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] hfsplus: validate the wrapper and partition map before following them
Date: Fri,  2 Oct 2026 00:21:35 +0800
Message-ID: <2037378c974c98794dcd1d832e3c31628e9801b8.1790689266.git.matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1790689266.git.matthias.goergens@gmail.com>
References: <cover.1790689266.git.matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hfsplus_read_wrapper() rereads the volume header through a bare "goto
reread", following an HFS wrapper's embedded-volume descriptor or, if
the header matches neither signature, the partition map found by
hfs_part_find().  hfsplus_read_mdb() does not check the offset it
returns, and hfs_part_find() does not check the start of a new-style map
entry, so a descriptor or entry with a zero offset leaves part_start
where it was and the mount loops forever.

Check both where they are parsed.  TN1150 places the embedded volume in
the wrapper's allocation blocks, and the boot blocks, MDB and volume
bitmap of an HFS volume are not part of any allocation block.  So
hfsplus_read_mdb() now rejects a wrapper whose allocation blocks start
at or before its MDB (drAlBlSt <= 2), whose embedded volume is empty, or
whose embedded volume ends past the wrapper's last allocation block
(drNmAlBlks).  hfs_part_find() gets the same check as in hfs: a
partition must be non-empty, start inside the device and, for a
new-style map, start after the map, which begins at block 1 and whose
size the first entry's pmMapBlkCnt gives (TN1189).

A wrapper hop now moves part_start forward by at least three sectors,
and a partition-table hop moves it past the map entries it has read.  So
the loop ends, at the latest when a read goes past the end of the
device, and the maps read on the way do not overlap.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
v2: check the wrapper in hfsplus_read_mdb() and the entries in
hfs_part_find() instead of limiting the hops in hfsplus_read_wrapper().

A wrapper whose embedded-volume descriptor points back at itself hangs
the mount without this patch and fails at once with it:

  img=hfsplus-wrapper-loop.img
  put() { printf "$2" | dd of=$img bs=1 seek=$1 conv=notrunc status=none; }
  truncate --size=64K $img
  put $((1024 + 0x00)) '\x42\x44'          # drSigWord 'BD'
  put $((1024 + 0x0a)) '\x82\x00'          # drAtrb: SLOCK | SPARED
  put $((1024 + 0x14)) '\x00\x00\x02\x00'  # drAlBlkSiz 512
  put $((1024 + 0x7c)) '\x48\x2b'          # drEmbedSigWord 'H+'
  put $((1024 + 0x7e)) '\x00\x00\x00\x64'  # drEmbedExtent: start 0, count 100
  mount -o ro,loop -t hfsplus $img /mnt

The partition map from the hfs patch hangs an hfsplus mount the same
way, with "-t hfsplus".

 fs/hfsplus/part_tbl.c      | 24 +++++++++++++++++++++++-
 fs/hfsplus/wrapper.c       | 16 +++++++++++++++-
 include/linux/hfs_common.h |  1 +
 3 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/fs/hfsplus/part_tbl.c b/fs/hfsplus/part_tbl.c
index 9ec21664eda6b..ceba3139f1f56 100644
--- a/fs/hfsplus/part_tbl.c
+++ b/fs/hfsplus/part_tbl.c
@@ -67,6 +67,22 @@ struct old_pmap {
 	}	pdEntry[42];
 } __packed;
 
+/*
+ * Check a partition map entry before following it.  The partition must
+ * be non-empty, start inside the device and start at or after @first:
+ * after the driver descriptor map in block 0 for an old-style map, and
+ * after the whole of a new-style map, whose size the first entry's
+ * pmMapBlkCnt gives (TN1189).  Every hop then moves forward, past the
+ * map entries just read, so hfsplus_read_wrapper() cannot loop and
+ * reads each block of a map at most once.
+ */
+static bool hfs_part_valid(struct super_block *sb, sector_t base,
+			   u64 first, u32 start, u32 size)
+{
+	return start >= first && size &&
+	       base + start < bdev_nr_sectors(sb->s_bdev);
+}
+
 static int hfs_parse_old_pmap(struct super_block *sb, struct old_pmap *pm,
 		sector_t *part_start, sector_t *part_size)
 {
@@ -76,7 +92,9 @@ static int hfs_parse_old_pmap(struct super_block *sb, struct old_pmap *pm,
 	for (i = 0; i < 42; i++) {
 		struct old_pmap_entry *p = &pm->pdEntry[i];
 
-		if (p->pdStart && p->pdSize &&
+		if (hfs_part_valid(sb, *part_start, HFS_DD_BLK + 1,
+				   be32_to_cpu(p->pdStart),
+				   be32_to_cpu(p->pdSize)) &&
 		    p->pdFSID == cpu_to_be32(0x54465331)/*"TFS1"*/ &&
 		    (sbi->part < 0 || sbi->part == i)) {
 			*part_start += be32_to_cpu(p->pdStart);
@@ -99,6 +117,10 @@ static int hfs_parse_new_pmap(struct super_block *sb, void *buf,
 
 	do {
 		if (!memcmp(pm->pmPartType, "Apple_HFS", 9) &&
+		    hfs_part_valid(sb, *part_start,
+				   HFS_PMAP_BLK + (u64)size,
+				   be32_to_cpu(pm->pmPyPartStart),
+				   be32_to_cpu(pm->pmPartBlkCnt)) &&
 		    (sbi->part < 0 || sbi->part == i)) {
 			*part_start += be32_to_cpu(pm->pmPyPartStart);
 			*part_size = be32_to_cpu(pm->pmPartBlkCnt);
diff --git a/fs/hfsplus/wrapper.c b/fs/hfsplus/wrapper.c
index 30cf4fe78b3d2..35cd2563dfdfe 100644
--- a/fs/hfsplus/wrapper.c
+++ b/fs/hfsplus/wrapper.c
@@ -66,7 +66,7 @@ int hfsplus_submit_bio(struct super_block *sb, sector_t sector,
 static int hfsplus_read_mdb(void *bufptr, struct hfsplus_wd *wd)
 {
 	u32 extent;
-	u16 attrib;
+	u16 attrib, nmalblks;
 	__be16 sig;
 
 	sig = *(__be16 *)(bufptr + HFSP_WRAPOFF_EMBEDSIG);
@@ -87,11 +87,25 @@ static int hfsplus_read_mdb(void *bufptr, struct hfsplus_wd *wd)
 		return 0;
 	wd->ablk_start =
 		be16_to_cpu(*(__be16 *)(bufptr + HFSP_WRAPOFF_ABLKSTART));
+	nmalblks = be16_to_cpu(*(__be16 *)(bufptr + HFSP_WRAPOFF_NMALBLKS));
 
 	extent = get_unaligned_be32(bufptr + HFSP_WRAPOFF_EMBEDEXT);
 	wd->embed_start = (extent >> 16) & 0xFFFF;
 	wd->embed_count = extent & 0xFFFF;
 
+	/*
+	 * The boot blocks, MDB and volume bitmap of an HFS volume are not
+	 * part of any allocation block, and the embedded volume occupies
+	 * allocation blocks of the wrapper (TN1150).  So the embedded
+	 * volume starts after the wrapper's MDB and ends inside the
+	 * wrapper.
+	 */
+	if (wd->ablk_start <= HFS_MDB_BLK)
+		return 0;
+	if (!wd->embed_count ||
+	    wd->embed_start + wd->embed_count > nmalblks)
+		return 0;
+
 	return 1;
 }
 
diff --git a/include/linux/hfs_common.h b/include/linux/hfs_common.h
index d6a615e74b26e..123475efe5b37 100644
--- a/include/linux/hfs_common.h
+++ b/include/linux/hfs_common.h
@@ -44,6 +44,7 @@
 
 #define HFSP_WRAPOFF_SIG		0x00
 #define HFSP_WRAPOFF_ATTRIB		0x0A
+#define HFSP_WRAPOFF_NMALBLKS		0x12
 #define HFSP_WRAPOFF_ABLKSIZE		0x14
 #define HFSP_WRAPOFF_ABLKSTART		0x1C
 #define HFSP_WRAPOFF_EMBEDSIG		0x7C
-- 
2.55.0

