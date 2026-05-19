Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D863B47C4
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 07:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779174399; cv=none; b=GkhcANmJ3Ss2QvETokgM5Qu1okk42SCluQUBFxvus2gpO5DpyYBpWOT1mVNuOQbcJYI2EXmXXtBe22ygyJIDfz0s0udPrOnaEFpKTS1SsxwZUuw94TPVNoHRx77OPEbHanRhmCMtp98PjZ/Kkk6Cq9AHiOhHGxPeQZ480mjrOZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779174399; c=relaxed/simple;
	bh=aZl/5XL1dNZSD4KlfnW8y89LWKpS1loskI5rKPTX5h4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CHHwpRzlEOjV9/g/PW8SduB2U+ZDhLtbiL39HPF113S2utLGS2LZmxRzJhFjiHDh94nxXCPFuEhEG30DywYz5I7aey7Q/jvmv0MkkPo5QEwgu8Issn4VyW53ef0c8qokWXbzXN/uFVSFocicI9Dt+SlBWdt7RL6tVUfdnkt0BoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=iugAJmY3; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="iugAJmY3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=d9YeWJ8RW+KqCdIuTm1V2nAxzOMMtQQrvmlNrkiRKzw=; b=iugAJmY3MmbKjcG/Kalypjih1j
	jDliSNdA8a+D/L9qRFc3NcHPwC5CIOFnGtfeAEJ1bYSvqG6NkzxmQds8kA3SWuyWcdpYuttLB/v24
	0GUZ3v5Er1F33tZVsVmuNDr2KJGQXyfbFbyKmQurg595FC0cTMvoyfQutSvPID9Dl4QSgMktkkI+O
	gr/dhSSDdlUxZeZ8n/lbA/V/NvboPnX48GMoHkv92ZpdFycyBGE087BYIFrA9e8z/3jUl6DP1B7Gw
	fKB2QBaaokg/CSpOaMmgllDNdcTBGCyayCnlGylLYhsgBYLNFc0bCaNAeI/9tYPLHv7sRSMOUn1SM
	a1Yt56HA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wPEXC-00000008Uvg-08kx;
	Tue, 19 May 2026 07:06:34 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [RFC PATCH 08/14] populate_attrs(): move cleanup to the sole caller
Date: Tue, 19 May 2026 08:06:27 +0100
Message-ID: <20260519070633.2025485-9-viro@zeniv.linux.org.uk>
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

... where it folds with configfs_remove_dir() into a call of
configfs_detach_item().  Note that at the early failure exit
(before we'd added any children) we were not calling detach_attrs()
only because there it would've been a no-op - nothing added,
nothing there to be removed.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/configfs/dir.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index d2a60429a545..395270cc3710 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -621,25 +621,23 @@ static int populate_attrs(struct config_item *item)
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
@@ -824,6 +822,13 @@ static void link_group(struct config_group *parent_group, struct config_group *g
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
@@ -856,7 +861,7 @@ static int configfs_attach_item(struct config_item *parent_item,
 			 * we must lock them as rmdir() would.
 			 */
 			inode_lock(d_inode(dentry));
-			configfs_remove_dir(item);
+			configfs_detach_item(item);
 			d_inode(dentry)->i_flags |= S_DEAD;
 			dont_mount(dentry);
 			inode_unlock(d_inode(dentry));
@@ -867,13 +872,6 @@ static int configfs_attach_item(struct config_item *parent_item,
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

