Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B7436AB61;
	Sat, 21 Mar 2026 10:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774090761; cv=none; b=bV6X9Ec8d7CIVqALoXUEIOxSRPAUglFu+n/wvAjR4tCDMNmYpn/shUDG5Bw2CYBJZPVOXFPpbxYcN94km5aUc8c5w7dKvg9IezLm0EqNf5ycEsSTpqUMsptAdzlK7+z1Uj212jwJHvR0PYLQTuqOBbIX/+wLnoJ+vLA82HYL4PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774090761; c=relaxed/simple;
	bh=QQXZFI1/fmSKfRGEcGsAn1o/xAEgHZmMzHfPBZtLerU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FB2NqcM2MN1WuFmquNlIlAwQYWFrNwuvB5sJIdERfognqTtdekd4ZPASdEjymQaGTXU3baUWuHmNlC2z/WhbGqusORu33Mx0dgUgU0CQXZ9g0igvHS8q2Z4p7NvpILWi/SbzCVblsl4+ypWC9GHpaifI3eatud+zTkTE+z85tEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nBsh6s7/; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nBsh6s7/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774090760; x=1805626760;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QQXZFI1/fmSKfRGEcGsAn1o/xAEgHZmMzHfPBZtLerU=;
  b=nBsh6s7/HK5Q/hSEhLY0wd7HyRNUGvcsECK01jIabcBTMgvInBEyaCtH
   HxGZelvW8TSP64vY768mqrbpfJgay6xek4ESCL2UBDPi5iOP3Fag50t6h
   H3MdiZ3dYM5WDevkfK2lqkvl5AtJrFM7peUWLaWIIB7oTjBv5Bk5kBSQs
   AKQpghn7Bayc/0cGUHnQ+tac8vtfTRw2nOnfpfy5D2prjEQ30OiJ1jgF5
   kTYztna45Fk4Zjo4nlRcIbv0Utb4wxJwAnvUsrMuzEERz4wCSwbgQn0aI
   n9ndxu8DxKNec8Zin+FNqadfDmwxTeslp8YRkcJ3SCSF3ALFDO5DWDdA7
   A==;
X-CSE-ConnectionGUID: ds6A+CMhQ6ip5gBfsp08nA==
X-CSE-MsgGUID: 5Ujez/XxRZKGVHZ5ovQUGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="79026152"
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; 
   d="scan'208";a="79026152"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2026 03:59:19 -0700
X-CSE-ConnectionGUID: +QN8/L37T1GjFsPzxIpNnA==
X-CSE-MsgGUID: 7naftmS6S7Sda8MWZ4FJNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; 
   d="scan'208";a="220391717"
Received: from lkp-server02.sh.intel.com (HELO d7fefbca0d04) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 21 Mar 2026 03:59:16 -0700
Received: from kbuild by d7fefbca0d04 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w3u2z-000000000d7-2CY3;
	Sat, 21 Mar 2026 10:59:13 +0000
Date: Sat, 21 Mar 2026 18:59:10 +0800
From: kernel test robot <lkp@intel.com>
To: Emanuele Rocca <emanuele.rocca@arm.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] pidfds: add coredump_code field to pidfd_info
Message-ID: <202603211842.JCwUVYTI-lkp@intel.com>
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
config: i386-allnoconfig (https://download.01.org/0day-ci/archive/20260321/202603211842.JCwUVYTI-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260321/202603211842.JCwUVYTI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603211842.JCwUVYTI-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   In function 'pidfd_info',
       inlined from 'pidfd_ioctl' at fs/pidfs.c:527:10:
>> include/linux/compiler_types.h:706:45: error: call to '__compiletime_assert_410' declared with attribute error: BUILD_BUG_ON failed: sizeof(struct pidfd_info) != PIDFD_INFO_SIZE_VER3
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:687:25: note: in definition of macro '__compiletime_assert'
     687 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:706:9: note: in expansion of macro '_compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   fs/pidfs.c:350:9: note: in expansion of macro 'BUILD_BUG_ON'
     350 |         BUILD_BUG_ON(sizeof(struct pidfd_info) != PIDFD_INFO_SIZE_VER3);
         |         ^~~~~~~~~~~~


vim +/__compiletime_assert_410 +706 include/linux/compiler_types.h

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
