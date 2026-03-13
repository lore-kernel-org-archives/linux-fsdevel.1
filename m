Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804EA3909A4
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2026 12:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773403467; cv=none; b=H7iypOVAxegT0tcIzyeRTi8HPSwnmbx1OwkN7IGsu+8n1dhQJOWZuwCk+kXTHQY0u8RkJNk8dcOj8LXZcsALvLi08R1sHs6A+gL6Zip0hrEgmCIuTKE/zOgl4zjrcmW7mKpDbD4Lqz5js1oJnabnWZbgHaKEM/C3NJ69oiUU7H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773403467; c=relaxed/simple;
	bh=Vn9MKdmospXCDEw0rllXl9HCIunbJ7CLm0zvFF8ui1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdhHHBGcA9iGas2Ls/sLZzFdq+JyQ5FFBmWr4zplieM6HPlWDOGnl6Szh6oQjHgcOdr5bW03hK/Xa4VVRj16e/EQ3aj9XPu1WLvARe5B2AAG0UJsYWPKjo5Xfy6obM59+pAjMrBncsBkgbLXp2JAbLdapDGuuIrcRjCtBuH6K+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hr44b+rk; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hr44b+rk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773403457; x=1804939457;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vn9MKdmospXCDEw0rllXl9HCIunbJ7CLm0zvFF8ui1s=;
  b=Hr44b+rkXTg2yjvjljFS8XT2I927rS8ZXYuLiYKb1g8Z7ehWTmdJDsUF
   xC6R/wsHUH0iP/D4ngEUzxDO48Ezn3Zg1z46LrcgdyJKbdON3n98cdpoo
   3ujKdiBB6Rl+DNHE0zc1Q5PmveOWjCh4zjPNpC4W8bEJF5YZz9AfAwz67
   v7MGY4wKCRGlOsQILJgfzdiSDfW4Jxg5UlJ96j9cC/vSNCI73RI81wRkV
   VhIU9eYLHRKue2QOYeM9eNfibUOnoYjUR2+cKdf8ENIeoljzVFeQ6Bb3l
   3k4riscwhlKd/MW94U2T6TRTdGkJmFmodJsEszB2xKTxC6B7Sjv8AYgJh
   g==;
X-CSE-ConnectionGUID: toeJwVn8T8+w8hXzI13hig==
X-CSE-MsgGUID: R1p1wDhbQfK5C+UUhyTjRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74477032"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="74477032"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 05:04:14 -0700
X-CSE-ConnectionGUID: xFO41X7NRaq0My1mU5FAsA==
X-CSE-MsgGUID: TXxtIBCET5qcSAy5YPgqhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="246333775"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by fmviesa001.fm.intel.com with ESMTP; 13 Mar 2026 05:04:12 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w11FS-000000003eX-0A44;
	Fri, 13 Mar 2026 12:04:10 +0000
Date: Fri, 13 Mar 2026 13:03:25 +0100
From: kernel test robot <lkp@intel.com>
To: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Bernd Schubert <bernd@bsbernd.com>
Subject: Re: [PATCH v2 6/6] fuse: support FSCONFIG_SET_FD for "fd" option
Message-ID: <202603131356.P70o4OPq-lkp@intel.com>
References: <20260312194019.3077902-7-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312194019.3077902-7-mszeredi@redhat.com>

Hi Miklos,

kernel test robot noticed the following build errors:

[auto build test ERROR on mszeredi-fuse/for-next]
[also build test ERROR on linus/master v7.0-rc3 next-20260312]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Miklos-Szeredi/fuse-create-fuse_dev-on-dev-fuse-open-instead-of-mount/20260313-153922
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git for-next
patch link:    https://lore.kernel.org/r/20260312194019.3077902-7-mszeredi%40redhat.com
patch subject: [PATCH v2 6/6] fuse: support FSCONFIG_SET_FD for "fd" option
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260313/202603131356.P70o4OPq-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260313/202603131356.P70o4OPq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603131356.P70o4OPq-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/fuse/inode.c:916:2: error: cannot jump from switch statement to this case label
     916 |         default:
         |         ^
   fs/fuse/inode.c:864:16: note: jump bypasses initialization of variable with __attribute__((cleanup))
     864 |                 struct file *file __free(fput) = fget(result.uint_32);
         |                              ^
   fs/fuse/inode.c:910:2: error: cannot jump from switch statement to this case label
     910 |         case OPT_BLKSIZE:
         |         ^
   fs/fuse/inode.c:864:16: note: jump bypasses initialization of variable with __attribute__((cleanup))
     864 |                 struct file *file __free(fput) = fget(result.uint_32);
         |                              ^
   fs/fuse/inode.c:906:2: error: cannot jump from switch statement to this case label
     906 |         case OPT_MAX_READ:
         |         ^
   fs/fuse/inode.c:864:16: note: jump bypasses initialization of variable with __attribute__((cleanup))
     864 |                 struct file *file __free(fput) = fget(result.uint_32);
         |                              ^
   fs/fuse/inode.c:902:2: error: cannot jump from switch statement to this case label
     902 |         case OPT_ALLOW_OTHER:
         |         ^
   fs/fuse/inode.c:864:16: note: jump bypasses initialization of variable with __attribute__((cleanup))
     864 |                 struct file *file __free(fput) = fget(result.uint_32);
         |                              ^
   fs/fuse/inode.c:898:2: error: cannot jump from switch statement to this case label
     898 |         case OPT_DEFAULT_PERMISSIONS:
         |         ^
   fs/fuse/inode.c:864:16: note: jump bypasses initialization of variable with __attribute__((cleanup))
     864 |                 struct file *file __free(fput) = fget(result.uint_32);
         |                              ^
   fs/fuse/inode.c:886:2: error: cannot jump from switch statement to this case label
     886 |         case OPT_GROUP_ID:
         |         ^
   fs/fuse/inode.c:864:16: note: jump bypasses initialization of variable with __attribute__((cleanup))
     864 |                 struct file *file __free(fput) = fget(result.uint_32);
         |                              ^
   fs/fuse/inode.c:874:2: error: cannot jump from switch statement to this case label
     874 |         case OPT_USER_ID:
         |         ^
   fs/fuse/inode.c:864:16: note: jump bypasses initialization of variable with __attribute__((cleanup))
     864 |                 struct file *file __free(fput) = fget(result.uint_32);
         |                              ^
   fs/fuse/inode.c:867:2: error: cannot jump from switch statement to this case label
     867 |         case OPT_ROOTMODE:
         |         ^
   fs/fuse/inode.c:864:16: note: jump bypasses initialization of variable with __attribute__((cleanup))
     864 |                 struct file *file __free(fput) = fget(result.uint_32);
         |                              ^
   8 errors generated.


vim +916 fs/fuse/inode.c

510714a1f72bd3f Miklos Szeredi 2026-03-12  821  
84c215075b5723a Miklos Szeredi 2021-08-04  822  static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
d8a5ba45457e4a2 Miklos Szeredi 2005-09-09  823  {
c30da2e981a703c David Howells  2019-03-25  824  	struct fs_parse_result result;
84c215075b5723a Miklos Szeredi 2021-08-04  825  	struct fuse_fs_context *ctx = fsc->fs_private;
c30da2e981a703c David Howells  2019-03-25  826  	int opt;
525bd65aa759ec3 Eric Sandeen   2024-07-02  827  	kuid_t kuid;
525bd65aa759ec3 Eric Sandeen   2024-07-02  828  	kgid_t kgid;
c30da2e981a703c David Howells  2019-03-25  829  
84c215075b5723a Miklos Szeredi 2021-08-04  830  	if (fsc->purpose == FS_CONTEXT_FOR_RECONFIGURE) {
e8b20a474cf2c42 Miklos Szeredi 2020-07-14  831  		/*
e8b20a474cf2c42 Miklos Szeredi 2020-07-14  832  		 * Ignore options coming from mount(MS_REMOUNT) for backward
e8b20a474cf2c42 Miklos Szeredi 2020-07-14  833  		 * compatibility.
e8b20a474cf2c42 Miklos Szeredi 2020-07-14  834  		 */
84c215075b5723a Miklos Szeredi 2021-08-04  835  		if (fsc->oldapi)
e8b20a474cf2c42 Miklos Szeredi 2020-07-14  836  			return 0;
e8b20a474cf2c42 Miklos Szeredi 2020-07-14  837  
84c215075b5723a Miklos Szeredi 2021-08-04  838  		return invalfc(fsc, "No changes allowed in reconfigure");
b330966f79fb4fd Miklos Szeredi 2020-07-14  839  	}
b330966f79fb4fd Miklos Szeredi 2020-07-14  840  
84c215075b5723a Miklos Szeredi 2021-08-04  841  	opt = fs_parse(fsc, fuse_fs_parameters, param, &result);
c30da2e981a703c David Howells  2019-03-25  842  	if (opt < 0)
c30da2e981a703c David Howells  2019-03-25  843  		return opt;
c30da2e981a703c David Howells  2019-03-25  844  
c30da2e981a703c David Howells  2019-03-25  845  	switch (opt) {
c30da2e981a703c David Howells  2019-03-25  846  	case OPT_SOURCE:
84c215075b5723a Miklos Szeredi 2021-08-04  847  		if (fsc->source)
84c215075b5723a Miklos Szeredi 2021-08-04  848  			return invalfc(fsc, "Multiple sources specified");
84c215075b5723a Miklos Szeredi 2021-08-04  849  		fsc->source = param->string;
c30da2e981a703c David Howells  2019-03-25  850  		param->string = NULL;
c30da2e981a703c David Howells  2019-03-25  851  		break;
c30da2e981a703c David Howells  2019-03-25  852  
c30da2e981a703c David Howells  2019-03-25  853  	case OPT_SUBTYPE:
c30da2e981a703c David Howells  2019-03-25  854  		if (ctx->subtype)
84c215075b5723a Miklos Szeredi 2021-08-04  855  			return invalfc(fsc, "Multiple subtypes specified");
c30da2e981a703c David Howells  2019-03-25  856  		ctx->subtype = param->string;
c30da2e981a703c David Howells  2019-03-25  857  		param->string = NULL;
d8a5ba45457e4a2 Miklos Szeredi 2005-09-09  858  		return 0;
c30da2e981a703c David Howells  2019-03-25  859  
c30da2e981a703c David Howells  2019-03-25  860  	case OPT_FD:
6ad877148e563ae Miklos Szeredi 2026-03-12  861  		if (param->type == fs_value_is_file)
6ad877148e563ae Miklos Szeredi 2026-03-12  862  			return fuse_opt_fd(fsc, param->file);
6ad877148e563ae Miklos Szeredi 2026-03-12  863  
6ad877148e563ae Miklos Szeredi 2026-03-12  864  		struct file *file __free(fput) = fget(result.uint_32);
6ad877148e563ae Miklos Szeredi 2026-03-12  865  		return fuse_opt_fd(fsc, file);
d8a5ba45457e4a2 Miklos Szeredi 2005-09-09  866  
d8a5ba45457e4a2 Miklos Szeredi 2005-09-09  867  	case OPT_ROOTMODE:
c30da2e981a703c David Howells  2019-03-25  868  		if (!fuse_valid_type(result.uint_32))
84c215075b5723a Miklos Szeredi 2021-08-04  869  			return invalfc(fsc, "Invalid rootmode");
c30da2e981a703c David Howells  2019-03-25  870  		ctx->rootmode = result.uint_32;
cabdb4fa2f666fa zhengbin       2020-01-14  871  		ctx->rootmode_present = true;
d8a5ba45457e4a2 Miklos Szeredi 2005-09-09  872  		break;
d8a5ba45457e4a2 Miklos Szeredi 2005-09-09  873  
d8a5ba45457e4a2 Miklos Szeredi 2005-09-09  874  	case OPT_USER_ID:
eea6a8322efd398 Eric Sandeen   2024-07-02  875  		kuid = result.uid;
525bd65aa759ec3 Eric Sandeen   2024-07-02  876  		/*
525bd65aa759ec3 Eric Sandeen   2024-07-02  877  		 * The requested uid must be representable in the
525bd65aa759ec3 Eric Sandeen   2024-07-02  878  		 * filesystem's idmapping.
525bd65aa759ec3 Eric Sandeen   2024-07-02  879  		 */
525bd65aa759ec3 Eric Sandeen   2024-07-02  880  		if (!kuid_has_mapping(fsc->user_ns, kuid))
525bd65aa759ec3 Eric Sandeen   2024-07-02  881  			return invalfc(fsc, "Invalid user_id");
525bd65aa759ec3 Eric Sandeen   2024-07-02  882  		ctx->user_id = kuid;
cabdb4fa2f666fa zhengbin       2020-01-14  883  		ctx->user_id_present = true;
d8a5ba45457e4a2 Miklos Szeredi 2005-09-09  884  		break;
d8a5ba45457e4a2 Miklos Szeredi 2005-09-09  885  
87729a5514e855c Miklos Szeredi 2005-09-09  886  	case OPT_GROUP_ID:
eea6a8322efd398 Eric Sandeen   2024-07-02  887  		kgid = result.gid;
525bd65aa759ec3 Eric Sandeen   2024-07-02  888  		/*
525bd65aa759ec3 Eric Sandeen   2024-07-02  889  		 * The requested gid must be representable in the
525bd65aa759ec3 Eric Sandeen   2024-07-02  890  		 * filesystem's idmapping.
525bd65aa759ec3 Eric Sandeen   2024-07-02  891  		 */
525bd65aa759ec3 Eric Sandeen   2024-07-02  892  		if (!kgid_has_mapping(fsc->user_ns, kgid))
84c215075b5723a Miklos Szeredi 2021-08-04  893  			return invalfc(fsc, "Invalid group_id");
525bd65aa759ec3 Eric Sandeen   2024-07-02  894  		ctx->group_id = kgid;
cabdb4fa2f666fa zhengbin       2020-01-14  895  		ctx->group_id_present = true;
87729a5514e855c Miklos Szeredi 2005-09-09  896  		break;
87729a5514e855c Miklos Szeredi 2005-09-09  897  
1e9a4ed9396e9c3 Miklos Szeredi 2005-09-09  898  	case OPT_DEFAULT_PERMISSIONS:
cabdb4fa2f666fa zhengbin       2020-01-14  899  		ctx->default_permissions = true;
1e9a4ed9396e9c3 Miklos Szeredi 2005-09-09  900  		break;
1e9a4ed9396e9c3 Miklos Szeredi 2005-09-09  901  
1e9a4ed9396e9c3 Miklos Szeredi 2005-09-09  902  	case OPT_ALLOW_OTHER:
cabdb4fa2f666fa zhengbin       2020-01-14  903  		ctx->allow_other = true;
1e9a4ed9396e9c3 Miklos Szeredi 2005-09-09  904  		break;
1e9a4ed9396e9c3 Miklos Szeredi 2005-09-09  905  
db50b96c0f28a21 Miklos Szeredi 2005-09-09  906  	case OPT_MAX_READ:
c30da2e981a703c David Howells  2019-03-25  907  		ctx->max_read = result.uint_32;
db50b96c0f28a21 Miklos Szeredi 2005-09-09  908  		break;
db50b96c0f28a21 Miklos Szeredi 2005-09-09  909  
d809161402e9f99 Miklos Szeredi 2006-12-06  910  	case OPT_BLKSIZE:
c30da2e981a703c David Howells  2019-03-25  911  		if (!ctx->is_bdev)
84c215075b5723a Miklos Szeredi 2021-08-04  912  			return invalfc(fsc, "blksize only supported for fuseblk");
c30da2e981a703c David Howells  2019-03-25  913  		ctx->blksize = result.uint_32;
d809161402e9f99 Miklos Szeredi 2006-12-06  914  		break;
d809161402e9f99 Miklos Szeredi 2006-12-06  915  
d8a5ba45457e4a2 Miklos Szeredi 2005-09-09 @916  	default:
c30da2e981a703c David Howells  2019-03-25  917  		return -EINVAL;
d8a5ba45457e4a2 Miklos Szeredi 2005-09-09  918  	}
5a53368277efa2d Miklos Szeredi 2005-09-09  919  
d8a5ba45457e4a2 Miklos Szeredi 2005-09-09  920  	return 0;
c30da2e981a703c David Howells  2019-03-25  921  }
d8a5ba45457e4a2 Miklos Szeredi 2005-09-09  922  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
