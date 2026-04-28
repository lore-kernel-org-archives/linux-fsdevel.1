Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41A93D410C;
	Tue, 28 Apr 2026 08:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777364324; cv=none; b=fiW+n6j0FWhCYX2vnBsiO/AU7YYPicE//heezHMUdfu7w0apYUPHKGgL3ZO3XrC4d4E8pIHxvJ+Gk5h+nbt07es5yDa4RAZ0ujt0Blu4lQ1bW+lya1GpCsILqpPv/INVq5hArOEdzdURGM19oE8VmhyeZMn75LJMcXLk4kf7Tok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777364324; c=relaxed/simple;
	bh=Pifngnls7yzoEeGxFyOD4KN5JPXem2G0mv34DhxL2U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIGXKZnetv2hunI1l2fFARZ/Z9UVD32velKq/DYiU88Uo+yRaK6oI/C//bs/ghc+SHef/w6Bscz1mbnXv34YNQZ9cdjfPHgmU1UVWKz4GEFlkKEWLB0JhVquTypE46Mp4CIJYJHoXiUoKHRCWNvYMRQokadLhjUBWHhTWfi/BSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hm3p1uM1; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hm3p1uM1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777364323; x=1808900323;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Pifngnls7yzoEeGxFyOD4KN5JPXem2G0mv34DhxL2U4=;
  b=Hm3p1uM1+tvfRNCsy0Uq0I9ke6UaxYWA7xZz+nFchpcuaLASgIJFyc+Y
   AdyIBxO5sXM3D9z01lwGfX8s+3gYSpkMnKCEL1tCmEXaCgW4mWWBjYNkk
   R3cTxLnrlMJLQkF1DHrFpMgefOKyKCibJ0tDzJ2iziWD9qorpCUDgLqPU
   74LcNaY+ZLE+8RILxqx8TfRukHmAP/ILNQ7njwmZwh207gXswMTGP8iWZ
   h6e7DbZQZFqy1Pb/E2VezrneWM58djLL71K/bWgVZXvAN7zxUmRUs16/J
   oYhE7dVHGSTA343CEbBCIbhl339dfXCjZ4daqGL2kEFp8KvfBJHe/zoVd
   w==;
X-CSE-ConnectionGUID: t9cZ2wxETYGCFdC6ZVYaVQ==
X-CSE-MsgGUID: Lbpyce14QCKja7QDSkw7lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="89646037"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="89646037"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 01:18:42 -0700
X-CSE-ConnectionGUID: fZiFiA1hTKiicJQRYZmMvQ==
X-CSE-MsgGUID: 2F5PYIEZSF+KN/QYJ3BUQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="264273755"
Received: from lkp-server01.sh.intel.com (HELO aa799cca880d) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 28 Apr 2026 01:18:41 -0700
Received: from kbuild by aa799cca880d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wHdeP-000000009eS-2hEf;
	Tue, 28 Apr 2026 08:18:37 +0000
Date: Tue, 28 Apr 2026 16:17:37 +0800
From: kernel test robot <lkp@intel.com>
To: Matan Cohen <matan@matanco.space>, Miklos Szeredi <miklos@szeredi.hu>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Matan Cohen <matan@matanco.space>
Subject: Re: [PATCH] fuse: expose backing files in the daemon's fd table
Message-ID: <202604281646.PF70aaEU-lkp@intel.com>
References: <20260424144553.6241-1-matan@matanco.space>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424144553.6241-1-matan@matanco.space>

Hi Matan,

kernel test robot noticed the following build errors:

[auto build test ERROR on v7.0]
[also build test ERROR on linus/master next-20260427]
[cannot apply to mszeredi-fuse/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Matan-Cohen/fuse-expose-backing-files-in-the-daemon-s-fd-table/20260426-193147
base:   v7.0
patch link:    https://lore.kernel.org/r/20260424144553.6241-1-matan%40matanco.space
patch subject: [PATCH] fuse: expose backing files in the daemon's fd table
config: nios2-allmodconfig (https://download.01.org/0day-ci/archive/20260428/202604281646.PF70aaEU-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260428/202604281646.PF70aaEU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604281646.PF70aaEU-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "task_work_add" [fs/fuse/fuse.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
