Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11CF2E9733
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 01:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774574937; cv=none; b=hf3QFFTmMg+ymHsSkqI6ycMFOY0xx8i3vdljsbtQzElaYfO/GQUYxvbtu81TSSfc7jl7NKr6UG92AXUH4kCHPa3P/yN+Qmn76Gto8fVZxWqg6cIvSPkEaH0Xr8AEi+tDbhLbIkw7tzod9d9SnqshgADuOAHj5Crl6LtFKi+Ug14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774574937; c=relaxed/simple;
	bh=g3Ws7iERFhuWiUB1LsCXT4KMstCFG0Y9jid1HUUB6xg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sPr7UvcNtZSRZCEc/TGz5meG8lE5xJR531OXC8SLtUyQoHjd4aqhK8rfj13ROE/RlWZ2itwVtKkV1i20ljwmWtdJnFtFRfMt6ttM4w138exl+V/LCSDu59zwfFcHyi6dIOdp2N1NZU97obq57iXfUFxBWOO6vdBvJCbSxgKvCAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=roTYr+oT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="roTYr+oT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5FAC116C6;
	Fri, 27 Mar 2026 01:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774574937;
	bh=g3Ws7iERFhuWiUB1LsCXT4KMstCFG0Y9jid1HUUB6xg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=roTYr+oTuR6AvnEOyKzDv3zAAi3yyixU+2hf5fDgPaSJhXA1SHvDHVJ5S6hfl9LAD
	 Y/aW7Yjv8h0vH+TsQZsuqMYxW3OzUeXswgewQkzIiOxWEc3qJ6bc5ai8fi1BrDnOjt
	 3YqHW37BTqTOGsh+YKIIZ3zZdPNZD0r98pbOX4h549IW06EVCa7FvPEmB4AbPm8keR
	 1VUdKcjw97QYw8cr1DRhiS8O75b+fosNZCAvlsbE5ZOk8ICQQnuqDdbR3UoORq3cWm
	 t3JzDRlOuynil6MXR8C2U17UIAxkbFMbKLijD3ohVCx0elp6So4kYj+L1i56G1XmHr
	 swXlcOnB2oXIg==
Date: Thu, 26 Mar 2026 18:28:57 -0700
Subject: [PATCH 16/17] example/hello_ll: port to single-file common code
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, miklos@szeredi.hu,
 neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <177457463409.1008428.15908268330603627959.stgit@frogsfrogsfrogs>
In-Reply-To: <177457463048.1008428.11432672970504238251.stgit@frogsfrogsfrogs>
References: <177457463048.1008428.11432672970504238251.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Port the hello_ll example fuse server to our new single-file library.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 example/hello_ll.c  |  128 ++++-----------------------------------------------
 example/meson.build |    4 +-
 2 files changed, 13 insertions(+), 119 deletions(-)


diff --git a/example/hello_ll.c b/example/hello_ll.c
index bd5fecdcd4d992..cccd44f352ec9d 100644
--- a/example/hello_ll.c
+++ b/example/hello_ll.c
@@ -32,30 +32,10 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include <assert.h>
+#define USE_SINGLE_FILE_LL_API
+#include "single_file.h"
 
 static const char *hello_str = "Hello World!\n";
-static const char *hello_name = "hello";
-
-static int hello_stat(fuse_ino_t ino, struct stat *stbuf)
-{
-	stbuf->st_ino = ino;
-	switch (ino) {
-	case 1:
-		stbuf->st_mode = S_IFDIR | 0755;
-		stbuf->st_nlink = 2;
-		break;
-
-	case 2:
-		stbuf->st_mode = S_IFREG | 0444;
-		stbuf->st_nlink = 1;
-		stbuf->st_size = strlen(hello_str);
-		break;
-
-	default:
-		return -1;
-	}
-	return 0;
-}
 
 static void hello_ll_init(void *userdata, struct fuse_conn_info *conn)
 {
@@ -69,97 +49,6 @@ static void hello_ll_init(void *userdata, struct fuse_conn_info *conn)
 	conn->want &= ~FUSE_CAP_ASYNC_READ;
 }
 
-static void hello_ll_getattr(fuse_req_t req, fuse_ino_t ino,
-			     struct fuse_file_info *fi)
-{
-	struct stat stbuf;
-
-	(void) fi;
-
-	memset(&stbuf, 0, sizeof(stbuf));
-	if (hello_stat(ino, &stbuf) == -1)
-		fuse_reply_err(req, ENOENT);
-	else
-		fuse_reply_attr(req, &stbuf, 1.0);
-}
-
-static void hello_ll_lookup(fuse_req_t req, fuse_ino_t parent, const char *name)
-{
-	struct fuse_entry_param e;
-
-	if (parent != 1 || strcmp(name, hello_name) != 0)
-		fuse_reply_err(req, ENOENT);
-	else {
-		memset(&e, 0, sizeof(e));
-		e.ino = 2;
-		e.attr_timeout = 1.0;
-		e.entry_timeout = 1.0;
-		hello_stat(e.ino, &e.attr);
-
-		fuse_reply_entry(req, &e);
-	}
-}
-
-struct dirbuf {
-	char *p;
-	size_t size;
-};
-
-static void dirbuf_add(fuse_req_t req, struct dirbuf *b, const char *name,
-		       fuse_ino_t ino)
-{
-	struct stat stbuf;
-	size_t oldsize = b->size;
-	b->size += fuse_add_direntry(req, NULL, 0, name, NULL, 0);
-	b->p = (char *) realloc(b->p, b->size);
-	memset(&stbuf, 0, sizeof(stbuf));
-	stbuf.st_ino = ino;
-	fuse_add_direntry(req, b->p + oldsize, b->size - oldsize, name, &stbuf,
-			  b->size);
-}
-
-#define min(x, y) ((x) < (y) ? (x) : (y))
-
-static int reply_buf_limited(fuse_req_t req, const char *buf, size_t bufsize,
-			     off_t off, size_t maxsize)
-{
-	if (off < bufsize)
-		return fuse_reply_buf(req, buf + off,
-				      min(bufsize - off, maxsize));
-	else
-		return fuse_reply_buf(req, NULL, 0);
-}
-
-static void hello_ll_readdir(fuse_req_t req, fuse_ino_t ino, size_t size,
-			     off_t off, struct fuse_file_info *fi)
-{
-	(void) fi;
-
-	if (ino != 1)
-		fuse_reply_err(req, ENOTDIR);
-	else {
-		struct dirbuf b;
-
-		memset(&b, 0, sizeof(b));
-		dirbuf_add(req, &b, ".", 1);
-		dirbuf_add(req, &b, "..", 1);
-		dirbuf_add(req, &b, hello_name, 2);
-		reply_buf_limited(req, b.p, b.size, off, size);
-		free(b.p);
-	}
-}
-
-static void hello_ll_open(fuse_req_t req, fuse_ino_t ino,
-			  struct fuse_file_info *fi)
-{
-	if (ino != 2)
-		fuse_reply_err(req, EISDIR);
-	else if ((fi->flags & O_ACCMODE) != O_RDONLY)
-		fuse_reply_err(req, EACCES);
-	else
-		fuse_reply_open(req, fi);
-}
-
 static void hello_ll_read(fuse_req_t req, fuse_ino_t ino, size_t size,
 			  off_t off, struct fuse_file_info *fi)
 {
@@ -219,10 +108,10 @@ static void hello_ll_removexattr(fuse_req_t req, fuse_ino_t ino, const char *nam
 
 static const struct fuse_lowlevel_ops hello_ll_oper = {
 	.init = hello_ll_init,
-	.lookup = hello_ll_lookup,
-	.getattr = hello_ll_getattr,
-	.readdir = hello_ll_readdir,
-	.open = hello_ll_open,
+	.lookup = single_file_ll_lookup,
+	.getattr = single_file_ll_getattr,
+	.readdir = single_file_ll_readdir,
+	.open = single_file_ll_open,
 	.read = hello_ll_read,
 	.setxattr = hello_ll_setxattr,
 	.getxattr = hello_ll_getxattr,
@@ -259,6 +148,10 @@ int main(int argc, char *argv[])
 		goto err_out1;
 	}
 
+	ret = single_file_configure_simple("hello");
+	if (ret)
+		goto err_out1;
+
 	se = fuse_session_new(&args, &hello_ll_oper,
 			      sizeof(hello_ll_oper), NULL);
 	if (se == NULL)
@@ -291,6 +184,7 @@ int main(int argc, char *argv[])
 	fuse_session_destroy(se);
 err_out1:
 	free(opts.mountpoint);
+	single_file_close();
 	fuse_opt_free_args(&args);
 
 	return ret ? 1 : 0;
diff --git a/example/meson.build b/example/meson.build
index 19a383f7cd2c74..0a7cc3dbf31da4 100644
--- a/example/meson.build
+++ b/example/meson.build
@@ -1,5 +1,5 @@
 examples = [ 'passthrough', 'passthrough_fh',
-             'hello', 'hello_ll',
+             'hello',
              'printcap', 'ioctl_client', 'ioctl_ll_client', 'poll_client',
              'ioctl', 'ioctl_ll', 'cuse', 'cuse_client' ]
 
@@ -12,7 +12,7 @@ if not platform.endswith('bsd') and platform != 'dragonfly'
     examples += [ 'null' ]
 endif
 
-single_file_examples = [ ]
+single_file_examples = [ 'hello_ll' ]
 
 if platform.endswith('linux')
     single_file_examples += [ 'service_ll' ]

