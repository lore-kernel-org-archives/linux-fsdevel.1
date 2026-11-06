Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793926905;
	b=Esm1WVJuckclekSZqhChnvyJFg2YpAGvlEBBpnltwlfSwZKmKIKjeUWbQoJNFgUAhKH1
	 GS3Nkq5qx1oaHqMDxFMlqmRfFJnrE7/XUc7BcT9KIZPn3vkSvJISSG0w47ksUoqud9Fz5
	 nW54cPgjghAH5biuTyMuNArWo0cnwlX4ZnCmru13wTf1R6cxtR1FR6j2AzyrCBrV1pwkK
	 fRThikgdCY3u7GV3rcW56Z633ZwJ0498oJPF3SsbkCM3Ujr10ZsVtluKuDkHhGB5ru3Hm
	 RamqjeGTLM3BYGairwltfcBA0w2V1j9CzJfyPcAxFK+OAV6UFU5l8skC/4meo/VafOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793926905;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding;
	bh=VGB1N91OrRVxM418j3U4Eg1a7qSw+E2WCwXs9zxL8Xg=;
	b=2qIOzF3ox6OM0q2ulLmeo9wTC/m3m8lAE/PxhAdlaYT/L+lu5A9TznAXNcttPpuvCjRh
	 EELuYaz+5exwiRg4l8Qe1RACMl2EiDJnVIl1YYP2JipCg7bn/jcoIty8f4g1mnGZOrS1b
	 w2HWZSlUyrLSuM997pKpKSo/DIOYmlL73iLcu8auYkqk/jQWK2fHxpgBDk+K94dDcrLPB
	 fuOzms6ha1Y7T7nhw1PjvK8eJ1VS6wOIhgjq5jwxpuBmjgf60WXKx4JNUc+CVoPia5kRK
	 r2wmcpnqSYNJYISMDqsepwAiF83e+G4Cz2Sm9RvM59ZzcuM5Kqx5+fEcKpMXcIGawXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="l/QDtNTd";
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89735606A31B;
	Fri,  6 Nov 2026 01:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89735606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=l/QDtNTd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793926904; x=1825462904;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=sK93C0hjcPIDsCisxELiH3uFUygQiikRATGgdib/NGc=;
  b=l/QDtNTdW1885m4knFDuoSSWEO7rWtcigIiiIvjQcLLzeuPGtos+nd6G
   FRj7g+3W5vPzJwCJY7WXr9Pua/YV4L7Z7YO2GA26TCwB294OcaXQnSPIy
   7nGZDG/vSre3E/OLbUGRwaeK0V3lHZ/wkTncMd4+W7iET2yx9g8wW0LiF
   qONZhp6/qI+fiWPrQLfsJb+23bfG1mDBp2OzF2AOQnJuXxbK4hJh5+lEj
   K2NXCE3gKH3zVfudkGhm/2ScApHBnJ7gzCw7fZ2fGtyl7fHJnhMYp3i0j
   xpQ6mFsUv4ufCAR3xSga3VtvN2VoAPxdzVs3KQYeZrucweZl+Hg+wmrZh
   Q==;
X-CSE-ConnectionGUID: oXOwnycrRKiXpiVD6ioDCw==
X-CSE-MsgGUID: ++z/zoSsSDWRt5X0Mqmj1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2752790"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2752790"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 17:01:43 -0800
X-CSE-ConnectionGUID: ppxUl7HUSne6cIdLerpzTw==
X-CSE-MsgGUID: 1NC1sPh/QYuI2UkyAugkfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7055412"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 17:01:41 -0800
Date: Fri, 6 Nov 2026 09:01:38 +0800
From: kernel test robot <yi1.lai@intel.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, yi1.lai@intel.com
Subject: [linus:master] [fs]  161ce1e692:  will-it-scale.per_process_ops
 113.3% improvement
Message-ID: <202611060127.79124a4f-lkp@intel.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit



Hello,

kernel test robot noticed a 113.3% improvement of will-it-scale.per_process_ops on:

commit: 161ce1e692d01ddec0522f24a29535ac59a3afaf ("fs: avoid spurious dentry ref/unref cycle on open") https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: will-it-scale
config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 192 threads 2 sockets Intel(R) Xeon(R) 6740E  CPU @ 2.4GHz (Sierra Forest) with 256G memory
parameters:

	nr_task: 100%
	mode: process
	test: open3
	cpufreq_governor: performance

Details are as below:
-------------------------------------------------------------------------------------------------->

The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20261106/202611060127.79124a4f-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-14/performance/x86_64-rhel-9.4/process/100%/debian-13-x86_64-20250902.cgz/lkp-srf-2sp2/open3/will-it-scale

commit: 
  v7.3-rc1
  161ce1e692 ("fs: avoid spurious dentry ref/unref cycle on open")

        v7.3-rc1 161ce1e692d01ddec0522f24a29
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    582504 ±  4%    +113.3%    1242579 ± 18%  will-it-scale.192.processes
      3033 ±  4%    +113.3%       6471 ± 18%  will-it-scale.per_process_ops
    582504 ±  4%    +113.3%    1242579 ± 18%  will-it-scale.workload
      0.14 ±  3%      +0.0        0.18 ±  9%  mpstat.cpu.all.usr%


Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


