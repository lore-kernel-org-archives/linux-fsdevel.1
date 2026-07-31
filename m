Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746B233372A
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 20:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785528498; cv=none; b=uLh2VUQynusVMggJ7ILx6rlOVUkt8bZjLnVggbaO8glhQCRWXOKCDLfgOUbhOA40l2AswAeMnqwO4HS3x9PFBi0IyR8tf+WmWodV9drPCItr5JCQmT8jgwpXzmEkqAcqlTO3JayKFZ1Z2c6OT2hm2bBdsF8azot8DdNcLUzhtsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785528498; c=relaxed/simple;
	bh=zzjnGsY3Xuf34zUGvtnOe3MuqxG3eRFPnfCBDlbpt8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B/qpTDyqhUqspibRgBYVDSm4gtBtyEvPGR6GxFXu7iBC6JvkHbScizp0GjMBHTWV8d/QhtEpqCbgLWVwi6jcoVYKS2VR8lUkbkDLY00jKfAqepSzvv/xwDf5sEzVMXxntkv20yu5k0uTwDEKMsCdavl/EHNAH5mxX0txqULt1No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WEUFo6lg; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WEUFo6lg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=bJ70o10O/g3H5Xkl1BshZBHBRF3IX9NucmJReUP8SV0=; b=WEUFo6lgpEaA3POSXGYOQvorJ9
	q53YIASpBfUusnCBlMc8ZeJXQClAlqIBG8xH98fFuBv8wle3jTQqR/d7AqvrCCjMYTvXY3Lh7RJ4L
	5xJVaolHKvCU2XoLkGguvbczr+dN9xS9+qjc28qvAR8tuR/zJT+Kh3iFd+GAIuHWymQN/TkwZMcZy
	jcyop2y8kT2j23DSIqZc8tTVfyzw3cERn/7cFsPIN4h+EX0dgtLC8pUyDouP286OjeVhAdg0We/nu
	AP/d57Df9WRrji5aarcIVGCJgxTyoB7NJx1kopNFKmXsa8KphPUsu7NtqdyK7v9mqC73a9aKpbxUJ
	iOPnk2dA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wptWW-00000002PjV-2oCc;
	Fri, 31 Jul 2026 20:08:04 +0000
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
Subject: [PATCH v8 05/15] guest_memfd: Use folio_has_hwpoisoned_page()
Date: Fri, 31 Jul 2026 21:07:50 +0100
Message-ID: <20260731200802.574821-6-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260731200802.574821-1-willy@infradead.org>
References: <20260731200802.574821-1-willy@infradead.org>
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

