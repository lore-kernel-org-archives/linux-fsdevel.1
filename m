Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188ED426D33;
	Thu, 30 Jul 2026 18:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785437349; cv=none; b=Xv/nJrNzsrgx5DWsHXW86qEhb+c5ArSBi+jylgpX2Jt0q/frdW27Rs0fHrR46UCk/fAnzKjp5wSv6N2tVd2Q902i7Q78LcAyk4myT8jUDfCQHuLpf8dJ5iDwVwn2X1VpitYdAeCXv7PhsrjGJm5+tXeMLLV4/+aX0XCjCT/Krrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785437349; c=relaxed/simple;
	bh=t3ZT140EEME6CAZGX1WOewbC9bU4iv2yEH/Gdet76kk=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=JU3zAlpsqrwKQ0TtJs3Yx1PnT//UirhZmuWocxQO32pEaNbHxH6RKhh8wh+lov+DLBlixNK596u8kKB62oMp3lnjaM2Y5UTwvsLbKmSz/94j+Bf0daJX3OGDxSbu1nWC7RodMAmQL1Q32jMjlVlUBUi7XWzRKx/Bt8ZprLEgFcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUjEBlmr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUjEBlmr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C121F000E9;
	Thu, 30 Jul 2026 18:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785437347;
	bh=NzmFEMDYiP5lMx6wborXQE8KEFG+stPAeMM7azGEa8s=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=AUjEBlmrCW/9XCbDfD+dwnJ83jIJZWQPb3UTlSWBfWW7AIuI7tK7tZJawDlq/TDN3
	 q9CYUdGSclC/5ee+fDW8L+IcUhmKGtJ7KLdKPJNy8BQ0eGy52pWz9WW0p7+iaDv5xI
	 +J5SgstrEj25j7y35lma1VfdPaPOxphDqFEhbGgp8GOa9ls9CNnjJnLwTc6aqqOq58
	 sqEMP+PO5EfGqvMcClkl3H54J/jRCAxbSi98FmEbuRqBuXTN63TtuTeQTTIJbiIfnp
	 qW4BgdmfATqlEM3MyUNFHbQK88w2SDl8h1O3qHTXlRHj5JervXA4EX/TfJJjUe2XMn
	 RjTBzXUlxs/Eg==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] xattrat: accept empty O_PATH file descriptors
From: Christian Brauner <brauner@kernel.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260722151023.1308069-1-agruenba@redhat.com>
References: <20260722151023.1308069-1-agruenba@redhat.com>
Date: Thu, 30 Jul 2026 20:49:03 +0200
Message-Id: <20260730-armband-reklamieren-heuchelei-6f67abb088de@brauner>
X-Mailer: b4 0.16-dev-3e0c3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9889; i=brauner@kernel.org;
 h=from:subject:message-id; bh=t3ZT140EEME6CAZGX1WOewbC9bU4iv2yEH/Gdet76kk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRlz1n0/TR7MsePqNaLwVpCubfXcJxpFYuKvuPBE7utf
 YHAyxj/jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIl4f2P4H34qvG9Ke/o1+z61
 HxmmSzQ07ikfY604UWxUFq+lcJnnHSPDU7eTPdHClw3WfTjQvvzSj/Zz1w3nMuW52lRxMj+cN6+
 cEwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-07-22 17:10 +0200, Andreas Gruenbacher wrote:
> Christian,
> 
> here's an updated patch for making the *xattrat() system calls accept
> O_PATH file descriptors.
> 
> Compared to the previous version (see the discussion at [*]), this
> version adds a fd_maybe_raw cleanup class that uses either fdget() or
> fdget_raw() depending on which kinds of file descriptors are acceptable.
> That's still a but ugly, but all the alternatives I could come up with
> are much worse.
> 
> [*] https://lore.kernel.org/linux-fsdevel/20260701191649.175871-1-agruenba@redhat.com/

Thank you. How do you feel about?

---
 fs/xattr.c | 100 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 64 insertions(+), 36 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index d58979115200..133bca3371ee 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -698,9 +698,10 @@ int filename_setxattr(int dfd, struct filename *filename,
 	return error;
 }
 
-static int path_setxattrat(int dfd, const char __user *pathname,
-			   unsigned int at_flags, const char __user *name,
-			   const void __user *value, size_t size, int flags)
+static int path_setxattrat(int dfd, struct file *dfd_file,
+			   const char __user *pathname, unsigned int at_flags,
+			   const char __user *name, const void __user *value,
+			   size_t size, int flags)
 {
 	struct xattr_name kname;
 	struct kernel_xattr_ctx ctx = {
@@ -725,11 +726,10 @@ static int path_setxattrat(int dfd, const char __user *pathname,
 
 	CLASS(filename_maybe_null, filename)(pathname, at_flags);
 	if (!filename && dfd >= 0) {
-		CLASS(fd, f)(dfd);
-		if (fd_empty(f))
+		if (!dfd_file)
 			error = -EBADF;
 		else
-			error = file_setxattr(fd_file(f), &ctx);
+			error = file_setxattr(dfd_file, &ctx);
 	} else {
 		error = filename_setxattr(dfd, filename, lookup_flags, &ctx);
 	}
@@ -756,7 +756,10 @@ SYSCALL_DEFINE6(setxattrat, int, dfd, const char __user *, pathname, unsigned in
 	if (error)
 		return error;
 
-	return path_setxattrat(dfd, pathname, at_flags, name,
+	/* setxattrat() accepts O_PATH file descriptors. */
+	CLASS(fd_raw, f)(dfd);
+
+	return path_setxattrat(dfd, fd_file(f), pathname, at_flags, name,
 			       u64_to_user_ptr(args.value), args.size,
 			       args.flags);
 }
@@ -765,21 +768,25 @@ SYSCALL_DEFINE5(setxattr, const char __user *, pathname,
 		const char __user *, name, const void __user *, value,
 		size_t, size, int, flags)
 {
-	return path_setxattrat(AT_FDCWD, pathname, 0, name, value, size, flags);
+	return path_setxattrat(AT_FDCWD, NULL, pathname, 0, name, value, size,
+			       flags);
 }
 
 SYSCALL_DEFINE5(lsetxattr, const char __user *, pathname,
 		const char __user *, name, const void __user *, value,
 		size_t, size, int, flags)
 {
-	return path_setxattrat(AT_FDCWD, pathname, AT_SYMLINK_NOFOLLOW, name,
-			       value, size, flags);
+	return path_setxattrat(AT_FDCWD, NULL, pathname, AT_SYMLINK_NOFOLLOW,
+			       name, value, size, flags);
 }
 
 SYSCALL_DEFINE5(fsetxattr, int, fd, const char __user *, name,
 		const void __user *,value, size_t, size, int, flags)
 {
-	return path_setxattrat(fd, NULL, AT_EMPTY_PATH, name,
+	/* fsetxattr() rejects O_PATH file descriptors. */
+	CLASS(fd, f)(fd);
+
+	return path_setxattrat(fd, fd_file(f), NULL, AT_EMPTY_PATH, name,
 			       value, size, flags);
 }
 
@@ -843,7 +850,8 @@ ssize_t filename_getxattr(int dfd, struct filename *filename,
 	return error;
 }
 
-static ssize_t path_getxattrat(int dfd, const char __user *pathname,
+static ssize_t path_getxattrat(int dfd, struct file *dfd_file,
+			       const char __user *pathname,
 			       unsigned int at_flags, const char __user *name,
 			       void __user *value, size_t size)
 {
@@ -865,10 +873,9 @@ static ssize_t path_getxattrat(int dfd, const char __user *pathname,
 
 	CLASS(filename_maybe_null, filename)(pathname, at_flags);
 	if (!filename && dfd >= 0) {
-		CLASS(fd, f)(dfd);
-		if (fd_empty(f))
+		if (!dfd_file)
 			return -EBADF;
-		return file_getxattr(fd_file(f), &ctx);
+		return file_getxattr(dfd_file, &ctx);
 	} else {
 		int lookup_flags = 0;
 		if (!(at_flags & AT_SYMLINK_NOFOLLOW))
@@ -898,27 +905,34 @@ SYSCALL_DEFINE6(getxattrat, int, dfd, const char __user *, pathname, unsigned in
 	if (args.flags != 0)
 		return -EINVAL;
 
-	return path_getxattrat(dfd, pathname, at_flags, name,
+	/* getxattrat() accepts O_PATH file descriptors. */
+	CLASS(fd_raw, f)(dfd);
+
+	return path_getxattrat(dfd, fd_file(f), pathname, at_flags, name,
 			       u64_to_user_ptr(args.value), args.size);
 }
 
 SYSCALL_DEFINE4(getxattr, const char __user *, pathname,
 		const char __user *, name, void __user *, value, size_t, size)
 {
-	return path_getxattrat(AT_FDCWD, pathname, 0, name, value, size);
+	return path_getxattrat(AT_FDCWD, NULL, pathname, 0, name, value, size);
 }
 
 SYSCALL_DEFINE4(lgetxattr, const char __user *, pathname,
 		const char __user *, name, void __user *, value, size_t, size)
 {
-	return path_getxattrat(AT_FDCWD, pathname, AT_SYMLINK_NOFOLLOW, name,
-			       value, size);
+	return path_getxattrat(AT_FDCWD, NULL, pathname, AT_SYMLINK_NOFOLLOW,
+			       name, value, size);
 }
 
 SYSCALL_DEFINE4(fgetxattr, int, fd, const char __user *, name,
 		void __user *, value, size_t, size)
 {
-	return path_getxattrat(fd, NULL, AT_EMPTY_PATH, name, value, size);
+	/* fgetxattr() rejects O_PATH file descriptors. */
+	CLASS(fd, f)(fd);
+
+	return path_getxattrat(fd, fd_file(f), NULL, AT_EMPTY_PATH, name, value,
+			       size);
 }
 
 /*
@@ -980,7 +994,8 @@ ssize_t filename_listxattr(int dfd, struct filename *filename,
 	return error;
 }
 
-static ssize_t path_listxattrat(int dfd, const char __user *pathname,
+static ssize_t path_listxattrat(int dfd, struct file *dfd_file,
+				const char __user *pathname,
 				unsigned int at_flags, char __user *list,
 				size_t size)
 {
@@ -991,10 +1006,9 @@ static ssize_t path_listxattrat(int dfd, const char __user *pathname,
 
 	CLASS(filename_maybe_null, filename)(pathname, at_flags);
 	if (!filename) {
-		CLASS(fd, f)(dfd);
-		if (fd_empty(f))
+		if (!dfd_file)
 			return -EBADF;
-		return file_listxattr(fd_file(f), list, size);
+		return file_listxattr(dfd_file, list, size);
 	}
 
 	lookup_flags = (at_flags & AT_SYMLINK_NOFOLLOW) ? 0 : LOOKUP_FOLLOW;
@@ -1005,24 +1019,31 @@ SYSCALL_DEFINE5(listxattrat, int, dfd, const char __user *, pathname,
 		unsigned int, at_flags,
 		char __user *, list, size_t, size)
 {
-	return path_listxattrat(dfd, pathname, at_flags, list, size);
+	/* listxattrat() accepts O_PATH file descriptors. */
+	CLASS(fd_raw, f)(dfd);
+
+	return path_listxattrat(dfd, fd_file(f), pathname, at_flags, list, size);
 }
 
 SYSCALL_DEFINE3(listxattr, const char __user *, pathname, char __user *, list,
 		size_t, size)
 {
-	return path_listxattrat(AT_FDCWD, pathname, 0, list, size);
+	return path_listxattrat(AT_FDCWD, NULL, pathname, 0, list, size);
 }
 
 SYSCALL_DEFINE3(llistxattr, const char __user *, pathname, char __user *, list,
 		size_t, size)
 {
-	return path_listxattrat(AT_FDCWD, pathname, AT_SYMLINK_NOFOLLOW, list, size);
+	return path_listxattrat(AT_FDCWD, NULL, pathname, AT_SYMLINK_NOFOLLOW,
+				list, size);
 }
 
 SYSCALL_DEFINE3(flistxattr, int, fd, char __user *, list, size_t, size)
 {
-	return path_listxattrat(fd, NULL, AT_EMPTY_PATH, list, size);
+	/* flistxattr() rejects O_PATH file descriptors. */
+	CLASS(fd, f)(fd);
+
+	return path_listxattrat(fd, fd_file(f), NULL, AT_EMPTY_PATH, list, size);
 }
 
 /*
@@ -1072,7 +1093,8 @@ static int filename_removexattr(int dfd, struct filename *filename,
 	return error;
 }
 
-static int path_removexattrat(int dfd, const char __user *pathname,
+static int path_removexattrat(int dfd, struct file *dfd_file,
+			      const char __user *pathname,
 			      unsigned int at_flags, const char __user *name)
 {
 	struct xattr_name kname;
@@ -1088,10 +1110,9 @@ static int path_removexattrat(int dfd, const char __user *pathname,
 
 	CLASS(filename_maybe_null, filename)(pathname, at_flags);
 	if (!filename) {
-		CLASS(fd, f)(dfd);
-		if (fd_empty(f))
+		if (!dfd_file)
 			return -EBADF;
-		return file_removexattr(fd_file(f), &kname);
+		return file_removexattr(dfd_file, &kname);
 	}
 	lookup_flags = (at_flags & AT_SYMLINK_NOFOLLOW) ? 0 : LOOKUP_FOLLOW;
 	return filename_removexattr(dfd, filename, lookup_flags, &kname);
@@ -1100,24 +1121,31 @@ static int path_removexattrat(int dfd, const char __user *pathname,
 SYSCALL_DEFINE4(removexattrat, int, dfd, const char __user *, pathname,
 		unsigned int, at_flags, const char __user *, name)
 {
-	return path_removexattrat(dfd, pathname, at_flags, name);
+	/* removexattrat() accepts O_PATH file descriptors. */
+	CLASS(fd_raw, f)(dfd);
+
+	return path_removexattrat(dfd, fd_file(f), pathname, at_flags, name);
 }
 
 SYSCALL_DEFINE2(removexattr, const char __user *, pathname,
 		const char __user *, name)
 {
-	return path_removexattrat(AT_FDCWD, pathname, 0, name);
+	return path_removexattrat(AT_FDCWD, NULL, pathname, 0, name);
 }
 
 SYSCALL_DEFINE2(lremovexattr, const char __user *, pathname,
 		const char __user *, name)
 {
-	return path_removexattrat(AT_FDCWD, pathname, AT_SYMLINK_NOFOLLOW, name);
+	return path_removexattrat(AT_FDCWD, NULL, pathname, AT_SYMLINK_NOFOLLOW,
+				  name);
 }
 
 SYSCALL_DEFINE2(fremovexattr, int, fd, const char __user *, name)
 {
-	return path_removexattrat(fd, NULL, AT_EMPTY_PATH, name);
+	/* fremovexattr() rejects O_PATH file descriptors. */
+	CLASS(fd, f)(fd);
+
+	return path_removexattrat(fd, fd_file(f), NULL, AT_EMPTY_PATH, name);
 }
 
 int xattr_list_one(char **buffer, ssize_t *remaining_size, const char *name)

