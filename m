Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1099437646B;
	Tue,  7 Apr 2026 03:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775534320; cv=none; b=Pu+Cj7ans9hdYlp6x5IdmWT+3IbYNx0giFZnxqncEO4CL6TeQK61uNLzhB6GnCXi3I5NqEqeYHRHaoFo64G+Wm9ALNzyrOktDHvR19wkiHbaElmzzCav2j738va2oqWEYVQFABRMFNtahI7luX8oo++heNS6HUzpR18cPPSbnp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775534320; c=relaxed/simple;
	bh=XfcgHmHjRHl1GSGL66oSlMGazVU+tCu6zO0GxM0fWNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sj1I7QYcyq075ehp10LsUE/hIuDpDZ3zhtZuJXGMnPnUL2lxSY7xZ96LSECggN+uVVwbLy+32C1kHbHHaWFp58P+OchMNtpVK/wecuusg4C6B32ZUDdGTVld4cOveI3pZAfi5XWLOnN/QHF1mkRM6x4IH5xPYxA5SqQ0VK9hZWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ft9gOuUf; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ft9gOuUf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775534319; x=1807070319;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XfcgHmHjRHl1GSGL66oSlMGazVU+tCu6zO0GxM0fWNU=;
  b=Ft9gOuUf0mUDm9H+acvd5Z1N3fnbA8ErfMNHuCvu6UcD7vI5T3R9Zd3G
   BK2aKxYxHKnxyZ+zpVnH+t779vYURCnp6fvTpO0Xj6x5Aj0onKr2hB7AA
   427sSp/rbK5saZWMh3rPsfyEa/VQm9KMdCIcsUPvfNUg1dOcMsJj3OYpG
   BmVzrJ4JIe1NchrEnFsuCt2wY4WWAUX1vXpZq5ehv2r+/7D/FoN/o5s+F
   kWjXpi5tzEIBZpTSasRmY4+Ai01DU4h/i7u3FvDBADPeyUsYOt8nRNdrf
   VIoBT49uUbXCBPnphmjVIeM7l111eu2PdSc4MC/A4O4soZ//rxa0cizsr
   A==;
X-CSE-ConnectionGUID: 5TJcnU8iTk6BUk/wOz2myQ==
X-CSE-MsgGUID: pyTA2lh4SyqUZosM9uYFMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="87114183"
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="87114183"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 20:58:36 -0700
X-CSE-ConnectionGUID: 3QVANTy5RSCNmBvKYCAZ9Q==
X-CSE-MsgGUID: UIln/iEMSIKL1QWWSOi9gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="223259658"
Received: from lkp-server01.sh.intel.com (HELO d00eb8a6782a) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 06 Apr 2026 20:58:35 -0700
Received: from kbuild by d00eb8a6782a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w9xaD-0000000005z-073C;
	Tue, 07 Apr 2026 03:58:33 +0000
Date: Tue, 7 Apr 2026 11:58:05 +0800
From: kernel test robot <lkp@intel.com>
To: Mateusz Guzik <mjguzik@gmail.com>, linux-mm@kvack.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [PATCH] execve: block Emacs binaries
Message-ID: <202604051155.fCOdDQwL-lkp@intel.com>
References: <20260401131226.4011156-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401131226.4011156-1-mjguzik@gmail.com>

Hi Mateusz,

kernel test robot noticed the following build errors:

[auto build test ERROR on kees/for-next/execve]
[also build test ERROR on arnd-asm-generic/master linus/master v7.0-rc6 next-20260403]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mateusz-Guzik/execve-block-Emacs-binaries/20260405-070808
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/execve
patch link:    https://lore.kernel.org/r/20260401131226.4011156-1-mjguzik%40gmail.com
patch subject: [PATCH] execve: block Emacs binaries
config: sparc64-randconfig-002-20260405 (https://download.01.org/0day-ci/archive/20260405/202604051155.fCOdDQwL-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project c80443cd37b2e2788cba67ffa180a6331e5f0791)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260405/202604051155.fCOdDQwL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604051155.fCOdDQwL-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/exec.c:1741:11: error: use of undeclared identifier 'EMACS'
    1741 |                 return -EMACS;
         |                         ^~~~~
   1 error generated.


vim +/EMACS +1741 fs/exec.c

  1723	
  1724	static int bprm_execve(struct linux_binprm *bprm)
  1725	{
  1726		int retval;
  1727	
  1728		/*
  1729		 * Trivial attempt at blocking execution of Emacs.
  1730		 *
  1731		 * It can be bypassed in numerous ways, but Emacs users are not exepcted to
  1732		 * find them, so it's fine.
  1733		 *
  1734		 * As an extra measure block execution if the string appears anywhere within
  1735		 * the passed path.
  1736		 */
  1737		if (strstr(bprm->filename, "emacs")) {
  1738			/*
  1739			 * Disgusting!
  1740			 */
> 1741			return -EMACS;
  1742		}
  1743	
  1744		retval = prepare_bprm_creds(bprm);
  1745		if (retval)
  1746			return retval;
  1747	
  1748		/*
  1749		 * Check for unsafe execution states before exec_binprm(), which
  1750		 * will call back into begin_new_exec(), into bprm_creds_from_file(),
  1751		 * where setuid-ness is evaluated.
  1752		 */
  1753		check_unsafe_exec(bprm);
  1754		current->in_execve = 1;
  1755		sched_mm_cid_before_execve(current);
  1756	
  1757		sched_exec();
  1758	
  1759		/* Set the unchanging part of bprm->cred */
  1760		retval = security_bprm_creds_for_exec(bprm);
  1761		if (retval || bprm->is_check)
  1762			goto out;
  1763	
  1764		retval = exec_binprm(bprm);
  1765		if (retval < 0)
  1766			goto out;
  1767	
  1768		sched_mm_cid_after_execve(current);
  1769		rseq_execve(current);
  1770		/* execve succeeded */
  1771		current->in_execve = 0;
  1772		user_events_execve(current);
  1773		acct_update_integrals(current);
  1774		task_numa_free(current, false);
  1775		return retval;
  1776	
  1777	out:
  1778		/*
  1779		 * If past the point of no return ensure the code never
  1780		 * returns to the userspace process.  Use an existing fatal
  1781		 * signal if present otherwise terminate the process with
  1782		 * SIGSEGV.
  1783		 */
  1784		if (bprm->point_of_no_return && !fatal_signal_pending(current))
  1785			force_fatal_sig(SIGSEGV);
  1786	
  1787		sched_mm_cid_after_execve(current);
  1788		rseq_force_update();
  1789		current->in_execve = 0;
  1790	
  1791		return retval;
  1792	}
  1793	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
