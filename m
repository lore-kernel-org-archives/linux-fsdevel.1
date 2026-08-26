Received: from mail-oa2-f11.google.com (mail-oa2-f11.google.com [74.125.231.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA86F43B6D3
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 14:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787756081; cv=none; b=hIKnOEwg4Rxe+Vobs5CPD0TAzHVMcDIL1TpCVAgAKy28kM5+ldIqN4ghYOb8uJseLXhMjVfntuGKZytywwetjEO0C7rFx6ZLYmVFbOq1lOJOa/2eneXywwY8L6k6wBTEBi0kSfjoNaeZdHoSCSJ7Wg6Z2lgMcEKlLzzzebfwOEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787756081; c=relaxed/simple;
	bh=h81Wf+JN2r7zw2xpnWCN10iX/UkrmlCDQtNHhSI6x0Q=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gpmT2oPIoTW5SthWCkXisbdnTc4Llo7TD7KW7SCoeAO/gQkE+wHWJGW3VTLucruDksLxYzvLn2QimSqDkMvyeDqxIzH9bE8Dz8Mf8xgXd0BGcTnyC4l90RtONHykgur30qCOE+9vnvWMErDIXgiidCJ233qW02bHmGdn/WCHKg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa2-f11.google.com with SMTP id 586e51a60fabf-45e2c1e33e1so513303fac.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 07:54:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787756079; x=1788360879;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fhc5akPL+e5xaAqcDZhj/uzCSZOI1Tcd3kQrpi5gMfg=;
        b=W7wJZd+T9eyz9/X5bUlZWjQXYOcdfqTlf2hIQQHRel+L5NGmgZMEpprlkOvXX/QxAB
         T5qsafjmmHUIfQM5moOKpdzLMDExV7peaYuge5LzXQnQ0R165yUYBQYYiMK2HsH4CVYF
         f2oJqqSkgP4HFXKtMxGlF/QLrS1uI18CGlcyLb5cQm/CNktvaAnXNwuATkdO7pmQ4xFM
         ZMZM1AyLGgMb7ULbKMHPokvL1Zim+o0Y1ViNI+AoSBLrfs9uua6NIxMa2BNl0wCyG0tn
         5M6V/Kx3AfOY/Vkvm6ujtI8PAu/tLwaJm0obG0yyEsRlV0Z68DmwSjlOnA6kFq5sDZ5s
         Uetg==
X-Forwarded-Encrypted: i=1; AHgh+Rrz6f6REGTdGSm2XAn9IB2dSWaKxue45s5RYflAvxrFMrv6TGMQLxuYHAZ7BeiKwKyO1ypaoP5aXjSp+8fm@vger.kernel.org
X-Gm-Message-State: AFuF++kB7IwI/n5zXEG1YNcGUIQwpuoBR7X9FHcImFuRQ3KyGkg1WBVM
	gsemUecLzEWD7mUBH39XnWD4c+8pWkhk7ZJct1a7jG3+R25wGccvWouYgLIOlC3o8m11my3kwvS
	fEYB7rb0FqbV/3ZxNAx9D41Ttx7R9wm0HsI/Ybzt328O2YjH6pFSrtnW+6jM=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:709b:10b0:6aa:e13e:ba26 with SMTP id
 006d021491bc7-6b1a052dbfamr5198298eaf.33.1787756078998; Wed, 26 Aug 2026
 07:54:38 -0700 (PDT)
Date: Wed, 26 Aug 2026 07:54:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a8efe2e.1d9ded08.62e62.00b2.GAE@google.com>
Subject: [syzbot] [fs?] memory leak in path_openat (4)
From: syzbot <syzbot+7666ed2c3d42196bf7e3@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    26260251022f Merge tag 'livepatching-for-7.3' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1196a179580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6c1b5958b2d1207f
dashboard link: https://syzkaller.appspot.com/bug?extid=7666ed2c3d42196bf7e3
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=139f7179580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0f75e7622b1f/disk-26260251.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2bbff9fd7b60/vmlinux-26260251.xz
kernel image: https://storage.googleapis.com/syzbot-assets/95d733004907/bzImage-26260251.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7666ed2c3d42196bf7e3@syzkaller.appspotmail.com

2026/08/22 14:47:52 executed programs: 26
2026/08/22 14:47:59 executed programs: 40
2026/08/22 14:48:07 executed programs: 54
2026/08/22 14:48:14 executed programs: 68
BUG: memory leak
unreferenced object 0xffff88812811f9c0 (size 176):
  comm "syz.0.25", pid 6047, jiffies 4294943865
  hex dump (first 32 bytes):
    00 00 00 00 19 00 08 04 40 fc a8 85 ff ff ff ff  ........@.......
    00 02 38 03 81 88 ff ff 80 cd 61 11 81 88 ff ff  ..8.......a.....
  backtrace (crc 1214ee3a):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4599 [inline]
    slab_alloc_node mm/slub.c:4919 [inline]
    kmem_cache_alloc_noprof+0x352/0x440 mm/slub.c:4933
    alloc_empty_file+0x57/0x180 fs/file_table.c:262
    path_openat+0x44/0x11f0 fs/namei.c:4986
    do_file_open+0x121/0x200 fs/namei.c:5029
    do_sys_openat2+0xa7/0x150 fs/open.c:1417
    do_sys_open fs/open.c:1423 [inline]
    __do_sys_openat fs/open.c:1439 [inline]
    __se_sys_openat fs/open.c:1434 [inline]
    __x64_sys_openat+0x82/0xf0 fs/open.c:1434
    do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
    do_syscall_64+0xe9/0x530 arch/x86/entry/syscall_64.c:84
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff8881280ec188 (size 56):
  comm "syz.0.25", pid 6047, jiffies 4294943865
  hex dump (first 32 bytes):
    ff ff 01 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 2672a0c6):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4599 [inline]
    slab_alloc_node mm/slub.c:4919 [inline]
    kmem_cache_alloc_noprof+0x352/0x440 mm/slub.c:4933
    lsm_file_alloc security/security.c:171 [inline]
    security_file_alloc+0x30/0x250 security/security.c:2406
    init_file+0x3e/0x160 fs/file_table.c:184
    alloc_empty_file+0x75/0x180 fs/file_table.c:266
    path_openat+0x44/0x11f0 fs/namei.c:4986
    do_file_open+0x121/0x200 fs/namei.c:5029
    do_sys_openat2+0xa7/0x150 fs/open.c:1417
    do_sys_open fs/open.c:1423 [inline]
    __do_sys_openat fs/open.c:1439 [inline]
    __se_sys_openat fs/open.c:1434 [inline]
    __x64_sys_openat+0x82/0xf0 fs/open.c:1434
    do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
    do_syscall_64+0xe9/0x530 arch/x86/entry/syscall_64.c:84
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88811161cd80 (size 192):
  comm "syz.0.25", pid 6047, jiffies 4294943865
  hex dump (first 32 bytes):
    c0 f9 11 28 81 88 ff ff 00 00 00 00 2c 00 00 01  ...(........,...
    b2 6d b2 0e 81 88 ff ff 00 00 00 00 00 00 00 00  .m..............
  backtrace (crc 6cdefeb4):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4599 [inline]
    slab_alloc_node mm/slub.c:4919 [inline]
    __kmalloc_cache_noprof+0x359/0x440 mm/slub.c:5480
    _kmalloc_noprof include/linux/slab.h:988 [inline]
    _kzalloc_noprof include/linux/slab.h:1309 [inline]
    iommufd_fops_open+0x24/0xe0 drivers/iommu/iommufd/main.c:319
    misc_open+0x12a/0x1f0 drivers/char/misc.c:163
    chrdev_open+0x108/0x310 fs/char_dev.c:411
    do_dentry_open+0x1fc/0x850 fs/open.c:996
    vfs_open+0x3d/0x1b0 fs/open.c:1101
    do_open fs/namei.c:4837 [inline]
    path_openat+0xde7/0x11f0 fs/namei.c:5000
    do_file_open+0x121/0x200 fs/namei.c:5029
    do_sys_openat2+0xa7/0x150 fs/open.c:1417
    do_sys_open fs/open.c:1423 [inline]
    __do_sys_openat fs/open.c:1439 [inline]
    __se_sys_openat fs/open.c:1434 [inline]
    __x64_sys_openat+0x82/0xf0 fs/open.c:1434
    do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
    do_syscall_64+0xe9/0x530 arch/x86/entry/syscall_64.c:84
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff888127dd4000 (size 256):
  comm "syz.0.25", pid 6047, jiffies 4294943865
  hex dump (first 32 bytes):
    01 00 00 00 01 00 00 00 04 00 00 00 01 00 00 00  ................
    00 00 00 00 00 00 00 00 01 48 cf 0a 81 88 ff ff  .........H......
  backtrace (crc 98731819):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4599 [inline]
    slab_alloc_node mm/slub.c:4919 [inline]
    __do_kmalloc_node mm/slub.c:5336 [inline]
    __kmalloc_noprof+0x3c2/0x560 mm/slub.c:5362
    _kmalloc_noprof include/linux/slab.h:992 [inline]
    _kzalloc_noprof include/linux/slab.h:1309 [inline]
    _iommufd_object_alloc+0x24/0x100 drivers/iommu/iommufd/main.c:41
    iommufd_ioas_alloc drivers/iommu/iommufd/ioas.c:28 [inline]
    iommufd_ioas_alloc_ioctl+0x46/0x160 drivers/iommu/iommufd/ioas.c:47
    iommufd_fops_ioctl+0x1ed/0x370 drivers/iommu/iommufd/main.c:556
    vfs_ioctl fs/ioctl.c:51 [inline]
    __do_sys_ioctl fs/ioctl.c:597 [inline]
    __se_sys_ioctl fs/ioctl.c:583 [inline]
    __x64_sys_ioctl+0xf4/0x140 fs/ioctl.c:583
    do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
    do_syscall_64+0xe9/0x530 arch/x86/entry/syscall_64.c:84
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88810eb26db0 (size 576):
  comm "syz.0.25", pid 6047, jiffies 4294943865
  hex dump (first 32 bytes):
    00 17 02 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    88 cd 61 11 81 88 ff ff c8 6d b2 0e 81 88 ff ff  ..a......m......
  backtrace (crc f41786a5):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4599 [inline]
    slab_alloc_node mm/slub.c:4919 [inline]
    kmem_cache_alloc_lru_noprof+0x350/0x440 mm/slub.c:4952
    xas_alloc+0xf1/0x110 lib/xarray.c:378
    xas_expand lib/xarray.c:590 [inline]
    xas_create+0x105/0x8a0 lib/xarray.c:661
    xas_store+0x7a/0xb20 lib/xarray.c:795
    __xa_alloc+0xec/0x200 lib/xarray.c:2005
    xa_alloc include/linux/xarray.h:878 [inline]
    _iommufd_object_alloc+0x9d/0x100 drivers/iommu/iommufd/main.c:56
    iommufd_ioas_alloc drivers/iommu/iommufd/ioas.c:28 [inline]
    iommufd_ioas_alloc_ioctl+0x46/0x160 drivers/iommu/iommufd/ioas.c:47
    iommufd_fops_ioctl+0x1ed/0x370 drivers/iommu/iommufd/main.c:556
    vfs_ioctl fs/ioctl.c:51 [inline]
    __do_sys_ioctl fs/ioctl.c:597 [inline]
    __se_sys_ioctl fs/ioctl.c:583 [inline]
    __x64_sys_ioctl+0xf4/0x140 fs/ioctl.c:583
    do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
    do_syscall_64+0xe9/0x530 arch/x86/entry/syscall_64.c:84
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88811161ccc0 (size 192):
  comm "syz.0.25", pid 6047, jiffies 4294943865
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 21b0f99b):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4599 [inline]
    slab_alloc_node mm/slub.c:4919 [inline]
    __kmalloc_cache_noprof+0x359/0x440 mm/slub.c:5480
    _kmalloc_noprof include/linux/slab.h:988 [inline]
    _kzalloc_noprof include/linux/slab.h:1309 [inline]
    iopt_alloc_pages.part.0+0x2b/0x210 drivers/iommu/iommufd/pages.c:1375
    iopt_alloc_pages drivers/iommu/iommufd/pages.c:1432 [inline]
    iopt_alloc_file_pages+0x7c/0xf0 drivers/iommu/iommufd/pages.c:1425
    iopt_map_file_pages+0x184/0x1e0 drivers/iommu/iommufd/io_pagetable.c:518
    iommufd_ioas_map_file+0x152/0x2f0 drivers/iommu/iommufd/ioas.c:231
    iommufd_fops_ioctl+0x1ed/0x370 drivers/iommu/iommufd/main.c:556
    vfs_ioctl fs/ioctl.c:51 [inline]
    __do_sys_ioctl fs/ioctl.c:597 [inline]
    __se_sys_ioctl fs/ioctl.c:583 [inline]
    __x64_sys_ioctl+0xf4/0x140 fs/ioctl.c:583
    do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
    do_syscall_64+0xe9/0x530 arch/x86/entry/syscall_64.c:84
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

connection error: failed to recv *flatrpc.ExecutorMessageRawT: read tcp 127.0.0.1:41845->127.0.0.1:36772: read: connection reset by peer


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
