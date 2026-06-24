Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335EB3859EC;
	Wed, 24 Jun 2026 06:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782281020; cv=none; b=f3iRw8W4lfaozpMDtUVENyqHMrU0Kz5RHXD6DaI/yG9XxhS8fUxDyKxMqbTA9UOQqz1C7rYD7zvCovRcKqtZoyQVJO3r05A2k5Z/Qk1QfwcsuuWEEmibe9kdfT9YXmxdfXNzSThnepfwbkmjMCBYSDl+tnKwYsn3A48hDsQrq4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782281020; c=relaxed/simple;
	bh=XD4C8lHqg5llupTHKudEm95H+7Usu80wkZ1XG4I9BnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFAzkQxCKBrm9OYUAVWmHu6NKkyNxOz1xUc2TaPE7cIyhuW5C+WF9tU8/nNJGWZzSSkUoIb2ZA9AtDlmr5lIbzeRSE09o1E3tSW9GaonvcK47IN+HcF0Z7/Q/mFqUUlw7TqUB9KqkNpNuHc0UqqpAm8zOkrAaeRIKtgJEjV39Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XilP8laH; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XilP8laH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782281018; x=1813817018;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XD4C8lHqg5llupTHKudEm95H+7Usu80wkZ1XG4I9BnY=;
  b=XilP8laHWitJB1aDu0cGdMGzzKY3CupX857rmTYgigpUgd9HI1Zw79gn
   detfDzs7fYq3qsUgsHlr/pN9VjqsPVlrPaSLUOHE8IIzXsYrAv0PZBmvX
   vvP+nol63zH5IB/Rr/PnlNAgP9HL+3uS1utxLI3z/IXzow9agnlHc9kni
   FioKxQ6Vl7QxRa+OzVMYMZxkZBcu1+NOrDi1QXeafX1H9Cvx7xnU0ED+I
   HD0Ib9I4rxrABG4vt9Qx2LFzvdNA3WSUhe2gPw1nH8PME9pQG5zjHyQfg
   7nFE6wERF4JYNzadHIq7b1eSdBLSMqy7oZGN5AA3OVcCRgT+kTP6fN/ei
   Q==;
X-CSE-ConnectionGUID: SpHSIK3ORYaYyLifs49zxg==
X-CSE-MsgGUID: zwyUtWx/SKCQfFNgrgpnAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="82017125"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="82017125"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 23:03:37 -0700
X-CSE-ConnectionGUID: J5sgBFZEQLCBsZeQtPQFiQ==
X-CSE-MsgGUID: qHHWgNz9TaK2NviZlSvuvg==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 23 Jun 2026 23:03:34 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wcGhr-0000000039h-1VoI;
	Wed, 24 Jun 2026 06:03:28 +0000
Date: Wed, 24 Jun 2026 14:02:39 +0800
From: kernel test robot <lkp@intel.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	David Timber <dxdt@dev.snart.me>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	jack@suse.cz, chrubis@suse.cz,
	Andrea Cervesato <andrea.cervesato@suse.com>
Subject: Re: [PATCH] exfat: implement swap activate
Message-ID: <202606241341.hkQXa0PG-lkp@intel.com>
References: <20260618-exfat_swap_activate-v1-1-4c6a465df295@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618-exfat_swap_activate-v1-1-4c6a465df295@suse.com>

Hi Andrea,

kernel test robot noticed the following build errors:

[auto build test ERROR on e771677c937da5808f7b6c1f0e4a97ec1a84f8a8]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrea-Cervesato/exfat-implement-swap-activate/20260622-172327
base:   e771677c937da5808f7b6c1f0e4a97ec1a84f8a8
patch link:    https://lore.kernel.org/r/20260618-exfat_swap_activate-v1-1-4c6a465df295%40suse.com
patch subject: [PATCH] exfat: implement swap activate
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20260624/202606241341.hkQXa0PG-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project a9b492db3d50683e446cd1a5c9ffaf4e92cb77a7)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260624/202606241341.hkQXa0PG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606241341.hkQXa0PG-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "generic_swapfile_activate" [fs/exfat/exfat.ko] undefined!

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
