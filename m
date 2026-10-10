Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816B63C2B9B
	for <linux-fsdevel@vger.kernel.org>; Sat, 10 Oct 2026 08:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791622591; cv=none; b=u7ORu0vHXo3tqUqtWgAB2mEmqyFw5gWa2km6HdCnHnG4+huOJZNjQAVM9HFbjJxvjhVMhdnZix0kQUazcDX04gFj1Hl4xqhLQ+1K3qRaV+PkwVaHnIrP13M8ucj4Gq1Mw5v1Jv2oRFl7ScDrAOZL3f6+VG3m4+m+noyfwMdrxKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791622591; c=relaxed/simple;
	bh=DSpS3bSiLKZn3l0kYtOd5x5P6qmB1vPDgvJscjdMtuU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SWqeswRKiPwJZwHsOUdwtIeJVsUijjL+AcunzCKq1C0vxWn3uQyHpcOflZh7WE1cx6eyani/QE0/fliVwd78Yx6BvbfMdqBWmRzB5YRAtJaB/+k5mHorC+PKhuSc9QL9xdOF4CCitADCi1pNVAFox59zMoo7sVU1KPxA+ccgQLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BbXpP9bp; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BbXpP9bp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791622589; x=1823158589;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DSpS3bSiLKZn3l0kYtOd5x5P6qmB1vPDgvJscjdMtuU=;
  b=BbXpP9bp+zMEJOR0HWCJyg4pzmtbOIlVyAcgCdUrSSIaZu6XHPh9S6O3
   Q/RjF832q5Ck/nvrd95BNaPor7djj+nHNb9xeIiqNhGMvEvWzfm+UkiRd
   F8db9LolqsBXujKg9gAxedS3pz2MvrB46w2dmlxG9KYwTMMUiWSpS73Pd
   eRwk5SzMApGGBKm0YPjDziBRLEeH2zZF7ZRznXrd0foaOQFDzXUzgetcH
   DRfh4DL0anIGILXwuQ38Dn/u+SBGGBSRVAUpdiQelwv4Xd/4lVyF8qm8U
   OlEoqK60B9DZnFMalUxrM5sQA83N6Ul33e9ZjujkU7un5HrXvSYFd2SFc
   g==;
X-CSE-ConnectionGUID: WdM8jolQSQKuD7WXmY6YYA==
X-CSE-MsgGUID: GsEZs38oR7eAUlkTdcAXxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="288737"
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="288737"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2026 01:56:28 -0700
X-CSE-ConnectionGUID: Qyqum+gdTASebE2A6hwbXQ==
X-CSE-MsgGUID: kKHQmbOVTuO3dxamKnSyeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="587890"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2026 01:56:24 -0700
Date: Sat, 10 Oct 2026 16:56:22 +0800
From: kernel test robot <yi1.lai@intel.com>
To: Yury Norov <ynorov@nvidia.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Andrew Ballance <andrewjballance@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	yi1.lai@intel.com
Subject: [linux-next:master] [lib]  6b23a67486:
 WARNING:possible_circular_locking_dependency_detected
Message-ID: <202610101009.240d59d9-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Hello,

kernel test robot noticed "WARNING:possible_circular_locking_dependency_detected" on:

commit: 6b23a6748698a7cbda7d18a3a28e59be63254571 ("lib: fix lock initialization in region allocation benchmark") https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master aac26bee2287c88af5be5a5ff96d783b19a28790]

in testcase: locktorture
with following parameters:

	runtime: 300s
	test: cpuhotplug
	torture_type: mutex_lock

config: i386-randconfig-2103-20261007
compiler: gcc-13
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 4 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)

If you fix the issue in a separate patch/commit (i.e. not just a new version of the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yi1.lai@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202610101009.240d59d9-lkp@intel.com

[   42.982991][  T184] WARNING: possible circular locking dependency detected
[   42.989787][  T184] 7.3.0-rc5+ #1 Not tainted
[   42.991360][  T184] ------------------------------------------------------
[   42.999839][  T184] systemd-udevd/184 is trying to acquire lock:
[   43.001945][  T184] bb80a5d0 (&sb->s_type->i_lock_key){+.+.}-{3:3}, at: igrab (linux/spinlock.h:347 inode.c:1594)
[   43.009033][  T184]
[   43.009033][  T184] but task is already holding lock:
[   43.009033][  T184]
[   43.009033][  T184] but task is already holding lock:
[   43.009033][  T184]
[   43.009033][  T184] but task is already holding lock:
[   43.011272][  T184] b9933d1c (&l->lock){+.+.}-{3:3}, at: __list_lru_walk_one+0x4d/0xe7
[   43.016330][  T184]
[   43.016330][  T184] which lock already depends on the new lock.
[   43.016330][  T184]
[   43.016330][  T184] which lock already depends on the new lock.
[   43.016330][  T184]
[   43.016330][  T184] which lock already depends on the new lock.
[   43.016330][  T184]
[   43.016333][  T184]
[   43.016333][  T184] the existing dependency chain (in reverse order) is:
[   43.016333][  T184]
[   43.016333][  T184] the existing dependency chain (in reverse order) is:
[   43.016333][  T184]
[   43.016333][  T184] the existing dependency chain (in reverse order) is:
[   43.016334][  T184]
[   43.016334][  T184] -> #2 (&l->lock){+.+.}-{3:3}:
[   43.016334][  T184]
[   43.016334][  T184] -> #2 (&l->lock){+.+.}-{3:3}:
[   43.016334][  T184]
[   43.016334][  T184] -> #2 (&l->lock){+.+.}-{3:3}:
[   43.016341][  T184]
[   43.016341][  T184] -> #1 (&lockref->lock){+.+.}-{3:3}:
[   43.016341][  T184]
[   43.016341][  T184] -> #1 (&lockref->lock){+.+.}-{3:3}:
[   43.016341][  T184]
[   43.016341][  T184] -> #1 (&lockref->lock){+.+.}-{3:3}:
[   43.016346][  T184]
[   43.016346][  T184] -> #0 (&sb->s_type->i_lock_key){+.+.}-{3:3}:
[   43.016346][  T184]
[   43.016346][  T184] -> #0 (&sb->s_type->i_lock_key){+.+.}-{3:3}:
[   43.016346][  T184]
[   43.016346][  T184] -> #0 (&sb->s_type->i_lock_key){+.+.}-{3:3}:
[   43.016350][  T184]        check_noncircular (locking/lockdep.c:2219)
[   43.016357][  T184]        check_prev_add (locking/lockdep.c:3209)
[   43.016359][  T184]        validate_chain (locking/lockdep.c:3328 locking/lockdep.c:3952)
[   43.016361][  T184]        __lock_acquire (locking/lockdep.c:5288)
[   43.016363][  T184]        lock_acquire (locking/lockdep.c:5942 locking/lockdep.c:5899)
[   43.016366][  T184]        _raw_spin_lock (linux/spinlock_api_smp.h:190 (discriminator 1) locking/spinlock.c:173 (discriminator 1))
[   43.016371][  T184]        igrab (linux/spinlock.h:347 inode.c:1594)
[   43.016374][  T184]        shmem_unused_huge_isolate (shmem.c:874)
[   43.016380][  T184]        __list_lru_walk_one+0x8b/0xe7
[   43.016383][  T184]        list_lru_walk_one (list_lru.c:399)
[   43.016385][  T184]        list_lru_walk_node (list_lru.c:419)
[   43.016388][  T184]        shmem_unused_huge_shrink (linux/list_lru.h:352 shmem.c:969)
[   43.016390][  T184]        shmem_alloc_and_add_folio+0x119/0x1bf
[   43.016393][  T184]        shmem_get_folio_gfp+0x1a0/0x3ba
[   43.016395][  T184]        shmem_get_folio (shmem.c:2832 (discriminator 1))
[   43.016397][  T184]        shmem_write_begin (shmem.c:3467)
[   43.016400][  T184]        generic_perform_write (filemap.c:4374)
[   43.016403][  T184]        shmem_file_write_iter (shmem.c:3642)
[   43.016406][  T184]        vfs_write (read_write.c:595 read_write.c:687)
[   43.016410][  T184]        ksys_write (read_write.c:739)
[   43.016413][  T184]        __ia32_sys_write (read_write.c:750 read_write.c:747 read_write.c:747)
[   43.016416][  T184]        ia32_sys_call (kbuild/obj/consumer/i386-randconfig-2103-20261007/./arch/x86/include/generated/asm/syscalls_32.h:5)
[   43.016419][  T184]        do_int80_syscall_32 (x86/entry/syscall_32.c:79 x86/entry/syscall_32.c:250)
[   43.016423][  T184]        restore_all_switch_stack (x86/entry/entry_32.S:945)
[   43.016425][  T184]
[   43.016425][  T184] other info that might help us debug this:
[   43.016425][  T184]
[   43.016425][  T184] other info that might help us debug this:
[   43.016425][  T184]
[   43.016425][  T184] other info that might help us debug this:
[   43.016425][  T184]
[   43.016426][  T184] Chain exists of:
[   43.016426][  T184]   &sb->s_type->i_lock_key --> &lockref->lock --> &l->lock
[   43.016426][  T184]
[   43.016426][  T184] Chain exists of:
[   43.016426][  T184]   &sb->s_type->i_lock_key --> &lockref->lock --> &l->lock
[   43.016426][  T184]
[   43.016426][  T184] Chain exists of:
[   43.016426][  T184]   &sb->s_type->i_lock_key --> &lockref->lock --> &l->lock
[   43.016426][  T184]
[   43.016431][  T184]  Possible unsafe locking scenario:
[   43.016431][  T184]
[   43.016431][  T184]  Possible unsafe locking scenario:
[   43.016431][  T184]
[   43.016431][  T184]  Possible unsafe locking scenario:
[   43.016431][  T184]
[   43.016432][  T184]        CPU0                    CPU1
[   43.016433][  T184]        ----                    ----
[   43.016434][  T184]   lock(&l->lock);
[   43.016436][  T184]                                lock(&lockref->lock);
[   43.016438][  T184]                                lock(&l->lock);
[   43.016440][  T184]   lock(&sb->s_type->i_lock_key);
[   43.016442][  T184]
[   43.016442][  T184]  *** DEADLOCK ***
[   43.016442][  T184]
[   43.016442][  T184]  *** DEADLOCK ***
[   43.016442][  T184]
[   43.016442][  T184]  *** DEADLOCK ***
[   43.016442][  T184]
[   43.016443][  T184] locks held by systemd-udevd/184: 4, last CPU#1:
[   43.016446][  T184]  #0: bbd65278 (sb_writers#5){.+.+}-{0:0}, at: file_start_write+0x1e/0x29
[   43.016455][  T184]  #1: bc0d3a54 (&sb->s_type->i_mutex_key#14){+.+.}-{4:4}, at: shmem_file_write_iter (linux/fs.h:1024 shmem.c:3632)
[   43.016464][  T184]  #2: b9933d1c (&l->lock){+.+.}-{3:3}, at: __list_lru_walk_one+0x4d/0xe7
[   43.016470][  T184]  #3: bb80a4e0 (&info->lock){+.+.}-{3:3}, at: shmem_unused_huge_isolate (linux/spinlock.h:359 shmem.c:870)
[   43.016477][  T184]
[   43.016477][  T184] stack backtrace:
[   43.016477][  T184]
[   43.016477][  T184] stack backtrace:
[   43.016477][  T184]
[   43.016477][  T184] stack backtrace:
[   43.016480][  T184] CPU: 1 UID: 0 PID: 184 Comm: systemd-udevd Not tainted 7.3.0-rc5+ #1 PREEMPT  e5cca4e8a868af3244d8321e49341795c86a4be3
[   43.016484][  T184] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   43.016487][  T184] Call Trace:
[   43.016491][  T184]  dump_stack_lvl (dump_stack.c:94 dump_stack.c:120)
[   43.016495][  T184]  dump_stack (dump_stack.c:129)
[   43.016498][  T184]  print_circular_bug (locking/lockdep.c:2087)
[   43.016501][  T184]  check_noncircular (locking/lockdep.c:2219)
[   43.016506][  T184]  check_prev_add (locking/lockdep.c:3209)
[   43.016509][  T184]  validate_chain (locking/lockdep.c:3328 locking/lockdep.c:3952)
[   43.016513][  T184]  __lock_acquire (locking/lockdep.c:5288)
[   43.016517][  T184]  lock_acquire (locking/lockdep.c:5942 locking/lockdep.c:5899)
[   43.016520][  T184]  ? igrab (linux/spinlock.h:347 inode.c:1594)
[   43.016524][  T184]  ? __lock_release+0x49/0x108
[   43.016527][  T184]  _raw_spin_lock (linux/spinlock_api_smp.h:190 (discriminator 1) locking/spinlock.c:173 (discriminator 1))
[   43.016530][  T184]  ? igrab (linux/spinlock.h:347 inode.c:1594)
[   43.016533][  T184]  igrab (linux/spinlock.h:347 inode.c:1594)
[   43.016536][  T184]  shmem_unused_huge_isolate (shmem.c:874)
[   43.016540][  T184]  ? next_order (linux/huge_mm.h:212)
[   43.016543][  T184]  __list_lru_walk_one+0x8b/0xe7
[   43.016545][  T184]  ? next_order (linux/huge_mm.h:212)
[   43.016550][  T184]  list_lru_walk_one (list_lru.c:399)
[   43.016553][  T184]  list_lru_walk_node (list_lru.c:419)
[   43.016555][  T184]  ? next_order (linux/huge_mm.h:212)
[   43.016559][  T184]  shmem_unused_huge_shrink (linux/list_lru.h:352 shmem.c:969)
[   43.016562][  T184]  ? vm_unacct_memory (linux/mman.h:78 linux/mman.h:83)
[   43.016567][  T184]  shmem_alloc_and_add_folio+0x119/0x1bf
[   43.016570][  T184]  shmem_get_folio_gfp+0x1a0/0x3ba
[   43.016574][  T184]  shmem_get_folio (shmem.c:2832 (discriminator 1))
[   43.016578][  T184]  shmem_write_begin (shmem.c:3467)
[   43.016581][  T184]  generic_perform_write (filemap.c:4374)
[   43.016587][  T184]  shmem_file_write_iter (shmem.c:3642)
[   43.016591][  T184]  vfs_write (read_write.c:595 read_write.c:687)
[   43.016596][  T184]  ksys_write (read_write.c:739)
[   43.016600][  T184]  __ia32_sys_write (read_write.c:750 read_write.c:747 read_write.c:747)
[   43.016603][  T184]  ia32_sys_call (kbuild/obj/consumer/i386-randconfig-2103-20261007/./arch/x86/include/generated/asm/syscalls_32.h:5)
[   43.016606][  T184]  do_int80_syscall_32 (x86/entry/syscall_32.c:79 x86/entry/syscall_32.c:250)
[   43.016609][  T184]  entry_INT80_32 (x86/entry/entry_32.S:940)
[   43.016612][  T184] EIP: 0x37f80092


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20261010/202610101009.240d59d9-lkp@intel.com



--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

