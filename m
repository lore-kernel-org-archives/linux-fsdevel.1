Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4BD37649A;
	Wed, 29 Apr 2026 14:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473264; cv=none; b=kg8d8hlc8ISGk9+NeOOhCkKsUKj+fZz1A1OMbS4jifbxf961pg6g1IoimHgXJcp/HmYkj9RSB3JEv9NmWfyKdIqAbF0OibwCxptToT+oX0cZSvw+ceISMw6eBeHvIMye0of+5wiCydQfNBho7Dq4x1yPewX/atVKmDjLcexnZq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473264; c=relaxed/simple;
	bh=V64Phx8gsGWg8LYyRTi5OM0+IR4FMh53y3aEjJUsgic=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YVvUQRLaMwjTzeVEjaA1Mz1ehc+sh38I+JHtU9tQC3Ht7zIgB46ZpN2NOcXH/qOeooQiwSfGP+x5tG1C7DcYTkNM0y4Olcm8g9DhpI3ypOcBiCw2tG/FeWBl/rqyxWiLPpXDeCOh8zklvZ8LAxj0g0JbHbMtMjBmf15ZjrGiA2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOsTE2d5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOsTE2d5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D8A3C2BCF4;
	Wed, 29 Apr 2026 14:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473263;
	bh=V64Phx8gsGWg8LYyRTi5OM0+IR4FMh53y3aEjJUsgic=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=SOsTE2d5FhhxZVG+hhBg1ROi6HRMAuTP+0B9R4JjJOiE46qws4vv7nuJKh1FS+J1/
	 v4t0Clbj2+5BPu4jPY/GXOtsw5iheM+QO1vERGtHXJOLz8S/ht6UyfCguSdt5ufx5G
	 bwJeSqGc1lCtd66BuYFfdcWJY8uEHI4tC2be5TakOPEOmW+eJT7tcBsjWheqU2toc+
	 mhI0y13mjTNIji6rcHZg1BkOSR5wG9VxkK112HPdQ7ZqBlZ4K2BBPfqagaDIBYgJRm
	 nbDj8hbhmMhpuzdcVYjdItAis3Ds0XaB/D5OF2EXE6FRlUqxS9VjgX6N/jG/mO292b
	 6m+iaEd6I3wag==
Date: Wed, 29 Apr 2026 07:34:22 -0700
Subject: [PATCH 5/9] fuse: cache atime when in iomap mode
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747206595.4103309.11659424316192000821.stgit@frogsfrogsfrogs>
In-Reply-To: <177747206436.4103309.9048553717124547447.stgit@frogsfrogsfrogs>
References: <177747206436.4103309.9048553717124547447.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

When we're running in iomap mode, allow the kernel to cache the access
timestamp to further reduce the number of roundtrips to the fuse server.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/dir.c        |    5 +++++
 fs/fuse/fuse_iomap.c |    6 ++++++
 fs/fuse/inode.c      |   11 ++++++++---
 3 files changed, 19 insertions(+), 3 deletions(-)


diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 53fda7f63b11c8..61015e83888ee4 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -2236,6 +2236,11 @@ int fuse_flush_times(struct inode *inode, struct fuse_file *ff)
 		inarg.ctime = inode_get_ctime_sec(inode);
 		inarg.ctimensec = inode_get_ctime_nsec(inode);
 	}
+	if (fuse_inode_has_iomap(inode)) {
+		inarg.valid |= FATTR_ATIME;
+		inarg.atime = inode_get_atime_sec(inode);
+		inarg.atimensec = inode_get_atime_nsec(inode);
+	}
 	if (ff) {
 		inarg.valid |= FATTR_FH;
 		inarg.fh = ff->fh;
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index a39370b97ca508..9278e2e399ba9b 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -1169,6 +1169,12 @@ void fuse_iomap_init_inode(struct inode *inode, struct fuse_attr *attr)
 	if (attr->flags & FUSE_ATTR_ATOMIC)
 		fuse_inode_set_atomic(inode);
 
+	/*
+	 * iomap caches atime too, so we must load it from the fuse server
+	 * at instantiation time.
+	 */
+	inode_set_atime(inode, attr->atime, attr->atimensec);
+
 	trace_fuse_iomap_init_inode(inode);
 }
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index aa9f880b9a2ea6..1a09b9e1446919 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -266,7 +266,8 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 	attr->mtimensec = min_t(u32, attr->mtimensec, NSEC_PER_SEC - 1);
 	attr->ctimensec = min_t(u32, attr->ctimensec, NSEC_PER_SEC - 1);
 
-	inode_set_atime(inode, attr->atime, attr->atimensec);
+	if (!(cache_mask & STATX_ATIME))
+		inode_set_atime(inode, attr->atime, attr->atimensec);
 	/* mtime from server may be stale due to local buffered write */
 	if (!(cache_mask & STATX_MTIME)) {
 		inode_set_mtime(inode, attr->mtime, attr->mtimensec);
@@ -331,8 +332,12 @@ u32 fuse_get_cache_mask(struct inode *inode)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
 
-	if (S_ISREG(inode->i_mode) &&
-	    (fuse_inode_has_iomap(inode) || fc->writeback_cache))
+	if (!S_ISREG(inode->i_mode))
+		return 0;
+
+	if (fuse_inode_has_iomap(inode))
+		return STATX_MTIME | STATX_CTIME | STATX_ATIME | STATX_SIZE;
+	if (fc->writeback_cache)
 		return STATX_MTIME | STATX_CTIME | STATX_SIZE;
 
 	return 0;

