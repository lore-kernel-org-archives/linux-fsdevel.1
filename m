Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C160B311963;
	Mon,  6 Apr 2026 20:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775505835; cv=none; b=dyXZelC8sci8qpV7Ic4Z12YvzDvecx1kIQ+lw8kOkUmdCm4/+lcy2k7AvdyYZCIsWLvo5skK2PO3P9uJvRyY5SkI9h9wCxTlVkAWIlkLFBjl2sJyUxAHV+hMcFqcaunvsyKP6uEcJA2Q9JNSjXsHDwf5O/qFa+G5t2xYLYBZPTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775505835; c=relaxed/simple;
	bh=4S/MnipbnS3vwSiuyX8oJjCLfGjnUdVy8YbbNjB3viw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drMF20d6733AviWMNY9Xrw6ehtoE/HXdQis/t25sNUCkTD/MIpSi2nuRjmmLmA1/LuVHf+a7G1HovUbya/8U67wUE9Ug147J/zcTB9MWfq0ZUB1YsrKDsUfoOJcnioclwo6LdGA1ZruaiRWiYoo+wV6gNvO9SHvhnO1S5WEq8GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=fYlT3pe6; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="fYlT3pe6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xdCPI5FovcsLxaxWp2Vw3rhw5szxgMLoj8VQSobmJyY=; b=fYlT3pe6jkhDgNnyPY/Bs5heit
	Qbs3CX/UkbhT1ErdA+vZfbv10x8Ox2uU/LXAaxQetjyWN9QYR7Y/Lh+m9b8fI9mXwh+xFN+5kPQbe
	+D2HwVBOTCruzZ+UQVRv4je27bW9bIkuu9/9vj/kUdOurd1fWPbVW+9ZpQ6lfC5ilW4Ffv6J1eXEf
	/mhy9h/3rnBwLHssjlIk1mJzRuxFJH/MIRZ0nLRRenvJciW0im6ILadwGL/cB0KI0LIJqlC+/h0Mq
	EECJ9GRn2FQ/yYiqT0DfCFSQVTCnipYLhqoQYUa5vD7gRH3ArsxCxbGPJHqCaLPwErIWcafXpJFdZ
	YkOOvOCg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w9qEP-0000000EvU7-3RwC;
	Mon, 06 Apr 2026 20:07:33 +0000
Date: Mon, 6 Apr 2026 21:07:33 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Helge Deller <deller@kernel.org>
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC] [PATCH] Fix warning at fs/dcache.c:430 dentry_free
Message-ID: <20260406200733.GZ3836593@ZenIV>
References: <adQO8B0rkR2ftusI@p100>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adQO8B0rkR2ftusI@p100>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Apr 06, 2026 at 09:52:16PM +0200, Helge Deller wrote:
> The debian buildd servers for the parisc architecture crash reproduceably when
> building the webkit2gtk debian package, shortly after having shown the warning
> below.
> 
> This patch keeps the lock of the dentry up until when the dentry is given back
> to the cache and after having freed the "external dentry name".
> 
> I'm not sure if this patch is really correct, but it seems to have fixed the
> problem, although more testing is needed.

Hard NAK.  You are turning every place that grabs ->d_lock on a dentry scheduled
for freeing (like, say it, any RCU pathwalk trying to check if the end result can
be grabbed) into a UAF.

Do you have a better localized reproducer?
