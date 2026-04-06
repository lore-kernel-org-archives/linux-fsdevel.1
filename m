Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1095630216D;
	Mon,  6 Apr 2026 20:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775507662; cv=none; b=aOdiHaR5YyGEZjX45QSRuGLLj4fVUYc+kDeoY/YuN1LdkPXXP9EuhvOuRyuMdy3bFFsdzbCHnXwWCD/ir+EstBgsxzYVoE6KyPIgJbFgzU3bhfG45B8Ov5l2O6lM1a5WUYm8gGQIvxBjTDKU/VkfYvoLkeys0yK6+qeu2KgGT1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775507662; c=relaxed/simple;
	bh=SPsEVOHHRSYChWOZyQw8G62GFHmZVaQbD5nRbE2t1U8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKlcuAIyveBu5tXmDeKTk4tu0XIdEE0Nepogu8f6m/UqZN/K78WeJ6NiyzQXJfa9X/oznlJk+PmgIBqOleVnBwIrqF10uvqaSI83PBUeOeQsslz6zOtltLDd64i8YePCm4x6oTZAHGdILZw+GEL78yVdtvYO8nWOrW/pxwbJFnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Q0XrDHKb; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Q0XrDHKb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Waqt676htqfU4TOFEVcF1WKgAc/4CEfh0B01PQf8pMc=; b=Q0XrDHKbGZ/L6WEB8wUuMZPZDt
	prxujLoewo4ahP8TbUdjpQ2s0POW1onhz8v06rZd+PTLYTtu1sDPENZxN+gMTS5/qiY8BRBlBLUvX
	pUKPAsSDwATnar4BZN0MHbxqea9iN+0vYSMbUSNquR2zuVgvO8uT8rxyc3F2uQQU225bogJZ6dypu
	mLdKJzOuPCkTkFGMWIDaTIEhtHy1R3lbUcmsdSp55ThbTgZ6O/6Lj0XjbxhtaGdqMH3veAQTc0Zzb
	SuuAcXA78Ng6QOVW9FbmJUQ1D3QUanhba+4fBfR55UW6OjaGnV7VpVF1a1l8+l0Z7KdHd7aOwxdSp
	PE7o5+PA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w9qht-0000000Ewlh-1WWq;
	Mon, 06 Apr 2026 20:38:01 +0000
Date: Mon, 6 Apr 2026 21:38:01 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Helge Deller <deller@gmx.de>
Cc: Helge Deller <deller@kernel.org>, linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC] [PATCH] Fix warning at fs/dcache.c:430 dentry_free
Message-ID: <20260406203801.GB3836593@ZenIV>
References: <adQO8B0rkR2ftusI@p100>
 <20260406200733.GZ3836593@ZenIV>
 <cfd3b7e4-b791-41b3-9f9b-76082025a906@gmx.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfd3b7e4-b791-41b3-9f9b-76082025a906@gmx.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Apr 06, 2026 at 10:21:17PM +0200, Helge Deller wrote:
> Hi Al,
> 
> On 4/6/26 22:07, Al Viro wrote:
> > On Mon, Apr 06, 2026 at 09:52:16PM +0200, Helge Deller wrote:
> > > The debian buildd servers for the parisc architecture crash reproduceably when
> > > building the webkit2gtk debian package, shortly after having shown the warning
> > > below.
> > > 
> > > This patch keeps the lock of the dentry up until when the dentry is given back
> > > to the cache and after having freed the "external dentry name".
> > > 
> > > I'm not sure if this patch is really correct, but it seems to have fixed the
> > > problem, although more testing is needed.
> > 
> > Hard NAK.  You are turning every place that grabs ->d_lock on a dentry scheduled
> > for freeing (like, say it, any RCU pathwalk trying to check if the end result can
> > be grabbed) into a UAF.
> 
> Thanks for looking into the patch!
> I assume UAF means User-after-free?
> As I'm not an expert here, could you please point me to where
> this use-after-free happens?
> The kfree() is used on the external dentry name, and the lock is
> unlocked before calling kmem_cache_free(), so I'd not expect that I
> introduced an UAF here. But of course I could be wrong....

s/UAF/deadlock/, actually.

A:	rcu_read_lock();
A:	find a dentry (lockless)
B:	grab dentry->d_lock
B:	dentry_free(dentry);
B:		call_rcu(..., __d_free) (or __d_free_external - whatever)
A:	grab dentry->d_lock, so we could verify that it's still live

A spins until __d_free() unlocks the sucker, which is not going to be called
until A does rcu_read_unlock().
