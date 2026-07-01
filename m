Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA023C9881
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 11:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782903862; cv=none; b=kIhCxuLeR9/AjhnR++/OdKAW+0ck/2qRlI9xs4EPL4rrHGZYAM/I2bBamc/mogxqgNJk8qa/ubc4Y2cW1zXXUaF5oqEKx65gXqtRbyJ05sOP0g8NeUQWHWAA0ZClyyFvOqIuqe+Jedo5/tTJAK1XVUXaJU6A9GhrPAUUgD8ii7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782903862; c=relaxed/simple;
	bh=MSrxmrzOCAc004e4bgNai+ZOe5wtK1/kJcZMJgq+c3c=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=rl+tvsIBjlF3sq9K8NB+TVADmJcWbKw1n79C+HauZvUOWpwLrDeoZ2U2SKPSYSyIsZT7I4wZeYy0CrstbxEA3saT2DZQBvF5UOGvOCcd0k0bKrNS/CcOgti7BqB6Wh6YzXtkDG5d8EK035SdUl925qjsJcxxgsVXFgHZQ+qWhAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=TwRVzxSz; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="TwRVzxSz"
X-KPN-MessageId: 97ab58c0-753c-11f1-bfba-00505699b430
Received: from mta.kpnmail.nl (unknown [10.31.161.189])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 97ab58c0-753c-11f1-bfba-00505699b430;
	Wed, 01 Jul 2026 13:04:12 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 97aa5570-753c-11f1-ae65-0050569981f5;
	Wed, 01 Jul 2026 13:04:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=gxUAjZ4jCu9GIeJocNb94loPTpAzzw+6Rx3tyQi/xVU=;
	b=TwRVzxSzRooToqCJhNJNxyW6aWV4YC0Dl+TI/fkVIeJKuZnhoWOq2MiW97sjcgs1DD+mr4jyAjeNc
	 vv08owxmAJ13QiYgwLTEnKny+FPqjOcMDZnwHZa9vRTeb3nn47GHytifk4tjTa3gBp2OFrSERXgGbw
	 TA2ipAJDBXI68pUNdJigc/68KjlhlcROHbEoLFH2GhOqmJdE1QywBgVbVpDdZ4OvJbazYiT7nmR4W3
	 YUpzWZ7xuTt/wOae3JasYc45fmLhFGiTL0qxEXJ0QkMU4cjWRlS3Qx7bW4sIWxhFLJXeLbCR2GFBBU
	 lCpwvWM2g2uxp2g6COKbRVfwfhrAieQ==
X-KPN-MID: 33|nH4netaQ8bTFXirivr5mTglSC4FC6KxXeYZMjxVpuIeQ9uXGlO6WcEJbVoH5thr
 iC1u6VhEkXhtFXRSLQFkOOak7QC7rNxArvZHzquP3RYg=
X-CMASSUN: 33|zWQdlOv2/X+kx0Ic0N4oEmJ4jxK262OX3E4c3yGyZLf3+gHNGqTfqqoNjaqYaCZ
 /vfj6CqmEwlnL9BlDQZy1zg==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh07 (cpxoxapps-mh07.personalcloud.so.kpn.org [10.128.135.213])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 979021d1-753c-11f1-916a-005056995d6c;
	Wed, 01 Jul 2026 13:04:12 +0200 (CEST)
Date: Wed, 1 Jul 2026 13:04:12 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: NeilBrown <neil@brown.name>, NeilBrown <neilb@ownmail.net>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <1647258662.3623074.1782903852645@kpc.webmail.kpnmail.nl>
In-Reply-To: <178285902311.27465.11536482082229795452@noble.neil.brown.name>
References: <20260630105400.68459-1-jkoolstra@xs4all.nl>
 <178285902311.27465.11536482082229795452@noble.neil.brown.name>
Subject: Re: [PATCH v2 00/31] vfs: pass S_IFDIR mode to vfs_prepare_mode()
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


> Op 01-07-2026 00:37 CEST schreef NeilBrown <neilb@ownmail.net>:
> 
>  
> On Tue, 30 Jun 2026, Jori Koolstra wrote:
> > There is a comment in vfs_prepare_mode() that says:
> > 
> > Note that it's currently valid for @type to be 0 if a directory is
> > created. Filesystems raise that flag individually and we need to check
> > whether each filesystem can deal with receiving S_IFDIR from the vfs
> > before we enforce a non-zero type.
> > 
> > It is useful to do this clean-up ahead of O_CREAT|O_DIRECTORY.
> > Specifically, in lookup_open() we need to replace the vfs_prepare_mode()
> > with something that also handles dirs. I don't really want to push the
> > odd
> > 
> >     mode = vfs_prepare_mode(idmap, dir, mode, S_IRWXUGO | S_ISVTX, 0);
> > 
> > further into that code, and neither do I want this to be different from
> > the regular vfs_mkdir() path. We can then also match on S_IFMT in
> > may_o_create(), instead of passing a bool to signal whether we are
> > creating a dir (and assuming 0 means a dir is really ugly).
> > 
> > It is a bit challenging to verify that passing S_IFDIR is safe, as there
> > are many filesystems. Claude Opus 4.8 was used to generate the context
> > for each mkdir implementation from which it can be judged whether
> > passing S_IFDIR is OK. The result was then verified by hand by looking
> > at how the mode argument is used in each case. To check whether all
> > mkdir implementations are covered, 'rg "\.mkdir" ' was used and checked
> > against the list of uses Claude found.
> > 
> > It is safe to do this clean-up except that three filesystems (fuse,
> > cifs, and coda) forward the mkdir @mode unchanged to something outside
> > the kernel. Mask S_IFDIR back out in coda_mkdir(), fuse_mkdir() and
> > cifs_mkdir() so that what is sent outside the kernel is unchanged.
> > Their maintainers can drop the mask once they have confirmed it is safe.
> > For the other filesystems redundant S_IFDIR OR'ing is dropped.
> 
> This all looks good to me - thanks.
> Reviewed-by: NeilBrown <neil@brown.name>
> 
> NeilBrown
> 
> 

Thanks for the review, Neil.

By the way, if possible, would be great if we can get the excl flag removed
(as you mentioned) before the next merge window. Then the O_CREAT|O_DIRECTORY
stuff can use that clean-up as well (along with this) and maybe we can get
it all into 7.3.

Is it OK if I just go ahead and do that? But it is your observation, so feel free
to do it yourself whenever you have time, of course :)
