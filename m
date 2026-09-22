Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0AA42125D;
	Tue, 22 Sep 2026 17:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790099158; cv=none; b=CN8KGjuMxNn+OHtSAETzFFQFVbxvjAcLIcxXr+UTcAsqO/wXZWKDt7fwxSzEKfDt33aymLPXo+6n1hhgKCScIiYp1+GNnbTRFwaNzLq1q8TbLg0/oy1izGn8BTq2lGupEORCabbM5hx2Bd6v168XCrUB+tgQkctGDDUil9I3xms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790099158; c=relaxed/simple;
	bh=numKCXBeqHeG+uwpRgzAc5A+25vCr6moZaFphK8rbZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRSqWSK0bkWIoGd33ZRyxBCd5n58VmSfxrJFeXm9oqsTUqjX1ljl6+bO5flBGm+He/W4S+ljYezFB1W1wEjme26x2nU+rMJCVwJs+spjxDBLmx63COHvyAj+VeftRJN8N6eKNCKJiwgSnMA3NMKXbpjK7sXxutJOPKbfLUyYD00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I+irRMrH; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I+irRMrH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790099156; x=1821635156;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=numKCXBeqHeG+uwpRgzAc5A+25vCr6moZaFphK8rbZs=;
  b=I+irRMrHo6yl/XIC1NICKhOZYKH7j+E74DGNJXyLqmISwF/9rHerK+vF
   pzLaejsmTkAXsuvA9EuHoy1X6QJNDDLeP64tybuVCB7NEYgpp5P1FSEUd
   U0Qmg0K8Gh87zJ8rqxxVSun0brrx2P51bKyjgiGliVz5yHMDPzlG6QPrq
   wHbv1a/cm8f0OJCwsVyvWI8MhoRudmxBm/ogerYCVrMpkT9iXRvxeFw9P
   FGSU0k5LYRkCkFXxfV3d5c7myy6irPZCfPd1fIVcJHxX04wvNbUIFfhda
   2YfWDWBWEqL4EaGY7JZyio0fbAZwrdvHEdZ57QsGEschChE4KcdDKBzJn
   g==;
X-CSE-ConnectionGUID: wtSHGwuhRry0bIm0rUYynw==
X-CSE-MsgGUID: IvIQRLEQSTKoa4Y95SZbuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="89644761"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="89644761"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 10:45:41 -0700
X-CSE-ConnectionGUID: Ej7Auh4YTcqXqdy+EW+XIw==
X-CSE-MsgGUID: GI1CwLDCQAahT0U6/zoRPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="301133553"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 22 Sep 2026 10:45:39 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x94Yi-00000000Fpq-24vQ;
	Tue, 22 Sep 2026 17:45:36 +0000
Date: Wed, 23 Sep 2026 01:45:12 +0800
From: kernel test robot <lkp@intel.com>
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: oe-kbuild-all@lists.linux.dev,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+f8ce6c197125ab9d72ce@syzkaller.appspotmail.com,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Subject: Re: [PATCH v6] hfsplus: validate b-tree fork extents at mount and
 inode read
Message-ID: <202609230123.7x3OfA7z-lkp@intel.com>
References: <20260918085156.920842-1-ngocthang2710.1999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918085156.920842-1-ngocthang2710.1999@gmail.com>

Hi Nguyen,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on linus/master v7.3-rc4 next-20260921]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nguyen-Ngoc-Thang/hfsplus-validate-b-tree-fork-extents-at-mount-and-inode-read/20260918-155156
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20260918085156.920842-1-ngocthang2710.1999%40gmail.com
patch subject: [PATCH v6] hfsplus: validate b-tree fork extents at mount and inode read
config: sparc64-randconfig-1000-20260922 (https://download.01.org/0day-ci/archive/20260923/202609230123.7x3OfA7z-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260923/202609230123.7x3OfA7z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609230123.7x3OfA7z-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/hfsplus/inode.c:562:5: error: conflicting types for 'hfsplus_inode_read_fork'; have 'int(struct inode *, struct hfsplus_fork_raw *)'
     562 | int hfsplus_inode_read_fork(struct inode *inode, struct hfsplus_fork_raw *fork)
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from fs/hfsplus/inode.c:22:
   fs/hfsplus/hfsplus_fs.h:456:6: note: previous declaration of 'hfsplus_inode_read_fork' with type 'void(struct inode *, struct hfsplus_fork_raw *)'
     456 | void hfsplus_inode_read_fork(struct inode *inode,
         |      ^~~~~~~~~~~~~~~~~~~~~~~
   fs/hfsplus/inode.c: In function 'hfsplus_inode_read_fork':
   fs/hfsplus/inode.c:571:11: error: implicit declaration of function 'hfsplus_check_fork'; did you mean 'hfsplus_free_fork'? [-Wimplicit-function-declaration]
     571 |     ret = hfsplus_check_fork(sb, fork->extents, sbi->total_blocks);
         |           ^~~~~~~~~~~~~~~~~~
         |           hfsplus_free_fork
   In file included from include/asm-generic/bug.h:31,
                    from arch/sparc/include/asm/bug.h:25,
                    from include/linux/bug.h:5,
                    from include/linux/instrumented.h:10,
                    from include/linux/atomic/atomic-instrumented.h:17,
                    from include/linux/atomic.h:82,
                    from include/asm-generic/bitops/lock.h:5,
                    from arch/sparc/include/asm/bitops_64.h:52,
                    from arch/sparc/include/asm/bitops.h:5,
                    from include/linux/bitops.h:67,
                    from include/linux/bitmap.h:8,
                    from include/linux/nodemask.h:91,
                    from include/linux/list_lru.h:12,
                    from include/linux/fs/super_types.h:7,
                    from include/linux/fs/super.h:5,
                    from include/linux/fs.h:5,
                    from include/linux/highmem.h:5,
                    from include/linux/bvec.h:10,
                    from include/linux/blk_types.h:10,
                    from include/linux/blkdev.h:9,
                    from fs/hfsplus/inode.c:12:
   include/linux/kern_levels.h:5:25: warning: format '%lu' expects argument of type 'long unsigned int', but argument 2 has type 'u64' {aka 'long long unsigned int'} [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:483:25: note: in definition of macro 'printk_index_wrap'
     483 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:554:9: note: in expansion of macro 'printk'
     554 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/kern_levels.h:11:25: note: in expansion of macro 'KERN_SOH'
      11 | #define KERN_ERR        KERN_SOH "3"    /* error conditions */
         |                         ^~~~~~~~
   include/linux/printk.h:554:16: note: in expansion of macro 'KERN_ERR'
     554 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |                ^~~~~~~~
   fs/hfsplus/inode.c:573:9: note: in expansion of macro 'pr_err'
     573 |         pr_err("hfsplus: fork check failed for inode %lu (err=%d)\n", inode->i_ino, ret);
         |         ^~~~~~
   fs/hfsplus/inode.c:574:17: error: 'HFSPLUS_I_CORRUPT_TREE' undeclared (first use in this function)
     574 |         set_bit(HFSPLUS_I_CORRUPT_TREE, &hip->flags);
         |                 ^~~~~~~~~~~~~~~~~~~~~~
   fs/hfsplus/inode.c:574:17: note: each undeclared identifier is reported only once for each function it appears in
   fs/hfsplus/inode.c:580:33: error: 'HFSPLUS_EXTENT_LAST_IDX' undeclared (first use in this function)
     580 |     for (count = 0, i = 0; i <= HFSPLUS_EXTENT_LAST_IDX; i++)
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~


vim +562 fs/hfsplus/inode.c

   561	
 > 562	int hfsplus_inode_read_fork(struct inode *inode, struct hfsplus_fork_raw *fork)
   563	{
   564	    struct super_block *sb = inode->i_sb;
   565	    struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
   566	    struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
   567	    u32 count;
   568	    int i, ret;
   569	
   570	    /* Validate fork extents to catch on-disk corruption early */
   571	    ret = hfsplus_check_fork(sb, fork->extents, sbi->total_blocks);
   572	    if (ret) {
   573		pr_err("hfsplus: fork check failed for inode %lu (err=%d)\n", inode->i_ino, ret);
   574		set_bit(HFSPLUS_I_CORRUPT_TREE, &hip->flags);
   575		sb->s_flags |= SB_RDONLY;
   576		return ret; /* Return error directly to the caller */
   577	    }
   578	
   579	    memcpy(&hip->first_extents, &fork->extents, sizeof(hfsplus_extent_rec));
   580	    for (count = 0, i = 0; i <= HFSPLUS_EXTENT_LAST_IDX; i++)
   581		count += be32_to_cpu(fork->extents[i].block_count);
   582	    hip->first_blocks = count;
   583	    memset(hip->cached_extents, 0, sizeof(hfsplus_extent_rec));
   584	    hip->cached_start = 0;
   585	    hip->cached_blocks = 0;
   586	
   587	    hip->alloc_blocks = be32_to_cpu(fork->total_blocks);
   588	    hip->phys_size = inode->i_size = be64_to_cpu(fork->total_size);
   589	    hip->fs_blocks =
   590		(inode->i_size + sb->s_blocksize - 1) >> sb->s_blocksize_bits;
   591	    inode_set_bytes(inode, hip->fs_blocks << sb->s_blocksize_bits);
   592	    hip->clump_blocks =
   593		be32_to_cpu(fork->clump_size) >> sbi->alloc_blksz_shift;
   594	    if (!hip->clump_blocks) {
   595		hip->clump_blocks = HFSPLUS_IS_RSRC(inode) ?
   596		    sbi->rsrc_clump_blocks :
   597		    sbi->data_clump_blocks;
   598	    }
   599	
   600	    return 0;
   601	}
   602	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
