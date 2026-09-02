Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1577E44AB8A;
	Wed,  2 Sep 2026 13:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788355692; cv=none; b=bSg66Yaw4usI2vGYYVwalbfTMWeQxbrnj2K3RrBB73+QN79qiiOLv6GXWkvYOmF96ZrxwUnsZH4mPEG/xPXOFGcyxauCmcetHvCH9k5xLbRACOlGrLI/29F8wpb0LJO9vdJlBXRJpkOwQiGX1IjncOgxZmi59l5NlDj7r9trSg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788355692; c=relaxed/simple;
	bh=2P+u2evSNuuMf4FBE5dnzxmrTE45UpvZNO/XGsFxtzk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hgO3khOshxpzexf6WyzUHpgABXoEPe2AhPzRyc0iijEAqao7zFgFXSdOaEXzoacaHKhPGpCCsepPD23MIvQSey8MmbgVqFcXiit1zeNu8wvgvGjWRlHTMfEp6w9Yv5+kJHOcsIVGqacfGDWwvQ0Rs6dN2s49zJsSmkp4rbSfE5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXqN/kIe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXqN/kIe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2BF1F000E9;
	Wed,  2 Sep 2026 13:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788355691;
	bh=VS9LQdp7NkiQgnxIwqzDIraeCmzg3HvYohE2ygTY9TU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YXqN/kIeNaq+lJzMUoBaz8Kp/YKh+8m+uwOyVd1GpVg9fcelm2bjLuRMOiZgpTXRa
	 X7PDoN8gF/M0QkLGlNi3utM0B9qHJd5hru4Zn6q1SLXNxLoudl/9mNMwo0zpR8rUTC
	 8oQv6zu8D4IYIDmz4xrseArNbIskD96HZr2rHUSZYfDFdEhZklp6I4eu19G6dFfSC+
	 mahtDTJywL8A4eLKkKCm2Hl3nkFOUWB2VcONEk9aEacaWZaDiHgZ8w1+CK0kUecT7I
	 obKAZR7KyWJDi5slZvofnpFHKPOUv04vGzyyhKXB7A+SaLM13JyJYscUGhX2WppEr/
	 OAkX3fE7rryjg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Wed, 02 Sep 2026 15:26:02 +0200
Subject: [PATCH v5 06/12] rust: xarray: add `find_next` and `find_next_mut`
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-xarray-entry-send-v5-6-d18adae40708@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5938; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=2P+u2evSNuuMf4FBE5dnzxmrTE45UpvZNO/XGsFxtzk=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqmCQeZh+yM/Lo9ujPEXm7kNCxhZn06Kgb64T24
 Hz94PDsAXGJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCapgkHgAKCRD6UCkIqsW9
 0D28EACu5MO7rnm5jy8eTjtmuVUmSYK+/hF/m9SvPkSmDggfcQXwjphQFoCr7jQejjUOgk7ggmq
 yGYXHIBX+K8e26yBI9+7plMGEvv0yWJDNkLr4IVi4GLoHKwltxM1xgSD4rkI9WoFOSMmKHTzqVP
 7zojUxmZy7xDeUScIqIjL+2s8fTP+Fs+5fbojtQ+fC4ZOw7cXvbGACxDAGUUdCnaJJ8/ucw3RIA
 H0PmMspSofYJNXHDA5bJq/ox2EmHUHVNczPp5y0YxL8/HTBrn0ZAkS6jrQAWfud0PY244gHY+dc
 QCbi6+jMMsJUli+SZjAo0LXL6axlD51AoGLW6WeTm8Jjlzw47WknY0X01QrLdoO/noXs47TlN+C
 CDtjAyCQ7hS08Mhmhbu0K99y32hLVegyR54hxE/O3RhE1r0uGHygQEBLI9DhG65Mf/j5ZrrfFOa
 MYz2eaciQTsIKzghYIBdRbq8tysHzC0nLqpZgA1rceS/zjsp+HGncK77Uw3VF4YRPfsEdBoTFc7
 INUZ9u2NQxevOsVLwZU2YqG4g3DseAhxtJBFUx+UKIq4uO5uZKnK+bbhVpwGxDOKiCGoR82+95X
 7UdmA4bFSoQ7NjUEN/K9C7nNm3GDEXx0D3EpxjB87XReQrNzhNe+wICVgGiuwt8RCML79ZV17sA
 cw7CTQA0lGs+y/A==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add methods to find the next element in an XArray starting from a
given index. The methods return a tuple containing the index where the
element was found and a reference to the element.

The implementation uses the XArray state API via `xas_find` to avoid taking
the rcu lock as an exclusive lock is already held by `Guard`.

Assisted-by: LLM
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/xarray.rs | 101 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
index a14f874ad630..9993783fc854 100644
--- a/rust/kernel/xarray.rs
+++ b/rust/kernel/xarray.rs
@@ -219,6 +219,22 @@ fn load(&self, index: usize) -> Option<NonNull<c_void>> {
     }
 
     /// Provides a reference to the element at the given index.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// # use kernel::{prelude::*, xarray::{AllocKind, XArray}};
+    /// let xa = KBox::pin_init(XArray::<KBox<u32>>::new(AllocKind::Alloc1), GFP_KERNEL)?;
+    /// let mut guard = xa.lock();
+    ///
+    /// // Expanding an empty `Alloc1` array stores an internal zero entry at
+    /// // index 0. It must not be visible through the API.
+    /// guard.store(5, KBox::new(0xcafeu32, GFP_ATOMIC)?, GFP_ATOMIC)?;
+    /// assert_eq!(guard.get(0), None);
+    /// assert_eq!(guard.find_next(0).map(|(i, v)| (i, *v)), Some((5, 0xcafe)));
+    ///
+    /// # Ok::<(), kernel::error::Error>(())
+    /// ```
     #[inline]
     pub fn get(&self, index: usize) -> Option<T::Borrowed<'_>> {
         let ptr = self.load(index)?;
@@ -234,6 +250,67 @@ pub fn get_mut(&mut self, index: usize) -> Option<T::BorrowedMut<'_>> {
         Some(unsafe { T::borrow_mut(ptr.as_ptr()) })
     }
 
+    fn load_next(&self, index: usize) -> Option<(usize, NonNull<c_void>)> {
+        XArrayState::new(self, index).load_next(usize::MAX)
+    }
+
+    /// Finds the next element starting from the given index.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// # use kernel::{prelude::*, xarray::{AllocKind, XArray}};
+    /// let mut xa = KBox::pin_init(XArray::<KBox<u32>>::new(AllocKind::Alloc), GFP_KERNEL)?;
+    /// let mut guard = xa.lock();
+    ///
+    /// guard.store(10, KBox::new(10u32, GFP_ATOMIC)?, GFP_ATOMIC)?;
+    /// guard.store(20, KBox::new(20u32, GFP_ATOMIC)?, GFP_ATOMIC)?;
+    ///
+    /// if let Some((found_index, value)) = guard.find_next(11) {
+    ///     assert_eq!(found_index, 20);
+    ///     assert_eq!(*value, 20);
+    /// }
+    ///
+    /// if let Some((found_index, value)) = guard.find_next(5) {
+    ///     assert_eq!(found_index, 10);
+    ///     assert_eq!(*value, 10);
+    /// }
+    ///
+    /// # Ok::<(), kernel::error::Error>(())
+    /// ```
+    pub fn find_next(&self, index: usize) -> Option<(usize, T::Borrowed<'_>)> {
+        self.load_next(index)
+            // SAFETY: `ptr` came from `T::into_foreign`.
+            .map(|(index, ptr)| (index, unsafe { T::borrow(ptr.as_ptr()) }))
+    }
+
+    /// Finds the next element starting from the given index, returning a mutable reference.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// # use kernel::{prelude::*, xarray::{AllocKind, XArray}};
+    /// let mut xa = KBox::pin_init(XArray::<KBox<u32>>::new(AllocKind::Alloc), GFP_KERNEL)?;
+    /// let mut guard = xa.lock();
+    ///
+    /// guard.store(10, KBox::new(10u32, GFP_ATOMIC)?, GFP_ATOMIC)?;
+    /// guard.store(20, KBox::new(20u32, GFP_ATOMIC)?, GFP_ATOMIC)?;
+    ///
+    /// if let Some((found_index, mut_value)) = guard.find_next_mut(5) {
+    ///     assert_eq!(found_index, 10);
+    ///     *mut_value = 0x99;
+    /// }
+    ///
+    /// assert_eq!(guard.get(10).copied(), Some(0x99));
+    ///
+    /// # Ok::<(), kernel::error::Error>(())
+    /// ```
+    pub fn find_next_mut(&mut self, index: usize) -> Option<(usize, T::BorrowedMut<'_>)> {
+        self.load_next(index)
+            // SAFETY: `ptr` came from `T::into_foreign`.
+            .map(move |(index, ptr)| (index, unsafe { T::borrow_mut(ptr.as_ptr()) }))
+    }
+
     /// Removes and returns the element at the given index.
     pub fn remove(&mut self, index: usize) -> Option<T> {
         // SAFETY:
@@ -359,6 +436,30 @@ fn load(&mut self) -> Option<NonNull<c_void>> {
         // SAFETY: `xa_zero_to_null` only inspects the value of `ptr`.
         NonNull::new(unsafe { bindings::xa_zero_to_null(ptr) }.cast())
     }
+
+    fn load_next(&mut self, max: usize) -> Option<(usize, NonNull<c_void>)> {
+        loop {
+            // SAFETY: `self.state` is a valid `xa_state` by the type invariant. By the same
+            // invariant, `self.state.xa` aliases the xarray reachable through `self.guard`,
+            // whose lock we hold.
+            let ptr = unsafe { bindings::xas_find(&raw mut self.state, max) };
+            if ptr.is_null() {
+                break None;
+            }
+
+            // Unlike the normal API, `xas_find` does not filter out internal entries. Arrays
+            // created with [`AllocKind::Alloc1`] store `XA_ZERO_ENTRY` at index 0 when they
+            // are expanded from empty. Skip zero entries and continue the search, like the
+            // `xas_retry` loop in `xa_find` does. Retry entries cannot be observed here
+            // because they require concurrent modification of the array, and we hold the
+            // lock.
+            //
+            // SAFETY: `xa_zero_to_null` only inspects the value of `ptr`.
+            if let Some(ptr) = NonNull::new(unsafe { bindings::xa_zero_to_null(ptr) }) {
+                break Some((self.state.xa_index, ptr));
+            }
+        }
+    }
 }
 
 // SAFETY: `XArray<T>` has no shared mutable state so it is `Send` iff `T` is `Send`.

-- 
2.51.2


