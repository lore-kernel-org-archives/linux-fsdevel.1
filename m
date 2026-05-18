Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60CC3F8889;
	Mon, 18 May 2026 11:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779104955; cv=none; b=APQHlq+ziyWVvygxEMDTcotc0rc/q0CqSUMkJnaMRCP9K3wc1daEhxj4TBjt65kmVcw1y1AttIo5z4DZ3yUWphxMsqyc4Uj0sou4BIEqHnwLdtK1PxGOxLM2TwhAuBuUedtMxgTqzuvPjq4McLhEqIGwbo3eWVUY+mseDtXS0V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779104955; c=relaxed/simple;
	bh=hzb+y/Rb6afK82CIBGhJEoM0p7JFocu3IrIsx6m+2DE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cNZShiPNtng3TwbK5inppJcJTAroRV5/as8Ny8PXG8skb3GqeQ5s0DnS9wTt7e/mMOf7BEX/VP8TfUSUPqRPgA71kPbBK0UL7UL5nZzqH/X/oY4QfLteQKI5J89gN0FUI3R8wco6bqMvb/+JnmTkEbKFpLYGteWIqIlBv39G12o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhMr9JQg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhMr9JQg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78092C2BCB7;
	Mon, 18 May 2026 11:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779104954;
	bh=hzb+y/Rb6afK82CIBGhJEoM0p7JFocu3IrIsx6m+2DE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fhMr9JQgJgWJhidgEFNHtqL3ezIyWIMClg4X8XS3vFVWfTcBkYqeRQcstHKj/UMI+
	 THxQs/VOaFejNYpF3J9O99OLvseA4XrttnYlgtzjOrup7wGOMh6OEYj4OgeKBLX5tT
	 6QBG/7z4zbNnhneDazlouaPL/y6WHqri3/dNSEyjdOzUcp6CeEsmErwAGshWrZtfHj
	 cuV+vpRDwLxJc4/PmQa5ZLPp/qYmNXAXJlOT/O0Kprxui/DVxJannylK1L/mbzNdxX
	 xCh0d/WJpURdOucudonoYay6X19o6UOL6/BZ2aQIAIz/AaganvdAl/M4liX+R6/ftb
	 BQVWem2hMYT+w==
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
	charsyam@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v4 11/11] exfat: make exfat_truncate() return error code
Date: Mon, 18 May 2026 20:47:05 +0900
Message-Id: <20260518114705.9601-12-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260518114705.9601-1-linkinjeon@kernel.org>
References: <20260518114705.9601-1-linkinjeon@kernel.org>
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

Acked-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/exfat/file.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index d9c4e8dd9fd8..1271202b35ed 100644
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

