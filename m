Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C25E40628A
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 07:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472907; cv=none; b=qNMMKUr77mzrjzJxpni0DjlSLSTItDgOBbQ6rj+ot0kX5727jwUFc6o+kAMYEflukBjkR3Pf2Veld67Ufjukod0z8RY6/dXlD8i0fKN4SvEvSSYSA/rGDoMNCGPt1Wey8hOwBUOV5PCIdk9OfqbvVX9xFZ+O0i9xE9fEDpqqqPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472907; c=relaxed/simple;
	bh=/rTl/KNFx4LmRoUuBUnVeLBlfrdJi6Pr3ppMguNH8HI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HWtAoTwOPzmqID6YCJi48CDr2kot7z86cQ/38v9iVC3JNfFQD7C7Okrmtix0yiNvrXEBM74ul7xr0JZzdP/yS8H3Efk2FZLKMdhfDqGniH614mQXLMPTWQZu1NapJ8fzJYfD6/y1SqGnwutRGhpwRe6/5yiz4/uMzJhx3jwh7pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Aexh9xVH; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Aexh9xVH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=SJltqu92nAd1SHwY8+wr9tBd4GnJjBkdEwM4CB6G0k8=; b=Aexh9xVH6BPVZVviy2yRKPzf1b
	tqpK/oVAX7Z8tLKOk52ZagJb8wm9w6SbfBThKCXod4BArnVJjKAWgO/S300QBndg3+7B6ghQT5jhy
	x8MFTKwQXXbokJQCyRi9AXtiFFcfXKlEvM9f7HGDQpMmbtpK5FpwoRLgE60C2UPOVDOP9A1uLiTrU
	RBY4trltl+AqryYoEJ6eQdDGCncJhV5aviXXFZd5eSd99ASZdEw49vVhluNa+5RZLmkueFlvd7ZA8
	MS5WSqn1K1oeG2y8PDME+IoKCwy0IWFVRpdgOIb06jWsidmAwybanoenTiaQzBYLxZ8De6xDd7ZUw
	UMLUStDg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wUgKm-0000000CjEy-22O0;
	Wed, 03 Jun 2026 07:48:16 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 05/18] configfs_depend_prep(): pass configfs_dirent instead of dentry
Date: Wed,  3 Jun 2026 08:48:02 +0100
Message-ID: <20260603074815.3033766-9-viro@zeniv.linux.org.uk>
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

Again, the only thing it uses dentry for is dentry->d_fsdata; for the
recursive call the situation is the same as with configfs_detach_prep()
and the same observation about ->s_dentry->d_fsdata applies.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/configfs/dir.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index b456e4de25ab..a6b99bcbddbc 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -1093,15 +1093,12 @@ static int configfs_dump(struct configfs_dirent *sd, int level)
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
 
@@ -1109,8 +1106,7 @@ static int configfs_depend_prep(struct dentry *origin,
 		if ((child_sd->s_type & CONFIGFS_DIR) &&
 		    !(child_sd->s_type & CONFIGFS_USET_DROPPING) &&
 		    !(child_sd->s_type & CONFIGFS_USET_CREATING)) {
-			ret = configfs_depend_prep(child_sd->s_dentry,
-						   target);
+			ret = configfs_depend_prep(child_sd, target);
 			if (!ret)
 				goto out;  /* Child path boo-yah */
 		}
@@ -1131,7 +1127,7 @@ static int configfs_do_depend_item(struct dentry *subsys_dentry,
 
 	spin_lock(&configfs_dirent_lock);
 	/* Scan the tree, return 0 if found */
-	ret = configfs_depend_prep(subsys_dentry, target);
+	ret = configfs_depend_prep(subsys_dentry->d_fsdata, target);
 	if (ret)
 		goto out_unlock_dirent_lock;
 
-- 
2.47.3

