Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C0F26B755
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 03:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773803286; cv=none; b=tM6Sal/cJrAvlEZC5zH6mkTpwA8N7AWMqCYGut5qZuw27ezi5y7D+NC/N2/X36mBZKUhg7PQupC4Eem95ij3BH7rZQJ/OxGK12yE3K/uX5aaOhnLK014I8hbjXP7XdLLhiL7lJnDT5IibYZErnzKMoUirIXbPcBpXhZ6gawuTiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773803286; c=relaxed/simple;
	bh=Pm+rxUj16jii2JZbOZ/rTJ2V1uCOE7Zp0jiPRSW3nxY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=O5QmANP6VbBOMl/Hxz6Q+UqvMBq5eyHzIf3gosz8poILaDp4ccIZhQuhazEs15a1uPrYB2E0fB8Aivwbv7JYnJCHzzswmfnf+gnDrpu7xeZy9/Bticza6kF872ZjgEz0eU2RyaZ8EAMLMBmsjnG8tp8ECdOTQbiXBtOjyCBZApU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-4170466438dso26282509fac.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 20:08:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773803283; x=1774408083;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gxvOJNpri5w4RKCQDfdsWJpDQ+y1OdANJaHF9wxYFME=;
        b=HOXtXb/xPmcynykgqhwpOqK8rQFx/C+W7BHUF2DZoEdVsb/HrhWQUc424iRkwHdU9+
         B+6zGJdDb01eusydgPPRH0fMuVvJiBWtaAk6bop7OtPOog3IklKHoY7Er56WhRnov1Lz
         ev3FemAS2AW6HTt724weOsT/TRvucFVGsJ0APCM7cZBBNFFhNB+t07mNizB1aELyS69w
         t9+LqqL6Ts0TkeD0Q+xb+jQs9bScM6mel08jPTQ39u6I8x9WFcsK5ykv1hdl/4YB92ef
         7kxNUm0o/r9V/wxx0dZ2ZSuB8+OXpdmy1Cp9DLCLz3D+VhWrxiinIAsGcLvjV9pSAXlb
         Tm0w==
X-Forwarded-Encrypted: i=1; AJvYcCXg1N8+IHTJXoXl2/ujSGRxEKNPfDGJ28H8S5x4V8DEg8RmfBz5raTAfwMI7OH17EG0WeRYtF6VJ7OtGy9+@vger.kernel.org
X-Gm-Message-State: AOJu0YypTPOXBxLJjxvFhd43KU1GeWjA2CYlYQYEOFmzf/+Kj5ukl93d
	uY2yqVkdaNNyD4io0PVoyLYaYSAWjNqR4a8RiDg3+sVHwUkfi9OB6DN+d7rJ0FOosP1VMKyyJej
	rlxxN4x2zK0JcfHwVHyfoWCnid07ORgsMh1U68+3691fcmSGlEMvR4X0MyB4=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1ca9:b0:67b:a489:3b6f with SMTP id
 006d021491bc7-67c0db5551fmr1348347eaf.66.1773803283716; Tue, 17 Mar 2026
 20:08:03 -0700 (PDT)
Date: Tue, 17 Mar 2026 20:08:03 -0700
In-Reply-To: <aboPKERGvOniN-OK@hyeyoo>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69ba1713.050a0220.3077e3.0001.GAE@google.com>
Subject: Re: [syzbot] [mm?] [f2fs?] [exfat?] memory leak in __kfree_rcu_sheaf
From: syzbot <syzbot+cae7809e9dc1459e4e63@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, catalin.marinas@arm.com, chao@kernel.org, 
	hao.li@linux.dev, harry.yoo@oracle.com, jaegeuk@kernel.org, jannh@google.com, 
	liam.howlett@oracle.com, linkinjeon@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	pfalcato@suse.de, sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, 
	vbabka@kernel.org, vbabka@suse.cz, wangqing7171@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
memory leak in __pcs_replace_empty_main

BUG: memory leak
unreferenced object 0xffff88810e983c00 (size 512):
  comm "softirq", pid 0, jiffies 4294948614
  hex dump (first 32 bytes):
    c8 2c 04 00 81 88 ff ff 00 a4 98 0e 81 88 ff ff  .,..............
    00 12 04 00 81 88 ff ff 3c 00 00 00 00 00 00 00  ........<.......
  backtrace (crc 8f5c2bf9):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4543 [inline]
    slab_alloc_node mm/slub.c:4866 [inline]
    __do_kmalloc_node mm/slub.c:5259 [inline]
    __kmalloc_noprof+0x3bd/0x560 mm/slub.c:5272
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __alloc_empty_sheaf+0x35/0x50 mm/slub.c:2764
    alloc_empty_sheaf mm/slub.c:2779 [inline]
    alloc_full_sheaf mm/slub.c:2829 [inline]
    __pcs_replace_empty_main+0x1e0/0x2f0 mm/slub.c:4626
    alloc_from_pcs mm/slub.c:4717 [inline]
    slab_alloc_node mm/slub.c:4851 [inline]
    __do_kmalloc_node mm/slub.c:5259 [inline]
    __kmalloc_noprof+0x4c5/0x560 mm/slub.c:5272
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    cfg80211_inform_single_bss_data+0x21d/0xa70 net/wireless/scan.c:2344
    cfg80211_inform_bss_data+0x13f/0x1dc0 net/wireless/scan.c:3226
    cfg80211_inform_bss_frame_data+0x108/0x340 net/wireless/scan.c:3317
    ieee80211_bss_info_update+0x13a/0x320 net/mac80211/scan.c:230
    ieee80211_scan_rx+0x269/0x3b0 net/mac80211/scan.c:364
    __ieee80211_rx_handle_packet net/mac80211/rx.c:5305 [inline]
    ieee80211_rx_list+0x111b/0x1850 net/mac80211/rx.c:5588
    ieee80211_rx_napi+0x50/0x110 net/mac80211/rx.c:5611
    ieee80211_rx include/net/mac80211.h:5267 [inline]
    ieee80211_handle_queued_frames+0x9c/0xf0 net/mac80211/main.c:452
    tasklet_action_common+0xb7/0x270 kernel/softirq.c:925
    handle_softirqs+0xdf/0x2c0 kernel/softirq.c:622
    __do_softirq kernel/softirq.c:656 [inline]
    invoke_softirq kernel/softirq.c:496 [inline]
    __irq_exit_rcu+0x91/0xb0 kernel/softirq.c:723
    instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1056 [inline]
    sysvec_apic_timer_interrupt+0x73/0x80 arch/x86/kernel/apic/apic.c:1056

BUG: memory leak
unreferenced object 0xffff88810e98a400 (size 512):
  comm "kworker/u8:7", pid 1022, jiffies 4294952987
  hex dump (first 32 bytes):
    00 3c 98 0e 81 88 ff ff 00 68 cd 2a 81 88 ff ff  .<.......h.*....
    00 12 04 00 81 88 ff ff 3c 00 00 00 00 00 00 00  ........<.......
  backtrace (crc b6e2f12f):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4543 [inline]
    slab_alloc_node mm/slub.c:4866 [inline]
    __do_kmalloc_node mm/slub.c:5259 [inline]
    __kmalloc_noprof+0x3bd/0x560 mm/slub.c:5272
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __alloc_empty_sheaf+0x35/0x50 mm/slub.c:2764
    alloc_empty_sheaf mm/slub.c:2779 [inline]
    alloc_full_sheaf mm/slub.c:2829 [inline]
    __pcs_replace_empty_main+0x1e0/0x2f0 mm/slub.c:4626
    alloc_from_pcs mm/slub.c:4717 [inline]
    slab_alloc_node mm/slub.c:4851 [inline]
    __do_kmalloc_node mm/slub.c:5259 [inline]
    __kmalloc_noprof+0x4c5/0x560 mm/slub.c:5272
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    cfg80211_inform_single_bss_data+0x21d/0xa70 net/wireless/scan.c:2344
    cfg80211_inform_bss_data+0x13f/0x1dc0 net/wireless/scan.c:3226
    cfg80211_inform_bss_frame_data+0x108/0x340 net/wireless/scan.c:3317
    ieee80211_bss_info_update+0x13a/0x320 net/mac80211/scan.c:230
    ieee80211_rx_bss_info net/mac80211/ibss.c:1094 [inline]
    ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1575 [inline]
    ieee80211_ibss_rx_queued_mgmt+0xb75/0x1230 net/mac80211/ibss.c:1602
    ieee80211_iface_process_skb net/mac80211/iface.c:1748 [inline]
    ieee80211_iface_work+0x6af/0x9b0 net/mac80211/iface.c:1802
    cfg80211_wiphy_work+0x1db/0x280 net/wireless/core.c:440
    process_one_work+0x277/0x5f0 kernel/workqueue.c:3276
    process_scheduled_works kernel/workqueue.c:3359 [inline]
    worker_thread+0x255/0x4a0 kernel/workqueue.c:3440
    kthread+0x14e/0x1a0 kernel/kthread.c:436
    ret_from_fork+0x23c/0x4b0 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF


Tested on:

commit:         a989fde7 Merge tag 'libnvdimm-fixes-7.0-rc5' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1005f8da580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e2bba615ee79faa5
dashboard link: https://syzkaller.appspot.com/bug?extid=cae7809e9dc1459e4e63
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1405b406580000

