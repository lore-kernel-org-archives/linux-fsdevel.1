Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672D13E7151
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Aug 2026 21:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785963971; cv=none; b=lDdmXYIgxghzNI3VlEIb/y5ZjSc+BIsEae3nddM6nfqJvFfHR3BIoPieXzTMuWFUHhczK/eeP6mskcyA0NZq5Orxhti29ZUm3p7s4YODO63+N/OZLzEr+1OPB7EuSCwtFxX7Yzb/bhWG6jePCPX+73RUSzyzCWVTkYjzETT4eC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785963971; c=relaxed/simple;
	bh=Y3ZXcHV7865zV9eHkjKb4GnIhC8DaJA8pIN1vZo1cEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iDWwQSHtjTJ+Zz+gIm6ab9Q0H0KjcveO9uk4hZOzTCOdrw/B7nzGO0eQgEoMq9OGIBS+fD+RX8DbLNO30GwuKql23p/9N4W1/uM5JFMrcuSjmJ176ZUJebp5t8cSX1iWAwWiSIyFWFFCYWHnMvfzgjRV1tpymkajllS0dThGrM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jttHYba7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jttHYba7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=+Iuudu8THMhTPdbtY99FmaOUUzNBZygqz4n4fsPGJTs=; b=jttHYba7DCQZkDO6zhHaEiHRPQ
	Q2vrpqDBKr67LBvg6g1EMpDyF3plhZbSAE8Z8FFGzEi4s1MVEgp6cfoBCLddP9I3uegd5dRX8THMo
	G8Mhm3S9swaNqLWhq/inKzLG393Ou39Cl4hFLlZzrXp7qACb1fTPNQ5pORZgT7Y+oG3NS7UwkyjBE
	ZQZx+P8a/6IccPRxQHrDjKpad+xr5aWvYqtgGk300fbd9MFF5QpE1NhNfZXy86nSy15S6iXMx65oh
	uzE56ARnYqcdsOf7blHS65y8fgMop6i6TNtoTiQjlXgTxgM9KAiPkbfHbHyYX+ocEbowJlqnV0L3V
	aTmReqTw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrioJ-00000004h6F-3eDl;
	Wed, 05 Aug 2026 21:05:59 +0000
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
	"Gregory Price (Meta)" <gourry@gourry.net>
Subject: [PATCH v9 06/15] kpageflags: Use is_page_hwpoison() to set KPF_HWPOISON
Date: Wed,  5 Aug 2026 22:05:46 +0100
Message-ID: <20260805210557.1118966-7-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805210557.1118966-1-willy@infradead.org>
References: <20260805210557.1118966-1-willy@infradead.org>
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
Reviewed-by: Jane Chu <jane.chu@oracle.com>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
---
 fs/proc/page.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index 7d9387143435..323e4c049f69 100644
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
+		u |= 1 << KPF_HWPOISON;
 
 	u |= kpf_copy_bit(k, KPF_RESERVED,	PG_reserved);
 	u |= kpf_copy_bit(k, KPF_OWNER_2,	PG_owner_2);
-- 
2.47.3

