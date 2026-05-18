Received: from smtp05-ext.udag.de (smtp05-ext.udag.de [62.146.106.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1963D2ED84A;
	Mon, 18 May 2026 07:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779087723; cv=none; b=GJOI6TbcBH3sqxCgoAdLF+XKWP8KVCGrrCQUZ/WSyUMTz3y7pJkiFF99igEe4wIyqQZm1x9yDCY8fDCHNQEKCFXFQav2eGTsf9GCO9A+OxRsYB+NWiOxsGaz15lbcCvoPM7qnMY6aiuO02Ughtv77Sj2Txw2cHiYOlTiiOLMSXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779087723; c=relaxed/simple;
	bh=RvOMmhfPP7Qb2P8FlsKpgoTLMwWUYwf9ehjYpkJdVoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hv0jlPxi79XC9k0bpU7hsgwEuc/TVRBBRa2Srhh7QZoJMMoHVyGq2d3+miYeqKNDSv/Eeq2IBOk+rmYNWKCCQgthokUxYfzcSuN/qbqkMsKgcFUTo0iqlbtc72KHAy0+Khcb3VPYG2yyGBH5DuHpGjwINv99EBmD5d1+P1L+Bss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (075-132-067-156.ip-addr.inexio.net [156.67.132.75])
	by smtp05-ext.udag.de (Postfix) with ESMTPA id 45979E04B4;
	Mon, 18 May 2026 09:01:57 +0200 (CEST)
Authentication-Results: smtp05-ext.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Mon, 18 May 2026 09:01:56 +0200
From: Horst Birthelmer <horst@birthelmer.de>
To: NeilBrown <neil@brown.name>
Cc: Horst Birthelmer <horst@birthelmer.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: Re: [PATCH] dcache: add fs.dentry-limit sysctl with
 negative-first reaper
Message-ID: <agq1xnx2lMvA22BL@fedora.fritz.box>
References: <20260514-limit-dentries-cache-v1-1-431b9eb0c530@ddn.com>
 <177906210551.3947082.4313294634549021141@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177906210551.3947082.4313294634549021141@noble.neil.brown.name>

On Mon, May 18, 2026 at 09:55:05AM +1000, NeilBrown wrote:
> On Fri, 15 May 2026, Horst Birthelmer wrote:
> > From: Horst Birthelmer <hbirthelmer@ddn.com>
> > 
> > The dcache only shrinks under memory pressure, which is rarely reached
> > on machines with ample RAM, so cached negative dentries can accumulate
> > without bound.  Give administrators a soft cap they can set,
> > and a background worker that prefers negative dentries when reclaiming.
> > 
> > Two new sysctls under /proc/sys/fs/:
> > 
> >   dentry-limit             -- soft cap on nr_dentry.  0 (default)
> >                               disables the feature; behaviour is then
> >                               identical to before.
> 
> Is a system-wide cap really a suitable tool?  What guidance would you
> give to sysadmins who are considering setting a number?

I know it is a rhetorical question ... nevertheless
It's a soft cap, so it depends on the number of open files usually floating 
around on the machine. It even depends on the file systems. That was actually
my motivation (more than the negative entries). Some cache entries are 
expensive for our fuse server due to our DLM usage and private data 
held in user space.

> Is there a better approach?

After reading your thoughts and those of the others who have taken the time
to revisit this, I think there is no better solution in the VFS layer.

Since 2025 (commit 395b95530343e) shrink_dentry_list() is an exported symbol 
and that can be used for a specific file system to do its own housekeeping. 
This will probably be considered a misuse by some , but it would be more 
specific and better controllable especially from filesystems where certain
cache entries are more expensive than others and/or running in user space (FUSE).

> 
> According to the email you linked, a problem arises when a directory has
> a great many negative children.  Code which walks the list of children
> (such as fsnotify) while holding a lock can suffer unpredictable delays
> and result in long lock-hold times.  So maybe a limit on negative
> dentries for any parent is what we really want.  That would be clumsy to
> implement I imagine.
> 
> But what if we move dentries to the end of the list when they become
> negative, and to the start of the list when they become positive?  Then
> code which walks the child list could simply abort on the first
> negative.
> 
> I doubt that would be quite as easy as it sounds, but it would at least
> be more focused on the observed symptom rather than some whole-system
> number which only vaguely correlates with the observed symptom.
> 
> Maybe a completely different approach: change children-walking code to
> drop and retake the lock (with appropriate validation) periodically.
> What too would address the specific symptom.
> 
> Thanks for attempting to resolve this issue, but I'm not convinced that
> you have found a good solution yet.

Thanks for the clear words. I realy appreciate it!

> 
> NeilBrown
> 
