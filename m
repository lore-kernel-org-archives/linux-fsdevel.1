Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEDF377017;
	Tue,  7 Apr 2026 03:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775534326; cv=none; b=O8KoamZn6L+KBkSUJ7LyKbTelUZm6XH10ucXX1VgFTKvQ9uyIoHaUs1RM16plD2x9lsLgvVOXjbh80PFfvuDxfh2n9IA8nafDl0IljLcVCkaoLB0ruRM57RKZ5RmivoSiIbfdMHTptOCT0wDdkxZzs3M+t2vmm3IJ1g2fN6wYd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775534326; c=relaxed/simple;
	bh=PhLz4EawfqMG2HCkLS4Mk1S4X4ao3m4Ud6DBoFfSSZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRULLtxM+8aq/TlFMuiwdYDsKeo+MyQxgGCrhIMVyPrtTCXBWxfxJnBwYJqDu3xdemwqDm7ubEH2e8gp6J8009fhis2uqCLgwEC5s4afWpTk3GyMJ83vHrUnD6+3HF+wGjTO8qacsufqvPVLOK7NJ24GM+6QC1bkKxY1+efHLxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GRJLC/GZ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GRJLC/GZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775534322; x=1807070322;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PhLz4EawfqMG2HCkLS4Mk1S4X4ao3m4Ud6DBoFfSSZQ=;
  b=GRJLC/GZ++1uW6dJfK8Jp8aqXk5a5bVeBmPFqZQt7+tpPcc9VVXasbyh
   yLLwlw0L0Jqcf4QRUqxAEAbIIRZvy0d/4/oGfk53XYZRLF6r7vzPR8jLh
   usRneAAHxqofNOkiY6UtFgBsNL5etzaB4qeX8hLFP/tAQR+CEcj/FFnMu
   rTjgDy/97pAwuBW2nBP1p8usBO7VGGaBZr17yDyS6Q8mWJgS/TP3RWBp+
   jC2jAQKrHk024GU04jbnlCHWU4hfNzgXTmW9DJDQL8DJd4IQTHRsEcGIn
   UM81pqkSV4ZTFYREbLnQSQ39VXBGF3DEf5lNKA4e2gHFRr/seTtwkm6/v
   A==;
X-CSE-ConnectionGUID: Ddz0Mkj0R/6bVPOY1Fjflg==
X-CSE-MsgGUID: e8vajh9/R0i2ZCYuzmSwxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="76369568"
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="76369568"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 20:58:38 -0700
X-CSE-ConnectionGUID: ohz4hObdSmWTxzmWqAuitw==
X-CSE-MsgGUID: oF+O2C2XSHiEGYkkJdZiOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="232091284"
Received: from lkp-server01.sh.intel.com (HELO d00eb8a6782a) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 06 Apr 2026 20:58:36 -0700
Received: from kbuild by d00eb8a6782a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w9xaD-00000000061-0GzJ;
	Tue, 07 Apr 2026 03:58:33 +0000
Date: Tue, 7 Apr 2026 11:57:54 +0800
From: kernel test robot <lkp@intel.com>
To: Li Wang <liwang@kylinos.cn>, Miklos Szeredi <miklos@szeredi.hu>
Cc: oe-kbuild-all@lists.linux.dev, Bernd Schubert <bernd@bsbernd.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Li Wang <liwang@kylinos.cn>
Subject: Re: [PATCH] fuse: Send FORGET over io_uring when ring is ready
Message-ID: <202604050807.AgGX2Wf1-lkp@intel.com>
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
config: sparc-randconfig-002-20260405 (https://download.01.org/0day-ci/archive/20260405/202604050807.AgGX2Wf1-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 12.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260405/202604050807.AgGX2Wf1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604050807.AgGX2Wf1-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/fuse/dev.c: In function 'fuse_io_uring_send_forget':
>> fs/fuse/dev.c:731:21: error: 'struct fuse_args' has no member named 'abort_on_kill'
     731 |         if (!d->args.abort_on_kill)
         |                     ^


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
