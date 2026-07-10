Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6564337C925
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 18:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783709771; cv=none; b=NEQHOCQpEypDbhraiRVrGYf7NrI9TM9Z2BVGUmAI0ENo8Oyj907VmEUnmgN1ag3lUpVcvfE9/XVqjP+uYgrIKVYdz0Sn79yLr6i/AoMl0nkEAzKhSStLIrRZXBlCXKHVk9wCzq9T7YEHChVvWCdiqv/4CpG3rPdjOXim/Ycg3aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783709771; c=relaxed/simple;
	bh=IYEngjm2u2U8mwA1AsIHeS/HWJN8Lo/RbG0QV9Hs0zI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=DFVT5jjSgWfyTgkBv76w7l7Hs8sNUa2g5fYAvNMOjHFXHEc1kst+JlmgOKqWP9Obb3Ggztzwu+DpGc77Hu+1poIoIW+nlMzLRJ+iR9pVzy/XZViijH6WpJnvSbMYIKQYRy5XiSoScAHKe6krEF1wSJ56yc1SVXhBNlsirOTbqbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=IuhOkU9j; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="IuhOkU9j"
X-KPN-MessageId: fd92093b-7c90-11f1-9e8e-005056999439
Received: from mta.kpnmail.nl (unknown [10.31.161.191])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id fd92093b-7c90-11f1-9e8e-005056999439;
	Fri, 10 Jul 2026 20:55:59 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id fd910505-7c90-11f1-91b6-00505699891e;
	Fri, 10 Jul 2026 20:55:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=foQ7N96TTaOBYzh6e+zqiSy3uy81tMUpx53gtSwRZhM=;
	b=IuhOkU9jOFjXAT59dtLcO1IQQO+kW1DknickgsZEpsO4vA6S+Sgm7s69ELoDOiaE48NFaQ0Qo6liK
	 CIHva4Om8jgcVv4aztBsySdqFxjE1l/ze+kIihcFsWmR5oUDFOoWBuu4NHVFhsm4Eis8Pm0fg4h4J2
	 ImrXbH6a5I/M/z3JSkCFHhqZflpy+QWBcNnFwZTO/FXunpndxeck+P20LgAMWjjgFWfRHB6uFdzGEv
	 ZtZ9ipiFbbLoMs2IFauK5Wda3oF/rmjZV839uhQECDLtoi9XovtcwwHqP5RPdLHOoA5fmLJNLRuEu2
	 0wqZD/FHyF0Q61fsqupFvbllNcI6/7Q==
X-KPN-MID: 33|TgsavHs0M8oEKlbFi/gvCntxzOaIS37Gw8FOWXnD3GsPri37lygxdIypnY0O+gn
 9FyzEk50FNt66tWxK/u6nOQyGWnJbPNlb5TXAMRn6mdI=
X-CMASSUN: 33|y8sTOXm0NMcKQXyWP1Bugzr2MKcoIa0LfBXTKfHRwembCYOoJbIYqmJ3nGIum5M
 oL2RlHtY+o+ybTVsVbPA6Mw==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh05 (cpxoxapps-mh05.personalcloud.so.kpn.org [10.128.135.211])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id fd866990-7c90-11f1-8edb-00505699eff2;
	Fri, 10 Jul 2026 20:55:59 +0200 (CEST)
Date: Fri, 10 Jul 2026 20:55:59 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <aleksa@amutable.com>, NeilBrown <neil@brown.name>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <1944666535.644663.1783709759572@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260707-zeigen-lachhaft-situiert-1fe7432e21f9@brauner>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
 <20260704164149.3480051-10-jkoolstra@xs4all.nl>
 <20260707-zeigen-lachhaft-situiert-1fe7432e21f9@brauner>
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


> Op 07-07-2026 12:51 CEST schreef Christian Brauner <brauner@kernel.org>:
> 
>  
> > Currently there is no way to race-freely create and open a directory.
> > For regular files we have open(O_CREAT) for creating a new file inode,
> > and returning a pinning fd to it. The lack of such functionality for
> > directories means that when populating a directory tree there's always
> > a race involved: the inodes first need to be created, and then opened
> > to adjust their permissions/ownership/labels/timestamps/acls/xattrs/...,
> > but in the time window between the creation and the opening they might
> > be replaced by something else.
> > 
> > Addressing this race without proper APIs is possible (by immediately
> > fstat()ing what was opened, to verify that it has the right inode type),
> > but difficult to get right. Hence, adding support for a new flag combo
> 
> Eh, but that still means someone could've raced you and actually created
> that directory. When you bring in a shared filesysem state with joint
> cleanup responsibilities things aren't easily solved by fstat()ing.
> 

Right, but can't I check with fstat() if the object satisfies all properties
I need, like owner, group, inode, type, etc.?

If it does, then why care how it was created?

> > O_CREAT|O_DIRECTORY to open*(2) that creates a directory (if it does not
> > exist already) and returns an O_DIRECTORY fd is very useful.
> > 
> > Historically, the O_CREAT|O_DIRECTORY behaviour was to return ENOTDIR if
> > a regular file exists at the open path; EISDIR if a directory exists at
> > the path; and to create a regular file if no file exists at the path.
> > This behaviour changed accidentally with 973d4b73fbaf ("do_last(): rejoin
> > the common path even earlier in FMODE_{OPENED,CREATED} case") causing
> > ENOTDIR to return in the last case while still creating the file. As
> > this change was not detected for a long time, Brauner proposed to adopt
> > the more consistent NetBSD behaviour, i.e. to return EINVAL on the the
> > O_CREAT|O_DIRECTORY combination. This change was applied in 43b450632676
> > ("open: return EINVAL for O_DIRECTORY | O_CREAT") in March, 2023. As
> > the EINVAL behaviour has been in the kernel for about 3 year now, no
> > rollback is expected as a result of userspace reliance on old
> > behaviour, leaving us free to reassign the O_CREAT|O_DIRECTORY semantics.
> > 
> > O_CREAT|O_DIRECTORY is made to reduce to a lookup on ->atomic_open()
> > filesystems. This is implemented by stripping the O_CREAT bit. The other
> > option of simply returning -EINVAL leads to inconsistent behaviour:
> 
> I think this doesn't spell out why that's done: afaict, netfses can't
> currently deal with O_CREAT | O_DIRECTORY without protocol extensions.
> So that means you force it into a fallback mode where it manages to open
> an existing directory but fails with ENOENT otherwise. This should carry
> a brief comment why you force that type of fallback.
> 
> Also, how do you deal with O_EXCL? If you strip O_CREAT but leave O_EXCL
> depending on where exactly you do it, might this risk opening a
> directory giving userspace the impression they exclusively created it?
> 

I think we're fine, in do_open() we still have:

	if (open_flag & O_CREAT) {
		if ((open_flag & O_EXCL) && !(file->f_mode & FMODE_CREATED))
			return -EEXIST;

and I am stripping the local variable O_CREAT bit only. Also, do_open() is
only reached if we didn't have an -ENOENT return (lookup succeeded).

So it's either -ENOENT if the dir does not exist or if it does -EEXIST
(with O_EXCL set).

Agree?

> -- 
> Christian Brauner <brauner@kernel.org>
