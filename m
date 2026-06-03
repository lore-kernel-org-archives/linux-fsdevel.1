Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0E03A875E
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 14:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780497769; cv=none; b=PbwMJ/7VdLEH0gaaSUkzBPugfPZuVkgGgxSO/VTibTsrfSzMof5wnPW3dyhjxld40XwfubCuruH6JnOFloTWdOHm8qndViKlKIue0LY2OObGRyDpJtpG4enkptMad1+YaZaOFm416hArHdU7hVKfcKEI2G9/YnTXDTtsznRLYBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780497769; c=relaxed/simple;
	bh=IAXIe9i199iVavRnrmTXTxm2Y+IVirjDD3K3rG4IhqA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HaqBnb6843boRK9bV3qKAVn0/4QtPdzKoMYKVvQun9dEpLRzZQluhjdqmoeBe8U14h+Ow1qpztu74aX+Gt7cxQWRroBrSGFz5WqDbpP9gosaVO/OzmKhMzMJ5+bmloWRlRbTZuIhgMfgPst9nDm4B3zkXUOki+AAyeT/lZpsH90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h5KXLT8i; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h5KXLT8i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780497767; x=1812033767;
  h=date:from:to:cc:subject:message-id;
  bh=IAXIe9i199iVavRnrmTXTxm2Y+IVirjDD3K3rG4IhqA=;
  b=h5KXLT8iby4ZsPazPcDuYqB0/PlKmFrpUt5esnYe+xIrpWLQ2rUDqcv3
   xSQ2VbwwaQtVDyt8beOvKp3ZfrOQRjpGWeq5kk/Im37BiACv2ezKaRhSe
   HkfsDv1uW3hk6SyucZB0YowT0lbOqEhbOdx1KcdWemc0gxzeSSniHq7MV
   kfbXdK9YFMiVta/yokTeYVPnFD5kdn8kNvECDNVEzh5CliVk5Trneb8pz
   7rQR8Oz/LEefdD3J1easEElqipe6JK5wGfQhJOf16AMEbPbAG/9xqXFqz
   DSjtw5NgEz1Ld2TFKJInzSd09xCSgr7EJcU0O7SAA/8gxEGt0VwMckXoX
   A==;
X-CSE-ConnectionGUID: glcPBgTWTem3mrbzAciFZA==
X-CSE-MsgGUID: JN+ckTKFRVCqgV2U68rtjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="91624809"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="91624809"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 07:42:47 -0700
X-CSE-ConnectionGUID: H0bRajFSR9aum4ahq1yLng==
X-CSE-MsgGUID: GWqVLa2URreIybuiLRFYPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="246082250"
Received: from igk-lkp-server01.igk.intel.com (HELO 892db79562d4) ([10.211.93.152])
  by fmviesa004.fm.intel.com with ESMTP; 03 Jun 2026 07:42:45 -0700
Received: from kbuild by 892db79562d4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wUmnp-0000000024l-3y1h;
	Wed, 03 Jun 2026 14:42:41 +0000
Date: Wed, 03 Jun 2026 16:41:54 +0200
From: kernel test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:more.configfs 33/33] fs/configfs/symlink.c:136:26:
 warning: variable 'sd' set but not used
Message-ID: <202606031627.uHB6eQoo-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git more.configfs
head:   53a9faf145785b0b12ec71f2204f3b3011dbda5e
commit: 53a9faf145785b0b12ec71f2204f3b3011dbda5e [33/33] kill configfs_dirent_is_ready()
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260603/202606031627.uHB6eQoo-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project f43d6834093b19baf79beda8c0337ab020ac5f17)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260603/202606031627.uHB6eQoo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606031627.uHB6eQoo-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/configfs/symlink.c:136:26: warning: variable 'sd' set but not used [-Wunused-but-set-variable]
     136 |         struct configfs_dirent *sd;
         |                                 ^
   1 warning generated.


vim +/sd +136 fs/configfs/symlink.c

7063fbf2261194f Joel Becker       2005-12-15  130  
7063fbf2261194f Joel Becker       2005-12-15  131  
7a77db95511c39b Christian Brauner 2023-01-13  132  int configfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
549c7297717c32e Christian Brauner 2021-01-21  133  		     struct dentry *dentry, const char *symname)
7063fbf2261194f Joel Becker       2005-12-15  134  {
7063fbf2261194f Joel Becker       2005-12-15  135  	int ret;
2a109f2a4155f16 Louis Rilling     2008-07-04 @136  	struct configfs_dirent *sd;
7063fbf2261194f Joel Becker       2005-12-15  137  	struct config_item *parent_item;
3c48f23adada870 Subrata Modak     2009-04-19  138  	struct config_item *target_item = NULL;
aa293583f0fe8b1 Bhumika Goyal     2017-10-16  139  	const struct config_item_type *type;
7063fbf2261194f Joel Becker       2005-12-15  140  
2a109f2a4155f16 Louis Rilling     2008-07-04  141  	sd = dentry->d_parent->d_fsdata;
2a109f2a4155f16 Louis Rilling     2008-07-04  142  
7063fbf2261194f Joel Becker       2005-12-15  143  	parent_item = configfs_get_config_item(dentry->d_parent);
7063fbf2261194f Joel Becker       2005-12-15  144  	type = parent_item->ci_type;
7063fbf2261194f Joel Becker       2005-12-15  145  
2a109f2a4155f16 Louis Rilling     2008-07-04  146  	ret = -EPERM;
7063fbf2261194f Joel Becker       2005-12-15  147  	if (!type || !type->ct_item_ops ||
7063fbf2261194f Joel Becker       2005-12-15  148  	    !type->ct_item_ops->allow_link)
7063fbf2261194f Joel Becker       2005-12-15  149  		goto out_put;
7063fbf2261194f Joel Becker       2005-12-15  150  
351e5d869e5ac10 Al Viro           2019-08-03  151  	/*
351e5d869e5ac10 Al Viro           2019-08-03  152  	 * This is really sick.  What they wanted was a hybrid of
351e5d869e5ac10 Al Viro           2019-08-03  153  	 * link(2) and symlink(2) - they wanted the target resolved
351e5d869e5ac10 Al Viro           2019-08-03  154  	 * at syscall time (as link(2) would've done), be a directory
351e5d869e5ac10 Al Viro           2019-08-03  155  	 * (which link(2) would've refused to do) *AND* be a deep
351e5d869e5ac10 Al Viro           2019-08-03  156  	 * fucking magic, making the target busy from rmdir POV.
351e5d869e5ac10 Al Viro           2019-08-03  157  	 * symlink(2) is nothing of that sort, and the locking it
351e5d869e5ac10 Al Viro           2019-08-03  158  	 * gets matches the normal symlink(2) semantics.  Without
351e5d869e5ac10 Al Viro           2019-08-03  159  	 * attempts to resolve the target (which might very well
351e5d869e5ac10 Al Viro           2019-08-03  160  	 * not even exist yet) done prior to locking the parent
351e5d869e5ac10 Al Viro           2019-08-03  161  	 * directory.  This perversion, OTOH, needs to resolve
351e5d869e5ac10 Al Viro           2019-08-03  162  	 * the target, which would lead to obvious deadlocks if
351e5d869e5ac10 Al Viro           2019-08-03  163  	 * attempted with any directories locked.
351e5d869e5ac10 Al Viro           2019-08-03  164  	 *
351e5d869e5ac10 Al Viro           2019-08-03  165  	 * Unfortunately, that garbage is userland ABI and we should've
351e5d869e5ac10 Al Viro           2019-08-03  166  	 * said "no" back in 2005.  Too late now, so we get to
351e5d869e5ac10 Al Viro           2019-08-03  167  	 * play very ugly games with locking.
351e5d869e5ac10 Al Viro           2019-08-03  168  	 *
351e5d869e5ac10 Al Viro           2019-08-03  169  	 * Try *ANYTHING* of that sort in new code, and you will
351e5d869e5ac10 Al Viro           2019-08-03  170  	 * really regret it.  Just ask yourself - what could a BOFH
351e5d869e5ac10 Al Viro           2019-08-03  171  	 * do to me and do I want to find it out first-hand?
351e5d869e5ac10 Al Viro           2019-08-03  172  	 *
351e5d869e5ac10 Al Viro           2019-08-03  173  	 *  AV, a thoroughly annoyed bastard.
351e5d869e5ac10 Al Viro           2019-08-03  174  	 */
351e5d869e5ac10 Al Viro           2019-08-03  175  	inode_unlock(dir);
1b25dea3867abc9 Al Viro           2025-09-04  176  	ret = get_target(symname, &target_item, dentry->d_sb);
351e5d869e5ac10 Al Viro           2019-08-03  177  	inode_lock(dir);
7063fbf2261194f Joel Becker       2005-12-15  178  	if (ret)
7063fbf2261194f Joel Becker       2005-12-15  179  		goto out_put;
7063fbf2261194f Joel Becker       2005-12-15  180  
351e5d869e5ac10 Al Viro           2019-08-03  181  	if (dentry->d_inode || d_unhashed(dentry))
351e5d869e5ac10 Al Viro           2019-08-03  182  		ret = -EEXIST;
351e5d869e5ac10 Al Viro           2019-08-03  183  	else
4609e1f18e19c3b Christian Brauner 2023-01-13  184  		ret = inode_permission(&nop_mnt_idmap, dir,
47291baa8ddfdae Christian Brauner 2021-01-21  185  				       MAY_WRITE | MAY_EXEC);
351e5d869e5ac10 Al Viro           2019-08-03  186  	if (!ret)
7063fbf2261194f Joel Becker       2005-12-15  187  		ret = type->ct_item_ops->allow_link(parent_item, target_item);
e75206517504461 Louis Rilling     2008-06-12  188  	if (!ret) {
9a73d78cda750f1 Louis Rilling     2008-06-20  189  		mutex_lock(&configfs_symlink_mutex);
7063fbf2261194f Joel Becker       2005-12-15  190  		ret = create_link(parent_item, target_item, dentry);
9a73d78cda750f1 Louis Rilling     2008-06-20  191  		mutex_unlock(&configfs_symlink_mutex);
e75206517504461 Louis Rilling     2008-06-12  192  		if (ret && type->ct_item_ops->drop_link)
e75206517504461 Louis Rilling     2008-06-12  193  			type->ct_item_ops->drop_link(parent_item,
e75206517504461 Louis Rilling     2008-06-12  194  						     target_item);
e75206517504461 Louis Rilling     2008-06-12  195  	}
7063fbf2261194f Joel Becker       2005-12-15  196  
7063fbf2261194f Joel Becker       2005-12-15  197  	config_item_put(target_item);
7063fbf2261194f Joel Becker       2005-12-15  198  
7063fbf2261194f Joel Becker       2005-12-15  199  out_put:
7063fbf2261194f Joel Becker       2005-12-15  200  	config_item_put(parent_item);
7063fbf2261194f Joel Becker       2005-12-15  201  	return ret;
7063fbf2261194f Joel Becker       2005-12-15  202  }
7063fbf2261194f Joel Becker       2005-12-15  203  

:::::: The code at line 136 was first introduced by commit
:::::: 2a109f2a4155f168047aa2f5b3a170e279bef89a [PATCH] configfs: Prevent userspace from creating new entries under attaching directories

:::::: TO: Louis Rilling <louis.rilling@kerlabs.com>
:::::: CC: Mark Fasheh <mfasheh@suse.com>

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
