Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97872D7BF;
	Mon,  6 Apr 2026 21:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775509591; cv=none; b=RD3RBg/MrYDgVHx6OSOPEjx26i2elapJ9NMN+EU3SgP8bpKCzo//dyxJUIM9DdlpXa7a+VPRiheazRCnetlY6SSB8qDgIlZSmIJxd+AW7OoHvkoFaAiaqb7zoV8R2MCXuVl15AQLXsFqmQoHhoEhcye3099HLck+0jONvUix0zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775509591; c=relaxed/simple;
	bh=DBPQkykKpyykik2wF66jpe+ADxHYBWftToCvGrT2iks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXamwKAZE/9v1zVC0Wp3N/nqnF/KtfJzZVmcj5A2Tg+Kd7irOYONlrqNWBKDQoE8Jk4jpCXtxyUjhYDTHh3o0nEQRs6ndwoEIFPZombE1Cg65aeGkzJgZjcQbI3Wgq8ywrMZ0qO+fNHweFRglNgSB61eA6I+8GeEohVBxiTUIeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=mdiou6Ir; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mdiou6Ir"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1Gh5qcKn1qFsJPdPfZbAQh2/exE2jTdSdEoiGwgogcY=; b=mdiou6Irko9BLgr1KcxD6o3rmy
	66EGiEboO6I/FNX1ib8xMz5Q3CEEjlbmKKZwO0Asr8+SCqCjYCr5uNJ4RCu4ikq5mS9824XI0G90D
	4zHPRgP+oUk0lbRlte72kxyqQDaJT9VLSUassVfX/KTYenGO4NUq9yRU5a3Pbj4Zk8tUbr8Mup3IA
	/xGiIMMc5IHp+dEm3e9WL/ZRqxMMLKNRPZcoe8dWbOvobkuLjzLI+pzm+DVOSjk/HuwTxJkGvrT0W
	l+6kWcwFqx9VmuCxF7EE6mSYqgYAEaA5hry3UgzbFsU3zVLBKlAgFdj7kSEHXQIEUM78Z+duLFLL5
	qfm0kyCg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w9rD0-0000000Eyju-3egv;
	Mon, 06 Apr 2026 21:10:10 +0000
Date: Mon, 6 Apr 2026 22:10:10 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Helge Deller <deller@gmx.de>
Cc: Helge Deller <deller@kernel.org>, linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC] [PATCH] Fix warning at fs/dcache.c:430 dentry_free
Message-ID: <20260406211010.GC3836593@ZenIV>
References: <adQO8B0rkR2ftusI@p100>
 <20260406200733.GZ3836593@ZenIV>
 <20260406202829.GA3836593@ZenIV>
 <0e4a8cef-2a64-4392-a5ba-f9f57de48f8c@gmx.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e4a8cef-2a64-4392-a5ba-f9f57de48f8c@gmx.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Apr 06, 2026 at 10:43:57PM +0200, Helge Deller wrote:

> > BTW, could you reproduce it on viro/vfs.git #work.dcache-busy-wait?  It's possible
> > that changes in there might accidentally fix that, and if they did it would narrow
> > the things down a lot.
> 
> Ok, will try.
> Please note that building kernel/ installing / running dpkg build takes hours & days,
> so it may take quite some time until I come back here....

Which kernel(s) had that been reproduced on, BTW?

Incidentally, can that be reproduced on any of qemu-based setups?  And do you need
to build the kernel natively?  Debian kernels can be cross-built, after all...
