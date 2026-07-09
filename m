Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E8E3C3458
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2026 18:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783622893; cv=none; b=XWgtKScbKF84HLhuWMuKfagLcw39YRrJoql1J3frbSoxXoXg1JThQUhFaOGdj9ZG5A8RY6E171/Tu2hfXLCOnBxA5RKhTZMxLth0dNtyUBFU6WGj/u/hDksUGszZ/X3xu8AmQi4PcEqXFtp83+o9H2UNWiS/gmU3q1ZZ1bRhjw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783622893; c=relaxed/simple;
	bh=v+T3wWZh4rlmUqQ6YOfh51xo1hMamxYbjmGSvlBouos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XP9DtIF3NGQCXxJ2u4XJ7FlgEJ/q6dEfQnULEmUBdPQIVSA9gqilJ38L9ghSSKfyB7Fra3oqbNnrM2eiqt2aa770JrDc2Clxyhs1uFQ0LRnK43MDJTiDQZ3DyQhAHSZ3WXBZLrR6+OO9Eiy8ZUy+2W1IFu4JfJdQxFzdl9SUXtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Dl48xbCl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Dl48xbCl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=ajN0xgR99tv6l81DifCTyf3GY/vdZ+aOfksjFBPqRjY=; b=Dl48xbClpVu3psx+V80MUjtdAj
	8UQmYnc7eQGd+BeTLmmFz2KJOj3scPE4gecweu+K4OOAbSU+sJ1XMhPmvPnyRtPpVE/6lxE2QbN5q
	QC0f4GcS1SPL84JylUphQeFB1MjI1Va1lykEtf6uaoy0b/g0Tux8mlBKh2eBZd/5bD2iw7wKbhWAN
	aEMbWYHUM3H//nHywxQRAusIG3NLZVtxA2N8YW3TIcPW1oSzdCBBjTbyoncB/7W3p8rwZ2cEGuJE6
	IKmeGYJoif7IpRMChYalBoM5/1ttpCXboUv8NRC/n3T2Pl75ocYZi25l7xc/70OT+Nvm5AV3Vcc0a
	YoLB3uZA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whtmg-00000005OhH-2kju;
	Thu, 09 Jul 2026 18:47:42 +0000
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
	Christian Brauner <christian@brauner.io>
Subject: [PATCH v2 04/10] hugetlb: Set mapping folio order
Date: Thu,  9 Jul 2026 19:47:32 +0100
Message-ID: <20260709184740.1286561-5-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709184740.1286561-1-willy@infradead.org>
References: <20260709184740.1286561-1-willy@infradead.org>
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
index 216e1a0dd0b2..1760df6f2709 100644
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

