Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F8B4A0EE1;
	Wed,  2 Sep 2026 13:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788355711; cv=none; b=eK5uDa3sVDLc9HJhD+HWga3C0s3P3A7xlZUs53XkHUq5+l8zq7QH6v+K2m5jbpS2zMvA6CfGxfMr4828S70uROU3uPTo8iiP147JzDNZeAP55YiKl5hbqCPw/ZRcRqVTAlrJM+8cjwFV9CjGxdDOXtpl802DuRZDJcLDCCYsHcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788355711; c=relaxed/simple;
	bh=qh/kWsxpWtJTnMsjGDetI3+BPXuYwIehfqEkMzoAKOk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OjkTzoO0yz8D/AzKM7N6BrCKXEN0Xikdl4/R+MDiMLNHsL/8tqfbJnKbZgW7QT1xcA1e5oJr30rUCmjalpZWqQZmyqL/iG0H+O8SLOGkxP6xj4hcJ4Zfglb834iBD8nuPpZ+eYKauz5zHD1GQmk4FvT44nFzr4CnSWarF3T81YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUfwhx54; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUfwhx54"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561D11F00A3A;
	Wed,  2 Sep 2026 13:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788355709;
	bh=X7gwJtRN282x+tCWLvqdh4zA4VQZ73eNGEmZwXXg9AA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YUfwhx54IjYX5Ey/zFGYqewmbqaoJ6TrjvfumzLMK7iM/U8sK5VpTQjpMxyy43ryX
	 /Eo9EnkVyXkXT3Cfs0aRWlwdwb6NH7i2iggVOj43ZbBP0tTOEFtK/jekD0iUqPuewc
	 5LyYZyPA6Fd5rPaE4BsbsB3/iQ8stZUSZ59iYXPVnmX/plkb/oh8k2rfcOPMbaC0Rw
	 YvKD9GFuWlQF8pfXXAmHutTk4HPoY33h17zj9T7cxrrkK49Xi0WqmoLn4o3Sg6Krti
	 2I0bshwofTUlzt1BUa94WoMO7+DG9xnVQ0VcLC4MaafqE/c8aDg46x3fzjZUPO4QJk
	 lLAsSO8Kj4F7A==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Wed, 02 Sep 2026 15:25:59 +0200
Subject: [PATCH v5 03/12] xarray: move xas_result() and xa_zero_to_null()
 to the header
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-xarray-entry-send-v5-3-d18adae40708@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2745; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=qh/kWsxpWtJTnMsjGDetI3+BPXuYwIehfqEkMzoAKOk=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqmCQbKtU2TBroNoHBj4gHXVX9d4qVvUTe3v5l7
 WHLs1k9iNCJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCapgkGwAKCRD6UCkIqsW9
 0AApEACtvY4bZttqTtKgG4ptRmCZeXOYE0MPktLb/8/ea9/SZRCy8yzPZlN3pzNq/EzI5dX0fYo
 31bJ9XOJas2xPibfFTAvrxYUOV1abZxiu2M1fagVBF//mZ3oEydoi696PMOgOjJNd+J0RGTNAHl
 pfCRn15HO0aJUaow6XnYWdJX6I0nG2oMbiF0fXHuc8jeBvPa7uS+RWBiAqQsALpl7vQQz09IlZa
 iiG1HMl7gJ2VxvlStC4oMiMU4xg1IBFOV76/BUYvTgVJwVEVERujj2++HCjQyE/iRzaonRMNaCD
 Ro5Lkc086QvEvuvj5J6qw8GIVH/9JL//owEXcMEY7FHxCbwhYBsUHIrSgjj0xhx2e7PFNQnpCW+
 zf3nxBzzqtT/loJ5o5F5QbU2GibP47awBVdfmzWGwD0qI2RlGypGddQLDCJzAuyoEAJO3v2adMd
 2WCzT3dkAK+eyjiL4xF+xTIBXhFg+/8mUU5tUFuN+17hOT6zQw0R2Az/lgpBt8ah94Mngh07WqI
 fVrLdESuNxxGVext+AjR5Rbgje9KdvdUeO5h7NjhOVjpsIEMbkVWvCdeOHC8SrEK37YfzLxHEyq
 yfhgBfNFwYC06b9faLttEBD1l7A9Y9mpYF5OjgE7v1W+FbcyPFek/4RAJ3hyK73pCWMhZ90sqo6
 QzzutF1hJTxulGQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

The functions xas_result() and xa_zero_to_null() are static in
lib/xarray.c. Upcoming Rust XArray changes need to call them from
Rust helper functions. Move them to include/linux/xarray.h as static
inline functions, following the approach of commit 79ada2ae6615
("xarray: extract helper from __xa_{insert,cmpxchg}").

No functional change.

Suggested-by: Tamir Duberstein <tamird@kernel.org>
Assisted-by: LLM
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 include/linux/xarray.h | 26 ++++++++++++++++++++++++++
 lib/xarray.c           | 12 ------------
 2 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index be850174e802e..db2520864aaa7 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -191,6 +191,17 @@ static inline bool xa_is_zero(const void *entry)
 	return unlikely(entry == XA_ZERO_ENTRY);
 }
 
+/**
+ * xa_zero_to_null() - Convert an internal zero entry into a NULL pointer.
+ * @entry: XArray entry.
+ *
+ * Return: %NULL if @entry is a zero entry, @entry otherwise.
+ */
+static inline void *xa_zero_to_null(void *entry)
+{
+	return xa_is_zero(entry) ? NULL : entry;
+}
+
 /**
  * xa_is_err() - Report whether an XArray operation returned an error
  * @entry: Result from calling an XArray function
@@ -1437,6 +1448,21 @@ static inline int xas_error(const struct xa_state *xas)
 	return xa_err(xas->xa_node);
 }
 
+/**
+ * xas_result() - Extract the result of an XArray operation.
+ * @xas: XArray operation state.
+ * @curr: Entry returned by the operation.
+ *
+ * Return: @curr if the operation succeeded, the error encoded in @xas
+ * otherwise.
+ */
+static inline void *xas_result(struct xa_state *xas, void *curr)
+{
+	if (xas_error(xas))
+		curr = xas->xa_node;
+	return curr;
+}
+
 /**
  * xas_set_err() - Note an error in the xa_state.
  * @xas: XArray operation state.
diff --git a/lib/xarray.c b/lib/xarray.c
index 9a8b4916540cf..cddb44f6b4ab2 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -437,11 +437,6 @@ static unsigned long max_index(void *entry)
 	return (XA_CHUNK_SIZE << xa_to_node(entry)->shift) - 1;
 }
 
-static inline void *xa_zero_to_null(void *entry)
-{
-	return xa_is_zero(entry) ? NULL : entry;
-}
-
 static void xas_shrink(struct xa_state *xas)
 {
 	struct xarray *xa = xas->xa;
@@ -1624,13 +1619,6 @@ void *xa_load(struct xarray *xa, unsigned long index)
 }
 EXPORT_SYMBOL(xa_load);
 
-static void *xas_result(struct xa_state *xas, void *curr)
-{
-	if (xas_error(xas))
-		curr = xas->xa_node;
-	return curr;
-}
-
 /**
  * __xa_erase() - Erase this entry from the XArray while locked.
  * @xa: XArray.

-- 
2.51.2


