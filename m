Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C711233926
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jun 2026 04:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782534505; cv=none; b=D06BT2/q2080EdwQhgFEYlsIlnHu24YWH2Fl5v8D4FptHJbg83QNGoSoFshp7mNO/xGvGvwMc7gYKqHJ9UgfezqRqkL2T37EepG7YR6xjqdFmfiSWBYdC08gbmhWpDx58bMgQGEQLqbGYvnW1BxGoJrod6HBule09N3223/X4yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782534505; c=relaxed/simple;
	bh=Rtp1Ev6VA2Q+XDAabZHhG/dcIwAWXl0RNGOGgDpC1qg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t6IF7CSwQ/MfjVTikXwEUrSPyDbUMTAQZR9uwBkDFFhjVB+KBcPBu2JANl6ZiwjTezYvFcbbJoD8z+Qje9PqN6U3c90Vb03Iw14xUZNQWjHTF4Qa9zUYyoYyyujkS8SlBeWx2TQb6cs5H0PM7iYIZNUbc1/N9BaHpE6azjrISEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIVQU6xs; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIVQU6xs"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-37fb434c547so287571a91.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2026 21:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782534503; x=1783139303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/ULQw+0kROWQ+50mu6tbRwiETntZ0adR/wyHI3BGd00=;
        b=SIVQU6xs3oJFyyhrS9OVDICg2behkIREmZS51VkEDwpdPaj0uz8MNf6QgHBOzq6WbV
         zIxVn6rZX4PGQoHLsm/mTVe5JpSBmmqiaL1dEYSRlG62KAZthlBceEswyfjNZPlPlZbo
         i4yQDRH0+BcSXXUG9wUtq4WihDFliUXBGO6pSd9l41I1JhOW/RX058qw+oUXdnin7CJT
         vx9HFfCwX+/nmR6ggwdm5i8LOglcOP19/mFmqrPiavD+Ml8AVuleyaKZjgKRH5OaSmTa
         MMb9GJVu7KQ+tQrLQiPYJsekpU6NygsWT0zG1Ebo3jU7NKHJC9rjX0MVRnrC1JVzS+x0
         mf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782534503; x=1783139303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ULQw+0kROWQ+50mu6tbRwiETntZ0adR/wyHI3BGd00=;
        b=fcMjXsOV42U4K/3781MfIPtaJ3rE6plQBb/ZSsgCq5dq0XSXIy0nTZVCpOqDMgJ++t
         CixfsqiAMZoYvwiz6DhS+1uQERHSccHJHlFlwgcHY1KSLnuzRJ/1VSw9awsJj11Uscmi
         MseV6gafxRB4gl7yX80geb5+uyHWrOBkg9pi8c5l0C3vjp33Fl5OlMPk6BunFgIFJQv/
         gJA/0HifyT0yXcpf8cDkKk7MnWzQelKqtdNGVhVd00ceJwZ8B4LOD5rvczqADoC1R57B
         nDC2oKQV5gAgivAT685gFQebjnZn2rz0WfkIvo8Acl7RxYJb6eM6/FDf1yK9gDs6NSmE
         7yiQ==
X-Gm-Message-State: AOJu0YxkMMNa8pl/FIt5Hr/dlb7djR0KIzg+Xb1CV+aNLQCSiroWVSzN
	dI+NLiytUDQfmBR/6gHD37wvSXy4do0VNnQfzMSQ0/1IqSWcXjqyDJmg
X-Gm-Gg: AfdE7clu+XPpD2UtkGKCFGgLQsQ1hzgMUw5NkpxYMtBhXN9jTT8zjv1WtKM32bJ0xOv
	cZudfVMAWsEaRESqpHnW0zpV6WNhXYlrk3h0nJo3hFm14APImbdboVrLBCmrNlWaGzIwrMlzgmH
	3oR52oT816jkbgmC69ssQ3bZjw77Q0mqxHAf8lMzvhB2R033Mp6pdZU8pfIB2xXZ8whKM8Kx0bk
	ggO/PUAggIs3nZDw0Vc3kdacyAVJS635X0ke8Kf+u0wNEJT0GkXR+zACaAX9aH1Sho4hB9otDTo
	L0cnuJu8VL0JpwhcVDpTvoRW56Uwz+/e69/4WJ0kmDeXdxSkYvVXu1INx3U/Vj0T863vUzqcD8P
	HYWVsbt8GJtLO8XX9iz5wYoaXpWMRQHvdzeoSQVZPNWn2nUL+X//5zve4vVhFXoR0OPgtju4hjD
	Zv5rbrZ08=
X-Received: by 2002:a17:90b:2f8f:b0:37d:eeda:75c4 with SMTP id 98e67ed59e1d1-37dfa1cf391mr8197952a91.14.1782534503272;
        Fri, 26 Jun 2026 21:28:23 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37fbf0ea4c8sm475384a91.5.2026.06.26.21.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 21:28:22 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH v2] ntfs: serialize attribute-list replacement with lookups
Date: Sat, 27 Jun 2026 12:28:16 +0800
Message-Id: <20260627042816.2842609-1-zzzccc427@gmail.com>
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

Add a per-ntfs_inode attr_list_lock.  ntfs_attr_lookup() takes the read
side around the NInoAttrList() decision and the selected local or
external lookup, so any attr-list cursor derived during the lookup is
protected until the lookup returns.  Writers take the write side only
while publishing, rolling back, detaching, or clearing the in-memory
attr_list pointer, size, and state.  The on-disk ntfs_attrlist_update()
work stays outside the write side.

Fixes: 495e90fa3348 ("ntfs: update attrib operations")
Assisted-by: Codex:gpt-5.5
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
v2:
- Replace the read-iomap mrec_lock wrapper with a per-inode attr_list rwsem,
  following Hyunchul Lee's review.
- Protect attr-list creation, replacement, rollback, detach, and clear
  transitions, while keeping ntfs_attrlist_update() outside the write side.
- Update the Fixes tag to the attribute operations commit.

 fs/ntfs/attrib.c   | 21 +++++++++++++++++----
 fs/ntfs/attrlist.c | 10 +++++++++-
 fs/ntfs/inode.c    | 10 ++++++++++
 fs/ntfs/inode.h    |  4 ++++
 4 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index dd8828098511..e630f63ed7ad 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -1565,6 +1565,7 @@ int ntfs_attr_lookup(const __le32 type, const __le16 *name,
 		struct ntfs_attr_search_ctx *ctx)
 {
 	struct ntfs_inode *base_ni;
+	int err;
 
 	ntfs_debug("Entering.");
 	if (ctx->base_ntfs_ino)
@@ -1572,11 +1573,18 @@ int ntfs_attr_lookup(const __le32 type, const __le16 *name,
 	else
 		base_ni = ctx->ntfs_ino;
 	/* Sanity check, just for debugging really. */
-	if (!base_ni || !NInoAttrList(base_ni) || type == AT_ATTRIBUTE_LIST)
+	if (!base_ni)
 		return ntfs_attr_find(type, name, name_len, ic, val, val_len,
 				ctx);
-	return ntfs_external_attr_find(type, name, name_len, ic, lowest_vcn,
-			val, val_len, ctx);
+
+	down_read(&base_ni->attr_list_lock);
+	if (!NInoAttrList(base_ni) || type == AT_ATTRIBUTE_LIST)
+		err = ntfs_attr_find(type, name, name_len, ic, val, val_len, ctx);
+	else
+		err = ntfs_external_attr_find(type, name, name_len, ic,
+					      lowest_vcn, val, val_len, ctx);
+	up_read(&base_ni->attr_list_lock);
+	return err;
 }
 
 /**
@@ -2622,6 +2630,7 @@ static int ntfs_non_resident_attr_record_add(struct ntfs_inode *ni, __le32 type,
 int ntfs_attr_record_rm(struct ntfs_attr_search_ctx *ctx)
 {
 	struct ntfs_inode *base_ni, *ni;
+	u8 *old_al = NULL;
 	__le32 type;
 	int err;
 
@@ -2659,10 +2668,14 @@ int ntfs_attr_record_rm(struct ntfs_attr_search_ctx *ctx)
 
 	/* Post $ATTRIBUTE_LIST delete setup. */
 	if (type == AT_ATTRIBUTE_LIST) {
+		down_write(&base_ni->attr_list_lock);
 		if (NInoAttrList(base_ni) && base_ni->attr_list)
-			kvfree(base_ni->attr_list);
+			old_al = base_ni->attr_list;
 		base_ni->attr_list = NULL;
+		base_ni->attr_list_size = 0;
 		NInoClearAttrList(base_ni);
+		up_write(&base_ni->attr_list_lock);
+		kvfree(old_al);
 	}
 
 	/* Free MFT record, if it doesn't contain attributes. */
diff --git a/fs/ntfs/attrlist.c b/fs/ntfs/attrlist.c
index afb13038ba42..e91fc74eda31 100644
--- a/fs/ntfs/attrlist.c
+++ b/fs/ntfs/attrlist.c
@@ -220,14 +220,18 @@ int ntfs_attrlist_entry_add(struct ntfs_inode *ni, struct attr_record *attr)
 			entry_offset, ni->attr_list_size - entry_offset);
 
 	/* Set new runlist. */
+	down_write(&ni->attr_list_lock);
 	old_al = ni->attr_list;
 	ni->attr_list = new_al;
 	ni->attr_list_size = ni->attr_list_size + entry_len;
+	up_write(&ni->attr_list_lock);
 
 	err = ntfs_attrlist_update(ni);
 	if (err) {
+		down_write(&ni->attr_list_lock);
 		ni->attr_list = old_al;
 		ni->attr_list_size -= entry_len;
+		up_write(&ni->attr_list_lock);
 		goto err_out;
 	}
 	kvfree(old_al);
@@ -251,6 +255,7 @@ int ntfs_attrlist_entry_rm(struct ntfs_attr_search_ctx *ctx)
 	int new_al_len;
 	struct ntfs_inode *base_ni;
 	struct attr_list_entry *ale;
+	u8 *old_al;
 
 	if (!ctx || !ctx->ntfs_ino || !ctx->al_entry) {
 		ntfs_debug("Invalid arguments.\n");
@@ -285,9 +290,12 @@ int ntfs_attrlist_entry_rm(struct ntfs_attr_search_ctx *ctx)
 				ale->length), new_al_len - ((u8 *)ale - base_ni->attr_list));
 
 	/* Set new runlist. */
-	kvfree(base_ni->attr_list);
+	down_write(&base_ni->attr_list_lock);
+	old_al = base_ni->attr_list;
 	base_ni->attr_list = new_al;
 	base_ni->attr_list_size = new_al_len;
+	up_write(&base_ni->attr_list_lock);
+	kvfree(old_al);
 
 	return ntfs_attrlist_update(base_ni);
 }
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index c2715521e562..25e957401892 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -475,6 +475,7 @@ void __ntfs_init_inode(struct super_block *sb, struct ntfs_inode *ni)
 	ni->folio = NULL;
 	ni->folio_ofs = 0;
 	ni->mrec = NULL;
+	init_rwsem(&ni->attr_list_lock);
 	ni->attr_list_size = 0;
 	ni->attr_list = NULL;
 	ni->itype.index.block_size = 0;
@@ -3112,9 +3113,11 @@ int ntfs_inode_add_attrlist(struct ntfs_inode *ni)
 	}
 
 	/* Set in-memory attribute list. */
+	down_write(&ni->attr_list_lock);
 	ni->attr_list = al;
 	ni->attr_list_size = al_len;
 	NInoSetAttrList(ni);
+	up_write(&ni->attr_list_lock);
 
 	attr_al_len = offsetof(struct attr_record, data.resident.reserved) + 1 +
 		((al_len + 7) & ~7);
@@ -3147,8 +3150,11 @@ int ntfs_inode_add_attrlist(struct ntfs_inode *ni)
 
 remove_attrlist_record:
 	/* Prevent ntfs_attr_recorm_rm from freeing attribute list. */
+	down_write(&ni->attr_list_lock);
 	ni->attr_list = NULL;
+	ni->attr_list_size = 0;
 	NInoClearAttrList(ni);
+	up_write(&ni->attr_list_lock);
 	/* Remove $ATTRIBUTE_LIST record. */
 	ntfs_attr_reinit_search_ctx(ctx);
 	if (!ntfs_attr_lookup(AT_ATTRIBUTE_LIST, NULL, 0,
@@ -3160,9 +3166,11 @@ int ntfs_inode_add_attrlist(struct ntfs_inode *ni)
 	}
 
 	/* Setup back in-memory runlist. */
+	down_write(&ni->attr_list_lock);
 	ni->attr_list = al;
 	ni->attr_list_size = al_len;
 	NInoSetAttrList(ni);
+	up_write(&ni->attr_list_lock);
 rollback:
 	/*
 	 * Scan attribute list for attributes that placed not in the base MFT
@@ -3189,10 +3197,12 @@ int ntfs_inode_add_attrlist(struct ntfs_inode *ni)
 	}
 
 	/* Remove in-memory attribute list. */
+	down_write(&ni->attr_list_lock);
 	ni->attr_list = NULL;
 	ni->attr_list_size = 0;
 	NInoClearAttrList(ni);
 	NInoClearAttrListDirty(ni);
+	up_write(&ni->attr_list_lock);
 put_err_out:
 	ntfs_attr_put_search_ctx(ctx);
 err_out:
diff --git a/fs/ntfs/inode.h b/fs/ntfs/inode.h
index 9aacd5787ffe..0aaa6c90a7fb 100644
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
-- 
2.43.0
