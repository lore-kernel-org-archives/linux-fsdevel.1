Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA96D35B632;
	Thu,  9 Apr 2026 08:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775724539; cv=none; b=icp6QAZcjOUY1HWNtwhbMHePUeV+m0YHod/ENkuHZpVIcBD6sofdx+lh+ShleVIBSMJ/uraFPO/nhYQxLNxjHEnOL4M3atC+3MZq2JtK83I/gTAnae9MPsKQJKzKViWOxsrFvbYQdzcwpkhFHslxXLCTlP/c2ySwTx59aYj9kBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775724539; c=relaxed/simple;
	bh=eAqTo0iQZIB/nmUmtWdYSxA1QZLSoGfvAUXtQLRvMDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Atk/po4Orz7JdaqD6geUCK9fbjkz3Si7GB8aygeSgghkEwQmERZW3wTpVwFFuVcQt6G6l2SRNoKIlzP7YV1WEV8gAUcrxeHDpseYWh0VwOrP2yk147HwjOaUgXuepvObprCEHntDfY1RsMdJHK7xhAH+V8cvm7Y0wCZuQEh7x9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hpB+WSLN; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hpB+WSLN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775724538; x=1807260538;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eAqTo0iQZIB/nmUmtWdYSxA1QZLSoGfvAUXtQLRvMDU=;
  b=hpB+WSLNuTKA7ez+4nStSUelWpJZlY5uBYnH4Icbe6r4aePkmvYujn0p
   x2XMQ2dukL1+FJRxguLp7WkYniJ50lsjkRTFeJKrAPgiLUgBAzvnNvqMW
   yCy/A+gQC33JjOrLmwmwtaNRD3uziTi3c+VsuoBDRv/qQhTZ1ppZSSkDa
   q9o0rx/39dXydRIVodDC5LBr+JruYZEsyx24J8SLoBnj3NhI75aeg+053
   sRU5ownW71KR0lkjT0SZ//9dfk3ttBLx8tfESWZ+wbJc9/zVGL65bkqqH
   PxpjGXQ51Myppthfhz0/Q1MXqLHFPUmyN4+SjE6EQX4OlTZWvqsxxuv1s
   Q==;
X-CSE-ConnectionGUID: F8A2OnusTf+JhuGS8tY6cA==
X-CSE-MsgGUID: V2dVhi+tTpOQxWKXjvIC1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76441734"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="76441734"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 01:48:58 -0700
X-CSE-ConnectionGUID: /kRpxIXfQxuNarG/WAD9uw==
X-CSE-MsgGUID: EhdljPDqRJ+EESDAjgUlnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="225546762"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.162])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 01:48:54 -0700
Date: Thu, 9 Apr 2026 11:48:52 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petr Mladek <pmladek@suse.com>
Cc: David Disseldorp <ddiss@suse.de>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 0/6] initramfs: test and improve cpio hex header
 validation
Message-ID: <addn9HXBt8SV9x-D@ashevche-desk.local>
References: <20260331070519.5974-1-ddiss@suse.de>
 <ac0Wd1tmV0ndmE1-@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac0Wd1tmV0ndmE1-@pathway.suse.cz>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 01, 2026 at 02:58:31PM +0200, Petr Mladek wrote:
> On Tue 2026-03-31 17:57:30, David Disseldorp wrote:
> > v5 changes:
> > - rework 2/6 and 4/6 test comment, as suggested by Andy
> > - 2/6: initialize struct kstat in tests to account for possible
> >   init_stat() failure
> >   + drop Andy's review tag due to this minor change
> > 
> > ----------------------------------------------------------------
> > v4: 20260329105307.2876-1-ddiss@suse.de
> > - rework initramfs_test changes to use an inject_ox parameter instead of
> >   having tests pass through an unvalidated format string.
> >   + drop Andy's reviewed-by from 1/6 and 2/6 to account for changed test
> >   + 4/6 minor changes for test context and comment
> > - add review tags for 3/6, 5/6 and 6/6 following list feedback
> > 
> > ----------------------------------------------------------------
> > v3: 20260323150054.3587083-1-andriy.shevchenko@linux.intel.com
> > 
> > The series that introduced simple_strntoul() had passed into kernel
> > without proper review and hence reinvented a wheel that's not needed.
> > Here is the refactoring to show that. It can go via PRINTK or VFS
> > tree.
> > 
> > I have tested this on x86, but I believe the same result will be
> > on big-endian CPUs (I deduced that from how strtox() works).
> > 
> > I also run KUnit tests.
> > 
> > Changelog v3:
> > - rebased on top of latest kernel
> > - squashed patches proposed by David
> > 
> > v2: 20260121172749.32322-1-ddiss@suse.de
> > v1: 20260119204151.1447503-1-andriy.shevchenko@linux.intel.com
> > 
> > ----------------------------------------------------------------
> > Andy Shevchenko (4):
> >       initramfs: Sort headers alphabetically
> >       initramfs: Refactor to use hex2bin() instead of custom approach
> >       vsprintf: Revert "add simple_strntoul"
> >       kstrtox: Drop extern keyword in the simple_strtox() declarations
> > 
> > David Disseldorp (2):
> >       initramfs_test: add fill_cpio() inject_ox parameter
> >       initramfs_test: test header fields with 0x hex prefix
> 
> The patchset seems to be ready for linux-next. I could take it via
> printk tree.
> 
> But I would like see an ACK from a VFS maintainer first.

Christian, what route do you prefer?

-- 
With Best Regards,
Andy Shevchenko


