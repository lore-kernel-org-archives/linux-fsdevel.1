Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795180272;
	b=uEHTKjgpb1puXBH1wLw9qsdS5x8AUZq9TuucS7/LJRSAhQgziB5+1waVCmpiWXGeOn8l
	 78DSGFnRPnJrLLv6bkkMFflGAIIh5SFF7qXk9xKUdEzKFjKY9KCGV2yFnbAQI22yUwMPa
	 nqtu/yk8RaGXNLQ3bcXSseVg9OjTT5Affr6ecQyBnvbnK6x2PPZsQxfLur/AxBW8wyp4v
	 yaAnMgU8c4v0CHweXyp5xKSAZwzkWCx2q1jQfprekkozuJjA1AdtnWWP32ZwPji6hJbLW
	 lfrzpwAfeMsZLq1z5Ix274JnxNACXt+KVdQ82jE37mps1NF+AR/GHSzMItFvo49Oo6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795180272;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=+b67SetJCKoOq6HPFCZ+dRd+4Za+7CxQKhQ+b7IQ2N0=;
	b=IUMzue0LoVAcu3ppvu0y3rC9e8M7VGI4Wd78m5Qva3WyPOKG3ZCZ4NUJCkIN9OvyHFqh
	 h/3c52MgJ87KKjVpDuWQGu6fn43nFPLcyXUdNDhxjgRsxFO/SuTf1hElSFLo5RxmDzPin
	 tCm+T7qYBUAnh1W6TFruvlhRPAMfAjiOaj7HYnwP17a+RqtvsrkXkwoO6Kp38qHnO4uH6
	 RO6J2mDP7UyjotLkO43E8GauJTYtdSXkDOOC/A4EIIK10WXCHotrKwQ5SjW74vOwyv3gX
	 Mq4YkYmqIFaTCOiQPGq0fRQ/KFTJZNpDlkJe4yNoddx9DwkxUqqG7y2b8zHy5snnMbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ptq7qIFf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55656606A33C;
	Fri, 20 Nov 2026 13:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ptq7qIFf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 917C81F000C4;
	Fri, 20 Nov 2026 13:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795180271;
	bh=+b67SetJCKoOq6HPFCZ+dRd+4Za+7CxQKhQ+b7IQ2N0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Ptq7qIFfkPNpvJnfaRDnA31wzDuqbrOyjKa4gqxJ6yun667Wz6V1LOWxLS6OK+aTK
	 1lRUqGEc4VESVDH4xxG1ha7mYOWqkE+7prrDjeqwAhcX6Y9k2hvzWZyTRYalJkrvA2
	 JEqso7JGyI4YUrlTAKy51sxyKPO4sfOQEcdcsx6BKf4gleyWxGn5ECtrdj4ltasYp9
	 fMSB7dRNQR2eWzYUI1HsIRhpP/Df7H362e3WLXVEfHW05/9qrakPwg2QGWaVBtRg4l
	 onVgjENPbCjlEblE/QyDuOIQHiONgLBN8XQ+zG0HnKebF3dFas3YozBZoesr1L2Re8
	 WLZEGCokRrBnA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 20 Nov 2026 14:10:16 +0100
Subject: [PATCH v6 05/12] rust: xarray: simplify `Guard::load`
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
Message-Id: <20261120-xarray-entry-send-v6-5-1f69d7385f70@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2477; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=d0rtVC+HSo0Vi0sBV4kpNh2AbvNEJkRxW50q4wxsVeM=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBrAEbHCtNGa0jo0ST/zXruZoCrOK+bQmB9UVylF
 6aY7C26+9+JAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCawBGxwAKCRD6UCkIqsW9
 0CklEACZohQhZKz38cjO5nz9zaGBObG7WbQQ4qIvSQjQyjN1Ei+ETjw6A8K7qLJd7CTExFg4MyQ
 4rfsUVoPKMb5t4xCvsiNRIcZdF6XckWaXrtJRM/lloUb77YA0yDCEbY1aIIbiWigFU4slxRhXsL
 68mrqFLzNcXmdKvomI5clsH6PjeMcaNbHK39U7fAI4wud/dtTVQzfX329JLp3MXszdgvQXGYZUe
 b/pi26d6Js4eiYDtxmouaTlilEyLdMS/1ZxnLmx0f3f8RL5yR2SFsctWepac5YdJPgwO48tLzzy
 KKMMTExDh1svWdwZxgfLmfZXGapBJO/Cl2banPV0z8fxgEyBOvwRmvqoYGcMFaF4H8F9wLF3OR5
 MM9gf1Oy0FIziPSzFZwnBlpRf1hSQ6T7j9EXbmzMPXXOolC1j9M+hGC+Re6/nytEWYRzMraMn8w
 ZeKdGHH0kvA/3W6Nr9YY+wrOv00ob+fdi6usnhrv0OvhjWc4S+nXCihkOHLySLQgQ7ksEJ9almI
 oBLUGoUyB7X4OIf8JX2VAsQOrr6Ow1d13JeX30CSopTxUgG7L+x27uQDx+1UaLQpLVqd7xS7+ZY
 Pt92mpNItTt43cJaJgsafVreTZfqjCWn0xBCV7bKa4ZpHOWdMVqNrSCb+LvSjL2V7DqTnYLI2Am
 VC+IqB36m0N9OcQ==
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
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/xarray.rs | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
index 183808971683..94386678ef81 100644
--- a/rust/kernel/xarray.rs
+++ b/rust/kernel/xarray.rs
@@ -214,28 +214,25 @@ fn from(value: StoreError<T>) -> Self {
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
2.54.0


