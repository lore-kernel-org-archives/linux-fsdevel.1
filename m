Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B7534040A
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 13:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784726832; cv=none; b=Gfqqq98XrRAzemfZKH0kFAXUdiut1Y5bMZ2yEUP4QbFZQqtGrAmXMPQGxJgCfQyDJU8gjgedfHL+9rkVJp6BNZ7XkDE9FKYBzigQOnNVYWh2Z19QE+2IuitFaddTRUHW/v7RAF0xvyM4BrztmIDKuy4fWwsUwOENH17IGAK0tm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784726832; c=relaxed/simple;
	bh=ThJS8kQC1lyDt7HVuDS3gsyTKZWnYBBr2K9Vr5VYfBk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=AFh6EpUqHc6AT7T18AqeYEZ36CjKm0mTkXf+tV2Hp/oFUsWziVt0uXjOt1VWKPVc+Sc+ebdBDA/85xQ8he9k/WTNUpsDSXIQ2IUN3BYh3SPPVV/1NBhgSuzfbW42NT3iUC0HJB6cAT9FsWCtVqvnW70RUb96QGWkO5KRkmMjYDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=RyVAgi6o; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="RyVAgi6o"
X-KPN-MessageId: 09b941d4-85d1-11f1-8f54-005056992ed3
Received: from mta.kpnmail.nl (unknown [10.31.161.189])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 09b941d4-85d1-11f1-8f54-005056992ed3;
	Wed, 22 Jul 2026 15:27:08 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 09b819cf-85d1-11f1-ae89-0050569981f5;
	Wed, 22 Jul 2026 15:27:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=34cfnwifCy5RIEQFZMc/WICgSXla8u0z6EY3+zhWjmo=;
	b=RyVAgi6oNk15xanzeCj7gmpc7EfPLRyNebKiQ49SmB7ouxWMJI2dmesA+8Q5rr0ZS99JZSdGJU8k3
	 /ktyRYK/PWJfPB28KywiED0b/hbueX0fRiLYeV88fKd1HHc/IGxhcc4Ee47Z+V3U0lhf51RJfvjbYC
	 RaxI96Iet0JRIcas5r02p3/eCdLzejkcSPz5zSBGwfoyRlnfnExOXrDtNGLKOsZne6Ha7cSRQ/q+r0
	 RRCjwozDFoUATCEq8JT9h5qi+WfYd76MGsIq3vaejFDNWiX479N03P8UG2qAq2ngUqiUYsdTFIouw1
	 KQfzKd3lX6KiqmMRM0EPjHZikqfSHMw==
X-KPN-MID: 33|128Rxe5x9dzzpGjIEuntcbGn7XASwlrAGY+TcLht/MrDO1PFv6asN3Bz2+/sGsr
 JvOEiyiVfcSERgeSYRDwOEw==
X-CMASSUN: 33|rOmBz37bBSKYg4mQQ/qWJ4/bhyyedI03X/flEUlBnfqi3tKXf4NJbzUgs0kZz8G
 PbhwxG/TG48cIZDHqVqQbzw==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh01 (cpxoxapps-mh01.personalcloud.so.kpn.org [10.128.135.207])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 09ad7b29-85d1-11f1-916a-005056995d6c;
	Wed, 22 Jul 2026 15:27:08 +0200 (CEST)
Date: Wed, 22 Jul 2026 15:27:08 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christoph Hellwig <hch@infradead.org>,
	Christian Brauner <brauner@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>, Jeff Layton <jlayton@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <aleksa@amutable.com>, NeilBrown <neil@brown.name>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <987276143.170754.1784726828216@kpc.webmail.kpnmail.nl>
In-Reply-To: <amDBQN5lCGbRxGWm@infradead.org>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
 <20260704164149.3480051-10-jkoolstra@xs4all.nl>
 <akyyqnv9EpY7xVdC@pedro-suse.lan>
 <20260707-vorteil-unhaltbar-apotheke-47bb105161ff@brauner>
 <alS10NN_OduZEqvt@infradead.org>
 <20260722-mundpropaganda-vorwahl-funkverkehr-48efdde92a00@brauner>
 <amDBQN5lCGbRxGWm@infradead.org>
Subject: Re: [PATCH v3 09/14] vfs: add O_CREAT|O_DIRECTORY to open*(2)
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


> Op 22-07-2026 15:10 CEST schreef Christoph Hellwig <hch@infradead.org>:
> 
>  
> On Wed, Jul 22, 2026 at 02:51:54PM +0200, Christian Brauner wrote:
> > > No, we can't rely on something being backport to old enterprise/cloud
> > > kernel.  Doing so makes the interface unusable for actual applications.
> > 
> > It's backported to all LTS kernels for multiple years and this
> > nonsensical theory of using a software version with O_DIRECTORY |
> > O_CREAT on a pre-LTS kernel from years ago is just flimsy.
> 
> the kernel has always ignored unknown open flags, or unchecked
> combinations and you can't just silently give them a meaning unless
> it is backwars compatible.  That has nothing to do with this particular
> combination.
> 
> > 
> > Even just the mere fact that I was able to just backport that bugfix
> > that started returning hard errors to all LTS kernels with absolutely
> > zero regression reports defeats that argument. We've done way more
> > invasive changes. This is a strawman really. 
> 
> Of course it didn't break anything yet because no one used it yet.
> One we give it a meaning it will be used and break.  And if you like
> it or not, a lot o Linux deployment is not using recent stable releases
> or even tracking the -stable releases at all.
> 

If you want your software to be compatible with any Frankenstein-kernel
you just check what you O_CREATed is in fact a directory. If it is and
there is no EINVAL/EISDIR, you are running a supported kernel,
if it isn't, you're not.

Or you just require a minimal reasonable kernel version.

> Just like we've always done in the past we'll need to APIs that don't
> accidentally do the wrong thing on any old kernel.  We've survived doing
> it this way the last 25 years (maybe longer, but that's about how long
> I've been around) and there is no reason to magically change this now.
