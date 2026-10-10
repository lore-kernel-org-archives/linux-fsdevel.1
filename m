Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0813CFF72;
	Sat, 10 Oct 2026 14:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791642947; cv=none; b=EwOBrtJvUSQDZnd4kCn/y6GfqtV46EdkSX/Lag+KaoD1o1V/JRLZ89NQpf2HVJj8nvRuOMYt8TwmtUWdjmyhpquXAPZDcEFZse+/rjbDDNsAGFy4kUyCos8kHeOyRv2VpNmlj/4qMFML6CcEtVfKuHNz9zeMr8k9J5nO+ObdDnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791642947; c=relaxed/simple;
	bh=gE5RR2wMGIGmi8SS4+44cF4apqbYrvG68xamRPAgVQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrvQcn1LjLzbR6MDO6yKUk39+YAcoxfj9OjpQcV+q9L/TU1IiJLAQwvcZnng3eYJcsSSewOFwmkzSAsACh9R7FEoO3EoXQGlQSjVjuYTj1vwAEh///umx6uyMezv6lvo11LzLjpoNl3GDe4zvPufTpHoYYK3+wzc6kHSIa9aeUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pm4Ky1k1; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pm4Ky1k1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791642945; x=1823178945;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gE5RR2wMGIGmi8SS4+44cF4apqbYrvG68xamRPAgVQk=;
  b=Pm4Ky1k14XeVcgIOKeuYo8zVTxP2RTtnoQYDal9twL+LFwufvr2becEc
   iDtWETMgErZGWxi896sPgd58HgQCk9ftwBl2CFIsT6og/bpK3AV6uf4zb
   TUdSI4uYm3sUALiMiFTdWiCpdIer/C5zxT3sc5VMwzopFTYpieq6pVf1R
   nrIC05g9OoKXUvKRLHG48dIPieJWFVyhz5PoC4TrxpdqW3UJhncEdKpnV
   IPynKdHGzMBevD+//MkXOAgTV6CgjKQWt13a+Ieb5idd34k9U4JcVEBCQ
   +bK/8Ox0SPPbofpgrw9+2EoGO+e3G5WXqQttUxsbazWzlp2KgJQq4QpKo
   A==;
X-CSE-ConnectionGUID: 2z14Ur6RQp+CxYODbVBRYg==
X-CSE-MsgGUID: +1KAuHdzTK2sC3VZrp3A7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11931"; a="308309"
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="308309"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2026 07:35:45 -0700
X-CSE-ConnectionGUID: 9oWULqtiToqoSW2u/wNZtA==
X-CSE-MsgGUID: jTVsbqIlSlWo6SAztmvjzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="2364771"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa011.fm.intel.com with ESMTP; 10 Oct 2026 07:35:43 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xFYAm-000000009qy-1RQR;
	Sat, 10 Oct 2026 14:35:40 +0000
Date: Sat, 10 Oct 2026 22:35:19 +0800
From: kernel test robot <lkp@intel.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>, glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: Re: [PATCH v2 3/3] hfsplus: add KUnit tests for date/time conversion
Message-ID: <202610102251.YL8azbf1-lkp@intel.com>
References: <20261009213132.997851-4-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009213132.997851-4-slava@dubeyko.com>

Hi Viacheslav,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v7.3-rc6 next-20261009]
[cannot apply to brauner-vfs/vfs.all]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Viacheslav-Dubeyko/hfsplus-fix-timestamp-wrapped-issue/20261009-143130
base:   linus/master
patch link:    https://lore.kernel.org/r/20261009213132.997851-4-slava%40dubeyko.com
patch subject: [PATCH v2 3/3] hfsplus: add KUnit tests for date/time conversion
config: x86_64-randconfig-1017-20261010 (https://download.01.org/0day-ci/archive/20261010/202610102251.YL8azbf1-lkp@intel.com/config)
compiler: clang version 22.1.3 (https://github.com/llvm/llvm-project e9846648fd6183ee6d8cbdb4502213fcf902a211)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261010/202610102251.YL8azbf1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610102251.YL8azbf1-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error: the following would cause module name conflict:
     kernel/time/time_test.ko
     fs/hfsplus/time_test.ko

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
