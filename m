Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECF483A14
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Jul 2026 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783180968; cv=none; b=miES/gEyJd9diXaxpeGrMbSK3heKNp+5tTZ172tg5Y5Wnpab4qRJNHB0uV9uYZjk4tyIULOZh0tNwV2BmN3kqGw1TSaRI0c/NFsOM7bT9o4rVSYc89QWlR70kV/HT9d5Nss/dVSrfQW/kAS+1RBsHO5CSEBXIg+PTwBz+6l1NEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783180968; c=relaxed/simple;
	bh=zycDZSv7AxEp0Ph71TFBqleTL/rnxPHeLEU8Bah/eyM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lqF9ZDeUBT4WCJ/7AVTIkYhGiM7HOlQ1BnZPBmn+86j7q+24tY3rTpMMPZRufpwKXxTKY06o5DWvExpQ0Xjx0QjX7jV4CVTEtMRUGSI1OLJNLjizOdtAd4fnMDoYkMA0B2mids5+sWYVJsq1ZqxhoEMdXAN7+ZDYGa3nTCfOGm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgSlI9s0; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgSlI9s0"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cace91f112so12058295ad.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 Jul 2026 09:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783180961; x=1783785761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=caJjxTU6/Ukw6tC9QPzwGNzpV01ADXFgnfNYfi1G4z0=;
        b=RgSlI9s00ti6Ahi1iuZAs1wV2vHrwXto3rF5mLtqX3FwpWbTQvDJM0LaFPvKVLC8ce
         k2jer2UwhuOlyOf3j/VVr6UQmE3wRwGeHAy9Vzxg74t4RFIpL2GANZNSXMiRpaYrWoua
         hkN4ASexJXR8Cj5J/3vO0MP8+SnIOkdvqnKrReDTy4862S4TxsWyruG+mTjoOUuzhUB4
         G0L8aLYam0MzPGtVB852rbKiLgTzoJsAVoGwZl/4hd+UaeYI9GF6640FJEq5RjEvwLL4
         vOLE05GRo3ZPJBAuNug2+KD+TBAybmoyRCTi7YPwiDgpYzUc2/A95eNw9uxqtFmhHB0M
         87Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783180961; x=1783785761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=caJjxTU6/Ukw6tC9QPzwGNzpV01ADXFgnfNYfi1G4z0=;
        b=MebWMsdK2jQoge8RYW0GRUS1zuveO/cWeSF3NZ1vLIs/7XC/UTI/qNrRGr/mn0lqcc
         +nIER8rQPXvES1BHrit0YREt7WzDyeeYa5lH4l/V71bUZz8RLvE4ERreIyWL/SlAtIiY
         uKkzgKFaNPYbJ/dgG0KpMMhO3FJdLYJuZIiSwoebMI5SQN6O90pYcLYmo9BpmEs8z5q4
         bezfJvhFOsXy27c/lVgDB0l32p5Ua9ZYlT9M6L+dRR+aE4mK//ygHVqZ1RFA48DFQDd0
         mmjvozSSifHuIV+nI7PD205gOUDa9MC2+frQZL9e20sOA++EQykeMZDsw+g9Kz0Ra7Et
         gcUQ==
X-Gm-Message-State: AOJu0YxsgI0mCaaN8lKVyGoEKU7VDAlEAzNZFqTccznn+fL+ygxHQ/1t
	x2aLou3gHpX6xKkGaaQdLJIcpYuOgJ9YYAK40TVuckAogxfw9U8Euomz
X-Gm-Gg: AfdE7clBvV3h3HgKQe8HSh2h6/spz9j53QqOj3XLLfKTya0kSncoEio9mNnn65Ij/OS
	bhkJmIGyPQ8mKzOzy02cRRdo+2jj0CSMBbcm99jz1bz3H0B1ISohUSD6D7lvqQEYBWJk6WbhNta
	4+NI++ajU0D/p0/O5g4xkv69dMDoxkxWTlQ5hOCbBV6r1gqYQnuk5DtdPU4L+1Lz/6dl4h/Ccxo
	WLJQMXSropHgPpw3eYNPXqZ64rh2EJejeY1wfTQk930lEykNpIgchbtYzukDKbaUVJ8DvhIRFb8
	OUuj1uuH586K5vDz5nBIvw6Wq0/Rq1nbFor633MUwBJBGeZaaA3tRdEGVLaOHJQ3V8zRFEsYhq5
	CA9RxAn6vEPlD6Jd9YTauX/s8alpCecYe7LLgepjhTF/LA69TQVnLBAem2BjophkjeYvM2utUTe
	9tNTgvJXk=
X-Received: by 2002:a17:902:d508:b0:2c9:cf62:6f61 with SMTP id d9443c01a7336-2cbb9e26373mr32759915ad.17.1783180959111;
        Sat, 04 Jul 2026 09:02:39 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad6f260c7sm24793625ad.12.2026.07.04.09.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 09:02:38 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com
Subject: [RFC PATCH v5] ntfs: serialize attribute-list replacement with lookups
Date: Sun,  5 Jul 2026 00:02:29 +0800
Message-Id: <20260704160229.1725504-1-zzzccc427@gmail.com>
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
 fs/ntfs/aops.c     |  55 +++-
 fs/ntfs/attrib.c   | 783 +++++++++++++++++++++++++++++++++++++++++++----------
 fs/ntfs/attrib.h   |  45 ++-
 fs/ntfs/attrlist.c |  93 +++++--
 fs/ntfs/attrlist.h |   1 +
 fs/ntfs/compress.c |   6 +-
 fs/ntfs/dir.c      |  76 +++++-
 fs/ntfs/dir.h      |   2 +
 fs/ntfs/ea.c       |   2 +-
 fs/ntfs/file.c     | 164 ++++++++---
 fs/ntfs/index.c    | 261 +++++++++++++++---
 fs/ntfs/index.h    |   3 +
 fs/ntfs/inode.c    | 417 ++++++++++++++++++++++------
 fs/ntfs/inode.h    |  17 ++
 fs/ntfs/iomap.c    | 154 +++++++++--
 fs/ntfs/iomap.h    |   3 +
 fs/ntfs/logfile.c  |   4 +
 fs/ntfs/mft.c      |  63 +++--
 fs/ntfs/namei.c    |  19 +-
 fs/ntfs/ntfs.h     |   1 +
 fs/ntfs/reparse.c  |  30 +-
 fs/ntfs/super.c    |  13 +-
 22 files changed, 1792 insertions(+), 420 deletions(-)

diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index 1fbf832ad1654..172f02b0430c9 100644
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -67,7 +67,7 @@ static const struct iomap_read_ops ntfs_iomap_bio_read_ops = {
  *
  * Return: 0 on success, or -errno on error.
  */
-static int ntfs_read_folio(struct file *file, struct folio *folio)
+static int __ntfs_read_folio(struct folio *folio, const struct iomap_ops *ops)
 {
 	struct ntfs_inode *ni = NTFS_I(folio->mapping->host);
 	struct iomap_read_folio_ctx ctx = {
@@ -97,10 +97,25 @@ static int ntfs_read_folio(struct file *file, struct folio *folio)
 			return ntfs_read_compressed_block(folio);
 	}
 
-	iomap_read_folio(&ntfs_read_iomap_ops, &ctx, NULL);
+	iomap_read_folio(ops, &ctx, NULL);
 	return 0;
 }
 
+static int ntfs_read_folio(struct file *file, struct folio *folio)
+{
+	return __ntfs_read_folio(folio, &ntfs_read_iomap_ops);
+}
+
+static int ntfs_read_folio_nested(struct file *file, struct folio *folio)
+{
+	return __ntfs_read_folio(folio, &ntfs_read_iomap_nested_ops);
+}
+
+int ntfs_read_folio_nolock(struct file *file, struct folio *folio)
+{
+	return __ntfs_read_folio(folio, &ntfs_read_iomap_nolock_ops);
+}
+
 /*
  * ntfs_bmap - map logical file block to physical device block
  * @mapping:	address space mapping to which the block to be mapped belongs
@@ -131,6 +146,7 @@ static sector_t ntfs_bmap(struct address_space *mapping, sector_t block)
 	s64 lcn;
 	unsigned long blocksize, flags;
 	struct ntfs_inode *ni = NTFS_I(mapping->host);
+	struct ntfs_inode *attr_lock_ni;
 	struct ntfs_volume *vol = ni->vol;
 	unsigned int delta;
 	unsigned char blocksize_bits;
@@ -160,10 +176,12 @@ static sector_t ntfs_bmap(struct address_space *mapping, sector_t block)
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
@@ -222,7 +240,8 @@ static sector_t ntfs_bmap(struct address_space *mapping, sector_t block)
 	return block;
 }
 
-static void ntfs_readahead(struct readahead_control *rac)
+static void __ntfs_readahead(struct readahead_control *rac,
+		const struct iomap_ops *ops)
 {
 	struct address_space *mapping = rac->mapping;
 	struct inode *inode = mapping->host;
@@ -238,7 +257,17 @@ static void ntfs_readahead(struct readahead_control *rac)
 	 */
 	if (!NInoNonResident(ni) || NInoCompressed(ni))
 		return;
-	iomap_readahead(&ntfs_read_iomap_ops, &ctx, NULL);
+	iomap_readahead(ops, &ctx, NULL);
+}
+
+static void ntfs_readahead(struct readahead_control *rac)
+{
+	__ntfs_readahead(rac, &ntfs_read_iomap_ops);
+}
+
+static void ntfs_readahead_nested(struct readahead_control *rac)
+{
+	__ntfs_readahead(rac, &ntfs_read_iomap_nested_ops);
 }
 
 static int ntfs_writepages(struct address_space *mapping,
@@ -291,9 +320,23 @@ const struct address_space_operations ntfs_aops = {
 	.swap_activate          = ntfs_swap_activate,
 };
 
+const struct address_space_operations ntfs_system_aops = {
+	.read_folio		= ntfs_read_folio_nested,
+	.readahead		= ntfs_readahead_nested,
+	.writepages		= ntfs_writepages,
+	.dirty_folio		= iomap_dirty_folio,
+	.bmap			= ntfs_bmap,
+	.migrate_folio		= filemap_migrate_folio,
+	.is_partially_uptodate	= iomap_is_partially_uptodate,
+	.error_remove_folio	= generic_error_remove_folio,
+	.release_folio		= iomap_release_folio,
+	.invalidate_folio	= iomap_invalidate_folio,
+	.swap_activate          = ntfs_swap_activate,
+};
+
 const struct address_space_operations ntfs_mft_aops = {
-	.read_folio		= ntfs_read_folio,
-	.readahead		= ntfs_readahead,
+	.read_folio		= ntfs_read_folio_nested,
+	.readahead		= ntfs_readahead_nested,
 	.writepages		= ntfs_mft_writepages,
 	.dirty_folio		= iomap_dirty_folio,
 	.bmap			= ntfs_bmap,
diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index dd88280985118..9d4993821d4f5 100644
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
@@ -1037,7 +1040,8 @@ int load_attribute_list(struct ntfs_inode *base_ni, u8 *al_start, const s64 size
 	if (!al_start || size <= 0)
 		return -EINVAL;
 
-	attr_vi = ntfs_attr_iget(VFS_I(base_ni), AT_ATTRIBUTE_LIST, AT_UNNAMED, 0);
+	attr_vi = ntfs_attr_iget_nolock(VFS_I(base_ni), AT_ATTRIBUTE_LIST,
+					AT_UNNAMED, 0);
 	if (IS_ERR(attr_vi)) {
 		ntfs_error(base_ni->vol->sb,
 			   "Failed to open an inode for Attribute list, mft = %llu",
@@ -1045,7 +1049,7 @@ int load_attribute_list(struct ntfs_inode *base_ni, u8 *al_start, const s64 size
 		return PTR_ERR(attr_vi);
 	}
 
-	if (ntfs_inode_attr_pread(attr_vi, 0, size, al_start) != size) {
+	if (ntfs_inode_attr_pread_nolock(attr_vi, 0, size, al_start) != size) {
 		iput(attr_vi);
 		ntfs_error(base_ni->vol->sb,
 			   "Failed to read attribute list, mft = %llu",
@@ -1579,6 +1583,86 @@ int ntfs_attr_lookup(const __le32 type, const __le16 *name,
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
+struct ntfs_inode *ntfs_attr_list_lock(struct ntfs_inode *ni,
+				       enum ntfs_attr_search_ctx_lock_mode lock_mode)
+{
+	struct ntfs_inode *lock_ni;
+
+	if (lock_mode == NTFS_ATTR_CTX_LOCK_NONE)
+		return NULL;
+
+	lock_ni = ntfs_attr_search_lock_inode(ni);
+	if (!lock_ni)
+		return NULL;
+
+	if (lock_mode == NTFS_ATTR_CTX_LOCK_WRITE)
+		down_write(&lock_ni->attr_list_lock);
+	else if (lock_mode == NTFS_ATTR_CTX_LOCK_WRITE_NESTED)
+		down_write_nested(&lock_ni->attr_list_lock, SINGLE_DEPTH_NESTING);
+	else if (lock_mode == NTFS_ATTR_CTX_LOCK_READ_NESTED)
+		down_read_nested(&lock_ni->attr_list_lock, SINGLE_DEPTH_NESTING);
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
+	if (lock_mode == NTFS_ATTR_CTX_LOCK_WRITE ||
+	    lock_mode == NTFS_ATTR_CTX_LOCK_WRITE_NESTED)
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
+	if (lock_mode == NTFS_ATTR_CTX_LOCK_NONE)
+		return;
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
@@ -1609,6 +1693,8 @@ static bool ntfs_attr_init_search_ctx(struct ntfs_attr_search_ctx *ctx,
 	ctx->base_mrec = NULL;
 	ctx->base_attr = NULL;
 	ctx->mapped_base_mrec = false;
+	ctx->attr_list_lock_ni = NULL;
+	ctx->attr_list_lock_mode = NTFS_ATTR_CTX_LOCK_NONE;
 	return true;
 }
 
@@ -1624,6 +1710,9 @@ static bool ntfs_attr_init_search_ctx(struct ntfs_attr_search_ctx *ctx,
  */
 void ntfs_attr_reinit_search_ctx(struct ntfs_attr_search_ctx *ctx)
 {
+	struct ntfs_inode *attr_list_lock_ni = ctx->attr_list_lock_ni;
+	enum ntfs_attr_search_ctx_lock_mode attr_list_lock_mode =
+		ctx->attr_list_lock_mode;
 	bool mapped_mrec;
 
 	if (likely(!ctx->base_ntfs_ino)) {
@@ -1645,6 +1734,8 @@ void ntfs_attr_reinit_search_ctx(struct ntfs_attr_search_ctx *ctx)
 	mapped_mrec = ctx->mapped_base_mrec;
 	ntfs_attr_init_search_ctx(ctx, ctx->base_ntfs_ino, ctx->base_mrec);
 	ctx->mapped_mrec = mapped_mrec;
+	ctx->attr_list_lock_ni = attr_list_lock_ni;
+	ctx->attr_list_lock_mode = attr_list_lock_mode;
 }
 
 /*
@@ -1656,7 +1747,8 @@ void ntfs_attr_reinit_search_ctx(struct ntfs_attr_search_ctx *ctx)
  * and return it. Return NULL if allocation failed.
  */
 struct ntfs_attr_search_ctx *ntfs_attr_get_search_ctx(struct ntfs_inode *ni,
-		struct mft_record *mrec)
+		struct mft_record *mrec,
+		enum ntfs_attr_search_ctx_lock_mode lock_mode)
 {
 	struct ntfs_attr_search_ctx *ctx;
 	bool init;
@@ -1667,6 +1759,8 @@ struct ntfs_attr_search_ctx *ntfs_attr_get_search_ctx(struct ntfs_inode *ni,
 		if (init == false) {
 			kmem_cache_free(ntfs_attr_ctx_cache, ctx);
 			ctx = NULL;
+		} else {
+			ntfs_attr_lock_search_ctx(ctx, ni, lock_mode);
 		}
 	}
 
@@ -1682,6 +1776,8 @@ struct ntfs_attr_search_ctx *ntfs_attr_get_search_ctx(struct ntfs_inode *ni,
  */
 void ntfs_attr_put_search_ctx(struct ntfs_attr_search_ctx *ctx)
 {
+	ntfs_attr_unlock_search_ctx(ctx);
+
 	if (ctx->mapped_mrec)
 		unmap_mft_record(ctx->ntfs_ino);
 
@@ -1905,7 +2001,8 @@ int ntfs_resident_attr_value_resize(struct mft_record *m, struct attr_record *a,
  * inode i_size is that this is not necessarily uptodate.  This happens when
  * ntfs_attr_make_non_resident() is called in the ->truncate call path(s).
  */
-int ntfs_attr_make_non_resident(struct ntfs_inode *ni, const u32 data_size)
+static int __ntfs_attr_make_non_resident(struct ntfs_inode *ni, u32 data_size,
+					 enum ntfs_attr_search_ctx_lock_mode lock_mode)
 {
 	s64 new_size;
 	struct inode *vi = VFS_I(ni);
@@ -1951,7 +2048,7 @@ int ntfs_attr_make_non_resident(struct ntfs_inode *ni, const u32 data_size)
 		ctx = NULL;
 		goto err_out;
 	}
-	ctx = ntfs_attr_get_search_ctx(base_ni, m);
+	ctx = ntfs_attr_get_search_ctx(base_ni, m, lock_mode);
 	if (unlikely(!ctx)) {
 		err = -ENOMEM;
 		goto err_out;
@@ -2225,6 +2322,12 @@ int ntfs_attr_make_non_resident(struct ntfs_inode *ni, const u32 data_size)
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
@@ -2290,7 +2393,7 @@ int ntfs_attr_set_initialized_size(struct ntfs_inode *ni, loff_t new_size)
 	if (!NInoNonResident(ni))
 		return -EINVAL;
 
-	ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	ctx = ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_READ);
 	if (!ctx)
 		return -ENOMEM;
 
@@ -2390,7 +2493,7 @@ int ntfs_resident_attr_record_add(struct ntfs_inode *ni, __le32 type,
 	}
 
 	/* Locate place where record should be. */
-	ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	ctx = ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_NONE);
 	if (!ctx) {
 		ntfs_error(ni->vol->sb, "%s: Failed to get search context",
 				__func__);
@@ -2512,7 +2615,7 @@ static int ntfs_non_resident_attr_record_add(struct ntfs_inode *ni, __le32 type,
 	}
 
 	/* Locate place where record should be. */
-	ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	ctx = ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_NONE);
 	if (!ctx) {
 		pr_err("%s: Failed to get search context\n", __func__);
 		return -ENOMEM;
@@ -2622,8 +2725,11 @@ static int ntfs_non_resident_attr_record_add(struct ntfs_inode *ni, __le32 type,
 int ntfs_attr_record_rm(struct ntfs_attr_search_ctx *ctx)
 {
 	struct ntfs_inode *base_ni, *ni;
+	u8 *old_al = NULL;
 	__le32 type;
 	int err;
+	struct ntfs_inode *lock_ni;
+	enum ntfs_attr_search_ctx_lock_mode lock_mode;
 
 	if (!ctx || !ctx->ntfs_ino || !ctx->mrec || !ctx->attr)
 		return -EINVAL;
@@ -2660,18 +2766,28 @@ int ntfs_attr_record_rm(struct ntfs_attr_search_ctx *ctx)
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
 	if (le32_to_cpu(ctx->mrec->bytes_in_use) -
 			le16_to_cpu(ctx->mrec->attrs_offset) == 8) {
+		lock_ni = ctx->attr_list_lock_ni;
+		lock_mode = ctx->attr_list_lock_mode;
+		if (lock_ni)
+			ntfs_attr_unlock_search_ctx(ctx);
 		if (ntfs_mft_record_free(ni->vol, ni)) {
+			if (lock_ni)
+				ntfs_attr_lock_search_ctx(ctx, base_ni, lock_mode);
 			ntfs_debug("Couldn't free MFT record.\n");
 			return -EIO;
 		}
+		if (lock_ni)
+			ntfs_attr_lock_search_ctx(ctx, base_ni, lock_mode);
 		/* Remove done if we freed base inode. */
 		if (ni == base_ni)
 			return 0;
@@ -2756,8 +2872,9 @@ int ntfs_attr_record_rm(struct ntfs_attr_search_ctx *ctx)
  *
  * On success return 0. On error return -1 with errno set to the error code.
  */
-int ntfs_attr_add(struct ntfs_inode *ni, __le32 type,
-		__le16 *name, u8 name_len, u8 *val, s64 size)
+static int __ntfs_attr_add(struct ntfs_inode *ni, __le32 type,
+		__le16 *name, u8 name_len, u8 *val, s64 size,
+		enum ntfs_attr_search_ctx_lock_mode lock_mode)
 {
 	struct super_block *sb;
 	u32 attr_rec_size;
@@ -2851,7 +2968,9 @@ int ntfs_attr_add(struct ntfs_inode *ni, __le32 type,
 	unmap_mft_record(ni);
 
 	/* Try to add to extent inodes. */
-	err = ntfs_inode_attach_all_extents(ni);
+	err = lock_mode == NTFS_ATTR_CTX_LOCK_NONE ?
+			ntfs_inode_attach_all_extents_nolock(ni) :
+			ntfs_inode_attach_all_extents(ni);
 	if (err) {
 		ntfs_error(sb, "Failed to attach all extents to inode");
 		goto err_out;
@@ -2877,7 +2996,9 @@ int ntfs_attr_add(struct ntfs_inode *ni, __le32 type,
 	/* There is no extent that contain enough space for new attribute. */
 	if (!NInoAttrList(ni)) {
 		/* Add attribute list not present, add it and retry. */
-		err = ntfs_inode_add_attrlist(ni);
+		err = lock_mode == NTFS_ATTR_CTX_LOCK_NONE ?
+				ntfs_inode_add_attrlist_nolock(ni) :
+				ntfs_inode_add_attrlist(ni);
 		if (err) {
 			ntfs_error(sb, "Failed to add attribute list");
 			goto err_out;
@@ -2924,7 +3045,9 @@ int ntfs_attr_add(struct ntfs_inode *ni, __le32 type,
 		return 0;
 
 	/* Open new attribute and resize it. */
-	attr_vi = ntfs_attr_iget(VFS_I(ni), type, name, name_len);
+	attr_vi = lock_mode == NTFS_ATTR_CTX_LOCK_NONE ?
+			ntfs_attr_iget_nolock(VFS_I(ni), type, name, name_len) :
+			ntfs_attr_iget(VFS_I(ni), type, name, name_len);
 	if (IS_ERR(attr_vi)) {
 		err = PTR_ERR(attr_vi);
 		ntfs_error(sb, "Failed to open just added attribute");
@@ -2933,8 +3056,12 @@ int ntfs_attr_add(struct ntfs_inode *ni, __le32 type,
 	attr_ni = NTFS_I(attr_vi);
 
 	/* Resize and set attribute value. */
-	if (ntfs_attr_truncate(attr_ni, size) ||
-		(val && (ntfs_inode_attr_pwrite(attr_vi, 0, size, val, false) != size))) {
+	if ((lock_mode == NTFS_ATTR_CTX_LOCK_NONE ?
+	     ntfs_attr_truncate_nolock(attr_ni, size) :
+	     ntfs_attr_truncate(attr_ni, size)) ||
+	    (val && ((lock_mode == NTFS_ATTR_CTX_LOCK_NONE ?
+		      ntfs_inode_attr_pwrite_nolock(attr_vi, 0, size, val, false) :
+		      ntfs_inode_attr_pwrite(attr_vi, 0, size, val, false)) != size))) {
 		err = -EIO;
 		ntfs_error(sb, "Failed to initialize just added attribute");
 		if (ntfs_attr_rm(attr_ni))
@@ -2978,6 +3105,20 @@ int ntfs_attr_add(struct ntfs_inode *ni, __le32 type,
 	return err;
 }
 
+int ntfs_attr_add_nolock(struct ntfs_inode *ni, __le32 type,
+		__le16 *name, u8 name_len, u8 *val, s64 size)
+{
+	return __ntfs_attr_add(ni, type, name, name_len, val, size,
+			NTFS_ATTR_CTX_LOCK_NONE);
+}
+
+int ntfs_attr_add(struct ntfs_inode *ni, __le32 type,
+		__le16 *name, u8 name_len, u8 *val, s64 size)
+{
+	return __ntfs_attr_add(ni, type, name, name_len, val, size,
+			NTFS_ATTR_CTX_LOCK_WRITE);
+}
+
 /*
  * __ntfs_attr_init - primary initialization of an ntfs attribute structure
  * @ni:		ntfs attribute inode to initialize
@@ -3087,7 +3228,7 @@ int ntfs_attr_open(struct ntfs_inode *ni, const __le32 type,
 		newname = name;
 	}
 
-	ctx = ntfs_attr_get_search_ctx(base_ni, NULL);
+	ctx = ntfs_attr_get_search_ctx(base_ni, NULL, NTFS_ATTR_CTX_LOCK_READ);
 	if (!ctx) {
 		err = -ENOMEM;
 		pr_err("%s: Failed to get search context\n", __func__);
@@ -3239,7 +3380,7 @@ void ntfs_attr_close(struct ntfs_inode *ni)
  * will map the runlist fragments from each of the extents thus giving access
  * to the entirety of the disk allocation of an attribute.
  */
-int ntfs_attr_map_whole_runlist(struct ntfs_inode *ni)
+int ntfs_attr_map_whole_runlist_nolock(struct ntfs_inode *ni)
 {
 	s64 next_vcn, last_vcn, highest_vcn;
 	struct ntfs_attr_search_ctx *ctx;
@@ -3262,7 +3403,7 @@ int ntfs_attr_map_whole_runlist(struct ntfs_inode *ni)
 	else
 		base_ni = ni;
 
-	ctx = ntfs_attr_get_search_ctx(base_ni, NULL);
+	ctx = ntfs_attr_get_search_ctx(base_ni, NULL, NTFS_ATTR_CTX_LOCK_NONE);
 	if (!ctx) {
 		ntfs_error(sb, "%s: Failed to get search context", __func__);
 		return -ENOMEM;
@@ -3354,6 +3495,18 @@ int ntfs_attr_map_whole_runlist(struct ntfs_inode *ni)
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
@@ -3388,7 +3541,7 @@ int ntfs_attr_record_move_to(struct ntfs_attr_search_ctx *ctx, struct ntfs_inode
 
 	/* Find place in MFT record where attribute will be moved. */
 	a = ctx->attr;
-	nctx = ntfs_attr_get_search_ctx(ni, NULL);
+	nctx = ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_NONE);
 	if (!nctx) {
 		ntfs_error(sb, "%s: Failed to get search context", __func__);
 		return -ENOMEM;
@@ -3455,6 +3608,8 @@ int ntfs_attr_record_move_away(struct ntfs_attr_search_ctx *ctx, int extra)
 	struct mft_record *m;
 	int i, err;
 	struct super_block *sb;
+	struct ntfs_inode *lock_ni;
+	enum ntfs_attr_search_ctx_lock_mode lock_mode;
 
 	if (!ctx || !ctx->attr || !ctx->ntfs_ino || extra < 0)
 		return -EINVAL;
@@ -3475,7 +3630,7 @@ int ntfs_attr_record_move_away(struct ntfs_attr_search_ctx *ctx, int extra)
 		return -EINVAL;
 	}
 
-	err = ntfs_inode_attach_all_extents(ctx->ntfs_ino);
+	err = ntfs_inode_attach_all_extents_nolock(ctx->ntfs_ino);
 	if (err) {
 		ntfs_error(sb, "Couldn't attach extents, inode=%llu",
 			(unsigned long long)base_ni->mft_no);
@@ -3520,7 +3675,13 @@ int ntfs_attr_record_move_away(struct ntfs_attr_search_ctx *ctx, int extra)
 	 * new extent and move attribute to it.
 	 */
 	ni = NULL;
+	lock_ni = ctx->attr_list_lock_ni;
+	lock_mode = ctx->attr_list_lock_mode;
+	if (lock_ni)
+		ntfs_attr_unlock_search_ctx(ctx);
 	err = ntfs_mft_record_alloc(base_ni->vol, 0, &ni, base_ni, NULL);
+	if (lock_ni)
+		ntfs_attr_lock_search_ctx(ctx, base_ni, lock_mode);
 	if (err) {
 		ntfs_error(sb, "Couldn't allocate MFT record, err : %d", err);
 		return err;
@@ -3539,7 +3700,9 @@ int ntfs_attr_record_move_away(struct ntfs_attr_search_ctx *ctx, int extra)
  * update allocated and compressed size.
  */
 static int ntfs_attr_update_meta(struct attr_record *a, struct ntfs_inode *ni,
-		struct mft_record *m, struct ntfs_attr_search_ctx *ctx)
+		struct mft_record *m, struct ntfs_attr_search_ctx *ctx,
+		struct ntfs_inode **attr_lock_ni,
+		struct runlist_element *rl)
 {
 	int sparse, err = 0;
 	struct ntfs_inode *base_ni;
@@ -3558,7 +3721,7 @@ static int ntfs_attr_update_meta(struct attr_record *a, struct ntfs_inode *ni,
 
 	a->data.non_resident.allocated_size = cpu_to_le64(ni->allocated_size);
 
-	sparse = ntfs_rl_sparse(ni->runlist.rl);
+	sparse = ntfs_rl_sparse(rl);
 	if (sparse < 0) {
 		err = -EIO;
 		goto out;
@@ -3574,21 +3737,42 @@ static int ntfs_attr_update_meta(struct attr_record *a, struct ntfs_inode *ni,
 		if ((le32_to_cpu(a->length) -
 		     le16_to_cpu(a->data.non_resident.mapping_pairs_offset) == 8) &&
 		    !(le32_to_cpu(m->bytes_allocated) - le32_to_cpu(m->bytes_in_use))) {
-
 			if (!NInoAttrList(base_ni)) {
-				err = ntfs_inode_add_attrlist(base_ni);
+				bool relock = attr_lock_ni && *attr_lock_ni;
+
+				if (relock) {
+					ntfs_attr_list_unlock(*attr_lock_ni,
+							NTFS_ATTR_CTX_LOCK_WRITE);
+					*attr_lock_ni = NULL;
+				}
+				err = ntfs_inode_add_attrlist_nolock(base_ni);
+				if (relock)
+					*attr_lock_ni = ntfs_attr_list_lock(ni,
+							NTFS_ATTR_CTX_LOCK_WRITE);
 				if (err)
 					goto out;
 				err = -EAGAIN;
 				goto out;
 			}
+			if (attr_lock_ni && *attr_lock_ni) {
+				ctx->attr_list_lock_ni = *attr_lock_ni;
+				ctx->attr_list_lock_mode =
+					NTFS_ATTR_CTX_LOCK_WRITE;
+				*attr_lock_ni = NULL;
+			}
 			err = ntfs_attr_record_move_away(ctx, 8);
+			if (attr_lock_ni && ctx->attr_list_lock_ni) {
+				*attr_lock_ni = ctx->attr_list_lock_ni;
+				ctx->attr_list_lock_ni = NULL;
+				ctx->attr_list_lock_mode =
+					NTFS_ATTR_CTX_LOCK_NONE;
+			}
 			if (err) {
 				ntfs_error(sb, "Failed to move attribute");
 				goto out;
 			}
 
-			err = ntfs_attrlist_update(base_ni);
+			err = ntfs_attrlist_update_nolock(base_ni);
 			if (err)
 				goto out;
 			err = -EAGAIN;
@@ -3639,7 +3823,7 @@ static int ntfs_attr_update_meta(struct attr_record *a, struct ntfs_inode *ni,
 	if (NInoFullyMapped(ni) && (sparse || NInoCompressed(ni))) {
 		s64 new_compr_size;
 
-		new_compr_size = ntfs_rl_get_compressed_size(ni->vol, ni->runlist.rl);
+		new_compr_size = ntfs_rl_get_compressed_size(ni->vol, rl);
 		if (new_compr_size < 0) {
 			err = new_compr_size;
 			goto out;
@@ -3664,6 +3848,33 @@ static int ntfs_attr_update_meta(struct attr_record *a, struct ntfs_inode *ni,
 }
 
 #define NTFS_VCN_DELETE_MARK -2
+
+static struct runlist_element *ntfs_attr_runlist_snapshot(struct ntfs_inode *ni,
+		bool runlist_locked)
+{
+	struct runlist_element *rl;
+	size_t count;
+
+	if (!runlist_locked)
+		down_read(&ni->runlist.lock);
+	rl = ni->runlist.rl;
+	count = ni->runlist.count;
+	if (rl && count) {
+		struct runlist_element *snapshot;
+
+		snapshot = kvcalloc(count, sizeof(*snapshot), GFP_NOFS);
+		if (snapshot)
+			memcpy(snapshot, rl, count * sizeof(*snapshot));
+		if (!runlist_locked)
+			up_read(&ni->runlist.lock);
+		return snapshot ?: ERR_PTR(-ENOMEM);
+	}
+	if (!runlist_locked)
+		up_read(&ni->runlist.lock);
+
+	return ERR_PTR(-EINVAL);
+}
+
 /*
  * ntfs_attr_update_mapping_pairs - update mapping pairs for ntfs attribute
  * @ni:		non-resident ntfs inode for which we need update
@@ -3677,7 +3888,8 @@ static int ntfs_attr_update_meta(struct attr_record *a, struct ntfs_inode *ni,
  * call to this function. Vice-versa @na->compressed_size will be calculated and
  * set to correct value during this function.
  */
-int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
+static int __ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn,
+		struct ntfs_inode **attr_lock_ni, bool runlist_locked)
 {
 	struct ntfs_attr_search_ctx *ctx;
 	struct ntfs_inode *base_ni;
@@ -3689,6 +3901,7 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
 	bool first_updated = false;
 	struct super_block *sb;
 	struct runlist_element *start_rl;
+	struct runlist_element *rl_snapshot = NULL;
 	unsigned int de_cluster_count = 0;
 
 retry:
@@ -3709,16 +3922,24 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
 	else
 		base_ni = ni;
 
-	ctx = ntfs_attr_get_search_ctx(base_ni, NULL);
+	rl_snapshot = ntfs_attr_runlist_snapshot(ni, runlist_locked);
+	if (IS_ERR(rl_snapshot)) {
+		err = PTR_ERR(rl_snapshot);
+		rl_snapshot = NULL;
+		return err;
+	}
+
+	ctx = ntfs_attr_get_search_ctx(base_ni, NULL, NTFS_ATTR_CTX_LOCK_NONE);
 	if (!ctx) {
 		ntfs_error(sb, "%s: Failed to get search context", __func__);
+		kvfree(rl_snapshot);
 		return -ENOMEM;
 	}
 
 	/* Fill attribute records with new mapping pairs. */
 	stop_vcn = 0;
 	finished_build = false;
-	start_rl = ni->runlist.rl;
+	start_rl = rl_snapshot;
 	while (!(err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
 				CASE_SENSITIVE, from_vcn, NULL, 0, ctx))) {
 		unsigned int de_cnt = 0;
@@ -3744,7 +3965,7 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
 			 * the last run in runlist, if so, then deallocate
 			 * all attrubute extents starting this one.
 			 */
-			first_lcn = ntfs_rl_vcn_to_lcn(ni->runlist.rl, stop_vcn);
+			first_lcn = ntfs_rl_vcn_to_lcn(rl_snapshot, stop_vcn);
 			if (first_lcn == LCN_EINVAL) {
 				err = -EIO;
 				ntfs_error(sb, "Bad runlist");
@@ -3769,10 +3990,13 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
 			continue;
 		}
 
-		err = ntfs_attr_update_meta(a, ni, m, ctx);
+		err = ntfs_attr_update_meta(a, ni, m, ctx, attr_lock_ni,
+				rl_snapshot);
 		if (err < 0) {
 			if (err == -EAGAIN) {
 				ntfs_attr_put_search_ctx(ctx);
+				kvfree(rl_snapshot);
+				rl_snapshot = NULL;
 				goto retry;
 			}
 			goto put_err_out;
@@ -3808,24 +4032,61 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
 			 * attributes and try again.
 			 */
 			if (ni->type == AT_ATTRIBUTE_LIST) {
+				bool relock = attr_lock_ni && *attr_lock_ni;
+
 				ntfs_attr_put_search_ctx(ctx);
-				if (ntfs_inode_free_space(base_ni, mp_size -
+				if (relock) {
+					ntfs_attr_list_unlock(*attr_lock_ni,
+							NTFS_ATTR_CTX_LOCK_WRITE);
+					*attr_lock_ni = NULL;
+				}
+				if (ntfs_inode_free_space_nolock(base_ni, mp_size -
 							cur_max_mp_size)) {
+					if (relock)
+						*attr_lock_ni = ntfs_attr_list_lock(ni,
+								NTFS_ATTR_CTX_LOCK_WRITE);
 					ntfs_debug("Attribute list is too big. Defragment the volume\n");
+					kvfree(rl_snapshot);
 					return -ENOSPC;
 				}
-				if (ntfs_attrlist_update(base_ni))
+				if (ntfs_attrlist_update_nolock(base_ni)) {
+					if (relock)
+						*attr_lock_ni = ntfs_attr_list_lock(ni,
+								NTFS_ATTR_CTX_LOCK_WRITE);
+					kvfree(rl_snapshot);
 					return -EIO;
+				}
+				if (relock)
+					*attr_lock_ni = ntfs_attr_list_lock(ni,
+							NTFS_ATTR_CTX_LOCK_WRITE);
+				kvfree(rl_snapshot);
+				rl_snapshot = NULL;
 				goto retry;
 			}
 
 			/* Add attribute list if it isn't present, and retry. */
 			if (!NInoAttrList(base_ni)) {
+				bool relock = attr_lock_ni && *attr_lock_ni;
+
 				ntfs_attr_put_search_ctx(ctx);
-				if (ntfs_inode_add_attrlist(base_ni)) {
+				if (relock) {
+					ntfs_attr_list_unlock(*attr_lock_ni,
+							NTFS_ATTR_CTX_LOCK_WRITE);
+					*attr_lock_ni = NULL;
+				}
+				if (ntfs_inode_add_attrlist_nolock(base_ni)) {
+					if (relock)
+						*attr_lock_ni = ntfs_attr_list_lock(ni,
+								NTFS_ATTR_CTX_LOCK_WRITE);
 					ntfs_error(sb, "Can not add attrlist");
+					kvfree(rl_snapshot);
 					return -EIO;
 				}
+				if (relock)
+					*attr_lock_ni = ntfs_attr_list_lock(ni,
+							NTFS_ATTR_CTX_LOCK_WRITE);
+				kvfree(rl_snapshot);
+				rl_snapshot = NULL;
 				goto retry;
 			}
 
@@ -3854,7 +4115,7 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
 		if ((ctx->ntfs_ino->nr_extents == -1 || NInoAttrList(ctx->ntfs_ino)) &&
 		    ctx->attr->type != AT_ATTRIBUTE_LIST) {
 			ctx->al_entry->lowest_vcn = cpu_to_le64(stop_vcn);
-			err = ntfs_attrlist_update(base_ni);
+			err = ntfs_attrlist_update_nolock(base_ni);
 			if (err)
 				goto put_err_out;
 		}
@@ -3913,11 +4174,26 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
 		ntfs_debug("Deallocate marked extents.\n");
 		while (!(err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
 				CASE_SENSITIVE, 0, NULL, 0, ctx))) {
+			struct ntfs_inode *lock_ni = NULL;
+
 			if (le64_to_cpu(ctx->attr->data.non_resident.highest_vcn) !=
 					NTFS_VCN_DELETE_MARK)
 				continue;
+			if (attr_lock_ni && *attr_lock_ni) {
+				lock_ni = *attr_lock_ni;
+				ctx->attr_list_lock_ni = lock_ni;
+				ctx->attr_list_lock_mode =
+					NTFS_ATTR_CTX_LOCK_WRITE;
+				*attr_lock_ni = NULL;
+			}
 			/* Remove unused attribute record. */
 			err = ntfs_attr_record_rm(ctx);
+			if (lock_ni) {
+				*attr_lock_ni = ctx->attr_list_lock_ni;
+				ctx->attr_list_lock_ni = NULL;
+				ctx->attr_list_lock_mode =
+					NTFS_ATTR_CTX_LOCK_NONE;
+			}
 			if (err) {
 				ntfs_error(sb, "Could not remove unused attr");
 				goto put_err_out;
@@ -3936,6 +4212,11 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
 	ctx = NULL;
 
 	/* Allocate new MFT records for the rest of mapping pairs. */
+	if (attr_lock_ni && *attr_lock_ni) {
+		ntfs_attr_list_unlock(*attr_lock_ni,
+				NTFS_ATTR_CTX_LOCK_WRITE);
+		*attr_lock_ni = NULL;
+	}
 	while (1) {
 		struct ntfs_inode *ext_ni = NULL;
 		unsigned int de_cnt = 0;
@@ -4018,14 +4299,47 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
 out:
 	if (from_vcn == 0)
 		ni->i_dealloc_clusters = de_cluster_count;
+	kvfree(rl_snapshot);
 	return 0;
 
 put_err_out:
 	if (ctx)
 		ntfs_attr_put_search_ctx(ctx);
+	kvfree(rl_snapshot);
 	return err;
 }
 
+int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn)
+{
+	struct ntfs_inode *attr_lock_ni;
+	int err;
+
+	attr_lock_ni = ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LOCK_WRITE);
+	err = __ntfs_attr_update_mapping_pairs(ni, from_vcn, &attr_lock_ni,
+			false);
+	if (attr_lock_ni)
+		ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
+
+	return err;
+}
+
+int ntfs_attr_update_mapping_pairs_locked(struct ntfs_inode *ni, s64 from_vcn,
+		struct ntfs_inode **attr_lock_ni)
+{
+	return __ntfs_attr_update_mapping_pairs(ni, from_vcn, attr_lock_ni,
+			false);
+}
+
+int ntfs_attr_update_mapping_pairs_runlist_locked(struct ntfs_inode *ni, s64 from_vcn)
+{
+	return __ntfs_attr_update_mapping_pairs(ni, from_vcn, NULL, true);
+}
+
+int ntfs_attr_update_mapping_pairs_nolock(struct ntfs_inode *ni, s64 from_vcn)
+{
+	return __ntfs_attr_update_mapping_pairs(ni, from_vcn, NULL, false);
+}
+
 /*
  * ntfs_attr_make_resident - convert a non-resident to a resident attribute
  * @ni:		open ntfs attribute to make resident
@@ -4083,7 +4397,7 @@ static int ntfs_attr_make_resident(struct ntfs_inode *ni, struct ntfs_attr_searc
 	}
 
 	/* Read and cache the whole runlist if not already done. */
-	err = ntfs_attr_map_whole_runlist(ni);
+	err = ntfs_attr_map_whole_runlist_nolock(ni);
 	if (err)
 		return err;
 
@@ -4159,7 +4473,8 @@ static int ntfs_attr_make_resident(struct ntfs_inode *ni, struct ntfs_attr_searc
  *
  * Reduce the size of a non-resident, open ntfs attribute @na to @newsize bytes.
  */
-static int ntfs_non_resident_attr_shrink(struct ntfs_inode *ni, const s64 newsize)
+static int ntfs_non_resident_attr_shrink(struct ntfs_inode *ni,
+		const s64 newsize, bool need_lock)
 {
 	struct ntfs_volume *vol;
 	struct ntfs_attr_search_ctx *ctx;
@@ -4214,13 +4529,16 @@ static int ntfs_non_resident_attr_shrink(struct ntfs_inode *ni, const s64 newsiz
 	if (ntfs_bytes_to_cluster(vol, ni->allocated_size) != first_free_vcn) {
 		struct ntfs_attr_search_ctx *ctx;
 
-		err = ntfs_attr_map_whole_runlist(ni);
+		err = need_lock ? ntfs_attr_map_whole_runlist(ni) :
+				ntfs_attr_map_whole_runlist_nolock(ni);
 		if (err) {
 			ntfs_debug("Eeek! ntfs_attr_map_whole_runlist failed.\n");
 			return err;
 		}
 
-		ctx = ntfs_attr_get_search_ctx(ni, NULL);
+		ctx = ntfs_attr_get_search_ctx(ni, NULL,
+				need_lock ? NTFS_ATTR_CTX_LOCK_READ :
+					    NTFS_ATTR_CTX_LOCK_NONE);
 		if (!ctx) {
 			ntfs_error(vol->sb, "%s: Failed to get search context", __func__);
 			return -ENOMEM;
@@ -4260,7 +4578,9 @@ static int ntfs_non_resident_attr_shrink(struct ntfs_inode *ni, const s64 newsiz
 			VFS_I(base_ni)->i_blocks = ni->allocated_size >> 9;
 
 		/* Write mapping pairs for new runlist. */
-		err = ntfs_attr_update_mapping_pairs(ni, 0 /*first_free_vcn*/);
+		err = need_lock ? ntfs_attr_update_mapping_pairs(ni, 0 /*first_free_vcn*/) :
+				ntfs_attr_update_mapping_pairs_runlist_locked(ni,
+						0 /*first_free_vcn*/);
 		if (err) {
 			ntfs_debug("Eeek! Mapping pairs update failed. Leaving inconstant metadata. Run chkdsk.\n");
 			return err;
@@ -4268,7 +4588,9 @@ static int ntfs_non_resident_attr_shrink(struct ntfs_inode *ni, const s64 newsiz
 	}
 
 	/* Get the first attribute record. */
-	ctx = ntfs_attr_get_search_ctx(base_ni, NULL);
+	ctx = ntfs_attr_get_search_ctx(base_ni, NULL,
+			need_lock ? NTFS_ATTR_CTX_LOCK_READ :
+				    NTFS_ATTR_CTX_LOCK_NONE);
 	if (!ctx) {
 		ntfs_error(vol->sb, "%s: Failed to get search context", __func__);
 		return -ENOMEM;
@@ -4380,7 +4702,8 @@ static int ntfs_non_resident_attr_expand(struct ntfs_inode *ni, const s64 newsiz
 	 * clusters if there is a change.
 	 */
 	if (ntfs_bytes_to_cluster(vol, ni->allocated_size) < first_free_vcn) {
-		err = ntfs_attr_map_whole_runlist(ni);
+		err = need_lock ? ntfs_attr_map_whole_runlist(ni) :
+				ntfs_attr_map_whole_runlist_nolock(ni);
 		if (err) {
 			ntfs_error(sb, "ntfs_attr_map_whole_runlist failed");
 			return err;
@@ -4499,14 +4822,17 @@ static int ntfs_non_resident_attr_expand(struct ntfs_inode *ni, const s64 newsiz
 
 		/* Prepare to mapping pairs update. */
 		ni->allocated_size = ntfs_cluster_to_bytes(vol, first_free_vcn);
-		err = ntfs_attr_update_mapping_pairs(ni, 0);
+		err = need_lock ? ntfs_attr_update_mapping_pairs(ni, 0) :
+				ntfs_attr_update_mapping_pairs_runlist_locked(ni, 0);
 		if (err) {
 			ntfs_debug("Mapping pairs update failed");
 			goto rollback;
 		}
 	}
 
-	ctx = ntfs_attr_get_search_ctx(base_ni, NULL);
+	ctx = ntfs_attr_get_search_ctx(base_ni, NULL,
+			need_lock ? NTFS_ATTR_CTX_LOCK_READ :
+				    NTFS_ATTR_CTX_LOCK_NONE);
 	if (!ctx) {
 		err = -ENOMEM;
 		if (ni->allocated_size == org_alloc_size)
@@ -4557,22 +4883,29 @@ static int ntfs_non_resident_attr_expand(struct ntfs_inode *ni, const s64 newsiz
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
+				if (ntfs_attr_update_mapping_pairs_locked(ni, 0,
+						&attr_lock_ni))
+					ntfs_error(sb, "Failed to restore old mapping pairs");
+				if (attr_lock_ni)
+					ntfs_attr_list_unlock(attr_lock_ni,
+							NTFS_ATTR_CTX_LOCK_WRITE);
+			} else if (ntfs_attr_update_mapping_pairs_runlist_locked(ni, 0)) {
+				ntfs_error(sb, "Failed to restore old mapping pairs");
+			}
 
-		if (NInoSparse(ni) || NInoCompressed(ni)) {
-			ni->itype.compressed.size =  org_compressed_size;
-			VFS_I(base_ni)->i_blocks = ni->itype.compressed.size >> 9;
-		} else
-			VFS_I(base_ni)->i_blocks = ni->allocated_size >> 9;
+			if (NInoSparse(ni) || NInoCompressed(ni)) {
+				ni->itype.compressed.size =  org_compressed_size;
+				VFS_I(base_ni)->i_blocks = ni->itype.compressed.size >> 9;
+			} else
+				VFS_I(base_ni)->i_blocks = ni->allocated_size >> 9;
 	}
 	if (ctx)
 		ntfs_attr_put_search_ctx(ctx);
@@ -4593,13 +4926,15 @@ static int ntfs_non_resident_attr_expand(struct ntfs_inode *ni, const s64 newsiz
  * Change the size of a resident, open ntfs attribute @na to @newsize bytes.
  */
 static int ntfs_resident_attr_resize(struct ntfs_inode *attr_ni, const s64 newsize,
-		const s64 prealloc_size, unsigned int holes)
+		const s64 prealloc_size, unsigned int holes,
+		enum ntfs_attr_search_ctx_lock_mode lock_mode)
 {
 	struct ntfs_attr_search_ctx *ctx;
 	struct ntfs_volume *vol = attr_ni->vol;
 	struct super_block *sb = vol->sb;
 	int err = -EIO;
 	struct ntfs_inode *base_ni, *ext_ni = NULL;
+	u32 resident_value_len;
 
 attr_resize_again:
 	ntfs_debug("Inode 0x%llx attr 0x%x new size %lld\n",
@@ -4612,7 +4947,7 @@ static int ntfs_resident_attr_resize(struct ntfs_inode *attr_ni, const s64 newsi
 		base_ni = attr_ni;
 
 	/* Get the attribute record that needs modification. */
-	ctx = ntfs_attr_get_search_ctx(base_ni, NULL);
+	ctx = ntfs_attr_get_search_ctx(base_ni, NULL, lock_mode);
 	if (!ctx) {
 		ntfs_error(sb, "%s: Failed to get search context", __func__);
 		return -ENOMEM;
@@ -4664,13 +4999,16 @@ static int ntfs_resident_attr_resize(struct ntfs_inode *attr_ni, const s64 newsi
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
 		/* Resize non-resident attribute */
-		return ntfs_non_resident_attr_expand(attr_ni, newsize, prealloc_size, holes, true);
+		return ntfs_non_resident_attr_expand(attr_ni, newsize,
+				prealloc_size, holes,
+				lock_mode != NTFS_ATTR_CTX_LOCK_NONE);
 	} else if (err != -ENOSPC && err != -EPERM) {
 		ntfs_error(sb, "Failed to make attribute non-resident");
 		goto put_err_out;
@@ -4692,8 +5030,8 @@ static int ntfs_resident_attr_resize(struct ntfs_inode *attr_ni, const s64 newsi
 			continue;
 
 		/*
-		 * Check out whether convert is reasonable. Assume that mapping
-		 * pairs will take 8 bytes.
+		 * Check out whether convert is reasonable. Assume that
+		 * mapping pairs will take 8 bytes.
 		 */
 		if (le32_to_cpu(a->length) <= (sizeof(struct attr_record) - sizeof(s64)) +
 				((a->name_length * sizeof(__le16) + 7) & ~7) + 8)
@@ -4701,18 +5039,29 @@ static int ntfs_resident_attr_resize(struct ntfs_inode *attr_ni, const s64 newsi
 		if (a->type == AT_DATA && !value_len)
 			continue;
 
-		if (a->type == AT_DATA)
-			tvi = ntfs_iget(sb, base_ni->mft_no);
-		else
+		if (a->type == AT_DATA) {
+			tvi = igrab(VFS_I(base_ni));
+			if (!tvi) {
+				ntfs_error(sb, "Couldn't open attribute");
+				continue;
+			}
+		} else if (lock_mode == NTFS_ATTR_CTX_LOCK_NONE ||
+			   ctx->attr_list_lock_ni) {
+			tvi = ntfs_attr_iget_nolock(VFS_I(base_ni), a->type,
+				(__le16 *)((u8 *)a + le16_to_cpu(a->name_offset)),
+				a->name_length);
+		} else {
 			tvi = ntfs_attr_iget(VFS_I(base_ni), a->type,
 				(__le16 *)((u8 *)a + le16_to_cpu(a->name_offset)),
 				a->name_length);
+		}
 		if (IS_ERR(tvi)) {
 			ntfs_error(sb, "Couldn't open attribute");
 			continue;
 		}
 
-		if (ntfs_attr_make_non_resident(NTFS_I(tvi), value_len)) {
+		if (__ntfs_attr_make_non_resident(NTFS_I(tvi), value_len,
+						  NTFS_ATTR_CTX_LOCK_NONE)) {
 			iput(tvi);
 			continue;
 		}
@@ -4738,19 +5087,30 @@ static int ntfs_resident_attr_resize(struct ntfs_inode *attr_ni, const s64 newsi
 		ntfs_attr_put_search_ctx(ctx);
 
 		if (!NInoAttrList(base_ni)) {
-			err = ntfs_inode_add_attrlist(base_ni);
+			if (lock_mode == NTFS_ATTR_CTX_LOCK_NONE)
+				err = ntfs_inode_add_attrlist_nolock(base_ni);
+			else
+				err = ntfs_inode_add_attrlist(base_ni);
 			if (err)
 				return err;
 		}
 
-		err = ntfs_inode_free_space(base_ni, sizeof(struct attr_record));
+		if (lock_mode == NTFS_ATTR_CTX_LOCK_NONE)
+			err = ntfs_inode_free_space_nolock(base_ni,
+					sizeof(struct attr_record));
+		else
+			err = ntfs_inode_free_space(base_ni,
+					sizeof(struct attr_record));
 		if (err) {
 			err = -ENOSPC;
 			ntfs_error(sb,
 				"Couldn't free space in the MFT record to make attribute list non resident");
 			return err;
 		}
-		err = ntfs_attrlist_update(base_ni);
+		if (lock_mode == NTFS_ATTR_CTX_LOCK_NONE)
+			err = ntfs_attrlist_update_nolock(base_ni);
+		else
+			err = ntfs_attrlist_update(base_ni);
 		if (err)
 			return err;
 		goto attr_resize_again;
@@ -4784,7 +5144,10 @@ static int ntfs_resident_attr_resize(struct ntfs_inode *attr_ni, const s64 newsi
 	/* Add attribute list if not present. */
 	if (!NInoAttrList(base_ni)) {
 		ntfs_attr_put_search_ctx(ctx);
-		err = ntfs_inode_add_attrlist(base_ni);
+		if (lock_mode == NTFS_ATTR_CTX_LOCK_NONE)
+			err = ntfs_inode_add_attrlist_nolock(base_ni);
+		else
+			err = ntfs_inode_add_attrlist(base_ni);
 		if (err)
 			return err;
 		goto attr_resize_again;
@@ -4806,7 +5169,10 @@ static int ntfs_resident_attr_resize(struct ntfs_inode *attr_ni, const s64 newsi
 		goto put_err_out;
 	}
 
-	err = ntfs_attrlist_update(base_ni);
+	if (lock_mode == NTFS_ATTR_CTX_LOCK_NONE)
+		err = ntfs_attrlist_update_nolock(base_ni);
+	else
+		err = ntfs_attrlist_update(base_ni);
 	if (err < 0)
 		goto put_err_out;
 
@@ -4843,19 +5209,18 @@ int __ntfs_attr_truncate_vfs(struct ntfs_inode *ni, const s64 newsize,
 			(unsigned long long)ni->mft_no, ni->type, newsize);
 
 	if (NInoNonResident(ni)) {
-		if (newsize > i_size) {
-			down_write(&ni->runlist.lock);
+		if (newsize > i_size)
 			err = ntfs_non_resident_attr_expand(ni, newsize, 0,
 							    NVolDisableSparse(ni->vol) ?
 							    HOLES_NO : HOLES_OK,
-							    false);
-			up_write(&ni->runlist.lock);
-		} else
-			err = ntfs_non_resident_attr_shrink(ni, newsize);
+							    true);
+		else
+			err = ntfs_non_resident_attr_shrink(ni, newsize, true);
 	} else
 		err = ntfs_resident_attr_resize(ni, newsize, 0,
 						NVolDisableSparse(ni->vol) ?
-						HOLES_NO : HOLES_OK);
+						HOLES_NO : HOLES_OK,
+						NTFS_ATTR_CTX_LOCK_READ);
 	ntfs_debug("Return status %d\n", err);
 	return err;
 }
@@ -4895,7 +5260,8 @@ int ntfs_attr_expand(struct ntfs_inode *ni, const s64 newsize, const s64 preallo
 	} else
 		err = ntfs_resident_attr_resize(ni, newsize, prealloc_size,
 						NVolDisableSparse(ni->vol) ?
-						HOLES_NO : HOLES_OK);
+						HOLES_NO : HOLES_OK,
+						NTFS_ATTR_CTX_LOCK_READ);
 	if (!err)
 		i_size_write(VFS_I(ni), newsize);
 	ntfs_debug("Return status %d\n", err);
@@ -4914,7 +5280,8 @@ int ntfs_attr_expand(struct ntfs_inode *ni, const s64 newsize, const s64 preallo
  * newly allocated space is marked as not initialised and no real allocation
  * on disk is performed.
  */
-int ntfs_attr_truncate_i(struct ntfs_inode *ni, const s64 newsize, unsigned int holes)
+static int __ntfs_attr_truncate_i(struct ntfs_inode *ni, const s64 newsize,
+		unsigned int holes, enum ntfs_attr_search_ctx_lock_mode lock_mode)
 {
 	int err;
 
@@ -4948,18 +5315,41 @@ int ntfs_attr_truncate_i(struct ntfs_inode *ni, const s64 newsize, unsigned int
 
 	if (NInoNonResident(ni)) {
 		if (newsize > ni->data_size)
-			err = ntfs_non_resident_attr_expand(ni, newsize, 0, holes, true);
+			err = ntfs_non_resident_attr_expand(ni, newsize, 0,
+					holes, lock_mode != NTFS_ATTR_CTX_LOCK_NONE);
 		else
-			err = ntfs_non_resident_attr_shrink(ni, newsize);
+			err = ntfs_non_resident_attr_shrink(ni, newsize,
+					lock_mode != NTFS_ATTR_CTX_LOCK_NONE);
 	} else
-		err = ntfs_resident_attr_resize(ni, newsize, 0, holes);
+		err = ntfs_resident_attr_resize(ni, newsize, 0, holes,
+						lock_mode);
 	ntfs_debug("Return status %d\n", err);
 	return err;
 }
 
+int ntfs_attr_truncate_i_nolock(struct ntfs_inode *ni, const s64 newsize,
+		unsigned int holes)
+{
+	return __ntfs_attr_truncate_i(ni, newsize, holes,
+			NTFS_ATTR_CTX_LOCK_NONE);
+}
+
+int ntfs_attr_truncate_i(struct ntfs_inode *ni, const s64 newsize, unsigned int holes)
+{
+	return __ntfs_attr_truncate_i(ni, newsize, holes,
+			NTFS_ATTR_CTX_LOCK_READ);
+}
+
 /*
  * Resize an attribute, creating a hole if relevant
  */
+int ntfs_attr_truncate_nolock(struct ntfs_inode *ni, const s64 newsize)
+{
+	return ntfs_attr_truncate_i_nolock(ni, newsize,
+					   NVolDisableSparse(ni->vol) ?
+					   HOLES_NO : HOLES_OK);
+}
+
 int ntfs_attr_truncate(struct ntfs_inode *ni, const s64 newsize)
 {
 	return ntfs_attr_truncate_i(ni, newsize,
@@ -4969,7 +5359,7 @@ int ntfs_attr_truncate(struct ntfs_inode *ni, const s64 newsize)
 
 int ntfs_attr_map_cluster(struct ntfs_inode *ni, s64 vcn_start, s64 *lcn_start,
 		s64 *lcn_count, s64 max_clu_count, bool *balloc, bool update_mp,
-		bool skip_holes)
+		bool skip_holes, bool defer_update_mp)
 {
 	struct ntfs_volume *vol = ni->vol;
 	struct ntfs_attr_search_ctx *ctx;
@@ -4979,14 +5369,17 @@ int ntfs_attr_map_cluster(struct ntfs_inode *ni, s64 vcn_start, s64 *lcn_start,
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
@@ -5083,7 +5476,7 @@ int ntfs_attr_map_cluster(struct ntfs_inode *ni, s64 vcn_start, s64 *lcn_start,
 	ni->runlist.rl = rl;
 	ni->runlist.count = new_rl_count;
 
-	if (!update_mp) {
+	if (!update_mp && !defer_update_mp) {
 		u64 free = atomic64_read(&vol->free_clusters) * 100;
 
 		do_div(free, vol->nr_clusters);
@@ -5093,7 +5486,7 @@ int ntfs_attr_map_cluster(struct ntfs_inode *ni, s64 vcn_start, s64 *lcn_start,
 
 	if (update_mp) {
 		ntfs_attr_reinit_search_ctx(ctx);
-		err = ntfs_attr_update_mapping_pairs(ni, 0);
+		err = ntfs_attr_update_mapping_pairs_runlist_locked(ni, 0);
 		if (err) {
 			int err2;
 
@@ -5146,7 +5539,7 @@ int ntfs_attr_rm(struct ntfs_inode *ni)
 		err = ntfs_attr_map_whole_runlist(ni);
 		if (err)
 			return err;
-		ctx = ntfs_attr_get_search_ctx(ni, NULL);
+		ctx = ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_READ);
 		if (!ctx) {
 			ntfs_error(sb, "%s: Failed to get search context", __func__);
 			return -ENOMEM;
@@ -5160,7 +5553,7 @@ int ntfs_attr_rm(struct ntfs_inode *ni)
 	}
 
 	/* Search for attribute extents and remove them all. */
-	ctx = ntfs_attr_get_search_ctx(base_ni, NULL);
+	ctx = ntfs_attr_get_search_ctx(base_ni, NULL, NTFS_ATTR_CTX_LOCK_WRITE);
 	if (!ctx) {
 		ntfs_error(sb, "%s: Failed to get search context", __func__);
 		return -ENOMEM;
@@ -5184,15 +5577,16 @@ int ntfs_attr_rm(struct ntfs_inode *ni)
 	return ret;
 }
 
-int ntfs_attr_exist(struct ntfs_inode *ni, const __le32 type, __le16 *name,
-		u32 name_len)
+static int __ntfs_attr_exist(struct ntfs_inode *ni, const __le32 type,
+		__le16 *name, u32 name_len,
+		enum ntfs_attr_search_ctx_lock_mode lock_mode)
 {
 	struct ntfs_attr_search_ctx *ctx;
 	int ret;
 
 	ntfs_debug("Entering\n");
 
-	ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	ctx = ntfs_attr_get_search_ctx(ni, NULL, lock_mode);
 	if (!ctx) {
 		ntfs_error(ni->vol->sb, "%s: Failed to get search context",
 				__func__);
@@ -5206,6 +5600,20 @@ int ntfs_attr_exist(struct ntfs_inode *ni, const __le32 type, __le16 *name,
 	return !ret;
 }
 
+int ntfs_attr_exist_nolock(struct ntfs_inode *ni, const __le32 type,
+		__le16 *name, u32 name_len)
+{
+	return __ntfs_attr_exist(ni, type, name, name_len,
+			NTFS_ATTR_CTX_LOCK_NONE);
+}
+
+int ntfs_attr_exist(struct ntfs_inode *ni, const __le32 type, __le16 *name,
+		u32 name_len)
+{
+	return __ntfs_attr_exist(ni, type, name, name_len,
+			NTFS_ATTR_CTX_LOCK_READ);
+}
+
 int ntfs_attr_remove(struct ntfs_inode *ni, const __le32 type, __le16 *name,
 		u32 name_len)
 {
@@ -5252,8 +5660,9 @@ int ntfs_attr_remove(struct ntfs_inode *ni, const __le32 type, __le16 *name,
  * and which needs to be freed when it's not needed anymore. If the
  * @data_size parameter is non-NULL then the data size is set there.
  */
-void *ntfs_attr_readall(struct ntfs_inode *ni, const __le32 type,
-		__le16 *name, u32 name_len, s64 *data_size)
+static void *__ntfs_attr_readall(struct ntfs_inode *ni, const __le32 type,
+		__le16 *name, u32 name_len, s64 *data_size,
+		enum ntfs_attr_search_ctx_lock_mode lock_mode)
 {
 	struct ntfs_inode *bmp_ni;
 	struct inode *bmp_vi;
@@ -5263,7 +5672,9 @@ void *ntfs_attr_readall(struct ntfs_inode *ni, const __le32 type,
 
 	ntfs_debug("Entering\n");
 
-	bmp_vi = ntfs_attr_iget(VFS_I(ni), type, name, name_len);
+	bmp_vi = lock_mode == NTFS_ATTR_CTX_LOCK_NONE ?
+			ntfs_attr_iget_nolock(VFS_I(ni), type, name, name_len) :
+			ntfs_attr_iget(VFS_I(ni), type, name, name_len);
 	if (IS_ERR(bmp_vi)) {
 		ntfs_debug("ntfs_attr_iget failed");
 		goto err_exit;
@@ -5281,8 +5692,12 @@ void *ntfs_attr_readall(struct ntfs_inode *ni, const __le32 type,
 	if (!data)
 		goto out;
 
-	size = ntfs_inode_attr_pread(VFS_I(bmp_ni), 0, bmp_ni->data_size,
-			(u8 *)data);
+	if (lock_mode == NTFS_ATTR_CTX_LOCK_NONE)
+		size = ntfs_inode_attr_pread_nolock(VFS_I(bmp_ni), 0,
+				bmp_ni->data_size, (u8 *)data);
+	else
+		size = ntfs_inode_attr_pread(VFS_I(bmp_ni), 0,
+				bmp_ni->data_size, (u8 *)data);
 	if (size != bmp_ni->data_size) {
 		ntfs_error(sb, "ntfs_attr_pread failed");
 		kvfree(data);
@@ -5298,9 +5713,24 @@ void *ntfs_attr_readall(struct ntfs_inode *ni, const __le32 type,
 	return ret;
 }
 
+void *ntfs_attr_readall_nolock(struct ntfs_inode *ni, const __le32 type,
+		__le16 *name, u32 name_len, s64 *data_size)
+{
+	return __ntfs_attr_readall(ni, type, name, name_len, data_size,
+			NTFS_ATTR_CTX_LOCK_NONE);
+}
+
+void *ntfs_attr_readall(struct ntfs_inode *ni, const __le32 type,
+		__le16 *name, u32 name_len, s64 *data_size)
+{
+	return __ntfs_attr_readall(ni, type, name, name_len, data_size,
+			NTFS_ATTR_CTX_LOCK_READ);
+}
+
 int ntfs_non_resident_attr_insert_range(struct ntfs_inode *ni, s64 start_vcn, s64 len)
 {
 	struct ntfs_volume *vol = ni->vol;
+	struct ntfs_inode *attr_lock_ni;
 	struct runlist_element *hole_rl, *rl;
 	struct ntfs_attr_search_ctx *ctx;
 	int ret;
@@ -5321,16 +5751,19 @@ int ntfs_non_resident_attr_insert_range(struct ntfs_inode *ni, s64 start_vcn, s6
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
@@ -5339,6 +5772,7 @@ int ntfs_non_resident_attr_insert_range(struct ntfs_inode *ni, s64 start_vcn, s6
 				  hole_rl, 1, &new_rl_count);
 	if (IS_ERR(rl)) {
 		up_write(&ni->runlist.lock);
+		ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
 		kfree(hole_rl);
 		return PTR_ERR(rl);
 	}
@@ -5349,12 +5783,13 @@ int ntfs_non_resident_attr_insert_range(struct ntfs_inode *ni, s64 start_vcn, s6
 	ni->data_size += ntfs_cluster_to_bytes(vol, len);
 	if (ntfs_cluster_to_bytes(vol, start_vcn) < ni->initialized_size)
 		ni->initialized_size += ntfs_cluster_to_bytes(vol, len);
-	ret = ntfs_attr_update_mapping_pairs(ni, 0);
 	up_write(&ni->runlist.lock);
+	ret = ntfs_attr_update_mapping_pairs_locked(ni, 0, &attr_lock_ni);
+	ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
 	if (ret)
 		return ret;
 
-	ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	ctx = ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_READ);
 	if (!ctx) {
 		ret = -ENOMEM;
 		return ret;
@@ -5379,6 +5814,7 @@ int ntfs_non_resident_attr_insert_range(struct ntfs_inode *ni, s64 start_vcn, s6
 int ntfs_non_resident_attr_collapse_range(struct ntfs_inode *ni, s64 start_vcn, s64 len)
 {
 	struct ntfs_volume *vol = ni->vol;
+	struct ntfs_inode *attr_lock_ni;
 	struct runlist_element *punch_rl, *rl;
 	struct ntfs_attr_search_ctx *ctx = NULL;
 	s64 end_vcn;
@@ -5393,10 +5829,12 @@ int ntfs_non_resident_attr_collapse_range(struct ntfs_inode *ni, s64 start_vcn,
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
 
@@ -5406,6 +5844,7 @@ int ntfs_non_resident_attr_collapse_range(struct ntfs_inode *ni, s64 start_vcn,
 	rl = ntfs_rl_find_vcn_nolock(ni->runlist.rl, start_vcn);
 	if (!rl) {
 		up_write(&ni->runlist.lock);
+		ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
 		return -EIO;
 	}
 
@@ -5413,6 +5852,7 @@ int ntfs_non_resident_attr_collapse_range(struct ntfs_inode *ni, s64 start_vcn,
 				    start_vcn, len, &punch_rl, &new_rl_cnt);
 	if (IS_ERR(rl)) {
 		up_write(&ni->runlist.lock);
+		ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
 		return PTR_ERR(rl);
 	}
 	ni->runlist.rl = rl;
@@ -5433,16 +5873,15 @@ int ntfs_non_resident_attr_collapse_range(struct ntfs_inode *ni, s64 start_vcn,
 			ni->initialized_size = ntfs_cluster_to_bytes(vol, start_vcn);
 	}
 
-	if (ni->allocated_size > 0) {
-		ret = ntfs_attr_update_mapping_pairs(ni, 0);
-		if (ret) {
-			up_write(&ni->runlist.lock);
-			goto out_rl;
-		}
-	}
 	up_write(&ni->runlist.lock);
+	if (ni->allocated_size > 0)
+		ret = ntfs_attr_update_mapping_pairs_locked(ni, 0,
+				&attr_lock_ni);
+	ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
+	if (ret)
+		goto out_rl;
 
-	ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	ctx = ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_READ);
 	if (!ctx) {
 		ret = -ENOMEM;
 		goto out_rl;
@@ -5474,6 +5913,7 @@ int ntfs_non_resident_attr_collapse_range(struct ntfs_inode *ni, s64 start_vcn,
 int ntfs_non_resident_attr_punch_hole(struct ntfs_inode *ni, s64 start_vcn, s64 len)
 {
 	struct ntfs_volume *vol = ni->vol;
+	struct ntfs_inode *attr_lock_ni;
 	struct runlist_element *punch_rl, *rl;
 	s64 end_vcn;
 	int dst_cnt;
@@ -5487,10 +5927,12 @@ int ntfs_non_resident_attr_punch_hole(struct ntfs_inode *ni, s64 start_vcn, s64
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
 
@@ -5500,6 +5942,7 @@ int ntfs_non_resident_attr_punch_hole(struct ntfs_inode *ni, s64 start_vcn, s64
 	rl = ntfs_rl_find_vcn_nolock(ni->runlist.rl, start_vcn);
 	if (!rl) {
 		up_write(&ni->runlist.lock);
+		ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
 		return -EIO;
 	}
 
@@ -5507,13 +5950,15 @@ int ntfs_non_resident_attr_punch_hole(struct ntfs_inode *ni, s64 start_vcn, s64
 				start_vcn, len, &punch_rl, &new_rl_count);
 	if (IS_ERR(rl)) {
 		up_write(&ni->runlist.lock);
+		ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
 		return PTR_ERR(rl);
 	}
 	ni->runlist.rl = rl;
 	ni->runlist.count = new_rl_count;
 
-	ret = ntfs_attr_update_mapping_pairs(ni, 0);
 	up_write(&ni->runlist.lock);
+	ret = ntfs_attr_update_mapping_pairs_locked(ni, 0, &attr_lock_ni);
+	ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
 	if (ret) {
 		kvfree(punch_rl);
 		return ret;
@@ -5544,9 +5989,13 @@ int ntfs_attr_fallocate(struct ntfs_inode *ni, loff_t start, loff_t byte_len, bo
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
@@ -5558,7 +6007,7 @@ int ntfs_attr_fallocate(struct ntfs_inode *ni, loff_t start, loff_t byte_len, bo
 		return PTR_ERR(mrec);
 	}
 
-	ctx = ntfs_attr_get_search_ctx(ni, mrec);
+	ctx = ntfs_attr_get_search_ctx(ni, mrec, NTFS_ATTR_CTX_LOCK_READ);
 	if (!ctx) {
 		err = -ENOMEM;
 		goto out_unmap;
@@ -5571,12 +6020,30 @@ int ntfs_attr_fallocate(struct ntfs_inode *ni, loff_t start, loff_t byte_len, bo
 	}
 
 	old_data_size = ni->data_size;
-	if (start + byte_len > ni->data_size) {
+	ntfs_attr_put_search_ctx(ctx);
+	ctx = NULL;
+	unmap_mft_record(ni);
+	mutex_unlock(&ni->mrec_lock);
+
+	if (start + byte_len > old_data_size) {
 		err = ntfs_attr_truncate(ni, start + byte_len);
 		if (err)
-			goto out_unmap;
+			goto out;
 		if (keep_size) {
-			ntfs_attr_reinit_search_ctx(ctx);
+			mutex_lock_nested(&ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL);
+			mrec = map_mft_record(ni);
+			if (IS_ERR(mrec)) {
+				mutex_unlock(&ni->mrec_lock);
+				err = PTR_ERR(mrec);
+				goto out;
+			}
+
+			ctx = ntfs_attr_get_search_ctx(ni, mrec,
+					NTFS_ATTR_CTX_LOCK_READ);
+			if (!ctx) {
+				err = -ENOMEM;
+				goto out_unmap;
+			}
 			err = ntfs_attr_lookup(AT_DATA, AT_UNNAMED, 0, 0, 0, NULL, 0, ctx);
 			if (err) {
 				err = -EIO;
@@ -5590,13 +6057,13 @@ int ntfs_attr_fallocate(struct ntfs_inode *ni, loff_t start, loff_t byte_len, bo
 				ctx->attr->data.resident.value_length =
 					cpu_to_le32((u32)old_data_size);
 			mark_mft_record_dirty(ni);
+			ntfs_attr_put_search_ctx(ctx);
+			ctx = NULL;
+			unmap_mft_record(ni);
+			mutex_unlock(&ni->mrec_lock);
 		}
 	}
 
-	ntfs_attr_put_search_ctx(ctx);
-	unmap_mft_record(ni);
-	mutex_unlock(&ni->mrec_lock);
-
 	if (!NInoNonResident(ni))
 		goto out;
 
@@ -5613,32 +6080,47 @@ int ntfs_attr_fallocate(struct ntfs_inode *ni, loff_t start, loff_t byte_len, bo
 	 */
 	vcn = vcn_start;
 	while (vcn < vcn_uninit) {
+		s64 rl_lcn, rl_length, rl_vcn;
+
 		down_read(&ni->runlist.lock);
 		rl = ntfs_attr_find_vcn_nolock(ni, vcn, NULL);
+		if (!IS_ERR(rl)) {
+			rl_lcn = rl->lcn;
+			rl_length = rl->length;
+			rl_vcn = rl->vcn;
+		}
 		up_read(&ni->runlist.lock);
 		if (IS_ERR(rl)) {
 			err = PTR_ERR(rl);
 			goto out;
 		}
 
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
 
 			while (try_alloc_cnt > 0) {
-				mutex_lock_nested(&ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL);
-				down_write(&ni->runlist.lock);
-				err = ntfs_attr_map_cluster(ni, vcn, &lcn, &alloc_cnt,
-							    try_alloc_cnt, &balloc, false, false);
-				up_write(&ni->runlist.lock);
-				mutex_unlock(&ni->mrec_lock);
+				struct ntfs_inode *attr_lock_ni;
+
+					mutex_lock_nested(&ni->mrec_lock,
+							  NTFS_INODE_MUTEX_NORMAL);
+					attr_lock_ni = ntfs_attr_list_lock(ni,
+							NTFS_ATTR_CTX_LOCK_WRITE);
+					down_write(&ni->runlist.lock);
+					err = ntfs_attr_map_cluster(ni, vcn, &lcn,
+							&alloc_cnt, try_alloc_cnt,
+							&balloc, false, false, true);
+					up_write(&ni->runlist.lock);
+					ntfs_attr_list_unlock(attr_lock_ni,
+							NTFS_ATTR_CTX_LOCK_WRITE);
+					mutex_unlock(&ni->mrec_lock);
 				if (err)
 					goto out;
 
@@ -5663,12 +6145,17 @@ int ntfs_attr_fallocate(struct ntfs_inode *ni, loff_t start, loff_t byte_len, bo
 	/* allocate clusters outside of initialized_size */
 	try_alloc_cnt = vcn_end - vcn;
 	while (try_alloc_cnt > 0) {
+		struct ntfs_inode *attr_lock_ni;
+
 		mutex_lock_nested(&ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL);
-		down_write(&ni->runlist.lock);
-		err = ntfs_attr_map_cluster(ni, vcn, &lcn, &alloc_cnt,
-					    try_alloc_cnt, &balloc, false, false);
-		up_write(&ni->runlist.lock);
-		mutex_unlock(&ni->mrec_lock);
+		attr_lock_ni = ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LOCK_WRITE);
+			down_write(&ni->runlist.lock);
+			err = ntfs_attr_map_cluster(ni, vcn, &lcn, &alloc_cnt,
+						    try_alloc_cnt, &balloc, false, false,
+						    true);
+			up_write(&ni->runlist.lock);
+			ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
+			mutex_unlock(&ni->mrec_lock);
 		if (err || signal_pending(current))
 			goto out;
 
@@ -5679,13 +6166,11 @@ int ntfs_attr_fallocate(struct ntfs_inode *ni, loff_t start, loff_t byte_len, bo
 
 	if (NInoRunlistDirty(ni)) {
 		mutex_lock_nested(&ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL);
-		down_write(&ni->runlist.lock);
 		err = ntfs_attr_update_mapping_pairs(ni, 0);
 		if (err)
 			ntfs_error(ni->vol->sb, "Updating mapping pairs failed");
 		else
 			NInoClearRunlistDirty(ni);
-		up_write(&ni->runlist.lock);
 		mutex_unlock(&ni->mrec_lock);
 	}
 	return err;
diff --git a/fs/ntfs/attrib.h b/fs/ntfs/attrib.h
index e2224fbfaabe9..47c2c071b5a88 100644
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
@@ -39,6 +41,14 @@ extern __le16 AT_UNNAMED[];
  * any modification of the search context, to automagically get the next
  * matching attribute.
  */
+enum ntfs_attr_search_ctx_lock_mode {
+	NTFS_ATTR_CTX_LOCK_NONE,
+	NTFS_ATTR_CTX_LOCK_READ,
+	NTFS_ATTR_CTX_LOCK_WRITE,
+	NTFS_ATTR_CTX_LOCK_READ_NESTED,
+	NTFS_ATTR_CTX_LOCK_WRITE_NESTED,
+};
+
 struct ntfs_attr_search_ctx {
 	struct mft_record *mrec;
 	bool mapped_mrec;
@@ -50,6 +60,8 @@ struct ntfs_attr_search_ctx {
 	struct mft_record *base_mrec;
 	bool mapped_base_mrec;
 	struct attr_record *base_attr;
+	struct ntfs_inode *attr_list_lock_ni;
+	enum ntfs_attr_search_ctx_lock_mode attr_list_lock_mode;
 };
 
 enum {                  /* ways of processing holes when expanding */
@@ -66,6 +78,7 @@ struct runlist_element *ntfs_attr_find_vcn_nolock(struct ntfs_inode *ni,
 		const s64 vcn, struct ntfs_attr_search_ctx *ctx);
 struct runlist_element *__ntfs_attr_find_vcn_nolock(struct runlist *runlist,
 		const s64 vcn);
+int ntfs_attr_map_whole_runlist_nolock(struct ntfs_inode *ni);
 int ntfs_attr_map_whole_runlist(struct ntfs_inode *ni);
 int ntfs_attr_lookup(const __le32 type, const __le16 *name,
 		const u32 name_len, const u32 ic,
@@ -87,14 +100,24 @@ static inline s64 ntfs_attr_size(const struct attr_record *a)
 
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
 int ntfs_attr_can_be_resident(const struct ntfs_volume *vol,
 		const __le32 type);
 int ntfs_attr_map_cluster(struct ntfs_inode *ni, s64 vcn_start, s64 *lcn_start,
-		s64 *lcn_count, s64 max_clu_count, bool *balloc, bool update_mp, bool skip_holes);
+		s64 *lcn_count, s64 max_clu_count, bool *balloc,
+		bool update_mp, bool skip_holes, bool defer_update_mp);
 int ntfs_attr_record_resize(struct mft_record *m, struct attr_record *a, u32 new_size);
 int ntfs_resident_attr_value_resize(struct mft_record *m, struct attr_record *a,
 		const u32 new_size);
@@ -112,15 +135,22 @@ int ntfs_non_resident_attr_punch_hole(struct ntfs_inode *ni, s64 start_vcn, s64
 int __ntfs_attr_truncate_vfs(struct ntfs_inode *ni, const s64 newsize,
 		const s64 i_size);
 int ntfs_attr_expand(struct ntfs_inode *ni, const s64 newsize, const s64 prealloc_size);
+int ntfs_attr_truncate_i_nolock(struct ntfs_inode *ni, const s64 newsize,
+		unsigned int holes);
 int ntfs_attr_truncate_i(struct ntfs_inode *ni, const s64 newsize, unsigned int holes);
+int ntfs_attr_truncate_nolock(struct ntfs_inode *ni, const s64 newsize);
 int ntfs_attr_truncate(struct ntfs_inode *ni, const s64 newsize);
 int ntfs_attr_rm(struct ntfs_inode *ni);
+int ntfs_attr_exist_nolock(struct ntfs_inode *ni, const __le32 type,
+		__le16 *name, u32 name_len);
 int ntfs_attr_exist(struct ntfs_inode *ni, const __le32 type, __le16 *name,
 		u32 name_len);
 int ntfs_attr_remove(struct ntfs_inode *ni, const __le32 type, __le16 *name,
 		u32 name_len);
 int ntfs_attr_record_rm(struct ntfs_attr_search_ctx *ctx);
 int ntfs_attr_record_move_to(struct ntfs_attr_search_ctx *ctx, struct ntfs_inode *ni);
+int ntfs_attr_add_nolock(struct ntfs_inode *ni, __le32 type,
+		__le16 *name, u8 name_len, u8 *val, s64 size);
 int ntfs_attr_add(struct ntfs_inode *ni, __le32 type,
 		__le16 *name, u8 name_len, u8 *val, s64 size);
 int ntfs_attr_record_move_away(struct ntfs_attr_search_ctx *ctx, int extra);
@@ -129,10 +159,17 @@ char *ntfs_attr_name_get(const struct ntfs_volume *vol, const __le16 *uname,
 void ntfs_attr_name_free(unsigned char **name);
 void *ntfs_attr_readall(struct ntfs_inode *ni, const __le32 type,
 		__le16 *name, u32 name_len, s64 *data_size);
+void *ntfs_attr_readall_nolock(struct ntfs_inode *ni, const __le32 type,
+		__le16 *name, u32 name_len, s64 *data_size);
 int ntfs_resident_attr_record_add(struct ntfs_inode *ni, __le32 type,
 		__le16 *name, u8 name_len, u8 *val, u32 size,
 		__le16 flags);
 int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn);
+int ntfs_attr_update_mapping_pairs_locked(struct ntfs_inode *ni, s64 from_vcn,
+		struct ntfs_inode **attr_lock_ni);
+int ntfs_attr_update_mapping_pairs_runlist_locked(struct ntfs_inode *ni,
+		s64 from_vcn);
+int ntfs_attr_update_mapping_pairs_nolock(struct ntfs_inode *ni, s64 from_vcn);
 struct runlist_element *ntfs_attr_vcn_to_rl(struct ntfs_inode *ni, s64 vcn, s64 *lcn);
 
 /*
@@ -148,7 +185,9 @@ struct runlist_element *ntfs_attr_vcn_to_rl(struct ntfs_inode *ni, s64 vcn, s64
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
index afb13038ba425..ead9b47921ee3 100644
--- a/fs/ntfs/attrlist.c
+++ b/fs/ntfs/attrlist.c
@@ -51,23 +51,45 @@ int ntfs_attrlist_need(struct ntfs_inode *ni)
 	return 0;
 }
 
-int ntfs_attrlist_update(struct ntfs_inode *base_ni)
+static int __ntfs_attrlist_update(struct ntfs_inode *base_ni,
+		enum ntfs_attr_search_ctx_lock_mode lock_mode)
 {
 	struct inode *attr_vi;
 	struct ntfs_inode *attr_ni;
 	int err;
 
-	attr_vi = ntfs_attr_iget(VFS_I(base_ni), AT_ATTRIBUTE_LIST, AT_UNNAMED, 0);
+	attr_vi = lock_mode == NTFS_ATTR_CTX_LOCK_NONE ?
+			ntfs_attr_iget_nolock(VFS_I(base_ni), AT_ATTRIBUTE_LIST,
+					      AT_UNNAMED, 0) :
+			ntfs_attr_iget(VFS_I(base_ni), AT_ATTRIBUTE_LIST,
+				       AT_UNNAMED, 0);
 	if (IS_ERR(attr_vi)) {
 		err = PTR_ERR(attr_vi);
 		return err;
 	}
 	attr_ni = NTFS_I(attr_vi);
 
-	err = ntfs_attr_truncate_i(attr_ni, base_ni->attr_list_size, HOLES_NO);
+	if (lock_mode == NTFS_ATTR_CTX_LOCK_NONE)
+		err = ntfs_attr_truncate_i_nolock(attr_ni,
+				base_ni->attr_list_size, HOLES_NO);
+	else
+		err = ntfs_attr_truncate_i(attr_ni, base_ni->attr_list_size,
+				HOLES_NO);
 	if (err == -ENOSPC && attr_ni->mft_no == FILE_MFT) {
-		err = ntfs_attr_truncate(attr_ni, 0);
-		if (err || ntfs_attr_truncate_i(attr_ni, base_ni->attr_list_size, HOLES_NO) != 0) {
+		if (lock_mode == NTFS_ATTR_CTX_LOCK_NONE)
+			err = ntfs_attr_truncate_nolock(attr_ni, 0);
+		else
+			err = ntfs_attr_truncate(attr_ni, 0);
+		if (err)
+			goto truncate_err;
+		if (lock_mode == NTFS_ATTR_CTX_LOCK_NONE)
+			err = ntfs_attr_truncate_i_nolock(attr_ni,
+					base_ni->attr_list_size, HOLES_NO);
+		else
+			err = ntfs_attr_truncate_i(attr_ni,
+					base_ni->attr_list_size, HOLES_NO);
+		if (err) {
+truncate_err:
 			iput(attr_vi);
 			ntfs_error(base_ni->vol->sb,
 					"Failed to truncate attribute list of inode %#llx",
@@ -87,8 +109,11 @@ int ntfs_attrlist_update(struct ntfs_inode *base_ni)
 	if (NInoNonResident(attr_ni) && !NInoAttrListNonResident(base_ni))
 		NInoSetAttrListNonResident(base_ni);
 
-	if (ntfs_inode_attr_pwrite(attr_vi, 0, base_ni->attr_list_size,
-				   base_ni->attr_list, false) !=
+	if ((lock_mode == NTFS_ATTR_CTX_LOCK_NONE ?
+	     ntfs_inode_attr_pwrite_nolock(attr_vi, 0, base_ni->attr_list_size,
+					   base_ni->attr_list, false) :
+	     ntfs_inode_attr_pwrite(attr_vi, 0, base_ni->attr_list_size,
+				    base_ni->attr_list, false)) !=
 	    base_ni->attr_list_size) {
 		iput(attr_vi);
 		ntfs_error(base_ni->vol->sb,
@@ -102,6 +127,16 @@ int ntfs_attrlist_update(struct ntfs_inode *base_ni)
 	return 0;
 }
 
+int ntfs_attrlist_update_nolock(struct ntfs_inode *base_ni)
+{
+	return __ntfs_attrlist_update(base_ni, NTFS_ATTR_CTX_LOCK_NONE);
+}
+
+int ntfs_attrlist_update(struct ntfs_inode *base_ni)
+{
+	return __ntfs_attrlist_update(base_ni, NTFS_ATTR_CTX_LOCK_READ);
+}
+
 /*
  * ntfs_attrlist_entry_add - add an attribute list attribute entry
  * @ni:	opened ntfs inode, which contains that attribute
@@ -117,8 +152,10 @@ int ntfs_attrlist_entry_add(struct ntfs_inode *ni, struct attr_record *attr)
 	u8 *new_al;
 	int entry_len, entry_offset, err;
 	struct mft_record *ni_mrec;
+	struct ntfs_inode *lock_ni;
 	u8 *old_al;
 	__le64 lowest_vcn;
+	enum ntfs_attr_search_ctx_lock_mode lock_mode;
 
 	if (!ni || !attr) {
 		ntfs_debug("Invalid arguments.\n");
@@ -153,7 +190,7 @@ int ntfs_attrlist_entry_add(struct ntfs_inode *ni, struct attr_record *attr)
 		return -ENOMEM;
 
 	/* Find place for the new entry. */
-	ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	ctx = ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_WRITE);
 	if (!ctx) {
 		err = -ENOMEM;
 		ntfs_error(ni->vol->sb, "Failed to get search context");
@@ -176,7 +213,6 @@ int ntfs_attrlist_entry_add(struct ntfs_inode *ni, struct attr_record *attr)
 		if (ctx->al_entry->lowest_vcn == lowest_vcn) {
 			err = -EEXIST;
 			ntfs_debug("Such attribute already present in the attribute list.\n");
-			ntfs_attr_put_search_ctx(ctx);
 			goto err_out;
 		}
 		/* Add new entry after this extent. */
@@ -186,15 +222,11 @@ int ntfs_attrlist_entry_add(struct ntfs_inode *ni, struct attr_record *attr)
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
@@ -219,20 +251,33 @@ int ntfs_attrlist_entry_add(struct ntfs_inode *ni, struct attr_record *attr)
 	memcpy(new_al + entry_offset + entry_len, ni->attr_list +
 			entry_offset, ni->attr_list_size - entry_offset);
 
-	/* Set new runlist. */
+	/* Set new attribute list. */
 	old_al = ni->attr_list;
 	ni->attr_list = new_al;
 	ni->attr_list_size = ni->attr_list_size + entry_len;
 
+	lock_ni = ctx->attr_list_lock_ni;
+	lock_mode = ctx->attr_list_lock_mode;
+	ctx->attr_list_lock_ni = NULL;
+	ctx->attr_list_lock_mode = NTFS_ATTR_CTX_LOCK_NONE;
+	ntfs_attr_put_search_ctx(ctx);
+	ctx = NULL;
+
+	ntfs_attr_list_unlock(lock_ni, lock_mode);
+
 	err = ntfs_attrlist_update(ni);
 	if (err) {
+		lock_ni = ntfs_attr_list_lock(ni, lock_mode);
 		ni->attr_list = old_al;
 		ni->attr_list_size -= entry_len;
+		ntfs_attr_list_unlock(lock_ni, lock_mode);
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
@@ -248,9 +293,12 @@ int ntfs_attrlist_entry_add(struct ntfs_inode *ni, struct attr_record *attr)
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
@@ -285,9 +333,20 @@ int ntfs_attrlist_entry_rm(struct ntfs_attr_search_ctx *ctx)
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
+	if (ctx_locked)
+		err = ntfs_attrlist_update(base_ni);
+	else
+		err = ntfs_attrlist_update_nolock(base_ni);
+	if (ctx_locked)
+		ntfs_attr_lock_search_ctx(ctx, base_ni, lock_mode);
+	return err;
 }
diff --git a/fs/ntfs/attrlist.h b/fs/ntfs/attrlist.h
index 1892a3934d3ab..8a7f69c324a7d 100644
--- a/fs/ntfs/attrlist.h
+++ b/fs/ntfs/attrlist.h
@@ -15,6 +15,7 @@
 int ntfs_attrlist_need(struct ntfs_inode *ni);
 int ntfs_attrlist_entry_add(struct ntfs_inode *ni, struct attr_record *attr);
 int ntfs_attrlist_entry_rm(struct ntfs_attr_search_ctx *ctx);
+int ntfs_attrlist_update_nolock(struct ntfs_inode *base_ni);
 int ntfs_attrlist_update(struct ntfs_inode *base_ni);
 
 #endif /* defined _NTFS_ATTRLIST_H */
diff --git a/fs/ntfs/compress.c b/fs/ntfs/compress.c
index 76bd806b41edd..4ccec5f035c7c 100644
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
 	up_write(&ni->runlist.lock);
+	err = ntfs_attr_update_mapping_pairs_locked(ni, 0, &attr_lock_ni);
+	ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
 	if (err) {
 		err = -EIO;
 		goto out;
diff --git a/fs/ntfs/dir.c b/fs/ntfs/dir.c
index 4b6bd5f30c65e..4d58c3695998a 100644
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
@@ -789,6 +789,7 @@ static int ntfs_readdir(struct file *file, struct dir_context *actor)
 					ictx);
 		if (!err) {
 			next = ictx->entry;
+			ntfs_attr_unlock_search_ctx(ictx->actx);
 			/*
 			 * Update ie_pos with private->curr_pos
 			 * to make next d_off of dirent correct.
@@ -814,7 +815,7 @@ static int ntfs_readdir(struct file *file, struct dir_context *actor)
 		file->private_data = private;
 	}
 
-	ctx = ntfs_attr_get_search_ctx(ndir, NULL);
+	ctx = ntfs_attr_get_search_ctx(ndir, NULL, NTFS_ATTR_CTX_LOCK_READ);
 	if (!ctx) {
 		err = -ENOMEM;
 		goto out;
@@ -839,6 +840,7 @@ static int ntfs_readdir(struct file *file, struct dir_context *actor)
 	ictx->parent_vcn[ictx->pindex] = VCN_INDEX_ROOT_PARENT;
 	ictx->is_in_root = true;
 	ictx->parent_pos[ictx->pindex] = 0;
+	ntfs_attr_unlock_search_ctx(ictx->actx);
 
 	ictx->block_size = le32_to_cpu(ir->index_block_size);
 	if (ictx->block_size < NTFS_BLOCK_SIZE) {
@@ -883,6 +885,8 @@ static int ntfs_readdir(struct file *file, struct dir_context *actor)
 
 	while (1) {
 		next = ntfs_index_next(next, ictx);
+		if (ictx->actx)
+			ntfs_attr_unlock_search_ctx(ictx->actx);
 		if (IS_ERR(next)) {
 			err = PTR_ERR(next);
 			goto out;
@@ -1007,7 +1011,9 @@ static int ntfs_readdir(struct file *file, struct dir_context *actor)
 	return err;
 }
 
-int ntfs_check_empty_dir(struct ntfs_inode *ni, struct mft_record *ni_mrec)
+static int __ntfs_check_empty_dir(struct ntfs_inode *ni,
+		struct mft_record *ni_mrec,
+		enum ntfs_attr_search_ctx_lock_mode lock_mode)
 {
 	struct ntfs_attr_search_ctx *ctx;
 	int ret = 0;
@@ -1015,7 +1021,7 @@ int ntfs_check_empty_dir(struct ntfs_inode *ni, struct mft_record *ni_mrec)
 	if (!(ni_mrec->flags & MFT_RECORD_IS_DIRECTORY))
 		return 0;
 
-	ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	ctx = ntfs_attr_get_search_ctx(ni, NULL, lock_mode);
 	if (!ctx) {
 		ntfs_error(ni->vol->sb, "Failed to get search context");
 		return -ENOMEM;
@@ -1044,6 +1050,17 @@ int ntfs_check_empty_dir(struct ntfs_inode *ni, struct mft_record *ni_mrec)
 	return ret;
 }
 
+int ntfs_check_empty_dir_nolock(struct ntfs_inode *ni,
+		struct mft_record *ni_mrec)
+{
+	return __ntfs_check_empty_dir(ni, ni_mrec, NTFS_ATTR_CTX_LOCK_NONE);
+}
+
+int ntfs_check_empty_dir(struct ntfs_inode *ni, struct mft_record *ni_mrec)
+{
+	return __ntfs_check_empty_dir(ni, ni_mrec, NTFS_ATTR_CTX_LOCK_READ);
+}
+
 /*
  * ntfs_dir_open - called when an inode is about to be opened
  * @vi:		inode to be opened
@@ -1108,7 +1125,8 @@ static int ntfs_dir_fsync(struct file *filp, loff_t start, loff_t end,
 	struct ntfs_inode *ni = NTFS_I(vi);
 	struct ntfs_attr_search_ctx *ctx;
 	struct inode *parent_vi, *ia_vi;
-	int err, ret;
+	u64 *parents = NULL;
+	int err, ret, i, nr_parents = 0, parents_size = 0, collect_err = 0;
 	struct ntfs_attr na;
 
 	ntfs_debug("Entering for inode 0x%llx.", ni->mft_no);
@@ -1116,19 +1134,52 @@ static int ntfs_dir_fsync(struct file *filp, loff_t start, loff_t end,
 	if (NVolShutdown(vol))
 		return -EIO;
 
-	ctx = ntfs_attr_get_search_ctx(ni, NULL);
-	if (!ctx)
+	mutex_lock_nested(&ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL_CHILD);
+	ctx = ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_READ);
+	if (!ctx) {
+		mutex_unlock(&ni->mrec_lock);
 		return -ENOMEM;
+	}
 
-	mutex_lock_nested(&ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL_CHILD);
 	while (!(err = ntfs_attr_lookup(AT_FILE_NAME, NULL, 0, 0, 0, NULL, 0, ctx))) {
 		struct file_name_attr *fn = (struct file_name_attr *)((u8 *)ctx->attr +
 				le16_to_cpu(ctx->attr->data.resident.value_offset));
+		u64 parent_mft_no = MREF_LE(fn->parent_directory);
 
-		if (MREF_LE(fn->parent_directory) == ni->mft_no)
+		if (parent_mft_no == ni->mft_no)
 			continue;
 
-		parent_vi = ntfs_iget(vi->i_sb, MREF_LE(fn->parent_directory));
+		for (i = 0; i < nr_parents; i++) {
+			if (parents[i] == parent_mft_no)
+				break;
+		}
+		if (i < nr_parents)
+			continue;
+
+		if (nr_parents == parents_size) {
+			u64 *new_parents;
+			int new_size = parents_size ? parents_size * 2 : 4;
+
+			new_parents = krealloc_array(parents, new_size,
+					sizeof(*parents), GFP_NOFS);
+			if (!new_parents) {
+				collect_err = -ENOMEM;
+				break;
+			}
+			parents = new_parents;
+			parents_size = new_size;
+		}
+		parents[nr_parents++] = parent_mft_no;
+	}
+	ntfs_attr_put_search_ctx(ctx);
+	mutex_unlock(&ni->mrec_lock);
+	if (collect_err) {
+		kfree(parents);
+		return collect_err;
+	}
+
+	for (i = 0; i < nr_parents; i++) {
+		parent_vi = ntfs_iget(vi->i_sb, parents[i]);
 		if (IS_ERR(parent_vi))
 			continue;
 		mutex_lock_nested(&NTFS_I(parent_vi)->mrec_lock, NTFS_INODE_MUTEX_NORMAL);
@@ -1143,8 +1194,7 @@ static int ntfs_dir_fsync(struct file *filp, loff_t start, loff_t end,
 		write_inode_now(parent_vi, 1);
 		iput(parent_vi);
 	}
-	mutex_unlock(&ni->mrec_lock);
-	ntfs_attr_put_search_ctx(ctx);
+	kfree(parents);
 
 	err = file_write_and_wait_range(filp, start, end);
 	if (err)
@@ -1166,9 +1216,7 @@ static int ntfs_dir_fsync(struct file *filp, loff_t start, loff_t end,
 	write_inode_now(vi, !datasync);
 
 	write_inode_now(vol->mftbmp_ino, 1);
-	down_write(&vol->lcnbmp_lock);
 	write_inode_now(vol->lcnbmp_ino, 1);
-	up_write(&vol->lcnbmp_lock);
 	write_inode_now(vol->mft_ino, 1);
 
 	err = sync_blockdev(vi->i_sb->s_bdev);
diff --git a/fs/ntfs/dir.h b/fs/ntfs/dir.h
index a38c6b0716783..1f4bd1086b6ce 100644
--- a/fs/ntfs/dir.h
+++ b/fs/ntfs/dir.h
@@ -27,6 +27,8 @@ extern __le16 I30[5];
 
 u64 ntfs_lookup_inode_by_name(struct ntfs_inode *dir_ni,
 		const __le16 *uname, const int uname_len, struct ntfs_name **res);
+int ntfs_check_empty_dir_nolock(struct ntfs_inode *ni,
+		struct mft_record *ni_mrec);
 int ntfs_check_empty_dir(struct ntfs_inode *ni, struct mft_record *ni_mrec);
 
 #endif /* _LINUX_NTFS_FS_DIR_H */
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
index 6a7b638e523d9..d019e91e89f83 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -23,6 +23,7 @@
 #include "iomap.h"
 #include "bitmap.h"
 #include "volume.h"
+#include "attrib.h"
 
 #include <linux/filelock.h>
 
@@ -79,15 +80,19 @@ static int ntfs_trim_prealloc(struct inode *vi)
 {
 	struct ntfs_inode *ni = NTFS_I(vi);
 	struct ntfs_volume *vol = ni->vol;
+	struct ntfs_inode *attr_lock_ni;
 	struct runlist_element *rl;
 	s64 aligned_data_size;
 	s64 vcn_ds, vcn_tr;
 	ssize_t rc;
 	int err = 0;
+	bool runlist_locked = false;
 
 	inode_lock(vi);
 	mutex_lock(&ni->mrec_lock);
+	attr_lock_ni = ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LOCK_WRITE);
 	down_write(&ni->runlist.lock);
+	runlist_locked = true;
 
 	aligned_data_size = round_up(ni->data_size, vol->cluster_size);
 	if (aligned_data_size >= ni->allocated_size)
@@ -111,7 +116,10 @@ static int ntfs_trim_prealloc(struct inode *vi)
 			ntfs_error(vol->sb, "Preallocated block rollback failed");
 		} else {
 			ni->allocated_size = ntfs_cluster_to_bytes(vol, vcn_tr);
-			err = ntfs_attr_update_mapping_pairs(ni, 0);
+			up_write(&ni->runlist.lock);
+			runlist_locked = false;
+			err = ntfs_attr_update_mapping_pairs_locked(ni, 0,
+					&attr_lock_ni);
 			if (err)
 				ntfs_error(vol->sb,
 					   "Failed to rollback mapping pairs for prealloc");
@@ -119,7 +127,9 @@ static int ntfs_trim_prealloc(struct inode *vi)
 	}
 
 out_unlock:
-	up_write(&ni->runlist.lock);
+	if (runlist_locked)
+		up_write(&ni->runlist.lock);
+	ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
 	mutex_unlock(&ni->mrec_lock);
 	inode_unlock(vi);
 
@@ -163,6 +173,14 @@ static int ntfs_file_fsync(struct file *filp, loff_t start, loff_t end,
 	int err, ret = 0;
 	struct inode *parent_vi, *ia_vi;
 	struct ntfs_attr_search_ctx *ctx;
+	struct ntfs_fsync_attr {
+		__le32 type;
+		__le16 *name;
+		u32 name_len;
+	} *attrs = NULL;
+	u64 *parents = NULL;
+	int i, nr_attrs = 0, attrs_size = 0;
+	int nr_parents = 0, parents_size = 0, collect_err = 0;
 
 	ntfs_debug("Entering for inode 0x%llx.", ni->mft_no);
 
@@ -177,58 +195,131 @@ static int ntfs_file_fsync(struct file *filp, loff_t start, loff_t end,
 		ret = __ntfs_write_inode(vi, 1);
 	write_inode_now(vi, !datasync);
 
-	ctx = ntfs_attr_get_search_ctx(ni, NULL);
-	if (!ctx)
+	mutex_lock_nested(&ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL_CHILD);
+	ctx = ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_READ);
+	if (!ctx) {
+		mutex_unlock(&ni->mrec_lock);
 		return -ENOMEM;
+	}
 
-	mutex_lock_nested(&ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL_CHILD);
 	while (!(err = ntfs_attr_lookup(AT_UNUSED, NULL, 0, 0, 0, NULL, 0, ctx))) {
 		if (ctx->attr->type == AT_FILE_NAME) {
 			struct file_name_attr *fn = (struct file_name_attr *)((u8 *)ctx->attr +
 					le16_to_cpu(ctx->attr->data.resident.value_offset));
+			u64 parent_mft_no = MREF_LE(fn->parent_directory);
 
-			parent_vi = ntfs_iget(vi->i_sb, MREF_LE(fn->parent_directory));
-			if (IS_ERR(parent_vi))
+			if (parent_mft_no == ni->mft_no)
 				continue;
-			mutex_lock_nested(&NTFS_I(parent_vi)->mrec_lock, NTFS_INODE_MUTEX_NORMAL);
-			ia_vi = ntfs_index_iget(parent_vi, I30, 4);
-			mutex_unlock(&NTFS_I(parent_vi)->mrec_lock);
-			if (IS_ERR(ia_vi)) {
-				iput(parent_vi);
+
+			for (i = 0; i < nr_parents; i++) {
+				if (parents[i] == parent_mft_no)
+					break;
+			}
+			if (i < nr_parents)
 				continue;
+
+			if (nr_parents == parents_size) {
+				u64 *new_parents;
+				int new_size = parents_size ? parents_size * 2 : 4;
+
+				new_parents = krealloc_array(parents, new_size,
+						sizeof(*parents), GFP_NOFS);
+				if (!new_parents) {
+					collect_err = -ENOMEM;
+					break;
+				}
+				parents = new_parents;
+				parents_size = new_size;
 			}
-			write_inode_now(ia_vi, 1);
-			iput(ia_vi);
-			write_inode_now(parent_vi, 1);
-			iput(parent_vi);
+			parents[nr_parents++] = parent_mft_no;
 		} else if (ctx->attr->non_resident) {
-			struct inode *attr_vi;
-			__le16 *name;
+			struct ntfs_fsync_attr *attr;
+			u32 name_len = ctx->attr->name_length;
+			__le16 *name = NULL;
 
-			name = (__le16 *)((u8 *)ctx->attr + le16_to_cpu(ctx->attr->name_offset));
-			if (ctx->attr->type == AT_DATA && ctx->attr->name_length == 0)
+			if (ctx->attr->type == AT_DATA && !name_len)
 				continue;
 
-			attr_vi = ntfs_attr_iget(vi, ctx->attr->type,
-						 name, ctx->attr->name_length);
-			if (IS_ERR(attr_vi))
-				continue;
-			spin_lock(&attr_vi->i_lock);
-			if (inode_state_read_once(attr_vi) & I_DIRTY_PAGES) {
-				spin_unlock(&attr_vi->i_lock);
-				filemap_write_and_wait(attr_vi->i_mapping);
-			} else
-				spin_unlock(&attr_vi->i_lock);
-			iput(attr_vi);
+			if (nr_attrs == attrs_size) {
+				struct ntfs_fsync_attr *new_attrs;
+				int new_size = attrs_size ? attrs_size * 2 : 4;
+
+				new_attrs = krealloc_array(attrs, new_size,
+						sizeof(*attrs), GFP_NOFS);
+				if (!new_attrs) {
+					collect_err = -ENOMEM;
+					break;
+				}
+				attrs = new_attrs;
+				attrs_size = new_size;
+			}
+
+			if (name_len) {
+				name = kmemdup((u8 *)ctx->attr +
+						le16_to_cpu(ctx->attr->name_offset),
+						name_len * sizeof(*name), GFP_NOFS);
+				if (!name) {
+					collect_err = -ENOMEM;
+					break;
+				}
+			}
+
+			attr = &attrs[nr_attrs++];
+			attr->type = ctx->attr->type;
+			attr->name = name;
+			attr->name_len = name_len;
 		}
 	}
-	mutex_unlock(&ni->mrec_lock);
 	ntfs_attr_put_search_ctx(ctx);
+	mutex_unlock(&ni->mrec_lock);
+	if (collect_err) {
+		for (i = 0; i < nr_attrs; i++)
+			kfree(attrs[i].name);
+		kfree(attrs);
+		kfree(parents);
+		return collect_err;
+	}
+
+	for (i = 0; i < nr_parents; i++) {
+		parent_vi = ntfs_iget(vi->i_sb, parents[i]);
+		if (IS_ERR(parent_vi))
+			continue;
+		mutex_lock_nested(&NTFS_I(parent_vi)->mrec_lock, NTFS_INODE_MUTEX_NORMAL);
+		ia_vi = ntfs_index_iget(parent_vi, I30, 4);
+		mutex_unlock(&NTFS_I(parent_vi)->mrec_lock);
+		if (IS_ERR(ia_vi)) {
+			iput(parent_vi);
+			continue;
+		}
+		write_inode_now(ia_vi, 1);
+		iput(ia_vi);
+		write_inode_now(parent_vi, 1);
+		iput(parent_vi);
+	}
+
+	for (i = 0; i < nr_attrs; i++) {
+		struct inode *attr_vi;
+
+		attr_vi = ntfs_attr_iget(vi, attrs[i].type,
+					 attrs[i].name, attrs[i].name_len);
+		if (IS_ERR(attr_vi))
+			continue;
+		spin_lock(&attr_vi->i_lock);
+		if (inode_state_read_once(attr_vi) & I_DIRTY_PAGES) {
+			spin_unlock(&attr_vi->i_lock);
+			filemap_write_and_wait(attr_vi->i_mapping);
+		} else
+			spin_unlock(&attr_vi->i_lock);
+		iput(attr_vi);
+	}
+
+	for (i = 0; i < nr_attrs; i++)
+		kfree(attrs[i].name);
+	kfree(attrs);
+	kfree(parents);
 
 	write_inode_now(vol->mftbmp_ino, 1);
-	down_write(&vol->lcnbmp_lock);
 	write_inode_now(vol->lcnbmp_ino, 1);
-	up_write(&vol->lcnbmp_lock);
 	write_inode_now(vol->mft_ino, 1);
 
 	/*
@@ -1057,6 +1148,7 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t offset, loff_t le
 	struct inode *vi = file_inode(file);
 	struct ntfs_inode *ni = NTFS_I(vi);
 	struct ntfs_volume *vol = ni->vol;
+	struct ntfs_inode *attr_lock_ni;
 	int err = 0;
 	loff_t old_size;
 	bool map_locked = false;
@@ -1071,9 +1163,11 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t offset, loff_t le
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
index c5f2cf75b750e..37a792dbf62e1 100644
--- a/fs/ntfs/index.c
+++ b/fs/ntfs/index.c
@@ -99,6 +99,8 @@ static s64 ntfs_ib_pos_to_vcn(struct ntfs_index_context *icx, s64 pos)
 
 static int ntfs_ib_write(struct ntfs_index_context *icx, struct index_block *ib)
 {
+	enum ntfs_attr_search_ctx_lock_mode lock_mode = NTFS_ATTR_CTX_LOCK_NONE;
+	bool relock = false;
 	s64 ret, vcn = le64_to_cpu(ib->index_block_vcn);
 
 	ntfs_debug("vcn: %lld\n", vcn);
@@ -107,9 +109,21 @@ static int ntfs_ib_write(struct ntfs_index_context *icx, struct index_block *ib)
 	if (ret)
 		return -EIO;
 
-	ret = ntfs_inode_attr_pwrite(VFS_I(icx->ia_ni),
-			ntfs_ib_vcn_to_pos(icx, vcn), icx->block_size,
-			(u8 *)ib, icx->sync_write);
+	if (icx->actx && icx->actx->attr_list_lock_ni) {
+		lock_mode = icx->actx->attr_list_lock_mode;
+		ntfs_attr_unlock_search_ctx(icx->actx);
+		relock = true;
+		ret = ntfs_inode_attr_pwrite_nolock(VFS_I(icx->ia_ni),
+				ntfs_ib_vcn_to_pos(icx, vcn), icx->block_size,
+				(u8 *)ib, icx->sync_write);
+		if (relock)
+			ntfs_attr_lock_search_ctx(icx->actx, icx->idx_ni,
+					lock_mode);
+	} else {
+		ret = ntfs_inode_attr_pwrite(VFS_I(icx->ia_ni),
+				ntfs_ib_vcn_to_pos(icx, vcn), icx->block_size,
+				(u8 *)ib, icx->sync_write);
+	}
 	if (ret != icx->block_size) {
 		ntfs_debug("Failed to write index block %lld, inode %llu",
 				vcn, (unsigned long long)icx->idx_ni->mft_no);
@@ -182,6 +196,7 @@ struct ntfs_index_context *ntfs_index_ctx_get(struct ntfs_inode *ni,
 			.idx_ni = ni,
 			.name = name,
 			.name_len = name_len,
+			.attr_list_lock_mode = NTFS_ATTR_CTX_LOCK_WRITE,
 		};
 	return icx;
 }
@@ -190,11 +205,6 @@ static void ntfs_index_ctx_free(struct ntfs_index_context *icx)
 {
 	ntfs_debug("Entering\n");
 
-	if (icx->actx) {
-		ntfs_attr_put_search_ctx(icx->actx);
-		icx->actx = NULL;
-	}
-
 	if (!icx->is_in_root) {
 		if (icx->ib_dirty)
 			ntfs_ib_write(icx, icx->ib);
@@ -202,6 +212,11 @@ static void ntfs_index_ctx_free(struct ntfs_index_context *icx)
 		icx->ib = NULL;
 	}
 
+	if (icx->actx) {
+		ntfs_attr_put_search_ctx(icx->actx);
+		icx->actx = NULL;
+	}
+
 	if (icx->ia_ni) {
 		iput(VFS_I(icx->ia_ni));
 		icx->ia_ni = NULL;
@@ -228,6 +243,8 @@ void ntfs_index_ctx_put(struct ntfs_index_context *icx)
  */
 void ntfs_index_ctx_reinit(struct ntfs_index_context *icx)
 {
+	enum ntfs_attr_search_ctx_lock_mode lock_mode = icx->attr_list_lock_mode;
+
 	ntfs_debug("Entering\n");
 
 	ntfs_index_ctx_free(icx);
@@ -236,6 +253,7 @@ void ntfs_index_ctx_reinit(struct ntfs_index_context *icx)
 		.idx_ni = icx->idx_ni,
 		.name = icx->name,
 		.name_len = icx->name_len,
+		.attr_list_lock_mode = lock_mode,
 	};
 }
 
@@ -568,14 +586,15 @@ int ntfs_index_root_inconsistent(struct ntfs_volume *vol,
 					      inum);
 }
 
-static struct index_root *ntfs_ir_lookup(struct ntfs_inode *ni, __le16 *name,
-		u32 name_len, struct ntfs_attr_search_ctx **ctx)
+static struct index_root *__ntfs_ir_lookup(struct ntfs_inode *ni, __le16 *name,
+		u32 name_len, struct ntfs_attr_search_ctx **ctx,
+		enum ntfs_attr_search_ctx_lock_mode lock_mode)
 {
 	struct attr_record *a;
 	struct index_root *ir = NULL;
 
 	ntfs_debug("Entering\n");
-	*ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	*ctx = ntfs_attr_get_search_ctx(ni, NULL, lock_mode);
 	if (!*ctx) {
 		ntfs_error(ni->vol->sb, "%s, Failed to get search context", __func__);
 		return NULL;
@@ -602,17 +621,31 @@ static struct index_root *ntfs_ir_lookup(struct ntfs_inode *ni, __le16 *name,
 	return ir;
 }
 
-static struct index_root *ntfs_ir_lookup2(struct ntfs_inode *ni, __le16 *name, u32 len)
+static struct index_root *ntfs_ir_lookup_nolock(struct ntfs_inode *ni,
+		__le16 *name, u32 name_len, struct ntfs_attr_search_ctx **ctx)
+{
+	return __ntfs_ir_lookup(ni, name, name_len, ctx,
+			NTFS_ATTR_CTX_LOCK_NONE);
+}
+
+static struct index_root *__ntfs_ir_lookup2(struct ntfs_inode *ni, __le16 *name,
+		u32 len, enum ntfs_attr_search_ctx_lock_mode lock_mode)
 {
 	struct ntfs_attr_search_ctx *ctx;
 	struct index_root *ir;
 
-	ir = ntfs_ir_lookup(ni, name, len, &ctx);
+	ir = __ntfs_ir_lookup(ni, name, len, &ctx, lock_mode);
 	if (ir)
 		ntfs_attr_put_search_ctx(ctx);
 	return ir;
 }
 
+static struct index_root *ntfs_ir_lookup2_nolock(struct ntfs_inode *ni,
+		__le16 *name, u32 len)
+{
+	return __ntfs_ir_lookup2(ni, name, len, NTFS_ATTR_CTX_LOCK_NONE);
+}
+
 /*
  * Find a key in the index block.
  */
@@ -704,8 +737,23 @@ static int ntfs_ie_lookup(const void *key, const u32 key_len,
 struct ntfs_inode *ntfs_ia_open(struct ntfs_index_context *icx, struct ntfs_inode *ni)
 {
 	struct inode *ia_vi;
+	enum ntfs_attr_search_ctx_lock_mode lock_mode = NTFS_ATTR_CTX_LOCK_NONE;
+	bool relock = false;
 
-	ia_vi = ntfs_index_iget(VFS_I(ni), icx->name, icx->name_len);
+	if (icx->actx && icx->actx->attr_list_lock_ni) {
+		lock_mode = icx->actx->attr_list_lock_mode;
+		ntfs_attr_unlock_search_ctx(icx->actx);
+		relock = true;
+	}
+
+	if (lock_mode == NTFS_ATTR_CTX_LOCK_READ_NESTED ||
+	    lock_mode == NTFS_ATTR_CTX_LOCK_WRITE_NESTED)
+		ia_vi = ntfs_index_iget_nested(VFS_I(ni), icx->name,
+				icx->name_len);
+	else
+		ia_vi = ntfs_index_iget(VFS_I(ni), icx->name, icx->name_len);
+	if (relock)
+		ntfs_attr_lock_search_ctx(icx->actx, ni, lock_mode);
 	if (IS_ERR(ia_vi)) {
 		ntfs_error(icx->idx_ni->vol->sb,
 				"Failed to open index allocation of inode %llu",
@@ -716,15 +764,72 @@ struct ntfs_inode *ntfs_ia_open(struct ntfs_index_context *icx, struct ntfs_inod
 	return NTFS_I(ia_vi);
 }
 
+static int ntfs_index_attr_add(struct ntfs_index_context *icx, __le32 type,
+		__le16 *name, u8 name_len, u8 *val, s64 size)
+{
+	enum ntfs_attr_search_ctx_lock_mode lock_mode = NTFS_ATTR_CTX_LOCK_NONE;
+	bool relock = false;
+	int ret;
+
+	if (icx->actx && icx->actx->attr_list_lock_ni) {
+		lock_mode = icx->actx->attr_list_lock_mode;
+		ntfs_attr_unlock_search_ctx(icx->actx);
+		relock = true;
+	}
+
+	ret = ntfs_attr_add(icx->idx_ni, type, name, name_len, val, size);
+
+	if (relock) {
+		ntfs_attr_lock_search_ctx(icx->actx, icx->idx_ni, lock_mode);
+		ntfs_attr_reinit_search_ctx(icx->actx);
+	}
+	return ret;
+}
+
+static int ntfs_index_inode_add_attrlist(struct ntfs_index_context *icx)
+{
+	enum ntfs_attr_search_ctx_lock_mode lock_mode = NTFS_ATTR_CTX_LOCK_NONE;
+	bool relock = false;
+	int ret;
+
+	if (icx->actx && icx->actx->attr_list_lock_ni) {
+		lock_mode = icx->actx->attr_list_lock_mode;
+		ntfs_attr_unlock_search_ctx(icx->actx);
+		relock = true;
+	}
+
+	ret = ntfs_inode_add_attrlist(icx->idx_ni);
+
+	if (relock) {
+		ntfs_attr_lock_search_ctx(icx->actx, icx->idx_ni, lock_mode);
+		ntfs_attr_reinit_search_ctx(icx->actx);
+	}
+	return ret;
+}
+
 static int ntfs_ib_read(struct ntfs_index_context *icx, s64 vcn, struct index_block *dst)
 {
+	enum ntfs_attr_search_ctx_lock_mode lock_mode = NTFS_ATTR_CTX_LOCK_NONE;
+	bool relock = false;
 	s64 pos, ret;
 
 	ntfs_debug("vcn: %lld\n", vcn);
 
 	pos = ntfs_ib_vcn_to_pos(icx, vcn);
 
-	ret = ntfs_inode_attr_pread(VFS_I(icx->ia_ni), pos, icx->block_size, (u8 *)dst);
+	if (icx->actx && icx->actx->attr_list_lock_ni) {
+		lock_mode = icx->actx->attr_list_lock_mode;
+		ntfs_attr_unlock_search_ctx(icx->actx);
+		relock = true;
+		ret = ntfs_inode_attr_pread_nolock(VFS_I(icx->ia_ni), pos,
+				icx->block_size, (u8 *)dst);
+		if (relock)
+			ntfs_attr_lock_search_ctx(icx->actx, icx->idx_ni,
+					lock_mode);
+	} else {
+		ret = ntfs_inode_attr_pread(VFS_I(icx->ia_ni), pos,
+				icx->block_size, (u8 *)dst);
+	}
 	if (ret != icx->block_size) {
 		if (ret == -1)
 			ntfs_error(icx->idx_ni->vol->sb, "Failed to read index block");
@@ -791,7 +896,9 @@ static int ntfs_icx_parent_dec(struct ntfs_index_context *icx)
  * the call to ntfs_index_ctx_put() to ensure that the changes are written
  * to disk.
  */
-int ntfs_index_lookup(const void *key, const u32 key_len, struct ntfs_index_context *icx)
+static int __ntfs_index_lookup(const void *key, const u32 key_len,
+		struct ntfs_index_context *icx,
+		enum ntfs_attr_search_ctx_lock_mode lock_mode)
 {
 	s64 old_vcn, vcn;
 	struct ntfs_inode *ni = icx->idx_ni;
@@ -808,7 +915,9 @@ int ntfs_index_lookup(const void *key, const u32 key_len, struct ntfs_index_cont
 		return -EINVAL;
 	}
 
-	ir = ntfs_ir_lookup(ni, icx->name, icx->name_len, &icx->actx);
+	icx->attr_list_lock_mode = lock_mode;
+	ir = __ntfs_ir_lookup(ni, icx->name, icx->name_len, &icx->actx,
+			lock_mode);
 	if (!ir)
 		return -EIO;
 
@@ -910,6 +1019,12 @@ int ntfs_index_lookup(const void *key, const u32 key_len, struct ntfs_index_cont
 
 }
 
+int ntfs_index_lookup(const void *key, const u32 key_len,
+		struct ntfs_index_context *icx)
+{
+	return __ntfs_index_lookup(key, key_len, icx, NTFS_ATTR_CTX_LOCK_WRITE);
+}
+
 static struct index_block *ntfs_ib_alloc(s64 ib_vcn, u32 ib_size,
 		u8 node_type)
 {
@@ -989,13 +1104,14 @@ static int ntfs_ibm_add(struct ntfs_index_context *icx)
 
 	ntfs_debug("Entering\n");
 
-	if (ntfs_attr_exist(icx->idx_ni, AT_BITMAP, icx->name, icx->name_len))
+	if (ntfs_attr_exist_nolock(icx->idx_ni, AT_BITMAP, icx->name,
+				icx->name_len))
 		return 0;
 	/*
 	 * AT_BITMAP must be at least 8 bytes.
 	 */
 	memset(bmp, 0, sizeof(bmp));
-	if (ntfs_attr_add(icx->idx_ni, AT_BITMAP, icx->name, icx->name_len,
+	if (ntfs_index_attr_add(icx, AT_BITMAP, icx->name, icx->name_len,
 				bmp, sizeof(bmp))) {
 		ntfs_error(icx->idx_ni->vol->sb, "Failed to add AT_BITMAP");
 		return -EINVAL;
@@ -1012,21 +1128,38 @@ static int ntfs_ibm_modify(struct ntfs_index_context *icx, s64 vcn, int set)
 	u32 bit = 1 << (pos % 8);
 	struct ntfs_inode *bmp_ni;
 	struct inode *bmp_vi;
+	enum ntfs_attr_search_ctx_lock_mode lock_mode = NTFS_ATTR_CTX_LOCK_NONE;
+	bool relock = false;
 	int ret = 0;
 
 	ntfs_debug("%s vcn: %lld\n", set ? "set" : "clear", vcn);
 
-	bmp_vi = ntfs_attr_iget(VFS_I(icx->idx_ni), AT_BITMAP, icx->name, icx->name_len);
+	if (icx->actx && icx->actx->attr_list_lock_ni) {
+		lock_mode = icx->actx->attr_list_lock_mode;
+		ntfs_attr_unlock_search_ctx(icx->actx);
+		relock = true;
+	}
+
+	bmp_vi = relock ? ntfs_attr_iget_nolock(VFS_I(icx->idx_ni),
+			AT_BITMAP, icx->name, icx->name_len) :
+			ntfs_attr_iget(VFS_I(icx->idx_ni), AT_BITMAP,
+			icx->name, icx->name_len);
 	if (IS_ERR(bmp_vi)) {
 		ntfs_error(icx->idx_ni->vol->sb, "Failed to open $BITMAP attribute");
-		return PTR_ERR(bmp_vi);
+		ret = PTR_ERR(bmp_vi);
+		goto out_relock;
 	}
 
 	bmp_ni = NTFS_I(bmp_vi);
 
 	if (set) {
 		if (bmp_ni->data_size < bpos + 1) {
-			ret = ntfs_attr_truncate(bmp_ni, (bmp_ni->data_size + 8) & ~7);
+			if (relock)
+				ret = ntfs_attr_truncate_nolock(bmp_ni,
+						(bmp_ni->data_size + 8) & ~7);
+			else
+				ret = ntfs_attr_truncate(bmp_ni,
+						(bmp_ni->data_size + 8) & ~7);
 			if (ret) {
 				ntfs_error(icx->idx_ni->vol->sb, "Failed to truncate AT_BITMAP");
 				goto err;
@@ -1035,7 +1168,8 @@ static int ntfs_ibm_modify(struct ntfs_index_context *icx, s64 vcn, int set)
 		}
 	}
 
-	if (ntfs_inode_attr_pread(bmp_vi, bpos, 1, &byte) != 1) {
+	if ((relock ? ntfs_inode_attr_pread_nolock(bmp_vi, bpos, 1, &byte) :
+		      ntfs_inode_attr_pread(bmp_vi, bpos, 1, &byte)) != 1) {
 		ret = -EIO;
 		ntfs_error(icx->idx_ni->vol->sb, "Failed to read $BITMAP");
 		goto err;
@@ -1046,7 +1180,8 @@ static int ntfs_ibm_modify(struct ntfs_index_context *icx, s64 vcn, int set)
 	else
 		byte &= ~bit;
 
-	if (ntfs_inode_attr_pwrite(bmp_vi, bpos, 1, &byte, false) != 1) {
+	if ((relock ? ntfs_inode_attr_pwrite_nolock(bmp_vi, bpos, 1, &byte, false) :
+		      ntfs_inode_attr_pwrite(bmp_vi, bpos, 1, &byte, false)) != 1) {
 		ret = -EIO;
 		ntfs_error(icx->idx_ni->vol->sb, "Failed to write $Bitmap");
 		goto err;
@@ -1054,6 +1189,9 @@ static int ntfs_ibm_modify(struct ntfs_index_context *icx, s64 vcn, int set)
 
 err:
 	iput(bmp_vi);
+out_relock:
+	if (relock)
+		ntfs_attr_lock_search_ctx(icx->actx, icx->idx_ni, lock_mode);
 	return ret;
 }
 
@@ -1072,11 +1210,20 @@ static s64 ntfs_ibm_get_free(struct ntfs_index_context *icx)
 	u8 *bm;
 	int bit;
 	s64 vcn, byte, size;
+	enum ntfs_attr_search_ctx_lock_mode lock_mode = NTFS_ATTR_CTX_LOCK_NONE;
 
 	ntfs_debug("Entering\n");
 
-	bm = ntfs_attr_readall(icx->idx_ni, AT_BITMAP,  icx->name, icx->name_len,
-			&size);
+	if (icx->actx && icx->actx->attr_list_lock_ni) {
+		lock_mode = icx->actx->attr_list_lock_mode;
+		ntfs_attr_unlock_search_ctx(icx->actx);
+		bm = ntfs_attr_readall_nolock(icx->idx_ni, AT_BITMAP,
+				icx->name, icx->name_len, &size);
+		ntfs_attr_lock_search_ctx(icx->actx, icx->idx_ni, lock_mode);
+	} else {
+		bm = ntfs_attr_readall(icx->idx_ni, AT_BITMAP, icx->name,
+				icx->name_len, &size);
+	}
 	if (!bm)
 		return (s64)-1;
 
@@ -1217,8 +1364,9 @@ static int ntfs_ia_add(struct ntfs_index_context *icx)
 	if (ret)
 		return ret;
 
-	if (!ntfs_attr_exist(icx->idx_ni, AT_INDEX_ALLOCATION, icx->name, icx->name_len)) {
-		ret = ntfs_attr_add(icx->idx_ni, AT_INDEX_ALLOCATION, icx->name,
+	if (!ntfs_attr_exist_nolock(icx->idx_ni, AT_INDEX_ALLOCATION, icx->name,
+				icx->name_len)) {
+		ret = ntfs_index_attr_add(icx, AT_INDEX_ALLOCATION, icx->name,
 					icx->name_len, NULL, 0);
 		if (ret) {
 			ntfs_error(icx->idx_ni->vol->sb, "Failed to add AT_INDEX_ALLOCATION");
@@ -1247,7 +1395,7 @@ static int ntfs_ir_reparent(struct ntfs_index_context *icx)
 
 	ntfs_debug("Entering\n");
 
-	ir = ntfs_ir_lookup2(icx->idx_ni, icx->name, icx->name_len);
+	ir = ntfs_ir_lookup2_nolock(icx->idx_ni, icx->name, icx->name_len);
 	if (!ir) {
 		ret = -ENOENT;
 		goto out;
@@ -1265,7 +1413,7 @@ static int ntfs_ir_reparent(struct ntfs_index_context *icx)
 		goto out;
 	}
 
-	ir = ntfs_ir_lookup2(icx->idx_ni, icx->name, icx->name_len);
+	ir = ntfs_ir_lookup2_nolock(icx->idx_ni, icx->name, icx->name_len);
 	if (!ir) {
 		ret = -ENOENT;
 		goto clear_bmp;
@@ -1283,7 +1431,7 @@ static int ntfs_ir_reparent(struct ntfs_index_context *icx)
 		goto clear_bmp;
 
 retry:
-	ir = ntfs_ir_lookup(icx->idx_ni, icx->name, icx->name_len, &ctx);
+	ir = ntfs_ir_lookup_nolock(icx->idx_ni, icx->name, icx->name_len, &ctx);
 	if (!ir) {
 		ret = -ENOENT;
 		goto clear_bmp;
@@ -1332,14 +1480,16 @@ static int ntfs_ir_reparent(struct ntfs_index_context *icx)
 	 * When there is no space to build a non-resident
 	 * index, we may have to move the root to an extent
 	 */
-	if ((ret == -ENOSPC) && (ctx->al_entry || !ntfs_inode_add_attrlist(icx->idx_ni))) {
+	if ((ret == -ENOSPC) &&
+	    (ctx->al_entry || !ntfs_index_inode_add_attrlist(icx))) {
 		ntfs_attr_put_search_ctx(ctx);
 		ctx = NULL;
-		ir = ntfs_ir_lookup(icx->idx_ni, icx->name, icx->name_len, &ctx);
+		ir = ntfs_ir_lookup_nolock(icx->idx_ni, icx->name, icx->name_len,
+					    &ctx);
 		if (ir && !ntfs_attr_record_move_away(ctx, ix_root_size -
 				le32_to_cpu(ctx->attr->data.resident.value_length))) {
-			if (ntfs_attrlist_update(ctx->base_ntfs_ino ?
-						 ctx->base_ntfs_ino : ctx->ntfs_ino))
+			if (ntfs_attrlist_update_nolock(ctx->base_ntfs_ino ?
+							ctx->base_ntfs_ino : ctx->ntfs_ino))
 				goto clear_bmp;
 			ntfs_attr_put_search_ctx(ctx);
 			ctx = NULL;
@@ -1379,10 +1529,14 @@ static int ntfs_ir_truncate(struct ntfs_index_context *icx, int data_size)
 	 *  INDEX_ROOT must be resident and its entries can be moved to
 	 *  struct index_block, so ENOSPC isn't a real error.
 	 */
-	ret = ntfs_attr_truncate(icx->idx_ni, data_size + offsetof(struct index_root, index));
+	ret = ntfs_attr_truncate_i_nolock(icx->idx_ni,
+			data_size + offsetof(struct index_root, index),
+			NVolDisableSparse(icx->idx_ni->vol) ?
+			HOLES_NO : HOLES_OK);
 	if (!ret) {
 		i_size_write(VFS_I(icx->idx_ni), icx->idx_ni->initialized_size);
-		icx->ir = ntfs_ir_lookup2(icx->idx_ni, icx->name, icx->name_len);
+		icx->ir = ntfs_ir_lookup2_nolock(icx->idx_ni, icx->name,
+						  icx->name_len);
 		if (!icx->ir)
 			return -ENOENT;
 
@@ -1485,7 +1639,7 @@ static int ntfs_ir_insert_median(struct ntfs_index_context *icx, struct index_en
 
 	ntfs_debug("Entering\n");
 
-	icx->ir = ntfs_ir_lookup2(icx->idx_ni, icx->name, icx->name_len);
+	icx->ir = ntfs_ir_lookup2_nolock(icx->idx_ni, icx->name, icx->name_len);
 	if (!icx->ir)
 		return -ENOENT;
 
@@ -1498,7 +1652,7 @@ static int ntfs_ir_insert_median(struct ntfs_index_context *icx, struct index_en
 	if (ret)
 		return ret;
 
-	icx->ir = ntfs_ir_lookup2(icx->idx_ni, icx->name, icx->name_len);
+	icx->ir = ntfs_ir_lookup2_nolock(icx->idx_ni, icx->name, icx->name_len);
 	if (!icx->ir)
 		return -ENOENT;
 
@@ -1637,7 +1791,9 @@ int ntfs_ie_add(struct ntfs_index_context *icx, struct index_entry *ie)
 	int ret;
 
 	while (1) {
-		ret = ntfs_index_lookup(&ie->key, le16_to_cpu(ie->key_length), icx);
+		ret = __ntfs_index_lookup(&ie->key,
+				le16_to_cpu(ie->key_length), icx,
+				icx->attr_list_lock_mode);
 		if (!ret) {
 			ret = -EEXIST;
 			ntfs_error(icx->idx_ni->vol->sb, "Index already have such entry");
@@ -2024,7 +2180,8 @@ int ntfs_index_rm(struct ntfs_index_context *icx)
 	return ret;
 }
 
-int ntfs_index_remove(struct ntfs_inode *dir_ni, const void *key, const u32 keylen)
+static int __ntfs_index_remove(struct ntfs_inode *dir_ni, const void *key,
+		const u32 keylen, enum ntfs_attr_search_ctx_lock_mode lock_mode)
 {
 	int ret = 0;
 	struct ntfs_index_context *icx;
@@ -2034,7 +2191,7 @@ int ntfs_index_remove(struct ntfs_inode *dir_ni, const void *key, const u32 keyl
 		return -EINVAL;
 
 	while (1) {
-		ret = ntfs_index_lookup(key, keylen, icx);
+		ret = __ntfs_index_lookup(key, keylen, icx, lock_mode);
 		if (ret)
 			goto err_out;
 
@@ -2058,6 +2215,20 @@ int ntfs_index_remove(struct ntfs_inode *dir_ni, const void *key, const u32 keyl
 	return ret;
 }
 
+int ntfs_index_remove_nested(struct ntfs_inode *dir_ni, const void *key,
+		const u32 keylen)
+{
+	return __ntfs_index_remove(dir_ni, key, keylen,
+			NTFS_ATTR_CTX_LOCK_WRITE_NESTED);
+}
+
+int ntfs_index_remove(struct ntfs_inode *dir_ni, const void *key,
+		const u32 keylen)
+{
+	return __ntfs_index_remove(dir_ni, key, keylen,
+			NTFS_ATTR_CTX_LOCK_WRITE);
+}
+
 /*
  * ntfs_index_walk_down - walk down the index tree (leaf bound)
  * until there are no subnode in the first index entry returns
@@ -2131,8 +2302,10 @@ static struct index_entry *ntfs_index_walk_up(struct index_entry *ie,
 			/* a new search context is to be allocated */
 			if (ictx->actx)
 				ntfs_attr_put_search_ctx(ictx->actx);
-			ictx->ir = ntfs_ir_lookup(ictx->idx_ni, ictx->name,
-						  ictx->name_len, &ictx->actx);
+			ictx->ir = __ntfs_ir_lookup(ictx->idx_ni,
+					ictx->name, ictx->name_len,
+					&ictx->actx,
+					ictx->attr_list_lock_mode);
 			if (ictx->ir)
 				entry = ntfs_ie_get_by_pos(
 					&ictx->ir->index,
diff --git a/fs/ntfs/index.h b/fs/ntfs/index.h
index 9a03f53bba479..31f9e034f6ee5 100644
--- a/fs/ntfs/index.h
+++ b/fs/ntfs/index.h
@@ -39,6 +39,7 @@
  * @block_size:	size of index blocks in bytes (from $INDEX_ROOT or $Boot)
  * @vcn_size_bits: log2(cluster size)
  * @sync_write:	true if synchronous writeback is requested for this context
+ * @attr_list_lock_mode: lock mode to use when reacquiring @actx
  *
  * @idx_ni is the index inode this context belongs to.
  *
@@ -87,6 +88,7 @@ struct ntfs_index_context {
 	u32 block_size;
 	u8 vcn_size_bits;
 	bool sync_write;
+	enum ntfs_attr_search_ctx_lock_mode attr_list_lock_mode;
 };
 
 int ntfs_index_root_inconsistent(struct ntfs_volume *vol,
@@ -107,6 +109,7 @@ int ntfs_index_lookup(const void *key, const u32 key_len,
 
 void ntfs_index_entry_mark_dirty(struct ntfs_index_context *ictx);
 int ntfs_index_add_filename(struct ntfs_inode *ni, struct file_name_attr *fn, u64 mref);
+int ntfs_index_remove_nested(struct ntfs_inode *ni, const void *key, const u32 keylen);
 int ntfs_index_remove(struct ntfs_inode *ni, const void *key, const u32 keylen);
 struct ntfs_inode *ntfs_ia_open(struct ntfs_index_context *icx, struct ntfs_inode *ni);
 struct index_entry *ntfs_index_walk_down(struct index_entry *ie, struct ntfs_index_context *ictx);
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index c2715521e5628..db04918000af1 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -129,9 +129,10 @@ static int ntfs_init_locked_inode(struct inode *vi, void *data)
 }
 
 static int ntfs_read_locked_inode(struct inode *vi);
-static int ntfs_read_locked_attr_inode(struct inode *base_vi, struct inode *vi);
+static int ntfs_read_locked_attr_inode(struct inode *base_vi, struct inode *vi,
+		enum ntfs_attr_search_ctx_lock_mode lock_mode);
 static int ntfs_read_locked_index_inode(struct inode *base_vi,
-		struct inode *vi);
+		struct inode *vi, enum ntfs_attr_search_ctx_lock_mode lock_mode);
 
 /*
  * ntfs_iget - obtain a struct inode corresponding to a specific normal inode
@@ -206,8 +207,9 @@ struct inode *ntfs_iget(struct super_block *sb, u64 mft_no)
  * value with IS_ERR() and if true, the function failed and the error code is
  * obtained from PTR_ERR().
  */
-struct inode *ntfs_attr_iget(struct inode *base_vi, __le32 type,
-		__le16 *name, u32 name_len)
+static struct inode *__ntfs_attr_iget(struct inode *base_vi, __le32 type,
+		__le16 *name, u32 name_len,
+		enum ntfs_attr_search_ctx_lock_mode lock_mode)
 {
 	struct inode *vi;
 	int err;
@@ -229,7 +231,7 @@ struct inode *ntfs_attr_iget(struct inode *base_vi, __le32 type,
 
 	/* If this is a freshly allocated inode, need to read it now. */
 	if (inode_state_read_once(vi) & I_NEW) {
-		err = ntfs_read_locked_attr_inode(base_vi, vi);
+		err = ntfs_read_locked_attr_inode(base_vi, vi, lock_mode);
 		unlock_new_inode(vi);
 	}
 	/*
@@ -244,6 +246,20 @@ struct inode *ntfs_attr_iget(struct inode *base_vi, __le32 type,
 	return vi;
 }
 
+struct inode *ntfs_attr_iget_nolock(struct inode *base_vi, __le32 type,
+		__le16 *name, u32 name_len)
+{
+	return __ntfs_attr_iget(base_vi, type, name, name_len,
+			NTFS_ATTR_CTX_LOCK_NONE);
+}
+
+struct inode *ntfs_attr_iget(struct inode *base_vi, __le32 type,
+		__le16 *name, u32 name_len)
+{
+	return __ntfs_attr_iget(base_vi, type, name, name_len,
+			NTFS_ATTR_CTX_LOCK_READ);
+}
+
 /*
  * ntfs_index_iget - obtain a struct inode corresponding to an index
  * @base_vi:	vfs base inode containing the index related attributes
@@ -263,8 +279,8 @@ struct inode *ntfs_attr_iget(struct inode *base_vi, __le32 type,
  * value with IS_ERR() and if true, the function failed and the error code is
  * obtained from PTR_ERR().
  */
-struct inode *ntfs_index_iget(struct inode *base_vi, __le16 *name,
-		u32 name_len)
+static struct inode *__ntfs_index_iget(struct inode *base_vi, __le16 *name,
+		u32 name_len, enum ntfs_attr_search_ctx_lock_mode lock_mode)
 {
 	struct inode *vi;
 	int err;
@@ -284,7 +300,7 @@ struct inode *ntfs_index_iget(struct inode *base_vi, __le16 *name,
 
 	/* If this is a freshly allocated inode, need to read it now. */
 	if (inode_state_read_once(vi) & I_NEW) {
-		err = ntfs_read_locked_index_inode(base_vi, vi);
+		err = ntfs_read_locked_index_inode(base_vi, vi, lock_mode);
 		unlock_new_inode(vi);
 	}
 	/*
@@ -299,6 +315,20 @@ struct inode *ntfs_index_iget(struct inode *base_vi, __le16 *name,
 	return vi;
 }
 
+struct inode *ntfs_index_iget_nested(struct inode *base_vi, __le16 *name,
+		u32 name_len)
+{
+	return __ntfs_index_iget(base_vi, name, name_len,
+			NTFS_ATTR_CTX_LOCK_READ_NESTED);
+}
+
+struct inode *ntfs_index_iget(struct inode *base_vi, __le16 *name,
+		u32 name_len)
+{
+	return __ntfs_index_iget(base_vi, name, name_len,
+			NTFS_ATTR_CTX_LOCK_READ);
+}
+
 struct inode *ntfs_alloc_big_inode(struct super_block *sb)
 {
 	struct ntfs_inode *ni;
@@ -326,7 +356,7 @@ static int ntfs_non_resident_dealloc_clusters(struct ntfs_inode *ni)
 	struct ntfs_attr_search_ctx *actx;
 	int err = 0;
 
-	actx = ntfs_attr_get_search_ctx(ni, NULL);
+	actx = ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_READ);
 	if (!actx)
 		return -ENOMEM;
 	WARN_ON(actx->mrec->link_count != 0);
@@ -475,6 +505,7 @@ void __ntfs_init_inode(struct super_block *sb, struct ntfs_inode *ni)
 	ni->folio = NULL;
 	ni->folio_ofs = 0;
 	ni->mrec = NULL;
+	init_rwsem(&ni->attr_list_lock);
 	ni->attr_list_size = 0;
 	ni->attr_list = NULL;
 	ni->itype.index.block_size = 0;
@@ -713,7 +744,7 @@ static int ntfs_read_locked_inode(struct inode *vi)
 		goto err_out;
 	}
 
-	ctx = ntfs_attr_get_search_ctx(ni, m);
+	ctx = ntfs_attr_get_search_ctx(ni, m, NTFS_ATTR_CTX_LOCK_READ);
 	if (!ctx) {
 		err = -ENOMEM;
 		goto unm_err_out;
@@ -862,7 +893,22 @@ static int ntfs_read_locked_inode(struct inode *vi)
 	err = ntfs_attr_lookup(AT_EA_INFORMATION, NULL, 0, 0, 0, NULL, 0, ctx);
 	if (!err) {
 		NInoSetHasEA(ni);
+		ntfs_attr_put_search_ctx(ctx);
+		unmap_mft_record(ni);
+		ctx = NULL;
+		m = NULL;
 		ntfs_ea_get_wsl_inode(vi, &dev, flags);
+
+		m = map_mft_record(ni);
+		if (IS_ERR(m)) {
+			err = PTR_ERR(m);
+			goto err_out;
+		}
+		ctx = ntfs_attr_get_search_ctx(ni, m, NTFS_ATTR_CTX_LOCK_READ);
+		if (!ctx) {
+			err = -ENOMEM;
+			goto unm_err_out;
+		}
 	}
 
 	if (ni->flags & FILE_ATTR_REPARSE_POINT) {
@@ -1250,7 +1296,8 @@ static int ntfs_read_locked_inode(struct inode *vi)
  *
  * Note this cannot be called for AT_INDEX_ALLOCATION.
  */
-static int ntfs_read_locked_attr_inode(struct inode *base_vi, struct inode *vi)
+static int ntfs_read_locked_attr_inode(struct inode *base_vi, struct inode *vi,
+		enum ntfs_attr_search_ctx_lock_mode lock_mode)
 {
 	struct ntfs_volume *vol = NTFS_SB(vi->i_sb);
 	struct ntfs_inode *ni = NTFS_I(vi), *base_ni = NTFS_I(base_vi);
@@ -1280,7 +1327,7 @@ static int ntfs_read_locked_attr_inode(struct inode *base_vi, struct inode *vi)
 		err = PTR_ERR(m);
 		goto err_out;
 	}
-	ctx = ntfs_attr_get_search_ctx(base_ni, m);
+	ctx = ntfs_attr_get_search_ctx(base_ni, m, lock_mode);
 	if (!ctx) {
 		err = -ENOMEM;
 		goto unm_err_out;
@@ -1488,7 +1535,8 @@ static int ntfs_read_locked_attr_inode(struct inode *base_vi, struct inode *vi)
  *
  * Return 0 on success and -errno on error.
  */
-static int ntfs_read_locked_index_inode(struct inode *base_vi, struct inode *vi)
+static int ntfs_read_locked_index_inode(struct inode *base_vi, struct inode *vi,
+		enum ntfs_attr_search_ctx_lock_mode lock_mode)
 {
 	loff_t bvi_size;
 	struct ntfs_volume *vol = NTFS_SB(vi->i_sb);
@@ -1520,7 +1568,7 @@ static int ntfs_read_locked_index_inode(struct inode *base_vi, struct inode *vi)
 		err = PTR_ERR(m);
 		goto err_out;
 	}
-	ctx = ntfs_attr_get_search_ctx(base_ni, m);
+	ctx = ntfs_attr_get_search_ctx(base_ni, m, lock_mode);
 	if (!ctx) {
 		err = -ENOMEM;
 		goto unm_err_out;
@@ -1653,7 +1701,13 @@ static int ntfs_read_locked_index_inode(struct inode *base_vi, struct inode *vi)
 	m = NULL;
 	ctx = NULL;
 	/* Get the index bitmap attribute inode. */
-	bvi = ntfs_attr_iget(base_vi, AT_BITMAP, ni->name, ni->name_len);
+	if (lock_mode == NTFS_ATTR_CTX_LOCK_READ_NESTED ||
+	    lock_mode == NTFS_ATTR_CTX_LOCK_WRITE_NESTED)
+		bvi = __ntfs_attr_iget(base_vi, AT_BITMAP, ni->name,
+				ni->name_len, NTFS_ATTR_CTX_LOCK_READ_NESTED);
+	else
+		bvi = ntfs_attr_iget(base_vi, AT_BITMAP, ni->name,
+				ni->name_len);
 	if (IS_ERR(bvi)) {
 		ntfs_error(vi->i_sb, "Failed to get bitmap attribute.");
 		err = PTR_ERR(bvi);
@@ -1911,7 +1965,7 @@ int ntfs_read_inode_mount(struct inode *vi)
 	/* Provides read_folio() for map_mft_record(). */
 	vi->i_mapping->a_ops = &ntfs_mft_aops;
 
-	ctx = ntfs_attr_get_search_ctx(ni, m);
+	ctx = ntfs_attr_get_search_ctx(ni, m, NTFS_ATTR_CTX_LOCK_READ);
 	if (!ctx) {
 		err = -ENOMEM;
 		goto err_out;
@@ -2466,7 +2520,7 @@ static int ntfs_inode_sync_standard_information(struct inode *vi, struct mft_rec
 	bool modified = false;
 
 	/* Update the access times in the standard information attribute. */
-	ctx = ntfs_attr_get_search_ctx(ni, m);
+	ctx = ntfs_attr_get_search_ctx(ni, m, NTFS_ATTR_CTX_LOCK_READ);
 	if (unlikely(!ctx))
 		return -ENOMEM;
 	err = ntfs_attr_lookup(AT_STANDARD_INFORMATION, NULL, 0,
@@ -2561,15 +2615,30 @@ int ntfs_inode_sync_filename(struct ntfs_inode *ni)
 	struct file_name_attr *fn;
 	struct file_name_attr *fnx;
 	struct reparse_point *rpp;
+	struct ntfs_filename_update {
+		struct file_name_attr *fn;
+		u64 parent_mft_no;
+		__le64 creation_time;
+		__le64 last_data_change_time;
+		__le64 last_mft_change_time;
+		__le64 last_access_time;
+		__le64 allocated_size;
+		__le64 data_size;
+		__le32 file_attributes;
+		__le32 reparse_tag;
+	} *updates = NULL;
 	__le32 reparse_tag;
-	int err = 0;
+	int err = 0, i, nr_updates = 0, updates_size = 0;
 	unsigned long flags;
 
 	ntfs_debug("Entering for inode %llu\n", ni->mft_no);
 
-	ctx = ntfs_attr_get_search_ctx(ni, NULL);
-	if (!ctx)
+	mutex_lock_nested(&ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL);
+	ctx = ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_READ);
+	if (!ctx) {
+		mutex_unlock(&ni->mrec_lock);
 		return -ENOMEM;
+	}
 
 	/* Collect the reparse tag, if any */
 	reparse_tag = cpu_to_le32(0);
@@ -2585,27 +2654,96 @@ int ntfs_inode_sync_filename(struct ntfs_inode *ni)
 
 	/* Walk through all FILE_NAME attributes and update them. */
 	while (!(err = ntfs_attr_lookup(AT_FILE_NAME, NULL, 0, 0, 0, NULL, 0, ctx))) {
+		struct ntfs_filename_update *update;
+		unsigned int fn_size;
+
 		fn = (struct file_name_attr *)((u8 *)ctx->attr +
 				le16_to_cpu(ctx->attr->data.resident.value_offset));
 		if (MREF_LE(fn->parent_directory) == ni->mft_no)
 			continue;
 
-		index_vi = ntfs_iget(sb, MREF_LE(fn->parent_directory));
+		if (NInoBeingDeleted(ni))
+			continue;
+
+		if (nr_updates == updates_size) {
+			struct ntfs_filename_update *new_updates;
+			int new_size = updates_size ? updates_size * 2 : 4;
+
+			new_updates = krealloc_array(updates, new_size,
+					sizeof(*updates), GFP_NOFS);
+			if (!new_updates) {
+				err = -ENOMEM;
+				break;
+			}
+			updates = new_updates;
+			updates_size = new_size;
+		}
+
+		fn_size = offsetof(struct file_name_attr, file_name) +
+				fn->file_name_length * sizeof(*fn->file_name);
+		update = &updates[nr_updates];
+		update->fn = kmemdup(fn, fn_size, GFP_NOFS);
+		if (!update->fn) {
+			err = -ENOMEM;
+			break;
+		}
+
+		update->parent_mft_no = MREF_LE(fn->parent_directory);
+		update->file_attributes =
+			(fn->file_attributes & ~FILE_ATTR_VALID_FLAGS) |
+			(ni->flags & FILE_ATTR_VALID_FLAGS);
+		if (ctx->mrec->flags & MFT_RECORD_IS_DIRECTORY)
+			update->data_size = update->allocated_size = 0;
+		else {
+			read_lock_irqsave(&ni->size_lock, flags);
+			if (NInoSparse(ni) || NInoCompressed(ni))
+				update->allocated_size =
+					cpu_to_le64(ni->itype.compressed.size);
+			else
+				update->allocated_size =
+					cpu_to_le64(ni->allocated_size);
+			update->data_size = cpu_to_le64(ni->data_size);
+			fn->allocated_size = update->allocated_size;
+			fn->data_size = update->data_size;
+			read_unlock_irqrestore(&ni->size_lock, flags);
+		}
+		update->reparse_tag = reparse_tag;
+		update->creation_time = fn->creation_time;
+		update->last_data_change_time = fn->last_data_change_time;
+		update->last_mft_change_time = fn->last_mft_change_time;
+		update->last_access_time = fn->last_access_time;
+		NInoSetDirty(ctx->ntfs_ino);
+		nr_updates++;
+	}
+	/* Check for real error occurred. */
+	if (err != -ENOENT) {
+		ntfs_error(sb, "Attribute lookup failed, err : %d, inode %llu", err,
+				ni->mft_no);
+		ntfs_attr_put_search_ctx(ctx);
+		mutex_unlock(&ni->mrec_lock);
+		goto out;
+	}
+	err = 0;
+
+	ntfs_attr_put_search_ctx(ctx);
+	mutex_unlock(&ni->mrec_lock);
+
+	for (i = 0; i < nr_updates; i++) {
+		struct ntfs_filename_update *update = &updates[i];
+
+		if (NInoBeingDeleted(ni))
+			continue;
+
+		index_vi = ntfs_iget(sb, update->parent_mft_no);
 		if (IS_ERR(index_vi)) {
 			ntfs_error(sb, "Failed to open inode %lld with index",
-					(long long)MREF_LE(fn->parent_directory));
+					(long long)update->parent_mft_no);
 			continue;
 		}
 
 		index_ni = NTFS_I(index_vi);
 
 		mutex_lock_nested(&index_ni->mrec_lock, NTFS_INODE_MUTEX_PARENT);
-		if (NInoBeingDeleted(ni)) {
-			mutex_unlock(&index_ni->mrec_lock);
-			iput(index_vi);
-			continue;
-		}
-
 		ictx = ntfs_index_ctx_get(index_ni, I30, 4);
 		if (!ictx) {
 			ntfs_error(sb, "Failed to get index ctx, inode %llu",
@@ -2615,7 +2753,7 @@ int ntfs_inode_sync_filename(struct ntfs_inode *ni)
 			continue;
 		}
 
-		err = ntfs_index_lookup(fn, sizeof(struct file_name_attr), ictx);
+		err = ntfs_index_lookup(update->fn, sizeof(struct file_name_attr), ictx);
 		if (err) {
 			ntfs_debug("Index lookup failed, inode %llu",
 					index_ni->mft_no);
@@ -2626,50 +2764,28 @@ int ntfs_inode_sync_filename(struct ntfs_inode *ni)
 		}
 		/* Update flags and file size. */
 		fnx = (struct file_name_attr *)ictx->data;
-		fnx->file_attributes =
-			(fnx->file_attributes & ~FILE_ATTR_VALID_FLAGS) |
-			(ni->flags & FILE_ATTR_VALID_FLAGS);
-		if (ctx->mrec->flags & MFT_RECORD_IS_DIRECTORY)
-			fnx->data_size = fnx->allocated_size = 0;
-		else {
-			read_lock_irqsave(&ni->size_lock, flags);
-			if (NInoSparse(ni) || NInoCompressed(ni))
-				fnx->allocated_size = cpu_to_le64(ni->itype.compressed.size);
-			else
-				fnx->allocated_size = cpu_to_le64(ni->allocated_size);
-			fnx->data_size = cpu_to_le64(ni->data_size);
-
-			/*
-			 * The file name record has also to be fixed if some
-			 * attribute update implied the unnamed data to be
-			 * made non-resident
-			 */
-			fn->allocated_size = fnx->allocated_size;
-			fn->data_size = fnx->data_size;
-			read_unlock_irqrestore(&ni->size_lock, flags);
-		}
+		fnx->file_attributes = update->file_attributes;
+		fnx->allocated_size = update->allocated_size;
+		fnx->data_size = update->data_size;
 
 		/* update or clear the reparse tag in the index */
-		fnx->type.rp.reparse_point_tag = reparse_tag;
-		fnx->creation_time = fn->creation_time;
-		fnx->last_data_change_time = fn->last_data_change_time;
-		fnx->last_mft_change_time = fn->last_mft_change_time;
-		fnx->last_access_time = fn->last_access_time;
+		fnx->type.rp.reparse_point_tag = update->reparse_tag;
+		fnx->creation_time = update->creation_time;
+		fnx->last_data_change_time = update->last_data_change_time;
+		fnx->last_mft_change_time = update->last_mft_change_time;
+		fnx->last_access_time = update->last_access_time;
 		ntfs_index_entry_mark_dirty(ictx);
 		ntfs_icx_ib_sync_write(ictx);
-		NInoSetDirty(ctx->ntfs_ino);
 		ntfs_index_ctx_put(ictx);
 		mutex_unlock(&index_ni->mrec_lock);
 		iput(index_vi);
 	}
-	/* Check for real error occurred. */
-	if (err != -ENOENT) {
-		ntfs_error(sb, "Attribute lookup failed, err : %d, inode %llu", err,
-				ni->mft_no);
-	} else
-		err = 0;
+	err = 0;
 
-	ntfs_attr_put_search_ctx(ctx);
+out:
+	for (i = 0; i < nr_updates; i++)
+		kfree(updates[i].fn);
+	kfree(updates);
 	return err;
 }
 
@@ -2759,11 +2875,9 @@ int __ntfs_write_inode(struct inode *vi, int sync)
 	}
 
 	if (NInoNonResident(ni) && NInoRunlistDirty(ni)) {
-		down_write(&ni->runlist.lock);
 		err = ntfs_attr_update_mapping_pairs(ni, 0);
 		if (!err)
 			NInoClearRunlistDirty(ni);
-		up_write(&ni->runlist.lock);
 	}
 
 	err = ntfs_inode_sync_standard_information(vi, m);
@@ -2778,8 +2892,18 @@ int __ntfs_write_inode(struct inode *vi, int sync)
 	 * from umount fails because of a disk unplug and etc.
 	 * the absent of SB_ACTIVE means umounting.
 	 */
-	if ((vi->i_sb->s_flags & SB_ACTIVE) && NInoTestClearFileNameDirty(ni))
+	if ((vi->i_sb->s_flags & SB_ACTIVE) && NInoTestClearFileNameDirty(ni)) {
+		unmap_mft_record(ni);
+		mutex_unlock(&ni->mrec_lock);
 		ntfs_inode_sync_filename(ni);
+		mutex_lock_nested(&ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL);
+		m = map_mft_record(ni);
+		if (IS_ERR(m)) {
+			mutex_unlock(&ni->mrec_lock);
+			err = PTR_ERR(m);
+			goto err_out;
+		}
+	}
 
 	/* Now the access times are updated, write the base mft record. */
 	if (NInoDirty(ni)) {
@@ -2982,7 +3106,7 @@ static struct ntfs_inode *ntfs_extent_inode_open(struct ntfs_inode *base_ni,
  *
  * Return 0 on success and error.
  */
-int ntfs_inode_attach_all_extents(struct ntfs_inode *ni)
+int ntfs_inode_attach_all_extents_nolock(struct ntfs_inode *ni)
 {
 	struct attr_list_entry *ale;
 	u64 prev_attached = 0;
@@ -3022,16 +3146,29 @@ int ntfs_inode_attach_all_extents(struct ntfs_inode *ni)
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
+static int __ntfs_inode_add_attrlist(struct ntfs_inode *ni, bool lock_attr_list)
 {
 	int err;
 	struct ntfs_attr_search_ctx *ctx;
+	struct ntfs_inode *attr_lock_ni = NULL;
 	u8 *al = NULL, *aln;
 	int al_len = 0;
 	struct attr_list_entry *ale = NULL;
@@ -3053,7 +3190,7 @@ int ntfs_inode_add_attrlist(struct ntfs_inode *ni)
 		return -EIO;
 
 	/* Form attribute list. */
-	ctx = ntfs_attr_get_search_ctx(ni, ni_mrec);
+	ctx = ntfs_attr_get_search_ctx(ni, ni_mrec, NTFS_ATTR_CTX_LOCK_NONE);
 	if (!ctx) {
 		err = -ENOMEM;
 		goto err_out;
@@ -3111,17 +3248,29 @@ int ntfs_inode_add_attrlist(struct ntfs_inode *ni)
 		goto put_err_out;
 	}
 
-	/* Set in-memory attribute list. */
+	if (lock_attr_list)
+		attr_lock_ni = ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LOCK_WRITE);
+	if (NInoAttrList(ni)) {
+		if (lock_attr_list)
+			ntfs_attr_list_unlock(attr_lock_ni,
+					NTFS_ATTR_CTX_LOCK_WRITE);
+		err = -EEXIST;
+		goto put_err_out;
+	}
 	ni->attr_list = al;
 	ni->attr_list_size = al_len;
 	NInoSetAttrList(ni);
+	if (lock_attr_list) {
+		ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
+		attr_lock_ni = NULL;
+	}
 
 	attr_al_len = offsetof(struct attr_record, data.resident.reserved) + 1 +
 		((al_len + 7) & ~7);
 	/* Free space if there is not enough it for $ATTRIBUTE_LIST. */
 	if (le32_to_cpu(ni_mrec->bytes_allocated) -
 			le32_to_cpu(ni_mrec->bytes_in_use) < attr_al_len) {
-		if (ntfs_inode_free_space(ni, (int)attr_al_len)) {
+		if (ntfs_inode_free_space_nolock(ni, (int)attr_al_len)) {
 			/* Failed to free space. */
 			err = -ENOSPC;
 			ntfs_error(ni->vol->sb, "Failed to free space for attrlist");
@@ -3129,6 +3278,8 @@ int ntfs_inode_add_attrlist(struct ntfs_inode *ni)
 		}
 	}
 
+	if (lock_attr_list)
+		attr_lock_ni = ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LOCK_WRITE);
 	/* Add $ATTRIBUTE_LIST to mft record. */
 	err = ntfs_resident_attr_record_add(ni, AT_ATTRIBUTE_LIST, AT_UNNAMED, 0,
 					    NULL, al_len, 0);
@@ -3137,10 +3288,14 @@ int ntfs_inode_add_attrlist(struct ntfs_inode *ni)
 		goto rollback;
 	}
 
-	err = ntfs_attrlist_update(ni);
+	err = ntfs_attrlist_update_nolock(ni);
 	if (err < 0)
 		goto remove_attrlist_record;
 
+	if (lock_attr_list) {
+		ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
+		attr_lock_ni = NULL;
+	}
 	ntfs_attr_put_search_ctx(ctx);
 	unmap_mft_record(ni);
 	return 0;
@@ -3148,6 +3303,7 @@ int ntfs_inode_add_attrlist(struct ntfs_inode *ni)
 remove_attrlist_record:
 	/* Prevent ntfs_attr_recorm_rm from freeing attribute list. */
 	ni->attr_list = NULL;
+	ni->attr_list_size = 0;
 	NInoClearAttrList(ni);
 	/* Remove $ATTRIBUTE_LIST record. */
 	ntfs_attr_reinit_search_ctx(ctx);
@@ -3164,6 +3320,8 @@ int ntfs_inode_add_attrlist(struct ntfs_inode *ni)
 	ni->attr_list_size = al_len;
 	NInoSetAttrList(ni);
 rollback:
+	if (lock_attr_list && !attr_lock_ni)
+		attr_lock_ni = ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LOCK_WRITE);
 	/*
 	 * Scan attribute list for attributes that placed not in the base MFT
 	 * record and move them to it.
@@ -3193,14 +3351,30 @@ int ntfs_inode_add_attrlist(struct ntfs_inode *ni)
 	ni->attr_list_size = 0;
 	NInoClearAttrList(ni);
 	NInoClearAttrListDirty(ni);
+	if (lock_attr_list) {
+		ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
+		attr_lock_ni = NULL;
+	}
 put_err_out:
 	ntfs_attr_put_search_ctx(ctx);
 err_out:
+	if (lock_attr_list)
+		ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
 	kvfree(al);
 	unmap_mft_record(ni);
 	return err;
 }
 
+int ntfs_inode_add_attrlist_nolock(struct ntfs_inode *ni)
+{
+	return __ntfs_inode_add_attrlist(ni, false);
+}
+
+int ntfs_inode_add_attrlist(struct ntfs_inode *ni)
+{
+	return __ntfs_inode_add_attrlist(ni, true);
+}
+
 /*
  * ntfs_inode_close - close an ntfs inode and free all associated memory
  * @ni:		ntfs inode to close
@@ -3344,7 +3518,8 @@ static int ntfs_attr_position(__le32 type, struct ntfs_attr_search_ctx *ctx)
  *
  * Return 0 on success or error.
  */
-int ntfs_inode_free_space(struct ntfs_inode *ni, int size)
+static int __ntfs_inode_free_space(struct ntfs_inode *ni, int size,
+				   enum ntfs_attr_search_ctx_lock_mode lock_mode)
 {
 	struct ntfs_attr_search_ctx *ctx;
 	int freed, err;
@@ -3368,7 +3543,7 @@ int ntfs_inode_free_space(struct ntfs_inode *ni, int size)
 	if (size <= freed)
 		return 0;
 
-	ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	ctx = ntfs_attr_get_search_ctx(ni, NULL, lock_mode);
 	if (!ctx) {
 		ntfs_error(sb, "%s, Failed to get search context", __func__);
 		return -ENOMEM;
@@ -3454,11 +3629,30 @@ int ntfs_inode_free_space(struct ntfs_inode *ni, int size)
 	return err;
 }
 
-s64 ntfs_inode_attr_pread(struct inode *vi, s64 pos, s64 count, u8 *buf)
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
+static s64 __ntfs_inode_attr_pread(struct inode *vi, s64 pos, s64 count,
+		u8 *buf, enum ntfs_attr_search_ctx_lock_mode lock_mode)
 {
 	struct address_space *mapping = vi->i_mapping;
 	struct folio *folio;
 	struct ntfs_inode *ni = NTFS_I(vi);
+	struct ntfs_inode *attr_lock_ni = NULL;
 	s64 isize;
 	u32 attr_len, total = 0, offset;
 	pgoff_t index;
@@ -3468,24 +3662,29 @@ s64 ntfs_inode_attr_pread(struct inode *vi, s64 pos, s64 count, u8 *buf)
 	if (!count)
 		return 0;
 
+	if (!NInoNonResident(ni))
+		attr_lock_ni = ntfs_attr_list_lock(ni, lock_mode);
 	mutex_lock(&ni->mrec_lock);
 	isize = i_size_read(vi);
 	if (pos > isize) {
 		mutex_unlock(&ni->mrec_lock);
+		ntfs_attr_list_unlock(attr_lock_ni, lock_mode);
 		return -EINVAL;
 	}
 	if (pos + count > isize)
 		count = isize - pos;
 
 	if (!NInoNonResident(ni)) {
+		struct ntfs_inode *base_ni = ni->ext.base_ntfs_ino;
 		struct ntfs_attr_search_ctx *ctx;
 		u8 *attr;
 
-		ctx = ntfs_attr_get_search_ctx(ni->ext.base_ntfs_ino, NULL);
+		ctx = ntfs_attr_get_search_ctx(base_ni, NULL, NTFS_ATTR_CTX_LOCK_NONE);
 		if (!ctx) {
 			ntfs_error(vi->i_sb, "Failed to get attr search ctx");
 			err = -ENOMEM;
 			mutex_unlock(&ni->mrec_lock);
+			ntfs_attr_list_unlock(attr_lock_ni, lock_mode);
 			goto out;
 		}
 
@@ -3495,6 +3694,7 @@ s64 ntfs_inode_attr_pread(struct inode *vi, s64 pos, s64 count, u8 *buf)
 			ntfs_error(vi->i_sb, "Failed to look up attr %#x", ni->type);
 			ntfs_attr_put_search_ctx(ctx);
 			mutex_unlock(&ni->mrec_lock);
+			ntfs_attr_list_unlock(attr_lock_ni, lock_mode);
 			goto out;
 		}
 
@@ -3502,6 +3702,7 @@ s64 ntfs_inode_attr_pread(struct inode *vi, s64 pos, s64 count, u8 *buf)
 		memcpy(buf, (u8 *)attr + pos, count);
 		ntfs_attr_put_search_ctx(ctx);
 		mutex_unlock(&ni->mrec_lock);
+		ntfs_attr_list_unlock(attr_lock_ni, lock_mode);
 		return count;
 	}
 	mutex_unlock(&ni->mrec_lock);
@@ -3509,7 +3710,10 @@ s64 ntfs_inode_attr_pread(struct inode *vi, s64 pos, s64 count, u8 *buf)
 	index = pos >> PAGE_SHIFT;
 	do {
 		/* Update @index and get the next folio. */
-		folio = read_mapping_folio(mapping, index, NULL);
+		folio = lock_mode == NTFS_ATTR_CTX_LOCK_NONE ?
+				read_cache_folio(mapping, index,
+						ntfs_read_folio_nolock, NULL) :
+				read_mapping_folio(mapping, index, NULL);
 		if (IS_ERR(folio))
 			break;
 
@@ -3531,6 +3735,19 @@ s64 ntfs_inode_attr_pread(struct inode *vi, s64 pos, s64 count, u8 *buf)
 	return err ? (s64)err : total;
 }
 
+s64 ntfs_inode_attr_pread_nolock(struct inode *vi, s64 pos, s64 count,
+		u8 *buf)
+{
+	return __ntfs_inode_attr_pread(vi, pos, count, buf,
+			NTFS_ATTR_CTX_LOCK_NONE);
+}
+
+s64 ntfs_inode_attr_pread(struct inode *vi, s64 pos, s64 count, u8 *buf)
+{
+	return __ntfs_inode_attr_pread(vi, pos, count, buf,
+			NTFS_ATTR_CTX_LOCK_READ);
+}
+
 static inline int ntfs_enlarge_attribute(struct inode *vi, s64 pos, s64 count,
 					 struct ntfs_attr_search_ctx *ctx)
 {
@@ -3548,7 +3765,7 @@ static inline int ntfs_enlarge_attribute(struct inode *vi, s64 pos, s64 count,
 		return -EOPNOTSUPP;
 
 	if (pos + count > ni->data_size) {
-		if (ntfs_attr_truncate(ni, pos + count)) {
+		if (ntfs_attr_truncate_nolock(ni, pos + count)) {
 			ntfs_debug("Failed to truncate attribute");
 			return -1;
 		}
@@ -3624,7 +3841,8 @@ static s64 __ntfs_inode_resident_attr_pwrite(struct inode *vi,
 static s64 __ntfs_inode_non_resident_attr_pwrite(struct inode *vi,
 						 s64 pos, s64 count, u8 *buf,
 						 struct ntfs_attr_search_ctx *ctx,
-						 bool sync)
+						 bool sync,
+						 enum ntfs_attr_search_ctx_lock_mode lock_mode)
 {
 	struct ntfs_inode *ni = NTFS_I(vi);
 	struct address_space *mapping = vi->i_mapping;
@@ -3647,7 +3865,8 @@ static s64 __ntfs_inode_non_resident_attr_pwrite(struct inode *vi,
 				break;
 			}
 		} else {
-			folio = read_mapping_folio(mapping, index, NULL);
+			folio = read_cache_folio(mapping, index,
+					ntfs_read_folio_nolock, NULL);
 			if (IS_ERR(folio)) {
 				ret = PTR_ERR(folio);
 				ntfs_error(vi->i_sb, "Failed to read a page %lu for attr %#x: %ld",
@@ -3669,6 +3888,8 @@ static s64 __ntfs_inode_non_resident_attr_pwrite(struct inode *vi,
 
 		if (sync) {
 			struct ntfs_volume *vol = ni->vol;
+			struct ntfs_inode *attr_lock_ni;
+			enum ntfs_attr_search_ctx_lock_mode mode;
 			s64 lcn, lcn_count;
 			unsigned int lcn_folio_off = 0;
 			struct bio *bio;
@@ -3678,13 +3899,16 @@ static s64 __ntfs_inode_non_resident_attr_pwrite(struct inode *vi,
 
 			lcn_count = max_t(s64, 1, ntfs_bytes_to_cluster(vol, attr_len));
 			vcn = ntfs_pidx_to_cluster(vol, folio->index);
+				mode = NTFS_ATTR_CTX_LOCK_NONE;
 
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
 
@@ -3696,6 +3920,7 @@ static s64 __ntfs_inode_non_resident_attr_pwrite(struct inode *vi,
 					lcn_count = 0;
 				}
 				up_write(&ni->runlist.lock);
+				ntfs_attr_list_unlock(attr_lock_ni, mode);
 
 				if (vol->cluster_size_bits > PAGE_SHIFT) {
 					lcn_folio_off = folio->index << PAGE_SHIFT;
@@ -3748,7 +3973,9 @@ static s64 __ntfs_inode_non_resident_attr_pwrite(struct inode *vi,
 	return ret ? ret : written;
 }
 
-s64 ntfs_inode_attr_pwrite(struct inode *vi, s64 pos, s64 count, u8 *buf, bool sync)
+static s64 __ntfs_inode_attr_pwrite(struct inode *vi, s64 pos, s64 count,
+				    u8 *buf, bool sync,
+				    enum ntfs_attr_search_ctx_lock_mode lock_mode)
 {
 	struct ntfs_inode *ni = NTFS_I(vi);
 	struct ntfs_attr_search_ctx *ctx;
@@ -3756,7 +3983,7 @@ s64 ntfs_inode_attr_pwrite(struct inode *vi, s64 pos, s64 count, u8 *buf, bool s
 
 	WARN_ON(!NInoAttr(ni));
 
-	ctx = ntfs_attr_get_search_ctx(ni->ext.base_ntfs_ino, NULL);
+	ctx = ntfs_attr_get_search_ctx(ni->ext.base_ntfs_ino, NULL, lock_mode);
 	if (!ctx) {
 		ntfs_error(vi->i_sb, "Failed to get attr search ctx");
 		return -ENOMEM;
@@ -3777,7 +4004,8 @@ s64 ntfs_inode_attr_pwrite(struct inode *vi, s64 pos, s64 count, u8 *buf, bool s
 		goto out;
 
 	if (NInoNonResident(ni))
-		ret = __ntfs_inode_non_resident_attr_pwrite(vi, pos, count, buf, ctx, sync);
+		ret = __ntfs_inode_non_resident_attr_pwrite(vi, pos, count,
+				buf, ctx, sync, lock_mode);
 	else
 		ret = __ntfs_inode_resident_attr_pwrite(vi, pos, count, buf, ctx);
 out:
@@ -3785,6 +4013,27 @@ s64 ntfs_inode_attr_pwrite(struct inode *vi, s64 pos, s64 count, u8 *buf, bool s
 	return ret;
 }
 
+s64 ntfs_inode_attr_pwrite_nolock(struct inode *vi, s64 pos, s64 count,
+				  u8 *buf, bool sync)
+{
+	return __ntfs_inode_attr_pwrite(vi, pos, count, buf, sync,
+			NTFS_ATTR_CTX_LOCK_NONE);
+}
+
+s64 ntfs_inode_attr_pwrite_nested(struct inode *vi, s64 pos, s64 count,
+				  u8 *buf, bool sync)
+{
+	return __ntfs_inode_attr_pwrite(vi, pos, count, buf, sync,
+			NTFS_ATTR_CTX_LOCK_READ_NESTED);
+}
+
+s64 ntfs_inode_attr_pwrite(struct inode *vi, s64 pos, s64 count, u8 *buf,
+			   bool sync)
+{
+	return __ntfs_inode_attr_pwrite(vi, pos, count, buf, sync,
+			NTFS_ATTR_CTX_LOCK_READ);
+}
+
 struct folio *ntfs_get_locked_folio(struct address_space *mapping,
 		pgoff_t index, pgoff_t end_index, struct file_ra_state *ra)
 {
diff --git a/fs/ntfs/inode.h b/fs/ntfs/inode.h
index 9aacd5787ffea..fe6803039a46d 100644
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
@@ -303,10 +307,14 @@ struct ntfs_attr {
 
 int ntfs_test_inode(struct inode *vi, void *data);
 struct inode *ntfs_iget(struct super_block *sb, u64 mft_no);
+struct inode *ntfs_attr_iget_nolock(struct inode *base_vi, __le32 type,
+		__le16 *name, u32 name_len);
 struct inode *ntfs_attr_iget(struct inode *base_vi, __le32 type,
 		__le16 *name, u32 name_len);
 struct inode *ntfs_index_iget(struct inode *base_vi, __le16 *name,
 		u32 name_len);
+struct inode *ntfs_index_iget_nested(struct inode *base_vi, __le16 *name,
+		u32 name_len);
 struct inode *ntfs_alloc_big_inode(struct super_block *sb);
 void ntfs_free_big_inode(struct inode *inode);
 int ntfs_drop_big_inode(struct inode *inode);
@@ -336,13 +344,22 @@ int ntfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 
 int ntfs_get_block_mft_record(struct ntfs_inode *mft_ni, struct ntfs_inode *ni);
 int __ntfs_write_inode(struct inode *vi, int sync);
+int ntfs_inode_attach_all_extents_nolock(struct ntfs_inode *ni);
 int ntfs_inode_attach_all_extents(struct ntfs_inode *ni);
+int ntfs_inode_add_attrlist_nolock(struct ntfs_inode *ni);
 int ntfs_inode_add_attrlist(struct ntfs_inode *ni);
 void ntfs_destroy_ext_inode(struct ntfs_inode *ni);
+int ntfs_inode_free_space_nolock(struct ntfs_inode *ni, int size);
 int ntfs_inode_free_space(struct ntfs_inode *ni, int size);
+s64 ntfs_inode_attr_pread_nolock(struct inode *vi, s64 pos, s64 count,
+		u8 *buf);
 s64 ntfs_inode_attr_pread(struct inode *vi, s64 pos, s64 count, u8 *buf);
 s64 ntfs_inode_attr_pwrite(struct inode *vi, s64 pos, s64 count, u8 *buf,
 		bool sync);
+s64 ntfs_inode_attr_pwrite_nested(struct inode *vi, s64 pos, s64 count,
+		u8 *buf, bool sync);
+s64 ntfs_inode_attr_pwrite_nolock(struct inode *vi, s64 pos, s64 count,
+		u8 *buf, bool sync);
 int ntfs_inode_close(struct ntfs_inode *ni);
 
 static inline void ntfs_commit_inode(struct inode *vi)
diff --git a/fs/ntfs/iomap.c b/fs/ntfs/iomap.c
index 52eecf5cb256a..7b87188ab1fb0 100644
--- a/fs/ntfs/iomap.c
+++ b/fs/ntfs/iomap.c
@@ -80,8 +80,9 @@ const struct iomap_write_ops ntfs_iomap_folio_ops = {
 	.put_folio = ntfs_iomap_put_folio,
 };
 
-static int ntfs_read_iomap_begin_resident(struct inode *inode, loff_t offset, loff_t length,
-		unsigned int flags, struct iomap *iomap)
+static int ntfs_read_iomap_begin_resident(struct inode *inode, loff_t offset,
+		loff_t length, unsigned int flags, struct iomap *iomap,
+		enum ntfs_attr_search_ctx_lock_mode lock_mode)
 {
 	struct ntfs_inode *base_ni, *ni = NTFS_I(inode);
 	struct ntfs_attr_search_ctx *ctx;
@@ -95,7 +96,7 @@ static int ntfs_read_iomap_begin_resident(struct inode *inode, loff_t offset, lo
 	else
 		base_ni = ni;
 
-	ctx = ntfs_attr_get_search_ctx(base_ni, NULL);
+	ctx = ntfs_attr_get_search_ctx(base_ni, NULL, lock_mode);
 	if (!ctx) {
 		err = -ENOMEM;
 		goto out;
@@ -184,34 +185,47 @@ static int ntfs_read_iomap_begin_resident(struct inode *inode, loff_t offset, lo
  */
 static int ntfs_read_iomap_begin_non_resident(struct inode *inode, loff_t offset,
 		loff_t length, unsigned int flags, struct iomap *iomap,
-		bool need_unwritten)
+		bool need_unwritten,
+		enum ntfs_attr_search_ctx_lock_mode lock_mode)
 {
 	struct ntfs_inode *ni = NTFS_I(inode);
+	struct ntfs_inode *attr_lock_ni;
 	s64 vcn;
 	s64 lcn;
 	struct runlist_element *rl;
 	struct ntfs_volume *vol = ni->vol;
 	loff_t vcn_ofs;
 	loff_t rl_length;
+	s64 rl_remaining;
 
 	vcn = ntfs_bytes_to_cluster(vol, offset);
 	vcn_ofs = ntfs_bytes_to_cluster_off(vol, offset);
 
+	attr_lock_ni = ntfs_attr_list_lock(ni, lock_mode);
 	down_write(&ni->runlist.lock);
 	rl = ntfs_attr_vcn_to_rl(ni, vcn, &lcn);
 	if (IS_ERR(rl)) {
 		up_write(&ni->runlist.lock);
+		ntfs_attr_list_unlock(attr_lock_ni, lock_mode);
 		return PTR_ERR(rl);
 	}
 
-	if (flags & IOMAP_REPORT) {
-		if (lcn < LCN_HOLE) {
-			up_write(&ni->runlist.lock);
-			return -ENOENT;
-		}
-	} else if (lcn < LCN_ENOENT) {
+	if (flags & IOMAP_REPORT && lcn < LCN_HOLE) {
 		up_write(&ni->runlist.lock);
-		return -EINVAL;
+		ntfs_attr_list_unlock(attr_lock_ni, lock_mode);
+		return -ENOENT;
+	} else if (lcn < LCN_HOLE) {
+		int err;
+
+		if (lcn == LCN_ENOENT)
+			err = -ENOENT;
+		else if (lcn == LCN_ENOMEM)
+			err = -ENOMEM;
+		else
+			err = -EIO;
+		up_write(&ni->runlist.lock);
+		ntfs_attr_list_unlock(attr_lock_ni, lock_mode);
+		return err;
 	}
 
 	iomap->bdev = inode->i_sb->s_bdev;
@@ -231,21 +245,33 @@ static int ntfs_read_iomap_begin_non_resident(struct inode *inode, loff_t offset
 		iomap->addr = ntfs_cluster_to_bytes(vol, lcn) + vcn_ofs;
 	}
 
-	rl_length = ntfs_cluster_to_bytes(vol, rl->length - (vcn - rl->vcn));
+	rl_remaining = rl->length - (vcn - rl->vcn);
+	if (rl_remaining <= 0 ||
+	    rl_remaining > (LLONG_MAX >> vol->cluster_size_bits)) {
+		ntfs_error(inode->i_sb,
+				"runlist(vcn : %lld, length : %lld, lcn : %lld) is corrupted\n",
+				rl->vcn, rl->length, rl->lcn);
+		up_write(&ni->runlist.lock);
+		ntfs_attr_list_unlock(attr_lock_ni, lock_mode);
+		return -EIO;
+	}
 
-	if (rl_length == 0 && rl->lcn > LCN_DELALLOC) {
+	rl_length = ntfs_cluster_to_bytes(vol, rl_remaining);
+	if (rl_length <= vcn_ofs) {
 		ntfs_error(inode->i_sb,
 				"runlist(vcn : %lld, length : %lld, lcn : %lld) is corrupted\n",
 				rl->vcn, rl->length, rl->lcn);
 		up_write(&ni->runlist.lock);
+		ntfs_attr_list_unlock(attr_lock_ni, lock_mode);
 		return -EIO;
 	}
 
-	if (rl_length && length > rl_length - vcn_ofs)
+	if (length > rl_length - vcn_ofs)
 		iomap->length = rl_length - vcn_ofs;
 	else
 		iomap->length = length;
 	up_write(&ni->runlist.lock);
+	ntfs_attr_list_unlock(attr_lock_ni, lock_mode);
 
 	if (!(flags & IOMAP_ZERO) &&
 			iomap->type == IOMAP_MAPPED &&
@@ -261,26 +287,51 @@ static int ntfs_read_iomap_begin_non_resident(struct inode *inode, loff_t offset
 
 static int __ntfs_read_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		unsigned int flags, struct iomap *iomap, struct iomap *srcmap,
-		bool need_unwritten)
+		bool need_unwritten,
+		enum ntfs_attr_search_ctx_lock_mode lock_mode)
 {
 	if (NInoNonResident(NTFS_I(inode)))
 		return ntfs_read_iomap_begin_non_resident(inode, offset, length,
-				flags, iomap, need_unwritten);
+				flags, iomap, need_unwritten, lock_mode);
 	return ntfs_read_iomap_begin_resident(inode, offset, length,
-					     flags, iomap);
+					     flags, iomap, lock_mode);
 }
 
 static int ntfs_read_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
 {
 	return __ntfs_read_iomap_begin(inode, offset, length, flags, iomap,
-			srcmap, true);
+			srcmap, true, NTFS_ATTR_CTX_LOCK_READ);
 }
 
 const struct iomap_ops ntfs_read_iomap_ops = {
 	.iomap_begin = ntfs_read_iomap_begin,
 };
 
+static int ntfs_read_iomap_begin_nested(struct inode *inode, loff_t offset,
+		loff_t length, unsigned int flags, struct iomap *iomap,
+		struct iomap *srcmap)
+{
+	return __ntfs_read_iomap_begin(inode, offset, length, flags, iomap,
+			srcmap, true, NTFS_ATTR_CTX_LOCK_READ_NESTED);
+}
+
+const struct iomap_ops ntfs_read_iomap_nested_ops = {
+	.iomap_begin = ntfs_read_iomap_begin_nested,
+};
+
+static int ntfs_read_iomap_begin_nolock(struct inode *inode, loff_t offset,
+		loff_t length, unsigned int flags, struct iomap *iomap,
+		struct iomap *srcmap)
+{
+	return __ntfs_read_iomap_begin(inode, offset, length, flags, iomap,
+			srcmap, true, NTFS_ATTR_CTX_LOCK_NONE);
+}
+
+const struct iomap_ops ntfs_read_iomap_nolock_ops = {
+	.iomap_begin = ntfs_read_iomap_begin_nolock,
+};
+
 /*
  * Check that the cached iomap still matches the NTFS runlist before
  * iomap_zero_range() is called. if the runlist changes while iomap is
@@ -318,7 +369,7 @@ static int ntfs_seek_iomap_begin(struct inode *inode, loff_t offset, loff_t leng
 		unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
 {
 	return __ntfs_read_iomap_begin(inode, offset, length, flags, iomap,
-			srcmap, false);
+			srcmap, false, NTFS_ATTR_CTX_LOCK_READ);
 }
 
 static int ntfs_zero_read_iomap_end(struct inode *inode, loff_t pos, loff_t length,
@@ -361,7 +412,8 @@ static int ntfs_zero_range(struct inode *inode, loff_t offset, loff_t length)
 }
 
 static int ntfs_write_simple_iomap_begin_non_resident(struct inode *inode, loff_t offset,
-						      loff_t length, struct iomap *iomap)
+		loff_t length, struct iomap *iomap,
+		struct ntfs_inode *attr_lock_ni)
 {
 	struct ntfs_inode *ni = NTFS_I(inode);
 	struct ntfs_volume *vol = ni->vol;
@@ -380,8 +432,11 @@ static int ntfs_write_simple_iomap_begin_non_resident(struct inode *inode, loff_
 	rl = ni->runlist.rl;
 	if (!rl) {
 		up_read(&ni->runlist.lock);
-		err = ntfs_map_runlist(ni, vcn);
+		down_write(&ni->runlist.lock);
+		err = ntfs_map_runlist_nolock(ni, vcn, NULL);
+		up_write(&ni->runlist.lock);
 		if (err) {
+			ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_READ);
 			mutex_unlock(&ni->mrec_lock);
 			return -ENOENT;
 		}
@@ -396,6 +451,7 @@ static int ntfs_write_simple_iomap_begin_non_resident(struct inode *inode, loff_
 	rl = __ntfs_attr_find_vcn_nolock(&ni->runlist, vcn);
 	if (IS_ERR(rl)) {
 		up_write(&ni->runlist.lock);
+		ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_READ);
 		mutex_unlock(&ni->mrec_lock);
 		return -EIO;
 	}
@@ -415,6 +471,7 @@ static int ntfs_write_simple_iomap_begin_non_resident(struct inode *inode, loff_
 				"runlist(vcn : %lld, length : %lld) is corrupted\n",
 				rl->vcn, rl->length);
 		up_write(&ni->runlist.lock);
+		ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_READ);
 		mutex_unlock(&ni->mrec_lock);
 		return -EIO;
 	}
@@ -429,6 +486,7 @@ static int ntfs_write_simple_iomap_begin_non_resident(struct inode *inode, loff_
 			if (max_clu_count < 0) {
 				err = max_clu_count;
 				up_write(&ni->runlist.lock);
+				ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_READ);
 				mutex_unlock(&ni->mrec_lock);
 				return err;
 			}
@@ -444,6 +502,7 @@ static int ntfs_write_simple_iomap_begin_non_resident(struct inode *inode, loff_
 					GFP_NOFS);
 			if (!rlc) {
 				up_write(&ni->runlist.lock);
+				ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_READ);
 				mutex_unlock(&ni->mrec_lock);
 				return -ENOMEM;
 			}
@@ -461,6 +520,7 @@ static int ntfs_write_simple_iomap_begin_non_resident(struct inode *inode, loff_
 			if (IS_ERR(rl)) {
 				ntfs_error(vol->sb, "Failed to merge runlists");
 				up_write(&ni->runlist.lock);
+				ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_READ);
 				mutex_unlock(&ni->mrec_lock);
 				kvfree(rlc);
 				return PTR_ERR(rl);
@@ -471,6 +531,7 @@ static int ntfs_write_simple_iomap_begin_non_resident(struct inode *inode, loff_
 			ni->i_dealloc_clusters += max_clu_count;
 		}
 		up_write(&ni->runlist.lock);
+		ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_READ);
 		mutex_unlock(&ni->mrec_lock);
 
 		if (lcn < LCN_DELALLOC)
@@ -523,6 +584,7 @@ static int ntfs_write_simple_iomap_begin_non_resident(struct inode *inode, loff_
 		}
 	} else {
 		up_write(&ni->runlist.lock);
+		ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_READ);
 		mutex_unlock(&ni->mrec_lock);
 
 		iomap->type = IOMAP_MAPPED;
@@ -545,13 +607,14 @@ static int ntfs_write_simple_iomap_begin_non_resident(struct inode *inode, loff_
 
 static int ntfs_write_da_iomap_begin_non_resident(struct inode *inode,
 		loff_t offset, loff_t length, unsigned int flags,
-		struct iomap *iomap, int ntfs_iomap_flags)
+		struct iomap *iomap, int ntfs_iomap_flags,
+		struct ntfs_inode *attr_lock_ni)
 {
 	struct ntfs_inode *ni = NTFS_I(inode);
 	struct ntfs_volume *vol = ni->vol;
 	loff_t vcn_ofs, rl_length;
 	s64 vcn, start_lcn, lcn_count;
-	bool balloc = false, update_mp;
+	bool balloc = false, update_mp, defer_update_mp;
 	int err;
 	s64 max_clu_count =
 		ntfs_bytes_to_cluster(vol, round_up(length, vol->cluster_size));
@@ -560,12 +623,24 @@ static int ntfs_write_da_iomap_begin_non_resident(struct inode *inode,
 	vcn_ofs = ntfs_bytes_to_cluster_off(vol, offset);
 
 	update_mp = ntfs_iomap_flags & (NTFS_IOMAP_FLAGS_DIO | NTFS_IOMAP_FLAGS_MKWRITE) ||
-			NInoAttr(ni) || ni->mft_no < FILE_first_user;
+				NInoAttr(ni) || ni->mft_no < FILE_first_user;
+	defer_update_mp = update_mp ||
+			(ntfs_iomap_flags & NTFS_IOMAP_FLAGS_WRITEBACK);
 	down_write(&ni->runlist.lock);
 	err = ntfs_attr_map_cluster(ni, vcn, &start_lcn, &lcn_count,
-			max_clu_count, &balloc, update_mp,
-			ntfs_iomap_flags & NTFS_IOMAP_FLAGS_WRITEBACK);
+			max_clu_count, &balloc, false,
+			ntfs_iomap_flags & NTFS_IOMAP_FLAGS_WRITEBACK,
+			defer_update_mp);
 	up_write(&ni->runlist.lock);
+	if (!err && defer_update_mp && NInoRunlistDirty(ni)) {
+		ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
+		attr_lock_ni = NULL;
+		err = ntfs_attr_update_mapping_pairs(ni, 0);
+		if (!err)
+			NInoClearRunlistDirty(ni);
+	}
+	if (attr_lock_ni)
+		ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
 	mutex_unlock(&ni->mrec_lock);
 	if (err) {
 		ni->i_dealloc_clusters = 0;
@@ -637,7 +712,7 @@ static int ntfs_write_iomap_begin_resident(struct inode *inode, loff_t offset,
 	int err = 0;
 	char *kattr;
 
-	ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	ctx = ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_READ);
 	if (!ctx) {
 		err = -ENOMEM;
 		goto out;
@@ -676,6 +751,7 @@ static int ntfs_write_iomap_begin_non_resident(struct inode *inode, loff_t offse
 					       struct iomap *iomap, int ntfs_iomap_flags)
 {
 	struct ntfs_inode *ni = NTFS_I(inode);
+	struct ntfs_inode *attr_lock_ni;
 
 	if (ntfs_iomap_flags & (NTFS_IOMAP_FLAGS_BEGIN | NTFS_IOMAP_FLAGS_DIO) &&
 	    offset + length > ni->initialized_size) {
@@ -689,15 +765,33 @@ static int ntfs_write_iomap_begin_non_resident(struct inode *inode, loff_t offse
 			return ret;
 	}
 
-	mutex_lock(&ni->mrec_lock);
+	if (NInoAttr(ni)) {
+		if (ntfs_iomap_flags & NTFS_IOMAP_FLAGS_BEGIN)
+			attr_lock_ni = ntfs_attr_list_lock(ni,
+					NTFS_ATTR_CTX_LOCK_READ);
+		else
+			attr_lock_ni = ntfs_attr_list_lock(ni,
+					NTFS_ATTR_CTX_LOCK_WRITE);
+		mutex_lock(&ni->mrec_lock);
+	} else {
+		mutex_lock(&ni->mrec_lock);
+		if (ntfs_iomap_flags & NTFS_IOMAP_FLAGS_BEGIN)
+			attr_lock_ni = ntfs_attr_list_lock(ni,
+					NTFS_ATTR_CTX_LOCK_READ);
+		else
+			attr_lock_ni = ntfs_attr_list_lock(ni,
+					NTFS_ATTR_CTX_LOCK_WRITE);
+	}
 	if (ntfs_iomap_flags & NTFS_IOMAP_FLAGS_BEGIN)
 		return  ntfs_write_simple_iomap_begin_non_resident(inode, offset,
-								   length, iomap);
+								   length, iomap,
+								   attr_lock_ni);
 	else
 		return ntfs_write_da_iomap_begin_non_resident(inode,
 							      offset, length,
 							      flags, iomap,
-							      ntfs_iomap_flags);
+							      ntfs_iomap_flags,
+							      attr_lock_ni);
 }
 
 static int __ntfs_write_iomap_begin(struct inode *inode, loff_t offset,
diff --git a/fs/ntfs/iomap.h b/fs/ntfs/iomap.h
index 3abc1d493e918..f9a7290661020 100644
--- a/fs/ntfs/iomap.h
+++ b/fs/ntfs/iomap.h
@@ -14,10 +14,13 @@
 
 extern const struct iomap_ops ntfs_write_iomap_ops;
 extern const struct iomap_ops ntfs_read_iomap_ops;
+extern const struct iomap_ops ntfs_read_iomap_nested_ops;
+extern const struct iomap_ops ntfs_read_iomap_nolock_ops;
 extern const struct iomap_ops ntfs_seek_iomap_ops;
 extern const struct iomap_ops ntfs_page_mkwrite_iomap_ops;
 extern const struct iomap_ops ntfs_dio_iomap_ops;
 extern const struct iomap_writeback_ops ntfs_writeback_ops;
 extern const struct iomap_write_ops ntfs_iomap_folio_ops;
 extern int ntfs_dio_zero_range(struct inode *inode, loff_t offset, loff_t length);
+int ntfs_read_folio_nolock(struct file *file, struct folio *folio);
 #endif /* _LINUX_NTFS_IOMAP_H */
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
index 78c159519f9ce..3d36dc9642e2f 100644
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
@@ -781,7 +781,7 @@ static int ntfs_check_unlinkable_dir(struct ntfs_attr_search_ctx *ctx, struct fi
 	struct ntfs_inode *ni = ctx->base_ntfs_ino ? ctx->base_ntfs_ino : ctx->ntfs_ino;
 	struct mft_record *ni_mrec = ctx->base_mrec ? ctx->base_mrec : ctx->mrec;
 
-	ret = ntfs_check_empty_dir(ni, ni_mrec);
+	ret = ntfs_check_empty_dir_nolock(ni, ni_mrec);
 	if (!ret || ret != -ENOTEMPTY)
 		return ret;
 
@@ -859,7 +859,7 @@ static int ntfs_delete(struct ntfs_inode *ni, struct ntfs_inode *dir_ni,
 	 * If filename in DOS or in WIN32 namespace, then remove DOS name first,
 	 * only then remove WIN32 name.
 	 */
-	actx = ntfs_attr_get_search_ctx(ni, NULL);
+	actx = ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_WRITE);
 	if (!actx) {
 		ntfs_error(sb, "%s, Failed to get search context", __func__);
 		if (need_lock) {
@@ -938,7 +938,8 @@ static int ntfs_delete(struct ntfs_inode *ni, struct ntfs_inode *dir_ni,
 	if (err)
 		goto err_out;
 
-	err = ntfs_index_remove(dir_ni, fn, le32_to_cpu(actx->attr->data.resident.value_length));
+	err = ntfs_index_remove_nested(dir_ni, fn,
+			le32_to_cpu(actx->attr->data.resident.value_length));
 	if (err)
 		goto err_out;
 
@@ -973,12 +974,15 @@ static int ntfs_delete(struct ntfs_inode *ni, struct ntfs_inode *dir_ni,
 	 */
 	if (ni_mrec->link_count == 0) {
 		NInoSetBeingDeleted(ni);
+		ntfs_attr_put_search_ctx(actx);
+		actx = NULL;
 		ntfs_delete_reparse_index(ni);
 		ntfs_delete_object_id_index(ni);
 		link_count_zero = true;
 	}
 
-	ntfs_attr_put_search_ctx(actx);
+	if (actx)
+		ntfs_attr_put_search_ctx(actx);
 	if (need_lock == true) {
 		mutex_unlock(&dir_ni->mrec_lock);
 		mutex_unlock(&ni->mrec_lock);
@@ -1001,7 +1005,8 @@ static int ntfs_delete(struct ntfs_inode *ni, struct ntfs_inode *dir_ni,
 	ntfs_debug("Done.\n");
 	return 0;
 err_out:
-	ntfs_attr_put_search_ctx(actx);
+	if (actx)
+		ntfs_attr_put_search_ctx(actx);
 	if (need_lock) {
 		mutex_unlock(&dir_ni->mrec_lock);
 		mutex_unlock(&ni->mrec_lock);
@@ -1607,7 +1612,7 @@ static struct dentry *ntfs_get_parent(struct dentry *child_dent)
 	if (IS_ERR(mrec))
 		return ERR_CAST(mrec);
 	/* Find the first file name attribute in the mft record. */
-	ctx = ntfs_attr_get_search_ctx(ni, mrec);
+	ctx = ntfs_attr_get_search_ctx(ni, mrec, NTFS_ATTR_CTX_LOCK_READ);
 	if (unlikely(!ctx)) {
 		unmap_mft_record(ni);
 		return ERR_PTR(-ENOMEM);
diff --git a/fs/ntfs/ntfs.h b/fs/ntfs/ntfs.h
index 45064dbcc2e47..750664a6c7740 100644
--- a/fs/ntfs/ntfs.h
+++ b/fs/ntfs/ntfs.h
@@ -172,6 +172,7 @@ extern struct kmem_cache *ntfs_index_ctx_cache;
 
 /* The various operations structs defined throughout the driver files. */
 extern const struct address_space_operations ntfs_aops;
+extern const struct address_space_operations ntfs_system_aops;
 extern const struct address_space_operations ntfs_mft_aops;
 
 extern const struct  file_operations ntfs_file_ops;
diff --git a/fs/ntfs/reparse.c b/fs/ntfs/reparse.c
index fa523dc3691ea..41de4d043e0d8 100644
--- a/fs/ntfs/reparse.c
+++ b/fs/ntfs/reparse.c
@@ -254,8 +254,9 @@ unsigned int ntfs_make_symlink(struct ntfs_inode *ni)
 	ni->reparse_tag = 0;
 	ni->reparse_flags = 0;
 
-	reparse_attr = ntfs_attr_readall(ni, AT_REPARSE_POINT, NULL, 0,
-					 &attr_size);
+	/* ntfs_read_locked_inode() already holds the attr-list lock here. */
+	reparse_attr = ntfs_attr_readall_nolock(ni, AT_REPARSE_POINT, NULL, 0,
+						&attr_size);
 	if (reparse_attr &&
 	    valid_reparse_data(ni, reparse_attr, attr_size)) {
 		err = -EINVAL;
@@ -506,8 +507,8 @@ static int set_reparse_index(struct ntfs_inode *ni, struct ntfs_index_context *x
 /*
  * Remove a reparse data index entry if attribute present
  */
-static int remove_reparse_index(struct inode *rp, struct ntfs_index_context *xr,
-				__le32 *preparse_tag)
+static int __remove_reparse_index(struct inode *rp, struct ntfs_index_context *xr,
+				__le32 *preparse_tag, bool nolock)
 {
 	struct reparse_index_key key;
 	u64 file_id_cpu;
@@ -520,7 +521,9 @@ static int remove_reparse_index(struct inode *rp, struct ntfs_index_context *xr,
 		return 0;
 
 	/* read the existing reparse_tag */
-	size = ntfs_inode_attr_pread(rp, 0, 4, (char *)preparse_tag);
+	size = nolock ? ntfs_inode_attr_pread_nolock(rp, 0, 4,
+			(char *)preparse_tag) :
+			ntfs_inode_attr_pread(rp, 0, 4, (char *)preparse_tag);
 	if (size != 4)
 		return -ENODATA;
 
@@ -537,6 +540,18 @@ static int remove_reparse_index(struct inode *rp, struct ntfs_index_context *xr,
 	return ret;
 }
 
+static int remove_reparse_index(struct inode *rp, struct ntfs_index_context *xr,
+				__le32 *preparse_tag)
+{
+	return __remove_reparse_index(rp, xr, preparse_tag, false);
+}
+
+static int remove_reparse_index_nolock(struct inode *rp,
+		struct ntfs_index_context *xr, __le32 *preparse_tag)
+{
+	return __remove_reparse_index(rp, xr, preparse_tag, true);
+}
+
 /*
  * Open the $Extend/$Reparse file and its index
  */
@@ -606,14 +621,15 @@ static int update_reparse_data(struct ntfs_inode *ni, struct ntfs_index_context
 	rp_ni = NTFS_I(rp_inode);
 
 	/* remove the existing reparse data */
-	oldsize = remove_reparse_index(rp_inode, xr, &reparse_tag);
+	oldsize = remove_reparse_index_nolock(rp_inode, xr, &reparse_tag);
 	if (oldsize < 0) {
 		err = oldsize;
 		goto put_rp_inode;
 	}
+	ntfs_index_ctx_reinit(xr);
 
 	/* overwrite value if any */
-	written = ntfs_inode_attr_pwrite(rp_inode, 0, size, value, false);
+	written = ntfs_inode_attr_pwrite_nolock(rp_inode, 0, size, value, false);
 	if (written != size) {
 		ntfs_error(ni->vol->sb, "Failed to update reparse data\n");
 		err = -EIO;
diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 8abe7bee4c0d9..0803ab553fc3e 100644
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
@@ -488,12 +488,13 @@ int ntfs_write_volume_label(struct ntfs_volume *vol, char *label)
 		ret = ntfs_attr_record_rm(ctx);
 	else if (ret == -ENOENT)
 		ret = 0;
-	ntfs_attr_put_search_ctx(ctx);
 	if (ret)
-		goto out;
+		goto put_out;
 
 	ret = ntfs_resident_attr_record_add(vol_ni, AT_VOLUME_NAME, AT_UNNAMED, 0,
 					    (u8 *)uname, uname_len * sizeof(__le16), 0);
+put_out:
+	ntfs_attr_put_search_ctx(ctx);
 out:
 	if (ret >= 0) {
 		char *old_label;
@@ -1430,6 +1431,7 @@ static bool load_system_files(struct ntfs_volume *vol)
 			   &mftbmp_runlist_lock_key);
 	lockdep_set_class(&NTFS_I(vol->mftbmp_ino)->mrec_lock,
 			   &mftbmp_mrec_lock_key);
+	vol->mftbmp_ino->i_mapping->a_ops = &ntfs_system_aops;
 	/* Read upcase table and setup @vol->upcase and @vol->upcase_len. */
 	if (!load_and_init_upcase(vol))
 		goto iput_mftbmp_err_out;
@@ -1454,6 +1456,7 @@ static bool load_system_files(struct ntfs_volume *vol)
 			   &lcnbmp_runlist_lock_key);
 	lockdep_set_class(&NTFS_I(vol->lcnbmp_ino)->mrec_lock,
 			   &lcnbmp_mrec_lock_key);
+	vol->lcnbmp_ino->i_mapping->a_ops = &ntfs_system_aops;
 
 	NInoSetSparseDisabled(NTFS_I(vol->lcnbmp_ino));
 	if ((vol->nr_clusters + 7) >> 3 > i_size_read(vol->lcnbmp_ino)) {
@@ -1481,7 +1484,7 @@ static bool load_system_files(struct ntfs_volume *vol)
 		goto volume_failed;
 	}
 
-	ctx = ntfs_attr_get_search_ctx(NTFS_I(vol->vol_ino), m);
+	ctx = ntfs_attr_get_search_ctx(NTFS_I(vol->vol_ino), m, NTFS_ATTR_CTX_LOCK_READ);
 	if (!ctx) {
 		ntfs_error(sb, "Failed to get attribute search context.");
 		goto get_ctx_vol_failed;
-- 
2.43.0
