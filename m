Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A38B481659;
	Thu, 11 Jun 2026 17:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198071; cv=none; b=MHRtQ2r0etmkO3UcmarfagJJnbeFueuJDXnUKYEpG3rfgaazif6TBV37OiJQfx11hsqwHSz8y0Pfxcir42T+Z5K5V6HcXiIvFkpHRUd0vxf7AfIqkFQ05MC0rsWtT+LSdorsYMQ7ksG+tKLG0ISxO1t7du9G3ZbXnaJpPLZ/rLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198071; c=relaxed/simple;
	bh=KZqzhXpLuUiZO+jd6YhFthJurVT4/GGa/2WSPqEKLuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GF+4+sHwvm2IxflI4EYQecSJl+ihj9t21y9/SRLIiRs3F693JPO5PLQAYSyFpG2R8Q6l9hTgAScRsm1vhbo7RitimHQj6dGbEC9hfkS265X1AiUQh534EPx0HZM49BmqILSJNB/Tw1p8b7t0IfKnV2Vcmqgq27LVCA9kE/FtASQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=d/uEMlJb; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="d/uEMlJb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=XQVmtnuRTUVgN+XDKa4kk4jqSyJyiqHHhlvxjk0X6XI=; b=d/uEMlJbnMdJgfnC3PlifVjhK5
	VJUot0+Pla00KEjJhDpVMjVYB64HpRgaMuirhW+RfFMZGL4SWbM23fR0sdUZIARnhBGeZ3/sur/qJ
	LxXIMPOSVCip2gs/i4vwjb2+GF1PriuVmCpZvtLthP+mp4bVi1wHHXFAs8V+1P1r5SeER5lQckn+s
	1OloyPrcqtip13qFCycNqzG+g3hk6bWwfjkBW9O/sNFtXrSgfw/3MHZHcsKZekZrzKuC4p5kc0SIr
	lo3sdmr9YDfsSNwaO0fORNjBmQEwPfew3I47lKLYhCe1u7fk3DKyjUWaQT1QWBUl/Wcqzr4lU8SZ3
	3oDLmRWw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wXiz4-000000070n1-1uTu;
	Thu, 11 Jun 2026 17:14:26 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-mm@kvack.org
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Harry Yoo <harry.yoo@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Mateusz Guzik <mjguzik@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/9] make bh_cachep statically allocated
Date: Thu, 11 Jun 2026 18:14:21 +0100
Message-ID: <20260611171425.1671254-7-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611171425.1671254-1-viro@zeniv.linux.org.uk>
References: <20260611171309.GN2636677@ZenIV>
 <20260611171425.1671254-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/buffer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index b0b3792b1496..e834f7091f51 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -51,6 +51,7 @@
 #include <linux/fscrypt.h>
 #include <linux/fsverity.h>
 #include <linux/sched/isolation.h>
+#include <linux/slab-static.h>
 
 #include "internal.h"
 
@@ -2906,7 +2907,8 @@ EXPORT_SYMBOL(try_to_free_buffers);
 /*
  * Buffer-head allocation
  */
-static struct kmem_cache *bh_cachep __ro_after_init;
+static struct kmem_cache_opaque bh_cache;
+#define bh_cachep to_kmem_cache(&bh_cache)
 
 /*
  * Once the number of bh's in the machine exceeds this level, we start
@@ -3065,7 +3067,7 @@ void __init buffer_init(void)
 	unsigned long nrpages;
 	int ret;
 
-	bh_cachep = KMEM_CACHE(buffer_head,
+	KMEM_CACHE_SETUP(bh_cachep, buffer_head,
 				SLAB_RECLAIM_ACCOUNT|SLAB_PANIC);
 	/*
 	 * Limit the bh occupancy to 10% of ZONE_NORMAL
-- 
2.47.3

