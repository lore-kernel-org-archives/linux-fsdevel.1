Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E20F4582FC;
	Fri,  9 Oct 2026 17:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791566250; cv=none; b=N91JLuBQFMFgFFoqf0pCYFrpoD2yZrSrUzi0R+1HAeCvOlUMOQtW8IV8T6qhk+W926jwiS4G1Bctwv3LaEQJT+kB0RlEf0ZLalJ5LkZG12l89qQnXPPOs1GI8c/Bw0IJN5M+zTqFdWmQ57z7mCN4tM1fXetAXKZkgU4OOstAIhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791566250; c=relaxed/simple;
	bh=rKok5y4T+lRZsuOj0DWfkOht7fGWmMLk504qoBdCbeM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NzYAsceMi+Mb9+Ga1stZPI8KeYaInjAzueMFaNRARFaRJOR1TS/DyPGV21fvskUStn9wF2DqPa1VFJtFJ3Sd1wUxm83oUtdfxXqI8dZYf0lhsPhJupSFfQzH2QxFScBx41YXgAz1B7aOFwPXoH5+v7QAK8rpm0nVTC/3+q3cMxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=ph2Cnh2r; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="ph2Cnh2r"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 659911D70;
	Fri,  9 Oct 2026 17:18:17 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=ph2Cnh2r;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 31CDC21AD;
	Fri,  9 Oct 2026 17:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1791566246;
	bh=AkJQmYRyQZFrA5Xbh/b7taSoQUbU92wOrsDKUUWlc5s=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ph2Cnh2r40YxYrmA5ZGYJvctOuxNuw9H7LsDd4WNJJdb9UAWwNjkq9y+xDhqkxnqV
	 PCqN9oI2cs8v6U1tb32jPcmkVlHMgeVU70SOFj3YFaWOUs2As0nB+Arl8hR9cuin8T
	 YkKDlxvfKOlIXw7dGPu2Ggj93xb/7vjngzSCDJv8=
Received: from localhost.localdomain (172.30.20.199) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 9 Oct 2026 20:17:25 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 04/11] fs/ntfs3: minor code cleanups
Date: Fri, 9 Oct 2026 19:16:57 +0200
Message-ID: <20261009171704.11379-5-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009171704.11379-1-almaz.alexandrovich@paragon-software.com>
References: <20261009171704.11379-1-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Use Add2Ptr() for pointer arithmetic in fill_name_de(), consistent
with the rest of the driver, and reflow two statements to match the
80-column style.

No functional change.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/inode.c | 3 +--
 fs/ntfs3/namei.c | 6 +++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index e6c96ef88b01..1f1b2e5897e1 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -285,8 +285,7 @@ static int ntfs_read_mft(struct inode *inode, const struct cpu_str *name,
 		break;
 
 	case ATTR_ROOT:
-		if (attr->non_res ||
-		    asize < sizeof(struct INDEX_ROOT) + roff ||
+		if (attr->non_res || asize < sizeof(struct INDEX_ROOT) + roff ||
 		    rsize < sizeof(struct INDEX_ROOT))
 			goto out;
 
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index ec59bbabd3c5..46923fff0865 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -56,7 +56,7 @@ int fill_name_de(struct ntfs_sb_info *sbi, void *buf, const struct qstr *name,
 	real_size = data_size + sizeof(struct NTFS_DE);
 	aligned_size = ALIGN(data_size, 8) + sizeof(struct NTFS_DE);
 	if (aligned_size > real_size)
-		memset((char *)buf + real_size, 0, aligned_size - real_size);
+		memset(Add2Ptr(buf, real_size), 0, aligned_size - real_size);
 
 	e->size = cpu_to_le16(aligned_size);
 	e->key_size = cpu_to_le16(data_size);
@@ -231,8 +231,8 @@ static int ntfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 static struct dentry *ntfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 				 struct dentry *dentry, umode_t mode)
 {
-	return ERR_PTR(ntfs_create_inode(idmap, dir, dentry, NULL,
-					 mode, 0, NULL, 0, NULL));
+	return ERR_PTR(ntfs_create_inode(idmap, dir, dentry, NULL, mode, 0,
+					 NULL, 0, NULL));
 }
 
 /*
-- 
2.43.0

