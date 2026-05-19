Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED393B3C05
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 07:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779174399; cv=none; b=jzlVO/djdkzsfArawaJ0T0lPcW1qJR2YeioZEWuJmLvXvVqWGkyuJnEx58Yj4vUa/jhNtw4ZMO4VVjhG9ft6WJX9KN9dvd6RDy1gAGTdNqP6PCmscxECc/PxFVABVuq9X3jcX+SypqLEiZeDEua/TkXmq6dhD4so0zMdwvFglgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779174399; c=relaxed/simple;
	bh=PE7iQB6BwhybPJqx8EZaUis8Jr5el0Fl8JD+wHYONqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CWKyfPXzY2C5KKtJXq0DpiCCptFzgfHxfBnjw5cu/CdgkOI1tqfmEE9sGUmyg64HcgPS/zZvXmDFZGhSBsg7ggwkyX/cQSZHI1WcPaPJT8ipBQLfMJ1PvvMN0Q7erTm7sDYMc8gT48P3L4R71csZCSPmGBTxsXHM5bkH8yYGMFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=YJRWl6oL; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="YJRWl6oL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=2Hsw6TrzWi2VwWhvsEU2T5h7h2/8vDXWcwThmgpDhSw=; b=YJRWl6oLcDN7CVOVJhvu7raByj
	XFEfC6q5gPApzybg1IeCxlb6wqQHmNiS7g05P4/lnduVQbhm1W6/4cUvBFHpYxKArbPaCT44ZBUPV
	/GP0h6h288JyJaVYA9kkt/4zFD24iksYoxaTjNZV0gSw8UOmEpaFDRzqd1v+n6mK4miDxrt5z929P
	y3L+fpw8zMUXq80alIw5B4jaogjmgi0vtC7AWZ5TLUSpNAb5dp2O5socqm+iUvuv8ujLZ6C0V6iOu
	nYTqS1IydX9iwTvZAv46PrPNlxQOSOAOdO/mAUXKIJ7N0EtZpMLobXWZucA4lTlC7KjzmSdKdQm+Y
	HtHwJnAw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wPEXB-00000008UvY-3Get;
	Tue, 19 May 2026 07:06:33 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [RFC PATCH 05/14] configfs_do_depend_item(): pass configfs_dirent instead of dentry
Date: Tue, 19 May 2026 08:06:24 +0100
Message-ID: <20260519070633.2025485-6-viro@zeniv.linux.org.uk>
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

Again, the only thing it uses the argument for is its ->d_fsdata
and callers already have that - as the matter of fact, they are
passing ->s_dentry of that configfs_dirent, so that the function
could get it back as ->d_fsdata of that.  With nothing else in
dentry even looked at...

configfs_dirent in question is a directory one - in this case those
are subdirectories of root (aka roots of "subsystem" trees).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/configfs/dir.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 5219c4fd527e..e4b7eaa58d65 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -1093,7 +1093,7 @@ static int configfs_depend_prep(struct configfs_dirent *sd,
 	return ret;
 }
 
-static int configfs_do_depend_item(struct dentry *subsys_dentry,
+static int configfs_do_depend_item(struct configfs_dirent *subsys_sd,
 				   struct config_item *target)
 {
 	struct configfs_dirent *p;
@@ -1101,7 +1101,7 @@ static int configfs_do_depend_item(struct dentry *subsys_dentry,
 
 	spin_lock(&configfs_dirent_lock);
 	/* Scan the tree, return 0 if found */
-	ret = configfs_depend_prep(subsys_dentry->d_fsdata, target);
+	ret = configfs_depend_prep(subsys_sd, target);
 	if (ret)
 		goto out_unlock_dirent_lock;
 
@@ -1167,7 +1167,7 @@ int configfs_depend_item(struct configfs_subsystem *subsys,
 	}
 
 	/* Ok, now we can trust subsys/s_item */
-	ret = configfs_do_depend_item(subsys_sd->s_dentry, target);
+	ret = configfs_do_depend_item(subsys_sd, target);
 
 out_unlock_fs:
 	inode_unlock(d_inode(root));
@@ -1269,7 +1269,7 @@ int configfs_depend_item_unlocked(struct configfs_subsystem *caller_subsys,
 	}
 
 	/* Now we can execute core of depend item */
-	ret = configfs_do_depend_item(subsys_sd->s_dentry, target);
+	ret = configfs_do_depend_item(subsys_sd, target);
 
 	if (target_subsys != caller_subsys)
 out_root_unlock:
-- 
2.47.3

