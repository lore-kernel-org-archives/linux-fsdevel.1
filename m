Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F39F3446AD;
	Tue, 19 May 2026 22:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229919; cv=none; b=PX/Wx4FbusRNAcO+KpMnxGOqCe2gd80azf8tnnmaGkGh/4LgwYqZS0Q6/k+aIVZdCw50JxC0Ik38wtWKLJ404bNn3+U73nGBwKc6aXCRK/wxDdCf2pGjwNO0VmD073dCw786cB38Hk7acqkeoAzspmcCCLEAxxqHgpkz3D8cXFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229919; c=relaxed/simple;
	bh=I2jZ6pkGvY6CbDFY8xiIqNAtSUdh5nfYG0qrrRFg7Bo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y9UzmsJ2y+L0D6RwpUamCZCPNrDSktRTRnSWuj6a2FgQDNXiUeD9dFXfLoLBqB3Y2marjFZcncNWB9zo1sCh64HlGwuNkgJTUnwsGJX/2icY9yU4KcHkOqDZfMq2Cn0dDMKTd8694erC2yBPqdNBKw12eGvrxKQ8KWB4EzJSQIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKegxOWX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKegxOWX"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 582411F000E9;
	Tue, 19 May 2026 22:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779229918;
	bh=hqtIJJkPJ7pdN5mFarhZxp5PwSjEDP5C3RM3FfbIbRo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=nKegxOWXJc4G1A1xjNW5OebKREzJ0Xm0UkYKduWNcGKMkDz5rT0vplLH7O/aEfoOs
	 Ew+I3df5OevegwYwV1obuY2CMNaJN/c16gO6qpOsJ+bN+265wc64lK5VLfbYeJgZ1T
	 USjwFc77Li2F04SDRNXjhPTc8QvDwaMQE2wEwZtm5PAIbaNjVaQKF4YDExH/NuUMRG
	 ngUItI/IRIrf6F/K3JvYcgdltS/Cth15ly/EviWJaDJAIbp8TZPrnDEiZWBbkLI7oO
	 Yn+h+2LGmHemapith+fZCUud6GryRwc501A9YXSerpax3P9w/dYbY6eW+NE2U2BXi5
	 GD2FYON8jV7fA==
Date: Tue, 19 May 2026 15:31:58 -0700
Subject: [PATCH 4/9] fuse: use an unrestricted backing device with iomap
 pagecache io
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, bernd@bsbernd.com,
 joannelkoong@gmail.com, fuse-devel@lists.linux.dev
Message-ID: <177922946263.2439242.3673226857782149823.stgit@frogsfrogsfrogs>
In-Reply-To: <177922946123.2439242.16666495969848656301.stgit@frogsfrogsfrogs>
References: <177922946123.2439242.16666495969848656301.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

With iomap support turned on for the pagecache, the kernel issues
writeback to directly to block devices and we no longer have to push all
those pages through the fuse device to userspace.  Therefore, we don't
need the tight dirty limits (~1M) that are used for regular fuse.  This
dramatically increases the performance of fuse's pagecache IO.

A reviewer of this patch asked why we reset s_bdi to the noop bdi and
call super_setup_bdi_name a second time, instead of simply clearing
STRICTLIMIT and resetting the bdi max ratio.

That's sufficient to undo the effects of fuse_bdi_init, yes.  However
the BDI gets created with the name "$major:$minor{-fuseblk}" and there
are "management" scripts that try to tweak fuse BDIs for better
performance.

I don't want some dumb script to mismanage a fuse-iomap filesystem
because it can't tell the difference, so I create a new bdi with the
name "$major:$minor.iomap" to make it obvious.  But super_setup_bdi_name
gets cranky if s_bdi isn't set to noop and we don't want to fail a mount
here due to ENOMEM so ... I implemented this weird switcheroo code.

Also, userspace scripts such as udev rules can modify the bdi as soon as
it appears in sysfs, so we can't run the fuse_bdi_init code in reverse
and expect that will undo everything.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h     |    3 ++
 fs/fuse/fuse_iomap.c |   64 ++++++++++++++++++++++++++++++++++++++++++++++++--
 mm/page-writeback.c  |    1 +
 3 files changed, 66 insertions(+), 2 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index ecacfc65e95a99..9e73522b8ed96e 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -675,6 +675,9 @@ struct fuse_iomap_conn {
 	/**  number of inodes that have iomap enabled */
 	atomic64_t inodes;
 
+	/* old ra_pages, in case we have to put things back */
+	unsigned long old_ra_pages;
+
 	/* fuse server doesn't implement iomap_end */
 	unsigned int no_end:1;
 
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index ac45a0912c9065..df68dec16f98c1 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -1018,12 +1018,16 @@ static int fuse_iomap_process_config(struct fuse_mount *fm, int error,
 				     const struct fuse_iomap_config_out *outarg)
 {
 	struct super_block *sb = fm->sb;
+	struct fuse_conn *fc = fm->fc;
+	struct backing_dev_info *old_bdi = sb->s_bdi;
+	char *suffix = sb->s_bdev ? "-fuseblk" : "-fuse";
+	int ret;
 
 	switch (error) {
 	case 0:
 		break;
 	case -ENOSYS:
-		return 0;
+		goto sb_config;
 	default:
 		return error;
 	}
@@ -1100,6 +1104,25 @@ static int fuse_iomap_process_config(struct fuse_mount *fm, int error,
 	if (outarg->flags & FUSE_IOMAP_CONFIG_MAXBYTES)
 		sb->s_maxbytes = outarg->s_maxbytes;
 
+sb_config:
+	/*
+	 * sb->s_bdi points to the initial private bdi.  However, we want to
+	 * redirect it to a new private bdi with default dirty and readahead
+	 * settings because iomap writeback won't be pushing a ton of dirty
+	 * data through the fuse device.  If this fails we fall back to the
+	 * initial fuse bdi.
+	 */
+	sb->s_bdi = &noop_backing_dev_info;
+	ret = super_setup_bdi_name(sb, "%u:%u%s.iomap", MAJOR(fc->dev),
+				   MINOR(fc->dev), suffix);
+	if (ret) {
+		sb->s_bdi = old_bdi;
+	} else {
+		fc->iomap_conn.old_ra_pages = old_bdi->ra_pages;
+		bdi_unregister(old_bdi);
+		bdi_put(old_bdi);
+	}
+
 	return 0;
 }
 
@@ -1189,12 +1212,49 @@ static inline void fuse_inode_clear_iomap(struct inode *inode)
 	clear_bit(FUSE_I_IOMAP, &fi->state);
 }
 
+static void fuse_iomap_constrain_bdi(struct inode *inode)
+{
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct super_block *sb = inode->i_sb;
+
+	sb->s_bdi->ra_pages = fc->iomap_conn.old_ra_pages;
+
+	bdi_set_strict_limit(sb->s_bdi, 1);
+
+	/*
+	 * For a single fuse filesystem use max 1% of dirty +
+	 * writeback threshold.
+	 *
+	 * This gives about 1M of write buffer for memory maps on a
+	 * machine with 1G and 10% dirty_ratio, which should be more
+	 * than enough.
+	 *
+	 * Privileged users can raise it by writing to
+	 *
+	 *    /sys/class/bdi/<bdi>/max_ratio
+	 */
+	bdi_set_max_ratio(sb->s_bdi, 1);
+}
+
 void fuse_iomap_init_inode(struct inode *inode, struct fuse_attr *attr)
 {
 	ASSERT(get_fuse_conn(inode)->iomap);
 
-	if (!(attr->flags & __FUSE_ATTR_IOMAP))
+	if (!(attr->flags & __FUSE_ATTR_IOMAP)) {
+		/*
+		 * If we allow a regular file to be stood up without iomap, it
+		 * will use the normal fuse pagecache IO paths.  The iomap
+		 * specific BDI has far fewer restrictions because iomap cannot
+		 * be enabled without CAP_SYS_RAWIO privilege, but in this odd
+		 * case we'll fall back to the same restrictions as a non-iomap
+		 * fuse server.
+		 */
+		if (S_ISREG(inode->i_mode) &&
+		    !(inode->i_sb->s_bdi->capabilities & BDI_CAP_STRICTLIMIT))
+			fuse_iomap_constrain_bdi(inode);
+
 		return;
+	}
 
 	/*
 	 * Any file being used in conjunction with iomap must also have the
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 833f743f309f9b..e147811d9376d0 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -809,6 +809,7 @@ int bdi_set_strict_limit(struct backing_dev_info *bdi, unsigned int strict_limit
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(bdi_set_strict_limit);
 
 static unsigned long dirty_freerun_ceiling(unsigned long thresh,
 					   unsigned long bg_thresh)

