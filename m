Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B001F4C8C;
	Thu, 30 Apr 2026 03:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777519239; cv=none; b=tMRFD6EhaMcIB7UelDcx2VJy+3DFGT9woRIjRb4WFQWIqZjL4IWetaCPj503aRAOuByrrR3FkWrncjLCFCqdb8rULScxW+JPHHUqSSzR31XSz2wdcOcZA09teLx9whvXL0ONNNe5EXwlnncwB6GbiHWK/LwcCOhzHE4OiHUZrz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777519239; c=relaxed/simple;
	bh=TMMIK1incSbHTts07AKbuWcnjJGwByY/8es7LJzTnGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBd4ghA3AUg3cMnFRyDsCcMGU81hHEHHj7R+vSYLRk7vug3/UKOVPgUBGtUyORRAZkZqlwfjcFFIi1RIFPv1OsQyfCPyBZvvAWwYtdjlt8WhDN9Xpz9Hm/PgiMUb+FW5yvqT58lVatMWUUT0SB7aAn9je/rq/ZjqxV/QxYTj8hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VG3N/ly7; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VG3N/ly7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777519238; x=1809055238;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TMMIK1incSbHTts07AKbuWcnjJGwByY/8es7LJzTnGc=;
  b=VG3N/ly73KE7IsIC/OdPaIy7H9+gFiQuAkrhmuYuexXF1KTcorpVM+46
   WQG9CxGyU4hSZkas0WYIfFoKmAHNAG9wbsQWsPCiwRjZvH/9mn50cMk2V
   qHER7EALGRe6OEz9L25WJ20Nc3mUzjd6VuiA7j4FeptaTMFAkpHU1lkXt
   Nd/oPnlcX4ro289Bnceg7Cyvdv1icNRjoDD9WZx5l2/m92nx6FSEDDYkN
   /VDv/Fm+8p1Yx3VLH5st+QSP9mREhYYI7bPo93aJcfZx6TEBhdSnsGbim
   V5RpUXfmZ5mxYq+Vwkc1W7CA3cE/qCLO+touCCBKRiWmBQrTpFR/nnzp6
   g==;
X-CSE-ConnectionGUID: Qe9ZqbsOS62H4oB9wzxC3w==
X-CSE-MsgGUID: JrRH84nDQWCbJH5HWAnTFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="82316456"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="82316456"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 20:20:37 -0700
X-CSE-ConnectionGUID: wVjtGuCMQUOlP178MdIGRg==
X-CSE-MsgGUID: QHDshEksQNySPD4lGjTf8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="257779404"
Received: from lkp-server01.sh.intel.com (HELO aa799cca880d) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 29 Apr 2026 20:20:36 -0700
Received: from kbuild by aa799cca880d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wIHx2-00000000Bsm-32uK;
	Thu, 30 Apr 2026 03:20:32 +0000
Date: Thu, 30 Apr 2026 11:19:46 +0800
From: kernel test robot <lkp@intel.com>
To: Li Wang <liwang@kylinos.cn>, Miklos Szeredi <miklos@szeredi.hu>
Cc: oe-kbuild-all@lists.linux.dev, Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bernd@bsbernd.com>, fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Li Wang <liwang@kylinos.cn>
Subject: Re: [PATCH v3] fuse: optional FORGET delivery over io_uring
Message-ID: <202604301155.Gw5TQF7K-lkp@intel.com>
References: <20260423110954.2676-1-liwang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423110954.2676-1-liwang@kylinos.cn>

Hi Li,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mszeredi-fuse/for-next]
[also build test WARNING on next-20260429]
[cannot apply to linus/master v7.1-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-Wang/fuse-optional-FORGET-delivery-over-io_uring/20260424-173453
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git for-next
patch link:    https://lore.kernel.org/r/20260423110954.2676-1-liwang%40kylinos.cn
patch subject: [PATCH v3] fuse: optional FORGET delivery over io_uring
config: x86_64-randconfig-076-20260427 (https://download.01.org/0day-ci/archive/20260430/202604301155.Gw5TQF7K-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260430/202604301155.Gw5TQF7K-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604301155.Gw5TQF7K-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/fuse/dev.c:825:13: warning: 'fuse_forget_uring_free' defined but not used [-Wunused-function]
     825 | static void fuse_forget_uring_free(struct fuse_args *args, int error)
         |             ^~~~~~~~~~~~~~~~~~~~~~


vim +/fuse_forget_uring_free +825 fs/fuse/dev.c

   824	
 > 825	static void fuse_forget_uring_free(struct fuse_args *args, int error)
   826	{
   827		struct fuse_forget_uring_data *d =
   828			container_of(args, struct fuse_forget_uring_data, args);
   829	
   830		kfree(d);
   831	}
   832	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
