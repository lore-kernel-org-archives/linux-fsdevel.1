Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68B2390212
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2026 21:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780952790; cv=none; b=RL03R318vOL7p8FOfuYnaSpNSzavwWqfjjwPYGCDc++Itf96FCxVq0IIJ04KchSqcx6Ly61ZIcBu7UiG8B9xj1Cikf7ndrLso+US8q2Cw04ipaqG2D0zec1zrOsg7ckETggzMkREFa+MCdvK10D66LA5tFY9Ehit16TLmWhN9+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780952790; c=relaxed/simple;
	bh=F7j9ZzrM0VfoeUmCCt5mChyipEhJ56IzXJJOThTCKjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oSEjsrOH3lwVxkuEK1KrDW/slRVyyygmSlLvxBzvxhHNevaBJn7izdebPW/KBylDSm+FGl9Wl1lpCGL5q2tDP6R5z67Z/Zr9MqEq/ZowDply1Z5M6U2fTlKdPT/IyujhzrluM8JTvBqUWXRtP3ohegAXboseGAkKMPKLzwWyd2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KROTr9S0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KROTr9S0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=uC57su7lQhQO1NelrjFHBLfbzQzxYj6jVoSFj1yoiXE=; b=KROTr9S0xX7mmTN3ichkij6BhP
	5TUMSFKNc7JNU8ZXJSU77mMLY2dt+E83FTj+WG4WPma1nJt+VEQUGfe+SA89ZwPFloHDbLXq+XRO3
	9Z1E1Qv3wV/peDxQVjJzcZQw4wM4pTesRuRVjEWdPaENeB73bqntyuYwb64yCbpaC1MJ+XXbjDgnE
	xvlilLt7d10XjGfdvsaXp4yPe63J/4JILdFWMHRCfnEedojZZQAeNDzYYGNiVCN+twA/llkW/giiF
	BijelPH+kcQUZa1C24P78cP3MMCXH+c0FmZF4j5CYOd5n0Jcr4BHaOT3jcs8gHSXrBJsnrV512xbs
	9SuXJ3xQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWhAr-0000000EQBl-0e9m;
	Mon, 08 Jun 2026 21:06:21 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 6/6] mm: Remove __folio_index
Date: Mon,  8 Jun 2026 22:06:16 +0100
Message-ID: <20260608210618.3437216-7-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608210618.3437216-1-willy@infradead.org>
References: <20260608210618.3437216-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

People have been abusing the existence of __folio_index.  Since that
was too subtle for them, unname it entirely.  Now we can't use it in the
FOLIO_MATCH, TABLE_MATCH and ZPDESC_MATCH macros, but that's OK, since
we don't care whether these fields alias index or some other field.
Also remove page->share since all users have been converted to use
folio->share and I'm absolutely certain somebody will start to access
folio->index through page->share if it's not removed.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm_types.h | 7 +------
 mm/zpdesc.h              | 2 --
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index a308e2c23b82..2f2ba262b963 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -101,10 +101,7 @@ struct page {
 				struct llist_node pcp_llist;
 			};
 			struct address_space *mapping;
-			union {
-				pgoff_t __folio_index;		/* Our offset within mapping. */
-				unsigned long share;	/* share count for fsdax */
-			};
+			unsigned long :1;	/* formerly index */
 			/**
 			 * @private: Mapping-private opaque data.
 			 * Usually used for buffer_heads if PagePrivate.
@@ -511,7 +508,6 @@ FOLIO_MATCH(flags, flags);
 FOLIO_MATCH(lru, lru);
 FOLIO_MATCH(mapping, mapping);
 FOLIO_MATCH(compound_info, lru);
-FOLIO_MATCH(__folio_index, index);
 FOLIO_MATCH(private, private);
 FOLIO_MATCH(_mapcount, _mapcount);
 FOLIO_MATCH(_refcount, _refcount);
@@ -612,7 +608,6 @@ TABLE_MATCH(flags, pt_flags);
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

