Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAF7382F0C
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 21:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780349163; cv=none; b=XdudHyo44kKMxGPfAz4fWqQTA5V5Zpbl1yyhlFdCtrSScPSA/qxR7gj5JwqOXFTLb6JYG7ohm3sBeSOWEDu3Z59AqsGG/du2NLcvBOFfu/oXau0dCemyCX3K+SHCvbK7LFGvMwL/AcO8B9/blMpMmPwJ9rKb/arLwQC1e/RI4Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780349163; c=relaxed/simple;
	bh=JGqK9iiSl9ljyNvUmyh3eV6cQ7MU5XCoP8NZjCui8dc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=mY2/unmREw+eIt9/0DEGpNEamaD+I/s2VG9rTJxE0Q+ZYauD5HpjcfOw+No+tVjwLZve24kAhK4anJime5D7ychadMuQwaR82YkFyYQ5z2lAyqboaMXqeqKJFg+6OaT9e/TkQdLGziW8zP6Jo+QOpr21eln21Y3fbWiQrmVO9lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=fawBf239; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="fawBf239"
X-KPN-MessageId: 7b85a619-5e00-11f1-89f2-00505699b430
Received: from mta.kpnmail.nl (unknown [10.31.161.191])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 7b85a619-5e00-11f1-89f2-00505699b430;
	Mon, 01 Jun 2026 23:25:59 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 7b83a4e9-5e00-11f1-83dd-00505699891e;
	Mon, 01 Jun 2026 23:25:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=PK8Cn+VTLZJlAtuZxbiceq5/1KVJAkOc3pytUpa3nB4=;
	b=fawBf2398frEPZIzjsxXoPIKxKuOZLaIZSUSuoxWltOXgUJ6+YZFeiCxjzU0liRfvq2Or6G4yvcQb
	 cxJdts9oDR9Oc7oCvmay+azsOx7uOaWipLcd3NCCpNkHsPQ+5hjp/qySa/hmZchWh1O4YIjOI7zrB3
	 h7EXLa1FslkBS9pQQpKOqlhAeeuHlpqVY937sZ7qpkzR7bZdItM4FZmGDQq8dgp7lng3gImbRkT6UK
	 8Rd7zGe69b0gmdOC4iCpWhTl+nBQUHIbrgAaLFuaNGZTQECTZOue4Nh8CL9i6TobEu1MYlOy0Gkkq/
	 S/i2KeLlUYF9i6CcCHVjU3OZNcUceMw==
X-KPN-MID: 33|loT5YMxADASKmWnnXAFfQX5QQnYBc8A0R/PIFZGuAYsaf6J9ItBAq24nEC3M+Gw
 5jIV3aB2TX+TBnLKAUb+TLKh3Jer/C0EFJTWNlJOD2YQ=
X-CMASSUN: 33|jUnX+SWO8C4JA1r9vk+QRfxZTNiV6Q1jP/1/6jPuq1XilsG1pL1l/0FIpx41Hyl
 YbCmt60Lcb0naHcuzwtIcWQ==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh02 (cpxoxapps-mh02.personalcloud.so.kpn.org [10.128.135.208])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 7b76a33a-5e00-11f1-94b1-00505699eff2;
	Mon, 01 Jun 2026 23:25:59 +0200 (CEST)
Date: Mon, 1 Jun 2026 23:25:58 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>, NeilBrown <neil@brown.name>,
	Aleksa Sarai <cyphar@cyphar.com>, NeilBrown <neilb@ownmail.net>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	cmirabil@redhat.com
Message-ID: <1825098847.140203.1780349158954@kpc.webmail.kpnmail.nl>
In-Reply-To: <177986687451.3379282.8177801680240137022@noble.neil.brown.name>
References: <20260525202937.466497-1-jkoolstra@xs4all.nl>
 <20260525202937.466497-2-jkoolstra@xs4all.nl>
 <177986687451.3379282.8177801680240137022@noble.neil.brown.name>
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


> Op 27-05-2026 09:27 CEST schreef NeilBrown <neilb@ownmail.net>:
>
> > @@ -1268,6 +1269,8 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
> >  	op->intent = flags & O_PATH ? 0 : LOOKUP_OPEN;
> >  
> >  	if (flags & O_CREAT) {
> > +		if ((flags & O_DIRECTORY) && (acc_mode & MAY_WRITE))
> > +			return -EISDIR;
> 
> It seems odd that the MAY_WRITE test is only performed for O_CREAT.
> Shouldn't any open of O_DIRECTORY|O_WRONLY fail, and shouldn't the one
> test catch both create and non-create cases?
> 

I get your point, it does look odd. But AFAIS O_DIRECTORY|O_WRONLY is currently only blocked
after path resolution and final lookup. So that was the behavior I tried to keep. On the
other hand, right now O_DIRECTORY|O_CREAT is already blocked in build_open_flags().

But if that is true, and you have atomic_open() defined for your filesystem, then you
can lookup and open a directory with O_DIRECTORY|O_WRONLY, while it fails with EISDIR later
(if the fs atomic_open() does not error on O_DIRECTORY|O_WRONLY, which I would guess it
mostly does). It will then fput_close() the file, so there is no leak, but I don't think
that is wanted behavior.

@Christian, what do you think?

> 
> >  		op->intent |= LOOKUP_CREATE;
> >  		if (flags & O_EXCL) {
> >  			op->intent |= LOOKUP_EXCL;
> > diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
> > index e4295a5b55b3..ec8c54c91261 100644
> > --- a/fs/smb/client/dir.c
> > +++ b/fs/smb/client/dir.c
> > @@ -526,6 +526,9 @@ int cifs_atomic_open(struct inode *dir, struct dentry *direntry,
> >  	if (unlikely(cifs_forced_shutdown(cifs_sb)))
> >  		return smb_EIO(smb_eio_trace_forced_shutdown);
> >  
> > +	if ((oflags & O_MKDIR_MASK) == O_MKDIR_MASK)
> > +		return -EINVAL;
> > +
> >  	/*
> >  	 * Posix open is only called (at lookup time) for file create now. For
> >  	 * opens (rather than creates), because we do not know if it is a file
> > diff --git a/fs/vboxsf/dir.c b/fs/vboxsf/dir.c
> > index 42bedc4ec7af..aef5ca6730be 100644
> > --- a/fs/vboxsf/dir.c
> > +++ b/fs/vboxsf/dir.c
> > @@ -318,6 +318,9 @@ static int vboxsf_dir_atomic_open(struct inode *parent, struct dentry *dentry,
> >  	u64 handle;
> >  	int err;
> >  
> > +	if ((flags & O_MKDIR_MASK) == O_MKDIR_MASK)
> > +		return -EINVAL;
> > +
> >  	if (d_in_lookup(dentry)) {
> >  		struct dentry *res = vboxsf_dir_lookup(parent, dentry, 0);
> >  		if (res || d_really_is_positive(dentry))
> > diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
> > index a332e79b3207..e31f3a57f07c 100644
> > --- a/include/linux/fcntl.h
> > +++ b/include/linux/fcntl.h
> > @@ -12,6 +12,8 @@
> >  	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
> >  	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
> >  
> > +#define O_MKDIR_MASK	(O_CREAT | O_DIRECTORY)
> > +
> >  /* List of all valid flags for the how->resolve argument: */
> >  #define VALID_RESOLVE_FLAGS \
> >  	(RESOLVE_NO_XDEV | RESOLVE_NO_MAGICLINKS | RESOLVE_NO_SYMLINKS | \
> > -- 
> > 2.54.0
> > 
> > 
> > 
> 
> Thanks,
> NeilBrown

There is another point, I maybe should have mentioned in the cover letter: I have not attempted
to handle dangling symlinks for O_MKDIR. Not because I think they are a great idea (as Aleksa
has mentioned, but I am not very familiar with the dragons it entails), but I wanted to discuss
what behavior we want in this case. Do we say that we never do a mkdir after following a lookup
last symlink? I don't think that state is even recorded right now.

Best,
Jori.
