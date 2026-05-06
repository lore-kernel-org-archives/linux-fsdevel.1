Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86DE20CCDC;
	Wed,  6 May 2026 02:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778034096; cv=none; b=Qr8Xg6icc5lLZzEk8a0N0mTN8Dyh/+sPfvdv2biHeXN1OHphKCIoyvzgRL3a+YNarI9ZW3auFfTRlOV/ScZ3oLtX7G/G/ZOTXzppmrM6Vq8XfrIJ7tZsF98UgFnUloYzS04w/LmVm4TxoWlDQcqel4J8Jv8dwD3dUlqQMk4YQmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778034096; c=relaxed/simple;
	bh=x3WgQ0GtPAwyxJvEgtzHUnkMpQn2VPK21q2th5XcYpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAw5Xuqk8rPSSRkmWWkcQJMFRAA2zqd39yORTrUv2n5DWfm/ynJM6Ht1tp/1xZveCygBwUME7i8qmdG5VaggjEQ3oSsNqdI+AZ7zDSWA3FV3msu/ojnLhMLR+V4BRxcU29+LLzmIzQB4ad1ehEZWA7P7DMt1BC7965YFh4tQmFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=QWXBzqSg; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="QWXBzqSg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OjX7yfRjM0ugHVZowd3jdpL3yzhZGjOSZE42HlX8msw=; b=QWXBzqSg1EHQHZMULm3DllkIir
	ttVIIgnx2FjdGZARnidTj1I69A385Zl5PgQzNMTRbL8jQH+uUwDP8706mFqJ7jSaG5OlBWzCxqRGa
	SVx49hM15UzvFkGRY49XNj0TTriSQEzwgpahMxGSPgTY6sJUR6V/uxUtFaKE50w9DSQMmzmed3tId
	BCRq/+Z8UKCWYPSZlG12eZjhP6yW7GhXwjEo6RNTI2jLyZ+BF+B42HyfpxYXaFNwnDYptnT6jU6QP
	Iht3OlIflRb7s2g2wWbhmnDvOejaur4vlFOSQ22B5xivyLeloWJkFk5iF7oCph2vGPQUg1NxjrMg+
	jgLQK+oQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKRtY-0000000BQSr-3fJX;
	Wed, 06 May 2026 02:21:53 +0000
Date: Wed, 6 May 2026 03:21:52 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Vineet Agarwal <agarwal.vineet2006@gmail.com>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot <syzbot@syzkaller.appspotmail.com>
Subject: Re: [PATCH] fs/namespace: fix NULL pointer dereference in
 do_lock_mount()
Message-ID: <20260506022152.GK3518998@ZenIV>
References: <20260505095156.178351-1-agarwal.vineet2006@gmail.com>
 <afn88B9Z5TM-0d0T@lt-jori.localdomain>
 <CA+rjy8fM+8ahj7dcBWjnACU8xBWBqW4ssQFpi68dqRc-F-V3Xg@mail.gmail.com>
 <20260506021230.GJ3518998@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506021230.GJ3518998@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, May 06, 2026 at 03:12:30AM +0100, Al Viro wrote:

> Do you have a reproducer?  Which kernel it is and what .config is used?
> Incidentally, do the checks in your patch actually trigger on the setup
> you are testing?

While we are at it, could you post the stack traces of these oopsen?
