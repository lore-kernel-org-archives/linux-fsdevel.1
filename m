Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC01C3750BE;
	Sat, 20 Jun 2026 06:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781936756; cv=none; b=MVeG8isNQ18SKiu8dHFM0Wllp3KWRRJbAT3jF853RFnLL9UEoqQnRcTxrGm1cyiql6xa7YYtT6NWlkQ6CtOhCXUrLAn2USmxcLFS1eXrKQzOv6X/Ecmtu155EA5upcgCqphCMkGQdmq8dSns8LJ0E1au8B8aFAMY7xfgnhqvWqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781936756; c=relaxed/simple;
	bh=UqXjzrCUF1bPzxEq5ikGxBioYdY1aVWmFLF1ylksSXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jx+UEm5/CKXEIpamqZQMnYD3fK1K39OHEa7Na4mgZhi3mB1TRkSFbekXKOWaeOpXJpxv7aV43A+grsif5kNsEP7AvQ/08L7/kxTQeAClVRVLhIIiYM2afPl6ZsIf1ykXvxJm0FwDFDLa6yXEhDi/oUZQIIGo1LHJBf+AgDJf7/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kPpS26K+; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kPpS26K+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=78
	yxgcB9WIpsNzqGXaqF02HCLrwEpdIWxi+Ft8/BnzY=; b=kPpS26K+t6y/4jTr13
	yaSwri4fHHjCHuIaxRIcMkmXI8+U5U1p0XfEuFzcS8aiSOR+/oIrtgBtcQVpOBoE
	cUiaXEx0a80eAis6ualadoCS0RzMHG99C+WWlBoMeosxm1kBVXMqNe5xZptDwcSo
	2XS6FHaAyuqxT/W1USbAxC4kY=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wBHTsswMjZq5+F0Eg--.19463S4;
	Sat, 20 Jun 2026 14:24:52 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH 2/2] mm/filemap: reduce unnecessary xarray lookups in filemap_get_folios_contig()
Date: Sat, 20 Jun 2026 14:24:46 +0800
Message-ID: <20260620062446.351475-3-chizhiling@163.com>
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
X-CM-TRANSID:_____wBHTsswMjZq5+F0Eg--.19463S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur1ktw17Cw4kAr48KFy5twb_yoW8uF18pF
	4aga4kurWxGF17Cr13A3WrC3WFk3sYqa15GFWxG3WSvFn0yFn0kr17K3W5J398Zr95JF1x
	Xa18J348WF1UJa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jDtxfUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC3BTBX2o2MjTWNgAA3s

From: Chi Zhiling <chizhiling@kylinos.cn>

Apply the same optimization used in filemap_get_read_batch() by moving
the boundary check from the loop condition to before xas_next(),
avoiding an unnecessary xarray lookup and reducing branches in the fast
path.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 mm/filemap.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 199c835c68bf..4ee591bc7e71 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2270,10 +2270,11 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 	unsigned long nr;
 	struct folio *folio;
 
-	rcu_read_lock();
+	if (*start > end)
+		return 0;
 
-	for (folio = xas_load(&xas); folio && xas.xa_index <= end;
-			folio = xas_next(&xas)) {
+	rcu_read_lock();
+	for (folio = xas_load(&xas); folio; folio = xas_next(&xas)) {
 		if (xas_retry(&xas, folio))
 			continue;
 		/*
@@ -2281,11 +2282,11 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
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
@@ -2293,29 +2294,27 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 		if (unlikely(folio != xas_reload(&xas)))
 			goto put_folio;
 
-		if (!folio_batch_add(fbatch, folio)) {
-			*start = folio_next_index(folio);
-			goto out;
-		}
+		if (!folio_batch_add(fbatch, folio))
+			break;
+
 		xas_advance(&xas, folio_next_index(folio) - 1);
+		if (xas.xa_index >= end)
+			break;
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

