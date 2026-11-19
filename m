Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795131679;
	b=zRNAbyJQeH+vxk4sk1SfEvOzVC2KHFKnmJUiww7MKGlgIeEk6Pp4hZL+V6ekf2Om8ZXE
	 Tu8QsGOw4sSieEmG8U8UhE2Nzmx0blF4LU3zca2W8gpEHpHxpqN4VwyQD3znv0zdhqOKR
	 2dmarQC6LP+QadgLdu1/R/H4wUGpKzkFCC8S/ImYFtvSV/CEUpbZRkOgSaQKI5JmFodwy
	 SFH/OmVfLosijp1hdvXUpfrHR4xWV781ASxSqsS8OpJpgSmcWL856qWh4Uams7wumJ3L7
	 GnZNL1/vprFwdbv8T3C+8CWbhQMg9b07VkhQpFmovlE1q4f8V7c+DwpkFuV47AGrDaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795131679;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rrqe4OL7rF0jVL1e4A2AH8iDIiTDyxz7nVkoEsGHoek=;
	b=F/8cQ7MMv+Fkv5KxyY38qocBOh0YwBEo6S3sVzYrgyx2cQpomMMYrgJyvlKuER6hJiqw
	 XbG3J1iV9GMnLxvtS8kgtlQnI1KJZjD9DX8rvYgTzL+7S3g03oMDWMyjURHsTobRhNsWX
	 NWBZzvPKmpBDZvCKIOtYciUc+U4obr5FQyo9mAAdq4E1CfwyfoHJ6mBbflATs7NFWA6Bb
	 8wI+tttX+7Bqz01LJT22T7B5Ek3ND+qkjOXvUa+6wgDjRcX8GZTO/GgzAAgZQVe6E2CRZ
	 34YdO5/baHY/W6TxVvYELEBqb88nvF0q8+qURPcIwtmBL0VKg8OYwaFxUG7tQoqo+Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Wbw3MVau;
	arc=none smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BEF606A335
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 23:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0BEF606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Wbw3MVau
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b4e18369c8so2228007b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 15:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1795131678; x=1795736478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rrqe4OL7rF0jVL1e4A2AH8iDIiTDyxz7nVkoEsGHoek=;
        b=Wbw3MVauYF6euxivL0WLepHbMXlTv7BP7mivKx337xquqBERVRSuxX0S9xm/kQqqH3
         MswqeI+HHsDcb4ZkH5xaAxBVFI2vzmPk1fgl9e899tlflMpxuVJqqaZ4ey9sgzMcbJGD
         w/VOtxnvM61uiYQ/Lx9vxVbz1QAeu/98IQI9KnScRqdniDmPWi0LA9FHTBC78FXsXihW
         An7Fgxq65QOO+SH8897pKPRH1RvXvOqDtBHcJC/I6kdnfI6WXuNAywj2AyO2O3qnGvwa
         1AEx5BVcHl9Qq/JA4NYy/+r/Q6Iik0u6+4M6aZA6UKZc1EF/mx/FzYgUmuYUyq4SImv3
         qpyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795131678; x=1795736478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rrqe4OL7rF0jVL1e4A2AH8iDIiTDyxz7nVkoEsGHoek=;
        b=D5Z0+fZyT8R6exls/VNc72cQz9QNvqmjnqDNdvWLGOajc04RHR4hrBQYmRBc+cZpgc
         MTczxgY+rEid96LTX/cKWG+QBIBvNj7GRph2Ofrrh0Pl0xL4rkmxK9SRG3+qwXA2Erf8
         KnpHM5SUEW8i1KhG0Agc5R9fiyXStPcFQlNod0QrsBMlJKNCh8k8M5k/8aG7+r5bEXfp
         7vOF0Augv2nf2Sdr1r7ldOi3q22v2zowlaaN6Ciwnf5rdK2ZaY8DZLNrIODKtaILzn8K
         RuxzP34Nn7OQH7wYf6HvggtK0LQ24ZNiKQfonCz3/zAwx1AExWUwUttfDMb1e2Qz8tLB
         2N6Q==
X-Gm-Message-State: APuU4Z+m2ZbFf7GuZfZ9q284ECfPXbizY7G20z/c+AoO4rz6k3fLorjj
	JyHn5i/LqM+5WoKEaY9yIXsGW997BusxBBg4LIQClemAuO4dC65sBU6RsdX06wzy5m0=
X-Gm-Gg: AZFdTZcS8lBXm/X0XRDiLKdMxSIL12ChHFQiWG+5zDyffHzUtnK0P8pMrwFOCTEjgPt
	V8RVJv6Z21LqjsECW9olsBcr3bqjMLMxFyhQu4Sicos5R/3qNlbE9ZjZnSCUBt8JBzZdJKpP6I6
	76QqXmDX3KHDpSCLn40b/+NXjETNPqxqVfUjAKRIsEu2v6GMRcDFX++syMsF/cif9Y75EF+sN7y
	tQRaOoER0ERMiumnqX+piXZ0kQeM7+AdhJVPxUWgy/YD23lYl2mYJLyrnLv5P+I+Oj6/4HRJuTF
	bYo146CNt4VPvuLQ/DRQbgXHpNWoPqaSDi2u50cEBxHFZkraDiUhDXnKLGbWw48VQtDD0Olwm/a
	BoCIu0H+pYFcs22cBXk6uJ71HFrpUicYTxn8CJbmTFoud8XbJYnBjBJBN+pH4zbKfVsfqaqgYNT
	GETNxEfXFB6V54lL4wwxBRc4v8cwUkf3TYwfSt68PDgO7WrhCLt11OtvYyH2UeAxawgHJEJbPPM
	Gg1f5i7rZQ1dPSEk9KQ1W/OaGCucJPy6QCcXOuWlMfYSrRt3V9O/yaZ7lAoN2JqVQV9MgBOZC+p
	h0WQJCxtSDQqMd+tkmzXIingIfJNIWCxiA20yAFLcdNPVhTKt5Q/ASbkNVQQa70RfuVl/E5aHAJ
	rvW45VY2Xm++6g4AWIxPjplvbtEKUIXGdjZnvDpMRPTb301eudN6Aj/cyGUJQTEOv43+YRSU=
X-Received: by 2002:a05:690e:14c4:b0:67c:608:b372 with SMTP id 956f58d0204a3-67df441e4f7mr413834d50.66.1795131677626;
        Thu, 19 Nov 2026 15:41:17 -0800 (PST)
Received: from system76-laptop.attlocal.net ([2600:1700:6476:1430:1932:ad09:1827:11fb])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67df338e8fesm796893d50.16.2026.11.19.15.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 15:41:17 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Zheng Zheng <fengaojigui88@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/5] hfsplus: reject special files larger than their allocation at mount
Date: Thu, 19 Nov 2026 15:41:08 -0800
Message-ID: <20261119234112.720963-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119234112.720963-1-slava@dubeyko.com>
References: <20261119234112.720963-1-slava@dubeyko.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The volume header describes each special file (extents, catalog,
allocation, startup and attributes file) with a fork that holds its
logical size, its number of allocated blocks and its first eight
extents. hfsplus_inode_read_fork() takes the logical size as is, and
fs_blocks is derived from it, so a corrupted header can make a special
file look larger than the blocks allocated to it.

Syzkaller found an image whose allocation file has a logical size of
0x800000000800 bytes but only one allocated block. Deleting a file on
that volume frees its blocks, and hfsplus_block_free() reads the
bitmap page through the allocation file while it holds the deleted
file's extents_lock and sbi->alloc_mutex. Page 0 of the bitmap spans
fs blocks beyond the first allocation block. As they are below the
inflated fs_blocks, hfsplus_get_block() does not treat them as beyond
EOF: it takes the allocation file's extents_lock and searches the
extents B-tree, which has no record for them. Lockdep reports
recursive locking on extents_lock and the block free fails with -EIO:

  WARNING: possible recursive locking detected
  rm/922 is trying to acquire lock:
  (&HFSPLUS_I(inode)->extents_lock){+.+.}-{4:4}, at: hfsplus_get_block
  but task is already holding lock:
  (&HFSPLUS_I(inode)->extents_lock){+.+.}-{4:4}, at: hfsplus_file_truncate
  ...
   hfsplus_get_block
   block_read_full_folio
   ...
   read_cache_page
   hfsplus_block_free
   hfsplus_free_extents
   hfsplus_file_truncate
   hfsplus_delete_inode
   hfsplus_unlink
  hfsplus: unable to mark blocks free: error -5
  hfsplus: can't free extent: start 74, count 1

A logical size beyond the allocated blocks is invalid on HFS+, so
check it when the special file inodes are read from the volume header
and fail the mount if it is exceeded. The error is reported as:

  hfsplus: special file 6: size 140737488357376 exceeds allocated size 2048
  hfsplus: failed to load allocation file

Tested on a KASAN and lockdep kernel: the syzkaller image and images
with the logical size of the allocation, extents, catalog or
attributes file set one byte beyond its allocation are rejected, the
image with a consistent size mounts and its files can be deleted, and
generic/001, 002 and 013 pass on freshly created volumes.

The analysis, the fix and this changelog were drafted with the help of
an AI coding assistant (Claude Opus 5.5) and reviewed by the author.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Zheng Zheng <fengaojigui88@gmail.com>
Closes: https://lore.kernel.org/linux-fsdevel/CAO-4RZ1a46EoJY7x6euiS+7aTOb-T9X62E9nGyToRcyvKU+eHg@mail.gmail.com/
Cc: stable@vger.kernel.org
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 fs/hfsplus/super.c | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index f3283e9b42c8..33594e1f8367 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -26,34 +26,62 @@ static void hfsplus_free_inode(struct inode *inode);
 #include "hfsplus_fs.h"
 #include "xattr.h"
 
+/*
+ * The logical size of a special file must fit within its allocated
+ * blocks. Otherwise its page cache would map blocks past the end of the
+ * extent records, which the code accessing these files (e.g. the bitmap
+ * code holding alloc_mutex) does not expect.
+ */
+static int hfsplus_system_read_fork(struct inode *inode,
+				    struct hfsplus_fork_raw *fork)
+{
+	struct hfsplus_sb_info *sbi = HFSPLUS_SB(inode->i_sb);
+	u64 size = be64_to_cpu(fork->total_size);
+	u32 total_blocks = be32_to_cpu(fork->total_blocks);
+	u64 alloc_size = (u64)total_blocks << sbi->alloc_blksz_shift;
+
+	if (size > alloc_size) {
+		pr_err("special file %llu: size %llu exceeds allocated size %llu\n",
+		       inode->i_ino, size, alloc_size);
+		return -EIO;
+	}
+
+	hfsplus_inode_read_fork(inode, fork);
+	return 0;
+}
+
 static int hfsplus_system_read_inode(struct inode *inode)
 {
 	struct hfsplus_vh *vhdr = HFSPLUS_SB(inode->i_sb)->s_vhdr;
+	int err;
 
 	switch (inode->i_ino) {
 	case HFSPLUS_EXT_CNID:
-		hfsplus_inode_read_fork(inode, &vhdr->ext_file);
+		err = hfsplus_system_read_fork(inode, &vhdr->ext_file);
 		inode->i_mapping->a_ops = &hfsplus_btree_aops;
 		break;
 	case HFSPLUS_CAT_CNID:
-		hfsplus_inode_read_fork(inode, &vhdr->cat_file);
+		err = hfsplus_system_read_fork(inode, &vhdr->cat_file);
 		inode->i_mapping->a_ops = &hfsplus_btree_aops;
 		break;
 	case HFSPLUS_ALLOC_CNID:
-		hfsplus_inode_read_fork(inode, &vhdr->alloc_file);
+		err = hfsplus_system_read_fork(inode, &vhdr->alloc_file);
 		inode->i_mapping->a_ops = &hfsplus_aops;
 		break;
 	case HFSPLUS_START_CNID:
-		hfsplus_inode_read_fork(inode, &vhdr->start_file);
+		err = hfsplus_system_read_fork(inode, &vhdr->start_file);
 		break;
 	case HFSPLUS_ATTR_CNID:
-		hfsplus_inode_read_fork(inode, &vhdr->attr_file);
+		err = hfsplus_system_read_fork(inode, &vhdr->attr_file);
 		inode->i_mapping->a_ops = &hfsplus_btree_aops;
 		break;
 	default:
 		return -EIO;
 	}
 
+	if (err)
+		return err;
+
 	/*
 	 * Assign a dummy file type, for may_open() requires that
 	 * an inode has a valid file type.
-- 
2.53.0

