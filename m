Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81401A5BAE
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 19:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782933420; cv=none; b=MmOJwRmccANxEEMv1K/UdeEluwMJJrCis7X5mQz7lxMHF4z8aXXqs2dJNgnhAaVo44jGW6bl98BC1riCHAkK+/PeDGR4iOalL3SK0Ng1i8udb9KH77LmWWjDMN/AgJZR+FOZctYRYopP/nzqU72n4PBfdU2f0YB7WNu2vedTYm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782933420; c=relaxed/simple;
	bh=ZZYQB1ywWdaj6nerK4frFgidpSnEvrwM3J7Wzj7z7+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RUu/72657xGJnq/+WfIuHC/que9olh/e7JxFv6fJ0dheinW22/7ZrCGQ/Z7Eitac9cq/8V2Hs15HmErDG4VAkO5Rgk9XuagsnS49BdFMwUCQTlsUE15lytZi7f2oiA7FkGSWYL6dWRUtCF5MuQcX0KSB92zDNLk0TLQ/LcNY7pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H3fPN8Kb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H3fPN8Kb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782933417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pLZC12D+E8xxQ7rcSIFsFe8bUzAIAxTb4/5hf/WE3DQ=;
	b=H3fPN8KbRVGFsin+RjJaPxrJBop+kwEDleR1x0S47gnWUkMiarsCWRsEgNPWSGoftwQzRf
	n+yqje4PHwaekpPGpCaoghGFTMwt7Y3dYir9Xg0WD57jtJaDHZ19FkL5XxWtc97JFPrVmr
	WzWocv3MUVBO24CUvpmJENzaGrV5fC4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-chM19dmSMfCN1M4NdP2ZuA-1; Wed,
 01 Jul 2026 15:16:54 -0400
X-MC-Unique: chM19dmSMfCN1M4NdP2ZuA-1
X-Mimecast-MFC-AGG-ID: chM19dmSMfCN1M4NdP2ZuA_1782933413
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 350FE185D683;
	Wed,  1 Jul 2026 19:16:53 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.49.17])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 009FA30A8;
	Wed,  1 Jul 2026 19:16:50 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] xattrat: accept empty O_PATH file descriptors
Date: Wed,  1 Jul 2026 21:16:48 +0200
Message-ID: <20260701191649.175871-1-agruenba@redhat.com>
In-Reply-To: <20260701-beinfreiheit-export-enorm-1f81a94f2454@brauner>
References: <20260701-beinfreiheit-export-enorm-1f81a94f2454@brauner> <20260630-wunsch-wichtel-ansporn-f4754acc8bcf@brauner> <20260607164136.2948550-1-agruenba@redhat.com> <20260607164136.2948550-2-agruenba@redhat.com> <20260630120641.133521-1-agruenba@redhat.com> <20260630-ochsen-neutralisieren-langzeitfolgen-f685027b7f3c@brauner> <CAHc6FU4E8t1wXg4MFhi4W=+fBMsrHXQeXQ1B+W3ELiLxRdErJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On Wed, Jul 1, 2026 at 10:33 AM Christian Brauner <brauner@kernel.org> wrote:
> On 2026-06-30 15:05:03+02:00, Andreas Gruenbacher wrote:
> > On Tue, Jun 30, 2026 at 2:33 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > > On 2026-06-30 14:06 +0200, Andreas Gruenbacher wrote:
> > >
> > > I'm very confused why the f*at() variants are supposed to accept O_PATH
> > > but the f*() aren't? What's the point?
> >
> > Oh, I see. To keep things consistent with fchmod() and fchown() vs.
> > fchmodat() and fchownat(): the former two also don't accept O_PATH
> > file descriptors, while the latter two do.
>
> Right, I saw that and wondered about that there too. I guess it makes
> some sense in that nothing about O_PATH at this point is consistent
> anymore. Will be fun to document what exactly works and doesn't work on
> the manpage...
>
> So then I think we should refactor fs/xattr.c similar to how we did it
> for fch*() and fch*at(). So that f*xattr() call CLASS(fd, ...) and
> f*xattrat() call CLASS(fd_raw, ...).
>
> This should also make it a lot easier to follow, hopefully.

That works for flistxattr(), but it creates a mess for fgetxattr() and
fsetxattr() due to the argument passing; see below.

That argument passing happenss at that level because the lower-level functions
filename_{get,set}xattr() and file_{get,set}xattr() are also used by io_uring,
which has slightly different argument passing semantics.

The attribute name copying in path_removexattr() could be pushed down into
removexattr() because io_uring doesn't use that, but that would make things
less orthogonal.

So that's why I've proposed to change path_{get,set,list,remove}xattr() to
either handle only non-O_PATH or all file descriptors depending on the caller.

Thanks,
Andreas


diff --git a/fs/xattr.c b/fs/xattr.c
index d58979115200..a111813be920 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -725,7 +725,7 @@ static int path_setxattrat(int dfd, const char __user *pathname,
 
 	CLASS(filename_maybe_null, filename)(pathname, at_flags);
 	if (!filename && dfd >= 0) {
-		CLASS(fd, f)(dfd);
+		CLASS(fd_raw, f)(dfd);
 		if (fd_empty(f))
 			error = -EBADF;
 		else
@@ -779,8 +779,30 @@ SYSCALL_DEFINE5(lsetxattr, const char __user *, pathname,
 SYSCALL_DEFINE5(fsetxattr, int, fd, const char __user *, name,
 		const void __user *,value, size_t, size, int, flags)
 {
-	return path_setxattrat(fd, NULL, AT_EMPTY_PATH, name,
-			       value, size, flags);
+	struct xattr_name kname;
+	struct kernel_xattr_ctx ctx = {
+		.cvalue	= value,
+		.kvalue	= NULL,
+		.size	= size,
+		.kname	= &kname,
+		.flags	= flags,
+	};
+	int error;
+
+	error = setxattr_copy(name, &ctx);
+	if (error)
+		return error;
+
+	CLASS(fd, f)(fd);
+	error = -EBADF;
+	if (fd_empty(f))
+		goto out;
+
+	error = file_setxattr(fd_file(f), &ctx);
+
+out:
+	kvfree(ctx.kvalue);
+	return error;
 }
 
 /*
@@ -865,7 +887,7 @@ static ssize_t path_getxattrat(int dfd, const char __user *pathname,
 
 	CLASS(filename_maybe_null, filename)(pathname, at_flags);
 	if (!filename && dfd >= 0) {
-		CLASS(fd, f)(dfd);
+		CLASS(fd_raw, f)(dfd);
 		if (fd_empty(f))
 			return -EBADF;
 		return file_getxattr(fd_file(f), &ctx);
@@ -918,7 +940,24 @@ SYSCALL_DEFINE4(lgetxattr, const char __user *, pathname,
 SYSCALL_DEFINE4(fgetxattr, int, fd, const char __user *, name,
 		void __user *, value, size_t, size)
 {
-	return path_getxattrat(fd, NULL, AT_EMPTY_PATH, name, value, size);
+	struct xattr_name kname;
+	struct kernel_xattr_ctx ctx = {
+		.value    = value,
+		.size     = size,
+		.kname    = &kname,
+		.flags    = 0,
+	};
+	int error;
+
+	error = import_xattr_name(&kname, name);
+	if (error)
+		return error;
+
+	CLASS(fd, f)(fd);
+	if (fd_empty(f))
+		return -EBADF;
+
+	return file_getxattr(fd_file(f), &ctx);
 }
 
 /*
@@ -991,7 +1030,7 @@ static ssize_t path_listxattrat(int dfd, const char __user *pathname,
 
 	CLASS(filename_maybe_null, filename)(pathname, at_flags);
 	if (!filename) {
-		CLASS(fd, f)(dfd);
+		CLASS(fd_raw, f)(dfd);
 		if (fd_empty(f))
 			return -EBADF;
 		return file_listxattr(fd_file(f), list, size);
@@ -1022,7 +1061,11 @@ SYSCALL_DEFINE3(llistxattr, const char __user *, pathname, char __user *, list,
 
 SYSCALL_DEFINE3(flistxattr, int, fd, char __user *, list, size_t, size)
 {
-	return path_listxattrat(fd, NULL, AT_EMPTY_PATH, list, size);
+	CLASS(fd, f)(fd);
+	if (fd_empty(f))
+		return -EBADF;
+
+	return file_listxattr(fd_file(f), list, size);
 }
 
 /*
@@ -1088,7 +1131,7 @@ static int path_removexattrat(int dfd, const char __user *pathname,
 
 	CLASS(filename_maybe_null, filename)(pathname, at_flags);
 	if (!filename) {
-		CLASS(fd, f)(dfd);
+		CLASS(fd_raw, f)(dfd);
 		if (fd_empty(f))
 			return -EBADF;
 		return file_removexattr(fd_file(f), &kname);
@@ -1117,7 +1160,18 @@ SYSCALL_DEFINE2(lremovexattr, const char __user *, pathname,
 
 SYSCALL_DEFINE2(fremovexattr, int, fd, const char __user *, name)
 {
-	return path_removexattrat(fd, NULL, AT_EMPTY_PATH, name);
+	struct xattr_name kname;
+	int error;
+
+	error = import_xattr_name(&kname, name);
+	if (error)
+		return error;
+
+	CLASS(fd, f)(fd);
+	if (fd_empty(f))
+		return -EBADF;
+
+	return file_removexattr(fd_file(f), &kname);
 }
 
 int xattr_list_one(char **buffer, ssize_t *remaining_size, const char *name)

