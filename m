Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=128.30.2.78
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793128818;
	b=VsfICnJwOUmSzhIZ9C3h2YKcaASL087waMysuQc6ahkOEsbY2WZORwAcGH2QAktHlYow
	 1FOHVrAr8E9dEVErHETh3d/AupUyiavpEfyWe+KWvM2ufSvFKIgomyg1eRdv+KfL+k+7o
	 dCU68XflgUtxXTs8ceipyxmtjXlR9/vbEQUYP2WWV1/RZ2+elIrT/Hz7gB5VrU7TC1SSX
	 10ehC7w5/GWjy8TZegM0CjbT5PwVDrPU2ANptiFno/gZqwHpuyS5z/+rypb5L2rByI2Kb
	 5Fc6M/hcEnHErIaQuOlGG1D1Ab45qoaW2IWm9Qr2bCP/nFqA+6mp6ruMGUwwnp/WJIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793128818;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8q9qM/hZwHShCYQg/3HhVfggR1TOZYI42k3fGiqzpEA=;
	b=nog+XGR8QfuCY6LhW+zBh2KTFUEgaktjQZbQ1kRAUDrtPyhsgL+r8krhNwTV5ZbGYI2F
	 F82yG/lKclWVe38L/ch+foFXWY7eIn+Wdympu5pPAnpW7yLVwQCxQ33BFk0OFCgaUsOGj
	 7Qyh6ncDj4YWhFVTzR/YuxZLEjSQZuptPmLktsENwdJIUQze0PW2en47YJLDWxLPWyxd4
	 R8CiHNeFSJ1p8B04s5yYrPjVBv7o3W401+qIBmzFMAryzdDoNdX7vtNyYOh8jDwv6027l
	 psXZE6Fsu2gEdak2bsnNpjt4a9NVjbyb92lv3ZD62uguF8DfP1MmBnggBf4PKjlxd6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=csail.mit.edu;
	spf=pass smtp.mailfrom=csail.mit.edu;
	arc=none smtp.remote-ip=128.30.2.78
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316BD606A31A;
	Tue, 27 Oct 2026 19:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 316BD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
Received: from escalante.csail.mit.edu ([128.52.128.198])
	by outgoing2021.csail.mit.edu with esmtp (Exim 4.95)
	(envelope-from <nickolai@csail.mit.edu>)
	id 1xLmiU-00CXea-Tw;
	Tue, 27 Oct 2026 15:20:14 -0400
From: Nickolai Zeldovich <nickolai@csail.mit.edu>
To: Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Nickolai Zeldovich <nickolai@csail.mit.edu>
Subject: [PATCH v2] xarray: clear the new head's parent before freeing the old head
Date: Tue, 27 Oct 2026 15:20:14 -0400
Message-ID: <20261027192014.844878-1-nickolai@csail.mit.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <attzI4sj2Pagmvkd@casper.infradead.org>
References: <attzI4sj2Pagmvkd@casper.infradead.org>
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

xas_shrink() passes the old head to xa_node_free(), which queues it with
call_rcu(), before it clears the new head's parent pointer.  A lockless
walker that loads the new head after the grace period has started can
still climb from it into the old head through xa_parent(), as
xas_find(), xas_find_marked(), xas_next() and xas_prev() do when they
step past the end of a node, and read the old head after it is freed.

Clear the parent pointer before freeing the old head, as
radix_tree_shrink() does.

With a delay injected after xa_node_free() in xas_shrink(), KASAN
reports a slab-use-after-free in the walker; with this patch it does
not.

Fixes: 58d6ea3085f2 ("xarray: Add XArray unconditional store operations")
---

Notes:
    This patch was prepared with the help of an AI tool.
    
    Changes in v2:
    - Shorter commit message (Matthew Wilcox).  No code change.

 lib/xarray.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/xarray.c b/lib/xarray.c
index bfe7bef80f34e..ae9d7fc68861c 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -471,11 +471,12 @@ static void xas_shrink(struct xa_state *xas)
 		if (!xa_is_node(entry))
 			RCU_INIT_POINTER(node->slots[0], XA_RETRY_ENTRY);
 		xas_update(xas, node);
+		if (xa_is_node(entry))
+			xa_to_node(entry)->parent = NULL;
 		xa_node_free(node);
 		if (!xa_is_node(entry))
 			break;
 		node = xa_to_node(entry);
-		node->parent = NULL;
 	}
 }
 

base-commit: 62c457528529cdcfa32bc52b331ceca10f3937b6
-- 
2.53.0

