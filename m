Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664E140242F
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 07:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472908; cv=none; b=Rq74yB+Lm1KfD3D5B7thHyTEJkk8ZaXN7dTTD9Im2V5JUVwFiKK8A2YslzlUNE4yzovzwFc0qXIzqEMw+az8K3sPsRYe1HB7YCChtzmauMsrM9rPuqGfMJhmIWqAHVKPssBbwub93WuMRlplnU1svTNnQFgW0ltVk2+3Kt2rNCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472908; c=relaxed/simple;
	bh=fCZwFdtV0r5k4xU2U8NR+MaPT1DrEUmxc+QPOj3rhDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pMBA+RFp6u9VZRZSH9nn21S/irNAUGXXQnSWZ7BFnH1pEICS73ciB2mdd3l6iLvslRfIZ2WcjnKaGEAhzdQAnb2pJJA1StSsDfBAjeb0KelJNlYDl6EuReqEBYtKB4T1kiDJAIFHa3hfcQ9qWODcKQQRHeyFqBEKSXgCDdzTC1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ASxfxwjq; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ASxfxwjq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=uO+xq4U1UqHk8n/YmgBUetHHU8Pxk2VCRfuHcf6eqL0=; b=ASxfxwjqXsnLWYi/escfr5l0xe
	wZxBiy5HzGW3jf6MHCpiJGpjOnzg7jp6Q9jDPYSVKL05v7edQsSbDFisG3ngf/Joa/7Cme0Oi8nVP
	Viu7vhV/kut5/y/oFpevcZlLJp3cN0v69nUkdBsV1G3G/nrKLQZe6DYx7zEwxxRj5S+4gZNQ3fEy0
	lJquLg1RfV73nnyoalTUKEs1jWPutTyUdgPGEZ1mjO+4ULptaCnscFeNSoNKyY8Nu9DLf1vx9h5kf
	JaYZlKDJYDxIqSGmZC/ieaZ1mWkP0ID314ojTkD2ba2Yn4HfIyeS91xA1CjuQfksGUQklzOw/CKG8
	+nMc+pxQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wUgKm-0000000CjFA-2b4v;
	Wed, 03 Jun 2026 07:48:16 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 07/18] configfs_detach_rollback(): pass configfs_dirent instead of dentry
Date: Wed,  3 Jun 2026 08:48:04 +0100
Message-ID: <20260603074815.3033766-11-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603074815.3033766-1-viro@zeniv.linux.org.uk>
References: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
 <20260603074815.3033766-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

same story as with configfs_detach_prep() this function is undoing.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/configfs/dir.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index c6055a626bef..c420191610c3 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -563,16 +563,15 @@ static int configfs_detach_prep(struct configfs_dirent *parent_sd, struct dentry
  * Walk the tree, resetting CONFIGFS_USET_DROPPING wherever it was
  * set.
  */
-static void configfs_detach_rollback(struct dentry *dentry)
+static void configfs_detach_rollback(struct configfs_dirent *parent_sd)
 {
-	struct configfs_dirent *parent_sd = dentry->d_fsdata;
 	struct configfs_dirent *sd;
 
 	parent_sd->s_type &= ~CONFIGFS_USET_DROPPING;
 
 	list_for_each_entry(sd, &parent_sd->s_children, s_sibling)
 		if (sd->s_type & CONFIGFS_USET_DEFAULT)
-			configfs_detach_rollback(sd->s_dentry);
+			configfs_detach_rollback(sd);
 }
 
 /*
@@ -1537,7 +1536,7 @@ static int configfs_rmdir(struct inode *dir, struct dentry *dentry)
 		if (!ret) {
 			ret = configfs_detach_prep(sd, &wait);
 			if (ret)
-				configfs_detach_rollback(dentry);
+				configfs_detach_rollback(sd);
 		}
 		spin_unlock(&configfs_dirent_lock);
 		mutex_unlock(&configfs_symlink_mutex);
@@ -1558,7 +1557,7 @@ static int configfs_rmdir(struct inode *dir, struct dentry *dentry)
 	frag = sd->s_frag;
 	if (down_write_killable(&frag->frag_sem)) {
 		spin_lock(&configfs_dirent_lock);
-		configfs_detach_rollback(dentry);
+		configfs_detach_rollback(sd);
 		spin_unlock(&configfs_dirent_lock);
 		config_item_put(parent_item);
 		return -EINTR;
-- 
2.47.3

