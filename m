Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035463B38BF
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 01:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776908379; cv=none; b=kSrB07i3B8sDBXt+VGk/uvzJsMIIJqqVO63Q46Ny2whN16x/Nmm5IIgN/ras+rScvjka3txsh9XxXz2wWJdZV7grn3CqlxSqsdlDdqiTIJMgi47kW2AaybGczPTPQsNADLSgD0909YJwilwyozDY/kY7Gjgn9VfODFDEH7EQfW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776908379; c=relaxed/simple;
	bh=bcNiZPIjs8xL0mFnTXObwOwKn45Jip2ywuD7Yqeriw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fIhXVzdM77DGgfbjjDh5qc7YYwOsc+VyeQ8oeU/MLURwIJYKB08ZIbH1WGM6LGVJqNRBWFGtnaJn6WtfpOuMMcQ1fY95Q1Gf0NaytEIPE/DkyAU97roxnmd4/WNaOn2QMMo24C5xeL5pOIFQM+sdyknhMhNpYrZO26XmlRiUDHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=d5nGgtWc; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="d5nGgtWc"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3614826eca4so5560730a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 18:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1776908362; x=1777513162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kqz9+vfA4A6mhRKllDw5uLoyI65Q3eakO2iD6h55ZSE=;
        b=d5nGgtWcc9AahGszZUilOvuKb1tMgGvPEeKP0uYcCCtnO+KDQd3Nwdz1wYB262TAAU
         x6YARv9vA9IvXM/Gnm7JLz76/4vmVAbEdYxldF6bD7h+ZeUMjpXKGhA6aQ43O1n3OB3F
         UE0fEthu7yc8vEguFbTUVPDnnIEq96dHIMNlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776908362; x=1777513162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kqz9+vfA4A6mhRKllDw5uLoyI65Q3eakO2iD6h55ZSE=;
        b=Wx30wJ3+FAZkz6PxuDWHyQ2fwVy2+br5uqteRDWOUBshxwJrNPBHcVqmQzolvTwXEV
         zSWjMGlaBIY/hzTCpeUYQyFy7uEI+I29g3wW0oD/t/DVZlGzBvsj9KbplUeOBbfbQtFf
         b6PT7kDnVgxN7Nl8UoMBLdXF9MAzBUdFbXjrdZ8IFCTjyWBN0XWFlecBNnr1dgZQ4iLZ
         NW6CZNx3hN8N8NtIuwdmk9uOxEZ8EC4wUQsCCUmsyVZw0FAQ6dwYgn7EnzTOXVI3JQ+o
         LY1nTBRm/iCX089KOUsQ34rZOXAMCEO2lbDNvKsBxIIrQyANoV6cjVG8ghQTIdoPMVQl
         K7nQ==
X-Forwarded-Encrypted: i=1; AFNElJ+E0h4fNrW+WfnMBNViEwVVt4ZIEy6rEM/6Z29VwtAT2JhLRjpuJAaOIJgkFYVyAD+udwgbf64tIkUrTvw5@vger.kernel.org
X-Gm-Message-State: AOJu0YxgromgAzN9YZktCwMhnDQiiz8wx7giVDjNwuu+fsEJHM8qATha
	ZHKPiXMC8NC+c7zVflUMMdai3qI8A1fl1+W9Zsrinbh9twV7ZsffovShRKFMEGasmww=
X-Gm-Gg: AeBDies2kzbfgLKxKWH37oHf4lZj5ud4A2nKL0T1Yy9MZJgmyFDUtChJUL101xyjH5d
	X3r4mzP1h5kVto/dSkY4rFOC/s9j9rkH7GoWqt4yplzaNKd9U7ztn6zk3vn3qh3flyh919+68+0
	TRIqlvVPWQeaPcaKZ3EIK87DiHuS2ziDRkApyWMhgNep/cAhmFMUM2V9RRjGfa/43qb/w82WH1u
	pWazEbQB6pN4N84T6+zlm6al/c/fN8FxJjIcpyz0dtMZEGXClgj6RQAaFr6uAh5XmVVYcI4Od7v
	7ufNzBgXXjuRc00q2WE9eGIGVSPiQJhzepBVYll1xtsRB0QCPoh551uCIZrU0U/HMsDWGpd/2dV
	N4+EqfTl98CrYWSHTcbi89+RtzoXZL5nJxvWfD3ov8YnJwvLGXh3KBolIMh4ksFChgrrEeHxgDR
	lpf4JDJTIqxUOSWh1KUTVUpRy/xRMP+oqZ9NKHTxSWT2tEhTjpbPVNa16VzjvtUxJm2zUWMfsCV
	eiMxBGPfwN5
X-Received: by 2002:a17:90b:3b4b:b0:35d:95eb:879a with SMTP id 98e67ed59e1d1-36140463601mr25839731a91.13.1776908361972;
        Wed, 22 Apr 2026 18:39:21 -0700 (PDT)
Received: from eulgyu-desktop.localdomain ([147.46.174.223])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36141990bb6sm18831724a91.17.2026.04.22.18.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 18:39:21 -0700 (PDT)
From: Eulgyu Kim <eulgyukim@snu.ac.kr>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	byoungyoung@snu.ac.kr,
	jjy600901@snu.ac.kr
Subject: [BUG] KASAN: slab-use-after-free in link_path_walk
Date: Thu, 23 Apr 2026 10:39:16 +0900
Message-ID: <20260423013916.1589029-1-eulgyukim@snu.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

We encountered a "KASAN: slab-use-after-free in link_path_walk"
on kernel version v7.0.

As the issue is root-only memory corruption bug, we report this
in public mailing list.

We suspect there is a race condition between vfs_rmdir() and may_lookup()
on the BPF pseudo filesystem. It seems that while link_path_walk() is walking
a path, its call to may_lookup() checks permissions on the current directory
inode through nd->inode, and vfs_rmdir() can remove that same directory and
trigger inode destruction, leading to a use-after-free.

We have included the following items below: 
- C reproducer
- kernel delay patch
- KASAN crash log

To reliably trigger the race condition bug, we patched the kernel
to inject a delay at a specific point.

The kernel config used is the same as the syzbot configuration.

Unfortunately, we do not have a fix ready for this bug yet.
As this issue was identified via fuzzing and we have limited background,
we find it challenging to propose a correct fix or evaluate
its potential severity.

We hope this report helps address the issue. Please let us know
if any further information is needed.

Thank you for your time and attention.

Best Regards,
Eulgyu Kim



C reproducer:
==================================================================
#define _GNU_SOURCE

#include <fcntl.h>
#include <linux/mount.h>
#include <sys/prctl.h>
#include <sys/syscall.h>
#include <unistd.h>

int main(void)
{
	int fsfd, mfd, pid;

	fsfd = syscall(SYS_fsopen, "bpf", 0);
	syscall(SYS_fsconfig, fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);

	mfd = syscall(SYS_fsmount, fsfd, 0, 0);
	fchdir(mfd);

	syscall(SYS_mkdirat, AT_FDCWD, "file1", 0);

	pid = fork();
	if (pid == 0) {
		prctl(PR_SET_NAME, "gp-open", 0, 0, 0);
		syscall(SYS_openat, AT_FDCWD, "file1/x", O_RDONLY);
		_exit(0);
	}

	sleep(1);
	syscall(SYS_unlinkat, AT_FDCWD, "file1", AT_REMOVEDIR);
	return 0;
}
==================================================================



kernel delay patch:
==================================================================
diff --git a/fs/namei.c b/fs/namei.c
index 9e5500dad..851c7a43e 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -15,6 +15,8 @@
 /* [Feb-Apr 2000, AV] Rewrite to the new namespace architecture.
  */

+#include <linux/delay.h>
+#include <linux/string.h>
 #include <linux/init.h>
 #include <linux/export.h>
 #include <linux/slab.h>
@@ -1955,6 +1957,9 @@ static inline int may_lookup(struct mnt_idmap *idmap,
        int err, mask;

        mask = nd->flags & LOOKUP_RCU ? MAY_NOT_BLOCK : 0;
+       if (!strcmp(current->comm, "gp-open") && !strcmp(nd->path.dentry->d_name.name, "file1")) {
+               mdelay(2000);
+       }
        err = lookup_inode_permission_may_exec(idmap, nd->inode, mask);
        if (likely(!err))
                return 0;
==================================================================



KASAN crash log:
==================================================================
BUG: KASAN: slab-use-after-free in lookup_inode_permission_may_exec fs/namei.c:684 [inline]
BUG: KASAN: slab-use-after-free in may_lookup fs/namei.c:1965 [inline]
BUG: KASAN: slab-use-after-free in link_path_walk+0xfb8/0x19d0 fs/namei.c:2608
Read of size 2 at addr ffff88816a15c098 by task gp-open/10164

CPU: 7 UID: 0 PID: 10164 Comm: gp-open Not tainted 7.0.0-g468f5dd0ad77-dirty #18 PREEMPT(full)
Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 lookup_inode_permission_may_exec fs/namei.c:684 [inline]
 may_lookup fs/namei.c:1965 [inline]
 link_path_walk+0xfb8/0x19d0 fs/namei.c:2608
 path_openat+0x2b0/0x3840 fs/namei.c:4839
 do_file_open+0x203/0x440 fs/namei.c:4872
 do_sys_openat2+0x105/0x1e0 fs/open.c:1366
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_openat fs/open.c:1388 [inline]
 __se_sys_openat fs/open.c:1383 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1383
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x160/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x412b3d
Code: b3 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd1a290f38 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 0000000000412b3d
RDX: 0000000000000000 RSI: 0000000000480022 RDI: 00000000ffffff9c
RBP: 00007ffd1a290f50 R08: 00000000004b20e0 R09: 000000031a290f60
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd1a291068
R13: 00007ffd1a291078 R14: 00000000004a6f28 R15: 0000000000000001
 </TASK>

Allocated by task 10162:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4538 [inline]
 slab_alloc_node mm/slub.c:4866 [inline]
 kmem_cache_alloc_lru_noprof+0x2b9/0x650 mm/slub.c:4885
 alloc_inode+0xb8/0x1b0 fs/inode.c:349
 new_inode+0x22/0x170 fs/inode.c:1185
 bpf_get_inode kernel/bpf/inode.c:117 [inline]
 bpf_mkdir+0x71/0x1e0 kernel/bpf/inode.c:157
 vfs_mkdir+0x414/0x630 fs/namei.c:5246
 filename_mkdirat+0x27b/0x500 fs/namei.c:5279
 __do_sys_mkdirat fs/namei.c:5300 [inline]
 __se_sys_mkdirat+0x35/0x150 fs/namei.c:5297
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x160/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 10162:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2685 [inline]
 slab_free mm/slub.c:6165 [inline]
 kmem_cache_free+0x189/0x640 mm/slub.c:6295
 destroy_inode fs/inode.c:397 [inline]
 evict+0x8aa/0xae0 fs/inode.c:870
 d_delete_notify include/linux/fsnotify.h:377 [inline]
 vfs_rmdir+0x427/0x6e0 fs/namei.c:5364
 filename_rmdir+0x281/0x500 fs/namei.c:5406
 __do_sys_unlinkat fs/namei.c:5581 [inline]
 __se_sys_unlinkat+0x71/0x1a0 fs/namei.c:5574
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x160/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88816a15c098
 which belongs to the cache inode_cache of size 1144
The buggy address is located 0 bytes inside of
 freed 1144-byte region [ffff88816a15c098, ffff88816a15c510)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88816a15f248 pfn:0x16a158
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88816a15fc39
flags: 0x17ff00000000240(workingset|head|node=0|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 017ff00000000240 ffff888101ae5400 ffffea0005a84210 ffffea0005ac2c10
raw: ffff88816a15f248 0000000800190017 00000000f5000000 ffff88816a15fc39
head: 017ff00000000240 ffff888101ae5400 ffffea0005a84210 ffffea0005ac2c10
head: ffff88816a15f248 0000000800190017 00000000f5000000 ffff88816a15fc39
head: 017ff00000000003 ffffea0005a85601 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Reclaimable, gfp_mask 0xd20d0(__GFP_RECLAIMABLE|__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 10089, tgid 10089 ((agetty)), ts 58852348565, free_ts 25217842588
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x23d/0x2a0 mm/page_alloc.c:1889
 prep_new_page mm/page_alloc.c:1897 [inline]
 get_page_from_freelist+0x24e0/0x2580 mm/page_alloc.c:3962
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5250
 alloc_slab_page mm/slub.c:3292 [inline]
 allocate_slab+0x77/0x670 mm/slub.c:3481
 new_slab mm/slub.c:3539 [inline]
 refill_objects+0x33a/0x3d0 mm/slub.c:7175
 refill_sheaf mm/slub.c:2812 [inline]
 __pcs_replace_empty_main+0x2e8/0x730 mm/slub.c:4615
 alloc_from_pcs mm/slub.c:4717 [inline]
 slab_alloc_node mm/slub.c:4851 [inline]
 kmem_cache_alloc_lru_noprof+0x37b/0x650 mm/slub.c:4885
 alloc_inode+0xb8/0x1b0 fs/inode.c:349
 new_inode_pseudo include/linux/fs.h:3003 [inline]
 prepare_anon_dentry fs/libfs.c:2165 [inline]
 path_from_stashed+0x200/0x5c0 fs/libfs.c:2252
 proc_ns_get_link+0xec/0x210 fs/proc/namespaces.c:61
 pick_link+0x728/0xfe0 fs/namei.c:-1
 step_into_slowpath+0x53b/0x7d0 fs/namei.c:2131
 step_into fs/namei.c:2156 [inline]
 walk_component fs/namei.c:2292 [inline]
 lookup_last fs/namei.c:2793 [inline]
 path_lookupat+0x433/0x8c0 fs/namei.c:2817
 filename_lookup+0x212/0x570 fs/namei.c:2846
 vfs_statx+0xf7/0x1f0 fs/stat.c:353
 vfs_fstatat+0x11b/0x170 fs/stat.c:373
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1433 [inline]
 __free_frozen_pages+0xc43/0xde0 mm/page_alloc.c:2978
 __free_pages mm/page_alloc.c:5369 [inline]
 free_contig_range+0xbb/0x170 mm/page_alloc.c:7374
 destroy_args+0x501/0x590 mm/debug_vm_pgtable.c:993
 debug_vm_pgtable+0x38f/0x3a0 mm/debug_vm_pgtable.c:1368
 do_one_initcall+0x1f1/0x880 init/main.c:1382
 do_initcall_level+0x104/0x190 init/main.c:1444
 do_initcalls+0x59/0xa0 init/main.c:1460
 kernel_init_freeable+0x2a7/0x3e0 init/main.c:1692
 kernel_init+0x1d/0x1d0 init/main.c:1582
 ret_from_fork+0x513/0xba0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff88816a15bf80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88816a15c000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88816a15c080: fc fc fc fa fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff88816a15c100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88816a15c180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
