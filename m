Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C6C31F9B9
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 05:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780636156; cv=none; b=p1j1BSvn9u4JVThm+qQC0ryxoiYXYAfUn1QAynIlRlYOrJ986r3IIa0FZS/pT1WPY/LHOlrzxAtFONNLOLyOgr+etrfnqbWmRhfyQ71RyGtsFjH3okl8slKIFg6RJv9V5XtB44HYMdYiGlTvx29quhB1VNDIQsxzER+EAiSf0/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780636156; c=relaxed/simple;
	bh=s3lSnvqRCNgUSg7Pdogw+zbhjajW1VZjE9xHLzS1Rng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EN2PBvy8Y9L93gp00cuBTjFyfRRKZyA28+0nHHcy5G15aviaE/73oDjgLvrOpm3dZcGNHWH6of2IJkVDmabBrAYYl+FJHNC7u8rCxTSGj0YWOu2xV60nX5kunuOWMNrPij4/GwAN5Ea7ftonyfF3ZpmjhLKmWq4+ZQnScTFOg1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=F/7/elId; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="F/7/elId"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=VBpX1Pm6Z7E85HIs3A9LTpCRNH8bJc0q1utfEcP4b7U=; b=F/7/elId7E4pnkOJPxzrCU+f9H
	cKFhWQ3AiC7Ip7yfBNV+dLpJ/fyDbZ8ianhh+yddgJqsGzg7ZK+GeMnabqAnm3U5rEHeTH5Zkagqd
	Vk65Y8F2w/5+b8IesQnTKqruitnKCucRz4Lr4/Sj11GzEBFKmqImDVPuEg1nIQO2Vkb7g6JRoCLlu
	R2aj1zztz7fOpgYkCDQ/OwDmo0TpzhrfL6Jz6MCH5vOgmgnNZsq1Nmp8rUdxi9Wi98FIfRoUzkO/7
	2zW92//oMR42l5q+mGRQkou79ARvm8yyh65/bZUFenkmRESOa9G5w2FpDf8rke8RKvK8nHE3DXEy4
	EQaEbn5w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wVMnw-00000005TsV-0h2E;
	Fri, 05 Jun 2026 05:09:12 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Subject: [PATCH v2 06/22] make to_shrink_list() return whether it has moved dentry to list
Date: Fri,  5 Jun 2026 06:08:54 +0100
Message-ID: <20260605050910.1306432-7-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605050910.1306432-1-viro@zeniv.linux.org.uk>
References: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
 <20260605050910.1306432-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

... and make it check the refcount for being zero in addition to
dentry not being on a shrink list already.  Simplifies the callers...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 40031b806b73..7a0c8349b5a1 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -988,14 +988,17 @@ void d_make_discardable(struct dentry *dentry)
 }
 EXPORT_SYMBOL(d_make_discardable);
 
-static void to_shrink_list(struct dentry *dentry, struct list_head *list)
+static bool to_shrink_list(struct dentry *dentry, struct list_head *list)
 __must_hold(&dentry->d_lock)
 {
-	if (!(dentry->d_flags & DCACHE_SHRINK_LIST)) {
+	if (likely(!dentry->d_lockref.count &&
+	    !(dentry->d_flags & DCACHE_SHRINK_LIST))) {
 		if (dentry->d_flags & DCACHE_LRU_LIST)
 			d_lru_del(dentry);
 		d_shrink_add(dentry, list);
+		return true;
 	}
+	return false;
 }
 
 void dput_to_list(struct dentry *dentry, struct list_head *list)
@@ -1180,8 +1183,7 @@ struct dentry *d_find_alias_rcu(struct inode *inode)
 void d_dispose_if_unused(struct dentry *dentry, struct list_head *dispose)
 {
 	spin_lock(&dentry->d_lock);
-	if (!dentry->d_lockref.count)
-		to_shrink_list(dentry, dispose);
+	to_shrink_list(dentry, dispose);
 	spin_unlock(&dentry->d_lock);
 }
 EXPORT_SYMBOL(d_dispose_if_unused);
@@ -1589,11 +1591,9 @@ static enum d_walk_ret select_collect(void *_data, struct dentry *dentry)
 	if (data->start == dentry)
 		goto out;
 
-	if (!dentry->d_lockref.count) {
+	if (dentry->d_lockref.count <= 0) {
 		to_shrink_list(dentry, &data->dispose);
 		data->found++;
-	} else if (dentry->d_lockref.count < 0) {
-		data->found++;
 	}
 	/*
 	 * We can return to the caller if we have found some (this
@@ -1623,17 +1623,12 @@ static enum d_walk_ret select_collect2(void *_data, struct dentry *dentry)
 	if (data->start == dentry)
 		goto out;
 
-	if (!dentry->d_lockref.count) {
-		if (dentry->d_flags & DCACHE_SHRINK_LIST) {
+	if (dentry->d_lockref.count <= 0) {
+		if (!to_shrink_list(dentry, &data->dispose)) {
 			rcu_read_lock();
 			data->victim = dentry;
 			return D_WALK_QUIT;
 		}
-		to_shrink_list(dentry, &data->dispose);
-	} else if (dentry->d_lockref.count < 0) {
-		rcu_read_lock();
-		data->victim = dentry;
-		return D_WALK_QUIT;
 	}
 	/*
 	 * We can return to the caller if we have found some (this
-- 
2.47.3

