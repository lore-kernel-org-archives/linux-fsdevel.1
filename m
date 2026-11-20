Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795180284;
	b=F6KeMN9RgGatef8THp+NnbvZMuRAsRxZHThgYx/jl4e6nwer6CwO74x2/5cs4jFyCtaQ
	 Z4X/+Foc2MpSfTaAppAID/VtQeukNJOq6p5WyGAVs8a96cGvClqmgLMwRg7Q1mEG6iazL
	 N/3AiQr3oB3xBwp4GlMESPjVvFKruiw8H9+DOrbBHjT3ZCAwl2uIQeh9eizJK30+gmMVI
	 30ZRQkj+OnxQp+fRq05/uBMgIxdmBuu1NjVrwJyQd4N6d8soPkkG+JAPgTOOvXjNOwSP/
	 1MmXNITbnq1xhTfjwQffexor2Edm76dW924zw8JLCoT3kQrsP07HfiXoJyCEMORAbRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795180284;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=A/+gZzyL81rIhTfQl485EM05rto2HhCWsUis8cJpLtM=;
	b=oIImkhDk14oQ2qoDyjFhnGqaObdqpzVe7YoWfiB21ik6z/invCkhdVWH3P2UvKv3wM3q
	 j450A+/ZDDc5iTsS5oEs2sddhAeGSuCTvCKfCFZy04hnp+0WGH+MPqq4y54g7tAW3rtak
	 2XjYAJVTW1MW7ek8JoYeqedvS3XtHdbuhL18aN9L3ON0DSyDkfiL94Z27nGD2u+6Phcuz
	 F2Z8xEesV4DlGW1JsSCvL+MzW4bmcucFEkg5oVvKrFykUJLA3BWq7YQJzm8eU576OM1W3
	 U2CC4FO4EzMJeOZnGI+3d17inTcvwcKpP8sqbyjOh33ZhYUyzoQaypNgwuuDwuhBlEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ij+IgiF7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A09460A2611;
	Fri, 20 Nov 2026 13:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ij+IgiF7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C841F01566;
	Fri, 20 Nov 2026 13:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795180284;
	bh=A/+gZzyL81rIhTfQl485EM05rto2HhCWsUis8cJpLtM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Ij+IgiF7PHYNpwNc92yJuJt87XUOL/CmbXVr5DjpF9qJfdOVNVAlXaBuIWkpx3sPX
	 PHaUng495YTQN+wIQceCjtMVbfAUougzkdJRflY41SyKb4jdZQlwU0Yt3+D8j0gWiz
	 +c/zpihzO+pwvgK9nWb9Qi+07x5lfGke2DpOjSVIED5jqp9MsVkgcQQ0n3HR2ZkyMB
	 hu55iMX3BHiJw/Se/bg8pO96BnQixbBqiTgZDjFwBOGaCBExO4t/hQb4WVBCuA80ai
	 +ewmynKEeussF/o/Wbyy0zvaIaieFopK3HoEwkEXGHzdO9hSP3ArHVLwfsWRW3gFGP
	 YrLYfNL9dX11Q==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 20 Nov 2026 14:10:14 +0100
Subject: [PATCH v6 03/12] xarray: move xas_result() and xa_zero_to_null()
 to the header
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
Message-Id: <20261120-xarray-entry-send-v6-3-1f69d7385f70@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2723; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=ca+4WUJBKKfPYSZI2hkWUZre4cjwUXs8x7GoxKkJ+V0=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBrAEbFnFw9rCz1Jelb3iakHInaQsNRR8kKr+7GN
 w8gpl0GTkCJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCawBGxQAKCRD6UCkIqsW9
 0J3CEACzMsK+m4Dg1xcrEbxsQuJ6A2tsRgSLRenMoZVnVmZCFXa91CIJAJjAHGYufxyjSiRNGaf
 CMTMgh3au4y1+w0CNdn7IQsHpCZnesqFIGkSx30ONJgijxCvMn29faGLvUvIcsGLlbLq/0INZgj
 GGjeMJlMIMklMIPq6OSmyg8/ghAc8X2AksxqSolcQJJVS2n7/MhoxbNnHvP9utkfuf63XwmkbU+
 6PchkUVhgUleFswDlr6LxZcKHpRXeWa6eNiG5e1ve6RG9hiLg6LgKJ47eBXMi+pApUP7Oko5g06
 NopeANniQ9yf5eyTCQsOK7omt59/0XEINdHIBxhQyn0RMLIxCwB/7HhePp9ygHM2i4R+hdFV+Cu
 qDIfInt3M5EO5hutxnt7ZRtCiFVMyz1ZX9RZh3HZ7mbjcWccuWSk1oNIYa1W03MQvlNZp46M0Ps
 xvXcqFMThGzNONErsCDC234+Rc8VIPFNKU0xw0oLg/1YP2zEvf1Y8HP6mvnv1ize2Gezc01Hgl9
 +xy9vogiSrovDdiJ+YM1xCuTgOq8UmsM/SReX1qSWhU9ouI8kzkBB203ikD60m1tyHBnAtKyDbl
 xNn1PlYt2XXB0LWYvXCJuOmVSx6qN6qoPhY0Z4u75vKT2Sq4FqTKx64bVxPBG7oeaAOvpoz8Ulj
 IGBeCmbtnUUpmhw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

The functions xas_result() and xa_zero_to_null() are static in
lib/xarray.c. Upcoming Rust XArray changes need to call them from
Rust helper functions. Move them to include/linux/xarray.h as static
inline functions, following the approach of commit 79ada2ae6615
("xarray: extract helper from __xa_{insert,cmpxchg}").

No functional change.

Suggested-by: Tamir Duberstein <tamird@kernel.org>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 include/linux/xarray.h | 26 ++++++++++++++++++++++++++
 lib/xarray.c           | 12 ------------
 2 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index be850174e802..db2520864aaa 100644
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
index bfe7bef80f34..49fbec5f6c38 100644
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
@@ -1627,13 +1622,6 @@ void *xa_load(struct xarray *xa, unsigned long index)
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
2.54.0


