Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDF947DD78
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Aug 2026 21:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785963989; cv=none; b=jO5fusHSdRUh3fith5aIFaAMyAP23lsz5C9O1+SAeM//DVv6CDy2terG7TbymdJDIbR7mGo6GvEmonTK/me9BEnJroEhIsGwOspBO1Mmg5YeO8wJv3kFiOcC9NwO3VZiyxRB7gjxdgUAU6UrWHUDuksHGW3ZZJ+dLxVBNQMzQKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785963989; c=relaxed/simple;
	bh=j7gGDzQHY5h6j0S61pQgeVlTDZaQGoXI4FNAETOFigU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oslk67k2lmX5hnAN+1f1WpHTbptlW4J5deGfRaJWfDLE6PF4qfdk2a3ly88yhUOMNPyt2QDSxl4oaT9kfXbsg9bCop1Bl4KQMzbJ/0537NxpEQSFlqNqC5xsIcGUop9EJJhHJyZzp1C+6PXRcc/yMXSHIcfgqtIH/2k9J/ONIrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wG2wDIMz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wG2wDIMz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=p/Fw7yB96qNg9eVkHMHEZx2IMjLwk7mFT+59ia7+Vjc=; b=wG2wDIMznIUjd/ztCA/5FaXYZX
	je9nyTHMWtGKfKgMqd+7/qCB+8m/2z33qc6aHk+lxlJLg/LEJzQCLYFNGPlB8+Gmq60bzADA6dmKO
	QwR9buG9mO8Eu/zqq+nhI9XnKlz0Ax92LsisqwFK0WACk6TnVwcEbKa2j2zEfXBi8c1sLleD9mXPB
	oydbf1C+sIEzZpMaZOFJTjRgJTzlBj1ivYNi7HnWenjocuuGSOS/LnZw5RUUBsDEx3JwAWAujjJpT
	N71/0nIjzE/hBL6kvLQdcydocmLECFJdkX0xFuf5r0bDUwqJ2KLP56xSBlNA4UvsfjzZOoqB/Ybx4
	jKnY+0bg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrioJ-00000004h6D-3C01;
	Wed, 05 Aug 2026 21:05:59 +0000
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
	Jiaqi Yan <jiaqiyan@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Gregory Price <gourry@gourry.net>
Subject: [PATCH v9 05/15] guest_memfd: Use folio_has_hwpoisoned_page()
Date: Wed,  5 Aug 2026 22:05:45 +0100
Message-ID: <20260805210557.1118966-6-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805210557.1118966-1-willy@infradead.org>
References: <20260805210557.1118966-1-willy@infradead.org>
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
Acked-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Ackerley Tng <ackerleytng@google.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Jane Chu <jane.chu@oracle.com>
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

