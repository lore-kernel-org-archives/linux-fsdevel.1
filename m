Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D163148A1;
	Fri, 23 Jan 2026 01:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769132742; cv=none; b=E4Y8axullE+XQ7+eknivPDsCIbMpfI4XJPHnJdOXr+sOXrxAzWgJYx2o06Tw8lynP1cGqZnOw9qW74S0QWOeSFshjh6Lp5osfytyJ/MESMPvWX+pnhJGj5vh+zOqyatAEr6OmxQvZ0upFlltYzRmT8qC4xOsrWyfcSIaI+7uwU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769132742; c=relaxed/simple;
	bh=x6fUikO0R/nUdmFtuYDUi+dRxJEe5v8ULG3T99qF5t8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bT2yOicXY/UZgt7tSCK8UhvonyzlHyrvGpzHbCRoyogZcnp3tlyd699l824y8yTRGmVHWYo83UivbKctzjYeQk268EyO8A4fse4L8P61NhLC3YVg1Go/7IhDdR1UohIJmREH9rGvfwgAVqo6XmcNoqTH1X38Mfwo1Dm+Xc1UZkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=PyrjXgwh; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="PyrjXgwh"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=X2tclZhWoOBbnPRpt4KYODEDqulzqggXkTbvFvdkSDc=;
	b=PyrjXgwh3oeFedO0IZtiBPyXTRCGepZB/sHrUDQu8DHUBA6xjpY+IVm3leGntWEF0yQjfuM1C
	GOAOihZk5rhBq+iw2hEYiXh6p0G/2Az2gHnlqpjZicpx93dMKt+9VH7fQzQh6iFEItYHkqFoA4+
	lN2IHN+tl9MPpZRn3IFFDcQ=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dy0yT3s6fz12LD8;
	Fri, 23 Jan 2026 09:41:21 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id E0DB340569;
	Fri, 23 Jan 2026 09:45:18 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 23 Jan
 2026 09:45:18 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>
CC: <hch@lst.de>, <djwong@kernel.org>, <amir73il@gmail.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH v18 04/10] erofs: add erofs_inode_set_aops helper to set the aops
Date: Fri, 23 Jan 2026 01:31:26 +0000
Message-ID: <20260123013132.662393-5-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20260123013132.662393-1-lihongbo22@huawei.com>
References: <20260123013132.662393-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr500015.china.huawei.com (7.202.195.162)

Add erofs_inode_set_aops helper to set the inode->i_mapping->a_ops
to make it cleaner.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/inode.c    | 24 +-----------------------
 fs/erofs/internal.h | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index bce98c845a18..202cbbb4eada 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -203,7 +203,6 @@ static int erofs_read_inode(struct inode *inode)
 
 static int erofs_fill_inode(struct inode *inode)
 {
-	struct erofs_inode *vi = EROFS_I(inode);
 	int err;
 
 	trace_erofs_fill_inode(inode);
@@ -235,28 +234,7 @@ static int erofs_fill_inode(struct inode *inode)
 	}
 
 	mapping_set_large_folios(inode->i_mapping);
-	if (erofs_inode_is_data_compressed(vi->datalayout)) {
-#ifdef CONFIG_EROFS_FS_ZIP
-		DO_ONCE_LITE_IF(inode->i_blkbits != PAGE_SHIFT,
-			  erofs_info, inode->i_sb,
-			  "EXPERIMENTAL EROFS subpage compressed block support in use. Use at your own risk!");
-		inode->i_mapping->a_ops = &z_erofs_aops;
-#else
-		err = -EOPNOTSUPP;
-#endif
-	} else {
-		inode->i_mapping->a_ops = &erofs_aops;
-#ifdef CONFIG_EROFS_FS_ONDEMAND
-		if (erofs_is_fscache_mode(inode->i_sb))
-			inode->i_mapping->a_ops = &erofs_fscache_access_aops;
-#endif
-#ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
-		if (erofs_is_fileio_mode(EROFS_SB(inode->i_sb)))
-			inode->i_mapping->a_ops = &erofs_fileio_aops;
-#endif
-	}
-
-	return err;
+	return erofs_inode_set_aops(inode, inode, false);
 }
 
 /*
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index ec79e8b44d3b..13b66564057a 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -455,6 +455,32 @@ static inline void *erofs_vm_map_ram(struct page **pages, unsigned int count)
 	return NULL;
 }
 
+static inline int erofs_inode_set_aops(struct inode *inode,
+				       struct inode *realinode, bool no_fscache)
+{
+	if (erofs_inode_is_data_compressed(EROFS_I(realinode)->datalayout)) {
+#ifdef CONFIG_EROFS_FS_ZIP
+		DO_ONCE_LITE_IF(realinode->i_blkbits != PAGE_SHIFT,
+			  erofs_info, realinode->i_sb,
+			  "EXPERIMENTAL EROFS subpage compressed block support in use. Use at your own risk!");
+		inode->i_mapping->a_ops = &z_erofs_aops;
+#else
+		return -EOPNOTSUPP;
+#endif
+	} else {
+		inode->i_mapping->a_ops = &erofs_aops;
+#ifdef CONFIG_EROFS_FS_ONDEMAND
+		if (!no_fscache && erofs_is_fscache_mode(realinode->i_sb))
+			inode->i_mapping->a_ops = &erofs_fscache_access_aops;
+#endif
+#ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
+		if (erofs_is_fileio_mode(EROFS_SB(realinode->i_sb)))
+			inode->i_mapping->a_ops = &erofs_fileio_aops;
+#endif
+	}
+	return 0;
+}
+
 int erofs_register_sysfs(struct super_block *sb);
 void erofs_unregister_sysfs(struct super_block *sb);
 int __init erofs_init_sysfs(void);
-- 
2.22.0

