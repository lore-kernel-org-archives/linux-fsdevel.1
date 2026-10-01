Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7273A489FC4
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2026 16:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790872503; cv=none; b=A6HfL+o623/upkffClXeIxwRnvjvCeFd+933mDq5+UekwKePrQ9D1H5//Bd5EGLxxemO8whpYYSkCupntCYCdEWSlEHTMQL1W93yJSmANfeLaWkrMY3JpEUax74ErkbbTt6yNNae91V5DGgwoRmhNJV690GnfSrVEWhZyABhWBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790872503; c=relaxed/simple;
	bh=L8Lns7TsZOH6fg9p7zuRQ17Cx9fE42n0YgkEobEXxRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BsXqE5i1hs0w7/jtb01D3V74fsm6z4RiNuVF/6VPK9TK5L+viT4wV9yqCGPloAilhCd5OM6YCsC9wKxhCOil/rtnnidRrbZ/fH0j94gp1HXtcpaH4F6q/L9fjsVw0RF9pnoGexFFJUYf71Rh2K2vWhwKE7NlPsch3hbtm2vVmx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o8a/2PLa; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o8a/2PLa"
Received: by mail-oo2-f43.google.com with SMTP id 006d021491bc7-6de79721a68so370857eaf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Oct 2026 09:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790872500; x=1791477300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GqroQK+KWhpUECnqkLQZ6DQ/b3Wl2bifoRVa0It3kTQ=;
        b=o8a/2PLaVsbY1QgRaZEpy2/0EHuR7To0RWXTWqkMstvabMpyhndQUYO8Cs8lzZo/pj
         qAAFI0ire4ZdWCJVQiN7tzEBuytLceKj3/jG2C8E3HsQkCduiEaGjbUAvOQALYXCeQ0k
         svUwOPQ1A693RbUSjrIpbFJinTqDyZsF6/P2MEVGPCTxvD7v/DIlfZWVAKZQPsZelOOH
         yTq6yiZBqjO9T/qJUrsg6ldLdQ3CaajuvNUh6RsUVs48cGCZGNjKW3e/qmrzSfHMADK3
         2PAk/K/dOMOg74IXqRxho+uQPmeKwfwlvwYqmD2u2tqejQ+R+eWDwN7ekUDdDrwZlPM+
         vSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790872500; x=1791477300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GqroQK+KWhpUECnqkLQZ6DQ/b3Wl2bifoRVa0It3kTQ=;
        b=WaRiiULfjCfUTdiKhly6yX5k3UhZdHcOddn4hBI6utYhIHg3ahNMnMsGSdrIb00xyN
         nWXPxvyLlSNL06XlIEohWt9pEzk34Ds3jf0WmMhZZpGq7Gia6FV3bURgiu5uj4oWkKIU
         SbVMCKzpugipwfB+kTiasP5Fib3xKpugWCQiUpckwm3U/C5wPtYxZOtC8m37bP0qFKZl
         k3twrFvrdgnGonMNEuCJWL//DbgZ1HSiKVTJ4Aj1wDEZUQvXNTJqLPxyA9ZJGfF3QQun
         NxoEiuOX3Z7n/VCkkAnWvg1I+D3fnkF2lVohU2mlwcG2qXieELEPqG9VR3QEhQlFcf95
         zNeg==
X-Gm-Message-State: AFuF++kfJmpmuIL91DJ9a1N5FFk7lX1AgsoprWdAb6HjUF5QquReOV2U
	NC8s+mHxiVaklLIgzq++HJ+xnHa38Ckjuo1QEDj1guLP4uf5sxfaGb38
X-Gm-Gg: AYBFou0bAzGVQnM89xHKVWQkhG3o1of3HgtQdDVrt9/3d7xSsQTKm1rPwwfP4+OOTic
	ZLhgoopsVhtCh44x7/3W9FNjfPYb5NZXxYCHCXa0PR1CDaeamUqzoDUP7AIkDRNb+MFMfHlxYOR
	vvfBp5dYuaXfqz8jcincFOlM/ln/dVGfbBbY427P0XLWNvZCo0/9ZGQJgkeUyyMC6h+S4mmq09Y
	9XzGrh6xO+D454AHki0FqMOMFgGiIOoSV4Y0KAeEoIejMwgXWoTqrF+o87rjaZY+5H4Upe9wnxf
	/PpjhrCKuaNFPMaFuPKtlEEjeHOBvHIbMLSGTZcmyjHDYP8s4/DR/yN0KFPB0BOebpdoMttOzoG
	8t0T0fjBGXXWr6YhpZliZih/q4pAvz+OSRbDnXRygP0ncX2gAaEyPXnAjgC/FE8ZFEJs0Ba3PH7
	f4s3XuPLU2puVaubqH7nGIKOMOWaqpDY1c0+3CE8y3t9f0JzdDT8ekZQbUSFB9hBdreNFH+KPAA
	xqk+oHIY0tM5IWA+jiGHRFWpotu8jGuwFYIw+HfgKBJZVjaI/xseyqgHKOrPJ5XPYLb9KzwFvRK
	/UdhKj3nrwKbAkxAI5xodLCD7Y2HmHG+okwuWOT1gwuuoZIIgm6YCq5klIk=
X-Received: by 2002:a05:6820:604:b0:6de:d2c1:e97c with SMTP id 006d021491bc7-6ded2c1ea69mr922462eaf.86.1790872499756;
        Thu, 01 Oct 2026 09:34:59 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-49ded33505esm2712687fac.18.2026.10.01.09.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 09:34:59 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Jan Kara <jack@suse.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+799a0e744ac47f928024@syzkaller.appspotmail.com,
	syzbot+43fc5ba6dcb33e3261ca@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH 3/3] udf: leave udf_next_aext() outputs alone at the end of the extent list
Date: Fri,  2 Oct 2026 00:34:48 +0800
Message-ID: <20261001163448.753190-4-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

udf_next_aext() decodes each allocation descriptor straight into the
caller's eloc, elen and etype, and follows a continuation descriptor
into the next allocation extent.  If that allocation extent holds no
descriptors, it returns 0 for the end of the list, but by then eloc,
elen and etype describe the continuation descriptor itself: the block
of the empty allocation extent, one block long, type 3.

The kernel creates such lists itself: udf_delete_aext() leaves the last
allocation extent of a list empty when it removes its only descriptor,
and udf_do_extend_file() and udf_extend_file() already handle a list
that ends in an empty one.

Two callers use the outputs after a return of 0.  udf_discard_prealloc()
walks to the last extent and, if it is a preallocation, deletes it with
udf_delete_aext() and frees eloc/elen.  When an empty allocation extent
follows, udf_delete_aext() removes the continuation and frees the empty
block, and udf_discard_prealloc() then frees that block a second time
instead of the preallocated blocks.  On a space bitmap the preallocated
blocks are leaked and the free block count drifts.  On an unallocated
space table the second free adds a second free extent for the same
block, which is later handed out twice: fsx as run by generic/091 and
generic/263 ends up with two parts of its test file in one block and
reads back bad data.

udf_table_prealloc_blocks() can likewise take an empty allocation extent
at the end of the table's own list for a free extent starting at the
goal block.

Only update the outputs once a descriptor other than a continuation has
been found.  The other callers use the outputs only on a positive
return, or not at all, with one exception: when udf_table_free_blocks()
appends a new extent, it keeps the partition reference of whatever eloc
last held, which for a table whose list is a single continuation to an
empty allocation extent would now be uninitialised.  Take it from the
freed blocks instead.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
Reproducer, with fsx from fstests and mkudffs from udftools:

  truncate --size=2G udf.img
  mkudffs --blocksize=512 --space=unalloctable udf.img
  mount -t udf -o loop udf.img /mnt
  fsx -N 10000 -l 500000 -r 4096 -t 512 -w 512 -Z -R -W /mnt/junk

Without this patch fsx stops with READ BAD DATA after about 9850
operations, in every run; with it, all 10000 operations complete.
With --space=unallocbitmap fsx completes either way.

 fs/udf/balloc.c |  1 +
 fs/udf/inode.c  | 21 +++++++++++++++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
index 2ec577b4321c..d863ee201cbf 100644
--- a/fs/udf/balloc.c
+++ b/fs/udf/balloc.c
@@ -457,6 +457,7 @@ static void udf_table_free_blocks(struct super_block *sb,
 
 		int adsize;
 
+		eloc.partitionReferenceNum = bloc->partitionReferenceNum;
 		eloc.logicalBlockNum = start;
 		elen = EXT_RECORDED_ALLOCATED |
 			(count << sb->s_blocksize_bits);
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 71386e7ac796..0e55f749bc48 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -2266,22 +2266,35 @@ void udf_write_aext(struct inode *inode, struct extent_position *epos,
 
 /*
  * Returns 1 on success, -errno on error, 0 on hit EOF.
+ *
+ * eloc, elen and etype are only updated when the next allocation descriptor
+ * was found.  In particular, when a chain of indirect extents ends in an
+ * empty one, following the trailing CONTINUE descriptor and hitting EOF must
+ * not clobber them with the location and length of that CONTINUE: callers
+ * keep using the last real extent's values after a 0 return, e.g. to discard
+ * its preallocation.
  */
 int udf_next_aext(struct inode *inode, struct extent_position *epos,
 		  struct kernel_lb_addr *eloc, uint32_t *elen, int8_t *etype,
 		  int inc)
 {
+	struct kernel_lb_addr tloc;
+	uint32_t tlen;
+	int8_t ttype;
 	unsigned int indirections = 0;
 	int ret = 0;
 	udf_pblk_t block;
 
 	while (1) {
-		ret = udf_current_aext(inode, epos, eloc, elen,
-				       etype, inc);
+		ret = udf_current_aext(inode, epos, &tloc, &tlen, &ttype, inc);
 		if (ret <= 0)
 			return ret;
-		if (*etype != (EXT_NEXT_EXTENT_ALLOCDESCS >> 30))
+		if (ttype != (EXT_NEXT_EXTENT_ALLOCDESCS >> 30)) {
+			*eloc = tloc;
+			*elen = tlen;
+			*etype = ttype;
 			return ret;
+		}
 
 		if (++indirections > UDF_MAX_INDIR_EXTS) {
 			udf_err(inode->i_sb,
@@ -2290,7 +2303,7 @@ int udf_next_aext(struct inode *inode, struct extent_position *epos,
 			return -EFSCORRUPTED;
 		}
 
-		epos->block = *eloc;
+		epos->block = tloc;
 		epos->offset = sizeof(struct allocExtDesc);
 		brelse(epos->bh);
 		block = udf_get_lb_pblock(inode->i_sb, &epos->block, 0);
-- 
2.55.0

