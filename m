Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B882E8B71;
	Mon, 30 Mar 2026 09:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774864176; cv=none; b=ems2VflAqH9zbG1x/WfRT1yTSvvVyyuzxa1oC3iiN5K3eAYyU0MuacuxE+40P/pKNh/YwYVctfydBiNuErg9mPOMC/KeWdca2EIJjX0c1ow1G6pNHHFBoeEMQY7dkQqOOowKRrmswS4KqRQGrhX/YbFxiS7tBNO4afS92IayYFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774864176; c=relaxed/simple;
	bh=Yn9cP4D2geToIFO8/nx3k2khEgoesPia9rg9Bm0Rp3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJ60wGju2K+c+6nqnKRvNG7KPYFfVirRXFNjCGoaU5HkrXWBSAB+8RbL3u0y78PNdFKJ1cux79u0q27dCNMUIdQ+8IVoosetpU1FOCNTFZTP8FJH8O9DzJHYIlcogiaryg0mk/DKKD+8/YDsyw2FrzAgzmvBlBb9jwfgAtd05HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JMsU3180; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JMsU3180"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774864175; x=1806400175;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Yn9cP4D2geToIFO8/nx3k2khEgoesPia9rg9Bm0Rp3Y=;
  b=JMsU3180KjucchiFh4xXkjiQQaUxUUA7+BCHPQtRb5SjtV2wzsUNnUGL
   K3CqHWoiSzeaq9nEAPQGZ7Ycsi++yAIMFePduz6PUQMKN2autbXUaINYC
   E2HX//utVVIN1Tv5wuVUbvAkzfOsnSOvmv0qcaZn1t8qFmpOFSvEjffhh
   O6DrgwDV/J5EfZrIbbcaQNxQqaQOc7cQTXfcRBmc5BSY19AAl4pxe9JUN
   Hilsma4z3BlU8eMdiyY4YP69q6QwVFDKgLwdfe7B3XudaVxeD/Bi2WQ9v
   6J/bbYe0liLlLsH8Y9EZxYQoZ5l3v5Y33ljbV84Lft+PsFMZHCcmJDLPi
   Q==;
X-CSE-ConnectionGUID: pAXuHjfhSh2zo26P542u5A==
X-CSE-MsgGUID: 7SZ+rkceRgWykxFPveaqsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="76042771"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="76042771"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 02:49:34 -0700
X-CSE-ConnectionGUID: OZGpkVXyQCusjrM9WiIJrQ==
X-CSE-MsgGUID: lY6d5wE4Rg2BqIacpMCcxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="222695393"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 02:49:32 -0700
Date: Mon, 30 Mar 2026 12:49:29 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Disseldorp <ddiss@suse.de>
Cc: Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 1/6] initramfs_test: add fill_cpio() inject_ox
 parameter
Message-ID: <acpHKXhjOTiZORIY@ashevche-desk.local>
References: <20260329105307.2876-1-ddiss@suse.de>
 <20260329105307.2876-2-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329105307.2876-2-ddiss@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Mar 29, 2026 at 09:30:23PM +1100, David Disseldorp wrote:
> fill_cpio() uses sprintf() to write out the in-memory cpio archive from
> an array of struct initramfs_test_cpio. This change allows callers to
> modify the cpio sprintf() format string so that future tests can
> intentionally corrupt the header with "0x" and "0X" prefixed fields.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

> +/*
> + * bogus newc header with "0x" prefixes on the uid, gid and namesize values.

Perhaps Oxford comma?

> + * parse_header()/simple_str[n]toul() accept this.

Also see a comment in patch 4.

> + */

-- 
With Best Regards,
Andy Shevchenko


