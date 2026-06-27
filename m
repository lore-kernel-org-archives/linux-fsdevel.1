Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBC6175A69
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jun 2026 04:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782534487; cv=none; b=IJiklGtY1dx5TxQex9+AVcDaMG9MkDCf++DuPin0HfLOj1LGPChuRxSGcIFCajIQFtNsLbx8QRUX/aVkHJXIhIG6moHk9jeN1Mr+3wJgUCdqvRakYMhPJXSxxfuMCY8OeBDehPCQJV8VHkNih87pjC6sHZR1e96wJoKjk5Ti0hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782534487; c=relaxed/simple;
	bh=CslrLekTVHl9z3cjLuk6lO+68kMRlurUvl48ZNr3O8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=msC7zthcGMmVTk0sVAz6Bz6QtU0HmNarVqgM+59xUQoSmtIYVb9CHGpi+EKMgUH0AABSZ0zC93xsRUlGZc8YWMkMGeQ6eeOOtFnCNPTNeCD5ws4gW1s/dIc++o94iD4ygT8YA+gKrCGDUBngUBP7GOO6qaJ/0jgVU9CJjtMzSMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8BHcqx8; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8BHcqx8"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c7f1db3ad4so15520175ad.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2026 21:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782534485; x=1783139285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=om2RB2SmC2niukiy60C/3EPNOAQudzn37k82pM7gjKQ=;
        b=X8BHcqx8+AzwJDWDwEhroUZM079QfVQCe0t30JgliMPuWD5jTbMtoLSJKWmQAgoz2v
         OFX37jIIJex3QdNZ5EshIETlwcg1qu7RR8GQtiS0OBqRDL7wOlpfksE+YmMKAEgMPhBe
         QirUDwFSkDyqpNpqv3BkNCYvBoJMmPholj0/2GOO97tWebjvpSIfqPTI1jIzinGohAbs
         NUjgeekwdv0x2uaXb717/z8RR3qU4ZmdKCXujm9u8yu2T9YbcoYLslUel+X7JnB7SGO3
         B9IXgZpxLPf+5wSNssUKANAYxblK0aGNXpKVKMkqEK8oY2G3LNZw2YeL+rRcOCqAYv03
         UvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782534485; x=1783139285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=om2RB2SmC2niukiy60C/3EPNOAQudzn37k82pM7gjKQ=;
        b=E7eFUDJy20ITVpaGepVbVGNcM+1S3nuKHWimXcntmQnt9P5kS0uApLwg11a1WruoOD
         yGVFy7qlRshMjfYCWn/e329Y3y/A77/lOG0nXfFwejL7em8aPcAJhyxF4vBnazZ38+9J
         JHJ7QpWNSnH8KOK5vsk1ktcA6jdiEOKosFjK5zJ4CBgyIEEAhByNDOc0LXlJ3lE0D/DZ
         D9FPRtUmh+zXMbCOjA2clYG6DYg8A+mRj2rZDgIv1i2ORn6Oip9QUY5rSfGk+bs2Gio+
         Uu5HaKKiMfPx1Bf6YVX8YG9Y+R2KIGHGy0+7P+5HvV5H/hio4jZ9XXV8xIGrUQESQH7C
         ocvQ==
X-Gm-Message-State: AOJu0YwGnproOARg2ae9cG93akWHxJXOLxy0DlOWIs/o0ouohifGwxpP
	ntHUUlzDtTh6w2G2XZdtUYCjccFALe6v9LJzpOEQ0C17VfB4hPlPTNaIDkDfmAfatM8=
X-Gm-Gg: AfdE7cn2ACpNtnbqDkbKNFL2x1qfoYFCKp6LzGAikEm6pctAmQDHA+HC5TWnh/7gXHO
	F8tUvTag2S9pruC5OaGRoapTRmO7Yno8Vq3LkiWoaWhrJ9CXYpmPzoV/u8AvcKsYPaFcVccr4z2
	MOVvMVcCl8VUxsSgAalBRzVf9y8WkQUCpnkRZSN/GzN2vd1R8Mqe0OQQNgoigkH3x08NoDRE4JS
	hkXNK5scrzR1BIPCBozjAgRXsYMnRSGbXf6/6VXvZn+FkW/hhp++tVuAP+8PixBLmXpaq4m/ZmC
	YHP+U1399gRr6awi2eIQlQPdgsjYYK9VzgEbmrpiu4hNREUnxU/ameCAnkjG+UO7ct66h9GkOao
	cwxzRkVIJdjnarRM1VHgCKp+D25T0MjZPg/OXFetnlul2XLVnbsuaErv4J8WUSH9kFMBZ1NgyRW
	Ql1F//NOA=
X-Received: by 2002:a17:902:ffcb:b0:2bd:c925:3a16 with SMTP id d9443c01a7336-2c7fc9bfc55mr93355805ad.2.1782534484956;
        Fri, 26 Jun 2026 21:28:04 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f650827fsm50014905ad.77.2026.06.26.21.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 21:28:04 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH v2] ntfs: avoid stale runlist element dereference in fallocate
Date: Sat, 27 Jun 2026 12:27:58 +0800
Message-Id: <20260627042758.2841821-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_attr_fallocate() allocates holes and delayed allocations inside
initialized size by looking up the current runlist element under
ni->runlist.lock. The returned struct runlist_element is only a borrowed
pointer into ni->runlist.rl. A writer can replace and free that array
after the read lock is dropped, so later reads of rl->lcn, rl->length and
rl->vcn can touch freed memory.

The buggy scenario involves two paths, with each column showing the order
within that path:

ntfs_attr_fallocate():
  1. Take ni->runlist.lock for read.
  2. Get rl from ntfs_attr_find_vcn_nolock().
  3. Drop ni->runlist.lock.
  4. Read rl->lcn, rl->length and rl->vcn.

mmap page_mkwrite:
  1. Enter ntfs_filemap_page_mkwrite().
  2. Reach __ntfs_write_iomap_begin() and ntfs_attr_map_cluster().
  3. Merge allocation state with ntfs_runlists_merge().
  4. Reallocate ni->runlist.rl in ntfs_rl_realloc(), freeing the old array.

Validation reproduced this kernel report:
BUG: KASAN: slab-use-after-free in ntfs_attr_fallocate+0xbb8/0xd00

Call Trace:
 <TASK>
 dump_stack_lvl+0x66/0xa0
 print_report+0xce/0x630
 ? ntfs_attr_fallocate+0xbb8/0xd00
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __virt_addr_valid+0x20d/0x410
 ? ntfs_attr_fallocate+0xbb8/0xd00
 kasan_report+0xe0/0x110
 ? ntfs_attr_fallocate+0xbb8/0xd00
 ntfs_attr_fallocate+0xbb8/0xd00
 ? lock_acquire+0x2b8/0x2f0
 ? __pfx_ntfs_attr_fallocate+0x10/0x10
 ? 0xffffffffc0000095
 ? down_write+0x10d/0x1e0
 ntfs_fallocate+0x5c9/0x1d00
 ? __pfx_ntfs_fallocate+0x10/0x10
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? lock_acquire+0x2b8/0x2f0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? selinux_file_permission+0x3a7/0x510
 vfs_fallocate+0x29d/0xd30
 __x64_sys_fallocate+0xc7/0x150
 ? do_syscall_64+0x81/0x6a0
 do_syscall_64+0x115/0x6a0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Allocated by task 410:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x14/0x30
 __kasan_kmalloc+0xaa/0xb0
 __kvmalloc_node_noprof+0x353/0x920
 ntfs_rl_realloc+0x3f/0x110
 ntfs_runlists_merge+0xaa3/0x3010
 ntfs_attr_map_cluster+0x4e5/0xf80
 ntfs_attr_fallocate+0x53f/0xd00
 ntfs_fallocate+0x5c9/0x1d00
 vfs_fallocate+0x29d/0xd30
 __x64_sys_fallocate+0xc7/0x150
 do_syscall_64+0x115/0x6a0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 424:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x14/0x30
 kasan_save_free_info+0x3b/0x60
 __kasan_slab_free+0x5f/0x80
 kfree+0x307/0x580
 ntfs_rl_realloc+0x6f/0x110
 ntfs_runlists_merge+0x7b1/0x3010
 ntfs_attr_map_cluster+0x4e5/0xf80
 __ntfs_write_iomap_begin+0x8cd/0x2280
 iomap_iter+0x6de/0x11e0
 iomap_page_mkwrite+0x391/0x650
 ntfs_filemap_page_mkwrite+0x1ac/0x400
 do_page_mkwrite+0x15c/0x280
 __handle_mm_fault+0xd6d/0x1ca0
 handle_mm_fault+0x19c/0x470
 do_user_addr_fault+0x23b/0x9c0
 exc_page_fault+0x5c/0xc0
 asm_exc_page_fault+0x26/0x30

Fix this by copying the needed runlist fields while the read lock is still
held and using only those scalar snapshots after unlocking.

After the snapshot, ntfs_attr_map_cluster() can also find that the range
is already mapped and return balloc=false. Only call ntfs_dio_zero_range()
when new clusters were allocated, matching the write iomap path and
preserving the zero-newly-allocated-holes behavior.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
Fixes: 495e90fa3348 ("ntfs: update attrib operations")
Assisted-by: Codex:gpt-5.5
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
v2:
Skip ntfs_dio_zero_range() when ntfs_attr_map_cluster() reports that no
clusters were allocated, as suggested by Hyunchul Lee.

 fs/ntfs/attrib.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index dd8828098511..a99b84751eb1 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -5536,6 +5536,7 @@ int ntfs_attr_fallocate(struct ntfs_inode *ni, loff_t start, loff_t byte_len, bo
 	s64 old_data_size;
 	s64 vcn_start, vcn_end, vcn_uninit, vcn, try_alloc_cnt;
 	s64 lcn, alloc_cnt;
+	s64 rl_lcn, rl_length, rl_vcn;
 	int err = 0;
 	struct runlist_element *rl;
 	bool balloc;
@@ -5615,19 +5616,23 @@ int ntfs_attr_fallocate(struct ntfs_inode *ni, loff_t start, loff_t byte_len, bo
 	while (vcn < vcn_uninit) {
 		down_read(&ni->runlist.lock);
 		rl = ntfs_attr_find_vcn_nolock(ni, vcn, NULL);
-		up_read(&ni->runlist.lock);
 		if (IS_ERR(rl)) {
+			up_read(&ni->runlist.lock);
 			err = PTR_ERR(rl);
 			goto out;
 		}
+		rl_lcn = rl->lcn;
+		rl_length = rl->length;
+		rl_vcn = rl->vcn;
+		up_read(&ni->runlist.lock);
 
-		if (rl->lcn > 0) {
-			vcn += rl->length - (vcn - rl->vcn);
-		} else if (rl->lcn == LCN_DELALLOC || rl->lcn == LCN_HOLE) {
-			try_alloc_cnt = min(rl->length - (vcn - rl->vcn),
+		if (rl_lcn > 0) {
+			vcn += rl_length - (vcn - rl_vcn);
+		} else if (rl_lcn == LCN_DELALLOC || rl_lcn == LCN_HOLE) {
+			try_alloc_cnt = min(rl_length - (vcn - rl_vcn),
 					    vcn_uninit - vcn);
 
-			if (rl->lcn == LCN_DELALLOC) {
+			if (rl_lcn == LCN_DELALLOC) {
 				vcn += try_alloc_cnt;
 				continue;
 			}
@@ -5642,11 +5647,14 @@ int ntfs_attr_fallocate(struct ntfs_inode *ni, loff_t start, loff_t byte_len, bo
 				if (err)
 					goto out;
 
-				err = ntfs_dio_zero_range(VFS_I(ni),
-							  lcn << vol->cluster_size_bits,
-							  alloc_cnt << vol->cluster_size_bits);
-				if (err > 0)
-					goto out;
+				if (balloc) {
+					err = ntfs_dio_zero_range(VFS_I(ni),
+								  lcn << vol->cluster_size_bits,
+								  alloc_cnt <<
+								  vol->cluster_size_bits);
+					if (err > 0)
+						goto out;
+				}
 
 				if (signal_pending(current))
 					goto out;
-- 
2.43.0
