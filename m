Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3033148C41A;
	Fri, 15 May 2026 15:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778858281; cv=none; b=V+Z5q+Gn7if/00CZLjlvOiZHJCsker6ObTMOC0HAMYmIGPqU56YpNxVXzZYLMYUAUvO0PIWK/T6kwcUqQJGBwtaLvc2mWsgVrSnba2w8oPyRaPmbJiUAz7a8Zc0oofFWcoF3xw6sTaevOlSozWNbdvyGqRnRO5skm0KDWdCPORY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778858281; c=relaxed/simple;
	bh=Ur+eO9+Wh3Qp0iw8CBPO7MW1A/4n2k3fABoZ47ld0hM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjN1s1YuEJQeQaoDn6+zYcYGeaZjVusJ9ugZ/L2Sfz8Nj5Ttw/rntWyZWXeq/K+nl/pe+THOGqQ980HzkkpQ3NdtbTF3K9uevj7EUba5DX0bKwz8FNj3+lcNPTzZo2WjmG9NcRcTA3oL7/mlasjCAs50IkvRHH366fvPlkWqiZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OndVjwjv; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OndVjwjv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778858277; x=1810394277;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ur+eO9+Wh3Qp0iw8CBPO7MW1A/4n2k3fABoZ47ld0hM=;
  b=OndVjwjvZ+sDW7aojVRRLVbajXKYisbbQXMiSNA+aYYRLT8o6ZfPMDjw
   mGnZ+64dG5r2YwN1gil51xHjJkRR49EFjCeoDyKjMI8Ksce80v9GDsEgb
   fAwvz9dp7lEyZ+c3XBHR+jbSLy2k3Bauw+25KtsY35trV2xCJi9LzdHbN
   VbUzFd2a4veUUQMIbgUN0IndTH+ExgxuC8F7zSnBebX9R+VY4UFNdDYiM
   uGgSUexulcuNG5iG3JX6OjYOJ4h37nT2b3ESLNuXO5clJVBtS+W0R7LUm
   co0V7ruT1kAG/AcCPKq4gOl0SX2D5C0nsDaJCYOmEcwfI6qLlgVBBY6qZ
   Q==;
X-CSE-ConnectionGUID: OE5D7TvxT6CHNaRyhQ72RQ==
X-CSE-MsgGUID: caQlXci5Qj2RoN8IiLU8TQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11787"; a="79856818"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="79856818"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 08:17:56 -0700
X-CSE-ConnectionGUID: 7b4FpsvdSDSdwQA6KE/3MQ==
X-CSE-MsgGUID: aSM7EcxmT42GYrvploautQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="276808619"
Received: from lkp-server02.sh.intel.com (HELO 7a33ad3e7d27) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 15 May 2026 08:17:53 -0700
Received: from kbuild by 7a33ad3e7d27 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wNuHf-0000000023H-2PVk;
	Fri, 15 May 2026 15:17:32 +0000
Date: Fri, 15 May 2026 23:09:56 +0800
From: kernel test robot <lkp@intel.com>
To: Horst Birthelmer <horst@birthelmer.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: [PATCH] dcache: add fs.dentry-limit sysctl with negative-first
 reaper
Message-ID: <202605152329.WHnEvZt7-lkp@intel.com>
References: <20260514-limit-dentries-cache-v1-1-431b9eb0c530@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514-limit-dentries-cache-v1-1-431b9eb0c530@ddn.com>

Hi Horst,

kernel test robot noticed the following build errors:

[auto build test ERROR on 5d6919055dec134de3c40167a490f33c74c12581]

url:    https://github.com/intel-lab-lkp/linux/commits/Horst-Birthelmer/dcache-add-fs-dentry-limit-sysctl-with-negative-first-reaper/20260515-154600
base:   5d6919055dec134de3c40167a490f33c74c12581
patch link:    https://lore.kernel.org/r/20260514-limit-dentries-cache-v1-1-431b9eb0c530%40ddn.com
patch subject: [PATCH] dcache: add fs.dentry-limit sysctl with negative-first reaper
config: s390-randconfig-002-20260515 (https://download.01.org/0day-ci/archive/20260515/202605152329.WHnEvZt7-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 5bac06718f502014fade905512f1d26d578a18f3)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260515/202605152329.WHnEvZt7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605152329.WHnEvZt7-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/dcache.c:1474:7: error: call to undeclared function 'get_nr_dentry'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1474 |         nr = get_nr_dentry();
         |              ^
   fs/dcache.c:1474:7: note: did you mean 'retain_dentry'?
   fs/dcache.c:835:20: note: 'retain_dentry' declared here
     835 | static inline bool retain_dentry(struct dentry *dentry, bool locked)
         |                    ^
   fs/dcache.c:1519:6: error: call to undeclared function 'get_nr_dentry'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1519 |         if (get_nr_dentry() <= (long)limit)
         |             ^
   2 errors generated.


vim +/get_nr_dentry +1474 fs/dcache.c

  1463	
  1464	static void dentry_limit_worker_fn(struct work_struct *work)
  1465	{
  1466		struct dentry_limit_ctx ctx;
  1467		unsigned long limit = READ_ONCE(sysctl_dentry_limit);
  1468		unsigned int ms;
  1469		long nr;
  1470	
  1471		if (!limit)
  1472			return;
  1473	
> 1474		nr = get_nr_dentry();
  1475		if (nr <= (long)limit)
  1476			return;
  1477	
  1478		ctx.over = nr - (long)limit;
  1479	
  1480		/* Phase 1: drain negative dentries across every superblock. */
  1481		ctx.isolate = dentry_lru_isolate_negative;
  1482		iterate_supers(dentry_limit_prune_sb, &ctx);
  1483	
  1484		/* Phase 2: still over? Apply the ordinary LRU policy. */
  1485		if (ctx.over > 0) {
  1486			ctx.isolate = dentry_lru_isolate;
  1487			iterate_supers(dentry_limit_prune_sb, &ctx);
  1488		}
  1489	
  1490		/*
  1491		 * Re-arm while still above the limit. Re-read the sysctls in
  1492		 * case the admin raised the cap or disabled the feature during
  1493		 * the walk.
  1494		 */
  1495		limit = READ_ONCE(sysctl_dentry_limit);
  1496		if (!limit || get_nr_dentry() <= (long)limit)
  1497			return;
  1498	
  1499		ms = READ_ONCE(sysctl_dentry_limit_interval_ms);
  1500		queue_delayed_work(system_unbound_wq, &dentry_limit_work,
  1501				   msecs_to_jiffies(ms));
  1502	}
  1503	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
