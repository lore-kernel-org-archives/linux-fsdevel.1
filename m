Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891104;
	b=HBtPVV9jHE6Zjt2TVix6atXCHxIUonHEQBZjMs/8MxIys/Fc/JSltE2vrOPcPz7JwoaR
	 ci1UgPKLze9Xo5jhzvc9jIcPxfkyNVaxLFyUhUymWWslrUwfz3FAMpZFTR82+3IIb3Jt8
	 vC2iUO9zDQkzx4NwBIuLbKTNdFE/6NUxo768ComsUHjr6RORBpeisePSRCDEAL1SoN5wo
	 Ynu/MCf/qOdHqwGxyQX8tPNscXsqBFu8P3Kc1kldU88/Oku0JCYPuRoEqFaIRP0LXiNyE
	 +kEfk7AfGOeuQSYFtPscN9M5cEwZGJB2KR+F3zgyXzmtEqdl7R2gxL8XTyDCAHKSM+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891104;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=IDZiEDQ2fJcCZR1mPomOrN1HJzC+gocV2xQLf/Xmqno=;
	b=ZINlSprPFoPW+BlDy2gFoGryyK4tbnD/wIiX0Vn3q/R2pUJzM8/bpl1AQiNzaDeltiFT
	 k0nAo6OP5EM42uWZyUrUPR2WsKfuBgb41WJROA/2nFkAy7bFp5myirJ7pmgNasTOdZkj0
	 SQl3vxyNejgwG/4Q1CYbjOvf7oW7lSLkcNeU5v75c2/xvXBmFG35QBHEygew0C3t02ZLr
	 cjMh/cPmWQgL4+DpJPweZTd7h8onnPQ81GICQSytR5ckJ+PBa4jecZwCQQ1bJQbumMV/y
	 qIM/zqoNkElm5wyI50mJyUEPDapE30oxzTDBOHQQowNLmoEE1HYtrOUg3KxLj4NNAdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HrOw8A1j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A96606A31B;
	Thu,  5 Nov 2026 15:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HrOw8A1j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA91E1F000C1;
	Thu,  5 Nov 2026 15:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793891103;
	bh=IDZiEDQ2fJcCZR1mPomOrN1HJzC+gocV2xQLf/Xmqno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HrOw8A1jlUuhJDo1BiAbNQGXgo0JMDDcCaPKHctvyeHpkOGNMXXK9/65YyKmpklzH
	 rlN5wpQjCoPa3I+ssp3r4upL0cZMHwUddWnS+er5KF4ShJtKSv9Kxe6YZf3mMwZZk3
	 SAvN2djBmxXJM/XX59Q/5PMOX4NA/rclcaRZTHsB94oMDA9H2FUvtVycQHZv4ravfX
	 pTPN7wyffQwgwU7ShR+nKJNKSvSQSozsE59O/DR2/496o73Wv2MkC9P0Nz5b06UeBZ
	 hkcjkn1ly8s5Yerske8dk0Ck2Sdd7endvSjESEOiAwolQU3ipl9m0CjobIs3Cyi+9U
	 SfdfwyVMM80WA==
Date: Thu, 5 Nov 2026 16:04:58 +0100
From: Christian Brauner <brauner@kernel.org>
To: kernel test robot <yi1.lai@intel.com>, 
	Breno Leitao <leitao@debian.org>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	Mateusz Guzik <mjguzik@gmail.com>, Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [linus:master] [fs/pipe]  f7f4665dc5:
 lmbench3.PIPE.bandwidth.MB/sec 18.5% regression
Message-ID: <20261105-trommeln-einspannen-radius-ccb4e174e407@brauner>
References: <202611041404.befe64cd-lkp@intel.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202611041404.befe64cd-lkp@intel.com>

On Thu, Nov 05, 2026 at 08:38:45AM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed a 18.5% regression of lmbench3.PIPE.bandwidth.MB/sec on:
> 
> 
> commit: f7f4665dc520fd8bbc1db20e59945773e03744a0 ("fs/pipe: unify the page pools into a single per-pipe pool") https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

@Breno can you reproduce this?
It's something we should at least investigate.

> 
> testcase: lmbench3
> config: x86_64-rhel-9.4
> compiler: gcc-14
> test machine: 224 threads 2 sockets Intel(R) Xeon(R) (Sapphire Rapids) with 128G memory
> parameters:
> 
> 	test_memory_size: 50%
> 	nr_threads: 20%
> 	mode: development
> 	test: PIPE
> 	cpufreq_governor: performance
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <yi1.lai@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202611041404.befe64cd-lkp@intel.com
> 
> Details are as below:
> -------------------------------------------------------------------------------------------------->
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20261104/202611041404.befe64cd-lkp@intel.com
> 
> =========================================================================================
> compiler/cpufreq_governor/kconfig/mode/nr_threads/rootfs/tbox_group/test/test_memory_size/testcase:
>   gcc-14/performance/x86_64-rhel-9.4/development/20%/debian-13-x86_64-20250902.cgz/lkp-spr-2sp2/PIPE/50%/lmbench3
> 
> commit: 
>   c610d2d078 ("fs: annotate inode timestamp accessors")
>   f7f4665dc5 ("fs/pipe: unify the page pools into a single per-pipe pool")
> 
> c610d2d0787961cd f7f4665dc520fd8bbc1db20e599
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>      29142 ±  2%     -18.5%      23737        lmbench3.PIPE.bandwidth.MB/sec
>     191.80 ±  8%     +54.1%     295.65 ±  5%  lmbench3.time.elapsed_time
>     191.80 ±  8%     +54.1%     295.65 ±  5%  lmbench3.time.elapsed_time.max
>      23261 ± 16%     +19.3%      27743 ±  5%  lmbench3.time.involuntary_context_switches
>       9853 ± 16%     +27.9%      12605 ±  5%  lmbench3.time.system_time
>      51.80 ±  2%     +11.6%      57.80 ±  3%  lmbench3.time.user_time
>  2.928e+08 ±  3%     +26.6%  3.706e+08 ±  4%  lmbench3.time.voluntary_context_switches
> 
> 
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are provided
> for informational purposes only. Any difference in system hardware or software
> design or configuration may affect actual performance.
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 
> 
> 

-- 
