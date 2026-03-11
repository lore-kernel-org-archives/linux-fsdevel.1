Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFFB35A3B9;
	Wed, 11 Mar 2026 00:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773188908; cv=none; b=K993ebA40khcEsPiYS98FOMZrnYCKYfO/nRn3OsMYjqtS93Runwc78Memqx1rRXIp/Fqd3MPaYk2OdHraVHFxDlspQhNz1n86szDnGAVMjb2lLQARu8WcDN1/uKWjhhmMNRNahj46cnPRZuqIUrH0FDJUSAk0we+9T9OMx0nERk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773188908; c=relaxed/simple;
	bh=iSAiWpBhq/rSijCYU0e/DiphDLlJkmF2WUm2ZWU3E+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uIhA9KAkhNrqRFEwQvBPAjTdMtZ+SeqqIuwdEcew7FQJ2WdWT8/raPxTSZzS1DcsU5y3yXRfP2LqRCBkXaBJ1kFJOkWSebeODY65OAnz9MRG5uJe51HRblCAXtikjIpNFGCiyE1YBNHX+qpJqEw5VpawI2W4G5QZop+lQT1pC6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XC8dXRZ/; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XC8dXRZ/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773188906; x=1804724906;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iSAiWpBhq/rSijCYU0e/DiphDLlJkmF2WUm2ZWU3E+s=;
  b=XC8dXRZ/DTe9+zpXstABvxKBsIb8+wuAvmx3KQd6agNCStCGizKWg1Ia
   ZBiSwqfrVgDEBYjsxnmPlk1tXm93cxFy3PGM6N8BOKs6UVT0Ow4cuoef0
   f02/a4VQAjMcNzDxE53R5AvCQ8hhCXU4JQGUh6dGmS4u2dDqtj2jPG89r
   KAplK9Rn1OFTCaATshL/ig703BzaVjQwCYuA4MFVUKSgJoy1OSjdZii6W
   4sPWb12xreG0W1l9uTOFIwiTyljkPR7zpRB8aj8TV51JxDUaLcshsFZVa
   utpKkigvucTLfh3J0SUypYzjnIvoAMkVZHHx5b9d1yZwx7Ng9vFWK7C22
   w==;
X-CSE-ConnectionGUID: eMnNf2uNSMGpMuLNDUkIAA==
X-CSE-MsgGUID: GDBOlyrKTfWQZtOCPL2ZnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="99715606"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="99715606"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 17:28:25 -0700
X-CSE-ConnectionGUID: xyrao5kARGCn3dmgdyfhAg==
X-CSE-MsgGUID: ZuDw8pPVTWCUsbsy+xWfCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="250788230"
Received: from lkp-server01.sh.intel.com (HELO 418530b1a366) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 10 Mar 2026 17:28:23 -0700
Received: from kbuild by 418530b1a366 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w07Qx-000000000RJ-0QVN;
	Wed, 11 Mar 2026 00:28:19 +0000
Date: Wed, 11 Mar 2026 08:27:24 +0800
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
Message-ID: <202603110842.VJ27Z6FK-lkp@intel.com>
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
config: x86_64-randconfig-161-20260311 (https://download.01.org/0day-ci/archive/20260311/202603110842.VJ27Z6FK-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
smatch: v0.5.0-9004-gb810ac53
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260311/202603110842.VJ27Z6FK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603110842.VJ27Z6FK-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/readdir.c:454:26: error: too few arguments provided to function-like macro invocation
     454 |                                 (unsigned long)dirent), efault) {
         |                                                      ^
   include/linux/uaccess.h:778:9: note: macro 'scoped_user_write_access_size' defined here
     778 | #define scoped_user_write_access_size(udst, size, elbl)                 \
         |         ^
>> fs/readdir.c:452:2: error: use of undeclared identifier 'scoped_user_write_access_size'; did you mean '__scoped_user_write_access_end'?
     452 |         scoped_user_write_access_size(dirent,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |         __scoped_user_write_access_end
   include/linux/uaccess.h:658:29: note: '__scoped_user_write_access_end' declared here
     658 | static __always_inline void __scoped_user_write_access_end(const void *p)
         |                             ^
>> fs/readdir.c:454:35: error: expected ';' after expression
     454 |                                 (unsigned long)dirent), efault) {
         |                                                               ^
         |                                                               ;
>> fs/readdir.c:454:29: error: use of undeclared identifier 'efault'
     454 |                                 (unsigned long)dirent), efault) {
         |                                                         ^
>> fs/readdir.c:454:35: error: expected expression
     454 |                                 (unsigned long)dirent), efault) {
         |                                                               ^
>> fs/readdir.c:532:60: error: use of undeclared label 'efault'
     532 |         scoped_user_write_access_size(prev, reclen + prev_reclen, efault);
         |                                                                   ^
>> fs/readdir.c:540:2: error: unknown type name 'buf'
     540 |         buf->prev_reclen = reclen;
         |         ^
>> fs/readdir.c:540:5: error: expected identifier or '('
     540 |         buf->prev_reclen = reclen;
         |            ^
   fs/readdir.c:541:2: error: unknown type name 'buf'
     541 |         buf->current_dir = (void __user *)dirent + reclen;
         |         ^
   fs/readdir.c:541:5: error: expected identifier or '('
     541 |         buf->current_dir = (void __user *)dirent + reclen;
         |            ^
>> fs/readdir.c:542:2: error: unknown type name 'ctx'
     542 |         ctx->count -= reclen;
         |         ^
   fs/readdir.c:542:5: error: expected identifier or '('
     542 |         ctx->count -= reclen;
         |            ^
   fs/readdir.c:543:2: error: expected identifier or '('
     543 |         return true;
         |         ^
>> fs/readdir.c:544:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
     544 | efault:
         | ^
         | int
>> fs/readdir.c:544:7: error: expected ';' after top level declarator
     544 | efault:
         |       ^
         |       ;
   fs/readdir.c:545:2: error: unknown type name 'buf'
     545 |         buf->error = -EFAULT;
         |         ^
   fs/readdir.c:545:5: error: expected identifier or '('
     545 |         buf->error = -EFAULT;
         |            ^
   fs/readdir.c:546:2: error: expected identifier or '('
     546 |         return false;
         |         ^
>> fs/readdir.c:547:1: error: extraneous closing brace ('}')
     547 | }
         | ^
   19 errors generated.


vim +454 fs/readdir.c

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
 > 532		scoped_user_write_access_size(prev, reclen + prev_reclen, efault);
   533			unsafe_put_user(offset, &prev->d_off, efault);
   534			unsafe_put_user(d_ino, &dirent->d_ino, efault);
   535			unsafe_put_user(reclen, &dirent->d_reclen, efault);
   536			unsafe_put_user(d_type, (char __user *) dirent + reclen - 1, efault);
   537			unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault);
   538		}
   539	
 > 540		buf->prev_reclen = reclen;
   541		buf->current_dir = (void __user *)dirent + reclen;
 > 542		ctx->count -= reclen;
   543		return true;
 > 544	efault:
   545		buf->error = -EFAULT;
   546		return false;
 > 547	}
   548	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
