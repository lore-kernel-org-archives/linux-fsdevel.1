Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795180312;
	b=XK05CePqdiFWyKCc/O1Ye6a0YKAmZItiPqJdRDccxPXlWI22jv9cJcWZxE9jfG/ZBHkL
	 2s0qSD+HyLcypXnkctBa6yB1iE2Xzw+P7Q91ExzK431aXFneccRChpDyxYLqQ+tOw6TKI
	 EO4QBPM62wyVkNRheKRgVkk9oU8FU8V4cqus8ZAyGuIjL438HYChG4gbvQIerW+u9+8Nl
	 lV40E9ln0/XH0o4CSMyBhtpiPqfYDzI6Sus3aNetHAweAx3LFVfghKU08OSxzXphSwDXE
	 AeTXf3SVBaGLnDZ4EmWMB//4Ofq1Xue6Kv1QqyQgkI1TT9J/GanKuVzB653Zh1xQ9JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795180312;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=gqLfJsppzt0bobg6k5RSzGuyBhJDJxtFjMmDgLlOsEI=;
	b=VDScxiwSJ9fpDR5Du7bjnWDBCXrR5P/xTfw80yBQbUj5BAb4j/A7PoQXLxZYibMfnMVD
	 RRlgCcul/B7n89dYcOxHCM9hzGgF9/foRJ67c1VWP0vERBmMg2g9qRdzDxyCz9GQkkbql
	 uNEjDYqeJenkzFVr8Tqxsp0nbtQdoocEzgflQtLXYlxl1cH/4LZ/wGo4u/gpiArWiPtmU
	 6i3hzLY/R/PhuEn6w/o1Lp8GUmqG/QdHOAloq1UXSw1yEBp8l/H7UvbgnXyv4o7TiB6Ia
	 3HQ3hmgPvq+NhBi1I0CFCRQGSPlTWxSbBQy7WZyhztfeZ+N91SykyLe8o749PD8pqEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lyy+di5v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5883460A2616;
	Fri, 20 Nov 2026 13:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lyy+di5v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4206A1F01569;
	Fri, 20 Nov 2026 13:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795180311;
	bh=gqLfJsppzt0bobg6k5RSzGuyBhJDJxtFjMmDgLlOsEI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lyy+di5vtOR4obXghB110cGopjnUbxlBWNX0db+usG4+43Nnm6/AntuujrvZb1PU7
	 csvsuwR6rB1XFCwRAA1KJwEvtcAo4HKEXyS8kYeRmc+SGdHST5oBrMi7OhZJz4UXs7
	 9JLhBh4Eokris3PlyVn5ylrm4+1UoVLe0ymzEYhszY6w1kLmx35Uw5MFI8jqU1Ma24
	 G7i4MFr9lO/EfLva+3pJyVNJzTvDmWd5mQ6Ryf5WIPNBo1OVlu4+6H60VVk6jhXaDP
	 LOYqn4nEYpl61LpLYXiuA4F9TR/P8zwXOe/3+c/650C1JFEHqx99RR93bbli6Uy8m7
	 JZhx6bl8AG3fQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 20 Nov 2026 14:10:17 +0100
Subject: [PATCH v6 06/12] rust: xarray: add `find_next` and `find_next_mut`
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
Message-Id: <20261120-xarray-entry-send-v6-6-1f69d7385f70@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5968; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=jINgMPg5g4/dlMBkBia86AcDidALlNNcvPEg68+PUEY=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBrAEbIreNmBUJDVCCTeQ2qKfoguy2Vd5fGVmND7
 KeQW99mI9+JAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCawBGyAAKCRD6UCkIqsW9
 0GphD/9wAEux9+T6rbwFt41YJn+QmcqhYxU+IWcqcmMpat5/xm3Ss9HxTEv4jxWSVP1Bs2Bs6BD
 hS0lPQ3lIBy3MSKHacKEKXr2OGN1BIXqPbS2zovlkYZgqoAQ5+wELbjsObGGQPGBxK6FYGGdyYU
 RLflm0W+tCeRjroKOqIdXAJyI6CMCOMLiIn0qPP2BUlvKQLPxUWr1tk/yWc7OUKXlp30XgKN4w8
 jvEY4pb7aXlOw+oMEDmG8RPSiPfnM4+zuqc7KNRK2rP2sv5dZV941FdxhaavxfounsbIWBmmrk1
 NvSTNO+EwCl3SliLw3NS5stMNrcgN9ln8NZdn9L7Ta8ejwscsnqBpSwzBc9IUnJxncYlf8Oj4Jv
 occWNsqWXMcP9wfXwKGP3yw/JFE3lf7sAKDZrndkc2NMNfKBxxowMg+70hZ2SS1MG/96Dy8oV7f
 AUP9K+/JNBiknVEeAiNhmFDPMBy8prckR9zvX65VRTzrrms4M+hUHDFGQ8aWY5ogYioQSoSOjpH
 HTrRS5+tX2eyed+jNumfGuhu82dD5LlzzQgk2GggikA4j0lbsP7Tn+1xMhJYv0VoMhjh+dOji38
 NTLtRhWvrGm+6NN5xu05Y4TiDJLGK3gogv+AO+wTfxZZ5Wz+btYf0uWGwl10R8s3+kfLaGrbtmf
 YHxM8/rxewp64/g==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add methods to find the next element in an XArray starting from a
given index. The methods return a tuple containing the index where the
element was found and a reference to the element.

The implementation uses the XArray state API via `xas_find` to avoid taking
the rcu lock as an exclusive lock is already held by `Guard`.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/xarray.rs | 104 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
index 94386678ef81..07ec08223fbd 100644
--- a/rust/kernel/xarray.rs
+++ b/rust/kernel/xarray.rs
@@ -220,6 +220,22 @@ fn load(&self, index: usize) -> Option<NonNull<c_void>> {
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
@@ -235,6 +251,70 @@ pub fn get_mut(&mut self, index: usize) -> Option<T::BorrowedMut<'_>> {
         Some(unsafe { T::borrow_mut(ptr.as_ptr()) })
     }
 
+    #[inline]
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
+    #[inline]
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
+    #[inline]
+    pub fn find_next_mut(&mut self, index: usize) -> Option<(usize, T::BorrowedMut<'_>)> {
+        self.load_next(index)
+            // SAFETY: `ptr` came from `T::into_foreign`.
+            .map(move |(index, ptr)| (index, unsafe { T::borrow_mut(ptr.as_ptr()) }))
+    }
+
     /// Removes and returns the element at the given index.
     pub fn remove(&mut self, index: usize) -> Option<T> {
         // SAFETY:
@@ -361,6 +441,30 @@ fn load(&mut self) -> Option<NonNull<c_void>> {
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
2.54.0


