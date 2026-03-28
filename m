Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FBC26ED33
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Mar 2026 13:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774706047; cv=none; b=PvlyJCC0/X5m5xZrc9fEtobo12j0HFOuH+tYL1W7HmOjSB0h1EE92T4lf+JOtKvPZC0lgCfNfYQpCC9XtklP47+OORN11Q8ZrFtJE+SO2rPpsnPIeL6VgVhtkaW7WdmXQQkDfkhzO6T8Lrg7OVJEhI6pxuRmYgrpjgcbbFj3Gig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774706047; c=relaxed/simple;
	bh=YVYCGntBvyIjUxMBKGP5U7zMPbdGlUZrGABdfrJgNn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQ2xgt3Ply8TM1fpsfpC6w3vpdAwO1xokKbFWWSzUQNXrQHYXFxmcVeXK8rCK0GEunW5ZCfWy4pbasDeWb+ABMSCYcY/AAeBCdvzyDTumVvJgT7mn2SmEwm7LI74B9/sA6v5AumfJ70Dvg3sAwRh+r+DSl9PoGQx+0rXnfAHRws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MWbzyuNv; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MWbzyuNv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774706046; x=1806242046;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YVYCGntBvyIjUxMBKGP5U7zMPbdGlUZrGABdfrJgNn8=;
  b=MWbzyuNv4VwvzxPeZv0FoM72h5XDaoH3FUXGwYFKSdvLoYftqZciBkS0
   ulhtcNlWiG1Dz7yYCKoZGWKxaX4mHsl+H4lrcaeHqFWwKnNlzTe2kF6gU
   vLlU9wMrQCPruoGGZ9eFwxNztsaS7ARPXWCT1yRJb4x8ARG8/U/PHe5nM
   GAROcAe/q/G0o2+HhrsVgLVEFsOz87elxRWgY48UgeJnqrZJoTk4ccSrL
   fQr+cQL5D0QycZwd3DMmcDv/Te5qT1DCs8eAkUCwRJPHiOvkLJnX/Ro5/
   d0r8FxpJSn0R3FB5zHMOZZUanfz+GYiEeMeanqwzZXc8Dlg0tACvtOnrF
   w==;
X-CSE-ConnectionGUID: 4EXlzzvvSDy6ce+rNUryfg==
X-CSE-MsgGUID: VJdHPLUKQEaeB/KA3qzucQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="75956181"
X-IronPort-AV: E=Sophos;i="6.23,146,1770624000"; 
   d="scan'208";a="75956181"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2026 06:54:05 -0700
X-CSE-ConnectionGUID: N4Wz+Lj9QBSno9x8XrH+sA==
X-CSE-MsgGUID: 9hGTh2o3Ql6nYYjatSirrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,146,1770624000"; 
   d="scan'208";a="248812701"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by fmviesa001.fm.intel.com with ESMTP; 28 Mar 2026 06:54:04 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w6U6z-000000007gP-1bAH;
	Sat, 28 Mar 2026 13:54:01 +0000
Date: Sat, 28 Mar 2026 14:53:10 +0100
From: kernel test robot <lkp@intel.com>
To: Joanne Koong <joannelkoong@gmail.com>, axboe@kernel.dk
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, miklos@szeredi.hu,
	bschubert@ddn.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1 8/9] fuse: add zero-copy over io-uring
Message-ID: <202603281401.HP3uX5G1-lkp@intel.com>
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
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260328/202603281401.HP3uX5G1-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260328/202603281401.HP3uX5G1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603281401.HP3uX5G1-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/fuse/dev_uring.c:132:3: error: call to undeclared function 'io_buffer_unregister'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     132 |                 io_buffer_unregister(ent->cmd, ent->id, issue_flags);
         |                 ^
   fs/fuse/dev_uring.c:132:3: note: did you mean 'io_buffer_unregister_bvec'?
   include/linux/io_uring/cmd.h:188:5: note: 'io_buffer_unregister_bvec' declared here
     188 | int io_buffer_unregister_bvec(struct io_uring_cmd *cmd, unsigned int index,
         |     ^
   fs/fuse/dev_uring.c:317:17: error: call to undeclared function 'io_uring_registered_mem_region_get'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     317 |         mem_reg_addr = io_uring_registered_mem_region_get(cmd, &nr_pages,
         |                        ^
   fs/fuse/dev_uring.c:317:15: error: incompatible integer to pointer conversion assigning to 'void *' from 'int' [-Wint-conversion]
     317 |         mem_reg_addr = io_uring_registered_mem_region_get(cmd, &nr_pages,
         |                      ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     318 |                                                           issue_flags);
         |                                                           ~~~~~~~~~~~~
   fs/fuse/dev_uring.c:356:8: error: call to undeclared function 'io_uring_buf_ring_pin'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     356 |         err = io_uring_buf_ring_pin(cmd, FUSE_URING_BUFRING_GROUP, issue_flags,
         |               ^
   fs/fuse/dev_uring.c:361:7: error: call to undeclared function 'io_uring_is_kmbuf_ring'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     361 |         if (!io_uring_is_kmbuf_ring(cmd, FUSE_URING_BUFRING_GROUP, issue_flags))
         |              ^
   fs/fuse/dev_uring.c:372:2: error: call to undeclared function 'io_uring_buf_ring_unpin'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     372 |         io_uring_buf_ring_unpin(cmd, FUSE_URING_BUFRING_GROUP, issue_flags);
         |         ^
   fs/fuse/dev_uring.c:425:4: error: call to undeclared function 'io_uring_buf_ring_unpin'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     425 |                         io_uring_buf_ring_unpin(cmd, FUSE_URING_BUFRING_GROUP,
         |                         ^
>> fs/fuse/dev_uring.c:859:11: error: use of undeclared identifier 'IO_BUF_DEST'
     859 |                 ddir |= IO_BUF_DEST;
         |                         ^
>> fs/fuse/dev_uring.c:861:11: error: use of undeclared identifier 'IO_BUF_SOURCE'
     861 |                 ddir |= IO_BUF_SOURCE;
         |                         ^
>> fs/fuse/dev_uring.c:883:11: error: too many arguments to function call, expected 5, have 8
     881 |         err = io_buffer_register_bvec(ent->cmd, bvs, ap->num_folios,
         |               ~~~~~~~~~~~~~~~~~~~~~~~
     882 |                                       fuse_zero_copy_release, zc_bvs,
     883 |                                       ddir, ent->id,
         |                                       ^~~~~~~~~~~~~~
     884 |                                       issue_flags);
         |                                       ~~~~~~~~~~~
   include/linux/io_uring/cmd.h:185:5: note: 'io_buffer_register_bvec' declared here
     185 | int io_buffer_register_bvec(struct io_uring_cmd *cmd, struct request *rq,
         |     ^                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     186 |                             void (*release)(void *), unsigned int index,
         |                             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     187 |                             unsigned int issue_flags);
         |                             ~~~~~~~~~~~~~~~~~~~~~~~~
   fs/fuse/dev_uring.c:1013:8: error: call to undeclared function 'io_ring_buffer_select'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1013 |         sel = io_ring_buffer_select(cmd_to_io_kiocb(ent->cmd), &len,
         |               ^
   fs/fuse/dev_uring.c:1013:8: note: did you mean 'io_uring_cmd_buffer_select'?
   include/linux/io_uring/cmd.h:83:18: note: 'io_uring_cmd_buffer_select' declared here
      83 | struct io_br_sel io_uring_cmd_buffer_select(struct io_uring_cmd *ioucmd,
         |                  ^
   fs/fuse/dev_uring.c:1013:6: error: assigning to 'struct io_br_sel' from incompatible type 'int'
    1013 |         sel = io_ring_buffer_select(cmd_to_io_kiocb(ent->cmd), &len,
         |             ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1014 |                                     ent->queue->bufring.list, issue_flags);
         |                                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/fuse/dev_uring.c:1017:11: error: no member named 'kaddr' in 'struct io_br_sel'; did you mean 'addr'?
    1017 |         if (!sel.kaddr)
         |                  ^~~~~
         |                  addr
   include/linux/io_uring_types.h:100:16: note: 'addr' declared here
     100 |                 void __user *addr;
         |                              ^
   fs/fuse/dev_uring.c:1020:35: error: no member named 'kaddr' in 'struct io_br_sel'; did you mean 'addr'?
    1020 |         ent->payload_kvec.iov_base = sel.kaddr;
         |                                          ^~~~~
         |                                          addr
   include/linux/io_uring_types.h:100:16: note: 'addr' declared here
     100 |                 void __user *addr;
         |                              ^
   fs/fuse/dev_uring.c:1022:20: error: no member named 'buf_id' in 'struct io_br_sel'
    1022 |         ent->buf_id = sel.buf_id;
         |                       ~~~ ^
   fs/fuse/dev_uring.c:1038:15: error: call to undeclared function 'io_uring_kmbuf_recycle'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1038 |         WARN_ON_ONCE(io_uring_kmbuf_recycle(ent->cmd, FUSE_URING_BUFRING_GROUP,
         |                      ^
   16 errors generated.


vim +/io_buffer_unregister +132 fs/fuse/dev_uring.c

   110	
   111	static void fuse_uring_req_end(struct fuse_ring_ent *ent, struct fuse_req *req,
   112				       int error, unsigned issue_flags)
   113	{
   114		struct fuse_ring_queue *queue = ent->queue;
   115		struct fuse_ring *ring = queue->ring;
   116		struct fuse_conn *fc = ring->fc;
   117	
   118		lockdep_assert_not_held(&queue->lock);
   119		spin_lock(&queue->lock);
   120		ent->fuse_req = NULL;
   121		list_del_init(&req->list);
   122		if (test_bit(FR_BACKGROUND, &req->flags)) {
   123			queue->active_background--;
   124			spin_lock(&fc->bg_lock);
   125			fuse_uring_flush_bg(queue);
   126			spin_unlock(&fc->bg_lock);
   127		}
   128	
   129		spin_unlock(&queue->lock);
   130	
   131		if (ent->zero_copied) {
 > 132			io_buffer_unregister(ent->cmd, ent->id, issue_flags);
   133			ent->zero_copied = false;
   134		}
   135	
   136		if (error)
   137			req->out.h.error = error;
   138	
   139		clear_bit(FR_SENT, &req->flags);
   140		fuse_request_end(req);
   141	}
   142	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
