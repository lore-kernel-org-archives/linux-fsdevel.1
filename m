Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793839133;
	b=tfb1z16SR2keUd71EjteKe+mQ70hzm3MAJ18ASoN1QB1NZnC2W/EqpIqFHXwM2WLnhXe
	 u0ThN2AcWusYzTLn9hfz3eUX/A/+16PGBTPJF9OzerqwnRYvvDuQhe/qq4pmvQDvolzEc
	 HF3LRJ16VLV93tdC/b/+u68Gs8QYEv2soBOHBUZWxGGMy657IaU9xUX3mm5aBBCtMizLQ
	 1DVSsxSuJHsmbE8wQfS1OLgFG1eDA8oDTTqYKq4lOi7oMhO72uvaBI01pvoSueCtGqmgM
	 m+qgnSisNp8FXd1tUdQEd5i0k8rLL8wOC4JESkYnG6i9v8zdkm79pL463li5UHlAS+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793839133;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding;
	bh=3j8nosRT0hMFrdPaU0fdOT3QafLKdAoumLCtN8aeB7c=;
	b=rc5wJhrf3C0Y0Pp3v/3D9B18oK3bO/3vIKLZn5tfeEzSYzcFxAblSUYo/8IlvKBvuqMh
	 BxE9mOXRoyV5K2LQd9GeYQ5XvGxLPY/XBWYxlxX6txuVamqwerAgLdv9p5XxSqLFLm2Lg
	 5WFxInowysxSEGAUMqJ9JykBTIEmYCP5AZY2SKCTBMoNSmUbE0y5VJwxH6Ktgg8uQswr3
	 04Xq/uizZyNZ2kxF1ns6PrEHquLlv5D2DnCv7DDoljxGO9ZXOelWz+cFRN6Ohea12RTDm
	 LwKafcpNB0UguhyRgN5Vthkwl6N6YmckNGfYsGpxvsGoYPdPwbUZtYFaZnRUYjv6BqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=h6i4uEwF;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE15606A326;
	Thu,  5 Nov 2026 00:38:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AE15606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=h6i4uEwF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793839131; x=1825375131;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=5+t87+N/s71iHTzWzcKOMalV2nyZX0pYiXF/rYzODWc=;
  b=h6i4uEwFrfeEv+kx230LwJIbRGbUXf2FXk6G8Iswv+zpLtubgbW0EEiN
   427KQH5pi4KZjJna1Nrd2lKvzE5z6cRlIQfXyFP8ip+E/bl3y96vWFyRv
   3kfj/FaoLOjmpNdoMDUInMRnsdH1aPL2vrMnlP6z3sHOSs5QANdqEpX19
   Hw+MyGugM16yqJaja/ArqQiJUHgde0Pu+C6X3bLWcKwXmAvUm7Q5nk8Bd
   +EWKV+z7WTCiwxEfTFBrp7HDMuq9Q6HARTaLrqKryhHxatQv9tSltZwBk
   lEW07AGBgqf4rpaChh2dY1nawdpM68LaJshc3u0bICKBDBuZj27kgJHMW
   Q==;
X-CSE-ConnectionGUID: Ff+7UFPaQIWm7dPcryLQpQ==
X-CSE-MsgGUID: 1sXCG6OZTHe028hIUeJ95Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2630956"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2630956"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 16:38:50 -0800
X-CSE-ConnectionGUID: uRcZfDPTQACPdZzQ63gB0g==
X-CSE-MsgGUID: iLMWVtDLQ3ulnBNpVVj06w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="6866644"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 16:38:48 -0800
Date: Thu, 5 Nov 2026 08:38:45 +0800
From: kernel test robot <yi1.lai@intel.com>
To: Breno Leitao <leitao@debian.org>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	linux-fsdevel@vger.kernel.org, yi1.lai@intel.com
Subject: [linus:master] [fs/pipe]  f7f4665dc5: lmbench3.PIPE.bandwidth.MB/sec
 18.5% regression
Message-ID: <202611041404.befe64cd-lkp@intel.com>
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

kernel test robot noticed a 18.5% regression of lmbench3.PIPE.bandwidth.MB/sec on:


commit: f7f4665dc520fd8bbc1db20e59945773e03744a0 ("fs/pipe: unify the page pools into a single per-pipe pool") https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: lmbench3
config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 224 threads 2 sockets Intel(R) Xeon(R) (Sapphire Rapids) with 128G memory
parameters:

	test_memory_size: 50%
	nr_threads: 20%
	mode: development
	test: PIPE
	cpufreq_governor: performance

If you fix the issue in a separate patch/commit (i.e. not just a new version of the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yi1.lai@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202611041404.befe64cd-lkp@intel.com

Details are as below:
-------------------------------------------------------------------------------------------------->

The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20261104/202611041404.befe64cd-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_threads/rootfs/tbox_group/test/test_memory_size/testcase:
  gcc-14/performance/x86_64-rhel-9.4/development/20%/debian-13-x86_64-20250902.cgz/lkp-spr-2sp2/PIPE/50%/lmbench3

commit: 
  c610d2d078 ("fs: annotate inode timestamp accessors")
  f7f4665dc5 ("fs/pipe: unify the page pools into a single per-pipe pool")

c610d2d0787961cd f7f4665dc520fd8bbc1db20e599
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     29142 ±  2%     -18.5%      23737        lmbench3.PIPE.bandwidth.MB/sec
    191.80 ±  8%     +54.1%     295.65 ±  5%  lmbench3.time.elapsed_time
    191.80 ±  8%     +54.1%     295.65 ±  5%  lmbench3.time.elapsed_time.max
     23261 ± 16%     +19.3%      27743 ±  5%  lmbench3.time.involuntary_context_switches
      9853 ± 16%     +27.9%      12605 ±  5%  lmbench3.time.system_time
     51.80 ±  2%     +11.6%      57.80 ±  3%  lmbench3.time.user_time
 2.928e+08 ±  3%     +26.6%  3.706e+08 ±  4%  lmbench3.time.voluntary_context_switches


Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


