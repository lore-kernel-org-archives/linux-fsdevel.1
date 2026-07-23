Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB9B28686
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 00:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784765456; cv=none; b=MpZi4Bn397ZBpMFQ35iuSgqkEgl1RRP0o2I3zUt3KB/LdMJoE6EIN38xJRvYdBJDu1vxRltsxAy3X11mhl0HzKIo0AV0Q3eK0ZflDfmj/b+OFQwG+FslHUOehAdGygOje9V5NIF1RMAIFEjakA0Ykwu5NPbJ4ROP3BeuoVhcFaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784765456; c=relaxed/simple;
	bh=9lLToDOzP1YmjPYLDgTZCdeHAd4X3R4jDDxcuRYnXvM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=n9sI0Xb17BbMReoHTxw7LSpeO+Ja7clVDiEZwmDIuBJT3fWs7fBoa7aWa7O0c06vwGIGbuZVyWBCtQ2YM/skPhiq5nGCq4eKT8DJloCcrs6ffjGwNDE2J5iJK47Gha383p3PGymYu0vIHEjA1oM+sjc++lbKUYlcf+hIALE4neM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=SsTYNn/+; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="SsTYNn/+"
X-KPN-MessageId: f28d034e-862a-11f1-bfba-00505699b430
Received: from mta.kpnmail.nl (unknown [10.31.161.190])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id f28d034e-862a-11f1-bfba-00505699b430;
	Thu, 23 Jul 2026 02:10:44 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id f28c8fd9-862a-11f1-b312-0050569977a2;
	Thu, 23 Jul 2026 02:10:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=n6woxcP3hzLUxxwSkZSd/gkpfJOskCDQbMLnubQhrw8=;
	b=SsTYNn/++WSjKPRLxLRk0DcdJibMM2wtN20oP2mPeLe2IW9sr2JE7tTpSPU7IxiGCLCIYBXyEOrpW
	 Ne0x9+LzL3YR6x8rWo7L2DPTQcaMOzFsblQNbdpTel2lKx9N5r/RGEsnLlg8UxfpaT82J1EOkLhuHL
	 r+ruaBDpn61H4+9bvFCFlAag4jhYhW44ZMUhU8pyA0CDdj4Vr+Ucekf4E6qotK+FOwNgVu1lqxzE7B
	 RFL9BOqUaXspCJvvMGFotCohuM8ZAM47aY0V3EF13XSLcL22rmfQ6m4iwxRTsF6rItuwbRc3ED4Y9F
	 Zw3TvXaASFQGGQHLzGAjXLSjNUjEZxw==
X-KPN-MID: 33|MwHrNRCWJ0YKnFi0kOpFYVEqszIUCW7f5SkO2uxRm+jsvttEBbBgyuhIDFYliB7
 CmFBMomfSUOGs03fhQX33fEDO1XA11NJ3rZw3Hr9+45Q=
X-CMASSUN: 33|GnQRVV+gQeGgj2b5ljGi4NT860jtH8CXi3nAf+PC5eAKyuLapQZ57YDfl8958mI
 JC+6yPQpXg2ZTySZVxxmKPQ==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh05 (cpxoxapps-mh05.personalcloud.so.kpn.org [10.128.135.211])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id f27bed51-862a-11f1-8edb-00505699eff2;
	Thu, 23 Jul 2026 02:10:44 +0200 (CEST)
Date: Thu, 23 Jul 2026 02:10:44 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: NeilBrown <neil@brown.name>, NeilBrown <neilb@ownmail.net>,
	Christoph Hellwig <hch@infradead.org>,
	Christian Brauner <brauner@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>, Jeff Layton <jlayton@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <aleksa@amutable.com>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <1713122837.215334.1784765444011@kpc.webmail.kpnmail.nl>
In-Reply-To: <178475745953.3371781.2895727677996716858@noble.neil.brown.name>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
 <20260704164149.3480051-10-jkoolstra@xs4all.nl>
 <akyyqnv9EpY7xVdC@pedro-suse.lan>
 <20260707-vorteil-unhaltbar-apotheke-47bb105161ff@brauner>
 <alS10NN_OduZEqvt@infradead.org>
 <20260722-mundpropaganda-vorwahl-funkverkehr-48efdde92a00@brauner>
 <amDBQN5lCGbRxGWm@infradead.org>
 <987276143.170754.1784726828216@kpc.webmail.kpnmail.nl>
 <178475745953.3371781.2895727677996716858@noble.neil.brown.name>
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


> Op 22-07-2026 23:57 CEST schreef NeilBrown <neilb@ownmail.net>:
> 
>  
> On Wed, 22 Jul 2026, Jori Koolstra wrote:
> > 
> > If you want your software to be compatible with any Frankenstein-kernel
> > you just check what you O_CREATed is in fact a directory. If it is and
> > there is no EINVAL/EISDIR, you are running a supported kernel,
> > if it isn't, you're not.
> > 
> > Or you just require a minimal reasonable kernel version.
> 
> Without getting all the arguments about how people should write their
> apps and choose their kernels.....
> 
> Given how easy it would be to make this bullet proof by adding a "fail
> if this combination isn't explicit permitted" flag to openat2 - why
> don't we just do that so that it is EASY to write as safe app and EASY
> to choose a kernel (i.e. any kernel at all with do).

There are two potential issues with this approach, neither of them definitively
killing the idea, but still:

1. Afaik, openat2 used to (or still is?) blocked by many seccomp-profiles,
   in particular by systemd. And frankly, a lot of UAPI changes are driven
   by the needs of these large user space applications, so it may defeat
   some of the purpose if these applications cannot use the discovery
   mechanism.

2. Matter of style: openat2 should just be about opening files, I'd rather
   not multiplex is to also do feature discovery.

Actually, why isn't there a has_feature(2) syscall that takes the syscall # as
argument and some other struct describing a feature. Then when adding a new
feature that may need discovery, require to extend it in the same patch series,
then not even Frankenstein-kernels can get in trouble.

Anyway, it is up to Christian.

Best,
Jori.
