Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792583254;
	b=HM8JjLNOIqa7qqm4wbQzKwe4gCTaCmA+IoNjr4K9oKDgS+NPNxS+lT9L8fAHytfUk2n0
	 CHoaSyqKkbnU/RG6ZPOPcBbAwUxN3XxzI7bIDytY6emsmm09jMTNA3LLr/uDsFhJBrqS4
	 iw0BEmzBUURHSUoMB1ewG1bcBpbZvDbPyfUMs3pIR3ibSYOwP99lKNQGHHUlqCLBVXXDO
	 dPFCwKM9gfti5gT2gnS3OMoBd1YT5GRjtUznBxssJBHRWfI6CZGxYcRbOnibUnvh6qFBT
	 4bsP/O/s0h2GFq1eRTBkWc4bZf191lcn9gIwsdEkLkPSR+P4YttqeFglwdM1KrEtqVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792583254;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=k5tAUz/tkiXqS8hJnljlzMQfqWaNZ/lYqApYxklXIbU=;
	b=rtrcSRqx9A/W2zK6C9Jl0VnyNdHFYClPf0fd5cK7Bw9dCDpwy9wTwliyOXAsE1TB6wRd
	 vgRdMGkGeFBVODZChZ/q2PzhU9XsjtUXZDTizPG6Tpyo1J1vae1jtJc5APXkCqn4aU4gq
	 WdkTa8SlD1kIE//Ccvgy1KO/ihD6EnAdCgV8Sw3+K4JBwbuYw9VY6n2sTVckzcqKmC4x+
	 FKU7otBSGc1CX3SpPVqmWQaCWa5s5RSkTdowf8XfEzx/8sGgAWcOVJVLcBskdI/tc6BfI
	 d+g3O92A39bZvsZraX371e7RJ9IwmQ1EH2I8tSEForTcIKBox3iElzkWmCDej7E3z8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KmjfHBMG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85AE60A263C;
	Wed, 21 Oct 2026 11:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KmjfHBMG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC8DB1F000C6;
	Wed, 21 Oct 2026 11:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792583253;
	bh=k5tAUz/tkiXqS8hJnljlzMQfqWaNZ/lYqApYxklXIbU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KmjfHBMGzG71BBUUV9FeGHY/xvy+/c4Vnrc44gX4jucXojg2nTgIi8T46RM+52sIh
	 CgG/UumtBk/l6Hxq78hLSFQOHjHAwkdGcU95oPB8EuM5G24kWATQKMra0NMQ5LIC5M
	 /SiAOtWXWIg7PBpFsBvaj+wOTBPbxZBoSVpR2W0+mjb1FFgW1ok87RIvDoDwfjG2g2
	 WdZ78CMqOuBUccxQP77+dfbibnob4H0ZElJTlDuIQzHwMPTGWW6Pit98D/xJr8a4bR
	 /0DG+ck0ogX23fUXpQ2jq2OGBtebDg7WQbfEmA1NTZkMosbIUkf3+MsGAYaZu9Bw52
	 SJvrec4At6Jhw==
From: "Harry Yoo (Meta)" <harry@kernel.org>
Date: Wed, 21 Oct 2026 12:46:44 +0100
Subject: [PATCH slab/for-next 03/14] lib/xarray: specify SLAB_MAY_ACCOUNT
 for radix_tree_node cache
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-memalloc-prof-dont-waste-slabobj-ext-metadata-v1-3-096800aa3330@kernel.org>
References: <20261021-memalloc-prof-dont-waste-slabobj-ext-metadata-v1-0-096800aa3330@kernel.org>
In-Reply-To: <20261021-memalloc-prof-dont-waste-slabobj-ext-metadata-v1-0-096800aa3330@kernel.org>
To: Vlastimil Babka <vbabka@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Suren Baghdasaryan <surenb@google.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Roman Gushchin <roman.gushchin@linux.dev>
Cc: Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
 David Rientjes <rientjes@google.com>, Muchun Song <muchun.song@linux.dev>, 
 Hao Ge <hao.ge@linux.dev>, Pedro Falcato <pfalcato@suse.de>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 "Harry Yoo (Meta)" <harry@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
 linux-fsdevel@vger.kernel.org
X-Mailer: b4 0.16.0

XArrays with XA_FLAGS_ACCOUNT (e.g. the page cache) allocate nodes with
__GFP_ACCOUNT, and xarray/IDR callers can also pass GFP_KERNEL_ACCOUNT
directly. Specify SLAB_MAY_ACCOUNT when the object may be charged to a
memcg. __GFP_ACCOUNT without SLAB_MAY_ACCOUNT will not be allowed.

Path: __filemap_add_folio() (i_pages has XA_FLAGS_ACCOUNT)
  -> xas_store() -> xas_alloc() (gfp |= __GFP_ACCOUNT)
  -> kmem_cache_alloc_lru(radix_tree_node_cachep)

Assisted-by: LLM
Cc: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>
---
 lib/radix-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index 976b9bd02a1b..2c7531deb0df 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -1600,7 +1600,7 @@ void __init radix_tree_init(void)
 	BUILD_BUG_ON(XA_CHUNK_SIZE > 255);
 	radix_tree_node_cachep = kmem_cache_create("radix_tree_node",
 			sizeof(struct radix_tree_node), 0,
-			SLAB_PANIC | SLAB_RECLAIM_ACCOUNT,
+			SLAB_PANIC | SLAB_RECLAIM_ACCOUNT | SLAB_MAY_ACCOUNT,
 			radix_tree_node_ctor);
 	ret = cpuhp_setup_state_nocalls(CPUHP_RADIX_DEAD, "lib/radix:dead",
 					NULL, radix_tree_cpu_dead);

-- 
2.54.0

