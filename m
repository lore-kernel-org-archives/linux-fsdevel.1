Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5297C42CAEC
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 14:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433936; cv=none; b=VWbfrmLBaAuoZyHSfIyU/SnFTgLuXQTj1DqbgUrH//5ocrj0IIdUTXXjuZWxX7mQJ4OQSWBoS4ofdcO9yI791rMDiTrd0lJjrOeLiZ6qFW6N8qK4Ka+bxQfv/VwTbuQ+MIb0uLsTyfz7v9lE8TkaCbDJSO68tWym6kPy2mrr3W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433936; c=relaxed/simple;
	bh=0HinGbLIfqn1dk1gfe/lJwMyzfeNQxD+s0GeYYWjXAc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=jLHFW3KWnXnblQ9kUZkHV6T9P0SB19C2gU/7pGyJ4JRLw5+uS1FT7AwXpuhgRlYkdG0oeHgHHC1PtqheD5zVa8xzHKFrevx+d58/NBKm/2DUbYR6MPKaEpJ7zcGb1cSVT++JSowTRh3J+McYhv0MRjwxKizRYh6IQYKlD4EQ/vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=b2F1YfZ9; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="b2F1YfZ9"
X-KPN-MessageId: c6f6ee6f-7a0e-11f1-8f53-005056992ed3
Received: from mta.kpnmail.nl (unknown [10.31.161.189])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id c6f6ee6f-7a0e-11f1-8f53-005056992ed3;
	Tue, 07 Jul 2026 16:18:51 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id c6f5af73-7a0e-11f1-ae6c-0050569981f5;
	Tue, 07 Jul 2026 16:18:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=e8Jr0miG0HqWBl+z/oA/825tacXhz2vtpjiLhYu4zvI=;
	b=b2F1YfZ9v0pEILBFnuLWcZa+kjfIvJvcsmwTFEjZsSbXS4bxQmzNoCvtAzFJcFDHUPT3ixqBI+Xzl
	 4EH1V2x/bgIo0x2m2TsMSxNb2B0jj7HXMkgLZBIn38AY1TKxq32j2BVRO+Dx9RtCMZodzy4sN9VMeD
	 WOZT4D7cpHN6sovYhLLzTpg4M5EigqiuOzotKhr8v3LW3dqggZsFDuUDO6bP69Hbo9ftj/XZUFqd83
	 Oy9wXHrt8hYhC5acmToakGXpQIlo3e1yPCan6ODu5BZWWCHits+YhR36SrsL+AH+5lKxj2L0eW4eEA
	 8QXaf6ghKs9ELIlYLXJrRxT3Ogw0O6A==
X-KPN-MID: 33|LBuJPXzEVC3PnGi8LqqjM8oBbvlphZVMYEA9B0dIZ6aLNvkGBSfhe1iYncU9BRr
 YESm3nKZEUgytxCAhIaCHVafsbsvWIrjSCOetop9Q0oo=
X-CMASSUN: 33|9W8L/2oGiwltrBVCi5ulT+phm7aB8BCZYGDvh+AHg952yl/OLKjSdk8VjeHGjvo
 lF6VB968Ls544yNEkDeGggQ==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh04 (cpxoxapps-mh04.personalcloud.so.kpn.org [10.128.135.210])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id c6ea7fbd-7a0e-11f1-916a-005056995d6c;
	Tue, 07 Jul 2026 16:18:51 +0200 (CEST)
Date: Tue, 7 Jul 2026 16:18:50 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Aleksa Sarai <aleksa@amutable.com>, Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, NeilBrown <neil@brown.name>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <1400609680.217714.1783433931054@kpc.webmail.kpnmail.nl>
In-Reply-To: <akz_Ik8_eTnXav1H@pedro-suse>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
 <20260704164149.3480051-10-jkoolstra@xs4all.nl>
 <akyyqnv9EpY7xVdC@pedro-suse.lan>
 <1464441345.181098.1783418805206@kpc.webmail.kpnmail.nl>
 <akz_Ik8_eTnXav1H@pedro-suse>
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


> Op 07-07-2026 15:55 CEST schreef Pedro Falcato <pfalcato@suse.de>:
> 
>  
> On Tue, Jul 07, 2026 at 12:06:44PM +0200, Jori Koolstra wrote:
> > Hi Pedro,
> > 
> > > Op 07-07-2026 10:35 CEST schreef Pedro Falcato <pfalcato@suse.de>:
> > > 
> > > Ok so I genuinely don't see how users are supposed to use O_CREAT | O_DIRECTORY.
> > > Lets think about the portability here. This is undefined by POSIX (meaning you
> > > cannot rely on a O_CREAT | O_DIRECTORY having particular semantics). FreeBSD
> > > and NetBSD each have different semantics (my investigation stopped there
> > > ~3 years ago; I vaguely remember that macOS/Darwin does not/did not support
> > > O_DIRECTORY. I don't remember what's the deal with OpenBSD/Solaris/Illumos
> > > here).
> > > 
> > > So, essentially you can't rely on _any_ common behavior between platforms.
> > > Ok. Now, you may say "it's 2026 lol who cares about BSD". So lets look at Linux:
> > > - Linux for most of its lifetime had "return open directory, or create
> > >   a regular file".
> > > - It later had the above, with the added caveat that it always returned
> > >   ENOTDIR.
> > > - In 2023 I then found the bug and Christian changed it to always return
> > >   EINVAL on that combination.
> > > 
> > > Ok. So Linux had 3 behaviors and 2 of them do not make any kind of sense. But
> > > that's fine, we return EINVAL now. Except that the other behaviors existed.
> > > 
> > > So, lets say this feature lands as-is. If you're writing something *for Linux*,
> > > you have to contend with the previous *3 behaviors* for a grand total of 4
> > > behaviors. Including bizarre runtime tests, lest you are running on something
> > > pre-6.4 (system calls can be similarly problematic, but at least there its a
> > > simple ENOSYS test).
> > > 
> > 
> > But isn't this a problem with all UAPI design? You introduce a new feature that
> > does not exist on old kernels, then userspace can use that feature but must
> > provide fallback behaviors for any older kernel that the userspace program wants
> > to support. Ideally, this is abstracted away by some library. Then, at some point
> > this library raises its minimal supported kernel version bar, and it can clean-up
> > the now obsolete fallback code.
> 
> Correct, but usually most new UAPIs have very simple checks:
> 
> if (syscall(SYS_ponies) < 0 && errno == ENOSYS) {
> 	fallback();
> }
> 
> or
> 
> if (ponies(NEW_FLAG) < 0 && errno == EINVAL) {
> 	fallback();
> }
> 
> (in fact, many system calls out there can even be silently emulated by the
> libc if need be; this one can't, but that's besides the point)
> 

Forgive my ignorance, but why can't we use uname(2) or something to detect
kernel version and rely on that? Why must we check behavior as if it is a
black box? Is uname(2) blocked on systems for security reasons or something?

> My problem isn't with adding a new uapi, it's that the flag combination has
> so horrifically overloaded with weird semantics that it's pretty non-trivial
> to find out conclusively whether or not you have the feature, across the recent
> lifetime of Linux. I'm not even concerned with repurposing the flags because the
> old semantics were so obviously BS.
> 

How bad would it be to backport -EINVAL to the last stable kernels? I mean we know
people didn't really rely on the weird semantics prior to that because of your
find.

> 
> FWIW, thinking about this a bit more, it's possible that openat2() could serve
> as a stricter check for the UAPI in open() in general. Making this less
> footgunny to use.
> 

Not sure if I follow what you mean here.

> 
> -- 
> Pedro

Best,
Jori.
