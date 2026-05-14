Received: from mail.barrensea.org (mail.barrensea.org [198.12.121.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF051EB5FD;
	Thu, 14 May 2026 05:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.12.121.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778737075; cv=none; b=MB9epN5utRXoGtJuQyk8ZFth3zaitdhmy/fZ5MNPwnN1j7i5sjH2kPBPficw1GEOOUya+csX32iCZf0d5r2/KEZvQt1OvN4WXYJisTpBvLK4HLBRK3UNqfSI5JVfDtW6ykiwg22JY2BP4ipC4eZ1nalVjLUjflSwDecuuqP4EJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778737075; c=relaxed/simple;
	bh=3w8u4NQMV2+LcjwGsPevqZyUJjqBzKWPeujnD3NnYtw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=czd+Dp+THizmoHpUrsaiCyDOw4HyVoZEpGW0z+0s9FDLAbb2Ad+olcLg9z8nsLXtLAFPLUOpK7NJXPw9ORkMmIK3CdP+UJsft14AxptsI3Ff4qvYZqtTmZYxT2H4OHoyjbBR+m8LUATV26eGRqigCQN5rLss52QvSRecxVRzIJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=barrensea.org; spf=pass smtp.mailfrom=barrensea.org; dkim=pass (2048-bit key) header.d=barrensea.org header.i=@barrensea.org header.b=lZ/0Nkgx; arc=none smtp.client-ip=198.12.121.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=barrensea.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=barrensea.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=barrensea.org header.i=@barrensea.org header.b="lZ/0Nkgx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=barrensea.org;
	s=mail; t=1778737065;
	bh=3w8u4NQMV2+LcjwGsPevqZyUJjqBzKWPeujnD3NnYtw=;
	h=From:To:Cc:Subject;
	b=lZ/0NkgxcPZqBAIrvZYk6AlBJNqZ5L5UvSJMgX8+XU7i9o2KkiZtiROqBea4luKB7
	 k77ehaKwMu59SGKFIqZGPVh38XbvI1wJ2JlGBqDzzCx9u0jg1xmpijXKmz9U2s0E4Z
	 1HJhPcTIkA841fPuZo735w+wezPFtt1Yy85jN2pW5y3NeTBGunvoqoTfwAcueXaRpq
	 yIbYEAE7vsSt0XeWpZdhYz2189q8r1oP/0PqEC0Cl7ZcFD7V2XUAEbeoiMSrqwF5OQ
	 xFynrL4lu+C7C18aE2X2u30SaSukjJQXH8+fdNGGdaRC3F/B9h3UpBMdWs9Xklw/3V
	 Wv50DGiz9O55Q==
From: Donjuanplatinum <donplat@barrensea.org>
To: ojeda@kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	jack@suse.cz,
	rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Donjuanplatinum <donplat@barrensea.org>
Subject: [PATCH] rust: seq_file: route seq_print! directly to seq_write
Date: Thu, 14 May 2026 13:37:24 +0800
Message-ID: <20260514053724.178321-1-donplat@barrensea.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the `seq_print!` macro formats output by passing a Rust
`fmt::Arguments` object to the C `seq_printf` function using the `%pA`.
This involves crossing the FFI boundary, parsing the
format string in C via `vsnprintf`, and triggering a callback back
into Rust to perform the actual buffer write.

This patch implements `core::fmt::Write` for `&SeqFile` and updates
`call_printf` to use it, routing Rust's formatting directly to
`bindings::seq_write`. This approach leverages the bounded string
slices naturally produced by the Rust formatting machinery and copies
them directly into the `seq_file` buffer.

By mapping to `seq_write`, we bypass the C string parsing state machine
and the `%pA` FFI callback, streamlining the execution path. Since
`seq_write` uses a bounded `memcpy` relying on the explicitly passed
length, it perfectly matches Rust's `&str` semantics and operates
safely without requiring null-termination.

Note that `fmt::Write` chunks the output into multiple `seq_write` calls.
If an overflow occurs during a partial write, `seq_write` sets the
overflow flag. The `seq_file` subsystem inherently handles this by
discarding the current record and retrying with a larger buffer.
Therefore, this optimization introduces no observable semantic change
to user-space.

Signed-off-by: Donjuanplatinum <donplat@barrensea.org>
---
 rust/kernel/seq_file.rs | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/seq_file.rs b/rust/kernel/seq_file.rs
index 518265558..16ba1fdd8 100644
--- a/rust/kernel/seq_file.rs
+++ b/rust/kernel/seq_file.rs
@@ -4,7 +4,7 @@
 //!
 //! C header: [`include/linux/seq_file.h`](srctree/include/linux/seq_file.h)
 
-use crate::{bindings, fmt, str::CStrExt as _, types::NotThreadSafe, types::Opaque};
+use crate::{bindings, ffi::c_void, fmt, types::NotThreadSafe, types::Opaque};
 
 /// A utility for generating the contents of a seq file.
 #[repr(transparent)]
@@ -32,14 +32,26 @@ pub unsafe fn from_raw<'a>(ptr: *mut bindings::seq_file) -> &'a SeqFile {
     /// Used by the [`seq_print`] macro.
     #[inline]
     pub fn call_printf(&self, args: fmt::Arguments<'_>) {
-        // SAFETY: Passing a void pointer to `Arguments` is valid for `%pA`.
+        let mut this = self;
+        let _ = fmt::Write::write_fmt(&mut this, args);
+    }
+}
+
+impl fmt::Write for &SeqFile {
+    fn write_str(&mut self, s: &str) -> fmt::Result {
+        // SAFETY: `self` is a valid reference, ensuring `self.inner.get()` is a valid pointer
+        // to `struct seq_file`. `s` is a valid string slice, guaranteeing `s.as_ptr()` is
+        // readable for `s.len()` bytes. `seq_write` handles bounds checking and does not
+        // require a null-terminated string.
+        //
+        // CAST: `s.as_ptr()` (a `*const u8`) is cast to `*const c_void` because `seq_write`
+        // only reads the buffer via `memcpy` and does not care about the underlying type.
+
         unsafe {
-            bindings::seq_printf(
-                self.inner.get(),
-                c"%pA".as_char_ptr(),
-                core::ptr::from_ref(&args).cast::<crate::ffi::c_void>(),
-            );
+            bindings::seq_write(self.inner.get(), s.as_ptr().cast::<c_void>(), s.len());
         }
+
+        Ok(())
     }
 }
 
-- 
2.53.0

