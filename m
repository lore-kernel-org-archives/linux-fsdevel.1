Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DAA3749E2;
	Sat, 20 Jun 2026 06:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781936749; cv=none; b=K98j5oZT91vA6G9jBKs3xjLHaFVdIkv+Dx44F0uWUONZWQJ9PJt85Wzbogo8tIgixmiVJJrPqip619y0M/3uDdvc9iXHEMMW9TD02QGXy7l+iu1tl4tOXR5EQiOqRlqcmnhzWQsOHFn7rFerd+ZddhkDXiYyZYbgWikEwx2YbEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781936749; c=relaxed/simple;
	bh=46Mj9xAE6Eyf9H6XqvU5rReAWfEbEt/yF/Lz3szkO+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o9GIqjs7bKZxfhfB18gTLEb42reKduLbXPZbivd432QNqwIRJFd97rBKi75wAncsvin9BUS6YFUY5KHZtaApUgBiX1BSoneI3Z5lg2py/6tDzPuUchZq+vLhS+cdtSO1NgULTkfi/H1ZkZSGGnqx9nq2Nblaxye1TC5VM6Yh55k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=qLAtKll1; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qLAtKll1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=IR
	8OjEadSHNp3RDaVRCbvQ410sp8ufyNn8WIXp3XoqQ=; b=qLAtKll1DZSW+tm/yx
	i4eBERR1R1JbYXQYo7k1gg6iSM75Wf4VUbGeVtQf5yVHpCk8XkAB5egBghhftfve
	/r8b2iV9s356z4LSeahlOxigeGnwx+shyB72NP1LZP9IaSo3cFZcLVs5aKHLHpV1
	sDFyGmBiSVxBX48qFEzcr+vMo=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wBHTsswMjZq5+F0Eg--.19463S3;
	Sat, 20 Jun 2026 14:24:52 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH 1/2] mm/filemap: reduce unnecessary xarray lookups when read cached pages
Date: Sat, 20 Jun 2026 14:24:45 +0800
Message-ID: <20260620062446.351475-2-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260620062446.351475-1-chizhiling@163.com>
References: <20260620062446.351475-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHTsswMjZq5+F0Eg--.19463S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur4ruFW7JF1rZr1DCFyrXrb_yoW8CF13pr
	Z8Ga4ktrWDJFWUCrsrA3WSv34Fg3s2qFW5JFyxK34avFn8tFnIkrWxKa45G3Z8uryrAF1S
	qF18X348WF45t3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jzhFxUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC2xTBX2o2MjQOiAAA3N

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

Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 mm/filemap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 09cf51fd43b2..199c835c68bf 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2467,11 +2467,14 @@ static void filemap_get_read_batch(struct address_space *mapping,
 	XA_STATE(xas, &mapping->i_pages, index);
 	struct folio *folio;
 
+	if (index > max)
+		return;
+
 	rcu_read_lock();
 	for (folio = xas_load(&xas); folio; folio = xas_next(&xas)) {
 		if (xas_retry(&xas, folio))
 			continue;
-		if (xas.xa_index > max || xa_is_value(folio))
+		if (xa_is_value(folio))
 			break;
 		if (xa_is_sibling(folio))
 			break;
@@ -2488,6 +2491,8 @@ static void filemap_get_read_batch(struct address_space *mapping,
 		if (folio_test_readahead(folio))
 			break;
 		xas_advance(&xas, folio_next_index(folio) - 1);
+		if (xas.xa_index >= max)
+			break;
 		continue;
 put_folio:
 		folio_put(folio);
-- 
2.43.0

