Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6593603FB;
	Thu, 10 Sep 2026 03:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789010966; cv=none; b=BHUSmZ0a+Ql50WauEcX06AYQXWETUDRElmZBNOcgd3OvsecyB/VkObE1bwdrbrB+SB621txJWSDk0PrfJFHh8Wqy7HHfYrExHrKlH7xSAFYvfVyaornFvnhsD4SvIakyNG8P1roE5jq6JJZilLaitM5Nuq5Hgz0I/E125rQziyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789010966; c=relaxed/simple;
	bh=R5ZmA9ZvPvP1QNDogTCVyoFtS7h5Z+UX4hS7ENIPH24=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qjjQ4W+M+E5NWZ2uN1TUvlQxg9Tw+f2Xmfb/LCQ7hBJz0lmosOwZ4/nqbPeR7GeP3onuVwllkdIlirmem1XRa8RZOiFK5Uktl5iD9v+RoU8yQIjLg+28cFBg9Pk8QHRp189X97o38Ag3jgUvAzcAX2YzQykeodVDDmqa9yPpiC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jqZo0jYu; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jqZo0jYu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789010964; x=1820546964;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=R5ZmA9ZvPvP1QNDogTCVyoFtS7h5Z+UX4hS7ENIPH24=;
  b=jqZo0jYu7ijYmdxmtv86GmlfS+cvwRYHTbZCp+LGwePvlgsBhxqgD4zW
   EJtRz0Eek7bO7M+LnAu3zKtb6pXrnC8GWWQiGrbl6CzbdnavsCZwl9oLP
   3TA6a5QtiydZFP/FSsiVrnEjrlMp1vIUCzx0K60RoUFcbrCZFefTkto4N
   7CnJrDny0szR1Pm/ZXb/p394Z2c5u2J/msRMEyfEtgxLBpyXF4WHhGJRS
   QL7hsb5W8i0ujYjV9E09rPfnG2wjm0Rr7s22/A0X9YAxzukZGxLFZ+6bx
   EWmghgI8eZjOxMR8rfKytTBjrtb8D/1o/sE+L8nSCo0rRYZWr95T2lTm1
   Q==;
X-CSE-ConnectionGUID: e6Uw7himQ0KkV8RWU/J0iw==
X-CSE-MsgGUID: brf7RhPfTb6PMRUsGoeVPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="93276730"
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="93276730"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 20:29:24 -0700
X-CSE-ConnectionGUID: Gg1zQX4CT9aLpslbT2VlIw==
X-CSE-MsgGUID: Kd1uG4YoQhqLtUm6gTu4iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="275646486"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 20:29:22 -0700
Date: Thu, 10 Sep 2026 11:29:18 +0800
From: kernel test robot <yi1.lai@intel.com>
To: Yury Norov <ynorov@nvidia.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	Eliot Courtney <ecourtney@nvidia.com>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	yi1.lai@intel.com
Subject: [linus:master] [lib]  f4806cc63c:
 INFO:trying_to_register_non-static_key
Message-ID: <202609101106.771b567e-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Hello,

kernel test robot noticed "INFO:trying_to_register_non-static_key" on:

commit: f4806cc63cc65bd752fd72d84937614dca6504ec ("lib: test bitmap vs IDA vs Maple Tree performance for region allocations") https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linux-next/master a9d7ced84989ec05be09b4b8428759ef60450a0f]

in testcase: boot

config: i386-randconfig-054-20260822
compiler: gcc-14
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

If you fix the issue in a separate patch/commit (i.e. not just a new version of the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yi1.lai@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202609101106.771b567e-lkp@intel.com

[  157.121248][    T1] INFO: trying to register non-static key.
[  157.122147][    T1] The code is fine but needs lockdep annotation, or maybe
[  157.122147][    T1] you didn't initialize this object before use?
[  157.122147][    T1] turning off the locking correctness validator.
[  157.122147][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.2.0-rc4-00086-gf4806cc63cc6 #1 PREEMPT(full)  167be1ded5cf2d764b5931072317f04af057210f
[  157.122147][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  157.122147][    T1] Call Trace:
[  157.122147][    T1]  ? show_stack (x86/kernel/dumpstack.c:319 x86/kernel/dumpstack.c:337)
[  157.122147][    T1]  ? dump_stack_lvl (dump_stack.c:94 dump_stack.c:120)
[  157.122147][    T1]  ? dump_stack (dump_stack.c:129)
[  157.122147][    T1]  ? register_lock_class (locking/lockdep.c:984 locking/lockdep.c:1299)
[  157.122147][    T1]  ? __lock_acquire (locking/lockdep.c:5237)
[  157.122147][    T1]  ? __lock_acquire (locking/lockdep.c:5112)
[  157.122147][    T1]  ? lock_acquire (locking/lockdep.c:5872)
[  157.122147][    T1]  ? mtree_alloc_range (linux/spinlock.h:342 maple_tree.c:5800)
[  157.122147][    T1]  ? __lock_acquire (locking/lockdep.c:5237)
[  157.122147][    T1]  ? lock_acquire (locking/lockdep.c:5833)
[  157.122147][    T1]  ? mtree_alloc_range (linux/spinlock.h:342 maple_tree.c:5800)
[  157.122147][    T1]  ? _raw_spin_lock (linux/spinlock_api_smp.h:158 (discriminator 1) locking/spinlock.c:158 (discriminator 1))
[  157.122147][    T1]  ? mtree_alloc_range (linux/spinlock.h:342 maple_tree.c:5800)
[  157.122147][    T1]  ? __lock_release+0x42/0x140
[  157.122147][    T1]  ? kvm_clock_get_cycles (x86/kernel/kvmclock.c:80 (discriminator 1) x86/kernel/kvmclock.c:87 (discriminator 1))
[  157.122147][    T1]  ? ktime_get (time/timekeeping.c:321 time/timekeeping.c:455 time/timekeeping.c:973)
[  157.122147][    T1]  ? vprintk_default (printk/printk.c:2494)
[  157.122147][    T1]  ? benchmark_maple_tree (region_alloc_benchmark.c:136 (discriminator 1))
[  157.122147][    T1]  ? region_alloc_benchmark (region_alloc_benchmark.c:197 (discriminator 1))
[  157.122147][    T1]  ? benchmark_ida (region_alloc_benchmark.c:124)
[  157.122147][    T1]  ? do_one_initcall (main.c:1347)
[  157.122147][    T1]  ? do_initcalls (main.c:1409 (discriminator 1) main.c:1425 (discriminator 1))
[  157.122147][    T1]  ? kernel_init_freeable (main.c:1445 main.c:1658)
[  157.122147][    T1]  ? rest_init (main.c:717)
[  157.122147][    T1]  ? kernel_init (main.c:1548)
[  157.122147][    T1]  ? ret_from_fork (x86/kernel/process.c:158)
[  157.122147][    T1]  ? rest_init (main.c:717)
[  157.122147][    T1]  ? ret_from_fork_asm (x86/entry/entry_32.S:736)
[  157.122147][    T1]  ? entry_INT80_32 (x86/entry/entry_32.S:940)
[  158.731005][    C0] clocksource: Marking clocksource tsc unstable due to frequency skew
[  158.804793][    C0] clocksource: Watchdog               kvm-clock interval:            63117ns
[  158.871025][    C0] clocksource: Clocksource                  tsc interval:            62703ns
[  158.935843][    C0] tsc: Marking TSC unstable due to clocksource watchdog

The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260910/202609101106.771b567e-lkp@intel.com

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


