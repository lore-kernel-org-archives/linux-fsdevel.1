Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB24230149F;
	Wed, 24 Jun 2026 02:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782269722; cv=none; b=D3klUDDF8tke6sfTYYSiNYgzsZKWFtIKqM32lHwD02PIzpj92OesUXjuonq//HvyZ/4tONLtQR5VZd5egeSmFYbtog/xFhbqEZLzZtcjmu6ZE8lUUt8njd63sZJtbQkofgP/XSypjCW96Pmc7rGTdmz+8gXpilZ8xprB/asHF4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782269722; c=relaxed/simple;
	bh=DE7+pF5y28bPYW4IyyFXvEAe/Ac+GbsL6R0nAQuaGik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEIwP8A5ghzQxasQVlnBiD1Q56H4Vx3NYw7kMoqbkDTTnFCH//zu+LohfwOTzCdE7KWJ+zsAI9vyRXuh+ZFz8GC9QBDnXl73Bau2i/+YB36BHOEwyYAL2UipY2X5R7QOywK0NcloZyLe9E6bxaCKRm7ysXdAGq5Z0xT53JSm3Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IiDa44CB; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IiDa44CB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782269720; x=1813805720;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DE7+pF5y28bPYW4IyyFXvEAe/Ac+GbsL6R0nAQuaGik=;
  b=IiDa44CBrqSN/PfVLBAGbrgfgAVkZTFraRLLNLxuGHxBNMN0xRMTGR+g
   vdfzHzHinmydN5zrMPXW6BEsMeqBNFWdmONSq85sURGCp6H7lGOkbODQP
   n1OHouIByxxjnrBidWk/+OFEHY7VqVkO4mwalprDBxAdp2u/0PEVqBM36
   Gb7iCyqj5ZoCrlh0W00ix8EJ+rfVQA4d0hjl/kYL+lkgdF1N0qrT0YHKl
   1pNWEFmD5AQTAvPxuicJVQWkrgAmXdzy/CNobaBbLhNQG+0GPA5bwiWMj
   pFlK6Qic2iO899eddWYE9yGEDh4S94fzbus5a5TbV9WCmVKQwT5JfsRW2
   Q==;
X-CSE-ConnectionGUID: 8TlzUmLhQKGg+oPhgZRyrw==
X-CSE-MsgGUID: EijGoV4SSXyIhErY2Ff75Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="105814676"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="105814676"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 19:55:20 -0700
X-CSE-ConnectionGUID: mz2h8+0eTjKaKuWK0m+VKg==
X-CSE-MsgGUID: hUnYcgRRSo2xE1n36M2I5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="254676609"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 23 Jun 2026 19:55:17 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wcDlh-0000000034T-3RBN;
	Wed, 24 Jun 2026 02:55:13 +0000
Date: Wed, 24 Jun 2026 10:54:39 +0800
From: kernel test robot <lkp@intel.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	David Timber <dxdt@dev.snart.me>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, jack@suse.cz, chrubis@suse.cz,
	Andrea Cervesato <andrea.cervesato@suse.com>
Subject: Re: [PATCH] exfat: implement swap activate
Message-ID: <202606241018.4N100hSQ-lkp@intel.com>
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
config: microblaze-allyesconfig (https://download.01.org/0day-ci/archive/20260624/202606241018.4N100hSQ-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260624/202606241018.4N100hSQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606241018.4N100hSQ-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/exfat/inode.c: In function 'exfat_swap_activate':
>> fs/exfat/inode.c:556:16: error: implicit declaration of function 'generic_swapfile_activate' [-Wimplicit-function-declaration]
     556 |         return generic_swapfile_activate(sis, file, span);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/generic_swapfile_activate +556 fs/exfat/inode.c

   537	
   538	static int exfat_swap_activate(struct swap_info_struct *sis,
   539				       struct file *file, sector_t *span)
   540	{
   541		struct inode *inode = file_inode(file);
   542		struct exfat_inode_info *ei = EXFAT_I(inode);
   543		int ret;
   544	
   545		/*
   546		 * exfat's fallocate allocates clusters without updating valid_size,
   547		 * leaving them invisible to bmap(). Extend valid_size to i_size so
   548		 * that generic_swapfile_activate() can map all blocks.
   549		 */
   550		if (ei->valid_size < i_size_read(inode)) {
   551			ret = exfat_extend_valid_size(inode, i_size_read(inode));
   552			if (ret)
   553				return ret;
   554		}
   555	
 > 556		return generic_swapfile_activate(sis, file, span);
   557	}
   558	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
