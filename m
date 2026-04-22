Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032013DD524;
	Wed, 22 Apr 2026 12:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776861572; cv=none; b=OUT1182pDeR6CyxXGTqwY5EqrTzmkeKwdoI1MBggbG6/r9LXs/liBHIphg0aJVKpurIq2cJXKLSowQBmy6yZcYDG09/p6BcpoHnyt6tPwi2CGw+cD8L4T0C+7gGh6zUp3+5F0O3DCnbvQCqih+1xV2+eibhLVXekbZ89iKeuf9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776861572; c=relaxed/simple;
	bh=C7KDx+LOql97tFnni/jsDDLh9tWrcNK31Xw201UPthA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OUuWAnBWpTh9k6SBk09rW9gm5EPpZgPA/5C7luIv722tLBW6tNFU6o1mBqTonwiqE5S/bCkW0XS1wg1LLWR7sS+SkNYBeJi98WuYE/QhtcfXxjHp27lt9VzRqjIhLPbHlm7jXbQ6hYw0XNwBu3paT8WEtAB3VFAaJvQVHDcgYZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IcKM5dxW; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IcKM5dxW"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776861567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zVOFmFOVqcLybXQIVbAD0IkykFu0mao1hsCbmrvX7VI=;
	b=IcKM5dxW4zkedPF/HojXB6o8hyeMys3rUjTP8EwdZr3bHBBiaWSrTCvwpLyJtSpsv60tSl
	6qyBvIQfQAZhMEGSTi3sMCE2+c47Q41q8aCARUA0esprevGdyfacYvqGZv1Pi47ph6UXlX
	JrqTp2q2x6o22UwFR1jKAFCs6vf1XPo=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fuse: use QSTR() instead of QSTR_INIT() in fuse_get_dentry
Date: Wed, 22 Apr 2026 14:39:12 +0200
Message-ID: <20260422123911.100979-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=686; i=thorsten.blum@linux.dev; h=from:subject; bh=C7KDx+LOql97tFnni/jsDDLh9tWrcNK31Xw201UPthA=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJkvDuYrqJtxnzg488b26KKNj2es9nh5Jvru/r5WBauWs M28t+7UdJSyMIhxMciKKbI8mPVjhm9pTeUmk4idMHNYmUCGMHBxCsBEVu9gZDhwTpm/7s2SnXXd h17FWYp9l7V1nxZrL/ma3/f8Eut/7isZ/ooLKFvMMZ9pFvWh7tqsLveG/gkMa3bxRs39lnvi4eO r7twA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Drop the hard-coded length argument and use the simpler QSTR().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/fuse/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index deddfffb037f..d224bcba593b 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1113,7 +1113,7 @@ static struct dentry *fuse_get_dentry(struct super_block *sb,
 	inode = ilookup5(sb, handle->nodeid, fuse_inode_eq, &handle->nodeid);
 	if (!inode) {
 		struct fuse_entry_out outarg;
-		const struct qstr name = QSTR_INIT(".", 1);
+		const struct qstr name = QSTR(".");
 
 		if (!fc->export_support)
 			goto out_err;
