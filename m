Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795751562;
	b=voN4mg3hwiq5fSyE9KRaa7VOHAJ1Uy1VaKudbfxZzLvlvsCVAclz4V6vofU8ktHvxwF0
	 SNcHB0H9SJ1G/FbyJPlWklkCP1BvHrRtWrKZ2YqxzZgkNGc+Rqa/+TQC9x6Kd1gUA6gxJ
	 Q4763dZt1iK/qbP0EJ7Si5iBglSmZh/OvUXLey71irj7wUh+Z+VTCXg91FUREfvLC+L53
	 3sIYWgvZQOSnI4E2sXngPYPTKPF3GaSGCTzBNTLkcnBh5rtbh+9F5+bY9Y+adg62yQwj8
	 WbU1uv7Tsrf4IwA2vtkoio1HtoHIfC0FIIMl2e5dihzFxAShQtHRWSTq2XYGfeqUA+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795751562;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=GNq8bvSof7oF/vf2nSWQ+8TIKPV9Iapgfs3smeav4Io=;
	b=t9l5euoobr8AtYlVzzbtJ6VkgsqL5UIUveirjFcy81MDLXQbwrhiN9uebJ2IKGP+6m0z
	 bI+vfQnXx1a+58AnQ/uQSCsDx3SHr2i1Sq1n1tjvZFca7OOCFek3lQdN/ONFSUMng/STU
	 Q0edbWISZBLyqZkba5nxCJAeASF3rxmlp2hA4cbCQp0xFVpK/9Jinb23W1ZmA2znCG1Xj
	 +uRrJquTrdycxwiF+VmU49ht3oUT8bB0ZrVXjuHKVxUtDoBhnMdHr5kMWOtbsVSfRX3LN
	 pzfCeFtQoGf7ixFhdQ+zQWVpraD6buIQBrh7aQMBffOdOOKhoD+TPolidF1+USYZh+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hXsjelDt;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D12A606A31E;
	Fri, 27 Nov 2026 03:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D12A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hXsjelDt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795751561; x=1827287561;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JlzTxIIkIDLe1/DFNHobvx20prXee23ZBehdAjk9eNY=;
  b=hXsjelDtx+MnH4BhyF2YoZTctyLqbmn0tWQfadAUts8BFbmsbptOJ5Yz
   YpOwER9gS8NqKb2zY8fBaAE1d7/S3iVN7VRKWpjMQTDGbhDkUpto3w4OO
   7Iyf2OBEFU8P0NgWBvFdqbpSOOKiSxC7yi8lfsPUCQwhQdefRAnAeQglX
   Hl8B8gQ7r3ysAG+jwU6y/ZdB53+UznQVcYilN1xnMxs9oEDtuTU38ny7R
   iQLVe9FEf9YwvBQR2UDN607Z8gOKAnKAanC28qjvAGNAZrs7WpnrbCDvE
   2b0HxdWiamyhdVcQuE51Fdcgf/HGjSc9QzpKhOPnlSqs37uKX1S/gHAEq
   g==;
X-CSE-ConnectionGUID: bgpLURYfSwubbpHmElxiuQ==
X-CSE-MsgGUID: MOelrDxgQZeFU8l3Py0Hmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4564201"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4564201"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 19:52:40 -0800
X-CSE-ConnectionGUID: PFFHILt6SVeVyjM4/jXbeQ==
X-CSE-MsgGUID: nKZFK51oRkqgPxqDk2Pu5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="14073409"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa011.fm.intel.com with ESMTP; 26 Nov 2026 19:52:38 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xWn0l-00000001VIw-0jvk;
	Fri, 27 Nov 2026 03:52:35 +0000
Date: Fri, 27 Nov 2026 11:52:02 +0800
From: kernel test robot <lkp@intel.com>
To: shaos <shawnq1@163.com>, slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hfsplus: reorder complete combining runs for dentry keys
Message-ID: <20261127114353.IlT3o2gb-lkp@intel.com>
References: <20261126160720.3007837-1-shawnq1@163.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261126160720.3007837-1-shawnq1@163.com>

Hi shaos,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brauner-vfs/vfs.all]
[also build test WARNING on linus/master v7.4-rc4 next-20261126]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/shaos/hfsplus-reorder-complete-combining-runs-for-dentry-keys/20261126-160720
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20261126160720.3007837-1-shawnq1%40163.com
patch subject: [PATCH] hfsplus: reorder complete combining runs for dentry keys
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20261127/20261127114353.IlT3o2gb-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 16.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261127/20261127114353.IlT3o2gb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/20261127114353.IlT3o2gb-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/hfsplus/unicode.c: In function 'hfsplus_compare_dentry':
>> fs/hfsplus/unicode.c:747:1: warning: the frame size of 1456 bytes is larger than 1280 bytes [-Wframe-larger-than=]
     747 | }
         | ^
--
   fs/hfsplus/unicode_test.c: In function 'hfsplus_dentry_combining_reorder_long_test':
>> fs/hfsplus/unicode_test.c:1547:1: warning: the frame size of 1680 bytes is larger than 1280 bytes [-Wframe-larger-than=]
    1547 | }
         | ^


vim +747 fs/hfsplus/unicode.c

d45bce8faf5551 Duane Griffin      2007-07-15  721  
d45bce8faf5551 Duane Griffin      2007-07-15  722  /*
d45bce8faf5551 Duane Griffin      2007-07-15  723   * Compare strings with HFS+ filename ordering.
d45bce8faf5551 Duane Griffin      2007-07-15  724   * Composed unicode characters are decomposed and case-folding is performed
d45bce8faf5551 Duane Griffin      2007-07-15  725   * if the appropriate bits are (un)set on the superblock.
d45bce8faf5551 Duane Griffin      2007-07-15  726   */
6fa67e70755930 Al Viro            2016-07-31  727  int hfsplus_compare_dentry(const struct dentry *dentry,
621e155a359196 Nicholas Piggin    2011-01-07  728  		unsigned int len, const char *str, const struct qstr *name)
d45bce8faf5551 Duane Griffin      2007-07-15  729  {
d3fe19852e96aa Al Viro            2016-07-29  730  	struct super_block *sb = dentry->d_sb;
bbe5ebcbc006ac Viacheslav Dubeyko 2026-09-18  731  	int casefold = test_bit(HFSPLUS_SB_CASEFOLD, &HFSPLUS_SB(sb)->flags);
bbe5ebcbc006ac Viacheslav Dubeyko 2026-09-18  732  	struct hfsplus_decompose_iter it1, it2;
d45bce8faf5551 Duane Griffin      2007-07-15  733  
bbe5ebcbc006ac Viacheslav Dubeyko 2026-09-18  734  	hfsplus_decompose_iter_init(&it1, sb, str, len, HFS_REGULAR_NAME);
bbe5ebcbc006ac Viacheslav Dubeyko 2026-09-18  735  	hfsplus_decompose_iter_init(&it2, sb, name->name, name->len,
897c2beb4a7799 Viacheslav Dubeyko 2026-03-23  736  				    HFS_REGULAR_NAME);
d45bce8faf5551 Duane Griffin      2007-07-15  737  
bbe5ebcbc006ac Viacheslav Dubeyko 2026-09-18  738  	while (1) {
bbe5ebcbc006ac Viacheslav Dubeyko 2026-09-18  739  		int c1 = hfsplus_decompose_iter_next_folded(&it1, casefold);
bbe5ebcbc006ac Viacheslav Dubeyko 2026-09-18  740  		int c2 = hfsplus_decompose_iter_next_folded(&it2, casefold);
d45bce8faf5551 Duane Griffin      2007-07-15  741  
bbe5ebcbc006ac Viacheslav Dubeyko 2026-09-18  742  		if (c1 < 0 || c2 < 0)
bbe5ebcbc006ac Viacheslav Dubeyko 2026-09-18  743  			return c1 == c2 ? 0 : (c1 < 0 ? -1 : 1);
bbe5ebcbc006ac Viacheslav Dubeyko 2026-09-18  744  		if (c1 != c2)
bbe5ebcbc006ac Viacheslav Dubeyko 2026-09-18  745  			return c1 < c2 ? -1 : 1;
bbe5ebcbc006ac Viacheslav Dubeyko 2026-09-18  746  	}
d45bce8faf5551 Duane Griffin      2007-07-15 @747  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
