Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03E5471CF0
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 14:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784817055; cv=none; b=h30Pcnqf8zUB9rf7tZ098p3dtc+Gwb7Z3MY/Y6FNk2IeeQsWCAtWp9gBIqrsXed21YeoXXuS97Rx1w4KXZk23AzNwVVP6scqeivv6VfqevO2sUCXbP4Hoqvdq6TCMn80G20jTOWL2RXiIphVShiZU5G5lDg6McxhIZXcDydWkw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784817055; c=relaxed/simple;
	bh=RpP5w98aLyZs9ue2crFGh3X5oaOOYkDuiGwh5zONeg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ci58IAuPFdDgD33PdDPxbgMxCf8sU6V7igFYN3N7njh4dmI/h3rFbZyEyR2MQTMgxMwXdD4mK4jWjhTxRm3qvc+SUaSWgttcnjNm3fwBtz2PSUx0N/vIngAsgr3MVMlXbB4B3DL9PCb7I+IDfcvLZMOTk0DAVpFzJaYyT4S0CFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=t84RMmlD; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t84RMmlD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=I46grrWDH2O/dEj+ZMjbkD8D4mKznm+9gntugHYsM+g=; b=t84RMmlD0ISPnEJ9fDYzFYnGkC
	zDifmWaoBy14ux46UL1JmOHBicFN0exn+7bG8SLlIpUfCyMapxx7q/GkGkoU0JZPgUCZjwllUYm7h
	Be/aTtQYs6DuEV1T6vpLkIjdokW1+NGnfmUUtTViie+8lw6hgMalvv39WZnyZ4crGFO/IkiUlvqt3
	YligY2LoPqdwEEQiJrynXcoVtY1R/l89iXQuO4wpmI6Ui2osDUmNSCWWwBOj68e5IP9KTBVEkff/Q
	SjXBs6FiW4ETgI3UWKgxZgGUMm+RLmSL6qVoglBNPN+kolM8uI5AXWveSPUrWpDZ2S09i3Wewsutz
	YF1080jA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmuRY-00000000jhx-3lsm;
	Thu, 23 Jul 2026 14:30:36 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>,
	linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>,
	Jiaqi Yan <jiaqiyan@google.com>
Subject: [PATCH v4 05/14] guest_memfd: Use folio_has_hwpoisoned_page()
Date: Thu, 23 Jul 2026 15:30:22 +0100
Message-ID: <20260723143034.175661-6-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260723143034.175661-1-willy@infradead.org>
References: <20260723143034.175661-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

folio_test_hwpoison() only works on hugetlb folios today and will give
the wrong answer for other large folios.  folio_has_hwpoisoned_page()
works on both.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 virt/kvm/guest_memfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index db57c5766ab6..94eedcc7f1a9 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -774,7 +774,7 @@ static struct folio *__kvm_gmem_get_pfn(struct file *file,
 	if (IS_ERR(folio))
 		return folio;
 
-	if (folio_test_hwpoison(folio)) {
+	if (folio_has_hwpoisoned_page(folio)) {
 		folio_unlock(folio);
 		folio_put(folio);
 		return ERR_PTR(-EHWPOISON);
-- 
2.47.3

