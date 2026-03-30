Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CFE3ACA5F;
	Mon, 30 Mar 2026 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774864232; cv=none; b=ezt5Mw5NF3kD4t3MMIiPANRDvuulKCRkiOm0GuFpkASaBHCL6cKCU5mZgW0MYOc1jlMbNMH8sUGodUFIJHpZFVHPU3mnYq+rRfADV2aFdLx9mg7ZkNmLTe998TE9wjwb5vFkv/Kk4KxRS3KtfP8COqQyrTHNlzbvSHFWM4Blnnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774864232; c=relaxed/simple;
	bh=I5hdGgQyvxGpw1zoQZrzr98c7a19Hfb6oIHj8mNpoys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPFMLaam8zNttN1avnb8cryMaHcFCejFkxWJtvJgsDQCCHuff7YxlS533MJEB+oJYH02Stdrgdvop9ieDcxCAj9NzTGzz5bibx+tNOaNGn1eJu9Y+IgEk14bLue4SWHyu5g9J8lL72ZXAH34TW6lt2phbTeiqQTCIk73GJ5AYZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PgV7cag+; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PgV7cag+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774864231; x=1806400231;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I5hdGgQyvxGpw1zoQZrzr98c7a19Hfb6oIHj8mNpoys=;
  b=PgV7cag+hAXgpEw9m57N1U0ewvUiFG504U59ze8Z76LwYAWRzBjREihI
   60AiqrYJPAqctM948lYudsRKGzC9CiEXraxttzSw+IZsj40CGeM3ZhOMq
   1AlqVkQkIO9cU3sjlsaRxHDmI2ZOfuRTMOu2ws2FJSKS6ldMt5VaFL/Gl
   kbZFsGXdLM6Doz1687NlhXP+Nagmy0Yt0ijtojoTJgbOlXdQ2z1Z7n+nn
   1+NJUn3o7+aZB0sTSGOS0iXW/X3c2dj2UXkeDv0cfG1RayQd4JFfob2nO
   Iz8grTwMH/v4wUcxCqPMlxFXc3LLjl+iMkxxvSYXhp2I4vv8BJWs1+BG+
   A==;
X-CSE-ConnectionGUID: cJ8c07tzRy+E4I/XC7Gi0w==
X-CSE-MsgGUID: GO+kmO9bSY2mOqUMxFpPdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="79454932"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="79454932"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 02:50:30 -0700
X-CSE-ConnectionGUID: ySB/AEIWTs20rqlBXI17dA==
X-CSE-MsgGUID: mndLDD7kRiGgGz+CsgsH8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="226265052"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 02:50:27 -0700
Date: Mon, 30 Mar 2026 12:50:24 +0300
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
Message-ID: <acpHYPiOy-S3PUNT@ashevche-desk.local>
References: <20260329105307.2876-1-ddiss@suse.de>
 <20260329105307.2876-5-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329105307.2876-5-ddiss@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Mar 29, 2026 at 09:30:26PM +1100, David Disseldorp wrote:

> There is a simple_strntoul() function used solely as a shortcut
> for hex2bin() with proper endianess conversions. Replace that
> and drop the unneeded function in the next changes.
> 
> This implementation will abort if we fail to parse the cpio header,
> instead of using potentially bogus header values.

...

>  /*
>   * bogus newc header with "0x" prefixes on the uid, gid and namesize values.
> - * parse_header()/simple_str[n]toul() accept this.
> + * parse_header()/simple_str[n]toul() accepted this, contrary to the initramfs
> + * specification. hex2bin() now fails.
>   */
>  #define CPIO_HDR_OX_INJECT \
>  	"%s%08x%08x0x%06x0X%06x%08x%08x%08x%08x%08x%08x%08x0x%06x%08x%s"

I think this change should be in patch 1.

-- 
With Best Regards,
Andy Shevchenko


