Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A805F1CAA78
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 13:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780492573; cv=none; b=fR1WKwIRFcFIWm5XhK0Jpy9MyxEAZUnCsR42Nxcs42pjvtblIOnSipToelQNMXrPSBOBKgXArVBFC8PQdhngizD9aVYIuhlZaApLcgxiTOVmG757WGZwKIdGw7uqgYcfdeTcmwNMzukpZ6J+mVnNo0V6niw2xhKk0sQtekRXWrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780492573; c=relaxed/simple;
	bh=wozLM0J7FDMP484HAbYIEqrmWSxyvN0d83wEoo9gUDg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=gisU4scZf6uD82IHzM0ZqTy60cqbfasuwCxrJjvbY4MT+V1DEllxSfQ9KZK2qgohevIXYg8UaXkFxzRJ2YO4AcXMhh3BXfeCgOwWoDglLdGMKbdipoXFPsMbx54qULXFQhHkfiz9CN3EiloKKmoG1rqJBvsU/TfkdomvM39Y64o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=JbjfMWk+; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="JbjfMWk+"
X-KPN-MessageId: 5e60967d-5f4e-11f1-8ff7-005056999439
Received: from mta.kpnmail.nl (unknown [10.31.161.190])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 5e60967d-5f4e-11f1-8ff7-005056999439;
	Wed, 03 Jun 2026 15:16:02 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 5e5ef0fd-5f4e-11f1-99d0-0050569977a2;
	Wed, 03 Jun 2026 15:16:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=SuNbTneB8V86mfETiN+Nn4cazd1Zbkt1BJ1Ap/w2FQA=;
	b=JbjfMWk+ihnEUcJb8orzeNrNljrQtPzl8xnUfBdQTRh7IwzV0g1Da/V/nIBTKtLUPAhmo1mgOGj8a
	 vqfJhKU4cZX2w18xApxsloy6HREQvEV6vHjQePOmUPT5GmvcT8TYuXQB8L3l8Ii0fvJH+XKRcJMFon
	 dh0XwIy3pAmwK4LMcuzysMWrttpfbU/yioImWvda2z6m0gNqKKCrC61AYo3pICT7/d0rQbz0Fs0fFA
	 TOA+NK/qNEaBUp3QV0Mle6UJbPS9iXCgJ/nIxcIhekrOj6MfmNeeyRG7ZPh8XYBzcc4JXH7xjAr3wo
	 Ud9Vvb2ODtiRQHuR58I+GDWK+qG8niQ==
X-KPN-MID: 33|Udx/vehnoAA6wzixIuPd1hLxlrZkOLBjv7Mbgq7irl8gs1Z8yJlfZ+jedXhCzhD
 Kdb+gRtKjyq9GyFPAanW5/w==
X-CMASSUN: 33|AKiQEygRbVA1Z+Gol3mJifTzCc/IOrgL2mNFaZEfAn/ZN1hNgWeFmBkZf/AL4IY
 2IXZDQOpqI7nhVqvOiuKWNg==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh02 (cpxoxapps-mh02.personalcloud.so.kpn.org [10.128.135.208])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 5e4eaf84-5f4e-11f1-b8d7-005056995d6c;
	Wed, 03 Jun 2026 15:16:02 +0200 (CEST)
Date: Wed, 3 Jun 2026 15:16:01 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>, NeilBrown <neil@brown.name>
Cc: Aleksa Sarai <cyphar@cyphar.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	cmirabil@redhat.com
Message-ID: <1571071834.388026.1780492561946@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260602-sofern-filmpreis-erfordern-63998d3af067@brauner>
References: <20260525202937.466497-1-jkoolstra@xs4all.nl>
 <20260525202937.466497-2-jkoolstra@xs4all.nl>
 <177986687451.3379282.8177801680240137022@noble.neil.brown.name>
 <1825098847.140203.1780349158954@kpc.webmail.kpnmail.nl>
 <178035470365.2923901.16027569586235650310@noble.neil.brown.name>
 <20260602-sofern-filmpreis-erfordern-63998d3af067@brauner>
Subject: Re: [RFC PATCH v5 1/2] vfs: add O_CREAT|O_DIRECTORY to open*(2)
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


> Op 02-06-2026 17:44 CEST schreef Christian Brauner <brauner@kernel.org>:
> 
> Yes, I agree. This would change error codes but I don't think it
> matters:
> 
> * O_WRONLY | O_DIRECTORY on non-directory -> ENOTDIR
> * O_WRONLY | O_DIRECTORY on     directory -> EISDIR
> 
> I don't think that really matters and we should be able to collapse this
> to ENOTDIR.

I will pick this up in the next version of O_CREAT|O_DIRECTORY. I think that
makes most sense.

I have an outstanding patch for changing the EACCES/EPERM to EOPNOTSUPP;
Jeff and Jan were skeptical, but I want to know your opinion as well.
I feel the the scenario where userspace has no fall-through but does
handle every single -E listed in the man-page quite unlikely, so I say
lets change them and we'll hear from them if somehow someone relied on
this weird way of error handling.

> > > 
> > > There is another point, I maybe should have mentioned in the cover letter: I have not attempted
> > > to handle dangling symlinks for O_MKDIR. Not because I think they are a great idea (as Aleksa
> > > has mentioned, but I am not very familiar with the dragons it entails), but I wanted to discuss
> > > what behavior we want in this case. Do we say that we never do a mkdir after following a lookup
> > > last symlink? I don't think that state is even recorded right now.
> > 
> > I think the state might be recorded in nd->depth.  But you probably
> > don't want to use that directly.  Maybe forcing LOOKUP_FOLLOW to be
> > cleared if O_CREAT|O_DIRECTORY is set would be good.  But what would
> > stop you opening an existing directory through a symlink....
> > 
> > Probably we need a clear statement of intended semantics which we can
> > review, agree on, then implement.  Have you looked at preparing a patch
> > for man-pages to document the change in behaviour for openat etc?
> 
> Ugh, dangling symlinks. Actually, scratch that: Ugh, symlinks. So
> O_CREAT without O_NOFOLLOW allows you to create the target of a dangling
> symlink iirc. I always forget that. I think this is a very subtle bug
> and maybe - with both eyes closed - a feature at times.
> 
> We should straighten the behavior for O_DIRECTORY | O_CREAT and we
> agreed on that during LSFMM. It would be nice if we could get away with
> simply implying O_NOFOLLOW but I think you're right, Neil, that this
> prevents a valid O_CREAT | O_DIRECTORY on an existing directory which we
> can't do. Makes this kind of a pointless excercise.
> 
> But this shouldn't be all that crazy to do right. Using the O_CREAT as
> an _example_ for what we'd need:
> 
>     fs: refuse O_CREAT through a dangling symlink
> 
>     open(O_CREAT) without O_EXCL follows a trailing symlink and, when the
>     symlink target does not exist, creates it.  Refuse to create through a
>     dangling symlink instead.
> 
>     In lookup_open() a negative target reached with nd->depth > 0 was
>     arrived at by following a trailing symlink; since the dentry is negative
>     the symlink is dangling. Set create_error to -ELOOP in that case.
>     Reusing the existing create_error path strips O_CREAT for both the
>     generic and ->atomic_open create paths and only reports the error when
>     the target is actually negative, so opening an existing target through a
>     symlink, interior symlinks, and O_EXCL (which never follows the trailing
>     link) are all unaffected.
> 
>     Hastily-Cobbled-Together-by: Christian Brauner (Amutable) <brauner@kernel.org>
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index c7fac83c9a85..d20bbcc7e8d3 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4468,6 +4468,9 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>                                                     dentry, mode);
>                 else
>                         create_error = -EROFS;
> +               /* refuse to create through a dangling (trailing) symlink */
> +               if (unlikely(nd->depth) && !create_error)
> +                       create_error = -ELOOP;
>         }
>         if (create_error)
>                 open_flag &= ~O_CREAT;
> 
> It can't be that easy...

This is what I suggested above, correct, in terms of behavior?

In terms of the patch, I think this will work, but struct nameidata could really
use some commentary for its fields. I spent the last two hours verifying that
nd->depth really does what I thought it did, and I am still not 100% positive.
AFAIS, nd->depth indeed tracks the current symlink depth, which outside of
link_path_walk() reduces to the number of trailing links followed.

But if Neil's rework of lookup_open() is merged we lose access here to nd.
@Neil, have you thought about what would be a good way to resolve that?
