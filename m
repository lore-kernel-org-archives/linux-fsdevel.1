Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79E83859C7;
	Sun, 23 Aug 2026 19:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787514415; cv=none; b=RQK8V4mT4coSvzcR9zvz9+ypgwSrCgptbtHx7AAZWAxBe52j/9IT2kdIFYtnGztbGwze/s9y7N+faqgy7TkbmPte970IadylKbk2Q0u2qkJMwY5ECWt7DGX+FDDb9B1HnH4hNrELdcFb/pZyP3ZInCEl5MMG04Cbm0tDAQaP/os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787514415; c=relaxed/simple;
	bh=EPKbIcggAwGK0od1EiqwXwq5nuXFrOa0FB4k/3dYrNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgp/6dPDiFyyvKfBHEDMFDRKjpQymlCi4Nr1dihDMSwLtS1lCS3OAZ38ILyDPwe2W5pWVDM+swgyyAe2cIz0fQMJmuayBrBwdj00z3PhNbz1L8iq1ByfFPDD4O6/OIliwnZG/EgiEmug7Is4Xcty9ZJAhHJXPPpEOHHX7oDgmto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gIPOGR1Z; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gIPOGR1Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787514413; x=1819050413;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EPKbIcggAwGK0od1EiqwXwq5nuXFrOa0FB4k/3dYrNc=;
  b=gIPOGR1ZRIcpV83JWy+LyJbj/OLtcrPdpDrTkuaTD1+c/i9H6VkH/1ek
   D1SLCgj5/nJwvh5Aajq+mJ0BG2LtaTsGAD0HIUrZ5hlB0HpGmylbdOedG
   qCBDjSz+Mvel57Sb/MoOyzMN/sPI8GNiqsPP8CfxEVNWY2m3yM3rHa3t8
   7gueJUs/6FtjYAfv9qReCx6NFdwIqEFKvJbIY176hPWMmENPFgDTpyG7T
   J/5um4ue4Z8ofkPhJvVSNGESGNFPp5QKsbibZ1KNT+AhXy7ALbUGmRYYD
   rh+sMHr7qzIhkzsv1cTILPpnz0AYnuMtx53fkB7DNV1djApR0nmfl3ECe
   w==;
X-CSE-ConnectionGUID: kdWIieANTwm9BHDkeo57cQ==
X-CSE-MsgGUID: DMSSLYXJRj6PC5eP9lqGvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="75510940"
X-IronPort-AV: E=Sophos;i="6.25,239,1779174000"; 
   d="scan'208";a="75510940"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 12:46:52 -0700
X-CSE-ConnectionGUID: x+xh4Z1dToSez1oE58Ebhw==
X-CSE-MsgGUID: KPIvnkHMQX2OAjYP2mRC4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,239,1779174000"; 
   d="scan'208";a="305013235"
Received: from lkp-server01.sh.intel.com (HELO 3532383e6126) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 23 Aug 2026 12:46:49 -0700
Received: from kbuild by 3532383e6126 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wyE9Q-0000000014N-3FuZ;
	Sun, 23 Aug 2026 19:46:42 +0000
Date: Mon, 24 Aug 2026 03:46:27 +0800
From: kernel test robot <lkp@intel.com>
To: Bhaskar Chowdhury <unixbhaskar@gmail.com>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: Re: [PATCH] fs: Kconfig: Alignment of code and text in the FS_DAX
 help section for better readability
Message-ID: <202608240313.d7SDG2tE-lkp@intel.com>
References: <20260821101824.23203-1-unixbhaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821101824.23203-1-unixbhaskar@gmail.com>

Hi Bhaskar,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on linus/master v7.2 next-20260821]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bhaskar-Chowdhury/fs-Kconfig-Alignment-of-code-and-text-in-the-FS_DAX-help-section-for-better-readability/20260821-154402
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20260821101824.23203-1-unixbhaskar%40gmail.com
patch subject: [PATCH] fs: Kconfig: Alignment of code and text in the FS_DAX help section for better readability
config: i386-randconfig-141-20260824 (attached as .config)
compiler: clang version 22.1.3 (https://github.com/llvm/llvm-project e9846648fd6183ee6d8cbdb4502213fcf902a211)
smatch: v0.5.0-9187-g5189e3fb
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260824/202608240313.d7SDG2tE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608240313.d7SDG2tE-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/Kconfig:76: syntax error
   fs/Kconfig:76:warning: ignoring unsupported character ':'
   fs/Kconfig:76: unknown statement "See"
   fs/Kconfig:78:warning: ignoring unsupported character ':'
   fs/Kconfig:78:warning: ignoring unsupported character '/'
   fs/Kconfig:78:warning: ignoring unsupported character '/'
   fs/Kconfig:78:warning: ignoring unsupported character '.'
   fs/Kconfig:78:warning: ignoring unsupported character '.'
   fs/Kconfig:78:warning: ignoring unsupported character '/'
   fs/Kconfig:78:warning: ignoring unsupported character '/'
   fs/Kconfig:78:warning: ignoring unsupported character '/'
   fs/Kconfig:78: unknown statement "https"
   fs/Kconfig:80:warning: ignoring unsupported character '.'
   fs/Kconfig:80: unknown statement "For"
   fs/Kconfig:81: unknown statement "file"
   fs/Kconfig:82:warning: ignoring unsupported character '.'
   fs/Kconfig:82: unknown statement "per-inode"
   fs/Kconfig:83:warning: ignoring unsupported character '/'
   fs/Kconfig:83:warning: ignoring unsupported character '/'
   fs/Kconfig:83:warning: ignoring unsupported character '.'
   fs/Kconfig:83:warning: ignoring unsupported character '.'
   fs/Kconfig:83: unknown statement "Documentation"
   fs/Kconfig:85:warning: ignoring unsupported character ','
   fs/Kconfig:85: unknown statement "If"
   fs/Kconfig:86:warning: ignoring unsupported character ','
   fs/Kconfig:86:warning: ignoring unsupported character '.'
   fs/Kconfig:86: unknown statement "or"
   fs/Kconfig:87:warning: ignoring unsupported character '.'
   fs/Kconfig:87: unknown statement "by"
   make[3]: *** [scripts/kconfig/Makefile:85: oldconfig] Error 1
   make[2]: *** [Makefile:766: oldconfig] Error 2
   make[1]: *** [Makefile:248: __sub-make] Error 2
   make[1]: Target 'oldconfig' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2
   make: Target 'oldconfig' not remade because of errors.
--
>> fs/Kconfig:76: syntax error
   fs/Kconfig:76:warning: ignoring unsupported character ':'
   fs/Kconfig:76: unknown statement "See"
   fs/Kconfig:78:warning: ignoring unsupported character ':'
   fs/Kconfig:78:warning: ignoring unsupported character '/'
   fs/Kconfig:78:warning: ignoring unsupported character '/'
   fs/Kconfig:78:warning: ignoring unsupported character '.'
   fs/Kconfig:78:warning: ignoring unsupported character '.'
   fs/Kconfig:78:warning: ignoring unsupported character '/'
   fs/Kconfig:78:warning: ignoring unsupported character '/'
   fs/Kconfig:78:warning: ignoring unsupported character '/'
   fs/Kconfig:78: unknown statement "https"
   fs/Kconfig:80:warning: ignoring unsupported character '.'
   fs/Kconfig:80: unknown statement "For"
   fs/Kconfig:81: unknown statement "file"
   fs/Kconfig:82:warning: ignoring unsupported character '.'
   fs/Kconfig:82: unknown statement "per-inode"
   fs/Kconfig:83:warning: ignoring unsupported character '/'
   fs/Kconfig:83:warning: ignoring unsupported character '/'
   fs/Kconfig:83:warning: ignoring unsupported character '.'
   fs/Kconfig:83:warning: ignoring unsupported character '.'
   fs/Kconfig:83: unknown statement "Documentation"
   fs/Kconfig:85:warning: ignoring unsupported character ','
   fs/Kconfig:85: unknown statement "If"
   fs/Kconfig:86:warning: ignoring unsupported character ','
   fs/Kconfig:86:warning: ignoring unsupported character '.'
   fs/Kconfig:86: unknown statement "or"
   fs/Kconfig:87:warning: ignoring unsupported character '.'
   fs/Kconfig:87: unknown statement "by"
   make[3]: *** [scripts/kconfig/Makefile:85: olddefconfig] Error 1
   make[2]: *** [Makefile:766: olddefconfig] Error 2
   make[1]: *** [Makefile:248: __sub-make] Error 2
   make[1]: Target 'olddefconfig' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2
   make: Target 'olddefconfig' not remade because of errors.


vim +76 fs/Kconfig

    57	
    58	config FS_DAX
    59		bool "File system based Direct Access (DAX) support"
    60		depends on MMU
    61		depends on ZONE_DEVICE
    62		select FS_IOMAP
    63		select DAX
    64		help
    65		  Direct Access (DAX) can be used on memory-backed block devices.
    66		  If the block device supports DAX and the filesystem supports DAX,
    67		  then you can avoid using the pagecache to buffer I/Os.  Turning
    68		  on this option will compile in support for DAX.
    69	
    70		  For a DAX device to support file system access it needs to have
    71		  struct pages.  For the nfit based NVDIMMs this can be enabled
    72		  using the ndctl utility:
    73	
    74		# ndctl create-namespace --force --reconfig=namespace0.0 --mode=fsdax --map=mem
    75	
  > 76		  See the 'create-namespace' man page for details on the overhead of --map=mem:
    77	
    78		  https://docs.pmem.io/ndctl-user-guide/ndctl-man-pages/ndctl-create-namespace
    79	
    80		  For ndctl to work CONFIG_DEV_DAX needs to be enabled as well. For most
    81		  file systems DAX support needs to be manually enabled globally or
    82		  per-inode using a mount option as well.  See the file documentation in
    83		  Documentation/filesystems/dax.rst for details.
    84	
    85		  If you do not have a block device that is capable of using this,
    86		  or if unsure, say N.  Saying Y will increase the size of the kernel
    87		  by about 5kB.
    88	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
