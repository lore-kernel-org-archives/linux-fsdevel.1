Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch [79.135.106.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C5B36BCDA;
	Wed,  8 Apr 2026 21:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775685377; cv=none; b=fy9iQCW6LrYxQKQb4ik4gOk0T0zoZ/4q+PzQB0qd2Ujy4IC3QeOQ4O9VPT2kMMKLmJoX/8t0Gx/UloN1WkOZkOA7DQnHtSLKCm0GKJV5Skiqp62dnl5alWKmbrNMPVrmh6+r4gRQEkNosclDQRZcNlwCvkTODEz+MRw9TMaQ9gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775685377; c=relaxed/simple;
	bh=6hDRpod53Jd2kFovWttDWdYRa5oYg1i5i69+TgRD2lw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rvq0ldR6s6hMZxoGNd+7TOVcAa1cpNp6UCVKa8F+msNOUlfNpdhzX2RqQ+ToBnCcdrNqh5skPDYJOpqEjvW8KTULqL8AVX/YJ41o37ztvAbv+ZtjCHDQzQ/VUq3Gvx2M5pCzHltqO2ojb9l/8mzQRdZ2Wnkqozjn4JQUD2Xh6tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.ch; spf=pass smtp.mailfrom=protonmail.ch; dkim=pass (2048-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b=h5EMzqzm; arc=none smtp.client-ip=79.135.106.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b="h5EMzqzm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
	s=protonmail3; t=1775685367; x=1775944567;
	bh=eE7rO8vGXKlTxFRp9tVSgGlMcbnF2oLr5fZC0HBvncQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=h5EMzqzm+vHWSD7RcbyPuWpzfHOOkzy+VR3k7Rk44QEXxX4dNR5+r8pOc6yZ2g+8i
	 Q/9WoFaq8gYqC/AN6cDzmY9pCPU1b6hW074GwSIYeO8/AGH+H6M1yKELl7nyioWX0a
	 OawasFmSTBYH9wxftyQaoJ4kAZMjGypTUa5YLYarhND8PBos7z3As7ft2r8dY0Aa9v
	 4fIcbyBP/d2W0XHjzvkyKLkLFMTlJbkvdy6kwabd25mEeHJ/F3PLSZyIxzjWJzgw2o
	 V5ISbqCzqFX+Ti1PT523ogdudPMk5XWXIHj0VWzv0JksPP7YEtusK8y7crnR9rCXap
	 wKNEEFat4jNRw==
Date: Wed, 08 Apr 2026 21:56:03 +0000
To: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
From: Christian Benton <t1bur0n.kernel.org@protonmail.ch>
Cc: aliceryhl@google.com, ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, Christian Benton <t1bur0n.kernel.org@protonmail.ch>
Subject: [PATCH v2 1/1] rust: seq_file: add puts, putc, write, and hex_dump methods
Message-ID: <20260408215530.446994-2-t1bur0n.kernel.org@protonmail.ch>
In-Reply-To: <20260408215530.446994-1-t1bur0n.kernel.org@protonmail.ch>
References: <20260408215530.446994-1-t1bur0n.kernel.org@protonmail.ch>
Feedback-ID: 190658113:user:proton
X-Pm-Message-ID: eeb47319860faf4aff1c3093248d6234b24dc838
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The SeqFile abstraction currently only exposes seq_printf via the
seq_print! macro. This leaves several commonly used seq_file operations
unavailable to Rust kernel code.

Add the following methods to SeqFile:

- puts(): writes a C string using __seq_puts()
- putc(): writes a single byte using seq_putc()
- write(): writes raw bytes using seq_write()
- hex_dump(): dumps binary data as formatted hex using seq_hex_dump()

Also add HexDumpPrefix, a Rust enum wrapping the DUMP_PREFIX_NONE,
DUMP_PREFIX_ADDRESS, and DUMP_PREFIX_OFFSET constants, replacing the
raw integer interface with a type-safe alternative that makes invalid
prefix values unrepresentable.

The motivation for this patch is to support Rust character device drivers
that expose data as formatted output through the seq_file interface. The
amdtelem out-of-tree driver is a concrete example =E2=80=94 it registers a =
misc
character device that exposes GPU telemetry data, where puts() and
hex_dump() provide cleaner alternatives to repeated seq_print! calls for
string labels and binary register dumps.

v2: Fix build issues reported by kernel test robot
  - Reformat use statement to satisfy rustfmt line length requirement
  - Rename as_c_int() to to_c_int() to satisfy clippy wrong_self_convention
  - Replace rowsize/groupsize as-casts with ffi::c_int::from() to satisfy
    clippy cast_lossless lint

Signed-off-by: Christian Benton <t1bur0n.kernel.org@protonmail.ch>
---
 rust/kernel/seq_file.rs | 87 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 86 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/seq_file.rs b/rust/kernel/seq_file.rs
index 518265558d66..144bd6ef92d5 100644
--- a/rust/kernel/seq_file.rs
+++ b/rust/kernel/seq_file.rs
@@ -4,7 +4,9 @@
 //!
 //! C header: [`include/linux/seq_file.h`](srctree/include/linux/seq_file.=
h)
=20
-use crate::{bindings, fmt, str::CStrExt as _, types::NotThreadSafe, types:=
:Opaque};
+use crate::{
+    bindings, ffi, fmt, str::CStr, str::CStrExt as _, types::NotThreadSafe=
, types::Opaque,
+};
=20
 /// A utility for generating the contents of a seq file.
 #[repr(transparent)]
@@ -13,6 +15,26 @@ pub struct SeqFile {
     _not_send: NotThreadSafe,
 }
=20
+/// The prefix type for [`SeqFile::hex_dump`].
+pub enum HexDumpPrefix {
+    /// No prefix.
+    None,
+    /// Prefix with the memory address.
+    Address,
+    /// Prefix with the offset within the buffer.
+    Offset,
+}
+
+impl HexDumpPrefix {
+    fn to_c_int(self) -> ffi::c_int {
+        match self {
+            Self::None =3D> bindings::DUMP_PREFIX_NONE as ffi::c_int,
+            Self::Address =3D> bindings::DUMP_PREFIX_ADDRESS as ffi::c_int=
,
+            Self::Offset =3D> bindings::DUMP_PREFIX_OFFSET as ffi::c_int,
+        }
+    }
+}
+
 impl SeqFile {
     /// Creates a new [`SeqFile`] from a raw pointer.
     ///
@@ -41,6 +63,69 @@ pub fn call_printf(&self, args: fmt::Arguments<'_>) {
             );
         }
     }
+
+    /// Prints a C string to the seq file.
+    pub fn puts(&self, s: &CStr) {
+        // SAFETY: `self.inner.get()` is valid because `&self` guarantees =
the
+        // `SeqFile` is alive and was properly initialized via `from_raw`.
+        // `s.as_char_ptr()` is valid because `CStr` is always a valid
+        // null-terminated C string.
+        unsafe { bindings::__seq_puts(self.inner.get(), s.as_char_ptr()) }
+    }
+
+    /// Prints a single char to the seq file.
+    pub fn putc(&self, c: u8) {
+        // SAFETY: `self.inner.get()` is valid because `&self`
+        // guarantees `SeqFile` is alive and was properly initialized via =
`from_raw`
+        unsafe { bindings::seq_putc(self.inner.get(), c as ffi::c_char) }
+    }
+
+    /// Writes raw bytes to the seq file.
+    pub fn write(&self, data: &[u8]) {
+        // SAFETY: `self.inner.get()` is valid because `&self` guarantees =
the
+        // `SeqFile` is alive and was properly initialized via `from_raw`.
+        // `data.as_ptr()` is valid and non-dangling because it comes from=
 a
+        // `&[u8]`, which guarantees the memory is valid for `data.len()` =
bytes
+        // and will not be modified during the call due to the shared refe=
rence.
+        unsafe {
+            bindings::seq_write(
+                self.inner.get(),
+                data.as_ptr().cast::<ffi::c_void>(),
+                data.len(),
+            )
+        };
+    }
+
+    /// Prints a hex dump of `buf` to the seq file.
+    pub fn hex_dump(
+        &self,
+        prefix_str: &CStr,
+        prefix_type: HexDumpPrefix,
+        rowsize: u8,
+        groupsize: u8,
+        buf: &[u8],
+        ascii: bool,
+    ) {
+        // SAFETY: `self.inner.get()` is valid because `&self` guarantees =
the
+        // `SeqFile` is alive and was properly initialized via `from_raw`.
+        // `prefix_str.as_char_ptr()` is valid because `CStr` is always a =
valid
+        // null-terminated C string. `buf.as_ptr()` is valid and non-dangl=
ing
+        // because it comes from a `&[u8]`, which guarantees the memory is=
 valid
+        // for `buf.len()` bytes and will not be modified during the call =
due to
+        // the shared reference.
+        unsafe {
+            bindings::seq_hex_dump(
+                self.inner.get(),
+                prefix_str.as_char_ptr(),
+                prefix_type.to_c_int(),
+                ffi::c_int::from(rowsize),
+                ffi::c_int::from(groupsize),
+                buf.as_ptr().cast::<ffi::c_void>(),
+                buf.len(),
+                ascii,
+            )
+        }
+    }
 }
=20
 /// Write to a [`SeqFile`] with the ordinary Rust formatting syntax.
--=20
2.53.0


