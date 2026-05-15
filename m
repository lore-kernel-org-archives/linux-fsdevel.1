Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098383C8C65;
	Fri, 15 May 2026 09:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778838521; cv=none; b=qZCOLY709gR5tgh/lrix0IECWKEzgStZqdgwqPUf9Amu3Tzj3pAm0kjN3DPjvDiWoy9zsusaIIfayLGgPbjkzh1yRAl4qNh8choTD4eEvpMHyzWp92I0XZ1Aog2bbgpk5knkg548V8a+4kTEdbwV80T4Lbj8i8YvEivjbMj8UV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778838521; c=relaxed/simple;
	bh=HcuFBNmn2JjTP3n0RT/JaV3j1Ngq/Nn8k9pauhPa2j8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=prqV1p/nz7WS0yYgb1YbXvrlfw/h5iNHUgDNFjNhj4Zr6UKgy7mRDPW4PI/3qvFtEs2d1KZ1I5Oqgcv2M5VTaw8W0iIvlw5hRekE+jMV4uH5u3wh60bcgf8c5HfII8L2jQVkSBzXvybcN89PLH+vZBWQGjDD1803xkaEPMWoSz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DwCEea2W; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DwCEea2W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=tC
	AvDF399KUDDlsRRvXTB3FeBcx5LWuoyIvPW26D+rA=; b=DwCEea2WZ5HljjrfYt
	aGWsT72c229yIttmDYQTd8hcCUk6JCkTUwyQCNSthHZ3ruWWeMjSsaQHdgMR6H6D
	c7EFbBte8s+hMpUkFY3B5OAuZ0k34xHsU3kDiMV6zdA/uDgcI+FGhlVam+x+xYu/
	dru0TT5Bt8Y8n11L6pN01Uphw=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wBnVxek6wZq6RobBg--.38248S4;
	Fri, 15 May 2026 17:47:18 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [RFC PATCH 2/4] mm/shmem: use SGP_GET in read operations
Date: Fri, 15 May 2026 17:47:00 +0800
Message-ID: <20260515094702.1092355-3-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515094702.1092355-1-chizhiling@163.com>
References: <20260515094702.1092355-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnVxek6wZq6RobBg--.38248S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFWDKr1UJFyrCw13tF13urg_yoW8KFykpr
	W5Kwn7Xrs5J3yUuryfJayrZ34Ykas7XrWUta9xGw1fJFn5JFykKr47t348WFy3ArW7Aw1S
	g3WUGa1jv3Wjyr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jOcTQUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC+AZA3WoG66ZsIQAA3P

From: Chi Zhiling <chizhiling@kylinos.cn>

Replace SGP_READ with SGP_GET in shmem_file_read_iter(),
shmem_file_splice_read(), and shmem_get_link(). These functions
immediately unlock the folio after getting it, making the lock
acquisition redundant.

Even though folio_lock can protect folio data consistency or prevent
truncate while holding the lock, these can still happen after unlock.
Since these functions continue reading data after unlocking, the lock
does not provide effective protection. The folio reference count is
what actually prevents reclamation during access, making the lock
unnecessary.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 mm/shmem.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index ef19968cc51c..767610f78d0d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3370,15 +3370,13 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			break;
 
 		index = iocb->ki_pos >> PAGE_SHIFT;
-		error = shmem_get_folio(inode, index, 0, &folio, SGP_READ);
+		error = shmem_get_folio(inode, index, 0, &folio, SGP_GET);
 		if (error) {
 			if (error == -EINVAL)
 				error = 0;
 			break;
 		}
 		if (folio) {
-			folio_unlock(folio);
-
 			page = folio_file_page(folio, index);
 			if (PageHWPoison(page)) {
 				folio_put(folio);
@@ -3561,15 +3559,13 @@ static ssize_t shmem_file_splice_read(struct file *in, loff_t *ppos,
 			break;
 
 		index = *ppos >> PAGE_SHIFT;
-		error = shmem_get_folio(inode, index, 0, &folio, SGP_READ);
+		error = shmem_get_folio(inode, index, 0, &folio, SGP_GET);
 		if (error) {
 			if (error == -EINVAL)
 				error = 0;
 			break;
 		}
 		if (folio) {
-			folio_unlock(folio);
-
 			page = folio_file_page(folio, index);
 			if (PageHWPoison(page)) {
 				error = -EIO;
@@ -4170,17 +4166,15 @@ static const char *shmem_get_link(struct dentry *dentry, struct inode *inode,
 			return ERR_PTR(-ECHILD);
 		}
 	} else {
-		error = shmem_get_folio(inode, 0, 0, &folio, SGP_READ);
+		error = shmem_get_folio(inode, 0, 0, &folio, SGP_GET);
 		if (error)
 			return ERR_PTR(error);
 		if (!folio)
 			return ERR_PTR(-ECHILD);
 		if (PageHWPoison(folio_page(folio, 0))) {
-			folio_unlock(folio);
 			folio_put(folio);
 			return ERR_PTR(-ECHILD);
 		}
-		folio_unlock(folio);
 	}
 	set_delayed_call(done, shmem_put_link, folio);
 	return folio_address(folio);
-- 
2.43.0

