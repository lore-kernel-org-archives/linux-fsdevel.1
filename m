Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B431346A10;
	Mon,  1 Jun 2026 05:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780293495; cv=none; b=jjlDDFs/tBaT0HBHmsZBrIC61Eb7lOUsjComr4Y1q8+IUkxcGC9P/AZGN6GHK/ajy2SwP590oyc5bV+wx/Wvz8vrNSp9AsYjIgneFsG1SP3hJ2Lp0lF1g1wPIL+598ipteA9oayrqB2A5EycQwjIyrQBYik/Vnmcz5cn+ySjTjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780293495; c=relaxed/simple;
	bh=UMxeq9LPuPXgUjRNwxWespCzYt4u0qUiwMiR3PxLwQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJQhqdSj61IksVRSMc+NlXaR7z4/M/VN0plSjwq/vMqo5vRZsAA4/5QlqfhPcwEFzJJEKQOv/LL2ey0OHwws0dAOfDVoN9xWAB3W6ZPf8g+77m7YFa3I4Q4T3GTXJbHiC2Eg3KPp85sh0x9fk7L3Ow/1HRZMnZqmkkQx+YQuhAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HQh1rnhi; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HQh1rnhi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=hS
	FfhvzoChQOQgIIJG5v3NjnH7WU8ceJmhHARcctEEs=; b=HQh1rnhiRosYsEScko
	GkClTFquAuKP+Vh79FH9s2EGthCwz9V6MaOhQB2tX/5wFhrFQjJ565KBQYkPMy3a
	+1/ckkRU5cUMXC45gK942ZQ4HdnVnAi6hpF719Fa67drlNBfIfnF/4te+WYqDEoZ
	bY6j/Z8TL74u0/qa58UchjLI0=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3_7Q6Hx1qsb0MAw--.47504S4;
	Mon, 01 Jun 2026 13:57:20 +0800 (CST)
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
Subject: [PATCH v2 2/5] mm/filemap: reduce xarray lookups in filemap_get_folios_contig()
Date: Mon,  1 Jun 2026 13:57:01 +0800
Message-ID: <20260601055704.167436-3-chizhiling@163.com>
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
X-CM-TRANSID:_____wD3_7Q6Hx1qsb0MAw--.47504S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur1ktw17Cw4kAF17WFy7trb_yoW8tFWfpF
	4agas7WrWxJw13Cr1fA3WrC3WYk34vqa15GFWxGw1fZFn0yFnIkr17K3W5Jas8ZrykJF1x
	XF48J34kWF1UJa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j24E_UUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC9wC5V2odH0BQSAAA3p

From: Chi Zhiling <chizhiling@kylinos.cn>

Apply the same optimization used in filemap_get_read_batch() by moving
the boundary check from the loop condition to before xas_advance(),
avoiding an unnecessary xarray lookup and reducing branches in the fast
path.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 mm/filemap.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index d54450e529bd..6bc717f205a7 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2258,11 +2258,13 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 	XA_STATE(xas, &mapping->i_pages, *start);
 	unsigned long nr;
 	struct folio *folio;
+	pgoff_t next;
 
-	rcu_read_lock();
+	if (unlikely(*start > end))
+		return 0;
 
-	for (folio = xas_load(&xas); folio && xas.xa_index <= end;
-			folio = xas_next(&xas)) {
+	rcu_read_lock();
+	for (folio = xas_load(&xas); folio; folio = xas_next(&xas)) {
 		if (xas_retry(&xas, folio))
 			continue;
 		/*
@@ -2270,11 +2272,11 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 		 * No current caller is looking for DAX entries.
 		 */
 		if (xa_is_value(folio))
-			goto update_start;
+			break;
 
 		/* If we landed in the middle of a THP, continue at its end. */
 		if (xa_is_sibling(folio))
-			goto update_start;
+			break;
 
 		if (!folio_try_get(folio))
 			goto retry;
@@ -2282,30 +2284,28 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 		if (unlikely(folio != xas_reload(&xas)))
 			goto put_folio;
 
-		if (!folio_batch_add(fbatch, folio)) {
-			nr = folio_nr_pages(folio);
-			*start = folio->index + nr;
-			goto out;
-		}
-		xas_advance(&xas, folio_next_index(folio) - 1);
+		if (!folio_batch_add(fbatch, folio))
+			break;
+
+		next = folio_next_index(folio);
+		if (next > end)
+			break;
+		xas_advance(&xas, next - 1);
 		continue;
+
 put_folio:
 		folio_put(folio);
-
 retry:
 		xas_reset(&xas);
 	}
+	rcu_read_unlock();
 
-update_start:
 	nr = folio_batch_count(fbatch);
-
 	if (nr) {
 		folio = fbatch->folios[nr - 1];
 		*start = folio_next_index(folio);
 	}
-out:
-	rcu_read_unlock();
-	return folio_batch_count(fbatch);
+	return nr;
 }
 EXPORT_SYMBOL(filemap_get_folios_contig);
 
-- 
2.43.0

