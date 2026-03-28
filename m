Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05A78287E
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Mar 2026 13:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774702987; cv=none; b=P7kfvX22Jn6JDEjI6hndXNw77twxpZE5wRweAM5ocyXdtGY0wPWugIvsT0pobFqfSHJ/wqGVPYmeWmoS2Uso5to5JlvlKT1KDeQfnIgrBw9I981qfWYrhgyOe4jAzDh1vB+ZN+b+P+9w4Zy7C42aXSrQeHTLqwWx3q9GquElL2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774702987; c=relaxed/simple;
	bh=mpcl99Y1Wgs2WIaOOGVPg+jte1H/M3NUefB5eQJQNAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5PkrV3VOAtHNug4vnEHP+mhRTcuTdo20aGXPktcRjl27icX3nWKZF+hLUdzV989GKQ8aPRSIiAZqC1/zirq/nbYRshW21nJzhbBkSJaUAnGGXx4U4Cr3ALBAqDNgFFkWQ7/BFenjZp1aFEXFPPhaEwzOMrUxjDAbZsaRXTC4OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X3qi5vFj; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X3qi5vFj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774702986; x=1806238986;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mpcl99Y1Wgs2WIaOOGVPg+jte1H/M3NUefB5eQJQNAU=;
  b=X3qi5vFj+ifiVv2hRS3ewMz1tCiQjs5wOh6+98NxA1Ne2fv7uICacBgH
   RnLEaIf9dW4ktnTubXADnOZlcnYIZ477v1LxqUAtvXV+o76thUY29MzKs
   Ig7cJC+ccTMtweSvFMYlHEk58UpkWWbRwUl3jrLSOQErZ7EeztcxXXWoY
   KQMU/94KPmVh8XOw12opeYP1AUJM38rjfo4gWGZFmAoAyNCicjV4aZFo1
   ADzYbX0OYIZEvoclfqiwIwI8GDrN1GOKVLuPurtPMAXgitHTt0hiyZRzX
   qvUZwRuf32ZGzSMpvVwe9mCFGBuyn89/JUswONTsgSNlAWDyIhZbS6EF7
   A==;
X-CSE-ConnectionGUID: tPP91uTESfOXafoHem3+HA==
X-CSE-MsgGUID: Y+SEVyfOS3iHLzLiYrQYsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="87230956"
X-IronPort-AV: E=Sophos;i="6.23,146,1770624000"; 
   d="scan'208";a="87230956"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2026 06:03:05 -0700
X-CSE-ConnectionGUID: 0BukFwvMS5StND6WXwRgPA==
X-CSE-MsgGUID: z5dM877dSwW4E1p3bV6DCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,146,1770624000"; 
   d="scan'208";a="263514646"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by orviesa001.jf.intel.com with ESMTP; 28 Mar 2026 06:03:03 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w6TJd-000000007fx-0284;
	Sat, 28 Mar 2026 13:03:01 +0000
Date: Sat, 28 Mar 2026 14:02:20 +0100
From: kernel test robot <lkp@intel.com>
To: Joanne Koong <joannelkoong@gmail.com>, axboe@kernel.dk
Cc: oe-kbuild-all@lists.linux.dev, miklos@szeredi.hu, bschubert@ddn.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1 8/9] fuse: add zero-copy over io-uring
Message-ID: <202603281328.m7ticaDV-lkp@intel.com>
References: <20260324224532.3733468-9-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324224532.3733468-9-joannelkoong@gmail.com>

Hi Joanne,

kernel test robot noticed the following build errors:

[auto build test ERROR on mszeredi-fuse/for-next]
[also build test ERROR on linus/master v7.0-rc5 next-20260327]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Joanne-Koong/fuse-separate-next-request-fetching-from-sending-logic/20260328-142620
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git for-next
patch link:    https://lore.kernel.org/r/20260324224532.3733468-9-joannelkoong%40gmail.com
patch subject: [PATCH v1 8/9] fuse: add zero-copy over io-uring
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260328/202603281328.m7ticaDV-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260328/202603281328.m7ticaDV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603281328.m7ticaDV-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/fuse/dev_uring.c: In function 'fuse_uring_req_end':
   fs/fuse/dev_uring.c:132:17: error: implicit declaration of function 'io_buffer_unregister'; did you mean 'io_buffer_unregister_bvec'? [-Wimplicit-function-declaration]
     132 |                 io_buffer_unregister(ent->cmd, ent->id, issue_flags);
         |                 ^~~~~~~~~~~~~~~~~~~~
         |                 io_buffer_unregister_bvec
   fs/fuse/dev_uring.c: In function 'fuse_uring_get_buf_ring_headers':
   fs/fuse/dev_uring.c:317:24: error: implicit declaration of function 'io_uring_registered_mem_region_get' [-Wimplicit-function-declaration]
     317 |         mem_reg_addr = io_uring_registered_mem_region_get(cmd, &nr_pages,
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/fuse/dev_uring.c:317:22: error: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     317 |         mem_reg_addr = io_uring_registered_mem_region_get(cmd, &nr_pages,
         |                      ^
   fs/fuse/dev_uring.c: In function 'fuse_uring_buf_ring_setup':
   fs/fuse/dev_uring.c:356:15: error: implicit declaration of function 'io_uring_buf_ring_pin'; did you mean 'fuse_uring_buf_ring_setup'? [-Wimplicit-function-declaration]
     356 |         err = io_uring_buf_ring_pin(cmd, FUSE_URING_BUFRING_GROUP, issue_flags,
         |               ^~~~~~~~~~~~~~~~~~~~~
         |               fuse_uring_buf_ring_setup
   fs/fuse/dev_uring.c:361:14: error: implicit declaration of function 'io_uring_is_kmbuf_ring' [-Wimplicit-function-declaration]
     361 |         if (!io_uring_is_kmbuf_ring(cmd, FUSE_URING_BUFRING_GROUP, issue_flags))
         |              ^~~~~~~~~~~~~~~~~~~~~~
   fs/fuse/dev_uring.c:372:9: error: implicit declaration of function 'io_uring_buf_ring_unpin'; did you mean 'fuse_uring_buf_ring_setup'? [-Wimplicit-function-declaration]
     372 |         io_uring_buf_ring_unpin(cmd, FUSE_URING_BUFRING_GROUP, issue_flags);
         |         ^~~~~~~~~~~~~~~~~~~~~~~
         |         fuse_uring_buf_ring_setup
   fs/fuse/dev_uring.c: In function 'fuse_uring_set_up_zero_copy':
   fs/fuse/dev_uring.c:859:25: error: 'IO_BUF_DEST' undeclared (first use in this function)
     859 |                 ddir |= IO_BUF_DEST;
         |                         ^~~~~~~~~~~
   fs/fuse/dev_uring.c:859:25: note: each undeclared identifier is reported only once for each function it appears in
   fs/fuse/dev_uring.c:861:25: error: 'IO_BUF_SOURCE' undeclared (first use in this function); did you mean 'ITER_SOURCE'?
     861 |                 ddir |= IO_BUF_SOURCE;
         |                         ^~~~~~~~~~~~~
         |                         ITER_SOURCE
   fs/fuse/dev_uring.c:881:49: error: passing argument 2 of 'io_buffer_register_bvec' from incompatible pointer type [-Wincompatible-pointer-types]
     881 |         err = io_buffer_register_bvec(ent->cmd, bvs, ap->num_folios,
         |                                                 ^~~
         |                                                 |
         |                                                 struct bio_vec *
   In file included from fs/fuse/dev_uring.c:14:
   include/linux/io_uring/cmd.h:185:71: note: expected 'struct request *' but argument is of type 'struct bio_vec *'
     185 | int io_buffer_register_bvec(struct io_uring_cmd *cmd, struct request *rq,
         |                                                       ~~~~~~~~~~~~~~~~^~
   fs/fuse/dev_uring.c:881:56: error: passing argument 3 of 'io_buffer_register_bvec' makes pointer from integer without a cast [-Wint-conversion]
     881 |         err = io_buffer_register_bvec(ent->cmd, bvs, ap->num_folios,
         |                                                      ~~^~~~~~~~~~~~
         |                                                        |
         |                                                        unsigned int
   include/linux/io_uring/cmd.h:186:36: note: expected 'void (*)(void *)' but argument is of type 'unsigned int'
     186 |                             void (*release)(void *), unsigned int index,
         |                             ~~~~~~~^~~~~~~~~~~~~~~~
   fs/fuse/dev_uring.c:882:39: error: passing argument 4 of 'io_buffer_register_bvec' makes integer from pointer without a cast [-Wint-conversion]
     882 |                                       fuse_zero_copy_release, zc_bvs,
         |                                       ^~~~~~~~~~~~~~~~~~~~~~
         |                                       |
         |                                       void (*)(void *)
   include/linux/io_uring/cmd.h:186:67: note: expected 'unsigned int' but argument is of type 'void (*)(void *)'
     186 |                             void (*release)(void *), unsigned int index,
         |                                                      ~~~~~~~~~~~~~^~~~~
   fs/fuse/dev_uring.c:882:63: error: passing argument 5 of 'io_buffer_register_bvec' makes integer from pointer without a cast [-Wint-conversion]
     882 |                                       fuse_zero_copy_release, zc_bvs,
         |                                                               ^~~~~~
         |                                                               |
         |                                                               struct fuse_zero_copy_bvs *
   include/linux/io_uring/cmd.h:187:42: note: expected 'unsigned int' but argument is of type 'struct fuse_zero_copy_bvs *'
     187 |                             unsigned int issue_flags);
         |                             ~~~~~~~~~~~~~^~~~~~~~~~~
>> fs/fuse/dev_uring.c:881:15: error: too many arguments to function 'io_buffer_register_bvec'
     881 |         err = io_buffer_register_bvec(ent->cmd, bvs, ap->num_folios,
         |               ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/io_uring/cmd.h:185:5: note: declared here
     185 | int io_buffer_register_bvec(struct io_uring_cmd *cmd, struct request *rq,
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   fs/fuse/dev_uring.c: In function 'fuse_uring_select_buffer':
   fs/fuse/dev_uring.c:1013:15: error: implicit declaration of function 'io_ring_buffer_select'; did you mean 'io_uring_cmd_buffer_select'? [-Wimplicit-function-declaration]
    1013 |         sel = io_ring_buffer_select(cmd_to_io_kiocb(ent->cmd), &len,
         |               ^~~~~~~~~~~~~~~~~~~~~
         |               io_uring_cmd_buffer_select
   fs/fuse/dev_uring.c:1013:15: error: incompatible types when assigning to type 'struct io_br_sel' from type 'int'
   fs/fuse/dev_uring.c:1017:18: error: 'struct io_br_sel' has no member named 'kaddr'; did you mean 'addr'?
    1017 |         if (!sel.kaddr)
         |                  ^~~~~
         |                  addr
   fs/fuse/dev_uring.c:1020:42: error: 'struct io_br_sel' has no member named 'kaddr'; did you mean 'addr'?
    1020 |         ent->payload_kvec.iov_base = sel.kaddr;
         |                                          ^~~~~
         |                                          addr
   fs/fuse/dev_uring.c:1022:27: error: 'struct io_br_sel' has no member named 'buf_id'; did you mean 'buf_list'?
    1022 |         ent->buf_id = sel.buf_id;
         |                           ^~~~~~
         |                           buf_list
   In file included from arch/x86/include/asm/bug.h:193,
                    from arch/x86/include/asm/alternative.h:9,
                    from arch/x86/include/asm/segment.h:6,
                    from arch/x86/include/asm/ptrace.h:5,
                    from arch/x86/include/asm/math_emu.h:5,
                    from arch/x86/include/asm/processor.h:13,
                    from arch/x86/include/asm/timex.h:5,
                    from include/linux/timex.h:67,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/stat.h:19,
                    from include/linux/fs_dirent.h:5,
                    from include/linux/fs/super_types.h:5,
                    from include/linux/fs/super.h:5,
                    from include/linux/fs.h:5,
                    from fs/fuse/fuse_i.h:17,
                    from fs/fuse/dev_uring.c:7:
   fs/fuse/dev_uring.c: In function 'fuse_uring_recycle_buffer':
   fs/fuse/dev_uring.c:1038:22: error: implicit declaration of function 'io_uring_kmbuf_recycle' [-Wimplicit-function-declaration]
    1038 |         WARN_ON_ONCE(io_uring_kmbuf_recycle(ent->cmd, FUSE_URING_BUFRING_GROUP,
         |                      ^~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/bug.h:120:32: note: in definition of macro 'WARN_ON_ONCE'
     120 |         int __ret_warn_on = !!(condition);                              \
         |                                ^~~~~~~~~


vim +/io_buffer_register_bvec +881 fs/fuse/dev_uring.c

   847	
   848	static int fuse_uring_set_up_zero_copy(struct fuse_ring_ent *ent,
   849					       struct fuse_req *req,
   850					       unsigned issue_flags)
   851	{
   852		struct fuse_args_pages *ap;
   853		int err, i, ddir = 0;
   854		struct fuse_zero_copy_bvs *zc_bvs;
   855		struct bio_vec *bvs;
   856	
   857		/* out_pages indicates a read, in_pages indicates a write */
   858		if (req->args->out_pages)
   859			ddir |= IO_BUF_DEST;
   860		if (req->args->in_pages)
   861			ddir |= IO_BUF_SOURCE;
   862	
   863		WARN_ON_ONCE(!ddir);
   864	
   865		ap = container_of(req->args, typeof(*ap), args);
   866	
   867		zc_bvs = kmalloc(struct_size(zc_bvs, bvs, ap->num_folios),
   868				 GFP_KERNEL_ACCOUNT);
   869		if (!zc_bvs)
   870			return -ENOMEM;
   871	
   872		zc_bvs->nr_bvs = ap->num_folios;
   873		bvs = zc_bvs->bvs;
   874		for (i = 0; i < ap->num_folios; i++) {
   875			bvs[i].bv_page = folio_page(ap->folios[i], 0);
   876			bvs[i].bv_offset = ap->descs[i].offset;
   877			bvs[i].bv_len = ap->descs[i].length;
   878			folio_get(page_folio(bvs[i].bv_page));
   879		}
   880	
 > 881		err = io_buffer_register_bvec(ent->cmd, bvs, ap->num_folios,
 > 882					      fuse_zero_copy_release, zc_bvs,
   883					      ddir, ent->id,
   884					      issue_flags);
   885		if (err) {
   886			fuse_zero_copy_release(zc_bvs);
   887			return err;
   888		}
   889	
   890		ent->zero_copied = true;
   891	
   892		return 0;
   893	}
   894	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
