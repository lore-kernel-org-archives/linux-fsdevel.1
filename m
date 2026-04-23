Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809D233FE36
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 15:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776957148; cv=none; b=r6qwrt0oLg+3TgtnF/xkkZBMDmu6rlq1Y06PrJ4Xiu+NOiuCUh0ysRvZO/LHCBm96D47hUEZ4EJk+OAvjiD8BxwHX5EXUyumePwjuDm3xMM6hOV+7KDhZ7mIaavtpLq7arls+kMHrbzQ/oL/VDFMaEkQNxDoB7SL8ACWHWTTC44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776957148; c=relaxed/simple;
	bh=BmYK5O/Z+DQvYl6WI1DjpP91uuMKacDT9ltQ8AxHY08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IEq/vpUsa+9YBXUIxtVff4YpOLV8TbJLBK7QLx1mThz8opwDsLJdJC4WpbT6O828RkrRuR1tLAuUF7zSozUF//GrrH+IjQcSXOcu14sZlU7S7AvRGt/gAp7Fby6GmHOWf6y4vXzTad9tNN8pmpHOxyh3vorf5++dEomNmMbzkWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KLu8aBRI; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KLu8aBRI"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776957141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Wr4hzfuW5ZM/ULHUTZ9h1gf7GOP2pEdCkryUPktgQ80=;
	b=KLu8aBRIuAE0ogXTIIDNNovOqYfCmzEuMoyVe3qBULpupMtTyI7jH5Zt0LgMFShCxtmkPV
	Vg4RbidzzDO0YiHNVRudRltLVvdSI6kUl159Upclde8rofQDuxz6fPAzA7SYbAHCZ42cHV
	QMFcLhZ7zk272ALE2+kCcw2zbwdocP8=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] namei: use QSTR() instead of QSTR_INIT() in path_pts
Date: Thu, 23 Apr 2026 17:11:49 +0200
Message-ID: <20260423151147.270605-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1092; i=thorsten.blum@linux.dev; h=from:subject; bh=BmYK5O/Z+DQvYl6WI1DjpP91uuMKacDT9ltQ8AxHY08=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJmvzDY32DGu4+joVi7kMHEV8X/1xeVzxcV9gufue34rv N0Y+35dRykLgxgXg6yYIsuDWT9m+JbWVG4yidgJM4eVCWQIAxenAExE7zMjw1KJf7sOJ78tFLHY zhv85rStI+vqly/+N4Ypy4f8V0w128nIMKXu9Vwzj6tiMZ37FBUut+kd3me3dLVKQNv1iTE7p3X ncAAA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Drop the hard-coded length argument and use the simpler QSTR(). Inline
the code and drop the local variable.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Inline QSTR() and drop the local variable as suggested by Al Viro
- v1: https://lore.kernel.org/lkml/20260422123002.99876-3-thorsten.blum@linux.dev/
---
 fs/namei.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index c7fac83c9a85..01f3fbdf646c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3617,7 +3617,6 @@ int path_pts(struct path *path)
 	 */
 	struct dentry *parent = dget_parent(path->dentry);
 	struct dentry *child;
-	struct qstr this = QSTR_INIT("pts", 3);
 
 	if (unlikely(!path_connected(path->mnt, parent))) {
 		dput(parent);
@@ -3625,7 +3624,7 @@ int path_pts(struct path *path)
 	}
 	dput(path->dentry);
 	path->dentry = parent;
-	child = d_hash_and_lookup(parent, &this);
+	child = d_hash_and_lookup(parent, &QSTR("pts"));
 	if (IS_ERR_OR_NULL(child))
 		return -ENOENT;
 
