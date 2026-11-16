Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794870414;
	b=ktsNtdp32uSJGUTuTgZMQdgAoE7qJJxG4Kn9AR6NjsKUrWB1ts446dM5IzuHGSS/Z6Ic
	 xJA2tZGe7xdhkgdcY8XeEMNFK67TYFME7S+RRB4us1xyXIJX8cxnNU49Ul9Z5MKhaO7+9
	 jvnez7UC1esdLyEz/OLAcSkzu9uaWK9VQDOxjwNTaMTRggDN0ybbYWeJCVMCeLIY1n1L5
	 CmVerswTdE9eIWivwCEwjIa+9kHjIYHYPkmiRu/gvXoDV6/7LpEV4NuDudrRVzE6yciLh
	 /0NcZel2j+AM/WQOkl+AtHeN+lf6s1M6vu/DjYZlvsHOS8VbQICt3AwatlW75mWQJyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794870414;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=AjhVL/tzJIhPQa9pnWiA/Lzn5A7WcpHhkbmWbBd9Z/A=;
	b=XZad05o8LszA2E97mTJzsSpStpecqzcUpYRFq9lam9/Mv3K96lMVWsoMWGIdVVl3AuqG
	 u+jdDow9TctHDIDeQ2doFbWtE5fluB7IwxD+yHU5oQz+nyX8dedO5y14JHAg+tiFwZTfY
	 YX1Xvh6L1Lzo1yRkZYz2O+jHKXqUfGyl+lFmcZ29qq3yOoEtrHa1HQTowYlBIRmzdN6KV
	 YY7F/alwLNsECTBSa4d0zrZMk4MZ1EwMG1LOZC2gjnfAHVwlJ9W/n47ss//fqZmSWX7RN
	 lseVcKyU4IwfGpiBPxNrlN/9zyDy5qoSckny2FPGuvQOsFctObwgdDXDfR9CtuG56xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=OEasZFiC;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AA960A2627
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 23:06:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1AA960A2627
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=OEasZFiC
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ac847f9d78so469184a91.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 15:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794870413; x=1795475213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AjhVL/tzJIhPQa9pnWiA/Lzn5A7WcpHhkbmWbBd9Z/A=;
        b=OEasZFiCCXd7n/M/UcduiXgq0vhYk4srVVnzKHpXRqoD95nlXtUP3TeLNkX0JweEo9
         DxSjeVsQyDj3Vhdhc9KfpT8C8oXNfziWnGdNY++4B+7gzbqkQMK37k0UZd5fFUA9gqnx
         UyWgZrw0eNM/Fg/dLZoy8VwoY7prhxICFZjNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870413; x=1795475213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AjhVL/tzJIhPQa9pnWiA/Lzn5A7WcpHhkbmWbBd9Z/A=;
        b=MvZw4ZNk7zdJhiFHCHU8vUkbMPq72cMa+8T1CIj8KkKX828AQgPeg3/ujjAolYscVj
         hoSwu42iA//HFD4mIqPiBEHCP+QWxnQRyBE9REh0+XeCdH2LiOFP19gGqUPp6X2WiVKm
         VikvDA1mFUJE7mbXnnF+m65nq95Bsgz9rNaPvkwe6lvd2EX4Zah7Ajw7GlOXsBrpWyCw
         8fr77herzPuyav+qHjtIwzFg7EDNynvF4CTsuNmtJzxI+9YV/IySpUJUPTIE/P6BZXEd
         nrVV41eYwcLAcrbOhrTZ+bPKUGqMA5Qi27Ya94u/1q6rYzBEnB6qfpx+4IFpVEXjm2GV
         oz+g==
X-Forwarded-Encrypted: i=1; AL+hErEYlWWPNz+sWIadGWUtCx7l86HzvmoINoNewsGyoMAEoUhrwF5gMUGgqjwCzFh355liYI/U0mrNzUkRv0r3@vger.kernel.org
X-Gm-Message-State: APuU4Z+1sizDCXAUSmHSmTIIEkmyOYH1NsuVDjb2auxMjEtcecoG8ZW3
	GLNzr2xp1qiZ5ltOqq1EKtyd6q2CtsbVNc99LoZLanSgWzWYwrS5LHD6x3+D/M/IAQ==
X-Gm-Gg: AZFdTZeaS2YXMiLH/mQr5WMXKlAVgJTjTAC0CRVf85XvBBt1ayVAavuVMBqBbUaAXg5
	O8zeeBb7/N5WL+1vPOlznbILttrBBTwN2OWp8mZ5IpIdtrvvjw6kLU4v5P8a/NmSRRc0r1Rl0xf
	eyNnbW15U0wnxmRUaZh+BheTZLeIzme4yOf7jLxA6rATOG8RhqlGI4S1gSNkPVQfqlHLz7Kh0/O
	NcqJQmlLgGMfMR9eZ9o+qfz+GrlBBNbqC1UWPHaNT4oMT0sPQkRCHNLeHiD0RaQ/214C8yxubI9
	+xuLbU/KcrVLvAqf4x8fjrWxJ7yksLAxDjLfYneeVz7dQgfnUtf0Aq+yU3qw2bEiCespqm6xxF5
	z+Y9/Rxv3PTmeduDrPltsEcCGskIh3uORfcv9/uZFdHtE0OoKp2MbI2o63GrAEAIDQWlfPTvEf4
	qGJ87L7sp574xdLBgXQa/lhqvXOq5P1K2moOSSOUikXN2R2KTtJZDxzyTY54NwmcdDmDpAK3j19
	Mn0c8R8+DpSKKTsdGYuKZDIHf4TrtJlCr/IhdYevpzzDAvMvrJMCuPj14Bf+IaMouM7KCz1skSw
	Xxb/Ye8uA2u8bIiOtDVHkqFkEWQVHPqD1FOOftvfv0SjqGMr+uHr5DvE3mR1iQc41RcUu3U=
X-Received: by 2002:a17:90a:9f98:b0:3b3:b15f:eb89 with SMTP id 98e67ed59e1d1-3b3b15feeb1mr322004a91.1.1794870413060;
        Mon, 16 Nov 2026 15:06:53 -0800 (PST)
Received: from localhost (221.247.125.34.bc.googleusercontent.com. [34.125.247.221])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3b3abe8b263sm1120450a91.13.2026.11.16.15.06.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 15:06:52 -0800 (PST)
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
Subject: [PATCH v1 3/7] kexec: use GFP_HIGHUSER_KASAN for segment pages
Date: Mon, 16 Nov 2026 15:06:23 -0800
Message-ID: <20261116230627.3537051-4-jeffxu@chromium.org>
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

kimage_load_normal_segment() allocates the pages that hold the segments
of the next kernel. The kernel clears and fills them through
kmap_local_page(), and they are never mapped into userspace.

Allocate them with GFP_HIGHUSER_KASAN, so that they keep their KASAN
tagging when GFP_HIGHUSER starts to skip it later in this series.

No functional change: GFP_HIGHUSER_KASAN has the same value as
GFP_HIGHUSER at this point. Build tested only.

Assisted-by: LLM
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>
Cc: kexec@lists.infradead.org
Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 kernel/kexec_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index f4a31565c447..a3abbb6a2d75 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -839,7 +839,7 @@ static int kimage_load_normal_segment(struct kimage *image, int idx)
 		char *ptr;
 		size_t uchunk, mchunk;
 
-		page = kimage_alloc_page(image, GFP_HIGHUSER, maddr);
+		page = kimage_alloc_page(image, GFP_HIGHUSER_KASAN, maddr);
 		if (!page) {
 			result  = -ENOMEM;
 			goto out;
-- 
2.56.0.611.g1030f0b940-goog

