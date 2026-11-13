Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794530283;
	b=SQsRYKMRMT2n9KUe8pPBvTdQDJcUTm2TQJAG6xM0iWME2NUE5w89Lqr5jx95Av81wTMI
	 4JT0NgS1vnIYGbup9lMDT/4T1RE1NVqGxczbrN1MiVDkItr0WFa8AjGDrvjavwx/9mRv2
	 AsbW1SwfEWYVxEgFO908eNwC2E3cFf/1q8WTP3GXX8gVSXBTKdKDtQd3agafpmvF5s+fo
	 uEyaeA/ZD4scduc4OtOQkrsnJxd1k1x4uUK34rMrDM4n+PFuGVVrkX/DhuBtGIuNi+Ylo
	 WYHXE2tGU8c2B5obJyTfpAGhrXf3N1kJuVv7JxFcLEXsyRFdGQ3fDNaOzp9E26wpgAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794530283;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TmhPabmk4V5KcMSPRK/OfQ2JXZzmDv9LEr+le+m5Hhc=;
	b=Nwgbb1RrY4QTqT2aBtADBxIbINSnMLKU8vYM+0qN7eUzk2MkenKeBxmYyoz4dXl7vsgE
	 RySLcD1rANWeKabgamGKBCg0nRKkyRFS883YC5xCsQM5ETNSx+IVRDp2VLxjVD0S8Kp8W
	 8CdbHgA6VUGEg6g5tXeJ87wDWnyXvg78O3zjU9Veq1Kz2v/IxUlGcEd/B2qB/+kjWBTJ4
	 QmV9v7vIcnNiF1vfbW4xCuTNEaevOCVxVubsLArRnqTcS3mCcYjYRHonW6b9/Lhki7a/z
	 0lVgZuWRjtb71EoDCNwpjSKSsCmgdfWvwjjMCrsf6UIZcLtVPvr5zME32sCINInJjpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Rbogv6Vh;
	arc=none smtp.remote-ip=74.125.224.53
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CAA60A382F
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 00:38:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40CAA60A382F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Rbogv6Vh
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-67bfdab8f20so240031d50.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 16:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1794530282; x=1795135082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TmhPabmk4V5KcMSPRK/OfQ2JXZzmDv9LEr+le+m5Hhc=;
        b=Rbogv6VhsyZFwdkg8FS6gSssCsVqR1tgJL4N/h0qUG7A6vXzvETfhL3c+Cn0IetF+u
         Kq8Emc+/GwebvjPmGonHEbBecwFuXDlj6abryZSdQWJI15OR5KnsyywKlQBrtm5zCjVp
         /dOOkGeNSbsldtDfKrIZbVfCP3fApWJ+HVWS/nV2G4H7GttbFWi/6jvPMeuT4TkfGqdM
         hjMRTvFmwZIha/wTV6Pg9WsAvDCZQgfMs25vgf/9b/3p+DeT2iE4/3B8l72hsZfPaTT0
         eQO9GPUYrlWHC5lCVPIjfX/mi9yAgfDuRC+M52EGy/HFQHS/pE1gneQ3od8zgX1cVKxC
         U+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794530282; x=1795135082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TmhPabmk4V5KcMSPRK/OfQ2JXZzmDv9LEr+le+m5Hhc=;
        b=VpBSe1IeqBgaIatrKCIHh4cEq4MZccafzAkfrMuwdurF1piHsGnX4l61VoJFy4iMh+
         8+aYgYSyHEriVAJ9PUHxpvhP6dqHUQauaVVJ5Ho5JYu49/B2RF9GMgvtuIKAw7Pyr2DN
         rO6bYrxeDkmYnYqpCvKI8Xdg4MKZc+2oVRseJvgiA/E93YFcBvJctj5xPEYsw2fr9zgJ
         HZN73X2XeLWw2tIFCdQOt24mtgVbTq3zWiHeZBcUA3Ra+U5q3gmYpX/dAYRtLIcyGWY0
         IGllFTKhuc2r4823hT4Ad+oUj2OqMklzJTrnWpUzERHWhD/CfWlPgH1zq4EJYkcjx2nl
         Q1pw==
X-Gm-Message-State: APuU4Z/PhMU2uA7XnFpWF/8o1B2WijxXYqCwT4O25qr/3PTCrX16oN9G
	QdfzJ0DFByW88lL1+R8nUmPLYKADt+Bi7HQnSGIbKbTvxGZe3wS3jNxIJtbfTmYKCt8=
X-Gm-Gg: AYBFou0/Wv8oBW0OS+CfWzMmZGrRwKqL4LxCaCRMoqlLBa9wn37ohp3XD0mtzWRBFi5
	xGCD33IbP9vUhqaVsugkm5s0mE4kjyOLXOElWYRW56fPrL72L6lRrV9lehi21p9rOPQCoAWhSLe
	z3ZmFHhiIrGxGF+qil9j5Ey49po9BMVmSQl3hCMIU0VcmhoA+WmavaQw0BVjrCs6JSRnjrt9npB
	O2Pm+8CrnRQrt0bAICwajujCTygspRYVmj4r7BAloh+wfNbEAYdkm3+yjk9WwWxhM9OrFOrBPcO
	B+b1cUu58HsXAEUIu8YjNkuPBLU+aeB29xNxlTSTX5VldM//9qpTk/OY9NIdYjW+1+9usTYR6cY
	3GlkrxC2HtSuxsRs7Rec/34cPQFI5Fe5QV8Boi57HTsVqXHuGmDtD4vBgBZHFcwZjbgGQ8S1vmV
	s/z92rnJaBa+j7qO04DIN9lcr5STpyWyyGkKNSqHa+41m3jcTFFNd/cMpHRDtdTa4hJjhunazUg
	rSpEOqC72tXB7DEOpJoFEuLqhkZHgMG1kzWG0tKUn2m4Ho8eTARWmCV9rA9lwFhLUyTy+z0WID8
	0XgUxsUwH3lMhJ/pl+hHRVUHD0e0btmHwC9k8sqIW3J4JYmQbF19u2fDZKa/NtUICcvHCB5Bylz
	dg2MP/G15tWf40r4YEGJj3uBnnUwFYwRrqyLhpFf9QFId15wAFKdGxyAnr/Flh+iilonXnqg=
X-Received: by 2002:a05:690e:419a:b0:67c:cab:bd71 with SMTP id 956f58d0204a3-67d896ea1b2mr429723d50.106.1794530282261;
        Thu, 12 Nov 2026 16:38:02 -0800 (PST)
Received: from system76-laptop.attlocal.net ([2600:1700:6476:1430:3a31:6c95:5610:70f6])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67d8a59e70asm706463d50.10.2026.11.12.16.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 16:38:01 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH 1/2] hfsplus: don't take inode_lock in hfsplus_file_fsync()
Date: Thu, 12 Nov 2026 16:37:55 -0800
Message-ID: <20261113003756.1066989-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113003756.1066989-1-slava@dubeyko.com>
References: <20261113003756.1066989-1-slava@dubeyko.com>
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

hfsplus_file_fsync() takes inode_lock() around the metadata part of
fsync. For HFS+ it is not needed, because everything done under the lock is
already serialized by other means:

- sync_inode_metadata() ends up in hfsplus_write_inode(), which is
  also called by the flusher threads and by sync without holding
  inode_lock. Concurrent writeback of the same inode is serialized by
  the writeback code itself (I_SYNC), the extent record is written
  under hip->extents_lock, and the catalog record is updated under
  the catalog b-tree lock taken by hfs_find_init().

- The catalog, extents, attributes and allocation file flushes are
  per-superblock, not per-inode. They are guarded by the atomic
  HFSPLUS_I_*_DIRTY bits and the page cache of the b-tree inodes, so
  fsync() calls on different inodes already run this code in parallel,
  as does hfsplus_sync_fs(), which does the same flushes without
  inode_lock.

- The volume header is prepared and committed under sbi->vh_mutex
  (and sbi->alloc_mutex in hfsplus_commit_superblock()).

So inode_lock only serializes fsync() of an inode against write(),
truncate and setattr on the same inode, and against another fsync()
of it, without protecting any state that is not already protected.
Taking it there also means that fsync() of a large file holds off
writers of that file for the whole duration of the b-tree flushes and
the device cache flush. Other file systems (for example, ext4) don't
take inode_lock in ->fsync() either. Drop inode_lock()/inode_unlock()
from hfsplus_file_fsync().

Fixes: 02c24a82187d ("fs: push i_mutex and filemap_write_and_wait down into ->fsync() handlers")
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 fs/hfsplus/inode.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 5fa72b465922..8073fb99217d 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -370,7 +370,6 @@ int hfsplus_file_fsync(struct file *file, loff_t start, loff_t end,
 	error = file_write_and_wait_range(file, start, end);
 	if (error)
 		return error;
-	inode_lock(inode);
 
 	/*
 	 * Sync inode metadata into the catalog and extent trees.
@@ -429,8 +428,6 @@ int hfsplus_file_fsync(struct file *file, loff_t start, loff_t end,
 	if (!test_bit(HFSPLUS_SB_NOBARRIER, &sbi->flags))
 		blkdev_issue_flush(inode->i_sb->s_bdev);
 
-	inode_unlock(inode);
-
 	return error;
 }
 
-- 
2.53.0

