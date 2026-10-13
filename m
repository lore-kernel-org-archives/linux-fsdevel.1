Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CA83A6F11;
	Tue, 13 Oct 2026 07:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791877580; cv=none; b=Phj+Ewfh3IbqLPfCPdeSSmoPiJdhTGHyvjpDsj/jCRwXfcDcI+6W7oRBCMlRQIIn8qvjkRtB43ou3XiR0DLhhwTBzzhJjZgLQ+q/C2QH1fXREf6KPUs5OI+C7SGi6NzXApTsCGLloP1nGxdgzV/2YYVighEmxF6UXXpev8DKtTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791877580; c=relaxed/simple;
	bh=+NtnVCGmmGB8pe2zOOxww06KK+9XuftJ2meDrflIhRc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=E1g01vPZCSBGFXT86BJrl92Sifd23dqIxB+L4uK69DBlQ4nEOT6BUAD1fSDDDRCNWCOjT+5nShz1+SECCx96Vk4+jIBikKU+Xmk2QHdVK3faF8iU+W1kpEKJbsMORRU+wAzTtASK0hpirDhgNpcoh96KZ4thgpuaZJ6vEVmBB/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l4g7hJlP; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l4g7hJlP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791877578; x=1823413578;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=+NtnVCGmmGB8pe2zOOxww06KK+9XuftJ2meDrflIhRc=;
  b=l4g7hJlPaTyAuvT1x1+XYGqgZ4nsWUG39kdgCrlzK7n8q07dOt1tnzJY
   JctQFXy8UJjJZwdh8RNEGZj2h4A3821/5rXY6QfaPwbrjEQ2eTI4D9HD9
   Z7veoGkIMQBmTHe//eZN9PmAWueHcMVdoJgr3L+WrgF0S5Pa5sWeIllkm
   RV/c4RxjeppnX5aSh41Yf/tR/w9DJkVrl3jfa13Xs3ASNzk42NUjzG6tE
   OtyVybk4lm3zJ4nGGIFv3lAY8JSzPIgQxkz9qZOl9Va7d4vHlZ7cjD8yl
   16M1IyzMO86UTo06e5zP3OYH6+Nn+wrQ1kOA14nHGVGNEBoMEPBiszvY5
   g==;
X-CSE-ConnectionGUID: eHpB6YVSRcq2z90GNXkG8Q==
X-CSE-MsgGUID: eEEzLxXzTCyVG5ngex/CTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="601180"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="601180"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 00:46:18 -0700
X-CSE-ConnectionGUID: WC7WrMN+QhyXEkoCmCO6Iw==
X-CSE-MsgGUID: AV7yDSPxSJ+/xKM/JgsuTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1462091"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 00:46:17 -0700
Date: Tue, 13 Oct 2026 15:46:13 +0800
From: kernel test robot <yi1.lai@intel.com>
To: Christian Brauner <brauner@kernel.org>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, yi1.lai@intel.com
Subject: [linus:master] [fs]  7eb84d54fa:  stress-ng.kvm.ops_per_sec 28.2%
 regression
Message-ID: <202610130959.d3ca4cfa-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit



Hello,

kernel test robot noticed a 28.2% regression of stress-ng.kvm.ops_per_sec on:


commit: 7eb84d54fac5002bd975d1de8fd61d57e89172ab ("fs: don't let a migrating task hide its reference from do_umount()") https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 192 threads 2 sockets Intel(R) Xeon(R) 6740E  CPU @ 2.4GHz (Sierra Forest) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: kvm
	cpufreq_governor: performance


If you fix the issue in a separate patch/commit (i.e. not just a new version of the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yi1.lai@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202610130959.d3ca4cfa-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20261013/202610130959.d3ca4cfa-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-14/performance/x86_64-rhel-9.4/100%/debian-13-x86_64-20250902.cgz/lkp-srf-2sp2/kvm/stress-ng/60s

commit: 
  bba9960c07 ("selftests/filesystems: check that a busy propagated copy blocks a synchronous umount")
  7eb84d54fa ("fs: don't let a migrating task hide its reference from do_umount()")

bba9960c073dbea8 7eb84d54fac5002bd975d1de8fd
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    134749           -28.2%      96786 ±  2%  stress-ng.kvm.ops
      2245           -28.2%       1612 ±  2%  stress-ng.kvm.ops_per_sec
    571737           -25.3%     427284 ±  3%  stress-ng.time.minor_page_faults
      7905 ±  3%     +35.2%      10690 ±  6%  stress-ng.time.percent_of_cpu_this_job_got
      4566 ±  3%     +37.9%       6297 ±  6%  stress-ng.time.system_time
    190.93           -28.1%     137.21 ±  2%  stress-ng.time.user_time
    698896           -24.8%     525918        stress-ng.time.voluntary_context_switches


Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


