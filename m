Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794870422;
	b=xQAZa7DQcSMbf0VmSuKX1DzvGIjvkkkjysCz+YSPOXs1ZPHazKmAuaeCGfLXBZ/5U/oB
	 0qWx/hbg2zR4REj5xPD2D2Ce+c/wsHLmlqBjrgPxEezN3piPUkurozJ8c6fHyL6OMAJ2b
	 mhIByopKHdWaUDIfoOTksXLF/gqtBPrZ3sIk38Dqcyb0oD2mm+i76jrIyPTNDzMICeX0q
	 uyfJ64NKlzQHxTMMF3CmfWpKUNpiOQbR555AfoSHUS29htoTnVr6ThXaibiPpyS7RI83e
	 5Cx4qHBUj1zI9pqZsOOCeWoaGPi+yid+RyrokSGWf9zCdxWa62sO554zn/MWiQK77kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794870422;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7noARN/sft+NtmJTHmUDUAvU1Dihrn7FLenu365oKlA=;
	b=c7029KNX99VMcBEk0QqMl7lCk2LmF/yN9VZl/zkzevN4qJLHa+81lAYq2wGkg80wWbIq
	 yaE8nux/WVn+q9taxdBpPIUwIan1nJuotrU0qowRk2ttbrbtdw2FatIqU2z4cDzD0KICS
	 a2yA+4WvA55S5MVjFiKRdHAm3r+MIWRmaJ9g/1OEOO58q8urEp/rX8d/vDtFcojSVIP3Y
	 HsHJSpkvXhb9QJtmfoWzCgq4Zr+0U3r4A0/AkiRbWeb/drA/0FT3/Ibzr5ENUn3NejaMA
	 PTRIlL46D0ySnzMDQDpQb3mA3Bv2GiPfq1qUVfu5oazc67bzUOU7Z9uWecM7QOaqwEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=enUWIj8X;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD81D60A2604
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 23:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD81D60A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=enUWIj8X
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3b18bae2d56so594597a91.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 15:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794870421; x=1795475221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7noARN/sft+NtmJTHmUDUAvU1Dihrn7FLenu365oKlA=;
        b=enUWIj8XP4fdmByupRV6Q+NzmHYsTToCdcISBTo61x8Jh1LpzrDWa09rQhw6o8j0zf
         zFZqaE5P63pazT1sef9+1/JrWGdxK7weHtli/So0ILcKKBw6LqEx3uK8nYA5wk1bU87v
         3OK/vKMMFLi4B13HeojKSBQbJ+ujWeRibOE9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870421; x=1795475221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7noARN/sft+NtmJTHmUDUAvU1Dihrn7FLenu365oKlA=;
        b=pSl0GBs9S+aKPwWDWiQ7o7AjkYsBxr1vG2yoRBdc0FFZbHd9mwKYIAmpkPAGaLoYkA
         U4Hp44rytT4Q6xOIq7rlRn6TAJKAYdQdapI00rGFsFIDfwr7+Cawkfu0NSyQoclaixdq
         djvwLw8yVJb71u8f0EABUcW/pyqVwt+mQJPml3zcnEBIeWLqG1rxG2zXq3hLajhW/0if
         zojxmVpTszVuqOj1tBfaYRDZrraMnXFfjT3GqhPX73f2vj9K3rzjQvI7/aYJu1q4NxNx
         30vXhGAdzJl5Ef9q3/wn4aN+JWyCr4RUeRuvWlIhsU+8SeVbS/COynbAH7Frtbnhpv+S
         t5hg==
X-Forwarded-Encrypted: i=1; AL+hErHZlrrNOKK2tkIlItjD85FzBrCx12CgBhIpsfp6nTk6xdZu5hAuoIEGs1IXlsOJABJ2D5VCyJJZE7g3t4Dq@vger.kernel.org
X-Gm-Message-State: APuU4Z8gUy47JQQ6n6Di6ql86zdJ1JKsc7NmIbu5hSQ0gzE0NGcRzwwn
	zNrqlqchS9G9UiNnUL0yRJuLCA3RnfMCeGLgxWUxFD7csG0IeFdI3bWRccuhfAyTgQ==
X-Gm-Gg: AZFdTZeDMx/n4PVoY5UB008Wp4H37JA2apRHOp2a54LNr4FtBrbu0MBKaRXARgvkzSg
	iW2QPDGAH+I+LekcHYkNMqGyCWiEgchwW1mcGkFA4x/bOcze3EiWfH/0As36w8zjlw05wNj54dp
	81NdA8s2OPq0guBIVRunndT0REOi+/E+BLTlaNGSGeADbntJI7zI+y3D5ZFiQGDvhDxCLiLcsnk
	bCsetoahyNZL2DcP/b8DG/QZWj/XJAcOTtigjEoulKUyWlYMTp9d2jNSVpWm2fAfPiSEffQpFmy
	eLoGD9ZAtIM5x/2YIZYcTuvtG7KXjRH6g1wPc/DsdScvdEtNi86NlYeAetxZIOdSM8gABuLxQUj
	JHPOjN6lE28Z878MdhzKNahnXjxKTImpeAV6vKe0pRqun0hzoUR8JWvxHkz6JUmNrNE3UN/YCf0
	NuzZeBPdH9QmouzKbPJSUQ6t7zeJtv7AFhUx0dNfS8WuX/K6/c1YruXUK9bGavfYufx4uJRMatn
	4gnYC5e1E7L23WKQUZbMoPzI4+/PxLkbeRxmh/0UtESEUIyfyPMYAv155FY9q5SJ1wScmbXSChY
	Mg8b4VTu1fFMs+rNWQ4uL+QNGR4zvfl4wWZ6OpECb60gvYDo9DA6327ZVoSPbHk9CHv6rCM=
X-Received: by 2002:a17:90a:c88f:b0:3b0:9a3e:bf8b with SMTP id 98e67ed59e1d1-3b1b0b5d63amr16850510a91.6.1794870420893;
        Mon, 16 Nov 2026 15:07:00 -0800 (PST)
Received: from localhost (221.247.125.34.bc.googleusercontent.com. [34.125.247.221])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-cddc1873531sm4674755a12.10.2026.11.16.15.06.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 15:07:00 -0800 (PST)
From: Jeff Xu <jeffxu@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Jeff Xu <jeffxu@chromium.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Zi Yan <ziy@nvidia.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Marco Elver <elver@google.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chia-I Wu <olvaffe@gmail.com>,
	Dev Jain <dev.jain@arm.com>,
	Evgenii Stepanov <eugenis@google.com>,
	Ian Rickards <ian.rickards@arm.com>,
	Jann Horn <jannh@google.com>,
	Jeff Vander Stoep <jeffv@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Kees Cook <kees@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Collingbourne <peter@pcc.me.uk>,
	=?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Tomasz Figa <tfiga@chromium.org>,
	Will Deacon <will@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Baoquan He <baoquan.he@linux.dev>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Allison Henderson <achender@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-mm@kvack.org,
	kasan-dev@googlegroups.com,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	kexec@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 6/7] mm/kasan/kunit: add page_alloc_skip_kasan test
Date: Mon, 16 Nov 2026 15:06:26 -0800
Message-ID: <20261116230627.3537051-7-jeffxu@chromium.org>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
In-Reply-To: <20261116230627.3537051-1-jeffxu@chromium.org>
References: <20261116230627.3537051-1-jeffxu@chromium.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a KUnit test (page_alloc_skip_kasan) to verify that page allocations
using __GFP_SKIP_KASAN (GFP_KERNEL | __GFP_SKIP_KASAN, GFP_HIGHUSER, and
GFP_HIGHUSER_MOVABLE) under CONFIG_KASAN_HW_TAGS:
1. Reset page_kasan_tag() to KASAN_TAG_KERNEL (0xff) across all sub-pages
   of a high-order allocation, and
2. Return a match-all (0xff) linear-map pointer from page_address() that
   does not trigger a KASAN fault even when the underlying physical
   granules carry a mismatched tag (such as KASAN_TAG_INVALID or
   restored userspace PROT_MTE tags).

Assisted-by: LLM
Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 mm/kasan/kasan_test_c.c | 44 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
index f34163e19bd6..72342137bb18 100644
--- a/mm/kasan/kasan_test_c.c
+++ b/mm/kasan/kasan_test_c.c
@@ -380,6 +380,49 @@ static void page_alloc_uaf(struct kunit *test)
 	KUNIT_EXPECT_KASAN_FAIL_READ(test, ((volatile char *)ptr)[0]);
 }
 
+static void page_alloc_skip_kasan_helper(struct kunit *test, gfp_t gfp)
+{
+	struct page *pages;
+	size_t order = 2;
+	char *ptr;
+	size_t i;
+
+	pages = alloc_pages(gfp, order);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pages);
+
+	for (i = 0; i < (1UL << order); i++) {
+		/*
+		 * __GFP_SKIP_KASAN allocations must carry the match-all tag
+		 * in page->flags, and so in page_address(), not a random tag.
+		 */
+		KUNIT_EXPECT_EQ(test, page_kasan_tag(pages + i),
+				(u8)KASAN_TAG_KERNEL);
+
+		ptr = page_address(pages + i);
+		KUNIT_EXPECT_EQ(test, (u8)get_tag(ptr), (u8)KASAN_TAG_KERNEL);
+
+		/*
+		 * The memory tags of such pages are arbitrary: stale poison,
+		 * or tags set by userspace through PROT_MTE. Accesses via
+		 * page_address() must not fault regardless.
+		 */
+		kasan_poison(ptr, PAGE_SIZE, KASAN_TAG_INVALID, false);
+		KUNIT_EXPECT_KASAN_RESULT(test, WRITE_ONCE(*ptr, 0),
+					  "WRITE_ONCE(*ptr, 0)", false);
+	}
+
+	__free_pages(pages, order);
+}
+
+static void page_alloc_skip_kasan(struct kunit *test)
+{
+	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_HW_TAGS);
+
+	page_alloc_skip_kasan_helper(test, GFP_KERNEL | __GFP_SKIP_KASAN);
+	page_alloc_skip_kasan_helper(test, GFP_HIGHUSER);
+	page_alloc_skip_kasan_helper(test, GFP_HIGHUSER_MOVABLE);
+}
+
 static void krealloc_more_oob_helper(struct kunit *test,
 					size_t size1, size_t size2)
 {
@@ -2369,6 +2412,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(kmalloc_large_invalid_free),
 	KUNIT_CASE(page_alloc_oob_right),
 	KUNIT_CASE(page_alloc_uaf),
+	KUNIT_CASE(page_alloc_skip_kasan),
 	KUNIT_CASE(krealloc_more_oob),
 	KUNIT_CASE(krealloc_less_oob),
 	KUNIT_CASE(krealloc_large_more_oob),
-- 
2.56.0.611.g1030f0b940-goog

