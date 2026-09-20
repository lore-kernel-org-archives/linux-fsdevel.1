Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47051C3F0C;
	Sun, 20 Sep 2026 07:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789889540; cv=none; b=WLfAsaoEpWcTEBEPdwtA3sSYek3QIfmM3UIK1ya0FaIZjoB6mJd2IJs6rmA6Yetpv9QMwC3BtkoyQdiMJKEV4LkbWDVDnwzYBvqyxAuaV1FSzZun++/OEyfjcVC9BOzoHGzTysseFwLvWfMLSzJtImM9AeipuDvJ9c7rPvSWwSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789889540; c=relaxed/simple;
	bh=bqRopMR1Jx7jjHXsgA2b96gOdCVKphw3J2fzDuFOJfk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B0LNCNGFBvzDi/41ioVi1a4PA1w+7ucaOQ/bCGQOhOzsy9yFTVCdPfRPjZkvg6aeyt+B7y7jRnX3q8zCY0Ealv2hPWi3CIJFrf/1pDFXonC+F2Qy/+nPZPjsf5nxfCUxd5SQcDi7CnigfSepvd2ELaLhHcE7yZIOBENQJfyCqV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hndNK1KsZzTSdk;
	Sun, 20 Sep 2026 15:32:01 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hndNJ3ljVzTSdk;
	Sun, 20 Sep 2026 15:32:00 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id 463E54B60;
	Sun, 20 Sep 2026 15:31:59 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Sun, 20 Sep 2026 15:31:58 +0800
From: Huang Shijie <huangsj@hygon.cn>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>
CC: <zhongyuan@hygon.cn>, <fangbaoshun@hygon.cn>, <yingzhiwei@hygon.cn>,
	<jack@suse.cz>, <dev.jain@arm.com>, <ljs@kernel.org>, <adobriyan@gmail.com>,
	<akpm@linux-foundation.org>, <hpa@zytor.com>, <ryan.roberts@arm.com>,
	<mjguzik@gmail.com>, <joel.granados@kernel.org>, <jannh@google.com>,
	<oleg@redhat.com>, <aleksa@amutable.com>, <legion@kernel.org>,
	<kees@kernel.org>, <joannelkoong@gmail.com>, <tj@kernel.org>,
	<libaokun@linux.alibaba.com>, <ebiggers@kernel.org>, <sandeen@redhat.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Huang Shijie
	<huangsj@hygon.cn>
Subject: [RFC PATCH v2 1/3] fs/drop_caches: skip filesystems without page cache
Date: Sun, 20 Sep 2026 15:28:09 +0800
Message-ID: <20260920072811.2064247-2-huangsj@hygon.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920072811.2064247-1-huangsj@hygon.cn>
References: <20260920072811.2064247-1-huangsj@hygon.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cncheex05.Hygon.cn (172.23.18.115) To cncheex04.Hygon.cn
 (172.23.18.114)

Add a new flag SB_I_NO_PAGECACHE for superblock.

Skip scanning the inode lists of filesystems that have no page cache
in drop_pagecache_sb(), as indicated by the SB_I_NO_PAGECACHE flag.

This patch only changes the procfs.

Signed-off-by: Huang Shijie <huangsj@hygon.cn>
---
 fs/drop_caches.c               | 3 +++
 fs/proc/root.c                 | 2 +-
 include/linux/fs/super_types.h | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index 49f56a598ecb..27caf748b3c5 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -20,6 +20,9 @@ static void drop_pagecache_sb(struct super_block *sb, void *unused)
 {
 	struct inode *inode, *toput_inode = NULL;
 
+	if (sb->s_iflags & SB_I_NO_PAGECACHE)
+		return;
+
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		spin_lock(&inode->i_lock);
diff --git a/fs/proc/root.c b/fs/proc/root.c
index 99adddfeb4a4..d45f5af5ab53 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -266,7 +266,7 @@ static int proc_fill_super(struct super_block *s, struct fs_context *fc)
 		return ret;
 
 	/* User space would break if executables or devices appear on proc */
-	s->s_iflags |= SB_I_NOEXEC | SB_I_NODEV;
+	s->s_iflags |= SB_I_NOEXEC | SB_I_NODEV | SB_I_NO_PAGECACHE;
 	s->s_flags |= SB_NODIRATIME | SB_NOSUID | SB_NOEXEC;
 	s->s_blocksize = 1024;
 	s->s_blocksize_bits = 10;
diff --git a/include/linux/fs/super_types.h b/include/linux/fs/super_types.h
index ecd96aeb1cee..1a596caf58a8 100644
--- a/include/linux/fs/super_types.h
+++ b/include/linux/fs/super_types.h
@@ -352,5 +352,6 @@ struct super_block {
 #define SB_I_NOIDMAP	0x00002000	/* No idmapped mounts on this superblock */
 #define SB_I_ALLOW_HSM	0x00004000	/* Allow HSM events on this superblock */
 #define SB_I_NO_DATA_INTEGRITY	0x00008000 /* fs cannot guarantee data persistence on sync */
+#define SB_I_NO_PAGECACHE	0x00010000 /* this file system has no page cache */
 
 #endif /* _LINUX_FS_SUPER_TYPES_H */
-- 
2.53.0


