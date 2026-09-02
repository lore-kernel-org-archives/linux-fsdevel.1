Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC874A092A;
	Wed,  2 Sep 2026 13:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788355677; cv=none; b=pN6nmY4TQRh5lTD2pE8VRNaG7OZIIxjGKCL39e7YMJYQ/c2wbUCyfwTX+blgYWVtTdUo+e67do14a9391J95vws4IikRRPdHoIiXN43tect90PXRqd0i0rDRBa11fOb7eQxUenu9sSyo2/U91qrx/Z4OqwkDlnpx9krQTiLYQqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788355677; c=relaxed/simple;
	bh=IJL8sHLJzETBX5EUCq0+XoQYAigxpIcbmnUp4kDolk0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ow5kMCdGWFtVwaQ4QlRyiYoRKrjcAkoLW4slNK6/UtfOps3umQObKCZ/Q4DOxFQaI94w2eSF+mn9cfXG9MNcbBnF0wh7RoxOR6UodAVU02N37hLQAJYlJ57u4htcVrBLNrEy/c78J1bUJPVSUcjuHd63khkmNvAhzcVRTj4j6ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+7PMWtr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+7PMWtr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED25D1F00A3F;
	Wed,  2 Sep 2026 13:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788355672;
	bh=rmjpEvPISZ+t3PGfRKTnDAOa6lOnl7cuFJjli1+tyLs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=k+7PMWtrOSFTyQ9F5g7M7pAPrvsEadjDIxkAlifrK3tS7HWsm2efcg1GN0UE8dXi/
	 J8nmGfqbi4ZBMR/I5JaAo/uWxbElKXGEmWPWvW2MDhPgO8jexUfhVlFda5mKtUwWhs
	 btH5gqf8Z+qJ3mDS225R6aLd0Cs5RugRuIiASI+AdyQR3ySMWW42UQe1M48jeAzS/o
	 fB6q2i/ah5Rfh9e6YzYh7jtevdOucodmF+3AKJ6Vc20FQWpSWmPwQyvYQ3PlpcrWTw
	 1iJD6F9WyYK1tvLap+od60/zIkt7WXHWYjJX1XJLoi4Ne9f6YvDoO0SsQ8tz6DQXtc
	 CCydLNfXcKkLA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Wed, 02 Sep 2026 15:26:06 +0200
Subject: [PATCH v5 10/12] xarray, radix-tree: enable sheaf support for
 kmem_cache
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-xarray-entry-send-v5-10-d18adae40708@kernel.org>
References: <20260902-xarray-entry-send-v5-0-d18adae40708@kernel.org>
In-Reply-To: <20260902-xarray-entry-send-v5-0-d18adae40708@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1261; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=IJL8sHLJzETBX5EUCq0+XoQYAigxpIcbmnUp4kDolk0=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqmCQiFeVnhwTDdQFJRjCYOO1PxQcejmTfYtGJX
 zaKc7loM6SJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCapgkIgAKCRD6UCkIqsW9
 0AS4D/4mR4N32k1U3pAh2rJfK5jfyROypSsF3fJL4XksWWspR996nY603YS/pWVLIEy1IvXUWiG
 zqBNIfTISK+5Gx4Zb1jq+4DqRo0sq1xW2/UYQyFZYdUXfAZ5LZQTcZa9CTnZmDTqKXZLb6nZ0MI
 cXa5QRrjyQluHCkg5ZWkVZ52B5rdcJZdknWPvvFNd73JOGc7bUNfxHvUC1W8x2nx86MTv0rePvL
 bbMOofBww0Ps/BY5MW+snKMunRkCvVyn3nr3+yYzLBkC9mCj76NoXooxUafImT2SMhTS+j/KkV8
 gr5BizGqw4DTv9N/O8hzxe0raN/NkIdnAmUtXONK/DmjRBDL1dkl1xlHeFix6R6MWJjFcSK9SdC
 i6AV4GeoM7//WiIye3g5JDS22RbYfF3go+/RiKCgEgSTLZA6NkI6b/159rmlcPGZMmk6VEzcADO
 KmeclUmPOi6HKrWMP+NOymfrt04o0ji7XvH1qJ4ma3lITbaBkU8m7EafGDO0omxGmFCCr5eIzzi
 RrkCMszJ71vAm8fOhGeCYJnKFMtnWkjJJNyLwj/qmTOC6ZD5lDmcTd9b4yNcVuUjQLRMSJUZ6P3
 QsXVwKBoA8ADBipBkSodYaBfCwnJRH9UGwYkK0x4jHKlUIYl6ScJzFxNrSttLGjX4q9XzoCB1jH
 m32JydtEphMt1uA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

The rust null block driver plans to rely on preloading xarray nodes from
the radix_tree_node_cachep kmem_cache.

Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Assisted-by: LLM
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 lib/radix-tree.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index 976b9bd02a1b5..1cf0012b15ade 100644
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
2.51.2


