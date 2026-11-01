Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=128.30.2.78
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793541872;
	b=oBXLhiQTMsxq81xzms4UA4bJiIjecvZj648V6gVvgWbUVsq6EunHpRxj4ch/JO3JoG4b
	 uGiyRSC2Wnt5R3dMbePgw+JkEuxjzwkdcQvOv2W1M4WtRuDOUEKWJ2E4El33zyz9lndb6
	 VEuGuL0PZyXZegY7rlTRMiENGNaC87CEcLPYBYj/hR0hBDlKuB0sfd65clwM0dNr5l1+m
	 /43PpSnOholUu8K0c+6CJoYI3zCCXBc0q7/sB+Klg2xjnz1G61oy40lS/okHlZVmY+cN0
	 X+yPkfPxG9JpI5ZOuQuDN37Hg6UBo95w6huJ6VNW7sL23mCDgQ3/Or9bJxwLEesJkpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793541872;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=x2LG4I8K268YSfho51Oa9+mfFy/fqJPwPrh4z5MqxDg=;
	b=dIm/ynMfAbDaoYQ546DGX5FVJCKCuXIVt835rI1ms1CcEx3oDUfJ9/CAjzff3M8rpC0l
	 GGSpk3RyIDD5ZE6DzwHTMCZqbRI9v7sB4c18iPWLE+w2Xi3qUnt7T4/qLZTJ+GnOfpzrG
	 iaqxftNE47VqdGyjN92RGRqE/gF4PMlxiR1clvBFtoap/4yzyHctXX8eMxlkzmuLp1Eci
	 VKpWq7ame5hCpwt/Y2vbbzB7F3l7kf+MJgMSYWRX40NhiLXz58EC5U1pYiZ0ZAjr0F1d5
	 H20UXBKq1PqiUzyuiz71cnv/LZ8bW9maVbYLgZnL8LpDzwqFO3HQaiF/kjqWwSXU1Dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=csail.mit.edu;
	spf=pass smtp.mailfrom=csail.mit.edu;
	arc=none smtp.remote-ip=128.30.2.78
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35544606A324;
	Sun,  1 Nov 2026 14:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35544606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
Received: from escalante.csail.mit.edu ([128.52.128.198])
	by outgoing2021.csail.mit.edu with esmtp (Exim 4.95)
	(envelope-from <nickolai@csail.mit.edu>)
	id 1xNWAf-001kRh-Ol;
	Sun, 01 Nov 2026 09:04:29 -0500
From: Nickolai Zeldovich <nickolai@csail.mit.edu>
To: Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Nickolai Zeldovich <nickolai@csail.mit.edu>
Subject: [PATCH v2] xarray: unlink a node before freeing it
Date: Sun,  1 Nov 2026 09:04:29 -0500
Message-ID: <20261101140429.862287-1-nickolai@csail.mit.edu>
X-Mailer: git-send-email 2.53.0
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

xas_delete_node() passes an empty node to xa_node_free(), which queues
it with call_rcu(), before it stores NULL over the pointer to the node
in the parent's slot or in xa_head.  A lockless walker that loads that
pointer after the grace period has started is not waited for, and
reads the node after it is freed.

Free the node after unlinking it, as delete_node() in lib/radix-tree.c
does.

The radix-tree test suite's multiorder test hits this under
AddressSanitizer: a heap-use-after-free in xas_start() in 19 of 200
runs, none with this patch.

Fixes: 58d6ea3085f2 ("xarray: Add XArray unconditional store operations")
Signed-off-by: Nickolai Zeldovich <nickolai@csail.mit.edu>
---

Notes:
    This patch was prepared with the help of an AI tool.
    
    Changes in v2:
    - Resend with a shorter changelog, per Andrew Morton and Matthew Wilcox.
      No code change.
    
    v1: https://lore.kernel.org/all/20261012174230.772325-1-nickolai@csail.mit.edu/

 lib/xarray.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/xarray.c b/lib/xarray.c
index bfe7bef80f34..d48754c5f8b8 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -500,17 +500,18 @@ static void xas_delete_node(struct xa_state *xas)
 		parent = xa_parent_locked(xas->xa, node);
 		xas->xa_node = parent;
 		xas->xa_offset = node->offset;
-		xa_node_free(node);
 
 		if (!parent) {
 			xas->xa->xa_head = NULL;
 			xas->xa_node = XAS_BOUNDS;
+			xa_node_free(node);
 			return;
 		}
 
 		parent->slots[xas->xa_offset] = NULL;
 		parent->count--;
 		XA_NODE_BUG_ON(parent, parent->count > XA_CHUNK_SIZE);
+		xa_node_free(node);
 		node = parent;
 		xas_update(xas, node);
 	}

base-commit: cbbddb6b08cc9900a87cccaa9b22bbe06aa4f50a
-- 
2.53.0

