Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37503BADB1;
	Tue, 10 Mar 2026 22:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773180637; cv=none; b=mSeClzKABXfxUleCtVWAe3GKj2lxuMtGGDoMdVqbaCQVqXXsPIARdRwN+oFyEai1TpCCW4XeGLp5LxUF+sSys9ts0+41rrrRvyaIGjwT7DxPw+3jpPumFbK4bCtbxhZcsdyfFtwFioV666lRQ4JjAOoG6IX7wG4/C764Z4GgluQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773180637; c=relaxed/simple;
	bh=8PI8bZwz+N4vDpyLZBXtImAK/bqeB8D5DeynDAQEVVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCMxzN8NM6uxfhuTX95YApUK/IIEWzZPshqAuwivC4dXZzMz/b/7MCaNYeNqPn0Y8tvUUM+owNbCZmQ5IhdzwHNhDIHpeehiuwEi3I7YNyK7ew8ftbs9bX10uu7wcXDuW0x1iYOcfBmmSKb1vl5fbd1HkoHJg0JNZEtctbsASts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wk4JZ7Ra; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wk4JZ7Ra"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773180636; x=1804716636;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8PI8bZwz+N4vDpyLZBXtImAK/bqeB8D5DeynDAQEVVU=;
  b=Wk4JZ7RauPC7hTUmec3+uZdg0jXELeFxYsUrn7nmf8bXiU6XS1vyB348
   JqHHoh386wgRPjcm4J7wKDL0ZPXz4AsS1QHjufJ7LkBQLa80OnnRYPEhp
   QCWrWZBraLEywBVLw3+4DCxE2UGg+9sQqN44FrT4Lz5+YIkwHCrl5m0RT
   j7Qy/4eixjBT7maCfuW55CXnUVi3R7ucaeEBBukIGgmV023ZKZkiLulFP
   vlWBf67RLGN9hXF9eAPnYABobNTgTKwncT8C7Hlt+U9AW/+r5KDpQaG+p
   1JZYFzKrD0nX1EcfL3JQgz1ccxAM1OKHiiLk4E4gjDollUdKzJxmPXFof
   Q==;
X-CSE-ConnectionGUID: jU87gvwkT8SW03DK+PbCww==
X-CSE-MsgGUID: S/rIVCtUSnqvGI1vR1Ugrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="76851101"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="76851101"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 15:10:35 -0700
X-CSE-ConnectionGUID: oZnB9UxETSKRLrUZYJxnfQ==
X-CSE-MsgGUID: 14na8+h+Tl2X3lUic4G4pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="222823143"
Received: from lkp-server01.sh.intel.com (HELO 418530b1a366) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 10 Mar 2026 15:10:32 -0700
Received: from kbuild by 418530b1a366 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w05Ha-000000000MY-0e0N;
	Tue, 10 Mar 2026 22:10:30 +0000
Date: Wed, 11 Mar 2026 06:10:29 +0800
From: kernel test robot <lkp@intel.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	David Laight <david.laight.linux@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: Replace user_access_{begin/end} by scoped user access
Message-ID: <202603110628.zpGycSV5-lkp@intel.com>
References: <5021aa325554b3d2437341514ab0a2977e158274.1773153431.git.chleroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5021aa325554b3d2437341514ab0a2977e158274.1773153431.git.chleroy@kernel.org>

Hi Christophe,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on linus/master v7.0-rc3 next-20260310]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christophe-Leroy-CS-GROUP/fs-Replace-user_access_-begin-end-by-scoped-user-access/20260310-230227
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/5021aa325554b3d2437341514ab0a2977e158274.1773153431.git.chleroy%40kernel.org
patch subject: [PATCH] fs: Replace user_access_{begin/end} by scoped user access
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20260311/202603110628.zpGycSV5-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260311/202603110628.zpGycSV5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603110628.zpGycSV5-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   fs/readdir.c: In function 'compat_fillonedir':
>> fs/readdir.c:454:54: error: macro "scoped_user_write_access_size" requires 3 arguments, but only 2 given
     454 |                                 (unsigned long)dirent), efault) {
         |                                                      ^
   In file included from include/linux/sched/task.h:13,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/mm.h:37,
                    from fs/readdir.c:12:
   include/linux/uaccess.h:778:9: note: macro "scoped_user_write_access_size" defined here
     778 | #define scoped_user_write_access_size(udst, size, elbl)                 \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> fs/readdir.c:452:9: error: 'scoped_user_write_access_size' undeclared (first use in this function)
     452 |         scoped_user_write_access_size(dirent,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/readdir.c:452:9: note: each undeclared identifier is reported only once for each function it appears in
>> fs/readdir.c:454:57: error: 'efault' undeclared (first use in this function)
     454 |                                 (unsigned long)dirent), efault) {
         |                                                         ^~~~~~
>> fs/readdir.c:454:55: warning: left-hand operand of comma expression has no effect [-Wunused-value]
     454 |                                 (unsigned long)dirent), efault) {
         |                                                       ^
>> fs/readdir.c:454:63: error: expected ';' before ')' token
     454 |                                 (unsigned long)dirent), efault) {
         |                                                               ^
         |                                                               ;
>> fs/readdir.c:454:63: error: expected statement before ')' token
   fs/readdir.c: In function 'compat_filldir':
>> include/linux/uaccess.h:744:17: warning: this 'for' clause does not guard... [-Wmisleading-indentation]
     744 |                 for (const auto uptr  __cleanup(__scoped_user_##mode##_access_end) = \
         |                 ^~~
   include/linux/uaccess.h:779:9: note: in expansion of macro '__scoped_user_access'
     779 |         __scoped_user_access(write, udst, size, elbl)
         |         ^~~~~~~~~~~~~~~~~~~~
   fs/readdir.c:532:9: note: in expansion of macro 'scoped_user_write_access_size'
     532 |         scoped_user_write_access_size(prev, reclen + prev_reclen, efault);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/uaccess.h:616:1: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'for'
     616 | do {                                                    \
         | ^~
   fs/readdir.c:533:17: note: in expansion of macro 'unsafe_put_user'
     533 |                 unsafe_put_user(offset, &prev->d_off, efault);
         |                 ^~~~~~~~~~~~~~~
   In file included from include/linux/uaccess.h:13:
>> arch/x86/include/asm/uaccess.h:471:26: error: label 'efault' used but not defined
     471 | #define __m(x) (*(struct __large_struct __user *)(x))
         |                          ^~~~~~~~~~~~~~
   arch/x86/include/asm/uaccess.h:482:36: note: in expansion of macro '__m'
     482 |                 : : ltype(x), "m" (__m(addr))                           \
         |                                    ^~~
   arch/x86/include/asm/uaccess.h:146:9: note: in expansion of macro '__put_user_goto'
     146 |         __put_user_goto(x, ptr, "q", "er", label)
         |         ^~~~~~~~~~~~~~~
   arch/x86/include/asm/uaccess.h:248:17: note: in expansion of macro '__put_user_goto_u64'
     248 |                 __put_user_goto_u64(__x, __ptr, label);                 \
         |                 ^~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/uaccess.h:532:9: note: in expansion of macro '__put_user_size'
     532 |         __put_user_size((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)), label)
         |         ^~~~~~~~~~~~~~~
   include/linux/uaccess.h:618:9: note: in expansion of macro 'arch_unsafe_put_user'
     618 |         arch_unsafe_put_user(x, ptr, local_label);      \
         |         ^~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/uaccess.h:603:17: note: in expansion of macro 'unsafe_put_user'
     603 |                 unsafe_put_user(*(type *)(src),(type __user *)(dst),label);     \
         |                 ^~~~~~~~~~~~~~~
   arch/x86/include/asm/uaccess.h:617:9: note: in expansion of macro 'unsafe_copy_loop'
     617 |         unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u8, label);   \
         |         ^~~~~~~~~~~~~~~~
   fs/readdir.c:81:9: note: in expansion of macro 'unsafe_copy_to_user'
      81 |         unsafe_copy_to_user(dst, src, len, label);              \
         |         ^~~~~~~~~~~~~~~~~~~
   fs/readdir.c:537:17: note: in expansion of macro 'unsafe_copy_dirent_name'
     537 |                 unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~
   fs/readdir.c: At top level:
>> fs/readdir.c:540:12: error: expected '=', ',', ';', 'asm' or '__attribute__' before '->' token
     540 |         buf->prev_reclen = reclen;
         |            ^~
   fs/readdir.c:541:12: error: expected '=', ',', ';', 'asm' or '__attribute__' before '->' token
     541 |         buf->current_dir = (void __user *)dirent + reclen;
         |            ^~
   fs/readdir.c:542:12: error: expected '=', ',', ';', 'asm' or '__attribute__' before '->' token
     542 |         ctx->count -= reclen;
         |            ^~
>> fs/readdir.c:543:9: error: expected identifier or '(' before 'return'
     543 |         return true;
         |         ^~~~~~
>> fs/readdir.c:544:7: error: expected '=', ',', ';', 'asm' or '__attribute__' before ':' token
     544 | efault:
         |       ^
   fs/readdir.c:546:9: error: expected identifier or '(' before 'return'
     546 |         return false;
         |         ^~~~~~
>> fs/readdir.c:547:1: error: expected identifier or '(' before '}' token
     547 | }
         | ^
   fs/readdir.c: In function 'compat_filldir':
>> fs/readdir.c:538:9: warning: control reaches end of non-void function [-Wreturn-type]
     538 |         }
         |         ^


vim +/scoped_user_write_access_size +454 fs/readdir.c

   430	
   431	static bool compat_fillonedir(struct dir_context *ctx, const char *name,
   432				     int namlen, loff_t offset, u64 ino,
   433				     unsigned int d_type)
   434	{
   435		struct compat_readdir_callback *buf =
   436			container_of(ctx, struct compat_readdir_callback, ctx);
   437		struct compat_old_linux_dirent __user *dirent;
   438		compat_ulong_t d_ino;
   439	
   440		if (buf->result)
   441			return false;
   442		buf->result = verify_dirent_name(name, namlen);
   443		if (buf->result)
   444			return false;
   445		d_ino = ino;
   446		if (sizeof(d_ino) < sizeof(ino) && d_ino != ino) {
   447			buf->result = -EOVERFLOW;
   448			return false;
   449		}
   450		buf->result++;
   451		dirent = buf->dirent;
 > 452		scoped_user_write_access_size(dirent,
   453				(unsigned long)(dirent->d_name + namlen + 1) -
 > 454					(unsigned long)dirent), efault) {
   455			unsafe_put_user(d_ino, &dirent->d_ino, efault);
   456			unsafe_put_user(offset, &dirent->d_offset, efault);
   457			unsafe_put_user(namlen, &dirent->d_namlen, efault);
   458			unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault);
   459		}
   460		return true;
   461	efault:
   462		buf->result = -EFAULT;
   463		return false;
   464	}
   465	
   466	COMPAT_SYSCALL_DEFINE3(old_readdir, unsigned int, fd,
   467			struct compat_old_linux_dirent __user *, dirent, unsigned int, count)
   468	{
   469		int error;
   470		CLASS(fd_pos, f)(fd);
   471		struct compat_readdir_callback buf = {
   472			.ctx.actor = compat_fillonedir,
   473			.ctx.count = 1, /* Hint to fs: just one entry. */
   474			.dirent = dirent
   475		};
   476	
   477		if (fd_empty(f))
   478			return -EBADF;
   479	
   480		error = iterate_dir(fd_file(f), &buf.ctx);
   481		if (buf.result)
   482			error = buf.result;
   483	
   484		return error;
   485	}
   486	
   487	struct compat_linux_dirent {
   488		compat_ulong_t	d_ino;
   489		compat_ulong_t	d_off;
   490		unsigned short	d_reclen;
   491		char		d_name[];
   492	};
   493	
   494	struct compat_getdents_callback {
   495		struct dir_context ctx;
   496		struct compat_linux_dirent __user *current_dir;
   497		int prev_reclen;
   498		int error;
   499	};
   500	
   501	static bool compat_filldir(struct dir_context *ctx, const char *name, int namlen,
   502			loff_t offset, u64 ino, unsigned int d_type)
   503	{
   504		struct compat_linux_dirent __user *dirent, *prev;
   505		struct compat_getdents_callback *buf =
   506			container_of(ctx, struct compat_getdents_callback, ctx);
   507		compat_ulong_t d_ino;
   508		int reclen = ALIGN(offsetof(struct compat_linux_dirent, d_name) +
   509			namlen + 2, sizeof(compat_long_t));
   510		int prev_reclen;
   511		unsigned int flags = d_type;
   512	
   513		BUILD_BUG_ON(FILLDIR_FLAG_NOINTR & S_DT_MASK);
   514		d_type &= S_DT_MASK;
   515	
   516		buf->error = verify_dirent_name(name, namlen);
   517		if (unlikely(buf->error))
   518			return false;
   519		buf->error = -EINVAL;	/* only used if we fail.. */
   520		if (reclen > ctx->count)
   521			return false;
   522		d_ino = ino;
   523		if (sizeof(d_ino) < sizeof(ino) && d_ino != ino) {
   524			buf->error = -EOVERFLOW;
   525			return false;
   526		}
   527		prev_reclen = buf->prev_reclen;
   528		if (!(flags & FILLDIR_FLAG_NOINTR) && prev_reclen && signal_pending(current))
   529			return false;
   530		dirent = buf->current_dir;
   531		prev = (void __user *) dirent - prev_reclen;
   532		scoped_user_write_access_size(prev, reclen + prev_reclen, efault);
   533			unsafe_put_user(offset, &prev->d_off, efault);
   534			unsafe_put_user(d_ino, &dirent->d_ino, efault);
   535			unsafe_put_user(reclen, &dirent->d_reclen, efault);
   536			unsafe_put_user(d_type, (char __user *) dirent + reclen - 1, efault);
   537			unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault);
 > 538		}
   539	
 > 540		buf->prev_reclen = reclen;
 > 541		buf->current_dir = (void __user *)dirent + reclen;
   542		ctx->count -= reclen;
 > 543		return true;
 > 544	efault:
   545		buf->error = -EFAULT;
 > 546		return false;
 > 547	}
   548	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
