Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1103F9F56;
	Wed, 13 May 2026 11:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778671363; cv=none; b=Jbw4MxZpQ+7CQghAbHEwUk6x+cc7iQ24X4uidzg6TbSlcT97NWKLnNH0dPktwbIAgtDararwBs5J3zY0Xy59xX9E/mUqN3F3cMIi6oK5pv8YwwySosfT7MGzg3ZIaiTBDaPAxNDU/X+jawEcaAcguRsFMZbNLaG3sdQeHFSTTnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778671363; c=relaxed/simple;
	bh=p0NCUxLW5/lFSHG9MNpThep+4bYlHQO7IRftbA4CWE4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DfYRYxw+zPMqDxnExGA5BjFV0JLVvxYH0orN/xIrlnuh3dD5k0G6awFdSQrbak3lnBVs1s2G0KwIMfzNjvypJS4e0P6D5fl2giKi1t2FAARE/6oxM+iWIAVxYdSEAe2n541wlzRpPpkRdPvmwqa/TDEOrZs3og/TuDUAJROLpvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYb1P8hJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYb1P8hJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA055C2BCC7;
	Wed, 13 May 2026 11:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778671363;
	bh=p0NCUxLW5/lFSHG9MNpThep+4bYlHQO7IRftbA4CWE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mYb1P8hJMAF8kcoFifJ/FBIJWNqTXFWvdtJHtKF4oOmOXN1QDdUIZ4fMiiXVrQ1w9
	 0p8NY46480LolmXaMGtkwNBBIMx6EFYFnJwZfNUGpu2libvPbdm8xC4Xnw6rWIYslK
	 jBT0vy+h/VKslimZYl9i94JI45WPEE7cLfnOdd4c15quqs06kQ7UM87zpjbNo2b7q5
	 y2Y07FtUJUFGZjM5hkC6EBZ7tf01u81ahk+xEY/k+E+i3GQfSh7avFsSTBqAAm3fcD
	 Cbt907k39UeZLMXmhQHulOX8FKRVutac8j5FhWeKJtpaah67jx/iAeb+Vv3fVEN5NJ
	 sHs8cN3bws8Yw==
From: Namjae Jeon <linkinjeon@kernel.org>
To: sj1557.seo@samsung.com,
	yuezhang.mo@sony.com,
	brauner@kernel.org,
	djwong@kernel.org,
	hch@lst.de
Cc: linux-fsdevel@vger.kernel.org,
	anmuxixixi@gmail.com,
	dxdt@dev.snart.me,
	chizhiling@kylinos.cn,
	chizhiling@163.com,
	linux-kernel@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v3 11/11] exfat: make exfat_truncate() return error code
Date: Wed, 13 May 2026 20:21:56 +0900
Message-Id: <20260513112156.9122-12-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260513112156.9122-1-linkinjeon@kernel.org>
References: <20260513112156.9122-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert exfat_truncate() to return int, and make it return the error
code on failure. Update exfat_setattr() to handle the returned error
appropriately.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/exfat/file.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 6ae2f72621ab..2b650a73c5c8 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -292,7 +292,7 @@ int __exfat_truncate(struct inode *inode)
 	return 0;
 }
 
-static void exfat_truncate(struct inode *inode)
+static int exfat_truncate(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
@@ -315,6 +315,8 @@ static void exfat_truncate(struct inode *inode)
 	inode->i_blocks = round_up(i_size_read(inode), sbi->cluster_size) >> 9;
 write_size:
 	mutex_unlock(&sbi->s_lock);
+
+	return err;
 }
 
 int exfat_getattr(struct mnt_idmap *idmap, const struct path *path,
@@ -400,7 +402,7 @@ int exfat_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		 * __exfat_write_inode() is called from exfat_truncate(), inode
 		 * is already written by it, so mark_inode_dirty() is unneeded.
 		 */
-		exfat_truncate(inode);
+		error = exfat_truncate(inode);
 		up_write(&EXFAT_I(inode)->truncate_lock);
 	} else
 		mark_inode_dirty(inode);
-- 
2.25.1

