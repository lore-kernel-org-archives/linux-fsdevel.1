Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FD33B47C9
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 07:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779174399; cv=none; b=oycBogz1BuF0cU2SnrpoVKAUV1a/SM8wI8xPtTNLv6UZZ8GU2kg8k3po+2LGP3KHyZlrbPEZ3VFmJKfpDcZk0/DoG2hRgahrQKhcJbfLlm5MEhhCzx5EwnAQKb36NFOsPxDHXFq1DeSYtSdOk5VK5RK6Qb7K0QhGUBwr0LImkoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779174399; c=relaxed/simple;
	bh=vGpS3hyPPHhTuP8Q2DhwTW7wBe9IKHEwbda9Wo7yreY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hpX4jtRsTGy3lHzGJWeOIg2Hh2BHRJX9yEYTWuOhypIhWJ/L2s37X5Op/E0qXYfeFDGIrIkGqdyZSbrPXRlByUuGwAwfU0/N1l33AdG7YUCpQa/02kpj5SAKIn7XUerk7oyQnQNXM8BHDtXDTbZG1bopIGL7zdT0biym0C7gFnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=UCrLxc6T; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="UCrLxc6T"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=8PfwJlkx65b9Q2l8Ccu550i8jkhkA7fTs63i5iMBsAw=; b=UCrLxc6TfdNYWWrSfJvlJxp7Le
	xvKTPUJP+snMWTyt4pDqhxKSHrS52WIQJu0A5WL516rKnrBQCZrTbeY7nyUp0v9y92gYNKsV0lslX
	31zKrBBG8FEhTxDVQ26CbusW7Yc8bX6DWhHe9iBPDIcs1McMU9jLtPMIq26fRHiCOQeD+9fNK68cx
	F1Inu9BpenNdpt9o3ilo5Mh4fmjgBd2peopA+gPkB6dF15kVlM1ei3KXkFuKT6uWfWWpeYc4t9UkG
	lzarmZ/zGNWkgqmfMI4KzZStHgeZedU1w6A2hKK3lbogehP9ptypzoRbCwW1j5Ln/eWYOp2baNVPM
	FAdrboqQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wPEXB-00000008UvT-2dQF;
	Tue, 19 May 2026 07:06:33 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [RFC PATCH 04/14] configfs_depend_prep(): pass configfs_dirent instead of dentry
Date: Tue, 19 May 2026 08:06:23 +0100
Message-ID: <20260519070633.2025485-5-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
References: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Again, the only thing it uses dentry for is dentry->d_fsdata; for the
recursive call the situation is the same as with configfs_detach_prep()
and the same observation about ->s_dentry->d_fsdata applies.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/configfs/dir.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 0c071252c9d4..5219c4fd527e 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -1067,15 +1067,12 @@ static int configfs_dump(struct configfs_dirent *sd, int level)
  * much on the stack, though, so folks that need this function - be careful
  * about your stack!  Patches will be accepted to make it iterative.
  */
-static int configfs_depend_prep(struct dentry *origin,
+static int configfs_depend_prep(struct configfs_dirent *sd,
 				struct config_item *target)
 {
-	struct configfs_dirent *child_sd, *sd;
+	struct configfs_dirent *child_sd;
 	int ret = 0;
 
-	BUG_ON(!origin || !origin->d_fsdata);
-	sd = origin->d_fsdata;
-
 	if (sd->s_element == target)  /* Boo-yah */
 		goto out;
 
@@ -1083,8 +1080,7 @@ static int configfs_depend_prep(struct dentry *origin,
 		if ((child_sd->s_type & CONFIGFS_DIR) &&
 		    !(child_sd->s_type & CONFIGFS_USET_DROPPING) &&
 		    !(child_sd->s_type & CONFIGFS_USET_CREATING)) {
-			ret = configfs_depend_prep(child_sd->s_dentry,
-						   target);
+			ret = configfs_depend_prep(child_sd, target);
 			if (!ret)
 				goto out;  /* Child path boo-yah */
 		}
@@ -1105,7 +1101,7 @@ static int configfs_do_depend_item(struct dentry *subsys_dentry,
 
 	spin_lock(&configfs_dirent_lock);
 	/* Scan the tree, return 0 if found */
-	ret = configfs_depend_prep(subsys_dentry, target);
+	ret = configfs_depend_prep(subsys_dentry->d_fsdata, target);
 	if (ret)
 		goto out_unlock_dirent_lock;
 
-- 
2.47.3

