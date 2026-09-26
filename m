Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FEA357CE1
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2026 02:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790390118; cv=none; b=rCWB3vCMUOf3w5iAabElbm1m76LHAhSLuuPwlTXMu139Q/+whN5RPyoJFfxXvfYPeoUygHuD0ha+1Eh0veXKao6Rk+U9NpKCErrZeQIiXeI6WgGpolF3rytbbF+lHr07bYlUum+KtOaCz7b9W1qL5KpA0Ghbo7MsrpCz1p76K5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790390118; c=relaxed/simple;
	bh=vZJPbgJPdsXpKopo28Dsi+J0Feh0C3IQQRqQQTBqjPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fpkRCRpl7lMkV+YsxuJYtXMSPFLQkdKyhJDz8czAs12CPyGlx76P1xSq5NRDBf0srVwoFPKWM6zL7a3/1GDsX50I1KxABlnSrKn89hwGtUnoY8eOPzpyi1LtdYWtLAwlBysv4egRktuSVo0tSoScR62TV6jZMJXGqZ2PCAE2DZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qvalIY2W; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvalIY2W"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d90ba1d807so11570085ad.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 19:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790390116; x=1790994916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zTNC5edU10uB/RUSjLI3cwaqFAWGhgn7z7X8/RqAWVs=;
        b=qvalIY2W3ZjhAQWwygxxlcpEjwKS3Qa3BhJtooenciJQxNCGGckqd8CkoTLMb/g42F
         TFdN3mm9PneLXmvz36y1S30KDVw4xD5X8F1KJnRyvpN8af4hYRCiS6eGKy6D5m310OMg
         521Ys0rrBp2Pf9X12mZtLCKf+8jmkRPmEd/nu+UlPIkNlUjiGy4J/n65gO6MbMG2VtRn
         o2ZDtgYbq2C4ypr1hnXEEVcSEj5PqVO+WXpikAMtHMFS/SqqBFa4kBg3ke8i0R3kNZao
         LFBMNA5woJDCSfz/uhrFAPuDmNAQrwj+c47ow8Ms0/mKKfm1SncUOIk5g8aFIlKmKlvy
         5Ewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790390116; x=1790994916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zTNC5edU10uB/RUSjLI3cwaqFAWGhgn7z7X8/RqAWVs=;
        b=MOlFCv4nT+qhu+Fh9ipOjJpr/k+8trPCiiT1y6lF3t28MLTRC9B6kMlU7qWw3qLXqT
         Q4XLiq8AFuG82r2Umsm0DumtQbGoXbxmYvB4qQAPv99cai8+Y+aUoL8PSruyuYfBjUtO
         q2HFzJUkEBNtctcyHcYwR9j/ZgCAm4OYYTRD+3LedniUAaYBwUmAaD17+CJWLlljwRHl
         2kTpnn1jpXAuBRo+vhAV4yy25tEKSJhjUFI7qISEkjInoQeUVdNmLgzzAJckB4nUraKe
         JuAdpmm8Ma7FK0vxGEZrcqtxiPcvhx3TsSej4krEGSOnx27dpnRFBq+SRn3p1wZC3NKb
         Mxyg==
X-Gm-Message-State: AFuF++nerHvixziRH/cOklLkXfTHLlRsO3dMGfRwiMOEObrBnMLLXRPI
	f+tjg1zKuPAqXvSX5KbzkD7h9MOjFg/67QeDdMcMMxr1p0AwgS+lC6GU
X-Gm-Gg: AYBFou2HII0Wyt6+TmcXQWCR3T32YnIRu/SjcrzYwvgzs0l39ZhobbzJ3Pby2A+bgEK
	ykhii7fJzlX13Ik1996DyIDzC7vgsMlifnKMlPnB0YgiMTLrAOiXU58WiDNGtNioSvgt5WCbrX9
	Xvq1YqasKwL0Z2ZiW0vcWIZtYa1O5kCb5KGANpZ94+hi/r7JKEVN4pg/W+J5mxlPXZWgEkyYmUG
	/ouLeGVISO/hOKt51j3cpuqPydSfT2r4IpEFyXCfs5LioAHBJrufjYfb9ryj6pDSSxkW2bHxN0A
	mljYtgx+2/LrmqfafKbik0uwUN00xUF/prHXlG0rP4zuqhYPQkpMIzZTZonkMgfkEIGyPdwgfXl
	038HXsjWZtHacUWoAldR1im5NbYwvFenSpLXaKArdaN8NPRkbRy2L0wOrh19O/Rgbq5WaXlvic1
	2qnpDJ3VKhZf/gALQA+Sr2kA+UlE5WnHJDTVZ4kegs444qxqplMTLNCtcriVRT8sbcjmZYQip0L
	/Kqj8NoTvDop80WTQOfsIzMBQ4j+KZ44B3BduX5pAVzSTd4UVjQDERH72M0iGXzK/n8IAwkqHpY
	mldeFkooIno/lq3W11xviO+0bqoMJPL0/ZuX1qzj8z9eK/WiefIkZq87lsQ=
X-Received: by 2002:a17:90b:384c:b0:3a0:c8e6:ab23 with SMTP id 98e67ed59e1d1-3a0c8e6b96bmr2206750a91.54.1790390116029;
        Fri, 25 Sep 2026 19:35:16 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b99917besm7163204a91.14.2026.09.25.19.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 19:35:15 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: jack@suse.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] udf: don't let a stale metadata buffer overwrite expanded file data
Date: Sat, 26 Sep 2026 10:35:12 +0800
Message-ID: <20260926023512.3035718-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 62333e480d12 ("udf: Fix data loss when converting inline
inodes to out of line"), udf_expand_file_adinicb() allocates the data
block itself with udf_map_block() and then writes the folio with
filemap_fdatawrite().  Writeback maps the block through
udf_get_block_wb(), which does not allocate, so the buffer is never new
and nothing calls clean_bdev_aliases() for the block, as the generic
code does for every block get_block() reports as new.

A recently freed block can still have a dirty buffer in the block device
page cache.  The common case is the file entry of a deleted file:
udf_evict_inode() updates it with sync_inode_metadata(), which for an
inode that is not IS_SYNC only marks the buffer dirty, and then frees
the block.  If that block becomes the data block of an expanded file,
the next writeback of the block device writes the old file entry over
the file's data.

On a fresh mkudffs image, creating 20 small files, deleting them and
then creating five files with "printf hello >f; truncate -s 3000 f"
leaves all five with a deleted file's extended file entry as their first
block after sync and remount.  This happened in 400 of 400 runs, on
bitmap and table images alike.  When the file is extended by writing
instead of truncating, the write dirties the data again and the outcome
depends on writeback order: the data was corrupted in about 7% of runs.

Clean the aliases of the new block, as block_write_begin() and
mpage_writepages() would have done.

Fixes: 62333e480d12 ("udf: Fix data loss when converting inline inodes to out of line")
Cc: stable@vger.kernel.org
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
This is a regression in v7.3-rc1, and 62333e480d12 is also in 7.2.6 and
6.18.52.  On 7.2.7 and 6.18.54 the truncate case corrupts the data in
400 of 400 runs, as on mainline, and the write case in 10 and 7 of 400
runs; with this patch, which applies cleanly to both, there was no
corruption in 400 runs of either case.  Before 62333e480d12, extending
the file by writing was safe (no corruption in 400 runs with it
reverted): the write allocated the block through udf_get_block(), which
marks it new, so block_write_begin() cleaned the alias.  Truncating up
lost the data before 62333e480d12 as well, which is what that commit
fixed.

To reproduce, run this as root in a VM; cmp reports every corrupted
file:

#!/bin/sh
img=/tmp/udf.img mnt=/tmp/udf.mnt
truncate -s 1M $img
mkudffs $img >/dev/null
mkdir -p $mnt
mount -t udf -o loop $img $mnt
for i in $(seq 20); do echo small >$mnt/s$i; done
rm $mnt/s*
for i in $(seq 5); do
	printf hello >$mnt/f$i
	truncate -s 3000 $mnt/f$i
done
sync
umount $mnt
mount -t udf -o loop $img $mnt
printf hello >/tmp/expect
truncate -s 3000 /tmp/expect
for i in $(seq 5); do cmp $mnt/f$i /tmp/expect && echo "f$i ok"; done
umount $mnt

 fs/udf/inode.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index e45e546a739a..804554d26595 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -442,6 +442,13 @@ int udf_expand_file_adinicb(struct inode *inode)
 	err = udf_map_block(inode, &map);
 	if (err < 0)
 		goto restore;
+	/*
+	 * The block may have held metadata that is still dirty in the block
+	 * device page cache (e.g. the file entry of a deleted inode). Make
+	 * sure writeback of that buffer cannot overwrite our data.
+	 */
+	if (map.oflags & UDF_BLK_NEW)
+		clean_bdev_aliases(inode->i_sb->s_bdev, map.pblk, 1);
 
 	folio_mark_dirty(folio);
 	folio_unlock(folio);

base-commit: 165768bb70265b5c38cf0b73fafd75be235f8b14
-- 
2.55.0

