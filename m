Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBAD1E1C02
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 13:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774271840; cv=none; b=LTHYlHwCOem1aj6Z6yWWLJQqU5hx4ybcu39iJ2vGcv7OUDfYKgC5EnjgEm0+CdcDujlbJnKZ4LQ0ROcgVNBN3j58fHQGGZ9Ve5jNTKNk5gm2OGi8Ar3U6mJ0cJrxYBs98EDl/m5CUrsk7g9qhBKaLm3TqXfMxkXqbsG7/rpJ4Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774271840; c=relaxed/simple;
	bh=ih2xZT8cSAgrSQ39UjkTZOAwvgZpaNRyQMrac+q6C1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5SW04Cq4Hc9e29v3OpuYXezNAyoJtqxWriFsau1hbgT9ljVsKwkZZizHZ5vVRk1nVfVyv33tjz8zwFy0Vb+esRYfHa2BwoBFXKHV/wvaEiJUp7FX3cKEMbpdmivr+Mrdlo6nWFFii1usJ4wI68EG4dLvC6vc+R4cLPn3T3qbcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KREw9a6T; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KREw9a6T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774271839; x=1805807839;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ih2xZT8cSAgrSQ39UjkTZOAwvgZpaNRyQMrac+q6C1Q=;
  b=KREw9a6TbD0LyKr7S3U4EwXBNjS6T1ulXskH8BL/Enf8SV6ulj6kebHP
   cEw4K9oraTvfiSF40tPl/yigbBB2rEdMAWc9bBLuy5gKrhBusek5am6gm
   c2iHfdr2ddxOO+Q3dcJbgkbd46dAmG8MNG0YKnR25XZSIyeOrAhE4jjAz
   kySviBanxBGAjUJDClLhzRXd4S5HAO0VJfjOMR4JZFN9LH0baPwJPsG5M
   C2PX26TXDqsB8yUbMf4x1hlwyA7lmRaSmmxjw5G6fZS+IyU5lFqNpI4L8
   De9badcDqGhX57FYf0YSoYchUr0AH/r/AEIqOwElf1OIk1hnLoDqBdM8w
   g==;
X-CSE-ConnectionGUID: 9MzL27WqTmq2O8WUljU1Zg==
X-CSE-MsgGUID: pR3taPYpSIa8a2MtGJIuqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="86742207"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="86742207"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 06:17:18 -0700
X-CSE-ConnectionGUID: nGPwzmKTQZm4QU0wlq2T+g==
X-CSE-MsgGUID: S6hx8wlrS8SGd+0hpqQPgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="223214242"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.22])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 06:17:17 -0700
Date: Mon, 23 Mar 2026 15:17:14 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Disseldorp <ddiss@suse.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] SQUASH: test and improve cpio hex header
 validation
Message-ID: <acE9WhfcBT0XahXu@ashevche-desk.local>
References: <20260121172749.32322-1-ddiss@suse.de>
 <20260323225318.062bec14.ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323225318.062bec14.ddiss@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 23, 2026 at 10:53:18PM +1100, David Disseldorp wrote:
> On Thu, 22 Jan 2026 04:12:48 +1100, David Disseldorp wrote:
> 
> > This patchset is a combination of my
> > https://lore.kernel.org/linux-fsdevel/20260120204715.14529-1-ddiss@suse.de/
> > and Andy's
> > https://lore.kernel.org/linux-fsdevel/20260119204151.1447503-1-andriy.shevchenko@linux.intel.com/
> > patchsets.
> > 
> > The reason for combining them is so that a the initramfs_test case can
> > track the user-facing change in header parsing behaviour for cpio
> > fields that carry a "0x" hex prefix.
> > 
> > @Andy: please feel free to squash the two SQUASH flagged patches into
> > your 4/8 hex2bin() patch.
> 
> It seems this series stalled. Did you have any thoughts on the SQUASH
> flagged patches? I think it makes sense to go ahead with your hex2bin
> changes. I can split the initramfs_test changes out into a separate
> series again if you'd prefer.

Okay, let me send a new version.

-- 
With Best Regards,
Andy Shevchenko


