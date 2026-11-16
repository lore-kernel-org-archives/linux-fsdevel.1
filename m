Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794870409;
	b=bUUp1QxiwBBPUdP9bFtlhPctlGCzCd51hq+udsQFoYRmhYefmPphLg81NFu7+YhzZtYU
	 8LgcNdvSfs8MQtV1BT2rsvKDTMjjeU4GoevxpJfakmfMp5NpNfVcw57lVM7S2G5/+1MPC
	 xp8J/nxvPFm1mIFy18c5GcJEUmrkBxXDwGfFWkwxrA/JEfg5ALzdKHYDKfpqXCgjK2XaO
	 Tq5gHFciaU24P08pGC/gxpX4zGKjSeEtd0swQJLvAX79TBLEwrUv74wWCOPSt3uMpwnnq
	 Tc3nwX526IGQtx6/TYzChSgVWb3fhGQxDPX9YIXCOYwOdZBq6bqfexB5J+yr8HJ1wvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794870409;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=jGcgw87oL+/aayCG1LZRiyRs5ahRDiLzP62eRx4RAEM=;
	b=FnTu/YDID1R/y0p2sxQ9ELFwvJUe/Pp4NUoZdDnBVzHvopnBMSy5b5P80j9Tqbk7ZOX4
	 Jh6Z6W3H112rJ/bjaTAEM01HTwKWewwky9LJr0W4en4ZM+EYjVWWFylNWjwQfdRWZLp/L
	 HRTE0jUFSU/tQ4u56ZhAlDlV2p0fst3408uH0tZ+N8JCt9tb5wgtg/9zD2vN1F/JoYYCn
	 3e9D5ZI+0/Y9N4WWrUkh75GGl9ehSYDrWvqGozCihrRjNZsFn917KBDWgXeROLVt/JY/K
	 AmVH9b1jWQwDOMHuqhzu3Qk4qk+9CIy3iOW9v+L5+rpTj5BMKfFMQ1TB/CmVti2gqtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=kk6K2Mds;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B00606A8A3
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 23:06:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3B00606A8A3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=kk6K2Mds
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cdda6625e2aso221890a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 15:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794870408; x=1795475208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jGcgw87oL+/aayCG1LZRiyRs5ahRDiLzP62eRx4RAEM=;
        b=kk6K2MdsQgdCogkjrc1s8JbIoFQAiggPJV7wUYjqOZ6QuiZpbJJvKe9lzn7JrPs2BS
         XjdRRTRvTuEkLTTU0BybV3HCSYy8668HmwSRmTX/PQgwdZujyZiZT2sd7WxcQHk2u1Zp
         xhfLBrYKJ8E8wCfRTNb8MH5R9pBQK8BDFXS3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870408; x=1795475208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jGcgw87oL+/aayCG1LZRiyRs5ahRDiLzP62eRx4RAEM=;
        b=NZnUFdnshkXqsUUiCc1YW5f4eR05V8Yj9BhhO8UrI68WYYGRCBPqGM90giKsulT5vI
         AUo4d88vF0//lszw53wn8QA2rY5Whba0J12mJLp4iKtkkYZvr/FehQW5v+nw7tDEShzg
         eM7B4KN5VqnwY6Gqueb6JgXwbJtHTAgkfDQ/Rxh3jyrHQFISeEhsQW9tzUiTPoMXRvGp
         cOdLVtwthXCXk0DzQv8K1sz/9CdYR/AmQaB0iNNxfCt/6d/5maQ4Zxy55yYqz3WdZ7VJ
         FsGigIBZq40oiL7T4vaVZaQSCRAs+G3mUTJhVQPAex9uDaH1mfEgeOqS6ifJUk9pOj9G
         iHWg==
X-Forwarded-Encrypted: i=1; AL+hErE1qQE3z7s/QZOuZN8qZef7zbGf0X8AyfTLRA/ILL1PZicgKj5EO2IYkAMzzWxVgKBNiTbwk+d2HW0AzllT@vger.kernel.org
X-Gm-Message-State: APuU4Z8xqnWEnoYV7bWzfalfsbPF0P63tBwzMQr1HXuCDqfQd40k6t1h
	0Az2ddTbpVfIMeG1T+CkbghkGxmEYxdw8wW5+/rToq8akAcrntIg8Pc/1qF1mpvN7w==
X-Gm-Gg: AZFdTZfYWRUBymnIAwMLhzstX4S2c6LYBlp0KsicPCTM78kb0BzB1/iCVEqWMLDtIXO
	uC+BfKLrQU3KnoO31EvZ6BFMenBXTBzKJdNs4uiK6nV9zi/QqnIR4xx/hP7S+m/BdBwaQ2VsvZC
	IzSl5v6FuAS4XBJSSn42gEuqRA1GnK4o9tqLkvUaXMnmiBjgZHqRZOHJ2nc/htExS4HCl0qu3x/
	FkG77+3keCHKBJFOQ5g15va7X7M08rjVs1LD3OmLSfqw44//4lroDZ/Su3Oyf4mm+6KL2z5omJT
	L7IUFqJzenCmA4Dy+gzC0qymr3GnnN8gbPw2+NFl17CvIw1/sggYKubUD98SkZAais0qmEvrT1c
	7OFO363RNSwjJ7Xg3DKwTK0UEohoCGcgVnoYbYH59gSLfHFluBR5jDj6p7bHDEqVO4qsOcI0uMz
	Ig78GXJPUI3J8+pN3Ekbhu5T3710g+t2ZBAG2xadwug1VZSnB6ZbatRaMJaoYwRw8WsY+C+2NrY
	ekF8Iq2JYPRqTihPLyg70LsErHyujdovwHYuuuhaYe1RBEq/tns5utqaVuhMwUEHtJe8GNVqn10
	y1OTg1clgd30AEwzrcEOdFNeumIngQ6sA3eqFYqa3MuY2YFydKml7jBev6L0BFoou99vl7k=
X-Received: by 2002:a17:90a:9f98:b0:3b3:b15f:eb89 with SMTP id 98e67ed59e1d1-3b3b15feeb1mr321766a91.1.1794870408006;
        Mon, 16 Nov 2026 15:06:48 -0800 (PST)
Received: from localhost (221.247.125.34.bc.googleusercontent.com. [34.125.247.221])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3b3ab9f3c5dsm1108222a91.0.2026.11.16.15.06.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 15:06:47 -0800 (PST)
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
Subject: [PATCH v1 1/7] mm: add GFP_HIGHUSER_KASAN
Date: Mon, 16 Nov 2026 15:06:21 -0800
Message-ID: <20261116230627.3537051-2-jeffxu@chromium.org>
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

A later patch in this series adds __GFP_SKIP_KASAN to GFP_HIGHUSER, so
that with CONFIG_KASAN_HW_TAGS its pages are neither tagged on
allocation nor poisoned on free. That suits pages whose contents belong
to userspace and are mapped there.

Some GFP_HIGHUSER users allocate buffers that the kernel itself fills
and drains through kmap_local_page(), such as pipe buffers. While such
pages are tagged, KASAN can report a linear overflow out of the page
and an access to it while it is free.

Add GFP_HIGHUSER_KASAN for these users, so that they can be converted
before GFP_HIGHUSER changes. It has the value GFP_HIGHUSER has today
and will not gain __GFP_SKIP_KASAN. The two stay identical without
CONFIG_KASAN_HW_TAGS, where __GFP_SKIP_KASAN is 0.

GFP_HIGHUSER_KASAN must not be used for memory that userspace can map
with PROT_MTE (anonymous, shmem and hugetlb pages). Userspace sets the
memory tags of such a page, while the kernel keeps accessing it through
page_address() with the KASAN tag from page->flags. The two do not
match, and kernel accesses are reported as KASAN faults. arm64 does not
reset the tag in page->flags when the page is mapped; it relies on the
page having been allocated with __GFP_SKIP_KASAN. Nothing checks for
misuse at allocation or mapping time.

No functional change. The kernel-doc describes GFP_HIGHUSER as it will
be once it skips KASAN tagging.

Assisted-by: LLM
Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 include/linux/gfp_types.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index c1331bf0b239..567c93fc1cfb 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -356,6 +356,16 @@ enum {
  * move once in use. An example may be a hardware allocation that maps
  * data directly into userspace but has no addressing limitations.
  *
+ * %GFP_HIGHUSER_KASAN is %GFP_HIGHUSER for pages that the kernel itself reads
+ * and writes, such as pipe buffers. Unlike %GFP_HIGHUSER it does not skip
+ * KASAN tagging: with CONFIG_KASAN_HW_TAGS the pages get a KASAN tag, which
+ * page_address() and kmap_local_page() return in the pointer. It must not be
+ * used for memory that userspace can map with PROT_MTE (anonymous, shmem and
+ * hugetlb pages). Userspace sets the memory tags of such a page, so the
+ * kernel's tagged pointer no longer matches them and kernel accesses to the
+ * page are reported as KASAN faults. Nothing checks for this at allocation
+ * or mapping time; those reports are the only sign of misuse.
+ *
  * %GFP_HIGHUSER_MOVABLE is for userspace allocations that the kernel does not
  * need direct access to but can use kmap() when access is required. They
  * are expected to be movable via page reclaim or page migration. Typically,
@@ -377,6 +387,7 @@ enum {
 #define GFP_DMA		__GFP_DMA
 #define GFP_DMA32	__GFP_DMA32
 #define GFP_HIGHUSER	(GFP_USER | __GFP_HIGHMEM)
+#define GFP_HIGHUSER_KASAN	(GFP_USER | __GFP_HIGHMEM)
 #define GFP_HIGHUSER_MOVABLE	(GFP_HIGHUSER | __GFP_MOVABLE | __GFP_SKIP_KASAN)
 #define GFP_TRANSHUGE_LIGHT	((GFP_HIGHUSER_MOVABLE | __GFP_COMP | \
 			 __GFP_NOMEMALLOC | __GFP_NOWARN) & ~__GFP_RECLAIM)

base-commit: 4b028d0cedf95f66b8c5294fde2d7d698bf830da
-- 
2.56.0.611.g1030f0b940-goog

