Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B710C4C901E;
	Thu,  4 Jun 2026 17:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780594872; cv=none; b=d5zOyT+EqYwIbzikT4mlA/IIe9b+JbXViL2MxpCCY4JmJ96uahjSqMa1O/6HJbfIPebJkfAESTQ5A4yP929xoNtXY3NJ5siUbaWSYxCPz0JgKShF1p0X4IuKf6YY66Gy+OuYQFr/uHt1Pxi/JZt6sJUS3iBp6atBpM0FcCVkZ+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780594872; c=relaxed/simple;
	bh=M/Og9lWRieiXcFbU1iM6IZCxavgEoay3nykz+VQBczM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMkHQPbAyEjaIsNAOPFobNUD2BVI5BKJ/gRT/hvboNVyQ6KqqsOJcaD0Ozc7b5DHQk+y3MNrE3a/n301qnV+f9tmsSTjNvNznOFvYeEL1SugID+v5OknIssHstPGyDETbFtfSVEz6WUOhNJ8Nl8ILVSwJHIl0xaiG9OnOTreOjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WKxfQ/Yq; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WKxfQ/Yq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780594871; x=1812130871;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M/Og9lWRieiXcFbU1iM6IZCxavgEoay3nykz+VQBczM=;
  b=WKxfQ/YqKKI3OrH1Pyo/bspZggxIP65bCsuzcFnkmNyUoYT1fA2dNBS7
   wdD22pb9XT2oyniROkQ0kGPryBvH4uwzDW1zGWpXsTtnv8/UYbhDqXabn
   JLeLtnbjYoCjarWknQhUGD9Jlq/BE9GUrxl66GbKCDmiRnMFfickOKQu5
   z+wjMzlGG5G5ONkL5ohBPXvs5sbVG6GQKooZNuLUuVFZ2TmdiMvQwNL+C
   p2bO/11puS+3FKPiDCKgy1wx0gCbIVD3EAa8xXN6hB7JUHdA47FOuA/mh
   GmfW/geCgixMsBdRcat18ojlXUESO7rLo7p0JJC1CUeuP8E28kDol0sxt
   A==;
X-CSE-ConnectionGUID: EZG+7is5QOK/g6GDopb4qA==
X-CSE-MsgGUID: ygAJVtm/Rle5HrXeQX17lA==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="92537264"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="92537264"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 10:41:10 -0700
X-CSE-ConnectionGUID: C3RHm6gSSDua6N9IGJwqBw==
X-CSE-MsgGUID: tTh9GSAcTi61ZU218l7pSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="274855856"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa002.jf.intel.com with ESMTP; 04 Jun 2026 10:41:07 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 6B2FE98; Thu, 04 Jun 2026 19:41:06 +0200 (CEST)
Date: Thu, 4 Jun 2026 19:41:06 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Richard Fung <richardfung@google.com>
Cc: Eric Biggers <ebiggers@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>, Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] fuse: fs-verity: aoid out-of-range comparison
Message-ID: <aiG4suLcgILS8Hha@black.igk.intel.com>
References: <20240730142802.1082627-1-arnd@kernel.org>
 <20240801010953.GA1835661@google.com>
 <CAGndiTNdCGuHRmnp+G-=_PzTaLXnUZpuXAT8dK-wdoG7Mpwt4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGndiTNdCGuHRmnp+G-=_PzTaLXnUZpuXAT8dK-wdoG7Mpwt4A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Aug 01, 2024 at 10:45:01AM -0700, Richard Fung wrote:
> > I think this was just defensive coding to ensure that the assignment to
> > iov_len can't overflow regardless of the type of digest_size
> 
> I agree with this. Removing it sounds good to me

Where we are with this? I have just stumbled over this issue yesterday when
tried to have `make W=1` clean build of fs/.

-- 
With Best Regards,
Andy Shevchenko


