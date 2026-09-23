Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BC557EDBB
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 15:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177555; cv=none; b=YylK+sAxkCa/bm3ZGuPNn6x+V1kQDwRm4SafO57np7s5g25tzeUUVckwwyntyGM89wDT4/voRIquN0+6Cz10x4vEOVBVxI9RSnf5Sp6hptOywLAlYj60NdLsrO679MLvDvipp7pTZCx7QPxMu7Kym1vVjssM65oeBj/bxZxkXHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177555; c=relaxed/simple;
	bh=Gu9+nrK3qgH+7qb+CZYmwyIDmpFJbJL53RekI2ivdwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SqYGWm18f4yff7GSCl7iUoe2l/ydWgl0hlSculGh7H1reQ2G0+vCZ2HfYlRyAzV/KubluqZbyfoNv6gF5qZffyrBJByQnBVdoB/1tiPDzHgn+qeC+4rnR9CnDVLnMc9Sv2MPEVtkc61kkLvv9/7ycjjUUeLDP+WrXhsBa9l6sZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7WIL9MN; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7WIL9MN"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb1a98fso803861a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 08:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790177545; x=1790782345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DnoFHUKW7tDU9xg+lJNRDsf69NVh/CDjHQhqWC4Oo24=;
        b=W7WIL9MNi86ekjHZGE4nSc3ADQfWV7MFglLrCBH/6Ixr0XChJKVuxKKu1OByhwgqPz
         oOkDC6ygxFvIUCnFwuvpkLrSFYf7pAqquIDqrq0hERyTC9i+RV+EW5OB1A0fIu5of6zl
         iqVsXbVfn/HigNABW2zRdJHHPciXxGkHsvka/L9CGTM1WICjTcR42orqDPKkZDA4iAOe
         szWTkYlFQ1tyBYS6HUux+ENHSZTe3K4laU0fIOxlplZXRyRtPSGk8bnmq1DlHhTgilTG
         XnBH8XYE5gyZX0uCihrTubvxcHngSN7sN8I8H4668P+ueewHEfRUwgbcALHHjWkQCdlK
         zFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790177545; x=1790782345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DnoFHUKW7tDU9xg+lJNRDsf69NVh/CDjHQhqWC4Oo24=;
        b=izgkyE3YBol7RuCgJgjdNq++TNCy/zsu7pK98cWQ06diROJAd5Vsi0ABn5ng7rJt7e
         F1vuLiuKug8SDm65YHJT8IH6jG/Xl+GaOlcdSwIzmqaoQuuiL9E3poNEnOM+I8vPP39H
         YD8CAkwM+wBzbIRhedfOGGe8Z/pxUM9+if6iXkALSOHb/qvCueShzBr2cwmwhTs3MB0t
         q25w0Tpmr3PQnOVqVG4yBLreYgRyJV4Ozkkd6wQhZ43CKWiOqzlFljM9ltcjiTaKPZYr
         9g13JTt3ZVPTzv4MDMPMk6a/nwracuHSAdN/VgMfyE9d9ene3DN+1nfbxN4UK00F59lw
         x7ZQ==
X-Forwarded-Encrypted: i=1; AKwUvByR+WzNnlWO/YGiQUTN+O/NmxsjRNPxVoEBKRYAqoAaPXPgJJ8WcNelGuVOw/rKcUxGv0m/z0hOjbrFSV8r@vger.kernel.org
X-Gm-Message-State: AFuF++n42Co39Z1Xcg4BBM+4AlEU0ce5mJAxvh2m2ifoQcOypkKEA7tX
	8w7eKvmfFgYwKsqaVQNj/jFG5wI2DCFcjD5la3GvA6lZ0vFF3BwBQD/H57DMhsK8CXY=
X-Gm-Gg: AYBFou1EODCxsvYh8qBGfonlCfVvgXf+Vlp444oCQMqxwrWfM93wFPQMulsefPU6BM/
	iKYZBa3ZQ+Bt4jtxsm0FR5gEUjdfVPQE73HQzzouGTtYet5TiDvzwOElYE76zIpB/eDTZhKY8TI
	Y9TGn6Q+wt4UcfWGc4JO5sxbZjGRItC6Ceg8rN0s96M/r4KnvglKeA92aGGiNQqAn1W/eQ2CgsT
	2Vhvfo9FhyQVbm5KrySRK/ZQeV72MxD77A+IWCngibG4eLjx7/M6mx9C/FJ4Dco63nRnE+HwH5C
	7r35+Ngj1YchEI7Bc1ictkpxWF70FBXvtLV+LH6cKLVOTI6Yfoit+iop7Xm1FuHjPJAOWX8Sr1/
	llF3yUxGcdVlo+m+9suUfG4nmiMpzN73qeCbYFTLrOw/3fVdqqwB5hcrc7eGSk01rilkYqMU+/c
	tS+9fbjpPTbCTOQrQrVbywh8Wasc5Si/WKLWvqtM0Rc0QgTVSVCr5F05m34HKnB3mC4e6l3GOdB
	QNRnW/dcN5NiN1dw+QC8DQv6lry+L8LFUP1VYJNFEtQUjjCgA/crg6BdvXGW5AjyXYHdnmtBNNn
	MRFRzBOFnBQ2FgShrxpS4b7vRARExEMvk/MYhbbcCPlPhESMh0R/n/bPEJ10OZ6UywgBVDoJ
X-Received: by 2002:a17:90b:4a03:b0:39e:6c6a:6574 with SMTP id 98e67ed59e1d1-3a07e65a181mr2796215a91.55.1790177544714;
        Wed, 23 Sep 2026 08:32:24 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.252.203.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a089197169sm3351681a91.8.2026.09.23.08.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 08:32:23 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	chenyichong@uniontech.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthias Goergens <matthias.goergens@gmail.com>
Subject: [PATCH v2] isofs: validate directory records in isofs_read_level3_size()
Date: Wed, 23 Sep 2026 23:32:20 +0800
Message-ID: <20260923153220.777907-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

isofs_read_level3_size() walks the multi-extent directory records of a
file and dereferences de->size and de->flags for each one without ever
checking the record's length byte.  A record with a short length placed
near the end of a block makes those fixed-field reads run past the
record, and for a record at the end of the last block of a page, past
the buffer.

readdir, lookup and the NFS get_parent path have validated every record
with isofs_dir_record_valid() since commit e2ee4078ec58 ("isofs:
validate directory records consistently").  Do the same here, after
moving on to the next block when the previous record ended exactly at
the end of the block or the rest of the block is zero padding, as
commit 3c01d9263683 ("isofs: Fix handling of directories with tight
blocks") does for the other two walkers.

The check rejects a record that would run past its block, so the code
that reassembled such a record from two blocks can no longer run.
ECMA-119 does not allow directory records to straddle sector
boundaries, which is what commit b2eb2e288604 ("isofs: Drop support of
directory entries straddling blocks") relied on when it removed the
same code from readdir and lookup.  Remove it here too, along with its
temporary record buffer.

Found by fuzzing fs/isofs in a userspace harness with ASan
(heap-buffer-overflow reads in isonum_733(de->size)).

Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
v2: squash the two patches into one, so the record is checked only
after the move to the next block, as Jan suggested.  In v1, 1/2 relied
on the straddle code that 2/2 then removed to handle a record ending
exactly at the end of a block.  The resulting code is the same as after
v1's 2/2.  Based on jack/linux-fs for_next, and cites the tight-block
fix as 3c01d9263683.

isofs_read_inode() still reassembles a first record that straddles a
block.  Only an NFS file handle can point it at one now, and the level
3 walk then returns -EIO.  I can send a follow-up that makes it reject
such records too.

v1: https://lore.kernel.org/all/20260922140137.1768064-1-matthias.goergens@gmail.com/

 fs/isofs/inode.c | 44 +++++++++++++-------------------------------
 1 file changed, 13 insertions(+), 31 deletions(-)

diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index b766b5c9c593b..184350d2e6ad5 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -1176,7 +1176,6 @@ static int isofs_read_level3_size(struct inode *inode)
 	unsigned long block, offset, block_saved, offset_saved;
 	int i = 0;
 	int more_entries = 0;
-	struct iso_directory_record *tmpde = NULL;
 	struct iso_inode_info *ei = ISOFS_I(inode);
 
 	inode->i_size = 0;
@@ -1200,9 +1199,12 @@ static int isofs_read_level3_size(struct inode *inode)
 				goto out_noread;
 		}
 		de = (struct iso_directory_record *) (bh->b_data + offset);
-		de_len = *(unsigned char *) de;
 
-		if (de_len == 0) {
+		/*
+		 * If we are at the end of a block (or at its zero-padded
+		 * tail), move on to the next block.
+		 */
+		if (offset >= bufsize || de->length[0] == 0) {
 			brelse(bh);
 			bh = NULL;
 			++block;
@@ -1210,32 +1212,18 @@ static int isofs_read_level3_size(struct inode *inode)
 			continue;
 		}
 
+		if (!isofs_dir_record_valid(de, offset, bufsize)) {
+			printk(KERN_NOTICE "iso9660: Corrupted directory entry in block %lu of inode %llu\n",
+			       block, inode->i_ino);
+			brelse(bh);
+			return -EIO;
+		}
+
+		de_len = de->length[0];
 		block_saved = block;
 		offset_saved = offset;
 		offset += de_len;
 
-		/* Make sure we have a full directory entry */
-		if (offset >= bufsize) {
-			int slop = bufsize - offset + de_len;
-			if (!tmpde) {
-				tmpde = kmalloc(256, GFP_KERNEL);
-				if (!tmpde)
-					goto out_nomem;
-			}
-			memcpy(tmpde, de, slop);
-			offset &= bufsize - 1;
-			block++;
-			brelse(bh);
-			bh = NULL;
-			if (offset) {
-				bh = sb_bread(inode->i_sb, block);
-				if (!bh)
-					goto out_noread;
-				memcpy((void *)tmpde+slop, bh->b_data, offset);
-			}
-			de = tmpde;
-		}
-
 		inode->i_size += isonum_733(de->size);
 		if (i == 1) {
 			ei->i_next_section_block = block_saved;
@@ -1249,17 +1237,11 @@ static int isofs_read_level3_size(struct inode *inode)
 			goto out_toomany;
 	} while (more_entries);
 out:
-	kfree(tmpde);
 	brelse(bh);
 	return 0;
 
-out_nomem:
-	brelse(bh);
-	return -ENOMEM;
-
 out_noread:
 	printk(KERN_INFO "ISOFS: unable to read i-node block %lu\n", block);
-	kfree(tmpde);
 	return -EIO;
 
 out_toomany:

base-commit: c8437ca3d4386af1ae1f2869643e82fdb9c1f0f5
-- 
2.55.0

