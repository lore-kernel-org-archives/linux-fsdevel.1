Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA7137F00C
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 07:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783323002; cv=none; b=YP4nw0gEKkNG58tUXs2iWKFNUgCBZvkhK7vcL584+JtLc3EFJc+0mQRE+zs1muhs72HOnpIRbc/6f+rxHimnUgy928joFM8E44CUMGSHPppNNWF6QA0Jgn+E6IZntvR+qzuq09TTRj+dIG2tM4jowappZjnv62AwOIoAblbbSvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783323002; c=relaxed/simple;
	bh=YIfKh4z0etB3dhrOOFVp+iIv9yRAHwumgSMzjtU3VE0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sVwNfOB/aClXjZCYEcgnprfyRRU8N7u2dVrtzNPyi0zT2P7YvUm50jDqEQUK6yg8BhU6gDg9nvCFqL2AlviR3UwNHJRdBk8orsN7Sm4FOuskTlnv4czDfStg4Ls7lsUxX4lL12cNOAQgBlo6/NclYQhZA+RChXB1y3ViC72wiS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ou4qUnAP; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ou4qUnAP"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493c59f740cso18046035e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2026 00:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783322990; x=1783927790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gk/h+4f6MUXqGijdtmTGfvBn38IT9YErIxRtJmutDk=;
        b=Ou4qUnAPwm4JX9FxnRv4o3ZpZjjkbTSyELHf1GMu4bMw8xBuP8GiQlLVojKdA1bEoA
         xd/FTmomejKknONTtTz19VZF8Vf5D+eWfCY/ywxljCBuLaa8BI+UnftJcnkVx35uoJFF
         9vghy7L5cHvyyre5MBrnHmitabtIgROWwXr2PwOym1mG8tzP0fIozNtyVdVNTg4GFyUR
         eh2ahJLbmeIsAbabrbbFJiNeCy5yMjRxA0lWTDzU6B6g+gPxOIEMVieA1ZaV+f/v0jx8
         5mlpDF+hVK8BQvZc8Eyzarg0gtLqE4g7EaHmD/NoXRwPG6zBOHo8mY01eGIE6L/5DiDY
         omJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783322990; x=1783927790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2gk/h+4f6MUXqGijdtmTGfvBn38IT9YErIxRtJmutDk=;
        b=mLuZuPHNm0+8nxHzgvnPGfuTuwoC6Ff7HYATZc15Bk3pe3eatnQMBtMwEqVqwtmzcz
         8bTIzhJ180aYV7RaDrrG6JKXXOhX22XYXVP2tztwf8T/hwbJ+OhA8h6CzyjHQ8ZWMFoI
         atRyDqk2B1dUW12HW+wIkAO3Zy8WndAywO++WBR6BWiKB0+BeCxMiux4TictkTDcUl7g
         IY3XFVejTR1UA7M2YHVB1Va6Lv5mM0wHif0+TY1cWy+rduoPawXpLTTbOfkyxVfO9q0H
         /ekgdWTp60E6lI2JJTj3GHtvzA+xAOSwaqW/4cZ/1OTByL0ygt/7tN4iL6ZFzyJJIxBM
         x6nQ==
X-Forwarded-Encrypted: i=1; AHgh+RqTtLmrVOtkFICaTdOtQz5pslECmwjhN0K8JhAR2Vrpflj8QOcMIqlLn2PW2LHX0LXk2yi+gRvAVShNouJY@vger.kernel.org
X-Gm-Message-State: AOJu0YwIGbCITGZ3TG5a7YUp6zeYSVG932G0EDqF5p5VEdiWvua6asA0
	kivRiyqMOEkXBVDHu7qXkQRSZGjQqCu9+l7kRzo0iSAVD5/8QYVU1OsN
X-Gm-Gg: AfdE7clLThKC3VlHoIc2uJ36a2AX0QMAnH96N8ELzrHa7K0pNMVm44SO1K1HwfemQiB
	7qwCoUxpfWWj+9M9Wn63uXI0mbJ2gKmHMcLbP3ONFUUhl9T5S9Jc461UYGWI1zWOwabxBsuBeeI
	Opw9Xd+/t7/eRyd5idC96s8tQzTo3yd5lo6oq7uiJxjcsohs5g03fn+Uu+F5bZmVKL76BC8qPl3
	GCf01YVm0XJkHhLR5kZvX3ErnD8pQ4rx4NCeo0V7p6ltU5butu4uxgdpNseVNCaBsy/wZWmhfWn
	GE8H7tpRtDgQ4g4ygHizPf61jaaMILW46pXKWgCm/7KKiEr3kl0jJkwbZfC73pskuBVdAQQVATJ
	GHzJkbvZ9yermCFRk2Qr/xj2htvSpHe5H1IiQLtt00D+CGGPS4Ocr3imjlUv7zpZWCVGUGfiBe6
	mn9tFPBo/6N+jRmrTFJSpTDjQHypebgy5fKfviOLY+DloRFA==
X-Received: by 2002:a05:600c:5296:b0:493:d741:5d72 with SMTP id 5b1f17b1804b1-493d7415e1bmr58494515e9.38.1783322989313;
        Mon, 06 Jul 2026 00:29:49 -0700 (PDT)
Received: from pumpkin (host-92-21-50-228.as13285.net. [92.21.50.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c6381e4fsm404764895e9.8.2026.07.06.00.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 00:29:48 -0700 (PDT)
Date: Mon, 6 Jul 2026 08:29:47 +0100
From: David Laight <david.laight.linux@gmail.com>
To: NeilBrown <neilb@ownmail.net>
Cc: NeilBrown <neil@brown.name>, "Jori Koolstra" <jkoolstra@xs4all.nl>,
 "Jeff Layton" <jlayton@kernel.org>, "Christian Brauner"
 <brauner@kernel.org>, "Al Viro" <viro@zeniv.linux.org.uk>, "Aleksa Sarai"
 <aleksa@amutable.com>, "Amir Goldstein" <amir73il@gmail.com>, "Jan Kara"
 <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/14] fs/namei.c: use trailing_slashes()
Message-ID: <20260706082947.248bcd17@pumpkin>
In-Reply-To: <178331016004.27465.14624469599238469373@noble.neil.brown.name>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
	<20260704164149.3480051-2-jkoolstra@xs4all.nl>
	<178331016004.27465.14624469599238469373@noble.neil.brown.name>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 06 Jul 2026 13:56:00 +1000
NeilBrown <neilb@ownmail.net> wrote:

> On Sun, 05 Jul 2026, Jori Koolstra wrote:
> > There are several places in fs/namei.c that can use the
> > trailing_slashes() function to improve intent.  
> 
> I think it would help to state here that trailing_slashes() is changed
> to take a qstr instead of a nameidata as that is useful in more places.

It is also taking the struct 'by value' so should really be always_inline
before something makes a compiler decide it should be a real function.

(Or make it take a pointer)

	David

> 
> Reviewed-by: NeilBrown <neil@brown.name>
> 
> Thanks,
> NeilBrown
> 
> 
> > 
> > Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> > ---
> >  fs/namei.c | 26 +++++++++++++-------------
> >  1 file changed, 13 insertions(+), 13 deletions(-)
> > 
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 19ce43c9a6e6..a8890bc0ae21 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -2781,9 +2781,14 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
> >  	return s;
> >  }
> >  
> > +static inline bool trailing_slashes(const struct qstr last)
> > +{
> > +	return (bool)last.name[last.len];
> > +}
> > +
> >  static inline const char *lookup_last(struct nameidata *nd)
> >  {
> > -	if (nd->last_type == LAST_NORM && nd->last.name[nd->last.len])
> > +	if (nd->last_type == LAST_NORM && trailing_slashes(nd->last))
> >  		nd->flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
> >  
> >  	return walk_component(nd, WALK_TRAILING);
> > @@ -4521,17 +4526,12 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
> >  	return ERR_PTR(error);
> >  }
> >  
> > -static inline bool trailing_slashes(struct nameidata *nd)
> > -{
> > -	return (bool)nd->last.name[nd->last.len];
> > -}
> > -
> >  static struct dentry *lookup_fast_for_open(struct nameidata *nd, int open_flag)
> >  {
> >  	struct dentry *dentry;
> >  
> >  	if (open_flag & O_CREAT) {
> > -		if (trailing_slashes(nd))
> > +		if (trailing_slashes(nd->last))
> >  			return ERR_PTR(-EISDIR);
> >  
> >  		/* Don't bother on an O_EXCL create */
> > @@ -4539,7 +4539,7 @@ static struct dentry *lookup_fast_for_open(struct nameidata *nd, int open_flag)
> >  			return NULL;
> >  	}
> >  
> > -	if (trailing_slashes(nd))
> > +	if (trailing_slashes(nd->last))
> >  		nd->flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
> >  
> >  	dentry = lookup_fast(nd);
> > @@ -4950,7 +4950,7 @@ static struct dentry *filename_create(int dfd, struct filename *name,
> >  	 * Do the final lookup.  Suppress 'create' if there is a trailing
> >  	 * '/', and a directory wasn't requested.
> >  	 */
> > -	if (last.name[last.len] && !want_dir)
> > +	if (trailing_slashes(last) && !want_dir)
> >  		create_flags &= ~LOOKUP_CREATE;
> >  	dentry = start_dirop(path->dentry, &last, reval_flag | create_flags);
> >  	if (IS_ERR(dentry))
> > @@ -5569,7 +5569,7 @@ int filename_unlinkat(int dfd, struct filename *name)
> >  		goto exit_drop_write;
> >  
> >  	/* Why not before? Because we want correct error value */
> > -	if (unlikely(last.name[last.len])) {
> > +	if (unlikely(trailing_slashes(last))) {
> >  		if (d_is_dir(dentry))
> >  			error = -EISDIR;
> >  		else
> > @@ -6171,16 +6171,16 @@ int filename_renameat2(int olddfd, struct filename *from,
> >  	if (flags & RENAME_EXCHANGE) {
> >  		if (!d_is_dir(rd.new_dentry)) {
> >  			error = -ENOTDIR;
> > -			if (new_last.name[new_last.len])
> > +			if (trailing_slashes(new_last))
> >  				goto exit_unlock;
> >  		}
> >  	}
> >  	/* unless the source is a directory trailing slashes give -ENOTDIR */
> >  	if (!d_is_dir(rd.old_dentry)) {
> >  		error = -ENOTDIR;
> > -		if (old_last.name[old_last.len])
> > +		if (trailing_slashes(old_last))
> >  			goto exit_unlock;
> > -		if (!(flags & RENAME_EXCHANGE) && new_last.name[new_last.len])
> > +		if (!(flags & RENAME_EXCHANGE) && trailing_slashes(new_last))
> >  			goto exit_unlock;
> >  	}
> >  
> > -- 
> > 2.55.0
> > 
> >   
> 
> 

