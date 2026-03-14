Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25171225416
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Mar 2026 17:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773508981; cv=none; b=Y2YrUj5oIVIiq1QfFAxQovKub+bEkHDv6dgizPm+sW3QfhPLbWtf/QGGYkBFc83CpefTpgIVghAZhbA6x6kUCSLXist7QJcwAKbNDY+vK6gfMAYn+BcQhgQyBM0O30EZT4ilRCLmfKh/iziVrKoIT4Z4X0PqyiFKk3DJXm6tenc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773508981; c=relaxed/simple;
	bh=jeyxYf3mt+Ucm3D6AF7nus1qEg0DBuTv18+YxdDOnUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lT29OWe98r3Z3+J0QX4Qgy0CAup7UJbFpvt/OIk98MIL4yuQCvXARBfjAut27iMhxrc+u14457lH8kXr1XlyAavkEky2b3Lxfiv5rhxIGdxYGUnbkvoXorhsU/TtZXUfYCrSO9TNcUodhd3EM9BoY0ffUtyxeW24XLJM9ldA2ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KL1OINN0; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KL1OINN0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773508979; x=1805044979;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jeyxYf3mt+Ucm3D6AF7nus1qEg0DBuTv18+YxdDOnUk=;
  b=KL1OINN0mBQ9abNu+8QLSUCiggRGT1FUdyTqZlh/E6HY3pfHUT3iOFHF
   babpkf9taOYAEFp2PTaDVVSRPAZZh/cVj962VHv95uaoxtdPZezPsY7Qr
   QFBI+xr2bSk159glHNDB65D0RUsAVNzJkEeDx5f5cK5rSOLwfm8fEeB6P
   7AsUkD/2Ntuf9EyngOZTGau2BPln0aKk3oOHEyoJrPSKlgTJ2rJNwdbxq
   A7DpsRrUsPuf9c5xp1VxrB3xMhmKswc8AytIhu2R5jI/xvcplIjaN6Bll
   QhfcUGGaqIxBkTthTi1PtUEQ3O4B4URKBSJg6q52LwUk0uwInstxYiuIx
   Q==;
X-CSE-ConnectionGUID: GmsLeOshQlecRBuEomrV2g==
X-CSE-MsgGUID: uppUSmweSUizcjpKYN9VHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11729"; a="74703918"
X-IronPort-AV: E=Sophos;i="6.23,119,1770624000"; 
   d="scan'208";a="74703918"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2026 10:22:58 -0700
X-CSE-ConnectionGUID: 70ThAylcRh+B5zvGlUOleg==
X-CSE-MsgGUID: PcC8nIOSRoiKn6LdhojAhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,119,1770624000"; 
   d="scan'208";a="221426618"
Received: from lkp-server01.sh.intel.com (HELO 418530b1a366) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 14 Mar 2026 10:22:57 -0700
Received: from kbuild by 418530b1a366 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w1ShS-000000005RX-0J0U;
	Sat, 14 Mar 2026 17:22:54 +0000
Date: Sun, 15 Mar 2026 01:22:35 +0800
From: kernel test robot <lkp@intel.com>
To: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Bernd Schubert <bernd@bsbernd.com>
Subject: Re: [PATCH v2 6/6] fuse: support FSCONFIG_SET_FD for "fd" option
Message-ID: <202603150134.fG997K63-lkp@intel.com>
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
[also build test ERROR on linus/master v7.0-rc3 next-20260311]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Miklos-Szeredi/fuse-create-fuse_dev-on-dev-fuse-open-instead-of-mount/20260313-153922
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git for-next
patch link:    https://lore.kernel.org/r/20260312194019.3077902-7-mszeredi%40redhat.com
patch subject: [PATCH v2 6/6] fuse: support FSCONFIG_SET_FD for "fd" option
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20260315/202603150134.fG997K63-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260315/202603150134.fG997K63-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603150134.fG997K63-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/fuse/inode.c:916:2: error: cannot jump from switch statement to this case label
           default:
           ^
   fs/fuse/inode.c:864:16: note: jump bypasses initialization of variable with __attribute__((cleanup))
                   struct file *file __free(fput) = fget(result.uint_32);
                                ^
   fs/fuse/inode.c:910:2: error: cannot jump from switch statement to this case label
           case OPT_BLKSIZE:
           ^
   fs/fuse/inode.c:864:16: note: jump bypasses initialization of variable with __attribute__((cleanup))
                   struct file *file __free(fput) = fget(result.uint_32);
                                ^
   fs/fuse/inode.c:906:2: error: cannot jump from switch statement to this case label
           case OPT_MAX_READ:
           ^
   fs/fuse/inode.c:864:16: note: jump bypasses initialization of variable with __attribute__((cleanup))
                   struct file *file __free(fput) = fget(result.uint_32);
                                ^
   fs/fuse/inode.c:902:2: error: cannot jump from switch statement to this case label
           case OPT_ALLOW_OTHER:
           ^
   fs/fuse/inode.c:864:16: note: jump bypasses initialization of variable with __attribute__((cleanup))
                   struct file *file __free(fput) = fget(result.uint_32);
                                ^
   fs/fuse/inode.c:898:2: error: cannot jump from switch statement to this case label
           case OPT_DEFAULT_PERMISSIONS:
           ^
   fs/fuse/inode.c:864:16: note: jump bypasses initialization of variable with __attribute__((cleanup))
                   struct file *file __free(fput) = fget(result.uint_32);
                                ^
   fs/fuse/inode.c:886:2: error: cannot jump from switch statement to this case label
           case OPT_GROUP_ID:
           ^
   fs/fuse/inode.c:864:16: note: jump bypasses initialization of variable with __attribute__((cleanup))
                   struct file *file __free(fput) = fget(result.uint_32);
                                ^
   fs/fuse/inode.c:874:2: error: cannot jump from switch statement to this case label
           case OPT_USER_ID:
           ^
   fs/fuse/inode.c:864:16: note: jump bypasses initialization of variable with __attribute__((cleanup))
                   struct file *file __free(fput) = fget(result.uint_32);
                                ^
   fs/fuse/inode.c:867:2: error: cannot jump from switch statement to this case label
           case OPT_ROOTMODE:
           ^
   fs/fuse/inode.c:864:16: note: jump bypasses initialization of variable with __attribute__((cleanup))
                   struct file *file __free(fput) = fget(result.uint_32);
                                ^
   8 errors generated.


vim +916 fs/fuse/inode.c

510714a1f72bd3 Miklos Szeredi 2026-03-12  821  
84c215075b5723 Miklos Szeredi 2021-08-04  822  static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
d8a5ba45457e4a Miklos Szeredi 2005-09-09  823  {
c30da2e981a703 David Howells  2019-03-25  824  	struct fs_parse_result result;
84c215075b5723 Miklos Szeredi 2021-08-04  825  	struct fuse_fs_context *ctx = fsc->fs_private;
c30da2e981a703 David Howells  2019-03-25  826  	int opt;
525bd65aa759ec Eric Sandeen   2024-07-02  827  	kuid_t kuid;
525bd65aa759ec Eric Sandeen   2024-07-02  828  	kgid_t kgid;
c30da2e981a703 David Howells  2019-03-25  829  
84c215075b5723 Miklos Szeredi 2021-08-04  830  	if (fsc->purpose == FS_CONTEXT_FOR_RECONFIGURE) {
e8b20a474cf2c4 Miklos Szeredi 2020-07-14  831  		/*
e8b20a474cf2c4 Miklos Szeredi 2020-07-14  832  		 * Ignore options coming from mount(MS_REMOUNT) for backward
e8b20a474cf2c4 Miklos Szeredi 2020-07-14  833  		 * compatibility.
e8b20a474cf2c4 Miklos Szeredi 2020-07-14  834  		 */
84c215075b5723 Miklos Szeredi 2021-08-04  835  		if (fsc->oldapi)
e8b20a474cf2c4 Miklos Szeredi 2020-07-14  836  			return 0;
e8b20a474cf2c4 Miklos Szeredi 2020-07-14  837  
84c215075b5723 Miklos Szeredi 2021-08-04  838  		return invalfc(fsc, "No changes allowed in reconfigure");
b330966f79fb4f Miklos Szeredi 2020-07-14  839  	}
b330966f79fb4f Miklos Szeredi 2020-07-14  840  
84c215075b5723 Miklos Szeredi 2021-08-04  841  	opt = fs_parse(fsc, fuse_fs_parameters, param, &result);
c30da2e981a703 David Howells  2019-03-25  842  	if (opt < 0)
c30da2e981a703 David Howells  2019-03-25  843  		return opt;
c30da2e981a703 David Howells  2019-03-25  844  
c30da2e981a703 David Howells  2019-03-25  845  	switch (opt) {
c30da2e981a703 David Howells  2019-03-25  846  	case OPT_SOURCE:
84c215075b5723 Miklos Szeredi 2021-08-04  847  		if (fsc->source)
84c215075b5723 Miklos Szeredi 2021-08-04  848  			return invalfc(fsc, "Multiple sources specified");
84c215075b5723 Miklos Szeredi 2021-08-04  849  		fsc->source = param->string;
c30da2e981a703 David Howells  2019-03-25  850  		param->string = NULL;
c30da2e981a703 David Howells  2019-03-25  851  		break;
c30da2e981a703 David Howells  2019-03-25  852  
c30da2e981a703 David Howells  2019-03-25  853  	case OPT_SUBTYPE:
c30da2e981a703 David Howells  2019-03-25  854  		if (ctx->subtype)
84c215075b5723 Miklos Szeredi 2021-08-04  855  			return invalfc(fsc, "Multiple subtypes specified");
c30da2e981a703 David Howells  2019-03-25  856  		ctx->subtype = param->string;
c30da2e981a703 David Howells  2019-03-25  857  		param->string = NULL;
d8a5ba45457e4a Miklos Szeredi 2005-09-09  858  		return 0;
c30da2e981a703 David Howells  2019-03-25  859  
c30da2e981a703 David Howells  2019-03-25  860  	case OPT_FD:
6ad877148e563a Miklos Szeredi 2026-03-12  861  		if (param->type == fs_value_is_file)
6ad877148e563a Miklos Szeredi 2026-03-12  862  			return fuse_opt_fd(fsc, param->file);
6ad877148e563a Miklos Szeredi 2026-03-12  863  
6ad877148e563a Miklos Szeredi 2026-03-12  864  		struct file *file __free(fput) = fget(result.uint_32);
6ad877148e563a Miklos Szeredi 2026-03-12  865  		return fuse_opt_fd(fsc, file);
d8a5ba45457e4a Miklos Szeredi 2005-09-09  866  
d8a5ba45457e4a Miklos Szeredi 2005-09-09  867  	case OPT_ROOTMODE:
c30da2e981a703 David Howells  2019-03-25  868  		if (!fuse_valid_type(result.uint_32))
84c215075b5723 Miklos Szeredi 2021-08-04  869  			return invalfc(fsc, "Invalid rootmode");
c30da2e981a703 David Howells  2019-03-25  870  		ctx->rootmode = result.uint_32;
cabdb4fa2f666f zhengbin       2020-01-14  871  		ctx->rootmode_present = true;
d8a5ba45457e4a Miklos Szeredi 2005-09-09  872  		break;
d8a5ba45457e4a Miklos Szeredi 2005-09-09  873  
d8a5ba45457e4a Miklos Szeredi 2005-09-09  874  	case OPT_USER_ID:
eea6a8322efd39 Eric Sandeen   2024-07-02  875  		kuid = result.uid;
525bd65aa759ec Eric Sandeen   2024-07-02  876  		/*
525bd65aa759ec Eric Sandeen   2024-07-02  877  		 * The requested uid must be representable in the
525bd65aa759ec Eric Sandeen   2024-07-02  878  		 * filesystem's idmapping.
525bd65aa759ec Eric Sandeen   2024-07-02  879  		 */
525bd65aa759ec Eric Sandeen   2024-07-02  880  		if (!kuid_has_mapping(fsc->user_ns, kuid))
525bd65aa759ec Eric Sandeen   2024-07-02  881  			return invalfc(fsc, "Invalid user_id");
525bd65aa759ec Eric Sandeen   2024-07-02  882  		ctx->user_id = kuid;
cabdb4fa2f666f zhengbin       2020-01-14  883  		ctx->user_id_present = true;
d8a5ba45457e4a Miklos Szeredi 2005-09-09  884  		break;
d8a5ba45457e4a Miklos Szeredi 2005-09-09  885  
87729a5514e855 Miklos Szeredi 2005-09-09  886  	case OPT_GROUP_ID:
eea6a8322efd39 Eric Sandeen   2024-07-02  887  		kgid = result.gid;
525bd65aa759ec Eric Sandeen   2024-07-02  888  		/*
525bd65aa759ec Eric Sandeen   2024-07-02  889  		 * The requested gid must be representable in the
525bd65aa759ec Eric Sandeen   2024-07-02  890  		 * filesystem's idmapping.
525bd65aa759ec Eric Sandeen   2024-07-02  891  		 */
525bd65aa759ec Eric Sandeen   2024-07-02  892  		if (!kgid_has_mapping(fsc->user_ns, kgid))
84c215075b5723 Miklos Szeredi 2021-08-04  893  			return invalfc(fsc, "Invalid group_id");
525bd65aa759ec Eric Sandeen   2024-07-02  894  		ctx->group_id = kgid;
cabdb4fa2f666f zhengbin       2020-01-14  895  		ctx->group_id_present = true;
87729a5514e855 Miklos Szeredi 2005-09-09  896  		break;
87729a5514e855 Miklos Szeredi 2005-09-09  897  
1e9a4ed9396e9c Miklos Szeredi 2005-09-09  898  	case OPT_DEFAULT_PERMISSIONS:
cabdb4fa2f666f zhengbin       2020-01-14  899  		ctx->default_permissions = true;
1e9a4ed9396e9c Miklos Szeredi 2005-09-09  900  		break;
1e9a4ed9396e9c Miklos Szeredi 2005-09-09  901  
1e9a4ed9396e9c Miklos Szeredi 2005-09-09  902  	case OPT_ALLOW_OTHER:
cabdb4fa2f666f zhengbin       2020-01-14  903  		ctx->allow_other = true;
1e9a4ed9396e9c Miklos Szeredi 2005-09-09  904  		break;
1e9a4ed9396e9c Miklos Szeredi 2005-09-09  905  
db50b96c0f28a2 Miklos Szeredi 2005-09-09  906  	case OPT_MAX_READ:
c30da2e981a703 David Howells  2019-03-25  907  		ctx->max_read = result.uint_32;
db50b96c0f28a2 Miklos Szeredi 2005-09-09  908  		break;
db50b96c0f28a2 Miklos Szeredi 2005-09-09  909  
d809161402e9f9 Miklos Szeredi 2006-12-06  910  	case OPT_BLKSIZE:
c30da2e981a703 David Howells  2019-03-25  911  		if (!ctx->is_bdev)
84c215075b5723 Miklos Szeredi 2021-08-04  912  			return invalfc(fsc, "blksize only supported for fuseblk");
c30da2e981a703 David Howells  2019-03-25  913  		ctx->blksize = result.uint_32;
d809161402e9f9 Miklos Szeredi 2006-12-06  914  		break;
d809161402e9f9 Miklos Szeredi 2006-12-06  915  
d8a5ba45457e4a Miklos Szeredi 2005-09-09 @916  	default:
c30da2e981a703 David Howells  2019-03-25  917  		return -EINVAL;
d8a5ba45457e4a Miklos Szeredi 2005-09-09  918  	}
5a53368277efa2 Miklos Szeredi 2005-09-09  919  
d8a5ba45457e4a Miklos Szeredi 2005-09-09  920  	return 0;
c30da2e981a703 David Howells  2019-03-25  921  }
d8a5ba45457e4a Miklos Szeredi 2005-09-09  922  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
