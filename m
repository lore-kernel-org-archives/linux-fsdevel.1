Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6BD34D4EA;
	Wed, 29 Apr 2026 14:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473028; cv=none; b=ox+eScQdiB4C1LF7yyTCC1lBwCrP9kkPFdLWcY4aKXEiOpHTR7UdTi3nAbMDXp6ooS5ggDTH6/Wp0sxsxpBDUyYVr+snWRuFGW9985/jkZOyJi7sO05wwkaHrSTYGI2RwyjJvLw3mqjck1iF6cIBbnq9orhdl1vmLEzNyV4LF5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473028; c=relaxed/simple;
	bh=yN37VKcrc966ZrlM+zdn51o7iUxnYGC3bpE7tYaqumU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uOp9MdmS6sjEYCdtoe5vEmPh8+lRNAGEkK0v4ui+hRXyz4bDT7FXkMP0/Qyc8d9BFxNNWEe6OPlBWb00pC+qM8v4fM9T+LFxV/jJz5hsmnmAghTyHEmxaUehdfw30VjEYrmqgfH2dzTfwOiGv+Z9MgKFIHutB70URvmj689fVGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U47Iqj8b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U47Iqj8b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676B2C2BCC4;
	Wed, 29 Apr 2026 14:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473028;
	bh=yN37VKcrc966ZrlM+zdn51o7iUxnYGC3bpE7tYaqumU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=U47Iqj8b+KcexEEsFby6qYeTniTxahAsURlv40uyU2bZGlZqISjegWesrENAjSHnF
	 4amqxEOF4SiSUwSxgmDyCdXhJ4ux6UysnMGpeQhj70Fl2zAU41xjFKvXY4W3g3rX3y
	 xbFIPJzSg4zEVodq1VZspZ8KFfSQe9WBGuPw0RC8LvRv+D7yDD3VkgvNfnTnT4EZ8x
	 LqbWgGSq/LE3NAxbs2UUZfvd0MfYNyvvRxlDGPWdv58wZqtTqISE+O1kQOu097RsTX
	 esl1bDeOimfC4wu37SIKJCHIMfr2BYRLbCKe5Q/dNGft5mCrcA+rdopyzgd/UX2PXN
	 oX7fzC4Hqdtrw==
Date: Wed, 29 Apr 2026 07:30:28 -0700
Subject: [PATCH 26/33] fuse: implement inline data file IO via iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747205707.4101881.7117774253873164905.stgit@frogsfrogsfrogs>
In-Reply-To: <177747204948.4101881.16044986246405634629.stgit@frogsfrogsfrogs>
References: <177747204948.4101881.16044986246405634629.stgit@frogsfrogsfrogs>
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
 fs/fuse/fuse_iomap.c |  213 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 205 insertions(+), 8 deletions(-)


diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 807d84a2139362..b9531ad5ab5180 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -398,6 +398,156 @@ fuse_iomap_find_dev(struct fuse_conn *fc, const struct fuse_iomap_io *map)
 	return ret;
 }
 
+static inline int fuse_iomap_inline_alloc(struct iomap *iomap)
+{
+	ASSERT(iomap->inline_data == NULL);
+	ASSERT(iomap->length > 0);
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
+ * to reconnect to the inode via the nodeid.
+ */
+static int fuse_iomap_inline_read(struct inode *inode, loff_t pos,
+				  loff_t count, struct iomap *iomap)
+{
+	struct fuse_read_in in = {
+		.offset = pos,
+		.size = count,
+	};
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_mount *fm = get_fuse_mount(inode);
+	FUSE_ARGS(args);
+	ssize_t ret;
+
+	if (BAD_DATA(!iomap_inline_data_valid(iomap))) {
+		fuse_iomap_inline_free(iomap);
+		return -EFSCORRUPTED;
+	}
+
+	args.opcode = FUSE_READ;
+	args.nodeid = fi->nodeid;
+	args.in_numargs = 1;
+	args.in_args[0].size = sizeof(in);
+	args.in_args[0].value = &in;
+	args.out_argvar = true;
+	args.out_numargs = 1;
+	args.out_args[0].size = count;
+	args.out_args[0].value = iomap_inline_data(iomap, pos);
+
+	ret = fuse_simple_request(fm, &args);
+	if (ret == -ENOSYS)
+		ret = 0;
+	if (ret < 0) {
+		fuse_iomap_inline_free(iomap);
+		return ret;
+	}
+	/* no readahead means something bad happened */
+	if (ret == 0) {
+		fuse_iomap_inline_free(iomap);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/*
+ * Use the FUSE_WRITE command to write inline file data from the fuse server.
+ * Note that there's no file handle attached, so the fuse server must be able
+ * to reconnect to the inode via the nodeid.
+ */
+static int fuse_iomap_inline_write(struct inode *inode, loff_t pos,
+				   loff_t count, struct iomap *iomap)
+{
+	struct fuse_write_in in = {
+		.offset = pos,
+		.size = count,
+	};
+	struct fuse_write_out out = { };
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_mount *fm = get_fuse_mount(inode);
+	FUSE_ARGS(args);
+	ssize_t ret;
+
+	if (BAD_DATA(!iomap_inline_data_valid(iomap)))
+		return -EFSCORRUPTED;
+
+	args.opcode = FUSE_WRITE;
+	args.nodeid = fi->nodeid;
+	args.in_numargs = 2;
+	args.in_args[0].size = sizeof(in);
+	args.in_args[0].value = &in;
+	args.in_args[1].size = count;
+	args.in_args[1].value = iomap_inline_data(iomap, pos);
+	args.out_numargs = 1;
+	args.out_args[0].size = sizeof(out);
+	args.out_args[0].value = &out;
+
+	ret = fuse_simple_request(fm, &args);
+	if (ret == -ENOSYS)
+		ret = 0;
+	if (ret < 0) {
+		fuse_iomap_inline_free(iomap);
+		return ret;
+	}
+	/* short write means something bad happened */
+	if (out.size < count) {
+		fuse_iomap_inline_free(iomap);
+		return -EIO;
+	}
+
+	return 0;
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
+			err = fuse_iomap_inline_alloc(iomap);
+			if (err)
+				return err;
+		}
+
+		if (srcmap->type == IOMAP_INLINE) {
+			err = fuse_iomap_inline_alloc(srcmap);
+			if (!err)
+				err = fuse_iomap_inline_read(inode, pos, count,
+							     srcmap);
+			if (err) {
+				fuse_iomap_inline_free(iomap);
+				return err;
+			}
+		}
+	} else if (iomap->type == IOMAP_INLINE) {
+		/* inline data read */
+		err = fuse_iomap_inline_alloc(iomap);
+		if (!err)
+			err = fuse_iomap_inline_read(inode, pos, count, iomap);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 			    unsigned opflags, struct iomap *iomap,
 			    struct iomap *srcmap)
@@ -467,12 +617,20 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
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
 	 * XXX: if we ever want to support closing devices, we need a way to
 	 * track the fuse_backing refcount all the way through bio endios.
 	 * For now we put the refcount here because you can't remove an iomap
 	 * device until unmount time.
 	 */
+out_write_dev:
 	fuse_backing_put(write_dev);
 out_read_dev:
 	fuse_backing_put(read_dev);
@@ -511,8 +669,32 @@ static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t count,
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
+			err = fuse_iomap_inline_write(inode, pos, written,
+						      iomap);
+			fuse_iomap_inline_free(iomap);
+			if (err)
+				return err;
+
+			spin_lock(&fi->lock);
+			fi->i_disk_size = max(fi->i_disk_size, pos + written);
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
@@ -1462,7 +1644,6 @@ static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
 					  unsigned int len, u64 end_pos)
 {
 	struct inode *inode = wpc->inode;
-	struct iomap write_iomap, dontcare;
 	ssize_t ret;
 
 	if (fuse_is_bad(inode)) {
@@ -1475,23 +1656,39 @@ static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
 	trace_fuse_iomap_writeback_range(inode, offset, len, end_pos);
 
 	if (!fuse_iomap_revalidate_writeback(wpc, offset)) {
+		struct iomap_iter fake_iter = { };
+		struct iomap *write_iomap = &fake_iter.iomap;
+
 		ret = fuse_iomap_begin(inode, offset, len,
-				       FUSE_IOMAP_OP_WRITEBACK,
-				       &write_iomap, &dontcare);
+				       FUSE_IOMAP_OP_WRITEBACK, write_iomap,
+				       &fake_iter.srcmap);
 		if (ret)
 			goto discard_folio;
 
+		if (BAD_DATA(write_iomap->type == IOMAP_INLINE)) {
+			/*
+			 * iomap assumes that inline data writes are completed
+			 * by the time ->iomap_end completes, so it should
+			 * never mark a pagecache folio dirty.
+			 */
+			fuse_iomap_end(inode, offset, len, 0,
+				       FUSE_IOMAP_OP_WRITEBACK,
+				       write_iomap);
+			ret = -EIO;
+			goto discard_folio;
+		}
+
 		/*
 		 * Landed in a hole or beyond EOF?  Send that to iomap, it'll
 		 * skip writing back the file range.
 		 */
-		if (write_iomap.offset > offset) {
-			write_iomap.length = write_iomap.offset - offset;
-			write_iomap.offset = offset;
-			write_iomap.type = IOMAP_HOLE;
+		if (write_iomap->offset > offset) {
+			write_iomap->length = write_iomap->offset - offset;
+			write_iomap->offset = offset;
+			write_iomap->type = IOMAP_HOLE;
 		}
 
-		memcpy(&wpc->iomap, &write_iomap, sizeof(struct iomap));
+		memcpy(&wpc->iomap, write_iomap, sizeof(struct iomap));
 	}
 
 	ret = iomap_add_to_ioend(wpc, folio, offset, end_pos, len);

