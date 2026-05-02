Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D832F222580
	for <linux-fsdevel@vger.kernel.org>; Sat,  2 May 2026 00:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777682962; cv=none; b=AHI7IEEPz+gbCRz6EdSTj0tahFVwZKeTH/7VI1kX0kE3gCv6nN8BOVnK1HakZCjPVV38X7MI9sUmSQLiFuzUo3vnBYSKf4DtyvGxjuTvEou8w/ou9OlmsN5lX+ZbVMGQlKqdKe8BUqYoyOsHGIGV6Xyk99IXD1qm3p56u2Ysq68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777682962; c=relaxed/simple;
	bh=IeV2kFIhwjJnX0skXZIwlcr9DgYoBXSMOh8rEjHzi6E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eNx3rXaStPdW60SkcWiGiyNUbj28y9qTAolX3cKOUsmA4uHpopRyXIWE1TptdZ18Z9Lc1X3KgML/v4XeS4qcOExRj/ir3gjaEbyMe3AWA+vM/yYlatgFwTzqEjza5vN95Bt28XQ703VarslfmAUSZLhHeP3wo1q/8SMaJkBKaYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8t6ALYC; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8t6ALYC"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-364da4849b2so472150a91.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 May 2026 17:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777682960; x=1778287760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KvbakKe1AH43pz8vth2Kv2pNuUbrRZ4DWIjUmda08Cg=;
        b=Y8t6ALYCyHC5bHtZJL32zaMAu4nm66n1YwRHsWvc/q06T6fcamah/2c9qsobPS9Nba
         m5RQuKP7sP9edgrfbUmYTlkVoVFnWpGULKbMQQNUgueQPDLVrIeagKoq3/wXI41yq2jh
         bLUSy5ZAfn1bgmQwY+ENz8GqbirJYmfaRrx6ZbeWyHD2NkORhHqfLOulNzRIH995f5dE
         dc/9aCMrxQFUEBCnifPV7zGtzZlAVKgiCa0o6+0cF+QSD+pr0/Yv4o7kHOw8CMbY2K5B
         dYDW6IezhHRxqrh9LE2e2WqnxFO92eaV+j/3F7AesniSy0m3RLP/YuR8LQUIMT89vsOy
         F+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777682960; x=1778287760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KvbakKe1AH43pz8vth2Kv2pNuUbrRZ4DWIjUmda08Cg=;
        b=fqRigCiKVMDkp6wSsv0L7njIrRqqTo20k2+ejw+aXapkHNwsYhaaXX2IKISXA035cd
         rbeQdNFjHz0nmfTmzVoASdhPd8TNp/PUxcjjFNS37phzQ800K/F0UwuAgZpP/9zrLVUW
         Kus2PPUaJKcZNZ9fBDRmv+G6tFUeAZLmQOYtKS3IEyOwlP7T2KNifLVeJL+vlpU5Ebw4
         GZLA8apG7o1Dd01lE2nscOr5zgrNkmc8yPmfK7Ierqv1n1fgtC/ObKw+OBloW5FSYV0K
         YIvJSeYcRE7Und3yiJI+ryp95vxKcy3YX1GdRUQcCqoLp298HO+oW/tNXlzq9Edb27U9
         HDjQ==
X-Gm-Message-State: AOJu0Yy9OrgC54f00y+QmS9OBk1UYvNqyqg8j+E24CnompnXwQ1TC6mE
	QkxwjUrAUy3hRtHOikWQD8aVNp+AVBD2kBoEHwYpkVCsCq9lXiHRUEG2
X-Gm-Gg: AeBDiesXG1Zydie9bM3Uu/K3EbC/weDvmMJ4LIIipPCBmPgjF1FyDpNhThHLwZRfQrQ
	dGtciJDTxOYYSQUVm8hicZXLynwg3FBEoUc0CpSZJ77Yqku7qkMWy+r+IvwTUXKCSKIKTrKhWOy
	tU0wgAgz88S6zeG3iWaXKX3QDrG/0Y40qpTd2g88WSe1pev9ZWehTFfAk0OVw6li617pMF+bljS
	4xd4BL2LhVnvcWjp/AFvclaIgMNd6pQgdQLLmShL9YjXyIj0r2FXodi59r/8NzGcWUTYDFRHm3y
	HxNHPASisR6ymd6Rjvj0H0BVX+RTTakzQfxjMyFz2oUGR2t6A8mpMgRpQi52v31CvLHihEv8Zkh
	0Wb59k0+hCQwDb6LzsJ+3L6uhHjus1aq5Togkj2vO5cc+ZnE65pd/MkUKpv1VDqBX3NIlVE/HcL
	ufbM8lBLgQkmencfR6ZCL4gfB3S9U=
X-Received: by 2002:a17:902:d2c9:b0:2b0:7136:d980 with SMTP id d9443c01a7336-2b9f25330b1mr7048495ad.2.1777682960211;
        Fri, 01 May 2026 17:49:20 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caa7e827sm30526155ad.1.2026.05.01.17.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 17:49:19 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH] ntfs: avoid use-after-free of index inode in ntfs_inode_sync_filename()
Date: Sat,  2 May 2026 09:49:16 +0900
Message-ID: <20260502004916.492207-1-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_inode_sync_filename() walks every FILE_NAME attribute and, for
each one that points at a different parent, opens the parent index
inode with ntfs_iget() and locks index_ni->mrec_lock.  All three error
branches (NInoBeingDeleted, ntfs_index_ctx_get failure, ntfs_index_lookup
failure) drop the parent reference before unlocking:

	iput(index_vi);
	mutex_unlock(&index_ni->mrec_lock);
	continue;

index_ni is NTFS_I(index_vi), so the ntfs_inode (and its mrec_lock) is
embedded in the inode allocation.  If the parent directory is not held
outside the icache - no open dentry, recently evicted from dcache, no
other concurrent lookup - ntfs_iget() returns with i_count == 1 and
our iput() drops the last reference.  evict_inode() then runs and
destroy_inode() schedules the slab object for RCU free, while
mutex_unlock() on the next line is still touching index_ni->mrec_lock.

Swap the order so the mutex is dropped while index_vi is still alive,
matching the success path at the bottom of the loop which already
unlocks before iput().

Reproduced under KASAN with a debug build that forces
ntfs_index_ctx_get() to fail when the parent index inode has been
opened with i_count == 1.  KASAN reports a slab-use-after-free read
on the parent's mrec_lock from mutex_unlock() on the writeback worker:

  BUG: KASAN: slab-use-after-free in __mutex_unlock_slowpath+0xb5/0x970
  Read of size 8 at addr ffff8880014b7598 by task kworker/u8:0/12
  Workqueue: writeback wb_workfn (flush-253:0)
  Call Trace:
   mutex_unlock
   ntfs_inode_sync_filename
   __ntfs_write_inode
   ntfs_write_inode
   __writeback_single_inode

  Allocated by task 103:
   ntfs_alloc_big_inode
   ntfs_iget
   ntfs_lookup
   __x64_sys_mkdir

  Freed by task 12:
   ntfs_free_big_inode
   i_callback
   rcu_do_batch

  Last potentially related work creation:
   call_rcu
   destroy_inode
   evict
   dispose_list
   evict_inodes
   ntfs_inode_sync_filename
   __ntfs_write_inode

  The buggy address belongs to the object at ffff8880014b7440
   which belongs to the cache ntfs_big_inode_cache of size 1800

The freed object is the parent directory inode itself: allocated by
mkdir(2) via ntfs_iget(), then released through call_rcu(i_callback)
that destroy_inode() scheduled when evict_inodes() ran from inside
ntfs_inode_sync_filename().  Re-running the same workload with
mutex_unlock() moved before iput() runs cleanly under KASAN.

Fixes: af0db57d4293 ("ntfs: update inode operations")
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/ntfs/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 16890d411194..360bebd1ee3f 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -2582,8 +2582,8 @@ int ntfs_inode_sync_filename(struct ntfs_inode *ni)
 
 		mutex_lock_nested(&index_ni->mrec_lock, NTFS_INODE_MUTEX_PARENT);
 		if (NInoBeingDeleted(ni)) {
-			iput(index_vi);
 			mutex_unlock(&index_ni->mrec_lock);
+			iput(index_vi);
 			continue;
 		}
 
@@ -2591,8 +2591,8 @@ int ntfs_inode_sync_filename(struct ntfs_inode *ni)
 		if (!ictx) {
 			ntfs_error(sb, "Failed to get index ctx, inode %llu",
 					index_ni->mft_no);
-			iput(index_vi);
 			mutex_unlock(&index_ni->mrec_lock);
+			iput(index_vi);
 			continue;
 		}
 
@@ -2601,8 +2601,8 @@ int ntfs_inode_sync_filename(struct ntfs_inode *ni)
 			ntfs_debug("Index lookup failed, inode %llu",
 					index_ni->mft_no);
 			ntfs_index_ctx_put(ictx);
-			iput(index_vi);
 			mutex_unlock(&index_ni->mrec_lock);
+			iput(index_vi);
 			continue;
 		}
 		/* Update flags and file size. */
-- 
2.43.0

