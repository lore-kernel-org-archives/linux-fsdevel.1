Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795180298;
	b=YvzI62giwxN0OuWqwBfBKDYKq5Fq+LLoQEnTXs1pxWgkWVN7755GuRsdMzwANqpXHjTY
	 svYXbZC9kGi48M6qvygz9GA3jeV96VIHJuz+E5SIiICkqqWZJ5zekO0kRdaaWQgo/rwc2
	 WoU7Cd5DWOwP9GaHBtLbjYIr3tWutoyH8VckZYpAV5zN6OOxcNqzGDXTwBr2kOnzXhmmd
	 EHoU0OCqV28utTwpsbLLmKmmHM7Sz7cBh8PJM9Gc2SguAiR019EU2I4Mrp6m/OwQwfsTu
	 cbVWlltoVYUTJo4IW6r/x7X+a5UVByDgVFDpb+yNfiFn3NCijyufSFAZ9w5kcudhWSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795180298;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=8LHuI22szusf4UXGeTOjgNmIH+GHGJvOcdvuE97yqUQ=;
	b=PYejW/ySM5npMIl2fvDMBajZMjW2QHGPSwu6LWXxQV2aZJDnygOu/4iGqiqIBYXdTgXP
	 bz+bEuq+UiDyAxxnBwDM8TtljxhUbrFlrgKkPmeT/g70snuujDwpvv/oyk36L2k1LzYVS
	 k4OwsvcepTpHVtiV2SCMFNM89NNXFAj10ob3VkfpFWfgFJeQ7QjJXUXek34XddbzhXugI
	 2+fDCyk/oQ8Mr5ymZUxbOnIoJrXgeQz6VRR+mvDKYgUMHmd+bWm6nxXmlU82EsMg8clBJ
	 wxpUsLPhIVusi/A+ZRcFkmGmwP42rrYt9db2j8Jl2Ew0nwnJwWtny+aGlSd7XeH4LXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NDs+oIZH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5655460A2615;
	Fri, 20 Nov 2026 13:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NDs+oIZH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B521F01816;
	Fri, 20 Nov 2026 13:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795180297;
	bh=8LHuI22szusf4UXGeTOjgNmIH+GHGJvOcdvuE97yqUQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NDs+oIZH6pf0PIfg3WYotvJXRKhXwKgdAdKkOM3o63no4vgbkOr8fQJNiJLvn4x9w
	 Y8xHVHKl/W0/g3QWBbKuEZktuZ1G2kXWP93D4M2jtyXhATS9GdHTRWWRUp7J1eBsEN
	 AnWwQ8uFhtR6SP3+QlBDIrgfd4yz4C38fUXjRxzk8j6CM0Ohw4g42SPkv/eh3oZGda
	 Aw354dMSTvUg7ngUTKzj3yrdv40bkhMYPZ0cAPkKn+bEqMVvJjE2DKqjIspxcRZNo6
	 Ji+y8VUmybBySINrrslmUIIpmjzdFczXfZcyWXTRinuQ/pxgfn6iqyAA+SMShfz6+j
	 TyUnMbFf/fg/w==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 20 Nov 2026 14:10:13 +0100
Subject: [PATCH v6 02/12] rust: xarray: add debug format for `StoreError`
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
Message-Id: <20261120-xarray-entry-send-v6-2-1f69d7385f70@kernel.org>
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
 Daniel Gomez <da.gomez@samsung.com>, Tamir Duberstein <tamird@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1349; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=LDqnnXjwNbemXFH4MwCH5RwEl8ydtzExVZLJ/kvwf9Y=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBrAEbESh7mTqcqxVhy5f5lzdMLsct0ZQTSf3nY8
 RDvJtkhN2KJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCawBGxAAKCRD6UCkIqsW9
 0IQ4D/wNtEDI/o8Mtqa7hUmPiYz6corHYXVqjaD2UcDKoLsi3eKQxnHWscWQ2o1qk56f4Esl6xE
 VBNYC+V6DCxVVzcuP/qZKUmQJZH5hhdJNV7OROo4JXX4PiSLGlILBFGR65IuBMoDZrn1SpHsF0s
 XxUp9tmqOxBTN3MSc3zF7cAIg9ifCxpSbXFvcCs2rjHrQBqshUwuszQdmsXs1kGerVLaqTxVIl1
 RSPgGH+01XMFGYFpXu+PqUgP2SFFn2NvncQFOJLj9S7Xv0jGBnS/moeMVEFdlCytiIQFRhulHpT
 bQNFOZkFK2I/G2HlvUTiFew/zImrv5gfQSUdf/b3PNYbQ4+5Gc5oWdn73TRWsfDy7AQzxD0KNNP
 6UIEi8FnUkydR5WT+kjQ+bdY/jjUixxPKJjTVDwNApg1UqVfnJH1l5GPtySLzWPLPz58MGC0qhO
 vQJHAdgOeXvQy9Aipt0/BZlExaozDRnhipQmEGkiE3I8oDGXFuWur4EO+jeOLxd/piIJF2aXYX0
 pBPPN3Ory8jXvmc34aeAaqCPkRe7fT91GGIWWWy0Ma/DRL19mxY7T5AwjbaZHubZ46kwLMJDPf5
 wS36++AH7cUU56sxPv68VUJM+syQ0epZcQ1K+RhPDElgi3XDbh+VbuNiaKTU0uKwx5tTWYuY33Y
 v14rfmLKMFPJxsQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a `Debug` implementation for `StoreError<T>` to enable better error
reporting and debugging. The implementation only displays the `error`
field and omits the `value` field, as `T` may not implement `Debug`.

Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Daniel Gomez <da.gomez@samsung.com>
Acked-by: Tamir Duberstein <tamird@gmail.com>
Acked-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/xarray.rs | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
index 4f4b6bf5750d..19581b9dfe9e 100644
--- a/rust/kernel/xarray.rs
+++ b/rust/kernel/xarray.rs
@@ -19,6 +19,7 @@
         Result, //
     },
     ffi::c_void,
+    fmt,
     types::{
         ForeignOwnable,
         NotThreadSafe,
@@ -193,6 +194,15 @@ pub struct StoreError<T> {
     pub value: T,
 }
 
+impl<T> fmt::Debug for StoreError<T> {
+    #[inline]
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        f.debug_struct("StoreError")
+            .field("error", &self.error)
+            .finish()
+    }
+}
+
 impl<T> From<StoreError<T>> for Error {
     #[inline]
     fn from(value: StoreError<T>) -> Self {

-- 
2.54.0


