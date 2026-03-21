Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEA634753E;
	Sat, 21 Mar 2026 08:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774080109; cv=none; b=l3niuLO2nuNYl7pB3QDefnpS16rn4cJkkyCZvhqSBX3hAzPMb2aeqAMrKM0WZYIeM9wyjDi0tgvXNWInSMRERouZs5JRSAFEXUYEgVCroJj1thkiSSnhPr4MGQBYxf1qTYjHebQYuD8FHqH4k9N7fOluq+L0r0xU6p3gTn0VQ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774080109; c=relaxed/simple;
	bh=5FIgDZrI2DcKVIUXdYi5DSqUD3YRSikuzTmh/in095w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FINM1qj5kWb8HodClfvjktdBFwggZVqGFSyZBIaRk+kYfGBsU36P4yK9BTt50FRh/QsoWTSC9YoVS7lAy3p1InV8dq/efTE0GULPWeKF9RVz7dMAVxJClPXTmMDwuQORor2xdzHq4MkmpjVeHvcqqqL6qMvub9aeF9jBF373zYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=dHg4tLDW; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="dHg4tLDW"
Received: from DESKTOP-SUEFNF9.tailb3ad3b.ts.net (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 37c8ce11f;
	Sat, 21 Mar 2026 16:01:35 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: slava.dubeyko@ibm.com
Cc: akpm@linux-foundation.org,
	frank.li@vivo.com,
	glaubitz@physik.fu-berlin.de,
	jianhao.xu@seu.edu.cn,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	slava@dubeyko.com,
	zilin@seu.edu.cn
Subject: [PATCH v4 2/2] hfsplus: extract hidden directory search into a helper function
Date: Sat, 21 Mar 2026 16:01:30 +0800
Message-Id: <20260321080130.1292216-3-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260321080130.1292216-1-zilin@seu.edu.cn>
References: <20260321080130.1292216-1-zilin@seu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d0f69f36c03a1kunmf3bcb71e291d78
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaQ09MVk8eHhpLTx5JQh5OTFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZS1VLVUtVS1kG
DKIM-Signature: a=rsa-sha256;
	b=dHg4tLDW4+rcHUEUj8PmN7aysJ776Rmb2Q5kxBdpUJbuka8OywblPsCb3V+7XMwZdsRNGU15FNmTc9gUKS485l4JvesOvnexyf/SuUIL+wBrsMTenKbqEhGBQ5KR6prfRc1QRgXSERBBdISh3jeKRG3ksjMnLXRG0zvPhEHhB84=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=zIy8kKxLCRdVVdT2e6dDK/SKw8y1CJWatnez5CnsCs8=;
	h=date:mime-version:subject:message-id:from;

In hfsplus_fill_super(), the process of looking up the hidden directory
involves initializing a catalog search, building a search key, reading
the b-tree record, and releasing the search data.

Currently, this logic is open-coded directly within the main superblock
initialization routine. This makes hfsplus_fill_super() quite lengthy
and its error handling paths less straightforward.

Extract the hidden directory search sequence into a new helper function,
hfsplus_get_hidden_dir_entry(). This improves overall code readability,
cleanly encapsulates the hfs_find_data lifecycle, and simplifies the
error exits in hfsplus_fill_super().

Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 fs/hfsplus/super.c | 44 ++++++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index f396fee19ab8..5ea2d1852591 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -424,12 +424,35 @@ void hfsplus_prepare_volume_header_for_commit(struct hfsplus_vh *vhdr)
 	vhdr->attributes |= cpu_to_be32(HFSPLUS_VOL_INCNSTNT);
 }
 
+static inline int hfsplus_get_hidden_dir_entry(struct super_block *sb,
+					       const struct qstr *str,
+					       hfsplus_cat_entry *entry)
+{
+	struct hfs_find_data fd;
+	int err;
+
+	err = hfs_find_init(HFSPLUS_SB(sb)->cat_tree, &fd);
+	if (unlikely(err))
+		return err;
+
+	err = hfsplus_cat_build_key(sb, fd.search_key, HFSPLUS_ROOT_CNID, str);
+	if (unlikely(err))
+		goto free_fd;
+
+	err = hfs_brec_read(&fd, entry, sizeof(*entry));
+	if (err)
+		err = -ENOENT;
+
+free_fd:
+	hfs_find_exit(&fd);
+	return err;
+}
+
 static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct hfsplus_vh *vhdr;
 	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
 	hfsplus_cat_entry entry;
-	struct hfs_find_data fd;
 	struct inode *root, *inode;
 	struct qstr str;
 	struct nls_table *nls;
@@ -565,16 +588,14 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	str.len = sizeof(HFSP_HIDDENDIR_NAME) - 1;
 	str.name = HFSP_HIDDENDIR_NAME;
-	err = hfs_find_init(sbi->cat_tree, &fd);
-	if (err)
-		goto out_put_root;
-	err = hfsplus_cat_build_key(sb, fd.search_key, HFSPLUS_ROOT_CNID, &str);
-	if (unlikely(err < 0)) {
-		hfs_find_exit(&fd);
+	err = hfsplus_get_hidden_dir_entry(sb, &str, &entry);
+	if (err == -ENOENT) {
+		/*
+		 * Hidden directory is absent or it cannot be read.
+		 */
+	} else if (unlikely(err)) {
 		goto out_put_root;
-	}
-	if (!hfs_brec_read(&fd, &entry, sizeof(entry))) {
-		hfs_find_exit(&fd);
+	} else {
 		if (entry.type != cpu_to_be16(HFSPLUS_FOLDER)) {
 			err = -EIO;
 			goto out_put_root;
@@ -585,8 +606,7 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 			goto out_put_root;
 		}
 		sbi->hidden_dir = inode;
-	} else
-		hfs_find_exit(&fd);
+	}
 
 	if (!sb_rdonly(sb)) {
 		/*
-- 
2.34.1

