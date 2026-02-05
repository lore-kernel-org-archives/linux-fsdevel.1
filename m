Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1DF334C08
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 07:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770277302; cv=none; b=csQFdvt4TIWafiB4qaSr/+DTACoUM/Tugd92VIv5rlsaDAfbkIn7l+Y6BI01xAGqSghY2Fs6mkYtLGFeJXtegwkospM1GrSnbyVOG7GEAYIkskMLm3VVTKXirAvZikyR42km7UoroGTWGVfYNU8NtG6YuCJXkoVnPX9sk2cr/hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770277302; c=relaxed/simple;
	bh=cXHCOvajtVYiXqTkJTybg33SpPIqnOy93rzrlC7CWy4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MbAdDlnCX8ZX323WF40RsWiQXKHSoQfDf1+9CY076Smj+q4tGXUb7sb+lu+3hG5TEYcS/YOISoFkrmE4rrRUuqw+lDr63FYL7HjcJJklNeuVauQKu7B16oYUtr/mB0Q9/bexKjnP5LUaW/JDYYjtjYtZgbYk45/g3frkAh1oW9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=s7jg/jWf; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="s7jg/jWf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=6idPeOukR7RDsihHW5LjfvXzJnxIbS62IKiT73Yy394=; b=s7jg/jWfsb2tBk9e8MCpWBXn9/
	qtyPz4K+WGzagXMZ+wHEj9ay51M237LU+iSYAwE0SYjwl8OXf2tO2YYLwxeBKv/R7d2tiVhXinYDa
	E6BZqho+sUo9c8E+xlLlwfuXjOq0OPZrG8facunptY2X07kO1+3xvhqmnJfhoHlqHHVouHPvPCW6t
	fbS09Swgcdhr1rlgpaGY3zgbAvHX70Vm6JSUj5sbd/mVj4mqw/Ysjbj1mgzm5C7AkxzfWpupccKep
	b/ekwY9IMbTZpqi4NcEzqH005fGN+H4UKg7y6wMfJG9+hi47x5htfQI95K0UIgkvOix9l1ComIdvx
	ctpXC6XA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vnu1e-0000000AYQz-36ro;
	Thu, 05 Feb 2026 07:43:42 +0000
Date: Thu, 5 Feb 2026 07:43:42 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Alice Ryhl <aliceryhl@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH][RFC] rust_binderfs: fix a dentry leak (regression from
 tree-in-dcache conversion)
Message-ID: <20260205074342.GR3183987@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

[just realized that this one had been sitting in #fixes without being
posted - sorry]

Parallel to binderfs patches - 02da8d2c0965 "binderfs_binder_ctl_create():
kill a bogus check" and the bit of b89aa544821d "convert binderfs" that
got lost when making 4433d8e25d73 "convert rust_binderfs"; the former is
a cleanup, the latter is about marking /binder-control persistent, so that
it would be taken out on umount.

Fixes: 4433d8e25d73 ("convert rust_binderfs")
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/android/binder/rust_binderfs.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/android/binder/rust_binderfs.c b/drivers/android/binder/rust_binderfs.c
index c69026df775c..e36011e89116 100644
--- a/drivers/android/binder/rust_binderfs.c
+++ b/drivers/android/binder/rust_binderfs.c
@@ -391,12 +391,6 @@ static int binderfs_binder_ctl_create(struct super_block *sb)
 	if (!device)
 		return -ENOMEM;
 
-	/* If we have already created a binder-control node, return. */
-	if (info->control_dentry) {
-		ret = 0;
-		goto out;
-	}
-
 	ret = -ENOMEM;
 	inode = new_inode(sb);
 	if (!inode)
@@ -431,7 +425,8 @@ static int binderfs_binder_ctl_create(struct super_block *sb)
 
 	inode->i_private = device;
 	info->control_dentry = dentry;
-	d_add(dentry, inode);
+	d_make_persistent(dentry, inode);
+	dput(dentry);
 
 	return 0;
 
-- 
2.47.3

