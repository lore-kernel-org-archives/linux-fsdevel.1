Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BFA29A31C
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jul 2026 06:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784357240; cv=none; b=kWKqFUpILjF//P87r7leOfSwsWlAIFS0KkRhhDLjwBeNLf7RnlRThjgwC9sFmjJmy/qlwIWRKiZ8VxiQQe4Cu3YFDLj9gwyhS+z+DJsDihByl25UJU0lMKr67WvtO0tDFirt7yrZzVTO5OWy+ovr3+eAvEu8bje8LcoHxeQXQrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784357240; c=relaxed/simple;
	bh=Y7th76WwtcItj7/jCiSMZuzhw7nJ3NrD84KSq+nl9KI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=fD3xOCd5EUdzxf/Xdw4ypjYaTsRFVm/YZZ/yX/V2fZGxCsU+Cah34K6pvHhlGTpRDkd4SOGEg8bvExrqulGryMHvA1Ic/kpEFiIoWswd8d2MJHCJ41Nrq3S8M0aCviutgHqHho3IGjJEJgUfATNW3kaT20uZ/u29AZCe5CaNOco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4909b046dabso13097371b6e.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2026 23:47:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784357238; x=1784962038;
        h=content-type:cc:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=im0XS6doI6lHfHAZUyPFcDEiteNFyq5LXp1lzN7Bed0=;
        b=JTU/TQ2EvJXFGPMziJN2K3WkJXWAVa91Cn5y1JSsKX9DIRwqHHYNOC+SuIX4Cx62ak
         +mwHh6TLqfXlhLvpzSY5UDEtXqv+6qNu6F+mvLhkPbDWFgR5m4JftgArQrrZgYoEqGEo
         C3GjoXc2RxYv+r/tMThahEoSK3fDr8oHziXNHJcKcmtxbjA0e9niqOhEutzepaUBC2C8
         fHYmXlDu30g0qPaiBMNbbZ4527P/D6BKIfcNxzHacpMjWCM+iWmKhdghGV1+sILik+1p
         IeWZ9LTNqrnOg5qo9ng05e4klhwoZpFScU65wH2wN2HDurWlb+UDwNOxtjW0f12T2XDe
         aUEw==
X-Forwarded-Encrypted: i=1; AHgh+Rq7JbJ9wT4ovYGCwo27EznxBXW+4kAqwmHagTwbIhe/dqrvDhxXb6osqd7A6aaccJfUEef9EThGA4FYi0yE@vger.kernel.org
X-Gm-Message-State: AOJu0YyTZobY5H/HUHsN+sCvosmaBGUm0dalG5+PZFbwTtVVo+WZouxo
	qq+Ll8bDs0RwNTkCJI9t/6f75GQMqdVSrB/V1XiWnr8ZU9R/i5PWIJLg118enoEN1TAksRX1OSu
	/LaxCscg61Yi/0NwmALkQb8/1u7CwBC256lwHLQl2B0s72WvIsTdPuFAVrP8=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:13ca:b0:4a4:a930:1f76 with SMTP id
 5614622812f47-4a4d02f988cmr2657882b6e.11.1784357238111; Fri, 17 Jul 2026
 23:47:18 -0700 (PDT)
Date: Fri, 17 Jul 2026 23:47:18 -0700
In-Reply-To: <20260717-b4-scalable-cow-virt-pgoff-v1-0-cf24910ef094@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a5b2176.5028b7d0.1f0bb.00e1.GAE@google.com>
Subject: [syzbot ci] Re: mm/rmap: index MAP_PRIVATE file-backed folios by virt pgoff
From: syzbot ci <syzbot+ci64ff753c2913b080@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, apopple@nvidia.com, arnd@arndb.de, 
	baohua@kernel.org, baolin.wang@linux.alibaba.com, byungchul@sk.com, 
	chengming.zhou@linux.dev, david@kernel.org, dev.jain@arm.com, 
	gourry@gourry.net, gregkh@linuxfoundation.org, harry@kernel.org, jack@suse.cz, 
	jannh@google.com, joshua.hahnjy@gmail.com, kees@kernel.org, 
	lance.yang@linux.dev, liam@infradead.org, linmiaohe@huawei.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, ljs@kernel.org, 
	matthew.brost@intel.com, mhocko@suse.com, nao.horiguchi@gmail.com, 
	npache@redhat.com, peterx@redhat.com, pfalcato@suse.de, rakie.kim@sk.com, 
	riel@surriel.com, rppt@kernel.org, ryan.roberts@arm.com, surenb@google.com, 
	usama.arif@linux.dev, vbabka@kernel.org, willy@infradead.org, 
	xu.xin16@zte.com.cn, ying.huang@linux.alibaba.com, ziy@nvidia.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v1] mm/rmap: index MAP_PRIVATE file-backed folios by virt pgoff
https://lore.kernel.org/all/20260717-b4-scalable-cow-virt-pgoff-v1-0-cf24910ef094@kernel.org
* [PATCH 01/15] mm/vma: introduce VMA virtual page offset field and add helpers
* [PATCH 02/15] mm: introduce linear_virt_page_index()
* [PATCH 03/15] mm: abstract vma_address() and introduce vma_anon_address()
* [PATCH 04/15] mm: update print_bad_page_map() to show virtual page index
* [PATCH 05/15] mm: introduce and use vma_filebacked_address()
* [PATCH 06/15] mm: propagate VMA virtual page offset on map, remap, split + merge
* [PATCH 07/15] mm/rmap: track whether the page VMA mapped walk is anonymous
* [PATCH 08/15] mm: introduce and use linear_folio_page_index()
* [PATCH 09/15] mm/rmap: use virt pgoff for MAP_PRIVATE file-backed anon folios
* [PATCH 10/15] tools/testing/vma: expand VMA merge tests to assert virt pgoff
* [PATCH 11/15] tools/testing/selftests/mm: test virtual page offset merge behaviour
* [PATCH 12/15] mm/vma: only permit MAP_PRIVATE /dev/zero to be mapped anonymous
* [PATCH 13/15] mm/vma: make MAP_PRIVATE-mapped /dev/zero mappings truly anonymous
* [PATCH 14/15] tools/testing/vma: add test to assert MAP_PRIVATE-/dev/zero is anon
* [PATCH 15/15] tools/testing/selftests/mm: add MAP_PRIVATE-/dev/zero merge tests

and found the following issue:
general protection fault in mapping_wrprotect_range_one

Full report is available here:
https://ci.syzbot.org/series/b5c827e8-78a4-494c-b925-417c34a60e85

***

general protection fault in mapping_wrprotect_range_one

tree:      mm-new
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/akpm/mm.git
base:      5093dba1014c1d7f7e247fd118f0fa8f22136046
arch:      amd64
compiler:  Debian clang version 22.1.6 (++20260514074242+fc4aad7b5db3-1~exp1~20260514074407.73), Debian LLD 22.1.6
config:    https://ci.syzbot.org/builds/0d856612-f1b4-4e6e-86af-4ed3215225aa/config
syz repro: https://ci.syzbot.org/findings/3484dc14-c12f-477e-b14a-6b249c47b2fd/syz_repro

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 1 UID: 0 PID: 32 Comm: kworker/1:1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: events fb_deferred_io_work
RIP: 0010:folio_test_anon include/linux/page-flags.h:718 [inline]
RIP: 0010:mapping_wrprotect_range_one+0x147/0x230 mm/rmap.c:1246
Code: 7c 24 40 49 8d 7f 28 ba 18 00 00 00 31 f6 e8 e0 2e 14 00 48 c7 84 24 80 00 00 00 01 00 00 00 49 83 c6 18 4c 89 f0 48 c1 e8 03 <42> 80 3c 20 00 74 08 4c 89 f7 e8 ea 2b 14 00 4d 8b 36 44 89 f6 83
RSP: 0018:ffffc90000a777c0 EFLAGS: 00010206
RAX: 0000000000000003 RBX: ffffc90000a779e0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc90000a77840
RBP: ffffc90000a778e0 R08: ffffc90000a7783f R09: 0000000000000000
R10: ffffc90000a77828 R11: fffff5200014ef08 R12: dffffc0000000000
R13: 1ffff9200014eefc R14: 0000000000000018 R15: ffffc90000a77800
FS:  0000000000000000(0000) GS:ffff8882a920c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f84a91e9c38 CR3: 000000000e746000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 __rmap_walk_file+0x4cd/0x6a0 mm/rmap.c:3116
 mapping_wrprotect_range+0x110/0x180 mm/rmap.c:1294
 fb_deferred_io_work+0x15a/0x310 drivers/video/fbdev/core/fb_defio.c:399
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3405
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3486
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:folio_test_anon include/linux/page-flags.h:718 [inline]
RIP: 0010:mapping_wrprotect_range_one+0x147/0x230 mm/rmap.c:1246
Code: 7c 24 40 49 8d 7f 28 ba 18 00 00 00 31 f6 e8 e0 2e 14 00 48 c7 84 24 80 00 00 00 01 00 00 00 49 83 c6 18 4c 89 f0 48 c1 e8 03 <42> 80 3c 20 00 74 08 4c 89 f7 e8 ea 2b 14 00 4d 8b 36 44 89 f6 83
RSP: 0018:ffffc90000a777c0 EFLAGS: 00010206
RAX: 0000000000000003 RBX: ffffc90000a779e0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc90000a77840
RBP: ffffc90000a778e0 R08: ffffc90000a7783f R09: 0000000000000000
R10: ffffc90000a77828 R11: fffff5200014ef08 R12: dffffc0000000000
R13: 1ffff9200014eefc R14: 0000000000000018 R15: ffffc90000a77800
FS:  0000000000000000(0000) GS:ffff8882a920c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000025d35e991000 CR3: 0000000110c34000 CR4: 00000000000006f0
----------------
Code disassembly (best guess):
   0:	7c 24                	jl     0x26
   2:	40                   	rex
   3:	49 8d 7f 28          	lea    0x28(%r15),%rdi
   7:	ba 18 00 00 00       	mov    $0x18,%edx
   c:	31 f6                	xor    %esi,%esi
   e:	e8 e0 2e 14 00       	call   0x142ef3
  13:	48 c7 84 24 80 00 00 	movq   $0x1,0x80(%rsp)
  1a:	00 01 00 00 00
  1f:	49 83 c6 18          	add    $0x18,%r14
  23:	4c 89 f0             	mov    %r14,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	4c 89 f7             	mov    %r14,%rdi
  34:	e8 ea 2b 14 00       	call   0x142c23
  39:	4d 8b 36             	mov    (%r14),%r14
  3c:	44 89 f6             	mov    %r14d,%esi
  3f:	83                   	.byte 0x83


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

To test a patch for this bug, please reply with `#syz test`
(should be on a separate line).

The patch should be attached to the email.
Note: arguments like custom git repos and branches are not supported.
