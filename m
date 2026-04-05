Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F1D2F5498
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Apr 2026 02:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775355102; cv=none; b=VFpqJc2sULGem5VgSiHbhshRvwvMdadLeZGZUDjCsqd4JRbid5ykoXAQdrfkDaOQhtSlLLjANFWvBxjrhaRdxMJMBm35YJ69nzg+doz3ny2r9VK+rACzq6nm7NkFRKEJLRP5EPuRsx5F2rJqhPGJjXsada3ZeCPeG497/ejSCoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775355102; c=relaxed/simple;
	bh=Rmg6rx5xI61j/8Yx7IPvAZc8QlXw/DnkZBfn0arLrK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AoV7yId7i9PAqoNvdiQWtCs5Pl/TOThC3lenG8uj/W4MwRvSeP6Ym+qDWRidDeSu058dfi5ezQ5ayDreWLXLMCx3GZUdf+cFvkn1TOfWF0k2g1GuzBRDIisNiYlAU7A34fAwWLeut6O2JnNKIk39+3wXCDAhMcLJd5Nz+SiEkN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=HImUstYf; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="HImUstYf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=xra5DuOYe4XmkntuHoNftboKFeTW8xht8zzwfnotSto=; b=HImUstYfdcx1RC3GMZzSX6UO+t
	mcvMBC7MqfWv0TZUdRMxeO6g+KEqteA2QihLUu6t8W7qU9qJwQZrcTNAEQnFFb5kFuC+U9WuLtTu1
	nUx2Zu7hu0YQTQL7NdETBkQj4EvSA4KLvCz9whSzxfuE0719kfd8qrBOrEmLIV0nCM8xoOJ0MYzP8
	hIm1tu3rfutMBOktoMlrYuuHMHaP4GZQY3COwUEx1XJmjd85Zs5pkTKR2k1khy9qAl5wwzvpIoTp4
	Fxa+7+1LicssTfZThgD4mBQV12hMjYPho72p3ppSsdcnKqkP/L9TOoL33ZvjWYeMyHkJD/U+dfRTY
	3wZ1MIvw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w9D1A-0000000C1gX-0Tpu;
	Sun, 05 Apr 2026 02:15:16 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jan Harkes <jaharkes@cs.cmu.edu>
Subject: [PATCH 2/3] sanitize coda_dentry_delete()
Date: Sun,  5 Apr 2026 03:15:14 +0100
Message-ID: <20260405021515.2866402-3-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260405021515.2866402-1-viro@zeniv.linux.org.uk>
References: <20260405021515.2866402-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

d_really_is_negative(dentry) is a check for d_inode(dentry) being NULL;
rechecking that is pointless (and no, it can't race - the caller is holding
->d_lock, so ->d_inode is stable)

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/coda/dir.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/coda/dir.c b/fs/coda/dir.c
index 799c3d3ea12c..2a5048bab635 100644
--- a/fs/coda/dir.c
+++ b/fs/coda/dir.c
@@ -479,18 +479,12 @@ static int coda_dentry_revalidate(struct inode *dir, const struct qstr *name,
  */
 static int coda_dentry_delete(const struct dentry * dentry)
 {
-	struct inode *inode;
-	struct coda_inode_info *cii;
-
-	if (d_really_is_negative(dentry)) 
-		return 0;
+	struct inode *inode = d_inode(dentry);
 
-	inode = d_inode(dentry);
 	if (!inode)
-		return 1;
+		return 0;
 
-	cii = ITOC(inode);
-	if (cii->c_flags & C_PURGE)
+	if (ITOC(inode)->c_flags & C_PURGE)
 		return 1;
 
 	return 0;
-- 
2.47.3

