Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2E71A2C0B;
	Wed, 29 Apr 2026 14:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472731; cv=none; b=nokfMNJQZ1kCVXLnZ5IstIt3jOeBU0ZXHB48o6SR3sG4WARtJHgw0/TzYFV0XOYBub0YXsfg/mYDWvhNHnNTarI/fglVljt2/U4+u4E0EUttxIfL+wtU8zx1etBGlxcI6UKsSxjfDzSVDkJLS55i/G7MnqHLGEPCW7MqbfCIwgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472731; c=relaxed/simple;
	bh=cjQt4Z3HIBbNq6YCTR0u/oEO5WgvxUGYhu3ZiQ286vY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FC8te64/flOnnfsU9Xq227PIrvvVut8UuvfkYsgXmudnirzA2lewIIS4QuYFP614OQcKlea2zSVBsDfc5TvSGPw7HqKWpLAconoZrOfR6T1sNAjyspmDHabnZiJVbIux84y6nKgc7gtR7Oog8eKuIuIV3Gs9ehA/rKJIEsSsb2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XkL4pdSG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkL4pdSG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75641C2BCB8;
	Wed, 29 Apr 2026 14:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777472731;
	bh=cjQt4Z3HIBbNq6YCTR0u/oEO5WgvxUGYhu3ZiQ286vY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=XkL4pdSGMtb03aKPsHB9qWb+oS+66vff62vwlwDt9JS0fjofluGeZf5gmzAG+QZhI
	 uQKt2Zy32QxO7YuOFY8Krz+IMvIYLKNCza+fc3ACuApWrUqu2XIIBm91npyHwHH5zY
	 TuRX/YSUiQrHdpukMISPMEPjSCoondUQuvaCVlv7prinhcr6pGSjzOXYaQcj3jFzJf
	 sMbqGGzBNnL7J0hISbmCWIUy95OSip+vxniOF1W3F9dGti7qgfGS4MYFti6boAVPo0
	 mDVoVA1c+1nCvvNfpRX/w8+pLpCHFl2WDJ7x9kWafN2HV8fVh1ruRslYT0kfFEjdOy
	 fow87LBgMS/5Q==
Date: Wed, 29 Apr 2026 07:25:31 -0700
Subject: [PATCH 07/33] fuse: clean up per-file type inode initialization
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747205300.4101881.16850761355584768271.stgit@frogsfrogsfrogs>
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

Clean up the per-filetype inode initialization in fuse_init_inode before
we start adding more functionality here.  Primarily this consists of
refactoring to use a switch statement and passing the file attr struct
around.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h |    2 +-
 fs/fuse/file.c   |    5 +++--
 fs/fuse/inode.c  |   36 +++++++++++++++++++++++++-----------
 3 files changed, 29 insertions(+), 14 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 620489520ddc8e..740589d5dc6c2d 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1229,7 +1229,7 @@ int fuse_notify_poll_wakeup(struct fuse_conn *fc,
 /**
  * Initialize file operations on a regular file
  */
-void fuse_init_file_inode(struct inode *inode, unsigned int flags);
+void fuse_init_file_inode(struct inode *inode, struct fuse_attr *attr);
 
 /**
  * Initialize inode operations on regular files and special files
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index c59452d60b8da0..5e7fe7ef87d2e4 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3199,11 +3199,12 @@ static const struct address_space_operations fuse_file_aops  = {
 	.direct_IO	= fuse_direct_IO,
 };
 
-void fuse_init_file_inode(struct inode *inode, unsigned int flags)
+void fuse_init_file_inode(struct inode *inode, struct fuse_attr *attr)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_conn *fc = get_fuse_conn(inode);
 
+	fuse_init_common(inode);
 	inode->i_fop = &fuse_file_operations;
 	inode->i_data.a_ops = &fuse_file_aops;
 	if (fc->writeback_cache)
@@ -3217,5 +3218,5 @@ void fuse_init_file_inode(struct inode *inode, unsigned int flags)
 	init_waitqueue_head(&fi->direct_io_waitq);
 
 	if (IS_ENABLED(CONFIG_FUSE_DAX))
-		fuse_dax_inode_init(inode, flags);
+		fuse_dax_inode_init(inode, attr->flags);
 }
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 945afc30211d69..bf86edbfa22d6b 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -422,6 +422,12 @@ static void fuse_init_submount_lookup(struct fuse_submount_lookup *sl,
 	refcount_set(&sl->count, 1);
 }
 
+static void fuse_init_special(struct inode *inode, struct fuse_attr *attr)
+{
+	fuse_init_common(inode);
+	init_special_inode(inode, inode->i_mode, new_decode_dev(attr->rdev));
+}
+
 static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr,
 			    struct fuse_conn *fc)
 {
@@ -429,20 +435,28 @@ static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr,
 	inode->i_size = attr->size;
 	inode_set_mtime(inode, attr->mtime, attr->mtimensec);
 	inode_set_ctime(inode, attr->ctime, attr->ctimensec);
-	if (S_ISREG(inode->i_mode)) {
-		fuse_init_common(inode);
-		fuse_init_file_inode(inode, attr->flags);
-	} else if (S_ISDIR(inode->i_mode))
+
+	switch (inode->i_mode & S_IFMT) {
+	case S_IFREG:
+		fuse_init_file_inode(inode, attr);
+		break;
+	case S_IFDIR:
 		fuse_init_dir(inode);
-	else if (S_ISLNK(inode->i_mode))
+		break;
+	case S_IFLNK:
 		fuse_init_symlink(inode);
-	else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
-		 S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
-		fuse_init_common(inode);
-		init_special_inode(inode, inode->i_mode,
-				   new_decode_dev(attr->rdev));
-	} else
+		break;
+	case S_IFCHR:
+	case S_IFBLK:
+	case S_IFIFO:
+	case S_IFSOCK:
+		fuse_init_special(inode, attr);
+		break;
+	default:
 		BUG();
+		break;
+	}
+
 	/*
 	 * Ensure that we don't cache acls for daemons without FUSE_POSIX_ACL
 	 * so they see the exact same behavior as before.

