Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3C233AD9C;
	Tue, 19 May 2026 22:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229796; cv=none; b=OEBgd9NzimVDW1jJ/70AI3EW9ZxNCIZwRC+iY5Zjk2xEZoXLnUp7n+w1vd//PeVEFNWWz7OLOonm33K8dSskgB8Wx7C4aZ+y4a5CYSlPo1JwDdNdMEW0BGVc5lHAZP1MCp2baTtjNV4k7EvB9/1JDbzJ/A0u+GScYvfs7SL/gEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229796; c=relaxed/simple;
	bh=nkXWGJctw6Gm73c8PABVFzaRmW6YRMg9zlQnwVTV4TA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uSQH6xN4PzUv5zJSyEMe1EAID5tVIF14THOvdnytHl8IKhEBkANWfkZ23ptu8ulFrhFL38lDYJHziQR3jfJC8A9ctZVvoEeHgY9yqTWn93VADgJ8MEeR0Fd/xbL0jJ4RVBc0upGh5CTXIPmGesoOFAJm1oGGbeSQLAviT3JTPKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsDiAY89; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsDiAY89"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 2B1D21F000E9;
	Tue, 19 May 2026 22:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779229794;
	bh=3dv79IvnqZwrwunS4uEJuRfTOrjXWsTXRhKPOK/TBHk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=ZsDiAY89KlQR57E9kkiip4gxHlwILs0Y64k2iLS6+pWG1NA7eo78sNDaf52pF5DFP
	 isk+Ppk5qWOMJz99Xm7u4DJ8GjIJuFzHU1CQ5+egs/GRwvlP0RpxheaFMqmikfoUN7
	 lIOqxuR6ozOgdqaK3hMDgtwXSc+qhAdsMWZbKh+PuKekbHiLlFY0dPemkmxzb+JFlD
	 Ixj5ROix/MkHa3Wn4Cq2FgkSHszcS6cM1NGVY6eEsoGDHLZeLEfaxgKPDesY9X/Aj0
	 JvWrpn5m9dZRfJ60V0rzAMKLLdSNX1Nyfvwufg1CPx1h+wmOHO44+N9Zkqv3CoHNrA
	 Ri4LcnPmBVkLw==
Date: Tue, 19 May 2026 15:29:53 -0700
Subject: [PATCH 2/6] fuse_trace: implement direct IO with iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, bernd@bsbernd.com,
 joannelkoong@gmail.com, fuse-devel@lists.linux.dev
Message-ID: <177922945785.2437300.4253633014941816463.stgit@frogsfrogsfrogs>
In-Reply-To: <177922945706.2437300.14187386529698019759.stgit@frogsfrogsfrogs>
References: <177922945706.2437300.14187386529698019759.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Add tracepoints for the previous patch.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_iomap.h |    6 +
 fs/fuse/fuse_trace.h |  222 +++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/fuse/fuse_iomap.c |   18 ++++
 fs/fuse/trace.c      |    2 
 4 files changed, 244 insertions(+), 4 deletions(-)


diff --git a/fs/fuse/fuse_iomap.h b/fs/fuse/fuse_iomap.h
index 4ea34082e01a15..a7c30ebd46dda7 100644
--- a/fs/fuse/fuse_iomap.h
+++ b/fs/fuse/fuse_iomap.h
@@ -42,6 +42,11 @@ int fuse_iomap_finish_open(const struct fuse_file *ff,
 void fuse_iomap_open_truncate(struct inode *inode);
 
 void fuse_iomap_set_disk_size(struct fuse_inode *fi, loff_t newsize);
+static inline loff_t fuse_iomap_get_disk_size(const struct fuse_inode *fi)
+{
+	/* unlocked access, for tracing only */
+	return fuse_inode_has_iomap(&fi->inode) ? fi->i_disk_size : 0;
+}
 int fuse_iomap_setsize_finish(struct inode *inode, loff_t newsize);
 
 ssize_t fuse_iomap_read_iter(struct kiocb *iocb, struct iov_iter *to);
@@ -59,6 +64,7 @@ ssize_t fuse_iomap_write_iter(struct kiocb *iocb, struct iov_iter *from);
 # define fuse_iomap_finish_open(...)		(-ENOSYS)
 # define fuse_iomap_open_truncate(...)		((void)0)
 # define fuse_iomap_set_disk_size(...)		((void)0)
+# define fuse_iomap_get_disk_size(...)		((loff_t)0)
 # define fuse_iomap_setsize_finish(...)		(-ENOSYS)
 # define fuse_iomap_read_iter(...)		(-ENOSYS)
 # define fuse_iomap_write_iter(...)		(-ENOSYS)
diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 10e263732305c0..46a6b7527c3bb3 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -60,6 +60,7 @@
 	EM( FUSE_STATX,			"FUSE_STATX")		\
 	EM( FUSE_IOMAP_BEGIN,		"FUSE_IOMAP_BEGIN")	\
 	EM( FUSE_IOMAP_END,		"FUSE_IOMAP_END")	\
+	EM( FUSE_IOMAP_IOEND,		"FUSE_IOMAP_IOEND")	\
 	EMe(CUSE_INIT,			"CUSE_INIT")
 
 /*
@@ -84,7 +85,8 @@ OPCODES
 		__field(dev_t,			connection) \
 		__field(uint64_t,		ino) \
 		__field(uint64_t,		nodeid) \
-		__field(loff_t,			isize)
+		__field(loff_t,			isize) \
+		__field(loff_t,			idisksize)
 
 #define FUSE_INODE_ASSIGN(inode, fi, fm) \
 		const struct fuse_inode *fi = get_fuse_inode(inode); \
@@ -93,16 +95,18 @@ OPCODES
 		__entry->connection	=	(fm)->fc->dev; \
 		__entry->ino		=	(fi)->orig_ino; \
 		__entry->nodeid		=	(fi)->nodeid; \
-		__entry->isize		=	i_size_read(inode)
+		__entry->isize		=	i_size_read(inode); \
+		__entry->idisksize	=	fuse_iomap_get_disk_size(fi)
 
 #define FUSE_INODE_FMT \
-		"connection %u ino %llu nodeid %llu isize 0x%llx"
+		"connection %u ino %llu nodeid %llu isize 0x%llx idisksize 0x%llx"
 
 #define FUSE_INODE_PRINTK_ARGS \
 		__entry->connection, \
 		__entry->ino, \
 		__entry->nodeid, \
-		__entry->isize
+		__entry->isize, \
+		__entry->idisksize
 
 #define FUSE_FILE_RANGE_FIELDS(prefix) \
 		__field(loff_t,			prefix##offset) \
@@ -299,6 +303,17 @@ DEFINE_FUSE_BACKING_EVENT(fuse_backing_close);
 	{ FUSE_IOMAP_TYPE_UNWRITTEN,		"unwritten" }, \
 	{ FUSE_IOMAP_TYPE_INLINE,		"inline" }
 
+#define FUSE_IOMAP_IOEND_STRINGS \
+	{ FUSE_IOMAP_IOEND_SHARED,		"shared" }, \
+	{ FUSE_IOMAP_IOEND_UNWRITTEN,		"unwritten" }, \
+	{ FUSE_IOMAP_IOEND_BOUNDARY,		"boundary" }, \
+	{ FUSE_IOMAP_IOEND_DIRECT,		"direct" }, \
+	{ FUSE_IOMAP_IOEND_APPEND,		"append" }
+
+#define IOMAP_DIOEND_STRINGS \
+	{ IOMAP_DIO_UNWRITTEN,			"unwritten" }, \
+	{ IOMAP_DIO_COW,			"cow" }
+
 TRACE_DEFINE_ENUM(FUSE_I_ADVISE_RDPLUS);
 TRACE_DEFINE_ENUM(FUSE_I_INIT_RDPLUS);
 TRACE_DEFINE_ENUM(FUSE_I_SIZE_UNSTABLE);
@@ -483,6 +498,75 @@ TRACE_EVENT(fuse_iomap_end_error,
 		  __entry->error)
 );
 
+TRACE_EVENT(fuse_iomap_ioend,
+	TP_PROTO(const struct inode *inode,
+		 const struct fuse_iomap_ioend_in *inarg),
+
+	TP_ARGS(inode, inarg),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+		__field(unsigned,		ioendflags)
+		__field(int,			error)
+		__field(uint32_t,		dev)
+		__field(uint64_t,		new_addr)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	inarg->pos;
+		__entry->length		=	inarg->written;
+		__entry->ioendflags	=	inarg->flags;
+		__entry->error		=	inarg->error;
+		__entry->dev		=	inarg->dev;
+		__entry->new_addr	=	inarg->new_addr;
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT() " ioendflags (%s) error %d dev %u new_addr 0x%llx",
+		  FUSE_IO_RANGE_PRINTK_ARGS(),
+		  __print_flags(__entry->ioendflags, "|", FUSE_IOMAP_IOEND_STRINGS),
+		  __entry->error,
+		  __entry->dev,
+		  __entry->new_addr)
+);
+
+TRACE_EVENT(fuse_iomap_ioend_error,
+	TP_PROTO(const struct inode *inode,
+		 const struct fuse_iomap_ioend_in *inarg,
+		 const struct fuse_iomap_ioend_out *outarg,
+		 int error),
+
+	TP_ARGS(inode, inarg, outarg, error),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+		__field(unsigned,		ioendflags)
+		__field(int,			error)
+		__field(uint32_t,		dev)
+		__field(uint64_t,		new_addr)
+		__field(uint64_t,		new_size)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	inarg->pos;
+		__entry->length		=	inarg->written;
+		__entry->ioendflags	=	inarg->flags;
+		__entry->error		=	error;
+		__entry->dev		=	inarg->dev;
+		__entry->new_addr	=	inarg->new_addr;
+		__entry->new_size	=	outarg->newsize;
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT() " ioendflags (%s) error %d dev %u new_addr 0x%llx new_size 0x%llx",
+		  FUSE_IO_RANGE_PRINTK_ARGS(),
+		  __print_flags(__entry->ioendflags, "|", FUSE_IOMAP_IOEND_STRINGS),
+		  __entry->error,
+		  __entry->dev,
+		  __entry->new_addr,
+		  __entry->new_size)
+);
+
 DECLARE_EVENT_CLASS(fuse_inode_state_class,
 	TP_PROTO(const struct inode *inode),
 	TP_ARGS(inode),
@@ -553,6 +637,136 @@ TRACE_EVENT(fuse_iomap_lseek,
 		  __entry->offset,
 		  __entry->whence)
 );
+
+DECLARE_EVENT_CLASS(fuse_iomap_file_io_class,
+	TP_PROTO(const struct kiocb *iocb, const struct iov_iter *iter),
+	TP_ARGS(iocb, iter),
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+	),
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(file_inode(iocb->ki_filp), fi, fm);
+		__entry->offset		=	iocb->ki_pos;
+		__entry->length		=	iov_iter_count(iter);
+	),
+	TP_printk(FUSE_IO_RANGE_FMT(),
+		  FUSE_IO_RANGE_PRINTK_ARGS())
+)
+#define DEFINE_FUSE_IOMAP_FILE_IO_EVENT(name)		\
+DEFINE_EVENT(fuse_iomap_file_io_class, name,		\
+	TP_PROTO(const struct kiocb *iocb, const struct iov_iter *iter), \
+	TP_ARGS(iocb, iter))
+DEFINE_FUSE_IOMAP_FILE_IO_EVENT(fuse_iomap_direct_read);
+DEFINE_FUSE_IOMAP_FILE_IO_EVENT(fuse_iomap_direct_write);
+
+DECLARE_EVENT_CLASS(fuse_iomap_file_ioend_class,
+	TP_PROTO(const struct kiocb *iocb, const struct iov_iter *iter,
+		 ssize_t ret),
+	TP_ARGS(iocb, iter, ret),
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+		__field(size_t,			bytes)
+		__field(int,			error)
+	),
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(file_inode(iocb->ki_filp), fi, fm);
+		__entry->offset		=	iocb->ki_pos;
+		__entry->length		=	iov_iter_count(iter);
+		if (ret >= 0) {
+			__entry->bytes	=	ret;
+			__entry->error	=	0;
+			__entry->offset -=	ret;
+			__entry->length +=	ret;
+		} else {
+			__entry->bytes	=	0;
+			__entry->error	=	ret;
+		}
+	),
+	TP_printk(FUSE_IO_RANGE_FMT() " bytes 0x%zx error %d",
+		  FUSE_IO_RANGE_PRINTK_ARGS(),
+		  __entry->bytes,
+		  __entry->error)
+)
+#define DEFINE_FUSE_IOMAP_FILE_IOEND_EVENT(name)	\
+DEFINE_EVENT(fuse_iomap_file_ioend_class, name,		\
+	TP_PROTO(const struct kiocb *iocb, const struct iov_iter *iter, \
+		 ssize_t ret), \
+	TP_ARGS(iocb, iter, ret))
+DEFINE_FUSE_IOMAP_FILE_IOEND_EVENT(fuse_iomap_direct_read_end);
+DEFINE_FUSE_IOMAP_FILE_IOEND_EVENT(fuse_iomap_direct_write_end);
+
+TRACE_EVENT(fuse_iomap_dio_write_end_io,
+	TP_PROTO(const struct inode *inode, loff_t pos, ssize_t written,
+		 int error, unsigned flags),
+
+	TP_ARGS(inode, pos, written, error, flags),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+		__field(unsigned,		dioendflags)
+		__field(int,			error)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	pos;
+		__entry->length		=	written;
+		__entry->dioendflags	=	flags;
+		__entry->error		=	error;
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT() " dioendflags (%s) error %d",
+		  FUSE_IO_RANGE_PRINTK_ARGS(),
+		  __print_flags(__entry->dioendflags, "|", IOMAP_DIOEND_STRINGS),
+		  __entry->error)
+);
+
+DECLARE_EVENT_CLASS(fuse_iomap_inode_class,
+	TP_PROTO(const struct inode *inode),
+
+	TP_ARGS(inode),
+
+	TP_STRUCT__entry(
+		FUSE_INODE_FIELDS
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+	),
+
+	TP_printk(FUSE_INODE_FMT,
+		  FUSE_INODE_PRINTK_ARGS)
+);
+#define DEFINE_FUSE_IOMAP_INODE_EVENT(name)	\
+DEFINE_EVENT(fuse_iomap_inode_class, name,	\
+	TP_PROTO(const struct inode *inode), \
+	TP_ARGS(inode))
+DEFINE_FUSE_IOMAP_INODE_EVENT(fuse_iomap_open_truncate);
+
+DECLARE_EVENT_CLASS(fuse_iomap_file_range_class,
+        TP_PROTO(const struct inode *inode, loff_t offset, loff_t length),
+
+        TP_ARGS(inode, offset, length),
+
+        TP_STRUCT__entry(
+                FUSE_IO_RANGE_FIELDS()
+        ),
+
+        TP_fast_assign(
+                FUSE_INODE_ASSIGN(inode, fi, fm);
+                __entry->offset         =       offset;
+                __entry->length         =       length;
+        ),
+
+        TP_printk(FUSE_IO_RANGE_FMT(),
+                  FUSE_IO_RANGE_PRINTK_ARGS())
+)
+#define DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(name)                \
+DEFINE_EVENT(fuse_iomap_file_range_class, name,         \
+        TP_PROTO(const struct inode *inode, loff_t offset, loff_t length), \
+        TP_ARGS(inode, offset, length))
+DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_setsize_finish);
+
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 5e23c662b972fa..ed6d9ba32c47b2 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -622,6 +622,8 @@ fuse_iomap_setsize_finish(
 
 	ASSERT(fuse_inode_has_iomap(inode));
 
+	trace_fuse_iomap_setsize_finish(inode, newsize, 0);
+
 	spin_lock(&fi->lock);
 	fi->i_disk_size = newsize;
 	spin_unlock(&fi->lock);
@@ -652,6 +654,8 @@ static int fuse_iomap_ioend(struct inode *inode, loff_t pos, size_t written,
 	outarg.newsize = max_t(loff_t, fi->i_disk_size, pos + written),
 	spin_unlock(&fi->lock);
 
+	trace_fuse_iomap_ioend(inode, &inarg);
+
 	if (fuse_should_send_iomap_ioend(fm, &inarg)) {
 		FUSE_ARGS(args);
 		int iomap_error;
@@ -677,6 +681,9 @@ static int fuse_iomap_ioend(struct inode *inode, loff_t pos, size_t written,
 		case 0:
 			break;
 		default:
+			trace_fuse_iomap_ioend_error(inode, &inarg, &outarg,
+						     iomap_error);
+
 			/*
 			 * If the write IO failed, return the failure code to
 			 * the caller no matter what happens with the ioend.
@@ -950,6 +957,8 @@ static ssize_t fuse_iomap_direct_read(struct kiocb *iocb, struct iov_iter *to)
 	struct inode *inode = file_inode(iocb->ki_filp);
 	ssize_t ret = 0;
 
+	trace_fuse_iomap_direct_read(iocb, to);
+
 	if (!iov_iter_count(to))
 		goto out; /* skip atime */
 
@@ -963,6 +972,7 @@ static ssize_t fuse_iomap_direct_read(struct kiocb *iocb, struct iov_iter *to)
 	inode_unlock_shared(inode);
 
 out:
+	trace_fuse_iomap_direct_read_end(iocb, to, ret);
 	return ret;
 }
 
@@ -977,6 +987,9 @@ static int fuse_iomap_dio_write_end_io(struct kiocb *iocb, ssize_t written,
 
 	ASSERT(fuse_inode_has_iomap(inode));
 
+	trace_fuse_iomap_dio_write_end_io(inode, iocb->ki_pos, written, error,
+					  dioflags);
+
 	if (dioflags & IOMAP_DIO_COW)
 		ioendflags |= FUSE_IOMAP_IOEND_SHARED;
 	if (dioflags & IOMAP_DIO_UNWRITTEN)
@@ -1013,6 +1026,8 @@ static ssize_t fuse_iomap_direct_write(struct kiocb *iocb,
 	unsigned int flags = IOMAP_DIO_COMP_WORK;
 	ssize_t ret = 0;
 
+	trace_fuse_iomap_direct_write(iocb, from);
+
 	if (!count)
 		goto out;
 
@@ -1047,6 +1062,7 @@ static ssize_t fuse_iomap_direct_write(struct kiocb *iocb,
 out_unlock:
 	inode_unlock(inode);
 out:
+	trace_fuse_iomap_direct_write_end(iocb, from, ret);
 	return ret;
 }
 
@@ -1064,6 +1080,8 @@ void fuse_iomap_open_truncate(struct inode *inode)
 
 	ASSERT(fuse_inode_has_iomap(inode));
 
+	trace_fuse_iomap_open_truncate(inode);
+
 	spin_lock(&fi->lock);
 	fi->i_disk_size = 0;
 	spin_unlock(&fi->lock);
diff --git a/fs/fuse/trace.c b/fs/fuse/trace.c
index 65badac814b591..ac17cc79bfbc7c 100644
--- a/fs/fuse/trace.c
+++ b/fs/fuse/trace.c
@@ -8,7 +8,9 @@
 #include "fuse_dev_i.h"
 
 #include <linux/pagemap.h>
+#include <linux/iomap.h>
 
+#include "fuse_iomap.h"
 #include "fuse_iomap_i.h"
 
 #define CREATE_TRACE_POINTS

