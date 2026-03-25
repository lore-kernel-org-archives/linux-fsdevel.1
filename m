Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0AF35AC28
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 06:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774420669; cv=none; b=d/8as9MK9Yp+lv3JdaXl7a+BzTZ2ep2UNUOvwQ36HeC8B+00fJ4lq/XQPyBBIgq0RUJdgufbDl3rA9BuVI5Fet7llDvAcNe7rIucXPfr+QH1oiayTI2MhNTjFy+vS1tz8huj7UgNxTPIc/085QBEQRbZNUQpbdj1lPVFVF6pX1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774420669; c=relaxed/simple;
	bh=nHod+BFG9InpKacMb1tsrR6w8qwj3gpBB7U1zxdjN50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O4M1Cs6ggs2iljnZmz17xs264+vx36XGtGqYMOHUZQwUxUnegFGUBsLMpVwCSAAmqOrU6fFO/0SrYFpCAavHG3vb4TqirB7lSjx7wWRKZdqIiKUO5ZpnThBio9ju0CeNZm3U/6LYitGiwTxrVOA+Kf1qYSzz5bSXo70JwdwdCKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HiKh2a2k; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HiKh2a2k"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=F3faI7PUGxkFFjVlYDbRbtXLQpgncFp9/oCX7fDtUGo=; b=HiKh2a2kcINrpiJVg0nnjlgV1s
	SRpGygcW8QjEZL3rp/UZaerK/LV/9D72s9DzwTUAv/NZAHq1pSfm0YYgXqgPAzpWmsAhiB4d0kslQ
	/wQV14kOP7VK9O00WjAHsFaxyODkizRi5yoCNJqOCJbBi23r4qWXsy+fouiE5C24MjYMi50t3Lybh
	Hm3voIgIFwhbGnPaj7u0PP60q3jnzOQW2kpzH1JggzAhXkC0IVFf6dKvcSxGR9b1eG6whjkqSP5WR
	xzbWLOx8TWHIaG1Qo7ZT8vb9WuzzYvKVc375gknzZiUE+WLhy3GN++Q+nd0dLgnnNkK12c/R3XwNY
	C35scezg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5Hs8-00000002nOY-38cf;
	Wed, 25 Mar 2026 06:37:45 +0000
From: Christoph Hellwig <hch@lst.de>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Sterba <dsterba@suse.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/5] proc: rename proc_notify_change to proc_setattr
Date: Wed, 25 Mar 2026 07:36:52 +0100
Message-ID: <20260325063711.3298685-6-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260325063711.3298685-1-hch@lst.de>
References: <20260325063711.3298685-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Make the function name match the method that it implements.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/proc/generic.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 501889856461..8bb81e58c9d8 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -115,8 +115,8 @@ static bool pde_subdir_insert(struct proc_dir_entry *dir,
 	return true;
 }
 
-static int proc_notify_change(struct mnt_idmap *idmap,
-			      struct dentry *dentry, struct iattr *iattr)
+static int proc_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
+		struct iattr *iattr)
 {
 	struct inode *inode = d_inode(dentry);
 	struct proc_dir_entry *de = PDE(inode);
@@ -151,7 +151,7 @@ static int proc_getattr(struct mnt_idmap *idmap,
 }
 
 static const struct inode_operations proc_file_inode_operations = {
-	.setattr	= proc_notify_change,
+	.setattr	= proc_setattr,
 };
 
 /*
@@ -364,7 +364,7 @@ const struct dentry_operations proc_net_dentry_ops = {
 static const struct inode_operations proc_dir_inode_operations = {
 	.lookup		= proc_lookup,
 	.getattr	= proc_getattr,
-	.setattr	= proc_notify_change,
+	.setattr	= proc_setattr,
 };
 
 static void pde_set_flags(struct proc_dir_entry *pde)
-- 
2.47.3

