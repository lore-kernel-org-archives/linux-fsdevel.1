Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042223F99E5
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 21:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790197854; cv=none; b=CJ0mAdM7n21LTnHyOCStvB3EnD9ZfDY+eLVLXmm1KVIyrRnir0zrv02YeEAIHIrkyVfmwNDu69BWFF2EteAqaSbSrinU/1f+bN/BlWLvGupTv2gMqQLO8/LFUDj5hCPu2PU/jpyOrTRE+W2Fa/uCFB488r+qRcdF+gGPQ0akvXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790197854; c=relaxed/simple;
	bh=6+p9c16JaWvd1hm6n4rhzqJqBx/gTTw/01UKuroqhmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4keYklDxmF7iwTV3C3XymTBuF+y1UNgmM+jWs7hUDRjRK5mrxIeTtIEjVENmy/Yy88l9GOZYo4KB0tE3Mgs5snoX+w08r/HiopDj+xBnLGwm0fRqLK3BhxYd8HTeG07Gjbdc/DkNUNt8AXMSDW47P8SONsKm0nYAQdrt4HP51s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=uz8sfil1; arc=none smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="uz8sfil1"
Received: by mail-qk2-f42.google.com with SMTP id af79cd13be357-93be29bb454so195655785a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 14:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1790197849; x=1790802649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xVr7KuSWyr8CUJERgbEEA0iI2fqWk3sHPjbcAbZFfj4=;
        b=uz8sfil1N48qs4SpM6831TG710nH4VNPJXmYySjrhJ7Cy6EkA2UyinpfsnKx78dT3D
         vJE+NdFypAXQw/W9ej1lKkKJo34nrU4y/Jk9sKIL6gAEpothK17WdBx9qk9fcHGwXAin
         0eKaooFB6VYEq5Ar8IZ+pism6w7GZkEQwtR5Uzk/XjM3FycNSzqYlcNQdu0dFEtTVa9K
         8z7v4NxGjnAHVx3Ul5l229ndO6zO4cCe41VmzXVRhfVDA4rpnx13W5A5txqwvjQsPvV2
         CbMG5KqL8NOptIPnKp6pYuiHvmLZC5h7kCfr3F0dXgf2x7kZG3Ho/NjzCZm5NM8fDTIX
         KDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790197849; x=1790802649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xVr7KuSWyr8CUJERgbEEA0iI2fqWk3sHPjbcAbZFfj4=;
        b=gfwa9Ir3B6vExHMiVxQyoaMX7TWRdYoBFJHlm68y5ysKJVXIzqSPCRZ2rJx7/mDh/g
         LDqP4/zJ9jzEVBpyk0HFSFiZbowxZVxx1X8h2t6UdmnrTSfuC73HTVweN2MC4rSxM0Bt
         Tg4d5NJdZDItVarlticRKFE30yUvt1zAqk9iqIvoCGGKB4Qjg9BSE+f6l17aT9P3DYCa
         d22sELI9XIdfoSMAgakn0kxyjn/N47phvOeOglb62nBlAoVJVphLtcv9TEI5N15EFC2e
         Artfj6+yJ5yLsleCki3FNa/n1iLKHDZbwvKIPyttJCjyrwxpcVoX6U/jPvamf6BZkdId
         HubQ==
X-Forwarded-Encrypted: i=1; AKwUvBz+XJb/iaLtagBwmlI/+B213/Bi4OwjhsL0TG9HWujCVEYYZmxxGX7Vij6bh2b30mgNqJu084P6sFngtgWM@vger.kernel.org
X-Gm-Message-State: AFuF++nDlmxYbvT6RhUOQPq1UQyMb9e8EF/OCKudSuhbUIGyK+vLmdqH
	BRqmTe4Yfin4pWyMUr95uLvOkEIbz2RJHHKTCbr4lZ8ZhXIcuMeN09/iEfayTuwiMLU=
X-Gm-Gg: AYBFou1FnI4IOQXX0Z2JtTfShPIfz4teJWeDbNrOR8MuAaTXK/HyiC0tI2GbtE6hcpv
	X8ogBD8qFdiVZf0up0Hc333tL+QRCO83NhJtX/oYLi4OIEaBMVuMxVAF0c2Q2Ra0WClBkQHan7l
	y8WjtFZIYafaWLNljwUHxh+n2Npkks8YAX/xrepoNWJ4Lx9lD5Ci/5HvPrL180m2VUUHP7cot9R
	TcyaQFioEO79oCihw9FBz6KxSJ9uPJvPQeKAMKNWU9+WRena6XiXTLvtC9KrhjRAHKAR1MMZwj+
	tESYIu6/K8J5V7jqhrAVeRY27e90LgMbbIDCa6d9NPbeao2SJZ6WDbX21d6dsssStEAp/wDoUSl
	OOYLJ7KV7AlY+mRV/mO88eTFiLrmV5CC1fcU2Tzbx5Gsw91ZYB9FqB5UF5zi3/nwoqmhXp5cchU
	9rAtt6rpkklrulWLofk4BTpEGp8I4+rfQrlqv4+e/Bxc5AftTUiG6mS8Su1eHDMd8PlAw2ICxG3
	3p6kE1hbJPeYaXF/CRkmLbDJ7Enq7xXVfDSdszElyt2D6yMT0Lf6GWFQsSl
X-Received: by 2002:a05:620a:880a:b0:934:ab73:ac53 with SMTP id af79cd13be357-93c34573b4fmr67685585a.0.1790197848646;
        Wed, 23 Sep 2026 14:10:48 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c2485926esm305893085a.19.2026.09.23.14.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 14:10:48 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	willy@infradead.org,
	jack@suse.cz,
	akpm@linux-foundation.org,
	david@kernel.org,
	gourry@gourry.net,
	ziy@nvidia.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	vbabka@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	Brendan Jackman <brendan.jackman@google.com>
Subject: [RFC PATCH 3/6] mm/page_alloc: add an alloc_flags-aware folio allocator
Date: Wed, 23 Sep 2026 17:10:37 -0400
Message-ID: <20260923211041.3127588-4-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923211041.3127588-1-gourry@gourry.net>
References: <20260923211041.3127588-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Brendan Jackman <brendan.jackman@google.com>

The low-level page allocator accepts explicit allocator behavior flags,
but the folio helper hard-codes ALLOC_DEFAULT.

Add an MM-internal folio allocator that accepts alloc_flags. Keep the
existing exported folio and node interfaces unchanged as ALLOC_DEFAULT
wrappers.

No functional change intended.

Signed-off-by: Brendan Jackman <brendan.jackman@google.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/page_alloc.c | 14 +++++++++++---
 mm/page_alloc.h |  6 ++++++
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b4a021fad183..feb9c64efd84 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5510,13 +5510,21 @@ struct page *alloc_pages_node_noprof(int nid, gfp_t gfp_mask, unsigned int order
 }
 EXPORT_SYMBOL(alloc_pages_node_noprof);
 
-struct folio *__folio_alloc_noprof(gfp_t gfp, unsigned int order, int preferred_nid,
-		nodemask_t *nodemask)
+struct folio *__folio_alloc_flags_noprof(gfp_t gfp, unsigned int order,
+		int preferred_nid, nodemask_t *nodemask,
+		unsigned int alloc_flags)
 {
 	struct page *page = __alloc_pages_noprof(gfp | __GFP_COMP, order,
-					preferred_nid, nodemask, ALLOC_DEFAULT);
+					preferred_nid, nodemask, alloc_flags);
 	return page_rmappable_folio(page);
 }
+
+struct folio *__folio_alloc_noprof(gfp_t gfp, unsigned int order,
+		int preferred_nid, nodemask_t *nodemask)
+{
+	return __folio_alloc_flags_noprof(gfp, order, preferred_nid, nodemask,
+					 ALLOC_DEFAULT);
+}
 EXPORT_SYMBOL(__folio_alloc_noprof);
 
 /*
diff --git a/mm/page_alloc.h b/mm/page_alloc.h
index b9259deddb59..986e733b586e 100644
--- a/mm/page_alloc.h
+++ b/mm/page_alloc.h
@@ -258,6 +258,12 @@ struct page *__alloc_pages_noprof(gfp_t gfp, unsigned int order, int preferred_n
 		nodemask_t *nodemask, unsigned int alloc_flags);
 #define __alloc_pages(...)			alloc_hooks(__alloc_pages_noprof(__VA_ARGS__))
 
+struct folio *__folio_alloc_flags_noprof(gfp_t gfp, unsigned int order,
+		int preferred_nid, nodemask_t *nodemask,
+		unsigned int alloc_flags);
+#define __folio_alloc_flags(...) \
+	alloc_hooks(__folio_alloc_flags_noprof(__VA_ARGS__))
+
 extern void zone_pcp_reset(struct zone *zone);
 extern void zone_pcp_disable(struct zone *zone);
 extern void zone_pcp_enable(struct zone *zone);
-- 
2.55.0

