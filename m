Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAB4126BF7
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Mar 2026 12:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774702534; cv=none; b=ZJ0aUxFQ9qFF2DnRM+PuoxaUNXl6PgwIy61GIt2WTs+LgwX9D698P7s/EDlso3zlaPP6WCe2Pc8bCa7eJHacvCV0jzoPNOYpeyKm0xHE8Z8B/q6yNUw0Khpt+bHdNtId80VGEMBaH4KhiTPXMxHeJ9VCPbqRNi7TjyZilQue1qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774702534; c=relaxed/simple;
	bh=lqKhZusTlxWaStkhrhG9DXoPubhACuloS9RsyJgXU3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9c5ju1m2ubUD/DTghajEoIBiMi6BsAmYoXt8rfbRDu0HyaWvg5ZCIZUQgXvG3iIsdUSkFWHDZo44mH2S2AyVZGDF6GpLmRr8VSehCa4IS2hcys4exoENeiVsSChuA6PTzDbWBr4izxbi7I7VfnGqqzF3+wnxF9Cm9LzId440/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ht5cyVFr; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ht5cyVFr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774702532; x=1806238532;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lqKhZusTlxWaStkhrhG9DXoPubhACuloS9RsyJgXU3U=;
  b=ht5cyVFrq7KDmIU0uBse7Pkqx1ex0IwCbzmUM+lRI1FC3gfbrYl3AHeQ
   tnlCM/ZTmH0xOEtPmBKAuED8XDWsOP+cTjlbHoCgk8nNBc7Ua073tHyYg
   kVqPIMOptKDWR9ICN8I4EKjWgik+C4kZiTHbmCnLfVxYT+DXRWbpdrC2g
   qgzjSZyUxd4/YwLH1pfbo91ULfXNV3xuzkiqgFwfQhKZuutEJif82z0D+
   7Zmicdul7PvlWWCVAx1mv6XLvLKM9j6ZZG5TQ0JllpgX5gUIVzg4dd15Q
   E+dpzOttBAlacKAAVa3/SAIn9R7FBVxIz3/G/2TD+sVwkbsRGBixO0in4
   g==;
X-CSE-ConnectionGUID: K4Jgf9BtQyOs7L4wrzcphw==
X-CSE-MsgGUID: R5VzMxeRQzecYkj604hKQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="75954488"
X-IronPort-AV: E=Sophos;i="6.23,146,1770624000"; 
   d="scan'208";a="75954488"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2026 05:55:32 -0700
X-CSE-ConnectionGUID: sJZhv7+STkS3Y4UAblWZRg==
X-CSE-MsgGUID: 1YDaTWDdTh+KRI5uBi5Q+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,146,1770624000"; 
   d="scan'208";a="222703510"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 28 Mar 2026 05:55:30 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w6TCJ-00000000BQP-2WVh;
	Sat, 28 Mar 2026 12:55:27 +0000
Date: Sat, 28 Mar 2026 20:54:46 +0800
From: kernel test robot <lkp@intel.com>
To: Joanne Koong <joannelkoong@gmail.com>, axboe@kernel.dk
Cc: oe-kbuild-all@lists.linux.dev, miklos@szeredi.hu, bschubert@ddn.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1 7/9] fuse: add io-uring kernel-managed buffer ring
Message-ID: <202603282050.aq4eO74Y-lkp@intel.com>
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
config: hexagon-randconfig-r071-20260328 (https://download.01.org/0day-ci/archive/20260328/202603282050.aq4eO74Y-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 054e11d1a17e5ba88bb1a8ef32fad3346e80b186)
smatch: v0.5.0-9004-gb810ac53
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260328/202603282050.aq4eO74Y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603282050.aq4eO74Y-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/fuse/trace.c:6:
>> fs/fuse/dev_uring_i.h:63:16: error: field has incomplete type 'struct kvec'
      63 |                         struct kvec payload_kvec;
         |                                     ^
   include/linux/mm.h:3010:8: note: forward declaration of 'struct kvec'
    3010 | struct kvec;
         |        ^
   1 error generated.
--
   In file included from fs/fuse/dev_uring.c:8:
>> fs/fuse/dev_uring_i.h:63:16: error: field has incomplete type 'struct kvec'
      63 |                         struct kvec payload_kvec;
         |                                     ^
   include/linux/mm.h:3010:8: note: forward declaration of 'struct kvec'
    3010 | struct kvec;
         |        ^
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
>> fs/fuse/dev_uring.c:703:48: error: no member named 'id' in 'struct fuse_ring_ent'
     703 |                         sizeof(struct fuse_uring_req_header) * ent->id;
         |                                                                ~~~  ^
   fs/fuse/dev_uring.c:733:48: error: no member named 'id' in 'struct fuse_ring_ent'
     733 |                         sizeof(struct fuse_uring_req_header) * ent->id;
         |                                                                ~~~  ^
>> fs/fuse/dev_uring.c:771:18: error: no member named 'payload_kvec' in 'struct fuse_ring_ent'
     771 |                 cs->len = ent->payload_kvec.iov_len;
         |                           ~~~  ^
   fs/fuse/dev_uring.c:772:20: error: no member named 'payload_kvec' in 'struct fuse_ring_ent'
     772 |                 cs->kaddr = ent->payload_kvec.iov_base;
         |                             ~~~  ^
   fs/fuse/dev_uring.c:903:8: error: call to undeclared function 'io_ring_buffer_select'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     903 |         sel = io_ring_buffer_select(cmd_to_io_kiocb(ent->cmd), &len,
         |               ^
   fs/fuse/dev_uring.c:903:8: note: did you mean 'io_uring_cmd_buffer_select'?
   include/linux/io_uring/cmd.h:83:18: note: 'io_uring_cmd_buffer_select' declared here
      83 | struct io_br_sel io_uring_cmd_buffer_select(struct io_uring_cmd *ioucmd,
         |                  ^
   fs/fuse/dev_uring.c:903:6: error: assigning to 'struct io_br_sel' from incompatible type 'int'
     903 |         sel = io_ring_buffer_select(cmd_to_io_kiocb(ent->cmd), &len,
         |             ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     904 |                                     ent->queue->bufring.list, issue_flags);
         |                                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/fuse/dev_uring.c:907:11: error: no member named 'kaddr' in 'struct io_br_sel'
     907 |         if (!sel.kaddr)
         |              ~~~ ^
   fs/fuse/dev_uring.c:910:7: error: no member named 'payload_kvec' in 'struct fuse_ring_ent'
     910 |         ent->payload_kvec.iov_base = sel.kaddr;
         |         ~~~  ^
   fs/fuse/dev_uring.c:910:35: error: no member named 'kaddr' in 'struct io_br_sel'
     910 |         ent->payload_kvec.iov_base = sel.kaddr;
         |                                      ~~~ ^
   fs/fuse/dev_uring.c:911:7: error: no member named 'payload_kvec' in 'struct fuse_ring_ent'
     911 |         ent->payload_kvec.iov_len = len;
         |         ~~~  ^
   fs/fuse/dev_uring.c:912:7: error: no member named 'buf_id' in 'struct fuse_ring_ent'
     912 |         ent->buf_id = sel.buf_id;
         |         ~~~  ^
   fs/fuse/dev_uring.c:912:20: error: no member named 'buf_id' in 'struct io_br_sel'
     912 |         ent->buf_id = sel.buf_id;
         |                       ~~~ ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   20 errors generated.


vim +63 fs/fuse/dev_uring_i.h

    38	
    39	/** A fuse ring entry, part of the ring queue */
    40	struct fuse_ring_ent {
    41		union {
    42			/* queue->bufring.enabled == false */
    43			struct {
    44				/* userspace buffers */
    45				struct fuse_uring_req_header __user *headers;
    46				void __user *payload;
    47			};
    48			/* queue->bufring.enabled == true */
    49			struct {
    50				/*
    51				 * unique fixed id for the ent. Used by kernel/server to
    52				 * locate the header data.
    53				 */
    54				unsigned int id;
    55				/*
    56				 * id of the bufring buffer the ent is using for the
    57				 * current request. May differ per-request.
    58				 *
    59				 * this needs to be tracked so we can recycle the buffer
    60				 * back to the ring when the request is done.
    61				 */
    62				unsigned int buf_id;
  > 63				struct kvec payload_kvec;
    64			};
    65		};
    66	
    67		/* the ring queue that owns the request */
    68		struct fuse_ring_queue *queue;
    69	
    70		/* fields below are protected by queue->lock */
    71	
    72		struct io_uring_cmd *cmd;
    73	
    74		struct list_head list;
    75	
    76		enum fuse_ring_req_state state;
    77	
    78		struct fuse_req *fuse_req;
    79	};
    80	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
