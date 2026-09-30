Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592D549A3D6
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 23:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790810804; cv=none; b=nrSWHd1vGIfQmnN55j4NLn7yVp3zssC1x3+py17W0ET9us+AUrMEdZvuZacHykw03WBJ6KWE5A9nu3CSdMZ5a7VFrFEgdFEmnN8h1z7k9A/O4kvehMhvSgfhMRLg/hOYpuFDKGC00k3uCbVaQ9kX8w/yz3mOTLfiwMxGBs7VkHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790810804; c=relaxed/simple;
	bh=vPCAj/r9+1khiYIkXZIsgOtzQkGawxm+39EicdGE9Gk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=TAz/iYDVS86X29d7QY7GR/v0C4SFGQfthmfUYOE3Zi8X9fOJjswx8+hI0Sk39kMAhj5OV44uHSHtrL9CwYgcFsbw9UJXFXV/SpmPyLugpCQzvzOPJ6OFOI38ec+mOMxgNIS/qR5iUmmTv8Jeal4Y8bpbzSFI6vvO+DldVgDVwq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=KHa2TcEw; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="KHa2TcEw"
X-KPN-MessageId: 3a134e15-bd26-11f1-9e92-005056999439
Received: from mta.kpnmail.nl (unknown [10.31.161.188])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 3a134e15-bd26-11f1-9e92-005056999439;
	Thu, 01 Oct 2026 01:25:30 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 3a1227e2-bd26-11f1-ac16-00505699693e;
	Thu, 01 Oct 2026 01:25:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=EvyBXuZUixQbvhXaKEfI0QRoEXiRbDrSh4i0d9P5vNM=;
	b=KHa2TcEw8g7bqErpJsElhZen5CYoVLIoSwzwvgFRviccVuoqx5joSi+WuIBl2vd2W4rQISfmR00Sg
	 jQxnCKk0x/bbufCUNc7bAem8rGWKhmJSAQFVO3DSx5oUOOlxfcq/hxrwmfGpaPUqqpXkDdsZLihYEM
	 mkUXAvzcDzba7MauuXxnrPDAW4hkop52zbbbk3uhJUVeKChE5KR9wmk4uvgBw+HEfrRda3jUj/sCE5
	 rEBYQ+5uZG3V141Id2jIsJlZUQvNnEx02drUHjRrTLR+/b/uNFRtPEm3G+e74x29bp2UVav1i3pdU2
	 15M02r80b80bDQQpMJzpzton9pq4osA==
X-KPN-MID: 33|HhE2L2SaMWkGGO+libFZ2ax4logpeyTaQdfq4ReocqADJqllEDPbPrzwF7siQjk
 4ZLOh9QthLPhBR/DVKWnZ7dvcBBDGXCK1yhR+LZu8WKk=
X-CMASSUN: 33|om+lnf1ZmBkPmv8EQyS13ZysB1tcEecQ0oA6GihtTKHMhwzL28avix6KMfa4ysU
 l3zs0x/7HMaH5q+95BjOqPQ==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh08 (cpxoxapps-mh08.personalcloud.so.kpn.org [10.128.135.214])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 3a0abb5f-bd26-11f1-916a-005056995d6c;
	Thu, 01 Oct 2026 01:25:30 +0200 (CEST)
Date: Thu, 1 Oct 2026 01:25:30 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: NeilBrown <neil@brown.name>, NeilBrown <neilb@ownmail.net>
Cc: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <aleksa@amutable.com>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <1755972037.791960.1790810730535@kpc.webmail.kpnmail.nl>
In-Reply-To: <179080897361.37859.5844379463485936668@noble.neil.brown.name>
References: <20260913185016.523376-1-jkoolstra@xs4all.nl>
 <20260913185016.523376-8-jkoolstra@xs4all.nl>
 <20260918-reklamieren-syndikat-gemildert-763b72008b46@brauner>
 <178972607557.207413.4312278359822083538@noble.neil.brown.name>
 <178977609418.207413.15011378414000392029@noble.neil.brown.name>
 <1010887891.582666.1790682845752@kpc.webmail.kpnmail.nl>
 <179072013439.37859.465558431050704411@noble.neil.brown.name>
 <1315372552.791055.1790807597593@kpc.webmail.kpnmail.nl>
 <179080897361.37859.5844379463485936668@noble.neil.brown.name>
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


> Op 30-09-2026 18:56 EDT schreef NeilBrown <neilb@ownmail.net>:
> 
>  
> On Thu, 01 Oct 2026, Jori Koolstra wrote:
> > 
> > Err, *derp*, what a stupid suggestion of mine.
> > 
> > > Currently O_DIRECTORY|O_CREAT results in -EINVAL.  I would rather it
> > > remain a -EINVAL on any filesystem which doesn't completely support
> > > the functionality.
> > > 
> > 
> > I don't think that works for the reason I just wrote in my email to Amir:
> > it would make lookup dependent on the dentry cache. If it's in-cache, you get
> > your dir, otherwise suddenly -EINVAL.
> > 
> > > To do that we need some way to detect kernfs and tracefs.  I think
> > > the only way we can do that is to make some change to those two
> > > filesystems.
> > > Maybe a new  SB_I_ flag in sb->s_iflags would be ok in the short term.
> > > 
> > 
> > We can just implement atomic_open() for kernfs/tracefs, do a lookup there,
> > and if negative with O_CREAT return maybe -ENOENT (or really we need a new
> > error that says "the requested create could not be serviced," like -ENOCREATE,
> > or whatever). And if it is positive we do finish_no_open().
> > 
> > It's a bit of a hack because it does not really have anything to do with
> > atomicity, but it does short-circuit the mkdir call in lookup_open(). I guess
> > that would work. Maybe I am confused, but wasn't that what you proposed here
> > earlier?
> 
> Yes, it is what I proposed earlier.  But I think it would require more
> review and probably make it unrealistic to land this cycle.  But I'm not
> thinking it is unlikely to be ready this cycle any way.
> 

Not unlikely, so likely that is :)

> I'm now wondering if we should keep ->atomic_open out of the loop and
> always use ->mkdir to create a directory.
> Based on your justification you probably always want O_EXCL and I would
> be inclined to require that.
> 

I wanted it to work as regular O_CREAT, so no forced O_EXCL per se.

> So if the dentry is in-lookup we call ->atomic_open(O_DIRECTORY).  If
> that succeeds - good.  If it reports ENOENT or a negative dentry, then

Can ->atomic_open() return a negative dentry?

> we cal ->mkdir.  If that succeeds with a positive dentry, we call
> through to call ->open.
> If ->mkdir succeeds with a negative dentry - we have the problem of
> kernfs and tracefs.  I'm leaning towards fixing those to do the lookup.

Yes, I follow this. But we do need to ask their maintainers then why that
was chosen. Plus, we need to ban negative dentry returns also for future
fses, which may be limiting.

> 
> I don't think any filesystems *can* combine mkdir with open, so not
> using ->atomic_open for the mkdir doesn't actually lose anything.
> 

Yeah, I don't quite understand the specifics of this as I am not familiar
with NFS and the likes. I presume because of things like network traffic
->atomic_open() was needed as a single call into the underlying fs. But
I have no idea why or why not that would make sense for directories. If
we do it the way you suggest now, we can get rid of all the O_CREAT stripping

> NeilBrown
