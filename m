Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CAF306D26
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 15:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784733033; cv=none; b=UuE89jT6HFwnA1dGu0ryT9JKpuWLoxY6i9dfkcMsSw5j3KPLFuQFMjQz0DOmAxsp3OneEOqw07nvfWYO0wt8Zq2jbH86FRP1csu9lp+piY2y0CPz4HbHM8L0NJpJI4UKUIM+WfuVTfHPUJ7p4M9C4UNpbkgHWyl8SoMkUKtVDpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784733033; c=relaxed/simple;
	bh=6WXGrHo0dikDHmWykT6z2NqkSZeKXK1+HQCurgUY7s0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=heEirRSjRGjK6p491NnsuQWBqxhugQsLSnpX//MCuBXBPsrtRnDMeanH32YfhbocbegYE6z5qz/VbfrMfHrFAXNQ/ahHB4lvvlmtYoswU22KZ2WS5U1KJ9pkr2Lvw0DFyZ5yRiYOQaYyIAF6mqROvabiDI1s0EGbP9Zks51U8dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QFEDoAWZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QFEDoAWZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784733030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1yt8FUDEBJWvkvHAGOiwKVr2QpJfzSKKOP0l5IdtRVA=;
	b=QFEDoAWZ8jEGMZ7JdyAU4TvZpbSKq0xXI7Pla0yqyCsRlCb4m4oi5DTCfKsLbDm1qTwhHy
	s4ySz32inXVEmLmQB6MfhsMTJm5tu1k0wfBzLjbvfgP+nlmqCnFPOh93yu/1muI4JkODR2
	0P5GrEaE2XrEAV2NTFWYmOAw79BWGRM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-3DHYQJt-O8yuqXdyzkU7JA-1; Wed,
 22 Jul 2026 11:10:29 -0400
X-MC-Unique: 3DHYQJt-O8yuqXdyzkU7JA-1
X-Mimecast-MFC-AGG-ID: 3DHYQJt-O8yuqXdyzkU7JA_1784733028
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 187401805F01;
	Wed, 22 Jul 2026 15:10:28 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.48.147])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 72BBA1956042;
	Wed, 22 Jul 2026 15:10:25 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] xattrat: accept empty O_PATH file descriptors
Date: Wed, 22 Jul 2026 17:10:22 +0200
Message-ID: <20260722151023.1308069-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Christian,

here's an updated patch for making the *xattrat() system calls accept
O_PATH file descriptors.

Compared to the previous version (see the discussion at [*]), this
version adds a fd_maybe_raw cleanup class that uses either fdget() or
fdget_raw() depending on which kinds of file descriptors are acceptable.
That's still a but ugly, but all the alternatives I could come up with
are much worse.

[*] https://lore.kernel.org/linux-fsdevel/20260701191649.175871-1-agruenba@redhat.com/

Thanks,
Andreas

--

Currently, the setxattrat(), getxattrat(), listxattrat(), and removexattrat()
system calls fail with -EBADF when dfd is an O_PATH file descriptor, pathname
is an empty string or NULL, and the AT_EMPTY_PATH flag is set in at_flags.
This is inconsistent with the behavior of other system calls like fstatat() and
fchmodat() which do accept O_PATH file descriptors, so change the *xattrat()
system calls to accept O_PATH file descriptors as well.

In environments where /proc is available, operations on O_PATH file descriptors
can also be carried out by using "/proc/self/fd/<dfd>" as the pathname, so from
a security standpoint, this is a relatively insignificant change.

We stick with the existing practice of leaving the behavior of the fsetxattr(),
fgetxattr(), flistxattr(), and fremovexattr() system calls unchanged: those
will still reject O_PATH file descriptors.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/xattr.c           | 55 +++++++++++++++++++++++++-------------------
 include/linux/file.h |  2 ++
 2 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index d58979115200..1db6596a2ec1 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -700,7 +700,8 @@ int filename_setxattr(int dfd, struct filename *filename,
 
 static int path_setxattrat(int dfd, const char __user *pathname,
 			   unsigned int at_flags, const char __user *name,
-			   const void __user *value, size_t size, int flags)
+			   const void __user *value, size_t size, int flags,
+			   bool raw)
 {
 	struct xattr_name kname;
 	struct kernel_xattr_ctx ctx = {
@@ -725,7 +726,7 @@ static int path_setxattrat(int dfd, const char __user *pathname,
 
 	CLASS(filename_maybe_null, filename)(pathname, at_flags);
 	if (!filename && dfd >= 0) {
-		CLASS(fd, f)(dfd);
+		CLASS(fd_maybe_raw, f)(dfd, raw);
 		if (fd_empty(f))
 			error = -EBADF;
 		else
@@ -758,14 +759,15 @@ SYSCALL_DEFINE6(setxattrat, int, dfd, const char __user *, pathname, unsigned in
 
 	return path_setxattrat(dfd, pathname, at_flags, name,
 			       u64_to_user_ptr(args.value), args.size,
-			       args.flags);
+			       args.flags, true);
 }
 
 SYSCALL_DEFINE5(setxattr, const char __user *, pathname,
 		const char __user *, name, const void __user *, value,
 		size_t, size, int, flags)
 {
-	return path_setxattrat(AT_FDCWD, pathname, 0, name, value, size, flags);
+	return path_setxattrat(AT_FDCWD, pathname, 0, name, value, size, flags,
+			       false);
 }
 
 SYSCALL_DEFINE5(lsetxattr, const char __user *, pathname,
@@ -773,14 +775,14 @@ SYSCALL_DEFINE5(lsetxattr, const char __user *, pathname,
 		size_t, size, int, flags)
 {
 	return path_setxattrat(AT_FDCWD, pathname, AT_SYMLINK_NOFOLLOW, name,
-			       value, size, flags);
+			       value, size, flags, false);
 }
 
 SYSCALL_DEFINE5(fsetxattr, int, fd, const char __user *, name,
 		const void __user *,value, size_t, size, int, flags)
 {
 	return path_setxattrat(fd, NULL, AT_EMPTY_PATH, name,
-			       value, size, flags);
+			       value, size, flags, false);
 }
 
 /*
@@ -845,7 +847,7 @@ ssize_t filename_getxattr(int dfd, struct filename *filename,
 
 static ssize_t path_getxattrat(int dfd, const char __user *pathname,
 			       unsigned int at_flags, const char __user *name,
-			       void __user *value, size_t size)
+			       void __user *value, size_t size, bool raw)
 {
 	struct xattr_name kname;
 	struct kernel_xattr_ctx ctx = {
@@ -865,7 +867,7 @@ static ssize_t path_getxattrat(int dfd, const char __user *pathname,
 
 	CLASS(filename_maybe_null, filename)(pathname, at_flags);
 	if (!filename && dfd >= 0) {
-		CLASS(fd, f)(dfd);
+		CLASS(fd_maybe_raw, f)(dfd, raw);
 		if (fd_empty(f))
 			return -EBADF;
 		return file_getxattr(fd_file(f), &ctx);
@@ -899,26 +901,28 @@ SYSCALL_DEFINE6(getxattrat, int, dfd, const char __user *, pathname, unsigned in
 		return -EINVAL;
 
 	return path_getxattrat(dfd, pathname, at_flags, name,
-			       u64_to_user_ptr(args.value), args.size);
+			       u64_to_user_ptr(args.value), args.size, true);
 }
 
 SYSCALL_DEFINE4(getxattr, const char __user *, pathname,
 		const char __user *, name, void __user *, value, size_t, size)
 {
-	return path_getxattrat(AT_FDCWD, pathname, 0, name, value, size);
+	return path_getxattrat(AT_FDCWD, pathname, 0, name, value, size,
+			       false);
 }
 
 SYSCALL_DEFINE4(lgetxattr, const char __user *, pathname,
 		const char __user *, name, void __user *, value, size_t, size)
 {
 	return path_getxattrat(AT_FDCWD, pathname, AT_SYMLINK_NOFOLLOW, name,
-			       value, size);
+			       value, size, false);
 }
 
 SYSCALL_DEFINE4(fgetxattr, int, fd, const char __user *, name,
 		void __user *, value, size_t, size)
 {
-	return path_getxattrat(fd, NULL, AT_EMPTY_PATH, name, value, size);
+	return path_getxattrat(fd, NULL, AT_EMPTY_PATH, name, value, size,
+			       false);
 }
 
 /*
@@ -982,7 +986,7 @@ ssize_t filename_listxattr(int dfd, struct filename *filename,
 
 static ssize_t path_listxattrat(int dfd, const char __user *pathname,
 				unsigned int at_flags, char __user *list,
-				size_t size)
+				size_t size, bool raw)
 {
 	int lookup_flags;
 
@@ -991,7 +995,7 @@ static ssize_t path_listxattrat(int dfd, const char __user *pathname,
 
 	CLASS(filename_maybe_null, filename)(pathname, at_flags);
 	if (!filename) {
-		CLASS(fd, f)(dfd);
+		CLASS(fd_maybe_raw, f)(dfd, raw);
 		if (fd_empty(f))
 			return -EBADF;
 		return file_listxattr(fd_file(f), list, size);
@@ -1005,24 +1009,25 @@ SYSCALL_DEFINE5(listxattrat, int, dfd, const char __user *, pathname,
 		unsigned int, at_flags,
 		char __user *, list, size_t, size)
 {
-	return path_listxattrat(dfd, pathname, at_flags, list, size);
+	return path_listxattrat(dfd, pathname, at_flags, list, size, true);
 }
 
 SYSCALL_DEFINE3(listxattr, const char __user *, pathname, char __user *, list,
 		size_t, size)
 {
-	return path_listxattrat(AT_FDCWD, pathname, 0, list, size);
+	return path_listxattrat(AT_FDCWD, pathname, 0, list, size, false);
 }
 
 SYSCALL_DEFINE3(llistxattr, const char __user *, pathname, char __user *, list,
 		size_t, size)
 {
-	return path_listxattrat(AT_FDCWD, pathname, AT_SYMLINK_NOFOLLOW, list, size);
+	return path_listxattrat(AT_FDCWD, pathname, AT_SYMLINK_NOFOLLOW, list,
+				size, false);
 }
 
 SYSCALL_DEFINE3(flistxattr, int, fd, char __user *, list, size_t, size)
 {
-	return path_listxattrat(fd, NULL, AT_EMPTY_PATH, list, size);
+	return path_listxattrat(fd, NULL, AT_EMPTY_PATH, list, size, false);
 }
 
 /*
@@ -1073,7 +1078,8 @@ static int filename_removexattr(int dfd, struct filename *filename,
 }
 
 static int path_removexattrat(int dfd, const char __user *pathname,
-			      unsigned int at_flags, const char __user *name)
+			      unsigned int at_flags, const char __user *name,
+			      bool raw)
 {
 	struct xattr_name kname;
 	unsigned int lookup_flags;
@@ -1088,7 +1094,7 @@ static int path_removexattrat(int dfd, const char __user *pathname,
 
 	CLASS(filename_maybe_null, filename)(pathname, at_flags);
 	if (!filename) {
-		CLASS(fd, f)(dfd);
+		CLASS(fd_maybe_raw, f)(dfd, raw);
 		if (fd_empty(f))
 			return -EBADF;
 		return file_removexattr(fd_file(f), &kname);
@@ -1100,24 +1106,25 @@ static int path_removexattrat(int dfd, const char __user *pathname,
 SYSCALL_DEFINE4(removexattrat, int, dfd, const char __user *, pathname,
 		unsigned int, at_flags, const char __user *, name)
 {
-	return path_removexattrat(dfd, pathname, at_flags, name);
+	return path_removexattrat(dfd, pathname, at_flags, name, true);
 }
 
 SYSCALL_DEFINE2(removexattr, const char __user *, pathname,
 		const char __user *, name)
 {
-	return path_removexattrat(AT_FDCWD, pathname, 0, name);
+	return path_removexattrat(AT_FDCWD, pathname, 0, name, false);
 }
 
 SYSCALL_DEFINE2(lremovexattr, const char __user *, pathname,
 		const char __user *, name)
 {
-	return path_removexattrat(AT_FDCWD, pathname, AT_SYMLINK_NOFOLLOW, name);
+	return path_removexattrat(AT_FDCWD, pathname, AT_SYMLINK_NOFOLLOW, name,
+				  false);
 }
 
 SYSCALL_DEFINE2(fremovexattr, int, fd, const char __user *, name)
 {
-	return path_removexattrat(fd, NULL, AT_EMPTY_PATH, name);
+	return path_removexattrat(fd, NULL, AT_EMPTY_PATH, name, false);
 }
 
 int xattr_list_one(char **buffer, ssize_t *remaining_size, const char *name)
diff --git a/include/linux/file.h b/include/linux/file.h
index 27484b444d31..2a1dc738981e 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -82,6 +82,8 @@ static inline void fdput_pos(struct fd f)
 
 DEFINE_CLASS(fd, struct fd, fdput(_T), fdget(fd), int fd)
 DEFINE_CLASS(fd_raw, struct fd, fdput(_T), fdget_raw(fd), int fd)
+DEFINE_CLASS(fd_maybe_raw, struct fd, fdput(_T),
+	     raw ? fdget_raw(fd) : fdget(fd), int fd, bool raw)
 DEFINE_CLASS(fd_pos, struct fd, fdput_pos(_T), fdget_pos(fd), int fd)
 
 extern int f_dupfd(unsigned int from, struct file *file, unsigned flags);
-- 
2.55.0

