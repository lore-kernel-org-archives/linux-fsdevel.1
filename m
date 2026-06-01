Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FF8363C6B
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 19:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780341992; cv=none; b=gUoQn+HyEH/I1OKj1PcB/yhrDjWVcMr1L714+M8gVAQvWjrFStIh1i809bS1GWHh7BveJvQ4u5BwMZpvR7zcV27o/w6RJ97j/+zlpXgNSAdc5xA0ySokGwYFfoRlCnlFVHKU/o8bAYXJWq5i7TJhcNW4kfzX2V66AMVIdc01K6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780341992; c=relaxed/simple;
	bh=VVS5A+zfhd9WeJIMVX1hfB9oEM8MVJ2nynnhw0JPRjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Chds6tp2eOFwFYM5btpKWHqc8v5JhB3aB0Ez1zcFhZnyO6/OxeIF8T/0tWnFYuiq+OdlTj1ZmhoaByoapDQbbN6w9DjACdWJZUL2CyJJU5P+Pb9WNviA7t3hh2CdBec8FtpG7kjMwlzUHdy54xOt7dv17Vpbi2+Lpsm3HGbKc0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pVr3UK6T; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pVr3UK6T"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=c1KJ2Wwe3ucfE/pLWnGUXc+3brG6sd+o4SoK+rDcOrQ=; b=pVr3UK6T4h/0D/X6PEhDowRZa5
	3ke529BHpmBOlsRCOIjeWqpJ9ab1sK9cou2vPuLa0cUlOYI5k2QNwesxuG3PyqArcPJvHXCZmo6ov
	tA/AY9SR8sTEupLocLlYOedX7BPHxxA95xPDIDI/Bd9fFOcH122EfKvj45HqZFMnWNOijyMnTJ/Kj
	XpoAy+c/JMoXxsqEK2xLdJHAJ9dH81XlDCG8TE0a5CGrvidhGvMbuwQNUiwn5W9dfrz2yjlk+rxge
	ywR2bKppyST5x97vdb8Q9DkU+U665N/hTmf0XOYyjCNUV4xszCsapTojGOpby7Q9wX6bcsohpnq/8
	TrOqUVWg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU8HM-00000000dEa-0cW4;
	Mon, 01 Jun 2026 19:26:28 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/3] mm: Remove __folio_index
Date: Mon,  1 Jun 2026 20:26:22 +0100
Message-ID: <20260601192626.150804-4-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601192626.150804-1-willy@infradead.org>
References: <20260601192626.150804-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

People have been abusing the existence of __folio_index.  Since that was
too subtle for them, use a bigger hammer to make it unusable.  That also
makes it unusable for the FOLIO_MATCH, TABLE_MATCH and ZPDESC_MATCH
macros, but that's OK, since we don't care what fields these fields alias.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm_types.h | 9 +++------
 mm/zpdesc.h              | 2 --
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index a308e2c23b82..8f8687bb80d9 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -101,10 +101,9 @@ struct page {
 				struct llist_node pcp_llist;
 			};
 			struct address_space *mapping;
-			union {
-				pgoff_t __folio_index;		/* Our offset within mapping. */
-				unsigned long share;	/* share count for fsdax */
-			};
+#define DO_NOT_USE(x)	x ## __LINE__
+			unsigned long DO_NOT_USE(_pad);
+#undef DO_NOT_USE
 			/**
 			 * @private: Mapping-private opaque data.
 			 * Usually used for buffer_heads if PagePrivate.
@@ -511,7 +510,6 @@ FOLIO_MATCH(flags, flags);
 FOLIO_MATCH(lru, lru);
 FOLIO_MATCH(mapping, mapping);
 FOLIO_MATCH(compound_info, lru);
-FOLIO_MATCH(__folio_index, index);
 FOLIO_MATCH(private, private);
 FOLIO_MATCH(_mapcount, _mapcount);
 FOLIO_MATCH(_refcount, _refcount);
@@ -612,7 +610,6 @@ TABLE_MATCH(flags, pt_flags);
 TABLE_MATCH(compound_info, pt_list);
 TABLE_MATCH(compound_info, _pt_pad_1);
 TABLE_MATCH(mapping, __page_mapping);
-TABLE_MATCH(__folio_index, pt_index);
 TABLE_MATCH(rcu_head, pt_rcu_head);
 TABLE_MATCH(page_type, __page_type);
 TABLE_MATCH(_refcount, __page_refcount);
diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index b8258dc78548..194392afd3a7 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -54,8 +54,6 @@ struct zpdesc {
 ZPDESC_MATCH(flags, flags);
 ZPDESC_MATCH(lru, lru);
 ZPDESC_MATCH(mapping, movable_ops);
-ZPDESC_MATCH(__folio_index, next);
-ZPDESC_MATCH(__folio_index, handle);
 ZPDESC_MATCH(private, zspage);
 ZPDESC_MATCH(page_type, first_obj_offset);
 ZPDESC_MATCH(_refcount, _refcount);
-- 
2.47.3

