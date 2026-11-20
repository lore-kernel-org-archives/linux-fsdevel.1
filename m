Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795180325;
	b=oAJKndlJXDGoiQInc99iImSU29lA3j4VmpePKJuF5lIAmDZxkyLI1/spenXqvU0w1H5Q
	 a9+VGrqJggZJHd5VfTNX/0SQjDedWQ3xEONBMZBAr1lYWI/2UrWmFoEZsaPm6x7elOl4n
	 IeGZPnTwEvlBUNrz5echitMsnJ39M3EkngniNndeKdHqkEejz405D9ZmYqBsJEmDj0n83
	 HzQ2Kz8e+wqiolAngo4Bxjs8X0rHcIPw/4ud/7q7KEH3WreBumvys6W2/dprP6TyRrmUK
	 x8vJ5C+jL9zQZt6L30lEGeyODOf68RgmsT3uVW1QMs2QLnB5k1JpDna3WnmfwUPD82g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795180325;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=+hP09lZtE6eQ8TbOuLXpxKM/7C1qHWXDDDUTO6VJ3ZM=;
	b=0fOzDssSs5sYq5uQvcCK2dF1LQ1DZPwhZUfKK+l9E4pCTHEQBpENgbb2/wdZJAiF+nfW
	 cDuLOjBOs14f4OOxUk9WS7JOE/o8N2Wp9CytBHnVxZWHyqUL9bx2chxO53+fteTvhDNpR
	 UAyc1pSeq+3oRBpLPOmqfo0gsiDBg3nMJS2pd4RJBHiZcQBeyPOp25BLst6WeCHtKWZd9
	 Z95Mj7BdvYW88cbuIaNIJ8bUyHtntFJOy9tQJdvWwVa8Hsg33ey5UOY58O93m9ctyLMgE
	 4cDgpYnQ0HXPv0Jg4OYLoyTSs35M2tQe2MFQy9pwRrksFgoLZ8qFSNwoeoUTE3fru3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FYU7uep7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2DF606A334;
	Fri, 20 Nov 2026 13:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FYU7uep7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15AA91F00A3E;
	Fri, 20 Nov 2026 13:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795180325;
	bh=+hP09lZtE6eQ8TbOuLXpxKM/7C1qHWXDDDUTO6VJ3ZM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FYU7uep7KTrRdPpP4dAAYQbhPmxrxVcP63ZFjmE7U5GmbWKSjDhQhbPYuaoqGsro7
	 yBEbbhT2ZDFJh7aX1CTohFdxhVbi86QU330Ej7w2l3DMz9Ywl9viuehGnGshAkjod3
	 WQOiUTIILk7KNCrT56pF5jkXWd0Fog40XVf8HbDwwzZjQB/yrLNBNLo6zrf707E+AF
	 9OqgF7t3JCOwPlKlKs5tguq8ckY8Tws0L9Zvuh/8t0J5jsvRLANbRCOXm8WC6hhJ04
	 F30izqoSX0bbp3g0dIgfoUFMKqZrbGSjBP3pAWK5BEQ149Xp/6RrxEfmXLuLC/5wIr
	 HYTwsImapaCBQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 20 Nov 2026 14:10:12 +0100
Subject: [PATCH v6 01/12] rust: xarray: minor formatting fixes
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
Message-Id: <20261120-xarray-entry-send-v6-1-1f69d7385f70@kernel.org>
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
 Daniel Gomez <da.gomez@samsung.com>, 
 "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2376; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=vu1pWIgWMPl43F9OTIFN+xRMKvVrKE4I7rGleY0rCyk=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBrAEbDluzOEiiN89ogWhX6YJrkQn7fHtPhXw8n3
 yNSGBu/+9KJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCawBGwwAKCRD6UCkIqsW9
 0HadEACW15CWVaNz/Lm2ABKKs5xRUk28QKyZlwDp/bl68R/VMljAMo7h3/6/RCpNiCnROhjcS09
 eBTT1gz4+z9d7BEBZaciekVY/QmN4SJXcTgsL6yBQ+BaRo8iSh3boG21d55kG6iu/mryuKXGKM+
 LZGiXVt3NNdUV1ssqOkMde25ozGoHiFkW6Kc2k8WCPPmllBlVR7qCTDY7LHVZGf23RZAFcpeaxX
 p5yCuZWW0gqk6W3jdbBSXLq90liGhfbn4CDLD19jnMhGtt6m56N/u0WVCvAo0vPwhjso8fp+uzr
 PK/5hdVpe701sAOPrzfx1dQsljK22hqfJ3/UN9gQb5PRKL3PaYVqZhEKb9FB+h1+Prfau5BiZ/E
 Otl/pd7RNyEgsw6jwCcZai1xk9zjAU3kXACqxre3z6D5W9zVa1ruIsBXOlOsE9s4sQPl9gvT149
 phoRiz/NEwwe9we0XA2owHRfYByJZeqOy2Ob4DYhZiqIE2eAOIHY4BAFHtE42qGbiboszDEgcwd
 QHfif6NVapxysKPm3RwFEa8gvomBkjw5oRjX9wMtmtRtEcfqeIxyBemRbUcdLt6IMdfn91oo0v9
 xD9i+eiZ5HlYXq+KhzjncTW+wMyWGYyFRQsvF8rGhigKjd5t/HCRqMgXGBvZ/ZGHMgXWBP99xn/
 x3MESYqU7mAj94g==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Fix formatting in xarray module to comply with kernel coding
guidelines:

- Update use clauses to use vertical layout with each import on its
  own line.
- Add trailing empty comments to preserve formatting and prevent
  rustfmt from collapsing imports.
- Refer to the kernel crate as `kernel` rather than `crate` in use
  clauses.
- Break long assert_eq! statement in documentation across multiple
  lines for better readability.

Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Tamir Duberstein <tamird@gmail.com>
Acked-by: Tamir Duberstein <tamird@gmail.com>
Reviewed-by: Daniel Gomez <da.gomez@samsung.com>
Acked-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/xarray.rs | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
index 987c9c0c2198..4f4b6bf5750d 100644
--- a/rust/kernel/xarray.rs
+++ b/rust/kernel/xarray.rs
@@ -4,11 +4,20 @@
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
     build_assert::build_assert,
-    error::{Error, Result},
+    error::{
+        Error,
+        Result, //
+    },
     ffi::c_void,
     types::{
         ForeignOwnable,
@@ -16,8 +25,12 @@
         Opaque, //
     }, //
 };
-use core::{iter, marker::PhantomData, pin::Pin, ptr::NonNull};
-use pin_init::{pin_data, pin_init, pinned_drop, PinInit};
+use pin_init::{
+    pin_data,
+    pin_init,
+    pinned_drop,
+    PinInit, //
+};
 
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
2.54.0


