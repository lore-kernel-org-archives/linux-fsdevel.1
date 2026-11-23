Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795404686;
	b=waIBrud5LSVVrBQ35BIbWJE+BadniSZHJzvdOpoYLJCyNHJyvB1OSbCiyKJ5piLeLkWJ
	 2QBWT8pVu2+uLSnVFRGE7e3d9yTcgXpYqxLVkGoGTsFVCFEQ9az+DZqBjZg6j0zXCQKYh
	 67T4cvJfYDfGuKvhnnwtrQHiJTRoveMowBH9q8LP0XEGF6g+/uuF30T0v6yH2diuQ5Ud+
	 KqlJF1J2zLNet5AfiNu8DUdRPfrXkzuOUNlGogAYBKDaRmZ9lw/E/bY1d49v3Oa1XeDnV
	 ZKZEs8SsG6t8qF4WI1RJVm40YHMmq9VJGxqy2SgJw3ESl6k07k6QeYmEwSbfM3mMQyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795404686;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Ar/2HKjK+NYDL4XIdqT0HePA7oYDrfs2vyoMNJhSjA0=;
	b=nZ2wCuglkb+o7l/qT7IZAn5OiMYZJrwhRlMvKn+TID+RlCGsrOh7vGzrkvgvx0EmnLG0
	 XmDNjOCZvYNFUmnWembgQE3tc7ZWH37COvE6R27HICZhh3KyB/7oso6fI0sH4cRIX46gE
	 8HF8/w0YkYB7N3QI++iJU5dernDDypoXRTlV2RzWZiuTCb6Y2jZNsOvdzPejhmyk53Le+
	 FQBny736EFqnGNPEQbYZPTaeCJnm+XbMspW3QD+4ROAMA3mYJE8xe5xKOrnmLLY8OynJ3
	 qzNFeI3Eyt2gzXJoNrz4tWtGeq7Q3m2quUQzWK0tyXW476hxWDi/urO5UrINQ4pC1Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=YrgltWNy;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8BB606A690
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 03:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D8BB606A690
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=YrgltWNy
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cdd8c20bccaso121986a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Nov 2026 19:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795404685; x=1796009485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ar/2HKjK+NYDL4XIdqT0HePA7oYDrfs2vyoMNJhSjA0=;
        b=YrgltWNyVy+bKK49Fpq+t+cUbRnSXxMTJEY5Jnbn/GDPL0DRgqMmGT5NQ+18rJU7NN
         0BoM7kVmJqRpZcv8urL2GzgxYO+oVfMQnq4HtHec4C7YDr3h15BAD08sYaACIDgOUboR
         PtEgFm28eXbI4MYuQa82/uvUyYwqFNBHOyxhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795404685; x=1796009485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ar/2HKjK+NYDL4XIdqT0HePA7oYDrfs2vyoMNJhSjA0=;
        b=z1Iycymjn4Cg+Q+Q+N+98AwFHw0WAJcGFHS0uNo0+QT+4fZ1z8Kumr82XgPBw/HRZ/
         xxeLbh9nxx6fJ9DQ+pPeuTErA3E2EPvpkU05qvG28UO24x/bHI2FilxWM8sjRJ5vfLZD
         rwWZI1zrmT8RPf31NMEUrJ6vWjenmI3GdvDT6IpPaKdZGxNXHerrs8359nute08AG3IC
         rC2n6ukM3E3t4/h7nczYLMYgZL4Je1IT7dPvsRZSz/HQSnQ/F43P6e1p5CIYwOhMK4pF
         Hxvazh3i3djigi+SbMVOpQMJnLHeynpU/8n0pd9bzDChRWrUqhsKrnM/Bc+wTRo9GwT2
         PTvw==
X-Forwarded-Encrypted: i=1; AL+hErFpwfRyfgGA9RVQedYBsTPHbwbU9R8KpjWF6aupTJQMIPuWcVh/iFb9myrd38uvWrcjOmeiUz07CStDOr41@vger.kernel.org
X-Gm-Message-State: APuU4Z8U1OHe3rMecgxAIph+xbHfOmvNXDk+icmfwW80LBiYaAbNJEcm
	fKN2GkRk/4pKR5tOoAe/lGO1U6n2UpicFiNywnnDl91eSUbvFpIwX1ySZUawyFA24g==
X-Gm-Gg: AZFdTZd+IHPCKiMqt0cbW5rOY7yKm26ZgfBOJZaesQOfd7wA2vFjrGbwqB0fx/cBZY3
	HtCvMXEfqTB2RlouHUpwUt2VPX5Js1de8YhGTuf27bPWywfq2J2f2b6r51oDVWpR0hLTwNj0YRo
	tK+PvMo8GqKtublSlBB2ajcx91iVkpgHtwoOK0L27c5Wkl47d3olBP3COU9qMK9E05D1OBmqscV
	/DzS8xtQJuXv9436nzzem7jKI/sSFa2Mj8E65mGE+JjK1qwhiUF4a+1I9o8w9/B9rrTzPqsnzn+
	/p5QE4O4NDl5BOWcIVV7L0by6b+KBgZp/B9tRt0gMWmV76vxsSmOZgDPceydzszichWs1NyIXqS
	9UcqKaVV9eX8v6aVpXubZc3jH5GUKc+eBDeOFYCppRYorPTlX/2XGjCaE5YsoHQ4fjaua3zUqyg
	IdYg3DySnm3EwP1dQC1b0JIoKPOpI7Z/9MVwnHAEPCgj+VjtFTuhXVO2GbyuxJO3H3HyRlx/UHo
	Ks9P4hqDDwcLoWJsL3nF/FaLD6v9RM5hoivBWVZWwCLBn39fW6d3OUtVDsMrIvmv3zL8626Qmeq
	7aCGz5n3gtkAsLjoM7eElzVUUiCBMsuaD2LwD7hhKfCoGiWDp+jJJjLY8gBNg41+cyNi3g==
X-Received: by 2002:a05:6a20:9f08:b0:3ef:2f72:c7e5 with SMTP id adf61e73a8af0-4014ae6fe31mr16689502637.2.1795404685515;
        Sun, 22 Nov 2026 19:31:25 -0800 (PST)
Received: from localhost (221.247.125.34.bc.googleusercontent.com. [34.125.247.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-8c873f16b41sm4720304b3a.56.2026.11.22.19.31.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 19:31:24 -0800 (PST)
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
Subject: [PATCH v2 2/2] mm/kasan/kunit: add page_alloc_skip_kasan test
Date: Sun, 22 Nov 2026 19:31:11 -0800
Message-ID: <20261123033111.2349160-3-jeffxu@chromium.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <20261123033111.2349160-1-jeffxu@chromium.org>
References: <20261123033111.2349160-1-jeffxu@chromium.org>
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

Tested on arm64 with CONFIG_KASAN_HW_TAGS under QEMU (virt,mte=on) with
kasan.mode=sync, async and asymm.

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
2.56.1.750.gf70dc682cf-goog

