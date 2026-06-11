Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181001A9F90;
	Thu, 11 Jun 2026 04:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781151527; cv=none; b=sTLBhES7pDzzmgl9AVaRkeBaSVwbbOvoZ4DmsCE9QRGnhn22o0ImtbMIXE2/EleysMtYaPCOgR00mrOUSj/HdQhgWmFe8zU/4Zd9XgBHyay6QUd6n2E8j3q/68kUghzZG2Kd3UnzqJgjnR4mt/FwUvsp+wagYjxheWtGaT5Swb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781151527; c=relaxed/simple;
	bh=k/N9PzP8urmr7cKC1TYZw0B/99I1ksbcHVIBnW2D0uU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxE8piKQK/0ysOsqQBK/zLOiCkIebTSUyDUmGavGZ57mYcS9Aymm47A2fgqjejlBJr8LjeuHZSKyFeN6K9NM+WVSL360eH2LCRkFb6jjJi+95c/CTZVoi8Vooxt/CE+mODmPF+6rCkGYsiVeVapfLWmQQFZ67RPmVtDNytlENWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8699oWT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8699oWT"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A9A461F00893;
	Thu, 11 Jun 2026 04:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781151525;
	bh=QhsrUDXjPtxdirQnof0Klka8enOpJ1zjgovM2IvdMiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m8699oWTTh9PY0Zyz9zOm4tXemk4DHVAKPrjKIEnR8umKrHzogR7hazwnQO4x5T5k
	 UII2guZ72qfBlZdVTgZVSbhzPuIDgd8otRXfHAlQ258nZ0CRthqUBcuVrPhq4PBsD7
	 g3O8y5QYdfzi9Ui6YD4EkMhDk/0Y5nJL0Ahq9TXuH/KHmdQYTJSr/IvEnLO5csCoLu
	 1OM1m/FMKubR6ya/w6xTaBQKDdrLQvV026zc7K3o/asogCrD1Cm11o4aPeHE/PxRKr
	 fJNdItwdHkHcTxKoKKtSxTvicpUSMoICJiC/k3engPKE9Ed83USLEssg4+wlXe/eP5
	 t150FzDmcnxoA==
Date: Wed, 10 Jun 2026 21:18:45 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: david.laight.linux@gmail.com, Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>
Subject: Re: [PATCH next] fs/hfsplus/xattr: Use memcpy() and strscpy() to
 build xattr_name
Message-ID: <20260611041845.GC6060@frogsfrogsfrogs>
References: <20260608095523.2606-39-david.laight.linux@gmail.com>
 <2543b22369ec19dae397963fbdf2e7181c7419a8.camel@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2543b22369ec19dae397963fbdf2e7181c7419a8.camel@dubeyko.com>

On Wed, Jun 10, 2026 at 08:50:33PM -0700, Viacheslav Dubeyko wrote:
> On Mon, 2026-06-08 at 10:55 +0100, david.laight.linux@gmail.com wrote:
> > From: David Laight <david.laight.linux@gmail.com>
> > 
> > xattr_name is kmalloc()ed at the (assumed) maximal size and then the
> > prefix
> > and name concatenated together.
> > Use memcpy() for the prefix - its length is passed and strscpy() for
> > the
> > name to ensure it really doesnt overflow.
> > 
> > Prior to bf29e886b242c the buffers were smaller and on-stack.
> > (But I cant see the copy in the old code.)
> > I am also not sure why the buffer isnt created "just long enough".
> > 
> > Signed-off-by: David Laight <david.laight.linux@gmail.com>
> > ---
> > This is one of a group of patches that remove potentially unbounded
> > strcpy() calls.
> > 
> > They are mostly replaced by strscpy() or, when strlen() has just been
> > called, with memcpy() (usually including the '\0').
> > 
> > Calls with copy string literals into arrays are left unchanged.
> > They are safe and easily detected as such.
> > 
> > The changes were made by getting the compiler to detect the calls and
> > then fixing the code by hand.
> > 
> > Note that all the changes are only compile tested.
> > 
> > Some Makefiles were changed to allow files to contain strcpy().
> > As well as 'difficult to fix' files, this included 'show' functions
> > as they really need to use sysfs_emit() or seq_printf().
> > 
> > All the patches are being sent individually to avoid very long cc
> > lists.
> > Apologies for the terse commit messages and likely unexpected tags.
> > (There are about 100 patches in total.)
> > 
> >  fs/hfsplus/xattr.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
> > index 452a1f9becb2..0b3dd48c28c9 100644
> > --- a/fs/hfsplus/xattr.c
> > +++ b/fs/hfsplus/xattr.c
> > @@ -550,8 +550,8 @@ int hfsplus_setxattr(struct inode *inode, const
> > char *name,
> >  	xattr_name = kmalloc(xattr_name_len, GFP_KERNEL);
> >  	if (!xattr_name)
> >  		return -ENOMEM;
> > -	strcpy(xattr_name, prefix);
> > -	strcpy(xattr_name + prefixlen, name);
> > +	memcpy(xattr_name, prefix, prefixlen);
> 
> What's the point to mix memcpy and str*() family of methods? What's
> wrong with str*() method here? Otherwise, if it is wrong to use str*()
> family of methods, then why is it correct to use for second operation?
> 
> > +	strscpy(xattr_name + prefixlen, name, xattr_name_len -
> > prefixlen);
> 
> Why strscpy() is better than strncpy()? What is the main argument here?
> 
> >  	res = __hfsplus_setxattr(inode, xattr_name, value, size,
> > flags);
> >  	kfree(xattr_name);
> >  
> > @@ -698,6 +698,7 @@ ssize_t hfsplus_getxattr(struct inode *inode,
> > const char *name,
> >  			 void *value, size_t size,
> >  			 const char *prefix, size_t prefixlen)
> >  {
> > +	size_t xattr_name_len = NLS_MAX_CHARSET_SIZE *
> > HFSPLUS_ATTR_MAX_STRLEN + 1;
> 
> Frankly speaking, it looks like a constant that should be declared in
> hfs_common.h. Even if we would like to declare it here, then it should
> be const size_t, from my point of view.
> 
> >  	int res;
> >  	char *xattr_name;
> >  
> > @@ -705,13 +706,12 @@ ssize_t hfsplus_getxattr(struct inode *inode,
> > const char *name,
> >  		inode->i_ino, name ? name : NULL,
> >  		prefix ? prefix : NULL);
> >  
> > -	xattr_name = kmalloc(NLS_MAX_CHARSET_SIZE *
> > HFSPLUS_ATTR_MAX_STRLEN + 1,
> > -			     GFP_KERNEL);
> > +	xattr_name = kmalloc(xattr_name_len, GFP_KERNEL);
> 
> Finally, I think kzalloc() should be much better for both cases.

kasprintf()?

--D

> Thanks,
> Slava.
> 
> >  	if (!xattr_name)
> >  		return -ENOMEM;
> >  
> > -	strcpy(xattr_name, prefix);
> > -	strcpy(xattr_name + prefixlen, name);
> > +	memcpy(xattr_name, prefix, prefixlen);
> > +	strscpy(xattr_name + prefixlen, name, xattr_name_len -
> > prefixlen);
> >  
> >  	res = __hfsplus_getxattr(inode, xattr_name, value, size);
> >  	kfree(xattr_name);
> 
