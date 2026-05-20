Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001D63D8914;
	Wed, 20 May 2026 10:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779272407; cv=none; b=Jg9Am5ftQo2y8tJvhOV5xTEA5DuhB2Z9v+rgownaZeyzAvScpMFzEHbVtPjfLosGT8C/c93zv3wkU5Cnu+smAly55zyehQu/rhTcFSXlCp/d3MggLkATyLqCbAfpGSxzv7HXaAgOJWOuaNl4jR//Os/8Ca7ZWemTyJZabe2NaEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779272407; c=relaxed/simple;
	bh=nlOvajUKQD2BdgpVjY1kpIMhzz4fKhzvO5HvrkmpJ+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ts93Jqvey7R2NMXHg25jJwrxF0nOVmAYB/mQXh7lNczQnTpvdMP0nTt1Q15AYCQvJxSoEi3gaiOzjIsE4u58TEVJpesxK8+xmbSm2Fa0uyMtKIRzfARGW4pAL6S6me6o6OK/e/Nq2U2sI5eY+IsxbEM6oW4LmiNwD5nB9puCxCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AuLw0WFb; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AuLw0WFb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=th
	5U1L5vmkhODOQbkCC1ck4kSZkOj2dVnpqhVaNU8Qs=; b=AuLw0WFbsvQEJCokO1
	Yp3PrR43mnNKiQroLSUV6P0BDgy0E1XKXhERkECG0XxbAuXsuiH8pwsyEVyDP/ub
	xKkUmmJRSPbRJl6EWXabBLOkqpdR4LEhpERQ0p3TbmRrawwbo8AH+6Zv8lUOivZZ
	qt2H6lhmk3kJ4Ha6m2pWwH10k=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDXbbprig1qQK31EQ--.641S6;
	Wed, 20 May 2026 18:18:26 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
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
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v1 4/5] mm/shmem: introduce copy_zero_to_iter() for large zeroing
Date: Wed, 20 May 2026 18:15:37 +0800
Message-ID: <20260520101538.58745-5-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520101538.58745-1-chizhiling@163.com>
References: <20260520101538.58745-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgDXbbprig1qQK31EQ--.641S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF4kZr13Kw18Kry8CryxuFg_yoW8WFyxpF
	y3G3Z8Ar4kJayfWr4fXF4rur1Fvr93J3yUGFWxGF4YvFn0qr98KFyrKFyYkFWfAryUCw1I
	qa10yryYka10yrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j1-erUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC9xKcOmoNinIMnAAA3M

From: Chi Zhiling <chizhiling@kylinos.cn>

This is a prep patch for shmem folio batching in the read path, where
non-uptodate folios need to be handled in the main iteration loop. A
large non-uptodate folio should be treated as a hole.

Currently, holes larger than PAGE_SIZE cannot be handled because
ZERO_PAGE is limited to a single page. Add copy_zero_to_iter() as a
wrapper to support copying larger zero ranges to the iterator.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 mm/shmem.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 458853c506ea..96ea5a4c0aff 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3336,6 +3336,20 @@ shmem_write_end(const struct kiocb *iocb, struct address_space *mapping,
 	return copied;
 }
 
+static size_t copy_zero_to_iter(size_t bytes, struct iov_iter *i)
+{
+	struct folio *zero = largest_zero_folio();
+	unsigned long nr, ret, written = 0;
+
+	do {
+		nr = min(bytes - written, folio_size(zero));
+		ret = copy_folio_to_iter(zero, 0, nr, i);
+		written += ret;
+	} while (written < bytes && ret == nr);
+
+	return written;
+}
+
 static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct file *file = iocb->ki_filp;
@@ -3430,7 +3444,7 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			 * clear_user() not so much, that it is noticeably
 			 * faster to copy the zero page instead of clearing.
 			 */
-			ret = copy_page_to_iter(ZERO_PAGE(0), offset, nr, to);
+			ret = copy_zero_to_iter(nr, to);
 		} else {
 			/*
 			 * But submitting the same page twice in a row to
-- 
2.43.0

