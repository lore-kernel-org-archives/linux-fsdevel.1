Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795770346;
	b=I01usJ2zsPk/DAwcoUw0rr5h8N24vBJhe9NamIPHOaas2KOUDmym0fGII8ANaWmW66bG
	 zZOAcaRsvHpsiXoyJXMpMN2b3buqi+TSSURu6XA5BAxV4rv/+Y6/MEMurg6ls36HCLItv
	 hXk8NyT0h2kF4VCmqcESrV+buxJUhX/9pBiEgAg3IFzxIjAkvAl4BjSDiULKdmFR03CSd
	 fydK3hUy1YLF7o1WxaiFeL0YUBv2StPJ4RdHYZOZdTfMfTVJOh6TiUGt1fTtsGkWwbu1u
	 fth6tLglUD/QRKU+W7JaHjp8P/gk78ZtfZH5NxtKzeb9mr86E+zD0gqZ+h9dZWvaoEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795770346;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=xTFTy5wSUzYE6jj+9jBvqGj4csiaNGqAOGzqnLd4EFs=;
	b=sFNCXWyrsXiLVpZFyi0JoG5D9K0M4vvsavn6wh6es3RbzdcWghUMl51AsYPOfr19/W/C
	 INriuSx/pk/ZNcCM5oVy41MM65h5TWdjKgN2GEGwx/WtmXTuFi7uRfFJWO6/9N4PJMWGo
	 2Z8rYnDtCk089eKmEWkStvV0cXRJ6jSoR6kSkjcqj1ideuA4joHBXv/aM48gTr5E/4A1J
	 l4pF/BmjOBiBezXVNDoBMjQtNO52h2oexaDRpoJQuTvcUxJke1mREX43ELGR78ef4mXbr
	 l/UdSV2n+ekO0i0fyQlkgwU5mS5FjpxrWzRN07Mavxn4CKjDG04RcQRFuelEKKXumKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mails.ucas.ac.cn;
	spf=pass smtp.mailfrom=mails.ucas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7861A606A32E;
	Fri, 27 Nov 2026 09:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7861A606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.ucas.ac.cn
Received: from localhost.localdomain (unknown [159.226.43.6])
	by APP-03 (Coremail) with SMTP id rQCowADXqZrURwlrfPLsAQ--.62564S2;
	Fri, 27 Nov 2026 17:05:24 +0800 (CST)
From: Xinyuan Zhao <zhaoxinyuan24@mails.ucas.ac.cn>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xinyuan Zhao <zhaoxinyuan24@mails.ucas.ac.cn>
Subject: [BUG] gfs2: slab-use-after-free in gfs2_release_folio due to premature free_sbd() in gfs2_fill_super()
Date: Fri, 27 Nov 2026 17:05:18 +0800
Message-ID: <20261127090518.29089-1-zhaoxinyuan24@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.54.0
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
X-CM-TRANSID:rQCowADXqZrURwlrfPLsAQ--.62564S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WFW8tF1rXr1DCF4xCw43trb_yoWfWF1DpF
	9ak3s7Xr4kW34UWr4xGF4rtFy8Xa9IyF17Gr1fWr13AF13Ww17Ga9F9rsrXa1UCF1kC34x
	Z3WUJrW7Wr1UJF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9m14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwCY1x0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_GFWl42xK82IYc2Ij64vIr41l4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
	1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JU1byNUUUUU=
X-CM-SenderInfo: p2kd055lq13trqsuqzpdlo2hpxfd2hldfou0/

Hi Andreas and GFS2 maintainers,

While fuzzing Linux 7.4.0-rc3 (upstream commit 4405c18) on x86_64 with
syzkaller, we encountered a KASAN slab-use-after-free in
gfs2_release_folio() triggered by kswapd0 racing with a failing
gfs2_fill_super() mount path. We verified both the latest torvalds/linux
master (7.4.0-rc4) and linux-next branches, and the error cleanup path in
gfs2_fill_super() (fs/gfs2/ops_fstype.c:1286-1316) remains unchanged.

Summary / Root Cause Analysis
=============================

During a failing mount, gfs2_fill_super() frees struct gfs2_sbd (sdp)
before VFS tears down the superblock and evicts cached inodes/folios:

1. gfs2_fill_super() allocates sdp via init_sbd() (fs/gfs2/ops_fstype.c:79,
   1121) and sets sb->s_fs_info = sdp. During mount initialization, GFS2
   reads metadata/system inodes and populates folios with buffer_heads
   backed by gfs2_release_folio() onto the LRU lists.

2. If mount fails later in gfs2_fill_super() (in this case, during
   gfs2_jdesc_check() with "my journal (0) is bad: -5"), execution falls
   through fail_per_node..fail_free (fs/gfs2/ops_fstype.c:1286-1316) and
   calls free_sbd(sdp) at line 1315:

     void free_sbd(struct gfs2_sbd *sdp)
     {
         struct super_block *sb = sdp->sd_vfs;

         free_percpu(sdp->sd_lkstats);
         sb->s_fs_info = NULL;
         kfree(sdp);
     }

   At this point, gfs2_fill_super() has not yet returned to VFS, so
   deactivate_locked_super() -> gfs2_kill_sb() -> kill_block_super() ->
   generic_shutdown_super() -> evict_inodes() has not yet run to evict
   remaining cached inodes and truncate their page cache folios (unlike
   normal unmount in gfs2_kill_sb(), which calls shrink_dcache_sb(),
   gfs2_evict_inodes(), and kill_block_super() before freeing sdp).

3. Concurrently, kswapd0 reclaims a folio belonging to this superblock via
   shrink_folio_list() -> filemap_release_folio() -> gfs2_release_folio()
   (fs/gfs2/aops.c:649-671):

     struct gfs2_sbd *sdp = gfs2_mapping2sbd(mapping);
     ...
     spin_lock(&sdp->sd_log_lock);

   If kswapd0 reads sdp before free_sbd() clears sb->s_fs_info and frees
   sdp, spin_lock(&sdp->sd_log_lock) at fs/gfs2/aops.c:671 triggers a
   slab-use-after-free (offset 3168 inside the freed 8192-byte struct
   gfs2_sbd). Conversely, if kswapd0 reads sb->s_fs_info after
   free_sbd() sets it to NULL, it would hit a NULL pointer dereference.

Possible Fix
============

Ensure all cached dentries, inodes, and their page cache folios are
evicted/truncated before freeing sdp on the gfs2_fill_super() failure
path (for example, by calling shrink_dcache_sb(sb) and
gfs2_evict_inodes(sb) before free_sbd(sdp), or deferring free_sbd(sdp)
until after generic_shutdown_super() has evicted all inodes).

Reproducer
==========

The crash was triggered by mounting a corrupted GFS2 image (failing in
gfs2_jdesc_check()) concurrently with memory reclaim pressure (kswapd0).
The extracted syzkaller program and C reproducer (with proactive compaction
disabled and a concurrent memory.reclaim / drop_caches worker) are available
at:

  https://gist.github.com/ilidanZtormrage/75671cc20d086f632e5c047fb166e32b

Note: on the same gfs2_fill_super() failure cleanup path, leftover folios on
the LRU can trigger two distinct UAFs during kswapd0 reclaim in evict_folios():
first on a freed struct gfs2_glock in isolate_folios() -> folio_evictable(),
and then on the freed struct gfs2_sbd (sdp) in shrink_folio_list() ->
gfs2_release_folio(). With panic_on_warn=1, kswapd0 may panic on
folio_evictable() first (~10s); running with panic_on_warn=0 allows
gfs2_release_folio() on the freed sdp to surface as well.

Crash Report
============

gfs2: fsid=..0: fatal: filesystem consistency error - inode = 1 19, function = gfs2_jdesc_check, file = fs/gfs2/super.c, line = 119
gfs2: fsid=..0: my journal (0) is bad: -5
==================================================================
BUG: KASAN: slab-use-after-free in __raw_spin_lock include/linux/spinlock_api_smp.h:190 [inline]
BUG: KASAN: slab-use-after-free in _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:173
Read of size 1 at addr ffff8880297ccc60 by task kswapd0/99
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xf4/0x600 mm/kasan/report.c:482
 kasan_report+0xe0/0x110 mm/kasan/report.c:595
 __kasan_check_byte+0x36/0x50 mm/kasan/common.c:588
 kasan_check_byte include/linux/kasan.h:406 [inline]
 lock_acquire kernel/locking/lockdep.c:5916 [inline]
 lock_acquire+0x126/0x370 kernel/locking/lockdep.c:5899
 __raw_spin_lock include/linux/spinlock_api_smp.h:190 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:173
 spin_lock include/linux/spinlock.h:347 [inline]
 gfs2_release_folio+0x140/0x720 fs/gfs2/aops.c:671
 filemap_release_folio+0x22d/0x390 mm/filemap.c:4587
 shrink_folio_list+0x177c/0x45b0 mm/vmscan.c:1569
 evict_folios+0x352/0x13d0 mm/vmscan.c:5097
 try_to_shrink_lruvec+0x301/0x7e0 mm/vmscan.c:5271
 shrink_one+0x33e/0x710 mm/vmscan.c:5318
 shrink_many mm/vmscan.c:5381 [inline]
 lru_gen_shrink_node mm/vmscan.c:5459 [inline]
 shrink_node+0x2906/0x4230 mm/vmscan.c:6465
 kswapd_shrink_node mm/vmscan.c:7258 [inline]
 balance_pgdat+0xa6b/0x1da0 mm/vmscan.c:7429
 kswapd+0x590/0xbd0 mm/vmscan.c:7705
 kthread+0x385/0x490 kernel/kthread.c:436
 ret_from_fork+0xb2a/0xdd0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 38319:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:57
 kasan_save_track+0x14/0x40 mm/kasan/common.c:79
 poison_kmalloc_redzone mm/kasan/common.c:412 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:429
 kasan_kmalloc include/linux/kasan.h:267 [inline]
 __kmalloc_cache_noprof+0x2e4/0x710 mm/slub.c:5680
 _kmalloc_noprof include/linux/slab.h:991 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 init_sbd fs/gfs2/ops_fstype.c:79 [inline]
 gfs2_fill_super+0x148/0x2f80 fs/gfs2/ops_fstype.c:1121
 get_tree_bdev_flags+0x392/0x630 fs/super.c:1821
 gfs2_get_tree+0x4e/0x280 fs/gfs2/ops_fstype.c:1331
 vfs_get_tree+0x8e/0x330 fs/super.c:1881
 fc_mount fs/namespace.c:1282 [inline]
 do_new_mount_fc fs/namespace.c:3910 [inline]
 do_new_mount fs/namespace.c:3986 [inline]
 path_mount+0x7bf/0x25c0 fs/namespace.c:4337
 do_mount fs/namespace.c:4350 [inline]
 __do_sys_mount fs/namespace.c:4563 [inline]
 __se_sys_mount fs/namespace.c:4540 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:4540
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x12e/0x800 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 38319:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:57
 kasan_save_track+0x14/0x40 mm/kasan/common.c:79
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:599
 poison_slab_object mm/kasan/common.c:267 [inline]
 __kasan_slab_free+0x73/0x90 mm/kasan/common.c:299
 kasan_slab_free include/linux/kasan.h:239 [inline]
 slab_free_hook mm/slub.c:2780 [inline]
 slab_free mm/slub.c:6637 [inline]
 kfree+0x160/0x720 mm/slub.c:6930
 free_sbd fs/gfs2/ops_fstype.c:72 [inline]
 gfs2_fill_super+0x15a9/0x2f80 fs/gfs2/ops_fstype.c:1315
 get_tree_bdev_flags+0x392/0x630 fs/super.c:1821
 gfs2_get_tree+0x4e/0x280 fs/gfs2/ops_fstype.c:1331
 vfs_get_tree+0x8e/0x330 fs/super.c:1881
 fc_mount fs/namespace.c:1282 [inline]
 do_new_mount_fc fs/namespace.c:3910 [inline]
 do_new_mount fs/namespace.c:3986 [inline]
 path_mount+0x7bf/0x25c0 fs/namespace.c:4337
 do_mount fs/namespace.c:4350 [inline]
 __do_sys_mount fs/namespace.c:4563 [inline]
 __se_sys_mount fs/namespace.c:4540 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:4540
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x12e/0x800 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880297cc000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 3168 bytes inside of
 freed 8192-byte region [ffff8880297cc000, ffff8880297ce000)

Best regards,
Xinyuan Zhao

