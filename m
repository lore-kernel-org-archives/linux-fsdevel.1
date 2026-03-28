Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7435735AC01
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Mar 2026 12:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774700528; cv=none; b=WTeHzG2hdbBy8AFmnZcodT0T4R9PX50bGocsQDXwVorzlk+wtBuzWTZgm/s67+IySXlI+C44x31mN8w3lEY6j2+W+ZnqyzetBmZAaC8e3BaWgt14wL6V3B038TC9m38NQ2Fqr36F/6O5E8fP4uS3x9WLKJ0g2qYlcA3XceiGWaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774700528; c=relaxed/simple;
	bh=IkvPHua859t3IeHo6zRRRtMeWCP1yGg2uIRI7gPo7lM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyoH4ahrvxKeVp01lUBgX2kiefRdju+Hx8+hbcL6jIJvFKJ+wEI5xx3QiNdCzDsc2nG58upBrSWRav0Tv3ozu9lzWMlTyfljfG/vtozhZ/hyQGvqM6++8QUrMpeIxG7FVDdHEQnRDF6utW2M23sGtyRQhyFijBnzp0T1w7IMlMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ShXy4s5Q; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ShXy4s5Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774700525; x=1806236525;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IkvPHua859t3IeHo6zRRRtMeWCP1yGg2uIRI7gPo7lM=;
  b=ShXy4s5QGY5p/FVtKoYvmxNJx0qOVlXVkobmXP0JRgQtvfjvIg0aUGYc
   mYjSEbuhSDuQgbTXV/lcA0HWmWjhRt4h+iwJmpgPBDA+OQaWZUtOjQD6+
   1xrAAyBHLeGVpZDcrjikQbldIweDKO1jwUr7EvwNdoQGEsh4rQQlv0y51
   GK4FoOjVWqxjls9FOlX1hiQixbEF0oj7ue4icAa9IF7WyCvk/rHBNvJqN
   zRJISfvX+eyydKVXUiEvexT2QY4/HdgaMwjf73DPVCUt5SLQwzxverzee
   sm6E8SvJo+vbhe4DGX4yWcryCCWcitjrIBODh0q+2274X6/ifJzoD75gp
   Q==;
X-CSE-ConnectionGUID: LQBIPnX9RQmJ0BujdS54hA==
X-CSE-MsgGUID: itym+zQnTQK4PgQKHbU16A==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="86834362"
X-IronPort-AV: E=Sophos;i="6.23,146,1770624000"; 
   d="scan'208";a="86834362"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2026 05:22:05 -0700
X-CSE-ConnectionGUID: XpQd/ngTS7ueI+hGGtatJQ==
X-CSE-MsgGUID: MqXuPcG9Rk2H/aRfBWApWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,146,1770624000"; 
   d="scan'208";a="225817318"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by orviesa007.jf.intel.com with ESMTP; 28 Mar 2026 05:22:03 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w6Sfw-000000007fR-2QjO;
	Sat, 28 Mar 2026 12:22:00 +0000
Date: Sat, 28 Mar 2026 13:21:35 +0100
From: kernel test robot <lkp@intel.com>
To: Joanne Koong <joannelkoong@gmail.com>, axboe@kernel.dk
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, miklos@szeredi.hu,
	bschubert@ddn.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1 7/9] fuse: add io-uring kernel-managed buffer ring
Message-ID: <202603281347.IHl1ccbK-lkp@intel.com>
References: <20260324224532.3733468-8-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324224532.3733468-8-joannelkoong@gmail.com>

Hi Joanne,

kernel test robot noticed the following build errors:

[auto build test ERROR on mszeredi-fuse/for-next]
[also build test ERROR on linus/master v7.0-rc5 next-20260327]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Joanne-Koong/fuse-separate-next-request-fetching-from-sending-logic/20260328-142620
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git for-next
patch link:    https://lore.kernel.org/r/20260324224532.3733468-8-joannelkoong%40gmail.com
patch subject: [PATCH v1 7/9] fuse: add io-uring kernel-managed buffer ring
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260328/202603281347.IHl1ccbK-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260328/202603281347.IHl1ccbK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603281347.IHl1ccbK-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/fuse/dev_uring.c:296:17: error: call to undeclared function 'io_uring_registered_mem_region_get'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     296 |         mem_reg_addr = io_uring_registered_mem_region_get(cmd, &nr_pages,
         |                        ^
>> fs/fuse/dev_uring.c:296:15: error: incompatible integer to pointer conversion assigning to 'void *' from 'int' [-Wint-conversion]
     296 |         mem_reg_addr = io_uring_registered_mem_region_get(cmd, &nr_pages,
         |                      ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     297 |                                                           issue_flags);
         |                                                           ~~~~~~~~~~~~
>> fs/fuse/dev_uring.c:334:8: error: call to undeclared function 'io_uring_buf_ring_pin'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     334 |         err = io_uring_buf_ring_pin(cmd, FUSE_URING_BUFRING_GROUP, issue_flags,
         |               ^
>> fs/fuse/dev_uring.c:339:7: error: call to undeclared function 'io_uring_is_kmbuf_ring'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     339 |         if (!io_uring_is_kmbuf_ring(cmd, FUSE_URING_BUFRING_GROUP, issue_flags))
         |              ^
>> fs/fuse/dev_uring.c:349:2: error: call to undeclared function 'io_uring_buf_ring_unpin'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     349 |         io_uring_buf_ring_unpin(cmd, FUSE_URING_BUFRING_GROUP, issue_flags);
         |         ^
   fs/fuse/dev_uring.c:400:4: error: call to undeclared function 'io_uring_buf_ring_unpin'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     400 |                         io_uring_buf_ring_unpin(cmd, FUSE_URING_BUFRING_GROUP,
         |                         ^
>> fs/fuse/dev_uring.c:903:8: error: call to undeclared function 'io_ring_buffer_select'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     903 |         sel = io_ring_buffer_select(cmd_to_io_kiocb(ent->cmd), &len,
         |               ^
   fs/fuse/dev_uring.c:903:8: note: did you mean 'io_uring_cmd_buffer_select'?
   include/linux/io_uring/cmd.h:83:18: note: 'io_uring_cmd_buffer_select' declared here
      83 | struct io_br_sel io_uring_cmd_buffer_select(struct io_uring_cmd *ioucmd,
         |                  ^
>> fs/fuse/dev_uring.c:903:6: error: assigning to 'struct io_br_sel' from incompatible type 'int'
     903 |         sel = io_ring_buffer_select(cmd_to_io_kiocb(ent->cmd), &len,
         |             ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     904 |                                     ent->queue->bufring.list, issue_flags);
         |                                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> fs/fuse/dev_uring.c:907:11: error: no member named 'kaddr' in 'struct io_br_sel'; did you mean 'addr'?
     907 |         if (!sel.kaddr)
         |                  ^~~~~
         |                  addr
   include/linux/io_uring_types.h:100:16: note: 'addr' declared here
     100 |                 void __user *addr;
         |                              ^
   fs/fuse/dev_uring.c:910:35: error: no member named 'kaddr' in 'struct io_br_sel'; did you mean 'addr'?
     910 |         ent->payload_kvec.iov_base = sel.kaddr;
         |                                          ^~~~~
         |                                          addr
   include/linux/io_uring_types.h:100:16: note: 'addr' declared here
     100 |                 void __user *addr;
         |                              ^
>> fs/fuse/dev_uring.c:912:20: error: no member named 'buf_id' in 'struct io_br_sel'
     912 |         ent->buf_id = sel.buf_id;
         |                       ~~~ ^
>> fs/fuse/dev_uring.c:928:15: error: call to undeclared function 'io_uring_kmbuf_recycle'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     928 |         WARN_ON_ONCE(io_uring_kmbuf_recycle(ent->cmd, FUSE_URING_BUFRING_GROUP,
         |                      ^
   12 errors generated.


vim +/io_uring_registered_mem_region_get +296 fs/fuse/dev_uring.c

   285	
   286	static void *fuse_uring_get_buf_ring_headers(struct io_uring_cmd *cmd,
   287						     u64 headers_offset,
   288						     unsigned int queue_depth,
   289						     unsigned int issue_flags)
   290	{
   291		void *mem_reg_addr;
   292		u64 mem_reg_size, headers_size;
   293		unsigned nr_pages;
   294	
   295		/* find the headers in the registered memory region */
 > 296		mem_reg_addr = io_uring_registered_mem_region_get(cmd, &nr_pages,
   297								  issue_flags);
   298	
   299		/* server does not have a registered memory region set up */
   300		if (!mem_reg_addr)
   301			return NULL;
   302	
   303		mem_reg_size = (u64)nr_pages * PAGE_SIZE;
   304		if (headers_offset > mem_reg_size)
   305			return NULL;
   306	
   307		/* verify headers fit within memory region bounds */
   308		headers_size = (u64)queue_depth * sizeof(struct fuse_uring_req_header);
   309		if (mem_reg_size - headers_offset < headers_size)
   310			return NULL;
   311	
   312		return mem_reg_addr + headers_offset;
   313	}
   314	
   315	static int fuse_uring_buf_ring_setup(struct io_uring_cmd *cmd,
   316					     struct fuse_ring_queue *queue,
   317					     unsigned int issue_flags)
   318	{
   319		const struct fuse_uring_cmd_req *cmd_req =
   320			io_uring_sqe128_cmd(cmd->sqe, struct fuse_uring_cmd_req);
   321		u64 headers_offset = READ_ONCE(cmd_req->init.headers_offset);
   322		unsigned queue_depth = READ_ONCE(cmd_req->init.queue_depth);
   323		void *headers;
   324		int err;
   325	
   326		if (!queue_depth)
   327			return -EINVAL;
   328	
   329		headers = fuse_uring_get_buf_ring_headers(cmd, headers_offset,
   330							  queue_depth, issue_flags);
   331		if (!headers)
   332			return -EINVAL;
   333	
 > 334		err = io_uring_buf_ring_pin(cmd, FUSE_URING_BUFRING_GROUP, issue_flags,
   335					    &queue->bufring.list);
   336		if (err)
   337			return err;
   338	
 > 339		if (!io_uring_is_kmbuf_ring(cmd, FUSE_URING_BUFRING_GROUP, issue_flags))
   340			goto error;
   341	
   342		queue->bufring.headers = headers;
   343		queue->bufring.queue_depth = queue_depth;
   344		queue->bufring.enabled = true;
   345	
   346		return 0;
   347	
   348	error:
 > 349		io_uring_buf_ring_unpin(cmd, FUSE_URING_BUFRING_GROUP, issue_flags);
   350		return -EINVAL;
   351	}
   352	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
