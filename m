Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net [178.154.239.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5083F927A;
	Thu, 13 Aug 2026 09:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786614332; cv=none; b=EBOA8cmt4ES96cpODn3lt5NYew3Rb+lCB2Uw8wOAtdrKVlMPNXcB6vCZJcTDB/1cgGPjhbB4lnxtaw0+0nnQJItlBv65SoIKyb7NcIS6IQWqFyTXno/KgMGiCKa/a+aoZ8cHVI8jOstAkv273lOyaHDtmfF3VSFsPqw76wOdv2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786614332; c=relaxed/simple;
	bh=lww/qlp/RkNOWt5+SQ/FDFpS8A3P7SH7tLkWCFp2LrY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pTR7eB8lLDQWCJLKSpXUlmWydRUMnTW67CVopLqfpPjj6C6+8yKVaLAHs1LZQV/D7In7BDtLyU0v7bYCYcpr1fQhH+w9pyi1+aDT1kXOOYSzaZN7FxOReLKCKcfsKiL22ZUa7nqVLoOK6lsMcJko/ozOuIJiuVwj/FRKlMgSAZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=obF4Zf4R; arc=none smtp.client-ip=178.154.239.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="obF4Zf4R"
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net [IPv6:2a02:6b8:c11:43a8:0:640:574d:0])
	by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id C3E8680628;
	Thu, 13 Aug 2026 12:43:36 +0300 (MSK)
Received: from [127.0.1.1] (unknown [2a02:6bf:8009:1403:13e2:aa39:7988:f1b2])
	by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA id YhMvcMH3p0U0-KYQo6iWS;
	Thu, 13 Aug 2026 12:43:36 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1786614216;
	bh=UsP2hNIQNYfiUm+QNN7IB2GVrEr/OJJaICJCQTlk/LA=;
	h=Cc:To:Message-Id:Date:Subject:From;
	b=obF4Zf4R4bQ4gpn6ndjoH4Lea6shYgiObCB5+D7Yju/JaabtSgKZQ8OGjGCBK6Te7
	 V8WFqHYhMjBbHxq5izZfccLNGcXLpGGrc5dckIALHhvJ0BIIHSTB10BNsri0oR5jVE
	 qGZsymWzGyP02O7lNNh0RdH5DXgcv0OLZP++wH2Q=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Mikhail Rudenko <xyzzy@yandex-team.ru>
Subject: [PATCH RFC 0/2] Defer final iputs for dirty-time inodes in
 PF_MEMALLOC context
Date: Thu, 13 Aug 2026 12:43:28 +0300
Message-Id: <20260813-deferred-dirtytime-iput-v1-0-ad2fb3ad6bdb@yandex-team.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQrCMBREr1JmbSANWMWt4AHcioummegXrOUnl
 ZbSuxt1+YZ5b0GiChMO1QLlW5K8+gL1pkJ3b/sbjYTCcNY1dl87ExipymCCaJ6zPMtjGLNpuYs
 uWu8bu0WxB2WU6Ve+4Hw64vof0+gf7PK3iXX9APK8kuGAAAAA
X-Change-ID: 20260812-deferred-dirtytime-iput-ae7f2f0bb605
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mikhail Rudenko <xyzzy@yandex-team.ru>
X-Mailer: b4 0.15.2

The motivation for this small series is the following kernel WARNING:

[  893.915584] ------------[ cut here ]------------
[  893.915589] WARNING: mm/page_alloc.c:4749 at __alloc_pages_slowpath.constprop.0+0xd4d/0x10f0, CPU#1: stress-ng-vm/3784
[  893.915599] Modules linked in: kheaders squashfs intel_rapl_msr intel_rapl_common kvm_intel kvm i2c_i801 ppdev cfg80211 i2c_mux irqbypass i2c_smbus lpc_ich parport_pc ghash_clmulni_intel mfd_core parport rfkill input_leds tpm_tis tpm_tis_core binfmt_misc sch_fq_codel dm_multipath drm msr fuse efi_pstore configfs nfnetlink dmi_sysfs qemu_fw_cfg autofs4
[  893.915629] CPU: 1 UID: 0 PID: 3784 Comm: stress-ng-vm Not tainted 7.0.11 #87 PREEMPT(lazy)
[  893.915633] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS Arch Linux 1.17.0-2-2 04/01/2014
[  893.915635] RIP: 0010:__alloc_pages_slowpath.constprop.0+0xd4d/0x10f0
[  893.915639] Code: 48 c7 44 24 18 00 00 00 00 e9 da fd ff ff 0f 0b c7 44 24 38 00 00 00 00 65 48 8b 05 85 a2 5f 02 f6 40 2d 08 0f 84 10 f3 ff ff <0f> 0b e9 09 f3 ff ff f3 90 8b 05 74 6f 6b 02 a8 01 75 f4 89 44 24
[  893.915642] RSP: 0000:ffffc900058cb3d0 EFLAGS: 00010202
[  893.915645] RAX: ffff8881fb95a500 RBX: 0000000000000000 RCX: 0000000000000002
[  893.915647] RDX: ffffc900058cb4c0 RSI: 0000000000000000 RDI: 0000000000008000
[  893.915648] RBP: ffffc900058cb4c0 R08: 0000000000000801 R09: 000000000000304f
[  893.915649] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000148c48
[  893.915650] R13: 0000000000000000 R14: 0000000000148c48 R15: 0000000000000000
[  893.915652] FS:  00007fce6009eac0(0000) GS:ffff8881f8136000(0000) knlGS:0000000000000000
[  893.915653] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  893.915655] CR2: 00007fce52f50000 CR3: 00000001fd821004 CR4: 0000000000f72ef0
[  893.915660] PKRU: 55555554
[  893.915662] Call Trace:
[  893.915664]  <TASK>
[  893.915668]  ? get_page_from_freelist+0x6a5/0x1090
[  893.915673]  ? mod_memcg_lruvec_state+0xab/0x1e0
[  893.915678]  __alloc_frozen_pages_noprof+0x377/0x390
[  893.915683]  alloc_pages_mpol+0x7b/0x160
[  893.915687]  folio_alloc_noprof+0x14/0x90
[  893.915691]  __filemap_get_folio_mpol+0x219/0x440
[  893.915696]  __getblk_slow+0x88/0x270
[  893.915701]  __ext4_get_inode_loc+0x148/0x570
[  893.915707]  ? __ext4_handle_dirty_metadata+0x70/0x1f0
[  893.915711]  ? ext4_get_inode_loc+0x41/0xa0
[  893.915714]  ext4_get_inode_loc+0x41/0xa0
[  893.915717]  ext4_reserve_inode_write+0x4d/0x100
[  893.915720]  __ext4_mark_inode_dirty+0x6b/0x240
[  893.915723]  ? jbd2__journal_start+0xfe/0x210
[  893.915729]  ext4_dirty_inode+0x5c/0x80
[  893.915732]  __mark_inode_dirty+0x63/0x3f0
[  893.915737]  sync_lazytime+0xe7/0x100
[  893.915741]  iput+0x6a/0x220
[  893.915745]  __dentry_kill+0x74/0x190
[  893.915749]  shrink_dentry_list+0xa3/0x160
[  893.915753]  prune_dcache_sb+0x57/0x80
[  893.915756]  super_cache_scan+0x120/0x1c0
[  893.915762]  do_shrink_slab+0x14a/0x380
[  893.915766]  shrink_slab+0x2c5/0x3e0
[  893.915769]  shrink_node+0x2df/0x830
[  893.915774]  do_try_to_free_pages+0xf0/0x560
[  893.915779]  try_to_free_pages+0xd8/0x210
[  893.915784]  __alloc_pages_slowpath.constprop.0+0x2f8/0x10f0
[  893.915788]  ? mod_memcg_state+0x9c/0x1d0
[  893.915792]  __alloc_frozen_pages_noprof+0x377/0x390
[  893.915796]  alloc_pages_mpol+0x7b/0x160
[  893.915798]  vma_alloc_folio_noprof+0x65/0x130
[  893.915802]  do_anonymous_page+0x260/0x820
[  893.915806]  ? __pte_offset_map+0x1b/0xd0
[  893.915810]  __handle_mm_fault+0xaf8/0xf70
[  893.915815]  handle_mm_fault+0x101/0x330
[  893.915818]  do_user_addr_fault+0x21b/0x6c0
[  893.915824]  exc_page_fault+0x80/0x1c0
[  893.915829]  asm_exc_page_fault+0x26/0x30
[  893.915833] RIP: 0033:0x5601e3ae5af5
[  893.915837] Code: ec 08 48 8b 15 b4 89 92 00 4c 8b 59 10 48 01 fa 4c 39 ca 0f 83 c4 00 00 00 31 c9 66 2e 0f 1f 84 00 00 00 00 00 89 cf 83 c1 01 <40> 88 3a 48 8b 3d 81 89 92 00 48 01 fa 4c 39 ca 72 e9 31 d2 48 89
[  893.915839] RSP: 002b:00007fff792403d0 EFLAGS: 00010202
[  893.915842] RAX: 0000000000000010 RBX: 00007fce5fc8b398 RCX: 00000000075bd401
[  893.915843] RDX: 00007fce52f50000 RSI: 00000001e1400000 RDI: 00000000075bd400
[  893.915845] RBP: 00007fff792403f0 R08: 0000000000000000 R09: 00007fce5d400000
[  893.915847] R10: 00007fcc7c000000 R11: 0000000000000000 R12: 00007fce5fc8b398
[  893.915848] R13: 00000001e1400000 R14: 0000000000000000 R15: 00007fff792405d0
[  893.915851]  </TASK>
[  893.915852] ---[ end trace 0000000000000000 ]---

It was initially observed in the wild on linux 6.12.y, but later I
reproduced it in Qemu with linux 7.0.11. I believe it is still an
issue in the mainline master. Similar issue was reported earlier [1],
but looks like no real analysis was performed then.

The warning is triggered when a process with PF_MEMALLOC flag set
requests a __GFP_NOFAIL page allocation. In this case, the allocation
comes from ext4_dirty_inode() called when shrinker frees a dentry,
resulting in i_count of an inode going zero, which in it turn can
trigger sync_lazytime() if said inode has I_DIRTY_TIME flag, resulting
in inode becoming dirty. On ext4 this causes an immediate journal
transaction, which may lead to __GFP_NOFAIL allocation in the
slowpath.

The proposed approach to fix this basically boils down to "if need to
do sync_lazytime() in PF_MEMALLOC context, defer instead".

Patch 1 adds basic per-superblock infrastracture for deferring iputs:
a workqueue, a work_struct, a list, a bool flag, a spinlock, and some
glue code. A tricky place is superblock shutdown: we should stop
accepting deferred iputs not too early, so that no legit cases fail to
defer, and not too late, so that superblock is still operational and
we can flush the workqueue. Since we cannot enter
deactivate_locked_super() from PF_MEMALLOC context, stopping after
shrinker_free() seems safe.

Patch 2 uses this infrastructure to defer iputs of inodes with
I_DIRTY_TIME, which would trigger sync_lazytime() otherwise, when
running in PF_MEMALLOC context. Clumping default and PF_MEMALLOC paths
together in iput() would have resulted in decreased readablity, so I
avoided that by setting up a separate iput_memalloc(), at cost of
slight code duplication.

[1] https://lkml.iu.edu/2601.2/06130.html

---
Mikhail Rudenko (2):
      fs: add superblock deferred iput infrastructure
      fs: defer dirtytime iput from PF_MEMALLOC context

 fs/dcache.c                    |  1 +
 fs/inode.c                     | 45 ++++++++++++++++++++-
 fs/internal.h                  |  3 ++
 fs/super.c                     | 92 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs/super_types.h |  6 +++
 5 files changed, 146 insertions(+), 1 deletion(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260812-deferred-dirtytime-iput-ae7f2f0bb605

Best regards,
--  
Mikhail Rudenko <xyzzy@yandex-team.ru>

