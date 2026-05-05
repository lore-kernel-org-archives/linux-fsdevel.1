Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF06426EC9
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 12:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777984122; cv=none; b=lVYL5HC3AQXcdBLClHbWu+8e0l5j6SVbHuz64vfpG3DqlSL6x5vhH9ipLl+wJ+SZpkw+et3JKK4KkouamKvHEvEHGTQeKTvWZHSUVZgYJTITdgdAdEk5aRrwGQ5TI+urkQ9vIRtfMSQt2VRpUBJpiM7n7GYfinMROtNyFGNfKTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777984122; c=relaxed/simple;
	bh=sZ/PlVVd1DdsbHYwTt60rJDl9K8udVmYxAZGV5Uy79k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XiuWP7W/IiCDESLogjLcy+goDuWuiOA7GGN09yMK5pvj9bh3hd5hLoNcAIPMk1AkWl3nUBiY3SpUOOWmP3fljG6f+JXfrlJcmiaPt9Sox1c1aQIN4iv2f7rza4c7ofQ2+yIAOU8CcTYnbkEfAvzJJJiSDClFn1SalZBmGX3amyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id BA3C11CBC3;
	Tue,  5 May 2026 12:28:38 +0000 (UTC)
Received: from maya.d.snart.me ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id L3/cOHLi+WkgZAEA8KYfjw:T3
	(envelope-from <dxdt@dev.snart.me>); Tue, 05 May 2026 12:28:38 +0000
From: David Timber <dxdt@dev.snart.me>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>
Cc: linux-fsdevel@vger.kernel.org,
	David Timber <dxdt@dev.snart.me>
Subject: [PATCH v1 3/3] exfat: fix memory leak (upcase table)
Date: Tue,  5 May 2026 21:28:08 +0900
Message-ID: <20260505122808.728020-3-dxdt@dev.snart.me>
X-Mailer: git-send-email 2.53.0.1.ga224b40d3f.dirty
In-Reply-To: <20260505122808.728020-1-dxdt@dev.snart.me>
References: <20260505122808.728020-1-dxdt@dev.snart.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix memory leak conditions due to exfat_free_upcase_table() not being
called.

Signed-off-by: David Timber <dxdt@dev.snart.me>
---
 fs/exfat/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index e0a80d8f5f80..e9dc1e616fac 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -707,6 +707,7 @@ static int __exfat_fill_super(struct super_block *sb,
 	exfat_free_bitmap(sbi);
 free_bh:
 	brelse(sbi->boot_bh);
+	exfat_free_upcase_table(sbi);
 	return ret;
 }
 
@@ -802,6 +803,7 @@ static int exfat_get_tree(struct fs_context *fc)
 
 static void exfat_free_sbi(struct exfat_sb_info *sbi)
 {
+	exfat_free_upcase_table(sbi);
 	exfat_free_iocharset(sbi);
 	kfree(sbi);
 }
-- 
2.53.0.1.ga224b40d3f.dirty

