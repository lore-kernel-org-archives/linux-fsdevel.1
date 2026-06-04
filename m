Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34582FE060
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jun 2026 02:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780539432; cv=none; b=se38kIqA7oAb77E+JFadsJa7IgRQhv5HM8Ak6GZG1lvRl6gZb2QyucwtcJEyMyZG7lRE4VtAcuLuBPNvZ2G+rW3hqFOub1elVju+t+WJNgCDzjt56ZZkVFyW6s9hQMqgjGk2N2nZyNAo40hfTmywJKLPG9IvYpzghWD+z+qDyWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780539432; c=relaxed/simple;
	bh=h9+JqMvkk39BCvmTywoeqrhTMeL4OUZnpNwPjVejWBQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mu1I2118FpETyEZB5NjOx+vUXzNw6NiOyDkeJT5GyinhPtv+Ot1gr8YdKCVvJbJuhn6t0CBtjC9Lp6IpfZYlIJH1t4fOdgegqibSxk1lNa08AxCLkx8E0bsWk0dvZRxlYrqjg46K3TxZFiPu6ldW4VIuJPq0dtYWH8IH9OM6imA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d75vosx3; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d75vosx3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780539424; x=1812075424;
  h=date:from:to:cc:subject:message-id;
  bh=h9+JqMvkk39BCvmTywoeqrhTMeL4OUZnpNwPjVejWBQ=;
  b=d75vosx3xa/rgHx51FWEGibA46n0OyFC3zW7JU+9aaa91qpKE4AuM5s/
   cXZdZBai9GsZaS3X4UmzVBDK/0mfgJ5NFjLRbq7JNUDrTaUtdjQHDNmr2
   QNuUVXgMyr73T/b8nVQD2hWQjZBGCiP3rh6hJBeZFffdn96KxBfr2zUkK
   I1DMO5TlSw5/00ZmvKpOgDSByq2JU/afhpWqBk4wI55tdEczBLFbY8O8b
   Tt3FmeHTfIiQoOk3WAhmt6MherWKBt2fBHbD4HZllIK9LLE7ucjZKu2+V
   rwso6J1vJTKvOAL9QofxjXkzVKQXfrn3rxboFsV9T03kUTWgx/Az+8H9k
   w==;
X-CSE-ConnectionGUID: ou6zQ0sxQ/eKXpaApYA75Q==
X-CSE-MsgGUID: FEHagnYwRh2Yf69yxrUn1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="81423504"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="81423504"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 19:17:03 -0700
X-CSE-ConnectionGUID: 46oUs8EjSxqb+IQrseWE1g==
X-CSE-MsgGUID: XDUmo70xRI+BavpEgr2pSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="274644433"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 03 Jun 2026 19:17:02 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wUxdj-00000000E9o-1NuI;
	Thu, 04 Jun 2026 02:16:59 +0000
Date: Thu, 04 Jun 2026 10:16:16 +0800
From: kernel test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:more.configfs 33/33] fs/configfs/symlink.c:136:33:
 warning: variable 'sd' set but not used
Message-ID: <202606041019.eVNiH4jZ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git more.configfs
head:   53a9faf145785b0b12ec71f2204f3b3011dbda5e
commit: 53a9faf145785b0b12ec71f2204f3b3011dbda5e [33/33] kill configfs_dirent_is_ready()
config: csky-randconfig-r073-20260604 (https://download.01.org/0day-ci/archive/20260604/202606041019.eVNiH4jZ-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 16.1.0
smatch: v0.5.0-9185-gbcc58b9c
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260604/202606041019.eVNiH4jZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606041019.eVNiH4jZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/configfs/symlink.c: In function 'configfs_symlink':
>> fs/configfs/symlink.c:136:33: warning: variable 'sd' set but not used [-Wunused-but-set-variable=]
     136 |         struct configfs_dirent *sd;
         |                                 ^~


vim +/sd +136 fs/configfs/symlink.c

7063fbf2261194 Joel Becker       2005-12-15  130  
7063fbf2261194 Joel Becker       2005-12-15  131  
7a77db95511c39 Christian Brauner 2023-01-13  132  int configfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
549c7297717c32 Christian Brauner 2021-01-21  133  		     struct dentry *dentry, const char *symname)
7063fbf2261194 Joel Becker       2005-12-15  134  {
7063fbf2261194 Joel Becker       2005-12-15  135  	int ret;
2a109f2a4155f1 Louis Rilling     2008-07-04 @136  	struct configfs_dirent *sd;
7063fbf2261194 Joel Becker       2005-12-15  137  	struct config_item *parent_item;
3c48f23adada87 Subrata Modak     2009-04-19  138  	struct config_item *target_item = NULL;
aa293583f0fe8b Bhumika Goyal     2017-10-16  139  	const struct config_item_type *type;
7063fbf2261194 Joel Becker       2005-12-15  140  
2a109f2a4155f1 Louis Rilling     2008-07-04  141  	sd = dentry->d_parent->d_fsdata;
2a109f2a4155f1 Louis Rilling     2008-07-04  142  
7063fbf2261194 Joel Becker       2005-12-15  143  	parent_item = configfs_get_config_item(dentry->d_parent);
7063fbf2261194 Joel Becker       2005-12-15  144  	type = parent_item->ci_type;
7063fbf2261194 Joel Becker       2005-12-15  145  
2a109f2a4155f1 Louis Rilling     2008-07-04  146  	ret = -EPERM;
7063fbf2261194 Joel Becker       2005-12-15  147  	if (!type || !type->ct_item_ops ||
7063fbf2261194 Joel Becker       2005-12-15  148  	    !type->ct_item_ops->allow_link)
7063fbf2261194 Joel Becker       2005-12-15  149  		goto out_put;
7063fbf2261194 Joel Becker       2005-12-15  150  
351e5d869e5ac1 Al Viro           2019-08-03  151  	/*
351e5d869e5ac1 Al Viro           2019-08-03  152  	 * This is really sick.  What they wanted was a hybrid of
351e5d869e5ac1 Al Viro           2019-08-03  153  	 * link(2) and symlink(2) - they wanted the target resolved
351e5d869e5ac1 Al Viro           2019-08-03  154  	 * at syscall time (as link(2) would've done), be a directory
351e5d869e5ac1 Al Viro           2019-08-03  155  	 * (which link(2) would've refused to do) *AND* be a deep
351e5d869e5ac1 Al Viro           2019-08-03  156  	 * fucking magic, making the target busy from rmdir POV.
351e5d869e5ac1 Al Viro           2019-08-03  157  	 * symlink(2) is nothing of that sort, and the locking it
351e5d869e5ac1 Al Viro           2019-08-03  158  	 * gets matches the normal symlink(2) semantics.  Without
351e5d869e5ac1 Al Viro           2019-08-03  159  	 * attempts to resolve the target (which might very well
351e5d869e5ac1 Al Viro           2019-08-03  160  	 * not even exist yet) done prior to locking the parent
351e5d869e5ac1 Al Viro           2019-08-03  161  	 * directory.  This perversion, OTOH, needs to resolve
351e5d869e5ac1 Al Viro           2019-08-03  162  	 * the target, which would lead to obvious deadlocks if
351e5d869e5ac1 Al Viro           2019-08-03  163  	 * attempted with any directories locked.
351e5d869e5ac1 Al Viro           2019-08-03  164  	 *
351e5d869e5ac1 Al Viro           2019-08-03  165  	 * Unfortunately, that garbage is userland ABI and we should've
351e5d869e5ac1 Al Viro           2019-08-03  166  	 * said "no" back in 2005.  Too late now, so we get to
351e5d869e5ac1 Al Viro           2019-08-03  167  	 * play very ugly games with locking.
351e5d869e5ac1 Al Viro           2019-08-03  168  	 *
351e5d869e5ac1 Al Viro           2019-08-03  169  	 * Try *ANYTHING* of that sort in new code, and you will
351e5d869e5ac1 Al Viro           2019-08-03  170  	 * really regret it.  Just ask yourself - what could a BOFH
351e5d869e5ac1 Al Viro           2019-08-03  171  	 * do to me and do I want to find it out first-hand?
351e5d869e5ac1 Al Viro           2019-08-03  172  	 *
351e5d869e5ac1 Al Viro           2019-08-03  173  	 *  AV, a thoroughly annoyed bastard.
351e5d869e5ac1 Al Viro           2019-08-03  174  	 */
351e5d869e5ac1 Al Viro           2019-08-03  175  	inode_unlock(dir);
1b25dea3867abc Al Viro           2025-09-04  176  	ret = get_target(symname, &target_item, dentry->d_sb);
351e5d869e5ac1 Al Viro           2019-08-03  177  	inode_lock(dir);
7063fbf2261194 Joel Becker       2005-12-15  178  	if (ret)
7063fbf2261194 Joel Becker       2005-12-15  179  		goto out_put;
7063fbf2261194 Joel Becker       2005-12-15  180  
351e5d869e5ac1 Al Viro           2019-08-03  181  	if (dentry->d_inode || d_unhashed(dentry))
351e5d869e5ac1 Al Viro           2019-08-03  182  		ret = -EEXIST;
351e5d869e5ac1 Al Viro           2019-08-03  183  	else
4609e1f18e19c3 Christian Brauner 2023-01-13  184  		ret = inode_permission(&nop_mnt_idmap, dir,
47291baa8ddfda Christian Brauner 2021-01-21  185  				       MAY_WRITE | MAY_EXEC);
351e5d869e5ac1 Al Viro           2019-08-03  186  	if (!ret)
7063fbf2261194 Joel Becker       2005-12-15  187  		ret = type->ct_item_ops->allow_link(parent_item, target_item);
e7520651750446 Louis Rilling     2008-06-12  188  	if (!ret) {
9a73d78cda750f Louis Rilling     2008-06-20  189  		mutex_lock(&configfs_symlink_mutex);
7063fbf2261194 Joel Becker       2005-12-15  190  		ret = create_link(parent_item, target_item, dentry);
9a73d78cda750f Louis Rilling     2008-06-20  191  		mutex_unlock(&configfs_symlink_mutex);
e7520651750446 Louis Rilling     2008-06-12  192  		if (ret && type->ct_item_ops->drop_link)
e7520651750446 Louis Rilling     2008-06-12  193  			type->ct_item_ops->drop_link(parent_item,
e7520651750446 Louis Rilling     2008-06-12  194  						     target_item);
e7520651750446 Louis Rilling     2008-06-12  195  	}
7063fbf2261194 Joel Becker       2005-12-15  196  
7063fbf2261194 Joel Becker       2005-12-15  197  	config_item_put(target_item);
7063fbf2261194 Joel Becker       2005-12-15  198  
7063fbf2261194 Joel Becker       2005-12-15  199  out_put:
7063fbf2261194 Joel Becker       2005-12-15  200  	config_item_put(parent_item);
7063fbf2261194 Joel Becker       2005-12-15  201  	return ret;
7063fbf2261194 Joel Becker       2005-12-15  202  }
7063fbf2261194 Joel Becker       2005-12-15  203  

:::::: The code at line 136 was first introduced by commit
:::::: 2a109f2a4155f168047aa2f5b3a170e279bef89a [PATCH] configfs: Prevent userspace from creating new entries under attaching directories

:::::: TO: Louis Rilling <louis.rilling@kerlabs.com>
:::::: CC: Mark Fasheh <mfasheh@suse.com>

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
