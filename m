Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB752370D47;
	Thu,  2 Apr 2026 12:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775134480; cv=none; b=TXdnUoU6oNSiqN6iJEFjlbw2jLGsdRrUmwpRQ5lxpklO5QXbBpCHG8l7uCuWNpviJOxlP4eAwhLsLQEJfX0hq224r0z0d3oStRLrwsov1KlWHFbcSHNNohw75FeHi++1WMPWECw6QjmWxf78Lg/jF2JXDBYdgD+wxCfRZgWZIAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775134480; c=relaxed/simple;
	bh=JxQBCwxJeOsKgCdFBFvQ5GwSDpS2HV+gb7mav0OmdM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9bDZ7pqsUQVcRUZuYNbBwc5hBWBLLb1L8/USqdVR0bv8w2ZI/7snJlewai6WMkoMSBrRg8EpBxKhXWFmVOBdoC6v1mWhAw5TD0JW4bu+lK19MMn2vPLp8OwkWxzsQQX4mM9iQQZJzAZlx/7kmXrk0KB0Jt9agOtFExXbfKlte4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cQLOLg80; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cQLOLg80"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=h7s8k7aMx6/zITyQQmXFAAylJN8natJY4Juu8aMTILw=; b=cQLOLg80DosbYCgrlISgbSn7Nt
	h7i1PIFACEa6Fk9AjOVIYci775a1yQdqJrRoO4Zi8xHz6zqRo5q8DBhw0ARbm3nXp/hCdzdGC8gHD
	PkpMNFLJlRwYCCJAujfvcDfYgNl1+cJoWG/vPpEMgeKZrhxwKKBRizdbVZ8uE53EPsBgqzBZMQI2R
	H1aRR3avWVAVpmGQh4+Uawp9MF7KWSCFTxgCal4mR/hHoFi2xrxWn+sraXrkV8FcKZsYOT5X49qnO
	oNW542jd0Fb1ftKVQ4h0snvr5482NWgZx/0lItgsY25kQUkJxZRJVnLQaTlMtzTolIDvxeRUbKdQ+
	3lFEuBmQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8HZ8-0000000CJdQ-28t5;
	Thu, 02 Apr 2026 12:54:30 +0000
Date: Thu, 2 Apr 2026 13:54:30 +0100
From: Matthew Wilcox <willy@infradead.org>
To: ven0mfuzzer <ven0mkernelfuzzer@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [BUG] BeeGFS 7.4.4 =?utf-8?Q?Use-After?=
 =?utf-8?Q?-Free_in_FhgfsInode=5FreferenceHandle_via_Message_Type_Corrupti?=
 =?utf-8?B?b24gKFPihpJDKQ==?=
Message-ID: <ac5nBvbUiRaI6nD6@casper.infradead.org>
References: <69ce4def.170a0220.9e8ab.803e@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69ce4def.170a0220.9e8ab.803e@mx.google.com>

On Thu, Apr 02, 2026 at 07:07:25PM +0800, ven0mfuzzer wrote:
> BeeGFS 7.4.4 Use-After-Free in FhgfsInode_referenceHandle via Message Type Corruption (S→C)

I was today years old when I heard of BeeGFS.  It's not part of Linux.
You probably need to report this to the BeeGFS maintainers, whoever they
are.
