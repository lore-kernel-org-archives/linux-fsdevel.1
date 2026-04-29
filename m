Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A5C33D6D7;
	Wed, 29 Apr 2026 14:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473405; cv=none; b=YrncEHLyancFkXMozfiYvL8QMAT571Z120uBEwrHWxQ04eFX08KMG0iBJ5AxmJ8zeZQR2sxJ/4IJeZlLpDIwL57+hXzSBVfKpXS+raM9sicastEjN4FPGDKqTA1Br0sMx4nQSKXZ7+F/n/rKZDMb9MZ0T/WtzL8nrw1ZdeZyfMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473405; c=relaxed/simple;
	bh=s2oyd6y44TZs1vDh8Fv1+ayi3lgLaTUupxY932TOTXU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kw151Qartl/8HfbJXdpRZbOaUIW2IPCta6boRgiDM0AOYDcN3iN3vny/27a2VxtF3CSSd3eOVkcKrB2BS/FtiwbF0tAmaaE59YZeT8lsL2UtnlnJglobKsgncGs3d0lyHV0ZSgYBY27iqBb5y38qktJuG3Y2Z80QulzQNU68jw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Usnit0aq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Usnit0aq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9374EC19425;
	Wed, 29 Apr 2026 14:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473404;
	bh=s2oyd6y44TZs1vDh8Fv1+ayi3lgLaTUupxY932TOTXU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Usnit0aqW9PAHc8S9S/PtWhrGvkDRpnyPvxPu8TqOsFiYeGkwbPO5DjGRMgLY6F/A
	 QM0LV+XCFLeJBixNCJIqYnR2Uf+5Ey1UCT7a7kYjUqVCYmqILzoihBLcl9D34Nn/FQ
	 k++Oe6QTmBOs+EYToKxX95dEo6OXDUQlCFBYQ2M43zIYKCw8pC0Ihyc3s8EUGIiRtf
	 YcI4Uec1dKVI2pyZLddcn7U6fqd/DPTYOPXpxwfF6+W3EyhTxeXSV+2p92qbJcDUCD
	 tekBOFbJBpgkAjQk+ocKnTQ7Es05WZs6xF54EU4Vto6sx+ZcSQw9RyAGubbT9ZWfYB
	 UnX8vGognbwSw==
Date: Wed, 29 Apr 2026 07:36:43 -0700
Subject: [PATCH 05/12] fuse: invalidate iomap cache after file updates
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747207106.4103699.16249134158119369954.stgit@frogsfrogsfrogs>
In-Reply-To: <177747206929.4103699.18256961856283014867.stgit@frogsfrogsfrogs>
References: <177747206929.4103699.18256961856283014867.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

The kernel doesn't know what the fuse server might have done in response
to truncate, fallocate, or ioend events.  Therefore, it must invalidate
the mapping cache after those operations to ensure cache coherency.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_iomap.h       |    3 +++
 fs/fuse/fuse_iomap_cache.h |    9 +++++++++
 fs/fuse/file.c             |   18 ++++++++++--------
 fs/fuse/fuse_iomap.c       |   28 ++++++++++++++++++++++++++--
 fs/fuse/fuse_iomap_cache.c |   27 +++++++++++++++++++++++++++
 5 files changed, 75 insertions(+), 10 deletions(-)


diff --git a/fs/fuse/fuse_iomap.h b/fs/fuse/fuse_iomap.h
index 25c36c9c39d6f3..5cdf7b311dba42 100644
--- a/fs/fuse/fuse_iomap.h
+++ b/fs/fuse/fuse_iomap.h
@@ -69,6 +69,8 @@ int fuse_iomap_fallocate(struct file *file, int mode, loff_t offset,
 			 loff_t length, loff_t new_size);
 int fuse_iomap_flush_unmap_range(struct inode *inode, loff_t pos,
 				 loff_t endpos);
+void fuse_iomap_copied_file_range(struct inode *inode, loff_t offset,
+				  u64 written);
 
 int fuse_dev_ioctl_iomap_support(struct file *file,
 				 struct fuse_iomap_support __user *argp);
@@ -101,6 +103,7 @@ int fuse_dev_ioctl_iomap_set_nofs(struct file *file, uint32_t __user *argp);
 # define fuse_iomap_setsize_start(...)		(-ENOSYS)
 # define fuse_iomap_fallocate(...)		(-ENOSYS)
 # define fuse_iomap_flush_unmap_range(...)	(-ENOSYS)
+# define fuse_iomap_copied_file_range(...)	((void)0)
 # define fuse_dev_ioctl_iomap_support(...)	(-EOPNOTSUPP)
 # define fuse_iomap_dev_inval(...)		(-ENOSYS)
 # define fuse_iomap_fadvise			NULL
diff --git a/fs/fuse/fuse_iomap_cache.h b/fs/fuse/fuse_iomap_cache.h
index dcd52c183f22ab..eba90d9519b8c3 100644
--- a/fs/fuse/fuse_iomap_cache.h
+++ b/fs/fuse/fuse_iomap_cache.h
@@ -99,6 +99,15 @@ enum fuse_iomap_lookup_result
 fuse_iomap_cache_lookup(struct inode *inode, enum fuse_iomap_iodir iodir,
 			loff_t off, uint64_t len,
 			struct fuse_iomap_lookup *mval);
+
+int fuse_iomap_cache_invalidate_range(struct inode *inode, loff_t offset,
+				      uint64_t length);
+static inline int fuse_iomap_cache_invalidate(struct inode *inode,
+					      loff_t offset)
+{
+	return fuse_iomap_cache_invalidate_range(inode, offset,
+						 FUSE_IOMAP_INVAL_TO_EOF);
+}
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _FS_FUSE_IOMAP_CACHE_H */
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index eecd0610fbd3e5..3e9de61122f529 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -101,7 +101,7 @@ static void fuse_release_end(struct fuse_mount *fm, struct fuse_args *args,
 	kfree(ra);
 }
 
-static void fuse_file_put(struct fuse_file *ff, bool sync)
+static void fuse_file_put(struct fuse_file *ff, struct inode *inode, bool sync)
 {
 	if (refcount_dec_and_test(&ff->count)) {
 		struct fuse_release_args *ra = &ff->args->release_args;
@@ -391,7 +391,7 @@ void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 	 * own ref to the file, the IO completion has to drop the ref, which is
 	 * how the fuse server can end up closing its clients' files.
 	 */
-	fuse_file_put(ff, false);
+	fuse_file_put(ff, inode, false);
 }
 
 void fuse_release_common(struct file *file, bool isdir)
@@ -422,7 +422,7 @@ void fuse_sync_release(struct fuse_inode *fi, struct fuse_file *ff,
 {
 	WARN_ON(refcount_read(&ff->count) > 1);
 	fuse_prepare_release(fi, ff, flags, FUSE_RELEASE, true);
-	fuse_file_put(ff, true);
+	fuse_file_put(ff, fi ? &fi->inode : NULL, true);
 }
 EXPORT_SYMBOL_GPL(fuse_sync_release);
 
@@ -1050,7 +1050,7 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
 		folio_put(ap->folios[i]);
 	}
 	if (ia->ff)
-		fuse_file_put(ia->ff, false);
+		fuse_file_put(ia->ff, inode, false);
 
 	fuse_io_free(ia);
 }
@@ -1912,7 +1912,7 @@ static void fuse_writepage_free(struct fuse_writepage_args *wpa)
 	if (wpa->bucket)
 		fuse_sync_bucket_dec(wpa->bucket);
 
-	fuse_file_put(wpa->ia.ff, false);
+	fuse_file_put(wpa->ia.ff, wpa->inode, false);
 
 	kfree(ap->folios);
 	kfree(wpa);
@@ -2069,7 +2069,7 @@ int fuse_write_inode(struct inode *inode, struct writeback_control *wbc)
 	ff = __fuse_write_file_get(fi);
 	err = fuse_flush_times(inode, ff);
 	if (ff)
-		fuse_file_put(ff, false);
+		fuse_file_put(ff, inode, false);
 
 	return err;
 }
@@ -2295,7 +2295,7 @@ static int fuse_iomap_writeback_submit(struct iomap_writepage_ctx *wpc,
 	}
 
 	if (data->ff)
-		fuse_file_put(data->ff, false);
+		fuse_file_put(data->ff, wpc->inode, false);
 
 	return error;
 }
@@ -3207,7 +3207,9 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 		goto out;
 	}
 
-	if (!is_iomap)
+	if (is_iomap)
+		fuse_iomap_copied_file_range(inode_out, pos_out, bytes_copied);
+	else
 		truncate_inode_pages_range(inode_out->i_mapping,
 				   ALIGN_DOWN(pos_out, PAGE_SIZE),
 				   ALIGN(pos_out + bytes_copied, PAGE_SIZE) - 1);
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index e1e7b98e591d16..6223b98890a83b 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -899,6 +899,8 @@ static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t count,
 			spin_lock(&fi->lock);
 			fi->i_disk_size = max(fi->i_disk_size, pos + written);
 			spin_unlock(&fi->lock);
+
+			fuse_iomap_cache_invalidate_range(inode, pos, written);
 		} else {
 			fuse_iomap_inline_free(iomap);
 		}
@@ -989,7 +991,7 @@ fuse_iomap_setsize_finish(
 	spin_lock(&fi->lock);
 	fi->i_disk_size = newsize;
 	spin_unlock(&fi->lock);
-	return 0;
+	return fuse_iomap_cache_invalidate(inode, newsize);
 }
 
 static int fuse_iomap_ioend(struct inode *inode, loff_t pos, size_t written,
@@ -1067,12 +1069,14 @@ static int fuse_iomap_ioend(struct inode *inode, loff_t pos, size_t written,
 
 	/*
 	 * If there weren't any ioend errors, update the incore isize, which
-	 * confusingly takes the new i_size as "pos".
+	 * confusingly takes the new i_size as "pos".  Invalidate cached
+	 * mappings for the file range that we just completed.
 	 */
 	spin_lock(&fi->lock);
 	fi->i_disk_size = outarg.newsize;
 	spin_unlock(&fi->lock);
 	fuse_write_update_attr(inode, pos + written, written);
+	fuse_iomap_cache_invalidate_range(inode, pos, written);
 	return 0;
 }
 
@@ -1781,6 +1785,8 @@ void fuse_iomap_open_truncate(struct inode *inode)
 	spin_lock(&fi->lock);
 	fi->i_disk_size = 0;
 	spin_unlock(&fi->lock);
+
+	fuse_iomap_cache_invalidate(inode, 0);
 }
 
 struct fuse_writepage_ctx {
@@ -2475,6 +2481,14 @@ fuse_iomap_fallocate(
 
 	trace_fuse_iomap_fallocate(inode, mode, offset, length, new_size);
 
+	if (mode & (FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_INSERT_RANGE))
+		error = fuse_iomap_cache_invalidate(inode, offset);
+	else
+		error = fuse_iomap_cache_invalidate_range(inode, offset,
+							  length);
+	if (error)
+		return error;
+
 	/*
 	 * If we unmapped blocks from the file range, then we zero the
 	 * pagecache for those regions and push them to disk rather than make
@@ -2492,6 +2506,8 @@ fuse_iomap_fallocate(
 	 */
 	if (new_size) {
 		error = fuse_iomap_setsize_start(inode, new_size);
+		if (!error)
+			error = fuse_iomap_setsize_finish(inode, new_size);
 		if (error)
 			return error;
 
@@ -2613,3 +2629,11 @@ int fuse_dev_ioctl_iomap_set_nofs(struct file *file, uint32_t __user *argp)
 		return -EINVAL;
 	}
 }
+
+void fuse_iomap_copied_file_range(struct inode *inode, loff_t offset,
+				  u64 written)
+{
+	ASSERT(fuse_inode_has_iomap(inode));
+
+	fuse_iomap_cache_invalidate_range(inode, offset, written);
+}
diff --git a/fs/fuse/fuse_iomap_cache.c b/fs/fuse/fuse_iomap_cache.c
index ea63a12a01c1fe..3d80c3eafad2cc 100644
--- a/fs/fuse/fuse_iomap_cache.c
+++ b/fs/fuse/fuse_iomap_cache.c
@@ -1444,6 +1444,33 @@ fuse_iomap_cache_remove(
 	return ret;
 }
 
+int fuse_iomap_cache_invalidate_range(struct inode *inode, loff_t offset,
+				      uint64_t length)
+{
+	loff_t aligned_offset;
+	const unsigned int blocksize = i_blocksize(inode);
+	int ret, ret2;
+
+	if (!fuse_inode_caches_iomaps(inode))
+		return 0;
+
+	aligned_offset = round_down(offset, blocksize);
+	if (length != FUSE_IOMAP_INVAL_TO_EOF) {
+		length += offset - aligned_offset;
+		length = round_up(length, blocksize);
+	}
+
+	fuse_iomap_cache_lock(inode);
+	ret = fuse_iomap_cache_remove(inode, READ_MAPPING,
+				      aligned_offset, length);
+	ret2 = fuse_iomap_cache_remove(inode, WRITE_MAPPING,
+				       aligned_offset, length);
+	fuse_iomap_cache_unlock(inode);
+	if (ret)
+		return ret;
+	return ret2;
+}
+
 static void
 fuse_iext_add_mapping(
 	struct fuse_iomap_cache		*ic,

