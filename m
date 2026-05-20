Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBB8371076;
	Wed, 20 May 2026 10:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779272386; cv=none; b=E+vWukdEgOjSNf5zU0tc+KPMX6ec4HHwc/1+sZhN2J0Og4V+Yi9AIrYXp+0TUsXzYzxtXoHIA2DOsH+tvxAd8LZZoDErI6JblknhZ5C6jp2CGo6VLgx49MX333zHSHyS30N36vd7iO35sCbzn2lmuIgrglX5csKt/XIgsAai7cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779272386; c=relaxed/simple;
	bh=+cmwFjakZiPSRkrOfY05sf/K/tS/w+gImnoUnzNZxAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tLj6IceAQokglemVu0f4ZM0e50nOzW3TRpPwz2XfsYr8H2xCfogQ/izjlXHi3XFTqnH/JipRilH2GkGpF1hjKeD6eua5zkn50mi2Ic4ZPPdekd+N488nwtkvURqPjlruOVdZjJyfhNmfIikeJVzbiDxtPr61sT97EpC00OQdRwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pD55Ilf4; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pD55Ilf4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=JJ
	QSb989Ft1cng8RSYH6fugEX9Hh0WZTKoGw3OGruD8=; b=pD55Ilf4nur0tnOU3G
	mx8swE2IrmRVcgZOcH5xJ6wXEP5i2Iww7dZ2JUazo2UZsnqUCQd0SsmwQWanpMxp
	Cg8d62lthDrQK0WnvTLCAazsnzvaCs6WZDkHMYyxMQzSRVtOOUcXSK5BpmqhevWy
	Okwi+hkZict3J5KTkTuy/EkfE=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDXbbprig1qQK31EQ--.641S4;
	Wed, 20 May 2026 18:18:25 +0800 (CST)
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
Subject: [PATCH v1 2/5] mm/filemap: reduce xarray lookups in filemap_get_folios_contig()
Date: Wed, 20 May 2026 18:15:35 +0800
Message-ID: <20260520101538.58745-3-chizhiling@163.com>
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
X-CM-TRANSID:QCgvCgDXbbprig1qQK31EQ--.641S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur1ktw17Cw4kAry5Zw4kCrg_yoW8uF4DpF
	43Ka4kWrWxJr13urnxA3Z5C3WYg34kWa15CFW7G3WavFnIyFnIkrnrK3W5Gr98ZrykJF1x
	XF48A348WF1Ut37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jSsjbUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC3BGcOmoNinFztgAA3y

From: Chi Zhiling <chizhiling@kylinos.cn>

Apply the same optimization used in filemap_get_read_batch() by moving
the boundary check from the loop condition to before xas_advance(),
avoiding an unnecessary xarray lookup and reducing branches in the fast
path.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 mm/filemap.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index d54450e529bd..5a5268a7c802 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2258,11 +2258,14 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 	XA_STATE(xas, &mapping->i_pages, *start);
 	unsigned long nr;
 	struct folio *folio;
+	pgoff_t next;
+
+	if (unlikely(*start > end))
+		return 0;
 
 	rcu_read_lock();
 
-	for (folio = xas_load(&xas); folio && xas.xa_index <= end;
-			folio = xas_next(&xas)) {
+	for (folio = xas_load(&xas); folio; folio = xas_next(&xas)) {
 		if (xas_retry(&xas, folio))
 			continue;
 		/*
@@ -2270,11 +2273,11 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
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
@@ -2282,12 +2285,15 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 		if (unlikely(folio != xas_reload(&xas)))
 			goto put_folio;
 
+		next = folio_next_index(folio);
 		if (!folio_batch_add(fbatch, folio)) {
-			nr = folio_nr_pages(folio);
-			*start = folio->index + nr;
+			*start = next;
 			goto out;
 		}
-		xas_advance(&xas, folio_next_index(folio) - 1);
+
+		if (next > end)
+			break;
+		xas_advance(&xas, next - 1);
 		continue;
 put_folio:
 		folio_put(folio);
@@ -2296,9 +2302,7 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 		xas_reset(&xas);
 	}
 
-update_start:
 	nr = folio_batch_count(fbatch);
-
 	if (nr) {
 		folio = fbatch->folios[nr - 1];
 		*start = folio_next_index(folio);
-- 
2.43.0

