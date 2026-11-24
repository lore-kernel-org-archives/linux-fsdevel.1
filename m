Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795550114;
	b=nLQArIjL5VhY8JvjJGoeyLYdkWEAwympuZOsTMMZPAmB+au8UoDRmVQkmQlHrjYjIrmq
	 T7gyrh0pSFPx9alUYQpu9+cfKu4KREaLYxMKGHSiAf8dGVrn2w6Ip3NwDNnYCX7rzS25D
	 iIEQcw0B0iTLJ9OG77yWVP6ctKSS6p8gzZpg8JYUyZzAzJDeovWrHzTz+QqI+2cixLS/U
	 9Q0LlKS9kJl3WtCsCNr8+pB8zN9Zd+UBiqoTfllfSPDmJTOWS4j4RLRbpxn+QTmcxch+Q
	 rzinqbMsLGEXVDja+Y2zU4ajVYObxjBWsu1nfqRS2tYr1Km0lRtK4t+V4BpNgXP1cKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795550114;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UfXL7pTzXBkITvsNUdQnzu2e0Gb3CsC6gpsm26wxQeI=;
	b=AtVK45cYzACW97zYnEq4x9csD5vjM4bkkTkSuTnlhLPfHv8aRhqk6M91h4plJoTJSVxT
	 G9XicycXvqWMp2aaZElDQWf9EJJ6Ka94UMW1eUWJVw5wiczxJjEy4jmhkIEh7M9gyJGdH
	 sWdlxQyT8DjFGMDtiIBu0yt5vCk0dQ0R+w1xjJTfcfExT/c5KGgyIlnBBZzdYMHigyyhd
	 Vjq6Y6q3rX20JWIysaBx1f60+1skSQU4Lyy+q3hHyLHA0H0ZkHNvP7rumXbNVmsZgkJ3R
	 ZB0duUloevJKW9pXIX3ygcG8WAZC7yhN/rATI8g8jiWJC6B0BeoSR32vuejW5cPPNZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=NzN+FZj7;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50E2606A33B
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 19:55:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C50E2606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=NzN+FZj7
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8b5e147f101so417583b3a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 11:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795550113; x=1796154913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UfXL7pTzXBkITvsNUdQnzu2e0Gb3CsC6gpsm26wxQeI=;
        b=NzN+FZj7y2Q4CIkzbGAvBjRkEx0HupldjNkvzS3Uq4m6W7oVevksM1jk/CdTgX0TP8
         TS2U/IBomPj149qQpXWRfe2Su6jATx66oZt3XTcs/nZf2XR9Qa69rABd5cA/Dr6lo3d7
         HiwpVVdI3Jb4tt7uE2eXPvcCBWRN74AsTjFIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795550113; x=1796154913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UfXL7pTzXBkITvsNUdQnzu2e0Gb3CsC6gpsm26wxQeI=;
        b=QTlaJN26vBEpcGaDZ1RfjjQiOK9mDRq5TR04dnOo/3zw2tpaJ3KqOHVVHsNvi4dJSn
         yx9eak1FP3lz66wdKloV1N3m+YjewolWdAlaxUmryMtMPJqW5jnmVUAGb5UyrlCWjPNl
         ehn16KvkLFdu6ff5YI7av+Ox3ageHg43PmVZR8GGLrUMGIUShlFhh0pFovzTBrzZuFtc
         pq7kfAVb0xOQ3sOmi1rvqssB3utUrc3XCh9gqc86I4vSrDuoQqDQQKwHeRVONZMC2wOs
         v617eunYICw3O67VQ0uagLdyqZZdpM2v4KSBklMpGjvcVSdQll6gcAa7JJ73rcwhkr8q
         AXDQ==
X-Forwarded-Encrypted: i=1; AL+hErFlXko/tKoQjQHIKRD3syVmGUx+yW+PhZo14DzNAzY2Zuxbh5FL6QJhzLAsFBxBDTbgFG/TKrsZ6Ysy1wNu@vger.kernel.org
X-Gm-Message-State: APuU4Z/8Xfa5DE+CqFcsIB2kv6LDvTEUncb04WwDyKO1oVFzMBw48cJX
	/75AbAiERkfmgvzoK65RagDeD9opVE0eg++y28UiX4LBV1VWds73XH3jfeMIS2EBnQ==
X-Gm-Gg: AZFdTZcO6H+VMhCdtgJ14ASVwlnVMSrAwA/993niL/4/CAbf6M43ViGOOVekwEhRLch
	lhSTdxAI418azpZXAKgP+ha0uj8hYaHBbu2aGG9pf8W/OGW1TzpLW719XoEmhI6mYkXRuzJvspa
	8yJpRvH4WRLZ+kw7r2vUcuMmftgLnsMjO/3vLY9Xu/3txD1LNeaB4YFnC46OTRPPGs7kc3NEt05
	PJJbukJRLF8Z/D7f6xBDVIM7cDQPdMroGhdVswQ9CLEi3z6KI1enUYnd5qb4eNr2wbp3LQFI5dt
	n9J4VTjjMsoLBEgn71X6Y4rK470d6+mTFnJyCGC2mOYJ9e0+8z6L+L55sWkC5VmBBcZZezz0U5A
	cXE+2Hfz/btNiYWL3ATk9KyPWQGUiyz/KVoCHEE4lpidVTnfkbSrU0lrlqMepkRGmQsj9O00/EN
	5SRgSOgdFjwwqCcMSzJfY9U51WOf5e5JwWUeSedF4onMS90sUrjc+nv9I6pDqjpBqqUREybB89I
	60RQy037i0i6hkZCbYZ5yrebtGKqd1zKZ12hOjEagiWOYMN9KSjjLPSchWYWgFO5IWUbcqreVmM
	vD3Y4d/5ixLlLcmMPewwRhAPRyrFJYZElJdNvNBoUL2fND4IzlGJgKBiF9o03pqYPqYASdCUVMu
	cuUxEYVE5vH0UAQU=
X-Received: by 2002:aa7:804c:0:b0:8a0:646e:7e16 with SMTP id d2e1a72fcca58-8c87b4f38cbmr15568834b3a.2.1795550112810;
        Tue, 24 Nov 2026 11:55:12 -0800 (PST)
Received: from localhost (221.247.125.34.bc.googleusercontent.com. [34.125.247.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-8c872e4c43bsm7550418b3a.26.2026.11.24.11.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 11:55:12 -0800 (PST)
From: Jeff Xu <jeffxu@chromium.org>
To: David Hildenbrand <david@kernel.org>
Cc: Jeff Xu <jeffxu@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
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
Subject: Re: [PATCH v2 2/2] mm/kasan/kunit: add page_alloc_skip_kasan test
Date: Tue, 24 Nov 2026 11:55:08 -0800
Message-ID: <20261124195508.164641-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <74dd67a2-eaff-4bbb-8105-4481fbbdd016@kernel.org>
References: <20261123033111.2349160-1-jeffxu@chromium.org> <20261123033111.2349160-3-jeffxu@chromium.org> <74dd67a2-eaff-4bbb-8105-4481fbbdd016@kernel.org>
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

On Tue, Nov 24, 2026 at 09:17:45AM +0100, David Hildenbrand (Arm) wrote:
> On 11/23/26 04:31, Jeff Xu wrote:
> > +static void page_alloc_skip_kasan_helper(struct kunit *test, gfp_t gfp)
> > +{
> > +	struct page *pages;
> > +	size_t order = 2;
>
> Why magic value two?
>
> Should be const.

Just a small non-zero order so the loop checks tag resets on sub-pages
as well as the head page. I'll change it to "const unsigned int order = 2;"
and add a brief comment explaining that in v3.

> > +	char *ptr;
> > +	size_t i;
> > +
> > +	pages = alloc_pages(gfp, order);
> > +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pages);
> > +
> > +	for (i = 0; i < (1UL << order); i++) {
>
> "1 << order" is sufficient.

Will change to "1 << order" in v3.

> > +		/*
> > +		 * __GFP_SKIP_KASAN allocations must carry the match-all tag
> > +		 * in page->flags, and so in page_address(), not a random tag.
> > +		 */
> > +		KUNIT_EXPECT_EQ(test, page_kasan_tag(pages + i),
> > +				(u8)KASAN_TAG_KERNEL);
>
> Squeeze this into a single line.

Will do in v3.

> > +
> > +		ptr = page_address(pages + i);
> > +		KUNIT_EXPECT_EQ(test, (u8)get_tag(ptr), (u8)KASAN_TAG_KERNEL);
> > +
> > +		/*
> > +		 * The memory tags of such pages are arbitrary: stale poison,
> > +		 * or tags set by userspace through PROT_MTE. Accesses via
> > +		 * page_address() must not fault regardless.
> > +		 */
> > +		kasan_poison(ptr, PAGE_SIZE, KASAN_TAG_INVALID, false);
> > +		KUNIT_EXPECT_KASAN_RESULT(test, WRITE_ONCE(*ptr, 0),
> > +					  "WRITE_ONCE(*ptr, 0)", false);
>
> Why do we care about checking HW behavior? (match-all working)

Good point, match_all_ptr_tag() already tests match-all behavior in
hardware. I'll drop the kasan_poison() and KUNIT_EXPECT_KASAN_RESULT()
checks in v3. That also lets me drop the local ptr variable.

> > @@ -2369,6 +2412,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
> >  	KUNIT_CASE(kmalloc_large_invalid_free),
> >  	KUNIT_CASE(page_alloc_oob_right),
> >  	KUNIT_CASE(page_alloc_uaf),
> > +	KUNIT_CASE(page_alloc_skip_kasan),
>
> Don't we have to limit this case to having actual MTE-capable HW etc?

No extra gating is needed here: on non-MTE hardware (or with kasan=off),
kasan_init_hw_tags() returns early without calling kasan_enable(), so
kasan_suite_init() sees !kasan_enabled() and aborts the suite before any
test case runs. For Generic and SW_TAGS builds,
KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_HW_TAGS) skips the test,
matching the rest of kasan_kunit_test_cases[].

I confirmed this by booting the HW_TAGS kernel under QEMU with mte=off
and with kasan=off: in both cases the suite fails to initialize and no
test case runs.

I'll add a short comment in page_alloc_skip_kasan() noting that in v3.

Thanks,
Jeff
