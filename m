Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680A3288C2D
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2026 01:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782438437; cv=none; b=XnImKxI7vGXHPSqjwxbANV9e0pWlYi6ZdI/qK3ZHt1AfBGofBidAGoxlVxRBxoFnm8SzlDJVT0GgHrNGCAtgStPPqwzEx7FYK5HvsZcp1gXKF2J4kM+QbD6Fa2ntXLHVm6TKMUx2I8XgGEgK94EPXsl6cQczFlYkhSbExRBNF7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782438437; c=relaxed/simple;
	bh=xeZsPWgK3AjbLhRWpEoIaxBFDKlXe4aYu3FcmCtqKoA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tEtysfRwVnjbO/Bm1gy2Qfo9Eabhk0OlSEpypdC8xZVloif/EpkXITliXkXbVx8GrQSUpxUYv1kNkyDsVFcIDUbCBO2H52JvQnV2wazuhlJndbxuoa3+/OhMTSf5mPIgttL/1tpPWFhAi10lNIfY8xc1d9nv4pY5TQkj4Y0I2S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpFpAWkT; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpFpAWkT"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c7ee3952f2so2361585ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 18:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782438434; x=1783043234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FoSu3ldRKTlHSHFb26a5f7zhGyPgD0yDIBGutihHg7s=;
        b=ZpFpAWkT47inzAr4p8iwrM9B6N/fZeFgf2u4HaV+EJ6bUNwWCvmCO9F2Jz/hXqsGTq
         TmQZBgAwfWDl0aSvvyN1u4sDqA4Ym0BBDxXcPVLHlcFDbN3tQVUyrXarqh+UlIL/liGV
         NNxrdieNgg/4Pl/mLQTgBRLVVnAqMwGt9oeExrxkpfybRuEXg64sY35e8v6nd70rFXqz
         KM+2B12gkWOqrQQki/KOgEVZqxyDz+g7s7BCnQ23OyVHX7mriEIqn26j3crggkCRA9MO
         o2QTjQV99QIHdHjB71I09zhLfK8cNeTRH7sy+YUvO1fW2M3nJdgHvAJxhQV81/ssqOZt
         PTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782438434; x=1783043234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FoSu3ldRKTlHSHFb26a5f7zhGyPgD0yDIBGutihHg7s=;
        b=RbXiin4SefWOmSIhsR3OFJK/3e5ebtdkAl30DFTvuMY/3pORzAuM2D4OvoNscN7t31
         9tzacsxJnG/nYltR2dkql2owWOUunxu8Hh8/lWHZxYD2ykuBIx7zZCsCwbpc1jbeHWBE
         Ey1kY2H0QmgGt132Rx6rmilt8SoMzrKnwMPjo/OJTdmZqT4ERSr/JDVEksX2M+vFV3zC
         vc+xeaqWbNPBuce0lpG6yrpiKl1vh7C07KMKLmeZxBO3lzK/gwlC0I1MB8igIOWgdbM4
         C4noEUMVHKfI5Tm+FfiLKm9tCf4dKV3COSMm8/XUsEZmGHswr3X0YCbb4S6yN6Zv750g
         8Hcg==
X-Gm-Message-State: AOJu0YzznqvSi6ViNQQQqAcViv2lPbJzdhvUtA7wRGplQ1XkRnltuJN4
	DngpiNyEEZoL8/JlFtZnYdIpy/WA22EGzQin95QONdoEwHWrgXycp8PA
X-Gm-Gg: AfdE7clcJEELyzM7/gwEf73HDhyY9Y5VyC7cDD8H2VZKD6+f15BWp+yiSj7ZqJR8YGv
	IZNRxaxXWwTR8nNARjW45+HiWMkSVPp9RpzcPEN0geEtpaEcBNeRA8J3QaPDPZNAhourCsKhl/m
	lOZv4R5ZX9nxxXng5onGB/whdJJYcOBudlQOyh6cdM7WMeRJK/A7fiBK9UEF9DXsdfi0hV6sx7p
	/SfZCt0IXlGVxlDg20KKTDRTqpBzLZXo7fKbpNwGCaVqNM2lYtVJLGSR4vhwgYeD1MzQb7o6QtG
	krFLojIqQtwsrGrESvvJELze/n0hPKYSNfM8I2/EgD7EsTCOVK7yTQl8wTPAiZHZFNCzaTNzj3Y
	da6pIvlDaNqtt5GRUBS840FuHn3kdFUoDrpqjlj0XTa8v+rCB3eRPY6BRVRLzqQ8kQx6dggygJd
	gVpiBZw3w=
X-Received: by 2002:a17:902:d2cd:b0:2c6:e146:79ac with SMTP id d9443c01a7336-2c7fc662e95mr46901045ad.7.1782438433520;
        Thu, 25 Jun 2026 18:47:13 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f6509ca0sm29016765ad.81.2026.06.25.18.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 18:47:13 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] ntfs: serialize read iomap lookup with mrec_lock
Date: Fri, 26 Jun 2026 09:47:06 +0800
Message-Id: <20260626014706.2840003-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Take the base inode's mrec_lock in the shared read/seek iomap begin
wrapper so both resident and non-resident lookups run under the same
serialization already used by the write-side metadata path.

The buggy scenario involves two paths, with each column showing the order
within that path:

read/seek iomap lookup path:
1. Enter __ntfs_read_iomap_begin().
2. Enter ntfs_attr_lookup() / ntfs_external_attr_find() on
   base_ni->attr_list.
3. Keep raw attr_list_entry cursors while mapping the extent.

attr-list mutation path:
1. Enter ntfs_attrlist_entry_add() or ntfs_attrlist_entry_rm().
2. Publish the replacement base_ni->attr_list.
3. kvfree() the old buffer.

Validation reproduced this kernel report:
BUG: KASAN: slab-use-after-free in ntfs_attr_lookup+0x24b2/0x2bf0

Call Trace:
 <TASK>
 dump_stack_lvl+0x66/0xa0
 print_report+0xce/0x630
 ? ntfs_attr_lookup+0x24b2/0x2bf0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __virt_addr_valid+0x20d/0x410
 ? ntfs_attr_lookup+0x24b2/0x2bf0
 kasan_report+0xe0/0x110
 ? ntfs_attr_lookup+0x24b2/0x2bf0
 ntfs_attr_lookup+0x24b2/0x2bf0
 ? ntfs_attr_lookup+0x9/0x2bf0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? 0xffffffffc00000da
 ? __pfx_ntfs_attr_lookup+0x10/0x10
 ntfs_attr_map_whole_runlist+0x488/0x8b0
 ? __pfx_ntfs_attr_map_whole_runlist+0x10/0x10
 ? __pfx_do_raw_spin_trylock+0x10/0x10
 ntfs_attr_vcn_to_rl+0x13a/0x1d0
 ? filemap_fault+0xf03/0x2080
 ntfs_read_iomap_begin_non_resident+0x142/0x920
 ? __pfx_ntfs_read_iomap_begin_non_resident+0x10/0x10
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __pfx_ntfs_read_iomap_begin+0x10/0x10
 iomap_iter+0x6de/0x11e0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? prepare_alloc_pages+0x1c4/0x4d0
 iomap_readahead+0x239/0x910
 ? folios_put_refs+0x1ed/0x4f0
 ? __pfx_iomap_readahead+0x10/0x10
 ? __pfx_folios_put_refs+0x10/0x10
 ? lock_release+0x1e0/0x280
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? xas_store+0x871/0x1650
 ? xas_find_conflict+0x64b/0xb90
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? lock_release+0x1e0/0x280
 ntfs_readahead+0x193/0x1d0
 ? __pfx_ntfs_readahead+0x10/0x10
 ? __filemap_add_folio+0x869/0xa60
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? lock_acquire+0x2b8/0x2f0
 ? __pfx___filemap_add_folio+0x10/0x10
 read_pages+0x18f/0x890
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? folio_alloc_noprof+0x69/0xb0
 ? __pfx_read_pages+0x10/0x10
 ? srso_alias_return_thunk+0x5/0xfbef5
 page_cache_ra_unbounded+0x389/0x6c0
 do_page_cache_ra+0x109/0x170
 filemap_fault+0xf03/0x2080
 ? __pfx_filemap_fault+0x10/0x10
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? lock_acquire+0x2b8/0x2f0
 ? lockdep_init_map_type+0x5c/0x230
 __do_fault+0xf0/0x260
 __handle_mm_fault+0xdcf/0x1ca0
 ? __pfx___handle_mm_fault+0x10/0x10
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? lock_release+0x1e0/0x280
 handle_mm_fault+0x19c/0x470
 do_user_addr_fault+0x23b/0x9c0
 exc_page_fault+0x5c/0xc0
 asm_exc_page_fault+0x26/0x30

Allocated by task 511:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x14/0x30
 __kasan_kmalloc+0xaa/0xb0
 __kvmalloc_node_noprof+0x353/0x920
 ntfs_attrlist_entry_rm+0x28d/0x510
 ntfs_attr_record_rm+0x4dd/0xda0
 ntfs_delete+0x50a/0xf90
 ntfs_unlink+0x212/0x4d0
 vfs_unlink+0x259/0xb00
 filename_unlinkat+0x2db/0x5f0
 __x64_sys_unlink+0x46/0x70
 do_syscall_64+0x115/0x6a0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 511:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x14/0x30
 kasan_save_free_info+0x3b/0x60
 __kasan_slab_free+0x5f/0x80
 kfree+0x307/0x580
 ntfs_attrlist_entry_add+0xc1b/0x1110
 ntfs_resident_attr_record_add+0x6a8/0xa10
 ntfs_attr_add+0x682/0xcd0
 __ntfs_link+0x815/0xde0
 ntfs_link+0x223/0x3d0
 vfs_link+0x465/0xcf0
 filename_linkat+0x316/0x540
 __x64_sys_link+0x81/0xb0
 do_syscall_64+0x115/0x6a0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: b041ca562526 ("ntfs: update iomap and address space operations")
Assisted-by: Codex:gpt-5.5
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 fs/ntfs/iomap.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/fs/ntfs/iomap.c b/fs/ntfs/iomap.c
index 52eecf5cb256..5f15a0432f0c 100644
--- a/fs/ntfs/iomap.c
+++ b/fs/ntfs/iomap.c
@@ -263,11 +263,26 @@ static int __ntfs_read_iomap_begin(struct inode *inode, loff_t offset, loff_t le
 		unsigned int flags, struct iomap *iomap, struct iomap *srcmap,
 		bool need_unwritten)
 {
-	if (NInoNonResident(NTFS_I(inode)))
-		return ntfs_read_iomap_begin_non_resident(inode, offset, length,
-				flags, iomap, need_unwritten);
-	return ntfs_read_iomap_begin_resident(inode, offset, length,
-					     flags, iomap);
+	struct ntfs_inode *ni = NTFS_I(inode);
+	struct ntfs_inode *base_ni = NInoAttr(ni) ? ni->ext.base_ntfs_ino : ni;
+	bool lock_mrec = NInoAttrList(base_ni);
+	int err;
+
+	if (lock_mrec)
+		mutex_lock(&base_ni->mrec_lock);
+
+	if (NInoNonResident(ni))
+		err = ntfs_read_iomap_begin_non_resident(inode, offset, length,
+							 flags, iomap,
+							 need_unwritten);
+	else
+		err = ntfs_read_iomap_begin_resident(inode, offset, length,
+						     flags, iomap);
+
+	if (lock_mrec)
+		mutex_unlock(&base_ni->mrec_lock);
+
+	return err;
 }
 
 static int ntfs_read_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
-- 
2.43.0

