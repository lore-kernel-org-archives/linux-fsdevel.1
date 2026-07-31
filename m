Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDA6175A72
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 09:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785489156; cv=none; b=Vmjyc8EOZUSBtEk5MV1sdf97sE3SQIe+bx3tcEJrQdmqWKoHIH/bcGz/mneUMfvSqauMrl2hqlxyvNv4L6Cbea1jfg4zy6ZxBwEvr6EjAfNitnC3jSxUlSI3kyopIoOSpySRVjcnH7MCb5B314iETgKIsSIKMldzQwAFA8uYhgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785489156; c=relaxed/simple;
	bh=+zBuoWj6GSK9P6K06kvWIQd86CvZJelLSrY/DZ0fA4U=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=NlTVKs/a3Kzl07JtdVKvuaofxISRq6NkriR8H6hiKHHyOBCNtJ19q3+niiw9LL3a36FENWYe266/O7iaelKeKizEtCyfA5BF/KNt3MvGZc08InEtrwo35Oo8we3MC3Pm3IH78hkRypHWqXnJ1QWTfqyB3dnyTQQ28YHUwjnQaCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=V9+TeuZi; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="V9+TeuZi"
X-KPN-MessageId: ccd54106-8cbf-11f1-a5a1-005056994fde
Received: from mta.kpnmail.nl (unknown [10.31.161.190])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id ccd54106-8cbf-11f1-a5a1-005056994fde;
	Fri, 31 Jul 2026 11:11:22 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id ccd40ea9-8cbf-11f1-b31a-0050569977a2;
	Fri, 31 Jul 2026 11:11:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=wxmUkEnpty6FYwIE54v609YdAntBAWMCZXSIWundWd0=;
	b=V9+TeuZinKKTri4f2IyasbpjlHNebe2jgQ/rdAPODVzw/Y0kFo0qRup4cfmq92FiEds/eEYQTt+ar
	 aa0iI3QnEnDMtpz6iUYFoj7vXPS6z0PCxjaCNIJWKgtgI1rt2OcRQSzJY4+RNln/eNEXlWzMgixpMe
	 rTzJzY7iJfGtdm3roReXDpyiPYmEbyub9ardDhh4xwAvjG2ySULDi0a/zJXFQrC5O/mKypFtDwiOVo
	 cry2WDTJPXQNIwnxiG5W2md5hFHREsg5iNFW6Wu9cOtRi49Agb9CDLujIj6G+JIHEm5HYnPtO0YgV8
	 8ivXzywfzPfxXxnVATZd08FVP5VwBPg==
X-KPN-MID: 33|XObs10YDnKZ9AUTPx57TBD+4STM/k/xz6b5rqoUwxp0zEeMysQ3tgzfbw11zRSU
 39IE6ad9RO2KqW4Hkwu8MVLR1eBcCnCbiYR7DQiicS8c=
X-CMASSUN: 33|0wAGn0XbrPwcT8AJxXuV5B6L+kFc6aOEmVQ1hU56yvyBdzmv9wdqnRj0dDsSk7e
 4cRi+mgk3rid5twUM7qvRaQ==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh06 (cpxoxapps-mh06.personalcloud.so.kpn.org [10.128.135.212])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id ccc76770-8cbf-11f1-916a-005056995d6c;
	Fri, 31 Jul 2026 11:11:22 +0200 (CEST)
Date: Fri, 31 Jul 2026 11:11:22 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>, NeilBrown <neil@brown.name>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org
Message-ID: <2144344067.691627.1785489082742@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260731-work-lookup-fixes-v1-2-2412b85cf65c@kernel.org>
References: <20260731-work-lookup-fixes-v1-0-2412b85cf65c@kernel.org>
 <20260731-work-lookup-fixes-v1-2-2412b85cf65c@kernel.org>
Subject: Re: [PATCH 2/3] fs/namei.c: fix kerneldoc of atomic_open() and
 vfs_lookup_open()
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

Hi Christian,

> Op 31-07-2026 10:36 CEST schreef Christian Brauner <brauner@kernel.org>:
> 
>  
> Commit ba0e87026613 ("fs/namei.c: update kerneldoc of atomic_open()")
> turned the comment above atomic_open() into kerneldoc, but wrote the
> return description as running text.  kernel-doc only recognises a return
> section introduced by "Return:" or "Returns:", so this added a warning
> under W=1:
> 
>   fs/namei.c:4362 No description found for return value of 'atomic_open'
> 
> Give it the missing colon.  The summary line also has to stand on its
> own line, so move the "from a negative dentry" part into the body, where
> it can say that the caller has to hand over a negative dentry.
> 
> Also add the "to" missing from vfs_lookup_open()'s description.
> 
> Fixes: ba0e87026613 ("fs/namei.c: update kerneldoc of atomic_open()")
> Fixes: 536227b814bd ("VFS: add vfs_lookup_open() for nfsd")
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/namei.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 226abf613983..e31905dfeb20 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4337,8 +4337,7 @@ static int may_o_create(struct mnt_idmap *idmap,
>  }
>  
>  /**
> - * atomic_open() - attempt to atomically look up, create and open a file
> - * from a negative dentry.
> + * atomic_open() - atomically look up, create and open a file
>   * @path:          parent directory path
>   * @dentry:        child to ->atomic_open()
>   * @file:          file to attach child to
> @@ -4346,6 +4345,9 @@ static int may_o_create(struct mnt_idmap *idmap,
>   * @mode:          create mode
>   * @create_error:  return value from may_o_create()
>   *
> + * Attempt to look up, create and open @dentry, which must be negative, in a
> + * single call into the filesystem.
> + *
>   * If a non-error dentry is returned then: when FMODE_OPENED is set,
>   * the file will have been attached to @file by the filesystem calling
>   * finish_open(). If FMODE_OPENED isn't set, the filesystem instead called
> @@ -4354,8 +4356,8 @@ static int may_o_create(struct mnt_idmap *idmap,
>   * FMODE_CREATED is set when the call to ->atomic_open() actually created
>   * the file.
>   *
> - * Returns the opened/looked-up dentry on success or ERR_PTR(-E) on failure.
> - * On error, atomic_open() consumes @dentry.
> + * Returns: the opened or looked-up dentry, or ERR_PTR() on failure.  The
> + * reference to @dentry is consumed in either case.

Is this true? Maybe I am confused about the semantics of "consumed." If a function
returns a dentry (or anything else refcounted), without dput()-ing it (or whatever),
does that count as consuming that dentry in that function?

It's not mentioned in the commit log, that's why I ask :)

Thanks for the fixup!

Best,
Jori.
