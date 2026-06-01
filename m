Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B47E273D6D;
	Mon,  1 Jun 2026 05:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780293490; cv=none; b=d0txyWAc7Zp/vcvvxjv7l7V8Z7Fi56y718bYEvCClmDaq8htMwQ3AuwxxzJwcW8zpaAVEJQ4zuRyFB2jbLwDh8flFFnZat5E1zwWKjAAVepdM5xPX95wyHMLuz38rgtui8YUDN8c98Ar2PxvmuNa/usT4iCe6QCrMxfraQpZVFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780293490; c=relaxed/simple;
	bh=q0on3xmktCoWaC80cHJbstOkLYMejQm7YbRQnLLX2tA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NFBJL9ZqYHBYmOPCG73UfyJf1COno5WbZvtMEn3MCwg+LxRty/qboa3SBJf0XQvBq13R0xJJWy3lGZqGu3KuN/vwvzeqvwOFB4YO5LfxeAQ1KgVl5STpvYc0p0pT/v9XadnWdPzJcvP99iMKmrJxKRgAPfrocVWMI1edCyszngA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dQkui9ew; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dQkui9ew"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=y8
	RQrqromftC/nCPgQZhg6QK2Ox4EieThtfTf6AdAQo=; b=dQkui9ew9GNqXbNcE6
	xWnzBmmRZQ25fnJ9RyI8uabGx6AnJkV84lvibaoa6svGxSn/AT6BDIhsk+QIK/9+
	lWV5UmeJTHkArpo0ghvPMKylnRj5RUe15kNf8/UUF4F1/kwpXdR8vGjAcobHfgfd
	8oyBC2hV+UbLEc0R/leHRdMEs=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3_7Q6Hx1qsb0MAw--.47504S3;
	Mon, 01 Jun 2026 13:57:19 +0800 (CST)
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
Subject: [PATCH v2 1/5] mm/filemap: reduce unnecessary xarray lookups when read cached pages
Date: Mon,  1 Jun 2026 13:57:00 +0800
Message-ID: <20260601055704.167436-2-chizhiling@163.com>
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
X-CM-TRANSID:_____wD3_7Q6Hx1qsb0MAw--.47504S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur4ruFW7JF1rZr1DCFyrXrb_yoW8Zr13pr
	n5Ka4ktr4DJFWYkrsxJ3WxZa4rK3sYqay5JFyxKw1fZFn8JFn8Kr92ga45G3Z8uFyrXF1I
	qF18Xa40gF45t3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j7a93UUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC9x+4VmodHz9QMQAA3w

From: Chi Zhiling <chizhiling@kylinos.cn>

When reading small amounts of data from the page cache, only a single
folio is typically returned from filemap_read_get_batch(). In this case,
calling xas_advance() or xas_next() after adding the folio to the batch
is unnecessary and only introduces extra branches.

The same issue exists for large reads, where one additional xarray walk
is always performed before termination.

Quit the loop once we get the last folio in the range, so the final
redundant xarray advancement can be avoided.

The xas_next() does not update xa_index when xas->xa_node is set to
XAS_RESTART, so the put and retry path would not update xa_index,
hence the warning should therefore never trigger.

During the 4k reads test, the overhead of this function dropped from
2.91% to 2.53%.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 mm/filemap.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 4e636647100c..d54450e529bd 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2458,12 +2458,16 @@ static void filemap_get_read_batch(struct address_space *mapping,
 {
 	XA_STATE(xas, &mapping->i_pages, index);
 	struct folio *folio;
+	pgoff_t next;
+
+	if (unlikely(index > max))
+		return;
 
 	rcu_read_lock();
 	for (folio = xas_load(&xas); folio; folio = xas_next(&xas)) {
 		if (xas_retry(&xas, folio))
 			continue;
-		if (xas.xa_index > max || xa_is_value(folio))
+		if (xa_is_value(folio) || WARN_ON(xas.xa_index > max))
 			break;
 		if (xa_is_sibling(folio))
 			break;
@@ -2479,7 +2483,11 @@ static void filemap_get_read_batch(struct address_space *mapping,
 			break;
 		if (folio_test_readahead(folio))
 			break;
-		xas_advance(&xas, folio_next_index(folio) - 1);
+
+		next = folio_next_index(folio);
+		if (next > max)
+			break;
+		xas_advance(&xas, next - 1);
 		continue;
 put_folio:
 		folio_put(folio);
-- 
2.43.0

