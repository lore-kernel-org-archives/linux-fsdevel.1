Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7584519A4
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 22:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790807672; cv=none; b=OtUhOwal8VVIoPWh6UjnnvTjjXxe+laiGB6uduGm/3XWVdKuoxy5mwdOveqGvG5D8zGKeynhhrnzq8VotC08PnFFNlqZNeZbeBKCCg8Y+nLBZU1KEZ0GF65FYMedGl6fZ+V+p1/KDkOv0y3JIedGiB+tIwr5Uf1ZMK6FBpprlLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790807672; c=relaxed/simple;
	bh=2JGLJJSgKSISnblt+VHqklAJMZE9HuyGtCVMUFaTON0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=AKVuSNX6WxsbRjG1AQ5dURo7HtEyuaTbN2ey8hKH9E0Mqt37ZYMZIiK8c7gbniuoPhhdEjhuPLb3pJZfPmBSE1DgaFyp3092X2LBeBDYPIR+upQjl2g0r7A4HghGARjyq9tgH3eVAIUtDoQ9RNCBxDQzD7EtNIAFnopKWGXzeKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=FNZh8ClQ; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="FNZh8ClQ"
X-KPN-MessageId: eeb4c18f-bd1e-11f1-bfbc-00505699b430
Received: from mta.kpnmail.nl (unknown [10.31.161.189])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id eeb4c18f-bd1e-11f1-bfbc-00505699b430;
	Thu, 01 Oct 2026 00:33:17 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id eeb3aa59-bd1e-11f1-a0a1-0050569981f5;
	Thu, 01 Oct 2026 00:33:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=FpACFrWzswCDMWDakD+E9dviGFux98HDkp1LoJR5/vI=;
	b=FNZh8ClQmVpViz22cSV+LBRp33lnkwGJszZWTW4aTvySDzQQ8a82nMjdTINdVdazewBd8qG58M7JL
	 VzlAdhiLRjzzLNzTs4c1ERJEJt4FlOR+fyUjzfgMcOY89FIZrwH2SwbO6dAN8TYWPGhlf2JoQcCcCo
	 quFZ1WyEz1QN4SOjk5K5AUbeovSX4cRdr95X25X4G5GRV5Oqg91dBRveJmj3cnQ/zEP2bFuT/wKufZ
	 ytqsx7xxzZZ+n4I9OAKVMTj224eTzqCYm9M+Fq/gh6K9u6r+1genYPdbxeqYI542TnHaVrgkjkYSn3
	 0tPyfN/0KFEQVB7+citNb91hlK3D6qQ==
X-KPN-MID: 33|gMznQ5Bkw0rlmJ81f4jDokLGcOpVpvzuk7Ppmjb9vja7gFDNXFnFdu6B3cxIsDI
 kn+CcFV/t/wphdxytTSwBTe0sYipWk92bynzYKoI5E9k=
X-CMASSUN: 33|E+zCT0t2xz8e8bi7dabAtuxaGhgcpuF+AHSwTZHVmMMLAMN1d3Z7fFkBQzyejqM
 8A7iCfvN3176rBWk1lkOICw==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh08 (cpxoxapps-mh08.personalcloud.so.kpn.org [10.128.135.214])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id eea99974-bd1e-11f1-916a-005056995d6c;
	Thu, 01 Oct 2026 00:33:17 +0200 (CEST)
Date: Thu, 1 Oct 2026 00:33:17 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: NeilBrown <neil@brown.name>, NeilBrown <neilb@ownmail.net>
Cc: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <aleksa@amutable.com>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <1315372552.791055.1790807597593@kpc.webmail.kpnmail.nl>
In-Reply-To: <179072013439.37859.465558431050704411@noble.neil.brown.name>
References: <20260913185016.523376-1-jkoolstra@xs4all.nl>
 <20260913185016.523376-8-jkoolstra@xs4all.nl>
 <20260918-reklamieren-syndikat-gemildert-763b72008b46@brauner>
 <178972607557.207413.4312278359822083538@noble.neil.brown.name>
 <178977609418.207413.15011378414000392029@noble.neil.brown.name>
 <1010887891.582666.1790682845752@kpc.webmail.kpnmail.nl>
 <179072013439.37859.465558431050704411@noble.neil.brown.name>
Subject: Re: [PATCH v6 07/12] vfs: add O_CREAT|O_DIRECTORY to open*(2)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal


> Op 29-09-2026 18:15 EDT schreef NeilBrown <neilb@ownmail.net>:
> 
>  
> On Tue, 29 Sep 2026, Jori Koolstra wrote:
> > > Op 19-09-2026 02:01 CEST schreef NeilBrown <neilb@ownmail.net>:
> > > 
> > > > 
> > > > nfsd_create_locked() used to do that before vfs_mkdir() could return a
> > > > dentry, but it doesn't any more.  The reason was because
> > > > d_splice_alias() on might return a different dentry. 
> > > > In this case we want the same dentry, but we need to do a lookup on it.
> > > > 
> > > > I'd rather fix this in kernfs, but maybe that is a longer-term goal.
> > > > 
> > > > The comment in kernfs_dop_revalidate() suggests the we should d_drop()
> > > > the negative dentry and d_alloc_parallel() a new one and ->lookup that.
> > > > I'm not certain that is needed if we keep the parent locked, but we
> > > > would need to be certain.
> > > > We at least need to d_drop() the dentry before ->lookup as ->lookup
> > > > cannot handle hashed dentries and a hashed-negative dentry is passed
> > > > to ->mkdir.
> > > > 
> > > > I wonder if we could just disable O_CREATE|O_DIRECTORY on kernfs ....
> > > > probably not.
> > > > 
> > > > Summary: I think that if vfs_mkdir() returns NULL (success) but the
> > > > dentry is negative, we need to d_drop() and call ->lookup with a big
> > > > comment about kernfs.  But we need to double-check that this will do the
> > > > right thing with ->d_time (I think it will).
> > > > We also need to think carefully about races with
> > > > kernfs_dop_revalidate(), which could happen concurrently with the
> > > > ->lookup.
> > > 
> > > I've thought a bit more about this ...  I think that doing a lookup after
> > > the vfs_mkdir() results in a negative is a bit ugly.  It assumes things
> > > about the fs that I would rather not assume.
> > > 
> > > I would rather have the current proposed code check for a negative
> > > dentry, and fail with -EIO or similar.
> > > 
> > 
> > I just noticed that there's precedent for this in overlayfs in super.c:
> > 
> > 		/* Weird filesystem returning with hashed negative (kernfs)? */
> > 		err = -EINVAL;
> > 		if (d_really_is_negative(work))
> > 			goto out_dput;
> > 
> > Shall we just do this for current kernel release, then we can add support
> > later if wanted.
> > 
> > (But let's do EOPNOTSUPP instead of EINVAL)
> > 
> > What do you think?
> 
> The problem with this approach is that open(.., O_CREAT|O_DIRECTORY)
> might create the directory, then return -EOPNOTSUPP.  This is weird and
> I'd rather it not be visible.
> 

Err, *derp*, what a stupid suggestion of mine.

> Currently O_DIRECTORY|O_CREAT results in -EINVAL.  I would rather it
> remain a -EINVAL on any filesystem which doesn't completely support
> the functionality.
> 

I don't think that works for the reason I just wrote in my email to Amir:
it would make lookup dependent on the dentry cache. If it's in-cache, you get
your dir, otherwise suddenly -EINVAL.

> To do that we need some way to detect kernfs and tracefs.  I think
> the only way we can do that is to make some change to those two
> filesystems.
> Maybe a new  SB_I_ flag in sb->s_iflags would be ok in the short term.
> 

We can just implement atomic_open() for kernfs/tracefs, do a lookup there,
and if negative with O_CREAT return maybe -ENOENT (or really we need a new
error that says "the requested create could not be serviced," like -ENOCREATE,
or whatever). And if it is positive we do finish_no_open().

It's a bit of a hack because it does not really have anything to do with
atomicity, but it does short-circuit the mkdir call in lookup_open(). I guess
that would work. Maybe I am confused, but wasn't that what you proposed here
earlier?

Best,
Jori.
