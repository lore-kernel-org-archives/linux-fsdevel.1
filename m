Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E786372B3D
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2026 16:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784995261; cv=none; b=RjA1sMsKBQKx+vKD8Glun9SyedQRvFfPOH33TZb1Pvdv1QGZEIyDsB/HEBx5+9mGwymJH3A0ChviTu9rlmcgLir5yV0uW16M1M6XMVYJrzhSv3XKIyR4KSansHv9W8ltIc9kRV/GeuwJrsHxn1w/NDgogcsJc5vFV3eEPRVYhPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784995261; c=relaxed/simple;
	bh=6H0E+/8Ev4ICbFgjc7gRDPMftupZC/TiOYxk7EbQKgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X96NvVHES2mqbbxVBbaePg49Keha2OGMIUGEh/wMtLPKreik4AK8AHCEcltUStAu6cmx5WEDABceZxD6/VBQBpBZUu8jjbPw26kTu1MIL684R/KY5csBb6q0ERXcfB0OBhEhKrpzVyppwYCP6s3DKxPqpVmvwdtq3uZibh9ci5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WqX8FEJg; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WqX8FEJg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=jQPhhI85VU/RfstxHcf4iE//LF5DLMgP3hQKUkFlgwE=; b=WqX8FEJgrd5xNI4QzoUx78zhwh
	LM3RjOtNqOm46x4TPbhmQo0AYvLcUmtSY2U9VzsJ7B2jw1YqAGc0J2B2aatriG5V/+IuK8GwIwgSp
	UTJPeBEuONiX+2EqJHqkgdg3y3pjK9Jz/MwkTQFHd0bdfEJWA5wM83h8KgIV8rs7eoZ3TR3nrPFS8
	oQHpM2ve7PHrdO+PQgPuI/6ubWgbCxhf2wtjsho0VHVI1oGJ2Xhoj1viSzWzk2UHv6ReKlE6x7e8X
	cBP8DnXfBoftZt6V0bMY+zGmWxwTZM46XmNpO7YZZuhf/ZD6UubttfK2lrwIpYmdtKe4MLNvttYgx
	mT7a0ZVg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnens-00000006X7i-1yR0;
	Sat, 25 Jul 2026 16:00:44 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>,
	linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>,
	Jiaqi Yan <jiaqiyan@google.com>
Subject: [PATCH v5 10/12] hugetlb: Set mapping folio order
Date: Sat, 25 Jul 2026 17:00:38 +0100
Message-ID: <20260725160042.1557264-11-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260725160042.1557264-1-willy@infradead.org>
References: <20260725160042.1557264-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hugetlbfs currently uses an fs-specific way to determine the size of
the folios in its page cache.  Thanks to the support of block sizes
larger than page sizes, we now support this as part of the page cache.
It's somewhat more efficient as we have this information directly in the
mapping rather than going from inode->i_sb->s_fs_info.  We can convert
the rest of the hugetlb code to use this at our leisure; this is needed
now so that we can use filemap_get_pages() unmodified.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/hugetlbfs/inode.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index dbca3f713bbf..8d15413a67ee 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -883,6 +883,16 @@ static struct inode *hugetlbfs_get_root(struct super_block *sb,
 	return inode;
 }
 
+static void hugetlbfs_init_regular_inode(struct inode *inode)
+{
+	struct hstate *hstate = hstate_inode(inode);
+	unsigned int order = huge_page_order(hstate);
+
+	inode->i_op = &hugetlbfs_inode_operations;
+	inode->i_fop = &hugetlbfs_file_operations;
+	mapping_set_folio_order_range(inode->i_mapping, order, order);
+}
+
 /*
  * Hugetlbfs is not reclaimable; therefore its i_mmap_rwsem will never
  * be taken from reclaim -- unlike regular filesystems. This needs an
@@ -926,8 +936,7 @@ static struct inode *hugetlbfs_get_inode(struct super_block *sb,
 			init_special_inode(inode, mode, dev);
 			break;
 		case S_IFREG:
-			inode->i_op = &hugetlbfs_inode_operations;
-			inode->i_fop = &hugetlbfs_file_operations;
+			hugetlbfs_init_regular_inode(inode);
 			break;
 		case S_IFDIR:
 			inode->i_op = &hugetlbfs_dir_inode_operations;
-- 
2.47.3

