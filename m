Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4113358C4;
	Mon,  1 Jun 2026 05:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780293497; cv=none; b=tMK8jg5pGu1hcCHmHVKei17Bi5WLYoO3ofvq47x1bSmhoSKXmg6fl49RBdvbCn3yVDGAdZEDdkrmpKjp1segh5Kke87K1318w663jnYjf345KsigV6/7nOQ6fCP1Qib+tf3KZL1feIgqA+xX/iKSrSnm5yQIqaE1MLOsAobvFnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780293497; c=relaxed/simple;
	bh=L5BeWN0U7lKv4EdCz4K3mK8Rpw62dharsFq3h0wdT1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZIPeMe6n3uj8S2kLnRtF8JwKliPBSzVzZpqm5lx7JdqhP5WdbboTc9DTvtuV9ebYJfeKFtgKm0jAZcQE67/YS0OnpL4QZHR/gesCTI8BKUhZHVDIfIsQhvMtBWyBqN6lmEs1I4SaFFN4MaveBKIkXb9kihT8N2C0dKqIv+smlag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CAX058sM; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CAX058sM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Gw
	M4pkP8SJrbgKz+ttAiFjnJ2HZxTx+PZU1H2nT4urU=; b=CAX058sMffpNy193aq
	v83uUOayxBBAYsZi1oA9/Il+UOCBIyuaJ/tp5HCEYtUKcpGyAsIHqg2IdM+NzByK
	AU3bAlF4tkHoGIB6qszRG9esP2NcI6zlmsVDlR63pgHbPRq0SKe8iTBTdT4tO7Fv
	XYfQCCgLVv44ZxHWLx2aw+F6w=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3_7Q6Hx1qsb0MAw--.47504S5;
	Mon, 01 Jun 2026 13:57:21 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v2 3/5] mm/shmem: introduce copy_zero_to_iter() for large zeroing
Date: Mon,  1 Jun 2026 13:57:02 +0800
Message-ID: <20260601055704.167436-4-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601055704.167436-1-chizhiling@163.com>
References: <20260601055704.167436-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_7Q6Hx1qsb0MAw--.47504S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF4kZr13Kw18Kry8CryxuFg_yoW8WFyxpF
	y3G3Z8ArWkJayxWw4fXF4rur1Fvr93JrWUGFWxGF4YvFn0qr90qFyrKFyYkFWfA34UGw1I
	qa10yrWYka10yrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j70eQUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC9wG5V2odH0FQZAAA3F

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
index 3b5dc21b323c..b08118fbd275 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3339,6 +3339,20 @@ shmem_write_end(const struct kiocb *iocb, struct address_space *mapping,
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
@@ -3433,7 +3447,7 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
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

