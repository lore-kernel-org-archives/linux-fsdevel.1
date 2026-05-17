Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37353BB661
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2026 17:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779039255; cv=none; b=aWgyhNCVkyC+vMjZrIHHaiNTeohIDjF++h19nyx7ydSmdyrRNumhrKm/waOmwkrhm2yQRHMN1rpM/R6CPei7vLI8WKESXGsMqjPWXBn6WUucgVcqkg4LbGHuHH/qs9KSvrUFUu43hgD2sOEkNTxzIAMfUAnGCTavr5MlP0gn5jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779039255; c=relaxed/simple;
	bh=anJBQfqCpkkieE7QSR3sEiOcNuEBrN+rl6Oxm7d8kq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mDVBJF9jw7RQ1Eiy4rXGjAYz057ghJMkcFmsGdPs7Sw2noBElkWtvmtxVQ4LQbASZvA5Ox2nJArMxHyT/SJEkWrRxa22u5xb1gshSHQtaTQzmEIZ9ckirWWlKWmdXs7eavdPVoknzNM4YqjMWNTan6Wf3240qIQpCECNrvYnwcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tZSSkhkl; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tZSSkhkl"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779039251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9ZtFPLiVGfBwb4H3U2XXIZqyHw0d1oq7qglfFlOQDyk=;
	b=tZSSkhkl/JmTF/JB6FSX5tX61evsYaIp8OkTt0gaqtep94A2rWWIADoiSlahUz2rfTzOkU
	kXwkAMnjKI7UxaNpEhuQmtUr59KuViwz6obx5QUlBRF+26ywnewWzVCeGGv9XNmVcY3A9g
	xcxZIs9OmtYA3VV5oMNax6CO72FAjJM=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] fuse: use QSTR() instead of QSTR_INIT() in fuse_get_dentry
Date: Sun, 17 May 2026 19:33:44 +0200
Message-ID: <20260517173342.4913-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1077; i=thorsten.blum@linux.dev; h=from:subject; bh=anJBQfqCpkkieE7QSR3sEiOcNuEBrN+rl6Oxm7d8kq0=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFmcv78vX3q+6GNWtbS4sKd1/jaWhadUw17/iKitK/jcy V/6rN6/o5SFQYyLQVZMkeXBrB8zfEtrKjeZROyEmcPKBDKEgYtTACbyWYnhv4u4y6O7H5ZKWM9p 0TyT0fWgoNSHKS5D93LUTKE52u7pixkZrmy2N+aP6nAwa1+ffdXg8JYv53xn8L6IWfDQ7vVLicR aVgA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Drop the hard-coded length argument and use the simpler QSTR(). Inline
the code and drop the local variable.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Inline QSTR() and drop the local variable as suggested by Al Viro
- v1: https://lore.kernel.org/lkml/20260422123911.100979-3-thorsten.blum@linux.dev/
---
 fs/fuse/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 0897f8e62b4d..51df88e43f6f 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1064,12 +1064,11 @@ static struct dentry *fuse_get_dentry(struct super_block *sb,
 	inode = ilookup5(sb, handle->nodeid, fuse_inode_eq, &handle->nodeid);
 	if (!inode) {
 		struct fuse_entry_out outarg;
-		const struct qstr name = QSTR_INIT(".", 1);
 
 		if (!fc->export_support)
 			goto out_err;
 
-		err = fuse_lookup_name(sb, handle->nodeid, &name, &outarg,
+		err = fuse_lookup_name(sb, handle->nodeid, &QSTR("."), &outarg,
 				       &inode);
 		if (err && err != -ENOENT)
 			goto out_err;
