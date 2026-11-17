Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794901337;
	b=37z9EDpxDwb1LvTNgNngyyO129ONuIdMVy1ciRqmjc50Yv2KaqgL09a7e+HukknsMDRh
	 oDQuL+2YqWU3kBFjNHToSENDqJ+94PfVB/WFkXMFFwTvNtU8XMDYGinSB+bIZKHUTIBlu
	 Y6YxnV4EqU8IwuxabQ7IgeQaLC66XruvvwOarzjesm0prrtJl/ceoeD1hkc/8tw2/1eCv
	 PqCVD6lgGyh2F/xBDAPe4sucjT58Pu2IrWI8sKJHGAFKaXexO4cdOdPW6Ob+e80JH4IvK
	 Nle7OjCq/4no84eFOI4l7Uw70GqRoyNgesWpyZtYsuWv/T4Du2tKGdsc5dIAQcKZJzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794901337;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=BNc0jc+y8gmBof9uvBRCGTTtAoU3LO+7YLj5ywN7oqI=;
	b=KI1zS83HDy3IpnJYCPOoF8y/4RW0xtpLwZ0d/QbXkbIVfeHXihKjUOYt5rjuYWEiE6UG
	 ZwvLwxDKY3Q7kHtoL0cS47o//pM5p5HYcpEy1qXyyUm9hX3aE0d9pXzlPXZUG80fLndKS
	 GEIoyudgQ9o8osaUKlrE3ZXeirgN1mbM+l8NP7aj5nHVf7KWwPZ9pUAhpoLRuJHY5gy3Y
	 viiXkSQx49J4LdWadOsccisXrPbYEVxZMAHAQ+i/g+KT80unWvigeGPQKdb/5yDn6R3HB
	 a9TyaMCuL5PPsjaQ3sWMF71UPTGV/aDeuVEg9YEBCpcyuJqnLY/0QN0pjMzIHcfbMkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kUlOkBc3;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25092606A31C;
	Tue, 17 Nov 2026 07:42:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25092606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kUlOkBc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794901336; x=1826437336;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EgA9YxNZ9BP8hN2g1J7ClShew7PSM78W1qj6c6PmgZc=;
  b=kUlOkBc3XtwPKKPo0RMgf++8L5oYss/5+b9nGc0IrccpOIXvnNWUdkKR
   bTxrWO7YCyWxubAGnMsUN9cRHbkEWjbsVRgfOoWJu7ICNrgdYSV+aieua
   PegOO1ep2RF5gHzIE9kCKGglBF/7v4sZSEfMNQGPfa2OZCHKg6a+0AJV3
   1Jz2LI3Y2m8FEJIga68c4EINtIAaHoyLjHvOET3igHVrpcBMrc0TlZMBS
   KVhp5Y5Ke/FTtlUsqFj5e5X0eQ4rmEf3xKCYROiAEAkTdCHqCiWABjFDe
   AiHz5oCjDQyPZO6vdPiIBerVSECzOg1J2fL8QCZskdDwUsbrmJQ8k3GXl
   A==;
X-CSE-ConnectionGUID: WPGHS5B/QsWTrctt2oWfeA==
X-CSE-MsgGUID: MOQ9mdnwTLiE3NameB+7JA==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3531449"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3531449"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 23:42:16 -0800
X-CSE-ConnectionGUID: y3u73FwOR3yNO6kgsuDVGw==
X-CSE-MsgGUID: TZYphSKdT9iKw7wvdnxtIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9842138"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 16 Nov 2026 23:42:14 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xTDpT-00000001ADo-0bXf;
	Tue, 17 Nov 2026 07:42:11 +0000
Date: Tue, 17 Nov 2026 15:41:48 +0800
From: kernel test robot <lkp@intel.com>
To: Ismael Luceno <ismael@iodev.co.uk>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Ismael Luceno <ismael@iodev.co.uk>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 3/8] init: let filesystems ask whether they are mounting
 the root device
Message-ID: <202611171523.oW7KTbJo-lkp@intel.com>
References: <20261116224316.11237-13-ismael@iodev.co.uk>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116224316.11237-13-ismael@iodev.co.uk>

Hi Ismael,

kernel test robot noticed the following build errors:

[auto build test ERROR on kdave/for-next]
[also build test ERROR on btrfs/for-next brauner-vfs/vfs.all linus/master v7.4-rc3 next-20261116]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ismael-Luceno/btrfs-add-config-options-for-the-root-device-scan/20261116-234317
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/20261116224316.11237-13-ismael%40iodev.co.uk
patch subject: [PATCH 3/8] init: let filesystems ask whether they are mounting the root device
config: parisc-randconfig-1001-20261117 (https://download.01.org/0day-ci/archive/20261117/202611171523.oW7KTbJo-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261117/202611171523.oW7KTbJo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611171523.oW7KTbJo-lkp@intel.com/

All errors (new ones prefixed by >>):

>> init/do_mounts.c:391:20: error: static declaration of 'is_root_dev' follows non-static declaration
    static inline bool is_root_dev(dev_t dev)
                       ^~~~~~~~~~~
   In file included from init/do_mounts.c:8:
   include/linux/root_dev.h:30:6: note: previous declaration of 'is_root_dev' was here
    bool is_root_dev(dev_t dev);
         ^~~~~~~~~~~


vim +/is_root_dev +391 init/do_mounts.c

   390	
 > 391	static inline bool is_root_dev(dev_t dev)
   392	{
   393		return false;
   394	}
   395	#endif /* CONFIG_BLOCK */
   396	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
