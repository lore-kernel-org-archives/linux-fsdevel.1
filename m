Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695833AE1AF
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Aug 2026 20:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785790217; cv=none; b=cuBDpnDhLeOeColo4pE9XZf0kHRlum5jChSxNPIqL811tnE34bzAhdG3yrB42HYDP5foRzICRVtspB1+xc22IDuJYHJi3TziXkygTBY/GBmnWDHfCJG2QtAND3J/A+irlcnR+CsSN7zSNsBoAIqafjCXcANZ38vnc64FMtJui7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785790217; c=relaxed/simple;
	bh=zw0jw+MmhJGVFhtB4L36YUou+bvgYnqyzVL349oNL2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QD9ZWbN5DNi1/PQslS87WkF5UIN/LBqYun/ZBxItWCTFZM+wFBxdzxm4qmGqelZYuUACX5saGD8iPVuGUsJONzuJVXOOr5zV/nRRGi5rcmuKJUKoaLpEFeRRt5oMpRZFmZwLPPzyoWX7hqB1AUB7mq5SjUt+ScwG2WTYJr30gHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jxRS5BHL; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jxRS5BHL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785790216; x=1817326216;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zw0jw+MmhJGVFhtB4L36YUou+bvgYnqyzVL349oNL2c=;
  b=jxRS5BHLenJDGvlrdQMxdgTUfJKYJRNuT0BZcigV34HLLa+aNdUKSPlA
   YzZW0wkUaclGK0H6UvnCDTkHYcrd3R7LT6LUprFPxGiAQIyJqAJbfgDGa
   miURPmOUkmFdBlZyclye4mhqgo4pPkSkUJj2Y0kiIXw/lyq8W0Dibk7Hs
   NF9UhBMcH4htqrCxNhC/PAjNYD/9wDY0uQS0F93F8vHvgkAsD1s1g6ouS
   s09oUJr1F030yX5lT56kzaasGYYeeB4zaOkDZfheHoBz22V3enqY8iKLN
   05KGHvG1JbbpEviJJtSqkGyuw71OFsCzYYzTg7nZblWdfssne7LPZm6DE
   g==;
X-CSE-ConnectionGUID: o2a7XwN0SEyP/xfBzJr5vA==
X-CSE-MsgGUID: Z8jgl9qsSFWz7Y3qlsTOZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="111892062"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="111892062"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 13:50:15 -0700
X-CSE-ConnectionGUID: l/m9YQ+STkukDebFA6p/tA==
X-CSE-MsgGUID: gsVFvw7DRbCc9ZAFZyqcAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="260717370"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 03 Aug 2026 13:50:09 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wqzbp-000000007xd-3ABe;
	Mon, 03 Aug 2026 20:50:05 +0000
Date: Tue, 4 Aug 2026 04:49:16 +0800
From: kernel test robot <lkp@intel.com>
To: Xin Zhao <jackzxcui1989@163.com>, brauner@kernel.org, ljs@kernel.org,
	rppt@kernel.org, pfalcato@suse.de, viro@zeniv.linux.org.uk,
	corbet@lwn.net, skhan@linuxfoundation.org,
	akpm@linux-foundation.org, liam@infradead.org, david@kernel.org,
	vbabka@kernel.org, surenb@google.com, mhocko@suse.com,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, mjguzik@gmail.com,
	ebiederm@xmission.com, jack@suse.cz, jlayton@kernel.org,
	chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de,
	keescook@chromium.org, mcgrof@kernel.org, j.granados@samsung.com,
	allen.lkml@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, kuba@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5] coredump: Add bit 9 of coredump_filter for pre-exit
 files before dumping
Message-ID: <202608040457.QGCptUZD-lkp@intel.com>
References: <20260630075604.52533-1-jackzxcui1989@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630075604.52533-1-jackzxcui1989@163.com>

Hi Xin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brauner-vfs/vfs.all]
[also build test WARNING on akpm-mm/mm-everything linus/master v7.2-rc6 next-20260803]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xin-Zhao/coredump-Add-bit-9-of-coredump_filter-for-pre-exit-files-before-dumping/20260804-021808
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20260630075604.52533-1-jackzxcui1989%40163.com
patch subject: [PATCH v5] coredump: Add bit 9 of coredump_filter for pre-exit files before dumping
config: alpha-allmodconfig (https://download.01.org/0day-ci/archive/20260804/202608040457.QGCptUZD-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260804/202608040457.QGCptUZD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608040457.QGCptUZD-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/array_size.h:5,
                    from include/linux/string.h:6,
                    from fs/file_table.c:9:
   fs/file_table.c: In function '__fput_deferred':
>> fs/file_table.c:576:53: warning: suggest parentheses around arithmetic in operand of '|' [-Wparentheses]
     576 |         if (likely(!in_interrupt() && !(task->flags & PF_KTHREAD | PF_DUMPCORE))) {
   include/linux/compiler.h:76:45: note: in definition of macro 'likely'
      76 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^


vim +576 fs/file_table.c

   561	
   562	static void __fput_deferred(struct file *file)
   563	{
   564		struct task_struct *task = current;
   565	
   566		if (unlikely(!(file->f_mode & (FMODE_BACKING | FMODE_OPENED)))) {
   567			file_free(file);
   568			return;
   569		}
   570	
   571		/*
   572		 * coredump_pre_exit() may release files before dumping core.
   573		 * Cannot use task_work in the case, needs to release files
   574		 * earlier."
   575		 */
 > 576		if (likely(!in_interrupt() && !(task->flags & PF_KTHREAD | PF_DUMPCORE))) {
   577			init_task_work(&file->f_task_work, ____fput);
   578			if (!task_work_add(task, &file->f_task_work, TWA_RESUME))
   579				return;
   580			/*
   581			 * After this task has run exit_task_work(),
   582			 * task_work_add() will fail.  Fall through to delayed
   583			 * fput to avoid leaking *file.
   584			 */
   585		}
   586	
   587		if (llist_add(&file->f_llist, &delayed_fput_list))
   588			schedule_delayed_work(&delayed_fput_work, 1);
   589	}
   590	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
