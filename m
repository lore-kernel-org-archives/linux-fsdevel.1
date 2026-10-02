Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F83235E1BD
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Oct 2026 04:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790915202; cv=none; b=t3fl81fmlGJcOCpW5uuaotYambfD4R/iSCHu6MfAl1gTY8rQuPRvmVl7hnSrWDRWDMzrF7d1lqg0QCess6TzinE3YvMZVpsZm1+Uz2Zlzl9Q/vpf16Ufj/X6CSNjZHXOccOMz8YGIpJE5yGhAls00bel/dr9CoWLPsWUFoQaCr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790915202; c=relaxed/simple;
	bh=L8Lns7TsZOH6fg9p7zuRQ17Cx9fE42n0YgkEobEXxRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hMTcYojozDlgnPLGL2jzgns/D+UKHoSA59Gxnykvp0+GZ/wtyO3Pes9TU6uaOK9byAEaSgzZeHhbs0kmUd7ZU6rPBiIFIB2apX3Jp5dkTy39kgSna1tyk4abUeJC9vOaUG6/OkGiILEqLBOCTBwC/ORG/TINCMi4MPGHCc0o1y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGb+96BT; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGb+96BT"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd66bb4so3395256a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Oct 2026 21:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790915199; x=1791519999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GqroQK+KWhpUECnqkLQZ6DQ/b3Wl2bifoRVa0It3kTQ=;
        b=lGb+96BTaNAcZpTBRH94X6BTjOt9ZaZAieA3w5FetpKUsFlothUrOTDCItPA2G4WiG
         yvqnaLN2vrDrgJMb9eiaPIlrqbWlWGv4P5axNjoXbd487l/B8lA5aR0fMvWkjRFyT2OF
         HKS770PvmG/ndHOtkRS7iDeOBvanTCN7jA4xm0lAAI3cFPfbrZ6V/bW/BIycZyTWHC24
         ScMRy3zbQURnckYP+fg012mPuEUb7zV0qQki0f9ov4FAKT9y4xYuAewceDEit1TsLDxj
         Sb3VkhjwBMWKpLLyIddaX/jtvacTLwvwlgujyiDr0BygZgMJ1H+RRCpuoz9/kazEybWx
         LBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790915200; x=1791520000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GqroQK+KWhpUECnqkLQZ6DQ/b3Wl2bifoRVa0It3kTQ=;
        b=SCBLIxen3APxUn9sOi1MQ6HeckjoBAQ9M95Qm/MuMHNZJInzzsP+BgfniA2cOeZh1y
         pLcApkOpXlkIro/N8MNmRXgZiy0auAUAY9yIX+8LGYyGWxl8DKeTqUWjCIdoSKZn61fZ
         1cgP4zS4bnXECQe5A0+byfRUvbqa6HPR6BdspENSG+f3zXGzgqyniDz19zVW+ud0++lU
         Iyd3mw4B3OdPNtxKH1NC1XQVdCscJOU+8NGfdysiyz/U6mdKhYkGJW1o3uOFv8iAinY+
         7paRIrVrBiNu9J+UB2ko5yUGao9TOBSipVEPXB8ROq8hVN4vnCAlc6yOolrthYfH0/nA
         xa0g==
X-Gm-Message-State: AFq9FYJk3+YfwY3xtyvx0xgQ5CMhPULjtp003MTCdChYXK3+FBgfcUDj
	hvsWUamARZ1UCDgbJ7tmszdDlQm6peiHO9ThuYu2cRMEJUAD347WaXzv
X-Gm-Gg: AYBFou1Jw6ZOHSwXT2dDKY1vci4wR2H3dTlUixW3ozRuwdA3yp+M45toi7k+qrGGBYX
	twAjkOeG8y5pATHfRrb8CR8A3y52mKPjqupsoA2QISfJoE9tOvNSyPibG8VUT9c2chqbgSv7/Ud
	wUzi0Ze7AofRn/F2TH+bcLly1xdM1ZucsFNb09IhMXyAOxPXqi81LgcXam0Iu21jhtNhItFAKsF
	X1Y953EE/LhncNeubGEPrJ6JhpZfL6Kfsu/LjBIkbytoYyu9CjE5yUVNy1NhWbYxGYclvqL0Ocv
	iP5z2BqbhdnaQCH/EdasBl+eH7QTUZXqBjVbbVb5zSXGPKJe6RS9m230vV9vMkmvzTbit4s7tuf
	2uJPpePSngEGtD5vGqa632rpBvj/N6TmdDqSPUJvmaZUR2Vt8uI9mfM5ltCtvbfLHgUgx/qkFCV
	RyaYllIo2zmbR1EGYz3/Rvq7HW7Fggnl7cXGURGdyQhwy1/dyJtAtcXlGA2HmOl2jKQ1aPJb8I3
	oJ0GIZO2NVvmS+rVjomKVHEV4uwxlr2vmd3QGv7nu9PL72rnCdD892NyPN7fe4a7r0rx1Ha8xZ0
	0XJikgvTBzI9RCIUKRRuF8cnzH+yswe6B1fN+aUPlBYr3PJUhgYxRhFCQpQ=
X-Received: by 2002:a17:90b:2b4b:b0:39e:6a81:5a90 with SMTP id 98e67ed59e1d1-3a6ce7962e3mr1330498a91.36.1790915199513;
        Thu, 01 Oct 2026 21:26:39 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6cd5ddb51sm2205054a91.14.2026.10.01.21.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 21:26:38 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Jan Kara <jack@suse.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+799a0e744ac47f928024@syzkaller.appspotmail.com,
	syzbot+43fc5ba6dcb33e3261ca@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH RESEND 3/3] udf: leave udf_next_aext() outputs alone at the end of the extent list
Date: Fri,  2 Oct 2026 12:26:27 +0800
Message-ID: <20261002042627.1677228-4-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261002042627.1677228-1-matthias.goergens@gmail.com>
References: <20261002042627.1677228-1-matthias.goergens@gmail.com>
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

