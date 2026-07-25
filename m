Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277553939B9
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2026 16:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784995265; cv=none; b=kWJr2xdHAe+WfyVPg+/vschBISDbm5v/vQ6NCAQkzWqpEhqJMMQrKOWwhSZdIXC/cDfMj0H6KLG24XcJ7NhBgDsdwtzaZyvNTHl3ILkfWLW8oJ++xm5VHUxd8mnU8P85WqDz6uCi+nRBgXy8UY2K22U46zONh5a2g+Bho3cSsvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784995265; c=relaxed/simple;
	bh=REKdxukiM/1vvRHY9FF3B4gCpxLxcVRQ5Dyqkh0ozYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OL43XeJxGs6rQNxaRRqhL+0kjed6irgWL6/1JAOtjKe6T2q/xJfom6plZ2ALOfB28+4L0XBO3ChFijLVQGugcaTL1KyQ7eVG/0Q3vRUp/x4VdSOOg0FuNEg+12RlOOuPLVaBZvSvBafvCryvEQeO8uzBQ0Kz7Y5igaBqm0QYAFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=u8/nxg/5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u8/nxg/5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=WvwUAx6FxDsrZq8ixYPmqXc4qqzBUS0RK7TxCy7zUaA=; b=u8/nxg/5NouAYRHeZNdNRAgwzQ
	0FNf7C/7P6pBVkXj5v+47x0OjnKCop5JQjvGWzI27XmdCLhWrSJokm6AxzN9H1481KjQwzcX5bxJ4
	a46bYQ3836F5jvg7jXDYXjkmpN3BGk68sM9bzRkYbQyO+Adg8TWst0zxmnsAk+Gj/ybVrTDR1AhSB
	JO+V7P7ucqqTjvMeegeLwiJACNdRoSCN5BgLFdah8fHql9xJrS+o4XRo/BnmwjiaylYjlEaurTsVE
	DmZIAGgUMNHq7ju3BsP/6+DVugNPBW1UDpanxwMpgP2FBbSHBHySKs4MYhn/tPlDFuQFSW+khtUBV
	qvF3oEuA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnenr-00000006X7W-3D4j;
	Sat, 25 Jul 2026 16:00:43 +0000
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
	Ackerley Tng <ackerleytng@google.com>
Subject: [PATCH v5 04/12] guest_memfd: Use folio_has_hwpoisoned_page()
Date: Sat, 25 Jul 2026 17:00:32 +0100
Message-ID: <20260725160042.1557264-5-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260725160042.1557264-1-willy@infradead.org>
References: <20260725160042.1557264-1-willy@infradead.org>
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

