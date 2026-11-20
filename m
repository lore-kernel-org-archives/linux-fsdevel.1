Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795180277;
	b=zVKmTirm7qlDGWq7a/29cwymwN9onyJBir1hTkYh17eMMycpz1jy/gst+O8E0uxdghPe
	 iikV+VW6elaEzt04IDIID0lrQ80wnM8mk4aDcRceNRKIjYkfHGaXgmBf9oyygTjcdtmKG
	 c9f28NqSLt4oT1W4yWv4GbzS7mZ042XQxf9xpL3XOBC6OTI9Soxh+hn1ToI8QjvgiKiV0
	 Domc70e/2cjRsDFnXZ0zG/w2BCSnjciNFId3Tay48jeA0ituFL8FztnGUQ7tU/NR98+Ab
	 HP1NB9WW/2c6IOy7iwoE43brqMXmNc4wFg1K+YD3uSpCNuF/sUBeqWLYacYrHjQZCaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795180277;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=160vS2fUgreh2TfeX5DPq7qpDcpzIYMArC2L5k9SgNM=;
	b=iWyUmeBGP8YQWg7qJpj4xEpreHW3xO9/PeDAGD9U8U0QgqodRG76xwyGQ5z/Rn1VnwNq
	 DQjXAY3ciQp2DDt3XfzhNm2LInXbb87fwymUq4axHRGXdYeLJCgCS8809iU57YTZlkwsr
	 gSt4Q5s5a6nrKc+2mAt4bSFarofRf9tWpDMtCuDpTAG3why1rzVLrhlsm78hIaMVV+C3K
	 KCGzOrASgKi7VQ0DaDu0RAZLCCBt3/zVPjt7vwnGIVT6qUUIWHmu36rRwcTO/riO5rpZA
	 qQPSPiBYEuj1Jx/5EGWIXrIimQZqpevjT9gktxIE3beP3o7domArELiQyeyN9ey0Gqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M7xirJuz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEC860A260F;
	Fri, 20 Nov 2026 13:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M7xirJuz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 870821F000D1;
	Fri, 20 Nov 2026 13:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795180277;
	bh=160vS2fUgreh2TfeX5DPq7qpDcpzIYMArC2L5k9SgNM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=M7xirJuzZ5oA1ievdq2Z5HJpO6zfZY8Vw1LWWiCMZdvJk/yYJe2E2wKKVkEcq81lk
	 DuBKaDKs21me7ZGk7j8C3eg5ljwN6ZOd0D+8uwY3w8ydLP0VpV2YLX1tOQlczuTdzb
	 jKb+LcI/ahZRDzBRBh+zGEK3TxK3SImtVsiU91gekIHoWWSpew/rwPhhwKahaz6CBE
	 v9wFrdYVDjhtX+woHg+UPtEC2T18Ww1kwjH+pnqrnTMhODEdWtdV7sz0zYznBZ99qw
	 YXv/efGovJMjhpYknIeuFdbyl1rE09jfcK1lm68QB9nVHR2cCf+IJaj3Y6Ud8h1AJE
	 OQxra4ITNG/0g==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 20 Nov 2026 14:10:21 +0100
Subject: [PATCH v6 10/12] xarray, radix-tree: enable sheaf support for
 kmem_cache
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
Message-Id: <20261120-xarray-entry-send-v6-10-1f69d7385f70@kernel.org>
References: <20261120-xarray-entry-send-v6-0-1f69d7385f70@kernel.org>
In-Reply-To: <20261120-xarray-entry-send-v6-0-1f69d7385f70@kernel.org>
To: Tamir Duberstein <tamird@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Matthew Wilcox <willy@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1241; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=P1Sxf06ssHf1MjkVVG32ZjziE2PXVu4nAet8QXuksZM=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBrAEbMHxjoltvdoQ0tnj6l/F1QLYjH67WwokRyZ
 IPDAfggC2aJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCawBGzAAKCRD6UCkIqsW9
 0E8XD/9pK5/gJYEgpSSdAhk3TcyQDq0CZSln331F2mWlr10c7EDtGcbOulbVg/kz2SfZvICcVgI
 MHr8SAG80LFTcTObqyfDSBTIgObduDMWcjvY21tTHQ7/bX5yuDgC3WaM5Azgv/1Ed9LYe0O4ENl
 GcNvLaalgFYpOVTbSvSW2kkaN8KdG7OYlNKVNZDRgXCMOqHk4ClSGLTEHflEsWI+gNwEjmUvc+1
 mS3KdZ9DmYoyX+341dMNha8x467GMeCne5W0RpoccYNwFdKz6efyAMFz/afNEqrKp8TidJeHCs9
 EVV8298HN+uhQkygODyeybv2J9HQK4XnY76FT4hNNOuMzFW0VPRme4uhFadlur/JJy67eeU552u
 FkoJNgiYsYogxMVIKA8V1tKxc1STFGR12biLiwAPSwBje4XjowtDL3Lbe6SEVQFWzBATQkquxvp
 2gbRoi8uEzErLbsW7Zi2NJoHUFgY6dVQ978GdKcZwhgynsHP9nqJ6A0ILiNARmm5JfQEkMJb7P1
 QKAeTQFTSLQFqD+kCsrO42jvkL9fqFlBEWBs/cYS5KZtBzMiG9kAVs16EqdMU7PufpP8o2RHC7A
 7njqjDReZdsSjqnogRpCbfar51tJc2bhyE9AtoDUyP1z30RESpXUAMEu4fhdRdhnuVpGT80J8Ch
 0MiOVM5xFufz+KA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

The rust null block driver plans to rely on preloading xarray nodes from
the radix_tree_node_cachep kmem_cache.

Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 lib/radix-tree.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index 976b9bd02a1b..1cf0012b15ad 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -1598,10 +1598,16 @@ void __init radix_tree_init(void)
 	BUILD_BUG_ON(RADIX_TREE_MAX_TAGS + __GFP_BITS_SHIFT > 32);
 	BUILD_BUG_ON(ROOT_IS_IDR & ~GFP_ZONEMASK);
 	BUILD_BUG_ON(XA_CHUNK_SIZE > 255);
-	radix_tree_node_cachep = kmem_cache_create("radix_tree_node",
-			sizeof(struct radix_tree_node), 0,
-			SLAB_PANIC | SLAB_RECLAIM_ACCOUNT,
-			radix_tree_node_ctor);
+
+	struct kmem_cache_args args = {
+		.ctor = radix_tree_node_ctor,
+		.sheaf_capacity = 64,
+	};
+
+	radix_tree_node_cachep = kmem_cache_create(
+		"radix_tree_node", sizeof(struct radix_tree_node), &args,
+		SLAB_PANIC | SLAB_RECLAIM_ACCOUNT);
+
 	ret = cpuhp_setup_state_nocalls(CPUHP_RADIX_DEAD, "lib/radix:dead",
 					NULL, radix_tree_cpu_dead);
 	WARN_ON(ret < 0);

-- 
2.54.0


