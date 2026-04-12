Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7080D1A275;
	Sun, 12 Apr 2026 00:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775954792; cv=none; b=SRLDfllyf1e0dFSa11XdXRQRY0phES/BVk66rcC+Zq4dtEv7bPUocN5M556PDcta/WeGmsDa0KSF3pNigRAjcWnGTjpk1sjbScwlLXkjqXG3tnVT8YGR5VBOV+XcHhW4pctCc6y5gymBgLfJ0aQUYaXfLRDjNo84eQyqT9KjEOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775954792; c=relaxed/simple;
	bh=DXMiRubHlvCTIwey5BQzAyERUfm0SaM6XImUdTgpUO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iK+qKhPs5wbjE/6Z3ZtW56fdDZvFI7QDVHOWli6nBUTzytvmsRtkpidcCFet/SewSSdM7Kc2RwnxruHQnrj7btHk129G1T3Xo2dCs5LYilbfEfNH2TF6fGzWccG9eNUmaUiff/RmIeeTWFr5cndffO+zaYdHTMbZi0GW3SbuG84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E9OPjwkm; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E9OPjwkm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775954791; x=1807490791;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DXMiRubHlvCTIwey5BQzAyERUfm0SaM6XImUdTgpUO4=;
  b=E9OPjwkmvlG0PJelbvZN2Fro74JTqDHiSYhfRvteK8I+62I1eWqvG9RN
   EV+yGM29Ch8k3BoXhUgv7DAKmfqoTNyAyLccP98li1BrqglBI+VbJQMIL
   1QzpiG5Th/62agNamNKdOopfJ99+DCPqpjezZHCzuZ2rjk2R50BeXTMW1
   tAtvvOVRXDoCe8JreuIQ/MakZz60i4fGgxYCY8+pfj5pNCI6Gok8RQthl
   YhSgSWwgSHfn5L2DNjqiv6ijMmrDmCERpf5v9KFQd2v20VT9bE9nyerc8
   GQRgHo6KQoaMCj7Vy2lX3VPHYrsyvEC/8AxGZhDbuyGo2EFcJSOVC0zzx
   w==;
X-CSE-ConnectionGUID: AHB0Nc+XQyWXUWnuRt2FuA==
X-CSE-MsgGUID: asZF3XEVRLOXGDR8N6Kmbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="79517401"
X-IronPort-AV: E=Sophos;i="6.23,174,1770624000"; 
   d="scan'208";a="79517401"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2026 17:46:30 -0700
X-CSE-ConnectionGUID: SifAcYjiQaqI8LCBuipWiw==
X-CSE-MsgGUID: UWYEpjYjSqiLIV9R5SGfrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,174,1770624000"; 
   d="scan'208";a="222951793"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by fmviesa009.fm.intel.com with ESMTP; 11 Apr 2026 17:46:26 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wBiy0-00000000BDZ-1HEP;
	Sun, 12 Apr 2026 00:46:24 +0000
Date: Sun, 12 Apr 2026 02:45:51 +0200
From: kernel test robot <lkp@intel.com>
To: Christian Benton <t1bur0n.kernel.org@protonmail.ch>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, aliceryhl@google.com, ojeda@kernel.org,
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu,
	dakr@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, Christian Benton <t1bur0n.kernel.org@protonmail.ch>
Subject: Re: [PATCH v2 1/1] rust: seq_file: add puts, putc, write, and
 hex_dump methods
Message-ID: <202604120236.nzYgh7vO-lkp@intel.com>
References: <20260408215530.446994-2-t1bur0n.kernel.org@protonmail.ch>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408215530.446994-2-t1bur0n.kernel.org@protonmail.ch>

Hi Christian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brauner-vfs/vfs.all]
[also build test WARNING on next-20260410]
[cannot apply to linus/master v6.16-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Benton/rust-seq_file-add-puts-putc-write-and-hex_dump-methods/20260412-035855
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20260408215530.446994-2-t1bur0n.kernel.org%40protonmail.ch
patch subject: [PATCH v2 1/1] rust: seq_file: add puts, putc, write, and hex_dump methods
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20260412/202604120236.nzYgh7vO-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260412/202604120236.nzYgh7vO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604120236.nzYgh7vO-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> warning: methods with the following characteristics: (`to_*` and `self` type is not `Copy`) usually take `self` by reference
   --> rust/kernel/seq_file.rs:29:17
   |
   29 |     fn to_c_int(self) -> ffi::c_int {
   |                 ^^^^
   |
   = help: consider choosing a less ambiguous name
   = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#wrong_self_convention
   = note: `-W clippy::wrong-self-convention` implied by `-W clippy::all`
   = help: to override `-W clippy::all` add `#[allow(clippy::wrong_self_convention)]`

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
