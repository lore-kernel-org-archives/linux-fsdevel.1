Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942128C1F
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 19:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782242938; cv=none; b=Y9eLaqbJ/5x9N0rQq395rvexD8v3G+yfPMspPt1HSxJr+HaBS7abWUrlLDY8DWoUbpZelWIqrFkCEzmvnlH5RWkpYg/NiniUri5VKWJsWzu5epmnglYDQfdx1GL2/Bg3lstghRK0DQkqJoxslXZI+0sT50kLvZ2Ofqce+eC8ryg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782242938; c=relaxed/simple;
	bh=LKHajBtNw8VRFq1vpzD9jEvNMLwdmvY+H2FZh71zIek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z2aHklTog8+BcdnvkxsRhqjKFXmoKiacNRSiyQfdXNIezeHImf5XFuTAjJAdRSqAIjuIJ9MPZrTRyeY0wehNDWuhy9a67zkn/XIw7Uajegr+1RnVAzcApUfV2ZCYbt99Pj63qPCEaUKnU0Bs8dzGON1ycsCI3oknV7snsFL6B5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gM0Pmid8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gM0Pmid8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=IRZnt1J4nxZEuonqv5vtaLSgoyniAZZwlu6BciFW4pA=; b=gM0Pmid8l5tJQIPL6tHC5h7LjZ
	dCZL4xjoJ68d8XxIRw9heRdoezk2kbV9vFYn4See/qPF+pIJ+Y8FVl9KgL9KB4EcGGsE5mp91pjCP
	/xI1JV8BKlYcCFOjKIttl0XZRy+PoIsOKpOVyYLNRHLC35yzARVy5Px+dg2KlqgutIYOnka0sFf5s
	FtcPHClEYFZCgPGz/sStFiTxlSX3UlPmLojHidnO/S0kR8pVaGmj0osDcHyZJ7PebNvmEt42UPSDp
	rQfwWWbMPYEIcf4pL9Fsy8VWvgZ0rtypK9GziM1l3xRq/JG90w2FU8Lmoxmtgda+NNLDuqw68X/AQ
	b+9JC65Q==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc6nj-00000006hBR-37Kv;
	Tue, 23 Jun 2026 19:28:51 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Rik van Riel <riel@surriel.com>,
	Zi Yan <ziy@nvidia.com>,
	Jinjiang Tu <tujinjiang@huawei.com>,
	Dave Jones <davej@codemonkey.org.uk>
Subject: [PATCH] fs: Free any excess xarray nodes in clear_inode()
Date: Tue, 23 Jun 2026 20:28:48 +0100
Message-ID: <20260623192850.1595958-1-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For many years we've had a hard to hit leak of xarray nodes.  Hugh
documented it well in commit 786b31121a2c.  Recently people and
syzbot have found ways to force it to happen with madvise.  Rather
than fix the leaks where they happen, just call xa_destroy() which
has the side-effect of cycling the i_pages lock.

Cc: Rik van Riel <riel@surriel.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Jinjiang Tu <tujinjiang@huawei.com>
Cc: Dave Jones <davej@codemonkey.org.uk>
Link: https://lore.kernel.org/all/20260121062243.1893129-1-tujinjiang@huawei.com/
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/inode.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 6a3cbc7dcd28..4070ff27b318 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -779,21 +779,18 @@ void clear_inode(struct inode *inode)
 		fsverity_cleanup_inode(inode);
 
 	/*
-	 * We have to cycle the i_pages lock here because reclaim can be in the
-	 * process of removing the last page (in __filemap_remove_folio())
-	 * and we must not free the mapping under it.
+	 * We have to cycle the i_pages lock here because reclaim
+	 * can be in the process of removing the last page (in
+	 * __filemap_remove_folio()) and we must not free the mapping
+	 * under it.  We also remove nodes which are empty; these
+	 * can occur in two different ways.  The first is that radix
+	 * tree expansion can fail partway and the second is that THP
+	 * collapse_file() can allocate some temporary nodes and not
+	 * clean them up.
 	 */
-	xa_lock_irq(&inode->i_data.i_pages);
+	xa_destroy(&inode->i_data.i_pages);
+
 	BUG_ON(inode->i_data.nrpages);
-	/*
-	 * Almost always, mapping_empty(&inode->i_data) here; but there are
-	 * two known and long-standing ways in which nodes may get left behind
-	 * (when deep radix-tree node allocation failed partway; or when THP
-	 * collapse_file() failed). Until those two known cases are cleaned up,
-	 * or a cleanup function is called here, do not BUG_ON(!mapping_empty),
-	 * nor even WARN_ON(!mapping_empty).
-	 */
-	xa_unlock_irq(&inode->i_data.i_pages);
 	BUG_ON(!(inode_state_read_once(inode) & I_FREEING));
 	BUG_ON(inode_state_read_once(inode) & I_CLEAR);
 	BUG_ON(!list_empty(&inode->i_wb_list));
-- 
2.47.3

