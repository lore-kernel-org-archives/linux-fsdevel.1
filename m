Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2D435DA5B
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 08:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782376442; cv=none; b=NqPwjwMzbfndywqiB8jkDdZGMtCjLTkrqVCBX+Q8jUEQU9xm4GW6utqcAFt2Mluew+RUv9+arw0VdaavRYOW1je9K3KKMn0pzmwVZqp0t8ehF6SDm0fZkWf29LF+NevGNoETyR62fDnUVqMHoBHi9tK3mOGTKxe2SXUglOI8Bo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782376442; c=relaxed/simple;
	bh=UX6I5CmKqHU3EwkLYIQI1LuMT+PrD4dHD7fjhhAG0Lc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZqeHXsmsz5k1BkKjyxoaAEPThW+W3pjohRymO1xAf702tq5KBiqYqr1xyEK8VVLiqHtB6LUrnuGIwXegTjjeq6pZCkva67TwDZ4yxhdt/02v0JX4BSeFGsvL+O2bTSpfmhi5YFBHbD49aTpRpYHR+JBCy/wauEsqAsnzmujE/8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIhicKh/; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIhicKh/"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c88d4606ec8so744904a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 01:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782376440; x=1782981240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+GSdXeFkdYhxY5ojG6ru563ACFoP26tU1BVeBK76VXQ=;
        b=bIhicKh/sD1cxtbQceDZK91qFcyOf3C9FcH1lnt0SS8rXoqgQUgKCOmmtM7Wsbagp4
         aerLfwH+wd9bq67YjloJiYT7WA8w1PR3aYw5dPe9yOWEdIakVC8bMSGQCwDwTRGEPxD4
         AUuWDyIx9hMLTAlXUFEKb8XT1kGDu3/c3COgP8MlJIzd6B2Zo91lxe6dxOvo6fdo9VDn
         EFPhXBt0rkCuIMIRVycMIV1gMIV/2bpp+8D5MiqIYEMWoMDEUMUpjHviYHGNAc6pwjMR
         i4fO5LFQmlZMfdiul8xjnhUuNY5NZioPPq6UvfV5fPrHwB5x4QxAYwesMuAX2LU95A1/
         vvVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782376440; x=1782981240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GSdXeFkdYhxY5ojG6ru563ACFoP26tU1BVeBK76VXQ=;
        b=RzlEL3NkIR+BV8BoI/X7ew1dYtfvfPQxr0haoq2l44L4/KrEjFU1eg1Bb1/S8jplYQ
         Dg77luoWr621ecBu6KrM3CNSmxBd0rYi7QRg4UGve3ulT5lTPeMz/D5b685BnhGKpPPM
         ZjPABxbOF7nnX4Ooro6DZM1IlBoHNSJg8ZA0qN1Vfx0vOS5r5DTIVOLWPBeL6SxGd3Pw
         rm+bgGmq2L4CBOuqTfZXhnuXZXcVxicHhVwMsDVD0xVWYjrhEKOtdWnsOZ0qorcehRP8
         dHwJK2TH3yL4oYi6UuXJXc8UYsJYpe56scgimDLO+fsWyp+9epYG12FG8wGAAV8L1blu
         UbKg==
X-Gm-Message-State: AOJu0Yxa+G2xzBNFghI5h3dXiAGETaTIDftQH5S6T2B9UqEiV4dPTDqW
	M+WhF9ZXi1RSIM+kq08zF0aIbNaqJKHIgQF0G4qDGNmbTIrhJunnArqF
X-Gm-Gg: AfdE7cnjud+zC/nOEWViYo4Nnn3YIQfYNNTqmLOPrSkeVux+VWYcHQIm2k2xKqIk/+q
	aQQKE7RbIT0O+O1yIo6fLHxrylG3sM36NOEAKSyhmYNpdTdt5bP6+WIPiVZUpKKFBtn0Mp66WLn
	HSJCAGgACBjcupLRl2AoRnBxHwIYq8qA+dJJAGNemZ+HY4dnV/bF+kHP37w0UX0FlQbZJtLg2ib
	muZurITabjyjExUFc53EyBLMhkoh23NCPS1wzeQyPSiBYyMzLZFH9rcBGXkqW4aVfXutgww9BM1
	DjjsDZfav8Kny+YZmyvSDCzr2R7wv5mtnCl6EWDTM1WdL1opMLchqBi0sKRkiQXffF0hjjb44SA
	d3SL4lC88wBgUhL4fs/C7vaChaJbGLSaMfOGhEMkeg5NDhNdHsDcJ0o7lqttxsL5OYdLhtMq8Aj
	1cJ/3v4NQ=
X-Received: by 2002:a17:903:946:b0:2c7:ef3b:e17f with SMTP id d9443c01a7336-2c7fc791633mr17443135ad.36.1782376439972;
        Thu, 25 Jun 2026 01:33:59 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f650aa8esm14739595ad.82.2026.06.25.01.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 01:33:59 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] ntfs: avoid stale runlist element dereference in fallocate
Date: Thu, 25 Jun 2026 16:33:53 +0800
Message-Id: <20260625083353.132243-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_attr_fallocate() walks the data runlist when it allocates holes or
delayed allocations inside initialized size.  It looks up a struct
runlist_element under ni->runlist.lock, drops the lock, and then reads
rl->lcn, rl->length and rl->vcn to decide how far the current extent can
advance.

That pointer is only borrowed from ni->runlist.rl.  A racing mmap
page_mkwrite path can enter __ntfs_write_iomap_begin(), map clusters, and
replace the same runlist through ntfs_runlists_merge().  When
ntfs_rl_realloc() allocates replacement storage, the old runlist array is
freed while fallocate still carries the stale element pointer.

The buggy scenario involves two paths, with each column showing the order
within that path:

ntfs_attr_fallocate():            mmap page_mkwrite path:
1. Look up rl under               1. Enter __ntfs_write_iomap_begin().
   ni->runlist.lock.              2. Map clusters through
2. Drop ni->runlist.lock.            ntfs_attr_map_cluster().
3. Read rl->lcn, rl->length       3. Merge a replacement runlist.
   and rl->vcn.                   4. Free the old runlist array.

Snapshot the needed runlist fields while ni->runlist.lock is still held,
and use only those scalars after unlock.  This preserves the existing
fallocate decisions without extending the lock over the later allocation
and zeroing work.

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

Fixes: 495e90fa3348 ("ntfs: update attrib operations")
Assisted-by: Codex:gpt-5.5
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 fs/ntfs/attrib.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index dd8828098511..73e01f32c067 100644
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
-- 
2.43.0

