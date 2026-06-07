Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9899530E838
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Jun 2026 18:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780857584; cv=none; b=i8+rl5Z2y+AfBXl6MTp4whsokB5nG/OQoyWHVL8qTKd+dpiVwNKxRKwSTiuW05vQqQK7cjAJDXiSWW5cpfMz55rfU9qiThWbh1jrK6b49jkxB/Ii/LhgmnlBTYvjUdFYHzPFi3/RTBllwkHb79qh4s6f4rMUezwfRvpxp6o6Qqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780857584; c=relaxed/simple;
	bh=PilhMNjn9+IA0ipiiW9xjgqcTcd4+/Tv7nRl62i6fLw=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=HUZP7qABgpA+8ySl8E6ajT4qs/2FKvvLFPrMNAODa4cH+9iQ/zF6LjWg0HArvnJIJrZ0++Pf6rVbk4TXr6b9hpziSpQCwP8SX3im966JkGQu9JhyJDNqsp17RV/854wFlyfp++63kfvCW2cl5eP+/EFkvRrRs2BbLwM2f4tkdKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=LATm2Go4; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="LATm2Go4"
X-KPN-MessageId: 39af5b9c-62a0-11f1-89f2-00505699b430
Received: from mta.kpnmail.nl (unknown [10.31.161.191])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 39af5b9c-62a0-11f1-89f2-00505699b430;
	Sun, 07 Jun 2026 20:39:32 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 39ae45a8-62a0-11f1-83df-00505699891e;
	Sun, 07 Jun 2026 20:39:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=CfyG3b785FHYxrJ51diJYcykf3Hmz3p02u0PL93s1iw=;
	b=LATm2Go4rGmcRgjVOaIqBu04+WQxCQWcrkQvBowGXAhfZJmbW7iBy9xfr34bM0y19Hhhy09Snk05o
	 gbWR/u+W3wDWQc5MlpWMgm8MH/FNav7PMyWD66bHQlbo6XeZQXb/fkIXXHInzKsUISXiWZ0MRApERn
	 xUqFKaqXVLnkbBdCcTd5Y8ppueINgwlsB2pOd4Ce4Q46qL+iLcHwUU5n3ZwTTVPREVqOwebBeUaO5g
	 4t94XUEWuTkye9oqqmUj/qUo6KI8Rh5iDMARV2Y4daTpUskJAo2xNRJ+oNWcE0tp/zrUF2j7F7R79n
	 gk2l4AI7jl2BPKACKcebvQnVusc/yAg==
X-KPN-MID: 33|wa2Vv7SqMNNWNMbAC3y3uvWtsLYij2aG+gkkCdWcms0qLNb5OQz+DdO3VCQu0X2
 0WnNZYB3EYMkhjxMjMolgsi1puoH/cR0wVQyfCh1Z8O0=
X-CMASSUN: 33|ccjjfpgXNTLb+SdmMxd3LPIg4iYB06+vuRKUiCaxs3RqqQDWUTzwlIjZBAx7sSU
 g3OOvPLpIpjr3kID9szQT2A==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh07 (cpxoxapps-mh07.personalcloud.so.kpn.org [10.128.135.213])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 39a44255-62a0-11f1-94b1-00505699eff2;
	Sun, 07 Jun 2026 20:39:32 +0200 (CEST)
Date: Sun, 7 Jun 2026 20:39:32 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <1068136348.856262.1780857572651@kpc.webmail.kpnmail.nl>
Subject: Re: [PATCH 2/3] xattrat: accept empty O_PATH file descriptors
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

On Sun, Jun 07, 2026 at 06:41:35PM +0200, Andreas Gruenbacher wrote:
> Right now, the setxattrat(), getxattrat(), listxattrat(), and removexattrat()
> system calls fail with -EBADF when dfd is an O_PATH file descriptor, pathname
> is an empty string or NULL, and the AT_EMPTY_PATH flag in at_flags is set.
> (Regular non-O_PATH file descriptors are accepted.)  This is inconsistent with
> the behavior of system calls like fstatat() and fchmodat() which do accept
> those file descriptors.
> 
> The same operations can also be carried out indirectly by using
> "/proc/self/fd/<dfd>" as the pathname, but that is only more cumbersome, and
> for no good reason.  Fix that by changing the xattrat() system calls to accept
> these file descriptors directly.
> 

It does change the security model somewhat, because containers cannot
rely anymore on unmounting procfs to prevent SCM_RIGHT fds from being
used this way. However, we have already been letting go of this a bit
with O_EMPTYPATH. But Christian told me we might have to drop it
depending on what user space is actually doing. I am not aware of any
additional security issues that would be introduced by this. Do you have
any thoughts on this?

> We stick with the existing practice of leaving the behavior of the fsetxattr(),
> fgetxattr(), flistxattr(), and fremovexattr() system calls unchanged: those
> will still reject O_PATH file descriptors.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  fs/xattr.c | 56 +++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 32 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 09ecbaaa1660..34fa5a6139c4 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -692,7 +692,8 @@ int filename_setxattr(int dfd, struct filename *filename,
>  
>  static int path_setxattrat(int dfd, const char __user *pathname,
>  			   unsigned int at_flags, const char __user *name,
> -			   const void __user *value, size_t size, int flags)
> +			   const void __user *value, size_t size, int flags,
> +			   fmode_t mask)
>  {
>  	struct xattr_name kname;
>  	struct kernel_xattr_ctx ctx = {
> @@ -717,7 +718,7 @@ static int path_setxattrat(int dfd, const char __user *pathname,
>  
>  	CLASS(filename_maybe_null, filename)(pathname, at_flags);
>  	if (!filename && dfd >= 0) {
> -		CLASS(fd, f)(dfd);
> +		CLASS(fd_except, f)(dfd, mask);
>  		if (fd_empty(f))
>  			error = -EBADF;
>  		else
> @@ -750,14 +751,15 @@ SYSCALL_DEFINE6(setxattrat, int, dfd, const char __user *, pathname, unsigned in
>  
>  	return path_setxattrat(dfd, pathname, at_flags, name,
>  			       u64_to_user_ptr(args.value), args.size,
> -			       args.flags);
> +			       args.flags, 0);
>  }
>  
>  SYSCALL_DEFINE5(setxattr, const char __user *, pathname,
>  		const char __user *, name, const void __user *, value,
>  		size_t, size, int, flags)
>  {
> -	return path_setxattrat(AT_FDCWD, pathname, 0, name, value, size, flags);
> +	return path_setxattrat(AT_FDCWD, pathname, 0, name, value, size, flags,
> +			       FMODE_PATH);
>  }
>  
>  SYSCALL_DEFINE5(lsetxattr, const char __user *, pathname,
> @@ -765,14 +767,14 @@ SYSCALL_DEFINE5(lsetxattr, const char __user *, pathname,
>  		size_t, size, int, flags)
>  {
>  	return path_setxattrat(AT_FDCWD, pathname, AT_SYMLINK_NOFOLLOW, name,
> -			       value, size, flags);
> +			       value, size, flags, FMODE_PATH);
>  }
>  
>  SYSCALL_DEFINE5(fsetxattr, int, fd, const char __user *, name,
>  		const void __user *,value, size_t, size, int, flags)
>  {
>  	return path_setxattrat(fd, NULL, AT_EMPTY_PATH, name,
> -			       value, size, flags);
> +			       value, size, flags, FMODE_PATH);
>  }
>  
>  /*
> @@ -837,7 +839,7 @@ ssize_t filename_getxattr(int dfd, struct filename *filename,
>  
>  static ssize_t path_getxattrat(int dfd, const char __user *pathname,
>  			       unsigned int at_flags, const char __user *name,
> -			       void __user *value, size_t size)
> +			       void __user *value, size_t size, fmode_t mask)
>  {
>  	struct xattr_name kname;
>  	struct kernel_xattr_ctx ctx = {
> @@ -857,7 +859,7 @@ static ssize_t path_getxattrat(int dfd, const char __user *pathname,
>  
>  	CLASS(filename_maybe_null, filename)(pathname, at_flags);
>  	if (!filename && dfd >= 0) {
> -		CLASS(fd, f)(dfd);
> +		CLASS(fd_except, f)(dfd, mask);
>  		if (fd_empty(f))
>  			return -EBADF;
>  		return file_getxattr(fd_file(f), &ctx);
> @@ -891,26 +893,28 @@ SYSCALL_DEFINE6(getxattrat, int, dfd, const char __user *, pathname, unsigned in
>  		return -EINVAL;
>  
>  	return path_getxattrat(dfd, pathname, at_flags, name,
> -			       u64_to_user_ptr(args.value), args.size);
> +			       u64_to_user_ptr(args.value), args.size, 0);
>  }
>  
>  SYSCALL_DEFINE4(getxattr, const char __user *, pathname,
>  		const char __user *, name, void __user *, value, size_t, size)
>  {
> -	return path_getxattrat(AT_FDCWD, pathname, 0, name, value, size);
> +	return path_getxattrat(AT_FDCWD, pathname, 0, name, value, size,
> +			       FMODE_PATH);
>  }
>  
>  SYSCALL_DEFINE4(lgetxattr, const char __user *, pathname,
>  		const char __user *, name, void __user *, value, size_t, size)
>  {
>  	return path_getxattrat(AT_FDCWD, pathname, AT_SYMLINK_NOFOLLOW, name,
> -			       value, size);
> +			       value, size, FMODE_PATH);
>  }
>  
>  SYSCALL_DEFINE4(fgetxattr, int, fd, const char __user *, name,
>  		void __user *, value, size_t, size)
>  {
> -	return path_getxattrat(fd, NULL, AT_EMPTY_PATH, name, value, size);
> +	return path_getxattrat(fd, NULL, AT_EMPTY_PATH, name, value, size,
> +			       FMODE_PATH);
>  }
>  
>  /*
> @@ -974,7 +978,7 @@ ssize_t filename_listxattr(int dfd, struct filename *filename,
>  
>  static ssize_t path_listxattrat(int dfd, const char __user *pathname,
>  				unsigned int at_flags, char __user *list,
> -				size_t size)
> +				size_t size, fmode_t mask)
>  {
>  	int lookup_flags;
>  
> @@ -983,7 +987,7 @@ static ssize_t path_listxattrat(int dfd, const char __user *pathname,
>  
>  	CLASS(filename_maybe_null, filename)(pathname, at_flags);
>  	if (!filename) {
> -		CLASS(fd, f)(dfd);
> +		CLASS(fd_except, f)(dfd, mask);
>  		if (fd_empty(f))
>  			return -EBADF;
>  		return file_listxattr(fd_file(f), list, size);
> @@ -997,24 +1001,26 @@ SYSCALL_DEFINE5(listxattrat, int, dfd, const char __user *, pathname,
>  		unsigned int, at_flags,
>  		char __user *, list, size_t, size)
>  {
> -	return path_listxattrat(dfd, pathname, at_flags, list, size);
> +	return path_listxattrat(dfd, pathname, at_flags, list, size, 0);
>  }
>  
>  SYSCALL_DEFINE3(listxattr, const char __user *, pathname, char __user *, list,
>  		size_t, size)
>  {
> -	return path_listxattrat(AT_FDCWD, pathname, 0, list, size);
> +	return path_listxattrat(AT_FDCWD, pathname, 0, list, size, FMODE_PATH);
>  }
>  
>  SYSCALL_DEFINE3(llistxattr, const char __user *, pathname, char __user *, list,
>  		size_t, size)
>  {
> -	return path_listxattrat(AT_FDCWD, pathname, AT_SYMLINK_NOFOLLOW, list, size);
> +	return path_listxattrat(AT_FDCWD, pathname, AT_SYMLINK_NOFOLLOW, list,
> +				size, FMODE_PATH);
>  }
>  
>  SYSCALL_DEFINE3(flistxattr, int, fd, char __user *, list, size_t, size)
>  {
> -	return path_listxattrat(fd, NULL, AT_EMPTY_PATH, list, size);
> +	return path_listxattrat(fd, NULL, AT_EMPTY_PATH, list, size,
> +				FMODE_PATH);
>  }
>  
>  /*
> @@ -1065,7 +1071,8 @@ static int filename_removexattr(int dfd, struct filename *filename,
>  }
>  
>  static int path_removexattrat(int dfd, const char __user *pathname,
> -			      unsigned int at_flags, const char __user *name)
> +			      unsigned int at_flags, const char __user *name,
> +			      fmode_t mask)
>  {
>  	struct xattr_name kname;
>  	unsigned int lookup_flags;
> @@ -1080,7 +1087,7 @@ static int path_removexattrat(int dfd, const char __user *pathname,
>  
>  	CLASS(filename_maybe_null, filename)(pathname, at_flags);
>  	if (!filename) {
> -		CLASS(fd, f)(dfd);
> +		CLASS(fd_except, f)(dfd, mask);
>  		if (fd_empty(f))
>  			return -EBADF;
>  		return file_removexattr(fd_file(f), &kname);
> @@ -1092,24 +1099,25 @@ static int path_removexattrat(int dfd, const char __user *pathname,
>  SYSCALL_DEFINE4(removexattrat, int, dfd, const char __user *, pathname,
>  		unsigned int, at_flags, const char __user *, name)
>  {
> -	return path_removexattrat(dfd, pathname, at_flags, name);
> +	return path_removexattrat(dfd, pathname, at_flags, name, 0);
>  }
>  
>  SYSCALL_DEFINE2(removexattr, const char __user *, pathname,
>  		const char __user *, name)
>  {
> -	return path_removexattrat(AT_FDCWD, pathname, 0, name);
> +	return path_removexattrat(AT_FDCWD, pathname, 0, name, FMODE_PATH);
>  }
>  
>  SYSCALL_DEFINE2(lremovexattr, const char __user *, pathname,
>  		const char __user *, name)
>  {
> -	return path_removexattrat(AT_FDCWD, pathname, AT_SYMLINK_NOFOLLOW, name);
> +	return path_removexattrat(AT_FDCWD, pathname, AT_SYMLINK_NOFOLLOW, name,
> +				  FMODE_PATH);
>  }
>  
>  SYSCALL_DEFINE2(fremovexattr, int, fd, const char __user *, name)
>  {
> -	return path_removexattrat(fd, NULL, AT_EMPTY_PATH, name);
> +	return path_removexattrat(fd, NULL, AT_EMPTY_PATH, name, FMODE_PATH);
>  }
>  
>  int xattr_list_one(char **buffer, ssize_t *remaining_size, const char *name)
> -- 
> 2.54.0
>
