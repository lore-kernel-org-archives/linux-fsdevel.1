Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBE23E0740;
	Thu,  4 Jun 2026 09:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780566386; cv=none; b=m8NfOZQHk2cdz/+UQsOutP6pCNDAwyQNb/oV8MijPuVXvXo++xM11AHrw03YYuhN8OzxfqC6jloAPwteg3bqk0PuUFt3WYOnZjt7pXUDyZHlrDzVg+K/ENc0Wn5bigJIzhElttbNweqStmkQICKvqlFSMxU//BJb2xqelMtRmbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780566386; c=relaxed/simple;
	bh=EcAQyhRe6QJnGmVDk+paEj4+UjC/1VaN20VYD8oIn7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=heqtQg1MIq3JkMObr2/lOOjWTxogcwoJ6zzKWvMM0N2Kwm2HxSkY31By7wUBrbb5/RmKui7LTKXYGLSFpL1JFC5rg2PaNwG5GRvlb3FbSdNVuKVR4ffQokt2bebSYaAliv/bP7zTOKVudllfPZ4NbbBWnhwvwI6/BYNGWkxl3yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eqM9llZz; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eqM9llZz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780566385; x=1812102385;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EcAQyhRe6QJnGmVDk+paEj4+UjC/1VaN20VYD8oIn7I=;
  b=eqM9llZzkiYHJ4OAsTLoGt5hNsKRobRAfPe3Uo2UeN4VrkWVjT2ALeP7
   50RtnD3RpXNkZcTmhDq/XOWn9BSG8yxba6BfsANfuBX6bd/ubNUy4FOyi
   KLXsOC4UMo8YLCGodzcZiffpom4d82KPNhah8zTVEiwzxNEOUVTccc5iG
   q1t385WQVQEsSrKN5GgSDWtvgsXWzevnC45hcBs9JrOcJulYyu7jj0IFf
   BzaK3kZPwfPgU1SGI8uAeTgT8OqHnjD1319kS7aHGYQz2+ZWez5S4UEa/
   8E+zE7uKvcrZyfNRX8Tphs2J+20IITprkHeNuQaSe/n6g7lxoGELAlS7z
   A==;
X-CSE-ConnectionGUID: i/BqkVsWQqqp+TPapCRZPg==
X-CSE-MsgGUID: uiicGHOQQl+GCjQVGLZMbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="92876124"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="92876124"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 02:46:25 -0700
X-CSE-ConnectionGUID: gImnoFVrRSaSle3qakSu3Q==
X-CSE-MsgGUID: tXQsxuPMRRi9fruIRoRjXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="249422051"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 02:46:23 -0700
Date: Thu, 4 Jun 2026 12:46:20 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Christian Brauner (Amutable)" <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v1 1/1] fs/read_write: Do not export __kernel_write() to
 the entire world
Message-ID: <aiFJbEm-b0-tF86B@ashevche-desk.local>
References: <20260604092821.247680-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604092821.247680-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 04, 2026 at 11:28:21AM +0200, Andy Shevchenko wrote:

...

> -EXPORT_SYMBOL_GPL(__kernel_write);
> +EXPORT_SYMBOL_GPL_FOR_MODULES(__kernel_write, "autofs");

Sorry, The GPL here was removed in a somewhat recent kernels. This won't build
on the current. I will send a v2.

-- 
With Best Regards,
Andy Shevchenko


