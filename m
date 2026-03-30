Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A39D3AEF2E;
	Mon, 30 Mar 2026 09:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774864355; cv=none; b=XBca02/R4AkvMtB2oFqXv9d9Imb7jGjpXKyfJggE/X/LsLDwcRJza0dZSXerCFEO7Xvi0lK6929FMecUT9H5TnssvXJjl1UxylZHgqhUPkNluraRyXRXhjGMrByPVc8bMGQjOBM3hxigKbnZCBzUTjlvc0pFjdeJVB/iTfYLj2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774864355; c=relaxed/simple;
	bh=ETPr5OXjqs7uuattlDMeDSe4f9bgfpxj1zefQvx842k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqZmrQ/MCsspLoC66XRX4nZ2Emrr+WcVRiKcHySr5I96P1PE5k6AGM5Pzv0Sku56a+BVOZGK4bmXi68DkVgwtQK+6B5j+pBSCPaA0Vndt8FQdHU3MJrQqN1u5cBhEZtdRVtEIYv3lX6bzoVsKLNYFFkNu7weSfb+UKWx9MPKFEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MMX6m/9G; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MMX6m/9G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774864354; x=1806400354;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ETPr5OXjqs7uuattlDMeDSe4f9bgfpxj1zefQvx842k=;
  b=MMX6m/9G5FL9DOWih8a8DTYiWVR+MTyKdQadR7otN9ZVsHcqMEIjbrYy
   DHsrdhcXhZgNG/fn35xUPpbGugNhf8bPghUCoIXiV3rKaUhPysbR5MFzE
   skj1UaCO5cLIR4lN6eAggV10q8AFcCy9I9NW5dtByVZhlVhIDdCqQ/R6m
   ULqotw+7+VT5kbnHR7F7gXYfVVeTT1HlK8rbIAsiIpBkEsdFm2ZjJG33h
   n5DfYFm22sXAModjjcHldjnQn9AliZ0CQo24XHp7JwcX3c47ZhDGTxvjD
   +nDH6wEmzml9EnpfJJQoOZMHOeWjClvQLpPRethQE2UrdcylKXNJfAPOF
   w==;
X-CSE-ConnectionGUID: dhPMwEqeSSqYCm59hdMutA==
X-CSE-MsgGUID: U0BudTU8SoWL5qGO4u2jIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="79717755"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="79717755"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 02:52:31 -0700
X-CSE-ConnectionGUID: b+Cf3hY8RWCCCKCbn6xdAQ==
X-CSE-MsgGUID: dFkwAfJ8QZCTbtaCzesgRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="221610617"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 02:52:27 -0700
Date: Mon, 30 Mar 2026 12:52:25 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Disseldorp <ddiss@suse.de>
Cc: Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 2/6] initramfs_test: test header fields with 0x hex
 prefix
Message-ID: <acpH2aGdrwoJrmUF@ashevche-desk.local>
References: <20260329105307.2876-1-ddiss@suse.de>
 <20260329105307.2876-3-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329105307.2876-3-ddiss@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Mar 29, 2026 at 09:30:24PM +1100, David Disseldorp wrote:
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

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


