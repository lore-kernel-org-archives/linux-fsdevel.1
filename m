Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795136840;
	b=hvJz0rezbiUKaDqStfTMmFiJz5joHk93KMjXYT/iKtFxAbcNiE4Uob/93BRpZyFHJ3Ii
	 xywzAKdLyDa9uf7zS/Y6ZQP01W59DWHFdH+7wN+biVmMJleVV2A5ku8hdd6U+/SU+h5Xg
	 T0SIowOrAy8pQgkv++v8RDsgQnYNr4umrj2CQTMHADWSpPwgQpYPHMBzhKl0jEp3JV4QS
	 DP+hCTQKdRi6OiMpXLuaroetbKE1+L4DJXqCHK3b9Rz+wnmaYBOcuh22Vfa2/HKIS/kNM
	 9OZog//HVoP/OEHfuH5XG/0OIVWQxqIEpF7XqG1OxVkl42SvAD9xWPQyTdXeioOsYzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795136840;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=vXU5FE3T392RxN9QNel254D35psegmPr29XGG2IaIcw=;
	b=GQ7SZ+sfvZyvBzOB8pxqou/lFHH2qDleXqteLWEHT57SlBOTW7qYMrdpccbZk7rObSGG
	 7TGwn8l1AybqYH6Ny++j8vGHhy2z7Na8LK2zzpNqSdM9J3as0MDSYVpOO5HZFSRdiHnz+
	 FCBhmxlENNYVOOTXy6NcApUCYxUtlstPs+si7CPGIbkTGu9RvUSwwigI2YRjF6/vUUcw6
	 uN5SCBj6YVfaMDDai+TIxeW/vTDwz+r6A+C/rmbazMNgc2I8l2EmmI9tUC2cMtrFBW97y
	 QHXt0ZTMbqVzksOlOTE/KQ/mNEbFI3saEb5qk9FS/rTaGJy0bBR13F5UsWyRvl+8zDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JN1XES1B;
	arc=none smtp.remote-ip=209.85.218.72
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5FD60A3830
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 01:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D5FD60A3830
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JN1XES1B
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c505f26e9e1so24315566b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 17:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795136838; x=1795741638; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vXU5FE3T392RxN9QNel254D35psegmPr29XGG2IaIcw=;
        b=JN1XES1B+9xWtZQpoeMZD1UeWfT8QzjJSgx/sA0JgmGXSEnoJmVjMhf9okWGToRyHI
         UC4p+4/gQ3721KhE81Am0R88BKIzA+63rA89MYsqczHOOjNk/NbKL5GRSVvSLYdrwFx7
         veJLApSlferalQefLmHR+mCgrOfnX40PeDyA8ugXlIHH0G+Vd1uNUEnIfQ7P5ZkksIPy
         3dw8vuxjXyNwYxSor20m6+Xloh49B3bI8AXiF4P+b8O2Ogb6X96BGDOB2a6/v24AIV38
         +Xk17oB24yyJNkX/CpxmOpCNeqIP9D9jG6kcaTsguL1bNkWDRHMQZcaWGRXk5eOxSdfT
         JBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795136838; x=1795741638;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vXU5FE3T392RxN9QNel254D35psegmPr29XGG2IaIcw=;
        b=kvOAGDhORAHt6uhzNsCPoK3sMwWBPTY0WJuHUCYsDLn1QBjlUN5HqkIDAqKIUPEwqR
         EA5mh0nMEIizumKkK81h0kZr/if2Z21zoBXMpq1RWGhBCjRBz1bwFsxQ1Y47wBZ8thfj
         Ay8V0AM4gJQhzB3mdMgGm9MxaNU8rCAhoMEfGI/Hqd6rqZ+ch9ky/USFfLPTzgTdRQHs
         kQ8T+OVpJl2mE7HNWHdsMF6T3bdWjdsTknxJ7Z6eWjpc26du4jgIaUiCCKPul2igDpGH
         NbzsytFnflDIIU+T9pMVquZO3/6l7kD3HYEPdEbN1aHg0woFLDW81COIag0vSiDY5h47
         1ZAA==
X-Forwarded-Encrypted: i=1; AL+hErHU8/wpPyCFwqeJnPfaQOdRliT+OYdAI2IHnEZxzqTNEXY5jlQU+RdqKJeZlR87hYRrGyVdf50ODv1KkO9C@vger.kernel.org
X-Gm-Message-State: APuU4Z8/HOWQBaeeCGqQwSPIJ0igMWBURM1jCPesGcdXhKs/gCmSVHAA
	WBi19vm8zBkYoom0JlgzZmUNkPTUHWT3/uAHFKDr9tFw2Lr+3zG9ggCRvPlN/EPE0YVneXc5qch
	dWwTQdg==
X-Received: from ejdlt17-n2.prod.google.com ([2002:a17:907:c651:20b0:c50:cd62:3dd0])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:4fc4:b0:c2e:62af:b6fe
 with SMTP id a640c23a62f3a-c513a5e62e7mr135377366b.8.1795136837193; Thu, 19
 Nov 2026 17:07:17 -0800 (PST)
Date: Fri, 20 Nov 2026 01:06:45 +0000
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
Message-ID: <20261120010655.467825-16-lrizzo@google.com>
Subject: [RFC PATCH v3 15/25] net: Use PISA for page_pool memory
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

When a page_pool performs DMA mapping (PP_FLAG_DMA_MAP) on a device with
pisa_rx_bufs enabled, pass __GFP_PISA_RW to use PISA memory.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 net/core/page_pool.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index d7c88c0b67e53..91cae5ba78373 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -16,6 +16,7 @@
 #include <net/page_pool/helpers.h>
 #include <net/page_pool/memory_provider.h>
 #include <net/xdp.h>
+#include <linux/pisa.h>
 
 #include <linux/dma-direction.h>
 #include <linux/dma-mapping.h>
@@ -622,6 +623,8 @@ static noinline netmem_ref __page_pool_alloc_netmems_slow(struct page_pool *pool
 	 */
 	if ((gfp & GFP_ATOMIC) == GFP_ATOMIC)
 		gfp |= __GFP_NOWARN;
+	if (dma_map)
+		gfp |= pisa_rx_gfp(pool->p.dev);
 
 	/* Don't support bulk alloc for high-order pages */
 	if (unlikely(pp_order))
-- 
2.56.1.809.ga0b61035b5-goog

