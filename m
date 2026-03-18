Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044AA30DD11
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 05:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773810126; cv=none; b=P3QwS7vehtgpWR24cvoS++vTxSze24uToOZN5OCV2GguGlq8nUidK2hDmUya5ggaCloP2Pmm3Ww6AsqaMw2S/nEaGGy+JQLmzhlU63At1bNJJ8zvQnjZ7mVa8u/ahnqQ4xiyrvpAvZTed8h1+zOHIMc33EKmxD3usEWNNSDFDFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773810126; c=relaxed/simple;
	bh=pTs4MzvoYqHL1k5EQGgwDF9thFZmA+CD5l2JYlCv4Zg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ueNCZoEpxV8azoYoXt1FNvAcH5tLz8lK5w7JUGbA/uQGBQlZ+dP+hvXadOcG7TqO3aherm6IpTLqncXVprSrgDX8HowFUbHseCwqfsKGIwyUqezDY9q58LbMtwfLTE7A/cN1DBhICvJI7Nnyui3djjfES/9XdBjnTWzHL30n5SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-67c1228b2a1so2244548eaf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 22:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773810122; x=1774414922;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XP4T4iMaCErg7kQXZBXgUrqdcl4Ozy9ZpxYT+MtYY3I=;
        b=k5zLe5yzJ4Li3Y5n3bsSmNZqg5rKZ0qvkJn0vdNkmGcYZJT3LUINPVMjvuFNRQ/FVw
         dyewhQYsfBwk6uySwNFY3B2HhxSL2BvGHwbbgS3GIDZpTdfVr0Kl3bIwapYFCYpNuU++
         MMMI7fyXf4vmynnwBvyok2HaXltBHuRfATc0mWnsH7RDJjbnQj+KOxF3ljM/Dv8dA4Dl
         47p2HRA8pb784KHvkKIcPgEoc4rvBivhZIisd2Dt/IlYIbiyHRHYS9husUB6jhV+48lR
         oz4wyISPi3Qo59J9MyNpM2pyUCbrEjfh9GqtXqUSXEkVSAAl3dyPSjltqS5zrkpFDHqy
         inMg==
X-Forwarded-Encrypted: i=1; AJvYcCXaTuegxgfEKzez6t5wFwInA4yGQSaVuWn6GIgE/OIWLBwNsSWan1k/hQNUQkODz8Xaj31o/Z8xB7dSkYO0@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5PMCtm0tVpYhN01/ST2zVQyyMN4MTL7EtzRwFocu7WzUFtXTr
	g71kPs40djo78lyvm5QjCVkNU/AWqNuhgdodylbbfSEVvViKA6R/J/matAx78YW7WfVIL3OoIY1
	2jionqJG9j9vXvEbbf2IFy45yWdPtRfBLAuxz7UXME4UmmEskQA2A0vVSsYg=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4887:b0:66b:6862:18d5 with SMTP id
 006d021491bc7-67c0da588ddmr1007794eaf.8.1773810121701; Tue, 17 Mar 2026
 22:02:01 -0700 (PDT)
Date: Tue, 17 Mar 2026 22:02:01 -0700
In-Reply-To: <abolyGbAyynUANDB@hyeyoo>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69ba31c9.050a0220.3077e3.0002.GAE@google.com>
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
unreferenced object 0xffff888129413800 (size 512):
  comm "kworker/u8:3", pid 58, jiffies 4294947638
  hex dump (first 32 bytes):
    00 ac 98 1c 81 88 ff ff 00 18 6b 0a 81 88 ff ff  ..........k.....
    00 12 04 00 81 88 ff ff 3c 00 00 00 00 00 00 00  ........<.......
  backtrace (crc 10da2a4f):
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

BUG: memory leak
unreferenced object 0xffff88812a621a00 (size 512):
  comm "kworker/u8:3", pid 58, jiffies 4294950606
  hex dump (first 32 bytes):
    00 18 62 2a 81 88 ff ff 00 d6 04 00 81 88 ff ff  ..b*............
    00 12 04 00 81 88 ff ff 3c 00 00 00 00 00 00 00  ........<.......
  backtrace (crc 231cde90):
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

BUG: memory leak
unreferenced object 0xffff88812a621800 (size 512):
  comm "kworker/u8:6", pid 932, jiffies 4294950638
  hex dump (first 32 bytes):
    00 18 6b 0a 81 88 ff ff 00 1a 62 2a 81 88 ff ff  ..k.......b*....
    00 12 04 00 81 88 ff ff 3c 00 00 00 00 00 00 00  ........<.......
  backtrace (crc 9a0f4a55):
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
console output: https://syzkaller.appspot.com/x/log.txt?x=15c4974a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e2bba615ee79faa5
dashboard link: https://syzkaller.appspot.com/bug?extid=cae7809e9dc1459e4e63
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=178fc216580000

