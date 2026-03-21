Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387CC35DA6C;
	Sat, 21 Mar 2026 12:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774096962; cv=none; b=XOa4iI9YvrhTpZJTk+y3vT+48dugu8TWjNi8VetdJ4ie1CGGQDfFfTZellqyhecta7GarwL6GoNFXuvFqzPXbGqjD9hZQ6iqnmAPSoGPnKODl9KWh4IwJXC69BGOaaQA99GJ/bEmEOJWyhKSg/d+lCMFZ5z0NSRTA0DxeDBDOqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774096962; c=relaxed/simple;
	bh=YSRwE9HFlw3c8F7q79izQqk16rp15SyRcSNcZiQZz9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5FEhU/l2GHOMz1Hy8mb4/tF/whLF27Q7d0e7kB/JWJbbckvu7kpDw5/MdTLKZraC5TrSHAflA1bi5nSNmFzBPDws6PtmZa0fqAbfdJJCFmC2aguBHyVoHnsgM1XJdY4Zdp0sdIaptCMb5zbeb6KCk8dzRD0NoZiI4Gac3/mP1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VtUiDfJr; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VtUiDfJr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774096957; x=1805632957;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YSRwE9HFlw3c8F7q79izQqk16rp15SyRcSNcZiQZz9k=;
  b=VtUiDfJrm4UY+HLvxZbWPhv5TJnpQZDFA7bErs/iZAhxDRAUKSlfq2S5
   NZxJrPe1XulJbPaim2NiuzurP4UZbJ1DCa3UkQYVcAeCjsY9lUpLWF8dy
   GDU1wJE6nM9OJbmrBOgggZ5am1HCndqGHOKEhc+fawqoNm10aSX9TbFGl
   FAjlnVA9AXy4eJq6WbPAYYZnWRhXHxFZQgH2UBT1V3W1o2n/WkkZW0LY7
   02ZgMsjs2F+pqjewamGXwVP/7aUVMnvDX9c+NH4mEgwxiuT+2LF1/eNQr
   8TiieZHeNZ8xd2EMkxSz3B+dSj5Q+y474Bl+UZgEoLH9pxisnl9JATkTX
   Q==;
X-CSE-ConnectionGUID: VTNxoTMtTe+HqF5/z9AkyQ==
X-CSE-MsgGUID: rk3TfPVPRReSZ7PJEEPY0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="62726043"
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; 
   d="scan'208";a="62726043"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2026 05:42:37 -0700
X-CSE-ConnectionGUID: CxRUZdr8RFiyvIyzU5KaYw==
X-CSE-MsgGUID: M/BRU8HiSHmwD0zw6PnwZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; 
   d="scan'208";a="227663711"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by orviesa003.jf.intel.com with ESMTP; 21 Mar 2026 05:42:34 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w3vex-0000000067B-1uLr;
	Sat, 21 Mar 2026 12:42:31 +0000
Date: Sat, 21 Mar 2026 13:42:00 +0100
From: kernel test robot <lkp@intel.com>
To: Emanuele Rocca <emanuele.rocca@arm.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] pidfds: add coredump_code field to pidfd_info
Message-ID: <202603211308.ZcBwzx9H-lkp@intel.com>
References: <ab29J6KsQm8Xg3LR@NH27D9T0LF>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab29J6KsQm8Xg3LR@NH27D9T0LF>

Hi Emanuele,

kernel test robot noticed the following build errors:

[auto build test ERROR on shuah-kselftest/next]
[also build test ERROR on shuah-kselftest/fixes brauner-vfs/vfs.all linus/master v7.0-rc4 next-20260320]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Emanuele-Rocca/pidfds-add-coredump_code-field-to-pidfd_info/20260321-125434
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
patch link:    https://lore.kernel.org/r/ab29J6KsQm8Xg3LR%40NH27D9T0LF
patch subject: [PATCH] pidfds: add coredump_code field to pidfd_info
config: i386-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20260321/202603211308.ZcBwzx9H-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260321/202603211308.ZcBwzx9H-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603211308.ZcBwzx9H-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   In function 'pidfd_info',
       inlined from 'pidfd_ioctl' at fs/pidfs.c:527:10:
>> ././include/linux/compiler_types.h:706:45: error: call to '__compiletime_assert_515' declared with attribute error: BUILD_BUG_ON failed: sizeof(struct pidfd_info) != PIDFD_INFO_SIZE_VER3
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   ././include/linux/compiler_types.h:687:25: note: in definition of macro '__compiletime_assert'
     687 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   ././include/linux/compiler_types.h:706:9: note: in expansion of macro '_compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   ./include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   ./include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   fs/pidfs.c:350:9: note: in expansion of macro 'BUILD_BUG_ON'
     350 |         BUILD_BUG_ON(sizeof(struct pidfd_info) != PIDFD_INFO_SIZE_VER3);
         |         ^~~~~~~~~~~~


vim +/__compiletime_assert_515 +706 ././include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  692  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  693  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  694  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  695  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  696  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  697   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  698   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  699   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  700   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  701   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  702   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  703   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  704   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  705  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @706  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  707  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
