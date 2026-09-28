Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F69648989F;
	Mon, 28 Sep 2026 10:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790592217; cv=none; b=mlEYLb2ynsTLYeVrikYfje1N5L+ZqbrDpo3n1QQlpMwFUSyvymhQo1tfz43mg2kl/eQ4NHL1OZjIVj2EnoF8P6eeIoM/t9Z5L+I1ICI91P4VB+AEwCFjOh0nEWw9kKvFYTjnSTxGq1GXEw/SfmFOHrkyDtWC/O9RTK41miepZkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790592217; c=relaxed/simple;
	bh=IAMusWTMHU8SIclWHel+/IVnnuAKzzVXSNHbxaONyVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9pNkMomIzumBjUXBgcLw9UIEypD+O9eA2+Grtgi6y6ba+vmwhS4cDbdSNbS8fU8pn74HWQxUWq//NVI7yPiqVQMRoloWfEGbSNGoXMPAiPYcgRv4rmtwaeRvG6thQcTXXG7vwjZM7PKtV/HGi42mHJhdissGBvPlcoXNXNrkXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i/m1pk9V; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i/m1pk9V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790592213; x=1822128213;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IAMusWTMHU8SIclWHel+/IVnnuAKzzVXSNHbxaONyVw=;
  b=i/m1pk9VVv462heW1xfF4awwHuTQIS/xcro/BR/7qcKWyYBiSQ76g7bM
   IblyRMo3fxOZKl+/gmEzR9lBRcf0uYk1MRQCpxXsSOG44/zDKN8pjq0ZK
   0kUEHrbaseLWixEniQ8lj5m1gPVM5n3RqUev1B6MBdEA109FbUcmYdd5a
   V+vVGRCVMijIbduBfvnu/kEQnkvRZqpxvsXh5jVBShrVAMG5goffRn2RU
   ++DqEj/SXzTHppwU5U4oUHvfvSkuEJl8Ooir+MrcdiK2D9hZS8h8bn55W
   uYPRgJLOfhiEzjsP1LO3HUpDC4g4mFafAle4x7BPJNq+TGoYO46ef2XuG
   w==;
X-CSE-ConnectionGUID: muz+NCvuQU2DT7ziqkDwrA==
X-CSE-MsgGUID: MRThJwr+TOqtOm/B9iZKCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90506056"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90506056"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 03:43:32 -0700
X-CSE-ConnectionGUID: 1l1YSLV6Q5GvjlkKXTCojg==
X-CSE-MsgGUID: AbDliMEMS2KhkhwmoWWURQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="304510639"
Received: from igk-lkp-server01.igk.intel.com (HELO 04362d00df5a) ([10.211.93.152])
  by orviesa002.jf.intel.com with ESMTP; 28 Sep 2026 03:43:27 -0700
Received: from kbuild by 04362d00df5a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xB8pR-000000000y7-0YNn;
	Mon, 28 Sep 2026 10:43:25 +0000
Date: Mon, 28 Sep 2026 12:42:47 +0200
From: kernel test robot <lkp@intel.com>
To: Georgios Androutsopoulos <georgeandrout13@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Jan Kara <jack@suse.cz>,
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Georgios Androutsopoulos <georgeandrout13@gmail.com>
Subject: Re: [PATCH v2] rust: file: handle fd table teardown in file
 descriptor APIs
Message-ID: <202609281234.H1AixLDP-lkp@intel.com>
References: <20260923022339.3340694-1-georgeandrout13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923022339.3340694-1-georgeandrout13@gmail.com>

Hi Georgios,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brauner-vfs/vfs.all]
[also build test WARNING on linus/master v7.3-rc5 next-20260925]
[cannot apply to linux-review/Georgios-Androutsopoulos/rust-file-handle-fd-table-teardown-in-file-descriptor-APIs/20260920-160154]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Georgios-Androutsopoulos/rust-file-handle-fd-table-teardown-in-file-descriptor-APIs/20260922-222339
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20260923022339.3340694-1-georgeandrout13%40gmail.com
patch subject: [PATCH v2] rust: file: handle fd table teardown in file descriptor APIs
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20260928/202609281234.H1AixLDP-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
rustc: rustc 1.96.0 (ac68faa20 2026-05-25)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260928/202609281234.H1AixLDP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609281234.H1AixLDP-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> warning: statement has unnecessary safety comment
   --> rust/kernel/fs/file.rs:455:9
   |
   455 | /         if crate::warn_on!(unsafe { (*current.as_ptr()).files.is_null() }) {
   456 | |             // `put_unused_fd` also requires `current->files` to be valid, so do not run
   457 | |             // the reservation's destructor after the current task has lost its fd table.
   458 | |             core::mem::forget(self);
   459 | |             return;
   460 | |         }
   | |_________^
   |
   help: consider removing the safety comment
   --> rust/kernel/fs/file.rs:452:12
   |
   452 |         // SAFETY: `current` points to the currently executing task, so it is
   |            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   = help: for further information visit https://rust-lang.github.io/rust-clippy/rust-1.96.0/index.html#unnecessary_safety_comment
   = note: requested on the command line with `-W clippy::unnecessary-safety-comment`

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
