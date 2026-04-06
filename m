Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C50136358;
	Mon,  6 Apr 2026 20:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775507090; cv=none; b=Q8y4cm2NGaX0PXejJfUJtjIaMbDFOIMvffJDRG3hSo9AJ7gbY6rzfrrE33zmcGwQqFmgbDCDmTFpbyIsPAazo8mQeONcs+OszBGbQYNpn5B40CrAZPhPEnITX5FGx2swCcGPzM2CfNrChLem+aNL476vzT49eJDYTLX0gPKDpjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775507090; c=relaxed/simple;
	bh=2RWzCH3Xq2C+K+V3tbXl57jZzuT+07gszRKFrkOGVUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vF+jEyBlazzCSyIAmHLxIEkOuVm2QzAqtyl6cTPRveWWd+WgNCWPRWFJkNvidF5dadkklzzWmgeoAbSqv9oSQQ2xab04seM/DNm0RnsJru4F/dgev8TTaJTB2qdVadqWrS1/2XLdt5lX+6uXMeJ40VDXk7P//yRppSV4VdXsYtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=kS4hQzTP; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="kS4hQzTP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=q91Fskz6SwtdACMwl6HoWqBF5ifmhLSdCLZ/CSFr6KI=; b=kS4hQzTPjHcGkOM9pOjn5H8g1K
	CNHm/BEV1ajNiLMBwX3kpzb5iqtBm2cIah75n+FFUeCz3NWix1bIDPYTbzO8EKbhj2p7xhL7j9gsL
	iwNVHpHtr3C2MbhT6/n8CuRDgn1l7kaRGeiNzYg6Hhx5/pBOBpEumYh4E6ifbWys8+SDs0C7ioJld
	F4C9jwHG2xzR5Y+zTdG37jnci9Puehs3Q9uSXrVsNMONFCbw+OB7K+Zig33PmsUC/vR3Ys/jbPkMg
	fAqMwC263aG1c39tfd8a8800AGVDCd4ZZZbe3R9L8oKysGDn1y+TgHKET7Kzn51Dzwau45Mdd40bo
	GqhaaJ0g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w9qYg-0000000EwDr-08AV;
	Mon, 06 Apr 2026 20:28:30 +0000
Date: Mon, 6 Apr 2026 21:28:29 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Helge Deller <deller@kernel.org>
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC] [PATCH] Fix warning at fs/dcache.c:430 dentry_free
Message-ID: <20260406202829.GA3836593@ZenIV>
References: <adQO8B0rkR2ftusI@p100>
 <20260406200733.GZ3836593@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406200733.GZ3836593@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Apr 06, 2026 at 09:07:33PM +0100, Al Viro wrote:
> On Mon, Apr 06, 2026 at 09:52:16PM +0200, Helge Deller wrote:
> > The debian buildd servers for the parisc architecture crash reproduceably when
> > building the webkit2gtk debian package, shortly after having shown the warning
> > below.
> > 
> > This patch keeps the lock of the dentry up until when the dentry is given back
> > to the cache and after having freed the "external dentry name".
> > 
> > I'm not sure if this patch is really correct, but it seems to have fixed the
> > problem, although more testing is needed.
> 
> Hard NAK.  You are turning every place that grabs ->d_lock on a dentry scheduled
> for freeing (like, say it, any RCU pathwalk trying to check if the end result can
> be grabbed) into a UAF.
> 
> Do you have a better localized reproducer?

BTW, could you reproduce it on viro/vfs.git #work.dcache-busy-wait?  It's possible
that changes in there might accidentally fix that, and if they did it would narrow
the things down a lot.

Some invariants that ought to hold:
	1) dentry_free() should never be called without DCACHE_DENTRY_KILLED
	2) DCACHE_DENTRY_KILLED should never be set on positive dentries
	3) DCACHE_DENTRY_KILLED | DCACHE_PAR_LOOKUP is only possible for
dentries that had never been inserted into ->d_in_lookup_hash
	4) dentry with DCACHE_DENTRY_KILLED should never become positive

Could you turn that
	WARN_ON(!hlist_unhashed(&dentry->d_alias));
in whatever you'd been testing into
	if (WARN_ON(!hlist_unhashed(&dentry->d_alias)))
		printk(KERN_ERR "->d_inode = %p, ->d_flags = %x",
			dentry->d_inode, dentry->d_flags);
and see what it shows?  That's a separate from #work.dcache-busy-wait test -
please, do that one on the tree where you'd seen the original bug.
