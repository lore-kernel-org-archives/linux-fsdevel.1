Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6A2481659
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 13:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780492846; cv=none; b=siRfWy98PxxzlMqKdpd5N5sS+IVPVWeBFqYM4orWk878uPDTEpTdB4EV20twLfxc5zFdfovMNAkItwImTI6AvEjUOUJV8lSndZnCc91nKBwJ1h4vGIkF1nazfxCG/s8aWz8JNXU/Akeh0/00MNHRx71xBuVDHvByLe8Y+u8XejM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780492846; c=relaxed/simple;
	bh=LS+4rNfxK7i9K5lzOlbHkJotT8jcURP1SRsKf+Hoakg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=EMl52KDUyQlfGAX2DivGh5PvZUdunXm9ocb3/s5Ks5jYiV6MPM5qVd/Z4YraK+9H8kYT7mbj8UWW9KoYkHAawfAnIehr5z0eaE7IuJKfrHtHuxe3HsuQbJcd/czJVcXNmGGKXmGe2MbaHB5SWhyzF72oOx20msiFczstE+nJJBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NM1ebNH4; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NM1ebNH4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780492845; x=1812028845;
  h=date:from:to:cc:subject:message-id;
  bh=LS+4rNfxK7i9K5lzOlbHkJotT8jcURP1SRsKf+Hoakg=;
  b=NM1ebNH4ausPTDrMAvl8XIWoVN2WVI5xP8PXrFHGIrmbmhqZeIpiUsxP
   73WNhBT39E4flB5SlZaMJYF/OJBMewiFBX1+qdFUElroDkFrvuyj0XUrg
   tbA2xz+59JxDMFB8/H9xj7IOWB03nezKttHBJVh+Y861qrplzpPWycubw
   JNjga2N1s+rH4KKBYcZDRaOcwlCnP2auESwjR1c1BwCmJxVwwCGb0sJnf
   Pd4IsTuJZ57UH3WesoI2XXz2jNTKBc4Osc36JWYneTaKWxXDYsJraQO0C
   3oo1HbrI66DV/gtlu837xiju0TTTxwHThkHqn7+jCNOc811/4k4DQTjuM
   w==;
X-CSE-ConnectionGUID: Rfrt5Po8QxO3JDv7We6YEw==
X-CSE-MsgGUID: ob7Q50G/Q9mfxno/qcASpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81428419"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="81428419"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 06:20:44 -0700
X-CSE-ConnectionGUID: zaP3vnPDTCO4rXoTblD7Ug==
X-CSE-MsgGUID: kY2rFTsIRNeIW8YYrp8TwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="241741619"
Received: from igk-lkp-server01.igk.intel.com (HELO 892db79562d4) ([10.211.93.152])
  by fmviesa008.fm.intel.com with ESMTP; 03 Jun 2026 06:20:43 -0700
Received: from kbuild by 892db79562d4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wUlWT-00000000243-1JPf;
	Wed, 03 Jun 2026 13:20:41 +0000
Date: Wed, 03 Jun 2026 15:20:40 +0200
From: kernel test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:more.configfs 30/33] Warning:
 fs/configfs/dir.c:260 function parameter 'parent_sd' not described in
 'configfs_create_dir'
Message-ID: <202606031516.cGG744n7-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git more.configfs
head:   53a9faf145785b0b12ec71f2204f3b3011dbda5e
commit: 2bbdcd7eabfcd3a5bd2614ab75ece19323d5f4c2 [30/33] configfs: attach the subtree only when it's completely built
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260603/202606031516.cGG744n7-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project f43d6834093b19baf79beda8c0337ab020ac5f17)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260603/202606031516.cGG744n7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606031516.cGG744n7-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: fs/configfs/dir.c:260 function parameter 'parent_sd' not described in 'configfs_create_dir'
>> Warning: fs/configfs/dir.c:260 function parameter 'parent_sd' not described in 'configfs_create_dir'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
