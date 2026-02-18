Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3BE145348;
	Wed, 18 Feb 2026 10:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771410203; cv=none; b=TX+e7ZPhhwuUxO+lCHCoohR+CKjpbs+PH60ZGKdMPA7GvFmz/q9+Dvwd+Zj7bKtc3rW54X0DjxeOPCdZk6foNfkNAihxufibKruYXRv16/GvDaCG//q0S37ufTJMRcTwdN0UYYoZrjhK6cV37BHBQ3Q31qIwD7/aVTkXq0+Zr4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771410203; c=relaxed/simple;
	bh=oXenyoOf6ubR0OAzaErVRJ09tPZl9ka/sy7cxMIfFgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8yJupn7Sd3mGdEka1slJivVoPBRZGSTyRsUsU/pb/z272ApJph60APcS3mwUhgIkF7HWnrNd+B2us/CGCeX1L5cbWZdDWqfXDl6A5PvkPGMGgtxa6VQ+o67w53MeUBD+d/ygY9Vsu3TacXjC5EmsHuRuHDLQ0upN2zWuuxSf74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eN11PawY; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eN11PawY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771410200; x=1802946200;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oXenyoOf6ubR0OAzaErVRJ09tPZl9ka/sy7cxMIfFgk=;
  b=eN11PawY49pRa5ap08Zr4woiAdxQimf4ymxH+MUhccKe28nukRbVbS4w
   GbFLGEdqGv5tn1b+zJpqRuU3AhoBuFYo5QEtA6Y3XWUI/jb5McXMhSBIU
   CoT20pUsJbFAil6TBdyyLdzRBRYz4F5On2jMetRZwYeBkGgE0CynWmX1/
   YMPs3qLj1UORqeqUElD63hrl2vjkRDvx7QVyOyMZrUM9FFmEo+bwz8uWc
   qaZD28Rzen1HNRar+XKHgHvreVCNAurLAjmyytT84lHGMor4z8NB284zn
   Bk+DxkVUIc27j2hLgLh/TeoWd3Zy6GXvyozX38iuvyYRUf7LazmsEL1Zp
   w==;
X-CSE-ConnectionGUID: HqEvs+F9RSm79iVwZ7miJw==
X-CSE-MsgGUID: LbRCqElHTQa5uJrETyboCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="72195952"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; 
   d="scan'208";a="72195952"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 02:23:20 -0800
X-CSE-ConnectionGUID: 3qDFRDz4QPC8MQHm8rM4GA==
X-CSE-MsgGUID: fBOcfXBmSseTUcD99kqEAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; 
   d="scan'208";a="218292192"
Received: from igk-lkp-server01.igk.intel.com (HELO e5404a91d123) ([10.211.93.152])
  by orviesa003.jf.intel.com with ESMTP; 18 Feb 2026 02:23:19 -0800
Received: from kbuild by e5404a91d123 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vseiC-000000003Yf-17vP;
	Wed, 18 Feb 2026 10:23:16 +0000
Date: Wed, 18 Feb 2026 11:22:20 +0100
From: kernel test robot <lkp@intel.com>
To: Ethan Ferguson <ethan.ferguson@zetier.com>, hirofumi@mail.parknet.co.jp
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: Re: [PATCH v2 2/2] fat: Add FS_IOC_SETFSLABEL ioctl
Message-ID: <202602181149.k8dhUKY6-lkp@intel.com>
References: <20260217230628.719475-3-ethan.ferguson@zetier.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217230628.719475-3-ethan.ferguson@zetier.com>

Hi Ethan,

kernel test robot noticed the following build errors:

[auto build test ERROR on 9f2693489ef8558240d9e80bfad103650daed0af]

url:    https://github.com/intel-lab-lkp/linux/commits/Ethan-Ferguson/fat-Add-FS_IOC_GETFSLABEL-ioctl/20260218-071019
base:   9f2693489ef8558240d9e80bfad103650daed0af
patch link:    https://lore.kernel.org/r/20260217230628.719475-3-ethan.ferguson%40zetier.com
patch subject: [PATCH v2 2/2] fat: Add FS_IOC_SETFSLABEL ioctl
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20260218/202602181149.k8dhUKY6-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260218/202602181149.k8dhUKY6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602181149.k8dhUKY6-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "msdos_format_name" [fs/fat/fat.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
