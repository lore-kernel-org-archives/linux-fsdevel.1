Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887743;
	b=l75jlfYO8N8FKd6PapIJlXG7FjcooQnWQ5XQfCsHXJsr5DNU+vTrUQu4UV7PymoBK27W
	 tLg0j9KtP4ztKb7NDa21mNYbdIY1Dnc1D3dOCg/K47/rHcqAhcRidxrX/DIeD0BzsnTQk
	 vXHN8VjEQYIiwWJiZNr5vswDRRXQL4RCp/ulozJ8ppwdQgt0UjNY+z2csddRiHfJnVM3Y
	 idysVsW0YvcCIqLlhLcF2DzOwZfUCiIKUIQPeKxFzKpb6Ew+lxqwMZwRDb09sYAeo2XQ1
	 2Ckg4u7p89K7ztUFhWd19noYxAqfANOowk92pA1n/B+iC6H3F/k8mB03ffQlNKl+0gA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887743;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=7ORlx52IHBwtuPXPvsF9LO7shERioECqrO4nOejQrGo=;
	b=h70ea3CVrP1iYFjnNLTwk8FwicStKD+pUpnzvmpjgMm2eGLcchy+2YWS+f+j3DDKqiGc
	 CkEJ91l/I4mh6i1GQeifDIhwq2eysgbC4bymCsrxXWqM7Im4GdiUNCYZKu19ESxRCnXfl
	 k5uZ0f2D8A7Y8KRT1ooO+vR73Q3VkYftbdJfTTxQZnj41cWwTKjkr4uJWHba+58SAcJaP
	 knaqsJUn8dihR3NtR1cbemzb+0LmlhpFOrJghaJ5a/i8IUlFhRlme9aVo9HraF3CmZZxf
	 YKrbLRm//sNK/1E9axSZfUp4T0dwKCmaJgdcSeNmUxnXusH2t4NxNcbDPZZkN0vpUfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S0WI5r5o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D76606A31B;
	Thu,  5 Nov 2026 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S0WI5r5o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DBBB1F000C1;
	Thu,  5 Nov 2026 14:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793887743;
	bh=7ORlx52IHBwtuPXPvsF9LO7shERioECqrO4nOejQrGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S0WI5r5oAv91NFdiWuD6NPZIvEBFnDLbU4BcQHd3j7wQ74bQOpWH4PXHB7LIEwjOF
	 1qqsLm2vT3BIg6xDzhsrVKvc8qt7JkcVKfAnI4btdDjc9WwzSeIPyy/8y3gUx0v0aG
	 pTHXUI5+DlvyePFKgtgv4TaHWkO+amcT1IIoKS1H4TQH0wkAwMeqigs04gBqO+wLyL
	 hW9yJbUNPOnb60E/1axAV/zjgwH9pQoDdLzK9KJRlwGSUjR5NAGK82S3lH7VlYXY3P
	 rt6PL0g04TC2mWggvMjbwcNDTqaKpbMS9CKu9NjlWQR8l6xuRXyOJ45AjhjrWmlhh0
	 W2KbD8wK0BO4Q==
Date: Thu, 5 Nov 2026 15:08:59 +0100
From: Christian Brauner <brauner@kernel.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christoph Hellwig <hch@lst.de>, Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org
Subject: Re: [PATCH RFC 02/16] proc: add pde_pin() and pde_unpin()
Message-ID: <20261105-parkuhren-zartheit-losgefahren-308a80e8f0c0@brauner>
References: <20261102-work-procfs-core-v1-2-75df35e4f8b8@kernel.org>
 <f3511970-2224-4b53-9ae7-478320b1c8ef@p183>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f3511970-2224-4b53-9ae7-478320b1c8ef@p183>

On Wed, Nov 04, 2026 at 10:03:38PM +0300, Alexey Dobriyan wrote:
> Permanent flags is set after publishing PDE to the world,
> so there is a window where +1 is done but -1 is not done.

The patch doesn't add this. You did in ef1d61781bc6 ("proc: mark more
files as permanent") and a61c01e8f4a5 ("proc: mark /proc/cmdline as
permanent").

Both call pde_make_permanent() after proc_create_single() has published
the entry.

And then 912289ee831d ("proc: allow to mark /proc files permanent
outside of fs/proc/") handed that pattern to the rest of the tree this
year.

And the specific split is yours as well from d919b33dafb3 ("proc: faster
open/read/close with "permanent" files") which put the shortcut into
proc_reg_open() and proc_reg_release().

An open in your window lists a pde_opener. The release after it takes
your shortcut and that pde_opener is never unlisted or freed.

So pde_pin() inherits this bug.

But to be very clear: The bug is unreachable.

Every one of those is an initcall. There's zero userspace to open
anything at that point.

Fixing it is also easy? We just set the at registration for everything
that is permanent the same way ->proc_flags already does it and then
pde_make_permanent() can be killed.

> And then 2147483647 security researchers arrive and overflow it.

How? The window is one initcall per boot before there is any userspace.
And in_use starts from zero at every boot. Nothing accumulates.

The only thing that ever biases and waits for in_use is
proc_entry_rundown(), which never runs for an entry that is never
removed. A pin leaked on a permanent entry is a number nobody ever
reads.

> There is no detection of buggy usage: proc_make_permanent on dynamic
> PDEs from buggy modules. It's easy to grep but I'm not signing up for
> that.

Modules can't do that? You defined PROC_ENTRY_PERMANENT as 0 under
MODULE in d919b33dafb3 and you didn't export impl_proc_make_permanent()
in 912289ee831d.

And for built-in code the detection exists? It's your WARN in
remove_proc_entry() from the same 2020 commit. Nothing in this series
changes any of that.

I'm confused by this review.
