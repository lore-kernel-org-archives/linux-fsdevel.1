Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1364C3A9632;
	Wed, 29 Apr 2026 08:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777451308; cv=none; b=g8FSdAenjM285B8UtwWSO1LmTqZ3+cCylSMN7tgpn/wmGB4UPkofIulF8wk819nB1UlnyaQM31xPxCspspZZAvgU63bHn57ujiDmnZIJ2k3flmCs3TllMfdmeBNDSonf/nHCCexgdp7y9Bh09n1AK2w05xOW9zoQjAFP55IsKcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777451308; c=relaxed/simple;
	bh=cOxa4CgWhjet1z2EeEEdLVqhmu6YFrkVnG4ZICWRr0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9DgyMqLHIxvs015OcgE9oOCj9goh5TG77xtfA3VHluzbu/jU3E2uqHR53bwxFNgPOg6YSQx/u1N2e5VUxNoqv+AM88bL+bmjBoReFq16M+tOC38gIdHLrtW3oIKwnBUoelUfAhAm/cAHpZXkJEjb/kvczeEENhaRF9rkokWYVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NYvQ95pO; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NYvQ95pO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777451307; x=1808987307;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cOxa4CgWhjet1z2EeEEdLVqhmu6YFrkVnG4ZICWRr0M=;
  b=NYvQ95pObiBus+noSgHKDeUYfD2bb416h8F8hq/48yJR3JCgKTZDmAL0
   rsyyZPFF115+dym+5Q8+x+y7szQlkESJ1YI3yZnk3pl1QeA0Acoy2Y4z9
   IgLpWxygPqoviB4wpwa/BntlxGNkFVy5UELZhKUytiDus3TOdHtyecyF0
   DCkQ841jm0dGLf/dPGP8HocqYwc+/XsJEnN9p3pSzMmTdo54cb3Jdfk9g
   bXD0v4U4t4EnSMbzl/motZhQHh/mgP/GlSBikSgZXeSTK05yL8rAPwvZq
   PQtrh5PjzGEwXf6LhXxbW8T01p8p5gfWdiLHzeA/t7Zsz5mKMns5ogq2t
   Q==;
X-CSE-ConnectionGUID: k6Cu91PgRkeNZiUhAiQulQ==
X-CSE-MsgGUID: OGAf1HXMRIaH2VNC4Tn2+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="65905223"
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="65905223"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 01:28:26 -0700
X-CSE-ConnectionGUID: 8mkmh+WgT9iotp82+uPsdQ==
X-CSE-MsgGUID: XnmKZAYmTgyF33Wn7Sdevg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="227692057"
Received: from lkp-server01.sh.intel.com (HELO aa799cca880d) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 29 Apr 2026 01:28:24 -0700
Received: from kbuild by aa799cca880d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wI0HM-00000000Ap2-3WbZ;
	Wed, 29 Apr 2026 08:28:20 +0000
Date: Wed, 29 Apr 2026 16:27:32 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Brauner <brauner@kernel.org>, Thomas Graf <tgraf@suug.ch>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	syzbot+5af806780f38a5fe691f@syzkaller.appspotmail.com,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] rhashtable: give each instance its own lockdep class
Message-ID: <202604291646.noNYgx5i-lkp@intel.com>
References: <20260427-work-rhashtable-lockdep-v1-1-f69e8bd91cb2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427-work-rhashtable-lockdep-v1-1-f69e8bd91cb2@kernel.org>

Hi Christian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 6596a02b207886e9e00bb0161c7fd59fea53c081]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Brauner/rhashtable-give-each-instance-its-own-lockdep-class/20260428-182539
base:   6596a02b207886e9e00bb0161c7fd59fea53c081
patch link:    https://lore.kernel.org/r/20260427-work-rhashtable-lockdep-v1-1-f69e8bd91cb2%40kernel.org
patch subject: [PATCH] rhashtable: give each instance its own lockdep class
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260429/202604291646.noNYgx5i-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260429/202604291646.noNYgx5i-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604291646.noNYgx5i-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: lib/rhashtable.c:1030 function parameter 'key' not described in '__rhashtable_init'
>> Warning: lib/rhashtable.c:1030 expecting prototype for rhashtable_init(). Prototype was for __rhashtable_init() instead
>> Warning: lib/rhashtable.c:1104 function parameter 'key' not described in '__rhltable_init'
>> Warning: lib/rhashtable.c:1104 expecting prototype for rhltable_init(). Prototype was for __rhltable_init() instead

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
