Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754774908DE
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 20:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785271489; cv=none; b=nJsu+UPHYA6GQ0+gkU4jkzxRfiz+mg5PZ1jF/MBK/lFqO2bAI+838gT9qP507+RBXWOtslwrq221XoskcPgpKsFgLHuzw6Zl7zWYk0aPadA4enXMKR2iPuo7I5BYZPMLn6g/qVoPqXq7mq6SLxLm/vEmkXcuOQdoyyHRsOGrLGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785271489; c=relaxed/simple;
	bh=zzjnGsY3Xuf34zUGvtnOe3MuqxG3eRFPnfCBDlbpt8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MRJSMKgMdUWrbo33IPQesGMVC35Lgc7pyshq4lbDLq07vBBI8DtEiK3zmBNP8x7cIr/dtYmIYOLy0nqOs6+vquR0AzoE9bkiBLi443+IIve2chrVxh7MRzkvXS8dDO7G2u59LCTFnqG/oqsXt9JqHVC5YFVAxrFukwFnvonsjnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JzvrCSsz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JzvrCSsz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=bJ70o10O/g3H5Xkl1BshZBHBRF3IX9NucmJReUP8SV0=; b=JzvrCSszvYiOIce4qGKkpUiAh6
	KQ3keSUTFtL80Lr2flwEphoPRUKe4rhlOTdq4XtjQoFIUbwa59Imw7G3jl9bzINM+UezFF31uw0aG
	z2UaMjcHOaQjT2bI661R6gOsxbv/qs9WTFIHaVc5weAe+FTR3t0TL8ED9xKbPE/a9mzVbTVgUrfBF
	34kzY53UzTljsbU4Qeblgt4QPyMpnKSFiG7F/eNfqSEwKHML9/ah+6QG89LsF+kfYrcLbLBcqu+xs
	4dz+zOiMhKNXJcx2eJBXgQ8YAQgAtPDnpQI8Hqn50iV6sF6gqMhZIicjch1h7OGKaOq3FgD/7TtE5
	596TWKdw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wooep-0000000EFWX-0K3s;
	Tue, 28 Jul 2026 20:44:11 +0000
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
Subject: [PATCH v7 04/13] guest_memfd: Use folio_has_hwpoisoned_page()
Date: Tue, 28 Jul 2026 21:43:56 +0100
Message-ID: <20260728204409.3396238-5-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260728204409.3396238-1-willy@infradead.org>
References: <20260728204409.3396238-1-willy@infradead.org>
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

