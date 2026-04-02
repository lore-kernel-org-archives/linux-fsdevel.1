Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBC232F740
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Apr 2026 09:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775121173; cv=none; b=Qe1b9wYOVPeCOQNlBaMF27KovYsilIAcaWdIUNJyeZ5Hw/MJzwYn8ClOGAFF0o5KEIiduJNDDulrLvtUDPFttl0S57GpwrR0rSdUum2GMU6mg6KZk+t9KF0P4aLUVoSw54pNWAqBbOEB7QIye0AN84Z6Mf2t63W937s8fnNqiXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775121173; c=relaxed/simple;
	bh=sEherq6mpoZoc7L3YQ8XNUEWLw9suS70+AlIhcU0vQ8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=RyMlL44kIFiNj9pfyuPkzOGvtZE1fAu7rQuhQ7qxiUgHw2NgEa0OD69L3Y3V+lwlgPRAot7tedICpVkEJVd36TjgOJX1Bq+dRcnP+whFdtxTQ5L35ehnlN4WADrc0IT+WbWAXrYTsSq67ikYYXr1IZpa6vnFIvvC8s3XSXEn+Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=tB2qsyyT; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="tB2qsyyT"
X-KPN-MessageId: 1de1f0af-2e74-11f1-bea8-005056992ed3
Received: from mta.kpnmail.nl (unknown [10.31.161.189])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 1de1f0af-2e74-11f1-bea8-005056992ed3;
	Thu, 02 Apr 2026 11:12:47 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 1e0be50b-2e74-11f1-b5d0-0050569981f5;
	Thu, 02 Apr 2026 11:12:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=YhpNgmP0kyOBY7UtwKYc84SximQyn1kpmW6JvS5K8wc=;
	b=tB2qsyyTYUrZqa/2kDAjA7sID1pamk57hYbeWv42ht799P58cOxDuj9APBgl/z9EtcIaSnZ1TfqAw
	 Xx9Fx0U1hhw8wrROyHEeome3yEBQB3W0ASAVQIL83z8rhhfm2Kfr1NODIzbvqIqxdICbiF82IwV/Fi
	 MM7oC5FysqNxfVvikm1UsLWVU8ClBWA/WEdUJVkTLEpj80PQYZ4e9I5SWohkQYk1f73jxuw8k59PtE
	 rE2GxA1bfuZ6C9oJ8IDmKqDpkOEcKQa8JFl13WRG36r/MnzC5im/XvdqIij1l6w71k0oAobxsmduGt
	 jwP6Tn8SSucjKidGu2U0n/TOLFhBF/Q==
X-KPN-MID: 33|YaZqOUkfv5lEBLIoUEwY7FtowS5+SAP1Z7Oazmx8glMnm1V0O4J0jU/ob5meAxZ
 zTsCisAFrCSmPh0Arknr9Jc9Bqpm6B1NEzE14BFO0waQ=
X-CMASSUN: 33|W6dXBSlPa9VgGlFR26h8LJAMFYxvKMyez48k8C+GPoCcmS/P/TvrtuTimCM+k+c
 GrqOzRUe+jvQ5FwjVCdry1g==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh07 (cpxoxapps-mh07.personalcloud.so.kpn.org [10.128.135.213])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 1e05d7ff-2e74-11f1-b8d7-005056995d6c;
	Thu, 02 Apr 2026 11:12:48 +0200 (CEST)
Date: Thu, 2 Apr 2026 11:12:47 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: kernel test robot <lkp@intel.com>, gregkh@linuxfoundation.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	NeilBrown <neil@brown.name>, Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	"open list:FILESYSTEMS (VFS and infrastructure)"
 <linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Message-ID: <1499602884.918603.1775121167994@kpc.webmail.kpnmail.nl>
In-Reply-To: <202604020519.RLV5cfGp-lkp@intel.com>
References: <20260331173726.3517440-1-jkoolstra@xs4all.nl>
 <202604020519.RLV5cfGp-lkp@intel.com>
Subject: Re: [PATCH] vfs: replace ints with enum component_type for LAST_XXX
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal


> Op 02-04-2026 08:25 CEST schreef kernel test robot <lkp@intel.com>:
> 
>  
> Hi Jori,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on brauner-vfs/vfs.all]
> [also build test ERROR on linus/master viro-vfs/for-next v7.0-rc6 next-20260331]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Jori-Koolstra/vfs-replace-ints-with-enum-component_type-for-LAST_XXX/20260401-024525
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
> patch link:    https://lore.kernel.org/r/20260331173726.3517440-1-jkoolstra%40xs4all.nl
> patch subject: [PATCH] vfs: replace ints with enum component_type for LAST_XXX
> config: hexagon-allmodconfig
> compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
> reproduce (this is a W=1 build):
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202604020519.RLV5cfGp-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> fs/smb/server/vfs.c:71:23: error: incompatible pointer types passing 'int *' to parameter of type 'enum component_type *' [-Werror,-Wincompatible-pointer-types]
>       71 |                                      path, &last, &type,
>          |                                                   ^~~~~
>    include/linux/namei.h:70:68: note: passing argument to parameter 'type' here
>       70 |                            struct path *parent, struct qstr *last, enum component_type *type,
>          |                                                                                         ^
> >> fs/smb/server/vfs.c:76:23: error: use of undeclared identifier 'LAST_NORM'
>       76 |         if (unlikely(type != LAST_NORM)) {
>          |                              ^
>    fs/smb/server/vfs.c:681:32: error: incompatible pointer types passing 'int *' to parameter of type 'enum component_type *' [-Werror,-Wincompatible-pointer-types]
>      681 |                                      &new_path, &new_last, &new_type,
>          |                                                            ^~~~~~~~~
>    include/linux/namei.h:70:68: note: passing argument to parameter 'type' here
>       70 |                            struct path *parent, struct qstr *last, enum component_type *type,
>          |                                                                                         ^
>    3 errors generated.
> 
> 
> vim +71 fs/smb/server/vfs.c
> 
> f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon 2021-03-16   52  
> 4e45cca31d4e70 fs/smb/server/vfs.c NeilBrown   2025-07-24   53  static int ksmbd_vfs_path_lookup(struct ksmbd_share_config *share_conf,
> 74d7970febf7e9 fs/ksmbd/vfs.c      Namjae Jeon 2023-04-21   54  				 char *pathname, unsigned int flags,
> 1ead2213dd7d14 fs/smb/server/vfs.c NeilBrown   2025-11-13   55  				 struct path *path, bool for_remove)
> f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon 2021-03-16   56  {
> 74d7970febf7e9 fs/ksmbd/vfs.c      Namjae Jeon 2023-04-21   57  	struct qstr last;
> 94cb22d109d517 fs/smb/server/vfs.c Al Viro     2025-07-06   58  	const struct path *root_share_path = &share_conf->vfs_path;
> 74d7970febf7e9 fs/ksmbd/vfs.c      Namjae Jeon 2023-04-21   59  	int err, type;
> 74d7970febf7e9 fs/ksmbd/vfs.c      Namjae Jeon 2023-04-21   60  	struct dentry *d;
> f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon 2021-03-16   61  
> 74d7970febf7e9 fs/ksmbd/vfs.c      Namjae Jeon 2023-04-21   62  	if (pathname[0] == '\0') {
> 74d7970febf7e9 fs/ksmbd/vfs.c      Namjae Jeon 2023-04-21   63  		pathname = share_conf->path;
> 74d7970febf7e9 fs/ksmbd/vfs.c      Namjae Jeon 2023-04-21   64  		root_share_path = NULL;
> 74d7970febf7e9 fs/ksmbd/vfs.c      Namjae Jeon 2023-04-21   65  	} else {
> 74d7970febf7e9 fs/ksmbd/vfs.c      Namjae Jeon 2023-04-21   66  		flags |= LOOKUP_BENEATH;
> ff1d57272552e4 fs/cifsd/vfs.c      Namjae Jeon 2021-04-13   67  	}
> f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon 2021-03-16   68  
> 39537a335a6189 fs/smb/server/vfs.c Al Viro     2025-12-14   69  	CLASS(filename_kernel, filename)(pathname);
> 74d7970febf7e9 fs/ksmbd/vfs.c      Namjae Jeon 2023-04-21   70  	err = vfs_path_parent_lookup(filename, flags,
> 4e45cca31d4e70 fs/smb/server/vfs.c NeilBrown   2025-07-24  @71  				     path, &last, &type,
> 74d7970febf7e9 fs/ksmbd/vfs.c      Namjae Jeon 2023-04-21   72  				     root_share_path);
> 4e45cca31d4e70 fs/smb/server/vfs.c NeilBrown   2025-07-24   73  	if (err)
> 74d7970febf7e9 fs/ksmbd/vfs.c      Namjae Jeon 2023-04-21   74  		return err;
> 74d7970febf7e9 fs/ksmbd/vfs.c      Namjae Jeon 2023-04-21   75  
> 74d7970febf7e9 fs/ksmbd/vfs.c      Namjae Jeon 2023-04-21  @76  	if (unlikely(type != LAST_NORM)) {
> 4e45cca31d4e70 fs/smb/server/vfs.c NeilBrown   2025-07-24   77  		path_put(path);
> 74d7970febf7e9 fs/ksmbd/vfs.c      Namjae Jeon 2023-04-21   78  		return -ENOENT;
> 74d7970febf7e9 fs/ksmbd/vfs.c      Namjae Jeon 2023-04-21   79  	}
> 74d7970febf7e9 fs/ksmbd/vfs.c      Namjae Jeon 2023-04-21   80  
> 1ead2213dd7d14 fs/smb/server/vfs.c NeilBrown   2025-11-13   81  	if (for_remove) {
> 4e45cca31d4e70 fs/smb/server/vfs.c NeilBrown   2025-07-24   82  		err = mnt_want_write(path->mnt);
> 864fb5d3716303 fs/smb/server/vfs.c Namjae Jeon 2023-11-20   83  		if (err) {
> 4e45cca31d4e70 fs/smb/server/vfs.c NeilBrown   2025-07-24   84  			path_put(path);
> 864fb5d3716303 fs/smb/server/vfs.c Namjae Jeon 2023-11-20   85  			return -ENOENT;
> 864fb5d3716303 fs/smb/server/vfs.c Namjae Jeon 2023-11-20   86  		}
> 864fb5d3716303 fs/smb/server/vfs.c Namjae Jeon 2023-11-20   87  
> 1ead2213dd7d14 fs/smb/server/vfs.c NeilBrown   2025-11-13   88  		d = start_removing_noperm(path->dentry, &last);
> 74d7970febf7e9 fs/ksmbd/vfs.c      Namjae Jeon 2023-04-21   89  
> 4e45cca31d4e70 fs/smb/server/vfs.c NeilBrown   2025-07-24   90  		if (!IS_ERR(d)) {
> 4e45cca31d4e70 fs/smb/server/vfs.c NeilBrown   2025-07-24   91  			dput(path->dentry);
> 4e45cca31d4e70 fs/smb/server/vfs.c NeilBrown   2025-07-24   92  			path->dentry = d;
> 4e45cca31d4e70 fs/smb/server/vfs.c NeilBrown   2025-07-24   93  			return 0;
> 4e45cca31d4e70 fs/smb/server/vfs.c NeilBrown   2025-07-24   94  		}
> 4e45cca31d4e70 fs/smb/server/vfs.c NeilBrown   2025-07-24   95  		mnt_drop_write(path->mnt);
> 4e45cca31d4e70 fs/smb/server/vfs.c NeilBrown   2025-07-24   96  		path_put(path);
> 4e45cca31d4e70 fs/smb/server/vfs.c NeilBrown   2025-07-24   97  		return -ENOENT;
> 4e45cca31d4e70 fs/smb/server/vfs.c NeilBrown   2025-07-24   98  	}
> 4e45cca31d4e70 fs/smb/server/vfs.c NeilBrown   2025-07-24   99  
> 4e45cca31d4e70 fs/smb/server/vfs.c NeilBrown   2025-07-24  100  	d = lookup_noperm_unlocked(&last, path->dentry);
> 4e45cca31d4e70 fs/smb/server/vfs.c NeilBrown   2025-07-24  101  	if (!IS_ERR(d) && d_is_negative(d)) {
> 4e45cca31d4e70 fs/smb/server/vfs.c NeilBrown   2025-07-24  102  		dput(d);
> 4e45cca31d4e70 fs/smb/server/vfs.c NeilBrown   2025-07-24  103  		d = ERR_PTR(-ENOENT);
> 4e45cca31d4e70 fs/smb/server/vfs.c NeilBrown   2025-07-24  104  	}
> 4e45cca31d4e70 fs/smb/server/vfs.c NeilBrown   2025-07-24  105  	if (IS_ERR(d)) {
> 4e45cca31d4e70 fs/smb/server/vfs.c NeilBrown   2025-07-24  106  		path_put(path);
> 4e45cca31d4e70 fs/smb/server/vfs.c NeilBrown   2025-07-24  107  		return -ENOENT;
> 4e45cca31d4e70 fs/smb/server/vfs.c NeilBrown   2025-07-24  108  	}
> 4e45cca31d4e70 fs/smb/server/vfs.c NeilBrown   2025-07-24  109  	dput(path->dentry);
> 74d7970febf7e9 fs/ksmbd/vfs.c      Namjae Jeon 2023-04-21  110  	path->dentry = d;
> 2b57a4322b1b14 fs/smb/server/vfs.c Namjae Jeon 2023-07-17  111  
> 2b57a4322b1b14 fs/smb/server/vfs.c Namjae Jeon 2023-07-17  112  	if (test_share_config_flag(share_conf, KSMBD_SHARE_FLAG_CROSSMNT)) {
> 2b57a4322b1b14 fs/smb/server/vfs.c Namjae Jeon 2023-07-17  113  		err = follow_down(path, 0);
> 2b57a4322b1b14 fs/smb/server/vfs.c Namjae Jeon 2023-07-17  114  		if (err < 0) {
> 2b57a4322b1b14 fs/smb/server/vfs.c Namjae Jeon 2023-07-17  115  			path_put(path);
> 4e45cca31d4e70 fs/smb/server/vfs.c NeilBrown   2025-07-24  116  			return -ENOENT;
> 2b57a4322b1b14 fs/smb/server/vfs.c Namjae Jeon 2023-07-17  117  		}
> 2b57a4322b1b14 fs/smb/server/vfs.c Namjae Jeon 2023-07-17  118  	}
> 74d7970febf7e9 fs/ksmbd/vfs.c      Namjae Jeon 2023-04-21  119  	return 0;
> f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon 2021-03-16  120  }
> f44158485826c0 fs/cifsd/vfs.c      Namjae Jeon 2021-03-16  121  
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

These should have been resolved in the v2 patch already. I missed the reference in
fs/smb/sever/vfs.c initially. My LSP config was off, probably should've just rg'ed
it in the first place...
