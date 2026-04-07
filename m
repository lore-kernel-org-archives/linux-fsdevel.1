Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63DB38A703;
	Tue,  7 Apr 2026 23:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775602845; cv=none; b=VSa9a/eFrUDoEyw1hAU/J/Q4Ker1U+waGp5OPguzZrSwNBKCV/eobTFBCtc9MGj79/zDdXplo9Sxf/vSp50QB/AtvlKki0ZZzwwNXSZAsz+Hj0RRcD+/+QzcNnKElMd9dqyuHa2/UzHRfidC4/nu8v2bg3zlBvXIEWSWpzn4jtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775602845; c=relaxed/simple;
	bh=Sy+BRlelaZG9WDkntYDY0tGb4c5RFFjT9XQH/dTL29Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CudZ7clGfB4fpJaWZlRo/IOqWkpzlX0Y3dYX2wPGmzcgWcBvycjaxF+2fNE/XsynDQxga8NAY/b9s1/AzEMJ4V8ebhjrRLT/8VKJ0kvAdJ1JQSV8MeOZAHpAHOSoJp/Kmter5tWB6Gnn0v0K2FDzJ5Fe7ATQ2rPhEn2CFCYSXfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S9aE7Jri; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S9aE7Jri"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775602844; x=1807138844;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Sy+BRlelaZG9WDkntYDY0tGb4c5RFFjT9XQH/dTL29Y=;
  b=S9aE7Jri5xeH/pTVf7SDh7JB7etjE0xjwWKSQcsMa2TY9GxbmdIX5aUF
   O66JnDwvtQTg9+KaixQSbj0DFyUaN6jlE5OV7OiT8mGfPmm3ewC2qIaEx
   2VFKax63KV4X8Nt6dp+BZG5M3Snk3pTzZQDs5EA3wJopbGiuzDa0RSzc0
   KFOC8P3nj1wUgtm0D+FPuvS2tlD9yFeD+5LnUNVpSxUeS7BhmKeLwnLHk
   1mE2EJxrC96Vdg5odhbZR4kpJ2NJSia1vp2SBzy2vh9x8h7tY44g7xY0H
   caMskLX2L5S1EoRJ7cDRvwKtxNVjDVcvDpUftTmfCOv0zHNpJKUH3KoSy
   g==;
X-CSE-ConnectionGUID: wcC93vPjTT66S/0bsYfgRw==
X-CSE-MsgGUID: vj+zWIRsRh6vn/ykLMHwIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="80172439"
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; 
   d="scan'208";a="80172439"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 16:00:44 -0700
X-CSE-ConnectionGUID: amAf8Z1ET6+Wd9Sj3IGtug==
X-CSE-MsgGUID: 6+CcoNjQSliMz+efVPcfFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; 
   d="scan'208";a="258725579"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by orviesa002.jf.intel.com with ESMTP; 07 Apr 2026 16:00:40 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wAFPS-00000000ALt-0ZP8;
	Tue, 07 Apr 2026 23:00:38 +0000
Date: Wed, 8 Apr 2026 01:00:16 +0200
From: kernel test robot <lkp@intel.com>
To: Christian Benton <t1bur0n.kernel.org@protonmail.ch>, ojeda@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, viro@zeniv.linux.org.uk,
	brauner@kernel.org, rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	aliceryhl@google.com, lossin@kernel.org,
	Christian Benton <t1bur0n.kernel.org@protonmail.ch>
Subject: Re: [PATCH] rust: seq_file: add puts, putc, write, and hex_dump
 methods
Message-ID: <202604080005.U3yjfXzs-lkp@intel.com>
References: <20260403233900.24640-1-t1bur0n.kernel.org@protonmail.ch>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403233900.24640-1-t1bur0n.kernel.org@protonmail.ch>

Hi Christian,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on rust/rust-next linus/master v7.0-rc7 next-20260407]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Benton/rust-seq_file-add-puts-putc-write-and-hex_dump-methods/20260407-211720
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20260403233900.24640-1-t1bur0n.kernel.org%40protonmail.ch
patch subject: [PATCH] rust: seq_file: add puts, putc, write, and hex_dump methods
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20260408/202604080005.U3yjfXzs-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260408/202604080005.U3yjfXzs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604080005.U3yjfXzs-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   PATH=/opt/cross/clang-20/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   INFO PATH=/opt/cross/rustc-1.88.0-bindgen-0.72.1/cargo/bin:/opt/cross/clang-20/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   /usr/bin/timeout -k 100 12h /usr/bin/make KCFLAGS=\ -fno-crash-diagnostics\ -Wno-error=return-type\ -Wreturn-type\ -funsigned-char\ -Wundef\ -falign-functions=64 W=1 --keep-going LLVM=1 -j32 -C source O=/kbuild/obj/consumer/x86_64-rhel-9.4-rust ARCH=x86_64 SHELL=/bin/bash rustfmtcheck 
   make: Entering directory '/kbuild/src/consumer'
   make[1]: Entering directory '/kbuild/obj/consumer/x86_64-rhel-9.4-rust'
>> Diff in rust/kernel/seq_file.rs:4:
    //!
    //! C header: [`include/linux/seq_file.h`](srctree/include/linux/seq_file.h)
    
   -use crate::{bindings, ffi, fmt, str::CStr, str::CStrExt as _, types::NotThreadSafe, types::Opaque};
   +use crate::{
   +    bindings, ffi, fmt, str::CStr, str::CStrExt as _, types::NotThreadSafe, types::Opaque,
   +};
    
    /// A utility for generating the contents of a seq file.
    #[repr(transparent)]
>> Diff in rust/kernel/seq_file.rs:4:
    //!
    //! C header: [`include/linux/seq_file.h`](srctree/include/linux/seq_file.h)
    
   -use crate::{bindings, ffi, fmt, str::CStr, str::CStrExt as _, types::NotThreadSafe, types::Opaque};
   +use crate::{
   +    bindings, ffi, fmt, str::CStr, str::CStrExt as _, types::NotThreadSafe, types::Opaque,
   +};
    
    /// A utility for generating the contents of a seq file.
    #[repr(transparent)]
   make[2]: *** [Makefile:1916: rustfmt] Error 123
   make[1]: Leaving directory '/kbuild/obj/consumer/x86_64-rhel-9.4-rust'
   make[1]: *** [Makefile:248: __sub-make] Error 2
   make[2]: Target 'rustfmtcheck' not remade because of errors.
   make[1]: Target 'rustfmtcheck' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2
   make: Target 'rustfmtcheck' not remade because of errors.
   make: Leaving directory '/kbuild/src/consumer'
--
>> warning: methods called `as_*` usually take `self` by reference or `self` by mutable reference
   --> rust/kernel/seq_file.rs:27:17
   |
   27 |     fn as_c_int(self) -> ffi::c_int {
   |                 ^^^^
   |
   = help: consider choosing a less ambiguous name
   = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#wrong_self_convention
   = note: `-W clippy::wrong-self-convention` implied by `-W clippy::all`
   = help: to override `-W clippy::all` add `#[allow(clippy::wrong_self_convention)]`
--
>> warning: casts from `u8` to `i32` can be expressed infallibly using `From`
   --> rust/kernel/seq_file.rs:119:17
   |
   119 |                 rowsize as ffi::c_int,
   |                 ^^^^^^^^^^^^^^^^^^^^^
   |
   = help: an `as` cast can become silently lossy if the types change in the future
   = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#cast_lossless
   = note: requested on the command line with `-W clippy::cast-lossless`
   help: use `ffi::c_int::from` instead
   |
   119 -                 rowsize as ffi::c_int,
   119 +                 ffi::c_int::from(rowsize),
   |
--
>> warning: casts from `u8` to `i32` can be expressed infallibly using `From`
   --> rust/kernel/seq_file.rs:120:17
   |
   120 |                 groupsize as ffi::c_int,
   |                 ^^^^^^^^^^^^^^^^^^^^^^^
   |
   = help: an `as` cast can become silently lossy if the types change in the future
   = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#cast_lossless
   help: use `ffi::c_int::from` instead
   |
   120 -                 groupsize as ffi::c_int,
   120 +                 ffi::c_int::from(groupsize),
   |

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
