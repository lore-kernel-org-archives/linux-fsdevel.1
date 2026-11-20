Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795136850;
	b=uyBxHd5JAaPk6zAS1608AW1OULJpshkkYZMIC4OhzFdXveTGu60g295iPn4Ez7AlXPSj
	 wqyymMrWbUfM44rKqXNfaH3PJpmm7MOtucoTZWzFqKavTEVC8gdQRBOQJNQN2ac0WyfVD
	 5yYg+zeiqyD/0rvx8cxb/6xsUBiPPgz0RZfxhXj6lmteWkZhdNS0xvb8b7Owq413iWxT+
	 Ttyte63WbmQJUoO99/p/u67T5Ch3NHmfDRLmQMq2RXkFqd3HkUJI5xMk4TqKGHjUIfTee
	 Bbhaw0VWHRytlJ98s1ow+F7DCGQoo82QCxu9+3Uz8Inz9pDXKdtX9F6fOie6IiR7GSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795136850;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=uXiDLRBLPSFfTPfUoJ5i1Hu7TTvZxwWf2XG5sLJAj+k=;
	b=w436eV5a6odkte+ww6Bi/8w7ffGP/QPNNnm4BYJ0fdyYDbm2+zJaAy3WuwG8VqhWheW5
	 02VENteWHUXc8G0AVTicqLIuF/YxUg7WuSubpv2f6AQqmcGPXj26JnAkSM15BxhJWpo42
	 0JeAtrYcVjFSMZJhM/4T95GxT+FlECJjMsb0jEtOknC3S4gXCxjI4UB8tB9zjv4HjJi8t
	 qQ8o8yDNUo8iX4JUBGvue6Ixuc78fNTVONP43jGUuVJ+r+KLYqqc+lMI2NE41cddQj4lw
	 ZhyXipWOo0RYGfz6cGV2N9sG0g0XGj9yGy0DvqusVuLMjbtSlO/SeHzoe4IqNZcmULQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="o8/jQ8G5";
	arc=none smtp.remote-ip=209.85.208.70
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D1F60758E4
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 01:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1D1F60758E4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=o8/jQ8G5
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6b6fb975053so292147a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 17:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795136848; x=1795741648; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uXiDLRBLPSFfTPfUoJ5i1Hu7TTvZxwWf2XG5sLJAj+k=;
        b=o8/jQ8G5sobnDxBkVOsLwhQhLl6twoVamTYKOKL8p2acoeympxvi3nnuJZGHaHHmPt
         GPcmNATKSO7RlIBz+WjhQpGNmzPUbEBltYwSG2kT6r4PgupfWceU7kDoVxphYDUbvWV9
         JyqxPv5fejFgjD4cU4wdkXzlfoTQjcXjvjOYHhvtQR2pK5Vqyky2Aw7GstC5cVwzakXw
         iRyqRchpy3a0dS7w55dKjHHCgEIleGlGBrHpO1uRfACQWTGjLEYNJCw4I24DKcuWuga1
         W8Qpq1Ome2xg3oW9dDnEcQFhLCReGttAlMdUwcEBXu9TpG5Puxgrp1hjuwekRyTxGVDm
         cNfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795136848; x=1795741648;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uXiDLRBLPSFfTPfUoJ5i1Hu7TTvZxwWf2XG5sLJAj+k=;
        b=A7pnIjgiRdtY12iX2HLnhbgYjKx49oHU2YPUdvcvoee4i1jOlaDbuVcwk4MmNgqxEb
         r2pUXruanJAxw2tTUhxCytTqTUFJatNffcS/21ePofkUwTMZ5fC/KHzvgIpbPOVKyN8H
         fwPyjNUbVqdDm3+03m+feT7uWNU7x2305aEWqo+dr3HR2nHPhIQ6bfPkUimO9AjsohFA
         AkaVH0aHXJKnbWE2fxrdUjm0nekLUPWvvYfJM6NyRj8cwRXrWb7rgFs5uRFvx3m1I90i
         trqt1PBe/x4PalV324Hm+htubwW+Nww+VuLMqkyqXasqeISgkewGfGzP1d28+5c7Xjf/
         4cgA==
X-Forwarded-Encrypted: i=1; AL+hErH3yumq83KdenEoiTLtDH+6zwnpeHAby5LTfyfoSTMjd5sEGe7R3EwGfUzl5/Klh+hz8rDaeu0HySF2wczs@vger.kernel.org
X-Gm-Message-State: APuU4Z90siuD7mQR1QYrYxd99M33/6nEwn7y06/h/TI+Mgto/403irYA
	TWungTWe2lON3xx2vzoOpL4/ZA2AvrxUrdcPGZV9NCw3dLbgFlnaoy9LcMPWQsN61PE+CzFN5+U
	hoakDSg==
X-Received: from edeg28.prod.google.com ([2002:a05:6402:565c:b0:6b7:8448:c876])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:c522:20b0:6b4:c971:589d
 with SMTP id 4fb4d7f45d1cf-6ba37d640bbmr579772a12.13.1795136847835; Thu, 19
 Nov 2026 17:07:27 -0800 (PST)
Date: Fri, 20 Nov 2026 01:06:54 +0000
In-Reply-To: <20261120010655.467825-1-lrizzo@google.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261109182533.3594984-1-lrizzo@google.com> <20261120010655.467825-1-lrizzo@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261120010655.467825-25-lrizzo@google.com>
Subject: [RFC PATCH v3 24/25] net/gve: Use PISA memory for RX buffers
From: Luigi Rizzo <lrizzo@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Vlastimil Babka <vbabka@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Luigi Rizzo <rizzo.unipi@gmail.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>, Harry Yoo <harry@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Joshua Washington <joshwash@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>, Dragos Tatulea <dtatulea@nvidia.com>, 
	Naman Gulati <namangulati@google.com>, Pranjal Shrivastava <praan@google.com>, 
	Mostafa Saleh <smostafa@google.com>, Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org, 
	iommu@lists.linux.dev, netdev@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-api@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

When dev->pisa_rx_bufs is enabled, allocate GQI-RDA RX packet buffers
with pisa_rx_gfp(dev) so they come from the per-node PISA
allocator, and evict plain pages when a free PISA RX block is available;
DQO-RDA uses page_pool, which checks dev->pisa_rx_bufs directly.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 drivers/net/ethernet/google/gve/gve_rx.c | 34 ++++++++++++++++--------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/ethernet/google/gve/gve_rx.c
index 7c201fd513ee3..562c11f5bdd24 100644
--- a/drivers/net/ethernet/google/gve/gve_rx.c
+++ b/drivers/net/ethernet/google/gve/gve_rx.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2015-2021 Google, Inc.
  */
 
+#include <linux/pisa.h>
 #include "gve.h"
 #include "gve_adminq.h"
 #include "gve_utils.h"
@@ -165,6 +166,8 @@ static int gve_rx_alloc_buffer(struct gve_priv *priv, struct device *dev,
 	dma_addr_t dma;
 	int err;
 
+	if (rx->data.raw_addressing)
+		gfp |= pisa_rx_gfp(dev);
 	err = gve_alloc_page(priv, dev, &page, &dma, DMA_FROM_DEVICE, gfp);
 	if (err) {
 		u64_stats_update_begin(&rx->statss);
@@ -494,13 +497,19 @@ static void gve_rx_flip_buff(struct gve_rx_slot_page_info *page_info, __be64 *sl
 	*(slot_addr) ^= offset;
 }
 
-static int gve_rx_can_recycle_buffer(struct gve_rx_slot_page_info *page_info)
+static int gve_rx_can_recycle_buffer(struct gve_rx_ring *rx,
+				     struct gve_rx_slot_page_info *page_info)
 {
 	int pagecount = page_count(page_info->page);
 
 	/* This page is not being used by any SKBs - reuse */
-	if (pagecount == page_info->pagecnt_bias)
+	if (pagecount == page_info->pagecnt_bias) {
+		if (rx && rx->data.raw_addressing &&
+		    !is_pisa_page(page_info->page) &&
+		    pisa_has_free_blocks_rx(&rx->gve->pdev->dev, 0, rx->gve->numa_node))
+			return 0;
 		return 1;
+	}
 	/* This page is still being used by an SKB - we can't reuse */
 	else if (pagecount > page_info->pagecnt_bias)
 		return 0;
@@ -544,7 +553,7 @@ static struct sk_buff *gve_rx_copy_to_pool(struct gve_rx_ring *rx,
 
 	copy_page_info = &rx->qpl_copy_pool[pool_idx];
 	if (!copy_page_info->can_flip) {
-		int recycle = gve_rx_can_recycle_buffer(copy_page_info);
+		int recycle = gve_rx_can_recycle_buffer(NULL, copy_page_info);
 
 		if (unlikely(recycle < 0)) {
 			gve_schedule_reset(rx->gve);
@@ -664,7 +673,7 @@ static struct sk_buff *gve_rx_skb(struct gve_priv *priv, struct gve_rx_ring *rx,
 			u64_stats_update_end(&rx->statss);
 		}
 	} else {
-		int recycle = gve_rx_can_recycle_buffer(page_info);
+		int recycle = gve_rx_can_recycle_buffer(rx, page_info);
 
 		if (unlikely(recycle < 0)) {
 			gve_schedule_reset(priv);
@@ -970,7 +979,7 @@ static bool gve_rx_refill_buffers(struct gve_priv *priv, struct gve_rx_ring *rx)
 			 * owns half the page it is impossible to tell which half. Either
 			 * the whole page is free or it needs to be replaced.
 			 */
-			int recycle = gve_rx_can_recycle_buffer(page_info);
+			int recycle = gve_rx_can_recycle_buffer(rx, page_info);
 
 			if (recycle < 0) {
 				if (!rx->data.raw_addressing)
@@ -982,13 +991,16 @@ static bool gve_rx_refill_buffers(struct gve_priv *priv, struct gve_rx_ring *rx)
 				union gve_rx_data_slot *data_slot =
 						&rx->data.data_ring[idx];
 				struct device *dev = &priv->pdev->dev;
-				gve_rx_free_buffer(dev, page_info, data_slot);
-				page_info->page = NULL;
-				if (gve_rx_alloc_buffer(priv, dev, page_info,
-							data_slot, rx,
-							GFP_ATOMIC)) {
+				struct gve_rx_slot_page_info new_info = {};
+				union gve_rx_data_slot new_slot;
+
+				if (gve_rx_alloc_buffer(priv, dev, &new_info,
+							&new_slot, rx,
+							GFP_ATOMIC))
 					break;
-				}
+				gve_rx_free_buffer(dev, page_info, data_slot);
+				*page_info = new_info;
+				*data_slot = new_slot;
 			}
 		}
 		fill_cnt++;
-- 
2.56.1.809.ga0b61035b5-goog

