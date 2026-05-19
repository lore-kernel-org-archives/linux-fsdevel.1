Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88254366563;
	Tue, 19 May 2026 22:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229843; cv=none; b=YutFqvshKwe1kznJhGBhxiswymPIiDQPrQaFFRooRa0V1I0KMOLvoRQaUay8VJOvWS3DrVaqQU33AewuRm3R7P0OLdOhCAdG3lYamoFY3iWyXblHmMj1251plbOIC0QMBh+jjwx7rz/99JM5mqw10ZMGi1ErdjmFXHwQalRFHE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229843; c=relaxed/simple;
	bh=sX+nsCZIEQpTBd/1xO5BoKO++3nAqYlM3Fvl2+OgluM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M282MoYVgZZ2VdgLtrsE0OUIBN/YT2v8BOBiGa5mgSKEpMjBjHyU7IBlPpmM+38quhmXHTZCIRoLKHdD48+WOhcZqYSl+fOmQ8qydq7usx5vutr0/3t9bdgi/kANldzdPE+2xUk9AK0uT+kcfdQ2jYzNPRZn1cehb5w50cyv85Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYSk4afT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYSk4afT"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id BBB761F000E9;
	Tue, 19 May 2026 22:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779229840;
	bh=TrKiYYTVCxbR8tAgXD10D1o7TjdddSlYNo1l0jOb9B8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=SYSk4afT5cckijhaPEZ+0IX+dndciyeDO3537iD4RQfEViA9xs6iWo+XQvlVhCrwr
	 yc7mCMO6RgY2sH01iEYHo5oQKLGO0IRJY96iNhfVHW3m4Y+5qBB6i+FaPI3mPdnqDO
	 xidkftXoRxHnBXwhFaqe5GjB+MkjDMOyKnKHVpmlega4WJTzg6ZHQB5LCIJmI3Edjn
	 3jn18wR6oeeqqrOpYoBOV8NPVnpN2Nfz6xGSQ438dIV/2FC3o4pdWZ15woQWQZKtMJ
	 tBKo343y+x7E9Z0aAbmUDLQ0P8hMzkrux/7i7Uk9viN9QXEJJ5ij+6aswfzmPxYEkB
	 4Pdzaig9L4mnA==
Date: Tue, 19 May 2026 15:30:40 -0700
Subject: [PATCH 5/6] fuse: implement inline data file IO via iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, bernd@bsbernd.com,
 joannelkoong@gmail.com, fuse-devel@lists.linux.dev
Message-ID: <177922945849.2437300.11136427239263142023.stgit@frogsfrogsfrogs>
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

Implement inline data file IO by issuing FUSE_READ/FUSE_WRITE commands
in response to an inline data mapping.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_iomap.c |  227 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 227 insertions(+)


diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 503d399d40d708..8d8a1bc2c4bfe5 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -8,6 +8,7 @@
 #include <linux/pagemap.h>
 #include <linux/falloc.h>
 #include <linux/fadvise.h>
+#include <linux/fserror.h>
 #include "fuse_i.h"
 #include "fuse_trace.h"
 #include "fuse_iomap.h"
@@ -424,6 +425,178 @@ fuse_iomap_validate_bdev_access(const struct fuse_backing *fb,
 	return (!fb || (fb->file->f_mode & fmode) == fmode) ? 0 : -EACCES;
 }
 
+static inline int fuse_iomap_inline_alloc(const struct inode *inode,
+					  struct iomap *iomap)
+{
+	ASSERT(iomap->inline_data == NULL);
+	ASSERT(iomap->length > 0);
+
+	if (iomap->length > i_blocksize(inode))
+		return -ENOMEM;
+
+	iomap->inline_data = kvzalloc(iomap->length, GFP_KERNEL);
+	return iomap->inline_data ? 0 : -ENOMEM;
+}
+
+static inline void fuse_iomap_inline_free(struct iomap *iomap)
+{
+	kvfree(iomap->inline_data);
+	iomap->inline_data = NULL;
+}
+
+/*
+ * Use the FUSE_READ command to read inline file data from the fuse server.
+ * Note that there's no file handle attached, so the fuse server must be able
+ * to reconnect to the inode via the nodeid.  Read all of the inline data every
+ * time so that iomap->inline_data is always uptodate.  This is safe (though
+ * not maximally efficient) because iomap_write_begin_inline doesn't handle
+ * inline mappings with nonzero offset.
+ */
+static int fuse_iomap_inline_read(struct inode *inode, loff_t pos,
+				  loff_t count, struct iomap *iomap)
+{
+	struct fuse_read_in in = {
+		.offset = iomap->offset,
+		.size = iomap->length,
+	};
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_mount *fm = get_fuse_mount(inode);
+	FUSE_ARGS(args);
+	ssize_t ret;
+
+	args.opcode = FUSE_READ;
+	args.nodeid = fi->nodeid;
+	args.in_numargs = 1;
+	args.in_args[0].size = sizeof(in);
+	args.in_args[0].value = &in;
+	args.out_argvar = true;
+	args.out_numargs = 1;
+	args.out_args[0].size = in.size;
+	args.out_args[0].value = iomap_inline_data(iomap, in.offset);
+
+	ret = fuse_simple_request(fm, &args);
+	if (ret == -ENOSYS)
+		ret = 0;
+	if (ret < 0)
+		return ret;
+
+	/* no readahead means something bad happened */
+	if (ret == 0)
+		return -EIO;
+
+	return 0;
+}
+
+/*
+ * Use the FUSE_WRITE command to write inline file data from the fuse server.
+ * Note that there's no file handle attached, so the fuse server must be able
+ * to reconnect to the inode via the nodeid.  Note that we only send the
+ * written range to the server.
+ */
+static ssize_t fuse_iomap_inline_write(struct inode *inode, loff_t pos,
+				       ssize_t written, struct iomap *iomap)
+{
+	struct fuse_write_in in = {
+		.offset = pos,
+		.size = written,
+	};
+	struct fuse_write_out out = { };
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_mount *fm = get_fuse_mount(inode);
+	FUSE_ARGS(args);
+	ssize_t persisted = 0;
+	ssize_t ret = 0;
+
+	if (BAD_DATA(pos + written > iomap->offset + iomap->length))
+		return -EIO;
+
+	while (in.size > 0) {
+		args.opcode = FUSE_WRITE;
+		args.nodeid = fi->nodeid;
+		args.in_numargs = 2;
+		args.in_args[0].size = sizeof(in);
+		args.in_args[0].value = &in;
+		args.in_args[1].size = in.size;
+		args.in_args[1].value = iomap_inline_data(iomap, in.offset);
+		args.out_numargs = 1;
+		args.out_args[0].size = sizeof(out);
+		args.out_args[0].value = &out;
+
+		ret = fuse_simple_request(fm, &args);
+		if (ret == -ENOSYS)
+			ret = 0;
+		if (ret < 0)
+			break;
+
+		/* zero or excessive length write means something bad happened */
+		if (out.size == 0 || BAD_DATA(out.size > in.size)) {
+			ret = -EIO;
+			break;
+		}
+
+		in.offset += out.size;
+		in.size -= out.size;
+		persisted += out.size;
+	}
+
+	return persisted ? persisted : ret;
+}
+
+/* Set up inline data buffers for iomap_begin */
+static int fuse_iomap_set_inline(struct inode *inode, unsigned opflags,
+				 loff_t pos, loff_t count,
+				 struct iomap *iomap, struct iomap *srcmap)
+{
+	int err;
+
+	if (opflags & IOMAP_REPORT)
+		return 0;
+
+	if (fuse_is_iomap_file_write(opflags)) {
+		if (iomap->type == IOMAP_INLINE) {
+			err = fuse_iomap_inline_alloc(inode, iomap);
+			if (err)
+				return err;
+		}
+
+		if (srcmap->type == IOMAP_INLINE) {
+			/* inline data read in preparation for write */
+			err = fuse_iomap_inline_alloc(inode, srcmap);
+			if (err)
+				goto out_iomap;
+
+			err = fuse_iomap_inline_read(inode, pos, count,
+						     srcmap);
+			if (err)
+				goto out_srcmap;
+		} else if (iomap->type == IOMAP_INLINE &&
+			   srcmap->type == IOMAP_HOLE) {
+			/* pure overwrite of inline data */
+			err = fuse_iomap_inline_read(inode, pos, count,
+						     iomap);
+			if (err)
+				goto out_iomap;
+		}
+	} else if (iomap->type == IOMAP_INLINE) {
+		/* inline data read */
+		err = fuse_iomap_inline_alloc(inode, iomap);
+		if (err)
+			return err;
+
+		err = fuse_iomap_inline_read(inode, pos, count, iomap);
+		if (err)
+			goto out_iomap;
+	}
+
+	return 0;
+
+out_srcmap:
+	fuse_iomap_inline_free(srcmap);
+out_iomap:
+	fuse_iomap_inline_free(iomap);
+	return err;
+}
+
 static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 			    unsigned opflags, struct iomap *iomap,
 			    struct iomap *srcmap)
@@ -510,6 +683,13 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 		fuse_iomap_from_server(iomap, read_dev, &outarg.read);
 	}
 
+	if (iomap->type == IOMAP_INLINE || srcmap->type == IOMAP_INLINE) {
+		err = fuse_iomap_set_inline(inode, opflags, pos, count, iomap,
+					    srcmap);
+		if (err)
+			goto out_write_dev;
+	}
+
 	/*
 	 * It's ok to put the refcount here because you can't remove an iomap
 	 * device unless there are zero iomap inodes.
@@ -547,14 +727,61 @@ static bool fuse_should_send_iomap_end(const struct fuse_mount *fm,
 	return written < count;
 }
 
+static void fuse_iomap_write_error(struct inode *inode, loff_t pos,
+				    loff_t count, unsigned opflags, int error)
+{
+	const enum fserror_type f =
+		(opflags & IOMAP_DIRECT) ? FSERR_DIRECTIO_WRITE :
+					   FSERR_BUFFERED_WRITE;
+
+	mapping_set_error(inode->i_mapping, error);
+	fserror_report_io(inode, f, pos, count, error, GFP_NOFS);
+}
+
 static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t count,
 			  ssize_t written, unsigned opflags,
 			  struct iomap *iomap)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_mount *fm = get_fuse_mount(inode);
+	struct iomap_iter *iter = container_of(iomap, struct iomap_iter, iomap);
+	struct iomap *srcmap = &iter->srcmap;
 	int err;
 
+	if (srcmap->inline_data)
+		fuse_iomap_inline_free(srcmap);
+
+	if (iomap->inline_data) {
+		if (fuse_is_iomap_file_write(opflags) && written > 0) {
+			ssize_t persisted =
+				fuse_iomap_inline_write(inode, pos, written,
+							iomap);
+
+			fuse_iomap_inline_free(iomap);
+			if (persisted < 0) {
+				fuse_iomap_write_error(inode, pos, written,
+						       opflags, persisted);
+				return persisted;
+			}
+
+			if (persisted < written)
+				fuse_iomap_write_error(inode,
+						       pos + persisted,
+						       written - persisted,
+						       opflags, -EIO);
+
+			spin_lock(&fi->lock);
+			fi->i_disk_size = max(fi->i_disk_size,
+					      pos + persisted);
+			spin_unlock(&fi->lock);
+		} else {
+			fuse_iomap_inline_free(iomap);
+		}
+
+		/* fuse server should already be aware of what happened */
+		return 0;
+	}
+
 	if (fuse_should_send_iomap_end(fm, iomap, opflags, count, written)) {
 		struct fuse_iomap_end_in inarg = {
 			.opflags = fuse_iomap_op_to_server(opflags),

