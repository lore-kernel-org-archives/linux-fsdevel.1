Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6517631E853
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 16:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009045; cv=none; b=MPcF/HYS8LADLOnf0/FenCWBxao8rM2t5UrmWarCc+79hawn4C8paGVLESx3eAmEhBtCOtpF3bSupIC8eiPHk8gMmy6M6lT/bKAdG6TDfJnLLA67nh4TnDTmPWw6qQrOk4H84iQhh16mBSTOlnoJLGkj7yt6uksdq7OP/jEmeQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009045; c=relaxed/simple;
	bh=J4GgX7ZLPGLzUInU4XnjxZ4s6IO4gojjxsSh0cscBkI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B6LzipRdXlfsFraXfXeEwb32UsO80o/nojuHX01s9gY7Ah1N2HfthkIU9pPPXSDd83o0uXxovs+OIeilbg5r3HBH7eWiAWCzFFPe+ZiUKd8MPjLIdRr06Nt3QXrYg/5ilgat9Z715A/4yrDZTlmILq2e8nH3UtJyqD+cjHTddcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6ii/Ont; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6ii/Ont"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-847a483e344so873538b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2026 09:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783009040; x=1783613840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7pktN3ut8/S9nazozmZQKqEuihpeLNV0fsGXt1JcLqQ=;
        b=V6ii/OntvtoTEt4t6jQf8MDnO549QEShcutk0xpaj1Xnod4fpalsRRAECzYZlJDnzT
         ONbLPpZv5P15F4GdnoTClZIjv/LsggeWGZlHJK8/veG2j193lxqh3a7mft6j+j+zn27w
         UX5YQoi6HxLQayXj0vBOsHcgYn29wXEIiVjKgZe7uD0chJf9lxmyc9Sx0ywIJ2lEr/oA
         P6UEcoPy22y4GEhWKdzk8/59Gagdv/39TI3bUR9PX45YxMzITzh6h0RKKhqe+VGsaw8U
         XNcv4jKdDunA3T9PzDp1XynV+LdaFd/wOt9n/H6Z5qcYrFyGErYlLAoQEB5+d8e6dM32
         mWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783009040; x=1783613840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pktN3ut8/S9nazozmZQKqEuihpeLNV0fsGXt1JcLqQ=;
        b=KmG4w987cfviRXwETo5wK8cm3U37Zyyzhl9P/HWwowKRamK38HWBC8sAGuz0bMZYjZ
         ypRrkwdxahiPzmvVm4Dbfc6o63gKo5zecC84YoSReCX23PRHOEKb+adLVBWlusyxApi9
         fnAPp/B19x8+jPg1rdwGJCdiViCDbE22GsG/jMXziN9RWqWHrc9f3TMVneSnwBcdNHCQ
         M4sDxNCMOwtiF0I3RVLhfENWU1HQ5z9mAluuTxSiKsnuYo+/z2ioghQAIgy6tHOamyE3
         QOmWJGUuhOxK0LGNunlo39J7/m0iWUWyZ9CquT7V9XPJh8Kw/QiBfXkqt3zUHuwnB2qZ
         8Ajg==
X-Gm-Message-State: AOJu0YyNTnjYE+wZYF8tiKbP23pr/znEigsRehW/ZDxhQPMRg0wii5TP
	A0b4ggajYsTlS2vFWRHPvqh8jJQwLbFaGwDd4BcV8PRGsKazio4sjwKy
X-Gm-Gg: AfdE7cnWbOXfVUbKbMbS3AioMLQ7yeZiDOY3Ed1jbUgH+YfpjxGVbNHgG4gikKpwR2e
	R5m+DFhkMpGwRB8AEIZNm0fEDMkNbb6Z5YhHhV5oxVtq2wkgTI05wu1Phc3GU6WgYg+JlYgwqGN
	ujHZ2uuIAmJr8iR3zPA5dPPwegP6O47a3jU1YdkQ/PX9Zr1rI7uauJBv3vFdJu+Exdb+TiaxrC+
	0sjR+jWXq+OPuGiu3Zcq7R9I+9qEnpDu+zbpt3VGfw3bgbZDu+CyMB7Ko3lTsCwU15D/bHt67WN
	w4pWjyGYQCeMw7T6Fnkt012li7pTnEePiXQ4Lz0j1nv07pNRBdG/p59qfeb4ACUaM7i4DAHXVts
	DubFi3ly1TJyL8CBO/Z0Y1/sCcg+DK4w0FM0js+DRzen/1cxRYReq6gDg3yPkU0dl3IhKxZHL0N
	f7+7j+kYs=
X-Received: by 2002:a05:6a00:2e88:b0:847:8f33:b159 with SMTP id d2e1a72fcca58-847e17bb433mr402842b3a.10.1783009039904;
        Thu, 02 Jul 2026 09:17:19 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb9a394asm1584612b3a.47.2026.07.02.09.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 09:17:18 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH v4] ntfs: serialize attribute-list replacement with lookups
Date: Fri,  3 Jul 2026 00:17:10 +0800
Message-Id: <20260702161710.2606853-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_external_attr_find() walks base_ni->attr_list with raw
attr_list_entry cursors stored in ctx->al_entry and local variables.  Other
metadata paths can replace base_ni->attr_list and free the old buffer while
a lookup still carries one of those cursors.

The buggy scenario involves two paths, with each column showing the order
within that path:

  attribute lookup path:              attribute-list mutation path:
  1. enters ntfs_attr_lookup()        1. enters an attr-list add/remove
  2. reads base_ni->attr_list         2. builds a replacement buffer
  3. keeps ctx->al_entry/al_entry     3. publishes base_ni->attr_list
     pointing into that buffer        4. frees the previous buffer
  4. continues the attribute search
  5. dereferences the saved cursor

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

Add a per-ntfs_inode attr_list_lock and couple it to
ntfs_attr_search_ctx.  Search contexts that may carry attr-list cursors
take the read side for their full lifetime, so ctx->al_entry remains
protected until ntfs_attr_put_search_ctx().  Attribute-list mutation paths
use the write side while deriving offsets from the old list and publishing
the replacement list.  Contexts used under runlist.lock use an explicit
NONE mode so the ordering stays:

  mrec_lock => attr_list_lock => runlist.lock

Fixes: 495e90fa3348 ("ntfs: update attrib operations")
Assisted-by: Codex:gpt-5.5
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
v4:
- Rebase onto ntfs-for-7.2-rc1 and carry attr_list_lock through the
  rebased nolock runlist mapping paths.
- Make LOCK_NONE assert that attr_list_lock is already held.
- Remove the lock_mode argument from __ntfs_attr_update_mapping_pairs().
- Avoid recursive attr_list_lock acquisition when resident resize calls
  ntfs_attr_make_non_resident().

v3:
- Keep attr_list_lock tied to ntfs_attr_search_ctx lifetime instead of
  taking it only around ntfs_attr_lookup().
- Add nolock helpers for paths that already hold attr_list_lock before
  runlist.lock, preserving the mrec_lock => attr_list_lock => runlist.lock
  order.
- Protect the remaining direct attr_list walker in
  ntfs_inode_attach_all_extents().
---
 fs/ntfs/aops.c     |   3 +
 fs/ntfs/attrib.c   | 315 ++++++++++++++++++++++++++++++++++++---------
 fs/ntfs/attrib.h   |  27 +++-
 fs/ntfs/attrlist.c |  30 +++--
 fs/ntfs/compress.c |   6 +-
 fs/ntfs/dir.c      |   8 +-
 fs/ntfs/ea.c       |   2 +-
 fs/ntfs/file.c     |  13 +-
 fs/ntfs/index.c    |   5 +-
 fs/ntfs/inode.c    |  88 ++++++++++---
 fs/ntfs/inode.h    |   7 +
 fs/ntfs/iomap.c    |  23 +++-
 fs/ntfs/logfile.c  |   4 +
 fs/ntfs/mft.c      |  63 ++++++---
 fs/ntfs/namei.c    |   6 +-
 fs/ntfs/super.c    |   6 +-
 16 files changed, 481 insertions(+), 125 deletions(-)

diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index 1fbf832ad1654..981777ff24279 100644
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -131,6 +131,7 @@ static sector_t ntfs_bmap(struct address_space *mapping, sector_t block)
 	s64 lcn;
 	unsigned long blocksize, flags;
 	struct ntfs_inode *ni = NTFS_I(mapping->host);
+	struct ntfs_inode *attr_lock_ni;
 	struct ntfs_volume *vol = ni->vol;
 	unsigned int delta;
 	unsigned char blocksize_bits;
@@ -160,10 +161,12 @@ static sector_t ntfs_bmap(struct address_space *mapping, sector_t block)
 	 */
 	if (unlikely(ofs >= size || (ofs + blocksize > size && size < i_size)))
 		goto hole;
+	attr_lock_ni = ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LOCK_READ);
 	down_read(&ni->runlist.lock);
 	lcn = ntfs_attr_vcn_to_lcn_nolock(ni, ntfs_bytes_to_cluster(vol, ofs),
 			false);
 	up_read(&ni->runlist.lock);
+	ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_READ);
 	if (unlikely(lcn < LCN_HOLE)) {
 		/*
 		 * Step down to an integer to avoid gcc doing a long long
diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index dd88280985118..9096a54865355 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -108,7 +108,7 @@ int ntfs_map_runlist_nolock(struct ntfs_inode *ni, s64 vcn, struct ntfs_attr_sea
 		m = map_mft_record(base_ni);
 		if (IS_ERR(m))
 			return PTR_ERR(m);
-		ctx = ntfs_attr_get_search_ctx(base_ni, m);
+		ctx = ntfs_attr_get_search_ctx(base_ni, m, NTFS_ATTR_CTX_LOCK_NONE);
 		if (unlikely(!ctx)) {
 			err = -ENOMEM;
 			goto err_out;
@@ -300,14 +300,17 @@ int ntfs_map_runlist_nolock(struct ntfs_inode *ni, s64 vcn, struct ntfs_attr_sea
  */
 int ntfs_map_runlist(struct ntfs_inode *ni, s64 vcn)
 {
+	struct ntfs_inode *attr_lock_ni;
 	int err = 0;
 
+	attr_lock_ni = ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LOCK_READ);
 	down_write(&ni->runlist.lock);
 	/* Make sure someone else didn't do the work while we were sleeping. */
 	if (likely(ntfs_rl_vcn_to_lcn(ni->runlist.rl, vcn) <=
 			LCN_RL_NOT_MAPPED))
 		err = ntfs_map_runlist_nolock(ni, vcn, NULL);
 	up_write(&ni->runlist.lock);
+	ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_READ);
 	return err;
 }
 
@@ -318,7 +321,7 @@ struct runlist_element *ntfs_attr_vcn_to_rl(struct ntfs_inode *ni, s64 vcn, s64
 	bool is_retry = false;
 
 	if (!rl) {
-		err = ntfs_attr_map_whole_runlist(ni);
+		err = ntfs_attr_map_whole_runlist_nolock(ni);
 		if (err)
 			return ERR_PTR(-ENOENT);
 		rl = ni->runlist.rl;
@@ -1579,6 +1582,93 @@ int ntfs_attr_lookup(const __le32 type, const __le16 *name,
 			val, val_len, ctx);
 }
 
+static struct ntfs_inode *ntfs_attr_search_lock_inode(struct ntfs_inode *ni)
+{
+	if (!ni)
+		return NULL;
+	if (NInoAttr(ni)) {
+		if (ni->type == AT_ATTRIBUTE_LIST)
+			return NULL;
+		return ni->ext.base_ntfs_ino;
+	}
+	return ni;
+}
+
+static void ntfs_attr_list_assert_held(struct ntfs_inode *ni)
+{
+	struct ntfs_inode *lock_ni = ntfs_attr_search_lock_inode(ni);
+
+	if (lock_ni)
+		rwsem_assert_held(&lock_ni->attr_list_lock);
+}
+
+struct ntfs_inode *ntfs_attr_list_lock(struct ntfs_inode *ni,
+				       enum ntfs_attr_search_ctx_lock_mode lock_mode)
+{
+	struct ntfs_inode *lock_ni;
+
+	if (lock_mode == NTFS_ATTR_CTX_LOCK_NONE) {
+		ntfs_attr_list_assert_held(ni);
+		return NULL;
+	}
+
+	lock_ni = ntfs_attr_search_lock_inode(ni);
+	if (!lock_ni)
+		return NULL;
+
+	if (lock_mode == NTFS_ATTR_CTX_LOCK_WRITE)
+		down_write(&lock_ni->attr_list_lock);
+	else
+		down_read(&lock_ni->attr_list_lock);
+
+	return lock_ni;
+}
+
+void ntfs_attr_list_unlock(struct ntfs_inode *lock_ni,
+			   enum ntfs_attr_search_ctx_lock_mode lock_mode)
+{
+	if (!lock_ni || lock_mode == NTFS_ATTR_CTX_LOCK_NONE)
+		return;
+
+	if (lock_mode == NTFS_ATTR_CTX_LOCK_WRITE)
+		up_write(&lock_ni->attr_list_lock);
+	else
+		up_read(&lock_ni->attr_list_lock);
+}
+
+void ntfs_attr_lock_search_ctx(struct ntfs_attr_search_ctx *ctx,
+			       struct ntfs_inode *ni,
+			       enum ntfs_attr_search_ctx_lock_mode lock_mode)
+{
+	struct ntfs_inode *lock_ni;
+
+	ctx->attr_list_lock_ni = NULL;
+	ctx->attr_list_lock_mode = NTFS_ATTR_CTX_LOCK_NONE;
+
+	if (lock_mode == NTFS_ATTR_CTX_LOCK_NONE) {
+		ntfs_attr_list_assert_held(ni);
+		return;
+	}
+
+	lock_ni = ntfs_attr_list_lock(ni, lock_mode);
+	if (!lock_ni)
+		return;
+
+	ctx->attr_list_lock_ni = lock_ni;
+	ctx->attr_list_lock_mode = lock_mode;
+}
+
+void ntfs_attr_unlock_search_ctx(struct ntfs_attr_search_ctx *ctx)
+{
+	if (!ctx->attr_list_lock_ni)
+		return;
+
+	ntfs_attr_list_unlock(ctx->attr_list_lock_ni, ctx->attr_list_lock_mode);
+
+	ctx->attr_list_lock_ni = NULL;
+	ctx->attr_list_lock_mode = NTFS_ATTR_CTX_LOCK_NONE;
+}
+
 /**
  * ntfs_attr_init_search_ctx - initialize an attribute search context
  * @ctx:        attribute search context to initialize
@@ -1609,6 +1699,8 @@ static bool ntfs_attr_init_search_ctx(struct ntfs_attr_search_ctx *ctx,
 	ctx->base_mrec = NULL;
 	ctx->base_attr = NULL;
 	ctx->mapped_base_mrec = false;
+	ctx->attr_list_lock_ni = NULL;
+	ctx->attr_list_lock_mode = NTFS_ATTR_CTX_LOCK_NONE;
 	return true;
 }
 
@@ -1624,6 +1716,9 @@ static bool ntfs_attr_init_search_ctx(struct ntfs_attr_search_ctx *ctx,
  */
 void ntfs_attr_reinit_search_ctx(struct ntfs_attr_search_ctx *ctx)
 {
+	struct ntfs_inode *attr_list_lock_ni = ctx->attr_list_lock_ni;
+	enum ntfs_attr_search_ctx_lock_mode attr_list_lock_mode =
+		ctx->attr_list_lock_mode;
 	bool mapped_mrec;
 
 	if (likely(!ctx->base_ntfs_ino)) {
@@ -1645,6 +1740,8 @@ void ntfs_attr_reinit_search_ctx(struct ntfs_attr_search_ctx *ctx)
 	mapped_mrec = ctx->mapped_base_mrec;
 	ntfs_attr_init_search_ctx(ctx, ctx->base_ntfs_ino, ctx->base_mrec);
 	ctx->mapped_mrec = mapped_mrec;
+	ctx->attr_list_lock_ni = attr_list_lock_ni;
+	ctx->attr_list_lock_mode = attr_list_lock_mode;
 }
 
 /*
@@ -1656,7 +1753,8 @@ void ntfs_attr_reinit_search_ctx(struct ntfs_attr_search_ctx *ctx)
  * and return it. Return NULL if allocation failed.
  */
 struct ntfs_attr_search_ctx *ntfs_attr_get_search_ctx(struct ntfs_inode *ni,
-		struct mft_record *mrec)
+		struct mft_record *mrec,
+		enum ntfs_attr_search_ctx_lock_mode lock_mode)
 {
 	struct ntfs_attr_search_ctx *ctx;
 	bool init;
@@ -1667,6 +1765,8 @@ struct ntfs_attr_search_ctx *ntfs_attr_get_search_ctx(struct ntfs_inode *ni,
 		if (init == false) {
 			kmem_cache_free(ntfs_attr_ctx_cache, ctx);
 			ctx = NULL;
+		} else {
+			ntfs_attr_lock_search_ctx(ctx, ni, lock_mode);
 		}
 	}
 
@@ -1682,6 +1782,8 @@ struct ntfs_attr_search_ctx *ntfs_attr_get_search_ctx(struct ntfs_inode *ni,
  */
 void ntfs_attr_put_search_ctx(struct ntfs_attr_search_ctx *ctx)
 {
+	ntfs_attr_unlock_search_ctx(ctx);
+
 	if (ctx->mapped_mrec)
 		unmap_mft_record(ctx->ntfs_ino);
 
@@ -1905,7 +2007,8 @@ int ntfs_resident_attr_value_resize(struct mft_record *m, struct attr_record *a,
  * inode i_size is that this is not necessarily uptodate.  This happens when
  * ntfs_attr_make_non_resident() is called in the ->truncate call path(s).
  */
-int ntfs_attr_make_non_resident(struct ntfs_inode *ni, const u32 data_size)
+static int __ntfs_attr_make_non_resident(struct ntfs_inode *ni, u32 data_size,
+					 enum ntfs_attr_search_ctx_lock_mode lock_mode)
 {
 	s64 new_size;
 	struct inode *vi = VFS_I(ni);
@@ -1951,7 +2054,7 @@ int ntfs_attr_make_non_resident(struct ntfs_inode *ni, const u32 data_size)
 		ctx = NULL;
 		goto err_out;
 	}
-	ctx = ntfs_attr_get_search_ctx(base_ni, m);
+	ctx = ntfs_attr_get_search_ctx(base_ni, m, lock_mode);
 	if (unlikely(!ctx)) {
 		err = -ENOMEM;
 		goto err_out;
@@ -2225,6 +2328,12 @@ int ntfs_attr_make_non_resident(struct ntfs_inode *ni, const u32 data_size)
 	return err;
 }
 
+int ntfs_attr_make_non_resident(struct ntfs_inode *ni, const u32 data_size)
+{
+	return __ntfs_attr_make_non_resident(ni, data_size,
+			NTFS_ATTR_CTX_LOCK_READ);
+}
+
 /*
  * ntfs_attr_set - fill (a part of) an attribute with a byte
  * @ni:		ntfs inode describing the attribute to fill
@@ -2290,7 +2399,7 @@ int ntfs_attr_set_initialized_size(struct ntfs_inode *ni, loff_t new_size)
 	if (!NInoNonResident(ni))
 		return -EINVAL;
 
-	ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	ctx = ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_READ);
 	if (!ctx)
 		return -ENOMEM;
 
@@ -2390,7 +2499,7 @@ int ntfs_resident_attr_record_add(struct ntfs_inode *ni, __le32 type,
 	}
 
 	/* Locate place where record should be. */
-	ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	ctx = ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_NONE);
 	if (!ctx) {
 		ntfs_error(ni->vol->sb, "%s: Failed to get search context",
 				__func__);
@@ -2512,7 +2621,7 @@ static int ntfs_non_resident_attr_record_add(struct ntfs_inode *ni, __le32 type,
 	}
 
 	/* Locate place where record should be. */
-	ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	ctx = ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_NONE);
 	if (!ctx) {
 		pr_err("%s: Failed to get search context\n", __func__);
 		return -ENOMEM;
@@ -2622,6 +2731,7 @@ static int ntfs_non_resident_attr_record_add(struct ntfs_inode *ni, __le32 type,
 int ntfs_attr_record_rm(struct ntfs_attr_search_ctx *ctx)
 {
 	struct ntfs_inode *base_ni, *ni;
+	u8 *old_al = NULL;
 	__le32 type;
 	int err;
 
@@ -2660,9 +2770,11 @@ int ntfs_attr_record_rm(struct ntfs_attr_search_ctx *ctx)
 	/* Post $ATTRIBUTE_LIST delete setup. */
 	if (type == AT_ATTRIBUTE_LIST) {
 		if (NInoAttrList(base_ni) && base_ni->attr_list)
-			kvfree(base_ni->attr_list);
+			old_al = base_ni->attr_list;
 		base_ni->attr_list = NULL;
+		base_ni->attr_list_size = 0;
 		NInoClearAttrList(base_ni);
+		kvfree(old_al);
 	}
 
 	/* Free MFT record, if it doesn't contain attributes. */
@@ -3087,7 +3199,7 @@ int ntfs_attr_open(struct ntfs_inode *ni, const __le32 type,
 		newname = name;
 	}
 
-	ctx = ntfs_attr_get_search_ctx(base_ni, NULL);
+	ctx = ntfs_attr_get_search_ctx(base_ni, NULL, NTFS_ATTR_CTX_LOCK_READ);
 	if (!ctx) {
 		err = -ENOMEM;
 		pr_err("%s: Failed to get search context\n", __func__);
@@ -3239,7 +3351,7 @@ void ntfs_attr_close(struct ntfs_inode *ni)
  * will map the runlist fragments from each of the extents thus giving access
  * to the entirety of the disk allocation of an attribute.
  */
-int ntfs_attr_map_whole_runlist(struct ntfs_inode *ni)
+int ntfs_attr_map_whole_runlist_nolock(struct ntfs_inode *ni)
 {
 	s64 next_vcn, last_vcn, highest_vcn;
 	struct ntfs_attr_search_ctx *ctx;
@@ -3262,7 +3374,7 @@ int ntfs_attr_map_whole_runlist(struct ntfs_inode *ni)
 	else
 		base_ni = ni;
 
-	ctx = ntfs_attr_get_search_ctx(base_ni, NULL);
+	ctx = ntfs_attr_get_search_ctx(base_ni, NULL, NTFS_ATTR_CTX_LOCK_NONE);
 	if (!ctx) {
 		ntfs_error(sb, "%s: Failed to get search context", __func__);
 		return -ENOMEM;
@@ -3354,6 +3466,18 @@ int ntfs_attr_map_whole_runlist(struct ntfs_inode *ni)
 	return err;
 }
 
+int ntfs_attr_map_whole_runlist(struct ntfs_inode *ni)
+{
+	struct ntfs_inode *attr_lock_ni;
+	int err;
+
+	attr_lock_ni = ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LOCK_READ);
+	err = ntfs_attr_map_whole_runlist_nolock(ni);
+	ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_READ);
+
+	return err;
+}
+
 /*
  * ntfs_attr_record_move_to - move attribute record to target inode
  * @ctx:	attribute search context describing the attribute record
@@ -3388,7 +3512,7 @@ int ntfs_attr_record_move_to(struct ntfs_attr_search_ctx *ctx, struct ntfs_inode
 
 	/* Find place in MFT record where attribute will be moved. */
 	a = ctx->attr;
-	nctx = ntfs_attr_get_search_ctx(ni, NULL);
+	nctx = ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_NONE);
 	if (!nctx) {
 		ntfs_error(sb, "%s: Failed to get search context", __func__);
 		return -ENOMEM;
@@ -3475,7 +3599,7 @@ int ntfs_attr_record_move_away(struct ntfs_attr_search_ctx *ctx, int extra)
 		return -EINVAL;
 	}
 
-	err = ntfs_inode_attach_all_extents(ctx->ntfs_ino);
+	err = ntfs_inode_attach_all_extents_nolock(ctx->ntfs_ino);
 	if (err) {
 		ntfs_error(sb, "Couldn't attach extents, inode=%llu",
 			(unsigned long long)base_ni->mft_no);
@@ -3574,9 +3698,8 @@ static int ntfs_attr_update_meta(struct attr_record *a, struct ntfs_inode *ni,
 		if ((le32_to_cpu(a->length) -
 		     le16_to_cpu(a->data.non_resident.mapping_pairs_offset) == 8) &&
 		    !(le32_to_cpu(m->bytes_allocated) - le32_to_cpu(m->bytes_in_use))) {
-
 			if (!NInoAttrList(base_ni)) {
-				err = ntfs_inode_add_attrlist(base_ni);
+				err = ntfs_inode_add_attrlist_nolock(base_ni);
 				if (err)
 					goto out;
 				err = -EAGAIN;
@@ -3677,7 +3800,7 @@ static int ntfs_attr_update_meta(struct attr_record *a, struct ntfs_inode *ni,
  * call to this function. Vice-versa @na->compressed_size will be calculated and
  * set to correct value during this function.
  */
-int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
+static int __ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
 {
 	struct ntfs_attr_search_ctx *ctx;
 	struct ntfs_inode *base_ni;
@@ -3709,7 +3832,7 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
 	else
 		base_ni = ni;
 
-	ctx = ntfs_attr_get_search_ctx(base_ni, NULL);
+	ctx = ntfs_attr_get_search_ctx(base_ni, NULL, NTFS_ATTR_CTX_LOCK_NONE);
 	if (!ctx) {
 		ntfs_error(sb, "%s: Failed to get search context", __func__);
 		return -ENOMEM;
@@ -3809,8 +3932,8 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
 			 */
 			if (ni->type == AT_ATTRIBUTE_LIST) {
 				ntfs_attr_put_search_ctx(ctx);
-				if (ntfs_inode_free_space(base_ni, mp_size -
-							cur_max_mp_size)) {
+				if (ntfs_inode_free_space_nolock(base_ni, mp_size -
+								cur_max_mp_size)) {
 					ntfs_debug("Attribute list is too big. Defragment the volume\n");
 					return -ENOSPC;
 				}
@@ -3822,7 +3945,7 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
 			/* Add attribute list if it isn't present, and retry. */
 			if (!NInoAttrList(base_ni)) {
 				ntfs_attr_put_search_ctx(ctx);
-				if (ntfs_inode_add_attrlist(base_ni)) {
+				if (ntfs_inode_add_attrlist_nolock(base_ni)) {
 					ntfs_error(sb, "Can not add attrlist");
 					return -EIO;
 				}
@@ -4026,6 +4149,23 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
 	return err;
 }
 
+int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
+{
+	struct ntfs_inode *attr_lock_ni;
+	int err;
+
+	attr_lock_ni = ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LOCK_WRITE);
+	err = __ntfs_attr_update_mapping_pairs(ni, from_vcn);
+	ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
+
+	return err;
+}
+
+int ntfs_attr_update_mapping_pairs_nolock(struct ntfs_inode *ni, s64 from_vcn)
+{
+	return __ntfs_attr_update_mapping_pairs(ni, from_vcn);
+}
+
 /*
  * ntfs_attr_make_resident - convert a non-resident to a resident attribute
  * @ni:		open ntfs attribute to make resident
@@ -4083,7 +4223,7 @@ static int ntfs_attr_make_resident(struct ntfs_inode *ni, struct ntfs_attr_searc
 	}
 
 	/* Read and cache the whole runlist if not already done. */
-	err = ntfs_attr_map_whole_runlist(ni);
+	err = ntfs_attr_map_whole_runlist_nolock(ni);
 	if (err)
 		return err;
 
@@ -4220,7 +4360,7 @@ static int ntfs_non_resident_attr_shrink(struct ntfs_inode *ni, const s64 newsiz
 			return err;
 		}
 
-		ctx = ntfs_attr_get_search_ctx(ni, NULL);
+		ctx = ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_READ);
 		if (!ctx) {
 			ntfs_error(vol->sb, "%s: Failed to get search context", __func__);
 			return -ENOMEM;
@@ -4268,7 +4408,7 @@ static int ntfs_non_resident_attr_shrink(struct ntfs_inode *ni, const s64 newsiz
 	}
 
 	/* Get the first attribute record. */
-	ctx = ntfs_attr_get_search_ctx(base_ni, NULL);
+	ctx = ntfs_attr_get_search_ctx(base_ni, NULL, NTFS_ATTR_CTX_LOCK_READ);
 	if (!ctx) {
 		ntfs_error(vol->sb, "%s: Failed to get search context", __func__);
 		return -ENOMEM;
@@ -4380,7 +4520,8 @@ static int ntfs_non_resident_attr_expand(struct ntfs_inode *ni, const s64 newsiz
 	 * clusters if there is a change.
 	 */
 	if (ntfs_bytes_to_cluster(vol, ni->allocated_size) < first_free_vcn) {
-		err = ntfs_attr_map_whole_runlist(ni);
+		err = need_lock ? ntfs_attr_map_whole_runlist(ni) :
+				ntfs_attr_map_whole_runlist_nolock(ni);
 		if (err) {
 			ntfs_error(sb, "ntfs_attr_map_whole_runlist failed");
 			return err;
@@ -4499,14 +4640,15 @@ static int ntfs_non_resident_attr_expand(struct ntfs_inode *ni, const s64 newsiz
 
 		/* Prepare to mapping pairs update. */
 		ni->allocated_size = ntfs_cluster_to_bytes(vol, first_free_vcn);
-		err = ntfs_attr_update_mapping_pairs(ni, 0);
+		err = need_lock ? ntfs_attr_update_mapping_pairs(ni, 0) :
+				ntfs_attr_update_mapping_pairs_nolock(ni, 0);
 		if (err) {
 			ntfs_debug("Mapping pairs update failed");
 			goto rollback;
 		}
 	}
 
-	ctx = ntfs_attr_get_search_ctx(base_ni, NULL);
+	ctx = ntfs_attr_get_search_ctx(base_ni, NULL, NTFS_ATTR_CTX_LOCK_READ);
 	if (!ctx) {
 		err = -ENOMEM;
 		if (ni->allocated_size == org_alloc_size)
@@ -4557,16 +4699,22 @@ static int ntfs_non_resident_attr_expand(struct ntfs_inode *ni, const s64 newsiz
 		kvfree(ni->runlist.rl);
 		ni->runlist.rl = NULL;
 		ntfs_error(sb, "Couldn't truncate runlist. Rollback failed");
-	} else {
-		/* Prepare to mapping pairs update. */
-		ni->allocated_size = org_alloc_size;
-		/* Restore mapping pairs. */
-		if (need_lock)
-			down_read(&ni->runlist.lock);
-		if (ntfs_attr_update_mapping_pairs(ni, 0))
-			ntfs_error(sb, "Failed to restore old mapping pairs");
-		if (need_lock)
-			up_read(&ni->runlist.lock);
+		} else {
+			/* Prepare to mapping pairs update. */
+			ni->allocated_size = org_alloc_size;
+			/* Restore mapping pairs. */
+			if (need_lock) {
+				struct ntfs_inode *attr_lock_ni;
+
+				attr_lock_ni = ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LOCK_WRITE);
+				down_read(&ni->runlist.lock);
+				if (ntfs_attr_update_mapping_pairs_nolock(ni, 0))
+					ntfs_error(sb, "Failed to restore old mapping pairs");
+				up_read(&ni->runlist.lock);
+				ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
+			} else if (ntfs_attr_update_mapping_pairs_nolock(ni, 0)) {
+				ntfs_error(sb, "Failed to restore old mapping pairs");
+			}
 
 		if (NInoSparse(ni) || NInoCompressed(ni)) {
 			ni->itype.compressed.size =  org_compressed_size;
@@ -4600,6 +4748,7 @@ static int ntfs_resident_attr_resize(struct ntfs_inode *attr_ni, const s64 newsi
 	struct super_block *sb = vol->sb;
 	int err = -EIO;
 	struct ntfs_inode *base_ni, *ext_ni = NULL;
+	u32 resident_value_len;
 
 attr_resize_again:
 	ntfs_debug("Inode 0x%llx attr 0x%x new size %lld\n",
@@ -4612,7 +4761,7 @@ static int ntfs_resident_attr_resize(struct ntfs_inode *attr_ni, const s64 newsi
 		base_ni = attr_ni;
 
 	/* Get the attribute record that needs modification. */
-	ctx = ntfs_attr_get_search_ctx(base_ni, NULL);
+	ctx = ntfs_attr_get_search_ctx(base_ni, NULL, NTFS_ATTR_CTX_LOCK_READ);
 	if (!ctx) {
 		ntfs_error(sb, "%s: Failed to get search context", __func__);
 		return -ENOMEM;
@@ -4664,8 +4813,9 @@ static int ntfs_resident_attr_resize(struct ntfs_inode *attr_ni, const s64 newsi
 	/* There is not enough space in the mft record to perform the resize. */
 
 	/* Make the attribute non-resident if possible. */
-	err = ntfs_attr_make_non_resident(attr_ni,
-			le32_to_cpu(ctx->attr->data.resident.value_length));
+	resident_value_len = le32_to_cpu(ctx->attr->data.resident.value_length);
+	err = __ntfs_attr_make_non_resident(attr_ni, resident_value_len,
+					    NTFS_ATTR_CTX_LOCK_NONE);
 	if (!err) {
 		mark_mft_record_dirty(ctx->ntfs_ino);
 		ntfs_attr_put_search_ctx(ctx);
@@ -4712,7 +4862,8 @@ static int ntfs_resident_attr_resize(struct ntfs_inode *attr_ni, const s64 newsi
 			continue;
 		}
 
-		if (ntfs_attr_make_non_resident(NTFS_I(tvi), value_len)) {
+		if (__ntfs_attr_make_non_resident(NTFS_I(tvi), value_len,
+						  NTFS_ATTR_CTX_LOCK_NONE)) {
 			iput(tvi);
 			continue;
 		}
@@ -4844,12 +4995,16 @@ int __ntfs_attr_truncate_vfs(struct ntfs_inode *ni, const s64 newsize,
 
 	if (NInoNonResident(ni)) {
 		if (newsize > i_size) {
+			struct ntfs_inode *attr_lock_ni;
+
+			attr_lock_ni = ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LOCK_WRITE);
 			down_write(&ni->runlist.lock);
 			err = ntfs_non_resident_attr_expand(ni, newsize, 0,
 							    NVolDisableSparse(ni->vol) ?
 							    HOLES_NO : HOLES_OK,
 							    false);
 			up_write(&ni->runlist.lock);
+			ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
 		} else
 			err = ntfs_non_resident_attr_shrink(ni, newsize);
 	} else
@@ -4979,14 +5134,17 @@ int ntfs_attr_map_cluster(struct ntfs_inode *ni, s64 vcn_start, s64 *lcn_start,
 	int err = 0;
 	size_t new_rl_count;
 
-	err = ntfs_attr_map_whole_runlist(ni);
+	err = ntfs_attr_map_whole_runlist_nolock(ni);
 	if (err)
 		return err;
 
-	if (NInoAttr(ni))
-		ctx = ntfs_attr_get_search_ctx(ni->ext.base_ntfs_ino, NULL);
-	else
-		ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	if (NInoAttr(ni)) {
+		struct ntfs_inode *base_ni = ni->ext.base_ntfs_ino;
+
+		ctx = ntfs_attr_get_search_ctx(base_ni, NULL, NTFS_ATTR_CTX_LOCK_NONE);
+	} else {
+		ctx = ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_NONE);
+	}
 	if (!ctx) {
 		ntfs_error(vol->sb, "%s: Failed to get search context", __func__);
 		return -ENOMEM;
@@ -5093,7 +5251,7 @@ int ntfs_attr_map_cluster(struct ntfs_inode *ni, s64 vcn_start, s64 *lcn_start,
 
 	if (update_mp) {
 		ntfs_attr_reinit_search_ctx(ctx);
-		err = ntfs_attr_update_mapping_pairs(ni, 0);
+		err = ntfs_attr_update_mapping_pairs_nolock(ni, 0);
 		if (err) {
 			int err2;
 
@@ -5146,7 +5304,7 @@ int ntfs_attr_rm(struct ntfs_inode *ni)
 		err = ntfs_attr_map_whole_runlist(ni);
 		if (err)
 			return err;
-		ctx = ntfs_attr_get_search_ctx(ni, NULL);
+		ctx = ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_READ);
 		if (!ctx) {
 			ntfs_error(sb, "%s: Failed to get search context", __func__);
 			return -ENOMEM;
@@ -5160,7 +5318,7 @@ int ntfs_attr_rm(struct ntfs_inode *ni)
 	}
 
 	/* Search for attribute extents and remove them all. */
-	ctx = ntfs_attr_get_search_ctx(base_ni, NULL);
+	ctx = ntfs_attr_get_search_ctx(base_ni, NULL, NTFS_ATTR_CTX_LOCK_WRITE);
 	if (!ctx) {
 		ntfs_error(sb, "%s: Failed to get search context", __func__);
 		return -ENOMEM;
@@ -5192,7 +5350,7 @@ int ntfs_attr_exist(struct ntfs_inode *ni, const __le32 type, __le16 *name,
 
 	ntfs_debug("Entering\n");
 
-	ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	ctx = ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_READ);
 	if (!ctx) {
 		ntfs_error(ni->vol->sb, "%s: Failed to get search context",
 				__func__);
@@ -5301,6 +5459,7 @@ void *ntfs_attr_readall(struct ntfs_inode *ni, const __le32 type,
 int ntfs_non_resident_attr_insert_range(struct ntfs_inode *ni, s64 start_vcn, s64 len)
 {
 	struct ntfs_volume *vol = ni->vol;
+	struct ntfs_inode *attr_lock_ni;
 	struct runlist_element *hole_rl, *rl;
 	struct ntfs_attr_search_ctx *ctx;
 	int ret;
@@ -5321,16 +5480,19 @@ int ntfs_non_resident_attr_insert_range(struct ntfs_inode *ni, s64 start_vcn, s6
 	hole_rl[1].lcn = LCN_ENOENT;
 	hole_rl[1].length = 0;
 
+	attr_lock_ni = ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LOCK_WRITE);
 	down_write(&ni->runlist.lock);
-	ret = ntfs_attr_map_whole_runlist(ni);
+	ret = ntfs_attr_map_whole_runlist_nolock(ni);
 	if (ret) {
 		up_write(&ni->runlist.lock);
+		ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
 		return ret;
 	}
 
 	rl = ntfs_rl_find_vcn_nolock(ni->runlist.rl, start_vcn);
 	if (!rl) {
 		up_write(&ni->runlist.lock);
+		ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
 		kfree(hole_rl);
 		return -EIO;
 	}
@@ -5339,6 +5501,7 @@ int ntfs_non_resident_attr_insert_range(struct ntfs_inode *ni, s64 start_vcn, s6
 				  hole_rl, 1, &new_rl_count);
 	if (IS_ERR(rl)) {
 		up_write(&ni->runlist.lock);
+		ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
 		kfree(hole_rl);
 		return PTR_ERR(rl);
 	}
@@ -5349,12 +5512,13 @@ int ntfs_non_resident_attr_insert_range(struct ntfs_inode *ni, s64 start_vcn, s6
 	ni->data_size += ntfs_cluster_to_bytes(vol, len);
 	if (ntfs_cluster_to_bytes(vol, start_vcn) < ni->initialized_size)
 		ni->initialized_size += ntfs_cluster_to_bytes(vol, len);
-	ret = ntfs_attr_update_mapping_pairs(ni, 0);
+	ret = ntfs_attr_update_mapping_pairs_nolock(ni, 0);
 	up_write(&ni->runlist.lock);
+	ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
 	if (ret)
 		return ret;
 
-	ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	ctx = ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_READ);
 	if (!ctx) {
 		ret = -ENOMEM;
 		return ret;
@@ -5379,6 +5543,7 @@ int ntfs_non_resident_attr_insert_range(struct ntfs_inode *ni, s64 start_vcn, s6
 int ntfs_non_resident_attr_collapse_range(struct ntfs_inode *ni, s64 start_vcn, s64 len)
 {
 	struct ntfs_volume *vol = ni->vol;
+	struct ntfs_inode *attr_lock_ni;
 	struct runlist_element *punch_rl, *rl;
 	struct ntfs_attr_search_ctx *ctx = NULL;
 	s64 end_vcn;
@@ -5393,10 +5558,12 @@ int ntfs_non_resident_attr_collapse_range(struct ntfs_inode *ni, s64 start_vcn,
 	if (start_vcn >= end_vcn)
 		return -EINVAL;
 
+	attr_lock_ni = ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LOCK_WRITE);
 	down_write(&ni->runlist.lock);
-	ret = ntfs_attr_map_whole_runlist(ni);
+	ret = ntfs_attr_map_whole_runlist_nolock(ni);
 	if (ret) {
 		up_write(&ni->runlist.lock);
+		ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
 		return ret;
 	}
 
@@ -5406,6 +5573,7 @@ int ntfs_non_resident_attr_collapse_range(struct ntfs_inode *ni, s64 start_vcn,
 	rl = ntfs_rl_find_vcn_nolock(ni->runlist.rl, start_vcn);
 	if (!rl) {
 		up_write(&ni->runlist.lock);
+		ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
 		return -EIO;
 	}
 
@@ -5413,6 +5581,7 @@ int ntfs_non_resident_attr_collapse_range(struct ntfs_inode *ni, s64 start_vcn,
 				    start_vcn, len, &punch_rl, &new_rl_cnt);
 	if (IS_ERR(rl)) {
 		up_write(&ni->runlist.lock);
+		ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
 		return PTR_ERR(rl);
 	}
 	ni->runlist.rl = rl;
@@ -5434,15 +5603,17 @@ int ntfs_non_resident_attr_collapse_range(struct ntfs_inode *ni, s64 start_vcn,
 	}
 
 	if (ni->allocated_size > 0) {
-		ret = ntfs_attr_update_mapping_pairs(ni, 0);
+		ret = ntfs_attr_update_mapping_pairs_nolock(ni, 0);
 		if (ret) {
 			up_write(&ni->runlist.lock);
+			ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
 			goto out_rl;
 		}
 	}
 	up_write(&ni->runlist.lock);
+	ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
 
-	ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	ctx = ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_READ);
 	if (!ctx) {
 		ret = -ENOMEM;
 		goto out_rl;
@@ -5474,6 +5645,7 @@ int ntfs_non_resident_attr_collapse_range(struct ntfs_inode *ni, s64 start_vcn,
 int ntfs_non_resident_attr_punch_hole(struct ntfs_inode *ni, s64 start_vcn, s64 len)
 {
 	struct ntfs_volume *vol = ni->vol;
+	struct ntfs_inode *attr_lock_ni;
 	struct runlist_element *punch_rl, *rl;
 	s64 end_vcn;
 	int dst_cnt;
@@ -5487,10 +5659,12 @@ int ntfs_non_resident_attr_punch_hole(struct ntfs_inode *ni, s64 start_vcn, s64
 	if (start_vcn >= end_vcn)
 		return -EINVAL;
 
+	attr_lock_ni = ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LOCK_WRITE);
 	down_write(&ni->runlist.lock);
-	ret = ntfs_attr_map_whole_runlist(ni);
+	ret = ntfs_attr_map_whole_runlist_nolock(ni);
 	if (ret) {
 		up_write(&ni->runlist.lock);
+		ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
 		return ret;
 	}
 
@@ -5500,6 +5674,7 @@ int ntfs_non_resident_attr_punch_hole(struct ntfs_inode *ni, s64 start_vcn, s64
 	rl = ntfs_rl_find_vcn_nolock(ni->runlist.rl, start_vcn);
 	if (!rl) {
 		up_write(&ni->runlist.lock);
+		ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
 		return -EIO;
 	}
 
@@ -5507,13 +5682,15 @@ int ntfs_non_resident_attr_punch_hole(struct ntfs_inode *ni, s64 start_vcn, s64
 				start_vcn, len, &punch_rl, &new_rl_count);
 	if (IS_ERR(rl)) {
 		up_write(&ni->runlist.lock);
+		ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
 		return PTR_ERR(rl);
 	}
 	ni->runlist.rl = rl;
 	ni->runlist.count = new_rl_count;
 
-	ret = ntfs_attr_update_mapping_pairs(ni, 0);
+	ret = ntfs_attr_update_mapping_pairs_nolock(ni, 0);
 	up_write(&ni->runlist.lock);
+	ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
 	if (ret) {
 		kvfree(punch_rl);
 		return ret;
@@ -5544,9 +5721,13 @@ int ntfs_attr_fallocate(struct ntfs_inode *ni, loff_t start, loff_t byte_len, bo
 		return -EINVAL;
 
 	if (NInoNonResident(ni) && !NInoFullyMapped(ni)) {
+		struct ntfs_inode *attr_lock_ni;
+
+		attr_lock_ni = ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LOCK_READ);
 		down_write(&ni->runlist.lock);
-		err = ntfs_attr_map_whole_runlist(ni);
+		err = ntfs_attr_map_whole_runlist_nolock(ni);
 		up_write(&ni->runlist.lock);
+		ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_READ);
 		if (err)
 			return err;
 	}
@@ -5558,7 +5739,7 @@ int ntfs_attr_fallocate(struct ntfs_inode *ni, loff_t start, loff_t byte_len, bo
 		return PTR_ERR(mrec);
 	}
 
-	ctx = ntfs_attr_get_search_ctx(ni, mrec);
+	ctx = ntfs_attr_get_search_ctx(ni, mrec, NTFS_ATTR_CTX_LOCK_READ);
 	if (!ctx) {
 		err = -ENOMEM;
 		goto out_unmap;
@@ -5633,11 +5814,15 @@ int ntfs_attr_fallocate(struct ntfs_inode *ni, loff_t start, loff_t byte_len, bo
 			}
 
 			while (try_alloc_cnt > 0) {
+				struct ntfs_inode *attr_lock_ni;
+
 				mutex_lock_nested(&ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL);
+				attr_lock_ni = ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LOCK_WRITE);
 				down_write(&ni->runlist.lock);
 				err = ntfs_attr_map_cluster(ni, vcn, &lcn, &alloc_cnt,
 							    try_alloc_cnt, &balloc, false, false);
 				up_write(&ni->runlist.lock);
+				ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
 				mutex_unlock(&ni->mrec_lock);
 				if (err)
 					goto out;
@@ -5663,11 +5848,15 @@ int ntfs_attr_fallocate(struct ntfs_inode *ni, loff_t start, loff_t byte_len, bo
 	/* allocate clusters outside of initialized_size */
 	try_alloc_cnt = vcn_end - vcn;
 	while (try_alloc_cnt > 0) {
+		struct ntfs_inode *attr_lock_ni;
+
 		mutex_lock_nested(&ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL);
+		attr_lock_ni = ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LOCK_WRITE);
 		down_write(&ni->runlist.lock);
 		err = ntfs_attr_map_cluster(ni, vcn, &lcn, &alloc_cnt,
 					    try_alloc_cnt, &balloc, false, false);
 		up_write(&ni->runlist.lock);
+		ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
 		mutex_unlock(&ni->mrec_lock);
 		if (err || signal_pending(current))
 			goto out;
@@ -5678,14 +5867,18 @@ int ntfs_attr_fallocate(struct ntfs_inode *ni, loff_t start, loff_t byte_len, bo
 	}
 
 	if (NInoRunlistDirty(ni)) {
+		struct ntfs_inode *attr_lock_ni;
+
 		mutex_lock_nested(&ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL);
+		attr_lock_ni = ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LOCK_WRITE);
 		down_write(&ni->runlist.lock);
-		err = ntfs_attr_update_mapping_pairs(ni, 0);
+		err = ntfs_attr_update_mapping_pairs_nolock(ni, 0);
 		if (err)
 			ntfs_error(ni->vol->sb, "Updating mapping pairs failed");
 		else
 			NInoClearRunlistDirty(ni);
 		up_write(&ni->runlist.lock);
+		ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
 		mutex_unlock(&ni->mrec_lock);
 	}
 	return err;
diff --git a/fs/ntfs/attrib.h b/fs/ntfs/attrib.h
index e2224fbfaabe9..6f167194afb89 100644
--- a/fs/ntfs/attrib.h
+++ b/fs/ntfs/attrib.h
@@ -26,6 +26,8 @@ extern __le16 AT_UNNAMED[];
  * @base_ntfs_ino: Base inode
  * @mapped_base_mrec: true if @base_mrec was mapped by the search
  * @base_attr: Base attribute record pointer
+ * @attr_list_lock_ni: Base inode whose attr_list_lock is held
+ * @attr_list_lock_mode: attr_list_lock mode held by this context
  *
  * Structure must be initialized to zero before the first call to one of the
  * attribute search functions. Initialize @mrec to point to the mft record to
@@ -39,6 +41,12 @@ extern __le16 AT_UNNAMED[];
  * any modification of the search context, to automagically get the next
  * matching attribute.
  */
+enum ntfs_attr_search_ctx_lock_mode {
+	NTFS_ATTR_CTX_LOCK_NONE,
+	NTFS_ATTR_CTX_LOCK_READ,
+	NTFS_ATTR_CTX_LOCK_WRITE,
+};
+
 struct ntfs_attr_search_ctx {
 	struct mft_record *mrec;
 	bool mapped_mrec;
@@ -50,6 +58,8 @@ struct ntfs_attr_search_ctx {
 	struct mft_record *base_mrec;
 	bool mapped_base_mrec;
 	struct attr_record *base_attr;
+	struct ntfs_inode *attr_list_lock_ni;
+	enum ntfs_attr_search_ctx_lock_mode attr_list_lock_mode;
 };
 
 enum {                  /* ways of processing holes when expanding */
@@ -66,6 +76,7 @@ struct runlist_element *ntfs_attr_find_vcn_nolock(struct ntfs_inode *ni,
 		const s64 vcn, struct ntfs_attr_search_ctx *ctx);
 struct runlist_element *__ntfs_attr_find_vcn_nolock(struct runlist *runlist,
 		const s64 vcn);
+int ntfs_attr_map_whole_runlist_nolock(struct ntfs_inode *ni);
 int ntfs_attr_map_whole_runlist(struct ntfs_inode *ni);
 int ntfs_attr_lookup(const __le32 type, const __le16 *name,
 		const u32 name_len, const u32 ic,
@@ -87,7 +98,16 @@ static inline s64 ntfs_attr_size(const struct attr_record *a)
 
 void ntfs_attr_reinit_search_ctx(struct ntfs_attr_search_ctx *ctx);
 struct ntfs_attr_search_ctx *ntfs_attr_get_search_ctx(struct ntfs_inode *ni,
-		struct mft_record *mrec);
+		struct mft_record *mrec,
+		enum ntfs_attr_search_ctx_lock_mode lock_mode);
+struct ntfs_inode *ntfs_attr_list_lock(struct ntfs_inode *ni,
+				       enum ntfs_attr_search_ctx_lock_mode lock_mode);
+void ntfs_attr_list_unlock(struct ntfs_inode *lock_ni,
+			   enum ntfs_attr_search_ctx_lock_mode lock_mode);
+void ntfs_attr_lock_search_ctx(struct ntfs_attr_search_ctx *ctx,
+			       struct ntfs_inode *ni,
+			       enum ntfs_attr_search_ctx_lock_mode lock_mode);
+void ntfs_attr_unlock_search_ctx(struct ntfs_attr_search_ctx *ctx);
 void ntfs_attr_put_search_ctx(struct ntfs_attr_search_ctx *ctx);
 int ntfs_attr_size_bounds_check(const struct ntfs_volume *vol,
 		const __le32 type, const s64 size);
@@ -133,6 +153,7 @@ int ntfs_resident_attr_record_add(struct ntfs_inode *ni, __le32 type,
 		__le16 *name, u8 name_len, u8 *val, u32 size,
 		__le16 flags);
 int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn);
+int ntfs_attr_update_mapping_pairs_nolock(struct ntfs_inode *ni, s64 from_vcn);
 struct runlist_element *ntfs_attr_vcn_to_rl(struct ntfs_inode *ni, s64 vcn, s64 *lcn);
 
 /*
@@ -148,7 +169,9 @@ struct runlist_element *ntfs_attr_vcn_to_rl(struct ntfs_inode *ni, s64 vcn, s64
  *	    @ni, you can simply do:
  *
  *	int err;
- *	struct ntfs_attr_search_ctx *ctx = ntfs_attr_get_search_ctx(ni, NULL);
+ *	struct ntfs_attr_search_ctx *ctx;
+ *
+ *	ctx = ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_READ);
  *	if (!ctx)
  *		// Error code is in errno. Handle this case.
  *	while (!(err = ntfs_attrs_walk(ctx))) {
diff --git a/fs/ntfs/attrlist.c b/fs/ntfs/attrlist.c
index afb13038ba425..fd5eac0612784 100644
--- a/fs/ntfs/attrlist.c
+++ b/fs/ntfs/attrlist.c
@@ -153,7 +153,7 @@ int ntfs_attrlist_entry_add(struct ntfs_inode *ni, struct attr_record *attr)
 		return -ENOMEM;
 
 	/* Find place for the new entry. */
-	ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	ctx = ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_WRITE);
 	if (!ctx) {
 		err = -ENOMEM;
 		ntfs_error(ni->vol->sb, "Failed to get search context");
@@ -176,7 +176,6 @@ int ntfs_attrlist_entry_add(struct ntfs_inode *ni, struct attr_record *attr)
 		if (ctx->al_entry->lowest_vcn == lowest_vcn) {
 			err = -EEXIST;
 			ntfs_debug("Such attribute already present in the attribute list.\n");
-			ntfs_attr_put_search_ctx(ctx);
 			goto err_out;
 		}
 		/* Add new entry after this extent. */
@@ -186,15 +185,11 @@ int ntfs_attrlist_entry_add(struct ntfs_inode *ni, struct attr_record *attr)
 		/* Check for real errors. */
 		if (err != -ENOENT) {
 			ntfs_debug("Attribute lookup failed.\n");
-			ntfs_attr_put_search_ctx(ctx);
 			goto err_out;
 		}
 		/* No previous extents found. */
 		ale = ctx->al_entry;
 	}
-	/* Don't need it anymore, @ctx->al_entry points to @ni->attr_list. */
-	ntfs_attr_put_search_ctx(ctx);
-
 	/* Determine new entry offset. */
 	entry_offset = ((u8 *)ale - ni->attr_list);
 	/* Set pointer to new entry. */
@@ -223,16 +218,22 @@ int ntfs_attrlist_entry_add(struct ntfs_inode *ni, struct attr_record *attr)
 	old_al = ni->attr_list;
 	ni->attr_list = new_al;
 	ni->attr_list_size = ni->attr_list_size + entry_len;
+	ntfs_attr_put_search_ctx(ctx);
+	ctx = NULL;
 
 	err = ntfs_attrlist_update(ni);
 	if (err) {
+		down_write(&ni->attr_list_lock);
 		ni->attr_list = old_al;
 		ni->attr_list_size -= entry_len;
+		up_write(&ni->attr_list_lock);
 		goto err_out;
 	}
 	kvfree(old_al);
 	return 0;
 err_out:
+	if (ctx)
+		ntfs_attr_put_search_ctx(ctx);
 	kvfree(new_al);
 	return err;
 }
@@ -248,9 +249,12 @@ int ntfs_attrlist_entry_add(struct ntfs_inode *ni, struct attr_record *attr)
 int ntfs_attrlist_entry_rm(struct ntfs_attr_search_ctx *ctx)
 {
 	u8 *new_al;
-	int new_al_len;
+	int err, new_al_len;
 	struct ntfs_inode *base_ni;
 	struct attr_list_entry *ale;
+	enum ntfs_attr_search_ctx_lock_mode lock_mode;
+	bool ctx_locked;
+	u8 *old_al;
 
 	if (!ctx || !ctx->ntfs_ino || !ctx->al_entry) {
 		ntfs_debug("Invalid arguments.\n");
@@ -285,9 +289,17 @@ int ntfs_attrlist_entry_rm(struct ntfs_attr_search_ctx *ctx)
 				ale->length), new_al_len - ((u8 *)ale - base_ni->attr_list));
 
 	/* Set new runlist. */
-	kvfree(base_ni->attr_list);
+	old_al = base_ni->attr_list;
 	base_ni->attr_list = new_al;
 	base_ni->attr_list_size = new_al_len;
+	kvfree(old_al);
 
-	return ntfs_attrlist_update(base_ni);
+	ctx_locked = ctx->attr_list_lock_ni;
+	lock_mode = ctx->attr_list_lock_mode;
+	if (ctx_locked)
+		ntfs_attr_unlock_search_ctx(ctx);
+	err = ntfs_attrlist_update(base_ni);
+	if (ctx_locked)
+		ntfs_attr_lock_search_ctx(ctx, base_ni, lock_mode);
+	return err;
 }
diff --git a/fs/ntfs/compress.c b/fs/ntfs/compress.c
index 76bd806b41edd..bac6b32069475 100644
--- a/fs/ntfs/compress.c
+++ b/fs/ntfs/compress.c
@@ -1287,6 +1287,7 @@ static int ntfs_write_cb(struct ntfs_inode *ni, loff_t pos, struct page **pages,
 	/* more compressed zeroes, to be followed by some count */
 	static char morezeroes[] = {0x03, 0xb0, 0x02, 0x00};
 	struct page **pages_disk = NULL, *pg;
+	struct ntfs_inode *attr_lock_ni;
 	s64 bio_lcn;
 	struct runlist_element *rlc, *rl;
 	int i, err;
@@ -1390,10 +1391,12 @@ static int ntfs_write_cb(struct ntfs_inode *ni, loff_t pos, struct page **pages,
 	}
 
 	bio_lcn = rlc->lcn;
+	attr_lock_ni = ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LOCK_WRITE);
 	down_write(&ni->runlist.lock);
 	rl = ntfs_runlists_merge(&ni->runlist, rlc, 0, &new_rl_count);
 	if (IS_ERR(rl)) {
 		up_write(&ni->runlist.lock);
+		ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
 		ntfs_error(vol->sb, "Failed to merge runlists");
 		err = PTR_ERR(rl);
 		if (ntfs_cluster_free_from_rl(vol, rlc))
@@ -1405,8 +1408,9 @@ static int ntfs_write_cb(struct ntfs_inode *ni, loff_t pos, struct page **pages,
 	ni->runlist.count = new_rl_count;
 	ni->runlist.rl = rl;
 
-	err = ntfs_attr_update_mapping_pairs(ni, 0);
+	err = ntfs_attr_update_mapping_pairs_nolock(ni, 0);
 	up_write(&ni->runlist.lock);
+	ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
 	if (err) {
 		err = -EIO;
 		goto out;
diff --git a/fs/ntfs/dir.c b/fs/ntfs/dir.c
index 4b6bd5f30c65e..165503d059c6d 100644
--- a/fs/ntfs/dir.c
+++ b/fs/ntfs/dir.c
@@ -91,7 +91,7 @@ u64 ntfs_lookup_inode_by_name(struct ntfs_inode *dir_ni, const __le16 *uname,
 				-PTR_ERR(m));
 		return ERR_MREF(PTR_ERR(m));
 	}
-	ctx = ntfs_attr_get_search_ctx(dir_ni, m);
+	ctx = ntfs_attr_get_search_ctx(dir_ni, m, NTFS_ATTR_CTX_LOCK_READ);
 	if (unlikely(!ctx)) {
 		err = -ENOMEM;
 		goto err_out;
@@ -814,7 +814,7 @@ static int ntfs_readdir(struct file *file, struct dir_context *actor)
 		file->private_data = private;
 	}
 
-	ctx = ntfs_attr_get_search_ctx(ndir, NULL);
+	ctx = ntfs_attr_get_search_ctx(ndir, NULL, NTFS_ATTR_CTX_LOCK_READ);
 	if (!ctx) {
 		err = -ENOMEM;
 		goto out;
@@ -1015,7 +1015,7 @@ int ntfs_check_empty_dir(struct ntfs_inode *ni, struct mft_record *ni_mrec)
 	if (!(ni_mrec->flags & MFT_RECORD_IS_DIRECTORY))
 		return 0;
 
-	ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	ctx = ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_READ);
 	if (!ctx) {
 		ntfs_error(ni->vol->sb, "Failed to get search context");
 		return -ENOMEM;
@@ -1116,7 +1116,7 @@ static int ntfs_dir_fsync(struct file *filp, loff_t start, loff_t end,
 	if (NVolShutdown(vol))
 		return -EIO;
 
-	ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	ctx = ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_READ);
 	if (!ctx)
 		return -ENOMEM;
 
diff --git a/fs/ntfs/ea.c b/fs/ntfs/ea.c
index 0cd192752b7cd..284c985807a6e 100644
--- a/fs/ntfs/ea.c
+++ b/fs/ntfs/ea.c
@@ -587,7 +587,7 @@ static int ntfs_new_attr_flags(struct ntfs_inode *ni, __le32 fattr)
 	if (IS_ERR(m))
 		return PTR_ERR(m);
 
-	ctx = ntfs_attr_get_search_ctx(ni, m);
+	ctx = ntfs_attr_get_search_ctx(ni, m, NTFS_ATTR_CTX_LOCK_READ);
 	if (!ctx) {
 		err = -ENOMEM;
 		goto err_out;
diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 6a7b638e523d9..dcb5554ff1b71 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -23,6 +23,7 @@
 #include "iomap.h"
 #include "bitmap.h"
 #include "volume.h"
+#include "attrib.h"
 
 #include <linux/filelock.h>
 
@@ -79,6 +80,7 @@ static int ntfs_trim_prealloc(struct inode *vi)
 {
 	struct ntfs_inode *ni = NTFS_I(vi);
 	struct ntfs_volume *vol = ni->vol;
+	struct ntfs_inode *attr_lock_ni;
 	struct runlist_element *rl;
 	s64 aligned_data_size;
 	s64 vcn_ds, vcn_tr;
@@ -87,6 +89,7 @@ static int ntfs_trim_prealloc(struct inode *vi)
 
 	inode_lock(vi);
 	mutex_lock(&ni->mrec_lock);
+	attr_lock_ni = ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LOCK_WRITE);
 	down_write(&ni->runlist.lock);
 
 	aligned_data_size = round_up(ni->data_size, vol->cluster_size);
@@ -111,7 +114,7 @@ static int ntfs_trim_prealloc(struct inode *vi)
 			ntfs_error(vol->sb, "Preallocated block rollback failed");
 		} else {
 			ni->allocated_size = ntfs_cluster_to_bytes(vol, vcn_tr);
-			err = ntfs_attr_update_mapping_pairs(ni, 0);
+			err = ntfs_attr_update_mapping_pairs_nolock(ni, 0);
 			if (err)
 				ntfs_error(vol->sb,
 					   "Failed to rollback mapping pairs for prealloc");
@@ -120,6 +123,7 @@ static int ntfs_trim_prealloc(struct inode *vi)
 
 out_unlock:
 	up_write(&ni->runlist.lock);
+	ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
 	mutex_unlock(&ni->mrec_lock);
 	inode_unlock(vi);
 
@@ -177,7 +181,7 @@ static int ntfs_file_fsync(struct file *filp, loff_t start, loff_t end,
 		ret = __ntfs_write_inode(vi, 1);
 	write_inode_now(vi, !datasync);
 
-	ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	ctx = ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_READ);
 	if (!ctx)
 		return -ENOMEM;
 
@@ -1057,6 +1061,7 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t offset, loff_t le
 	struct inode *vi = file_inode(file);
 	struct ntfs_inode *ni = NTFS_I(vi);
 	struct ntfs_volume *vol = ni->vol;
+	struct ntfs_inode *attr_lock_ni;
 	int err = 0;
 	loff_t old_size;
 	bool map_locked = false;
@@ -1071,9 +1076,11 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t offset, loff_t le
 		return -ENOSPC;
 
 	if (NInoNonResident(ni) && !NInoFullyMapped(ni)) {
+		attr_lock_ni = ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LOCK_READ);
 		down_write(&ni->runlist.lock);
-		err = ntfs_attr_map_whole_runlist(ni);
+		err = ntfs_attr_map_whole_runlist_nolock(ni);
 		up_write(&ni->runlist.lock);
+		ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_READ);
 		if (err)
 			return err;
 	}
diff --git a/fs/ntfs/index.c b/fs/ntfs/index.c
index c5f2cf75b750e..36a70aaa9e2de 100644
--- a/fs/ntfs/index.c
+++ b/fs/ntfs/index.c
@@ -575,7 +575,7 @@ static struct index_root *ntfs_ir_lookup(struct ntfs_inode *ni, __le16 *name,
 	struct index_root *ir = NULL;
 
 	ntfs_debug("Entering\n");
-	*ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	*ctx = ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_WRITE);
 	if (!*ctx) {
 		ntfs_error(ni->vol->sb, "%s, Failed to get search context", __func__);
 		return NULL;
@@ -1332,7 +1332,8 @@ static int ntfs_ir_reparent(struct ntfs_index_context *icx)
 	 * When there is no space to build a non-resident
 	 * index, we may have to move the root to an extent
 	 */
-	if ((ret == -ENOSPC) && (ctx->al_entry || !ntfs_inode_add_attrlist(icx->idx_ni))) {
+	if ((ret == -ENOSPC) &&
+	    (ctx->al_entry || !ntfs_inode_add_attrlist_nolock(icx->idx_ni))) {
 		ntfs_attr_put_search_ctx(ctx);
 		ctx = NULL;
 		ir = ntfs_ir_lookup(icx->idx_ni, icx->name, icx->name_len, &ctx);
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index c2715521e5628..8ed6cb5b9c42f 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -326,7 +326,7 @@ static int ntfs_non_resident_dealloc_clusters(struct ntfs_inode *ni)
 	struct ntfs_attr_search_ctx *actx;
 	int err = 0;
 
-	actx = ntfs_attr_get_search_ctx(ni, NULL);
+	actx = ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_READ);
 	if (!actx)
 		return -ENOMEM;
 	WARN_ON(actx->mrec->link_count != 0);
@@ -475,6 +475,7 @@ void __ntfs_init_inode(struct super_block *sb, struct ntfs_inode *ni)
 	ni->folio = NULL;
 	ni->folio_ofs = 0;
 	ni->mrec = NULL;
+	init_rwsem(&ni->attr_list_lock);
 	ni->attr_list_size = 0;
 	ni->attr_list = NULL;
 	ni->itype.index.block_size = 0;
@@ -713,7 +714,7 @@ static int ntfs_read_locked_inode(struct inode *vi)
 		goto err_out;
 	}
 
-	ctx = ntfs_attr_get_search_ctx(ni, m);
+	ctx = ntfs_attr_get_search_ctx(ni, m, NTFS_ATTR_CTX_LOCK_READ);
 	if (!ctx) {
 		err = -ENOMEM;
 		goto unm_err_out;
@@ -1280,7 +1281,7 @@ static int ntfs_read_locked_attr_inode(struct inode *base_vi, struct inode *vi)
 		err = PTR_ERR(m);
 		goto err_out;
 	}
-	ctx = ntfs_attr_get_search_ctx(base_ni, m);
+	ctx = ntfs_attr_get_search_ctx(base_ni, m, NTFS_ATTR_CTX_LOCK_READ);
 	if (!ctx) {
 		err = -ENOMEM;
 		goto unm_err_out;
@@ -1520,7 +1521,7 @@ static int ntfs_read_locked_index_inode(struct inode *base_vi, struct inode *vi)
 		err = PTR_ERR(m);
 		goto err_out;
 	}
-	ctx = ntfs_attr_get_search_ctx(base_ni, m);
+	ctx = ntfs_attr_get_search_ctx(base_ni, m, NTFS_ATTR_CTX_LOCK_READ);
 	if (!ctx) {
 		err = -ENOMEM;
 		goto unm_err_out;
@@ -1911,7 +1912,7 @@ int ntfs_read_inode_mount(struct inode *vi)
 	/* Provides read_folio() for map_mft_record(). */
 	vi->i_mapping->a_ops = &ntfs_mft_aops;
 
-	ctx = ntfs_attr_get_search_ctx(ni, m);
+	ctx = ntfs_attr_get_search_ctx(ni, m, NTFS_ATTR_CTX_LOCK_READ);
 	if (!ctx) {
 		err = -ENOMEM;
 		goto err_out;
@@ -2466,7 +2467,7 @@ static int ntfs_inode_sync_standard_information(struct inode *vi, struct mft_rec
 	bool modified = false;
 
 	/* Update the access times in the standard information attribute. */
-	ctx = ntfs_attr_get_search_ctx(ni, m);
+	ctx = ntfs_attr_get_search_ctx(ni, m, NTFS_ATTR_CTX_LOCK_READ);
 	if (unlikely(!ctx))
 		return -ENOMEM;
 	err = ntfs_attr_lookup(AT_STANDARD_INFORMATION, NULL, 0,
@@ -2567,7 +2568,7 @@ int ntfs_inode_sync_filename(struct ntfs_inode *ni)
 
 	ntfs_debug("Entering for inode %llu\n", ni->mft_no);
 
-	ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	ctx = ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_READ);
 	if (!ctx)
 		return -ENOMEM;
 
@@ -2759,11 +2760,15 @@ int __ntfs_write_inode(struct inode *vi, int sync)
 	}
 
 	if (NInoNonResident(ni) && NInoRunlistDirty(ni)) {
+		struct ntfs_inode *attr_lock_ni;
+
+		attr_lock_ni = ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LOCK_WRITE);
 		down_write(&ni->runlist.lock);
-		err = ntfs_attr_update_mapping_pairs(ni, 0);
+		err = ntfs_attr_update_mapping_pairs_nolock(ni, 0);
 		if (!err)
 			NInoClearRunlistDirty(ni);
 		up_write(&ni->runlist.lock);
+		ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
 	}
 
 	err = ntfs_inode_sync_standard_information(vi, m);
@@ -2982,7 +2987,7 @@ static struct ntfs_inode *ntfs_extent_inode_open(struct ntfs_inode *base_ni,
  *
  * Return 0 on success and error.
  */
-int ntfs_inode_attach_all_extents(struct ntfs_inode *ni)
+int ntfs_inode_attach_all_extents_nolock(struct ntfs_inode *ni)
 {
 	struct attr_list_entry *ale;
 	u64 prev_attached = 0;
@@ -3022,13 +3027,25 @@ int ntfs_inode_attach_all_extents(struct ntfs_inode *ni)
 	return 0;
 }
 
+int ntfs_inode_attach_all_extents(struct ntfs_inode *ni)
+{
+	struct ntfs_inode *attr_lock_ni;
+	int err;
+
+	attr_lock_ni = ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LOCK_READ);
+	err = ntfs_inode_attach_all_extents_nolock(ni);
+	ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_READ);
+
+	return err;
+}
+
 /*
  * ntfs_inode_add_attrlist - add attribute list to inode and fill it
  * @ni: opened ntfs inode to which add attribute list
  *
  * Return 0 on success or error.
  */
-int ntfs_inode_add_attrlist(struct ntfs_inode *ni)
+int ntfs_inode_add_attrlist_nolock(struct ntfs_inode *ni)
 {
 	int err;
 	struct ntfs_attr_search_ctx *ctx;
@@ -3053,7 +3070,7 @@ int ntfs_inode_add_attrlist(struct ntfs_inode *ni)
 		return -EIO;
 
 	/* Form attribute list. */
-	ctx = ntfs_attr_get_search_ctx(ni, ni_mrec);
+	ctx = ntfs_attr_get_search_ctx(ni, ni_mrec, NTFS_ATTR_CTX_LOCK_NONE);
 	if (!ctx) {
 		err = -ENOMEM;
 		goto err_out;
@@ -3111,7 +3128,6 @@ int ntfs_inode_add_attrlist(struct ntfs_inode *ni)
 		goto put_err_out;
 	}
 
-	/* Set in-memory attribute list. */
 	ni->attr_list = al;
 	ni->attr_list_size = al_len;
 	NInoSetAttrList(ni);
@@ -3121,7 +3137,7 @@ int ntfs_inode_add_attrlist(struct ntfs_inode *ni)
 	/* Free space if there is not enough it for $ATTRIBUTE_LIST. */
 	if (le32_to_cpu(ni_mrec->bytes_allocated) -
 			le32_to_cpu(ni_mrec->bytes_in_use) < attr_al_len) {
-		if (ntfs_inode_free_space(ni, (int)attr_al_len)) {
+		if (ntfs_inode_free_space_nolock(ni, (int)attr_al_len)) {
 			/* Failed to free space. */
 			err = -ENOSPC;
 			ntfs_error(ni->vol->sb, "Failed to free space for attrlist");
@@ -3148,6 +3164,7 @@ int ntfs_inode_add_attrlist(struct ntfs_inode *ni)
 remove_attrlist_record:
 	/* Prevent ntfs_attr_recorm_rm from freeing attribute list. */
 	ni->attr_list = NULL;
+	ni->attr_list_size = 0;
 	NInoClearAttrList(ni);
 	/* Remove $ATTRIBUTE_LIST record. */
 	ntfs_attr_reinit_search_ctx(ctx);
@@ -3201,6 +3218,18 @@ int ntfs_inode_add_attrlist(struct ntfs_inode *ni)
 	return err;
 }
 
+int ntfs_inode_add_attrlist(struct ntfs_inode *ni)
+{
+	struct ntfs_inode *attr_lock_ni;
+	int err;
+
+	attr_lock_ni = ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LOCK_WRITE);
+	err = ntfs_inode_add_attrlist_nolock(ni);
+	ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
+
+	return err;
+}
+
 /*
  * ntfs_inode_close - close an ntfs inode and free all associated memory
  * @ni:		ntfs inode to close
@@ -3344,7 +3373,8 @@ static int ntfs_attr_position(__le32 type, struct ntfs_attr_search_ctx *ctx)
  *
  * Return 0 on success or error.
  */
-int ntfs_inode_free_space(struct ntfs_inode *ni, int size)
+static int __ntfs_inode_free_space(struct ntfs_inode *ni, int size,
+				   enum ntfs_attr_search_ctx_lock_mode lock_mode)
 {
 	struct ntfs_attr_search_ctx *ctx;
 	int freed, err;
@@ -3368,7 +3398,7 @@ int ntfs_inode_free_space(struct ntfs_inode *ni, int size)
 	if (size <= freed)
 		return 0;
 
-	ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	ctx = ntfs_attr_get_search_ctx(ni, NULL, lock_mode);
 	if (!ctx) {
 		ntfs_error(sb, "%s, Failed to get search context", __func__);
 		return -ENOMEM;
@@ -3454,6 +3484,23 @@ int ntfs_inode_free_space(struct ntfs_inode *ni, int size)
 	return err;
 }
 
+int ntfs_inode_free_space_nolock(struct ntfs_inode *ni, int size)
+{
+	return __ntfs_inode_free_space(ni, size, NTFS_ATTR_CTX_LOCK_NONE);
+}
+
+int ntfs_inode_free_space(struct ntfs_inode *ni, int size)
+{
+	struct ntfs_inode *attr_lock_ni;
+	int err;
+
+	attr_lock_ni = ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LOCK_WRITE);
+	err = __ntfs_inode_free_space(ni, size, NTFS_ATTR_CTX_LOCK_NONE);
+	ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
+
+	return err;
+}
+
 s64 ntfs_inode_attr_pread(struct inode *vi, s64 pos, s64 count, u8 *buf)
 {
 	struct address_space *mapping = vi->i_mapping;
@@ -3478,10 +3525,11 @@ s64 ntfs_inode_attr_pread(struct inode *vi, s64 pos, s64 count, u8 *buf)
 		count = isize - pos;
 
 	if (!NInoNonResident(ni)) {
+		struct ntfs_inode *base_ni = ni->ext.base_ntfs_ino;
 		struct ntfs_attr_search_ctx *ctx;
 		u8 *attr;
 
-		ctx = ntfs_attr_get_search_ctx(ni->ext.base_ntfs_ino, NULL);
+		ctx = ntfs_attr_get_search_ctx(base_ni, NULL, NTFS_ATTR_CTX_LOCK_READ);
 		if (!ctx) {
 			ntfs_error(vi->i_sb, "Failed to get attr search ctx");
 			err = -ENOMEM;
@@ -3669,6 +3717,8 @@ static s64 __ntfs_inode_non_resident_attr_pwrite(struct inode *vi,
 
 		if (sync) {
 			struct ntfs_volume *vol = ni->vol;
+			struct ntfs_inode *attr_lock_ni;
+			enum ntfs_attr_search_ctx_lock_mode mode;
 			s64 lcn, lcn_count;
 			unsigned int lcn_folio_off = 0;
 			struct bio *bio;
@@ -3678,13 +3728,16 @@ static s64 __ntfs_inode_non_resident_attr_pwrite(struct inode *vi,
 
 			lcn_count = max_t(s64, 1, ntfs_bytes_to_cluster(vol, attr_len));
 			vcn = ntfs_pidx_to_cluster(vol, folio->index);
+			mode = NTFS_ATTR_CTX_LOCK_READ;
 
 			do {
+				attr_lock_ni = ntfs_attr_list_lock(ni, mode);
 				down_write(&ni->runlist.lock);
 				rl = ntfs_attr_vcn_to_rl(ni, vcn, &lcn);
 				if (IS_ERR(rl)) {
 					ret = PTR_ERR(rl);
 					up_write(&ni->runlist.lock);
+					ntfs_attr_list_unlock(attr_lock_ni, mode);
 					goto err_unlock_folio;
 				}
 
@@ -3696,6 +3749,7 @@ static s64 __ntfs_inode_non_resident_attr_pwrite(struct inode *vi,
 					lcn_count = 0;
 				}
 				up_write(&ni->runlist.lock);
+				ntfs_attr_list_unlock(attr_lock_ni, mode);
 
 				if (vol->cluster_size_bits > PAGE_SHIFT) {
 					lcn_folio_off = folio->index << PAGE_SHIFT;
@@ -3756,7 +3810,7 @@ s64 ntfs_inode_attr_pwrite(struct inode *vi, s64 pos, s64 count, u8 *buf, bool s
 
 	WARN_ON(!NInoAttr(ni));
 
-	ctx = ntfs_attr_get_search_ctx(ni->ext.base_ntfs_ino, NULL);
+	ctx = ntfs_attr_get_search_ctx(ni->ext.base_ntfs_ino, NULL, NTFS_ATTR_CTX_LOCK_READ);
 	if (!ctx) {
 		ntfs_error(vi->i_sb, "Failed to get attr search ctx");
 		return -ENOMEM;
diff --git a/fs/ntfs/inode.h b/fs/ntfs/inode.h
index 9aacd5787ffea..4d0fbd53e1c4a 100644
--- a/fs/ntfs/inode.h
+++ b/fs/ntfs/inode.h
@@ -10,6 +10,8 @@
 #ifndef _LINUX_NTFS_INODE_H
 #define _LINUX_NTFS_INODE_H
 
+#include <linux/rwsem.h>
+
 #include "debug.h"
 
 enum ntfs_inode_mutex_lock_class {
@@ -66,6 +68,7 @@ enum ntfs_inode_mutex_lock_class {
  * Attribute list support (only for use by the attribute lookup
  * functions). Setup during read_inode for all inodes with attribute
  * lists. Only valid if NI_AttrList is set in state.
+ * @attr_list_lock: Serializes attribute list pointer updates with lookups.
  * @attr_list_size: Length of attribute list value in bytes.
  * @attr_list: Attribute list value itself.
  *
@@ -118,6 +121,7 @@ struct ntfs_inode {
 	int folio_ofs;
 	s64 mft_lcn[2];
 	unsigned int mft_lcn_count;
+	struct rw_semaphore attr_list_lock;
 	u32 attr_list_size;
 	u8 *attr_list;
 	union {
@@ -336,9 +340,12 @@ int ntfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 
 int ntfs_get_block_mft_record(struct ntfs_inode *mft_ni, struct ntfs_inode *ni);
 int __ntfs_write_inode(struct inode *vi, int sync);
+int ntfs_inode_attach_all_extents_nolock(struct ntfs_inode *ni);
 int ntfs_inode_attach_all_extents(struct ntfs_inode *ni);
+int ntfs_inode_add_attrlist_nolock(struct ntfs_inode *ni);
 int ntfs_inode_add_attrlist(struct ntfs_inode *ni);
 void ntfs_destroy_ext_inode(struct ntfs_inode *ni);
+int ntfs_inode_free_space_nolock(struct ntfs_inode *ni, int size);
 int ntfs_inode_free_space(struct ntfs_inode *ni, int size);
 s64 ntfs_inode_attr_pread(struct inode *vi, s64 pos, s64 count, u8 *buf);
 s64 ntfs_inode_attr_pwrite(struct inode *vi, s64 pos, s64 count, u8 *buf,
diff --git a/fs/ntfs/iomap.c b/fs/ntfs/iomap.c
index 52eecf5cb256a..3af2c6d32b0f7 100644
--- a/fs/ntfs/iomap.c
+++ b/fs/ntfs/iomap.c
@@ -95,7 +95,7 @@ static int ntfs_read_iomap_begin_resident(struct inode *inode, loff_t offset, lo
 	else
 		base_ni = ni;
 
-	ctx = ntfs_attr_get_search_ctx(base_ni, NULL);
+	ctx = ntfs_attr_get_search_ctx(base_ni, NULL, NTFS_ATTR_CTX_LOCK_READ);
 	if (!ctx) {
 		err = -ENOMEM;
 		goto out;
@@ -187,6 +187,7 @@ static int ntfs_read_iomap_begin_non_resident(struct inode *inode, loff_t offset
 		bool need_unwritten)
 {
 	struct ntfs_inode *ni = NTFS_I(inode);
+	struct ntfs_inode *attr_lock_ni;
 	s64 vcn;
 	s64 lcn;
 	struct runlist_element *rl;
@@ -197,20 +198,24 @@ static int ntfs_read_iomap_begin_non_resident(struct inode *inode, loff_t offset
 	vcn = ntfs_bytes_to_cluster(vol, offset);
 	vcn_ofs = ntfs_bytes_to_cluster_off(vol, offset);
 
+	attr_lock_ni = ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LOCK_READ);
 	down_write(&ni->runlist.lock);
 	rl = ntfs_attr_vcn_to_rl(ni, vcn, &lcn);
 	if (IS_ERR(rl)) {
 		up_write(&ni->runlist.lock);
+		ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_READ);
 		return PTR_ERR(rl);
 	}
 
 	if (flags & IOMAP_REPORT) {
 		if (lcn < LCN_HOLE) {
 			up_write(&ni->runlist.lock);
+			ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_READ);
 			return -ENOENT;
 		}
 	} else if (lcn < LCN_ENOENT) {
 		up_write(&ni->runlist.lock);
+		ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_READ);
 		return -EINVAL;
 	}
 
@@ -238,6 +243,7 @@ static int ntfs_read_iomap_begin_non_resident(struct inode *inode, loff_t offset
 				"runlist(vcn : %lld, length : %lld, lcn : %lld) is corrupted\n",
 				rl->vcn, rl->length, rl->lcn);
 		up_write(&ni->runlist.lock);
+		ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_READ);
 		return -EIO;
 	}
 
@@ -246,6 +252,7 @@ static int ntfs_read_iomap_begin_non_resident(struct inode *inode, loff_t offset
 	else
 		iomap->length = length;
 	up_write(&ni->runlist.lock);
+	ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_READ);
 
 	if (!(flags & IOMAP_ZERO) &&
 			iomap->type == IOMAP_MAPPED &&
@@ -365,6 +372,7 @@ static int ntfs_write_simple_iomap_begin_non_resident(struct inode *inode, loff_
 {
 	struct ntfs_inode *ni = NTFS_I(inode);
 	struct ntfs_volume *vol = ni->vol;
+	struct ntfs_inode *attr_lock_ni;
 	loff_t vcn_ofs, rl_length;
 	struct runlist_element *rl, *rlc;
 	bool is_retry = false;
@@ -390,12 +398,14 @@ static int ntfs_write_simple_iomap_begin_non_resident(struct inode *inode, loff_
 	}
 	up_read(&ni->runlist.lock);
 
+	attr_lock_ni = ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LOCK_READ);
 	down_write(&ni->runlist.lock);
 remap_rl:
 	/* Seek to element containing target vcn. */
 	rl = __ntfs_attr_find_vcn_nolock(&ni->runlist, vcn);
 	if (IS_ERR(rl)) {
 		up_write(&ni->runlist.lock);
+		ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_READ);
 		mutex_unlock(&ni->mrec_lock);
 		return -EIO;
 	}
@@ -415,6 +425,7 @@ static int ntfs_write_simple_iomap_begin_non_resident(struct inode *inode, loff_
 				"runlist(vcn : %lld, length : %lld) is corrupted\n",
 				rl->vcn, rl->length);
 		up_write(&ni->runlist.lock);
+		ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_READ);
 		mutex_unlock(&ni->mrec_lock);
 		return -EIO;
 	}
@@ -429,6 +440,7 @@ static int ntfs_write_simple_iomap_begin_non_resident(struct inode *inode, loff_
 			if (max_clu_count < 0) {
 				err = max_clu_count;
 				up_write(&ni->runlist.lock);
+				ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_READ);
 				mutex_unlock(&ni->mrec_lock);
 				return err;
 			}
@@ -444,6 +456,7 @@ static int ntfs_write_simple_iomap_begin_non_resident(struct inode *inode, loff_
 					GFP_NOFS);
 			if (!rlc) {
 				up_write(&ni->runlist.lock);
+				ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_READ);
 				mutex_unlock(&ni->mrec_lock);
 				return -ENOMEM;
 			}
@@ -461,6 +474,7 @@ static int ntfs_write_simple_iomap_begin_non_resident(struct inode *inode, loff_
 			if (IS_ERR(rl)) {
 				ntfs_error(vol->sb, "Failed to merge runlists");
 				up_write(&ni->runlist.lock);
+				ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_READ);
 				mutex_unlock(&ni->mrec_lock);
 				kvfree(rlc);
 				return PTR_ERR(rl);
@@ -471,6 +485,7 @@ static int ntfs_write_simple_iomap_begin_non_resident(struct inode *inode, loff_
 			ni->i_dealloc_clusters += max_clu_count;
 		}
 		up_write(&ni->runlist.lock);
+		ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_READ);
 		mutex_unlock(&ni->mrec_lock);
 
 		if (lcn < LCN_DELALLOC)
@@ -523,6 +538,7 @@ static int ntfs_write_simple_iomap_begin_non_resident(struct inode *inode, loff_
 		}
 	} else {
 		up_write(&ni->runlist.lock);
+		ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_READ);
 		mutex_unlock(&ni->mrec_lock);
 
 		iomap->type = IOMAP_MAPPED;
@@ -549,6 +565,7 @@ static int ntfs_write_da_iomap_begin_non_resident(struct inode *inode,
 {
 	struct ntfs_inode *ni = NTFS_I(inode);
 	struct ntfs_volume *vol = ni->vol;
+	struct ntfs_inode *attr_lock_ni;
 	loff_t vcn_ofs, rl_length;
 	s64 vcn, start_lcn, lcn_count;
 	bool balloc = false, update_mp;
@@ -561,11 +578,13 @@ static int ntfs_write_da_iomap_begin_non_resident(struct inode *inode,
 
 	update_mp = ntfs_iomap_flags & (NTFS_IOMAP_FLAGS_DIO | NTFS_IOMAP_FLAGS_MKWRITE) ||
 			NInoAttr(ni) || ni->mft_no < FILE_first_user;
+	attr_lock_ni = ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LOCK_WRITE);
 	down_write(&ni->runlist.lock);
 	err = ntfs_attr_map_cluster(ni, vcn, &start_lcn, &lcn_count,
 			max_clu_count, &balloc, update_mp,
 			ntfs_iomap_flags & NTFS_IOMAP_FLAGS_WRITEBACK);
 	up_write(&ni->runlist.lock);
+	ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
 	mutex_unlock(&ni->mrec_lock);
 	if (err) {
 		ni->i_dealloc_clusters = 0;
@@ -637,7 +656,7 @@ static int ntfs_write_iomap_begin_resident(struct inode *inode, loff_t offset,
 	int err = 0;
 	char *kattr;
 
-	ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	ctx = ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_READ);
 	if (!ctx) {
 		err = -ENOMEM;
 		goto out;
diff --git a/fs/ntfs/logfile.c b/fs/ntfs/logfile.c
index 024ddee42dc8f..bf967ef8ab68c 100644
--- a/fs/ntfs/logfile.c
+++ b/fs/ntfs/logfile.c
@@ -643,6 +643,7 @@ bool ntfs_empty_logfile(struct inode *log_vi)
 	struct ntfs_inode *log_ni = NTFS_I(log_vi);
 	struct ntfs_volume *vol = log_ni->vol;
 	struct super_block *sb = vol->sb;
+	struct ntfs_inode *attr_lock_ni;
 	struct runlist_element *rl;
 	unsigned long flags;
 	int err;
@@ -669,6 +670,7 @@ bool ntfs_empty_logfile(struct inode *log_vi)
 			vol->cluster_size_bits;
 	read_unlock_irqrestore(&log_ni->size_lock, flags);
 	truncate_inode_pages(log_vi->i_mapping, 0);
+	attr_lock_ni = ntfs_attr_list_lock(log_ni, NTFS_ATTR_CTX_LOCK_READ);
 	down_write(&log_ni->runlist.lock);
 	rl = log_ni->runlist.rl;
 	if (unlikely(!rl || vcn < rl->vcn || !rl->length)) {
@@ -755,6 +757,7 @@ bool ntfs_empty_logfile(struct inode *log_vi)
 		} while (start < end);
 	} while ((++rl)->vcn < end_vcn);
 	up_write(&log_ni->runlist.lock);
+	ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_READ);
 	kvfree(empty_buf);
 	kfree(ra);
 	truncate_inode_pages(log_vi->i_mapping, 0);
@@ -774,6 +777,7 @@ bool ntfs_empty_logfile(struct inode *log_vi)
 	kvfree(empty_buf);
 	kfree(ra);
 	up_write(&log_ni->runlist.lock);
+	ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_READ);
 	ntfs_error(sb, "Failed to fill LogFile with 0xff bytes (error %d).",
 			-err);
 	return false;
diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index a5019e80951b8..f3e27023250cb 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -12,6 +12,7 @@
 #include <linux/bio.h>
 #include <linux/iomap.h>
 
+#include "attrib.h"
 #include "bitmap.h"
 #include "lcnalloc.h"
 #include "mft.h"
@@ -1015,7 +1016,7 @@ static int ntfs_mft_attr_extend(struct ntfs_inode *ni)
 		base_ni = ni;
 
 	if (!NInoAttrList(base_ni)) {
-		ret = ntfs_inode_add_attrlist(base_ni);
+		ret = ntfs_inode_add_attrlist_nolock(base_ni);
 		if (ret) {
 			pr_err("Can not add attrlist\n");
 			goto out;
@@ -1025,7 +1026,7 @@ static int ntfs_mft_attr_extend(struct ntfs_inode *ni)
 		}
 	}
 
-	ret = ntfs_attr_update_mapping_pairs(ni, 0);
+	ret = ntfs_attr_update_mapping_pairs_nolock(ni, 0);
 	if (ret)
 		pr_err("MP update failed\n");
 
@@ -1057,6 +1058,7 @@ static int ntfs_mft_bitmap_extend_allocation_nolock(struct ntfs_volume *vol)
 	unsigned long flags;
 	struct folio *folio;
 	struct ntfs_inode *mft_ni, *mftbmp_ni;
+	struct ntfs_inode *attr_lock_ni;
 	struct runlist_element *rl, *rl2 = NULL;
 	struct ntfs_attr_search_ctx *ctx = NULL;
 	struct mft_record *mrec;
@@ -1075,6 +1077,7 @@ static int ntfs_mft_bitmap_extend_allocation_nolock(struct ntfs_volume *vol)
 	ntfs_debug("Extending mft bitmap allocation.");
 	mft_ni = NTFS_I(vol->mft_ino);
 	mftbmp_ni = NTFS_I(vol->mftbmp_ino);
+	attr_lock_ni = ntfs_attr_list_lock(mftbmp_ni, NTFS_ATTR_CTX_LOCK_WRITE);
 	/*
 	 * Determine the last lcn of the mft bitmap.  The allocated size of the
 	 * mft bitmap cannot be zero so we are ok to do this.
@@ -1087,6 +1090,7 @@ static int ntfs_mft_bitmap_extend_allocation_nolock(struct ntfs_volume *vol)
 			NTFS_B_TO_CLU(vol, ll - 1), NULL);
 	if (IS_ERR(rl) || unlikely(!rl->length || rl->lcn < 0)) {
 		up_write(&mftbmp_ni->runlist.lock);
+		ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
 		ntfs_error(vol->sb,
 			"Failed to determine last allocated cluster of mft bitmap attribute.");
 		if (!IS_ERR(rl))
@@ -1108,6 +1112,7 @@ static int ntfs_mft_bitmap_extend_allocation_nolock(struct ntfs_volume *vol)
 			ll >> PAGE_SHIFT, NULL);
 	if (IS_ERR(folio)) {
 		up_write(&mftbmp_ni->runlist.lock);
+		ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
 		ntfs_error(vol->sb, "Failed to read from lcn bitmap.");
 		return PTR_ERR(folio);
 	}
@@ -1139,6 +1144,7 @@ static int ntfs_mft_bitmap_extend_allocation_nolock(struct ntfs_volume *vol)
 				true, false, false);
 		if (IS_ERR(rl2)) {
 			up_write(&mftbmp_ni->runlist.lock);
+			ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
 			ntfs_error(vol->sb,
 					"Failed to allocate a cluster for the mft bitmap.");
 			return PTR_ERR(rl2);
@@ -1146,6 +1152,7 @@ static int ntfs_mft_bitmap_extend_allocation_nolock(struct ntfs_volume *vol)
 		rl = ntfs_runlists_merge(&mftbmp_ni->runlist, rl2, 0, &new_rl_count);
 		if (IS_ERR(rl)) {
 			up_write(&mftbmp_ni->runlist.lock);
+			ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
 			ntfs_error(vol->sb, "Failed to merge runlists for mft bitmap.");
 			if (ntfs_cluster_free_from_rl(vol, rl2)) {
 				ntfs_error(vol->sb, "Failed to deallocate allocated cluster.%s",
@@ -1173,7 +1180,7 @@ static int ntfs_mft_bitmap_extend_allocation_nolock(struct ntfs_volume *vol)
 		ret = PTR_ERR(mrec);
 		goto undo_alloc;
 	}
-	ctx = ntfs_attr_get_search_ctx(mft_ni, mrec);
+	ctx = ntfs_attr_get_search_ctx(mft_ni, mrec, NTFS_ATTR_CTX_LOCK_NONE);
 	if (unlikely(!ctx)) {
 		ntfs_error(vol->sb, "Failed to get search context.");
 		ret = -ENOMEM;
@@ -1265,6 +1272,7 @@ static int ntfs_mft_bitmap_extend_allocation_nolock(struct ntfs_volume *vol)
 	ntfs_attr_put_search_ctx(ctx);
 	unmap_mft_record(mft_ni);
 	up_write(&mftbmp_ni->runlist.lock);
+	ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
 	ntfs_debug("Done.");
 	return 0;
 
@@ -1281,6 +1289,7 @@ static int ntfs_mft_bitmap_extend_allocation_nolock(struct ntfs_volume *vol)
 		ntfs_attr_put_search_ctx(ctx);
 		unmap_mft_record(mft_ni);
 		up_write(&mftbmp_ni->runlist.lock);
+		ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
 		/*
 		 * The only thing that is now wrong is ->allocated_size of the
 		 * base attribute extent which chkdsk should be able to fix.
@@ -1324,7 +1333,8 @@ static int ntfs_mft_bitmap_extend_allocation_nolock(struct ntfs_volume *vol)
 			NVolSetErrors(vol);
 		}
 		mark_mft_record_dirty(ctx->ntfs_ino);
-	} else if (status.mp_extended && ntfs_attr_update_mapping_pairs(mftbmp_ni, 0)) {
+	} else if (status.mp_extended &&
+		   ntfs_attr_update_mapping_pairs_nolock(mftbmp_ni, 0)) {
 		ntfs_error(vol->sb, "Failed to restore mapping pairs.%s", es);
 		NVolSetErrors(vol);
 	}
@@ -1333,6 +1343,7 @@ static int ntfs_mft_bitmap_extend_allocation_nolock(struct ntfs_volume *vol)
 	if (!IS_ERR(mrec))
 		unmap_mft_record(mft_ni);
 	up_write(&mftbmp_ni->runlist.lock);
+	ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
 	return ret;
 }
 
@@ -1371,7 +1382,7 @@ static int ntfs_mft_bitmap_extend_initialized_nolock(struct ntfs_volume *vol)
 		ntfs_error(vol->sb, "Failed to map mft record.");
 		return PTR_ERR(mrec);
 	}
-	ctx = ntfs_attr_get_search_ctx(mft_ni, mrec);
+	ctx = ntfs_attr_get_search_ctx(mft_ni, mrec, NTFS_ATTR_CTX_LOCK_READ);
 	if (unlikely(!ctx)) {
 		ntfs_error(vol->sb, "Failed to get search context.");
 		ret = -ENOMEM;
@@ -1423,7 +1434,7 @@ static int ntfs_mft_bitmap_extend_initialized_nolock(struct ntfs_volume *vol)
 		NVolSetErrors(vol);
 		return ret;
 	}
-	ctx = ntfs_attr_get_search_ctx(mft_ni, mrec);
+	ctx = ntfs_attr_get_search_ctx(mft_ni, mrec, NTFS_ATTR_CTX_LOCK_READ);
 	if (unlikely(!ctx)) {
 		ntfs_error(vol->sb, "Failed to get search context.%s", es);
 		NVolSetErrors(vol);
@@ -1490,6 +1501,7 @@ static int ntfs_mft_data_extend_allocation_nolock(struct ntfs_volume *vol)
 	s64 min_nr, nr, ll;
 	unsigned long flags;
 	struct ntfs_inode *mft_ni;
+	struct ntfs_inode *attr_lock_ni;
 	struct runlist_element *rl, *rl2;
 	struct ntfs_attr_search_ctx *ctx = NULL;
 	struct mft_record *mrec;
@@ -1501,6 +1513,7 @@ static int ntfs_mft_data_extend_allocation_nolock(struct ntfs_volume *vol)
 
 	ntfs_debug("Extending mft data allocation.");
 	mft_ni = NTFS_I(vol->mft_ino);
+	attr_lock_ni = ntfs_attr_list_lock(mft_ni, NTFS_ATTR_CTX_LOCK_WRITE);
 	/*
 	 * Determine the preferred allocation location, i.e. the last lcn of
 	 * the mft data attribute.  The allocated size of the mft data
@@ -1514,6 +1527,7 @@ static int ntfs_mft_data_extend_allocation_nolock(struct ntfs_volume *vol)
 			NTFS_B_TO_CLU(vol, ll - 1), NULL);
 	if (IS_ERR(rl) || unlikely(!rl->length || rl->lcn < 0)) {
 		up_write(&mft_ni->runlist.lock);
+		ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
 		ntfs_error(vol->sb,
 			"Failed to determine last allocated cluster of mft data attribute.");
 		if (!IS_ERR(rl))
@@ -1544,6 +1558,7 @@ static int ntfs_mft_data_extend_allocation_nolock(struct ntfs_volume *vol)
 			ntfs_warning(vol->sb,
 				"Cannot allocate mft record because the maximum number of inodes (2^32) has already been reached.");
 			up_write(&mft_ni->runlist.lock);
+			ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
 			return -ENOSPC;
 		}
 	}
@@ -1568,6 +1583,7 @@ static int ntfs_mft_data_extend_allocation_nolock(struct ntfs_volume *vol)
 			ntfs_error(vol->sb,
 				"Failed to allocate the minimal number of clusters (%lli) for the mft data attribute.",
 				nr);
+			ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
 			return PTR_ERR(rl2);
 		}
 		/*
@@ -1583,6 +1599,7 @@ static int ntfs_mft_data_extend_allocation_nolock(struct ntfs_volume *vol)
 	rl = ntfs_runlists_merge(&mft_ni->runlist, rl2, 0, &new_rl_count);
 	if (IS_ERR(rl)) {
 		up_write(&mft_ni->runlist.lock);
+		ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
 		ntfs_error(vol->sb, "Failed to merge runlists for mft data attribute.");
 		if (ntfs_cluster_free_from_rl(vol, rl2)) {
 			ntfs_error(vol->sb,
@@ -1608,7 +1625,7 @@ static int ntfs_mft_data_extend_allocation_nolock(struct ntfs_volume *vol)
 		down_write(&mft_ni->runlist.lock);
 		goto undo_alloc;
 	}
-	ctx = ntfs_attr_get_search_ctx(mft_ni, mrec);
+	ctx = ntfs_attr_get_search_ctx(mft_ni, mrec, NTFS_ATTR_CTX_LOCK_NONE);
 	if (unlikely(!ctx)) {
 		ntfs_error(vol->sb, "Failed to get search context.");
 		ret = -ENOMEM;
@@ -1704,6 +1721,7 @@ static int ntfs_mft_data_extend_allocation_nolock(struct ntfs_volume *vol)
 	ntfs_attr_put_search_ctx(ctx);
 	unmap_mft_record(mft_ni);
 	ntfs_debug("Done.");
+	ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
 	return 0;
 restore_undo_alloc:
 	ntfs_attr_reinit_search_ctx(ctx);
@@ -1717,6 +1735,7 @@ static int ntfs_mft_data_extend_allocation_nolock(struct ntfs_volume *vol)
 		ntfs_attr_put_search_ctx(ctx);
 		unmap_mft_record(mft_ni);
 		up_write(&mft_ni->runlist.lock);
+		ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
 		/*
 		 * The only thing that is now wrong is ->allocated_size of the
 		 * base attribute extent which chkdsk should be able to fix.
@@ -1736,7 +1755,7 @@ static int ntfs_mft_data_extend_allocation_nolock(struct ntfs_volume *vol)
 		ntfs_error(vol->sb, "Failed to truncate mft data attribute runlist.%s", es);
 		NVolSetErrors(vol);
 	}
-	if (mp_extended && ntfs_attr_update_mapping_pairs(mft_ni, 0)) {
+	if (mp_extended && ntfs_attr_update_mapping_pairs_nolock(mft_ni, 0)) {
 		ntfs_error(vol->sb, "Failed to restore mapping pairs.%s",
 			   es);
 		NVolSetErrors(vol);
@@ -1765,6 +1784,7 @@ static int ntfs_mft_data_extend_allocation_nolock(struct ntfs_volume *vol)
 	}
 	if (!IS_ERR(mrec))
 		unmap_mft_record(mft_ni);
+	ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
 	return ret;
 }
 
@@ -2248,7 +2268,7 @@ int ntfs_mft_record_alloc(struct ntfs_volume *vol, const int mode,
 		err = PTR_ERR(m);
 		goto undo_data_init;
 	}
-	ctx = ntfs_attr_get_search_ctx(mft_ni, m);
+	ctx = ntfs_attr_get_search_ctx(mft_ni, m, NTFS_ATTR_CTX_LOCK_READ);
 	if (unlikely(!ctx)) {
 		ntfs_error(vol->sb, "Failed to get search context.");
 		err = -ENOMEM;
@@ -2593,14 +2613,17 @@ int ntfs_mft_record_free(struct ntfs_volume *vol, struct ntfs_inode *ni)
 static s64 lcn_from_index(struct ntfs_volume *vol, struct ntfs_inode *ni,
 		unsigned long index)
 {
+	struct ntfs_inode *attr_lock_ni;
 	s64 vcn;
 	s64 lcn;
 
 	vcn = ntfs_pidx_to_cluster(vol, index);
 
+	attr_lock_ni = ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LOCK_READ);
 	down_read(&ni->runlist.lock);
 	lcn = ntfs_attr_vcn_to_lcn_nolock(ni, vcn, false);
 	up_read(&ni->runlist.lock);
+	ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_READ);
 
 	return lcn;
 }
@@ -2700,14 +2723,20 @@ static int ntfs_write_mft_block(struct folio *folio, struct writeback_control *w
 				bio = NULL;
 			}
 
-			if (vol->cluster_size < folio_size(folio)) {
-				down_write(&ni->runlist.lock);
-				rl = ntfs_attr_vcn_to_rl(ni, vcn_off, &lcn);
-				up_write(&ni->runlist.lock);
-				if (IS_ERR(rl) || lcn < 0) {
-					err = -EIO;
-					goto unm_done;
-				}
+				if (vol->cluster_size < folio_size(folio)) {
+					struct ntfs_inode *attr_lock_ni;
+					enum ntfs_attr_search_ctx_lock_mode mode;
+
+					mode = NTFS_ATTR_CTX_LOCK_READ;
+					attr_lock_ni = ntfs_attr_list_lock(ni, mode);
+					down_write(&ni->runlist.lock);
+					rl = ntfs_attr_vcn_to_rl(ni, vcn_off, &lcn);
+					up_write(&ni->runlist.lock);
+					ntfs_attr_list_unlock(attr_lock_ni, mode);
+					if (IS_ERR(rl) || lcn < 0) {
+						err = -EIO;
+						goto unm_done;
+					}
 
 				if (bio &&
 				   (bio_end_sector(bio) >> (vol->cluster_size_bits - 9)) !=
diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
index 78c159519f9ce..cd1468960ca43 100644
--- a/fs/ntfs/namei.c
+++ b/fs/ntfs/namei.c
@@ -267,7 +267,7 @@ static struct dentry *ntfs_lookup(struct inode *dir_ino, struct dentry *dent,
 				ctx = NULL;
 				goto err_out;
 			}
-			ctx = ntfs_attr_get_search_ctx(ni, m);
+			ctx = ntfs_attr_get_search_ctx(ni, m, NTFS_ATTR_CTX_LOCK_READ);
 			if (unlikely(!ctx)) {
 				err = -ENOMEM;
 				goto err_out;
@@ -859,7 +859,7 @@ static int ntfs_delete(struct ntfs_inode *ni, struct ntfs_inode *dir_ni,
 	 * If filename in DOS or in WIN32 namespace, then remove DOS name first,
 	 * only then remove WIN32 name.
 	 */
-	actx = ntfs_attr_get_search_ctx(ni, NULL);
+	actx = ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_WRITE);
 	if (!actx) {
 		ntfs_error(sb, "%s, Failed to get search context", __func__);
 		if (need_lock) {
@@ -1607,7 +1607,7 @@ static struct dentry *ntfs_get_parent(struct dentry *child_dent)
 	if (IS_ERR(mrec))
 		return ERR_CAST(mrec);
 	/* Find the first file name attribute in the mft record. */
-	ctx = ntfs_attr_get_search_ctx(ni, mrec);
+	ctx = ntfs_attr_get_search_ctx(ni, mrec, NTFS_ATTR_CTX_LOCK_READ);
 	if (unlikely(!ctx)) {
 		unmap_mft_record(ni);
 		return ERR_PTR(-ENOMEM);
diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 8abe7bee4c0d9..6af24fbeb918d 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -380,7 +380,7 @@ static int ntfs_write_volume_flags(struct ntfs_volume *vol, const __le16 flags)
 	if (vol->vol_flags == flags)
 		goto done;
 
-	ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	ctx = ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_READ);
 	if (!ctx) {
 		err = -ENOMEM;
 		goto put_unm_err_out;
@@ -476,7 +476,7 @@ int ntfs_write_volume_label(struct ntfs_volume *vol, char *label)
 	}
 
 	mutex_lock(&vol_ni->mrec_lock);
-	ctx = ntfs_attr_get_search_ctx(vol_ni, NULL);
+	ctx = ntfs_attr_get_search_ctx(vol_ni, NULL, NTFS_ATTR_CTX_LOCK_WRITE);
 	if (!ctx) {
 		ret = -ENOMEM;
 		goto out;
@@ -1481,7 +1481,7 @@ static bool load_system_files(struct ntfs_volume *vol)
 		goto volume_failed;
 	}
 
-	ctx = ntfs_attr_get_search_ctx(NTFS_I(vol->vol_ino), m);
+	ctx = ntfs_attr_get_search_ctx(NTFS_I(vol->vol_ino), m, NTFS_ATTR_CTX_LOCK_READ);
 	if (!ctx) {
 		ntfs_error(sb, "Failed to get attribute search context.");
 		goto get_ctx_vol_failed;
-- 
2.43.0

