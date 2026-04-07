Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0FA376473;
	Tue,  7 Apr 2026 03:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775534328; cv=none; b=HkG6m4u17ysJTX/kGrr7EGLb+gaAGSeDnFU0ZSCiOT5x81yQvzhguzH5jVxn0z5VjSs1sP6t1qRKeWjHo8saoCRKDsa9ZXwrvHkmKLd52qjbqOBikGtHKFinTvUZbfRxn922ELzKabWBqbE/ud5irmoEOjRbt2sKK+pbs9HTbxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775534328; c=relaxed/simple;
	bh=y2iFZ0SurY4MbFcFrBOqLW6QkldmAsQ1WYr8ez5K3kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVph2LCOWyrjjipFdj/N/qqMCtsM2RJibbD5MVxBoGsi0i5I/VQ1o9W+IJT4rJ0YYMbkYdtYEYvObWewqlZO7gkEj+qBDkSFm5rnzWaj89g/vBxK0QLlRtI2ZSH7y3zm7h9Y1eNOfQ3AmH6l97srxTsu2KK8eWe7INyOehbAPSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mWFo5ET/; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mWFo5ET/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775534327; x=1807070327;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y2iFZ0SurY4MbFcFrBOqLW6QkldmAsQ1WYr8ez5K3kk=;
  b=mWFo5ET/s/ptGAVUjF45bSkevMjnZKC3PXsFGZH8Kyi8KWatLHHLkrbM
   RKBTUKPM85DrhYhtLM1AGIw0Ru8dI42PemCUKoHigOZLYuXgyRK5DMUbu
   6hS5/Fx4h3imZ1/BAzSfnlovEEiGFSVNO7He8mZ9qHl8GtFR1M32SyPf+
   t/X33AytWyQo64s1hLsBqcNICNj4zRVdU4zuNOAlmF+Ika8l4penDCFEA
   Z9rvwY+2VB0A8NGeCwOwBlfyeLSFG2GpXOOjD3lZPRLYNJ6bEwlZBKX3N
   8elmF8RYmhksvJrwGRXH1rw38aXIihlr0/Xk5lB5IyBLauzoxNeHkxebA
   Q==;
X-CSE-ConnectionGUID: 0Rw38cH7TmO1edzw5wau7w==
X-CSE-MsgGUID: j9l38C6PSs+a8CRy09Er3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="76369572"
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="76369572"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 20:58:38 -0700
X-CSE-ConnectionGUID: nXJVoX5VQbGOjHUypIU9AQ==
X-CSE-MsgGUID: PUojt7YMSTC4zBjeIQuxrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="232091286"
Received: from lkp-server01.sh.intel.com (HELO d00eb8a6782a) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 06 Apr 2026 20:58:36 -0700
Received: from kbuild by d00eb8a6782a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w9xaD-00000000063-0MRf;
	Tue, 07 Apr 2026 03:58:33 +0000
Date: Tue, 7 Apr 2026 11:58:03 +0800
From: kernel test robot <lkp@intel.com>
To: Li Wang <liwang@kylinos.cn>, Miklos Szeredi <miklos@szeredi.hu>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Bernd Schubert <bernd@bsbernd.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Li Wang <liwang@kylinos.cn>
Subject: Re: [PATCH] fuse: Send FORGET over io_uring when ring is ready
Message-ID: <202604051156.TIsmWOyA-lkp@intel.com>
References: <20260401104008.8827-1-liwang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401104008.8827-1-liwang@kylinos.cn>

Hi Li,

kernel test robot noticed the following build errors:

[auto build test ERROR on v7.0-rc6]
[also build test ERROR on linus/master]
[cannot apply to mszeredi-fuse/for-next next-20260403]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-Wang/fuse-Send-FORGET-over-io_uring-when-ring-is-ready/20260405-064557
base:   v7.0-rc6
patch link:    https://lore.kernel.org/r/20260401104008.8827-1-liwang%40kylinos.cn
patch subject: [PATCH] fuse: Send FORGET over io_uring when ring is ready
config: sparc64-randconfig-001-20260405 (https://download.01.org/0day-ci/archive/20260405/202604051156.TIsmWOyA-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project c80443cd37b2e2788cba67ffa180a6331e5f0791)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260405/202604051156.TIsmWOyA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604051156.TIsmWOyA-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/fuse/dev.c:731:15: error: no member named 'abort_on_kill' in 'struct fuse_args'
     731 |         if (!d->args.abort_on_kill)
         |              ~~~~~~~ ^
   1 error generated.


vim +731 fs/fuse/dev.c

   677	
   678	/*
   679	 * Send FUSE_FORGET through the io-uring ring when active; same payload as
   680	 * fuse_read_single_forget(), with userspace committing like any other request.
   681	 */
   682	void fuse_io_uring_send_forget(struct fuse_iqueue *fiq,
   683					struct fuse_forget_link *forget)
   684	{
   685		struct fuse_conn *fc = container_of(fiq, struct fuse_conn, iq);
   686		struct fuse_mount *fm;
   687		struct fuse_req *req;
   688		struct fuse_forget_uring_data *d;
   689	
   690		if (!fuse_uring_ready(fc)) {
   691			fuse_dev_queue_forget(fiq, forget);
   692			return;
   693		}
   694	
   695		down_read(&fc->killsb);
   696		if (list_empty(&fc->mounts)) {
   697			up_read(&fc->killsb);
   698			fuse_dev_queue_forget(fiq, forget);
   699			return;
   700		}
   701		fm = list_first_entry(&fc->mounts, struct fuse_mount, fc_entry);
   702		up_read(&fc->killsb);
   703	
   704		d = kmalloc(sizeof(*d), GFP_KERNEL);
   705		if (!d)
   706			goto fallback;
   707	
   708		atomic_inc(&fc->num_waiting);
   709		req = fuse_request_alloc(fm, GFP_KERNEL);
   710		if (!req) {
   711			kfree(d);
   712			fuse_drop_waiting(fc);
   713			goto fallback;
   714		}
   715	
   716		memset(&d->args, 0, sizeof(d->args));
   717		d->inarg.nlookup = forget->forget_one.nlookup;
   718		d->args.opcode = FUSE_FORGET;
   719		d->args.nodeid = forget->forget_one.nodeid;
   720		d->args.in_numargs = 1;
   721		d->args.in_args[0].size = sizeof(d->inarg);
   722		d->args.in_args[0].value = &d->inarg;
   723		d->args.force = true;
   724		d->args.noreply = true;
   725		d->args.end = fuse_forget_uring_free;
   726	
   727		kfree(forget);
   728	
   729		fuse_force_creds(req);
   730		__set_bit(FR_WAITING, &req->flags);
 > 731		if (!d->args.abort_on_kill)
   732			__set_bit(FR_FORCE, &req->flags);
   733		fuse_adjust_compat(fc, &d->args);
   734		fuse_args_to_req(req, &d->args);
   735		req->in.h.len = sizeof(struct fuse_in_header) +
   736			fuse_len_args(req->args->in_numargs,
   737				      (struct fuse_arg *)req->args->in_args);
   738	
   739		fuse_uring_queue_fuse_req(fiq, req);
   740		return;
   741	
   742	fallback:
   743		fuse_dev_queue_forget(fiq, forget);
   744	}
   745	#endif
   746	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
