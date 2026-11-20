Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795180338;
	b=WvGloOEkd0mVBLvskFs+gVeiGPe+SjG7PA8ovCAfb1tmNChXRD/FnJ6PnzG+4e2/Pq4X
	 lrBchMlfkAcUu4nFW2LH6iOn1KjxzYH4s42mKhprX0jz2QNZxWGqawNHllP+xqfSnZlhh
	 U4XDqSRpg26UerrgG42sa5iZhrJIf3Z7fhJVQYFjmsbL2r6mJxWc+dpgcvODGmybhidcm
	 Jy/vDVEgSdBwhKfMptTNuXf2of5JdGt9CXPSm/DGYkelTb7kb3EwKsWp86WoM1XdptGUo
	 7RGIaHMDplDsHF3BgYA5mWtFDzx9+iCAj9JVjwIKpLrBQf6+EzfAAhvgsf3+3Hybh4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795180338;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=GQRVZtFPrMqjM9Ljx1LpACPKsfPqrLTfGvTwOAaf6VM=;
	b=g+VkNYHJbzsQbzX/+CFyfNP0apQFzD1Axc/+fXoWUx2EFa6FtfdzsB/hdRONO0IlxbL6
	 nHz9bfF3X55SE8ArroeuN7+gWmjMF6p+FbE4NP9ASAms6MaQTlIcYP7jO+LCxHkltBVkh
	 YUbMhlS0LJRkkCsyjS9a8B3xaw8E2BThhotqY6OkPlNGk+QUNinU36F2NS78R/oslbv8G
	 VjY/nTAsNFSXBvClbyvq0Y0WEaOPqDaNwz762uofcDuTC9ehsU2I5w0kxFrBx+Vw1tmZn
	 5Y93JneBhQwtI/0I+E3SZ7lUJw15ij8SgoZg0ZuM6liSE0hIrNvdk7e46gO2xjHf+5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K8Y6HmxH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D9B606A326;
	Fri, 20 Nov 2026 13:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K8Y6HmxH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E93B51F000F2;
	Fri, 20 Nov 2026 13:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795180338;
	bh=GQRVZtFPrMqjM9Ljx1LpACPKsfPqrLTfGvTwOAaf6VM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=K8Y6HmxHZMw6CRCt76N2VnBiocP7PdwOweU372toBpijYOmqfquLIXI6SpIVKqPt+
	 iAHE1SM5ggVRzRSe0d0D8m1hUS92Br0JtIatpyVufiMlghY5KHI2YvYVAl1KCkok3M
	 CT76RY1K1H4On5pjq9GXyfmEDSBRWOgooAyrTpFpD8CmaJYKH7wTyTbjIj4Skjx4gF
	 JBLYrf1a7cyhWms+QQgiS8W7be1SREmCKbV7EFNQA6yus+2yAdHmmRtEe6euK/0hwG
	 mcz6bZr+Vxmua7otNJ9Q52wHxE9qLhwmRKzQQptVuKNC7Xa0SjhCBCwPhguE/+vFSe
	 qQxP3nN0Vhadg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 20 Nov 2026 14:10:23 +0100
Subject: [PATCH v6 12/12] rust: xarray: document `Guard` lock drop
 semantics
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
Message-Id: <20261120-xarray-entry-send-v6-12-1f69d7385f70@kernel.org>
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
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
 Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2687; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=zxQB5t6KyCkOL62Gnm19op5IEY8zItut+0e7/+ELoII=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBrAEbOnSzwO7iDduN3x24CkdhLSPxGyiPH8AA16
 LkANH/1YVmJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCawBGzgAKCRD6UCkIqsW9
 0EPrD/wLNAFwqxhPpX7DPbFMm92L5tSl+9alv+9E6ikSO21MrTTD3NQID03bsXyti9bI/SdZNrf
 pB5eFk6oGU7QEPw6FkUka5ZfNVatNLOk750e5xRnz3DFN2WP461SEYP+y4y04g0ZKAKMBQYU9gf
 RCx7/UG0SP/MwTTk8Y3Q3/Yz6sPagfXTKNugCwUvk3kTjtZZgIT4uXD2edkyWoSSF2FlYKA92I0
 6SqgpKA/mEyhE7ukhrINqWMj+KyRvuG1I2/aaXeLlOrSMCfeD22RqFpTR5Mwh0adbfWkxZvvbyt
 RkLSA1ow7cVLWxI2tVUPVs8U7wf/hqBJyVtuZ7BSmLi62pTyhZ5KpQMF8uQQDnZVVXfyGZAmobE
 sUfCaG4r9crR0wfyy3NonGCkbCLb1I2Ik6pa1qnAvGhk3439reqO6oX2YF2G2oa86gwyB64drXm
 cRcagdr+UedVE417C9CuCzpCEPVT0XeZ7924R4UPMfAFUxOvQ+EnEuAtjOKdRMP0I9hbpqPXIE9
 zDtE/Uz/jikFu5QjNEkVGAw2F6uBMEKckgPJgP01LUoGKRXyLOjxXUrKy0Ff0EReWHVUgNwWyRB
 EwgtBaFW1pkeGaq+AAaR/yMCCueQKBkrgR0PfiedO5Aps/yjKZg9cp6T2CU7WIt94pcIRa09IJK
 JIPTB7dPztzIxEA==
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
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/xarray.rs | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
index b13d06f9b0df..20792b09c126 100644
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
@@ -489,7 +504,12 @@ pub fn remove(&mut self, index: usize) -> Option<T> {
 
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
2.54.0


