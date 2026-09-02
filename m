Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FC149F10C;
	Wed,  2 Sep 2026 13:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788355670; cv=none; b=Y6A9sIlFRWUkHdJFS/RoVB8hlshx8CqRBBJR4ywNEnpzCZfkHVz//LCu4uQ4n7l5hehzvxnt+6eH7u1ENO47081CwibkC9iXBsLp3FAoqSVnuigOxe/huLHCSvSXnqOIqzAu+WT4hH5R7RRXzZnVnk/ytXXm3yy18SaDB2Hgj1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788355670; c=relaxed/simple;
	bh=YsZRkENbIkLSyIXntyIruQahHQMq15ROVwQjNeshW1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LiScHufKRhw37LdnA6zYk8eP44+0aUUnaSOs5xQto3qPlI3zcYYH/zBjuDP6lot+ITo7+PYw0EUYpflKERnMZfL3ZD0Vie2PcQ6SRIsJ5fd/AB1xeUXn88Ii2OpaGknu/l+JJbNY7Gj2hTQgvBsbnhNV4/D7uEp+nafSv6L2NIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9/mA62T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9/mA62T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8EB1F00A3A;
	Wed,  2 Sep 2026 13:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788355666;
	bh=rvrdQ1X2D5s1R4J+rxE40TWU2LjD4CJYJF+HOAohSg0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Z9/mA62TsFxmdp6qOn6JL9z5lNw3p8Igcv8uQLBoLG25/22AsmTKxdHEyZc3J4n4E
	 vXFNARAodEVuC8SisiGBSUmqW9whWKZzDla7OSY9p/6iltuB2fwnu9Ym3kcEjDCSmJ
	 XeqnTM48BKunAlYgBaa1TGatN5AM/wNxTKVBGrA0wMjcWtScAkYUqs7uw6PpqygcxJ
	 f/juEYygRnoQdOCqAj7qBu2vWJrwZ2RdOtT4HtJTTb1ikMjDmHJMVi41vExedVK5NY
	 U6DoMZ8lrsO445LisxgZAr2ZVJBFuUNPGstRJ5am8ccxUdesAh0m+f5HIEr5BfqWJ5
	 qnmpxagCLXUnA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Wed, 02 Sep 2026 15:26:08 +0200
Subject: [PATCH v5 12/12] rust: xarray: document `Guard` lock drop
 semantics
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-xarray-entry-send-v5-12-d18adae40708@kernel.org>
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
 Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2705; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=YsZRkENbIkLSyIXntyIruQahHQMq15ROVwQjNeshW1I=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqmCQjltpaMuy9pxr0plzFO8VrPqBiBwDIEQ3/Q
 /LPI/ftfsqJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCapgkIwAKCRD6UCkIqsW9
 0OYoEACjwP3ewbl4zVUWZWh7Q57z4bSf5HmjEqnTenAVKH162Qu8PsggMNdwBjI+5GrSS4QC1f7
 agvP8MhuRkcIWon43Um4pPe1+hwNTAIZzsPPQRSA9LBn9aqQYYOiY3P9PaNR8zaepid8BTNXYNd
 uviGW1OvMbTMc+nXySoe+d4vyYskroiYCFSmND1vBGRpD16KAITSVoNqZ3BX9elp+JAqDYUhhQ5
 mYgAm6eGW2Mhw6MfFJH+IW8/WEbKDUpksipvvKBroclQDjnTA6C71klgIhWWji6965B8LEKiEvO
 PG24IEDR85SgOrO6MmIMNdlXDFExtKpX3/0M5/px8V5IXPqkzcg/y5KaoUB6M37JiFkg0PAxxQv
 8Hxfuknl+cM6kd4ZhljhOdvxNYrsQ5Ifyqq/bxUryevVYY0ZdfyOkRnwyQbDN6TC3G9rNUOiQjr
 jVUVP5WPSFjxl1dz6YO/LEkv/WnxhuwxbnWcUlZVE6yLyHwrDxxv+2B3cp+MgKgh9AVUXx8jh5y
 vFUcEPal/Exk5Qrg+Z8sxV4s/uqwiTVCcc4sQrnVjOdIffQhp2Ytz2lG0VPPqIqF2759WLuH+t6
 bT35o0iU4oifBYIvjcGYDkkHtnvT2sw/zn8M8TjRqHXlOtSqbSZQO3djX9El7lWJhzDhbCHkIEx
 t+kiqY0kTwiRcJA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

`Guard::store` calls `__xa_store`, which drops the xarray lock to
allocate memory when called with blocking allocation flags and
reacquires it afterwards. A Rust lock guard is normally expected to
provide continuous mutual exclusion for its entire lifetime, so this
behavior can surprise users: a check-then-act sequence spanning a
blocking `store` call is not atomic.

Document the behavior on `Guard` and expand the `store` docs,
pointing to the entry API with preallocated memory as the way to
modify the array without dropping the lock.

Suggested-by: Sashiko <sashiko-bot@kernel.org>
Assisted-by: LLM
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/xarray.rs | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
index 87123ab96a92..a11472acc661 100644
--- a/rust/kernel/xarray.rs
+++ b/rust/kernel/xarray.rs
@@ -242,6 +242,21 @@ pub fn lock(&self) -> Guard<'_, T> {
 /// A lock guard.
 ///
 /// The lock is unlocked when the guard goes out of scope.
+///
+/// # Temporary lock drops
+///
+/// Unlike a typical Rust lock guard, holding a `Guard` does not guarantee
+/// continuous mutual exclusion for its entire lifetime: [`store`] may drop and
+/// reacquire the lock to allocate memory when called with blocking allocation
+/// flags. Other threads may lock and modify the array in that window, so a
+/// sequence of operations on the guard that spans such a call is not atomic.
+///
+/// To modify the array without dropping the lock, use the entry API with
+/// preallocated memory, see [`entry`] and [`insert_entry`].
+///
+/// [`store`]: Guard::store
+/// [`entry`]: Guard::entry
+/// [`insert_entry`]: Guard::insert_entry
 #[must_use = "the lock unlocks immediately when the guard is unused"]
 pub struct Guard<'a, T: ForeignOwnable> {
     xa: &'a XArray<T>,
@@ -485,7 +500,12 @@ pub fn remove(&mut self, index: usize) -> Option<T> {
 
     /// Stores an element at the given index.
     ///
-    /// May drop the lock if needed to allocate memory, and then reacquire it afterwards.
+    /// If `gfp` contains blocking allocation flags, this method may drop the
+    /// lock to allocate memory and reacquire it afterwards. Other threads may
+    /// lock and modify the array in that window, so callers must not rely on
+    /// this method being atomic with respect to other operations on the
+    /// guard. To store without dropping the lock, use [`Guard::insert_entry`]
+    /// with preallocated memory.
     ///
     /// On success, returns the element which was previously at the given index.
     ///

-- 
2.51.2


