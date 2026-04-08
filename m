Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A22E70830;
	Wed,  8 Apr 2026 05:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775624635; cv=none; b=AaLb88WGaRGAfenHqnH+H0z4M9GoSDdqYzxAI1OBkfxgEfBgOfkYNPwIdxR6FZ4BrKZHnar9GaaAdp4bflQqGdvW73dpvBhy9WCaVssnxxYOcyPKXkmYNriOvQd7kMF8/9YnDV51msxcH/jI6D0uQe9vOuMC+lQPnb3Ep5seE2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775624635; c=relaxed/simple;
	bh=nzKj1JYDVWXdfypihrSWXODLI+7vjEaN/DAreeNUhn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUn0+CDgGjz5vNy2rOhZAkmmuptWQ0j8X2e7dVvHyZtQrFEIBNQhhctALWNopzle+0Bt/PzEXQTFQN8G//kOibCXu1B4p2Rvs2lMP9o+qXuifHQQd04lcayDioRdQek2RWeTJb3kO9RZnaw/az+dWXlqOOZ3R8MJA1Woe+fdh60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=diIsj1vj; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="diIsj1vj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775624634; x=1807160634;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nzKj1JYDVWXdfypihrSWXODLI+7vjEaN/DAreeNUhn4=;
  b=diIsj1vjhXNqZM296a4OHPnFelU/7wUrolhzqMzFBEnEEsUEOWt79Bh6
   nfww9KhgD/koeX5N72kvsOipJhdC4uwV3Hl4k/ZV8kYWNdWU1FyPLisiJ
   hH6fBBRlu3IunAiwPlfxqaC7OvP9rXa9128EljEamogEQh9Phkmm2zrzQ
   gLTKArHoLECtOaCBQ00a3dJA/FhpFOiA3AmdJrrOJ3/mHizJEwKmoIeIp
   hsjIQsKQbaa7iejDVBQavak7rWaz8GJKwDFjoHu723/yrDNvSUhS3RkZu
   uWqoxqYtFWHo1vSMlYidm12g088gtpkHkKwWUeKRzibgAz2QUzZLh3x9p
   g==;
X-CSE-ConnectionGUID: QXkUrDB+QjqA4Nggl7P1IA==
X-CSE-MsgGUID: /Mezk+/KTcyonCxXu0jgxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="87982043"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="87982043"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 22:03:53 -0700
X-CSE-ConnectionGUID: sg7DmW7JS1aZ7LxRPdRRiA==
X-CSE-MsgGUID: TMFdbeG+SruJuCCKBcJl+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="251688363"
Received: from lkp-server01.sh.intel.com (HELO d00eb8a6782a) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 07 Apr 2026 22:03:52 -0700
Received: from kbuild by d00eb8a6782a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wAL4v-000000001Rt-2SJC;
	Wed, 08 Apr 2026 05:03:49 +0000
Date: Wed, 8 Apr 2026 13:03:22 +0800
From: kernel test robot <lkp@intel.com>
To: Li Wang <liwang@kylinos.cn>, Miklos Szeredi <miklos@szeredi.hu>,
	Bernd Schubert <bernd@bsbernd.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Li Wang <liwang@kylinos.cn>
Subject: Re: [PATCH v2] fuse: Send FORGET over io_uring when ring is ready
Message-ID: <202604081238.PU4HPayI-lkp@intel.com>
References: <20260403035752.20206-1-liwang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403035752.20206-1-liwang@kylinos.cn>

Hi Li,

kernel test robot noticed the following build errors:

[auto build test ERROR on v7.0-rc7]
[also build test ERROR on linus/master]
[cannot apply to mszeredi-fuse/for-next next-20260407]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-Wang/fuse-Send-FORGET-over-io_uring-when-ring-is-ready/20260408-015226
base:   v7.0-rc7
patch link:    https://lore.kernel.org/r/20260403035752.20206-1-liwang%40kylinos.cn
patch subject: [PATCH v2] fuse: Send FORGET over io_uring when ring is ready
config: m68k-defconfig (https://download.01.org/0day-ci/archive/20260408/202604081238.PU4HPayI-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260408/202604081238.PU4HPayI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604081238.PU4HPayI-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/fuse/dev_uring.c: In function 'fuse_io_uring_send_forget':
>> fs/fuse/dev_uring.c:1433:21: error: 'struct fuse_args' has no member named 'abort_on_kill'
    1433 |         if (!d->args.abort_on_kill)
         |                     ^


vim +1433 fs/fuse/dev_uring.c

  1378	
  1379	/*
  1380	 * Send FUSE_FORGET through the io-uring ring when active; same payload as
  1381	 * fuse_read_single_forget(), with userspace committing like any other request.
  1382	 * Called from fuse_dev_queue_forget() when fuse_uring_ready().
  1383	 */
  1384	void fuse_io_uring_send_forget(struct fuse_iqueue *fiq,
  1385					struct fuse_forget_link *forget)
  1386	{
  1387		struct fuse_conn *fc = container_of(fiq, struct fuse_conn, iq);
  1388		struct fuse_mount *fm;
  1389		struct fuse_req *req;
  1390		struct fuse_forget_uring_data *d;
  1391	
  1392		if (!fuse_uring_ready(fc)) {
  1393			fuse_dev_queue_forget_list(fiq, forget);
  1394			return;
  1395		}
  1396	
  1397		down_read(&fc->killsb);
  1398		if (list_empty(&fc->mounts)) {
  1399			up_read(&fc->killsb);
  1400			fuse_dev_queue_forget_list(fiq, forget);
  1401			return;
  1402		}
  1403		fm = list_first_entry(&fc->mounts, struct fuse_mount, fc_entry);
  1404		up_read(&fc->killsb);
  1405	
  1406		d = kmalloc(sizeof(*d), GFP_KERNEL);
  1407		if (!d)
  1408			goto fallback;
  1409	
  1410		atomic_inc(&fc->num_waiting);
  1411		req = fuse_request_alloc(fm, GFP_KERNEL);
  1412		if (!req) {
  1413			kfree(d);
  1414			fuse_drop_waiting(fc);
  1415			goto fallback;
  1416		}
  1417	
  1418		memset(&d->args, 0, sizeof(d->args));
  1419		d->inarg.nlookup = forget->forget_one.nlookup;
  1420		d->args.opcode = FUSE_FORGET;
  1421		d->args.nodeid = forget->forget_one.nodeid;
  1422		d->args.in_numargs = 1;
  1423		d->args.in_args[0].size = sizeof(d->inarg);
  1424		d->args.in_args[0].value = &d->inarg;
  1425		d->args.force = true;
  1426		d->args.noreply = true;
  1427		d->args.end = fuse_forget_uring_free;
  1428	
  1429		kfree(forget);
  1430	
  1431		fuse_force_creds(req);
  1432		__set_bit(FR_WAITING, &req->flags);
> 1433		if (!d->args.abort_on_kill)
  1434			__set_bit(FR_FORCE, &req->flags);
  1435		fuse_adjust_compat(fc, &d->args);
  1436		fuse_args_to_req(req, &d->args);
  1437		req->in.h.len = sizeof(struct fuse_in_header) +
  1438			fuse_len_args(req->args->in_numargs,
  1439				      (struct fuse_arg *)req->args->in_args);
  1440	
  1441		fuse_uring_queue_fuse_req(fiq, req);
  1442		return;
  1443	
  1444	fallback:
  1445		fuse_dev_queue_forget_list(fiq, forget);
  1446	}
  1447	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
