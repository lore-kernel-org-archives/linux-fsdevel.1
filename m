Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591B84A0134;
	Wed,  2 Sep 2026 13:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788355686; cv=none; b=QeUaNHWu6Z7DuRiJy8uLx+kdRrEg95v7qPN573ZaQ9KeISve2Lqj00BKhNQVIQvrkIblNXs4YQ5UrBPP289ZkDeHoeQe1UeBqPsr6jAKeYpxosAmzmlTkYslO52yK0uwCR11oEqoRI8n1fI5T0743v9kTqoqpQIkNpiXzQUAoEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788355686; c=relaxed/simple;
	bh=cfwTSDtHE61D+hAv0+T26KhcBz89hIRC5Ad95CVeQR0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h3fi6cKyKMJY9hvTqWfOLn7FfZlKbmJsD+QPGY9NGehw10tiklhMICNJMwy+IlooBtG8kajrRCIuhUNLmfIIzy9RHvmnur6Tw7AHgZcyC5CU17Yb6G+ssNjUxf6q7cUhOKoPwXeL62SAt7RofS/p0BgdsubAQlMKiJakf92ReQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+tYMlPt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+tYMlPt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C42D1F00A3D;
	Wed,  2 Sep 2026 13:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788355684;
	bh=xHSGAuvtInu1rhm1zYqbkY0gUKKIuZH8RVv8W86t1CI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=a+tYMlPtBLTjjh8u4I0FUUTv+/ATr23STxu8JvEOsEC6BB2JLrQVwYo+ibZ8djmMm
	 VHref0lIdaBJb2xNwMdS8HjCFo/mDPXX11icCPyHj57I3Zu8+fu2IzzXLlVfp6IR1F
	 OMlIRrh4bV/u8vZuFYYwmo3DGulz2YelZt4eTqfJREz1Ev2yA5dmUsNFNQIrFZZ8pM
	 8ThXilZ7eMwbyHcSYRthiu/BW9VKB6fLjKcTjTBvPTjbav1e/UtbSHBgp/uSuQxqR7
	 w95LewgIlqCvuL5AyH05omlOOHJQXRI8WYE+wSU/UBvn0m21HFlnL668t0RgUZWfhi
	 GU9HNUd6fjGUA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Wed, 02 Sep 2026 15:26:01 +0200
Subject: [PATCH v5 05/12] rust: xarray: simplify `Guard::load`
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-xarray-entry-send-v5-5-d18adae40708@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2495; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=cfwTSDtHE61D+hAv0+T26KhcBz89hIRC5Ad95CVeQR0=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqmCQdaA3WUZjTsSciZ+SO9NZseZTE17fvIgVUS
 7/2O2oFwYiJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCapgkHQAKCRD6UCkIqsW9
 0N2lEACRu02pSYdB4X0b63wrrITFo4OhOg2TPdse92x+5KfKfGKDppJb7bXIJJDBoju8vstecyJ
 9whvl5jPTyAvNMFuL+x0fDNgHq5O75raA0PfKMRLbyIj1PXP1YhgxQp1v+BH3qyhT536HEwKqOy
 wM8t5iym9EjYlBQmXKlDL+RZF6vjGBKkFSvze+ATeHfWmJxvFfgFg2MgAzR7dxRqaiz26kZCQy9
 yIo/wiuFqKq06cNyJLV2tTc/XHUzyjJH9g7hLJrAYueFElS/YirzAcpLj8FrRd61AR6RHVCAIvS
 LWfXLLrJlIdbeoh5CHV9fwDqt+KAAc2jnMMr+5CYMhfRs/L6rAltcBoBTrqCcJav56AIKwC/Zeb
 DIS6YN6o0NKgdQmVhY7pJqjWkNhzwVktGNByfaoFV2hCwJT84GfYjyKUBEvL2fIpAFMsXR+So1X
 jU7ysdOue364CTVO/lqLwRvP1+V9aU/YZzaCXNw6IOsHxeOVwA2VJNDwVlLwK7DDHihUxHJYp8v
 W1LwD4Im1Iij/LgRuAFg/XuwY8aUESgH8ul/nYnylvlgKATq0PBZvw9iI2g2CbA4Biwteni+qsr
 yj8HT77VWNvsqcDt8Kb32SLXfhLW1hunq6xoc4j82/rdS5Uad8lCLEjsixrc9i2hefZSA7NdaJ+
 AQgODgpC2vdQJJw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Simplify the implementation by removing the closure-based API from
`Guard::load` in favor of returning `Option<NonNull<c_void>>` directly.

The closure-based API existed to avoid passing around untyped
pointers. The following patches add find and entry operations that
need to store the returned pointer in entry objects and pass it
between internal functions, where the closure style does not scale.
Change `load` to return the pointer directly, establishing the style
used for the rest of the series. Pointers are still only converted to
references at the public API boundary.

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Assisted-by: LLM
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/xarray.rs | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
index e8082df2b479..a14f874ad630 100644
--- a/rust/kernel/xarray.rs
+++ b/rust/kernel/xarray.rs
@@ -213,28 +213,25 @@ fn from(value: StoreError<T>) -> Self {
 }
 
 impl<'a, T: ForeignOwnable> Guard<'a, T> {
-    fn load<F, U>(&self, index: usize, f: F) -> Option<U>
-    where
-        F: FnOnce(NonNull<c_void>) -> U,
-    {
-        let mut state = XArrayState::new(self, index);
-        Some(f(state.load()?))
+    #[inline]
+    fn load(&self, index: usize) -> Option<NonNull<c_void>> {
+        XArrayState::new(self, index).load()
     }
 
     /// Provides a reference to the element at the given index.
+    #[inline]
     pub fn get(&self, index: usize) -> Option<T::Borrowed<'_>> {
-        self.load(index, |ptr| {
-            // SAFETY: `ptr` came from `T::into_foreign`.
-            unsafe { T::borrow(ptr.as_ptr()) }
-        })
+        let ptr = self.load(index)?;
+        // SAFETY: `ptr` came from `T::into_foreign`.
+        Some(unsafe { T::borrow(ptr.as_ptr()) })
     }
 
     /// Provides a mutable reference to the element at the given index.
+    #[inline]
     pub fn get_mut(&mut self, index: usize) -> Option<T::BorrowedMut<'_>> {
-        self.load(index, |ptr| {
-            // SAFETY: `ptr` came from `T::into_foreign`.
-            unsafe { T::borrow_mut(ptr.as_ptr()) }
-        })
+        let ptr = self.load(index)?;
+        // SAFETY: `ptr` came from `T::into_foreign`.
+        Some(unsafe { T::borrow_mut(ptr.as_ptr()) })
     }
 
     /// Removes and returns the element at the given index.

-- 
2.51.2


