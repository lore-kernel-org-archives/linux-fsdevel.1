Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF214A0EF8;
	Wed,  2 Sep 2026 13:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788355717; cv=none; b=kvlICf7go2nHDFMB3Yl9mdRVAdtgbIAHtjOyDHLU+9Z611dqw44kkN5YkcPO+SPxjOzg19P6DnLA3T9dnRSKxl62XABgE58tTSwwo/AJIj7i9d7u/B7M4K6uKOqyZqZrBvJC2vAgFpKiHq/Wxp8vl4MQp6+oUEvw67Iiu0Rbvkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788355717; c=relaxed/simple;
	bh=+omDfc9TL/XAqCElB1ECov07Wz53Bjd9L1vrszIACpU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sB8jlQ9ptcJIB+js2Z/Kuh/mKNTgUHKlL0NnXvILHAryGdDiP8MPd1uzChFLwuYfSWt8CqpoMaHzI3QIfG/fWtG6ESUna82WSWQETWUI38BJPsCWxlu0yMmxzPMFxCipo+SFFLVcJoE94NZL7t5TviNFsfya96yhoGNQv5NtN7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lm0rohuP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lm0rohuP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F4C1F000E9;
	Wed,  2 Sep 2026 13:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788355715;
	bh=dd8siENsqtHhQzXPZF0LKxm97fALr2t5Pd26+e10O2o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Lm0rohuP6ISavxKdLUcodpGsLZ35LIfEfFgviN75v83FXuw7EgygD65gM6GLUyGZY
	 gDUftNOffZpkrhrXf4H0OLW7BoSl4QFXeuLj+M3LhJ+ZwIeQvNKdj6pgNPN7GBgZBX
	 FxiHHsWHlUfTuVSUyMly7Z/1mSWzTOFXHqIYSQJr2rnEa3W3VHxf7OB90QKnZU06y1
	 lXKYJtPkdUJ9yS6Vkaz+NCBaLnQ6ov27PGmV6JrJU792vLc8lTQEnwEJIHiySCHAhB
	 lrMc05SplsUftNtFpG7F8+Xk4UOgquQKVu+NPvf3jQho1uRyYd0cmtVRnNRksN4Ci0
	 5zW+xzYq4enxQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Wed, 02 Sep 2026 15:25:57 +0200
Subject: [PATCH v5 01/12] rust: xarray: minor formatting fixes
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-xarray-entry-send-v5-1-d18adae40708@kernel.org>
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
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
 Daniel Gomez <da.gomez@samsung.com>, 
 "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2371; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=+omDfc9TL/XAqCElB1ECov07Wz53Bjd9L1vrszIACpU=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqmCQawZH0SGA2p5ke/OiKg/3VhhXiRaJhAB+XD
 XruU96yNTiJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCapgkGgAKCRD6UCkIqsW9
 0P50D/4iu74xgFGoPRqYXhC28GSw5li89gEWBMELQwbtd37y7DiKm4hsVD/JbvDhAySxNOPcKhY
 3eKCjD3RcaZfmpBH71/DViwRdJ8tlHt8tTqzlA3ovdM9ck6v7Yfel55OaXcRTHm54+H7BXQSBnD
 5yMll5okuX3iDijeDKXWdrxUWoJl7hBUEjKK8vybks+uuNFVczRVeXkKwqyT3CyUrHVLn1V4KMP
 RdDBJFxj6OwrIZsiNfcMCudWMQUJG/onFXCx3U68Z+ehIkOob7fgN/VOcJNn2t965Y7sYPUMOoN
 O9//Evx9jynx2ZuRBiF/1UmgahJee8SFUjc9m14llAhhIO+M1PeX6z6hJQJqaldgm9Qdy6jqndD
 OxCyUPALpVpUdvb9XXFJNcxofJxB0BY687RxgRgEu0WztaPZ76QcnNawY2dW0wjdQQhHaHBmrnW
 dWi0dhVHd1pW2zd5mJInLzyJm598EsjCYyAHyRhx0aSmDEhiob9gW7Pwa9K5cGqIOkNu/+2ivLD
 nb3iy7mqO82EfMZUcRabMDSpPI4zLGis+bCLVosrvetRa73KwyXeS9ZIjr4ohalgkD6jn8nnpXR
 O6xbyhDUhDXsje6gCw634mB56nB51QY0Kij2FWVCTRI7wjuNo4UDQtNZJRRWye+JH6AroE8oK/n
 lp4H2sXM7jXm+Mg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Fix formatting in xarray module to comply with kernel coding
guidelines:

- Update use clauses to use vertical layout with each import on its
  own line.
- Add trailing empty comments to preserve formatting and prevent
  rustfmt from collapsing imports.
- Break long assert_eq! statement in documentation across multiple
  lines for better readability.

Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Tamir Duberstein <tamird@gmail.com>
Acked-by: Tamir Duberstein <tamird@gmail.com>
Reviewed-by: Daniel Gomez <da.gomez@samsung.com>
Acked-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Assisted-by: LLM
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/xarray.rs | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
index 987c9c0c21989..02f93ae1f92de 100644
--- a/rust/kernel/xarray.rs
+++ b/rust/kernel/xarray.rs
@@ -4,20 +4,33 @@
 //!
 //! C header: [`include/linux/xarray.h`](srctree/include/linux/xarray.h)
 
-use crate::{
+use core::{
+    iter,
+    marker::PhantomData,
+    pin::Pin,
+    ptr::NonNull, //
+};
+use kernel::{
     alloc,
     bindings,
-    build_assert::build_assert,
-    error::{Error, Result},
+    build_assert::build_assert, //
+    error::{
+        Error,
+        Result, //
+    },
     ffi::c_void,
     types::{
         ForeignOwnable,
         NotThreadSafe,
         Opaque, //
-    }, //
+    },
+};
+use pin_init::{
+    pin_data,
+    pin_init,
+    pinned_drop,
+    PinInit, //
 };
-use core::{iter, marker::PhantomData, pin::Pin, ptr::NonNull};
-use pin_init::{pin_data, pin_init, pinned_drop, PinInit};
 
 /// An array which efficiently maps sparse integer indices to owned objects.
 ///
@@ -50,7 +63,10 @@
 /// *guard.get_mut(0).unwrap() = 0xffff;
 /// assert_eq!(guard.get(0).copied(), Some(0xffff));
 ///
-/// assert_eq!(guard.store(0, beef, GFP_KERNEL)?.as_deref().copied(), Some(0xffff));
+/// assert_eq!(
+///     guard.store(0, beef, GFP_KERNEL)?.as_deref().copied(),
+///     Some(0xffff)
+/// );
 /// assert_eq!(guard.get(0).copied(), Some(0xbeef));
 ///
 /// guard.remove(0);

-- 
2.51.2


