Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B364382399;
	Tue, 31 Mar 2026 10:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774951985; cv=none; b=X4Klz/3OpT2WLY22eQeOnrCEieohTTujnlfoys82tqwtTOZ49fS8cX9KXGNsYoBYWrJFdO1v65pqeN+eC6vdDUckWEgsx43J4bV+F2EkN3vwCx2MX141oAY7SOS15nRa1/MVMnwIXqOl4uXFTFnRNNa61uENBedYXbhv0zchtHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774951985; c=relaxed/simple;
	bh=KfGHa1bv+FyKM0v084rlpSNAxXZaqrsVpJSPsiTc0lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WpEPuJLuU6/ahIH8rkT61tD2LCnfZz0lfIi31P4tfZpRilJxE6OEjGuTYW3lFueNvnsWZ216KiGmvQFZRJvD2wFcYGe/EyHOrd//qnWYr9x4Ksh82B9gpQSxr20FaFYwURmPkznLBPg3JHVeydIqG0j6Zm3Gvhl0Y79JkaBUI94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YFOMd4c+; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YFOMd4c+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774951984; x=1806487984;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KfGHa1bv+FyKM0v084rlpSNAxXZaqrsVpJSPsiTc0lI=;
  b=YFOMd4c+EoFPXZMwYSLUEbYB0X88aZQcc6vENw4mblMsMkqJBPymP0fT
   PWJkOqrsYoqhwPnLZseIUqQD0aoRPyPo38AnUqbmap02XOYpSSfBmP1l4
   va8uSOLWmXFDsqMnc2gKfyc3Ut4krcCHK/n/SJSTsAzUfyquGPmECrJy3
   X+s0iTULiBlXGzcUpLscHBf5sRAXruGxE1CO76FW/ISXzkHnRNpJ6iM/N
   EQ0UyZhhGdT8d10O1WMej8w9tyM043x47ejFM5AujDx1/ksth5V2gSGa8
   A4E7Mn4elP3JZGkil4S8f3olmqEHmDzZ3+/YRC9uAkN2LlNwwjRuHbCm2
   g==;
X-CSE-ConnectionGUID: xoy8M0OCR4ue2esTen2NFw==
X-CSE-MsgGUID: eq3ptRVITGq8UIdzGXMKdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="75843516"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="75843516"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 03:13:03 -0700
X-CSE-ConnectionGUID: mcFxOcQXRIaWHF5WfVD/bw==
X-CSE-MsgGUID: GOHk04g/SzSxiwrLQBVwPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="249525901"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 03:12:59 -0700
Date: Tue, 31 Mar 2026 13:12:57 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Disseldorp <ddiss@suse.de>
Cc: Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 2/6] initramfs_test: test header fields with 0x hex
 prefix
Message-ID: <acueKdFBUQXYxQrY@ashevche-desk.local>
References: <20260331070519.5974-1-ddiss@suse.de>
 <20260331070519.5974-3-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331070519.5974-3-ddiss@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Mar 31, 2026 at 05:57:32PM +1100, David Disseldorp wrote:
> cpio header fields are 8-byte hex strings, but one "interesting"
> side-effect of our historic simple_str[n]toul() use means that a "0x"
> (or "0X") prefixed header field will be successfully processed when
> coupled alongside a 6-byte hex remainder string.
> 
> "0x" prefix support is contrary to the initramfs specification at
> Documentation/driver-api/early-userspace/buffer-format.rst which states:
> 
>   The structure of the cpio_header is as follows (all fields contain
>   hexadecimal ASCII numbers fully padded with '0' on the left to the
>   full width of the field, for example, the integer 4780 is represented
>   by the ASCII string "000012ac"):
> 
> Test for this corner case by injecting "0x" prefixes into the uid, gid
> and namesize cpio header fields. Confirm that init_stat() returns
> matching uid and gid values.
> 
> This test can be modified in future to expect unpack_to_rootfs() failure
> when header validation is changed to properly follow the specification.
> 
> Add some missing struct kstat initializations to account for possible
> init_stat() failures.

Right, thanks.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


