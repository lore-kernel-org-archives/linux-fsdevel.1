Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBA02236FA
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 04:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782362756; cv=none; b=gnJRwqzDj/X1IfsEnlPq53fKmaVBx8B+HyjEN/6HudTqzfUXD59jwgPh2UHvee21V2i2RkWQZpuAQb44xkK+rBGqes6TTCIwR5XskcMBJH9csKlmkO/RqcQUKO0xiwqHgeAsxrtOJ9d5hi6NZYeXE7DgsRlKws5qav7EL/5hszo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782362756; c=relaxed/simple;
	bh=GRh1iSYKYVDNWCwJgwVbf5sb4hrMxZlyXqKxhbPuTlw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fSQfXf1JQoOomZKLyFxLaQpICB+w7Oe5FZtoJxKAY1kL6mWa42icEAYuD8hbbTIOwKFZhNWpUXGaXKZvZbLB9pZbJYUp9r6SgGjDMkOz9ZyqG7KZDtEEoeTytk4HDdBS8fL5ZDkeWwqjPhUYGZ0D2+uggCnM/B2rX8GyZo5V3T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxFU6kVx; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxFU6kVx"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-842307472d4so856704b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 21:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782362755; x=1782967555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=znor29OkcQ+wNwYoKzgzWdXuA/TUptbcDb1+PQubGc8=;
        b=hxFU6kVxGD65KkoL+qaj7dS6ndYMO2OHSmc3sBrTiF7Cu4Xhu2MIulEddrNXb7cF/q
         SfQUNgGEOfhBMyBQHUWBJY0XYIObxBVsyQVZkpgpAQwFrEaLwUWjDKsdoAHBwZ6Bo1if
         AlZ2DiaNvDLuiJ7HUs+Q5VJEvJnwZf0LRNWj4q+Bi9vL5zas1wlw/moLq0xkB2UKLtdd
         XbSq/vHXfyFh0AwJuF7iS9mzR1FXVlfyNFzs1rKRPlS4jI1Nrt1lPX8GMDL5vMsqIUsa
         X2WXKk+fSlvdBoCXB59KvKB3UmAdaFGtA4Xd1nRr615jpQgePOHwnNXRsoF6Z/Xg6Euf
         dEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782362755; x=1782967555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znor29OkcQ+wNwYoKzgzWdXuA/TUptbcDb1+PQubGc8=;
        b=DJBriEcYbdESoaulocRXXW1d0SuE+cveo06giavhq9MVObVMxAFwXHk6soZNLjwf7g
         UIpCGGuPiGVLKiMEBK8/r2gLQM/nA1AT4xWKhD6eTr2ln2YXlkZzekpiDnR8GMeQft92
         WLv+/Rl1c6QrPqNrL3VXF0YKyimWWwVnoDXFudCYqLmZJgfUh6ICE+ZhKrNPcVdggnaa
         rlUr2ldYiLxUzm35xq5SMlhfKf44uT7rUeTTQzcgWi2sANvdZeaTMTJV2E1yv5bYCSPy
         1i9rAJduniORZgiEk2Al3PqALko37J9fZzQr/1rbuLRoaZhcAge6qwz2CAimE+Qct3Dn
         iU1Q==
X-Gm-Message-State: AOJu0YxyHavzrRN+VNfBf49L1IRqV+4hyfYJ5NBLFLTNOXm2iqpg9RYz
	U+7CbZJ3DDmtXXRgMLuyOC5ZDUuGRf3rh6KvLN9/rvvsYVhoK7DZLZHf
X-Gm-Gg: AfdE7cmipyobpMIkemO7jDhLvKE2/0+4khUkQumOFJCmU7qcMWv6S3liMCYA+JlTwhK
	YBgpxz6I9uvM+LVEIZ/d2UkP7xG3dipxme9LcRXS5DxFi6iHZKPcj4hmU6q8d5IsUj8N2UHJ9vR
	ytVBCrb/HcOL3kcKIjHJcTN/j8K0fvhTSvm73e4xtb2QmvE99lyir9Uz4zGN+HGunDwzo5CmhSq
	z5/P7JpnngRHc6AT3GXVjDD3zZQhHF/oRXd/8mdxuurHG4AaRaAJFspfgapedutcfOQeTKKZTCR
	fO+CeIpK3thyJioVENThBSjr31K0UxX3mbL7VUzkTkCVeUbE6BqEzU10q8Uk0UlVwNdzL13sFEF
	CMUg4/EbJ/YbIwHbI2yl0czqdI4b3T0Aq0mpCZkUlAEvIzeLqU6KYVGI8vM30Bu4/bmlyReKAG3
	9Stx3ZigP4EhpOPeeSOA==
X-Received: by 2002:a05:6a00:10ca:b0:835:405a:7e72 with SMTP id d2e1a72fcca58-845b39e61b8mr1370544b3a.11.1782362754520;
        Wed, 24 Jun 2026 21:45:54 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a3fcd1fbsm3530139b3a.3.2026.06.24.21.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 21:45:54 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] ntfs: avoid stale runlist element dereference in MFT writeback
Date: Thu, 25 Jun 2026 12:45:47 +0800
Message-Id: <20260625044547.3729183-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_write_mft_block() maps each $MFT record through the $MFT data
runlist. For sub-folio clusters it looks up a struct runlist_element under
ni->runlist.lock, drops the lock, and later uses rl->length and rl->vcn
when choosing folio_sz.

That pointer is only borrowed from ni->runlist.rl. Concurrent $MFT
allocation extension can merge a replacement runlist under the same lock,
and ntfs_rl_realloc() can free the old backing array. If that happens
between the lookup and the later folio_sz decision, writeback can
dereference freed runlist storage.

The buggy scenario involves two paths, with each column showing the order
within that path:

MFT writeback path:               $MFT allocation extension:
1. Look up rl under               1. Extend the $MFT data allocation.
   ni->runlist.lock.              2. Publish a replacement runlist.
2. Drop ni->runlist.lock.         3. Free the old runlist array.
3. Read rl->length and rl->vcn
   to choose folio_sz.

Compute the remaining run length while ni->runlist.lock is still held, and
use that scalar after unlock. This preserves the existing folio sizing
decision without carrying a borrowed runlist_element across the lock
boundary.

Validation reproduced this kernel report:
BUG: KASAN: slab-use-after-free in ntfs_mft_writepages+0x1c8d/0x1fb0

Call Trace:
 <TASK>
 dump_stack_lvl+0x66/0xa0
 print_report+0xce/0x630
 ? ntfs_mft_writepages+0x1c8d/0x1fb0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __virt_addr_valid+0x20d/0x410
 ? ntfs_mft_writepages+0x1c8d/0x1fb0
 kasan_report+0xe0/0x110
 ? ntfs_mft_writepages+0x1c8d/0x1fb0
 ntfs_mft_writepages+0x1c8d/0x1fb0
 ? __pfx_ntfs_mft_writepages+0x10/0x10
 ? __pfx___mutex_unlock_slowpath+0x10/0x10
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? iput+0x92/0xa80
 do_writepages+0x219/0x530
 ? __pfx_do_writepages+0x10/0x10
 __writeback_single_inode+0x117/0xf50
 ? do_raw_spin_lock+0x130/0x270
 ? __pfx_do_raw_spin_lock+0x10/0x10
 ? __pfx___writeback_single_inode+0x10/0x10
 ? srso_alias_return_thunk+0x5/0xfbef5
 writeback_sb_inodes+0x65b/0x1810
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? lock_acquire+0x2b8/0x2f0
 ? __pfx_writeback_sb_inodes+0x10/0x10
 ? lock_release+0x1e0/0x280
 ? _raw_spin_unlock+0x23/0x40
 ? move_expired_inodes+0x2b8/0x850
 __writeback_inodes_wb+0xf4/0x270
 ? __pfx___writeback_inodes_wb+0x10/0x10
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? queue_io+0x2e4/0x410
 wb_writeback+0x666/0x880
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __pfx_wb_writeback+0x10/0x10
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? get_nr_dirty_inodes+0x1c/0x170
 wb_workfn+0x75e/0xbb0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? _raw_spin_unlock_irqrestore+0x27/0x60
 ? __pfx_wb_workfn+0x10/0x10
 ? __pfx_debug_object_deactivate+0x10/0x10
 ? lock_acquire+0x2b8/0x2f0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? lock_release+0x1e0/0x280
 process_one_work+0x8d0/0x1870
 ? __pfx_process_one_work+0x10/0x10
 ? srso_alias_return_thunk+0x5/0xfbef5
 worker_thread+0x575/0xf80
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x2e7/0x3c0
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x576/0x810
 ? __pfx_ret_from_fork+0x10/0x10
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __switch_to+0x57e/0xe10
 ? __switch_to_asm+0x33/0x70
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Allocated by task 970:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x14/0x30
 __kasan_kmalloc+0xaa/0xb0
 __kvmalloc_node_noprof+0x353/0x920
 ntfs_rl_realloc+0x3c/0x80
 ntfs_runlists_merge+0x1212/0x3010
 ntfs_mft_data_extend_allocation_nolock+0x3e0/0x1f40
 ntfs_mft_record_alloc+0x1ab4/0x4f10
 __ntfs_create+0x680/0x2e50
 ntfs_create+0x1e6/0x3a0
 path_openat+0x2b55/0x3c10
 do_file_open+0x1f4/0x460
 do_sys_openat2+0xde/0x170
 __x64_sys_openat+0x122/0x1e0
 do_syscall_64+0x115/0x6a0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 1294:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x14/0x30
 kasan_save_free_info+0x3b/0x60
 __kasan_slab_free+0x5f/0x80
 kfree+0x307/0x580
 ntfs_rl_realloc+0x66/0x80
 ntfs_runlists_merge+0x1212/0x3010
 ntfs_mft_data_extend_allocation_nolock+0x3e0/0x1f40
 ntfs_mft_record_alloc+0x1ab4/0x4f10
 __ntfs_create+0x680/0x2e50
 ntfs_create+0x1e6/0x3a0
 path_openat+0x2b55/0x3c10
 do_file_open+0x1f4/0x460
 do_sys_openat2+0xde/0x170
 __x64_sys_openat+0x122/0x1e0
 do_syscall_64+0x115/0x6a0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 115380f9a2f9 ("ntfs: update mft operations")
Assisted-by: Codex:gpt-5.5
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 fs/ntfs/mft.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index a5019e80951b..fd20d7abd6f5 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -2637,7 +2637,6 @@ static int ntfs_write_mft_block(struct folio *folio, struct writeback_control *w
 	s64 vcn = ntfs_pidx_to_cluster(vol, folio->index);
 	s64 end_vcn = ntfs_bytes_to_cluster(vol, ni->allocated_size);
 	unsigned int folio_sz;
-	struct runlist_element *rl = NULL;
 	loff_t i_size = i_size_read(vi);
 
 	ntfs_debug("Entering for inode 0x%llx, attribute type 0x%x, folio index 0x%lx.",
@@ -2682,6 +2681,7 @@ static int ntfs_write_mft_block(struct folio *folio, struct writeback_control *w
 					&tni, &ref_inos[nr_ref_inos])) {
 			unsigned int mft_record_off = 0;
 			s64 vcn_off = vcn;
+			s64 rl_len = 0;
 
 			/*
 			 * The record should be written.  If a locked ntfs
@@ -2701,8 +2701,12 @@ static int ntfs_write_mft_block(struct folio *folio, struct writeback_control *w
 			}
 
 			if (vol->cluster_size < folio_size(folio)) {
+				struct runlist_element *rl;
+
 				down_write(&ni->runlist.lock);
 				rl = ntfs_attr_vcn_to_rl(ni, vcn_off, &lcn);
+				if (!IS_ERR(rl))
+					rl_len = rl->length - (vcn_off - rl->vcn);
 				up_write(&ni->runlist.lock);
 				if (IS_ERR(rl) || lcn < 0) {
 					err = -EIO;
@@ -2733,7 +2737,7 @@ static int ntfs_write_mft_block(struct folio *folio, struct writeback_control *w
 
 			if (vol->cluster_size == NTFS_BLOCK_SIZE &&
 			    (mft_record_off ||
-			     (rl && rl->length - (vcn_off - rl->vcn) == 1) ||
+			     rl_len == 1 ||
 			     mft_ofs + NTFS_BLOCK_SIZE >= PAGE_SIZE))
 				folio_sz = NTFS_BLOCK_SIZE;
 			else
-- 
2.43.0

