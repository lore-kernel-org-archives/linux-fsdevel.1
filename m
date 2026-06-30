Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81C23C9894
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 12:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782821213; cv=none; b=i2sEUPRV8g2OE91npWAf49befjv1Fzh989bL2TTlNZmC07UVrjIFodZuc3f6rZAJ0FU2nBZ6lEul2rhc1zktcfFqfSSgQm1r7cBg1ZkwuDtqKKS4kDAcGBWHCmjkuYFoOtMGD1x28vEyLeORtx/5dirl4SawIdv1xN/BAP+4tRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782821213; c=relaxed/simple;
	bh=gj/wEJYySi3MEE17wYZ1ddxA0YVh3m7ssC5PQi+0np8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ikWr5yjlkxljaoDIpdapFpgYctbriwiGxwyTJ2lX4sQukn7V3lXM+S1PjR3S6pTKKBKwdarYVXnGhGGCUp2Yv14V5lpi70oQGTKcC1g+4hKnwdhibk4Oo8OyZt/DqAAIHw1XvwCLd65Zu2X0+GIooAnqc3SrMlace8BONIsUwM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MlWc4wda; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MlWc4wda"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782821210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YrKW+ASXvHkTAtDz3B6bbN0qjGt1KjYQ5+f/YXFilR8=;
	b=MlWc4wdaQs+Wyk0n/vCl6CJe4kiKgGNGpwQMXOtY6ojyfIsE3YfzsgFb38XAHzYg8/7ZsI
	2W54i/7YE/bHUhFGZ9CCsu8dTm2F1kMd86cSFMpg+v6g1vhZGbEHfQr6fFZqcFUbcF0UDw
	Vx7tZgOJhGwRX7rc8dWQJGly92tXuo4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-326-13cEbdzANlS82pMY0F8MLw-1; Tue,
 30 Jun 2026 08:06:46 -0400
X-MC-Unique: 13cEbdzANlS82pMY0F8MLw-1
X-Mimecast-MFC-AGG-ID: 13cEbdzANlS82pMY0F8MLw_1782821205
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D9CFF18052DB;
	Tue, 30 Jun 2026 12:06:44 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.49.17])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CE9CE1956051;
	Tue, 30 Jun 2026 12:06:42 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] xattrat: accept empty O_PATH file descriptors
Date: Tue, 30 Jun 2026 14:06:40 +0200
Message-ID: <20260630120641.133521-1-agruenba@redhat.com>
In-Reply-To: <20260630-wunsch-wichtel-ansporn-f4754acc8bcf@brauner>
References: <20260630-wunsch-wichtel-ansporn-f4754acc8bcf@brauner> <20260607164136.2948550-1-agruenba@redhat.com> <20260607164136.2948550-2-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Jun 30, 2026 at 11:12 AM Christian Brauner <brauner@kernel.org> wrote:
> > Right now, the setxattrat(), getxattrat(), listxattrat(), and removexattrat()
> > system calls fail with -EBADF when dfd is an O_PATH file descriptor, pathname
> > is an empty string or NULL, and the AT_EMPTY_PATH flag in at_flags is set.
> > (Regular non-O_PATH file descriptors are accepted.)  This is inconsistent with
> > the behavior of system calls like fstatat() and fchmodat() which do accept
> > those file descriptors.
> >
> > The same operations can also be carried out indirectly by using
> > "/proc/self/fd/<dfd>" as the pathname, but that is only more cumbersome, and
> > for no good reason.  Fix that by changing the xattrat() system calls to accept
> > these file descriptors directly.
> >
> > We stick with the existing practice of leaving the behavior of the fsetxattr(),
> > fgetxattr(), flistxattr(), and fremovexattr() system calls unchanged: those
> > will still reject O_PATH file descriptors.
> >
> > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> >
> > diff --git a/fs/xattr.c b/fs/xattr.c
> > index d58979115200..4737554df5fa 100644
> > --- a/fs/xattr.c
> > +++ b/fs/xattr.c
> > @@ -700,7 +700,8 @@ int filename_setxattr(int dfd, struct filename *filename,
> >
> >  static int path_setxattrat(int dfd, const char __user *pathname,
> >                          unsigned int at_flags, const char __user *name,
> > -                        const void __user *value, size_t size, int flags)
> > +                        const void __user *value, size_t size, int flags,
> > +                        fmode_t mask)
> >  {
> >       struct xattr_name kname;
> >       struct kernel_xattr_ctx ctx = {
> > @@ -725,7 +726,7 @@ static int path_setxattrat(int dfd, const char __user *pathname,
> >
> >       CLASS(filename_maybe_null, filename)(pathname, at_flags);
> >       if (!filename && dfd >= 0) {
> > -             CLASS(fd, f)(dfd);
> > +             CLASS(fd_except, f)(dfd, mask);
>
> So I can live with the O_PATH change, I guess...
> but I really dislike fd_except. The code should never bother to pass
> FMODE_PATH directly which is just rather ugly and we've taken pain to
> make it work without passing it.
>
> I also don't yet understand why this would be necessary at all.

So we've got some system calls that should accept O_PATH file descriptors
({get,set,list,remove}xattrat), and others that should not
(f{get,set,list,remove}xattr).

We could implement that by using either CLASS(fd) or CLASS(fd_raw) in
path_{get,set,list,remove}xattrat depending on which case we want, but that
would duplicate unrelated code.  To avoid that, this patch took the approach of
extending the class with a parameter that defines which file descriptors to
accept.  But we could also accept all file descriptors and filter out the bad
ones later like in the untested patch below.  Either approach will get us
there; just pick one ...

Thanks,
Andreas

diff --git a/fs/xattr.c b/fs/xattr.c
index d58979115200..8e4495585fad 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -845,7 +845,8 @@ ssize_t filename_getxattr(int dfd, struct filename *filename,
 
 static ssize_t path_getxattrat(int dfd, const char __user *pathname,
 			       unsigned int at_flags, const char __user *name,
-			       void __user *value, size_t size)
+			       void __user *value, size_t size,
+			       unsigned int reject_flags)
 {
 	struct xattr_name kname;
 	struct kernel_xattr_ctx ctx = {
@@ -865,10 +866,13 @@ static ssize_t path_getxattrat(int dfd, const char __user *pathname,
 
 	CLASS(filename_maybe_null, filename)(pathname, at_flags);
 	if (!filename && dfd >= 0) {
-		CLASS(fd, f)(dfd);
+		CLASS(fd_raw, f)(dfd);
 		if (fd_empty(f))
 			return -EBADF;
-		return file_getxattr(fd_file(f), &ctx);
+		struct file *file = fd_file(f);
+		if (file->f_flags & reject_flags)
+			return -EBADF;
+		return file_getxattr(file, &ctx);
 	} else {
 		int lookup_flags = 0;
 		if (!(at_flags & AT_SYMLINK_NOFOLLOW))
@@ -899,26 +903,27 @@ SYSCALL_DEFINE6(getxattrat, int, dfd, const char __user *, pathname, unsigned in
 		return -EINVAL;
 
 	return path_getxattrat(dfd, pathname, at_flags, name,
-			       u64_to_user_ptr(args.value), args.size);
+			       u64_to_user_ptr(args.value), args.size, 0);
 }
 
 SYSCALL_DEFINE4(getxattr, const char __user *, pathname,
 		const char __user *, name, void __user *, value, size_t, size)
 {
-	return path_getxattrat(AT_FDCWD, pathname, 0, name, value, size);
+	return path_getxattrat(AT_FDCWD, pathname, 0, name, value, size, 0);
 }
 
 SYSCALL_DEFINE4(lgetxattr, const char __user *, pathname,
 		const char __user *, name, void __user *, value, size_t, size)
 {
 	return path_getxattrat(AT_FDCWD, pathname, AT_SYMLINK_NOFOLLOW, name,
-			       value, size);
+			       value, size, 0);
 }
 
 SYSCALL_DEFINE4(fgetxattr, int, fd, const char __user *, name,
 		void __user *, value, size_t, size)
 {
-	return path_getxattrat(fd, NULL, AT_EMPTY_PATH, name, value, size);
+	return path_getxattrat(fd, NULL, AT_EMPTY_PATH, name, value, size,
+			       O_PATH);
 }
 
 /*

