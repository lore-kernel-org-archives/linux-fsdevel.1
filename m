Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6E240961D
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2026 16:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781540422; cv=none; b=E5GZxFqY34wu13uTUhl+peeyr/7lRjgvgJO7FS22EMGRnvPqls4SZYAWUVD6EZd1gIuPDYiT4nDmkaNnC8rndgECmp44gfSBJZI8j8VZrbT7di0g49g7DrAxWyfrfLLnmUdpJlRvC7Mijid6iV8Vh2N/C4UKAOWrIhXw+DxrQIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781540422; c=relaxed/simple;
	bh=Nu5dTBzqHSeadNsvnuXLGo5AWzCg6cwK5aErjglA5qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=su1yFoD0Mtrt/QkywWc1z5jgzWmYIrC+WJ8uzTZFev3ssb+Kud3d4LDdSgH4Nm6nzDIzzWyVxQ47JcKCy1kSnQFrWp7glMF0/xCDjfCcq+KopyJexnRwRbvD3edmoBa9OqJOm9kwu61NxFLKjY/pW6JyQ9beAPM7402rAMWcxmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=groves.net; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=groves.net
Received: from omf02.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id D67C014018E;
	Mon, 15 Jun 2026 16:20:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: john@groves.net) by omf02.hostedemail.com (Postfix) with ESMTPA id 1B9C18000E;
	Mon, 15 Jun 2026 16:20:18 +0000 (UTC)
Date: Mon, 15 Jun 2026 11:20:16 -0500
From: John Groves <john@groves.net>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Miklos Szeredi <mszeredi@redhat.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] famfs: FUSE_GET_DAXDEV -> FUSE_DEV_IOC_BACKING_OPEN
Message-ID: <ajAlcVPGa7ytSWOm@groves.net>
References: <20260529134302.1989958-1-mszeredi@redhat.com>
 <ah5-40YypaswEG-1@groves.net>
 <CAJfpegsJj8cZ=CXL-VGeVDOayAeTzstWJgvQye3N+sudHJ5L9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsJj8cZ=CXL-VGeVDOayAeTzstWJgvQye3N+sudHJ5L9g@mail.gmail.com>
X-Stat-Signature: m49g9y4xsna4r7p7yf9w51uk9c55qmin
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 1B9C18000E
X-Session-Marker: 6A6F686E4067726F7665732E6E6574
X-Session-ID: U2FsdGVkX19OqkSi2zwepdnJFandQALiWEILJiGPrWA=
X-HE-Tag: 1781540418-711546
X-HE-Meta: U2FsdGVkX197LG18CU/qTy6uWanShfJBGC5YNjJqjWwNkaJ/QfgGdygja2lha1vURtCdjNptG4x7uun2fLMXOAIszH4HgR9uasLJGCvI/qHDin5qITge7B8B7M+4QVPYKd6moMmYMOQ5Q9Q/3bKkJ6jD1CJBD0lhKaHzERTRbMfhcgZ6XGPI7plAUMa/waOzWfHZE7MQf8kCycZ+eiOUzS7KT8dOuZAnUPwu4Hf+GP2LwxJpJAuakehtoZirFesdyOOA01yIvntBY9fFmkvQqWKceu8piIJWxVXRLDCRG+7Er0/3AQ5l/5/DSXd1fSu8DQj95RiBLevJotZOy6P93OCnkYcV/jw18vt30CRM1JQPHpY5NiI2oFzBk0Kkl3yt

On 26/06/03 10:35AM, Miklos Szeredi wrote:
> On Tue, 2 Jun 2026 at 09:04, John Groves <john@groves.net> wrote:
> 
> > Device indices - the part that has to be right
> > ----------------------------------------------
> >
> > Everything below turns on what a famfs device index *is*, so let me make
> > it explicit, because the patch's model of it (kernel-allocated) isn't
> > workable for famfs.
> 
> The backing ID is a temporary reference for the lifetime of the fuse
> filesystem.  If there's a persistent device index the server just
> needs to map the persistent index to the temporary backing ID.
> 
> AFAICS the only case where this matters is debug messages, otherwise
> the kernel couldn't care less about whether the device index is
> persistent or not.
> 
> Am I missing something?
> 
> > Identity by reference, not by path - this part is right
> > -------------------------------------------------------
> >
> > The genuinely better idea here is getting the kernel out of resolving a
> > device pathname: the daemon hands over an already-resolved reference
> > (you do it with an fd, from which the kernel takes inode->i_rdev)
> > instead of a string the kernel has to kern_path(). I want to adopt that
> > - credit where it's due.
> 
> Name, dev_t  or fd are are all just ways to reference the same thing:
> the underlying DAX device.  They are completely interchangable, so if
> we have an interface that accepts one, there's no point in making it
> accept the others.
> 
> dev_t -> name:
>    readlink -f /dev/char/$dev
> 
> name -> dev_t:
>    stat -c %Hr:%Lr $name
> 
> name -> fd
>   fd = open(name, O_PATH);
> 
> fd -> dev_t
>   fstat(fd, &st);
> 
> Thanks,
> Miklos

Miklos,

Apologies for the slow response - I've been traveling and juggling the
other parts of my job. (If anyone here has only one job, don't tell me;
I'll just be jealous.)

I'm on vacation this week, but I plan to join the Thursday call -- from a
beach, signal permitting.

And starting next week I plan to take a real run at an implementation on
top of FUSE_DEV_IOC_BACKING_OPEN. So... beware ;)

Thanks,   
John

