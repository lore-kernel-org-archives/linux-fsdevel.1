Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794190880;
	b=1TqS7jNaI1Y2GVans6wuPyX3jPw3JyaWX6PEBdSQyZuet9hrdtqck4IL0VNFCvGg+pwl
	 YbJltIEScY3+bp5gnyGwkngzK5GrWMOtbiSyWmKgU1sztVVE9394fnG1zw4IlJWcagUVN
	 xGI1m+KfpC6bOaQSh1aIzsRPG68TolozYVernC3UvcvBkMnkM6Aa6BZpbABt1yUkA+Lfa
	 qCbfvvUbku6ty6V6N5QskA4s8H/pRngx8V2eJZ3E0jOUsHpG6VShG/yq1nYVjQU7YTMkS
	 nO6Tj6xi9h3LQ7Rg8zavCRvbuWJ0AMLqlrP4QSUrxWNR9YM7VAB9Gh4yHYWaY/9zmDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794190880;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding;
	bh=iW6QAKlV1qS/MBCzlPsZytfdoSp0El0cT2pW9sdd+j4=;
	b=mlMUS8LRSVcKYLQ52oEHqkS/mjqr+QI4RIGsHGVPn0d1bGz9rJPW1YVxyZNpqrmdnE4K
	 JjPEsJwy5zCpI04JA0JjmSigYBDqKCqz6qRAq9UkgYaz6g4sgraq0OWKr9CJibj4knk/l
	 ene9m2rvE0ESeP+9maj4b8JP6SkzysGDLScIJR0mZ9zr31HZndtkO88qhB8slIn77RG+h
	 FDC5nsY5stDkUCm+Sk7PceTt6Hu/vktyJh1K9yQ0+Ev/YvFZzWGSro+jClMFMhMopAe8b
	 6P8tiHn4pofiM/lMe3pPnqt7IHIIFKv6Q8t6vl4N/fePeJimEulne+0SIrLDpefgNqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Z3UW8pLu;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3304D606A31C;
	Mon,  9 Nov 2026 02:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3304D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Z3UW8pLu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794190878; x=1825726878;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=bQEKnHu4KJAZQ/rnX5e1Y9/G3MfiVexKeVIiCOrbpYo=;
  b=Z3UW8pLuKfHfi+BrezWk7EeGx2XmwKsjdEJEKbcYWFE60l5eLlrJtKgK
   Cd7nbU88tDyMy7m7LnxtQWPnLch49YTHIXPvy0qjiIOTZYuXuXBGgL0fM
   0g6HOZ7uGVDlfjXp1rvLbwyVrLsVWTDJN13RNqryQKsVGOn3hcDKmdQI2
   j/RjB0QgYn+nfwMTtLdI0R3mUhZ//U4G42q/XYHAiXNqdmZjIfm908rqv
   m2VUdISb4RaEQmj5RB7ByCme7wWunSLklLZaEJ+xGQvPGjW87kqqahRvF
   JTh8QidCsJTRA5/zsoQN2qFTQztEvKLvohvI16TywSzg9w9Ux3mALU1U+
   Q==;
X-CSE-ConnectionGUID: AoOoo/ZGSPGkjC/FNQGoKQ==
X-CSE-MsgGUID: pTLOngABRzqyijXD7jG8KA==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2948635"
X-IronPort-AV: E=Sophos;i="6.27,202,1787036400"; 
   d="scan'208";a="2948635"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2026 18:21:17 -0800
X-CSE-ConnectionGUID: IEp3A2LFTByh4OeuiOyHuw==
X-CSE-MsgGUID: +p8k5xMFT+i8ZOH0nyNRqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,202,1787036400"; 
   d="scan'208";a="7883333"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2026 18:21:16 -0800
Date: Mon, 9 Nov 2026 10:21:12 +0800
From: kernel test robot <yi1.lai@intel.com>
To: Christian Brauner <brauner@kernel.org>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	kernel test robot <yi1.lai@intel.com>,
	linux-fsdevel@vger.kernel.org
Subject: [linus:master] [libfs]  02a336a831:  stress-ng.clock.ops_per_sec
 147.7% improvement
Message-ID: <202611090811.f9303f5a-lkp@intel.com>
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

kernel test robot noticed a 147.7% improvement of stress-ng.clock.ops_per_sec on:


commit: 02a336a831f02a18047bacbd49018a237af8a172 ("libfs: hold one mount reference for all pins") https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 256 threads 4 sockets INTEL(R) XEON(R) PLATINUM 8592+ (Emerald Rapids) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: clock
	cpufreq_governor: performance


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20261109/202611090811.f9303f5a-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-14/performance/x86_64-rhel-9.4/100%/debian-13-x86_64-20250902.cgz/lkp-emr-2sp1/clock/stress-ng/60s

commit: 
  eeecea75ec ("proc: don't let an entry below /proc/<pid>/net be a mountpoint")
  02a336a831 ("libfs: hold one mount reference for all pins")

eeecea75ece2ba89 02a336a831f02a18047bacbd490
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   4669272          +147.6%   11562917        stress-ng.clock.ops
     77848          +147.7%     192799        stress-ng.clock.ops_per_sec
    126459           +80.5%     228294 ± 13%  stress-ng.time.involuntary_context_switches
     32287 ±  2%      -7.1%      30008 ±  3%  stress-ng.time.minor_page_faults
     23175            +4.0%      24092        stress-ng.time.percent_of_cpu_this_job_got
     13907            +3.7%      14423        stress-ng.time.system_time
     16.08          +213.4%      50.38        stress-ng.time.user_time
   2056711 ±  4%     +36.4%    2804386 ±  8%  stress-ng.time.voluntary_context_switches
      9325            -6.2%       8744        uptime.idle


Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


