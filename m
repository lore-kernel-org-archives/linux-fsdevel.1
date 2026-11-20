Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795136849;
	b=fbpt2+6jLQ+T2qC5qYQxrKOXTVejbVWzmSFg3xQ3JS/4EwWLUPL7GbJpZic9tMCBdUl4
	 McnDHqg2fNuarIVOCUYa/OsaLgMhK3bAHK+DPtcocuay/plPUq6ywcRv46KfVsjWCQCFL
	 A5D6B7lJOJwGi50JaPG5dNvAkgNMescgwtlna89ypnO4Rwxk/4SILsCjQdVAuQ6KUmco3
	 kx7Aoh3zUDrsOtIn8q4HFTt8aCgScLGsvfby40nT4IH/HrmesDEUYefQBeEoFV3eESIVC
	 7U5VpcmQboiofvL6EyyZICWjDWikiA0FsSMHz3vPYu6Zz2JT/qbtgpXqlX/b0f8z8uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795136849;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=E07+bb3FRwBQVv7TP6tKUfjd8V3oXYxVPDexh6Cqmzk=;
	b=dw9zP/MclLAZ5qHIQLT9kYhEm8VvIPcM+WmiO1Pj97tTfU8LtkoiWIV/jYPyawhciAn3
	 6s2Ok2Tn35Ddb482jTx2WU5qZKzCGJluEZGBUeYacLw6T0qiF/SRQrQoD6/vQ/eM/cMem
	 d0Q7A1s/hUnJXkNSD3PDplr1Xdv7IGMeDv0SGV/zuQYvA+AGYeVAFFsWopiHKjuA7bifB
	 brxFPrB+2bCtumBRWldN+t+rSSALh0bHorsLLYRHVRMQ6gHUSeWCSmpglo7yMMO7KvCnd
	 V08cgFKg00gveQaYX8xIihHUU1BGNwnrtOHhE9f5EUPI2d8+mLMD24Iw9DLOkheyP2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=b93YVg4T;
	arc=none smtp.remote-ip=209.85.208.70
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869446074AEE
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 01:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 869446074AEE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=b93YVg4T
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6b4f1fcf171so302825a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 17:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795136847; x=1795741647; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E07+bb3FRwBQVv7TP6tKUfjd8V3oXYxVPDexh6Cqmzk=;
        b=b93YVg4Tm3NX/spWylixOIxUhvRdvQxIAED0+riXQRtSo83NRIpTge2rBzxcszzDOC
         3rugR/9IJ5658Ud+fUJT4UcFrAj82J063h9Hfj/4dN+vMPLRUBX70qcyXWzD8yndZ4r3
         gvEnn939L6CAKAX2sbq66H1utJI9EEojPBLD5FlZNUJogu/LFQjD9PlVTjODPVgf4HfN
         Mmhes1u7rOGZpB3HfCkapqaCrgkDb1LIjXpz5iNJuBeXVa7tLbtBPXYS7tIwbEfohsZl
         /Ng6c6woQyveInvcT6fUrZi9u0LAgbi7XVVgHZFHCL3auVJkwOpwQMgP5SZvJhDx/pXk
         DgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795136847; x=1795741647;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E07+bb3FRwBQVv7TP6tKUfjd8V3oXYxVPDexh6Cqmzk=;
        b=jJkfVrlZR7hOnYErTAQb8Glf4iTdYXN7e8OlUs3siCiJ/bcWICEO9QpAv7D4I5bqFt
         fVbHUDYHvqwxqSuLUTZy2McWS88ptygN9flxtRIECVnwCm58DvDYu3ZW/h/xpWiCV+x3
         Ol1XHbuzD0/JxlYrQ0PwtwZLTjUpyjC0ccpUicZc+dlwfTxnqtTp4Fob0CRgJR1Gg/cj
         ie/L8MYRi8WVZ8BHGUqk7n+yk9l2rre4sitvIGiZ/CGA5yadwLUNJjrgVnElaEAKpjXb
         QqJwiOe/q8h25VduSqEAHBqKQeszk7uuUVala36pd3ZocpP3W9E8CKyNb7PqJOlccw9J
         DbUA==
X-Forwarded-Encrypted: i=1; AL+hErF6sDDRAtwKnNdJ8BO56GD6HhFIP0ZUkCib9mWHFGWiYoxLo/run7h0atwmgXuu5GfuwckR6HN7hibSQr0I@vger.kernel.org
X-Gm-Message-State: APuU4Z+kzmedOSdfX2MgNJQeRwlix4TWzywoY7uIIwsJlvdIXGdlrOgB
	4nLZmH4wWDUJARhPffkldHtwTXS1VOYHGppOVNeVpEsYj8Xq8wjrIjxibPuyh7O9HHUJo4M8aUm
	s1EwRCg==
X-Received: from edl2-n1.prod.google.com ([2002:a05:6402:4242:10b0:6b5:6602:7fc9])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:1e94:b0:6b5:8247:7bc7
 with SMTP id 4fb4d7f45d1cf-6ba37ed4f03mr808156a12.44.1795136846496; Thu, 19
 Nov 2026 17:07:26 -0800 (PST)
Date: Fri, 20 Nov 2026 01:06:53 +0000
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
Message-ID: <20261120010655.467825-24-lrizzo@google.com>
Subject: [RFC PATCH v3 23/25] net/gve: Use GFP_KERNEL when pre-filling RX rings
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

When pre-filling DQO and GQI RX rings in process context before NAPI is
enabled (e.g. gve_open), use GFP_KERNEL instead of GFP_ATOMIC so page
allocation (and CoCo page decryption) can sleep instead of dipping into
atomic reserves.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c |  8 +++++++-
 drivers/net/ethernet/google/gve/gve_rx.c              | 10 +++++-----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
index 6880d1531ba5e..a3fe684ca087a 100644
--- a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
@@ -223,13 +223,19 @@ void gve_free_to_page_pool(struct gve_rx_ring *rx,
 static int gve_alloc_from_page_pool(struct gve_rx_ring *rx,
 				    struct gve_rx_buf_state_dqo *buf_state)
 {
+	/*
+	 * Use GFP_KERNEL when pre-filling RX rings in process context (e.g.
+	 * gve_open) so PISA metadata init and CoCo page decryption can sleep.
+	 */
+	gfp_t gfp = (gve_get_napi_enabled(rx->gve) || in_softirq()) ?
+		    GFP_ATOMIC : GFP_KERNEL;
 	netmem_ref netmem;
 
 	buf_state->page_info.buf_size = rx->packet_buffer_truesize;
 	netmem = page_pool_alloc_netmem(rx->dqo.page_pool,
 					&buf_state->page_info.page_offset,
 					&buf_state->page_info.buf_size,
-					GFP_ATOMIC);
+					gfp);
 
 	if (!netmem)
 		return -ENOMEM;
diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/ethernet/google/gve/gve_rx.c
index 81ea800e66e94..7c201fd513ee3 100644
--- a/drivers/net/ethernet/google/gve/gve_rx.c
+++ b/drivers/net/ethernet/google/gve/gve_rx.c
@@ -159,14 +159,13 @@ static void gve_setup_rx_buffer(struct gve_rx_ring *rx,
 static int gve_rx_alloc_buffer(struct gve_priv *priv, struct device *dev,
 			       struct gve_rx_slot_page_info *page_info,
 			       union gve_rx_data_slot *data_slot,
-			       struct gve_rx_ring *rx)
+			       struct gve_rx_ring *rx, gfp_t gfp)
 {
 	struct page *page;
 	dma_addr_t dma;
 	int err;
 
-	err = gve_alloc_page(priv, dev, &page, &dma, DMA_FROM_DEVICE,
-			     GFP_ATOMIC);
+	err = gve_alloc_page(priv, dev, &page, &dma, DMA_FROM_DEVICE, gfp);
 	if (err) {
 		u64_stats_update_begin(&rx->statss);
 		rx->rx_buf_alloc_fail++;
@@ -209,7 +208,7 @@ static int gve_rx_prefill_pages(struct gve_rx_ring *rx,
 		}
 		err = gve_rx_alloc_buffer(priv, &priv->pdev->dev,
 					  &rx->data.page_info[i],
-					  &rx->data.data_ring[i], rx);
+					  &rx->data.data_ring[i], rx, GFP_KERNEL);
 		if (err)
 			goto alloc_err_rda;
 	}
@@ -986,7 +985,8 @@ static bool gve_rx_refill_buffers(struct gve_priv *priv, struct gve_rx_ring *rx)
 				gve_rx_free_buffer(dev, page_info, data_slot);
 				page_info->page = NULL;
 				if (gve_rx_alloc_buffer(priv, dev, page_info,
-							data_slot, rx)) {
+							data_slot, rx,
+							GFP_ATOMIC)) {
 					break;
 				}
 			}
-- 
2.56.1.809.ga0b61035b5-goog

