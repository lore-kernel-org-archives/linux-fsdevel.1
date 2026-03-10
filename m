Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B002B27FB05;
	Tue, 10 Mar 2026 14:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773153612; cv=none; b=oBp4Hcfh0ILzZf2qftZ1di7WpgFrfkVizZdRB0jkRde2HBH/vl7FRmAKQsSwKoLFIerC//Ltrhq09rP1OcgMulNh4PaTkLZPydU5JP7iH0T3gY9BM8F/pyD1RQG8xpnxjWsUQoHvZqy3IhTpA6XudGVJ9a2kQP/20P+FWFX5cd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773153612; c=relaxed/simple;
	bh=xfefwHQwZ0tT8OgxngTpIn/dJOBz/WqZnl9m10qhBbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/BB9eOhA3+jmJ38beBWBP52bA/SLhfgeJzLSUd7QYVg66r+44o+Agg5yhhJjnyaVF2GOMZk8fGs60g1KFClveMkia+0VzOdo2TFp5hD+vtQwEn0WxPb4vof9sTrn6CBuSYW0ggTV+y96k7K/NWhuhgeplvMC77+wNSel+C6prU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NzLkGsdr; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NzLkGsdr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773153611; x=1804689611;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xfefwHQwZ0tT8OgxngTpIn/dJOBz/WqZnl9m10qhBbY=;
  b=NzLkGsdrX1pOLujsZsqfJrSla/9hjWz3co3C/HxTQQJoyeo5QvtDDwBy
   KGY7nO/IqZWW/vCRPZZ3E0ayhIDVTpcB6l9tnI7LKBWHyr7FXx0D0stRE
   AgActgY0nQK3jhxEIgWDJfCCz3dF8O81ZaHRHIj0psSaneZGkckF0lFN8
   ARi92OsQz5XHTB/xPrMojgVJ67RcJkjdpw5TabsmzR6tWOen1t1UBNXoQ
   9g3/8nTzA0dtqtwsCtqdnKPmuqIRVSkG1O2rN2YdwLFMac08sBWBPtFeq
   tjSO5BArUFNw/gVECuJE2DeIQRZFFIvTeGnolLhuCAhg+DXFcObxrcOsX
   A==;
X-CSE-ConnectionGUID: 5rj6YssoQbGgRnha4Fh7jg==
X-CSE-MsgGUID: vXzmDnEITKiPemCMiy5xRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="85679940"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="85679940"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 07:40:11 -0700
X-CSE-ConnectionGUID: SGxghaRES3mfWIsUZ6Ze6A==
X-CSE-MsgGUID: JrmFztmCTxihRpJzhIL77Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="218094563"
Received: from lkp-server01.sh.intel.com (HELO 434e41ea3c86) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 10 Mar 2026 07:40:07 -0700
Received: from kbuild by 434e41ea3c86 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vzyFg-0000000025A-3i69;
	Tue, 10 Mar 2026 14:40:04 +0000
Date: Tue, 10 Mar 2026 22:39:45 +0800
From: kernel test robot <lkp@intel.com>
To: George Anthony Vernon <contact@gvernon.com>, slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com
Cc: oe-kbuild-all@lists.linux.dev,
	George Anthony Vernon <contact@gvernon.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH v3] hfs: Validate CNIDs in hfs_read_inode
Message-ID: <202603102229.zVuUXq6v-lkp@intel.com>
References: <20260310000826.242674-1-contact@gvernon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310000826.242674-1-contact@gvernon.com>

Hi George,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brauner-vfs/vfs.all]
[also build test WARNING on linus/master v7.0-rc3 next-20260309]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/George-Anthony-Vernon/hfs-Validate-CNIDs-in-hfs_read_inode/20260310-081836
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20260310000826.242674-1-contact%40gvernon.com
patch subject: [PATCH v3] hfs: Validate CNIDs in hfs_read_inode
config: microblaze-randconfig-r132-20260310 (https://download.01.org/0day-ci/archive/20260310/202603102229.zVuUXq6v-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 9.5.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260310/202603102229.zVuUXq6v-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603102229.zVuUXq6v-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/hfs/inode.c:408:55: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] cnid @@     got restricted __be32 [usertype] FlNum @@
   fs/hfs/inode.c:408:55: sparse:     expected unsigned int [usertype] cnid
   fs/hfs/inode.c:408:55: sparse:     got restricted __be32 [usertype] FlNum
>> fs/hfs/inode.c:431:54: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] cnid @@     got restricted __be32 [usertype] DirID @@
   fs/hfs/inode.c:431:54: sparse:     expected unsigned int [usertype] cnid
   fs/hfs/inode.c:431:54: sparse:     got restricted __be32 [usertype] DirID

vim +408 fs/hfs/inode.c

   378	
   379	/*
   380	 * hfs_read_inode
   381	 */
   382	static int hfs_read_inode(struct inode *inode, void *data)
   383	{
   384		struct hfs_iget_data *idata = data;
   385		struct hfs_sb_info *hsb = HFS_SB(inode->i_sb);
   386		hfs_cat_rec *rec;
   387	
   388		HFS_I(inode)->flags = 0;
   389		HFS_I(inode)->rsrc_inode = NULL;
   390		mutex_init(&HFS_I(inode)->extents_lock);
   391		INIT_LIST_HEAD(&HFS_I(inode)->open_dir_list);
   392		spin_lock_init(&HFS_I(inode)->open_dir_lock);
   393	
   394		/* Initialize the inode */
   395		inode->i_uid = hsb->s_uid;
   396		inode->i_gid = hsb->s_gid;
   397		set_nlink(inode, 1);
   398	
   399		if (idata->key)
   400			HFS_I(inode)->cat_key = *idata->key;
   401		else
   402			HFS_I(inode)->flags |= HFS_FLG_RSRC;
   403		HFS_I(inode)->tz_secondswest = sys_tz.tz_minuteswest * 60;
   404	
   405		rec = idata->rec;
   406		switch (rec->type) {
   407		case HFS_CDR_FIL:
 > 408			if (!is_valid_catalog_record(rec->file.FlNum, HFS_CDR_FIL))
   409				goto make_bad_inode;
   410			if (!HFS_IS_RSRC(inode)) {
   411				hfs_inode_read_fork(inode, rec->file.ExtRec, rec->file.LgLen,
   412						    rec->file.PyLen, be16_to_cpu(rec->file.ClpSize));
   413			} else {
   414				hfs_inode_read_fork(inode, rec->file.RExtRec, rec->file.RLgLen,
   415						    rec->file.RPyLen, be16_to_cpu(rec->file.ClpSize));
   416			}
   417	
   418			inode->i_ino = be32_to_cpu(rec->file.FlNum);
   419			inode->i_mode = S_IRUGO | S_IXUGO;
   420			if (!(rec->file.Flags & HFS_FIL_LOCK))
   421				inode->i_mode |= S_IWUGO;
   422			inode->i_mode &= ~hsb->s_file_umask;
   423			inode->i_mode |= S_IFREG;
   424			inode_set_mtime_to_ts(inode,
   425					      inode_set_atime_to_ts(inode, inode_set_ctime_to_ts(inode, hfs_m_to_utime(rec->file.MdDat))));
   426			inode->i_op = &hfs_file_inode_operations;
   427			inode->i_fop = &hfs_file_operations;
   428			inode->i_mapping->a_ops = &hfs_aops;
   429			break;
   430		case HFS_CDR_DIR:
 > 431			if (!is_valid_catalog_record(rec->dir.DirID, HFS_CDR_DIR))
   432				goto make_bad_inode;
   433			inode->i_ino = be32_to_cpu(rec->dir.DirID);
   434			inode->i_size = be16_to_cpu(rec->dir.Val) + 2;
   435			HFS_I(inode)->fs_blocks = 0;
   436			inode->i_mode = S_IFDIR | (S_IRWXUGO & ~hsb->s_dir_umask);
   437			inode_set_mtime_to_ts(inode,
   438					      inode_set_atime_to_ts(inode, inode_set_ctime_to_ts(inode, hfs_m_to_utime(rec->dir.MdDat))));
   439			inode->i_op = &hfs_dir_inode_operations;
   440			inode->i_fop = &hfs_dir_operations;
   441			break;
   442		make_bad_inode:
   443			pr_warn("Invalid cnid %lu\n", inode->i_ino);
   444			pr_warn("Volume is probably corrupted, try performing fsck.\n");
   445			fallthrough;
   446		default:
   447			make_bad_inode(inode);
   448			break;
   449		}
   450		return 0;
   451	}
   452	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
