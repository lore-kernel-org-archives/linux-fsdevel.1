Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0113530BB8D
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Jun 2026 06:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780728606; cv=none; b=ZYUw6PI2eQV6mD87+RK/AgNxs8gQw/IsYA1yruvi6BKpyXw//301ZQpqn/sGlzy7AasTa1xPlPsDW2LyB8Qxs2AszUTZ7mdaAmKsHuOuaZEAiPks9hNqiflY3MNE24nMnoLdkV7WVqjmw0l8Z27DIFAZdlxIjnYuDz6uFZh2Btc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780728606; c=relaxed/simple;
	bh=jSzg01ZsVGnNQKd+SUxm5aVrl0kRdw4tYyLru/qCuqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TGtpP9yEdS8c2Iwhel9FkSY4dB9SQfH8dOiAO+finNadcNnL/hVFc/s7sxyTpDrkgoiyZZgZTvUV9iEAk7sHGzEaiyeSCc1DTFOdT/lWlARu5N+hqvLjF40ZkIA9/fNhktk13z/q9z/znlTnaThdUYMfV4NHGuBdzP+MW5xf0oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=jyTypOjD; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="jyTypOjD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=NiH8W9ec3+qCU55/Df2TyPWYDg3sKFMoNIrKexqsxp4=; b=jyTypOjDkiHGlF43qSxPS0spKK
	zfxhcMmv+npv8cTklZZVa6zY7qzy7Car6mssc5XF2n+emLaDYy8+0to9pc1eZA6Et2ua9PD4RwS18
	NdxWmVzy8QHx9LJTz4X4UKdTyTwL4ZqRy6yK1rvKpAjLQZE1pyzeqSpNLvmrhLjyMqPtxmoge1oL8
	vRfIUeODICixHQBDj4/4igOoU8xCMkG4lawkJOggpjYAMchtyNAde3CkNvI2dgR2rOKzJIa026CQL
	2ZW7j2g0ueI6aVG/VzKuvvg6hfaq0PBt/qEcEzrR0nPLNtwOXIKgmSRu5NcMYZr16SH73U+mFSRFn
	ybT269uQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wVkr0-0000000BQM9-0ZnD;
	Sat, 06 Jun 2026 06:49:58 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Tyler Hicks <code@tyhicks.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 3/6] ecryptfs: use d_splice_alias() for ->lookup() return value
Date: Sat,  6 Jun 2026 07:49:53 +0100
Message-ID: <20260606064956.2722874-4-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260606064956.2722874-1-viro@zeniv.linux.org.uk>
References: <20260606064956.2722874-1-viro@zeniv.linux.org.uk>
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
 fs/ecryptfs/inode.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 546c1fe692c0..7aaf1913f9c6 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -350,11 +350,9 @@ static struct dentry *ecryptfs_lookup_interpose(struct dentry *dentry,
 	 */
 	lower_inode = READ_ONCE(lower_dentry->d_inode);
 
-	if (!lower_inode) {
-		/* We want to add because we couldn't find in lower */
-		d_add(dentry, NULL);
-		return NULL;
-	}
+	if (!lower_inode) /* We want to add because we couldn't find in lower */
+		return d_splice_alias(NULL, dentry);
+
 	inode = __ecryptfs_get_inode(lower_inode, dentry->d_sb);
 	if (IS_ERR(inode)) {
 		printk(KERN_ERR "%s: Error interposing; rc = [%ld]\n",
-- 
2.47.3

