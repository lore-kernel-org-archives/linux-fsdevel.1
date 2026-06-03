Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F66271456
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 23:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780528713; cv=none; b=HQCNKzBZUonUOea3MG8cZDFiPq0tDfeSKGgHyNKSFVv1ctE0Pl2cL2ZKXEGie6+gQ4MfC4ORgymENqFOk3YQX5bqjTzci+XyKJmSvINGmppPn2uHYrlK52EjkmxQ0CDAUJmTxI7R5HDtOpS72SkzuzMpLjfvpmpVo9daYCX5Nqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780528713; c=relaxed/simple;
	bh=D5ekZyD4d3nHxiBwfUVIn/vbwyWsEYUhqLB1pos0gXs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=jF22/QDbEPbe8M9xUsIhzgu3YJ70HMz8XdBazvLmsjngoxrRrDhxxw3VCJY9adtDQuH9+vS+u5lv6JFDExtY4zkSH6576Hm0R9HxtLCRkTyt8pjbvM0+uG1rcMm4HYgl+h4odam1YJRAxgsegfmXAyPWsiVp5mO8BoIdDrlQaWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mr7bmv1A; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mr7bmv1A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780528711; x=1812064711;
  h=date:from:to:cc:subject:message-id;
  bh=D5ekZyD4d3nHxiBwfUVIn/vbwyWsEYUhqLB1pos0gXs=;
  b=Mr7bmv1Adh1I9pXK27VTE3JF7SncuOWMbJVewE5o2pEmygSq0p6pypMl
   f8MeS/0lw/L7q8YsEyHd4tvOYQDnEj4pRteliiVIFgadRNqQ1bTUrQEWZ
   Oj7asbQ4WzKtVlljeQqohV34MsgFO8svOybKHN3sZ5OjAMrF/xZca76y1
   3P6paA7kaXvhHePqpPrp3O56Yfd5pHTETSJ5NNMvjb7TXPKFoFAg67CP5
   UIN9+6yin/ZxKGujgUMLyJCPoPfhuqvz98xUiK+clNKTJrWX28igf2NiT
   LCUyVgroaBUtFGsG7gOcrsCpR5nhSJMidm2yEqC7+QewFKwMhFqxkrNRD
   w==;
X-CSE-ConnectionGUID: sgvFyP8mT+mEMc6R+rfkVg==
X-CSE-MsgGUID: BNKivW2XQQy617NQNvJU3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="104014679"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="104014679"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 16:18:30 -0700
X-CSE-ConnectionGUID: 2Jv1w9u8Qae+5xPlU7NtGQ==
X-CSE-MsgGUID: uwMaYZnTQWmLOY2BxQbeNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="240185877"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 03 Jun 2026 16:18:29 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wUuqw-00000000DzH-2YPq;
	Wed, 03 Jun 2026 23:18:26 +0000
Date: Thu, 04 Jun 2026 07:18:02 +0800
From: kernel test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:more.configfs 30/33] Warning:
 fs/configfs/dir.c:260 function parameter 'parent_sd' not described in
 'configfs_create_dir'
Message-ID: <202606040743.eKD89WcV-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git more.configfs
head:   53a9faf145785b0b12ec71f2204f3b3011dbda5e
commit: 2bbdcd7eabfcd3a5bd2614ab75ece19323d5f4c2 [30/33] configfs: attach the subtree only when it's completely built
config: csky-randconfig-r073-20260604 (https://download.01.org/0day-ci/archive/20260604/202606040743.eKD89WcV-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 16.1.0
smatch: v0.5.0-9185-gbcc58b9c
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260604/202606040743.eKD89WcV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606040743.eKD89WcV-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: fs/configfs/dir.c:260 function parameter 'parent_sd' not described in 'configfs_create_dir'
>> Warning: fs/configfs/dir.c:260 function parameter 'parent_sd' not described in 'configfs_create_dir'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
