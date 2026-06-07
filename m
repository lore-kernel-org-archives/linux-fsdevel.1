Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3C52FC037
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Jun 2026 16:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780850510; cv=none; b=EvvpdMUu2URBLh/yON+forOPxSsVj3uLbrmuLKZc3An71smimGHWUOwRT/Wrwqb6k/X+tZzvv9KQwhh2+6q2GKvTTk1nvl7ZK6R2gG4IfSGy5XMIUuTj+burzQTSM/04yjGV7qWHIOqFd0WaE3BTc1cZapLFzMW3aMBZWmhypho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780850510; c=relaxed/simple;
	bh=V8VprHURiZqMK5fxpaxYrYXAFvMmkMG1d5S2TFfALe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T5rr7COpdUcpstxLsN8fUaBY9ANmGJv1Jn7YAAWkZadSPtkwkMeR3ppQVqqsQsiNJZCn1YenPvYJxe1PwxSbmOhwSkiuqcWBjsPZwIO7oFWufe+f3mzrxG7X3IEydWUjZZTQVLkBjvsO1cNF6fE+9Y6E/v9dLx6I84mehfh2ahk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ny3YfeaW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ny3YfeaW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780850508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vzP3l+Xeyr/4MmsvGddbD+H02kE+760dkrPs6TsfooI=;
	b=Ny3YfeaWIrTkIqNh9gKLLiPf2lPEMvQmd2EUyN5rL+YdKgV5UtTXp/u6qFQyUanpU7fHM7
	nRyQq1AGv22athhvJnX1EUaDPoyAEu66Ps0nADsjRSAKw0YcGwK7M4N5f+JcTkXZ1XipgU
	1qnklxSJhIsEbIgpqN9BOajQHAWTeEw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471-7m91wzxzOAKJHLGuPLiHDQ-1; Sun,
 07 Jun 2026 12:41:45 -0400
X-MC-Unique: 7m91wzxzOAKJHLGuPLiHDQ-1
X-Mimecast-MFC-AGG-ID: 7m91wzxzOAKJHLGuPLiHDQ_1780850503
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ABA44195608C;
	Sun,  7 Jun 2026 16:41:43 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.30])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 68B0030001BE;
	Sun,  7 Jun 2026 16:41:41 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 2/3] xattrat: accept empty O_PATH file descriptors
Date: Sun,  7 Jun 2026 18:41:35 +0200
Message-ID: <20260607164136.2948550-2-agruenba@redhat.com>
In-Reply-To: <20260607164136.2948550-1-agruenba@redhat.com>
References: <20260607164136.2948550-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Right now, the setxattrat(), getxattrat(), listxattrat(), and removexattrat()
system calls fail with -EBADF when dfd is an O_PATH file descriptor, pathname
is an empty string or NULL, and the AT_EMPTY_PATH flag in at_flags is set.
(Regular non-O_PATH file descriptors are accepted.)  This is inconsistent with
the behavior of system calls like fstatat() and fchmodat() which do accept
those file descriptors.

The same operations can also be carried out indirectly by using
"/proc/self/fd/<dfd>" as the pathname, but that is only more cumbersome, and
for no good reason.  Fix that by changing the xattrat() system calls to accept
these file descriptors directly.

We stick with the existing practice of leaving the behavior of the fsetxattr(),
fgetxattr(), flistxattr(), and fremovexattr() system calls unchanged: those
will still reject O_PATH file descriptors.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/xattr.c | 56 +++++++++++++++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 09ecbaaa1660..34fa5a6139c4 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -692,7 +692,8 @@ int filename_setxattr(int dfd, struct filename *filename,
 
 static int path_setxattrat(int dfd, const char __user *pathname,
 			   unsigned int at_flags, const char __user *name,
-			   const void __user *value, size_t size, int flags)
+			   const void __user *value, size_t size, int flags,
+			   fmode_t mask)
 {
 	struct xattr_name kname;
 	struct kernel_xattr_ctx ctx = {
@@ -717,7 +718,7 @@ static int path_setxattrat(int dfd, const char __user *pathname,
 
 	CLASS(filename_maybe_null, filename)(pathname, at_flags);
 	if (!filename && dfd >= 0) {
-		CLASS(fd, f)(dfd);
+		CLASS(fd_except, f)(dfd, mask);
 		if (fd_empty(f))
 			error = -EBADF;
 		else
@@ -750,14 +751,15 @@ SYSCALL_DEFINE6(setxattrat, int, dfd, const char __user *, pathname, unsigned in
 
 	return path_setxattrat(dfd, pathname, at_flags, name,
 			       u64_to_user_ptr(args.value), args.size,
-			       args.flags);
+			       args.flags, 0);
 }
 
 SYSCALL_DEFINE5(setxattr, const char __user *, pathname,
 		const char __user *, name, const void __user *, value,
 		size_t, size, int, flags)
 {
-	return path_setxattrat(AT_FDCWD, pathname, 0, name, value, size, flags);
+	return path_setxattrat(AT_FDCWD, pathname, 0, name, value, size, flags,
+			       FMODE_PATH);
 }
 
 SYSCALL_DEFINE5(lsetxattr, const char __user *, pathname,
@@ -765,14 +767,14 @@ SYSCALL_DEFINE5(lsetxattr, const char __user *, pathname,
 		size_t, size, int, flags)
 {
 	return path_setxattrat(AT_FDCWD, pathname, AT_SYMLINK_NOFOLLOW, name,
-			       value, size, flags);
+			       value, size, flags, FMODE_PATH);
 }
 
 SYSCALL_DEFINE5(fsetxattr, int, fd, const char __user *, name,
 		const void __user *,value, size_t, size, int, flags)
 {
 	return path_setxattrat(fd, NULL, AT_EMPTY_PATH, name,
-			       value, size, flags);
+			       value, size, flags, FMODE_PATH);
 }
 
 /*
@@ -837,7 +839,7 @@ ssize_t filename_getxattr(int dfd, struct filename *filename,
 
 static ssize_t path_getxattrat(int dfd, const char __user *pathname,
 			       unsigned int at_flags, const char __user *name,
-			       void __user *value, size_t size)
+			       void __user *value, size_t size, fmode_t mask)
 {
 	struct xattr_name kname;
 	struct kernel_xattr_ctx ctx = {
@@ -857,7 +859,7 @@ static ssize_t path_getxattrat(int dfd, const char __user *pathname,
 
 	CLASS(filename_maybe_null, filename)(pathname, at_flags);
 	if (!filename && dfd >= 0) {
-		CLASS(fd, f)(dfd);
+		CLASS(fd_except, f)(dfd, mask);
 		if (fd_empty(f))
 			return -EBADF;
 		return file_getxattr(fd_file(f), &ctx);
@@ -891,26 +893,28 @@ SYSCALL_DEFINE6(getxattrat, int, dfd, const char __user *, pathname, unsigned in
 		return -EINVAL;
 
 	return path_getxattrat(dfd, pathname, at_flags, name,
-			       u64_to_user_ptr(args.value), args.size);
+			       u64_to_user_ptr(args.value), args.size, 0);
 }
 
 SYSCALL_DEFINE4(getxattr, const char __user *, pathname,
 		const char __user *, name, void __user *, value, size_t, size)
 {
-	return path_getxattrat(AT_FDCWD, pathname, 0, name, value, size);
+	return path_getxattrat(AT_FDCWD, pathname, 0, name, value, size,
+			       FMODE_PATH);
 }
 
 SYSCALL_DEFINE4(lgetxattr, const char __user *, pathname,
 		const char __user *, name, void __user *, value, size_t, size)
 {
 	return path_getxattrat(AT_FDCWD, pathname, AT_SYMLINK_NOFOLLOW, name,
-			       value, size);
+			       value, size, FMODE_PATH);
 }
 
 SYSCALL_DEFINE4(fgetxattr, int, fd, const char __user *, name,
 		void __user *, value, size_t, size)
 {
-	return path_getxattrat(fd, NULL, AT_EMPTY_PATH, name, value, size);
+	return path_getxattrat(fd, NULL, AT_EMPTY_PATH, name, value, size,
+			       FMODE_PATH);
 }
 
 /*
@@ -974,7 +978,7 @@ ssize_t filename_listxattr(int dfd, struct filename *filename,
 
 static ssize_t path_listxattrat(int dfd, const char __user *pathname,
 				unsigned int at_flags, char __user *list,
-				size_t size)
+				size_t size, fmode_t mask)
 {
 	int lookup_flags;
 
@@ -983,7 +987,7 @@ static ssize_t path_listxattrat(int dfd, const char __user *pathname,
 
 	CLASS(filename_maybe_null, filename)(pathname, at_flags);
 	if (!filename) {
-		CLASS(fd, f)(dfd);
+		CLASS(fd_except, f)(dfd, mask);
 		if (fd_empty(f))
 			return -EBADF;
 		return file_listxattr(fd_file(f), list, size);
@@ -997,24 +1001,26 @@ SYSCALL_DEFINE5(listxattrat, int, dfd, const char __user *, pathname,
 		unsigned int, at_flags,
 		char __user *, list, size_t, size)
 {
-	return path_listxattrat(dfd, pathname, at_flags, list, size);
+	return path_listxattrat(dfd, pathname, at_flags, list, size, 0);
 }
 
 SYSCALL_DEFINE3(listxattr, const char __user *, pathname, char __user *, list,
 		size_t, size)
 {
-	return path_listxattrat(AT_FDCWD, pathname, 0, list, size);
+	return path_listxattrat(AT_FDCWD, pathname, 0, list, size, FMODE_PATH);
 }
 
 SYSCALL_DEFINE3(llistxattr, const char __user *, pathname, char __user *, list,
 		size_t, size)
 {
-	return path_listxattrat(AT_FDCWD, pathname, AT_SYMLINK_NOFOLLOW, list, size);
+	return path_listxattrat(AT_FDCWD, pathname, AT_SYMLINK_NOFOLLOW, list,
+				size, FMODE_PATH);
 }
 
 SYSCALL_DEFINE3(flistxattr, int, fd, char __user *, list, size_t, size)
 {
-	return path_listxattrat(fd, NULL, AT_EMPTY_PATH, list, size);
+	return path_listxattrat(fd, NULL, AT_EMPTY_PATH, list, size,
+				FMODE_PATH);
 }
 
 /*
@@ -1065,7 +1071,8 @@ static int filename_removexattr(int dfd, struct filename *filename,
 }
 
 static int path_removexattrat(int dfd, const char __user *pathname,
-			      unsigned int at_flags, const char __user *name)
+			      unsigned int at_flags, const char __user *name,
+			      fmode_t mask)
 {
 	struct xattr_name kname;
 	unsigned int lookup_flags;
@@ -1080,7 +1087,7 @@ static int path_removexattrat(int dfd, const char __user *pathname,
 
 	CLASS(filename_maybe_null, filename)(pathname, at_flags);
 	if (!filename) {
-		CLASS(fd, f)(dfd);
+		CLASS(fd_except, f)(dfd, mask);
 		if (fd_empty(f))
 			return -EBADF;
 		return file_removexattr(fd_file(f), &kname);
@@ -1092,24 +1099,25 @@ static int path_removexattrat(int dfd, const char __user *pathname,
 SYSCALL_DEFINE4(removexattrat, int, dfd, const char __user *, pathname,
 		unsigned int, at_flags, const char __user *, name)
 {
-	return path_removexattrat(dfd, pathname, at_flags, name);
+	return path_removexattrat(dfd, pathname, at_flags, name, 0);
 }
 
 SYSCALL_DEFINE2(removexattr, const char __user *, pathname,
 		const char __user *, name)
 {
-	return path_removexattrat(AT_FDCWD, pathname, 0, name);
+	return path_removexattrat(AT_FDCWD, pathname, 0, name, FMODE_PATH);
 }
 
 SYSCALL_DEFINE2(lremovexattr, const char __user *, pathname,
 		const char __user *, name)
 {
-	return path_removexattrat(AT_FDCWD, pathname, AT_SYMLINK_NOFOLLOW, name);
+	return path_removexattrat(AT_FDCWD, pathname, AT_SYMLINK_NOFOLLOW, name,
+				  FMODE_PATH);
 }
 
 SYSCALL_DEFINE2(fremovexattr, int, fd, const char __user *, name)
 {
-	return path_removexattrat(fd, NULL, AT_EMPTY_PATH, name);
+	return path_removexattrat(fd, NULL, AT_EMPTY_PATH, name, FMODE_PATH);
 }
 
 int xattr_list_one(char **buffer, ssize_t *remaining_size, const char *name)
-- 
2.54.0

