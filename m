Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3937A4028DC
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 07:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472905; cv=none; b=KfuN1nDWgC4xL4NoSQnWsdq+aT4cqkAhE9EzaA8JzDrKac541QNJl7qKx0M8MwFCMDj3VHnzXct3p2eVtiTAxQmgE9iLkL1MjjrOQH8cxqY5xv4zcSLdD2WntdqARVPcSxnZoNYo1zd1O7QZ5V1lP4uxLvgGBL0xeg3v6R0E93o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472905; c=relaxed/simple;
	bh=F7a8mI5NWwCjV3j/t9eteHDmwMdFd3gBCqoEG03TH/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XRlD4/10eSAcfr8hvrLi4lkTDZonvWxJ61PXix1smghidQWQZA6DTIA24L+xDGPulY6P0CypmU0TFoS/6Xq8y0/nv7P+KGCssCivQOqGcd4gqc6ZxEOm6V0u0m8Kaa4T/MS6fdg39vQnoJlZXOJBc3kfdCDfNNw2QCcfmEgMQ0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=FQHkFXFA; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="FQHkFXFA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=53gGgzKjHyiXDtf1irK9VXmLzlwuyPX8ABe+sC1CVcY=; b=FQHkFXFAx8/pdUiLGSg6XWP4jQ
	oDe1rvVzEffox7R8N+SbJWQN3bzrigCpAZCYt27EliUZqIqMcFhACxSr+qnZ/TJEEbm0ZCq6wGk8N
	q7UG192E5oglXgk5Wd/AVmvI9qUXjXdJ8LZjc2MSQk0DByuosG4I+pkM90E+9ZAmUaL5qpZf8ETV0
	cgo0N9x5DmF0uRG3DQsjj2XMZx0zRpi/YHfxgRSAYskle/SwSoLEiZTmbPVRKYNg0aTEH0gCtJ96A
	/mGeHFr245su5mCnvF0tenfY+9pSFLq7AwygJoKrPVA9+zVDt4xa44IPaflGNlQtL87tiOvPZ5Gz3
	/R9h551g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wUgKm-0000000CjEK-0O7U;
	Wed, 03 Jun 2026 07:48:16 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 3/3] configfs: expand the call of simple_rmdir()
Date: Wed,  3 Jun 2026 08:47:59 +0100
Message-ID: <20260603074815.3033766-6-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/configfs/dir.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 273e43adc8b7..775496add849 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -766,15 +766,24 @@ static void configfs_detach_item(struct config_item *item)
 {
 	struct dentry *dentry;
 	struct dentry *parent;
+	struct inode *dir, *inode;
 
 	detach_attrs(item);
 
 	dentry = dget(item->ci_dentry);
 	parent = dget(dentry->d_parent);
+	dir = d_inode(parent);
+	inode = d_inode(dentry);
 
 	configfs_remove_dirent(dentry);
-	simple_rmdir(d_inode(parent), dentry);
-
+	if (simple_empty(dentry)) {
+		drop_nlink(d_inode(dentry));
+		inode_set_mtime_to_ts(dir,
+			      inode_set_ctime_to_ts(dir, inode_set_ctime_current(inode)));
+		drop_nlink(inode);
+		dput(dentry);
+		drop_nlink(dir);
+	}
 	dput(parent);
 	/**
 	 * Drop reference from dget() on entrance.
-- 
2.47.3

