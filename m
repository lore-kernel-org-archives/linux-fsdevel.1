Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795180318;
	b=lgvSDki1dsCMEb3oMh3b/epLOHAJ8PgINZh2clcQsKk+2vl4xAcRdtsWoTQ5b5BGFa1R
	 U+eh4mNX9rQP/17T2jNhwvU+OR7DZftLRGcXvC7hF2JmnWxpVkTVFC8PO9MPc1l0gI0ug
	 Pmm926hW1N8uxvqP0VjJWnoRIlvv28k39wGLZB9yZms45WDOcuNBDzl1CeYNH6uKgEcMU
	 v/Zk4987dwHP86tvs4L3elrShqJ6R7sGLxqILyuWKAoAgnO5xq6q7u+EIfFiixu46qvVK
	 D9koPbdfgQzACgQIod8jUxtYre3J4/NSn59Z+39J8aWkYncDG9mXUBfvk3NcVDQEmkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795180318;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=XlmLL61qNv0OJxe6/2KedGlG+39G1uTBbnNGEpqe9oE=;
	b=vyh8kp8lfM34rg4v8sY9ARhWnt5YJaBKb5E+Mrczcs/nIxNIEl+MGPoDj5NECoeqy1++
	 gXBuSKj9L4twDeV20UpauMaCCE4GHJV5iP8zav1NIC4JDoFCpZr/gyNdq0vjs9JH48SwO
	 gwJd/ShiAjqH/NbCXSulxQCaOLNbTcIaT3BZeB5JUl9lljaGs2ZioMyDM3OeHPlgGuBJd
	 VTL/AINR9FteXJw2L84QQIWDvXQ8kLH6h5h4oJ0JsU8Sdo5o6FbI9sHRRY4e8ubkbZwvM
	 z/Uqf+20cT9vADD/YbYK858cHy/qRJGRW1LYzT8bkCCwPmoGrDfc/j4ilKHXS9EoUzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DT1RSs4I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBB9606ABA1;
	Fri, 20 Nov 2026 13:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DT1RSs4I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A591F000D2;
	Fri, 20 Nov 2026 13:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795180318;
	bh=XlmLL61qNv0OJxe6/2KedGlG+39G1uTBbnNGEpqe9oE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=DT1RSs4IIaivB2KicItxBnhRebQ3ZiWJgyvghHNy20HUDHVVZpBuhqiiL0oCocS/c
	 NILNDPi3NbQi7fb8XFz3G1/0HVnQRVSs7AeuYQpxWMxz28lHFkeiSrZ3CJbpplzxjS
	 Wf11Z4r0o7s03SS0gGHtbiZAlb8BMetWSdbSZmKMZl0aZvmCzLRJiOCGUb8OYMlUOe
	 3gYRPFb25irwhQP79fYtw0XgYnUwg1N7dWlFSqTZH5WX3rZRaLPMR/vMrwNnxHNF6+
	 gihvG03mX+X2/JdXkS9UO6iT4VeXjA/OQ2N1S1J+cgBbNu2O0zMD+yQ3RZLorHyFZ0
	 lzglXsBSis/PA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 20 Nov 2026 14:10:15 +0100
Subject: [PATCH v6 04/12] rust: xarray: add `XArrayState`
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
Message-Id: <20261120-xarray-entry-send-v6-4-1f69d7385f70@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6530; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=LmjFE/5c1aDLEafxOg2FuEeZAj/8eatZT5GZBC4r4iw=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBrAEbGcl2AWVbKxDl+OBbYLszNt5tGmg33naAWK
 8kKJ8tL8p+JAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCawBGxgAKCRD6UCkIqsW9
 0CavEACMKNGo5a968KztezeCuxFNxQVhD5ghum/M6uKI373upKYf5LFwVk7OrlAFioJoTj1TBs0
 Up9QsCxbsI+FyhXBID/Smx1kBv3+0uqqNgsouExKPr4ePI9qYYtM7j++hkzSFQCEV1DpcGein70
 W7WJrE1Sn5Spm89HVu2Idnn5hHQIhsydFZ+1FwzN1oO7QSFuUipiLTevVkX2ee9pe5yaBND0GgW
 F6y1vNI16lOtn5JbHWAGFsxYyEGBFZr1taxrJy+5rufMiUQi9ghF8j5T0CCFTsA6rlcz8l2zQo3
 4w07Q1UBgNGCFqDYkEKFLnRjfof+JoM4Wz4INmefG12kaCqofyuNfG4/7wnNOwqc+fPu4kh/Crt
 b4cjSB2gQuf2YE0NhlqmveQAQJJ7tUpWQz1Q7XbdcDmkkt53TzTk8yDXIXld1xx1C3hDnaV2bzQ
 CDGAtQWILDylYCKukXFxvbk2srA+If6zK+KDpGUNWzgSciIfMA1FE7Ag8GR95c/iGd4pj02V6fG
 VXH1qHTbZl/0gAHwd1m9RpJ8Y2v/0DHiDMhHJRHKtPcFVpDM7J/bGrCmRmR6ywLyuReQk4REGJN
 bntU042a9URuYnRrQE7ChmR4e3uuigUWkZ0cnHbDsTTF1TtuUv7wKccVS9V6umgqfzwHAv2WqyF
 epS7JIwIpNGEWmw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add `XArrayState` as internal state for XArray iteration and entry
operations. This struct wraps the C `xa_state` structure and holds a
reference to a `Guard` to ensure exclusive access to the XArray for the
lifetime of the state object. `XArrayState` is generic over the guard
borrow through a `Deref` bound, so it can hold either a shared or a
mutable reference to the guard.

Use the new state in `Guard::load` by replacing the call to `xa_load`
with `xas_load`. The `xa_load` function takes the RCU lock internally,
which we do not need, since the `Guard` already holds an exclusive lock
on the `XArray`. The `xas_load` function operates on `xa_state` and
assumes the required locks are already held.

Unlike `xa_load`, `xas_load` does not filter out internal entries.
Arrays created with `AllocKind::Alloc1` store `XA_ZERO_ENTRY` at index
0 when they are expanded from empty, so convert zero entries to `NULL`
like the C normal API does, exposing the `xa_zero_to_null` helper for
this purpose.

The `XAS_RESTART` constant is also exposed through the bindings helper
to properly initialize the `xa_node` field.

The `guard` field of `XArrayState` is not read until a later patch
adds `into_guard`, so it is annotated with `#[expect(dead_code)]`
until then.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/bindings/bindings_helper.h |  7 ++++
 rust/helpers/xarray.c           |  5 +++
 rust/kernel/xarray.rs           | 75 ++++++++++++++++++++++++++++++++++++++---
 3 files changed, 82 insertions(+), 5 deletions(-)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 3791af0aadc7..517c5872ad25 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -130,6 +130,13 @@ const xa_mark_t RUST_CONST_HELPER_XA_PRESENT = XA_PRESENT;
 
 const gfp_t RUST_CONST_HELPER_XA_FLAGS_ALLOC = XA_FLAGS_ALLOC;
 const gfp_t RUST_CONST_HELPER_XA_FLAGS_ALLOC1 = XA_FLAGS_ALLOC1;
+/*
+ * `XAS_RESTART` is `((struct xa_node *)3UL)` -- a sentinel pointer value, not
+ * an address. Cast to `size_t` so bindgen emits a plain `usize` constant; for
+ * pointer-typed macro values bindgen otherwise generates a `pub static mut`,
+ * see https://github.com/rust-lang/rust-bindgen/issues/3347.
+ */
+const size_t RUST_CONST_HELPER_XAS_RESTART = (size_t)XAS_RESTART;
 
 const vm_flags_t RUST_CONST_HELPER_VM_MERGEABLE = VM_MERGEABLE;
 const vm_flags_t RUST_CONST_HELPER_VM_READ = VM_READ;
diff --git a/rust/helpers/xarray.c b/rust/helpers/xarray.c
index 08979b304341..79799c55c3d7 100644
--- a/rust/helpers/xarray.c
+++ b/rust/helpers/xarray.c
@@ -26,3 +26,8 @@ __rust_helper void rust_helper_xa_unlock(struct xarray *xa)
 {
 	return xa_unlock(xa);
 }
+
+__rust_helper void *rust_helper_xa_zero_to_null(void *entry)
+{
+	return xa_zero_to_null(entry);
+}
diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
index 19581b9dfe9e..183808971683 100644
--- a/rust/kernel/xarray.rs
+++ b/rust/kernel/xarray.rs
@@ -8,7 +8,10 @@
     iter,
     marker::PhantomData,
     pin::Pin,
-    ptr::NonNull, //
+    ptr::{
+        null_mut,
+        NonNull, //
+    },
 };
 use kernel::{
     alloc,
@@ -215,10 +218,8 @@ fn load<F, U>(&self, index: usize, f: F) -> Option<U>
     where
         F: FnOnce(NonNull<c_void>) -> U,
     {
-        // SAFETY: `self.xa.xa` is always valid by the type invariant.
-        let ptr = unsafe { bindings::xa_load(self.xa.xa.get(), index) };
-        let ptr = NonNull::new(ptr.cast())?;
-        Some(f(ptr))
+        let mut state = XArrayState::new(self, index);
+        Some(f(state.load()?))
     }
 
     /// Provides a reference to the element at the given index.
@@ -301,6 +302,70 @@ pub fn store(
     }
 }
 
+/// Internal state for XArray iteration and entry operations.
+///
+/// `R` is the borrow held on the guard: either `&Guard` for read-only callers
+/// or `&mut Guard` for entry-style APIs that need to surrender the borrow back
+/// via [`XArrayState::into_guard`].
+///
+/// # Invariants
+///
+/// - `state` is always a valid `bindings::xa_state`.
+/// - `state.xa` aliases the xarray reachable through `guard`.
+pub(crate) struct XArrayState<R> {
+    // The borrow is held to guarantee exclusive access to the array. It is
+    // not read until a later patch adds `into_guard`, so silence the dead
+    // code warning until then.
+    #[expect(dead_code)]
+    guard: R,
+    state: bindings::xa_state,
+}
+
+impl<'a, R, T> XArrayState<R>
+where
+    T: ForeignOwnable + 'a,
+    R: core::ops::Deref<Target = Guard<'a, T>>,
+{
+    #[inline]
+    fn new(guard: R, index: usize) -> Self {
+        let xa_ptr = guard.xa.xa.get();
+        // INVARIANT: `state` is initialized to a valid `xa_state` whose `xa` field aliases the
+        // xarray reachable through `guard`.
+        Self {
+            guard,
+            state: bindings::xa_state {
+                xa: xa_ptr,
+                xa_index: index,
+                xa_shift: 0,
+                xa_sibs: 0,
+                xa_offset: 0,
+                xa_pad: 0,
+                xa_node: bindings::XAS_RESTART as *mut bindings::xa_node,
+                xa_alloc: null_mut(),
+                xa_update: None,
+                xa_lru: null_mut(),
+            },
+        }
+    }
+
+    #[inline]
+    fn load(&mut self) -> Option<NonNull<c_void>> {
+        // SAFETY: `self.state` is a valid `xa_state` by the type invariant. By the same
+        // invariant, `self.state.xa` aliases the xarray reachable through `self.guard`, whose
+        // lock we hold.
+        let ptr = unsafe { bindings::xas_load(&raw mut self.state) };
+
+        // Unlike the normal API, `xas_load` does not filter out internal entries. Arrays
+        // created with [`AllocKind::Alloc1`] store `XA_ZERO_ENTRY` at index 0 when they are
+        // expanded from empty, so convert zero entries to `NULL` like `xa_load` does. Retry
+        // entries cannot be observed here because they require concurrent modification of the
+        // array, and we hold the lock.
+        //
+        // SAFETY: `xa_zero_to_null` only inspects the value of `ptr`.
+        NonNull::new(unsafe { bindings::xa_zero_to_null(ptr) }.cast())
+    }
+}
+
 // SAFETY: `XArray<T>` has no shared mutable state so it is `Send` iff `T` is `Send`.
 unsafe impl<T: ForeignOwnable + Send> Send for XArray<T> {}
 

-- 
2.54.0


