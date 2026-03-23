Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE42D368972
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 07:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774252783; cv=none; b=b74IncwL2dxYFXc/M+ZtGKQG3ucRgJEsXV5OAoBaatXCK/cjGtspCXopMVbHRhSpEcdQfLtuoJ008iCh2+SffGayDnl2fv1zVYJwdrgLwer3vjYUJE6P1IxaqATXEJm8z+McFkzV/iyyivW4BCjqZGG26zPhyz/mg7S5cAna7B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774252783; c=relaxed/simple;
	bh=ZK4S2koWfvvbFCmInI+xOvEDaGvIpkJ+5gTQ4xr1f4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GF4vztjLxXxrhg5qiwP7WOOcY5ISYG3y3H189vZ1kkrIqHU8gH/XWGpXS/hL2Ygzvn8eztZCwdOHWNiD4b5MXBnefnBh+jY+4Zua4qzyCtW0RzaUBttiTlYO/XMU3EqA+6APLK8POiQ40Ga4lO/g6Ygpx5r22CZtsM971sz3S/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yfk4T06x; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yfk4T06x"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-439af7d77f0so2829970f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 00:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774252779; x=1774857579; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u9TDw557HHr9QxeSzljvTvjTyUstusLez8TY6c03rPs=;
        b=Yfk4T06x4gWPreMk7S52u9PqLcXCd86Q5Jmido0KgaYpogUmxkv3uqvUExf+/WX0gP
         XJNNgAGQl4h7/W+X44e4leu/qF76J1Nkq7GCpJwPQhcdLd8opKRwSuk5j25dH9BpWAi8
         AXw1cW0nSJVUkNONsLG0xITly2RwPvGflDuc1ArkdSThieAhfaJrnd8IefZwxJwDxoQs
         j5YkcIpqiKR2/inUmYKuzaGZUEVOPFXsY1luDwLB/1asrR8/AiNWGhT7o0PHpMvPx6tx
         ecbKd8BHWfq7QZhEDy/nOGJetyjCjEHHtQUjhnsztpBgu70wMuNElhlRMxKDGmVaGhvg
         bhxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774252779; x=1774857579;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9TDw557HHr9QxeSzljvTvjTyUstusLez8TY6c03rPs=;
        b=NPomSc0e7YLDdpBFfsNlXY8LBlNqzi9pR13sxMfHKQhasCdM2n+UockxPO55p86Znr
         5LGlad7iHM/Hm9IzezSfh3rY+VKLLoQHsXpp3yuLvOR2+vfyeScqUc/0Ldwrbjr7Fmyz
         pouyCAsxauJ6hDTuqIicTfvkC6UBG3O+E6g8cqw54YlZFcnC1SPAlxvm9yk1l/SXrO0K
         NcG/1xSWHNlOnsr02N+xNzn0hmhYLaX7x1ljWE+F+e1UTLl6zQiuWXulVbzcpMCnKzqD
         B2lqJixoM+QBceeuu+RZVIjdmAHAWuY/UOxE1jRRNARKWeDCb1Sz7wkZvShbiSbgUvRO
         ax3w==
X-Forwarded-Encrypted: i=1; AJvYcCWC7Empo81U+aw/WxqfXYkRjOvjaC6BKTN0tV/3X9FThL6d6Zpacipln7DKD0Ri1k2k2Ettb4yqGrDtVwZw@vger.kernel.org
X-Gm-Message-State: AOJu0YxD7bvTyJfywOj/0ED9vHsD88tq2DXrhuANRSVs4yZJUjePJSIQ
	IUcnWVKHiYsb7FeeYHzlQ+rdBF9NUkJ42KdvIENyir6+LmW9wQBvzK5xd422NkJfvqc=
X-Gm-Gg: ATEYQzzA30G2lBr1XlgXI6ulZ/b2e67XWcYNHss864BvplKOkzogIaSfH4CLeS7dsgY
	mmx1768B/pUvm0eGNZW0GrYr55V3kXU0KPQZ1BgDPlOHvO/+yRVOaf9MHpmA076mrTR8/Lzak/g
	32JCpqv80hkjtZZQkA6HHsKLcRBLEzwKNcg0WX+/FDpP62bugJhiwWvHqApTiS0lO98WdGUMnq6
	jo6X6XCUfA2zmJqv6tSKZnw2u8V3ExkT24sse71HW0S3haxbGGkW22gdhE8lBBED1PU0O7vbWP/
	UtAPNQ4XwLhrw7cIMaARuA+XR9UNPZeqBN13Sye6tc57UX6sqqquEnP6SDstbKR6WDzK5NKrcOF
	ocujY6lhpeVPY5Qm9xtX5BfXLoR9ldwvB+fbNWSFLNDbaYJsnlVJ6rrequvvb0kx+HpSQJ/wKnr
	5u9wnKgYtGMWEYCm6MOUfIEFLBYFWw
X-Received: by 2002:a05:6000:2889:b0:43b:4f97:9608 with SMTP id ffacd0b85a97d-43b6423a2d0mr18921847f8f.14.1774252779046;
        Mon, 23 Mar 2026 00:59:39 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae016sm26289900f8f.4.2026.03.23.00.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 00:59:38 -0700 (PDT)
Date: Mon, 23 Mar 2026 10:59:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, David Timber <dxdt@dev.snart.me>,
	linkinjeon@kernel.org, sj1557.seo@samsung.com
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, yuezhang.mo@sony.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Timber <dxdt@dev.snart.me>
Subject: Re: [PATCH v0 1/1] exfat: add limited FALLOC_FL_ZERO_RANGE support
Message-ID: <202603221252.dVVrrOrL-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319043553.301185-2-dxdt@dev.snart.me>

Hi David,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Timber/exfat-add-limited-FALLOC_FL_ZERO_RANGE-support/20260319-185700
base:   next-20260318
patch link:    https://lore.kernel.org/r/20260319043553.301185-2-dxdt%40dev.snart.me
patch subject: [PATCH v0 1/1] exfat: add limited FALLOC_FL_ZERO_RANGE support
config: i386-randconfig-141-20260322 (https://download.01.org/0day-ci/archive/20260322/202603221252.dVVrrOrL-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
smatch: v0.5.0-9004-gb810ac53

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202603221252.dVVrrOrL-lkp@intel.com/

smatch warnings:
fs/exfat/file.c:183 exfat_fallocate() warn: inconsistent returns '&inode->i_rwsem'.

vim +183 fs/exfat/file.c

bf1797960c20f3d David Timber 2026-02-28  107  static long exfat_fallocate(struct file *file, int mode,
bf1797960c20f3d David Timber 2026-02-28  108  			  loff_t offset, loff_t len)
bf1797960c20f3d David Timber 2026-02-28  109  {
bf1797960c20f3d David Timber 2026-02-28  110  	struct inode *inode = file->f_mapping->host;
1178dacb657facf David Timber 2026-03-19  111  	loff_t newsize, isize;
bf1797960c20f3d David Timber 2026-02-28  112  	int err = 0;
bf1797960c20f3d David Timber 2026-02-28  113  
bf1797960c20f3d David Timber 2026-02-28  114  	/* No support for other modes */
1178dacb657facf David Timber 2026-03-19  115  	switch (mode) {
1178dacb657facf David Timber 2026-03-19  116  	case FALLOC_FL_ALLOCATE_RANGE:
1178dacb657facf David Timber 2026-03-19  117  	case FALLOC_FL_ZERO_RANGE:
1178dacb657facf David Timber 2026-03-19  118  	case FALLOC_FL_ZERO_RANGE|FALLOC_FL_KEEP_SIZE:
1178dacb657facf David Timber 2026-03-19  119  		break;
1178dacb657facf David Timber 2026-03-19  120  	default:
bf1797960c20f3d David Timber 2026-02-28  121  		return -EOPNOTSUPP;
1178dacb657facf David Timber 2026-03-19  122  	}
bf1797960c20f3d David Timber 2026-02-28  123  
bf1797960c20f3d David Timber 2026-02-28  124  	/* No support for dir */
bf1797960c20f3d David Timber 2026-02-28  125  	if (!S_ISREG(inode->i_mode))
1178dacb657facf David Timber 2026-03-19  126  		return mode & FALLOC_FL_ZERO_RANGE ? -EINVAL : -EOPNOTSUPP;
bf1797960c20f3d David Timber 2026-02-28  127  
bf1797960c20f3d David Timber 2026-02-28  128  	if (unlikely(exfat_forced_shutdown(inode->i_sb)))
bf1797960c20f3d David Timber 2026-02-28  129  		return -EIO;
bf1797960c20f3d David Timber 2026-02-28  130  
bf1797960c20f3d David Timber 2026-02-28  131  	inode_lock(inode);
                                                ^^^^^^^^^^^^^^^^^^

bf1797960c20f3d David Timber 2026-02-28  132  
1178dacb657facf David Timber 2026-03-19  133  	newsize = offset + len;
1178dacb657facf David Timber 2026-03-19  134  	isize = i_size_read(inode);
1178dacb657facf David Timber 2026-03-19  135  
1178dacb657facf David Timber 2026-03-19  136  	if (mode & FALLOC_FL_ZERO_RANGE) {
1178dacb657facf David Timber 2026-03-19  137  		struct exfat_inode_info *ei = EXFAT_I(inode);
1178dacb657facf David Timber 2026-03-19  138  		loff_t saved_validsize = ei->valid_size;
1178dacb657facf David Timber 2026-03-19  139  
1178dacb657facf David Timber 2026-03-19  140  		/* The requested range must span to or past EOF */
1178dacb657facf David Timber 2026-03-19  141  		if (newsize < isize) {
1178dacb657facf David Timber 2026-03-19  142  			err = -EOPNOTSUPP;
1178dacb657facf David Timber 2026-03-19  143  			goto error;
1178dacb657facf David Timber 2026-03-19  144  		}
1178dacb657facf David Timber 2026-03-19  145  
1178dacb657facf David Timber 2026-03-19  146  		/* valid_size can only be truncated */
1178dacb657facf David Timber 2026-03-19  147  		if (offset < ei->valid_size)
1178dacb657facf David Timber 2026-03-19  148  			ei->valid_size = offset;
1178dacb657facf David Timber 2026-03-19  149  		/* If offset >= ei->valid_size, the range is already zeroed so that'd be no-op */
1178dacb657facf David Timber 2026-03-19  150  
1178dacb657facf David Timber 2026-03-19  151  		if (!(mode & FALLOC_FL_KEEP_SIZE) && isize < newsize) {
1178dacb657facf David Timber 2026-03-19  152  			err = exfat_cont_expand(inode, newsize);
1178dacb657facf David Timber 2026-03-19  153  			if (err) {
1178dacb657facf David Timber 2026-03-19  154  				/* inode unchanged - revert valid_size */
1178dacb657facf David Timber 2026-03-19  155  				ei->valid_size = saved_validsize;
1178dacb657facf David Timber 2026-03-19  156  				goto error;
1178dacb657facf David Timber 2026-03-19  157  			}
1178dacb657facf David Timber 2026-03-19  158  			/* inode invalidated in exfat_cont_expand() */
1178dacb657facf David Timber 2026-03-19  159  		} else {
1178dacb657facf David Timber 2026-03-19  160  			/* update inode */
1178dacb657facf David Timber 2026-03-19  161  			inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
1178dacb657facf David Timber 2026-03-19  162  
1178dacb657facf David Timber 2026-03-19  163  			mark_inode_dirty(inode);
1178dacb657facf David Timber 2026-03-19  164  
1178dacb657facf David Timber 2026-03-19  165  			if (IS_SYNC(inode))
1178dacb657facf David Timber 2026-03-19  166  				return write_inode_now(inode, 1);

I don't think this calls inode_unlock(inode);

1178dacb657facf David Timber 2026-03-19  167  		}
1178dacb657facf David Timber 2026-03-19  168  
1178dacb657facf David Timber 2026-03-19  169  		/* drop cache after the new valid_size */
1178dacb657facf David Timber 2026-03-19  170  		if (ei->valid_size != saved_validsize)
1178dacb657facf David Timber 2026-03-19  171  			truncate_pagecache(inode, ei->valid_size);
1178dacb657facf David Timber 2026-03-19  172  	} else { /* mode == FALLOC_FL_ALLOCATE_RANGE */
1178dacb657facf David Timber 2026-03-19  173  		if (newsize <= isize)
bf1797960c20f3d David Timber 2026-02-28  174  			goto error;
bf1797960c20f3d David Timber 2026-02-28  175  
bf1797960c20f3d David Timber 2026-02-28  176  		/* This is just an expanding truncate */
bf1797960c20f3d David Timber 2026-02-28  177  		err = exfat_cont_expand(inode, newsize);
1178dacb657facf David Timber 2026-03-19  178  	}
bf1797960c20f3d David Timber 2026-02-28  179  
bf1797960c20f3d David Timber 2026-02-28  180  error:
bf1797960c20f3d David Timber 2026-02-28  181  	inode_unlock(inode);
bf1797960c20f3d David Timber 2026-02-28  182  
bf1797960c20f3d David Timber 2026-02-28 @183  	return err;
bf1797960c20f3d David Timber 2026-02-28  184  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

