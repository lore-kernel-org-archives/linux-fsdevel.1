Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D324028EC
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 07:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472910; cv=none; b=MzwG14ti5NI+AJXiqnL+IA2consb8Jq9Yt2MGqBCVLee9XaQE6zmHpEkWVRDlKh80doQa5Ln4Nce5wvHGTwc7PLU30+6BqBxElzBAeIloRsxEFRY/bQ9f1cfJBplJOrrU9dfnsDFuME1BtxOVC267+EJISiW5FIQ+6lf8IPNPyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472910; c=relaxed/simple;
	bh=KcgCUgijIOzKAhePrgkCmkCwCRYnCm71DuHYQjneCnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z5uPgN9lhACNj0Ezj2Toiq4CHG/eABYjuRNSiQUyulmBL4d6eHjx2Wv0X5grRZHbM/DR+suDkaU4XCcWFbu9YG0e5DWzHRrXcUJkjwrqKq6yl3cJAJxKriyVEoN8lwTIHEDRNL4hG69HAui9wJFmKYpgUK5MvfAuUa2mufwtJvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=k5rTJMvA; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="k5rTJMvA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=CZxfIE7f8psSR+RzXS8A3uRapwbom/tKdXbR9th5aIo=; b=k5rTJMvANkkB/0dod8Mpjb5ouw
	6MVCPCntzz37bpHiZe1i8OGsLpVisZkKy5DlmIn7ThBg4V1blia6j7lSIgqPs2Jw+AxoWxUAi1k56
	jgzf9Z+q4uVsn0+J8UZafv//iR8jYlU5alz5wtaPVXa+s/19yLUZbRMUtIf82ompZtLMeRartOKuq
	JeNrKJ62z8CZnF7Js9jTpHXmnXDvx/zBU8l2ZXcz2aq9+asLBojb9j6gCkbcHdW6khqpZwOho2jke
	jqd9TK4fK4q4d5jdfKmSrViDmObTwX1ceZ7CmPdQGARoVYtCPyKXhiPqGVhtbjV5zv/8tExz8qNkm
	wtEjcxSg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wUgKo-0000000CjH6-2GvL;
	Wed, 03 Jun 2026 07:48:18 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 14/18] kill configfs_drop_dentry()
Date: Wed,  3 Jun 2026 08:48:11 +0100
Message-ID: <20260603074815.3033766-18-viro@zeniv.linux.org.uk>
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

Fold into the only remaining user, don't bother with the timestamps
of parent - we are going to rmdir it shortly anyway, which will
override those.

Fix the locking of inode, while we are at it - updating the link
count and timestamps ought to be done with the inode locked.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/configfs/configfs_internal.h |  1 -
 fs/configfs/dir.c               | 24 +++++++++++++++++++++++-
 fs/configfs/inode.c             | 22 ----------------------
 3 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/fs/configfs/configfs_internal.h b/fs/configfs/configfs_internal.h
index 0b969d0eb8ff..acdeea8e2d69 100644
--- a/fs/configfs/configfs_internal.h
+++ b/fs/configfs/configfs_internal.h
@@ -76,7 +76,6 @@ extern int configfs_make_dirent(struct configfs_dirent *, struct dentry *,
 extern int configfs_dirent_is_ready(struct configfs_dirent *);
 
 extern const unsigned char * configfs_get_name(struct configfs_dirent *sd);
-extern void configfs_drop_dentry(struct configfs_dirent *sd, struct dentry *parent);
 extern int configfs_setattr(struct mnt_idmap *idmap,
 			    struct dentry *dentry, struct iattr *iattr);
 
diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 479d37b8d806..4a4bad1741cf 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -581,12 +581,34 @@ static void detach_attrs(struct dentry *dentry)
 
 	spin_lock(&configfs_dirent_lock);
 	for (sd = next_dirent(parent_sd, NULL); sd; sd = next) {
+		struct dentry *child;
+
 		next = next_dirent(parent_sd, sd);
 		if (!(sd->s_type & CONFIGFS_NOT_PINNED))
 			continue;
 		list_del_init(&sd->s_sibling);
+		child = sd->s_dentry;
+		if (child) {
+			spin_lock(&child->d_lock);
+			if (simple_positive(child)) {
+				dget_dlock(child);
+				__d_drop(child);
+				spin_unlock(&child->d_lock);
+			} else {
+				spin_unlock(&child->d_lock);
+				child = NULL;
+			}
+		}
 		spin_unlock(&configfs_dirent_lock);
-		configfs_drop_dentry(sd, dentry);
+		if (child) {
+			struct inode *inode = child->d_inode;
+
+			inode_lock_nested(inode, I_MUTEX_NONDIR2);
+			inode_set_ctime_current(inode);
+			drop_nlink(inode);
+			inode_unlock(inode);
+			dput(child);
+		}
 		configfs_put(sd);
 		spin_lock(&configfs_dirent_lock);
 	}
diff --git a/fs/configfs/inode.c b/fs/configfs/inode.c
index bc507b720a01..3c26b6c443be 100644
--- a/fs/configfs/inode.c
+++ b/fs/configfs/inode.c
@@ -195,25 +195,3 @@ const unsigned char * configfs_get_name(struct configfs_dirent *sd)
 	}
 	return NULL;
 }
-
-
-/*
- * Unhashes the dentry corresponding to given configfs_dirent
- * Called with parent inode's i_mutex held.
- */
-void configfs_drop_dentry(struct configfs_dirent * sd, struct dentry * parent)
-{
-	struct dentry * dentry = sd->s_dentry;
-
-	if (dentry) {
-		spin_lock(&dentry->d_lock);
-		if (simple_positive(dentry)) {
-			dget_dlock(dentry);
-			__d_drop(dentry);
-			spin_unlock(&dentry->d_lock);
-			__simple_unlink(d_inode(parent), dentry);
-			dput(dentry);
-		} else
-			spin_unlock(&dentry->d_lock);
-	}
-}
-- 
2.47.3

