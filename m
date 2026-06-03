Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF0640242E
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 07:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472908; cv=none; b=o2yeGgm8MMLqneSBNci7UCyLko80Fytpwi/iMurNlpCoOKHLYUsohV6DLZ7J0WEoX1pmeYSMJI4fEyJs+sqWPWOUnaUeSRr2NIQZ0W60qy2GzZaoxcpp7pUROkQr1vpj6QtpGEHstc4Gs3INeKhMTwSVtVo32sAH6SHBH6tutA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472908; c=relaxed/simple;
	bh=GbpaYMF9+bzF+USmw3e1M54eU+NCMn3wk6zJi9rToe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZjQodYtbLA0X/RFcjKP7JxVqeALriHKVe9zKRzpdARI7UJAenEdLxkRr5h9Yv/vMmPdOUHo/KA2Av+/XPwdXDjKCJGuFNZmGjnKgtmAxpHReHV0qTbooxbL7ptLtJcmkG8DKTLFlaZ++wgyrp0GySGmi8pERl1ccCa86ucEqpNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=qeSfw8SP; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="qeSfw8SP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=eOz4xFITT6vPJRmnR9iXe8KHeLGoYFpdhkx1FG7CnTM=; b=qeSfw8SP6+RoGWRKyEFQa5CBQw
	iXwXb0LA03gnbSop4wzQRzRyFFVijmrITFOD6rzTHPkG9W6PL/TzedVBcDDEzJWy/JlnS/ao9uwUJ
	ydh2hJzU9EsrFzyhuVmDoGelgXE70zVFphXaW+nmffDifOT1JQO2cctxWhUl/XB9sqVM9BTsr9ORC
	tIHVcSOLClQA4U/N1AdDDAAgoNL1gNglleSXVry4X51JkB27BtIRlWRWiUeSrO2KoZxz9KMukDoci
	3M+TYVLeaAbcQ2zp5GhZ4IVLY+AsfLwC4gvpoCeJhKkL4JLp4YYGxjcsi0qGOM4QP9Hug4DBLLcSo
	3dJziKAw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wUgKn-0000000CjFt-0lkg;
	Wed, 03 Jun 2026 07:48:17 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 09/18] populate_attrs(): move cleanup to the sole caller
Date: Wed,  3 Jun 2026 08:48:06 +0100
Message-ID: <20260603074815.3033766-13-viro@zeniv.linux.org.uk>
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

... where it folds with configfs_remove_dir() into a call of
configfs_detach_item().  Note that at the early failure exit
(before we'd added any children) we were not calling detach_attrs()
only because there it would've been a no-op - nothing added,
nothing there to be removed.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/configfs/dir.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 01de8ef5fbe6..6580c919ee5a 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -643,25 +643,23 @@ static int populate_attrs(struct config_item *item)
 			if (ops && ops->is_visible && !ops->is_visible(item, attr, i))
 				continue;
 
-			if ((error = configfs_create_file(item, attr)))
-				break;
+			error = configfs_create_file(item, attr);
+			if (error)
+				return error;
 		}
 	}
-	if (!error && t->ct_bin_attrs) {
+	if (t->ct_bin_attrs) {
 		for (i = 0; (bin_attr = t->ct_bin_attrs[i]) != NULL; i++) {
 			if (ops && ops->is_bin_visible && !ops->is_bin_visible(item, bin_attr, i))
 				continue;
 
 			error = configfs_create_bin_file(item, bin_attr);
 			if (error)
-				break;
+				return error;
 		}
 	}
 
-	if (error)
-		detach_attrs(item);
-
-	return error;
+	return 0;
 }
 
 static int configfs_attach_group(struct config_item *parent_item,
@@ -850,6 +848,13 @@ static void link_group(struct config_group *parent_group, struct config_group *g
 		link_group(group, new_group);
 }
 
+/* Caller holds the mutex of the item's inode */
+static void configfs_detach_item(struct config_item *item)
+{
+	detach_attrs(item);
+	configfs_remove_dir(item);
+}
+
 /*
  * The goal is that configfs_attach_item() (and
  * configfs_attach_group()) can be called from either the VFS or this
@@ -882,7 +887,7 @@ static int configfs_attach_item(struct config_item *parent_item,
 			 * we must lock them as rmdir() would.
 			 */
 			inode_lock(d_inode(dentry));
-			configfs_remove_dir(item);
+			configfs_detach_item(item);
 			d_inode(dentry)->i_flags |= S_DEAD;
 			dont_mount(dentry);
 			inode_unlock(d_inode(dentry));
@@ -893,13 +898,6 @@ static int configfs_attach_item(struct config_item *parent_item,
 	return ret;
 }
 
-/* Caller holds the mutex of the item's inode */
-static void configfs_detach_item(struct config_item *item)
-{
-	detach_attrs(item);
-	configfs_remove_dir(item);
-}
-
 /* Caller holds the mutex of the group's inode */
 static void configfs_detach_group(struct config_item *item)
 {
-- 
2.47.3

