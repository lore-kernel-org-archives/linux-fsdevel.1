Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429833DAC02
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 10:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783418810; cv=none; b=RgMiMelrHBkqkrnw2VjOKN27+q0wHd/n21wWJB5iEo46fJQDqlqSVX9Z4ElsjsQheFYJ1SpoxoLgF8rsTPKgrKeP/DI52ZL4rN/xlcmpjK75zQ53qvGTrjWSiCkmr858NNk/wpEDE4CCdZFticKa2fvCkP9Og+51EcrUtZZD97U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783418810; c=relaxed/simple;
	bh=D3rn0DtPYmuCF6e0GquOC9YrnF7/feVXEFfmrPrLxtA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=CfwVeE8mPyUlm7v9/WneZ1yDU/EAp7+Mu6iqprXMGWIgAr+xb+r9nLeqIjayLo3V5QGkeZSpdxn9sj0XYXbd1fcSVvTDSYdCCmnf3VG5RFaFcvevUBx3Aiurf+xTwrPmI6istcs2ytb7oZ/HIw7W0q6YJd2kzYYw9r4pP41l8co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=VebXnUm3; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="VebXnUm3"
X-KPN-MessageId: 8f451d7a-79eb-11f1-bfba-00505699b430
Received: from mta.kpnmail.nl (unknown [10.31.161.188])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 8f451d7a-79eb-11f1-bfba-00505699b430;
	Tue, 07 Jul 2026 12:06:45 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 8f43e2b7-79eb-11f1-9b0b-00505699693e;
	Tue, 07 Jul 2026 12:06:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=in+iHQH9wOy6U46pyL9cAT+porItx3t0Z29fgwgfggY=;
	b=VebXnUm3AB9qhjqXC5ty3ogulQdygqRwcMliwflr1DM/A8xvP97VL4UPYMiIybmAtxvmcQyZeQPL8
	 Py7Bfd3DEIEqMbQXMEELzP49djUNO267OfT8moYQ7SenDhEqh9rwLUMfnIW6kVO6imC/U8TF7nqU2g
	 mfeO9Rzey1GbsGWTWhp+H21ouyVss+E6awBNbWbvParFXijZ8nkPp1eqS3NAxuR/E/9NbsMuYQH8On
	 RmgDEO/licqe/JJl1nyRdWhxgFmB1mcR2D/kjW6GiSSAJhTBb9zeKQmAvt8Q5TaqnYZiUrU2uRVUpd
	 d4yPW7UXud28wFaYMChkLNnYP/2uKYQ==
X-KPN-MID: 33|WCGtEvvHeqy3H296w34MMV1+9acNTr5DEAMa68zH8/MoDGhzDEhbZA4Qw7+2cMl
 gNv48BHlg8bIYGMbydCeFk5TdBYjrfGUR0EjqwIXoNmE=
X-CMASSUN: 33|DLWlW11503ggDpue8mwEjLIjnWukaXzI3rmmTFWfv9GzRGXGftGLT1Gq8/l6Fsx
 Zr70Bdo5Npe1Sn1OEI6YofQ==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh06 (cpxoxapps-mh06.personalcloud.so.kpn.org [10.128.135.212])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 8f3566c7-79eb-11f1-8edb-00505699eff2;
	Tue, 07 Jul 2026 12:06:45 +0200 (CEST)
Date: Tue, 7 Jul 2026 12:06:44 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Pedro Falcato <pfalcato@suse.de>, Aleksa Sarai <aleksa@amutable.com>
Cc: Jeff Layton <jlayton@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, NeilBrown <neil@brown.name>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <1464441345.181098.1783418805206@kpc.webmail.kpnmail.nl>
In-Reply-To: <akyyqnv9EpY7xVdC@pedro-suse.lan>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
 <20260704164149.3480051-10-jkoolstra@xs4all.nl>
 <akyyqnv9EpY7xVdC@pedro-suse.lan>
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

Hi Pedro,

> Op 07-07-2026 10:35 CEST schreef Pedro Falcato <pfalcato@suse.de>:
> 
> Ok so I genuinely don't see how users are supposed to use O_CREAT | O_DIRECTORY.
> Lets think about the portability here. This is undefined by POSIX (meaning you
> cannot rely on a O_CREAT | O_DIRECTORY having particular semantics). FreeBSD
> and NetBSD each have different semantics (my investigation stopped there
> ~3 years ago; I vaguely remember that macOS/Darwin does not/did not support
> O_DIRECTORY. I don't remember what's the deal with OpenBSD/Solaris/Illumos
> here).
> 
> So, essentially you can't rely on _any_ common behavior between platforms.
> Ok. Now, you may say "it's 2026 lol who cares about BSD". So lets look at Linux:
> - Linux for most of its lifetime had "return open directory, or create
>   a regular file".
> - It later had the above, with the added caveat that it always returned
>   ENOTDIR.
> - In 2023 I then found the bug and Christian changed it to always return
>   EINVAL on that combination.
> 
> Ok. So Linux had 3 behaviors and 2 of them do not make any kind of sense. But
> that's fine, we return EINVAL now. Except that the other behaviors existed.
> 
> So, lets say this feature lands as-is. If you're writing something *for Linux*,
> you have to contend with the previous *3 behaviors* for a grand total of 4
> behaviors. Including bizarre runtime tests, lest you are running on something
> pre-6.4 (system calls can be similarly problematic, but at least there its a
> simple ENOSYS test).
> 

But isn't this a problem with all UAPI design? You introduce a new feature that
does not exist on old kernels, then userspace can use that feature but must
provide fallback behaviors for any older kernel that the userspace program wants
to support. Ideally, this is abstracted away by some library. Then, at some point
this library raises its minimal supported kernel version bar, and it can clean-up
the now obsolete fallback code.

I am fairly positive for instance that libpathrs would like to use O_CREAT | O_DIRECTORY,
but it is not going to demand kernel > 7.x anytime soon.


> If you're writing something that wants to be portable, or that intends to
> standardize on something, you have some 5 different behaviors all across
> the FOSS UNIX landscape, not considering everything else. It's also something
> that will, FWIW, probably never be included in POSIX because no one can agree
> on the semantics here.
> 

I have no idea how POSIX standardizes things. Does a committee get together and
revisit old syscalls every now and then?

But yeah, I think POSIX compliance isn't something we are really doing anymore.
Afaik there's nothing in POSIX about openat2(2) either, and we definitely wish
people would move to that instead of keep relying on open(2) (or even better,
use libpathrs!)

> TL;DR I don't see, given the reasons above, how users are supposed to use
> this without it being a total minefield.
> 
> If you're intent on the open() path, I would suggest that perhaps openat2()
> would be a nice alternative, although definitely not as beautiful as
> open(O_CREAT | O_DIRECTORY).
> 

Christian told me (somewhere on this list) that at LSFMMBPF all vfs maintainers
agreed on the O_CREAT | O_DIRECTORY direction. It allows to use all the neat
options from openat2(2) at the cost of a bit of multiplexing in lookup_open().
The question remains whether we also want the other things like mknodat_fd().

> Just my 2c. And I feel horrible typing this out because you clearly spent
> a great amount of time and effort between v2 and v3 as you redid this :/
> 

It's been a lot of work, yes :)

But luckily it has allowed me to study path resolution and the open()/mkdir()/etc.
syscalls in a fun and educative way.

> -- 
> Pedro

Best,
Jori.
