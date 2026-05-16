Received: from mail.barrensea.org (mail.barrensea.org [198.12.121.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C250322D7A1;
	Sat, 16 May 2026 04:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.12.121.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778904583; cv=none; b=GEk1LoaZzXLLj5sGK2pfiNhJByjULgljHS1TVYk2okBpDoOaNIitAxD66NZfpZlBxWkc347DT+HFnMeDtn2pOTyEz/kR2EChWetE9nIehA2Blq4+ChbtDl/8+dppwGkLc/Q2MrnBqeImuc5y2R9l53K2BEtzFcVCKg83bfQ/A34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778904583; c=relaxed/simple;
	bh=hkq73XUOQRHbCfIfA6UFCTqAPWIQo4E5uD50ki1jZbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RA3UXFMKvY9Dwj96sB2pXZiSkwZJRyNiCp3GHCsl82lZdQjAtUEJr/befi8f5RfASL80f8SSnkLoa/TfH5hCGqQ+2S3X8MA9Js3FyHkfObmrrRXDHGtZQ+fOP2d8IXoXGdMHdP2J/7swlHuHK0PpjdB4WZ3YCXbeleCa4/jhqIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=barrensea.org; spf=pass smtp.mailfrom=barrensea.org; dkim=pass (2048-bit key) header.d=barrensea.org header.i=@barrensea.org header.b=Wmwk5dL/; arc=none smtp.client-ip=198.12.121.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=barrensea.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=barrensea.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=barrensea.org header.i=@barrensea.org header.b="Wmwk5dL/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=barrensea.org;
	s=mail; t=1778904572;
	bh=hkq73XUOQRHbCfIfA6UFCTqAPWIQo4E5uD50ki1jZbY=;
	h=From:To:Cc:Subject:In-Reply-To:References;
	b=Wmwk5dL/Cdp/l0BoxchOp4iI9bNZHV/jjqiYXplRkJLZzWjrMUGw8Eu4mYZXni4wz
	 4oo56pnLKYCYOfe7vpeQXA30Da+pQEfW0VpFU1cxGO5AQEsQ0QB/qyWpDE/TdNimcv
	 4sAGvuyxQL5qyKPOAM6Z/1a3Dnj0CyOJ0fOvEDh7YOczvESHs4Qp04WngSy87Vo1t8
	 hrkBuqunhutAXtqLOMTZvnrsFcLLn5gqeDoWWkDWdJfVRRsR6N13cF+TUldZq7+soL
	 6YJ0g0OAbBmU+lvivOkPbIsLAE9KerQjX61YJG95BT3PWX72qcAPLV7nOsqxYNVM00
	 dS1iShhWwsozg==
From: Yifei Yao <donplat@barrensea.org>
To: donplat@barrensea.org
Cc: a.hindborg@kernel.org,
	aliceryhl@google.com,
	bjorn3_gh@protonmail.com,
	boqun@kernel.org,
	brauner@kernel.org,
	dakr@kernel.org,
	gary@garyguo.net,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lossin@kernel.org,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	tmgross@umich.edu,
	viro@zeniv.linux.org.uk
Subject: [PATCH v2] rust: seq_file: route seq_print! directly to seq_write
Date: Sat, 16 May 2026 12:08:12 +0800
Message-ID: <20260516040812.477347-1-donplat@barrensea.org>
In-Reply-To: <20260514053724.178321-1-donplat@barrensea.org>
References: <20260514053724.178321-1-donplat@barrensea.org>
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

Signed-off-by: Yifei Yao <donplat@barrensea.org>
---

Changes in v2:
- Add `#[inline]` annotation to the `write_str` trait method.
- Fix author name and signed-off name to use real name per the kernel's
  DCO policy.
- Correctly check the return value of `seq_write` and propagates errors on overflow.

 rust/kernel/seq_file.rs | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/rust/kernel/seq_file.rs b/rust/kernel/seq_file.rs
index 518265558d6..d7dbdadde60 100644
--- a/rust/kernel/seq_file.rs
+++ b/rust/kernel/seq_file.rs
@@ -4,7 +4,7 @@
 //!
 //! C header: [`include/linux/seq_file.h`](srctree/include/linux/seq_file.h)
 
-use crate::{bindings, fmt, str::CStrExt as _, types::NotThreadSafe, types::Opaque};
+use crate::{bindings, ffi::c_void, fmt, types::NotThreadSafe, types::Opaque};
 
 /// A utility for generating the contents of a seq file.
 #[repr(transparent)]
@@ -32,13 +32,29 @@ pub unsafe fn from_raw<'a>(ptr: *mut bindings::seq_file) -> &'a SeqFile {
     /// Used by the [`seq_print`] macro.
     #[inline]
     pub fn call_printf(&self, args: fmt::Arguments<'_>) {
-        // SAFETY: Passing a void pointer to `Arguments` is valid for `%pA`.
-        unsafe {
-            bindings::seq_printf(
-                self.inner.get(),
-                c"%pA".as_char_ptr(),
-                core::ptr::from_ref(&args).cast::<crate::ffi::c_void>(),
-            );
+        let mut this = self;
+        let _ = fmt::Write::write_fmt(&mut this, args);
+    }
+}
+
+impl fmt::Write for &SeqFile {
+    #[inline]
+    fn write_str(&mut self, s: &str) -> fmt::Result {
+        // SAFETY: `self` is a valid reference, ensuring `self.inner.get()` is a valid pointer
+        // to `struct seq_file`. `s` is a valid string slice, guaranteeing `s.as_ptr()` is
+        // readable for `s.len()` bytes. `seq_write` handles bounds checking and does not
+        // require a null-terminated string.
+        //
+        // CAST: `s.as_ptr()` (a `*const u8`) is cast to `*const c_void` because `seq_write`
+        // only reads the buffer via `memcpy` and does not care about the underlying type.
+
+        let res =
+            unsafe { bindings::seq_write(self.inner.get(), s.as_ptr().cast::<c_void>(), s.len()) };
+
+        if res < 0 {
+            Err(fmt::Error)
+        } else {
+            Ok(())
         }
     }
 }
-- 
2.53.0

