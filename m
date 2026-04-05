Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111BC22068D;
	Sun,  5 Apr 2026 02:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775356027; cv=none; b=AsTP/WhrPLJflTsRoL/6gszZ6UKJnYVxm9D+ByFOHg+Bd66cxXm1t3SAPX9cmRfNS903fhlSJUpak0npqaNNH4lmhK4fsLf+HsJUthxeUEzcO+B2433lnG3cFCxHRP9UNLiHPQx+euCWGxsPnHmcLjQAB/KNMR00Dc9ZDdibkWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775356027; c=relaxed/simple;
	bh=4y5TlLE0F6JutpLlnX6j8Xp/QIA+mirx1JvONfapVis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAq0M09vgukMY+LUHrI2GkVDmghL/I4Gjq3sWMhtGbtjYW0cN/cF41ZfAThgGL+b8qD1iFQLpWHlBqSQK9cHl+uID0EbaqMNu3xh9N3jodRoJH3vsOk6SerPIIOt/yYZJqs1kVDh5quyT/GNHSI73YLyA7em1tjCRXuHY9cQbUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jvvuNt9Y; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jvvuNt9Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775356025; x=1806892025;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4y5TlLE0F6JutpLlnX6j8Xp/QIA+mirx1JvONfapVis=;
  b=jvvuNt9Y4EJl0F6TstNNU5Od347fv5EQXoLUgDD2oedsYuSekfvam7CJ
   tsFlaJToGbvoYro1r9CD4DHLu+mscpJVwZ7tg3+1F+DKX0MAoWl+gxN2/
   ZP8/PZRmA3vGMfmp8kmbMC2SyGm/WzXYA+tmEf2OiBT1ygeXYHZdvTJwx
   CB5EVhaM1OErlMzTGtQNxM2NFNxe5HfvH9AhNTqKOZXtQ7YD4LyGdn7ZI
   6EF+aL2xcJ7a6PHiImDEFGmNfzUPpJXFC4OtP76h+9BNsa/clE15QKtv1
   9B/TObP/jYduhcvxch2uJbLoEZGKJ0gXdyPB9IW5WxtXRrz2PB205izEL
   A==;
X-CSE-ConnectionGUID: o3TNH/XcSZmnEeCCM6P0SQ==
X-CSE-MsgGUID: euht4KLPRpOM9oa4eNRj4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11749"; a="87067858"
X-IronPort-AV: E=Sophos;i="6.23,160,1770624000"; 
   d="scan'208";a="87067858"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2026 19:27:04 -0700
X-CSE-ConnectionGUID: wUxwvD4DQry7PhVzA8r6dg==
X-CSE-MsgGUID: V8akI/qQQjWRo9Zijuso3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,160,1770624000"; 
   d="scan'208";a="258057641"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by orviesa002.jf.intel.com with ESMTP; 04 Apr 2026 19:27:03 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w9DCW-000000009jd-1NXD;
	Sun, 05 Apr 2026 02:27:00 +0000
Date: Sun, 5 Apr 2026 04:26:37 +0200
From: kernel test robot <lkp@intel.com>
To: Li Wang <liwang@kylinos.cn>, Miklos Szeredi <miklos@szeredi.hu>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Bernd Schubert <bernd@bsbernd.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Li Wang <liwang@kylinos.cn>
Subject: Re: [PATCH] fuse: Send FORGET over io_uring when ring is ready
Message-ID: <202604050417.m1KBL3ur-lkp@intel.com>
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
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260405/202604050417.m1KBL3ur-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260405/202604050417.m1KBL3ur-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604050417.m1KBL3ur-lkp@intel.com/

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
