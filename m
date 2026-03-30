Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE581339B1;
	Mon, 30 Mar 2026 09:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774864524; cv=none; b=YFWKIUYN9LoimnSgX4TV2iSfjXDjTA4bB20aXF6lNwTHuSBZvd5d0XtcGof8HOmVXP9Ya5BTCmJAGJNkUaECsnUVlfFZ/QeHD4nmxgLcYwBFTif/nS58snxEEJq0qRjq7dO0v3sYdJxJecr1AEtQsfmOzEdrh0J8BFgq6axF39E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774864524; c=relaxed/simple;
	bh=bI8GEwBV3kEctvAD5i+rnJfni2MF7fSXKnvfq4B2Ieo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YX9A2UGREfDlzfI2I/EGk2jovHKzxGSt1suf65sowhesBbZWndKRKI6AGIbd0TdBuBqLwcKkkZNjED1fFi9TTspXnUsarB7xAHoM8ZOgd+/LISag9+N3sQ0XUFWehDkaJbVN5eAiNz9LO+SD9m8zoADWLeLpvaw2jkoT38GFcmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nhPL6lZv; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nhPL6lZv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774864524; x=1806400524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bI8GEwBV3kEctvAD5i+rnJfni2MF7fSXKnvfq4B2Ieo=;
  b=nhPL6lZvrXEwo4JUSNjNR+ChAesXQsAvlocFag+Ib2bINCrJPxHCQSed
   oqlhjaBEoyNwWITbHXNT7ZTcFMGd3kT/glyPLFrEQAaMuqgZyzfB+JEv8
   a/0FoVwlctOYysp+beCrDGfdBBvTHm3XbMWj9D5Bz8asCk0VUCGRk1Z0S
   lvnZ3zOvmJW6BWNmrvdHH6EevGlYXEMktfYorrSaFGrGzac5TPV74jvXu
   g13igYkax+SEWDDe5LvVtsvbvJ4cRbAVyN3Bey+V/5lr987RC4j0ccBzf
   atI3mxIdpEoYCZn/OxFTtgsAu6TW8BqMVX5gwyGxDTrJPhaBBK9vvlQqy
   A==;
X-CSE-ConnectionGUID: AGdXMikoRVuuoa4nlVkvgg==
X-CSE-MsgGUID: e+ki3PnfQ468qEJ56MxYgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="98464181"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="98464181"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 02:55:23 -0700
X-CSE-ConnectionGUID: kOoYYJGzSWy8ZGaURWomJg==
X-CSE-MsgGUID: F9aVXxkJTveK+5kKFiVwHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="230067470"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 02:55:20 -0700
Date: Mon, 30 Mar 2026 12:55:16 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Disseldorp <ddiss@suse.de>
Cc: Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 4/6] initramfs: Refactor to use hex2bin() instead of
 custom approach
Message-ID: <acpIhBT22b2H4rfr@ashevche-desk.local>
References: <20260329105307.2876-1-ddiss@suse.de>
 <20260329105307.2876-5-ddiss@suse.de>
 <acpHYPiOy-S3PUNT@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acpHYPiOy-S3PUNT@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 30, 2026 at 12:50:30PM +0300, Andy Shevchenko wrote:
> On Sun, Mar 29, 2026 at 09:30:26PM +1100, David Disseldorp wrote:

...

> >  /*
> >   * bogus newc header with "0x" prefixes on the uid, gid and namesize values.
> > - * parse_header()/simple_str[n]toul() accept this.
> > + * parse_header()/simple_str[n]toul() accepted this, contrary to the initramfs
> > + * specification. hex2bin() now fails.
> >   */
> >  #define CPIO_HDR_OX_INJECT \
> >  	"%s%08x%08x0x%06x0X%06x%08x%08x%08x%08x%08x%08x%08x0x%06x%08x%s"
> 
> I think this change should be in patch 1.

Hmm... Re-reading it, seems the both needs to be updated.

For the patch 1:

 * Bogus newc header with "0x" prefixes on the uid, gid, and namesize values.
 * parse_header()/simple_str[n]toul() accept this, contrary to the initramfs
 * specification.

For the patch 4:

 * Bogus newc header with "0x" prefixes on the uid, gid, and namesize values.
 * parse_header()/simple_str[n]toul() accepted this, contrary to the initramfs
 * specification. hex2bin() now fails.

-- 
With Best Regards,
Andy Shevchenko


