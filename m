Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A788E36A350
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 20:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785528496; cv=none; b=BE7AWncQLKAxtjgdAorm1lnEQ/ZVLiNo7ht20WCeWx82Wo2mcR7hpEUM/fOba0vVVVsGBIfJkuZf0gpVVoSWuJNB+tFPmcX/++d+YR6nqhG5z2C+B4kXsYHT7phpkRgNmXoSU6e/YZFOY6e6Hu3BHxchQZ0sEsmuL6ALQWX0oAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785528496; c=relaxed/simple;
	bh=idps8KtpsrJN5vAG/zJV9m7tFxPyDBkzE/EELLDTkMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rCG2CMtFW0qreaWzLeLXHjc27zpdSP1dMotfxddkoQGGMhC0t0547I9Gvtktbouch00gJwM1Yj72jVFw56U7YrJX5dRLWTGPiZUaez/5O4hpTyQpwVu/FWpk3KzSVW/AshdFBoQSX7s6t59HZ0JYD3jboXjvjxSupuj87GI5nP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tK/RvxUM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tK/RvxUM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=6pjpw7CE45fm5rwUaMmq6NBeRjAsSjRlEPCJeSuv2J8=; b=tK/RvxUMIG0VqyalMTuee1h3yL
	6qB62SBlIS64AWYMW4/BAE8i665UJD3bzYB4jVj8gPjKH0nvJovsfqNt0UdOvCY/pWB3r11qpcOrw
	MTD4MPGCRIFfE7mLnMie8h9Y46RGcUFBpkSv0NNWAOUtPlrjBjAsGWKxHIcagyk9AiFDbBcjYDIoB
	n8ircKqbCxO8KD1YsKcc2RGHYp1S3l0F8j330KQgPArm55cruwtihYPfGQShsHQasXiFe0+5SECHd
	Q057AZk6wYPC808oBQmpoZk3fJN1i8iyG2pqcZg9dSG8oOwm7mhSuIgNc1TCrs3szVNddWIX+ijfk
	vEA3wnvg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wptWW-00000002PkY-3Eny;
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
	Jiaqi Yan <jiaqiyan@google.com>
Subject: [PATCH v8 06/15] kpageflags: Use is_page_hwpoison() to set KPF_HWPOISON
Date: Fri, 31 Jul 2026 21:07:51 +0100
Message-ID: <20260731200802.574821-7-willy@infradead.org>
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

Instead of knowing how hugetlb handles hwpoison, just ask
is_page_hwpoison().  This gives us the flexibility to change how hwpoison
is handled without updating this function in the future.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/proc/page.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index 7d9387143435..28c9a7b724f3 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -233,12 +233,8 @@ u64 stable_page_flags(const struct page *page)
 	u |= kpf_copy_bit(k, KPF_UNEVICTABLE,	PG_unevictable);
 	u |= kpf_copy_bit(k, KPF_MLOCKED,	PG_mlocked);
 
-#ifdef CONFIG_MEMORY_FAILURE
-	if (u & (1 << KPF_HUGE))
-		u |= kpf_copy_bit(k, KPF_HWPOISON,	PG_hwpoison);
-	else
-		u |= kpf_copy_bit(ps.page_snapshot.flags.f, KPF_HWPOISON, PG_hwpoison);
-#endif
+	if (is_page_hwpoison(page))
+		u |= KPF_HWPOISON;
 
 	u |= kpf_copy_bit(k, KPF_RESERVED,	PG_reserved);
 	u |= kpf_copy_bit(k, KPF_OWNER_2,	PG_owner_2);
-- 
2.47.3

