Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AFC40DFBD
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Apr 2026 21:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776547980; cv=none; b=SA0yRl9ELm9ERKCIKVsS3JWY4aEO/ieZJ4HcTmyD7zgOKW0gN+8iCbOZ8gBYF75+bYWLqL65WHMpT/Er4BtZhVUd69/0FqerUuhswcwosE+0arVxNTsHwj+OoqSwJ4OL26aU2QR/Ab1yc2lTR2ndHGHl28lwayfzyhUlF2FU9yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776547980; c=relaxed/simple;
	bh=bRWAr1sHm3FI6Lj331+ZxY01lFHEhqUNpzdkBK6spCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fYYoJXhwLQqalOoDByncfcNWA4kdUZjWBOYpkEfMlCtOe4g4f7SJVBWZomkLB9XXBZhTDuvHcFKWFco9qvE15Uvqgk404XpLtE6boWYIaCbvkYzyQHV7pqX8jvaCWAKSOQOtclmAsrWFnOnCoYYJzu7ev4COgZ04RUfFR2LSZUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AvpOkjgR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AvpOkjgR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SklTkomoz6BngvqaTC/W/jtZITRWybZJVeL0/xrM3d4=; b=AvpOkjgRmIrblvbjDY/bU0Ugnl
	lpWKGs0xt+RTICUyysNAxrrRejsNvE2RIQO++xE0rHQ3Wo/AJDXiy1OFlSDQOJQ/Qf6R0JvawTw+w
	zzUXNwGcdVOTK4+O4X6p6XGbZLG4qeVqWejGjhwo9vr+twJd3DVj8roDgRA+8ZWltDvQ3FyYxW0i+
	Lxtz+yv/aCTUdLASxJAFIhsiszr+E2knVa6LJMtgjvNsIDZJZQFWFkpzW4ZG2NOV4wH7vH5Bv2+Rq
	gKB1BjmQnaA1WPxtrrbG3Wr95B0qUz0bZG43JTM7tB+HTlmJNHZJW5ZL/xBRTRjSRIMsqYaekZMX/
	ZhAQFl3Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEDHV-000000061vY-1rVS;
	Sat, 18 Apr 2026 21:32:49 +0000
Date: Sat, 18 Apr 2026 22:32:49 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH] docs: add guidelines for submitting new filesystems
Message-ID: <aeP4gT5T69izWj-m@casper.infradead.org>
References: <20260417142503.1436446-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417142503.1436446-1-amir73il@gmail.com>

On Fri, Apr 17, 2026 at 04:25:03PM +0200, Amir Goldstein wrote:
> +Be testable
> +  The filesystem must be testable in a meaningful way.  The
> +  `fstests <https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git>`_
> +  framework (also known as xfstests) is the standard testing infrastructure
> +  for Linux filesystems and its use is highly recommended.  At a minimum,
> +  there must be a credible and documented way to test the filesystem and
> +  detect regressions.  When submitting, include a summary of test results
> +  indicating which tests pass, fail, or are not applicable.

Perhaps we need a section on fuzzing?  Maybe something like this:

Fuzzing
  Filesystems in the Linux kernel are subjected to various fuzzing
  activities, by academic researchers, syzbot and malicious actors.
  Your filesystem will need to be robust against not just random
  syscalls but also fuzzed (corrupted) filesystem images (for block
  based filesystems) and crafted hostile network messages (for network
  filesystems).  It should react appropriately to such attacks,
  by repairing or reporting a corrupted filesystem, but not hanging
  executing BUG() or WARN() statements or otherwise corrupting the kernel.

Happy for you to reword that.
