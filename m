Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30772361DA1
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Mar 2026 05:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774158844; cv=none; b=MngY0+RNt5AEX/V3HcGV25BsgzDC4BgF1xrnLZC+lSRv5Ax1VU0FEIqAybrI6ge3DHDgeNJ816Av7KHloiMU18XVdRzuX177i2trq7zMsZpCnlpKHP/63MCi1F8r2bqhH8qRRsDhuB4QmJCgH9AD5uiNpX2MOWcSPutDG/EUhpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774158844; c=relaxed/simple;
	bh=Ugk/mZdnf4BBglsm37SaYfJeiv6BykBtxi1sFDjpmCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hEcVlTgw9uOfG7198vrqVofz2d1gD2ZpTN7+2P8qcLAeT71YGZlruUOSSiXhYk9uhzOOVKEXiUmbtqWUvMPg3o4Dpw5x6b1lXVLLz00GIZTR/k8EVzfX664qwTku3m2mh9hFTf8TP6v468UmKHtGKFSXdWL3gqjXi99heisJB0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W0SKarqo; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W0SKarqo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774158840; x=1805694840;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ugk/mZdnf4BBglsm37SaYfJeiv6BykBtxi1sFDjpmCk=;
  b=W0SKarqozI8pwvSXFSmQXot7Kcpirs31AXuREfcJj5we4rbwM2f2x/Ht
   kH3CiAj589pKb3QhR3Zi5EeuY1337NwJkG12eg4IAv8gXCFMqXkF0ST95
   zsNM1LteUyW+HE8GY180b9xiIfK3AUuxtN6ccC4kvv8YGAhXbhrlCgrSX
   VpkCfVW9/cmVLO2oe7p25ecHnTl5/IXF1Qh87paY4/GqNT1FGNnf7FBQH
   /UbkjqKwi+L4sSkOMS2SYGvdpMlEKurVZ92sktOoEEpmH41TBRp7JmqeQ
   0RHFg2huuYgQYFn+5O5moH5s94+DK1GrvQPLg4/+iEC2SKUeQndS+WPD9
   w==;
X-CSE-ConnectionGUID: M5iDINAfT6mi0WTVBvK0QQ==
X-CSE-MsgGUID: KKWtQQEYSf+qe4lHJ1K/pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11736"; a="75315464"
X-IronPort-AV: E=Sophos;i="6.23,134,1770624000"; 
   d="scan'208";a="75315464"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2026 22:53:59 -0700
X-CSE-ConnectionGUID: QmiY/CTFR1W97vIkOKwrAg==
X-CSE-MsgGUID: KvbTIfw9TeWe6DrTOa4UvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,134,1770624000"; 
   d="scan'208";a="220511544"
Received: from lkp-server02.sh.intel.com (HELO d7fefbca0d04) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 21 Mar 2026 22:53:57 -0700
Received: from kbuild by d7fefbca0d04 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w4Bka-000000001kr-0kHf;
	Sun, 22 Mar 2026 05:53:32 +0000
Date: Sun, 22 Mar 2026 13:53:01 +0800
From: kernel test robot <lkp@intel.com>
To: David Timber <dxdt@dev.snart.me>, linkinjeon@kernel.org,
	hyc.lee@gmail.com, almaz.alexandrovich@paragon-software.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, ntfs3@lists.linux.dev,
	David Timber <dxdt@dev.snart.me>
Subject: Re: [PATCH] ntfs(3): export super block magic
Message-ID: <202603221308.oDwds9wL-lkp@intel.com>
References: <20260319234047.43253-1-dxdt@dev.snart.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319234047.43253-1-dxdt@dev.snart.me>

Hi David,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20260319]
[cannot apply to brauner-vfs/vfs.all linus/master v7.0-rc4 v7.0-rc3 v7.0-rc2 v7.0-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Timber/ntfs-3-export-super-block-magic/20260320-181810
base:   next-20260319
patch link:    https://lore.kernel.org/r/20260319234047.43253-1-dxdt%40dev.snart.me
patch subject: [PATCH] ntfs(3): export super block magic
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20260322/202603221308.oDwds9wL-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260322/202603221308.oDwds9wL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603221308.oDwds9wL-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/ntfs/super.c:2152:18: error: use of undeclared identifier 'NTFS_SUPER_MAGIC'
    2152 |         sfs->f_type   = NTFS_SUPER_MAGIC;
         |                         ^
   fs/ntfs/super.c:2355:16: error: use of undeclared identifier 'NTFS_SUPER_MAGIC'
    2355 |         sb->s_magic = NTFS_SUPER_MAGIC;
         |                       ^
   2 errors generated.
--
>> fs/ntfs3/super.c:734:16: error: use of undeclared identifier 'NTFS3_SUPER_MAGIC'
     734 |         buf->f_type = NTFS3_SUPER_MAGIC;
         |                       ^
   fs/ntfs3/super.c:1282:16: error: use of undeclared identifier 'NTFS3_SUPER_MAGIC'
    1282 |         sb->s_magic = NTFS3_SUPER_MAGIC;
         |                       ^
   2 errors generated.


vim +/NTFS_SUPER_MAGIC +2152 fs/ntfs/super.c

  2123	
  2124	/*
  2125	 * ntfs_statfs - return information about mounted NTFS volume
  2126	 * @dentry:	dentry from mounted volume
  2127	 * @sfs:	statfs structure in which to return the information
  2128	 *
  2129	 * Return information about the mounted NTFS volume @dentry in the statfs structure
  2130	 * pointed to by @sfs (this is initialized with zeros before ntfs_statfs is
  2131	 * called). We interpret the values to be correct of the moment in time at
  2132	 * which we are called. Most values are variable otherwise and this isn't just
  2133	 * the free values but the totals as well. For example we can increase the
  2134	 * total number of file nodes if we run out and we can keep doing this until
  2135	 * there is no more space on the volume left at all.
  2136	 *
  2137	 * Called from vfs_statfs which is used to handle the statfs, fstatfs, and
  2138	 * ustat system calls.
  2139	 *
  2140	 * Return 0 on success or -errno on error.
  2141	 */
  2142	static int ntfs_statfs(struct dentry *dentry, struct kstatfs *sfs)
  2143	{
  2144		struct super_block *sb = dentry->d_sb;
  2145		s64 size;
  2146		struct ntfs_volume *vol = NTFS_SB(sb);
  2147		struct ntfs_inode *mft_ni = NTFS_I(vol->mft_ino);
  2148		unsigned long flags;
  2149	
  2150		ntfs_debug("Entering.");
  2151		/* Type of filesystem. */
> 2152		sfs->f_type   = NTFS_SUPER_MAGIC;
  2153		/* Optimal transfer block size. */
  2154		sfs->f_bsize = vol->cluster_size;
  2155		/* Fundamental file system block size, used as the unit. */
  2156		sfs->f_frsize = vol->cluster_size;
  2157	
  2158		/*
  2159		 * Total data blocks in filesystem in units of f_bsize and since
  2160		 * inodes are also stored in data blocs ($MFT is a file) this is just
  2161		 * the total clusters.
  2162		 */
  2163		sfs->f_blocks = vol->nr_clusters;
  2164	
  2165		/* wait event */
  2166		if (!NVolFreeClusterKnown(vol))
  2167			wait_event(vol->free_waitq, NVolFreeClusterKnown(vol));
  2168	
  2169		/* Free data blocks in filesystem in units of f_bsize. */
  2170		size = atomic64_read(&vol->free_clusters) -
  2171			atomic64_read(&vol->dirty_clusters);
  2172		if (size < 0LL)
  2173			size = 0LL;
  2174	
  2175		/* Free blocks avail to non-superuser, same as above on NTFS. */
  2176		sfs->f_bavail = sfs->f_bfree = size;
  2177	
  2178		/* Number of inodes in filesystem (at this point in time). */
  2179		read_lock_irqsave(&mft_ni->size_lock, flags);
  2180		sfs->f_files = i_size_read(vol->mft_ino) >> vol->mft_record_size_bits;
  2181		read_unlock_irqrestore(&mft_ni->size_lock, flags);
  2182	
  2183		/* Free inodes in fs (based on current total count). */
  2184		sfs->f_ffree = atomic64_read(&vol->free_mft_records);
  2185	
  2186		/*
  2187		 * File system id. This is extremely *nix flavour dependent and even
  2188		 * within Linux itself all fs do their own thing. I interpret this to
  2189		 * mean a unique id associated with the mounted fs and not the id
  2190		 * associated with the filesystem driver, the latter is already given
  2191		 * by the filesystem type in sfs->f_type. Thus we use the 64-bit
  2192		 * volume serial number splitting it into two 32-bit parts. We enter
  2193		 * the least significant 32-bits in f_fsid[0] and the most significant
  2194		 * 32-bits in f_fsid[1].
  2195		 */
  2196		sfs->f_fsid = u64_to_fsid(vol->serial_no);
  2197		/* Maximum length of filenames. */
  2198		sfs->f_namelen	   = NTFS_MAX_NAME_LEN;
  2199	
  2200		return 0;
  2201	}
  2202	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
