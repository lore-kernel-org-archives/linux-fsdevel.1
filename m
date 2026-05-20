Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756D23E1233;
	Wed, 20 May 2026 12:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779281110; cv=none; b=nbApTXWmibNH562H0yll1ZDn3aSDmdRNWpTSDh/b96uDTSeIO1SwTldzxdRWmcpENVLEMprtE/2TvBblyMq3BrL3R88qJAZ0GsDv0HWQM9wZSt3SZeHTY3qyHj0cf4JY4GYj/2sjcsrLcW4XNx0HrdIrXhYzonTQlYD3qlh/9ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779281110; c=relaxed/simple;
	bh=nVvw8sK7QoJlknSpgna5CuMA0A4P6bOu2DxiOepEIkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEuE+6stxwzkVhAnvqTqBDGSd7PRXeBak7OBoWgN7iBEHn8slvmysrEZPvAGajcgD70iQqSmtDp63bet5R/W1XPYddm1pSl29lAbVeoTP9d3dypkucKKlD2Ecmua+qXFb0XXOwAQIZ/wOaqXiGK4Mt5/kloggNp3pFlfpqm67zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ltv+38Pi; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ltv+38Pi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779281109; x=1810817109;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nVvw8sK7QoJlknSpgna5CuMA0A4P6bOu2DxiOepEIkc=;
  b=ltv+38Pi3Z/wUZ+JpN2psouSOAgWv1QvgI4v+ZShRNYhpN7KymeRjKpl
   DVS8XYV7JI9ijWqo3GDt1KS9cm8vDERH/2CreWpVCvj8E7FImhTc9WJAo
   mbDy6glnsYEUbt/aa5R5xuTfQXbHL7SXpI7Ia8+znPFOTleE+dTVXq4BE
   ZJ2EITCKMEHsKY1+muJky1dG0DQro0F9jNyg1c0GH5OtEZy0v+eKAPwHl
   l1iFsB5v3yDEaG+8bPEVf258SwCE9tP5zrc9jnI2CSLOQ9iE38uG6pJx8
   ZO4J5NXeUSsC0oVqjoO6shz47Dr6CPRYSZLsO2NyTn8lXWDpHocjZsGyL
   w==;
X-CSE-ConnectionGUID: aiaD+yTZThiM4EY2z3WhqA==
X-CSE-MsgGUID: ACxA9Z0gToaGLz9g2EqPLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="83793897"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="83793897"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 05:45:08 -0700
X-CSE-ConnectionGUID: wQeiMau4SjKx+5drUtE+bw==
X-CSE-MsgGUID: wSCEHMI4SuqSzA0KpDgHXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="237165166"
Received: from lkp-server02.sh.intel.com (HELO 30e86e9c1927) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 20 May 2026 05:45:06 -0700
Received: from kbuild by 30e86e9c1927 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wPgGx-000000003AD-1SgR;
	Wed, 20 May 2026 12:44:00 +0000
Date: Wed, 20 May 2026 20:41:18 +0800
From: kernel test robot <lkp@intel.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: oe-kbuild-all@lists.linux.dev, Mike Rapoport <rppt@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] init: do_mounts: use kmalloc() for allocations of
 temporary buffers
Message-ID: <202605202055.kwkCHqR9-lkp@intel.com>
References: <20260520-init-v1-1-aaf2ebac5ad9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520-init-v1-1-aaf2ebac5ad9@kernel.org>

Hi Mike,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 5d6919055dec134de3c40167a490f33c74c12581]

url:    https://github.com/intel-lab-lkp/linux/commits/Mike-Rapoport-Microsoft/init-do_mounts-use-kmalloc-for-allocations-of-temporary-buffers/20260520-164927
base:   5d6919055dec134de3c40167a490f33c74c12581
patch link:    https://lore.kernel.org/r/20260520-init-v1-1-aaf2ebac5ad9%40kernel.org
patch subject: [PATCH] init: do_mounts: use kmalloc() for allocations of temporary buffers
config: xtensa-allnoconfig (https://download.01.org/0day-ci/archive/20260520/202605202055.kwkCHqR9-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260520/202605202055.kwkCHqR9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605202055.kwkCHqR9-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux: section mismatch in reference: try_to_run_init_process+0x24 (section: .text.unlikely) -> initcall_level_names (section: .init.data)

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
