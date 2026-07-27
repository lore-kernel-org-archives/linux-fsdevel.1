Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93B042D770
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 18:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785176012; cv=none; b=ov8B8r38jkhtGW6iccNVMNEEp+5D7TGgbMEfWAPJkcv60ADC+jyFFaaIr4Fb3m2UHgUe+cH05vjMAlL8cT/6RuzbEaNrvRfxbtyxA0f7rqe72akXv6RoIS2pki8Bg6DX7kIe0nMZijnFvtXG6aF/8dovY4eD8cELBLCAUeH1gNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785176012; c=relaxed/simple;
	bh=REKdxukiM/1vvRHY9FF3B4gCpxLxcVRQ5Dyqkh0ozYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g59hPVa798I+aiDiNZSdKorZt9EWsA/kyGPF5eLUPvK8c9vaQnh0oXRRn4jreAk9yIh5jCYgRwAnzJFnfdrbWx2P5GL0H5vi7drAUePbSV9xzMKBJMvubD8Zo61w0OSRt2uy0dFhHsKZmbJCSZbyV1Z64IHg6roAI/rreQJA1cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=l+6i6MH2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l+6i6MH2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=WvwUAx6FxDsrZq8ixYPmqXc4qqzBUS0RK7TxCy7zUaA=; b=l+6i6MH2DbA+vKjsUFQ2UyCKGB
	BAzcZTd554OkBnhRbbW7XA505wKQjkkkKiaSXU26Po13RUMIphsrd0acJKL77YuG0jg81fg7wt1Kz
	EEX37GJKgeu+ah4z2WOEb5o835Xy3lBOedKn7hhNQL+vaA2LeG6Vg4P9ihliC9vBAH3duiv0WG6dt
	1LBrpNH1Bc55T6w6KKREa9iLA68xFv1cOLdikxMP2qeb1T1ZR1B0IxovvJh7ssOCUOxYAsznqyOz3
	uRhLOC5KZx578/t1KLWGPzcJtO2GEIg80K7DjNc53S6nwH4m4E2PwqAW6Szr2Huizj+ZioqyD6BU7
	0jXGcdAQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woPpA-0000000BD7U-0hk6;
	Mon, 27 Jul 2026 18:13:12 +0000
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
Subject: [PATCH v6 04/12] guest_memfd: Use folio_has_hwpoisoned_page()
Date: Mon, 27 Jul 2026 19:13:00 +0100
Message-ID: <20260727181310.2671972-5-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260727181310.2671972-1-willy@infradead.org>
References: <20260727181310.2671972-1-willy@infradead.org>
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

