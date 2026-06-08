Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47E7390223
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2026 21:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780952790; cv=none; b=eP2j61HP+D8cooAPVpyqrXJb3lf7sPx30rNvzbmPG+d1S0c6lMhkar1k87xV94DUq1ZfYK4SlI1OyXi+xYOSLwVgkluXhw+MM0o/pSDOycfA5rvlrtwwO1WuKWZpuTTZHLLTUUyqy/cVkjwOx2j6dYM0bejYD7uFPIXwTZxPXLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780952790; c=relaxed/simple;
	bh=1LjS7l/wPLSIhRfvPAzj+L/s5vlI1jX0sJBRhn4RtJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PKsuL1E0upP/T/vmldhx3BK73JMGnhOyFbYnLj9TtYx7pgDZvSe3R/sUQobX84CxgJ5nqoOZb1JL4DZiXemljhRV8tGfa4ReVlqYMbgpX54KeaWKpCrw2Te+bMQ2QKdr5432uj/kuVUSkaQwdotEntO1CFmt4yYR355OmjdtjEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R3UKD6mx; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R3UKD6mx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=5s4XjAOLGYLp6LndP+lIAzECrIjlhFFVdD772BNrAS8=; b=R3UKD6mxV+D5lq/MadFzucIUA3
	Cbv3naiUJCSfOffqPrg131P12hFQ3fIMkgcjM1gIKTHNmQ/IQ/gc0RlgO4E9GUNI3WWWjdKx4X/Eb
	77VYkQUBX/34XYtPGMn7OYJ+zx8cq4Cs1YNPbla07sbp11mzzZ5XMm7xF2e8KmBF5fQCsm1AjNkfm
	KuYiHw1+o3mI8sYh61oyPHMwDj1KGXlIrsRvjs+Vv6lS1mAP8xn6XrTkRrO7qousVn8UR0sslxSPC
	PQo+IFUq/xtuXweOcAh2m1GmPNoYdZO2I8FaahyLa3vHoWnSy4yFpYnKrnEg6apQ2b5NGZ+qFRDl5
	3YIqk3vA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWhAq-0000000EQBa-3xbF;
	Mon, 08 Jun 2026 21:06:20 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Ye Liu <liuye@kylinos.cn>
Subject: [PATCH v2 5/6] show_page_info: Remove printing of page index
Date: Mon,  8 Jun 2026 22:06:15 +0100
Message-ID: <20260608210618.3437216-6-willy@infradead.org>
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

Pages don't have indexes, folios have indexes.  Just delete it.  This
script is going to become increasingly barren unless somebody steps up
to maintain it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Ye Liu <liuye@kylinos.cn>
---
 tools/mm/show_page_info.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/mm/show_page_info.py b/tools/mm/show_page_info.py
index c46d8ea283d7..69094ef50719 100644
--- a/tools/mm/show_page_info.py
+++ b/tools/mm/show_page_info.py
@@ -91,7 +91,6 @@ def show_page_state(page, addr, mm, pid, task):
             "Page Virtual": hex(page_to_virt(page).value_()),
             "Page Refcount": page._refcount.counter.value_(),
             "Page Mapcount": page._mapcount.counter.value_(),
-            "Page Index": hex(page.__folio_index.value_()),
             "Page Memcg Data": hex(page.memcg_data.value_()),
         }
 
-- 
2.47.3

