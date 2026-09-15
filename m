Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1834A40F753
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 04:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789445439; cv=none; b=qPBv+7/Ev6aEvmhotLrz8+Q1Rcupq9D5XZ/j5NlS1uDNWM7DrD9ny9qQHxwBRdthlTE13Hag9y/6u5ngBasB3ttKJcnru6dSWkwp46+l6HaR9BFhFgrrXmNajRBv3dHDLB6ysshlnzPFj+zny3Oa0PxUuIpqHgtMkMaiSO0hdn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789445439; c=relaxed/simple;
	bh=IoHq6pA68jPK8A5EVELqzPYEiIuRvZaBxIbDPa5atM4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nKsFJCJHTQeQZ5rJfKVf2mf+EpbCLW3G1NTvJRharFjHujmNHt+QJFVRAuA7rhw8b2Eei7y+vHhl5VgYPXMY4nGewUbZ1w7OZwx/wCEeJ2O7zSAeRcMuDpw/LM/0vGZCeumGlyO20IXSycPlbYM5uOeT3bUKHLgcaI16nBcbKUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Khi+LOeu; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Khi+LOeu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789445437; x=1820981437;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=IoHq6pA68jPK8A5EVELqzPYEiIuRvZaBxIbDPa5atM4=;
  b=Khi+LOeud2ee9O/SJXUqgh2eNrWBcsDto12Uh7tzmI2SNy2CHBaBlDme
   o2X+XgirP+DphtHQTk0Vsb3qHk9ihuD+JeadjXAGNAIos/BTeXjcs5hqM
   TLuNY38aU1zBNZFuwpZWJR/CRZj9zkAhF4vtaEUUcskutkYSvIKOiXbCd
   GlkIMJfzHKmKuPJMu+qleR+pXga1B1Y43XwSeP18F5ADYTVHAnRHY3DWW
   5ZFkRWvRH4Vft3h6hEdhDf0EmRqagcAmTEhb2Smy3LBx7OZ1kzjMtS3pq
   t99X85+EWTuWAek8yHzbu/zwRTQvdpcZuTu3nhFyjfBEEXvrpxWPti6kF
   g==;
X-CSE-ConnectionGUID: JpL2J49yT1S8oV3mnpEbWQ==
X-CSE-MsgGUID: 4ajo9A+FS6+MNPxrVL2NJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="88938110"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="88938110"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 21:10:36 -0700
X-CSE-ConnectionGUID: gPi3sKHdTsybD2UWKaT+TA==
X-CSE-MsgGUID: /+DnVYeZSiKNcvXfa4U5yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="269551985"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 21:10:34 -0700
Date: Tue, 15 Sep 2026 12:10:31 +0800
From: kernel test robot <yi1.lai@intel.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, yi1.lai@intel.com
Subject: [linux-next:master] [fs]  0d1ea15329:  will-it-scale.per_process_ops
 84.8% improvement
Message-ID: <202609151145.9d373682-lkp@intel.com>
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

kernel test robot noticed a 84.8% improvement of will-it-scale.per_process_ops on:


commit: 0d1ea1532955fa881424cb01c4599d14b90a22f6 ("fs: avoid spurious dentry ref/unref cycle on open") https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

testcase: will-it-scale
config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 256 threads 2 sockets Intel(R) Xeon(R) 6768P  CPU @ 2.4GHz (Granite Rapids) with 64G memory
parameters:

	nr_task: 100%
	mode: process
	test: open3
	cpufreq_governor: performance


Details are as below:
-------------------------------------------------------------------------------------------------->

The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260915/202609151145.9d373682-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-14/performance/x86_64-rhel-9.4/process/100%/debian-13-x86_64-20250902.cgz/lkp-gnr-2sp4/open3/will-it-scale

commit: 
  8ca3582209 ("Merge patch series "vfs: add O_CREAT|O_DIRECTORY to open*(2)"")
  0d1ea15329 ("fs: avoid spurious dentry ref/unref cycle on open")

8ca35822098a612e 0d1ea1532955fa881424cb01c45
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    517664 ±  2%     +84.8%     956515 ±  5%  will-it-scale.256.processes
      2021 ±  2%     +84.8%       3736 ±  5%  will-it-scale.per_process_ops
    517664 ±  2%     +84.8%     956515 ±  5%  will-it-scale.workload


Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


